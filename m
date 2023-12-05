Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2657C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 13:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C3E88782F;
	Tue,  5 Dec 2023 14:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dsbf5Cdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7B9878D1; Tue,  5 Dec 2023 14:47:10 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 465A6870F4
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 14:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c9ea37ac87so48259551fa.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 05:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701784027; x=1702388827; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oSVKwPCpUfU+pNF0Xc6YbmXdtGmRtY0Wqn9ElJEQEfU=;
 b=Dsbf5Cdk1Ht23NV9ap2ZHaS/4Fmr+DLbGEdp+CKVH3tKDFJN0XmE/L5h8E5xuQ7szg
 TdQjWMs5xBCq6wQMTffNsud2gDth1w26M7PXZDkjMXIiE4KLn7I9KxONJEauoQCiQGiw
 Ipm43SaDE+jl3MMA0QnfO7I7WldJdQDoboQ++vKxrhA2n3kosrrYRrRJbffUplUfemZ3
 cSzu8SomOfC4UwF6sGZ+19uVxLXfDtI2OUUdfGWp0MfOJKwCwOVXZB6yC+uO4rcNfq1J
 YRj1aMzN6X0sR7ETwVNOeNJfJD6gLdOamugUXn1UFQNwsft1F5J7P3GEpu3BcSkvwaGV
 jdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701784027; x=1702388827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSVKwPCpUfU+pNF0Xc6YbmXdtGmRtY0Wqn9ElJEQEfU=;
 b=b27cwRXu3LmEqAucIv2LBNyU9jGLN1XvK4vjdVkJDoZ1PxJJ2gt796Djg/53o2UZi1
 0+vZqyZMENLAbOawvQvnAIvzQYwJyROY7m4/OqNXnzAtbl3oFyTfdhatc0uLSFfLHn5x
 1Aq4sVfOzsO7EWjPYnzEpSVVAP6LlNZ3j/LvDS5kdb2pjh8DxJPuqOIFh21OODWSwqGQ
 Jrp4QTyQbapdt/PZVm1cbv+KtkJuQKSod7Jt/gOolH070mcqYxqT1gEdBRWN93BgQGIN
 05yVjPs/UaQ+Jwp5Cjq1TQSpD+cYWR6+e1Dq6yWxDAGw/lOUgeMuVyUGMSo5tLmdombx
 2GSw==
X-Gm-Message-State: AOJu0YyggMTAfkpfORt55ULfeLEyudieJTlDxc9Nb21qUYImqJPJnTmQ
 RXZvS5KwdoTuM1vkPRmZ7+Zpdw==
X-Google-Smtp-Source: AGHT+IE1Eur/kxpotn1+MRcCg8X7mPPWGIaPqJbwwv3bxH9m2GZKjxrn2/JvaijQ5AgVAyF8nVZO0w==
X-Received: by 2002:a2e:9d0c:0:b0:2ca:2bd:3cf1 with SMTP id
 t12-20020a2e9d0c000000b002ca02bd3cf1mr1587962lji.8.1701784027649; 
 Tue, 05 Dec 2023 05:47:07 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a2e928a000000b002ca0e0c837asm369688ljh.100.2023.12.05.05.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 05:47:07 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 05 Dec 2023 13:46:53 +0000
Subject: [PATCH v6 8/9] spmi: msm: fix register range names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-b4-qcom-dt-compat-v6-8-61d104a8f920@linaro.org>
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6866;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=T9w4U36ymjfw6HJqQmOKxMGleoY2Y7gEQwltDdAA430=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtR8zXMzX+9nDz5T+3y16oWgu+Zn/Y3y/+bsFkq7tUHAL
 XIGX+PSjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRn1sYGSap1siEv2yezn/k
 2NF7m/Ytve1mN++4j4zPs0mXhEqbpWIZ/uc/fP980ZV/9zabJXUeqj5z/AjrQd4Di3mqGBekFJ2
 LN7IEAA==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/qcs404-evb.dts                |  7 +++--
 arch/arm/dts/sdm845.dtsi                   |  2 +-
 doc/device-tree-bindings/spmi/spmi-msm.txt | 26 -----------------
 drivers/spmi/spmi-msm.c                    | 46 ++++++++++++------------------
 4 files changed, 23 insertions(+), 58 deletions(-)

diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
index bd2e303e10f4..07bf7dd0b32f 100644
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

