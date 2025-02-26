Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09900C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B3F80805;
	Wed, 26 Feb 2025 12:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZgITYFlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2397280805; Wed, 26 Feb 2025 12:44:06 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0166D80805
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abb81285d33so167760566b.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570243; x=1741175043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdkPJ6qBAKsND2sFuGCMeH0/ObZSgwnNcp0TiSCR7A8=;
 b=ZgITYFlUcx6O+g2Qs4HggzKykgY7kPhOimj8aQ5c3dS1K2U0+xX3PAcCxiK2P4VX53
 yIIEUHpjLmd23xSCkLuiom8DaCzXYbbBLF36/vO7zM0tnnM4Ep9DDA2Mpz12c8Hm5EQE
 orEMWIRHB+r+Cy+7XSZJiAeqKNOpXLgPJPe7HbSf4nPDZUC+Z7Pan7ZiVsTpviKOhuWf
 DIxbqEoB30Bxg0Okd21MIRiBhD9Dn4PIdZVtxvFyTAJ0ZN8SRS5S+oKI8D3oMDJTwohH
 fmif3wqwQwW2OQ+zeRpBFIooQmJYi5BoqRHynHYxq/mSbTNCLcLALdNUKQSi1ofiRYQI
 FOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570243; x=1741175043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdkPJ6qBAKsND2sFuGCMeH0/ObZSgwnNcp0TiSCR7A8=;
 b=IIOxl2ascWZkIoB4EI5bWamevpL1Mqgg5MOpt3eTYz1PSxoaZDtRNKBLnYKFRtNomD
 Kan+XHpsKf9Odlu91j9lV4IQwbV1aSdJcWNJP3PG7q+lqzNMRWadnY97aVjOUC3p7q2t
 GouRnMTwlNbpNFSwSLw5xsv6S0XO/3SRBhMCBPjTfk+AwlPtB4ns8/MH9BN+ul4bAeNn
 PlKMxhhTbLNj9Bcd4WSPlZPoxTGfhz/7GNxcg3pPoJwmRosANCdDH5N9TcbdKGxatoLT
 yt9prsnxLP2qh59Dm+flaxBlbCeZG30IL6ipEiioCRxMbZDxwEwakiZz7/hJi6c3uFHD
 wu7Q==
X-Gm-Message-State: AOJu0YzpTIfZGAecIDz3f0WeBlNEKj649XBMOpmyIBsyHLJGbKk3cL4o
 /6L9mTeacirzFwsm0j+e0hGBUpRVl7UAktInFSNaB5AhUAI7JWNB
X-Gm-Gg: ASbGncvq4oPy3NvZY38++YtK1sPJ8H5ZYYbnZtvyOUYTJJlyXLM4WdR1u5dnE6MW6C8
 AnqseTJpA5KXB9I/iORVFg90a/Yd750o47mFR0r4KzkRF8ZjbankBMKkUOdhzDytXULdOCYBKV0
 VRtU1L9cELBgaaWM8J34KF2H2Tkc4f4zQ2DKqegwc7do0Bq715UK2vuvihN4hfDiFmVVjJMoDrn
 cXNyfX43mzUDHMLN9JMGzEH7EelWcXZtHSn3B4mv8Z5uEi+vQPNfa2uDSn2hbDxbBy8O9L7H8VJ
 5gaIEsb5exKphyHAiQ==
X-Google-Smtp-Source: AGHT+IFTZlaCSawIsS8BBCnzMXkwNwz+u6AwfaMnf7+EdB2l+imGUDiLgxllslydhBouZZkzxyypbQ==
X-Received: by 2002:a17:906:b818:b0:abc:29e3:f453 with SMTP id
 a640c23a62f3a-abc29e3f7cdmr1691427066b.33.1740570243063; 
 Wed, 26 Feb 2025 03:44:03 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20b5cc5sm309513066b.168.2025.02.26.03.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:44:02 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/7] pinctrl: tegra: add Tegra K1 support
Date: Wed, 26 Feb 2025 13:43:34 +0200
Message-ID: <20250226114340.42191-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226114340.42191-1-clamor95@gmail.com>
References: <20250226114340.42191-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Tegra 124 is fully compatible with existing Tegra pincontrol
driver, but it needs a specific MIPI PAD control pinconfig.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra124/pinmux.h |  4 ++
 drivers/pinctrl/tegra/pinctrl-tegra.c       | 56 +++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/include/asm/arch-tegra124/pinmux.h b/arch/arm/include/asm/arch-tegra124/pinmux.h
