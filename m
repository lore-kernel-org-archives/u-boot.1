Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F050DE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602B9801FB;
	Tue, 17 Dec 2024 15:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LFzp3pJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4713080224; Tue, 17 Dec 2024 15:04:14 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239AD801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53df80eeeedso5252411e87.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734444251; x=1735049051; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g31TGTrOXIU4AXOFGH3N/YDV4itk1MtqA5qQayR4rcQ=;
 b=LFzp3pJxy3oyKW6l6mAda+HDoy7+zATh5PxR4i2p0ygc/AGV0aW1r49R1lifXTsUeR
 4rkHeJA2j/OV4kirGWo5w/WIJKMTb8DGnpSKebj9si6zfbMVnsPCtTqIhFlrTZK/CZS0
 Vy5NmJjawvValvpLPNsmw0xEK15Sq/3Coog8cphlAUb6Igc++ZKFke26t8pAeZQ3bEss
 RDdSqImxN1wLg96NQPOrOJ3FazJ7YY30Fjui3cq5MZJM9+OQbxYn5NC2yIpdJlolrN64
 1HQUsj3/akeL+UJcNgJaZrTkKdPcXW5S/v+nE6pWdRJggVEYkZLplBMBy6aCJbjmSeYW
 W+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444251; x=1735049051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g31TGTrOXIU4AXOFGH3N/YDV4itk1MtqA5qQayR4rcQ=;
 b=s4uk3NuHjxMeZ0SLnZ/Ml37EwxMxNM6wfsBF57LSfzAyh/kX5eWcOmkrtMuzoXj+6o
 sFha/2Wh1SYTzl5EIjzcG2jq57o2IF9C2WfW5p9RdNgM/uGhpa3KAQo3d3HbXnLkufDc
 7WgCqkbTZB585ca2Eqfzz63FR4S064p8CtdyD8f4IVp8iu8YD5JUuYnMJulUeoHWCb31
 hl+fdPed+uhHjAr0eRVsygzYg39PJ+xSO0va6jPmBIphcjQADs/xB4H+7GppizVc70Cq
 Jvy6LInEthYJiS4KAlQ3lOAFE11A8bQbRF9mR5wu80Trseu0bqnAWieU1heLKf9lPlJB
 p2gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQGD5VXkqHzKFFrQ1OCZ/ZpmsiSI3PIjQ3jb4n1QHvyWPmx7MIoPkxSw2qKXDB7pNCj3Hh93k=@lists.denx.de
X-Gm-Message-State: AOJu0YzMM791TjBq7ihrmrpfS6UQqWH3T1M1Qg0qTUW/K3RB5fTpr0h0
 /Gqa/ZRGLB617hwo/cUoT7uWu6Hao66Os35tvNGuVBcmIL4o9LCXGtkNm28+fMqSQv01R0fb1r/
 PC1JqMhBPDxRtvXC+b3C6M3XIiqtQbapJhhE0gg==
X-Gm-Gg: ASbGncuEsoI1hvnVrV13+cJqycyjOP2Ol5oZ2uwTKsg53KW+FpSwk+HndMFWylZ1Hm3
 ixpSPuB/qt+XzTGMcgxYJwT5/pZhUaI0JQMJzJg==
X-Google-Smtp-Source: AGHT+IEcAxIlPPZkuYullHlopQ22/h7zU8Q8dagb4hBSqA3EF4R1LnFOg6/qYOCkUYJcT5rJtsLn1yuhYVm7QpBGPbE=
X-Received: by 2002:a05:6512:308d:b0:540:1f67:689a with SMTP id
 2adb3069b0e04-54099b72c9emr4427263e87.55.1734444249725; Tue, 17 Dec 2024
 06:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20241205203621.45806-1-heinrich.schuchardt@canonical.com>
 <20241205203621.45806-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241205203621.45806-2-heinrich.schuchardt@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 15:03:57 +0100
Message-ID: <CACRpkdbTQHKNGuJtkQgV0M99k190RXZh2JftB-Jiq4t5BTW7kA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] rtc: CONFIGS_RTC_PL031 must depend on
 CONFIGS_DM_RTC
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 David Feng <fenghua@phytium.com.cn>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 5, 2024 at 9:36=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:

> Building qemu_arm64_defconfig with CONFIGS_DM_RTC=3Dn and CONFIGS_RTC_PL0=
31=3Dy
> leads to a build failure.
>
> Adjust the vexpress64 configuration to avoid circular dependency.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>     Adjust the vexpress64 configuration to avoid circular dependency.

> +       imply DM_RTC
>         imply RTC_PL031
> -       select DM_RTC if RTC_PL031

Should it not be:
imply RTC_PL031 if DM_RTC

(The dependency in the driver will fix it I guess.)

The way we are using imply in U-Boot is a bit worrisome
but I'm no expert. It may work better in our case because we
never have an option be "m" (module) as in Linux... This
works for sure.

Yours,
Linus Walleij
