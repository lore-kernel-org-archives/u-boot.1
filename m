Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95ADC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 05:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0148886555;
	Thu, 24 Aug 2023 07:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDseCMuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889CF86554; Thu, 24 Aug 2023 07:41:51 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E66E8653D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso15827066b.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692855708; x=1693460508;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nFRyQBshjYgr4yeIxHCDfPvDN9UX6wF6KsnUKkVIbxM=;
 b=VDseCMuPGncHoJ+J//PGxjjNpNFZZCddBL6f9CUF3CiQM2l/X8cgkrNQBIVjfrAV09
 oxY0X4KNcKtBQ2tZQoVkWyZqKwl8gGhy0on6Ix7S1zLVBI23LODmEMeJCUwewkX69i5h
 rP8w6xCk4IMsSRFMGCequjCsX/uCNYFZCg0fIAyysget0Ti6FQObLWpRpzOdlZFnFO94
 uUpQUctyUfRylSTboMsUtmWZsk9Ax8JMMBvjx8w76PsES/rkZynbl/wlTw+NBXqQFJka
 0AmYTGp7B4doW7diV+uiJFqNqg+bVgkti/yS61j5v78xsUwDzfAtHtB5FYyPWCzwvUA3
 gijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692855708; x=1693460508;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nFRyQBshjYgr4yeIxHCDfPvDN9UX6wF6KsnUKkVIbxM=;
 b=dAGkpwJnrC2Mn+E+edoCBBb0+tBL+d7bSGsb23+oFT7STVzbYPm4ctoo/p7GVnW93D
 sVGqiry19nsmA3EikpLrJdTUIJ8T1X/qXHRLA3gSYSURdV8Sr1hNvtWJCXCXsGbWT7Rz
 yrzNAM5y9QiXsdXcH+pD0QFxea87oRB79kP13TboIkdaZKZXxSOHL4z8UmVO5D2VmphD
 Pshm884wJlpwgaKEsFGrqM4KlfBm9uW0M/ncucqLAvWXZX1Q3l8NhazSoPftlhx+w2F9
 BSCA3t4k7GLsmvPrtMnpNxDyjhxTezKoz4vIPgFeEZqHebF/N5H//JeHYRSZUN9zPMLy
 saUQ==
X-Gm-Message-State: AOJu0YwPAyKS+C4ImesjnxVlgA14DaQZhXws6JVe9QE0faTG16ehcpPX
 AQ11Lefh2UPpVw4dig1FPxI=
X-Google-Smtp-Source: AGHT+IH9JVGgaIK5DiwAtog+w0rmaI/T+cSHHNFU33noRGaUPtOM1BPh/V3W6Is71BW4wEOhZ5w+sg==
X-Received: by 2002:a17:906:186:b0:9a1:fdfe:a6bf with SMTP id
 6-20020a170906018600b009a1fdfea6bfmr1169157ejb.38.1692855707770; 
 Wed, 23 Aug 2023 22:41:47 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.11.129]) by smtp.gmail.com with ESMTPSA id
 y12-20020a1709064b0c00b009a1bf608ff3sm3008042eju.132.2023.08.23.22.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 22:41:47 -0700 (PDT)
Date: Thu, 24 Aug 2023 08:41:46 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@google.com>
CC: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 15/19] ARM: tegra: board2: add generic late init
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ3zyLjoX5-2zvC9X3Bz+h2KzODpq6X8kNAqR038qtaFVA@mail.gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-16-clamor95@gmail.com>
 <CAPnjgZ3zyLjoX5-2zvC9X3Bz+h2KzODpq6X8kNAqR038qtaFVA@mail.gmail.com>
Message-ID: <7AAC0372-D966-4D35-AA33-5EF03FD0DF2B@gmail.com>
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



24 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 02:57:34 GMT+03:00,=
 Simon Glass <sjg@google=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
>Hi Svyatoslav,
>
>On Tue, 22 Aug 2023 at 05:25, Svyatoslav Ryhel <clamor95@gmail=2Ecom> wro=
te:
>>
>> Board specific late init allows vendors to set up different device
>> or board specific env variables (like serial number, platform name)=2E
>> In case this information is missing, u-boot will lack info regards
>> serial or platform=2E
>>
>> To avoid this prior nvidia_board_late_init internal generic function
>> is called which fills required data=2E In this case platform name is
>> obtained from get_chip and serialno is filled with SoC id=2E
>>
>> Though SoC id is not dedicated to be devices serial but it fits well
>> in case of restriction of data about device and since SoC is basically
>> a main chip of the device=2E
>>
>> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo=2Ecom> # ASUS Transfor=
mers
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # Nvidia Tegratab
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  arch/arm/mach-tegra/board2=2Ec | 43 ++++++++++++++++++++++++++++++++++=
++
>>  1 file changed, 43 insertions(+)
>>
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
>>  #endif /* EARLY_INIT */
>>
>> +#ifndef CONFIG_TEGRA186
>> +static void nvidia_board_late_init_generic(void)
>> +{
>> +       char serialno_str[17];
>> +
>> +       /* Set chip id as serialno */
>> +       sprintf(serialno_str, "%016llx", tegra_chip_uid());
>> +       env_set("serial#", serialno_str);
>> +
>> +       switch (tegra_get_chip()) {
>> +       case CHIPID_TEGRA20:
>> +               env_set("platform", "Tegra 2 T20");
>> +               break;
>> +       case CHIPID_TEGRA30:
>> +               env_set("platform", "Tegra 3 T30");
>> +               break;
>> +       case CHIPID_TEGRA114:
>> +               env_set("platform", "Tegra 4 T114");
>> +               break;
>> +       case CHIPID_TEGRA124:
>> +               env_set("platform", "Tegra K1 T124");
>> +               break;
>> +       case CHIPID_TEGRA210:
>> +               env_set("platform", "Tegra X1 T210");
>> +               break;
>> +       default:
>> +               return;
>> +       }
>> +}
>> +#endif
>> +
>>  int board_late_init(void)
>>  {
>>  #if defined(CONFIG_TEGRA_SUPPORT_NON_SECURE)
>> @@ -268,6 +303,14 @@ int board_late_init(void)
>>  #endif
>>         start_cpu_fan();
>>         cboot_late_init();
>> +
>> +       /*
>> +        * Perform generic env setup in case
>> +        * vendor does not provide it=2E
>> +        */
>> +#ifndef CONFIG_TEGRA186
>> +       nvidia_board_late_init_generic();
>> +#endif
>>         nvidia_board_late_init();
>>
>>         return 0;
>> --
>> 2=2E39=2E2
>>
>
>This would be better done with events=2E I just sent a series that
>converts board_late_init() to use events [1] and with that you can add
>as many 'spy' functions as you like [2]=2E

This is definitely a nice suggestion, but I would rather dedicate this con=
vertion a separate patchset since it will affect multiple files and functio=
ns across all mach-terga=2E

Best regards,
Svyatoslav R=2E

>Regards,
>Simon
>
>[1] https://patchwork=2Eozlabs=2Eorg/project/uboot/list/?series=3D369742
>[2] https://u-boot=2Ereadthedocs=2Eio/en/latest/develop/event=2Ehtml
