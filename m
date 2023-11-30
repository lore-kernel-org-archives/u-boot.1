Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CECBC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432638772D;
	Thu, 30 Nov 2023 21:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YA+pcJAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2815087723; Thu, 30 Nov 2023 21:22:58 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C708876F6
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b3e7f2fd9so12823655e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375774; x=1701980574; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FdtUBSDF6w50SH691fL4oUvk9mLbWDRKwBTBsQpRvM8=;
 b=YA+pcJAws3vAjETFISKyNUGg0jvsGCzY360wC9auPMb6BG2CdhNY6+1hQ9DnrkvtAv
 1cuy9K6wQ7WNwoiX+OKzg2gXyqx8lmje8eXMm8Lx7on+khzVPlzUN4OpUffmkyWtDunU
 wLdJ2ctndFmWamBVs0Fe4b6T5nyX6S5v+d7r9Y+D2dOZdPr0hDWP0B0bAxHLjggRRxqP
 aw5Sd2DgufhWQmFUXzlQ00SrrS4/ZHEfvrrMGe7K8M4Vu4tiXgVnnskvnu4+Xg7ejX+T
 BtJqYPoWHzidHmDpXdbBnWI0a9+/0rnWFfkIKbygwju7XPE/3izvYgaOSKhcD7Jm8dY7
 u7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375774; x=1701980574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdtUBSDF6w50SH691fL4oUvk9mLbWDRKwBTBsQpRvM8=;
 b=dDBFWGy2s6PDJT6nPK2SbOSE09WN9kHPl5hdSU9/soJoQXsJkJi2Ib78jWH4KnWZZT
 Uwr/JLDvAxER4av1hQKquJY8cVtnpHtbeoaBUQCoOITu8miDCwhfRD9594O5c676tTWw
 lnenXyQpDDiJA4dS3kWXBBDVKBvuf/GVsb/rQInjlwXlYoHqRREOMPpx1gf5DAnJG3DC
 XbpP3U3VBk6NpG6pPrVuQN2FPUdvZOwEyJz0qRbvjNsV8cDYE7jfnryWtLF/K4gMIgAd
 DNHZPInPxEV3ZW246jSnSA6L26uuP85yNaO2UMrt1Q/qty/+2tv4cE5f6Td8Pcp3xYw4
 Yxiw==
X-Gm-Message-State: AOJu0YyrPdWkTB8u2CTlnJSwdL7eANUNBEGC6sANj6MHN0inOcE17WTf
 S32AtRmz4M5/a897Oq2/2SqPmA==
X-Google-Smtp-Source: AGHT+IEK2b4Sl2O6OzSTvG0zUgHeAxMEBMouyzKfQ2Jr5fvujzFEzxI1/JUp10LQ4RVxI1qVO9tIJA==
X-Received: by 2002:a05:600c:228c:b0:40b:5e21:c599 with SMTP id
 12-20020a05600c228c00b0040b5e21c599mr27948wmf.103.1701375774592; 
 Thu, 30 Nov 2023 12:22:54 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:54 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:32 +0000
Subject: [PATCH v5 8/9] spmi: msm: fix register range names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-8-41500e237ad0@linaro.org>
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=6713;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ngCQCcWA79jZqTpSLCdIzQaxdPsoQIWp6rrKFzavTy8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM92Jq7TMDy6weF68+lBe00vpYHrvCzxqmm99CDFceq
 Oy4k/2to5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzEToGRoXFzLsvvDjeL90sf
 BHCcUVe/ttHRIlZmX8LhR/Jlk/bIb2D4714S591i/1N19eydnX/12Xk7Tu3vb/z18K75B8Gdri8
 nJwEA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The core and chnl register ranges were swapped on SDM845. Fix it, and
fetch the register ranges by name instead of by index.

