Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025C1C54E72
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D6587DBB;
	Mon, 18 Mar 2024 16:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dhIZ2lbj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qz+a/z6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B600787F39; Mon, 18 Mar 2024 16:02:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B886487A80
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tyykk3MXbz9sqY;
 Mon, 18 Mar 2024 16:02:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zPV1P/aJfHshQeqHFMyBcWfLLoIUe3hbbzizuQKjOPk=;
 b=dhIZ2lbjOCbc7DFQNMiqrmPvPELCCHfWkIzQ6+yVgvWt8V8/UBEBY87Q3Cgw3QwaH0z+8U
 yoa8sfFdZpJQ3d4onmBvlCzFvGC+Pb4CSWVhZQydPF3KeBlRcSUN1dlfoW/O85tDBsb8P6
 14s6OQtleg4SxH8yrL/g6bsug+9402jZ74utJJxd3kdP2nxdvBy2qM9R4ps7vuLE5qbu5U
 ynrDXcdSkvI4ILAvB7ZUZn39Oah/DNxPm/+VCFhriEQZx/NDdWMbn+WU3YwZ/pNGhkafPo
 W17dBfUC0U0l3tnIkwKoECj47qP7WnEZxUpO15UMNaf+qVs53gQzJAhtMksAsg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zPV1P/aJfHshQeqHFMyBcWfLLoIUe3hbbzizuQKjOPk=;
 b=qz+a/z6DQGzYVnwXwwQxKisgQRmCXY9DbFWhwjxorY6J6E8QIB0RWw68xAoc5djGkMHoUM
 TW67Sckox+kkKB3r4nmaYGn9L0JJwpc6bF9JDUX1QIsDNMwX9dnyjiqPi0SjOr/pK8wPSO
 UzrA/74Jr6psLo8bfV5eKPpKOJORobF9obORNl7LZXSuc/qfYI0EIxOmO8x+IDpOeSeOuJ
 knR5ikOCHBmCqXocPjM8ho4I7ihctNrWVQk4bvs+teABS5UOqizaU8e3Cd6ZfYiNoIKd+m
 UAPnz3gSrm+JFBH2HLiV476E9xQNzIlZ4uL6eBeAw82ocD6b6d204Tua8Z1T+Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/4] boot: fdt: Change type of env_get_bootm_low() to
 phys_addr_t
Date: Mon, 18 Mar 2024 16:00:44 +0100
Message-ID: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7127fba40a98973ffec
X-MBO-RS-META: 9y4xkw87e3hs4gk4df5srbb3r1t637js
X-Rspamd-Queue-Id: 4Tyykk3MXbz9sqY
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

Change type of ulong env_get_bootm_low() to phys_addr_t env_get_bootm_low().
The PPC/LS systems already treat env_get_bootm_low() result as phys_addr_t,
while the function itself still returns ulong. This is potentially dangerous
on 64bit systems, where ulong might not be large enough to hold the content
of "bootm_low" environment variable. Fix it by using phys_addr_t, similar to
what env_get_bootm_size() does, which returns phys_size_t .

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
V2: - Drop now unnecessary conversion in boot_start_lmb()
      lmb_init_and_reserve_range()
    - Drop tmp variable in env_get_bootm_low()
    - Print initrd_high as u64/%llx
    - Add RB from Laurent
---
 boot/bootm.c       |  4 ++--
 boot/image-board.c | 14 ++++++--------
 boot/image-fdt.c   |  9 +++++----
 include/image.h    |  2 +-
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index d071537d692..032f5a4a160 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -242,13 +242,13 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 #ifdef CONFIG_LMB
 static void boot_start_lmb(struct bootm_headers *images)
 {
-	ulong		mem_start;
+	phys_addr_t	mem_start;
 	phys_size_t	mem_size;
 
 	mem_start = env_get_bootm_low();
 	mem_size = env_get_bootm_size();
 
-	lmb_init_and_reserve_range(&images->lmb, (phys_addr_t)mem_start,
+	lmb_init_and_reserve_range(&images->lmb, mem_start,
 				   mem_size, NULL);
 }
 #else
diff --git a/boot/image-board.c b/boot/image-board.c
index 75f6906cd56..3263497a1d5 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -107,14 +107,12 @@ static int on_loadaddr(const char *name, const char *value, enum env_op op,
 }
 U_BOOT_ENV_CALLBACK(loadaddr, on_loadaddr);
 
-ulong env_get_bootm_low(void)
+phys_addr_t env_get_bootm_low(void)
 {
 	char *s = env_get("bootm_low");
 
-	if (s) {
-		ulong tmp = hextoul(s, NULL);
-		return tmp;
-	}
+	if (s)
+		return simple_strtoull(s, NULL, 16);
 
 #if defined(CFG_SYS_SDRAM_BASE)
 	return CFG_SYS_SDRAM_BASE;
@@ -538,7 +536,7 @@ int boot_ramdisk_high(struct lmb *lmb, ulong rd_data, ulong rd_len,
 		      ulong *initrd_start, ulong *initrd_end)
 {
 	char	*s;
-	ulong	initrd_high;
+	phys_addr_t initrd_high;
 	int	initrd_copy_to_ram = 1;
 
 	s = env_get("initrd_high");
@@ -553,8 +551,8 @@ int boot_ramdisk_high(struct lmb *lmb, ulong rd_data, ulong rd_len,
 		initrd_high = env_get_bootm_mapsize() + env_get_bootm_low();
 	}
 
-	debug("## initrd_high = 0x%08lx, copy_to_ram = %d\n",
-	      initrd_high, initrd_copy_to_ram);
+	debug("## initrd_high = 0x%llx, copy_to_ram = %d\n",
+	      (u64)initrd_high, initrd_copy_to_ram);
 
 	if (rd_data) {
 		if (!initrd_copy_to_ram) {	/* zero-copy ramdisk support */
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 5e4aa9de0d2..c2571b22244 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -160,9 +160,10 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 {
 	void	*fdt_blob = *of_flat_tree;
 	void	*of_start = NULL;
-	u64	start, size, usable;
+	phys_addr_t start, size, usable;
 	char	*fdt_high;
-	ulong	mapsize, low;
+	phys_addr_t low;
+	phys_size_t mapsize;
 	ulong	of_len = 0;
 	int	bank;
 	int	err;
@@ -217,7 +218,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 			if (start + size < low)
 				continue;
 
-			usable = min(start + size, (u64)(low + mapsize));
+			usable = min(start + size, low + mapsize);
 
 			/*
 			 * At least part of this DRAM bank is usable, try
@@ -233,7 +234,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 			 * Reduce the mapping size in the next bank
 			 * by the size of attempt in current bank.
 			 */
-			mapsize -= usable - max(start, (u64)low);
+			mapsize -= usable - max(start, low);
 			if (!mapsize)
 				break;
 		}
diff --git a/include/image.h b/include/image.h
index 21de70f0c9e..acffd17e0df 100644
--- a/include/image.h
+++ b/include/image.h
@@ -946,7 +946,7 @@ static inline void image_set_name(struct legacy_img_hdr *hdr, const char *name)
 int image_check_hcrc(const struct legacy_img_hdr *hdr);
 int image_check_dcrc(const struct legacy_img_hdr *hdr);
 #ifndef USE_HOSTCC
-ulong env_get_bootm_low(void);
+phys_addr_t env_get_bootm_low(void);
 phys_size_t env_get_bootm_size(void);
 phys_size_t env_get_bootm_mapsize(void);
 #endif
-- 
2.43.0

