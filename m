Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFECCFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED82E83DEC;
	Mon, 24 Nov 2025 16:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TFc0ikQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B9C83E23; Mon, 24 Nov 2025 16:10:53 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C35183B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477a219db05so26636505e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763997051; x=1764601851;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hNVuyV3rpU9s7u049NmgHgLiePZ0m76jL5k3MAZhdgU=;
 b=TFc0ikQ61eqpM2bsF7/Qyof/iHhDzpN+6fvDbSruoE8aG4pmIxFlLmuJiU/3xSiAGN
 4UZ2Yme5Sy4nPwA2aII3ItjRM7JKLOa0/q4gHMtqjcC9vuikNaXljLmcEuEams8Zmlc5
 qX7XTeIfOhz2HFUMrnsEFtUq3lI2/7yy/lWaJ/z7LLSGEewn8jmTc/SvtFdWqTYNZJgH
 8AVSfwLUO/2xsKzlbrPKBmcJVrM4giS5FxZwgaELV7wPWWiTuCLmwt8LF5zPJ2kY7+RJ
 KLJVCLRoM97NsvtNvgUIuaHNpdYAUw+w2IBFXTpVp+FiuM8uK4ufFQjj6MVIU/Lt1rVZ
 qgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763997051; x=1764601851;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNVuyV3rpU9s7u049NmgHgLiePZ0m76jL5k3MAZhdgU=;
 b=ACyM3z9qs21X17jKe5JC1WgOkSXzyAvf9rV6g3MjS53WE+/Vfq7mkhCVT3rwR1N3wn
 12UDEUQMorbPmnW+5OuRbHE2Q0qRx8nCP8kcirnAv5EcmrfDJvdMzBDI2CNAybNKUQhc
 mdKZOXH9j1Rkg/NxInaDsI6kxSWBNmbATwtAfcQnRORgPv/XKJ2IRR5TRlhYxwWRVWDE
 XN9fnafCbXp3+v8Paxr06Bpv6XvJMXKlD68WkNZNYjnozT8AHRaVVjp4wmtA+3XIEafx
 IggKx4Qw68Pm47VXyEC8qSTGRSNRwc1MvXunOwu3klTN6MjK9BDuEiGAAyvP+UgRmmkO
 NjEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCWTKbUaXWsVU3spgUq8qVM4va/HPZTjvvfwymZjvRzx+W1yvruwyz99sLN9En1L0ktTcyf9A=@lists.denx.de
X-Gm-Message-State: AOJu0Yzt8o6E948cQBHhQBAfpsV6RtxLOSv4uG4Z+mhjHEaykyj1oryY
 pEseKK7aJPN1wh3JftChCSkuvN7FaK8VEwRLE4GvJtGrWa7ilMzgzv2nys68No9GLbc=
X-Gm-Gg: ASbGncuRgLnoI0XtDtvNLqAv445ctyKMXtgGfWMOjQKUB20mp/V5qcVz0/YuXopCeia
 eK8WTDymfaxroW4QKCD/mdLzdNpck12iGRPpAGH8WsPDL8FEyKnpzKZNq7fXw3PNneua3cgAy8e
 V/4bmNc6iUspdMDPZau7Xepcd7BHz+c5/MiWHnTAEW/8DhJ3U8oYNBaXnqkxcMVwTI5cgKoKcSW
 zVvpDtx9KDepvl+jTj3WXNPBOH4XasYlc2YWwJRGTBIDbtQTppHMcTafdohrWim4x7VoMSYLYi7
 s1JSulQwDYllGz3e/9HGFyhBE2Lt0UzVjAes925IC8tZzSoW+cS4/lXPhl0Ns5jdtfZGkYt0a7c
 EDL2HJfzut5B3H0zw+Ip4g8sZxDUJAovi2lDf0WW7IzjDh3UM+h7v5RYYGRa/DYgUBbDD+OeQ9f
 fxZ2iqOysBa5Ne1Av4WtNmD/LN
X-Google-Smtp-Source: AGHT+IHu67VhQ8LPRWM/gdmQ8/IR8Xj9yfWqNpzSK+3Vf71nPMbe0HOsmSVh7CoGL9Vh7Gjo29y5HQ==
X-Received: by 2002:a05:600c:3b05:b0:475:e007:baf1 with SMTP id
 5b1f17b1804b1-477c1133955mr117602895e9.34.1763997050995; 
 Mon, 24 Nov 2025 07:10:50 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:d26c:ecfc:3035:7758])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf36f535sm205398295e9.8.2025.11.24.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:10:50 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 24 Nov 2025 16:09:47 +0100
