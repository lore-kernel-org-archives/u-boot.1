Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BEACD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ED6884A63;
	Mon,  1 Jun 2026 14:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V2mE3odX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B2098487C; Mon,  1 Jun 2026 13:52:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16BDC8487F
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 13:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+petr.hodina.protonmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A1356441FD;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79EFCC2BCC6;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780314758;
 bh=+POkcUix82DF7DOek9B/SjKT8ZTkOeTQS/wr1Ai/5JQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=V2mE3odXk3oKOkSLJEfv0evQ/Vp1e9q/rpD09zJtKsJA72/j/BuOSMdXQr/7MBFkL
 jTVhYy0w7l2QPhDiiivCbhGCRzagWLalUloO/OTZoOx28/MV6q4w2exPAOcCHIKek+
 3ZX7tp0lsHYuiurrfDqTJRX4Lv0gXFJpWT6Frgkxk9sGEnx8KG2CZ2KYdxpjRL4paS
 eDT/1mZ+neKl22DjN27ZegMtI7svjuZ23KJ4J915CAy3Q69RIzq3xo6PxtfVCKGqd/
 Epi6eXEMlegE1OOmefmRTh4h2re2UwdDQqUjPKFkx8wFQOifG30bunnwfCtKUFgtSj
 ddKzntkuNdxQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7161CCD6E5D;
 Mon,  1 Jun 2026 11:52:38 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Mon, 01 Jun 2026 13:52:35 +0200
Subject: [PATCH 1/2] gpio: qcom_pmic_gpio: implement standard pinconf
 parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-gpio-v1-1-e24bcdb35da0@protonmail.com>
References: <20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com>
In-Reply-To: <20260601-qcom-gpio-v1-0-e24bcdb35da0@protonmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, phone-devel@vger.kernel.org, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780314756; l=2828;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=hinwgaYrU1XCJQzW4fBDv8E8o7r9z/FdGjiF7nGEfRw=;
 b=/PPQpDX1dQHdFwFVgV8gwnvrNF6UJxzJFFjUNEdpcAtfq5x4n5waDC40fqXeXAZFt6pAuDupg
 LIB7f7ElNb+ALtU1+1l0VT5UJ7EUvEQ5k/14Zx4XZi4nu/heoMt6ztZ
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Petr Hodina <petr.hodina@protonmail.com>

Set bias-pull-up/down/disable, input-enable and the vendor
qcom,drive-strength properties in pinconf_params.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/gpio/qcom_pmic_gpio.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 4458c55cd3d..71cc76fef2f 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -56,6 +56,8 @@
 #define REG_DIG_VIN_VIN0       0
 
 #define REG_DIG_PULL_CTL       0x42
+#define REG_DIG_PULL_UP_30K    0x0
+#define REG_DIG_PULL_DN        0x4
 #define REG_DIG_PULL_NO_PU     0x5
 
 #define REG_LV_MV_OUTPUT_CTL	0x44
@@ -365,6 +367,11 @@ U_BOOT_DRIVER(qcom_pmic_gpio) = {
 static const struct pinconf_param qcom_pmic_pinctrl_conf_params[] = {
 	{ "output-high", PIN_CONFIG_OUTPUT_ENABLE, 1 },
 	{ "output-low", PIN_CONFIG_OUTPUT, 0 },
+	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
+	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
+	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 0 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
+	{ "qcom,drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
 };
 
 static int qcom_pmic_pinctrl_get_pins_count(struct udevice *dev)
@@ -387,9 +394,31 @@ static const char *qcom_pmic_pinctrl_get_pin_name(struct udevice *dev, unsigned
 static int qcom_pmic_pinctrl_pinconf_set(struct udevice *dev, unsigned int selector,
 					 unsigned int param, unsigned int arg)
 {
-	/* We only support configuring the pin as an output, either low or high */
-	return _qcom_gpio_set_direction(dev, selector, false,
-					param == PIN_CONFIG_OUTPUT_ENABLE);
+	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	u32 gpio_base = plat->pid + REG_OFFSET(selector);
+
+	switch (param) {
+	case PIN_CONFIG_OUTPUT_ENABLE:
+	case PIN_CONFIG_OUTPUT:
+		return qcom_gpio_set_direction(dev, selector, false,
+					       param == PIN_CONFIG_OUTPUT_ENABLE);
+	case PIN_CONFIG_INPUT_ENABLE:
+		return qcom_gpio_set_direction(dev, selector, true, 0);
+	case PIN_CONFIG_BIAS_PULL_UP:
+		return pmic_reg_write(plat->pmic, gpio_base + REG_DIG_PULL_CTL,
+				      REG_DIG_PULL_UP_30K);
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		return pmic_reg_write(plat->pmic, gpio_base + REG_DIG_PULL_CTL,
+				      REG_DIG_PULL_DN);
+	case PIN_CONFIG_BIAS_DISABLE:
+		return pmic_reg_write(plat->pmic, gpio_base + REG_DIG_PULL_CTL,
+				      REG_DIG_PULL_NO_PU);
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		return pmic_reg_write(plat->pmic, gpio_base + REG_DIG_OUT_CTL,
+				      REG_DIG_OUT_CTL_CMOS | (arg & 0x3));
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 static const char *qcom_pmic_pinctrl_get_function_name(struct udevice *dev, unsigned int selector)

-- 
2.53.0


