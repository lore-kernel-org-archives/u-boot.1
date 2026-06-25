Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC96ACDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E02484894;
	Thu, 25 Jun 2026 19:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="ADqc49jW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2068495B; Thu, 25 Jun 2026 15:14:54 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3642D84949
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c08acccf4a4so393524066b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1782393292; x=1782998092; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Brz1HqWvShFrZE10GApHLmq4hH7RY2V9qJIBpBiH0Xo=;
 b=ADqc49jWSrvNgtSpP2OGvkQ6PVR+2po9Evq/h5y5flUbaeKARjfxViZQKMfXw1aSip
 NJNb4FIsDv/a/B96drKx/CmE7kCYm81mVK6+xhmOHF8JzmpcmzywQTvMU8S5mYIxrCKY
 XG/C5NL8pOB/9KDyzhkxm93OMWm4in7pk4fi9lVOWq7ZFjS1/qFyCgKgkNvIEeyzXaCB
 wUSQDl3JdtiXxMynbyGe/nvuPYcbWUAVCCXcpo1286OnJDcMSEINjpk5YL5bso8T3Vtj
 GgxmKZEbxYTREXpAfl72IpaVP/QUXk2GOpFrMHzJDgNFq2lHS/nqUY5hwUMEdhf2Zc+t
 dW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782393292; x=1782998092;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Brz1HqWvShFrZE10GApHLmq4hH7RY2V9qJIBpBiH0Xo=;
 b=oZ6yZNjRJQ0tkRxPD/kqRCACmh2E7ZcO99eMb5FiNMUoVUROc9/GjkuhHDB5MjV4t6
 ygvDRxQIKy4/+QMLg4IlZVSCGSX1M4jwjeDBjIdpn5pQVLvdz/6dcMalxE9KKtsC+cGI
 VrHtpjBbeWQWAgOGwyinyco36J4uP/yiIJrMDqN8GaZqeVeVjtdl9yXsb8yV2TP/na0x
 Bk0iNJamj9zIh0fBuDZn0wlHTPNboTMjuo7KxHenyecNRmTx/ChSj3P6oT1bpb2mh7Vv
 JZ2a1q1euaHZ79W7RlcumnG2jZhDNvBPt0kl/JhwbmBl98dQjprPowTgBCCoM55k/HlV
 argg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp87a4byMRH580rxzFBrjf/608cajV5NZjsZOTOpCLDlSjL19bnHstTgPh+WxpHPwRvuFadHCU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyng0s/t43NUHr9L5VnuqCtiHrctkRlZJ0Uzm4jb4WEYiZ/3E3L
 ZsD8fh2E0tMI0hQ4ko/eNMPBz43GXmVqSScXQndFjkAC2yW9iDNkKQxdXasII+Ew7rc=
X-Gm-Gg: AfdE7cmEzz/lUaYkbP6MV8Jken/7H9OZ3j4JxaC397GWR1i7Ecu1bwNLvzrRYpkIfri
 PNAj4ttk17Q7AbueWEDyvd3jMAjGCmto/Ay9ooJWEIP9zAiWh+Sf8dBbdbXFpvcMGROov0DoQAg
 cqAcf/QOgh/4bzaRPQjNxDyIXJMLqWApCVAIx3aXw/Cr/lnqahMEnZevxjwi6hkDmxmAhCt9jvb
 XCpEKpl31kdvH+tnp0bJTZvmZTssFI1sRIXKov9Ng8hFPtR04GGkiPNRR0tG3avaAzTR6VGgxiT
 m/WBrtsgUM6NPdnypHOUFNCevVF3HWYDu7hCXmBPsM7ds3LXiY2X2BCaNwgKTYww9GAyP1i9Gn1
 iiMX1DuJc4y7ZmIHtSqU6EgX02h9cnF2t7uO/wwehgVVTJzTRys7w6kKdPQtSmgK/ULdlDwTIcy
 WReVOl6grWlb+cKPMVUC/XFyz+Eg==
