Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E58C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 20:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF5E87D49;
	Fri,  8 Mar 2024 21:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vg6vbizM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7481F87D48; Fri,  8 Mar 2024 21:13:26 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D60B87D3D
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 21:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so659348a12.0
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 12:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709928802; x=1710533602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gcpWUVn3n8OflcmG0b08j0qeb1jMB57uTvTGUeVnYGw=;
 b=Vg6vbizMMNd1i2DUPOc00Ivdxpziv/fu3BZUxy7nRVZxcM+vu8t3P7NBEUkeadr9N/
 PprxDJJtjn2eXArjWb7ADLQoRjafzhHHYJc2T7h0pj33MWuyXXLWzCqh+yUQ//xAZhpS
 bzCoCBwwsopSiC/otqSRc6obGG4g8FIkERe/xDFYgGTaroJoKQvtcd9YFKySOK05PEc0
 kC41N0oSqRgzTonDbudAfzrQDdiIiLLSnw1X06mgD+6CTDEEjEFbz4LeRVyY/7xzOPpZ
 Xuj8i5HQzL9zj2GUSgEa4+3s6iWolY4/KLYQG0XomrYcTup3y+5QnAbvDFioiq4z5zJC
 7PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709928802; x=1710533602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gcpWUVn3n8OflcmG0b08j0qeb1jMB57uTvTGUeVnYGw=;
 b=j+GQuBCx6tKa16LxWtYuraNdiCNwFq5RQD0BThgInbP0uF/aAbEBSZAMpp0VeEiXRH
 cbhwF2o4vr0PiCheRFGkioPp5t7FNSt1eh5IqWCpAdtVxY0xoTOKc6DJh8RFaizjVyLg
 nxg2XBzvVSuR36nhNTR5YdGx+tUZPF7lMf9jLMLqCZ/mifbAT+cazttzlt03lZ9tS/tv
 rs1VoGke+n/awT8LsujxlnugTDTZD2f4bj5bIb52nIZTZ4LLv97WkvCMbOzsd1F1G2OK
 4rKziAW6cEyZfHMwI2pLsHcNL7qcwULGNOXIqhjKltyZISZu/MhCTrcY4s8qDdDU4EmS
 CmNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa9w+XWK/Xk0dxveNJvlc6GeIcBTUqStQVRd7SYqnpHWcgthyYj1ZZAAUKJpDcJpTx5CsXH9EZnMztC4bYWj6Xo5tVkw==
X-Gm-Message-State: AOJu0YzkoNiuc5cv72/ytdSegIU61DzcoWiubTBfjksBQ3bGU3pOhhSa
 YwLcjBAVmqiSBuIT0kelHddcQDktpCKFqtwuGTrgr0U2EQygVeF6
X-Google-Smtp-Source: AGHT+IHdGTC1ELeSvXQgYNdSwM9bb7xU0cf3xi8CY5pVgolRuJkEx0b8DKNPxaHWE2IpWnDHy2eK7A==
X-Received: by 2002:a05:6a00:2ea7:b0:6e6:5574:17fe with SMTP id
 fd39-20020a056a002ea700b006e6557417femr46120pfb.2.1709928802019; 
 Fri, 08 Mar 2024 12:13:22 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fd20:8903:3746:880b])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a056a00038b00b006e6529c7d75sm93808pfs.3.2024.03.08.12.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 12:13:21 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: seanga2@gmail.com
Cc: trini@konsulko.com, peng.fan@nxp.com, ye.li@nxp.com, u-boot@lists.denx.de,
 marcel.ziswiler@toradex.com, francesco.dolcini@toradex.com,
 hiago.franco@toradex.com, joao.goncalves@toradex.com,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
Date: Fri,  8 Mar 2024 17:13:15 -0300
Message-Id: <20240308201316.1721909-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Since commit cc7df0b9e8bc ("serial: lpuart: Enable IPG clock") 
the colibri-imx8qxp board no longer boots.

The reason is that the imx8qxp clock driver does not handle the
LPUART IPG clocks inside get_rate(), set_rate() and enable() functions.

Fix the boot regression by adding the LPUART IPG entries.

Fixes: cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 8bf7e325481..d900d4cd528 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -88,20 +88,23 @@ ulong imx8_clk_get_rate(struct clk *clk)
 		resource = SC_R_SDHC_1;
 		pm_clk = SC_PM_CLK_PER;
 		break;
-	case IMX8QXP_UART0_IPG_CLK:
 	case IMX8QXP_UART0_CLK:
+	case IMX8QXP_UART0_IPG_CLK:
 		resource = SC_R_UART_0;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART1_CLK:
+	case IMX8QXP_UART1_IPG_CLK:
 		resource = SC_R_UART_1;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART2_CLK:
+	case IMX8QXP_UART2_IPG_CLK:
 		resource = SC_R_UART_2;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART3_CLK:
+	case IMX8QXP_UART3_IPG_CLK:
 		resource = SC_R_UART_3;
 		pm_clk = SC_PM_CLK_PER;
 		break;
@@ -170,18 +173,22 @@ ulong imx8_clk_set_rate(struct clk *clk, unsigned long rate)
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART0_CLK:
+	case IMX8QXP_UART0_IPG_CLK:
 		resource = SC_R_UART_0;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART1_CLK:
+	case IMX8QXP_UART1_IPG_CLK:
 		resource = SC_R_UART_1;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART2_CLK:
+	case IMX8QXP_UART2_IPG_CLK:
 		resource = SC_R_UART_2;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART3_CLK:
+	case IMX8QXP_UART3_IPG_CLK:
 		resource = SC_R_UART_3;
 		pm_clk = SC_PM_CLK_PER;
 		break;
@@ -263,18 +270,22 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART0_CLK:
+	case IMX8QXP_UART0_IPG_CLK:
 		resource = SC_R_UART_0;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART1_CLK:
+	case IMX8QXP_UART1_IPG_CLK:
 		resource = SC_R_UART_1;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART2_CLK:
+	case IMX8QXP_UART2_IPG_CLK:
 		resource = SC_R_UART_2;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QXP_UART3_CLK:
+	case IMX8QXP_UART3_IPG_CLK:
 		resource = SC_R_UART_3;
 		pm_clk = SC_PM_CLK_PER;
 		break;
-- 
2.34.1

