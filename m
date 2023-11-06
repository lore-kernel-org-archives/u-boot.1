Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78667C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857098710C;
	Mon,  6 Nov 2023 21:58:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PktRxJHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12AB8709F; Mon,  6 Nov 2023 21:57:58 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE067870BA
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so35249085e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304276; x=1699909076; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u3Lwir3usfpmNklHHBGdbJjieVpk5O4AvgqPjpUlFxs=;
 b=PktRxJHMmpn3gNE7MwN10QQDbBel9uzQOgeMyYyeVz6exucTFdNNrZ8/I4RoyFitBa
 SLsClza3ZAjYK4cfF3/GfBFYuFdtXlmNAqkP+YQMf8rnG4Qf13SYLJ0QuD6rWQ9oPeOx
 5Syyur3+QHAzPGkUZSdyA3ievNXzdoay5C9ClqTx2qAcUQUAOjOLx1iZQ86IOhGNPPWg
 SyDUW0WPLlhWpQ5YC7TQ8kyXBebtKnzNSpOnXzfHn9FldnQk8lqbbYB+cvv6rS6DVcSN
 WbWGieAHBH8uf23yV/XWITjSkJn2saVfUTONQ1zY3Y63l8z36vMEZp75V0+OZ2rdsvTV
 FUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304276; x=1699909076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3Lwir3usfpmNklHHBGdbJjieVpk5O4AvgqPjpUlFxs=;
 b=UObTT9iiN7ZJoHGDYMJ9vdQHAE6eUsTxf5yD6siajgo2p0qIGl7s7bodwmFbtaOMdZ
 WRNKkRTEvBHe3VHCMm8h3xrtiFZ6O57v0U7k666X1UNh9q62h+ArzlG8u4ImN5ECgl5X
 Y1SiCN8tvGU3PrAMx76hvdGsRvwB+jeV7Cetf++npMXrA2HGOFP2WXFH+B0iKDiHgNfc
 sAMoGShb/4cD8Uh/LtIEB5cs4XHowuwbErYOjermALAN1ow7kGMTGIVD9KWicBDqJslr
 17KWKJ1eB0Mxz5Ov9yDW5kZ1m7lkjbHgRG3p+G8lR+3vmd7D1QZm9EIzxmU6nvUzB8z8
 JITQ==
X-Gm-Message-State: AOJu0YzMszbaRmgzOwM6X2Y6J7Z+T1MheKwk9jfBCr5XWnVFHwAMFs6b
 xZjNZRBelo9ECLBw/PCPUlygDA==
X-Google-Smtp-Source: AGHT+IHLau+NAgzPf+2YvzVMdJrBjygE4lzDaU1vYu6pQWQQtC4wHbErlMPrnGxVOPjtBfUrRfU/Ag==
X-Received: by 2002:a05:6000:18a4:b0:32f:8a45:937f with SMTP id
 b4-20020a05600018a400b0032f8a45937fmr594036wri.2.1699304276166; 
 Mon, 06 Nov 2023 12:57:56 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b0032f7d1e2c7csm511210wrt.95.2023.11.06.12.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:57:55 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 06 Nov 2023 20:57:32 +0000
Subject: [PATCH 4/5] spmi: msm: fix register range names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-b4-qcom-dt-compat-v1-4-0ccbb7841241@linaro.org>
References: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
In-Reply-To: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4848;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=douo1xqSRB+pL2QxBKbvYfai1vUp5nATabk40aa2fpA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTPYP/uCG0V5oKPNec8vzxzrROvLfp5iVWxbPrf3NW3J
 zwzV7TuKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABP5c4zhf1pSmtuSIr8JbYLb
 w4/r23FMcPb08uGwjFqbvVa878HdU4wM6z83MGySF2Xb3Ov5jr3Y6a/ziy37iuomvni925+p+vL
 LRwA=
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
 arch/arm/dts/sdm845.dtsi |  2 +-
 drivers/spmi/spmi-msm.c  | 46 ++++++++++++++++++----------------------------
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/arm/dts/sdm845.dtsi b/arch/arm/dts/sdm845.dtsi
index 4798ace0ff8b..98f3744027bb 100644
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
 
diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index 27a035c0a595..f8834e60c266 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -70,7 +70,7 @@ enum pmic_arb_channel {
 
 struct msm_spmi_priv {
 	phys_addr_t arb_chnl;  /* ARB channel mapping base */
-	phys_addr_t spmi_core; /* SPMI core */
+	phys_addr_t spmi_chnls; /* SPMI core */
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
2.42.0

