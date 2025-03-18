Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75350C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7485D81101;
	Wed, 19 Mar 2025 00:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LI5Yjllt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1257081026; Wed, 19 Mar 2025 00:42:52 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84A481CA8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46fcbb96ba9so45326821cf.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341368; x=1742946168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/XiS5H4uhdtHmURxc5sUvQ+SMIsfheaczXgnpGYplQ=;
 b=LI5YjlltItV4gil/4D4stkMkroT2gwI4eFmXJoADP4aDxEjTfD85oiqwSZtrBE6Bky
 jPjhUYJpUOlQXYVa7zH9n6yyyDn5nJn1Bcbr9QXzlH0lVpPHE39OPvrj7KZY0RaADHsQ
 tzmU+gyW4W7bgy7KKsqPHJ8LUu9wuKXyxNWnMjohPvByHpKUr9rTUgDdowSCBtOoHGYC
 VQfE2yEWwehN9h81pJJqO345LfItUMe6v/Q6XLG2fwephmoFtA8H4HPf+k1s0ou72TzI
 vgJ+FuDsYzLwa2okjXFd6bE7FgM0e5+y/Z4xQPjui4MrXdPVqpbhrQq1XKxpKczkeaUg
 cSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341368; x=1742946168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/XiS5H4uhdtHmURxc5sUvQ+SMIsfheaczXgnpGYplQ=;
 b=uMUYJpjA1ltvDMEkWrlCMx7C/LsP5u3xcekfg10M0pzOqJSkzUadhXfDOtc71PK7J1
 ZsS1JtgIAIq3cEKTP+H5o7l4ZflfENFjedUtlpHM2do1EcARjedGMJP0CYWLNwX61oky
 rOLhnxyNrWE9Rzx64WYmOpbJXUZ0GDsEGjueeRcHh6ZotOdXtnpPSpNX1KvdyhLPTnkR
 QRSE9XeJxtbx8JbdmoZBHe1VLq5QQdYhs/2ZT+Obexy+Wlzt4w2PjUomPu/abS5x60Sw
 HmBT/IbJvGWuHtlTSCs5Y5eMR+S3v9cfyc22k3+ItVdrPR9bIWUQWN8wcIpZhQ7rlYh9
 0cLA==
X-Gm-Message-State: AOJu0YxnL+KjXimLC/rlKwtwVFPad7kwD+Bjlozp1Jl41tYmPj633wqj
 QJn56CTOufBbbaVhDBZD0NBnlFaxMD2iPIUmGEg2CZUmjs35vqavkZTVrA==
X-Gm-Gg: ASbGncv40wb/QxlMg2xPX0c7DyLX5yyPH8JP6x+0+MUvroq9pK3yN0z9vnoIjuL+EUn
 C5E3UfpUFk+yXIDH4uf9HtWA2XSXA6EymO2+++t+ozwoqjH9+QZ0L4u/usB+s5Tz5H9kTmZUjso
 8HJRLi6tV1ITCyJujpXApTA3d/a+VBqpON4PjoMZYPZxpeRrJUuGk56SAaMMReTdqnYt8lhQEBL
 UIB5yvl6GXB5GIlO3gmjJU/9hYf6YzEm3euJAcD1m51ufwyRqZuj2Z9eXKb4ytcxziKL0KZNxPG
 VROrDlVmDxPI0OFwGtf3sRZHH1bzTnxZEzD93jXEC3xQcKTG5x9BN6XdBBJfXcIFxHkojsNJnKB
 WJ1sCp/TOMMnEcasor4U=
X-Google-Smtp-Source: AGHT+IFoJgaL4jmltc5XW4NsaDe4S2gRK80u0q+4B8nCGyXOYusnU200OHK+QNdYTsXJDM8uFgWg1g==
X-Received: by 2002:a05:622a:5145:b0:476:884e:52ee with SMTP id
 d75a77b69052e-477082e2054mr16094301cf.11.1742341368282; 
 Tue, 18 Mar 2025 16:42:48 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:47 -0700 (PDT)
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
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 04/10] clk: imx8mn: register UART clocks
Date: Tue, 18 Mar 2025 18:38:32 -0500
Message-ID: <20250318233849.587520-5-aford173@gmail.com>
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
 drivers/clk/imx/clk-imx8mn.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

V3:  No change
V2:  No Change

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

