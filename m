Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB45C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E7C87C0F;
	Tue, 23 Jan 2024 09:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="VwJEeO4b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5npJTYBJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VwJEeO4b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5npJTYBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4464687C9D; Tue, 23 Jan 2024 09:08:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21DC879B3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D7CE22283;
 Tue, 23 Jan 2024 08:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705997318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOiaUhlqDIvwFuwew+3DhOYh4p9q/+Vh0bpRAjjzOZM=;
 b=VwJEeO4buzZYQr9bJURPM3dNGHIqa+wPXoXrATExutD9Pygks324RK/0j/2HQRLEzHhCTZ
 OOkLqyAewFLfXqnAnyRjcYT1dg4/Nv0Co8yETh2DcOlxAlVcfy4GSKRn2hQ8HQzgCmyINd
 fREy0G5cxYDmTjhmHIPZrzjyiCQITQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705997318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOiaUhlqDIvwFuwew+3DhOYh4p9q/+Vh0bpRAjjzOZM=;
 b=5npJTYBJ43vwl8927pXE9PZaRd+x1O8s7pYLVY03r2fcagXwoKz3xlsc9leiKVlkJALP5j
 A541BwUUSzKBO6Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705997318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOiaUhlqDIvwFuwew+3DhOYh4p9q/+Vh0bpRAjjzOZM=;
 b=VwJEeO4buzZYQr9bJURPM3dNGHIqa+wPXoXrATExutD9Pygks324RK/0j/2HQRLEzHhCTZ
 OOkLqyAewFLfXqnAnyRjcYT1dg4/Nv0Co8yETh2DcOlxAlVcfy4GSKRn2hQ8HQzgCmyINd
 fREy0G5cxYDmTjhmHIPZrzjyiCQITQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705997318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOiaUhlqDIvwFuwew+3DhOYh4p9q/+Vh0bpRAjjzOZM=;
 b=5npJTYBJ43vwl8927pXE9PZaRd+x1O8s7pYLVY03r2fcagXwoKz3xlsc9leiKVlkJALP5j
 A541BwUUSzKBO6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A95E13786;
 Tue, 23 Jan 2024 08:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MF7iFgV0r2XOagAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 23 Jan 2024 08:08:37 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH v5 2/7] rpi5: Use devicetree as alternative way to read IO
 base addresses
Date: Tue, 23 Jan 2024 10:07:54 +0200
Message-ID: <20240123080819.13625-3-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123080819.13625-1-iivanov@suse.de>
References: <20240123080819.13625-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.92 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(4.22)[97.65%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]
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

From: Dmitry Malkin <dmitry@bedrocksystems.com>

MBOX and Watchdog on RPi5/bcm2712 have a different base IO offsets.
Find them via devicetree blob passed by bootloader.

Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 arch/arm/mach-bcm283x/include/mach/base.h  |  5 ++-
 arch/arm/mach-bcm283x/include/mach/mbox.h  |  3 +-
 arch/arm/mach-bcm283x/include/mach/sdhci.h |  3 +-
 arch/arm/mach-bcm283x/include/mach/timer.h |  3 +-
 arch/arm/mach-bcm283x/include/mach/wdog.h  |  3 +-
 arch/arm/mach-bcm283x/init.c               | 43 ++++++++++++++++++----
 6 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-bcm283x/include/mach/base.h b/arch/arm/mach-bcm283x/include/mach/base.h
index 4ccaf69693..6de99e7ea1 100644
--- a/arch/arm/mach-bcm283x/include/mach/base.h
+++ b/arch/arm/mach-bcm283x/include/mach/base.h
@@ -6,7 +6,10 @@
 #ifndef _BCM283x_BASE_H_
 #define _BCM283x_BASE_H_
 
-extern unsigned long rpi_bcm283x_base;
+extern unsigned long rpi_mbox_base;
+extern unsigned long rpi_timer_base;
+extern unsigned long rpi_sdhci_base;
+extern unsigned long rpi_wdog_base;
 
 #ifdef CONFIG_ARMV7_LPAE
 #ifdef CONFIG_TARGET_RPI_4_32B
diff --git a/arch/arm/mach-bcm283x/include/mach/mbox.h b/arch/arm/mach-bcm283x/include/mach/mbox.h
index 490664f878..35d4e2f075 100644
--- a/arch/arm/mach-bcm283x/include/mach/mbox.h
+++ b/arch/arm/mach-bcm283x/include/mach/mbox.h
@@ -38,8 +38,7 @@
 
 /* Raw mailbox HW */
 
