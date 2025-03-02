Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098EBC19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75162807B1;
	Sun,  2 Mar 2025 17:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JaqYfmDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987EA811D8; Sun,  2 Mar 2025 17:53:58 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4367810EA
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so14323555ab.2
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934381; x=1741539181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX4xLo4vxSTTUlEnzijcPHQznSEwsz1jGUXq0dYz9LI=;
 b=JaqYfmDsWsLhzpTZe2sGzSnIls5X5XvO7m7W2UlV9ckvVcTqe++ib2yJUds0jAi0cI
 dG6E5tHCdS9Sxdk2p7Q5UMjfOwC1FSIyjSNy6IV/X4u3uBF6qCc+LHQV8p540rcdI9hV
 cnzT0PSX31iHowisgofQI740Fcm7GBV69MHWLYnxrZo17sepNQ8pJ0qNFH08+ohFwMoQ
 QZw4BgfKBm4pMoMuLCjE6MGD0O9G8Xvt0GXWC86d70KFUEBaEY7leObKBK19b7bsO03A
 MzdG+9McfWBCpKLTYvahorEAWIZrz3LU6pElp2pSVoDEiFTxYFw00pWOePX9dOJeKOpd
 f1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934381; x=1741539181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oX4xLo4vxSTTUlEnzijcPHQznSEwsz1jGUXq0dYz9LI=;
 b=MO7Fjf3gkSvW4KNKWK6WD+36zXQ2yOLvU+s6gnuA5XfkDmvZhwbN4lbeFkYcryvuYN
 Xggj+32jnve31HIkzRy3C+pSLo+mNmcDiosrAbMJqds5ytphk+yEuCrj5xOoUzCJECkC
 SIvizT/eAZ8jQqwegoC2sRa6aHDYEwDilCvgKwzYqUBhJLnIgZwuYNL3KOQhkCZMXWmn
 B9KvqNEtg8FR51KE8/pXPGb4SoCNHtFc1aT8+rswbHbC3OGn8jgr1fL5oBDW4v8tcwvX
 AvTLyGlP4I56g6V3oG5+zD8TtBlP0t24TxX9xicMiYi0XzxOvphCawLma+S6ZjjuXgJN
 PsSw==
X-Gm-Message-State: AOJu0YyF5XDvZ59J0KmwVqRG9412/hU3Hf7VSP6pNKGUybt/bla6Ziwo
 ispxIeMDW6TKf+v+Cb7JpcmjF0XQ1/c5tKzhDzJwcNP7oFFdbb/TmocytQ==
X-Gm-Gg: ASbGnctDq7NgOOIXgWMYvyvksMkXOd+zgTddvZ2sYbJqOX7uKuLl7/DmtN9y7NJwH51
 Z8upfSuSqaE7ofHIsNBc8X0r+hDtxmEkXVd/ud5zb1Wj5JvXtSYrJx8ejvYN8of2nxH1sx3BU1B
 CWLIG8/lFOWDT4CURXUqGoEHugwcIs77DSciGhXue6c5Phw4DJzS88SfPQFejpWx5lpG3d2y0OK
 g2sc4/YS6dYYcUYKuynGfw9hLPoeTTAD3dCwkEGcqUtzcCCeEM2ew7PDmX4yhll447E1H4p01HH
 zNhi1GlrC9YLDoyCzyo2eQsc00ezt7HBMNLjHI6yqsTS2W80OelSmwm+CSo7dcEGqMJDThMifrh
 p2GCR7rtoNYfFs72l2/k=
X-Google-Smtp-Source: AGHT+IE8h3xGp9BsePdvlBPZ+PMThe6eYaD2KvxhugUfAtFuzQNouaIxRJxyZCOj1iAU2bFUgtAbOA==
X-Received: by 2002:a05:6e02:1485:b0:3d0:10ec:cc36 with SMTP id
 e9e14a558f8ab-3d3e6e71cc7mr93439405ab.11.1740934380853; 
 Sun, 02 Mar 2025 08:53:00 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:53:00 -0800 (PST)
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
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 01/10] clk: imx6q: Properly handle imx6qp ESPI clk_sels
Date: Sun,  2 Mar 2025 10:52:28 -0600
Message-ID: <20250302165249.267992-2-aford173@gmail.com>
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

The ECSPI clock has the ability to select between pll3_60m and
osc on the imx6qp, where it's fixed on other variants.  Fix this
by adding using a helper function to determine SoC variant and
register the clock accordingly.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/imx/clk-imx6q.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index df9f0285e1e..de5e5d8132b 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -13,6 +13,11 @@
 
 #include "clk.h"
 
+static inline int clk_on_imx6qp(void)
+{
+	return of_machine_is_compatible("fsl,imx6qp");
+}
+
 static int imx6q_clk_request(struct clk *clk)
 {
 	if (clk->id < IMX6QDL_CLK_DUMMY || clk->id >= IMX6QDL_CLK_END) {
@@ -35,6 +40,7 @@ static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *const periph_sels[]	= { "periph_pre", "periph_clk2", };
 static const char *const periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m",
 					       "pll2_pfd0_352m", "pll2_198m", };
+static const char *const ecspi_sels[] = { "pll3_60m", "osc", };
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -78,6 +84,12 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_mux("usdhc4_sel", base + 0x1c, 19, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 
+	if (clk_on_imx6qp()) {
+		clk_dm(IMX6QDL_CLK_ECSPI_SEL,
+		       imx_clk_mux("ecspi_sel",	base + 0x38, 18, 1, ecspi_sels,
+				   ARRAY_SIZE(ecspi_sels)));
+	}
+
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
 	       imx_clk_divider("usdhc1_podf", "usdhc1_sel",
 			       base + 0x24, 11, 3));
@@ -91,9 +103,13 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_divider("usdhc4_podf", "usdhc4_sel",
 			       base + 0x24, 22, 3));
 
-	clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
-	       imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19, 6));
-
+	if (clk_on_imx6qp()) {
+		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
+		       imx_clk_divider("ecspi_root", "ecspi_sel", base + 0x38, 19, 6));
+	} else {
+		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
+		       imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19, 6));
+	}
 	clk_dm(IMX6QDL_CLK_ECSPI1,
 	       imx_clk_gate2("ecspi1", "ecspi_root", base + 0x6c, 0));
 	clk_dm(IMX6QDL_CLK_ECSPI2,
-- 
2.45.2

