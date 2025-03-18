Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B758BC28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1288197D;
	Wed, 19 Mar 2025 00:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S1UMIoPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A97748129F; Wed, 19 Mar 2025 00:42:46 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BB3881026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-476a720e806so55136991cf.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341363; x=1742946163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05IORTc2Vurw6Muh69hCmXNe/ZHKS21PqO2V0t1noAU=;
 b=S1UMIoPgnJ7/O+mflsWWcf9uobTzCmlMuUU1pleG7RcqdzTybJSwMPg8QmHNO/Dnv3
 902cuQIswa/RX+monJ8Iv7vLn5GGJKQDDExuxk/6EM84kKjAbwAINafEelYbhrcaJdu1
 YJYDpPmTP9gTT610oR9PQoQqmRgTLDuqTCRGBtydDzUKJJdKlPJxF/U7w2DZC7htad1t
 QCOStufpIeuTY8IJ7hTKLAxxc6fU4Z8fMJLymNgWbJ8yl6ERECqBNrr9xCixi9OfV9P7
 TH9rrN8AVY3S66OsOs+cUe8djzF/EB3dADnd0KtvoPZFOj0t9eSbz0560+jzi6FoaqYB
 0yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341363; x=1742946163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05IORTc2Vurw6Muh69hCmXNe/ZHKS21PqO2V0t1noAU=;
 b=YXJmZpmh3gqKDXgjxfPQxoBmRWBHshPJVV/Hq/BJqlwvTXKFxJ5kE9FHWUOwXv9GRu
 IHkK6r5o0JYJIBy2KRt3Km6+NYVguvU/UKIeuS+KxBdeGAi+x1AAjYbf+bQtLlRwGzJs
 xh4qqzYDJOsf+PMMQ+yIML2v0Y4HO7fFhH+hLIDpRFuuPZaAkYv3MAerQvzJkf8F2A6S
 Bq8IkFCmQUx84iUTlPmc9T2JFV6kMCVbvvv4IN1+T8TcRKWrA7ZD0ZFoze9RFLp4aUM9
 jhhtXod64nhB+CAabBHcMVepUMjMDdC0yeCZhtqogI/UDOvlvsMERDT6fi0+2678xz0d
 GKxw==
X-Gm-Message-State: AOJu0YxDnmTpzBYhi/ug3NyI4zANszcLsKkniFzSNkzYsC/9XjQoaFCT
 wI4waALYf/X/6tivBl9GW6mLKWlt+bWPr+TPJDYPFLTCjIN/B2SvvgyhJQ==
X-Gm-Gg: ASbGncss4N1gAz8qFv5dGSWnhtIihTBsibD8VhGKVUtzl2vmDgWCw607F1grleXYt7s
 UKfnZ1C/UGwRQOzaZLFO+4yLgOV4hBkfHRlQbfbgmZcuYBR1oM/Ri45zoFSFbz61ZRG4LbNbw4l
 hBd1ypft/lp573TvyWvP7paz5O0lqPAFdI1VKIp/8l94DLv//jDo/VpeV12QsgD+H2Fn+hckDYT
 zIAAS+LhCAEGP/n7LAb9YKz/p2dFzgjXONc+zVjkjpGK9AIcrMjLFQn56oWIdQ7L4UXgnZvZWgg
 m8erhFDqWi7GwwPTgZom47YjeK0pBXBi379BeRwJgnyQvco82C9JwrSjURFMhKwlcw5p43puk6m
 UhHtm4xAqfn2AoJbCjKo=
X-Google-Smtp-Source: AGHT+IHAH2NypssrcveNZdY6sO1DNdbUqy1rYXhUFDtUeKA4oJONWvo84965SLcj69HIwqDio/8ZYQ==
X-Received: by 2002:a05:622a:1bab:b0:476:6ddb:1a25 with SMTP id
 d75a77b69052e-47708307153mr13699591cf.26.1742341362880; 
 Tue, 18 Mar 2025 16:42:42 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:42 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 02/10] clk: imx6q: Register UART clocks
Date: Tue, 18 Mar 2025 18:38:30 -0500
Message-ID: <20250318233849.587520-3-aford173@gmail.com>
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

In order to use the driver model and clock system to enable UART
clocks from the serial driver, it's necessary to register the UART
clocks.  With the helper function to check for imx6qp vs other
variants, the UART can register for both scenarios.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
V3:  No change
V2:  Directly call of_machine_is_compatible("fsl,imx6qp") instead of
     using a helper function
     
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