index 3aba17d21e4..fbe15fc612d 100644
--- a/arch/arm/include/asm/arch-tegra124/pinmux.h
+++ b/arch/arm/include/asm/arch-tegra124/pinmux.h
@@ -578,6 +578,10 @@ static const char * const tegra_pinctrl_to_drvgrp[] = {
 	[PMUX_DRVGRP_AO4] = "ao4",
 };
 
+static const char * const tegra_pinctrl_to_mipipadgrp[] = {
+	[PMUX_MIPIPADCTRLGRP_DSI_B] = "mipi_pad_ctrl_dsi_b",
+};
+
 static const char * const tegra_pinctrl_to_func[] = {
 	[PMUX_FUNC_DEFAULT] = "default",
 	[PMUX_FUNC_BLINK] = "blink",
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index ad7112a05e6..e6b957f5537 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -67,6 +67,58 @@ exit:
 	kfree(drive_group);
 }
 
+#ifdef TEGRA_PMX_SOC_HAS_MIPI_PAD_CTRL_GRPS
+static void tegra_pinctrl_set_mipipad(struct udevice *config, int padcnt)
+{
+	struct pmux_mipipadctrlgrp_config *mipipad_group;
+	int i, ret, pad_id;
+	const char *function;
+	const char **pads;
+
+	mipipad_group = kmalloc_array(padcnt, sizeof(*mipipad_group), GFP_KERNEL);
+	if (!mipipad_group) {
+		log_debug("%s: cannot allocate mipi pad group array\n", __func__);
+		return;
+	}
+
+	/* decode function id and fill the first copy of pmux_mipipadctrlgrp_config */
+	function = dev_read_string(config, "nvidia,function");
+	if (function)
+		for (i = 0; i < PMUX_FUNC_COUNT; i++)
+			if (tegra_pinctrl_to_func[i])
+				if (!strcmp(function, tegra_pinctrl_to_func[i]))
+					break;
+
+	mipipad_group[0].func = i;
+
+	for (i = 1; i < padcnt; i++)
+		memcpy(&mipipad_group[i], &mipipad_group[0], sizeof(mipipad_group[0]));
+
+	ret = dev_read_string_list(config, "nvidia,pins", &pads);
+	if (ret < 0) {
+		log_debug("%s: could not parse property nvidia,pins\n", __func__);
+		goto exit;
+	}
+
+	for (i = 0; i < padcnt; i++) {
+		for (pad_id = 0; pad_id < PMUX_MIPIPADCTRLGRP_COUNT; pad_id++)
+			if (tegra_pinctrl_to_mipipadgrp[pad_id])
+				if (!strcmp(pads[i], tegra_pinctrl_to_mipipadgrp[pad_id])) {
+					mipipad_group[i].grp = pad_id;
+					break;
+				}
+	}
+
+	pinmux_config_mipipadctrlgrp_table(mipipad_group, padcnt);
+
+	free(pads);
+exit:
+	kfree(mipipad_group);
+}
+#else
+static void tegra_pinctrl_set_mipipad(struct udevice *config, int padcnt) { }
+#endif
+
 static void tegra_pinctrl_set_pin(struct udevice *config, int pincnt)
 {
 	struct pmux_pingrp_config *pinmux_group;
@@ -170,6 +222,9 @@ static int tegra_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 		if (!strncmp(name, "drive_", 6))
 			/* Drive node is detected */
 			tegra_pinctrl_set_drive(child, ret);
+		else if (!strncmp(name, "mipi_pad_ctrl_", 14))
+			/* Handle T124 specific pinconfig */
+			tegra_pinctrl_set_mipipad(child, ret);
 		else
 			/* Pin node is detected */
 			tegra_pinctrl_set_pin(child, ret);
@@ -236,6 +291,7 @@ static int tegra_pinctrl_bind(struct udevice *dev)
 static const struct udevice_id tegra_pinctrl_ids[] = {
 	{ .compatible = "nvidia,tegra30-pinmux" },
 	{ .compatible = "nvidia,tegra114-pinmux" },
+	{ .compatible = "nvidia,tegra124-pinmux" },
 	{ },
 };
 
-- 
2.43.0

