Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE49CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 230B686D41;
	Mon, 25 Sep 2023 17:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UFdNXbM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC8C86D4A; Mon, 25 Sep 2023 17:12:40 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 181CA86C67
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32003aae100so5346348f8f.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695654757; x=1696259557; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0AwP1UC7uS8QqyE4+y2OkfHIhiI0Zc45IGVZHK6Zs4=;
 b=UFdNXbM5WI6NQDYWHCTo0slqp3W6ElT5R/ZhlnPd6ORXP2887yXJ5mGbawPJJT2kyr
 /PMSS0AaqQxM2Sm5QZMZUaBK/7BgIwQ+RjG+27xgxgoTRwcdY0tSlHn+QHIRjLFQA9Gs
 1b9C/YEIKpjo3Hbt/ooARfTcsG8PFSIbsQzRdriNQe9ezWnbRCHBWW8AQlQOdR4BP8ph
 4r3rbq7/W684QQ09plt9j+gLbCtuepvUBkSQ59L8oXe+gQvS9WNiEz1KmA3UAoAEUPC7
 itP6rWThuOQOKPjyQ4M+yEBxt8alIgm5S+CEshHB5usdZGCxdePwhG/W6+hO1Q26It3u
 yFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695654757; x=1696259557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0AwP1UC7uS8QqyE4+y2OkfHIhiI0Zc45IGVZHK6Zs4=;
 b=bHVum6mH7gQivMO/w/UGrJgnbylQMc1LVpz99sgxyqIGsCJDpKRPn2s4hyrYy/9Ele
 NgAY0DR8s4F16TqxJJlXdJHiOdAtqPGecgFMI3FQ58wIk6LU4FxBaAw0MRhv5JBmkH0g
 VkYYEv4iMqAIou7zHmsqKqyuaIxuQ9/S4br5sPL0BPta+JjVDLTgOEdNVI8JUPHh2LwA
 5b2OJ+avHthsOT9un5pZ+nmKzqn4GJOTAP/Q7JHK81UsrgFi+NM3jZG7WNFJOXeqaJdU
 7fX9uHuPl9KEbjqR5pEDgq11FLG3tmO8BVcZBC9fdFUceF1QZSZDcBYRYOA5SyvD7lJp
 N0GQ==
X-Gm-Message-State: AOJu0YwKSmjm+3unLNnH/c8iNGU8dEeqneSf40zJ8zbhe3DulOvH4C8z
 b5fAMDfYPlpsSVGP5j1DBnK3QpHBwoGt6DWv8yc=
X-Google-Smtp-Source: AGHT+IEdDgM0FVco0sI/x88axF5fW4gHg6Z5HfsE4tYn9hpoTbFRFgUDH4hrW0f1wvRKDE4ybdLofTh9wQ6uzaRxqDM=
X-Received: by 2002:adf:f485:0:b0:313:e391:e492 with SMTP id
 l5-20020adff485000000b00313e391e492mr5962113wro.17.1695654757331; Mon, 25 Sep
 2023 08:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
 <20230823155558.GM3953269@bill-the-cat>
 <C098A4DC-CE20-4516-8971-B52041120BCD@gmail.com>
 <20230925150534.GA305624@bill-the-cat>
In-Reply-To: <20230925150534.GA305624@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 25 Sep 2023 18:12:26 +0300
Message-ID: <CAPVz0n1F7c7m0=CfLTF8n1Qx2B83nv73VJrUWNHoZJeoeAe_eQ@mail.gmail.com>
Subject: Re: Config fragments
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>,
 Andrew <afd@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

