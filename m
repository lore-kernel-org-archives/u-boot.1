Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8452FC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 19:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA45882B6;
	Sat, 18 May 2024 21:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UnPojwtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BEF882B8; Sat, 18 May 2024 21:57:47 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC51287F39
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 21:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-572d83e3c7eso6640052a12.3
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716062264; x=1716667064; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bffhg0X7HWdXcCVfj9JRAgoe8gkNWP0KKYOqpYHVBmE=;
 b=UnPojwtbbaQrOTCxrk7gRy9Yr0QG4HgCyxnpnfspHS9psBovUp4Y1IlD4AQafLEx+t
 VjVzyX2OlzcbCQy/W15hxAg1Ss9xcNpGawae4Ot1HWZFdClNyo+/uuGJgo15E1kX3LxC
 lDfQQWvgKL+SlEn2eMT9r6W03WZo0EcLSu5j8HjM2mmkYomDg65aq3GyI53Rx2tHiurI
 vn0JsxmeJtwj6SBGHp77QCLvrIASsbS+Ly3niiG4qHm/Jm6XI8e7PhW7fYXbIWnUKtJf
 N0OnBoEQjSMpoBV83O2fsEQfGWTy24bWMnZzbq4zx5HHMNyWMVnw+fntyxGtoLjT1FhD
 iA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716062264; x=1716667064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bffhg0X7HWdXcCVfj9JRAgoe8gkNWP0KKYOqpYHVBmE=;
 b=wn9Jrwsu48CQmfB48qV+iWFqyFMKuhDxw+tHqn0hhALsROeLyY6bWYUqLhWs+MsF/p
 nqt8OH0w0/Tq7gL1/1g0DHOhvfvUzxp9Kpec28kok2Y8iWSAvP08yXVdKvzQi6YNI2c6
 5Bk1P1T9SqGT1iEJ9XmbY4Em19ru42ADe0omjFrudrKF+VOVAyB1eBn5yHzT/gNSdCgt
 94iiEfcaxYCl/xklqimFgTcOdTUCf4XjjeZVmEsdafHMsBu+9nTIxle0sUq4M7XdZwwW
 6dtR5nTSogfLgb4Wnj2H99f35cWLGt3LB/D/mZqazvxAhwKAozt7T5Z7xezyj+J+gjlm
 NaGA==
X-Gm-Message-State: AOJu0YwFzK0drOROxdPc3DBae2BPpj5yLypSHspPD1veolaIalZyQR9f
 KKfdemahwPVjjpa4ULxrVpBA+AclMLE6d6fSof5HphZzlef68RL4TExQzpMLdAWwUsZDf3VhgsZ
 L7NkxoUEBSLdQg3JTVdbheM6BMxg=
X-Google-Smtp-Source: AGHT+IGKva84it/adDOyexI/rI90Vln7GVy0ga90wqsSGQnYUzWAKuGjroPDCFUEzA/c47STAhSoF1eYFnNDnY1CuqM=
X-Received: by 2002:a05:6402:27cd:b0:573:555e:6d89 with SMTP id
 4fb4d7f45d1cf-573555e6e72mr17572332a12.1.1716062264122; Sat, 18 May 2024
 12:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240516104245.2075748-1-fiona.klute@gmx.de>
 <CAJaLiFw1BD6rtMd8E3eejM62YY9W+YA9fmP9FGkiN1KE0fwgZw@mail.gmail.com>
 <f1f07df1-758c-4329-8449-a187cb378c1d@gmx.de>
In-Reply-To: <f1f07df1-758c-4329-8449-a187cb378c1d@gmx.de>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sat, 18 May 2024 12:57:32 -0700
Message-ID: <CAJaLiFzWb_DrV1rqaULNW6PvwKChT3wm=R59VAatSUBtBvLyPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc: Detailed example for netconsole setup
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Fiona,

Added Heinrich to CC list.

