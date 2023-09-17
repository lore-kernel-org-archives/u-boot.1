Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE3ACD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2D086906;
	Sun, 17 Sep 2023 16:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ECsU20nA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LS+1F1Tp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EABB864D9; Sun, 17 Sep 2023 16:09:14 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC8E865A2
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVCq5Ltdz9sTW;
 Sun, 17 Sep 2023 16:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMsV7TIGfgI1hhDFVVVqCUg9FRAKsiQSTC1qijMUKTE=;
 b=ECsU20nA1TEgim+ObQmrqfZxhbJXk0v5KBDxfbxKkzLan5NlekkX4kxSzRs5rJNlqzJwyi
 +5XUPTiYxRfgCVoKWKcZtGIrddkGQJRAI9aDpROEVZQLvhkrhE9C1yJvYsn11HgxHFL8gw
 p5o06NrzUssHn0MvnOJ3SSctpHo0qz6QxU5Qw/j7hry+2jH6tarzeeINbs39nkC3eo9ywm
 OA36BL3PROvp/LWML6NUkPn8j5rUgupo2hmY39VQPBCOzlGcnd3qJ3AoIXpRwV83Z4KGdx
 G6wqdbVjMRYJZVyFnm/WMiT3UlDL2MOoMDw1LqVKe6iX/HJAjJNHgrSjyuAfKw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMsV7TIGfgI1hhDFVVVqCUg9FRAKsiQSTC1qijMUKTE=;
 b=LS+1F1TpWqgX9hvxMdhrInV4TD7nI5mp5b7Mxv2q/Zhlx9SgxLsV3OVvqKt3MkYevlRrms
 qxiD2ygjxflsFCs7VkmE3bslKwlQm+Rfx7/1neu4VTnbzGz3dsfkUhq5QyW6aOcn564ska
 XTZKpiIb+wCpsLPA4Yily3S6gPwp/cQdLbjVm22M3QgndmB6jOeC4RQNbiJInImJXwnkHo
 FuyfT8wrtCHu5EGQVFCM8ukmDVRy5iYdPIiz/7rd6+b2CBfpoIetmaTL1DOB8bh79piPqx
 MncwkkEl/jjL3bWoSKRzaf8udFEATpYidAJaV9miakAalYgz+hpP13z9nyB3LA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 04/18] pinctrl: renesas: Add support for 1.8V/2.5V I/O voltage
 levels
Date: Sun, 17 Sep 2023 16:08:35 +0200
Message-Id: <20230917140849.379711-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9b549a7c5fda48585c3
X-MBO-RS-META: yidxrcndme5dh1q6fgya4xmygujfi1yz
X-Rspamd-Queue-Id: 4RpVCq5Ltdz9sTW
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

Currently, the Renesas pin control driver supports pins that can switch
their I/O voltage levels between either 1.8V and 3.3V, or between 2.5V
and 3.3V.  However, some SoCs have pins that can switch between 1.8V and
2.5V.

Add support for this by replacing the separate SH_PFC_PIN_CFG_IO_VOLTAGE
capability and voltage level flags by a 2-bit field, to cover three
possible I/O voltage switching options.

Ported from Linux kernel commit by Geert Uytterhoeven:
b88e733ac517 ("pinctrl: renesas: Add support for 1.8V/2.5V I/O voltage levels")

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc.c    |  9 +++++++--
 drivers/pinctrl/renesas/sh_pfc.h | 20 +++++++-------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
