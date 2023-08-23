Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754BFEE49B0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49BB864B6;
	Wed, 23 Aug 2023 13:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6ZmURdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB94C864C3; Wed, 23 Aug 2023 13:42:23 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD2E1808E6
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4ffa94a7a47so7129161e87.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692790936; x=1693395736;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WjeVrbeqtSFNJpB8okFMfPHVIzLgK3JxDbVM0Wg1GSE=;
 b=S6ZmURdw/ccxbATGHW4mBa8gIz8DV944Ahf2nCyzJoVnkiGqW12K/0WSru/ER9tDcj
 OAMDjZ+z8HKKNux2/CmznXsVzxqNav812patHoPuFaXW26Y6Z2+SJFgpYoRXNu7E9Cz/
 heFcTzRp/lDedQQqmHliNRgEQsFL4MU+7fPD6mBuHX6f6vt6fAAbLluNXWsh/cds3sVd
 VLWKC4jU5qU7m9xTZulBEbU2BXguW78e0J5iq27ffImt+d31PviVC+zV/WQpcH2NX0M0
 +KpYYC5eOFDZldYijeE4qbE66+P6I57ABzsPcjbInkd/5jjH0rTw7hj7lXo1lNn9qn0I
 I30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692790936; x=1693395736;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WjeVrbeqtSFNJpB8okFMfPHVIzLgK3JxDbVM0Wg1GSE=;
 b=NnckmYzwBnqgqyvp+S+Yjlv55KlZkjUMTQDLbb/MFA8rhpDqS2TwyHAKw2ScBLroaD
 AP0C6HDyn5D7uvncMyKhz4lAoM/CtpKgGd+Oa0fQ8TsmMT5KFuIYS7Q2+zU5MzHmO1/Q
 nTbfVTUboxyaajwftO3J2NR1pU7QLd1qmtENFzFJjjRlHIAcuCTdtOoEVFbDOtrJl62u
 5NYI8tZ2O5gzAx2WGabW98m9ap00zFKZQYNGrgFwvUbnCqMamXWOsTm4uos4xcESOKQp
 g5Jbtm1xM0+OvfW5KySFTznPbd7C07ffzPMd6Y63n3HPhOLNbR0UMK62tWYd6DJjGR8v
 wDaA==
X-Gm-Message-State: AOJu0Yxrpw+jm5XBhzG18NQio3Ze2DwcVPyqX3TXFqAor0P0XVg4MzRI
 Xad4wp1+YJaeIiUDuLOBH0tcnrWsLCNvMw==
X-Google-Smtp-Source: AGHT+IF0ZYUi2JE3LN03iaySQBQD6B9BRjr45+O6AZoal/omL5qcfP6H1h4bY2p3oshG9tCd7l95RQ==
X-Received: by 2002:a05:6512:3b9e:b0:500:9a67:d40e with SMTP id
 g30-20020a0565123b9e00b005009a67d40emr464672lfv.60.1692790936443; 
 Wed, 23 Aug 2023 04:42:16 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.10.167]) by smtp.gmail.com with ESMTPSA id
 a16-20020aa7cf10000000b00521d2f7459fsm9152211edy.49.2023.08.23.04.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 04:42:16 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:42:15 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 15/19] ARM: tegra: board2: add generic late init
User-Agent: K-9 Mail for Android
In-Reply-To: <ZOXpx6oq8MYkoHcw@orome>
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-16-clamor95@gmail.com> <ZOXpx6oq8MYkoHcw@orome>
Message-ID: <09EF2F83-FAAE-4494-AF36-C84DA5BB5349@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 14:13:11 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Tue, Aug 22, 2023 at 02:22:13PM +0300, Svyatoslav Ryhel wrote:
>> Board specific late init allows vendors to set up different device
>> or board specific env variables (like serial number, platform name)=2E
>> In case this information is missing, u-boot will lack info regards
>> serial or platform=2E
>>=20
>> To avoid this prior nvidia_board_late_init internal generic function
>> is called which fills required data=2E In this case platform name is
>> obtained from get_chip and serialno is filled with SoC id=2E
>>=20
>> Though SoC id is not dedicated to be devices serial but it fits well
>> in case of restriction of data about device and since SoC is basically
>> a main chip of the device=2E
>>=20
>> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo=2Ecom> # ASUS Transfor=
mers
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # Nvidia Tegratab
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  arch/arm/mach-tegra/board2=2Ec | 43 ++++++++++++++++++++++++++++++++++=
++
>>  1 file changed, 43 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-tegra/board2=2Ec b/arch/arm/mach-tegra/board=
2=2Ec
>> index 981768bb0e=2E=2Eee69cb657a 100644
>> --- a/arch/arm/mach-tegra/board2=2Ec
>> +++ b/arch/arm/mach-tegra/board2=2Ec
>> @@ -26,6 +26,10 @@
>>  #include <asm/arch-tegra/gpu=2Eh>
>>  #include <asm/arch-tegra/usb=2Eh>
>>  #include <asm/arch-tegra/xusb-padctl=2Eh>
>> +#ifndef CONFIG_TEGRA186
>> +#include <asm/arch-tegra/fuse=2Eh>
>> +#include <asm/arch/gp_padctrl=2Eh>
>> +#endif
>>  #if IS_ENABLED(CONFIG_TEGRA_CLKRST)
>>  #include <asm/arch/clock=2Eh>
>>  #endif
>> @@ -256,6 +260,37 @@ int board_early_init_f(void)
>>  }
>>  #endif	/* EARLY_INIT */
>> =20
>> +#ifndef CONFIG_TEGRA186
>> +static void nvidia_board_late_init_generic(void)
>> +{
>> +	char serialno_str[17];
>> +
>> +	/* Set chip id as serialno */
>> +	sprintf(serialno_str, "%016llx", tegra_chip_uid());
>> +	env_set("serial#", serialno_str);
>> +
>> +	switch (tegra_get_chip()) {
>> +	case CHIPID_TEGRA20:
>> +		env_set("platform", "Tegra 2 T20");
>> +		break;
>> +	case CHIPID_TEGRA30:
>> +		env_set("platform", "Tegra 3 T30");
>> +		break;
>> +	case CHIPID_TEGRA114:
>> +		env_set("platform", "Tegra 4 T114");
>> +		break;
>> +	case CHIPID_TEGRA124:
>> +		env_set("platform", "Tegra K1 T124");
>> +		break;
>> +	case CHIPID_TEGRA210:
>> +		env_set("platform", "Tegra X1 T210");
>
>This variable is presumably something that you'd want to match on in a
>script, so perhaps we can settle on something a bit more canonical=2E In
>upstream Linux we use tegraXYZ quite consistently and you'll see that
>reflected in things like compatible strings, so I'd suggest reusing the
>same naming scheme here to simplify and avoid confusion=2E

I chose this look because it looks nice if call fastboot getvar platform=
=2E You can choose anything you want, I do not care=2E

>Thierry
