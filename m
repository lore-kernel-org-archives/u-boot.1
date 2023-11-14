Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807D3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4F68749E;
	Tue, 14 Nov 2023 14:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oH3b6srR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3E68748F; Tue, 14 Nov 2023 14:48:56 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D1187474
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso33196455e9.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699969733; x=1700574533; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K4HJn/tQnDoPEBtaMDZXekvN7HN3mdSExqfi0/VY234=;
 b=oH3b6srRJ8o9FCxtXIx/Q3n/nh48AW6pJqi5iftFjNwvCq/ysCa/j5VITQjm6tf3IX
 2QWK4IVcenYwk77ksPcIxAt3kFIObGLFP0PPgqTa/V3dUttbl9xEB2fS20N7QcTciBE6
 s3I5bH9nCVJBFVn7eCCcBw2YriEJItB1v41Ef8uocBWhv64siUwMyKWh5ORq8KljZLBY
 ypXcv1BqMESa29+Y8PgofPQrUqlRpU2ZbsgDMhrTsjDcewg5bIMJHEXoTflJafL3rniS
 1vTCfcf+EQTjDjaKYbjh2PKT9nYt8Ki/FHrbgTQLoD/cKVh2Es3ZHR/t4TyDPYan5uWN
 GrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699969733; x=1700574533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4HJn/tQnDoPEBtaMDZXekvN7HN3mdSExqfi0/VY234=;
 b=Sp6kWBm84vn3jQS4nOzJ56iUlHwEM8qtSl1e2YJl8oNhnUvaqNemEYJq+meT+L0mI+
 FmkQ29P7zG0icbMnO6baHlHCXZzdEZxPGfhQSbN7rUIuuTusQt7HW2t+Ds3uDmFVP/PI
 YBmsPGa6lIZHkA7w3xOdkGnbhOSkUQJJbJa2VeLwC3JR+Duza2HU/UoN0HiIQd562MrD
 FRgprW03+1+Mhk+6zB6SDOBGoUTM+YgW9FT4s+mU4JQ6ahKRe5wOytHEURv/Syqob+Tn
 AfzM7JaTsUb5A2Mpir3DBV+q8Jj4PWZq7lC2G5BcNm0dXYuitcDs7L8AGjMW2flV2Kdo
 PzKg==
X-Gm-Message-State: AOJu0YxXULYSaISeW0S3K9b7bD9FguTXPX8WjOwGLeUfMBa3ls7nGWNh
 dGOJI5fLgwl/Lie13aKFXLp6mQ==
X-Google-Smtp-Source: AGHT+IGaWIjPgBMiU0W0jyK8UeOo6mhAaFM4YCEB8xmq/TtTwUW+pbVnJZbZhbj3KX/mfGwn4HD5TQ==
X-Received: by 2002:a05:600c:1549:b0:409:6e0e:e95a with SMTP id
 f9-20020a05600c154900b004096e0ee95amr2211020wmg.19.1699969733524; 
 Tue, 14 Nov 2023 05:48:53 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a5d4b4a000000b003313426f136sm7804220wrs.39.2023.11.14.05.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 05:48:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 13:48:50 +0000
Subject: [PATCH v3 4/5] spmi: msm: fix register range names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-qcom-dt-compat-v3-4-88a92f8f00ba@linaro.org>
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
In-Reply-To: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4848;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5Nq6pIXn+6EIZVVsV3wf0ErrywVU36ZaB7JxmmJtnFg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgqgN2+cWyJXz6AasnmnstSNWp+CQs53xo180GGaeZL
 ir6nhodpSwMghwMsmKKLOInllk2rb1sr7F9wQWYOaxMIEMYuDgFYCIH8hkZ9mxMXCcTeGT1zT12
 XzxiFAtPvipZx+Z5cfVy4f5FJY2T6hkZNty/xXgoUX/p7o2CXgeElf/9vx//ZZ2kQkDNnMDS7/+
 5hQE=
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
2.42.1