X-Received: by 2002:a17:906:9f86:b0:c11:f5dc:22b with SMTP id
 a640c23a62f3a-c1205d97ee4mr186955666b.14.1782393291620; 
 Thu, 25 Jun 2026 06:14:51 -0700 (PDT)
Received: from [172.16.168.121] ([195.76.196.164])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c11fbe05fa8sm180365066b.38.2026.06.25.06.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:14:51 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 25 Jun 2026 15:14:39 +0200
Subject: [PATCH 2/2] clk/qcom: milos: Add TCSRCC clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-milos-ufs-fix-v1-2-b0923dabc35f@fairphone.com>
References: <20260625-milos-ufs-fix-v1-0-b0923dabc35f@fairphone.com>
In-Reply-To: <20260625-milos-ufs-fix-v1-0-b0923dabc35f@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782393284; l=2504;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=XhMA7SAkLLIGkBp7iUeGqvloWqhkSkwfATkuGGePG64=;
 b=SntroxwhmBc4S11FTqoyIC2noSOKMHCIRpt5jvIc1Bck1MCHBkJV18B9rv9zDArtu8wvdGjiz
 euB/L8esy6lAvFPkTngxHTI8aYdQ1S984Q8ZI4po/8Axzf78HYKMNfv
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:25 +0200
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

With a recent change to the UFS driver, now all clocks need to be
available. Add all the clocks from the TCSRCC block on Milos.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-milos.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
index 571cd134f1c..54103adc114 100644
--- a/drivers/clk/qcom/clock-milos.c
+++ b/drivers/clk/qcom/clock-milos.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <dt-bindings/clock/qcom,milos-gcc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sm8650-tcsr.h>
 
 #include "clock-qcom.h"
 
@@ -201,3 +202,68 @@ U_BOOT_DRIVER(milos_rpmh_clk) = {
 	.ops		= &milos_rpmh_clk_ops,
 	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
+
+/* TCSRCC */
+
+static const struct gate_clk milos_tcsr_clks[] = {
+	GATE_CLK(TCSR_PCIE_0_CLKREF_EN,		0x31100, BIT(0)),
+	GATE_CLK(TCSR_PCIE_1_CLKREF_EN,		0x31114, BIT(0)),
+	GATE_CLK(TCSR_UFS_CLKREF_EN,		0x31118, BIT(0)),
+	GATE_CLK(TCSR_UFS_PAD_CLKREF_EN,	0x31104, BIT(0)),
+};
+
+static struct msm_clk_data milos_tcsrcc_data = {
+	.clks = milos_tcsr_clks,
+	.num_clks = ARRAY_SIZE(milos_tcsr_clks),
+};
+
+static int tcsrcc_milos_clk_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	qcom_gate_clk_en(priv, clk->id);
+
+	return 0;
+}
+
+static ulong tcsrcc_milos_clk_get_rate(struct clk *clk)
+{
+	return TCXO_RATE;
+}
+
+static int tcsrcc_milos_clk_probe(struct udevice *dev)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
+	struct msm_clk_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->data = data;
+
+	return 0;
+}
+
+static struct clk_ops tcsrcc_milos_clk_ops = {
+	.enable = tcsrcc_milos_clk_enable,
+	.get_rate = tcsrcc_milos_clk_get_rate,
+};
+
+static const struct udevice_id tcsrcc_milos_of_match[] = {
+	{
+		.compatible = "qcom,milos-tcsr",
+		.data = (ulong)&milos_tcsrcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(tcsrcc_milos) = {
+	.name		= "tcsrcc_milos",
+	.id		= UCLASS_CLK,
+	.of_match	= tcsrcc_milos_of_match,
+	.ops		= &tcsrcc_milos_clk_ops,
+	.priv_auto	= sizeof(struct msm_clk_priv),
+	.probe		= tcsrcc_milos_clk_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.54.0

