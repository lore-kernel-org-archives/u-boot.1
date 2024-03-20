Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144D4C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 20:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBEE3880A6;
	Wed, 20 Mar 2024 21:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OYaA0nu6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TuqXPt6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC5AC880BF; Wed, 20 Mar 2024 21:54:38 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F72E8809B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 21:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V0LSD0gLSz9shD;
 Wed, 20 Mar 2024 21:54:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnzy9GqeBu7pENlXZdGpLA5XS7msH3dwI04Ov8kTF9o=;
 b=OYaA0nu6B5NQJY1GovELuzuVaMPrTEp4TFzuZj+jubc7TjNlO4N6Kadmt/WTqW++6pGqHR
 xCTaQ0572kWn8C0sB9Ta4HyggMNVoAJK0RG4HcsA+LzEE/rdPP/Ls46kamFrBAjAGiDFWr
 iyl+zrat7pVjOYOy5RvZsCVMuPT8WgctbP1dwY0fLr59rQUNtHikh0kTLfxl3GKi4YU71x
 qMGbDxy3mkkhHY3b+8PCaFl9byG2Y9bJk6b9tAyGSFM2mwfgpIXPEaNJSMy7rNDB2hyIVi
 1rlImcGxIr/B+MuzuJXuYJvcxDfBWQ0tYlRBwZO/vURvnaj9tEwBJwKTNhMGeQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnzy9GqeBu7pENlXZdGpLA5XS7msH3dwI04Ov8kTF9o=;
 b=TuqXPt6iR6RUYtP71vJWWzDhDDk8piQuC89siNKV2XYYnz2AECC5xNz6bZeJH8nb19SdZ6
 4Y4G65xk1UQ9RLyBWnJVHqaDFa0RMM0emZF4O0S02ctNVD1t6qQI+ef6T9lYS2VmBP1DZW
 +JSWCRQz2pmXOkYoRbCv3f97cvwXtzHtfKquPm2NX79fqJQh/rGuvX16w7dTHqFOFiDdC0
 ErpmS3LHuUMaE22SX0io/vAcWdKDpq5kJCXgCllejDqJk3S4wZ5/y+GMrQ2c7YLJ2Dn9Eq
 o7askAtXl8dbhnmsljZpClhXEIWjNFbOka48+j5hheHcGObZWPSAvuehxmrlhA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/5] boot: fdt: Drop lmb_alloc*() typecasts
Date: Wed, 20 Mar 2024 21:53:08 +0100
Message-ID: <20240320205413.32555-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240320205413.32555-1-marek.vasut+renesas@mailbox.org>
References: <20240320205413.32555-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wstbns4qwhaue4kfc6rfrsszzpppmnai
X-MBO-RS-ID: cb8d4c77a5909b0e555
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

