Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A800CD44161
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 14:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD70895B1;
	Tue, 19 Nov 2024 15:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1TKQjA+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50112895A7; Tue, 19 Nov 2024 15:16:57 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E648959B
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 15:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53da22c5863so6027700e87.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732025814; x=1732630614;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xO6iMguNjFQi8RqwLwvlRTkqCtsJPLcli0cjF+ohy0Y=;
 b=1TKQjA+jBdUIUik1Bp2j7L2NnB3GM7RigUH1/BL1krYO2fKxB8fwVQVFJGWgaLl6Ol
 LBS4VmxgByS8cxE3ga3MinGXuKG1wm4rb52lUBkWcDH+SjiP2B1t5Kfh3z473dh1rE2s
 2QqIdt8pQRGy3tIn0uIc7wlaJmRwez7QDIUxkQStc7ciodzlXQ4J6KpKAc+CoB8etwST
 W0CQeP7hcKA95tQP4mAMl0glVzr//EBgJuo7yuPdnuovcle64E2INmORd3SOJ6u7nIo+
 juVRaCoEwakVKHVfHQ7OXPI0s3j4FehmardX2UcJ89wIA3M/dX95cqrtIExHl3oKNsy5
 nd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732025814; x=1732630614;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xO6iMguNjFQi8RqwLwvlRTkqCtsJPLcli0cjF+ohy0Y=;
 b=Xg8k5GGEENvgu2XkpN77XXVTOUWUbW6PPRGMdsZJvM/aZPc4pl9G5wmnu9gIFLEpE9
 ytF0AJpxGzFqFa/BnDRB9l+InHjJGVSlIicF1/kz451+RG9Wv3rphHAONTITnSyp+WYH
 v07vEl7PiiSq8Mp/jd6DrXnjmEpD4B8MlHV0444Mv31Hon579raTonDCfOiyhzDVw7q8
 fH2DTNrHPC/mcmME9HG54BPr318P/QaE3FU5Pu6x74ZE7uN/CCMPdQdhTxVi5CWeh13I
 fjMOC0kcOXyqJ0TO1dpGsjupAF+gANJ9HPnYazuvtO0PRcmNUBdzb2KqJTEF6s4r/3LV
 egjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEWeRzRUKNguNjdsUEu2b10cHIbzSzxQvQQLWHKIunghp2c3tXG0tusJODThMCPAWb9doooN8=@lists.denx.de
X-Gm-Message-State: AOJu0YwJxKQdSPloUvf80IGGsALIv5xZmIytpm478c0CbAXfexRwD9Eg
 0f+hZYkbAlWKnj92o1/VZHsYPKZCWq6QmHKMnToQ9+hmPl3GFAoAz3qJPeE+t4U=
X-Google-Smtp-Source: AGHT+IFcuTEClhFjjR+ehJtthKvZ8dHlri+0w579n68GJW31iFZCj9AAYLrYHDHX2WAtU1uSIYTJug==
X-Received: by 2002:a05:6512:130e:b0:539:f807:ada5 with SMTP id
 2adb3069b0e04-53dab2941e0mr8476101e87.3.1732025814132; 
 Tue, 19 Nov 2024 06:16:54 -0800 (PST)
Received: from [192.168.2.170] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2946a3sm195147695e9.35.2024.11.19.06.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:16:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io
In-Reply-To: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Message-Id: <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
Date: Tue, 19 Nov 2024 15:16:53 +0100
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

On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
> Actually bootmethod android only support android boot image version 4
> and with AB image, some old platform wtill use android boot image
> version 2 with AB or without AB slot.
> 
> This patchset add support of both version 2 and non-AB slot images.
> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/5] bootstd: android: add support of bootimage v2
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
[2/5] bootstd: android: add non-A/B image support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
[3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
[4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
[5/5] bootstd: Add test for Android boot image v2
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a

--
Mattijs
