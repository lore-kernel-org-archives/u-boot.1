Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF405D6E2A4
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 09:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B57896C8;
	Thu, 21 Nov 2024 10:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hxgV6k3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C973F896C7; Thu, 21 Nov 2024 10:40:31 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F735894F4
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 10:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so5488485e9.2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 01:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732182029; x=1732786829;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cWgsTywPHfI31OysttwdqY606pvPKxlt5ldON59geHI=;
 b=hxgV6k3aLb9HC+8RYEPsSmI7UWv71w8elt9kYspuzWWClKw9Cad+hbqUxspeKcR9La
 kLlRyXS3tGic0bggefyWn/diAH6sTpVQOdGNgdWmvOXM+TyTH26G/JXZoC066vDeC9C8
 ygQLrU+ATbC5TNUyRAHvPIxVucNRjMSPnVtNJ8iE4DKc7/PIrHSyJD1rovgQb4t1Eg0G
 KaTd5jSlWSJymdqRIoljRjAFR78OgHgT7e9F1fCs7qLebfGw7gHigcoSV8MXd+2egHM2
 lPyw8FfBW1Qx4WsI8qZvgzmTuHWoiLftplocHjDrO5xMfAvEpLDeX0JMkcGkT6KtLA5E
 bfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732182029; x=1732786829;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWgsTywPHfI31OysttwdqY606pvPKxlt5ldON59geHI=;
 b=dwpT2X9ZomDyzv6mtIC+S94LU4kB+IFrEKS6QPWbgDaUPFl2/lF2Nmo+Cx96sfituF
 tDACmBPS5IdKZ6CQQBcIiF55s3ufXY5otVM+bSfTm/wb5HTDOUpfD1C6ZyPZOW5qC7sw
 7n9hBP7ZaQHQn/k6/pjxILYlctYlcfOIHGAPUldYADJxD/uoQvlvadn0N1LE5SjaHo91
 XqLkuYskYW1bOoYkzSMm6SE5ba5t/gXL7X0fJ3MjI7lOvTnTX4A6+qQNebI+594nhhkA
 rAJgnqPxocIfFh/EZsjGxv4m7ay9W41dfKyzd+g+12j2aLUNTmtiKMftZfJ3d/3Iqp0o
 iOOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7xY9DL7DTZGzwyszsQ/rzAt8vwy28S+75m7EElQlSrMQEDW934YIjVqKXymQNzVcnCXHn/ZQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+/+yKa0n+OJfvMRSkPdXBzPGbSfrIlemj1Fu729rUt+uY7nme
 4RvWV3Skd7B+/P2g9pYaHCcWJ1nfz0X93+SQfaIlGugc2TSDO48QORrJDZOIMNE=
X-Google-Smtp-Source: AGHT+IE2JrSIldrhiGTv2t/asx5B6rQM6/VdGFmTOjSt3khqjDM/vUVIH8Ln3i+q4Tve+f0hJurIoQ==
X-Received: by 2002:a05:600c:19d1:b0:431:5f1c:8352 with SMTP id
 5b1f17b1804b1-433489867e7mr51026475e9.5.1732182028794; 
 Thu, 21 Nov 2024 01:40:28 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254933bf7sm4491385f8f.72.2024.11.21.01.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 01:40:28 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume LA ROQUE <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <173202581313.45491.4764652989056463492.b4-ty@baylibre.com>
 <87mshvxhq3.fsf@baylibre.com>
 <d03137b3-02a1-4e1d-860b-5b0bc78be5c9@baylibre.com>
 <634d3625-deb9-4286-9b1d-4f18bdb49166@baylibre.com>
Date: Thu, 21 Nov 2024 10:40:25 +0100
Message-ID: <877c8wncvq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Guillaume,

On mer., nov. 20, 2024 at 18:54, Guillaume LA ROQUE <glaroque@baylibre.com>=
 wrote:

> Hi,
>
> unfortunately i don't find for now how i can fix issue in test.
>
> i don't really understand with when we launch test individually it's=20
> working but if we launch test_ut test not working ,
> I see on android test for image version 4 to mmc7 in bootflow list detect=
ed.
>
> =3D> ut bootstd bootflow_android_image_v4
> Test: bootflow_android_image_v4: bootflow.c
> scan_mmc_android_bootdev: mmc7
> order 0: mmc2
> order 1: mmc1
> order 2: mmc7
> order 3: <NULL>
> Enabled mmc mmc7 bootdev
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting slot=
 a, tries remaining 7
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ab_select_slot() ANDROID: Attempting slot=
 a, tries remaining 7
> Older order: mmc2
> Showing all bootflows
> Seq=C2=A0 Method=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 State=C2=A0=C2=A0 Uc=
lass=C2=A0=C2=A0=C2=A0 Part Name Filename
> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- ------------=
------------=20
> ----------------
>  =C2=A0 0=C2=A0 extlinux=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 mmc=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 mmc1.bootdev.part_1=20
> /extlinux/extlinux.conf
>  =C2=A0 1=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 m=
mc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.who=
le
>  =C2=A0 2=C2=A0 android=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ready=C2=A0=C2=A0 m=
mc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 mmc7.bootdev.who=
le
> ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ---- ------------=
------------=20
> ----------------
> (3 bootflows, 3 valid)
>
> if we just launch bootflow_android_image_v4 we have only a=20
> mmc7.bootdev.whole and so test is ok.
>
> if someone have an idea or can give some idea of what i can try or check .
>
> thanks for helping.

I'll have a look

>
> Guillaume
> Le 20/11/2024 =C3=A0 13:56, Guillaume LA ROQUE a =C3=A9crit=C2=A0:
>> Hi,
>>
>> Le 19/11/2024 =C3=A0 18:21, Mattijs Korpershoek a =C3=A9crit=C2=A0:
>>> Hi Guillaume,
>>>
>>> On mar., nov. 19, 2024 at 15:16, Mattijs Korpershoek=20
>>> <mkorpershoek@baylibre.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>>>> Actually bootmethod android only support android boot image version 4
>>>>> and with AB image, some old platform wtill use android boot image
>>>>> version 2 with AB or without AB slot.
>>>>>
>>>>> This patchset add support of both version 2 and non-AB slot images.
>>>>> It's fixed in same time a boot issue seen on khadas vim3{l} board=20
>>>>> with 16GB eMMC
>>>>>
>>>>> [...]
>>>> Thanks, Applied to=20
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>>>
>>>> [1/5] bootstd: android: add support of bootimage v2
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee99=
2e90bbe84278db20d29159e3eedfe0d
>>>> [2/5] bootstd: android: add non-A/B image support
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7=
bd3665366ca2704d1142d3f16f22c36
>>>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b=
2df5e4cabbaec57a0f2e7f212dbf823
>>>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717=
f2f33ef0dbb422026ef71938f2265aa
>>>> [5/5] bootstd: Add test for Android boot image v2
>>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a=
33146f887948d34130229388280844a
>>> CI has found some issues when applying these series:
>>> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23452
>>>
>>> Could you have a look please?
>> i will check
>>>
>>> Thanks!
>>>
>>>> --=20
>>>> Mattijs
>>
>>
