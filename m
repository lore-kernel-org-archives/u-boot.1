Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C3D0D7AB
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4AA389386;
	Fri, 11 Oct 2024 16:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oNrVN3Sp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B8289380; Fri, 11 Oct 2024 16:50:05 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D952B892F8
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fadb636abaso20617431fa.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728658203; x=1729263003; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xpxk8zWtiiezqa9rdeiLgwUHWEFbvu+/7Ih6E577aIc=;
 b=oNrVN3Spw47NUDR91/lVpmJplqzND3YrcLO9qmzrT2qMaJxMvJUCoC+mODAZrPDHbd
 Ilw27N9BHgMWBmcb6UnmtKKmMszAQO1FTX9yORbOYYHPJL2plOoQmbKsikVc+zGdk/Js
 QnrfwH7ZJkqLz+GMHOM2DD922xXaZBAf9NVUUeT0G27Fbz/XZrUsZAxaqCwmq+6caxI5
 +l6XQfcl8M9jkFAodkaItrPLnY4PnkhkturZfGBdMEjba/h2uV22ON7Q1CVfrkQnYXcZ
 tY35ZultsHV1tpGUHuXbxaL3Unn//zV1ftH8hpnTxUw1qwcZAyIiCBsf3WiTR2IRx7N6
 eUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728658203; x=1729263003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpxk8zWtiiezqa9rdeiLgwUHWEFbvu+/7Ih6E577aIc=;
 b=lfEmiwfStOwcoRYk3CA8wnwyvNq80Ug10jrJOqfBD9Ma8GjzBAxWW5pzJYiuZvOLYH
 FeFtox1dh0aNiaikA8opujdX+sYY9ccqI3G7Y0g6NAYset3b2baDXE0XrRhRiYGx/30d
 0FK3QYGG3TV6E+gZFIoHVjA9ztluBWaGhm5IaRhQQZTfxuvN1PH9s4pMINP98Q5iFXK1
 VLIWVSyrFLko0KWvoexA0ikBSWGigTmoH+4QMyj12+gjftUcANVHjofIkAStelU3/s49
 er4gzpr0apfkF45RAzQ22/a0fQxoSuLmZ5MWE0FYcH1fGqUYx6L7nTlc2HCczHexZx8L
 FSAA==
X-Gm-Message-State: AOJu0YwV3v3C8PEqmQbn0ve2+e75Bor6vrOh8j/etaDN2wgFp6I7OPxQ
 wFlGyVrc1+QT4S8me9SQfAD5w66LPQUTk3mOEyUMc8qOGYdtu1OdikaxzLV1bq8=
X-Google-Smtp-Source: AGHT+IGFQyJfFpsFpAosWUH5D27nZxTYoEqe/lG8JbJMQuqRgISeQPuoH8lSLtg80d7fJ+ZXz5upzQ==
X-Received: by 2002:a2e:be05:0:b0:2f4:5d9:e8e3 with SMTP id
 38308e7fff4ca-2fb3274036emr14865961fa.7.1728658202945; 
 Fri, 11 Oct 2024 07:50:02 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9372940e3sm2006113a12.81.2024.10.11.07.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:50:01 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 16:49:56 +0200
Subject: [PATCH v2 3/4] board: bcm96846: Enable NAND options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-bcmbca-nand-support-v2-3-1fe928e5b933@linaro.org>
References: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
In-Reply-To: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
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
index ea643eddcc66..2f94bd295122 100644
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
2.46.2

