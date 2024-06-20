Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55470C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 21:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B51D787D9B;
	Thu, 20 Jun 2024 23:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RpCuX9Y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B52883D9; Thu, 20 Jun 2024 23:58:07 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 519F087D43
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 23:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dfb05bcc50dso1244836276.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718920684; x=1719525484; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+wCpB8T/qYAvBe2oICOCTGBHWLoWx/OEJb7OcnqRlo=;
 b=RpCuX9Y6hdzS0r28DXmO90GETdlFfQYGUiZa/Sn4tEbAu99/Oq+8mN+gH2C/kvBkHw
 bJ4Js3Dfv2zSj7cf0+2feGHi8aSi3w5tiGRZaRfE50RVAl5mZ2Oqb4DHvSlYI8wBKTzu
 A9shP7cVJhUgGa5A8ctvqMPyg/NQgECOVf6rZCDYcybeN/ElMKU3qSDjjCvEc2yNsC/B
 xOu6Juot6mlZxrzWHRLWUj2w8XoKw73aInDsCen06PyyFaIkf19DBxIc2+7rLFyPbeFP
 OC+AQEeisGOyVtWZXNbBjj0Qi/m16ag1Szp1W7zAYE6HpHLpA2UNvyD1d/lxCaE+73Ql
 sCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718920684; x=1719525484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+wCpB8T/qYAvBe2oICOCTGBHWLoWx/OEJb7OcnqRlo=;
 b=djIIuVtszw/rQCq0KVzs5uv0SDe31l8kwr0dlSGeXgOWc8Tx0lfMkxU2rfAoMmRdiv
 fFc+ydQAhXRhVogwDNyeMEFTPSBzh9hFBQSboJaY1M3FnR7fhUwzrGKzzx4uQ9cv/8WW
 B4nHZ5kTr6eSYhNcOhZOaFYAmo7XTgurb852/Ab4cWJxB6dQ4za7aVl6yx/vDe9xCcV3
 bHKrQqYiwVRXyc9zCEq+yTZ0YkXuAzDrPVIuio2LsLLK8L4P6vWT27zve1JMY60aF3Ce
 4Tob9nQLpIccau3IMFS4fhCIcSTkuHqpRh4y4pywX6HoRGwLXeR8w+q+he/uVXzcAzVT
 EMng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2gmJUF8pi4Oug5Vw9bE3/jleVp3t0A2ghI89SyqmRp8AgdarScLxzZMaENGV6UOYKuootAhZwgHopjnXBmln+Xm3qfw==
X-Gm-Message-State: AOJu0YyQhZWKUb5P4fLvj0vBt5ik7/9e6iVcD2ND9FdYEmEcIhQH+gLs
 1DkvjcPqy+0cXi4jL24FDDO4dxVCrEmeXLsJ1aHaWll8GcupS7OPwcJLTclZsNPL5r4xQdp0qGr
 /jYYZpLoXdk6iouAC54aaLoC/OUY=
X-Google-Smtp-Source: AGHT+IG9AUhmXDhU7J0v3I+UhAjRvNP4l/HueboMUAt1esAbqeNvfK4v0eisb9c+G8O1eWNuxLIhXqOn6ifi1RlqRZk=
X-Received: by 2002:a25:3610:0:b0:e02:3bf8:be6e with SMTP id
 3f1490d57ef6-e02be100f50mr7167213276.1.1718920683988; Thu, 20 Jun 2024
 14:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240619-play-fdt-fixup-v1-1-18e2a728ca45@ti.com>
 <3f540efd-d428-49e3-bf48-de1e35dd41c3@ti.com>
 <20240620055103.jhn4krwido7nqbwr@dhruva>
 <0777668e-37dd-49c8-9255-8a2a9b8bc8da@ti.com>
 <20240620211519.c6o32wslwoquf26z@submarine>
