Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344B2C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5052B8129B;
	Sun,  2 Mar 2025 17:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RSz+xSra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7CA8128D; Sun,  2 Mar 2025 17:54:00 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB99811AC
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d3dd76a825so13838815ab.2
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934384; x=1741539184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvekJyzjVz4xkTzEbYSZXLqYR1IFDaVYxwp2UyANkyk=;
 b=RSz+xSraxGxpeWu/We3fzash0jZhCyRDXKzJJSjO6IEDdeEzb3x9y4kxKaRWaUU7q0
 6pmd4vWaOcHlknZ9WfM1ySGkNOzfgRmS92jF+RA/OUgyKdaDh3EZyyGVyouD6D0A7I+w
 ccX5aVyM/I5mNbCwqqJTLLPBECGP5HCCgelVn7m+Bq6l8NHU4L5liJTTLRMVfIk69lqS
 vaq2tMxd7b2e0A3Mr57FasUn9RHPRrNK4S/yrXH3ye7f6rd6C1pa838/ZfOlI7HWnUkl
 34pkfOBp0/URyJ2jL/ZgFyFZIlghz9X/zZ9ri47prqVzhjyEH7Bh56M1W2Ept9lHD060
 LFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934384; x=1741539184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvekJyzjVz4xkTzEbYSZXLqYR1IFDaVYxwp2UyANkyk=;
 b=Qgj+O0OxCm3mrT/bWU/L0ocSoEGmYjZeiDHDezizSZe5BscYzS10OEwCTo5uHNpoYe
 xtukdJwY1PMcwfEhXNor86yHmHTLNEvQ5TWgHzbkDcYt2alLcxBKM0GQgObQSaYayyVX
 IM3Qf7Wthh9ud4yYNrgrWDnrN2wPXtrefOlpy5NEyM8LPsDOvgKxaVB/fd8kxaPDfX8n
 OI76R0THDy/n5p2wc0ZHwoJAmEGktAH3qY5TUID8QZfhzv3Q4DWoPA/g5D1D1FV9zkmv
 uIAhzGlK3K5Aa2Pwk2/PArOPmgTvzkMzRMghJ/cHXXyHkjyyQyxJDoxpJjupvIpQKbh7
 7UQg==
X-Gm-Message-State: AOJu0YxJi9klcNPl/NauDFgI55BaGqkWuOQYcwFDreaQyGjSdthWF1XT
 ttbYbvoXH0E196Ve3c9f7raQlJtS9dP92bzC9ZhgwEPLTqeGg3uD0UkJYA==
X-Gm-Gg: ASbGncvp2MYrlzpXrmlLsRM7J0iBMTzakhqDdXJdRGE/5BjrZMRxhxghZWl5wluKdn/
 7oEZRjv3h0mrsXjzkBhJ9WvmkHIwqMedDQ7rwqZaBE5LiiUf7MGEYfTNoeW1nWZ5EfNKg70lf/H
 89U2gQfRWjmxboQxwA/1/dgfXVo+wdlK1kZeOEamFBoJPsIYJVkxrYcZn2aNXBg2O3gao//2flX
 sSn8OC9o/g+5uPX0+s2YtANPGIzp6ruhILrF5XohuIY81oiOh5pNYftzk4HBN1WiPmKxJkvV9H7
 V9T2RUbDkDx6vXE3R+YRxsoBIQpCbSFgiO2K47x4rGm9S3BLUUbaYA1/XFtvS/JmUjDctwoyAeO
 2G3qwmShRzDWZNwxjOG8=
X-Google-Smtp-Source: AGHT+IGuJ2hy3rxY04I0Xe/ZvJ1oBFFhssZ5HtGzUG0TN48ZcOB6ScLGrqlR3u5SpWd7hUK80ZINvA==
X-Received: by 2002:a05:6e02:138e:b0:3d0:4700:db0b with SMTP id
 e9e14a558f8ab-3d3e6e233f8mr107126675ab.2.1740934383754; 
 Sun, 02 Mar 2025 08:53:03 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:03 -0800 (PST)
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 02/10] clk: imx6q: Register UART clocks
Date: Sun,  2 Mar 2025 10:52:29 -0600
Message-ID: <20250302165249.267992-3-aford173@gmail.com>
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

In order to use the driver model and clock system to enable UART
clocks from the serial driver, it's necessary to register the UART
clocks.  With the helper function to check for imx6qp vs other
variants, the UART can register for both scenarios.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/imx/clk-imx6q.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index de5e5d8132b..caf20e2bc03 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -40,6 +40,7 @@ static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *const periph_sels[]	= { "periph_pre", "periph_clk2", };
 static const char *const periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m",
 					       "pll2_pfd0_352m", "pll2_198m", };
+static const char *const uart_sels[] = { "pll3_80m", "osc", };
 static const char *const ecspi_sels[] = { "pll3_60m", "osc", };
 
 static int imx6q_clk_probe(struct udevice *dev)
@@ -85,6 +86,9 @@ static int imx6q_clk_probe(struct udevice *dev)
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 
 	if (clk_on_imx6qp()) {
+		clk_dm(IMX6QDL_CLK_UART_SEL,
+		       imx_clk_mux("uart_sel", base + 0x24, 6, 1, uart_sels,
+				   ARRAY_SIZE(uart_sels)));
 		clk_dm(IMX6QDL_CLK_ECSPI_SEL,
 		       imx_clk_mux("ecspi_sel",	base + 0x38, 18, 1, ecspi_sels,
 				   ARRAY_SIZE(ecspi_sels)));
@@ -104,9 +108,13 @@ static int imx6q_clk_probe(struct udevice *dev)
 			       base + 0x24, 22, 3));
 
 	if (clk_on_imx6qp()) {
+		clk_dm(IMX6QDL_CLK_UART_SERIAL_PODF,
+		       imx_clk_divider("uart_serial_podf", "uart_sel", base + 0x24, 0, 6));
 		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
 		       imx_clk_divider("ecspi_root", "ecspi_sel", base + 0x38, 19, 6));
 	} else {
+		clk_dm(IMX6QDL_CLK_UART_SERIAL_PODF,
+		       imx_clk_divider("uart_serial_podf", "pll3_80m", base + 0x24, 0, 6));
 		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
 		       imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19, 6));
 	}
@@ -118,6 +126,10 @@ static int imx6q_clk_probe(struct udevice *dev)
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

