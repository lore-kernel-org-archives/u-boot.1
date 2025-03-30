Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419F8C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 10:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A782280FF7;
	Sun, 30 Mar 2025 12:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iVyXfKLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727BF8129B; Sun, 30 Mar 2025 12:27:14 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCAEF8003E
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so3195455f8f.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743330431; x=1743935231; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoJIkmSmnSQKLa7ZKzJexn1EfRBvANVmkpjQiKjDLCM=;
 b=iVyXfKLgj+z1nXB7f3MXeZjas+s0vAAj8+atJ28iQtkqtJsWHg7H9fMABqlGoMVy1r
 fDAuaN5gzjVnrHouu03TqfJyX5nLME6zYwsUAT+t6ncOxy3TcWDKXe/lLlnkazNanxM/
 0KFJwnOX8YnVijZN0FnMA4ZuC1t8JWwgnDQy12dc2ftb9Hfz3EvSxNDtw++/sFoT8xex
 H4MkUTw69+e6FCt8NrWde8ZoSoj0IRKvwwaZ9IcOw1L6D4xs9414u5k7C+/sAnc+YRiK
 eKqRwLnfKwC0w9rSuQRJvQ5hkosapozjE/ZcFSAY+y7PqjAJmUCdqgkpWz2mGje0pP2x
 Uc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743330431; x=1743935231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoJIkmSmnSQKLa7ZKzJexn1EfRBvANVmkpjQiKjDLCM=;
 b=XsTc9noOXuBziSbr3s9ryrXNqHHRuvKAOBxRFWuxIz+MMdI5uNBqH7zCS/KXJyf643
 +2vuJGKVdId/gZA2dcVwswZHBx7FJnh+0RcTdYBE+gEXcmyWyOPs3/xT6CBbMnThDpfC
 /UcRvFvZIqj+zxEZO4Eh/cd7e5VRqpXNtnDskTDeXff44z/xVsk/CfmlCmudFgAjFL66
 /UMIZu8E9P7XfMrUAZUwsy+k0sOcF5bzEGSj/3U8Voc03MCabzjEpzEDiNJsyBNi0af7
 BofWsCi+wI906lWD+1/ZWy5oviEUt3IyEe5vIjJvIQiLUzNGP3KNmweriuIbh/n4L/sL
 QtGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcLeefG+EvYVDDXwlBET0IQ+RUxXJou+sTtkXccJK5OuFaPBtvIS9v8fka3AeAxFrIYQ5RRmU=@lists.denx.de
X-Gm-Message-State: AOJu0YyO+eyplkJGTlxJKArm2JW5oTQoAT8p8rnnSJxs5hiQFULCNX3Q
 pOruEH/E0miOZN+EXwBIrHH73Vvp/BmutZ01G0T5RBaGGVLaJMHmaix8er5JGlxEfLJGskBpbV9
 W3WY9tqlB5I15F9GIx9tRqTLAO2o=
X-Gm-Gg: ASbGnctBWij0i6wPOwO/czePxgHKl6fY8RPjE1Pqi0/5AfbqCZfPytDrzQWzrCgvxlN
 RNZGaYgBc9Jyoph0rAW6Am3ue1LYZCF8YVlOW1VWoT7ra/BZfvtcoao+rIw0/Zmdu/eU5jlCV/w
 4fDuyhKsrECHXTYGecTHj7JllOgpIkr0/kzZr5NQ==
X-Google-Smtp-Source: AGHT+IFSlEj+Gto881PleRSDRb2A1TAYVCEuTxnpHt/UgGOSdZ+VJxTj2IPkUam5MUWboGiubwl2Vjlpq2hgGOU49s0=
X-Received: by 2002:a5d:584f:0:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-39c120e0a93mr3295901f8f.27.1743330430697; Sun, 30 Mar 2025
 03:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250330093600.10871-1-clamor95@gmail.com>
 <20250330093600.10871-3-clamor95@gmail.com>
 <CALeDE9NMaakSFwgrGFZjqOap2F=7VGG67Nj6u_MqGmeJZFHQpg@mail.gmail.com>
In-Reply-To: <CALeDE9NMaakSFwgrGFZjqOap2F=7VGG67Nj6u_MqGmeJZFHQpg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 30 Mar 2025 13:26:59 +0300
X-Gm-Features: AQ5f1JpRsXAV0hWtyT72gASzb0zdJmryrbc98szKarmDryZJkgJISOFEakMKpiw
Message-ID: <CAPVz0n1SfoFQM-xKDVkc8QPZxzbcr-k_xVs62QWj+6CnvrGEhg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] video: rename tegra20 to tegra
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Alban Bedel <alban.bedel@avionic-design.de>, Anatolij Gustschin <agust@denx.de>,
 Thierry Reding <treding@nvidia.com>, Simon Glass <sjg@chromium.org>,
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

=D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:25 Pete=
r Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> I started to look at and test your other display patch series in the last=
 week or so, one thing I noticed is you need to update the Kconfig descript=
ions as well as this rename.
>

This series has Kconfig description adjustments.

> Has the other series been merged to next? You should also put a note abou=
t dependencies etc.
>

Yes, prev series is already in the next.

