Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69530CF3962
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86023892C5;
	Thu, 19 Sep 2024 19:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SjQT2Ajq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F08A89219; Thu, 19 Sep 2024 16:45:21 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425E789205
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=konnorrigby@gmail.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39f51934f61so3581415ab.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726757118; x=1727361918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XmgcboKqjwVvcT4k8lid1BzjtMvSWQERJjFm1cYeYdg=;
 b=SjQT2AjqWuosq0hlwSR1lNVjvfS1zps4wl5uFUnDFNg9WR7fW9DChLz2GRr9BmSD3I
 5+xZbcMklVRiNcgzJuyH6IjvFFjBt5WCS/pa7+xZs48G2sHcYrB1sUOfhrJXlkCsuO7e
 MGCmN5L4iJgMszF9s2c6m9ldZcuxp9EZiMTOHRlZKvn8T2wginaW1mF1haCmAEyHBjUd
 7WxKrHikzH1aktB7w1dcn+FMvkFs0VguipSkGvWH07sf5cQMfeLy/Gr4l3Hqw3yRTX1m
 5mXbBdZrwaBbsHb683tx1g/7L2EWh6eKojgoZNiuVpsFG0XrFguQMRQ+JUwdiR8reHdn
 t1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726757118; x=1727361918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmgcboKqjwVvcT4k8lid1BzjtMvSWQERJjFm1cYeYdg=;
 b=RDBA9Xrs3ALMzbw/vQgWpQTdZMu71gBn4slDj2wqlj21yRGGN340BtXl0pvwl8xHj6
 2c/pCCCVqnhiFLgK5187jqoe4P4RXKGw8btM0VatF3krNox0VQqT5PFBlGkCo852rmWv
 jsuiS3rTMb5PxFT7CykYIoIK+0TIbOghYEAs+4gWgy8BF0gvd9Gz/LBDTbMPWdEhbMfV
 ssfbC+nNCB89PPxBJba1ZLMKscophexhYtUBBu4qiAIyC2rQ1q3xMMbiMjbUMeHgHgiw
 tX88V+i3ay95cyzkRK1QcNGnldCmgnn+WXmPy4aGpQJ4chyOIHZodzgTR4gPtWOKZscn
 rL/g==
X-Gm-Message-State: AOJu0YxYMlR11QQAKVG+FvU0egy/wzC28pfUSFlLus/SFqK0rE75KtIR
 3zmn/+KUdbTB5LKwSNl6zkNUk+MaiVd23cCop7a+qvltrZjJqNrf76ML4wSN
X-Google-Smtp-Source: AGHT+IFzoQi0EuoFEGUoFSB3zXGZOTPbp4+YbXzT8tNKAHRR41cI2rNdWEmG9HSpIqSnMXIUkprXrg==
X-Received: by 2002:a05:6e02:1543:b0:39f:36f3:1957 with SMTP id
 e9e14a558f8ab-3a08b6f7e96mr206683655ab.3.1726757117741; 
 Thu, 19 Sep 2024 07:45:17 -0700 (PDT)
Received: from connor-server.. (syn-068-189-053-090.res.spectrum.com.
 [68.189.53.90]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a092e8fecasm34876145ab.80.2024.09.19.07.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:45:16 -0700 (PDT)
From: Connor Rigby <konnorrigby@gmail.com>
To: u-boot@lists.denx.de
Cc: Connor Rigby <konnorrigby@gmail.com>,
 Alifer Moraes <alifer.wsdm@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Marco Franchi <marcofrk@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: imx: fix board_mmc_init for google coral
Date: Thu, 19 Sep 2024 08:45:07 -0600
Message-Id: <20240919144507.249682-1-konnorrigby@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Sep 2024 19:29:35 +0200
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

This fixes a typo in the mxc_get_clock function preventing SPL
from initializing USDHC1 and USDHC2.

Signed-off-by: Connor Rigby <konnorrigby@gmail.com>
---

 board/google/imx8mq_phanbell/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/google/imx8mq_phanbell/spl.c b/board/google/imx8mq_phanbell/spl.c
index cfba9300dc..2786584eed 100644
--- a/board/google/imx8mq_phanbell/spl.c
+++ b/board/google/imx8mq_phanbell/spl.c
@@ -101,7 +101,7 @@ int board_mmc_init(struct bd_info *bis)
 		switch (i) {
 		case 0:
 			init_clk_usdhc(0);
-			usdhc_cfg[0].sdhc_clk = mxc_get_clock(USDHC1_CLK_ROOT);
+			usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC_CLK);
 			usdhc_cfg[0].max_bus_width = 8;
 			imx_iomux_v3_setup_multiple_pads(usdhc1_pads,
 							 ARRAY_SIZE(usdhc1_pads));
@@ -112,7 +112,7 @@ int board_mmc_init(struct bd_info *bis)
 			break;
 		case 1:
 			init_clk_usdhc(1);
-			usdhc_cfg[1].sdhc_clk = mxc_get_clock(USDHC2_CLK_ROOT);
+			usdhc_cfg[1].sdhc_clk = mxc_get_clock(MXC_ESDHC2_CLK);
 			usdhc_cfg[1].max_bus_width = 4;
 			imx_iomux_v3_setup_multiple_pads(usdhc2_pads,
 							 ARRAY_SIZE(usdhc2_pads));
-- 
2.34.1

