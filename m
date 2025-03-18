Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0D1C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB0981CC5;
	Wed, 19 Mar 2025 00:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QN8obvKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3344681CA8; Wed, 19 Mar 2025 00:42:49 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1528881026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4768f90bf36so51922571cf.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341365; x=1742946165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+MbEYBfxOZsYe5j21XPzkfIWLBj5sGM+nl60IZV1FY=;
 b=QN8obvKaxAsvINsshVZ2zI/zmI1WcghvwyG/IkN2HVxqzrUjo6bwqn2jIn4iMYxZWM
 6H2pjZUCW2iWRtOG+dXhs8th23I/utTBL+DH4XD9eA4TpJRFkQTgfHYthrWm1gp8dj7X
 xw27CZ7TSZpOdAdmrfS5M9IHH2jPsqFs1zfMYW3wObJ757DvDGP8i9EhyJArFHgDIuAF
 lX7FrI5EbOfdUJZNrAWr/unSFT3tvq8PcHVdB9hSERFYetM0nlh7p5UvUvDhax+YnUNf
 55lq84DivEl0hkL2fcWF5OBOHCYkmZ4FM2l/+wZDT5nw8TnpyjUSThLC7Z8OY1DMRBlQ
 ySkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341365; x=1742946165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+MbEYBfxOZsYe5j21XPzkfIWLBj5sGM+nl60IZV1FY=;
 b=KrLMHo9KNb+VMPDfdrQHL/hlaLuNsXjdkjiiuDoh4S2xzq7zvCpgYnWmXK2Ib7ELvH
 zbY3rZ57+mJdt9yggVz054cVJz5Xi1zl0p3kvlyhQu9XrEn+rYMTcGxkShjTMOv29Ocz
 Phvb6UmqpV7CGQBdKtyMsSiNReZIwnxMP3hBxsP+ZeYy5H3V7qpKcN/qTN3lSF/AXtq+
 s1xZM4y8tScRQ+HSHUHt/9Pl8d8TSedghqXqYjnUw0/O7fjZYdv94ccsW2g/r7ea0Qp6
 QYVdDXBM5fKXKi8gMFxz47QB/27znNjXID6KJfBeTZg8B6baNki3e6rsuGxyd6QzlZGq
 YWkw==
X-Gm-Message-State: AOJu0YzdOPfZ5OWCl1J4Qb4KKhqJqd7vwjY8j/cx3eauoefiWK0wFXkA
 3ynqfn7dBlQVHfYBSw3mTRzV1ZGqUBSU1oCOhVtXLgP3IH2KDkWdvNlIbg==
X-Gm-Gg: ASbGncvapR3cN95g4t5F7tv78zVnmYpQmoTL9Q5mGPSvcviWJ4jAClH5asv+KNfFmLD
 j+uVRk27VZMS0po+sTqpgNmq7rj2qPhzPQ1K3yjDJN/cdxppNHPZRAuzd/4jH0c+n+54QGy2H3k
 btzR/J+iDdImdrDKT9gmdH+cLp/n8ib3G8lRwBa773GFm71Ta2U9fmk+qu49dxBy8ntnmeULNel
 01K6bfymtjU/G9NvI8+CNWhHpCVQ445NU3Qk+jbtVJ5IAmUT4/8uMmDu16rfNo/q55JPAB4YI4o
 tStscQeco9+qtoVTr3qf6nARviglNqFARZu5s4SGaMO2YUG5P/7RK2Cfnpt9hc1NLkE9+njx2R6
 3x7ax5bqXiYEsOnJrJzYE6XueHKocMQ==
X-Google-Smtp-Source: AGHT+IGle/EKJ8EhyBKC13IdQjsMHCfBpA4DELGU+uU8/tLgnEqVeKSFPXzj0i0Kro0X5BGd2RNpoA==
X-Received: by 2002:ac8:690f:0:b0:476:83d6:75ea with SMTP id
 d75a77b69052e-47708333f79mr13450231cf.15.1742341365306; 
 Tue, 18 Mar 2025 16:42:45 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:44 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 03/10] clk: imx8mm: register UART clocks
Date: Tue, 18 Mar 2025 18:38:31 -0500
Message-ID: <20250318233849.587520-4-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250318233849.587520-1-aford173@gmail.com>
References: <20250318233849.587520-1-aford173@gmail.com>
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

V3:  No change
V2:  No Change

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index bb6958f0ec2..378c07caba3 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -81,6 +81,22 @@ static const char * const imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m"
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
+static const char * const imx8mm_uart1_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext4",
+					  "audio_pll2_out", };
+
+static const char * const imx8mm_uart2_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext3",
+					  "audio_pll2_out", };
+
+static const char * const imx8mm_uart3_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext4",
+					  "audio_pll2_out", };
+
+static const char * const imx8mm_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2", "clk_ext3",
+					  "audio_pll2_out", };
+
 #if CONFIG_IS_ENABLED(PCIE_DW_IMX)
 static const char * const imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m",
 						      "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_500m",
@@ -322,6 +338,24 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite("i2c3", imx8mm_i2c3_sels, base + 0xae00));
 	clk_dm(IMX8MM_CLK_I2C4,
 	       imx8m_clk_composite("i2c4", imx8mm_i2c4_sels, base + 0xae80));
+
+	clk_dm(IMX8MM_CLK_UART1,
+	       imx8m_clk_composite("uart1", imx8mm_uart1_sels, base + 0xaf00));
+	clk_dm(IMX8MM_CLK_UART2,
+	       imx8m_clk_composite("uart2", imx8mm_uart2_sels, base + 0xaf80));
+	clk_dm(IMX8MM_CLK_UART3,
+	       imx8m_clk_composite("uart3", imx8mm_uart3_sels, base + 0xb000));
+	clk_dm(IMX8MM_CLK_UART4,
+	       imx8m_clk_composite("uart4", imx8mm_uart4_sels, base + 0xb080));
+	clk_dm(IMX8MM_CLK_UART1_ROOT,
+	       imx_clk_gate4("uart1_root_clk", "uart1", base + 0x4490, 0));
+	clk_dm(IMX8MM_CLK_UART2_ROOT,
+	       imx_clk_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0));
+	clk_dm(IMX8MM_CLK_UART3_ROOT,
+	       imx_clk_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0));
+	clk_dm(IMX8MM_CLK_UART4_ROOT,
+	       imx_clk_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0));
+
 	clk_dm(IMX8MM_CLK_WDOG,
 	       imx8m_clk_composite("wdog", imx8mm_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MM_CLK_USDHC3,
-- 
2.45.2

