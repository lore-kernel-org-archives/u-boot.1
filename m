Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B19AC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55BA2880D2;
	Thu, 21 Mar 2024 15:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y8bNuzhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A327880D2; Thu, 21 Mar 2024 15:55:33 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2102880AD
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dfff641d10so6829945ad.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711032927; x=1711637727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ad3uCstV6107Ex9Z//2I9L6055a6XtiiyrmcQSBfESM=;
 b=y8bNuzhX0xA5blDyoCtpRBa/oSanhSGRUG3qw31tmTDLV6bGJiGyt4DXDwzBWpvlFE
 mgZ2wZT0pHtE3/FDWBhQ5GT0RVrZgmHExX8yyGTqmCkv/x8gt3t4q8UsPxx3aRsjxUb6
 zjvjuLwnCTVXqRYfMvCQkXuqipf2jgFXcpBcnkVFXDHjTDNLaolRYLredIq24OdOqcfO
 RdC7VUOXrCKNkD/1wq8OPFW752l7TVoIuNEh8I/mV/19icYuf/WWSzOhXbrqJ0mLAySN
 gmOWVrKwRg4H1JWHcEB1IMv/dV057jF86/O8my1G3xwKoRtFdL3P8owB/++nD0jxB0PH
 1R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032927; x=1711637727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ad3uCstV6107Ex9Z//2I9L6055a6XtiiyrmcQSBfESM=;
 b=wLyy9lwtus7ZAGCAILUOQ2vkApP9JTUIXOI945P3MYm+7QB5+GH1uLNKzhSheL7LD6
 QGzbejyv14wjjZ6HbHA19rQLwnTr9DzXtoHGwM8/e6MdkePvHAHnLImbQ8+WY3N6PkOC
 IP+99RkWGFRosPLuvABTnxrtAQr5RfiHAvmtebYZF2rOrMRZnJ9QKJi9PqmKHsUw7Ee3
 Ftr38aCXEmPyXz2cSIPWEUbSMbqdsVfYC5L9lBpNgSLejZvE+9tz31xm3k3UjgLUedFC
 hg1QQjnxkE8FH3xjCanzAh492poY6T6SwsJp7aLtqFAWhUBT52DCgLDf1Tu30I4Nbz4Q
 UW9w==
X-Gm-Message-State: AOJu0YzX/Q6Gcq9KLXtIzrpCedzPs3wUCyMTJdNlmEzcWLsusNFMDZBm
 vJMUIftPYEKs9i1SZ49U9Aqy9k6FPDFtUhdyTw/p9ae8txOQtXOpx3BIRdknF8EdrfQbuywPYB1
 N
X-Google-Smtp-Source: AGHT+IFHx0aW7FBnDf+hF6FjnDMXZFnwMMsmIXYhX35HOyzS5SqmIWTHeITPeGTW7R+MawK262Kjmw==
X-Received: by 2002:a17:902:eb92:b0:1df:f73e:f8a3 with SMTP id
 q18-20020a170902eb9200b001dff73ef8a3mr16836498plg.30.1711032926835; 
 Thu, 21 Mar 2024 07:55:26 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:55:26 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 01/11] clk: imx8mp: Add support for PCIe clocks
Date: Thu, 21 Mar 2024 20:24:57 +0530
Message-Id: <20240321145507.619448-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321145507.619448-1-sumit.garg@linaro.org>
References: <20240321145507.619448-1-sumit.garg@linaro.org>
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

Add support for PCIe clocks required to enable PCIe support on
iMX8MP SoC.

Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/clk/imx/clk-imx8mp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index a21a3ce34bb..7dfc829df2c 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -62,6 +62,10 @@ static const char *imx8mp_dram_apb_sels[] = {"clock-osc-24m", "sys_pll2_200m", "
 					     "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 					     "sys_pll2_250m", "audio_pll2_out", };
 
+static const char * const imx8mp_pcie_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m",
+						    "sys_pll3_out", "sys_pll2_100m", "sys_pll1_80m",
+						    "sys_pll1_160m", "sys_pll1_200m", };
+
 static const char *imx8mp_i2c5_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
 					 "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 					 "audio_pll2_out", "sys_pll1_133m", };
@@ -272,6 +276,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_DRAM_ALT, imx8m_clk_composite("dram_alt", imx8mp_dram_alt_sels, base + 0xa000));
 	clk_dm(IMX8MP_CLK_DRAM_APB, imx8m_clk_composite_critical("dram_apb", imx8mp_dram_apb_sels, base + 0xa080));
+	clk_dm(IMX8MP_CLK_PCIE_AUX, imx8m_clk_composite("pcie_aux", imx8mp_pcie_aux_sels, base + 0xa400));
 	clk_dm(IMX8MP_CLK_I2C5, imx8m_clk_composite("i2c5", imx8mp_i2c5_sels, base + 0xa480));
 	clk_dm(IMX8MP_CLK_I2C6, imx8m_clk_composite("i2c6", imx8mp_i2c6_sels, base + 0xa500));
 	clk_dm(IMX8MP_CLK_ENET_QOS, imx8m_clk_composite("enet_qos", imx8mp_enet_qos_sels, base + 0xa880));
@@ -322,6 +327,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_I2C2_ROOT, imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0));
 	clk_dm(IMX8MP_CLK_I2C3_ROOT, imx_clk_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0));
 	clk_dm(IMX8MP_CLK_I2C4_ROOT, imx_clk_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0));
+	clk_dm(IMX8MP_CLK_PCIE_ROOT, imx_clk_gate4("pcie_root_clk", "pcie_aux", base + 0x4250, 0));
 	clk_dm(IMX8MP_CLK_PWM1_ROOT, imx_clk_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0));
 	clk_dm(IMX8MP_CLK_PWM2_ROOT, imx_clk_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0));
 	clk_dm(IMX8MP_CLK_PWM3_ROOT, imx_clk_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0));
-- 
2.34.1

