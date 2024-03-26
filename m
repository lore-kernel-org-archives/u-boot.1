Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1FBC54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 22:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC188806C;
	Tue, 26 Mar 2024 23:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YpI9HmLl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u2pN7ZzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE478807B; Tue, 26 Mar 2024 23:15:07 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3628805B
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V43yK1D8tz9sjK;
 Tue, 26 Mar 2024 23:15:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfmzeAzFgtZUa1jib4VGVs/JC/WLotHF6sssnXoU10c=;
 b=YpI9HmLlp7BNv09S+Qq4R+OTKhm5Mf247AMvoB05exXqmFSdUs9RcV1KNaePaF8xpWOSCJ
 wu/KwzrinNf5XLgk0JNsEQkVvnkMfe3C+Ehbr8phNS8Mw75VyY6CkAJAreFnPoMAEFWdu6
 BpGkjpxvV/zsfI57JW95qoUxVWwwEz+yAZb77uKjfzGWm+EOY9nqkDuoTxawQ6ZTrWVHZH
 1RfZytxd0vbxoEouZrQFnm1o6Hq+xy8Z3aeb0n5ASnBsROC/c4/k7KGkahB7fBrTQ7W3Wn
 affrUElc6G1rP29nlwUA57598v88UswapNnYoVcPre36d69ih6J0NOjRKN+/pQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711491303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfmzeAzFgtZUa1jib4VGVs/JC/WLotHF6sssnXoU10c=;
 b=u2pN7ZzPU8ZhNvE2H3+q4JvLAAwmKXbA7nR4xpzAtUF5CVJxuMNJGe0Fpzte03McqMLx5b
 ttIUl1pGpFcrtl4xZ1SshrAWlA1GCqemsZwhf1DAUWe3XQyiuw1gEjFQYs9tLRe/YCnkhd
 J+/IVJp2lnnPJJDwwcmV7X57c2+/IRDwCDEni+mfA8zoJvgY0DS4vaH3YkJSn9WUGr2ihk
 cz5rUQ7TPenanP0gTEB5pn8Z41R/OWRz10nLdJwLqedb07HPf7aQ2Cy0uaFir4VpYo/J9M
 kmrR3ClWnjh20UP0dlWct8hk7QnMNZSNFYUnWNVuJefVtXBXn5qRIvIeAVrEHA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 5/6] boot: fdt: Drop lmb_alloc*() typecasts
Date: Tue, 26 Mar 2024 23:13:15 +0100
Message-ID: <20240326221431.55346-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
References: <20240326221431.55346-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 47f1739254df106ab65
X-MBO-RS-META: 8pwg4kwnq7icemkopee739weszjb9nkn
X-Rspamd-Queue-Id: 4V43yK1D8tz9sjK
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

The lmb_alloc_base() returns phys_addr_t , map_sysmem() accepts
phys_addr_t as first parameter. Declare 'addr' as phys_addr_t and
get rid of the casts.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: - Replace $addr with 'addr' to somehow delimit the variable name
V3: - Add RB from Laurent
V4: No change
---
 boot/image-fdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index c2571b22244..c37442c9130 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -162,6 +162,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 	void	*of_start = NULL;
 	phys_addr_t start, size, usable;
 	char	*fdt_high;
+	phys_addr_t addr;
 	phys_addr_t low;
 	phys_size_t mapsize;
 	ulong	of_len = 0;
@@ -186,7 +187,6 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 	fdt_high = env_get("fdt_high");
 	if (fdt_high) {
 		ulong desired_addr = hextoul(fdt_high, NULL);
-		ulong addr;
 
 		if (desired_addr == ~0UL) {
 			/* All ones means use fdt in place */
@@ -224,8 +224,8 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 			 * At least part of this DRAM bank is usable, try
 			 * using it for LMB allocation.
 			 */
-			of_start = map_sysmem((ulong)lmb_alloc_base(lmb,
-				    of_len, 0x1000, usable), of_len);
+			addr = lmb_alloc_base(lmb, of_len, 0x1000, usable);
+			of_start = map_sysmem(addr, of_len);
 			/* Allocation succeeded, use this block. */
 			if (of_start != NULL)
 				break;
-- 
2.43.0