In-Reply-To: <20240620211519.c6o32wslwoquf26z@submarine>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 20 Jun 2024 16:57:37 -0500
Message-ID: <CAOCHtYht=gUtRGEw8JaRc6v_rYZ5cvNakY6LvuXeRjEMY9Lh9w@mail.gmail.com>
Subject: Re: [PATCH] board: beagle: beagleplay: enable OF_SYSTEM_SETUP
To: Nishanth Menon <nm@ti.com>
Cc: Chirag Shilwant <c-shilwant@ti.com>, u-boot@lists.denx.de,
 Bryan Brattlof <bb@ti.com>, 
 Tom Rini <trini@konsulko.com>, Dhruva Gole <d-gole@ti.com>,
 Andrew Davis <afd@ti.com>
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

On Thu, Jun 20, 2024 at 4:15=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:
>
> On 11:55-20240620, Chirag Shilwant wrote:
> >
> > On 20/06/24 11:21, Dhruva Gole wrote:
> > > On Jun 19, 2024 at 15:44:41 -0500, Andrew Davis wrote:
> > > > On 6/19/24 2:12 PM, Bryan Brattlof wrote:
> > > > > Unfortunately when enabling FDT fixups for the AM62x family of So=
Cs and
> > > > > moving TF-A to the bottom of RAM we missed the BeaglePlay. This i=
s
> > > > > causing Linux's memory allocator to clobber TF-A and break its bo=
ot.
> > > > >
> > > > > Enable OF_SYSTEM_SETUP to fixup the kernel's FDT to inform it of =
the
> > > > > actual location of the firmware
> > > > >
> > > > > CC: Andrew Davis <afd@ti.com>
> > > > > CC: Nishanth Menon <nm@ti.com>
> > > > > CC: Robert Nelson <robertcnelson@gmail.com>
> > > > > Reported-by: Dhruva Gole <d-gole@ti.com>
> > > > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > > > ---
> > > > Acked-by: Andrew Davis <afd@ti.com>
> >
> >
> > Acked-by: Chirag Shilwant <c-shilwant@ti.com>
> >
> >
> >
> > > > > Hello everyone,
> > > > >
> > > > > Fair warning, this may turn into a philosophical discussion about=
 the
> > > > > role of device-tree with SystemReady and U-Boot's role in enablin=
g true
> > > > > distribution to be completely agnostic of the board it's running =
on.
> > > > >
> > > > > However substantively this is simply fixing a boot regression Dhr=
uva
> > > > > found while testing out the beagleplay.
> > > > >
> > > > > Happy reviewing
> > > > > ~Bryan
> > > > > ---
> > > > >    board/beagle/beagleplay/Kconfig | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagl=
eplay/Kconfig
> > > > > index 7dbd833acb4cc..896a1c1be3010 100644
> > > > > --- a/board/beagle/beagleplay/Kconfig
> > > > > +++ b/board/beagle/beagleplay/Kconfig
> > > > > @@ -12,6 +12,7 @@ config TARGET_AM625_A53_BEAGLEPLAY
> > > > >         bool "BeagleBoard.org AM625 BeaglePlay running on A53"
> > > > >         select ARM64
> > > > >         select BINMAN
> > > > > +       select OF_SYSTEM_SETUP
> > > Thanks for the quick fix,
> > > Tested-by: Dhruva Gole <d-gole@ti.com>
> > >
> > > Boot logs upto kernel prompt:
> > > https://gist.github.com/DhruvaG2000/4dc1c1e42207dd98a144f27cc9dff177
> > >
>
>
> Thanks.
>
> Reviewed-by: Nishanth Menon <nm@ti.com>
>
>
> Tom: this is a regression in master and in next - will appreciate if you
> could merge this..

Boot tested on v2024.07-rc4 with my BeaglePlay's..

Tested-by: Robert Nelson <robertcnelson@gmail.com>

--=20
Robert Nelson
https://rcn-ee.com/