On Sat, May 18, 2024 at 4:05=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de> wr=
ote:
>
> Hi Tony!
>
> Am 16.05.24 um 21:28 schrieb Tony Dinh:
> > On Thu, May 16, 2024 at 3:43=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de=
> wrote:
> >>
> >> This adds details that I would have liked to have readily available,
> >> in particular how to activate the network interface before enabling
> >> netconsole, and how to integrate netconsole so you can use the U-Boot
> >> prompt.
> >>
> >> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> >> ---
> >> Changes in v2:
> >> * Include stderr redirection
> >> * Use 4 spaces instead of tabs for code block to avoid overflowing
> >>    lines
> >>
> >>   doc/usage/netconsole.rst | 33 ++++++++++++++++++++++++++++++++-
> >>   1 file changed, 32 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
> >> index 2aa3b9ccc5..647f0c220b 100644
> >> --- a/doc/usage/netconsole.rst
> >> +++ b/doc/usage/netconsole.rst
> >> @@ -18,7 +18,9 @@ broadcast address and port 6666 are used. If it is s=
et to an IP
> >>   address of 0 (or 0.0.0.0) then no messages are sent to the network.
> >>   The source / listening port can be configured separately by setting
> >>   the 'ncinport' environment variable and the destination port can be
> >> -configured by setting the 'ncoutport' environment variable.
> >> +configured by setting the 'ncoutport' environment variable. Note that
> >> +you need to set up the network interface (e.g. using DHCP) before it
> >> +can be used for network console.
> >>
> >>   For example, if your server IP is 192.168.1.1, you could use::
> >>
> >> @@ -107,3 +109,32 @@ as follows:
> >>
> >>   Note that unlike the U-Boot implementation the Linux netconsole is
> >>   unidirectional, i. e. you have console output only in Linux.
> >> +
> >> +Setup via environment
> >> +---------------------
> >> +
> >> +If persistent environment is enabled in your U-Boot configuration, yo=
u
> >> +can configure the network console using the environment. For example:=
:
> >> +
> >> +    =3D> env set autoload no
> >> +    =3D> env set hostname "u-boot"
> >> +    =3D> env set bootdelay 5
> >> +    =3D> env set nc 'dhcp; env set stdout nc; env set stderr nc; env =
set stdin nc'
> >> +    =3D> env set ncip 192.168.1.1
> >> +    =3D> env set preboot "${preboot}; run nc;"
> >> +    =3D> env save
> >> +    =3D> reset
> >> +
> >> +``autoload no`` tells the ``dhcp`` command to configure the network
> >> +interface without trying to load an image. ``hostname "u-boot"`` sets
> >> +the hostname to be sent in DHCP requests, so they are easy to
> >> +recognize in the DHCP server log. The command in ``nc`` calls ``dhcp`=
`
> >> +to make sure the network interface is set up before enabling
> >> +netconsole.
> >> +
> >> +Adding ``nc`` to ``preboot`` tells U-Boot to activate netconsole
> >> +before trying to find any boot options, so you can interact with it i=
f
> >> +desired.
> >> +
> >> +``env save`` stores the settings persistently, and ``reset`` then
> >> +triggers a fresh start that will use the changed settings.
> >> --
> >> 2.43.0
> >>
> >
> > Just for information, if the board uses static IP then the example
> > would be slightly different. I usually use static IP and ping the
> > netconsole server to make sure it is up. However, I think this DHCP
> > example is good enough to show how to prepare and activate netconsole.
>
> Maybe it'd make sense to link to a general network setup section for
> alternatives? The problem is I can't find any in the existing docs, the
> closest I see is the "Automatically updated variables" list:
> https://docs.u-boot.org/en/latest/usage/environment.html#automatically-up=
dated-variables
>
> As far as I understand you can also set the environment variables
> mentioned there manually to configure networking, but I'm not sure if
> that applies to all of them.
>
> Is my understanding correct? If yes, I could send a separate patch to
> add that information, and maybe rename the section to "Network
> configuration variables".

Currently, there is no documentation for using static IP in netconsole
that I'm aware of. I think it would be great if you send a separate
patch after this. Basically, the current u-boot network driver model
will automatically bring up the network when we try to use it, e.g.
pinging a server, or dhcp.

So the difference is instead of dhcp in your example, we could also do this=
:

env set ipaddr 192.168.1.100
env set nc 'if ping ${ncip}; then env set stdout nc; env set stderr
nc; env set stdin nc; fi'

Note that the board ipaddr needed to be set before the ping.

All the best,
Tony

>
> Best regards,
> Fiona
>
> > Reviewed-by: Tony Dinh <mibodhi@gmail.com>
> >
> > All the best,
> > Tony
>
