Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1F9C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC29981101;
	Sun,  2 Mar 2025 17:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eycg2Wzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A2ED807B1; Sun,  2 Mar 2025 17:53:49 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FCB080017
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-855fc51bdfcso150063939f.0
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934390; x=1741539190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6+QDupgP/yemmLjKZHOptsfxfK7jeKfj2qsxDsq1Ig=;
 b=Eycg2WzvKMT7n6aHtebIQ5DndG3/udmUGz81cqwKgP7SGF4CGTJOe/TaB0Zd68CuQT
 DoHyby0cnalpy++/2/QRRwgvMyHRaiWZ3EQ4X3V+vBalS+SwzKvhZVAbnpT8ITKpRwP3
 LW74vBKntNWFwQxzazw4saTCmcWBqjOuoI6Ac16YUycL7qHX8A705UCtbZ5iDMoCojj7
 8SoX0neyQu9Jd8BfjHzoacBc9H3hxLqdOtQ0MUSrg0sMtlcpiM2bepPFZQ8atjGtrZnM
 isQ62Uu+ZWj4g/rQ/F7wc8wsGDiSyB45j2x7GMZtTH22u8uasrG5CjIXqMxpub0Paxj2
 ndww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934390; x=1741539190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6+QDupgP/yemmLjKZHOptsfxfK7jeKfj2qsxDsq1Ig=;
 b=eQQF5IHIKrJEixOnsXLwp29+4m9nkFFRozi2WvYWHDXoY5QAX8oF9fcCofufX0nr/N
 31G4xkkSlkgPyUscddr1CNRYSBpmkH49KzJew4BlxZfMZug2DE/AV+0W/mJbCc7ogKrd
 HhmNRG3pSAbrJOxVAToZ8HDIv7RelzQIPo1UTqbQ7gL/DFcEz6OYZazAs1KscN4N9+Vb
 Hbx4Egr+aS59I7V4Eg4DoS2wt8weys1s07BJpiOvy5EwMe7RHzDSEAdX8WRgUNlwa6Dc
 12UY0jYncazoX+e5y2dJbq2hZyw83fhiDB9i/5f7FAa4vWM161QcVe+fgYGAsDzhIw2w
 IZxg==
X-Gm-Message-State: AOJu0YzOb6Ze5I9T+ovOV/rxEO1gaPmQUPL2aJFMvLpUnGTDcEiAka5r
 yPH67JA1ym9NvtZzTSCQBcJWiXAQVzTVJWMga841F93zZHS7vo6hldRdUA==
X-Gm-Gg: ASbGncsGw1FeSYyPTs8ZPR30E2wfO8b5NV1ddH5i3KMjpjBcpF0JxWNHmL4/0Vfbq+S
 tMmdq+SEQhWNvqUcofmWgQyoEmoV0kOzefOJVXHuaduQaKNeFtvwlWWlujbzZg/WxPsgJJt4aSD
 xwdwsU1p4aHImji3YYZznrZ5zVU/mXb80lJwHu8uuMeIBvGW43huTo9GPEkMztR48P/N/nOvzyr
 Cvb6WUWdxXO1atbSIqp2pWvdts+5XGAoi/WxnEGD0C1S4aKHdXt8UQvTdPWjDkjSd1j1qwCXPFw
 MQdf5aOrR1NhLKqs8R9ZRoUe742gImx6ICDeTCNyflLB+xpo9TxWLEVpNB4RlDGTH12Z4OHt8dD
 Zu2K5YCuHKBVZ8ym97ck=
X-Google-Smtp-Source: AGHT+IGRoykd1qcH4UjPvLiCI5j73hCtFoSOjq9soARGDRU+P0KTbqBOszbPaiSvm2TPagADxpq/eg==
X-Received: by 2002:a05:6e02:2689:b0:3d3:d156:1dcd with SMTP id
 e9e14a558f8ab-3d3dd230b45mr167445985ab.1.1740934389506; 
 Sun, 02 Mar 2025 08:53:09 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:08 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 04/10] clk: imx8mn: register UART clocks
Date: Sun,  2 Mar 2025 10:52:31 -0600
Message-ID: <20250302165249.267992-5-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250302165249.267992-1-aford173@gmail.com>
References: <20250302165249.267992-1-aford173@gmail.com>
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

In order to let the serial driver enable the clocks, the UART clocks
must be registered first.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/imx/clk-imx8mn.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index be15ebd0e25..54ae887817a 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -97,6 +97,22 @@ static const char * const imx8mn_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m"
 						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
+static const char * const imx8mn_uart1_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
+						 "clk_ext4", "audio_pll2_out", };
+
+static const char * const imx8mn_uart2_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
+						 "clk_ext3", "audio_pll2_out", };
+
+static const char * const imx8mn_uart3_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
+						 "clk_ext4", "audio_pll2_out", };
+
+static const char * const imx8mn_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
+						 "clk_ext3", "audio_pll2_out", };
+
 #ifndef CONFIG_XPL_BUILD
 static const char * const imx8mn_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
@@ -311,6 +327,14 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite("i2c3", imx8mn_i2c3_sels, base + 0xae00));
 	clk_dm(IMX8MN_CLK_I2C4,
 	       imx8m_clk_composite("i2c4", imx8mn_i2c4_sels, base + 0xae80));
+	clk_dm(IMX8MN_CLK_UART1,
+	       imx8m_clk_composite("uart1", imx8mn_uart1_sels, base + 0xaf00));
+	clk_dm(IMX8MN_CLK_UART2,
+	       imx8m_clk_composite("uart2", imx8mn_uart2_sels, base + 0xaf80));
+	clk_dm(IMX8MN_CLK_UART3,
+	       imx8m_clk_composite("uart3", imx8mn_uart3_sels, base + 0xb000));
+	clk_dm(IMX8MN_CLK_UART4,
+	       imx8m_clk_composite("uart4", imx8mn_uart4_sels, base + 0xb080));
 	clk_dm(IMX8MN_CLK_WDOG,
 	       imx8m_clk_composite("wdog", imx8mn_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MN_CLK_USDHC3,
@@ -355,6 +379,14 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	       imx_clk_gate2_shared2("nand_usdhc_rawnand_clk",
 				     "nand_usdhc_bus", base + 0x4300, 0,
 				     &share_count_nand));
+	clk_dm(IMX8MN_CLK_UART1_ROOT,
+	       imx_clk_gate4("uart1_root_clk", "uart1", base + 0x4490, 0));
+	clk_dm(IMX8MN_CLK_UART2_ROOT,
+	       imx_clk_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0));
+	clk_dm(IMX8MN_CLK_UART3_ROOT,
+	       imx_clk_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0));
+	clk_dm(IMX8MN_CLK_UART4_ROOT,
+	       imx_clk_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0));
 	clk_dm(IMX8MN_CLK_USB1_CTRL_ROOT,
 		imx_clk_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0));
 
-- 
2.45.2

