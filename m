Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D219C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1076F84CC9;
	Wed, 15 Jul 2026 16:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="nhSKAsO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A7D84ABB; Wed, 15 Jul 2026 15:37:14 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E5584AC5
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso336328866b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784122631; x=1784727431; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EYGVCtHiIB5BT8ZAwqABVrhzLnSi7+F0i11HV+vMc04=;
 b=nhSKAsO6bhdlUae/c64LCgDEFk4X3KfiPpstxWu03GaC9vRwXrGzH4OrJ5YzOlRM6i
 VGHEpx0X/9z4BRWwrQ/Gpw/Av30XSSRQPvjKHwdf49wapkOeOsbxjCPywU497qu8Klei
 b678CpdayLcoXtm1gavW0IMAXKAds5k0oC6s5zGYfrVJEIucMeHMHPfL9/ORuDlh1BpU
 ChyKn5XcG6le02DuR7g1oJXWtoznZhkgtjB3g1iPgsLLX+RxQEOiJCuPsL0UQr7UoV8y
 NWvAWqRDoX+0Y/KgsYGf0bBYm8qkhvAJUO4MP33WB/SjT+6nQfDL0Nyw8DkIU4ExnC+J
 Tc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784122631; x=1784727431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EYGVCtHiIB5BT8ZAwqABVrhzLnSi7+F0i11HV+vMc04=;
 b=WpGfROXaerxtqGB3O6Z15BYff7QLzPWD2Bafuj3s0kyvVjFnlYZDTeo0mFY53nDP6n
 /p+DlUp1CzA4KxnHfQDPbNLYlyAO/dIgjzvCGlJX+g7bmJvQk+h6yi02X35QnxZ2W7NU
 UE4Gp3RwWATOMNjifxQVjSe7fpGA8KrFcqw0JhI0CkOhqe1pUTb/4QP4Ui7u9+GJaSaF
 O5vgMU0X6SXwZXUWPuxc5f431zFM7bEfQDwdGbmjiD2m26Ze8vnOD4TpioYeIZHW0eXG
 MPMXbsni+sGWeZwCJxIG9/Csgi6yGi1is3OVaE0v5DPDpbmm+Z6UABBiZT3vUoYsc2Dn
 0dkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrB6bJID80rGJ/ppO9Cr8ft7yav6DPpBdi6T1K+AGBDCwP5K8OvrWtd+Ce6WyX1+ObwNT+tw5Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzeXahda932xaGUyNiNOaW7wO72lnQAWYqKz911YAwUg8MUoJkC
 555TcrlseFgmCmIGSHkL9+GI3WVpCdmK/TLaIW95GoyUz0Py8wSRJJsPe+CIM1LaA2Q=
X-Gm-Gg: AfdE7cmN9beHyGgP8kPvSzMSI98/O3W3xSTrEQzK+ADKInBkEs6SQAHMb37gIMyx5AY
 /QUDAXc976K5olQNHgyjlbrYpRJU6ahdS8fYIQFghiQFVSscmq27VP5KWqz5LwBMW+uYvXdVKrj
 P3uImLJekPsX/lnzUarBP8YKSwk8vQzNimp708lugS27PP0LK+TEiDYRXgJ9iQissuvMebGNYfO
 h1YenKUQEQn1Ygk2JtWZVgVD8HdVSiU6okDbyKoA4n1NVnUceHfPUtM23IE1BneuPewUqNwB8x6
 4/dS0FrA5Y82zUkqCXBSgbRkTsbGYZSF9pMh4Tw8iRyYozekY8VthUmdoW80j0qEQZfmp2xKWDU
 08/oDJsXbqYfE0cmCqrlHWEuHwVP+4xSjxOJd8QS0an5znOqQ4dKdGsQ3S+6b5Qct1DMoOqT+wn
 gcTD6zgvQOxB1v2RxxMZVDpqsTRyvxZoJ1CxwBIi0OepJ0THjGHZE3Y9JVKzC32hBj1vU=
X-Received: by 2002:a17:907:a48:b0:c15:f5cc:7942 with SMTP id
 a640c23a62f3a-c161e90a096mr925850766b.2.1784122631249; 
 Wed, 15 Jul 2026 06:37:11 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871962cesm29896166b.25.2026.07.15.06.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:37:11 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 15:37:08 +0200
