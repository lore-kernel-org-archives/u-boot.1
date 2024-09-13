Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0103DFA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A0C288CA2;
	Fri, 13 Sep 2024 11:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LRlZI45H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7746788CEB; Fri, 13 Sep 2024 11:57:11 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBEC88C70
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c3ed267a7bso2165562a12.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221426; x=1726826226;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DayMO+BG8fGqGpPxigAvYP6Gde782r5ZKw0Wsq4LiYs=;
 b=LRlZI45HC8Klht/Zpta5BfATOSVxz2egQwrNFT8oi2bCS9L/WhRWPHVVzqNjCF9Pe9
 zT7hn4y1eTaC89c7DYcSwh3764M8s3htphDnQcatR45L4JDJym8UkwJlyCl+q76uWsVt
 WnPs1Q7za+R5I33TfcCeJ9m4P/8rQXRrSqPis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221426; x=1726826226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DayMO+BG8fGqGpPxigAvYP6Gde782r5ZKw0Wsq4LiYs=;
 b=sIY+4iaPNMr2t6K53mpATN5xBQqvs20aPnBirQ4rkQoVN9m7y/U4PVkNK2u+pXe0OF
 RjLwX+naqejZRXevrQ9r/PcAOpA24bYinwEL4YacLrqGgLofYSO1mt56oNBeCaRVmFz9
 Y5DMKWgzQmoLL8o5O9m3lAdI7XQT23dQZD4Iao+NouyctX5E5vdQonTG4czRMWxOvdG5
 BOI1q4+22qt2Jnylz2a2kn23cAJV5qn3LZ7W9mw6LOuNif/k1yMqSAxe4ZDHB87QSlSw
 or1kgRcc+ukb9yU6O5xElBqXOPIvi1Kz4pCsEv68fQSnlzFyTVpiItEsOSrk5rcfR5N2
 +MYA==
X-Gm-Message-State: AOJu0Yx7E+26yVg5gUH4/fGTPz8Ewnio/B9Wlt5o8g8K3EKt13DK1xJE
 d2JXCJ/CN90wgXrYDRhQYf4LTlTaoIWPyarl9Mp+RVb8YSzuNzXFudF5Smce6JyriFeqLDCI/wZ
 WuNk=
X-Google-Smtp-Source: AGHT+IHcRiC9nWDABlPykP905y4RAPCghraZ9tK/U2Gmq25uBVJ3Lzi6ZuQRA2OOPGoBHX8+GnkAIA==
X-Received: by 2002:a17:907:f747:b0:a8d:6921:e181 with SMTP id
 a640c23a62f3a-a902943273bmr496515866b.16.1726221425488; 
 Fri, 13 Sep 2024 02:57:05 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:05 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3
 as enabled
Date: Fri, 13 Sep 2024 11:55:47 +0200
Message-ID: <20240913095622.72377-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Both clock are enabled by the bootloader and we need to increase their
reference count to avoid disable during reparent operation.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/clk-imx8mm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 432348a15cad..0e71ceefe96c 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -176,6 +176,8 @@ static const char * const imx8mm_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200
 static int imx8mm_clk_probe(struct udevice *dev)
 {
 	void __iomem *base;
+	struct clk *clk;
+	int ret;
 
 	base = (void *)ANATOP_BASE_ADDR;
 
@@ -458,6 +460,13 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MM_CLK_QSPI_ROOT,
 	       imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
 #endif
+	ret = clk_get_by_id(IMX8MM_SYS_PLL2, &clk);
+	if (!ret)
+		clk_enable(clk);
+
+	ret = clk_get_by_id(IMX8MM_SYS_PLL3, &clk);
+	if (!ret)
+		clk_enable(clk);
 
 	clk_dm(IMX8MM_CLK_ARM,
 	       imx_clk_mux2_flags("arm_core", base + 0x9880, 24, 1,
-- 
2.43.0

