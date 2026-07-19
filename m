Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F144FC44521
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3408780517;
	Sun, 19 Jul 2026 03:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A8B83FF5; Sun, 19 Jul 2026 03:51:22 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5460E80398
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGgZ-000000001mR-2O8u; Sun, 19 Jul 2026 01:51:19 +0000
Date: Sun, 19 Jul 2026 02:51:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 u-boot@lists.denx.de
Subject: [PATCH] spl: atf: fix BL32 entry point for multi-segment TEE images
Message-ID: <9f1c99806be7c7c07ec473eb67aa8c8fb13ea9cf.1784423836.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

binman's split-elf operation records one FIT image node per ELF
segment, all with os = "tee", and only the segment containing the ELF
entry point carries an entry property. Since fdt_add_subnode() inserts
new subnodes in front of existing ones, the /fit-images nodes end up in
reverse recording order, so spl_fit_images_find() would return the
*last* TEE segment and its load address was passed to BL31 as the BL32
entry point.

On RK3588 with an OP-TEE tee.elf consisting of two PT_LOAD segments
this made BL31 (SPD=opteed) ERET into OP-TEE's data segment at
0x30200000 instead of the entry point at 0x30000000, hanging the boot
right after 'BL31: Initializing BL32'.

Prefer the FIT image node which provides an entry property and only
fall back to the first matching node when none of them has one.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 common/spl/spl_atf.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 8bc5db77395..17acd3665df 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -212,7 +212,9 @@ static void __noreturn bl31_entry(ulong bl31_entry, ulong bl32_entry,
 static int spl_fit_images_find(void *blob, int os)
 {
 	int parent, node, ndepth = 0;
+	int found = -FDT_ERR_NOTFOUND;
 	const void *data;
+	ulong val;
 
 	if (!blob)
 		return -FDT_ERR_BADMAGIC;
@@ -231,11 +233,23 @@ static int spl_fit_images_find(void *blob, int os)
 		if (!data)
 			continue;
 
-		if (genimg_get_os_id(data) == os)
+		if (genimg_get_os_id(data) != os)
+			continue;
+
+		/*
+		 * A multi-segment image, e.g. an OP-TEE ELF split by
+		 * binman, is recorded as one node per segment, all with
+		 * the same os. Only the segment holding the ELF entry
+		 * point carries an entry property, so prefer that node.
+		 */
+		if (!fit_image_get_entry(blob, node, &val))
 			return node;
+
+		if (found < 0)
+			found = node;
 	};
 
-	return -FDT_ERR_NOTFOUND;
+	return found;
 }
 
 ulong spl_fit_images_get_entry(void *blob, int node)

base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.55.0
