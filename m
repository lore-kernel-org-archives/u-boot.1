Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECB5C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 10:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5A786F7E;
	Sat, 11 Nov 2023 11:46:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ImY/hUbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 546A486F45; Sat, 11 Nov 2023 11:46:34 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02EB86F6D
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 11:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso4468519a12.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699699590; x=1700304390;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScYicUFHb+qoluDbgLSAgAArMfhmqdSv2yQ/g84t7ys=;
 b=ImY/hUbh4sw/O0VHOlOTMSv4SlNt4cemzhFeJBJWwpkVauQdm659ieDeSMNR3vHp2V
 Tsjx6937njwP0LVVLmWuE9cHl/vwmqPpIFvyDkrpDJZ1z73AkB/Ut8IhUHUac9FVR7dJ
 LPIj002VWC1prhbT+zXG30fVxiTSlVCtsYgH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699699590; x=1700304390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ScYicUFHb+qoluDbgLSAgAArMfhmqdSv2yQ/g84t7ys=;
 b=IYXbe0S9R7oTHjJyz4DLApUtG/Sr38RaFOM6W4YuvzM0znRZ+De+81FJgmw0THMxTb
 1v78Ra5dVN1izclvBfOIS/W4/O9BTrcS2/xgpRZpyk2VRRQRd4g7D4MjRCKLfoDrQAtb
 zLIm+Z5wEmoLpswaupuJSJnmyZmIYZsjs97k1ExLfMHsg1Cj+H9fnfojyZ298YC+jvtA
 j3ovzdRVqdZfX5AMwMUyKHIDOnshD2EmFobjIe//RwtblvZqLJA1ZtY5akfUVFTS9mun
 yzgOCoWRe9nuAvYCxC9ome/UgdWjy1LtZNVpiPb9Vtdvv78hmz9neBHpi8nl4oOm3+NX
 oFQQ==
X-Gm-Message-State: AOJu0YxYl3+/r7ueD1CvWRbVTZF6Hr70ztDIMFvLuAZOSZ8NqFJEwTQv
 m7tOtF2C3aIRVSJ91mQQ9BIklS2FFBXiQqxV/yMo5Q==
X-Google-Smtp-Source: AGHT+IEPaTNngDVafeuHj8t4A+vhM0VmSP+1FdOomfw9kd+6vOdUpo7HnD5tHqn+eXIvU/I70aeoBQ==
X-Received: by 2002:a05:6402:510:b0:543:7256:6370 with SMTP id
 m16-20020a056402051000b0054372566370mr1234240edv.23.1699699590143; 
 Sat, 11 Nov 2023 02:46:30 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-20-97-182.retail.telecomitalia.it. [79.20.97.182])
 by smtp.gmail.com with ESMTPSA id
 c19-20020a50f613000000b00542d3e470f9sm827534edn.10.2023.11.11.02.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 02:46:29 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] clk: stm32f: fix setting of LCD clock
Date: Sat, 11 Nov 2023 11:46:19 +0100
Message-ID: <20231111104625.137511-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111104625.137511-1-dario.binacchi@amarulasolutions.com>
References: <20231111104625.137511-1-dario.binacchi@amarulasolutions.com>
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

Set pllsaidivr only if the PLLSAIR output frequency is an exact multiple
of the pixel clock rate. Otherwise, we search through all combinations
of pllsaidivr * pllsair and use the one which gives the rate closest to
requested one.

Fixes: 5e993508cb25 ("clk: clk_stm32f: Add set_rate for LTDC clock")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/clk/stm32/clk-stm32f.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
index 4c1864193357..d68c75ed2013 100644
--- a/drivers/clk/stm32/clk-stm32f.c
+++ b/drivers/clk/stm32/clk-stm32f.c
@@ -522,18 +522,20 @@ static ulong stm32_set_rate(struct clk *clk, ulong rate)
 
 	/* get the current PLLSAIR output freq */
 	pllsair_rate = stm32_clk_get_pllsai_rate(priv, PLLSAIR);
-	best_div = pllsair_rate / rate;
-
-	/* look into pllsaidivr_table if this divider is available*/
-	for (i = 0 ; i < sizeof(pllsaidivr_table); i++)
-		if (best_div == pllsaidivr_table[i]) {
-			/* set pll_saidivr with found value */
-			clrsetbits_le32(&regs->dckcfgr,
-					RCC_DCKCFGR_PLLSAIDIVR_MASK,
-					pllsaidivr_table[i] <<
-					RCC_DCKCFGR_PLLSAIDIVR_SHIFT);
-			return rate;
-		}
+	if ((pllsair_rate % rate) == 0) {
+		best_div = pllsair_rate / rate;
+
+		/* look into pllsaidivr_table if this divider is available */
+		for (i = 0 ; i < sizeof(pllsaidivr_table); i++)
+			if (best_div == pllsaidivr_table[i]) {
+				/* set pll_saidivr with found value */
+				clrsetbits_le32(&regs->dckcfgr,
+						RCC_DCKCFGR_PLLSAIDIVR_MASK,
+						pllsaidivr_table[i] <<
+						RCC_DCKCFGR_PLLSAIDIVR_SHIFT);
+				return rate;
+			}
+	}
 
 	/*
 	 * As no pllsaidivr value is suitable to obtain requested freq,
-- 
2.42.0

