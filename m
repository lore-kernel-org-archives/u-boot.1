Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233B9C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 09:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58E2F40785;
	Tue, 11 Aug 2026 09:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6YvAG3ZS4VlM; Tue, 11 Aug 2026 09:43:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 680944077E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786441380;
	bh=tmBfs55sVUTAtS5qrsozM/Pecp4uj5iH6emLPHRQjWs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eqhg0g9PXvTvjdQ0QqYdy9bEQw6jy31q8kcusgxzPknfUtoOg7gJ68htUVkXiprtf
	 0PjJg4h2xxW7jJg7AF5j6Vjijh1i9Fk/lPVNm792UnTWFeCbnMuKGmb+R1X+vx8hXa
	 BwEo50q8uE6XPHzKcSSr7OX4utYTLtK1WLZOwQPx++pOC81ihI9HOnuHos8u8R+om+
	 +ZPpQ2TdL/hzGdIZ513cvwgb6Z6zHC5E0LH49vl/iNxPw+yGAekuyTdtZbOMLqCH2Q
	 QlCv8mkVWvwcyBDo2g/HYSUoXyA0v7l0y5ffEVGpabpf7h1ARmzYp+Gb8v7rYLdAJt
	 Iu8E5EP2NRczQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 680944077E;
	Tue, 11 Aug 2026 09:43:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1984B259
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B9E24075C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1aFXZfIxnJy for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 09:42:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 51A894075F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51A894075F
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51A894075F
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:42:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 1/3] ARM: imx: Support detection of ECSPI recovery mode on
 i.MX6
Date: Tue, 11 Aug 2026 11:34:18 +0200
Message-ID: <20260811093423.212986-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fris.de; s=mail; t=1786440888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tmBfs55sVUTAtS5qrsozM/Pecp4uj5iH6emLPHRQjWs=;
 b=KNdu+ygCtVtkMyH6/kRbw3t9x7SbyaZjZoyo4qfbUL+Dy0Vly7DVsBTDvMogr+IxF7BoKC
 E7SYGbh1otfgzWSo4SPafdnz2JpaVUMGFMJSlD9VkiHRMsQeQzE/ncHWqixugS2nX6ETo4
 83tuCsdPiLFERdL5+5AfEc3+TtxvdhbBdgpWyFZ2TE3b/Lo0X9POscwNjbqtRz5a8fBr0y
 0IhQvfI86012mIUGSQkwJj8BEnilMpYRHyySn3711/clFCcvg3r66d0olLIIuzcY+q6utx
 TQQAx/4V/LG/yIHmS6veFEzi1+oE8D2OWWNfgMEWik72asG5I0Sico9qGmqcOw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=fris.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=KNdu+ygC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The i.MX6 allows to boot from a SPI NOR as a fallback if the primary
boot fails. Parse the ROM log in order to detect this and return
the proper boot device in spl_boot_device(). Otherwise the primary
boot device is returned even if it was not used.

To make imx6_is_ecspi_recovery_boot() usable in U-Boot proper,
add them in arch/arm/mach-imx/init.c.

This was tested on i.MX6S and the implementation covers other
i.MX6 variants based on the documentation from NXP (AN12853).

Assisted-by: Claude:claude-opus-5
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  1 +
 arch/arm/mach-imx/init.c                  | 75 +++++++++++++++++++++++
 arch/arm/mach-imx/spl.c                   |  7 +++
 3 files changed, 83 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index d25c08f8fe7..06b5636c7a0 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -159,6 +159,7 @@ enum imx6_bmode {
 };
 
 u32 imx6_src_get_boot_mode(void);
+bool imx6_is_ecspi_recovery_boot(void);
 void gpr_init(void);
 
 #endif /* CONFIG_MX6 */
diff --git a/arch/arm/mach-imx/init.c b/arch/arm/mach-imx/init.c
index ce3eb4b0b8a..4193b350e03 100644
--- a/arch/arm/mach-imx/init.c
+++ b/arch/arm/mach-imx/init.c
@@ -137,4 +137,79 @@ u32 imx6_src_get_boot_mode(void)
 	else
 		return readl(&src_base->sbmr1);
 }
+
+/*
+ * The boot ROM records what it did in an event log buffer in OCRAM. The
+ * address of that buffer is stored at a fixed, SoC specific location inside
+ * the ROM, see AN12853 "i.MX ROMs Log Events". i.MX6 uses the version 0 log
+ * format, where an entry consists of a 32-bit word holding a 24-bit event
+ * ID, optionally followed by up to three parameter words.
+ */
+#define IMX6_ROM_LOG_ID_MASK		GENMASK(23, 0)
+#define IMX6_ROM_LOG_MAX_ENTRIES	128
+
+static const u32 *imx6_get_rom_log(void)
+{
+	uintptr_t log;
+	ulong addr;
+
+	if (is_mx6dq() || is_mx6dqp() || is_mx6sl())
+		addr = 0xd4;
+	else if (is_mx6sdl())
+		addr = 0xd8;
+	else if (is_mx6sx() || is_mx6sll() || is_mx6ul() || is_mx6ull())
+		addr = 0x1e0;
+	else
+		return NULL;
+
+	log = readl(addr);
+
+	/* The log buffer lives in OCRAM, ignore an invalid pointer */
+	if (log < IRAM_BASE_ADDR || log >= IRAM_BASE_ADDR + IRAM_SIZE ||
+	    log & 0x3)
+		return NULL;
+
+	return (const u32 *)log;
+}
+
+/*
+ * If BOOT_CFG4[6] is fused, the boot ROM does not fall back to the serial
+ * downloader right away when the primary boot device fails, but first tries
+ * a recovery boot from the serial ROM selected by BOOT_CFG4[2:0]. Neither
+ * SRC_SBMR1 nor SRC_SBMR2 reflect that this happened, so ask the ROM event
+ * log instead.
+ */
+bool imx6_is_ecspi_recovery_boot(void)
+{
+	const u32 *log = imx6_get_rom_log();
+	u32 event_id;
+	int i;
+
+	if (!log)
+		return false;
+
+	for (i = 0; i < IMX6_ROM_LOG_MAX_ENTRIES; i++) {
+		event_id = log[i] & IMX6_ROM_LOG_ID_MASK;
+
+		switch (event_id) {
+		case 0x000000: /* End of list */
+			return false;
+		/* Recovery boot from ECSPI NOR device */
+		case 0x061004:
+			return true;
+		/* Log entries with 1 parameter, skip 1 */
+		case 0x080000: /* Start to read data from boot device */
+		case 0x090000: /* Image authentication result */
+		case 0x0a0000: /* Start to execute the plugin program */
+		case 0x0b0000: /* Jump to the boot image soon */
+		case 0x0d0000: /* Jump to the SDP boot image soon */
+			i += 1;
+			continue;
+		default:
+			continue;
+		}
+	}
+
+	return false;
+}
 #endif
diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 1029c1e4e85..fbe5172d385 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -93,6 +93,13 @@ u32 spl_boot_device(void)
 	if (is_usbotg_phy_active())
 		return BOOT_DEVICE_BOARD;
 
+	/*
+	 * Likewise the boot ROM may have done a recovery boot from a serial
+	 * ROM on ECSPI after the primary boot device failed.
+	 */
+	if (imx6_is_ecspi_recovery_boot())
+		return BOOT_DEVICE_SPI;
+
 	/* BOOT_CFG1[7:4] - see IMX6DQRM Table 8-8 */
 	switch ((reg & IMX6_BMODE_MASK) >> IMX6_BMODE_SHIFT) {
 	 /* EIM: See 8.5.1, Table 8-9 */
-- 
2.55.0