index f6e8dd93374..3ac25cbd080 100644
--- a/drivers/pinctrl/renesas/pfc.c
+++ b/drivers/pinctrl/renesas/pfc.c
@@ -798,7 +798,7 @@ static bool sh_pfc_pinconf_validate(struct sh_pfc *pfc, unsigned int _pin,
 		return pin->configs & SH_PFC_PIN_CFG_DRIVE_STRENGTH;
 
 	case PIN_CONFIG_POWER_SOURCE:
-		return pin->configs & SH_PFC_PIN_CFG_IO_VOLTAGE;
+		return pin->configs & SH_PFC_PIN_CFG_IO_VOLTAGE_MASK;
 
 	default:
 		return false;
@@ -814,6 +814,7 @@ static int sh_pfc_pinconf_set(struct sh_pfc_pinctrl *pmx, unsigned _pin,
 	int bit, ret;
 	int idx = sh_pfc_get_pin_index(pfc, _pin);
 	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
+	unsigned int mode, hi, lo;
 
 	if (!sh_pfc_pinconf_validate(pfc, _pin, param))
 		return -ENOTSUPP;
@@ -851,8 +852,12 @@ static int sh_pfc_pinconf_set(struct sh_pfc_pinctrl *pmx, unsigned _pin,
 
 		pocctrl = (void __iomem *)(uintptr_t)addr;
 
+		mode = pin->configs & SH_PFC_PIN_CFG_IO_VOLTAGE_MASK;
+		lo = mode <= SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 ? 1800 : 2500;
+		hi = mode >= SH_PFC_PIN_CFG_IO_VOLTAGE_18_33 ? 3300 : 2500;
+
 		val = sh_pfc_read_raw_reg(pocctrl, 32);
-		if (arg == ((pin->configs & SH_PFC_PIN_VOLTAGE_18_25) ? 2500 : 3300))
+		if (arg == hi)
 			val |= BIT(bit);
 		else
 			val &= ~BIT(bit);
diff --git a/drivers/pinctrl/renesas/sh_pfc.h b/drivers/pinctrl/renesas/sh_pfc.h
index bf40944053f..e6c21176125 100644
--- a/drivers/pinctrl/renesas/sh_pfc.h
+++ b/drivers/pinctrl/renesas/sh_pfc.h
@@ -26,19 +26,13 @@ enum {
 #define SH_PFC_PIN_CFG_PULL_DOWN	(1 << 3)
 #define SH_PFC_PIN_CFG_PULL_UP_DOWN	(SH_PFC_PIN_CFG_PULL_UP | \
 					 SH_PFC_PIN_CFG_PULL_DOWN)
-#define SH_PFC_PIN_CFG_IO_VOLTAGE	(1 << 4)
-#define SH_PFC_PIN_CFG_DRIVE_STRENGTH	(1 << 5)
-
-#define SH_PFC_PIN_VOLTAGE_18_33	(0 << 6)
-#define SH_PFC_PIN_VOLTAGE_25_33	(1 << 6)
-#define SH_PFC_PIN_VOLTAGE_18_25	(2 << 6)
-
-#define SH_PFC_PIN_CFG_IO_VOLTAGE_18_33	(SH_PFC_PIN_CFG_IO_VOLTAGE | \
-					 SH_PFC_PIN_VOLTAGE_18_33)
-#define SH_PFC_PIN_CFG_IO_VOLTAGE_25_33	(SH_PFC_PIN_CFG_IO_VOLTAGE | \
-					 SH_PFC_PIN_VOLTAGE_25_33)
-#define SH_PFC_PIN_CFG_IO_VOLTAGE_18_25	(SH_PFC_PIN_CFG_IO_VOLTAGE | \
-					 SH_PFC_PIN_VOLTAGE_18_25)
+
+#define SH_PFC_PIN_CFG_IO_VOLTAGE_MASK	GENMASK(5, 4)
+#define SH_PFC_PIN_CFG_IO_VOLTAGE_18_25	(1 << 4)
+#define SH_PFC_PIN_CFG_IO_VOLTAGE_18_33	(2 << 4)
+#define SH_PFC_PIN_CFG_IO_VOLTAGE_25_33	(3 << 4)
+
+#define SH_PFC_PIN_CFG_DRIVE_STRENGTH	(1 << 6)
 
 #define SH_PFC_PIN_CFG_NO_GPIO		(1 << 31)
 
-- 
2.40.1

