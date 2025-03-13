Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F72AC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 12:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DDE80F9C;
	Thu, 13 Mar 2025 13:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ccUiscy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA628168B; Thu, 13 Mar 2025 13:27:31 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DB88007D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 13:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so492272f8f.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741868848; x=1742473648; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmZZtmLunsZYLQvxD4MdXmEfJp5p6rPl1C3uB5CDYT0=;
 b=ccUiscy1HKy80efjFk/XIAaTCHV8bfucIeYFjlLqLiaqUzi9nztT4Um38cUrxNVq0h
 9hwszTUkh0B1zMF04iszVSUBjyciJTtkhjUyM95S/Ef/gXrA+DKl8fLqgGNcMqDr/GVO
 nhvly3FxFnN/VGD5AyExUD0QOY9nExo1kUZ8kqU7idv4reh+vN8C6vLLAg0Djy5Z18PZ
 HsKnFhCOa14YJh4qNwXn5OLXA4Sde8KWgQFPPdoF9jE3DRLbtbHxy6prPOeI/grK8g0b
 DCdS0DuHhMtmjYrbwZW5YQV+DJcLmG5xInRTcVvwwtgXFnAD5/xd+QdmEcprXCuiCzH0
 JD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741868848; x=1742473648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmZZtmLunsZYLQvxD4MdXmEfJp5p6rPl1C3uB5CDYT0=;
 b=BWFJdZVYJ1SsTXWKf5+fLbP3aKMbe48hlcLvlieN27KgDbQshWHx+oH6vllXMnqk3c
 /yhiqNYnwPdojO+gMINnZI69+H3soagmOpDwoqAi0L3AUtZ5tlrxGkz0FxJjjJMwYait
 j6fnE0y/YlDbV4SS2aRwsAEK3IvN6fqBPdNFogAr71S0TknBXi0yhIgPxhKgfbns2Pv6
 NVFmdottFDN+5xiGCDZEBfUGUfWJnMvzM/WC/fdUTS4b/AczmTCQCMBAlI6jxqqcGgNT
 szzy+YrB1RvdzKgEWFJIA+J5s8BXj+jhFkb5oxMlBbOqDHwzGWQ04A+WJop2KAnmXNjy
 S6OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaCubb/WnTAWcuBkXH2yxZ4jZl+Y/BAnTKw95UFaCjowXk45bS5Yl8sCr+phbKK1oB2qVsxwc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/Lx6ImbD/MEEkdgHBIHDSj6muYIpec41VW31aBdf6YgSGO/f9
 37x/u0TC0iswlBTDmgBrxf+QpV76Pz/ljHiiVbDQikTj7ExK+ADZD8Dpppt8/uylehTBw5+OjQ+
 Ex/fax1HUKXHJU/I539EAlsvcaQg=
X-Gm-Gg: ASbGncvPVJN3Q5AOkhqV2Z9Yud4CYyPyzCTJwmfUK997IWFuWcHt3YH1vz6fmNAz/wI
 eHTwqrUwbbd4jOnwNDwxZfwe64MWtMSe0DCoPguxRJphT5tXMX/cD/N+EO5lfnIxcD926ctEiE5
 7RKRnx0h7TuUGoZ9homiOVMeW55oE=
X-Google-Smtp-Source: AGHT+IHCS9cInDmEj55IcQfRs3gxZeisRgttunMr9HKqf1v7JzsGRT7WUyBVEwxCLEQ7Yl8Mo7dNecfN45J4WCfEt9s=
X-Received: by 2002:a05:6000:2ac:b0:390:f460:77b0 with SMTP id
 ffacd0b85a97d-39132d3805cmr20843046f8f.26.1741868848168; Thu, 13 Mar 2025
 05:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250312175857.120313-1-clamor95@gmail.com>
 <CALeDE9PBFv1ebVBrmAzUgEtD+jnfjxDMk7grQYG1tKmD=hQMjg@mail.gmail.com>
 <CAPVz0n0o6UMr-AGHdH5YPxcOaRGwoe=4R3fcaZLej4n=rjPYZw@mail.gmail.com>
 <CALeDE9NsjDrRbs2c7zBvkkDvaHKpUnU-CaYCWkSRVD0PMabOLw@mail.gmail.com>
