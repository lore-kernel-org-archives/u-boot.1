Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC81C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 13:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B47A887DC9;
	Tue, 20 Feb 2024 14:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zBZXPaBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E8C87D91; Tue, 20 Feb 2024 14:42:32 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCF487D5D
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-68f87e24be8so10411386d6.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708436546; x=1709041346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2fliZdbKRAS/8qB6Q+Mr+XBR/1QnLa1MnnWR1xjOsU=;
 b=zBZXPaBxOFF7fS89yOgwujaBEOx8/soQr3JBaLF7WO9DarTCtls6UD1ESCqsXljlGj
 3vjxHyKSXQqHfPskOY4bi6MJ7n1ynDllGNvgNdRAKBD466dDNaVXbmp/PKpKXKZIyTA1
 4pE28BzqzMlE3G38bD6V17TQoxz24I4RCfoYTInf+UwlIL/f8rusnBdx1aVp9FlBzAAT
 JcDS/73QNXWakGcbDlPi8/YYRC3GTft0mw7bF2FL+6j/1lbmxgHaHfNK7FycDDwBh7yk
 4NRluebYINyjCMhkc6DvFfm8KYPDYRvQsi/zDBJbFgvP3SEfo7Ce030kNOtow+Zo85j8
 e61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708436546; x=1709041346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2fliZdbKRAS/8qB6Q+Mr+XBR/1QnLa1MnnWR1xjOsU=;
 b=tM6xSxIfTt3dAyMMPWw8hIujfLtZnvr3ewm89Rw1TfPbFxwIgquv+6GGPdUoONCU1J
 SiU+wyRaN7FZ9maHkgSsSvI953CZ8vyu57zleMTBTAhcWlkEvN5CIZ5m/42inTcNJdrl
 Z88yq0yPF76ruR065NGkAnphJxzNa/UTLkKct9xjbKFMIoyngNEOhnnfJ+Io0T0hKx6p
 5Q0beoKaKR/oqz8HX7fSFZeO24YbA9vYrJkIAhUzZN+BI7LJmOACJ1A3yhy6qRL8OwZF
 zz50W3hNZ7cprZ+ykbk1IquXJqadjyUk/XTz4Bhi92/ZAxa+m8SRfSp1An3oq+e7FmIV
 rAPQ==
X-Gm-Message-State: AOJu0YwrwPAv1flDIv8X7kcPqg8hjXwvggEGRiGe+2eLTSJfXFJGgC88
 RuxWb4SFFIoIipU9o6myCXdg6oGfih7E+m5AzIAjsYWRNvIQKOWblAAgrXVvRuoxySIeT02Njw7
 i
X-Google-Smtp-Source: AGHT+IFO7rf/uyKaEKKW2midebZIs0WeBrCbjRTrQA+h3RtsNRoZeimkWk3HhQ5epOAahxr0ufl6Mg==
X-Received: by 2002:a05:6a21:1519:b0:1a0:828a:50d8 with SMTP id
 nq25-20020a056a21151900b001a0828a50d8mr13499651pzb.22.1708434677503; 
 Tue, 20 Feb 2024 05:11:17 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.148]) by smtp.gmail.com with ESMTPSA id
 y12-20020aa79e0c000000b006e3e72a4f87sm5195902pfq.0.2024.02.20.05.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 05:11:17 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 1/7] clk: imx8mp: Add support for PCIe clocks
Date: Tue, 20 Feb 2024 18:40:50 +0530
Message-Id: <20240220131056.2962331-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220131056.2962331-1-sumit.garg@linaro.org>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
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

Pre-requisite to enable PCIe support on iMX8MP SoC.

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

