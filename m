Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E260C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 15:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF5A875C5;
	Mon, 27 Nov 2023 16:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2CO+JsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05EFC875EB; Mon, 27 Nov 2023 16:53:07 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E5087538
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 16:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50ba78c7ee2so3291174e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701100383; x=1701705183; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yza8Vbud2eqGUJVcUFr7FD+4mXr4VtKJefULRUpcSpg=;
 b=Y2CO+JsPMzpHLtCXNZ4BYqDAt+btqf6YiiU8Q9MlibZ++0U8zMWT57ZYwFbv5RC153
 hLhflAhItlZUCqa8CW+dmPV9Nl+miD4ZUQgFcJ8C7vsmDWU2hhoawYlt+FpTeCqCp8k7
 u4KDeBaWKOdOYQ3Lzp/ZXbtwBwsLr2i0cKwh2eFj+YHx/jMtlmzC+5YA2So+PJXo4ql6
 KnXWwdpxmt7j6bWP4G1guy7PzO5V2C4raCOY8355WzwpmUPty5AVvVt18SXI/yj3HKmz
 NQtm/iyUxZn/OCG7sgshY6wRny56jbM8B6JD8eAkgWl+ynP+muYAA3l2lQDn5rKt7H+h
 VZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701100383; x=1701705183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yza8Vbud2eqGUJVcUFr7FD+4mXr4VtKJefULRUpcSpg=;
 b=R6gHfYwMYRLSqnX+CFi5bogHkdyEMJjgbzlCzT7043d6ry9Z7/8ubqb/zrRcclyRZ8
 /kjJaZrsVGEukEpe89IcN0ncYJFR8feyfvBT2uOSrfo5k+4G1sRt5eQzEkW13l7aUnSc
 rIYJ1mmjWanT21UhxuNrldm5gjY8EuU3tvjfOWIezxTrp2O3lZNewH/mGNeGmDUPpDJT
 RSi3MyikRTDisMAobvvPtu6eRO5HltY3nEPUpX++aSsLMF3NmLGxR1oKf93L0B+kwL9w
 p1ETy0jGKV5atOgIXdfwbUJp8OHevgnhLeWQvh4gnKQeS++xtm5VxFS83nP+RPZztMTy
 AVEA==
X-Gm-Message-State: AOJu0Yw1Urg9SBgBs+efO39n70FeenvhTSYDcmwj6ZrPzcD5ti5fCuTx
 VzbYj++G5fuZ9uo2qsZZ7GSTDaz/kGoisihoPFo=
X-Google-Smtp-Source: AGHT+IEqajElOgDTIaAjXoAzutvmRRcADcFnIBo350SNiPlIYSM8wXR09PHg1GeC6PgvkMapeY4KLrEPHKJoc6pPj00=
X-Received: by 2002:a19:5207:0:b0:503:3278:3221 with SMTP id
 m7-20020a195207000000b0050332783221mr7794050lfb.69.1701100382985; Mon, 27 Nov
 2023 07:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
 <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
 <20231127140813.GF2513409@bill-the-cat>
 <CAD8XO3b-BijLJz0fbsLA-DdAzW_Yj0Z+JOWZtFUFr-3KgKesQA@mail.gmail.com>
In-Reply-To: <CAD8XO3b-BijLJz0fbsLA-DdAzW_Yj0Z+JOWZtFUFr-3KgKesQA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 27 Nov 2023 15:52:50 +0000
Message-ID: <CALeDE9MMCPNtj9yaXdPwbppOsmUSvmuNWdicNLvqZmY2c=h9dw@mail.gmail.com>
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
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

On Mon, Nov 27, 2023 at 3:32=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
>
>
> On Mon, 27 Nov 2023 at 20:08, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Mon, Nov 27, 2023 at 08:06:23PM +0600, Maxim Uvarov wrote:
>> > On Mon, 27 Nov 2023 at 19:08, Tom Rini <trini@konsulko.com> wrote:
>> >
>> > > On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
>> > >
>> > > > Increase allowed binary size to fit lwip code.
>> > > >
>> > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> > > > ---
>> > > >  configs/am335x_evm_defconfig | 1 +
>> > > >  1 file changed, 1 insertion(+)
>> > > >
>> > > > diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_def=
config
>> > > > index f048e60f7f..9fd608bd76 100644
>> > > > --- a/configs/am335x_evm_defconfig
>> > > > +++ b/configs/am335x_evm_defconfig
>> > > > @@ -124,3 +124,4 @@ CONFIG_WDT=3Dy
>> > > >  CONFIG_DYNAMIC_CRC_TABLE=3Dy
>> > > >  CONFIG_RSA=3Dy
>> > > >  CONFIG_LZO=3Dy
>> > > > +CONFIG_SPL_MAX_SIZE=3D0x29000
>> > >
>> > > As probably a problem for other platforms you made this change on to=
o,
>> > > you can't do this. The link limit is here because that's the limit t=
he
>> > > hardware (and ROM) imposes.
>> > >
>> > > You might need to either:
>> > > - Figure out how to make lwip even tinier for the SPL case
>> > > - Limit the old network stack to just for SPL, and a later task is t=
o
>> > >   reduce what's in the old stack to just what's also needed within S=
PL.
>> > >
>> > >
>> > Thanks Tom. All these size changes need to be reviewed.  Some of them =
are
>> > ok, I think like for x86 or qemu virt, but some of them might not work=
.
>> >
>> > Question - Do we need networking inside SPL rather than in the main bi=
nary?
>> > Is it a real use case?
>>
>> Yes, the device supports loading SPL, and then SPL loading U-Boot both
>> over USB RNDIS as well as regular physical ethernet.
>>
>> --
>> Tom
>
>
> That looks like not a production use case. USB + NET + drivers + EXT4 + N=
AND + MTD and everything else and trying to fit into SPL.
> With enabling LTO I still need 4k (without dropping current code). From o=
ne point it's too synthetic use case here and might be a historical
> limitation which we will not see on future boards. From the other point i=
t will be good to not break it somehow....

Does this still include the old network code?

Also I wonder if we can have a paired down SPL_LWIP option that
removes things like PXE and HTTP/wget because none of those would be
used in the SPL use case as they're all brand new.

Peter