> Generally for this the rename makes sense so:
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>
> Peter
>
> On Sun, 30 Mar 2025 at 10:47, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
>>
>> Since this set of drivers suports four Tegra SoC generations, lets name =
it
>> just 'tegra'.
>>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> ---
>>  drivers/video/Kconfig                                  | 2 +-
>>  drivers/video/Makefile                                 | 2 +-
>>  drivers/video/{tegra20 =3D> tegra}/Kconfig               | 0
>>  drivers/video/{tegra20 =3D> tegra}/Makefile              | 0
>>  drivers/video/{tegra20 =3D> tegra}/mipi-phy.c            | 0
>>  drivers/video/{tegra20 =3D> tegra}/mipi-phy.h            | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-dc.c            | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-dc.h            | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-dsi.c           | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-dsi.h           | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-hdmi.c          | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-hdmi.h          | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-host1x.c        | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-mipi.c          | 0
>>  drivers/video/{tegra20 =3D> tegra}/tegra-pwm-backlight.c | 0
>>  15 files changed, 2 insertions(+), 2 deletions(-)
>>  rename drivers/video/{tegra20 =3D> tegra}/Kconfig (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/Makefile (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/mipi-phy.c (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/mipi-phy.h (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-dc.c (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-dc.h (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-dsi.c (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-dsi.h (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-hdmi.c (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-hdmi.h (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-host1x.c (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-mipi.c (100%)
>>  rename drivers/video/{tegra20 =3D> tegra}/tegra-pwm-backlight.c (100%)
>>
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index df607303616..afcdb16c599 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -819,7 +819,7 @@ config VIDEO_TEGRA124
>>
>>  source "drivers/video/bridge/Kconfig"
>>
>> -source "drivers/video/tegra20/Kconfig"
>> +source "drivers/video/tegra/Kconfig"
>>
>>  source "drivers/video/imx/Kconfig"
>>
>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>> index 6073bc5234a..f506f4ba050 100644
>> --- a/drivers/video/Makefile
>> +++ b/drivers/video/Makefile
>> @@ -85,4 +85,4 @@ obj-$(CONFIG_VIDEO_ZYNQMP_DPSUB) +=3D zynqmp/
>>
>>  obj-y +=3D bridge/
>>  obj-y +=3D sunxi/
>> -obj-y +=3D tegra20/
>> +obj-y +=3D tegra/
>> diff --git a/drivers/video/tegra20/Kconfig b/drivers/video/tegra/Kconfig
>> similarity index 100%
>> rename from drivers/video/tegra20/Kconfig
>> rename to drivers/video/tegra/Kconfig
>> diff --git a/drivers/video/tegra20/Makefile b/drivers/video/tegra/Makefi=
le
>> similarity index 100%
>> rename from drivers/video/tegra20/Makefile
>> rename to drivers/video/tegra/Makefile
>> diff --git a/drivers/video/tegra20/mipi-phy.c b/drivers/video/tegra/mipi=
-phy.c
>> similarity index 100%
>> rename from drivers/video/tegra20/mipi-phy.c
>> rename to drivers/video/tegra/mipi-phy.c
>> diff --git a/drivers/video/tegra20/mipi-phy.h b/drivers/video/tegra/mipi=
-phy.h
>> similarity index 100%
>> rename from drivers/video/tegra20/mipi-phy.h
>> rename to drivers/video/tegra/mipi-phy.h
>> diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra/tegr=
a-dc.c
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-dc.c
>> rename to drivers/video/tegra/tegra-dc.c
>> diff --git a/drivers/video/tegra20/tegra-dc.h b/drivers/video/tegra/tegr=
a-dc.h
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-dc.h
>> rename to drivers/video/tegra/tegra-dc.h
>> diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra/teg=
ra-dsi.c
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-dsi.c
>> rename to drivers/video/tegra/tegra-dsi.c
>> diff --git a/drivers/video/tegra20/tegra-dsi.h b/drivers/video/tegra/teg=
ra-dsi.h
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-dsi.h
>> rename to drivers/video/tegra/tegra-dsi.h
>> diff --git a/drivers/video/tegra20/tegra-hdmi.c b/drivers/video/tegra/te=
gra-hdmi.c
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-hdmi.c
>> rename to drivers/video/tegra/tegra-hdmi.c
>> diff --git a/drivers/video/tegra20/tegra-hdmi.h b/drivers/video/tegra/te=
gra-hdmi.h
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-hdmi.h
>> rename to drivers/video/tegra/tegra-hdmi.h
>> diff --git a/drivers/video/tegra20/tegra-host1x.c b/drivers/video/tegra/=
tegra-host1x.c
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-host1x.c
>> rename to drivers/video/tegra/tegra-host1x.c
>> diff --git a/drivers/video/tegra20/tegra-mipi.c b/drivers/video/tegra/te=
gra-mipi.c
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-mipi.c
>> rename to drivers/video/tegra/tegra-mipi.c
>> diff --git a/drivers/video/tegra20/tegra-pwm-backlight.c b/drivers/video=
/tegra/tegra-pwm-backlight.c
>> similarity index 100%
>> rename from drivers/video/tegra20/tegra-pwm-backlight.c
>> rename to drivers/video/tegra/tegra-pwm-backlight.c
>> --
>> 2.43.0
>>
