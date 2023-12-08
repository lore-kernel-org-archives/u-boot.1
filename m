Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC25C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 01:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684AE87559;
	Sat,  9 Dec 2023 02:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ics-com.20230601.gappssmtp.com header.i=@ics-com.20230601.gappssmtp.com header.b="IssYZic1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78A38761C; Fri,  8 Dec 2023 20:54:51 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA10874ED
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 20:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lpmeyer@ics.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1f060e059a3so1454517fac.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ics-com.20230601.gappssmtp.com; s=20230601; t=1702065286; x=1702670086;
 darn=lists.denx.de; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VQVCgLvgWiXm+Jih9SKbWQmF8Sy6LPCOf4maljQKx8=;
 b=IssYZic1vcvhuzFGkOauqUv3UssAIU9tIM5Qmigygd6EWsPEj4ywJKrO2zqNPAG45W
 NbsH/ibUAwhq5CJO9cMrma/tetjwR1B9maWHcLYY5VcIrnFqg1Ct7f7KTcTL86ZbbF4y
 Mv/allfZvh3JJt7Kf78hSyohne61tq8h00MUA0MTDCDb8yhlrT9ZuBZ4EvkEjQjVPeCB
 DA259Quvx24DG3+KYuVWI7a2a4TeSauYh3THgCaWhqTMtqjhr27hTe2Kj6+/GYTf2owj
 KHdLDO5+ytG20vzTEhcwX8dxn2Q1FBsAoddTqQU52WhO25rZsaW8a5XJpQNVzgH0QsJz
 hHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702065286; x=1702670086;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6VQVCgLvgWiXm+Jih9SKbWQmF8Sy6LPCOf4maljQKx8=;
 b=Qs4L2yyQprd5V2VLh6kkMQ7ooV/RnF+MmkUuB4R6qFv7VJS2ak9+wqLU0XtjzQ2zUZ
 DHXeS7MVPKmKmUEoNS2/kr+8wEhl+IGgI/61BTwCAFArEEnIxF9iuGaNBg2b+oNTnIMI
 brEu2+vafRo6JrmMJ3O5B3aAm6twoQTgNwU/W5oPntuVAwKZiWNzT801/E7BkQB5CgUb
 rUaXuNCMhoviTacJJU0JgGcP4NYpo/p2DmN//083vRKSE3q94mRGZzowM1iykoIAqDkZ
 iTGOHp/0nU8imG/WwsxDCFWcaCvbQUMX2G6LS281TenIsq3b7BvMNGeT+NnF+Opw+FQz
 oKPg==
X-Gm-Message-State: AOJu0Yx5D+KzWrKCFMMBguqHw9xlfQyMd9laXupsBjbHtRbjK8eB/scA
 8UzcV/wSsB5m07RjWIf0M9sLeyjleq7+kt3FqPsM+a22G5Fku9npT2g=
X-Google-Smtp-Source: AGHT+IEyeS4L2Vuoj09BAsjaqrN8fWxKSv6mRFwhszbgGh968Kw2aV5EMTCtlFyip3V0Wyuhnm1oFyGN1nkl2JgK4EI=
X-Received: by 2002:a05:6870:70a4:b0:1fb:75c:4016 with SMTP id
 v36-20020a05687070a400b001fb075c4016mr706887oae.118.1702065285863; Fri, 08
 Dec 2023 11:54:45 -0800 (PST)
MIME-Version: 1.0
References: <CABqjNW-wv1g-3W139TyTX_sSP5h3KLFzX_Sqzvx+atV=ZJrOYw@mail.gmail.com>
 <CAOMZO5BzCRhNnseNq5RMP94GLt=1H9s742ywtm_LWOqTxaJcrg@mail.gmail.com>
In-Reply-To: <CAOMZO5BzCRhNnseNq5RMP94GLt=1H9s742ywtm_LWOqTxaJcrg@mail.gmail.com>
From: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Date: Fri, 8 Dec 2023 16:54:30 -0300
Message-ID: <CABqjNW-w3BRg0rqDXXYRMKY6-Ws3HsuxdUbx_pKAQ2hiuUrOaA@mail.gmail.com>
Subject: Re: iMX6, CONFIG_IMX_HAB and fuse_read()
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 09 Dec 2023 02:14:53 +0100
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

Hi!

On Fri, Dec 8, 2023 at 3:53=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Lisandro,
>
> On Fri, Dec 8, 2023 at 3:43=E2=80=AFPM Lisandro P=C3=A9rez Meyer <lpmeyer=
@ics.com> wrote:
> >
> > Hi!
> >
> > I am currently not subscribed (already filled the form waiting for
> > confirmation), so please CC me for the moment.
> >
> > I am trying to enable Secure Boot/HAB on u-boot 2022.07. In a previous
>
> Please try the top of tree U-Boot instead.
>
> On the mx7dsabresd_defconfig, for example, both CONFIG_IMX_HAB=3Dy and
> CONFIG_CMD_FUSE=3Dy are selected
> and this target builds fine.

Sure thing!

For the sake of completeness:

gcc: gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz as per
https://developer-archives.toradex.com/knowledge-base/build-u-boot-and-linu=
x-kernel-from-source-code#tab-4-imx-6

```
$ export ARCH=3Darm
$ export DTC_FLAGS=3D"-@"
$ export PATH=3D~/gcc-linaro/bin/:$PATH
$ export CROSS_COMPILE=3Darm-none-linux-gnueabihf-
```

I added IMX_HAB:

```
$ echo "CONFIG_IMX_HAB=3Dy" >> configs/apalis_imx6_defconfig
```

And built:

```
$ make apalis_imx6_defconfig
$ make -j16
[...]
  LD      spl/u-boot-spl
arm-none-linux-gnueabihf-ld.bfd: arch/arm/mach-imx/hab.o: in function
`imx_hab_is_enabled':
/tmp/tmp.iSzdlFQa34/u-boot/arch/arm/mach-imx/hab.c:879: undefined
reference to `fuse_read'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
```

Same error :-/




--=20
Lisandro P=C3=A9rez Meyer
Embedded Platform Engineer
