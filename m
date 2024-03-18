Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C74C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F9BB87F3F;
	Mon, 18 Mar 2024 16:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aHuelFwJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i6NECAOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E4B587F6F; Mon, 18 Mar 2024 16:02:30 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CDF87F4B
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tyykn4M2xz9sZX;
 Mon, 18 Mar 2024 16:02:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRHIX2dmuw6VbjMJb0C+S79BuSprYh6Nk3O83WOuYdw=;
 b=aHuelFwJVmrqBOT2ICcJum1BxOvNqSvOGpjXal4kQOq/dptT1WFDEkpQlDvfyld84Qrs5q
 Ru5Ocrg7f2hQDW5Df+Vbmzge8JLhXfBlfB84UC71ND648KOPrV9h3HLi/w09FKPahLtX1S
 3ym8EZ67GR4WSrSCMBjam6kzOcgO/H3QJLvCblT1iwPddQ5d6oXPleynFXVkJFvhUdypAS
 NfMdABELejPE23ptKs2lYpnOtP8H8M7yL9gfvsFJrQL6yjajgl9Sh4F0TIYl3EUsb9cl/U
 hcNdAqyh2ylKoRwecMA21438zvB852W4BqCLnHy+uykH2ciTDU8M6Bt5jc5XfQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRHIX2dmuw6VbjMJb0C+S79BuSprYh6Nk3O83WOuYdw=;
 b=i6NECAOsQ26bs0liqQPDDfz6rZxNVlgBHHfgOH/CUsLzB/os6eYs64C3K2v+hUKH9N9nit
 7MjdzRqZ2Xz7KNGodPmjVZ4TyeIRBjyldcrqdOLQOaQbdsZtz8MVTIgeA3f2z1YOBMLJca
 QeaHNQIbXKi6nHmidAEAsXsrlZrcIwEiUvNr1yysQcrU15InpDtLyb152PuV+EQFRoMZBO
 g4ntZTnJOmGVKIrAXim6nWH8qFIv6CoYBYHVOJbIeYkaVodrBR/cATau9x0RQBxfiyUrKC
 Qo9mdxtzKyN8WZsy9EH4fDPbC7Cl9cpALSEmnnir2SZeMqzI25OQOU9Pw9RTqw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] boot: fdt: Drop lmb_alloc*() typecasts
Date: Mon, 18 Mar 2024 16:00:46 +0100
Message-ID: <20240318150200.8178-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
References: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9d00fdff9b784222050
X-MBO-RS-META: k1h9zr9bjmbs5qd5gjt36afjhssoemg5
X-Rspamd-Queue-Id: 4Tyykn4M2xz9sZX
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