Subject: [PATCH] board: ti: am6x: Restore do_board_detect functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-fixti-v1-1-6b2d37536905@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADp1JGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyMT3bTMipJMXcPkJHMz02RLCyNDCyWg2oKiVKAE2Jzo2NpaAEG5itF
 XAAAA
X-Change-ID: 20251124-fixti-1cb765c98218
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Peng Fan <peng.fan@nxp.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Michal Simek <michal.simek@amd.com>, Dhruva Gole <d-gole@ti.com>, 
 Aashvij Shenai <a-shenai@ti.com>, t-pratham@ti.com, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
X-Mailer: b4 0.14.3
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

This patch fixes a boot failure on the AM64x EVM that was introduced when the do_board_detect function was removed during a refactoring.

It restores the do_board_detect function for the AM64x, AM62x, and AM65x boards to ensure the common board detection logic is executed correctly.

Fixes: 804b80288ac ("board: am65x: Use generic AM6x board detection function")
Fixes: ce56e553c31 ("board: am64x: Use generic AM6x board detection functions")
Fixes: ff1b83c095c ("board: am62x: Add support for reading eeprom data")
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 board/ti/am62x/evm.c           | 9 +++++++--
 board/ti/am64x/evm.c           | 9 +++++++--
 board/ti/am65x/evm.c           | 9 +++++++--
 board/ti/common/board_detect.c | 2 +-
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 6bb243ee597..e9eba57eba7 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -82,11 +82,16 @@ struct efi_capsule_update_info update_info = {
 };
 
 #if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
+int do_board_detect(void)
+{
+	return do_board_detect_am6();
+}
+
 int checkboard(void)
 {
 	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
 
-	if (!do_board_detect_am6())
+	if (!do_board_detect())
 		printf("Board: %s rev %s\n", ep->name, ep->version);
 
 	return 0;
@@ -97,7 +102,7 @@ static void setup_board_eeprom_env(void)
 {
 	char *name = "am62x_skevm";
 
-	if (do_board_detect_am6())
+	if (do_board_detect())
 		goto invalid_eeprom;
 
 	if (board_is_am62x_skevm())
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 3688cf2ca25..25076a8a588 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -114,11 +114,16 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
 #endif
 
 #ifdef CONFIG_TI_I2C_BOARD_DETECT
+int do_board_detect(void)
+{
+	return do_board_detect_am6();
+}
+
 int checkboard(void)
 {
 	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
 
-	if (!do_board_detect_am6())
+	if (!do_board_detect())
 		printf("Board: %s rev %s\n", ep->name, ep->version);
 
 	return 0;
@@ -135,7 +140,7 @@ static void setup_board_eeprom_env(void)
 {
 	char *name = "am64x_gpevm";
 
-	if (do_board_detect_am6())
+	if (do_board_detect())
 		goto invalid_eeprom;
 
 	if (board_is_am64x_gpevm())
diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 68606746d5f..b35a9229033 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -72,11 +72,16 @@ int board_fit_config_name_match(const char *name)
 #endif
 
 #ifdef CONFIG_TI_I2C_BOARD_DETECT
+int do_board_detect(void)
+{
+	return do_board_detect_am6();
+}
+
 int checkboard(void)
 {
 	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
 
-	if (do_board_detect_am6())
+	if (do_board_detect())
 		/* EEPROM not populated */
 		printf("Board: %s rev %s\n", "AM6-COMPROCEVM", "E3");
 	else
@@ -89,7 +94,7 @@ static void setup_board_eeprom_env(void)
 {
 	char *name = "am65x";
 
-	if (do_board_detect_am6())
+	if (do_board_detect())
 		goto invalid_eeprom;
 
 	if (board_is_am65x_base_board())
diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index d49e26fa453..a235ea9ef21 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -825,7 +825,7 @@ bool __maybe_unused board_ti_was_eeprom_read(void)
 		return false;
 }
 
-#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
+#if IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)
 int do_board_detect_am6(void)
 {
 	int ret;

---
base-commit: 2d7eee5a55472f885474168acd3295d47a559755
change-id: 20251124-fixti-1cb765c98218

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>

