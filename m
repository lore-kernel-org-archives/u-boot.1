Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E69CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E677586AEE;
	Mon, 25 Sep 2023 15:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PzLA4G93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752A786BE8; Mon, 25 Sep 2023 15:18:51 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8945986ACC
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9aa2c6f0806so781931166b.3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695647929; x=1696252729; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d9/yI5lV4j0fp0Y9KlDfib1+ICnLpyS61Ovb1NZwCMI=;
 b=PzLA4G93L100HgRAOFsq4mumVgFOhbkfKbjPdpz2c1tBlNGZIkHwpa7lab7W6r47Fi
 ppxTU69k4s90nrl2Z6028fCVCuZtGSXezPmf5DnOZsMYXIK4RCp3slwnXTKc9jwId4I4
 qnYfXjKwnCzTQz0RW6Cu4Vd5pyRdKL0Unu9Zpn6ed+YEnvRTi7dPa9xfvaVXjH89Zp+6
 rODUBM1mXZMRqoiUcmY0YD6aF6TqeQ3ggHfV9k16HiwftLe+OMaH8GYiDBunRzitYSqK
 W0yqg6Nb4YMqJf0Wk6nVW46SiFNv1mNrRegzbhOSIfHmQbyQlYjtq0fizXHkuUBMw+Wt
 BH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647929; x=1696252729;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9/yI5lV4j0fp0Y9KlDfib1+ICnLpyS61Ovb1NZwCMI=;
 b=uSSSOyEUQkD3SfgdTMopz9NMmuIQeA335kNS3uMxkoNCxf6cinQ3/CCsBQ/o19mdkB
 /F8rNJMHAiav8M0djJMGM1SjJ782z94wHoIX3INUoa1AiA8Nvr8sfm4GwrWLuBxjEoTc
 w6JbzJSGKzO59RgrAXPMLi+NGHIVhqoUGQVFm7MVcEomozFB2LuUWYO7tNmzznYkFufq
 z7fMdkbqxAFHAjIadh537FltSKWXgjJxRT6Ytk7E7caMoiXaH3UPDiKGCjSPE0+ya1zr
 KF+y8cdiL7Iy3HeD4QCN5A3vE5D2kGPbB24yNs6F6BYKZK5+POZ23fJbUMIgnQsnFcnV
 ARyw==
X-Gm-Message-State: AOJu0Yz6hQDSf4WA+nxBl6OP+R6ls3hjntQURAKd8yCj9KhtdXYfrP3z
 qsKp+WawU+w+WzCUnqch9rmUjcFnzUU=
X-Google-Smtp-Source: AGHT+IFx22m6/OJOMH6rpW6jf4QnVMcv9FS3q66JmNtwj6azRMKJB+ytXC2LJI/AdzOv3Ou7mB4QvA==
X-Received: by 2002:a17:906:31d9:b0:9ae:57b8:ad11 with SMTP id
 f25-20020a17090631d900b009ae57b8ad11mr6304683ejf.38.1695647928703; 
 Mon, 25 Sep 2023 06:18:48 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.155.168]) by smtp.gmail.com with ESMTPSA id
 dx26-20020a170906a85a00b0099bcd1fa5b0sm6258101ejb.192.2023.09.25.06.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 06:18:48 -0700 (PDT)
Date: Mon, 25 Sep 2023 16:18:45 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Neha Francis <n-francis@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: Config fragments
User-Agent: K-9 Mail for Android
In-Reply-To: <20230823155558.GM3953269@bill-the-cat>
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
 <20230823155558.GM3953269@bill-the-cat>
Message-ID: <C098A4DC-CE20-4516-8971-B52041120BCD@gmail.com>
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



23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 18:55:58 GMT+03:00,=
 Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2=
(-=D0=BB=D0=B0):
>On Wed, Aug 23, 2023 at 09:30:31AM -0600, Simon Glass wrote:
>
>> Hi,
>>=20
>> Up until 2023=2E04 it has been possible to build all the defconfigs but
>> with 2023=2E07 that changed=2E Tom mentioned this to me recently=2E
>
>I'm adding Svyatoslav who is the person that brought in all of the
>config fragments that are going to be in v2023=2E07=2E
>
>> Up until 2023=2E04 we can enumerate all the board configs that can be
>> built=2E We can build any of them using a single name and a single
>> defconfig=2E The boards=2Ecfg file which buildman creates contains a fu=
ll
>> list of things that can be built=2E
>>=20
>> From 2023=2E07 this changes and we now have random =2Econfig files
>> sprinkled about the place=2E I say random because they are not connecte=
d
>> to anything=2E For example, here is
>
>They aren't random=2E  They're, just for v2023=2E07, in configs/ and then
>moving forward, they're in the board directory=2E  I would like to see
>them in more places possibly, but that's not something I'm sure enough
>on right now=2E
>
>> board/ti/am62x/MAINTAINERS:
>>
>> AM62x BOARD
>> M: Dave Gerlach <d-gerlach@ti=2Ecom>
>> M: Tom Rini <trini@konsulko=2Ecom>
>> S: Maintained
>> F: board/ti/am62x/
>> F: include/configs/am62x_evm=2Eh
>> F: configs/am62x_evm_r5_defconfig
>> F: configs/am62x_evm_a53_defconfig
>>=20
>> BEAGLEPLAY BOARD
>> M:     Nishanth Menon <nm@ti=2Ecom>
>> M:     Robert Nelson <robertcnelson@gmail=2Ecom>
>> M:     Tom Rini <trini@konsulko=2Ecom>
>> S:     Maintained
>> N:     beagleplay
>>=20
>> In most cases the MAINTAINERS file tells us about each board and until
>> [1] I had assumed that was the case=2E With that patch reverted, these
>> are the only 'orphaned' MAINTAINERS entries (buildman
>> --maintainer-check):
>>=20
>> WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
>> ending at line 8
>> WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending a=
t line 44
>> WARNING: orphaned defconfig in
>> board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
>> WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at li=
ne 6
>> WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at lin=
e 15
>>=20
>> But Tom advised me that MAINTAINERS is not intended for this purpose,
>> so the check has been dropped=2E I am not suggesting we bring it back,
>> necessarily, but if we did, we could use it to specify the =2Econfig an=
d
>> defconfig files which are used by each board=2E
>
>Note that the "N" syntax has been in use, for defconfigs for a lot
>longer, and is why the CI check for unmaintained / orphaned boards
>stopped working=2E
>
>> *Failing that*, I suggest a new 'name=2Ebrd' file in the board director=
y
>> to contain this information, e=2Eg=2E
>>=20
>> # Contents of board/ti/am62x/beagleplay=2Ebrd:
>> beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5=2Econfig
>> beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53=2Econfig
>>=20
>> This could be parsed by buildman and other tools, to produce a list of
>> available boards and to build each using a single name (e=2Eg=2E make
>> beagleplay-r5_defconfig)
>>=20
>> What do people think?
>
>I'm not sure I like this direction honestly=2E  Do we want CI to cover
>these configurations?  Maybe=2E  But it's just for CI=2E  Using the TI
>examples, I don't know that you can use buildman today to generate a
>functional binary (and if you can, if --keep will retain the right
>files)=2E
>
>Maybe we just need to make it clear that if you use config fragments
>then you're opting out of CI for that specific platform=2E  That should b=
e
>fine for example for the TI ones that will be built in OE a bunch
>anyhow so accidental failure to builds will be caught=2E  I don't know
>about the Tegra platforms=2E
>

Greetings! Are there any progress regards fragments move or this will hang=
 in mailing list indefinitely?

Best regards,
Svyatoslav R=2E
