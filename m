Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5D4C54E41
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 20:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53EB287D47;
	Fri,  8 Mar 2024 21:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KvNf4EeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFAF87D50; Fri,  8 Mar 2024 21:13:29 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C688087D3D
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 21:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so659359a12.0
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709928805; x=1710533605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCNa5+RnyNoxxHzAvIIDTXOgZK/1Y0APJ5I5gMi0rBg=;
 b=KvNf4EeUh5d5zd3nm4YEZpAOn9U4rwn+wzrbpOgsexJB+Kyl2KxsSb6cBHr6frpbO0
 9zPDXndihZJAfVOgmd9dKzl+C7uRVQgIqWaOn7MUUgCm4G0VD5i2t5HdmBYI+hpRKW4t
 kub5zHdjNRVZWEa1iN/cFVuYiqqe+rYxBXUjvDWNvlQs8yuNM2dvwzW865bAKQtg7VBQ
 Ffb6UNo16Aq7O1Yp5pQj34RSYMYpUhEJmoBz1LQFl4RH3AAbxy7Vjv9kcdIh3qOS14F3
 QkMeHJsWT2aIevvvrds5MbDhFifmRB7L4Yda/XpUuEI8NDbAxwVXhxu3hyniFPYaqtMU
 3PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709928805; x=1710533605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCNa5+RnyNoxxHzAvIIDTXOgZK/1Y0APJ5I5gMi0rBg=;
 b=asUs5Nhz6+MTzD8IlHV4OCw7xDQ94Xjpk1ZCuD2DMldL4q1f0dcZiye9TdPMruFAXc
 DEpbn+v2mMvzIWV238mVEnDerEzwpKsutpxE7ElLtJkbEnPjIc97zfweAl2647PDvvHw
 hWn4phy93hJOSeqBVvfpGYcCSfUzge+elTam7KxUq5lcVrz1w/i+pKHJBxk8EJJlGlp6
 eMwbmgTIJJgiNUBKxWqg9f7AOY5YMZ3BSjH+84Eux4IT7G7kK3Nbsb/CrW/s7SwA/p+a
 XQ7folr7kBXzcNJAOMFHlNcFjKRVZbUg7i1wPp0eLKFw3Ut8kw4ZR7lneJyJmNySOctt
 ABRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4GcbBpV2vSM4AXt0nlcuVWIGu9qroWhMzQjvCz4+t2z6pvex2rRySddwTMleTpqpl1COBbmS6QMoPb+U+bOXfqtJZJw==
X-Gm-Message-State: AOJu0YwxgN02n38IQGCtUo1/FXqFZFpkjZSKeK+sXI6hmRWVuIB8tMxP
 bHEFW/SBFny/gKEbD5oHQA0s4ZUpS7PczDZo6OD791qN7yBFK+Vq
X-Google-Smtp-Source: AGHT+IFtaLgZd2CmNXTKPqEsoCf31Cf61Bh9Od3GN3uaPY+RIdOkL2TApoadVHdGWZGSTzLZgOLRQg==
X-Received: by 2002:a05:6a20:93a2:b0:1a1:40a2:23a8 with SMTP id
 x34-20020a056a2093a200b001a140a223a8mr54402pzh.4.1709928805129; 
 Fri, 08 Mar 2024 12:13:25 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fd20:8903:3746:880b])
 by smtp.gmail.com with ESMTPSA id
 y11-20020a056a00038b00b006e6529c7d75sm93808pfs.3.2024.03.08.12.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 12:13:24 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: seanga2@gmail.com
Cc: trini@konsulko.com, peng.fan@nxp.com, ye.li@nxp.com, u-boot@lists.denx.de,
 marcel.ziswiler@toradex.com, francesco.dolcini@toradex.com,
 hiago.franco@toradex.com, joao.goncalves@toradex.com,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] clk: clk-imx8qm: Add LPUART IPG entries
Date: Fri,  8 Mar 2024 17:13:16 -0300
Message-Id: <20240308201316.1721909-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308201316.1721909-1-festevam@gmail.com>
References: <20240308201316.1721909-1-festevam@gmail.com>
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
the apalis-imx8qm board no longer boots.

The reason is that the imx8qm clock driver does not handle the
LPUART IPG clocks inside get_rate(), set_rate() and enable() functions.

Fix the boot regression by adding the LPUART IPG entries.

Fixes: cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/clk/imx/clk-imx8qm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8qm.c b/drivers/clk/imx/clk-imx8qm.c
index 6c05d07c340..01e33de9d63 100644
--- a/drivers/clk/imx/clk-imx8qm.c
+++ b/drivers/clk/imx/clk-imx8qm.c
@@ -95,20 +95,23 @@ ulong imx8_clk_get_rate(struct clk *clk)
 		resource = SC_R_SDHC_2;
 		pm_clk = SC_PM_CLK_PER;
 		break;
-	case IMX8QM_UART0_IPG_CLK:
 	case IMX8QM_UART0_CLK:
+	case IMX8QM_UART0_IPG_CLK:
 		resource = SC_R_UART_0;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART1_CLK:
+	case IMX8QM_UART1_IPG_CLK:
 		resource = SC_R_UART_1;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART2_CLK:
+	case IMX8QM_UART2_IPG_CLK:
 		resource = SC_R_UART_2;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART3_CLK:
+	case IMX8QM_UART3_IPG_CLK:
 		resource = SC_R_UART_3;
 		pm_clk = SC_PM_CLK_PER;
 		break;
@@ -181,18 +184,22 @@ ulong imx8_clk_set_rate(struct clk *clk, unsigned long rate)
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART0_CLK:
+	case IMX8QM_UART0_IPG_CLK:
 		resource = SC_R_UART_0;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART1_CLK:
+	case IMX8QM_UART1_IPG_CLK:
 		resource = SC_R_UART_1;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART2_CLK:
+	case IMX8QM_UART2_IPG_CLK:
 		resource = SC_R_UART_2;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART3_CLK:
+	case IMX8QM_UART3_IPG_CLK:
 		resource = SC_R_UART_3;
 		pm_clk = SC_PM_CLK_PER;
 		break;
@@ -283,18 +290,22 @@ int __imx8_clk_enable(struct clk *clk, bool enable)
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART0_CLK:
+	case IMX8QM_UART0_IPG_CLK:
 		resource = SC_R_UART_0;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART1_CLK:
+	case IMX8QM_UART1_IPG_CLK:
 		resource = SC_R_UART_1;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART2_CLK:
+	case IMX8QM_UART2_IPG_CLK:
 		resource = SC_R_UART_2;
 		pm_clk = SC_PM_CLK_PER;
 		break;
 	case IMX8QM_UART3_CLK:
+	case IMX8QM_UART3_IPG_CLK:
 		resource = SC_R_UART_3;
 		pm_clk = SC_PM_CLK_PER;
 		break;
-- 
2.34.1

