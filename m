Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB830C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A5281335;
	Wed, 12 Mar 2025 01:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S9KRqlJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9389781703; Wed, 12 Mar 2025 01:31:51 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6445580756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6e8f05acc13so62006896d6.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739507; x=1742344307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5Murh8z8D4xbQZwxlLFhdB+i+cIVHDjNIFE+0rN70g=;
 b=S9KRqlJ+9h8WiN6UyDg23kimATKPogVJw/YjJx6X6Yx7WFhA12gDqOJ3EyqFbQQZ6O
 Si+fKeqrP0bZQC8SFKtoJ5gTsLBi0l/aWdXoWHVH53uypsFJVy4dAc2n3n/+ShfxAbmf
 La+pwMkmLVn5bpelb+f3Hp+l+1IknH2iKt0aKEohqu8K+MhEvp2UbKolvvYJNZKEvrHH
 KXghChnZ16Nza7G9DIiG8bi/ddJDaazGopQCb6uU4+4zbobrAaXBbwjCg9ewJ5RPxps5
 Td9ovuah15R8MqefpQXGuzd+jNGEj01n2pI/pf0n0cB+u/9eRPOSAg8z3nhcUyoQVnGY
 HerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739507; x=1742344307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5Murh8z8D4xbQZwxlLFhdB+i+cIVHDjNIFE+0rN70g=;
 b=rc+OHSJB1vGS8RQ6J5EZMmndF47Fd96/0+ghvfeB3dtE5g9SXGJ+aECMPIl+kNxRv7
 S2hWDjCeG8RKZ70hxrFduTPoelQP8aPLMoD8VJ+B1R+LCQGYkcQbl6PeFaRLwhT5ljcy
 Tcd4BBxF1N0C3A2eGSSjxqVIOs9VpwlRtc1ZpnQwwhpARhSZ39vgRUpBlVEMngJKS9kf
 2lUc/S4Vkup5nRC1g+Mp3mxALUyfC+/agFBVROaPezlPw2fFxPk3DpLYlaBBCIFeOVGW
 HufSeANTT2TjgCHjzzVZ18rejP1HxWxSMvcausWcrLDS2f4wqHnHGQsQIVAO0A7XpTPZ
 piFw==
X-Gm-Message-State: AOJu0YyZRcUH5luOlBAR+IPYIMCDTsuFmXXLIdbj+mRYYmwoEa4Yy0ji
 KobjW1QY4OajTxMI1H6VHiLmyhF5/V4x0Eom+UGQxitfHdJnW87CPXEE1w==
X-Gm-Gg: ASbGncv8NGktgkTQe+KGyrI5M3hje1L17NRKAllaEe2rf96uVV18zBYUiiNltuhtA33
 aESPSqglNEpOSNZ9+58zgM+r3/9NvRRIIie+Q2yHSMQxMwfdSGy8unjqkREaeZ6J41TWMGfZ7gk
 K/xcn4yTVxLogIsWiqMgyXEski5sYUC4A7Bd/PyFMM3MzcEXi5nbK6zGItqyhWDxRnhnh4pjGqD
 kps2oCxDrJYVVJg/Xp1kWnLAqOQmitFOZcKhj7CvIv3trvLMARN47pYylCv/iRAzjiKQu8fzWNG
 ZhC5DM5v8U9P6aAehP0w21DBMS04ywHLU3TRNv7osBbVkVOJAMxlBi6BEJ2bfpD7Okv23USd41/
 T5VLWx+BCetUF1gZ0eO4=
X-Google-Smtp-Source: AGHT+IEtkT5iStOg4pv9kXffucudtLjM55IALCdQ8IXD8Qn1VNy20mmAy5IYQiDd8+bIlrIw+pLEZQ==
X-Received: by 2002:a05:6214:2425:b0:6e4:9b59:d9ce with SMTP id
 6a1803df08f44-6e9005ad731mr276694896d6.5.1741739507531; 
 Tue, 11 Mar 2025 17:31:47 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:31:47 -0700 (PDT)
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
Subject: [PATCH V2 02/10] clk: imx6q: Register UART clocks
Date: Tue, 11 Mar 2025 19:30:22 -0500
Message-ID: <20250312003041.110023-3-aford173@gmail.com>
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

