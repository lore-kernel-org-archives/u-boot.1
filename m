Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA94C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 09:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F58877D8;
	Wed, 13 Dec 2023 10:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B8rqwKZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618AF86FB0; Wed, 13 Dec 2023 10:47:04 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 131DA877D8
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 10:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54cd2281ccbso8756554a12.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702460820; x=1703065620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DMPDvSHeWoQ7sDq9t2SUu5VFDRp9w3GU4cnaV1znhok=;
 b=B8rqwKZTkRhXI5shzQnDmTlO9tPy44dMgubXB8fq7aYXyWBIkLQ3Xfx/6CTqgRz9C3
 94CbNrBPCabuUk0elXjR4UOaTH7VwSZpuq2rgIoueSfNP/vLeXQodQPfzWFxzQDP9neg
 I6XmUcNaZs28r9dg7Wih8GFS8CwHzIZ6jFYmYev54zCtCT/d7Uv2ruOxF2zVwh8ss8nx
 ntpuJ0bdOH+RVC+KKfIxfhoMyezrT3a57xI9uR7FIIw7c99d0WbosnK/qsTuLB+YSaKM
 5J/Zp2y2u6TlYgMxny3ML2tHO9+UdhzalRrZ/e6C+k8uiEktgyUN9mUAlS+9EQz2OSIk
 rTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702460820; x=1703065620;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMPDvSHeWoQ7sDq9t2SUu5VFDRp9w3GU4cnaV1znhok=;
 b=Gxnz2zEdH8+GkHBB+S1TnjJ96J7c33J6LnhRy16zEhu2Rxpwl2l/p2mcFtMLrLw1E/
 SZp1yzXYY8LFfYB5t1BXqjv2o3hC3Uyp6AMcg01DPP2j9i1QEK1XGQ6hOSiIZ/h+Ez0L
 6Pq3ig2rFUi79m9syd+bYgu8uhHja/XH4oNnB0zrC4lPYDVExXgOb22CxFpkiNdPeRju
 GQkmTEPAueikzQa1y2dftF6x5gMZgYgZ0ycwWhYK5w57q3maSKZrJmAMABptr7t5FWMV
 HrZe/8gAu7HfpyLOpGOhXNEIwvl/N/+5d6o5qH+npPEs1UEcB6iEydGvdeBffyvpuS75
 Q+kw==
X-Gm-Message-State: AOJu0YyuHg3UCYzpWlqQfJFFc1OdIizSyPWNZ0zq+9LEB9RD+uKo2jtO
 H2bR4bHnhnDFaefPUex1Vas=
X-Google-Smtp-Source: AGHT+IGh+3Qix1Z2uejU75vGx8E6MYMXU6Rb6TK/KF06/nWxzZQDVpZ9IoFEIsEsAXyUXo+82OuLPg==
X-Received: by 2002:a50:9515:0:b0:54c:2a05:fab6 with SMTP id
 u21-20020a509515000000b0054c2a05fab6mr5276152eda.0.1702460820249; 
 Wed, 13 Dec 2023 01:47:00 -0800 (PST)
Received: from [127.0.0.1] ([91.204.85.69]) by smtp.gmail.com with ESMTPSA id
 cr7-20020a056402222700b0054ce9ef93fbsm5478503edb.4.2023.12.13.01.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:47:00 -0800 (PST)
Date: Wed, 13 Dec 2023 11:46:58 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
CC: Thierry Reding <treding@nvidia.com>, Ramin Khonsari <raminterex@yahoo.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Kuan Lim Lee <kuanlim.lee@linux.starfivetech.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/8] Convert Tegra pinctrl to DM
User-Agent: K-9 Mail for Android
In-Reply-To: <20231209141406.GF2513409@bill-the-cat>
References: <20231204082054.4943-1-clamor95@gmail.com>
 <ZW2pYqo6hjGqKo_-@orome.fritz.box>
 <CAPVz0n1XDNvD8G06i_qEdr3SNXwWtFfkyURp6uZbr86rbH2jQA@mail.gmail.com>
 <20231209141406.GF2513409@bill-the-cat>
Message-ID: <0BD82463-7C19-4425-BEAE-D90811541FC8@gmail.com>
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



