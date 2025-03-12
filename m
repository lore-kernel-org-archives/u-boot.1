Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB96C282EC
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C59781761;
	Wed, 12 Mar 2025 01:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GbTIdjdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97CC480756; Wed, 12 Mar 2025 01:31:56 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F0781877
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-47698757053so22317011cf.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739513; x=1742344313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6+QDupgP/yemmLjKZHOptsfxfK7jeKfj2qsxDsq1Ig=;
 b=GbTIdjdrYVamzYQQ9h8RHOYY6fWKTb5TeAV8vAeW3WmFL816hLy9RsaLKS7hrTJ1+E
 w6gHSpuOnEZl35yYJDo6E2SfPDPZ+c+xPQ9V9z8MjvO4DPlTBjBk7K/lk0WWXRDSIPi7
 gvG866piPIjYXY1+oJMVC7G1Jypzxg3xryXfR+Hn0dju3NFrByjTR9aFTdWvungNldhe
 275+vSCE8bm2SgkETsMJ3ztPklnkpk+nG4t4hr5KmfuUDBf6bqYC6OXqTDjTrb5nR5ct
 1Q+A7AQ43zV9dAeCkxBxjozK0kpWqQBM1LDBFpIzGRNlqbAL5Gp+us2u2LOcbt3sS5KV
 j7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739513; x=1742344313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6+QDupgP/yemmLjKZHOptsfxfK7jeKfj2qsxDsq1Ig=;
 b=fbsDdCoUVA/KQ41kBwfQKuCFXy8jAGar9gPQAX43l/8pdyXD52G+fuXjSsQMcO1Woq
 h0THoicjK6fkZ45o3+giPbwp37M6Wf/wuFLUGo4hoUR3BZYUMIm6bXEsEHSyABhvPsqB
 9QiyMzubwQmz5wCjMkdlxnkhG0IjXAYuwLsjuUG5734nQeSeylYXRE6daqzwLpGufwpP
 GPJTKRJqUmFfKunTVdBsXk297RGeaVZnEmVOoDOgIMlnrQqMlkdYaRyZVfY/B0aiETp8
 mSZNj0oIX59QTnP2QszIJS+P5g0pBOOCHfFYVzOXQYW8u+bqcbZovGIEJRbK+1LwUIR8
 +yFw==
X-Gm-Message-State: AOJu0YzcYZztpQTKEdr+9kNR6SOlyWd1/auaqwjEtWhYymWLk7wDQsPO
 wh/j1XvlGES8jDb1Y+393fGU174r1YUXfup2J1REJ4LL323UpDl+qx5AOQ==
X-Gm-Gg: ASbGncvgeQSDY00pRjip68ZfrL0imhoN6D1i5YOXxhhMNG2f9QhulP5PCcoJeL0/mXT
 XKd3ZfXb+amXeZCVROTogOtOy5hlHL+iLk/Cvn8DOvQTTDE5CKJTxGFlndVfK4eLv/CzhjmxyJ0
 H6t+Ncp48A9/W6frBBd/qmNOzQ8AgQr6MgDvNRYzS/OEGQW0jie9tAfC2b5lDXHk3jwhAk6O174
 ULFYpYT/fdwMCPT/JCUmZxLnUXfRCKYJDMD76/ZhmAlljtDgeBaDfm4nIm83k1aJENn43kP5MLt
 1YvBKF6m0KuqRRm+xPu2yb6MdA2kAny+WUktP0TBfJoMQbDJvq62JBn0nd9yjHdZqgN9Iw8XWy/
 /lt+kwen5wNRffbQdgDo=
X-Google-Smtp-Source: AGHT+IG3K2v5tmLyc/q0/i4wn9ET1v8vKH9xkPKpgtxhBJpziNzoFgUeo4KGiFAsX7527iPeZ8xySA==
X-Received: by 2002:a0c:c689:0:b0:6ea:d190:f1ad with SMTP id
 6a1803df08f44-6ead190fbbfmr4235156d6.11.1741739512679; 
 Tue, 11 Mar 2025 17:31:52 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:31:52 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V2 04/10] clk: imx8mn: register UART clocks
Date: Tue, 11 Mar 2025 19:30:24 -0500
Message-ID: <20250312003041.110023-5-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
References: <20250312003041.110023-1-aford173@gmail.com>
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

