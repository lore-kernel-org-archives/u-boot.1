Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA39C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988558197F;
	Wed, 19 Mar 2025 00:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k3T1fhTo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F1778197D; Wed, 19 Mar 2025 00:42:44 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294F881026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-47698757053so74382001cf.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341360; x=1742946160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJUC/K6/EbY6H3rTw6jZu9fqkDbWKs1xzKBUhaGnE1Y=;
 b=k3T1fhTo+BelD6f7ngXHhE6LkYRuMgwPgdyNZW34LgcYBxRRMg1iJR0B6zjuGXU5mw
 4xwAXz/AExBuCOz/J0Wr+/yiJXD1aQibwSL0RLU1PuH9enFFtKmBMF8iAUqrm7PrXkdP
 tEoND8N7mKb9/nmJhVkKynJRZ2pvZ8ArhaWPEYCEPorwjW834xL5cXoZnl7TO0uVmicn
 9kRGnI5abHufzbsF2DZG1f37EKWdeMx9RQJU8qXKl7T1o4iQrOR04YF0VZ62LmhzSB1p
 +4BLaf3XqvIpMtf73/Qhz84IvBpANFS+vgosOB5mPZKW6sZli9XSANsOFOfOiUlK8uD0
 xuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341360; x=1742946160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJUC/K6/EbY6H3rTw6jZu9fqkDbWKs1xzKBUhaGnE1Y=;
 b=PJJl4VcLqcxbwc2jDr8vBsgRcAG+aXZbGVyDg/dNE//jh0zUXdYkVX8pfu76cFJGKp
 LbF3LNzIDpqw8e9flOgbnx5mmu0GCzmshunAI/HKt0eat7a82SuGGdKq1FYHUM0e20UF
 22WBQUdjia26wFYlXLZU5lZf8Z6xbqhDwTB3wSdqYfZ9w5d8jBnFO0lfCVYuVS6g4QmO
 fOYSft0SFEVKulPSMOFlbrLJFZC0SlXqoTT0GT5JXZJXTx42j7sJJ6xAlZS7Dv7RbCji
 Bniyo/zB95k8fWmbYpggMz9frM2krOizAAXb35YJvK1us4QOlKmKtM5rf3PxxtlzQErr
 1LWg==
X-Gm-Message-State: AOJu0YzqpLv/f4pSgq7IEzlemXvyNW/Nond9Q97yrIKlrgu0SQxYx3Ci
 dfD60FQ917YXZX2DjfZlAvvc4q7jYdxEUJvInWhD1EJn/8onLYsP2VbY1A==
X-Gm-Gg: ASbGncsZUC9D/Tq1BuXoRlsZKy/N4OmQte5FqUoCDDAoo1XWs/sjAoGptDu68b7pCRa
 Qf5arH8Q5ibU4xWyGhjivs8Hbb3R2aFAVfO3k3fQBJ5WPVMuDPDLGgNJr4kNExFQIi6CMEGTChm
 Zedp83pXsQqZ5XTvEv6bTiQzMqZjz1hqS4zoWleU7Q1gov3RV4cZZhg4PgC2zKBzt9NMTRR2h1E
 SYSrc5mAvUeakcAxkW+qDxXRukH0vHqDlGNHy+3ZJoADbJFHHjUZMyO9kCP86Zy0q/40lcJNVRD
 xzp7gj+kGJNP9vc9w+2N/dhF7ZF141GHMN1qBOhaJDGR8uTwKRoX5DPebxHyCwXvO97oCu2ORcW
 CEjB58EOrANJ2dxWQi+w=
X-Google-Smtp-Source: AGHT+IGI+9TMlu9wUoTpArqN7jJO48obRgSDTWlJu7183mvN5y8mP2WzgqH1wC8VZZXOkGqxS+k2XQ==
X-Received: by 2002:a05:622a:4085:b0:476:9b14:f905 with SMTP id
 d75a77b69052e-477083822c4mr16560891cf.47.1742341360461; 
 Tue, 18 Mar 2025 16:42:40 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:40 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 01/10] clk: imx6q: Properly handle imx6qp ECSPI clk_sels
Date: Tue, 18 Mar 2025 18:38:29 -0500
Message-ID: <20250318233849.587520-2-aford173@gmail.com>
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

The ECSPI clock has the ability to select between pll3_60m and
osc on the imx6qp, where it's fixed on other variants.  Fix this
by adding using a helper function to determine SoC variant and
register the clock accordingly.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

V3:  No change 
V2:  Fix the name "ECSPI" and elimiate helper function by
     directly calling of_machine_is_compatible.

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index df9f0285e1e..15ad0c9ac06 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -35,6 +35,7 @@ static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *const periph_sels[]	= { "periph_pre", "periph_clk2", };
 static const char *const periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m",
 					       "pll2_pfd0_352m", "pll2_198m", };
+static const char *const ecspi_sels[] = { "pll3_60m", "osc", };
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -78,6 +79,11 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_mux("usdhc4_sel", base + 0x1c, 19, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 
+	if (of_machine_is_compatible("fsl,imx6qp")
+		clk_dm(IMX6QDL_CLK_ECSPI_SEL,
+		       imx_clk_mux("ecspi_sel",	base + 0x38, 18, 1, ecspi_sels,
+				   ARRAY_SIZE(ecspi_sels)));
+
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
 	       imx_clk_divider("usdhc1_podf", "usdhc1_sel",
 			       base + 0x24, 11, 3));
@@ -91,8 +97,12 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_divider("usdhc4_podf", "usdhc4_sel",
 			       base + 0x24, 22, 3));
 
-	clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
-	       imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19, 6));
+	if (of_machine_is_compatible("fsl,imx6qp")
+		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
+		       imx_clk_divider("ecspi_root", "ecspi_sel", base + 0x38, 19, 6));
+	else
+		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
+		       imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19, 6));
 
 	clk_dm(IMX6QDL_CLK_ECSPI1,
 	       imx_clk_gate2("ecspi1", "ecspi_root", base + 0x6c, 0));
-- 
2.45.2

