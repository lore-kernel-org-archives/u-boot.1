Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFADAC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5340834DC;
	Sat, 24 May 2025 01:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qg7ZYcWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60EAE8333D; Sat, 24 May 2025 00:59:02 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9448334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-742b614581dso408162b3a.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041138; x=1748645938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kb6GlpZJZuxA9udpTCFGBvZWgtu+2OuHrZymA265ByU=;
 b=Qg7ZYcWSuRyF/MsiMx0fNXuLSkSC2/IP9lUE2bA+Q17vKv1QhmDxYnvPDKxM+q1WDv
 xXB2CGyAoTfPEEM9bPTqNeJ7jgUBCFtipI0zTJ4dbkfsdzuQOb1HWiQoni+DZ7UKuCgL
 mVj3BfgEyAL27h2B/zU+0VLf1RY8MdjF1MqyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041138; x=1748645938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kb6GlpZJZuxA9udpTCFGBvZWgtu+2OuHrZymA265ByU=;
 b=AJM2c+xRs4DrWEDVh7QWf8J4pbXU0w0dgHxiRImx0TqncMNmrvxo4NyKyGklZVPPF7
 QnpLozuOFFeDU7MBEGHb44w5ruNjarEHbmD6/8WIk82KhxSKt+JJbREzExS6/2jT8ihv
 BJMdc1vgEk/Pw6kz8suvErft/j6uDKndwNx73l7iVptMt4R8tM61iH1doXlcSwFM0Ofe
 Cxu26377Bmqmu2fOaJiJlGVVU9IHc+1MzE4gWIVQ2XxEgoGlPvVHDwccuHlbEX/pfY/b
 sKfCwROkJbionp2Z1tFYKo7sR2cDFoP5ss+/6KFG6tUmXavUF/FnGbbWNTVFAjEFsxXi
 5XOw==
X-Gm-Message-State: AOJu0YwvP9QzuTRdKk7pVW3uxl9vwFFQauKHe5QChwSJQGn8QHSQd5Pj
 Y1khGsEluV4qY6HdDsTZfrLSrD80dnc/eh19kIC4U619hyVSB2b9pq9dRrHxP4ED3A3tH0O3JQR
 aNDI=
X-Gm-Gg: ASbGncvK5euTgiWhh2/Y60DWwKaNK7hs8TBMxjHheNxTaOR4G01/nFH5/xM5x+5xbKr
 A4NJCoM1TAIB3UKpgSYiGnADe6atCTjF16eK+s7QGViSOHTV8vxPMe3WK/hX6SzZ2YUpC8ql4iW
 qFjC9YfAtKmzz8IpLuQWYa3IyrdEeUBRHnfMVb5nWx1Zjrou7aQSZeoSvVPZp42tLUQh2qLGm0u
 uC3vq2I+vt6ZVbHIn8lxN+JICc5cg/PM7WfUE5aMGK04ziEWWoBM9Cq30zRiLmDhUP/kf7JDl2h
 p5cZxcIwVfQdi9SugaoPt80OtmVbwBhqJMzeZeXqLtHJB+k3DZ4Wna+8Dt0GiuX8K3GTqdToEBb
 L5ZYmqxxllVXGGag=
X-Google-Smtp-Source: AGHT+IFL45dBI1QflUf3Ynoolv9MIJl0NMlPaId/S4Lo2vBKMQPtm7yX1d8mBXtp7xiRVJguLPPIAQ==
X-Received: by 2002:a05:6a00:21c6:b0:736:5664:53f3 with SMTP id
 d2e1a72fcca58-745fe06456bmr1640618b3a.15.1748041138536; 
 Fri, 23 May 2025 15:58:58 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a987af30sm13162883b3a.156.2025.05.23.15.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:58:58 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 07/28] serial: msm-geni: Enable SE clk in probe
Date: Fri, 23 May 2025 15:58:22 -0700
Message-ID: <20250523225845.2311989-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Enable the serial engine clk in probe so that this driver can work on
platforms that don't already initialize the clk for this device before
this driver runs. This fixes a problem I see on Coreboot platforms like
Trogdor where the UART hardware isn't enabled by coreboot unless the
serial console build is used.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/serial/serial_msm_geni.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index cb6c09fdd09e..620cb9a59343 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -131,6 +131,7 @@ struct msm_serial_data {
 	phys_addr_t base;
 	u32 baud;
 	u32 oversampling;
+	struct clk *se;
 };
 
 unsigned long root_freq[] = {7372800,  14745600, 19200000, 29491200,
@@ -181,19 +182,6 @@ static int get_clk_div_rate(u32 baud, u64 sampling_rate, u32 *clk_div)
 	return ser_clk;
 }
 
-static int geni_serial_set_clock_rate(struct udevice *dev, u64 rate)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	ret = clk_set_rate(clk, rate);
-	return ret;
-}
-
 /**
  * geni_se_get_tx_fifo_depth() - Get the TX fifo depth of the serial engine
  * @base:	Pointer to the concerned serial engine.
@@ -252,7 +240,7 @@ static int msm_serial_setbrg(struct udevice *dev, int baud)
 	priv->baud = baud;
 
 	clk_rate = get_clk_div_rate(baud, priv->oversampling, &clk_div);
-	ret = geni_serial_set_clock_rate(dev, clk_rate);
+	ret = clk_set_rate(priv->se, clk_rate);
 	if (ret < 0) {
 		pr_err("%s: Couldn't set clock rate: %d\n", __func__, ret);
 		return ret;
@@ -561,6 +549,16 @@ static int msm_serial_probe(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 	int ret;
+	struct clk *clk;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	priv->se = clk;
+
+	ret = clk_enable(clk);
+	if (ret)
+		return ret;
 
 	ret = geni_set_oversampling(dev);
 	if (ret < 0)
-- 
Sent by a computer, using git, on the internet