9 =D0=B3=D1=80=D1=83=D0=B4=D0=BD=D1=8F 2023 =D1=80=2E 16:14:06 GMT+02:00, =
Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
>On Mon, Dec 04, 2023 at 04:45:38PM +0200, Svyatoslav Ryhel wrote:
>> =D0=BF=D0=BD, 4 =D0=B3=D1=80=D1=83=D0=B4=2E 2023=E2=80=AF=D1=80=2E =D0=
=BE 12:26 Thierry Reding <treding@nvidia=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5:
>> >
>> > On Mon, Dec 04, 2023 at 10:20:46AM +0200, Svyatoslav Ryhel wrote:
>> > > Create a DM supported wrapper arround existing Tegra pinmux logic=
=2E
>> > > This implementation is backwards compatible with all existing board
>> > > setups and early stages of setup=2E All new boards must be device t=
ree
>> > > based=2E Linux dts pinmux nodes are fully compatible with this driv=
er=2E
>> > >
>> > > As an example I have converted recently merged T30 boards to this
>> > > layout (I have those devices and was able to test them properly) an=
d
>> > > Paz00 T20 board which was tested as well by owner=2E
>> > >
>> > > Svyatoslav Ryhel (8):
>> > >   ARM: mach-tegra: rearrange SPL configs
>> > >   drivers: pinctrl: create Tegra DM pinctrl driver
>> > >   drivers: pinctrl: tegra: incorporate existing code
>> > >   board: asus: grouper: switch to DM pinmux
>> > >   board: lg: x3-t30: switch to DM pinmux
>> > >   board: asus: transformer: switch to DM pinmux
>> > >   board: htc: endeavoru: switch to DM pinmux
>> > >   board: compal: paz00: clean up the board
>> > >
>> > >  arch/arm/dts/tegra20-paz00=2Edts                |    4 +-
>> > >  arch/arm/dts/tegra30-asus-grouper-common=2Edtsi |  712 ++++++++++
>> > >  =2E=2E=2E/dts/tegra30-asus-nexus7-grouper-E1565=2Edts |  113 ++
>> > >  =2E=2E=2E/dts/tegra30-asus-nexus7-grouper-PM269=2Edts |  113 ++
>> > >  =2E=2E=2E/dts/tegra30-asus-nexus7-tilapia-E1565=2Edts |  149 +++
>> > >  arch/arm/dts/tegra30-asus-p1801-t=2Edts         |  982 +++++++++++=
+++
>> > >  arch/arm/dts/tegra30-asus-tf201=2Edts           |   45 +
>> > >  arch/arm/dts/tegra30-asus-tf300t=2Edts          |   45 +
>> > >  arch/arm/dts/tegra30-asus-tf300tg=2Edts         |  128 ++
>> > >  arch/arm/dts/tegra30-asus-tf300tl=2Edts         |  163 +++
>> > >  arch/arm/dts/tegra30-asus-tf600t=2Edts          |  889 +++++++++++=
++
>> > >  arch/arm/dts/tegra30-asus-tf700t=2Edts          |   53 +
>> > >  arch/arm/dts/tegra30-asus-transformer=2Edtsi    |  984 +++++++++++=
+++
>> > >  arch/arm/dts/tegra30-htc-endeavoru=2Edts        | 1147 +++++++++++=
++++++
>> > >  arch/arm/dts/tegra30-lg-p880=2Edts              |   90 ++
>> > >  arch/arm/dts/tegra30-lg-p895=2Edts              |   93 ++
>> > >  arch/arm/dts/tegra30-lg-x3=2Edtsi               |  845 +++++++++++=
+
>> > >  arch/arm/include/asm/arch-tegra114/pinmux=2Eh   |  303 +++++
>> > >  arch/arm/include/asm/arch-tegra124/pinmux=2Eh   |  327 +++++
>> > >  arch/arm/include/asm/arch-tegra20/pinmux=2Eh    |  291 +++++
>> > >  arch/arm/include/asm/arch-tegra210/pinmux=2Eh   |  394 ++++++
>> > >  arch/arm/include/asm/arch-tegra30/pinmux=2Eh    |  381 ++++++
>> > >  arch/arm/mach-tegra/Kconfig                   |   16 +-
>> > >  arch/arm/mach-tegra/Makefile                  |    1 -
>> > >  arch/arm/mach-tegra/board=2Ec                   |    6 +-
>> > >  arch/arm/mach-tegra/board2=2Ec                  |    2 +-
>> > >  arch/arm/mach-tegra/tegra114/Makefile         |    2 +-
>> > >  arch/arm/mach-tegra/tegra124/Makefile         |    2 -
>> > >  arch/arm/mach-tegra/tegra20/Makefile          |    2 +-
>> > >  arch/arm/mach-tegra/tegra210/Makefile         |    1 -
>> > >  arch/arm/mach-tegra/tegra30/Makefile          |    2 +-
>> > >  board/asus/grouper/grouper=2Ec                  |   18 -
>> > >  board/asus/grouper/pinmux-config-grouper=2Eh    |  362 ------
>> > >  =2E=2E=2E/pinmux-config-transformer=2Eh               |  365 -----=
-
>> > >  board/asus/transformer-t30/transformer-t30=2Ec  |   23 -
>> > >  board/compal/paz00/Makefile                   |    8 -
>> > >  board/compal/paz00/paz00=2Ec                    |   53 -
>> > >  board/htc/endeavoru/endeavoru=2Ec               |   14 -
>> > >  board/htc/endeavoru/pinmux-config-endeavoru=2Eh |  362 ------
>> > >  board/lg/x3-t30/Kconfig                       |   12 -
>> > >  board/lg/x3-t30/configs/p880=2Econfig           |    1 -
>> > >  board/lg/x3-t30/configs/p895=2Econfig           |    1 -
>> > >  board/lg/x3-t30/pinmux-config-x3=2Eh            |  449 -------
>> > >  board/lg/x3-t30/x3-t30=2Ec                      |   23 -
>> > >  configs/paz00_defconfig                       |    3 +
>> > >  drivers/pinctrl/Kconfig                       |    1 +
>> > >  drivers/pinctrl/Makefile                      |    1 +
>> > >  drivers/pinctrl/tegra/Kconfig                 |   18 +
>> > >  drivers/pinctrl/tegra/Makefile                |   16 +
>> > >  =2E=2E=2E/pinctrl/tegra/funcmux-tegra114=2Ec          |    0
>> > >  =2E=2E=2E/pinctrl/tegra/funcmux-tegra124=2Ec          |    0
>> > >  =2E=2E=2E/pinctrl/tegra/funcmux-tegra20=2Ec           |    0
>> > >  =2E=2E=2E/pinctrl/tegra/funcmux-tegra210=2Ec          |    0
>> > >  =2E=2E=2E/pinctrl/tegra/funcmux-tegra30=2Ec           |    0
>> > >  drivers/pinctrl/tegra/pinctrl-tegra=2Ec         |  248 ++++
>> > >  drivers/pinctrl/tegra/pinctrl-tegra20=2Ec       |  177 +++
>> > >  =2E=2E=2E/pinctrl/tegra}/pinmux-common=2Ec            |    0
>> > >  =2E=2E=2E/pinctrl/tegra/pinmux-tegra114=2Ec           |    0
>> > >  =2E=2E=2E/pinctrl/tegra/pinmux-tegra124=2Ec           |    0
>> > >  =2E=2E=2E/pinctrl/tegra/pinmux-tegra20=2Ec            |    0
>> > >  drivers/pinctrl/tegra/pinmux-tegra210=2Ec       |  190 +++
>> > >  =2E=2E=2E/pinctrl/tegra/pinmux-tegra30=2Ec            |    0
>> > >  include/configs/x3-t30=2Eh                      |   13 +-
>> > >  63 files changed, 8920 insertions(+), 1723 deletions(-)
>> >
>> > So we're adding 7000 extra lines here just to get the same level of
>> > functionality? Do we really want this?
>>=20
>> Tom, as a project maintainer, may you answer? Does U-Boot really want
>> this? And ensure there will never ever be a forced pinmux DM
>> migration=2E
>>=20
>> >
>> > For things like the kernel this makes a bit more sense because we can
>> > have generic kernel images for a wide variety of boards, and
>> > additionally we can have dynamic reconfiguration of the pinmux at
>> > runtime=2E We have neither of those in U-Boot, so do we really need t=
o
>> > move all this into DT and add this extra overhead?
>>=20
>> There would not be so much overhead if Linux kernel used numbers for
>> pin definitions, not strings=2E
>
>Well, yes, this is the right direction=2E One of the goals is to be able
>to use the linux device trees as-is and be able to pass that along to
>the OS to use=2E And so we move a little away from the absolute thinnest
>case that we used to be and a bit more towards a generic case just like
>Linux did=2E In some cases, one can just change the device tree passed to
>U-Boot and re-use the same binary=2E And if Tegra platforms moved in that
>direction that's nice too=2E
>

These patches do not discard the existing header system of pinmux setup, i=
t is still supported and is not touched whatsoever=2E These patches add DM =
overlay so that boards which can afford inflated device tree and care about=
 size less could move to linux style device tree pinmux definition=2E Well =
I know how hard it is to rewrite pinmux over and over for different project=
s=2E
