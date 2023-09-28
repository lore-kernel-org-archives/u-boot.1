Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF82ACE7B0E
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6547086E3D;
	Thu, 28 Sep 2023 11:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uXmiiA2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7168686784; Thu, 28 Sep 2023 11:08:12 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76F286E30
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so11184134e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695892088; x=1696496888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhtpgkMV/3aq4wwpo2D6YCZZO9b3KYPcI68CRJRMN98=;
 b=uXmiiA2dGAnOjIPaL+5ey9obAvh/whxjw7Ekc6Lqry0LKn28iZwrs0ISCHvOmRuLos
 XIlg3gsf3ww3KaCMqJe7kytmEXSay6br4c7ct4YYPsVcw424VXgzG2W6U/xxvJL4d2Yf
 AklEs7UtKZOsgWmua0yZNqQD7fa77w/dhtqUuP0KynD/LrnaQ6JhOxJSmUbWGM4qSo5L
 Y403xXTaFxYHpRz+hPwSpn5I4u4BV/BWgbHnSIIU+UhM5aSCBFde8xmQTDe+UWoK/SWf
 fkeD3T5tlqSUG1CbsjNyu7Bkd6dOD+z8Abk0PkhsKaN9bRDnS7LBR/b2P3sCS0YpXaqX
 pfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695892088; x=1696496888;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bhtpgkMV/3aq4wwpo2D6YCZZO9b3KYPcI68CRJRMN98=;
 b=VOC99ObNqldi+0ZUSKe+6XEZQ2UYdu/htOQDSmlINgEdtLOp9p9ZHD+jvYKdUAhpeE
 KDhWhnS3Bskm6vWIImfwJ2Jv1UKwJ5dGM7tvdEQvobdCAZ4EogUqNIVzY7SLgi9lytO7
 hLaxyX1wVERU5CeJTpLuW/NcLqrMh2wddh0qJnOl97JKgDXbOF2P5QKaICX1dzaXWCqv
 4YmuFsxIoomzEcdLBG6up05H1AALeOknGnd1RTM/j54qlfvipm2kwyH2e2P7bxaQFzdY
 xS2rBGN/cNEn+OXYrl+ssTRlNJuMMcb57RUhU6TOmACtaq+FzR3ukqyqPA4jCs15Bd1x
 sc/g==
X-Gm-Message-State: AOJu0YxZ0fVRWi8u5Z11N5ixrbyng8e1GLE/bIuaiuYzarbc02N991j+
 hV904aX3FvlHsb/TkRyX9AFahw==
X-Google-Smtp-Source: AGHT+IG6uvMvtIaxdkicn30piqPnKdj+3HMQD+2ApU+5MvZzI6uYAxgobmIZNJ6WxvSUBKxcQ2AFbw==
X-Received: by 2002:a05:6512:110f:b0:500:99a9:bc40 with SMTP id
 l15-20020a056512110f00b0050099a9bc40mr728296lfg.69.1695892088337; 
 Thu, 28 Sep 2023 02:08:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a1c7911000000b00406408dc788sm4394846wme.44.2023.09.28.02.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 02:08:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20230925155209.130671-1-ivprusov@salutedevices.com>
References: <20230925155209.130671-1-ivprusov@salutedevices.com>
Subject: Re: [PATCH v2 0/2] clk: amlogic: a1: Add Amlogic A1 clock driver
Message-Id: <169589208750.3562382.6261825128142750127.b4-ty@linaro.org>
Date: Thu, 28 Sep 2023 11:08:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

Hi,

On Mon, 25 Sep 2023 18:52:07 +0300, Igor Prusov wrote:
> This series adds dt-bindings and driver implementation for Amlogic A1
> PLL and Peripherals clock controllers.
> 
> V1: https://lore.kernel.org/all/20230917101308.1250-1-ivprusov@salutedevices.com/
> 
> V1 -> V2:
>  - Add more verbose comments for driver
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] dt-bindings: clock: Add Amlogic A1 clock bindings
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/afc86079bff6e2f70df3eee9c2c30be07d9f7082
[2/2] clk: Add clock driver for Amlogic A1
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/def23a39851d52cadd29854a33e3db29ee4a6d26

-- 
Neil

