Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6299FFC981D
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 09:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A3783D17;
	Mon, 30 Mar 2026 11:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oHo+FOqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D6B80212; Mon, 30 Mar 2026 09:59:56 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4781C80212
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 09:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so40525945e9.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 00:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774857594; x=1775462394; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/es7CKprRfE8VJ85lgkCIhBeopC+/aYsmrInMfp/JoU=;
 b=oHo+FOqT71+AqEfMK9W8ZuSLrpwkHGf0x3nCkN15EaqwBecb0BA63/OhtAS6mRcNzJ
 fJEDwbue52dWTmCr9/pbWvRYIGFSDXlEzGs2ZZr6+pFyaMxdV6UbEJ4lmVjP+er9cn6B
 ZRVsoLzoxLaqfyOxM/QI2eA0GmNPDD7HvFRYMqZMe9XUTaDJqvFhKQR7ixHsRaoEUt0v
 IO4IXeqxBDJFqURzv67cPUFsGlJH7I7bdz97RY7+P2E0Nxe+aWDscX7laNoCh6HqP0T4
 q8ZLbnnVLZTOq+ZO/K12W1GAyzh0+CVik1pWFGMw6xFjpzr/UkQLyR5dbO5/KFuUcYoh
 4gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774857594; x=1775462394;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/es7CKprRfE8VJ85lgkCIhBeopC+/aYsmrInMfp/JoU=;
 b=NMMZK8VfDksCMsyXFrGhvmOk1X2qBvQUy445zXi6FosaOySgTCk2IIGwtq3uoAn58g
 iU9Gcj9idZ7tz2lFQUtc+tNZf4n1OTdpq9Ruew8/EW5yIIG79dMsB0GLcjos8W7a8aPb
 CeP2vvv+e7C4x9DkwbQFap0IEQ1MEjL+B6dQHszmLDEDOVNLfm7YvhvnH/+6ZArtpJFr
 nnlPBG+x/kxi0Mwe6B28Tz19hdQpv8WsYhQ1gpaw26GOn2gg7PsDynUoBEnerrhtAQpW
 RI0mqc2DG30h7f5UQkgUnfCICHY8GckOjAugnu1JwXu9lnmbKjQNFmTKAOY8yBQyEfu6
 WjKA==
X-Gm-Message-State: AOJu0Yz/iTybWw+a1JfJnYlLfx6P5Zl1ygeALdAEOP4zmziIaH45dvoK
 suOhQao5cL94AnCpJO1+EM+jgWM5j5NGc6N2Qs5vv11UcM4+WjAkOss7
X-Gm-Gg: ATEYQzzpy8QpfAx7U9zc/pYWinaS3XT/o+ZMb24OLT+zYfgzcwkUSmcM4k25RtSaRnw
 Zthwee5Uxh6oZHZsci6zxEWtn+/noduz01ogFZr8LyqPmeFMHeWxhxa8eQjZghyYAgAImB6jTuU
 jIJl9+7PDXA9gDmcXkqH88482lvZ/Yzh0Nnbj1w5iNxmSP0h/JSPT1Yc5dMartHjOsHLbmS3a6K
 aUoqP8wuuCDjuhkQp0OJcz0clrPMZIkUOqkzTrix7VQL7F489eS1cW3ztjdLLltExsbTPUIEVSf
 k1zS4CNjjT4Jr3ZlZaHUN8ad60S0msK1x52pbQrh0jRrVQ2/HUpiEO5BXkY+OQjKXUCPdTRARiv
 /Mnoy8L3agOOIxFy4LqcXzVGXsSCG72NL751wA7mruQt/4dAY/ZwWlBC4jblDrdcfXiuTYXYsoY
 tFxhr8X6K2gb5nQmufKmsWPnFvmr7cP4hhugJsgNPDl5sWjY0ExCMDEoVQwyKyA0EWuuvlilRpq
 L3p51oFE2C5/E1pPtFnPVD1MwpGQNqoZkHBfk8NyWaZajnlNqb7KidXUYmq5LYi18V4P1eF3/sH
X-Received: by 2002:a05:600c:46c5:b0:485:39d1:b4dd with SMTP id
 5b1f17b1804b1-48727ef0bcemr202413595e9.10.1774857593429; 
 Mon, 30 Mar 2026 00:59:53 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d49c18sm257298055e9.14.2026.03.30.00.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 00:59:52 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Subject: [PATCH 0/2] imx95-toradex-smarc: Migrate to OF_UPSTREAM and enable
 GPIO_HOG
Date: Mon, 30 Mar 2026 09:59:40 +0200
Message-Id: <20260330-smarc-of-upstream-v1-0-c5b8cab32a22@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGwtymkC/x3MPQqAMAxA4atIZgNtxR+8ijiUmmqGqiQqgnh3i
 +M3vPeAkjAp9MUDQhcrb2uGLQsIi19nQp6ywRnXmMq1qMlLwC3iuesh5BPGznaRWlvXPkDudqH
 I9/8cxvf9AMYgqu9jAAAA
X-Change-ID: 20260327-smarc-of-upstream-f818fe7155ac
To: u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Mon, 30 Mar 2026 11:00:28 +0200
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

This patch series migrates to OF_UPSTREAM to receive automatic device 
tree updates for the Toradex SMARC iMX95 and Enable CONFIG_GPIO_HOG
to apply gpio-hog definitions in the device tree.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
Franz Schnyder (2):
      arm: dts: imx95-toradex-smarc: migrate to OF_UPSTREAM
      configs: toradex-smarc-imx95: Add gpio-hog support

 arch/arm/dts/imx95-toradex-smarc-dev.dts |  277 -------
 arch/arm/dts/imx95-toradex-smarc.dtsi    | 1153 ------------------------------
 arch/arm/mach-imx/imx9/Kconfig           |    1 +
 board/toradex/smarc-imx95/MAINTAINERS    |    2 -
 configs/toradex-smarc-imx95_defconfig    |    3 +-
 5 files changed, 3 insertions(+), 1433 deletions(-)
---
base-commit: 80a4c49a4ab2ad06fa84a8b7bdf6e33b3b5101bf
change-id: 20260327-smarc-of-upstream-f818fe7155ac

Best regards,
-- 
Franz Schnyder <franz.schnyder@toradex.com>