In-Reply-To: <CALeDE9NsjDrRbs2c7zBvkkDvaHKpUnU-CaYCWkSRVD0PMabOLw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Mar 2025 14:27:16 +0200
X-Gm-Features: AQ5f1Jq9LEfU3pXeTbJ2h7nxKoQXxljDmtbK-RkGCmqyt2jnRy_aOVYNAYPP_Po
Message-ID: <CAPVz0n12XKTNRDr=SARE0Emw7vB+ojtcvJpNqxuvyrZHNh9Odw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] video: tegra: migrations, HDMI and HOST1x
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=87=D1=82, 13 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 14:21 Pete=
r Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> On Thu, 13 Mar 2025 at 11:58, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
>>
>> =D1=87=D1=82, 13 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:55 P=
eter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>> >
>> > Hey Svyatoslav,
>> >
>> > What generations of the hardware do you expect this to work on?
>> >
>>
>> Changes were tested on T20, T30, T114 and T124. They all successfully
>> work with proposed changes.
>
>
> Do you think it would work on T210?
>

I do not know for sure, T210 is aarch64 while T124 is last gen on
armv7 so there definitely will be some compatibility issues. Nothing
that should not be possible to resolve though. I  don't have access to
T210 devices and most likely will never have unless there will be a
device donation or very cheap one on used device market.

>>
>> > Peter
>> >
>> > On Wed, 12 Mar 2025 at 17:59, Svyatoslav Ryhel <clamor95@gmail.com> wr=
ote:
>> >>
>> >> Migrate DC and DSI to support video bridge UCLASS and OF graph bindin=
gs.
>> >> Add HDMI and basic HOST1X bus drivers. Move DC driven PWM backlight
>> >> into DC node.
>> >>
>> >> Svyatoslav Ryhel (10):
>> >>   video: tegra20: implement a minimal HOST1X driver for essential clo=
ck
>> >>     and reset setup
>> >>   video: tegra20: provide driver support for the HDMI controller
>> >>   video: tegra20: dc: add video bridge support
>> >>   video: tegra20: dc: convert to use of_graph
>> >>   video: tegra20: dc: get DSI/HDMI clock parent if internal DSI/HDMI =
is
>> >>     used
>> >>   video: tegra20: dc: remove unused video operations
>> >>   video: tegra20: dc: support binding child devices
>> >>   video: tegra20: pwm-backlight: convert into DC child
>> >>   video: tegra20: dsi: convert to video bridge UCLASS
>> >>   video: tegra20: dsi: respect speed mode used for DSI commands trans=
fer
>> >>
>> >>  arch/arm/include/asm/arch-tegra/dc.h        |  46 +-
>> >>  drivers/video/tegra20/Kconfig               |  16 +-
>> >>  drivers/video/tegra20/Makefile              |   2 +
>> >>  drivers/video/tegra20/tegra-dc.c            | 233 +++++--
>> >>  drivers/video/tegra20/tegra-dc.h            |   3 -
>> >>  drivers/video/tegra20/tegra-dsi.c           |  12 +-
>> >>  drivers/video/tegra20/tegra-hdmi.c          | 623 ++++++++++++++++++=
+
>> >>  drivers/video/tegra20/tegra-hdmi.h          | 652 ++++++++++++++++++=
++
>> >>  drivers/video/tegra20/tegra-host1x.c        |  86 +++
>> >>  drivers/video/tegra20/tegra-pwm-backlight.c |  12 +-
>> >>  10 files changed, 1603 insertions(+), 82 deletions(-)
>> >>  create mode 100644 drivers/video/tegra20/tegra-hdmi.c
>> >>  create mode 100644 drivers/video/tegra20/tegra-hdmi.h
>> >>  create mode 100644 drivers/video/tegra20/tegra-host1x.c
>> >>
>> >> --
>> >> 2.43.0
>> >>
