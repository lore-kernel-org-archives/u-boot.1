Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB867C3814E
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 08:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00E78848D;
	Sun,  7 Jul 2024 10:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pKPrcSjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CEEC8848D; Sun,  7 Jul 2024 10:20:11 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B31588327
 for <u-boot@lists.denx.de>; Sun,  7 Jul 2024 10:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a77c2d89af8so295503966b.2
 for <u-boot@lists.denx.de>; Sun, 07 Jul 2024 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720340407; x=1720945207;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yh4v3D3pWHHqrsVDjmkbDuP1IwQL+jZVx5ue+4JboHQ=;
 b=pKPrcSjZpJylWyKQCRE2QOofv4TUcy7xM6zBNmf6w19K6LmYSqJBBe11KxIhL/SyYr
 V46JuTOLt79SdGkcWayBfsNaFyqQ2fPrcl4lU7gMMcZsEQUF527xjz+zRIZG94mBbY8B
 mLUH1ZDXc1/QJFr3IdwpLIXfPWkeWz5EEsC0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720340407; x=1720945207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yh4v3D3pWHHqrsVDjmkbDuP1IwQL+jZVx5ue+4JboHQ=;
 b=u+FpVZ6vQ82UkJYZ8LCoNwiOIOpCor+kjZGDm8Qa2kCFzP0MJc1waSHqq2rU217WZB
 tolCFQ7xXgRMFkPXN0n+0gY+BNmqERNjfHX1zmRqGKoQp/mCoWCAE1BB81npw/4F5KrZ
 h+dU8ej+YjruzxhWMgkFrMRmoQvju34EKmURMYOhm0Ml23DqhaKSV5C4H5sKHiNk80fx
 v2EjtSzoyVHzkcrrsu6gwOoswIFcAhaJ5pv97SZyRaD0dAPz9Fo68VG6ssadMHKsDX1y
 UtZRK5IkqBEX7XIKaWuON7r6mcybGk6YWtPnt4cQs1BUg/RkxQGSRCph4PE3zbwfIIoS
 cLnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN926hJZZognTn/OtF+/mWEhug3YPfptf6TynDj2s/Vs22ygDxemnuS37GJuna7cIIprwOMByamfuui70HY37AvNdi5w==
X-Gm-Message-State: AOJu0YzVVo7O53jk3aIHf6zr4JT0PVhgXhc42w2atJt2TPXMiL0b7TNV
 wl8oU/aEeyatjYrjMLVBfIALM7Yq8znWMX3EEfGDgbXCWUWbQTUZbzOKOW53ZWA=
X-Google-Smtp-Source: AGHT+IE7EWP0HckpDEO7pBoFYAsWFcC7dyFmwczm91GSP855avq6HImRKWNCe3fgT57ccm99chiafQ==
X-Received: by 2002:a17:906:2e94:b0:a6f:d5b:20c3 with SMTP id
 a640c23a62f3a-a77ba72957fmr602899266b.74.1720340407567; 
 Sun, 07 Jul 2024 01:20:07 -0700 (PDT)
Received: from panicking.. ([109.52.6.228]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e4a8092dsm111708666b.58.2024.07.07.01.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 01:20:07 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
Date: Sun,  7 Jul 2024 10:19:58 +0200
Message-ID: <20240707082001.20746-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240707082001.20746-1-michael@amarulasolutions.com>
References: <20240707082001.20746-1-michael@amarulasolutions.com>
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

The osc_24m is the clock-output-name and not the one that
is used as internal name reference from the strcmp. The clock
that use osc_24m, will not be able to reparent it as they should.
We need anyway register the osc_24m clock fixed factor in the clock
tree.

Fixes: 710c4ffb890 ("clk: imx: clk-imx8mn add gpmi nand clocks")
Fixes: 85b1c11989c ("clk: imx: Add ECSPI to iMX8MN")
Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/imx/clk-imx8mn.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index ed9e16d7c1..bfd1677520 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -57,15 +57,15 @@ static const char *imx8mn_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sy
 					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
 
 #if CONFIG_IS_ENABLED(DM_SPI)
-static const char *imx8mn_ecspi1_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char *imx8mn_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
 					   "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 					   "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mn_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char *imx8mn_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
 					   "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 					   "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mn_ecspi3_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char *imx8mn_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
 					   "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 					   "sys_pll2_250m", "audio_pll2_out", };
 #endif
@@ -105,7 +105,7 @@ static const char *imx8mn_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sy
 static const char *imx8mn_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m", "sys_pll2_500m",
 					   "audio_pll2_out", "sys_pll1_266m", "sys_pll3_out", "sys_pll1_100m", };
 
-static const char * const imx8mn_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out",
+static const char * const imx8mn_nand_sels[] = {"clock-osc-24m", "sys_pll2_500m", "audio_pll1_out",
 						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
 						"sys_pll2_250m", "video_pll_out", };
 
@@ -119,7 +119,9 @@ static const char * const imx8mn_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_10
 
 static int imx8mn_clk_probe(struct udevice *dev)
 {
+	struct clk osc_24m_clk;
 	void __iomem *base;
+	int ret;
 
 	base = (void *)ANATOP_BASE_ADDR;
 
@@ -238,6 +240,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_SYS_PLL2_1000M,
 	       imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1));
 
+	ret = clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
+	if (ret)
+		return ret;
+	clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
+
 	base = dev_read_addr_ptr(dev);
 	if (!base)
 		return -EINVAL;
-- 
2.43.0

