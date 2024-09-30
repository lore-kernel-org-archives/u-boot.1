Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E192CE8340
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B0AD88F95;
	Mon, 30 Sep 2024 15:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mGnRcC8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A84F88F32; Mon, 30 Sep 2024 15:25:08 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBCE288ED7
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539908f238fso1503398e87.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727702702; x=1728307502; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Say+sXgvW1lTH9c/wxRnHBVVnzUBjmHWb5NTEEpJus=;
 b=mGnRcC8ka3UzfIR6M2kyeNjUZfkrI1YLna96L9wsa2tjq+V5bUFlqm93hZncatjbJ1
 EKpMR0zcaAnLqrgCzj39vfT2SN8Y7IEgMVVib6i/z6nVdcoZmz+wynliu9iqAPcQcgxJ
 eI9gO0xvUVEqgA3aPspeWwbQ2iGOJCo1g2ZjCrqessHH+/OI7LAfk5Hcb7MVuFm146qh
 GB/GysAn4lhlReSsj3i9vDVVpJKsbrt9aAig0+DP6oCaVhDylLNSv+rDVmEUKdRQNR71
 ZekO97cDt6Gkgnp/PuV5Dk8BRYJEOj/QPqAb2MApsHJJa6RHhZG9uB9+NHQKN5CYNy8Z
 J+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702702; x=1728307502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Say+sXgvW1lTH9c/wxRnHBVVnzUBjmHWb5NTEEpJus=;
 b=bM59E4Ay3/E4474ujZoUAUu7/AJXB4Zbl2JUTiyOKXCwj8oXjd8aasnwAgw8gHJU60
 v5aM8HfLF6ASl7AhlGSjz7UwAOAchimwTQAkPzvQwg8zICw8K7tACLEKgcJbeJo2m+02
 4jg9V+Hmdr0BLKWQuPR+q64MJ6cdhdYIxAYkCYpOw5izNKJgbgHFeYdMs6ZC3+wZm2Lm
 PAdADv6yyqXfkPrNGEBIdi+MK6Glwf/HNdVAhFG8v0vcOQEXoy420t9lW1/k6CFBiAMc
 PRWAUVTsPp6/gaMIXh16hJaJgKonQr4KtuZzFSPJlt/FOtfFviaKOhmK3j9Z2mJYn25a
 L6Hw==
X-Gm-Message-State: AOJu0YwtiLSo98tRnIb0PB95QsuFE6O2mKqoxlaoqB35U7oAOUYRCS1p
 whyVjp9qk6eJpX1o58E5n9BLQixdU0akPwKmdeIQyOWGClW7M4UwXyO5oKOXMmU=
X-Google-Smtp-Source: AGHT+IFptba6XfqN+ZbsmgdFhMixzBsuMAClrVBxwcj4qoPa53Xbsx8pURxBXZdD2ulgNgsxwmDG6g==
X-Received: by 2002:ac2:4f01:0:b0:52c:df6f:a66 with SMTP id
 2adb3069b0e04-5389fc858f5mr6137468e87.58.1727702701850; 
 Mon, 30 Sep 2024 06:25:01 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c88245fbeasm4484786a12.54.2024.09.30.06.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 06:25:01 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Sep 2024 15:24:56 +0200
Subject: [PATCH 4/4] board: bcm96846: Enable NAND options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-bcmbca-nand-support-v1-4-e637c65de947@linaro.org>
References: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
In-Reply-To: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0
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

This adds reasonable NAND options to the BCM96846 reference design:

- CMD_NAND, MTD_RAW_NAND
- Disable SYS_NAND_ONFI_DETECTION as this just give error messages
- MTD, MTDPARTS with DM and related config options
- CMD_UBI and CMD_UBIFS as this is likely used with ubi/ubifs

What I didn't add was something like the following:

CONFIG_MTDPARTS_DEFAULT="nand0:256k(cfi),257024k(image)"

Because I don't actually have a BCM96846 reference design. These
are only available to Broadcom and their customers  I think,
but perhaps the people at Broadcom can provide the detail of
the flash layout for BCM96846 so we can add this too so the
bcm96846_config is usable out of the box.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 configs/bcm96846_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configs/bcm96846_defconfig b/configs/bcm96846_defconfig
index 467f4de439e3..4d8767dbb41f 100644
--- a/configs/bcm96846_defconfig
+++ b/configs/bcm96846_defconfig
@@ -18,5 +18,17 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_NAND=y
+CONFIG_CMD_UBI=y
+CONFIG_CMD_UBIFS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_EMBED=y
 CONFIG_CLK=y
+CONFIG_MTD=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand0"
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_MTD_UBI_FASTMAP=y
+CONFIG_MTD_UBI_FASTMAP_AUTOCONVERT=1
+CONFIG_SYS_NAND_ONFI_DETECTION=n

-- 
2.46.1

