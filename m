Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E491ACD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A48086977;
	Sun, 17 Sep 2023 16:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QQ1TeswM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="skRKVsZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3C586552; Sun, 17 Sep 2023 16:09:15 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78218662F
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVCs68Ghz9sTd
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfymLXFMyqk4Fs7flS6ijwz4XZzVjiM9nENWRCJz0yE=;
 b=QQ1TeswMWJp8VhtPyi+1abxVCiwTekoMIA64qBU9TeuyKZJYk/YEKWXbVfgXyjytAo6Y8g
 9p19By/HxJvj0+2wyOA3sRu6da8NC5pZmCC74aqFDrMb8tIgPPtTDfkwRozwFTggWlxk2R
 RcZoFfdOYcjaYQgIdzf7PfBBxCiRQJbnLZgfc0HRvZE2vt0YAcHdN+v3xqFX8mGJm6DPMZ
 XxoY4J8S7vYMsSDxNpjYOMhQ0bFgwfLsxrnZKxoY34RJZSmwpVINRbdRmXGM6n33bU6bpv
 /VI4ePzKkyCQEI3vcB1R9YPQFeMxfmI2coXt81nr0RgwHL2Mq/1kPLz5B3H40g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfymLXFMyqk4Fs7flS6ijwz4XZzVjiM9nENWRCJz0yE=;
 b=skRKVsZdxFJU+bdY3j+bGM6BFKP6VmyvmfLh5UbVAB88RTSBHxU+36HVq5PoDdhxp9R9fs
 kndnX8RQ/Ha09Zk/XrFMeUhc3PZDirl0R9JcuKRvNui8heOchfXtTR63nrWAabfj93JXLS
 8jVDyXSb+wC6cQkRD3jtqb2nC8V5SpKoVMN7Jrz4ksgrvOrDLaNDCM8ByeuCn8PxRkoMK1
 /o7oBqvW5sdl0q/i00QWfpgJ0ilxgig9FAI9rdrDzyIOldwBy+/mokWMRmlGpTCo9/symb
 FHUSQJ2GVdIujlgNrL5+45P+OdYzBc/UUd51jCmMmdoF1UeIUiSno9/x6tZRpA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 09/18] pinctrl: renesas: Synchronize R8A77951 H3 PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:40 +0200
Message-Id: <20230917140849.379711-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 489485bf1d97fa009f7
X-MBO-RS-META: npqxramdn818crwn9hdfe5ouazesyqbw
X-Rspamd-Queue-Id: 4RpVCs68Ghz9sTd
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

Synchronize R-Car R8A77951 H3 PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a77951.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77951.c b/drivers/pinctrl/renesas/pfc-r8a77951.c
index d094bd7cc94..5d1c81c3eae 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77951.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77951.c
@@ -19,12 +19,12 @@
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_29(1, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_15(2, fn, sfx, CFG_FLAGS),	\
-	PORT_GP_CFG_12(3, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE),	\
+	PORT_GP_CFG_12(3, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE_18_33),	\
 	PORT_GP_CFG_1(3, 12, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_1(3, 13, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_1(3, 14, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_1(3, 15, fn, sfx, CFG_FLAGS),	\
-	PORT_GP_CFG_18(4, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE),	\
+	PORT_GP_CFG_18(4, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE_18_33),	\
 	PORT_GP_CFG_26(5, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_32(6, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_4(7, fn, sfx, CFG_FLAGS)
@@ -5612,7 +5612,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED 16-1 */
 		MOD_SEL2_0 ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static const struct pinmux_drive_reg pinmux_drive_regs[] = {
@@ -5863,7 +5863,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(6, 30),  8, 3 },	/* GP6_30/USB2_CH3_PWEN */
 		{ RCAR_GP_PIN(6, 31),  4, 3 },	/* GP6_31/USB2_CH3_OVC */
 	} },
-	{ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
@@ -5874,7 +5874,7 @@ enum ioctrl_regs {
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL] = { 0xe6060380, },
 	[TDSELCTRL] = { 0xe60603c0, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a77951_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
@@ -6131,7 +6131,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[30] = SH_PFC_PIN_NONE,
 		[31] = SH_PFC_PIN_NONE,
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct sh_pfc_soc_operations r8a77951_pfc_ops = {
-- 
2.40.1