=D0=BF=D0=BD, 25 =D0=B2=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 18:05 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Sep 25, 2023 at 04:18:45PM +0300, Svyatoslav Ryhel wrote:
> >
> >
> > 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 18:55:58 GMT+03:00=
, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
> > >On Wed, Aug 23, 2023 at 09:30:31AM -0600, Simon Glass wrote:
> > >
> > >> Hi,
> > >>
> > >> Up until 2023.04 it has been possible to build all the defconfigs bu=
t
> > >> with 2023.07 that changed. Tom mentioned this to me recently.
> > >
> > >I'm adding Svyatoslav who is the person that brought in all of the
> > >config fragments that are going to be in v2023.07.
> > >
> > >> Up until 2023.04 we can enumerate all the board configs that can be
> > >> built. We can build any of them using a single name and a single
> > >> defconfig. The boards.cfg file which buildman creates contains a ful=
l
> > >> list of things that can be built.
> > >>
> > >> From 2023.07 this changes and we now have random .config files
> > >> sprinkled about the place. I say random because they are not connect=
ed
> > >> to anything. For example, here is
> > >
> > >They aren't random.  They're, just for v2023.07, in configs/ and then
> > >moving forward, they're in the board directory.  I would like to see
> > >them in more places possibly, but that's not something I'm sure enough
> > >on right now.
> > >
> > >> board/ti/am62x/MAINTAINERS:
> > >>
> > >> AM62x BOARD
> > >> M: Dave Gerlach <d-gerlach@ti.com>
> > >> M: Tom Rini <trini@konsulko.com>
> > >> S: Maintained
> > >> F: board/ti/am62x/
> > >> F: include/configs/am62x_evm.h
> > >> F: configs/am62x_evm_r5_defconfig
> > >> F: configs/am62x_evm_a53_defconfig
> > >>
> > >> BEAGLEPLAY BOARD
> > >> M:     Nishanth Menon <nm@ti.com>
> > >> M:     Robert Nelson <robertcnelson@gmail.com>
> > >> M:     Tom Rini <trini@konsulko.com>
> > >> S:     Maintained
> > >> N:     beagleplay
> > >>
> > >> In most cases the MAINTAINERS file tells us about each board and unt=
il
> > >> [1] I had assumed that was the case. With that patch reverted, these
> > >> are the only 'orphaned' MAINTAINERS entries (buildman
> > >> --maintainer-check):
> > >>
> > >> WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> > >> ending at line 8
> > >> WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS endin=
g at line 44
> > >> WARNING: orphaned defconfig in
> > >> board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> > >> WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at=
 line 6
> > >> WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at =
line 15
> > >>
> > >> But Tom advised me that MAINTAINERS is not intended for this purpose=
,
> > >> so the check has been dropped. I am not suggesting we bring it back,
> > >> necessarily, but if we did, we could use it to specify the .config a=
nd
> > >> defconfig files which are used by each board.
> > >
> > >Note that the "N" syntax has been in use, for defconfigs for a lot
> > >longer, and is why the CI check for unmaintained / orphaned boards
> > >stopped working.
> > >
> > >> *Failing that*, I suggest a new 'name.brd' file in the board directo=
ry
> > >> to contain this information, e.g.
> > >>
> > >> # Contents of board/ti/am62x/beagleplay.brd:
> > >> beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
> > >> beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config
> > >>
> > >> This could be parsed by buildman and other tools, to produce a list =
of
> > >> available boards and to build each using a single name (e.g. make
> > >> beagleplay-r5_defconfig)
> > >>
> > >> What do people think?
> > >
> > >I'm not sure I like this direction honestly.  Do we want CI to cover
> > >these configurations?  Maybe.  But it's just for CI.  Using the TI
> > >examples, I don't know that you can use buildman today to generate a
> > >functional binary (and if you can, if --keep will retain the right
> > >files).
> > >
> > >Maybe we just need to make it clear that if you use config fragments
> > >then you're opting out of CI for that specific platform.  That should =
be
> > >fine for example for the TI ones that will be built in OE a bunch
> > >anyhow so accidental failure to builds will be caught.  I don't know
> > >about the Tegra platforms.
> > >
> >
> > Greetings! Are there any progress regards fragments move or this will
> > hang in mailing list indefinitely?
>
> I don't follow, sorry.  Yes, please send a patch on top of next to move
> the fragments for Tegra platforms to match how they're done for TI
> platforms now.
>
> --
> Tom

Oh, so it was merged already into next, sorry did not check the next branch=
.
Tegra fragments move patch was already sent a month ago alongside
other board improvements, waiting for Thierry now. Thanks!
