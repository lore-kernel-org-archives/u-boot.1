Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD237C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 06:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC1D87A80;
	Sun, 17 Mar 2024 07:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oFOIywKc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bwVBOTCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E0C87BEE; Sun, 17 Mar 2024 07:17:53 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3368C87B30
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 07:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Ty77y6k1nz9sWZ;
 Sun, 17 Mar 2024 07:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710656270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeqvLm1qM4wrSZOPHIkNTgSLnIyVy4o8ThM7N8jZ/48=;
 b=oFOIywKceS7TbfSX3gIjiu5J3jCFGNmCZkJV+QskSuqhVy6utSvw1GZDo4aLDn8uBSR3/O
 AHmLCogAwfSVpEULO1/92BrawUNwJJKrPTmVmBPpqB/8SojlnFxA1O2xvLpu4Y2F7F32T8
 pBwFEDNvmyrp60LCGmIoLb4sTiry7gC7KukiEl2hDwJql3XAD7/ImSwNy6E7lRvw06Tv0A
 loDw/Tt16KOcGOdwv/BgKd4ZinR1V87jvWFtLL0g6UzAylr1QYt6N2n1Rfb3vkN4Q5b7pA
 sG9j2F2OzJM0iKPo/iewh+0erE1l27wyUehU967XHqKlSVaSR6Dh6WXQD0PuYA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710656269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeqvLm1qM4wrSZOPHIkNTgSLnIyVy4o8ThM7N8jZ/48=;
 b=bwVBOTCjWYR/6W0hT1U2bwCDHIc2jrU1FWjTQM9tegIo8kLfo6iY3MDyDwkJvALnWIwWef
 uEky+vlWx8ZG50Tl02NwXaj94B7NBFR3h0SJ19sAwdQssUJHMKnWYluI7W9xWclfuqjJEw
 UMhejVsIPXDkJuwkuKJJ/Ne7rYMDGpqekoxoFhrZt9SsfQlXu+IIh5MOzMm1ACROaDbF5c
 yoEehOHB6UO4Ej3x7aEcn+ApcHP4M57ylqGtEYsC1BINaUsv9xxBTlcVGaIsDiOs9Rj9CQ
 GGM1DppwRY2FkHbca7V/+5DPFUSeMjIS0FLXgK1AWx0ZX5SpmRqVIGeIhEnHzg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] boot: fdt: Drop lmb_alloc*() typecasts
Date: Sun, 17 Mar 2024 07:16:30 +0100
Message-ID: <20240317061730.654893-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wb3be3umt44x6npznmwgdbc9d4mwim6y
X-MBO-RS-ID: f4f4ff9689bbfe5a8cc
X-Rspamd-Queue-Id: 4Ty77y6k1nz9sWZ
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
phys_addr_t as first parameter. Declare $addr as phys_addr_t and
get rid of the casts.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
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