In order to use the driver model and clock system to enable UART
clocks from the serial driver, it's necessary to register the UART
clocks.  With the helper function to check for imx6qp vs other
variants, the UART can register for both scenarios.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Directly call of_machine_is_compatible("fsl,imx6qp") instead of
     using a helper function
---
 drivers/clk/imx/clk-imx6q.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 15ad0c9ac06..a4295614016 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -35,6 +35,7 @@ static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *const periph_sels[]	= { "periph_pre", "periph_clk2", };
 static const char *const periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m",
 					       "pll2_pfd0_352m", "pll2_198m", };
+static const char *const uart_sels[] = { "pll3_80m", "osc", };
 static const char *const ecspi_sels[] = { "pll3_60m", "osc", };
 
 static int imx6q_clk_probe(struct udevice *dev)
@@ -79,10 +80,14 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_mux("usdhc4_sel", base + 0x1c, 19, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 
-	if (of_machine_is_compatible("fsl,imx6qp")
+	if (of_machine_is_compatible("fsl,imx6qp") {
+		clk_dm(IMX6QDL_CLK_UART_SEL,
+		       imx_clk_mux("uart_sel", base + 0x24, 6, 1, uart_sels,
+				   ARRAY_SIZE(uart_sels)));
 		clk_dm(IMX6QDL_CLK_ECSPI_SEL,
 		       imx_clk_mux("ecspi_sel",	base + 0x38, 18, 1, ecspi_sels,
 				   ARRAY_SIZE(ecspi_sels)));
+	}
 
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
 	       imx_clk_divider("usdhc1_podf", "usdhc1_sel",
@@ -97,12 +102,17 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_divider("usdhc4_podf", "usdhc4_sel",
 			       base + 0x24, 22, 3));
 
-	if (of_machine_is_compatible("fsl,imx6qp")
+	if (of_machine_is_compatible("fsl,imx6qp") {
+		clk_dm(IMX6QDL_CLK_UART_SERIAL_PODF,
+		       imx_clk_divider("uart_serial_podf", "uart_sel", base + 0x24, 0, 6));
 		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
 		       imx_clk_divider("ecspi_root", "ecspi_sel", base + 0x38, 19, 6));
-	else
+	} else {
+		clk_dm(IMX6QDL_CLK_UART_SERIAL_PODF,
+		       imx_clk_divider("uart_serial_podf", "pll3_80m", base + 0x24, 0, 6));
 		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
 		       imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19, 6));
+	}
 
 	clk_dm(IMX6QDL_CLK_ECSPI1,
 	       imx_clk_gate2("ecspi1", "ecspi_root", base + 0x6c, 0));
@@ -112,6 +122,10 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2("ecspi3", "ecspi_root", base + 0x6c, 4));
 	clk_dm(IMX6QDL_CLK_ECSPI4,
 	       imx_clk_gate2("ecspi4", "ecspi_root", base + 0x6c, 6));
+	clk_dm(IMX6QDL_CLK_UART_IPG,
+	       imx_clk_gate2("uart_ipg", "ipg", base + 0x7c, 24));
+	clk_dm(IMX6QDL_CLK_UART_SERIAL,
+	       imx_clk_gate2("uart_serial", "uart_serial_podf",  base + 0x7c, 26));
 	clk_dm(IMX6QDL_CLK_USDHC1,
 	       imx_clk_gate2("usdhc1", "usdhc1_podf", base + 0x80, 2));
 	clk_dm(IMX6QDL_CLK_USDHC2,
-- 
2.45.2

