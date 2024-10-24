Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6CDD0BB6A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 07:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7005289266;
	Thu, 24 Oct 2024 09:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FaCMiaHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0000892F9; Thu, 24 Oct 2024 09:43:05 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E856688BB2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso8081615e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729755781; x=1730360581;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TODPMX0o/rEzxeqWSlfYvsqyIZBuow/ww9HT1+B4an0=;
 b=FaCMiaHLMWXascksWhtqneaO7oJdEvCT1cXPHWZBKJpts1H+ZsCNCmT+SLAESaxaHb
 OKodPnYfThicLxvJlL35MB97cGQiyrlbWiEgf034783Q7U/bn3MkqJEXNweafYkAsFm7
 G/lXgPogHAWJ3lzPWEy4yJWmvSbLoq/1o3ZzMu1ZC1POGQL9SrEuVZDVadwCAC9jbdOs
 U34tUJO6bkqzsff7DUaFSW/AapOsAS+9ntT7rxGm3VYEuLAjgKoyinTi+rzaR0gBNMPs
 y7gbhs+XujclrXqkWB5ycQrsqwlpGVzK7WkYfbDAShm6o9DCAkz8sCgaR7H+Y5HvbPaT
 LPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729755781; x=1730360581;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TODPMX0o/rEzxeqWSlfYvsqyIZBuow/ww9HT1+B4an0=;
 b=DoxM3V4MIZj8L1XrE2K4WVWB41xFgWy/KUag8sHlaqt5tzqXBzzvWGdc0DH73+bB0J
 XXqNLN10Or6owU/cBHb10QOc0jEE7gHONA8wJTlPwdzxB6yTv+YW4DLoSh9Hr2VT4Y5y
 2TRDiZwp+lVHPxrQAYv00EFZOXvd7QLJ3h+N/QlC2q4jSfyUJAQFiUhqGQZPPwqLyO+W
 ttROlQpeHzbjM+lMy38IWvoSjp0emGdjvPwR+/sobg4KMWqubJJoA04F2uj2CsJfmAYX
 V+hwAakEGCd7f9lu1JK53h0JePmw9/rZm63tT0hhmRhL1lw891qPddrq8ywkRxUrIsVa
 vmtA==
X-Gm-Message-State: AOJu0YxI3Zi+uQFp4Rj2OkfaUwESWGo979vobW7/f1f4SB4LaIhqOsrE
 hgLeOspte9Np8AJZdMd3H5zwSfIzzjT50TDFO84H2yw4XLIInxtvNqYqQAtnTkk=
X-Google-Smtp-Source: AGHT+IEh/XJNIM5zmacblAVuulYIDp+7yOJGYxxZAtAS+FkIihs0CuVniLAehF91zOxqfzq5AkWqug==
X-Received: by 2002:a05:600c:5250:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-4318424f1a4mr60451895e9.32.1729755781248; 
 Thu, 24 Oct 2024 00:43:01 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b5430edsm9415815e9.2.2024.10.24.00.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 00:43:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
References: <20241001-uboot-topic-dfu-sf-dt-v2-0-67f7acfa3ff5@linaro.org>
Subject: Re: [PATCH v2 0/2] dfu: sf: fix flash probe when DM_SPI_FLASH is
 enabled
Message-Id: <172975578031.461045.15426683152861781969.b4-ty@baylibre.com>
Date: Thu, 24 Oct 2024 09:43:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Hi,

On Tue, 01 Oct 2024 18:06:10 +0200, Neil Armstrong wrote:
> With DM_SPI_FLASH is enabled, the code uses the legacy
> SPI FLASH code leading to probable errors since it doesn't
> use speed and mode provided by DT.
> 
> This adds the DM functions as dummy inline functions
> to add both legacy and DM support in DFU sf code avoiding
> using #if/#else conditionals.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] spi: add DM_SPI_FLASH compatibility inline functions
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/0872ac098a400632f02ae442dde65d77cc7eb1cb
[2/2] dfu: sf: rely on DT for spi speed and mode
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/97c29f868dd4e6d8f38d1cfdd964fb6b2b40267c

--
Mattijs
