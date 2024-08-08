Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6DDC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D7E88C44;
	Thu,  8 Aug 2024 05:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zwYTwJKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C9A88A34; Thu,  8 Aug 2024 05:15:21 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C1588C1C
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5d5c7f23f22so297675eaf.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086910; x=1723691710; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJSCepS5zMEk/aEHxN7GgskRjPtUAinU5iuesTC8YmY=;
 b=zwYTwJKez4AxsIeS6mu7ZR7U1zd3vtqHYNPyqdT3SZ3Talt3lrBu/jMjOG+L4J3p7Y
 acdnj3JTVIOVhOF/lOiyaXgQaCk+2ZddKCK4WYik+u0pf638FH0wDcCtfnWI3fW6Go0Y
 inhQ+him99t5/AuaWSssFqYCSdej1H86lLz2TbXFocBdhnBXUWK3FAe5cs4qXvwzVjYF
 JEsrMsqMl4YZN8GHmpx/S0G1L3F4O+E7I8G+XRVC8nzbAGj/Ei3HtZZclZsTjHd9Zh6X
 fScLupLv32g3Vab48whkI4edN6gdqLHjrK38GoAe6VdsPVjU+/LiTwnTdIQ/+HTDLK5h
 tANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086910; x=1723691710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJSCepS5zMEk/aEHxN7GgskRjPtUAinU5iuesTC8YmY=;
 b=sPVsXrkNrETNr7Tc8MwUoI3KnyQe13Lu3glyhzGLf7LReslhcogPVzKP0Bhx8QfEeo
 cqq+hFUq6TDJMPUXMUr0ExzYNa9Kh/TCWosHhP45bsev4ssucnV6iHgtwMPGPrCmaO8G
 VGQ/Z7Zak+/ht6oEMDY+Vs8JT8jP98KzwDqLQxBfAhNDKwjW5bAJqVgCuJaukbDRvNvk
 UAJ0GGg2+eNgtvRgK2eC+ez8BjtKRPbdkMpNAwEK1er0wZiKmeW7r57QvBuBLjVMYJzF
 NdmLr4J22aBft8Bwvd7pZ6l7slrdNrvR5QnRdwDIhQY2NJBPtO9PAFgetk4ob+gfxL2e
 Hycw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU3HwVk4VULOcpAquC6hcd7ewDvfluJd/RerHLvRzjSP1htcynRY1urSnuQ0fdPG45oe4hDKOU6WV3hgO28js6YkJB9g==
X-Gm-Message-State: AOJu0Yzna0lEiCWMJLWxfKYc3Jjn7OpVm7w4CyzZe5TDqEbsXHRLo/3P
 qk8+HgfRBCER1ZXQbDfAf21PfIF9EaXYzJ0YKs1WfULkAkhYsrDvgizbxXnw8Rk=
X-Google-Smtp-Source: AGHT+IFWP4MAKy9RSrquzx+qgEpn7SdoIDWIYpeJe44SRde5aBq/q4TmlR3o2TUvpLoogaAHlv8cMw==
X-Received: by 2002:a05:6820:1e0e:b0:5ce:d2e3:b18 with SMTP id
 006d021491bc7-5d855c6e599mr551553eaf.8.1723086910240; 
 Wed, 07 Aug 2024 20:15:10 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d76261a27fsm3523707eaf.39.2024.08.07.20.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:09 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 34/38] mmc: exynos_dw_mmc: Use dev->name as driver's
 displayed name
Date: Wed,  7 Aug 2024 22:14:40 -0500
Message-Id: <20240808031444.9619-35-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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

Reduce U-Boot footprint by reusing dev->name as a driver's displayed
name. This changes boot device name (and "mmc info" output) from "EXYNOS
DWMMC" to something like "mmc@12100000".

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 43111b749a6b..a9e240fd91d6 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -327,7 +327,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		       "continue anyway\n", host->dev_index, err);
 	}
 
-	host->name = "EXYNOS DWMMC";
+	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
 	host->caps = MMC_MODE_DDR_52MHz;
 	host->clksel = exynos_dwmci_clksel;
-- 
2.39.2

