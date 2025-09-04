Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D790CA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 09:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90A883B0D;
	Thu,  4 Sep 2025 11:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SY25zXDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DBD83B1B; Thu,  4 Sep 2025 11:57:37 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A45683B03
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 11:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b7ebe667cso8049525e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756979854; x=1757584654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3POGfZGDyyhRv03yWjCoIknRoKZGkOSARQajjMkpOY=;
 b=SY25zXDwH+a9FoCtNrNsLxVZ66vxPJuMUdJprIcHBJaqQ6I0idE/SlF2chd1uqQwzp
 BDgYlPsxCSsv5g7LuJAF1rpGSaJKG5ZV2W+eIHZgMlBGg5sV31STz2MwyoC+auHVwtOu
 MXAA3hx0zU6HoIA9RgUyrqz9Fqv5xrZZA9Wi7w4WN5Il5Qd+Z8UqGJEnfgAOZqgjzM7L
 ejcntG+QNSdTzRHCG9B4lIPeVHMxbUgnoN253a9Xu73SutVT+ZBQxHv4rlaXCclqiJoR
 QOksKFN9xQv6W9thRIMNPEkM0CeFoeKeeKV4yMVHJ5flYyul/Zm/9daJQnA4qvBD2HGL
 XVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756979854; x=1757584654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3POGfZGDyyhRv03yWjCoIknRoKZGkOSARQajjMkpOY=;
 b=ANZKNrShltJBb+21vYjB6JftWMMmby44+UZCaO6ylLw3niumhtkzbPGY/MHQCd1SG9
 62KRD2caw5kkZotqol9MqfkCDBx+SR30crMXLFqz7vpjBuJp7OW4MAMhX1zsmVVMN402
 voZidwYksudY6/JqbRQhE1Y1EUaMMF+XLEIC8pXFf375D14m8S8ofB/8dKZWUX+34V4a
 cvDTaiacqMuycllooWlPg7Hnhap39zwlAeLSzNT9YQ29F/ed+ksr9Is0WauL3lByjM3i
 WzaiV9buTlyD+DIbv0xSVysjgRO0ksC4hr07OnAemVhh+5U+TeZeIbexwttfl4yqXd2y
 TM+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK+IKQL3HF9eKy/GqnTw9hdki7QJ9gPstUBNdKed74bKRGgeXS4eBvz+Mu7sWtSKcPtaUUFZw=@lists.denx.de
X-Gm-Message-State: AOJu0YyaaZowCbWmlFzpK1NWpk81Th5C9B+xZe0C9FEYuzM7Dt68Ji8p
 sssoPvkAozERmAbaWNxniPs+bFbrJC4gUXiW4LOS+dwwGmIcBKvLH61t4XdldrPLA/k=
X-Gm-Gg: ASbGncstY7s6zjKmlC0O+AKIy/bCzOAv1T+IYslBq3CDsqvKjPineABS6FY4Bx2yh1d
 q+2EdEuyRYRM07yGGK6caQrtFLcxTQEPbqpsp2auK4jsxziZP6qYhagr16qDv5z2IB5uloR7uUc
 Rv0PBCFkEKBk6mpsfEpbcItx1uhxqChgXVGfTF/hjflOGS2+986XcOERVm+SXDbxPpTT/lCZoiU
 o0ZV9Y58wkq5sJVEZtPuC1LIccpservZqjKgeMEdNReN9xKkwVkNpA8lcxVcaudooWD6SvRq1lT
 nPH9gWyYkV066W/UJZF5d/WRIHbYjLJdcPrkTRoDGEuE6rZzUp/vII24R5QwmyL/Bvp4excBf8r
 y20qNkaskQIiwlKsprnNuqWU3Xj66iRCUEeDOhMl7XhGANPzK7kly+A==
X-Google-Smtp-Source: AGHT+IH+Yfs7NuGyGtKKf7InDIoMxHtmm1njuRgowUdhbCvE/SzypbjlcfPWFKO/Tkea8vmiaOA+cA==
X-Received: by 2002:a05:600c:c4ac:b0:458:a992:6f1e with SMTP id
 5b1f17b1804b1-45b85526106mr174218625e9.5.1756979854035; 
 Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 02:57:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
References: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
Subject: Re: [PATCH] adc: meson-saradc: uint cannot be less than zero
Message-Id: <175697985356.2904655.7249459124998381725.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 22 Jul 2025 15:06:14 +0100, Andrew Goodbody wrote:
> timeout is declared as a uint but then tested for being less than zero
> which must always fail. Change the while loop for a pre-decrement on
> timeout and test timeout for being zero.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] adc: meson-saradc: uint cannot be less than zero
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9504c710153f3b15812460b6a48e166e112f66eb

-- 
Neil