Subject: [PATCH 2/4] phy: phy-qcom-qusb2: Support reading has_se_clk_scheme
 from TCSR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-qusb2-msm8953-v1-2-b6e638599e02@fairphone.com>
References: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
In-Reply-To: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784122629; l=3365;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=jDpTNhftOlYuB58dghgG1r3gZttFSyeExuUruLReM8o=;
 b=0QIraSSN8P/5i7ORe52njff/yyGF7MNuVpEX5s8sWglATddit8cgyeeAdBgY5buncqurNo1ct
 kbnM3CqRkJ2A+JCLShR3ZJKdoHZFGGvwnhDVR6hpvXLoxQvuI0HCKH5
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:34:36 +0200
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

On SoCs like MSM8953 the fixed "se_clk_scheme_default" variable does not
reflect the correct value for that SoC, so support reading the correct
value from TCSR.

The code was adapted from the Linux driver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qcom/Kconfig          |  1 +
 drivers/phy/qcom/phy-qcom-qusb2.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 1fdadaccb12..ff85efeec32 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -35,6 +35,7 @@ config PHY_QCOM_QMP_UFS
 config PHY_QCOM_QUSB2
 	bool "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
+	depends on SYSCON
 	help
 	  Enable this to support the Super-Speed USB transceiver on various
 	  Qualcomm chipsets.
diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index a6c1095f412..01e64542c89 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -11,7 +11,9 @@
 #include <generic-phy.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <regmap.h>
 #include <reset.h>
+#include <syscon.h>
 
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 
@@ -318,6 +320,7 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
  *
  * @cfg_ahb_clk: AHB2PHY interface clock
  * @phy_rst: phy reset control
+ * @tcsr: TCSR syscon register map
  *
  * @cfg: phy config data
  * @has_se_clk_scheme: indicate if PHY has single-ended ref clock scheme
@@ -328,6 +331,7 @@ struct qusb2_phy {
 
 	struct clk cfg_ahb_clk;
 	struct reset_ctl phy_rst;
+	struct regmap *tcsr;
 
 	const struct qusb2_phy_cfg *cfg;
 	bool has_se_clk_scheme;
@@ -369,6 +373,7 @@ static int qusb2phy_power_on(struct phy *phy)
 {
 	struct qusb2_phy *qphy = dev_get_priv(phy->dev);
 	const struct qusb2_phy_cfg *cfg = qphy->cfg;
+	unsigned int clk_scheme;
 	int ret;
 	u32 val;
 
@@ -401,6 +406,31 @@ static int qusb2phy_power_on(struct phy *phy)
 	 */
 	qphy->has_se_clk_scheme = cfg->se_clk_scheme_default;
 
+	/*
+	 * read TCSR_PHY_CLK_SCHEME register to check if single-ended
+	 * clock scheme is selected. If yes, then disable differential
+	 * ref_clk and use single-ended clock, otherwise use differential
+	 * ref_clk only.
+	 */
+	if (qphy->tcsr) {
+		ret = regmap_read(qphy->tcsr, qphy->cfg->clk_scheme_offset,
+				  &clk_scheme);
+		if (ret) {
+			printf("%s: failed to read clk scheme reg\n", __func__);
+			return ret;
+		}
+
+		/* is it a differential clock scheme ? */
+		if (!(clk_scheme & PHY_CLK_SCHEME_SEL)) {
+			debug("%s(): select differential clk\n",
+			      __func__);
+			qphy->has_se_clk_scheme = false;
+		} else {
+			debug("%s(): select single-ended clk\n",
+			      __func__);
+		}
+	}
+
 	if (cfg->has_pll_test) {
 		if (!qphy->has_se_clk_scheme)
 			val &= ~CLK_REF_SEL;
@@ -488,6 +518,13 @@ static int qusb2phy_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	qphy->tcsr = syscon_regmap_lookup_by_phandle(dev,
+						     "qcom,tcsr-syscon");
+	if (IS_ERR(qphy->tcsr)) {
+		debug("%s: failed to lookup TCSR regmap\n", __func__);
+		qphy->tcsr = NULL;
+	}
+
 	debug("%s success qusb phy cfg %p\n", __func__, qphy->cfg);
 	return 0;
 }

-- 
2.55.0