-#define BCM2835_MBOX_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
-				 rpi_bcm283x_base + 0x0000b880; })
+#define BCM2835_MBOX_PHYSADDR	rpi_mbox_base
 
 struct bcm2835_mbox_regs {
 	u32 read;
diff --git a/arch/arm/mach-bcm283x/include/mach/sdhci.h b/arch/arm/mach-bcm283x/include/mach/sdhci.h
index 7323690687..e837c679c4 100644
--- a/arch/arm/mach-bcm283x/include/mach/sdhci.h
+++ b/arch/arm/mach-bcm283x/include/mach/sdhci.h
@@ -8,8 +8,7 @@
 
 #include <asm/arch/base.h>
 
-#define BCM2835_SDHCI_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
-				  rpi_bcm283x_base + 0x00300000; })
+#define BCM2835_SDHCI_PHYSADDR	rpi_sdhci_base
 
 int bcm2835_sdhci_init(u32 regbase, u32 emmc_freq);
 
diff --git a/arch/arm/mach-bcm283x/include/mach/timer.h b/arch/arm/mach-bcm283x/include/mach/timer.h
index 5567dbd7f3..60500a256d 100644
--- a/arch/arm/mach-bcm283x/include/mach/timer.h
+++ b/arch/arm/mach-bcm283x/include/mach/timer.h
@@ -11,8 +11,7 @@
 #include <linux/bug.h>
 #endif
 
-#define BCM2835_TIMER_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
-				  rpi_bcm283x_base + 0x00003000; })
+#define BCM2835_TIMER_PHYSADDR	rpi_timer_base
 
 #define BCM2835_TIMER_CS_M3	(1 << 3)
 #define BCM2835_TIMER_CS_M2	(1 << 2)
diff --git a/arch/arm/mach-bcm283x/include/mach/wdog.h b/arch/arm/mach-bcm283x/include/mach/wdog.h
index 9942666720..b950560674 100644
--- a/arch/arm/mach-bcm283x/include/mach/wdog.h
+++ b/arch/arm/mach-bcm283x/include/mach/wdog.h
@@ -8,8 +8,7 @@
 
 #include <asm/arch/base.h>
 
-#define BCM2835_WDOG_PHYSADDR ({ BUG_ON(!rpi_bcm283x_base); \
-				 rpi_bcm283x_base + 0x00100000; })
+#define BCM2835_WDOG_PHYSADDR	rpi_wdog_base
 
 struct bcm2835_wdog_regs {
 	u32 unknown0[7];
diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index f1a0c8588d..016bc1eb41 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -146,7 +146,11 @@ static void rpi_update_mem_map(void)
 static void rpi_update_mem_map(void) {}
 #endif
 
-unsigned long rpi_bcm283x_base = 0x3f000000;
+/* Default bcm283x devices addresses */
+unsigned long rpi_mbox_base  = 0x3f00b880;
+unsigned long rpi_sdhci_base = 0x3f300000;
+unsigned long rpi_wdog_base  = 0x3f100000;
+unsigned long rpi_timer_base = 0x3f003000;
 
 int arch_cpu_init(void)
 {
@@ -157,22 +161,45 @@ int arch_cpu_init(void)
 
 int mach_cpu_init(void)
 {
-	int ret, soc_offset;
+	int ret, soc, offset;
 	u64 io_base, size;
 
 	rpi_update_mem_map();
 
 	/* Get IO base from device tree */
-	soc_offset = fdt_path_offset(gd->fdt_blob, "/soc");
-	if (soc_offset < 0)
-		return soc_offset;
+	soc = fdt_path_offset(gd->fdt_blob, "/soc");
+	if (soc < 0)
+		return soc;
 
-	ret = fdt_read_range((void *)gd->fdt_blob, soc_offset, 0, NULL,
-				&io_base, &size);
+	ret = fdt_read_range((void *)gd->fdt_blob, soc, 0, NULL,
+			     &io_base, &size);
 	if (ret)
 		return ret;
 
-	rpi_bcm283x_base = io_base;
+	rpi_mbox_base  = io_base + 0x00b880;
+	rpi_sdhci_base = io_base + 0x300000;
+	rpi_wdog_base  = io_base + 0x100000;
+	rpi_timer_base = io_base + 0x003000;
+
+	offset = fdt_node_offset_by_compatible(gd->fdt_blob, soc,
+					       "brcm,bcm2835-mbox");
+	if (offset > soc)
+		rpi_mbox_base = fdt_get_base_address(gd->fdt_blob, offset);
+
+	offset = fdt_node_offset_by_compatible(gd->fdt_blob, soc,
+					       "brcm,bcm2835-sdhci");
+	if (offset > soc)
+		rpi_sdhci_base = fdt_get_base_address(gd->fdt_blob, offset);
+
+	offset = fdt_node_offset_by_compatible(gd->fdt_blob, soc,
+					       "brcm,bcm2835-system-timer");
+	if (offset > soc)
+		rpi_timer_base = fdt_get_base_address(gd->fdt_blob, offset);
+
+	offset = fdt_node_offset_by_compatible(gd->fdt_blob, soc,
+					       "brcm,bcm2712-pm");
+	if (offset > soc)
+		rpi_wdog_base = fdt_get_base_address(gd->fdt_blob, offset);
 
 	return 0;
 }
-- 
2.43.0