Drop the cosmetic "version" variable and clean up the debug logging.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/qcs404-evb.dts                |  7 +++--
 arch/arm/dts/sdm845.dtsi                   |  2 +-
 doc/device-tree-bindings/spmi/spmi-msm.txt | 26 -----------------
 drivers/spmi/spmi-msm.c                    | 46 ++++++++++++------------------
 4 files changed, 23 insertions(+), 58 deletions(-)

diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
index 3bb580ba4e17..cf41e5a33dbe 100644
--- a/arch/arm/dts/qcs404-evb.dts
+++ b/arch/arm/dts/qcs404-evb.dts
@@ -362,9 +362,10 @@
 
 		spmi@200f000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x200f000 0x1000
-			       0x2400000 0x400000
-			       0x2c00000 0x400000>;
+			reg = <0x200f000 0x001000>,
+			      <0x2400000 0x800000>,
+			      <0x2c00000 0x800000>;
+			reg-names = "core", "chnls", "obsrvr";
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
 
diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index a26e9f411ee0..96c9749a52c0 100644
--- a/arch/arm/dts/sdm845.dtsi
+++ b/arch/arm/dts/sdm845.dtsi
@@ -63,7 +63,7 @@
 			reg = <0xc440000 0x1100>,
 			      <0xc600000 0x2000000>,
 			      <0xe600000 0x100000>;
-			reg-names = "cnfg", "core", "obsrvr";
+			reg-names = "core", "chnls", "obsrvr";
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
 
