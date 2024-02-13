Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F486C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B423687D7F;
	Tue, 13 Feb 2024 12:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJLk72Ro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E1F887D65; Tue, 13 Feb 2024 12:44:01 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B06E87D5E
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 12:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d748f1320aso3253195ad.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 03:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707824632; x=1708429432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37FR03HPlfBGByQbFjivbu6zeLVYs0/CXtpXae2sf8g=;
 b=HJLk72RoCjvje6juPpb5mthq46oSnKdiSi0e6gfsrI5yIrjSasxYM0UXOs73xGutwB
 2GFdaCIZnjoAQyGQaJqgFNixV23xyQe00I9FPtLr+Nb4fNjH7ecqzN8GRzALsYoiqPCL
 kAoScClJBWoL95K90mJCz5VEVkCHwfRuUn1NWPwrtNSFf22pcfe96tCLcCWRhsA9XMoH
 DMo4dcniqVov56/g71xpV9p+igd/i/L2UTbL/DYLQkrLjn83x4xdkNBGYsciJvdFEzNR
 daqQ7KW9kJ4r4edIEGv5gl5L41Ojv8gKp/ewU6WuaVaiswN+kN5mCi+fslG2wd1goAWj
 h/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824632; x=1708429432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37FR03HPlfBGByQbFjivbu6zeLVYs0/CXtpXae2sf8g=;
 b=KjL27n/uYuyABOvRT5dwYf4aSJkCvLrOS66vr59kNwqkDI4fmbYpC1M+qHVoz80rzk
 sKz6PW95grXmcGksuHDDsVaiYhUZo6qHhxuhHk1FSGvXoHwwdiH9aXtmwsF9vQ+1cVvP
 Ww7E8dF8UHBNaEIyRxUwIvn/xx7QqOnHVJ971KK9asxq6cKQfEdBPpH1RZeAd292BKUx
 FdAGQ1t+t5KkRsk3gpKH6Jfi6z2QEGhRkChS56r15vynmCei2AkxabL5O3r4PIKqEIPZ
 eQn5SCXBwM0k5aIjIUbmRKfMC6Xna7V0XgXoxC25g30H7LpHwbOJM3GPuFBXodvvuxNd
 lhiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa7HYGqbw2iauA7FnqoITy/MMwdLPAciYFclrbbrY+tpKdt+1aAerwjw5/3OKa2Lg397gzufoC89CThznX2e1wR9n4pw==
X-Gm-Message-State: AOJu0YzOO/w9CdIfwC5GjZb/BkirhsVJprogmtZW/xYG/u9S7/5K5Rqk
 /Th7WI5bR5UqwxtOZlJRuuK6Rd8kGTkQmvc5XHiVaCEKwWjL8J8u
X-Google-Smtp-Source: AGHT+IFw/LEyMzccJU1Bq6RUe9LrEK0x11EMiMCe55ZSyHLPAmAzjBJOsbHvho4aXCCv9PDMPxKzNg==
X-Received: by 2002:a17:902:b68e:b0:1db:35c3:87e with SMTP id
 c14-20020a170902b68e00b001db35c3087emr1338394pls.3.1707824632447; 
 Tue, 13 Feb 2024 03:43:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX7rN8j7iFW8ovg7mw2kpza5tz4JhA0LGhwcAuGabeN4asSX2IE6rU+wgMnun6O/N3Ju9EfZxYx6wXlGeEu8ptEgiz7+vQlP1Rd1KoG5j+cnpSFmCx5lyfJxc4kjIohOOBUztTQZNikMDo6bpId/THni8M=
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c0bb:2b3:6958:833])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a170902f28500b001d8f0e4bc32sm350795plc.144.2024.02.13.03.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:43:51 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: ian.ray@ge.com, martyn.welch@collabora.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/5] msc_sm2s_imx8mp: Make Ethernet functional
Date: Tue, 13 Feb 2024 08:43:39 -0300
Message-Id: <20240213114342.2728075-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213114342.2728075-1-festevam@gmail.com>
References: <20240213114342.2728075-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Currently, the Ethernet ports are not working.

The Ethernet PHY reset lines are controlled by the TCA6424 I2C GPIO
expander.

The TCA6424 I2C GPIO expander is supported by the CONFIG_DM_PCA953X
driver.

Select the CONFIG_DM_PCA953X option so that the Ethernet PHYs can
go through a proper reset making Ethernet to be functional.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/msc_sm2s_imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index 9c27a72f8a..a190c1ea22 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -72,6 +72,7 @@ CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_MXC_GPIO=y
+CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-- 
2.34.1