diff --git a/doc/device-tree-bindings/spmi/spmi-msm.txt b/doc/device-tree-bindings/spmi/spmi-msm.txt
deleted file mode 100644
index ae47673b768b..000000000000
--- a/doc/device-tree-bindings/spmi/spmi-msm.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Qualcomm SPMI arbiter/bus driver
-
-This is bus driver for Qualcomm chips that use SPMI to communicate with PMICs.
-
-Required properties:
-- compatible: "qcom,spmi-pmic-arb"
-- reg: Register block adresses and sizes for various parts of device:
-   1) PMIC arbiter channel mapping base (PMIC_ARB_REG_CHNLn)
-   2) SPMI write command (master) registers (PMIC_ARB_CORE_SW_DEC_CHANNELS)
-   3) SPMI read command (observer) registers (PMIC_ARB_CORE_REGISTERS_OBS)
-
-Optional properties (if not set by parent):
-- #address-cells: 0x1 - childs slave ID address
-- #size-cells: 0x1
-
-All PMICs should be placed as a child nodes of bus arbiter.
-Automatic detection of childs is currently not supported.
-
-Example:
-
-spmi@200f000 {
-	compatible = "qcom,spmi-pmic-arb";
-	reg = <0x200f800 0x200 0x2400000 0x400000 0x2c00000 0x400000>;
-	#address-cells = <0x1>;
-	#size-cells = <0x1>;
-};
diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 27a035c0a595..5fe8a70abca7 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -70,7 +70,7 @@ enum pmic_arb_channel {
 
 struct msm_spmi_priv {
 	phys_addr_t arb_chnl;  /* ARB channel mapping base */
-	phys_addr_t spmi_core; /* SPMI core */
+	phys_addr_t spmi_chnls; /* SPMI channels */
 	phys_addr_t spmi_obs;  /* SPMI observer */
 	/* SPMI channel map */
 	uint8_t channel_map[SPMI_MAX_SLAVES][SPMI_MAX_PERIPH];
@@ -95,10 +95,10 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 
 	/* Disable IRQ mode for the current channel*/
 	writel(0x0,
-	       priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_CONFIG);
+	       priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_CONFIG);
 
 	/* Write single byte */
-	writel(val, priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_WDATA);
+	writel(val, priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_WDATA);
 
 	/* Prepare write command */
 	reg |= SPMI_CMD_EXT_REG_WRITE_LONG << SPMI_CMD_OPCODE_SHIFT;
@@ -113,12 +113,12 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
 		ch_offset = SPMI_CH_OFFSET(channel);
 
 	/* Send write command */
-	writel(reg, priv->spmi_core + SPMI_CH_OFFSET(channel) + SPMI_REG_CMD0);
+	writel(reg, priv->spmi_chnls + SPMI_CH_OFFSET(channel) + SPMI_REG_CMD0);
 
 	/* Wait till CMD DONE status */
 	reg = 0;
 	while (!reg) {
-		reg = readl(priv->spmi_core + SPMI_CH_OFFSET(channel) +
+		reg = readl(priv->spmi_chnls + SPMI_CH_OFFSET(channel) +
 			    SPMI_REG_STATUS);
 	}
 
@@ -186,47 +186,37 @@ static struct dm_spmi_ops msm_spmi_ops = {
 static int msm_spmi_probe(struct udevice *dev)
 {
 	struct msm_spmi_priv *priv = dev_get_priv(dev);
-	phys_addr_t config_addr;
+	phys_addr_t core_addr;
 	u32 hw_ver;
-	u32 version;
 	int i;
-	int err;
 
-	config_addr = dev_read_addr_index(dev, 0);
-	priv->spmi_core = dev_read_addr_index(dev, 1);
-	priv->spmi_obs = dev_read_addr_index(dev, 2);
+	core_addr = dev_read_addr_name(dev, "core");
+	priv->spmi_chnls = dev_read_addr_name(dev, "chnls");
+	priv->spmi_obs = dev_read_addr_name(dev, "obsrvr");
 
-	hw_ver = readl(config_addr + PMIC_ARB_VERSION);
+	hw_ver = readl(core_addr + PMIC_ARB_VERSION);
 
 	if (hw_ver < PMIC_ARB_VERSION_V3_MIN) {
 		priv->arb_ver = V2;
-		version = 2;
-		priv->arb_chnl = config_addr + APID_MAP_OFFSET_V1_V2_V3;
+		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
 	} else if (hw_ver < PMIC_ARB_VERSION_V5_MIN) {
 		priv->arb_ver = V3;
-		version = 3;
-		priv->arb_chnl = config_addr + APID_MAP_OFFSET_V1_V2_V3;
+		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V1_V2_V3;
 	} else {
 		priv->arb_ver = V5;
-		version = 5;
-		priv->arb_chnl = config_addr + APID_MAP_OFFSET_V5;
-
-		if (err) {
-			dev_err(dev, "could not read APID->PPID mapping table, rc= %d\n", err);
-			return -1;
-		}
+		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V5;
 	}
 
-	dev_dbg(dev, "PMIC Arb Version-%d (0x%x)\n", version, hw_ver);
+	dev_dbg(dev, "PMIC Arb Version-%d (%#x)\n", hw_ver >> 28, hw_ver);
 
 	if (priv->arb_chnl == FDT_ADDR_T_NONE ||
-	    priv->spmi_core == FDT_ADDR_T_NONE ||
+	    priv->spmi_chnls == FDT_ADDR_T_NONE ||
 	    priv->spmi_obs == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-	dev_dbg(dev, "priv->arb_chnl address (%llu)\n", priv->arb_chnl);
-	dev_dbg(dev, "priv->spmi_core address (%llu)\n", priv->spmi_core);
-	dev_dbg(dev, "priv->spmi_obs address (%llu)\n", priv->spmi_obs);
+	dev_dbg(dev, "priv->arb_chnl address (%#08llx)\n", priv->arb_chnl);
+	dev_dbg(dev, "priv->spmi_chnls address (%#08llx)\n", priv->spmi_chnls);
+	dev_dbg(dev, "priv->spmi_obs address (%#08llx)\n", priv->spmi_obs);
 	/* Scan peripherals connected to each SPMI channel */
 	for (i = 0; i < SPMI_MAX_PERIPH; i++) {
 		uint32_t periph = readl(priv->arb_chnl + ARB_CHANNEL_OFFSET(i));

-- 
2.42.1

