Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E611C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F099865A5;
	Thu, 24 Aug 2023 16:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="N/3DW9qf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173D286672; Thu, 24 Aug 2023 16:46:59 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04E988077D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so3195854a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692888415; x=1693493215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3RXFCxdUlIiaskDbwX5JWlzY8mjtVEmsQd2Yc5eP6eE=;
 b=N/3DW9qfLFZ00eU4IbJSqCmUSHM1F1csxal8DYiS2x/n5qPkWocN78xUqSx01Q0ydd
 hGrEPYKbnc8VYhj98+FArqESEAemQb2Xf3gd9o61edPNRzXpSAWtGWxbd1C9kCl3AkTN
 5qFqqWEUWC7zQXXiFBnv4YR07qBiONol6VLrwMGrGQ246qASn73+UhpBWcFC6vdtpW4b
 OLSd0rUkcgsoQFS88Kr1pU06k5r/dPVp31tLG6ykTMVQumUIus0Qd+kA3h3F41ciqtC4
 l7R47zCha0NyaMzAfu9NqV2vHql+iaZ54OlxCu1g1f99f+Nx1tH/H4iiaTLalVetd9Rz
 o/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888415; x=1693493215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RXFCxdUlIiaskDbwX5JWlzY8mjtVEmsQd2Yc5eP6eE=;
 b=kdkIWwpGckXd5+lE15vNBH3OZ9MXiOJ3t6o548eISpJfGLi4jycDwfd5uMvKqixg2n
 VKs8RmXIpQqWVIW5cf5Xa6MAOMLJBkzsNYDsiXGehXW5agkqRz6gMOa0yxjYBSsiIKct
 XMEdOByDdyvF9fxYdCIhycKp2D8cmZouot2/72tz3/mLbmxzF7kCyYKQKlO7WgO71AdM
 3JGzDflWym5Jud31cdYON3IFJcdRqW3s0udh9A6mH52QsnaaPzqE8nHWCtvxqtr/yKK6
 DmH+hxvZx1iP3LPplJY0OzOjq2rdqhWxF1hsBi7RQbLQZ1SFCo2KgV3P/Qwa3JsRSPbt
 rzKQ==
X-Gm-Message-State: AOJu0YzyQX9cT+fW7iNxwtRie619FLkeOHh3ya35ijQRN8bDGfEIcNoA
 idhFo4VYxN59Bksyvv1kop3fAtsfr9rvwO3mnaqQyQ==
X-Google-Smtp-Source: AGHT+IEJV0GVrtVJniaWff5/TRRsOhqq8n5NAE+Lipqs1OJh7KGDsK41QV8hNCWmA5mHJTurF8qHoKDDkid33gM0TJQ=
X-Received: by 2002:aa7:d3d2:0:b0:521:8777:b00d with SMTP id
 o18-20020aa7d3d2000000b005218777b00dmr11807112edr.15.1692888415389; Thu, 24
 Aug 2023 07:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
 <20230824032709.phneggflsw2ps2dv@reanalyze>
 <a3af68c4-490d-f3e2-a9ed-acd650ac0452@ti.com>
 <20230824142050.GL3953269@bill-the-cat>
 <CAPnjgZ23_aCG6XqJBwnVkrm3kcuwkz=-geQTX5BbX9rP+w49fA@mail.gmail.com>
 <20230824144358.GO3953269@bill-the-cat>
In-Reply-To: <20230824144358.GO3953269@bill-the-cat>
From: Simon Glass <sjg@google.com>
Date: Thu, 24 Aug 2023 08:46:44 -0600
Message-ID: <CAPnjgZ3Z=7Mfs+QC-YSU9NNKq4UnY0C-b891TdtDMJRgLdYUpQ@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
To: Tom Rini <trini@konsulko.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 24 Aug 2023 at 08:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 24, 2023 at 08:41:23AM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Thu, 24 Aug 2023 at 08:20, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 24, 2023 at 06:46:57PM +0530, Neha Malcom Francis wrote:
> > > > Hi Simon, Nishanth
> > > >
> > > > On 24/08/23 08:57, Nishanth Menon wrote:
> > > > > On 21:01-20230823, Simon Glass wrote:
> > > > > > Hi Nishanth,
> > > > > >
> > > > > > On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
> > > > > > >
> > > > > > > On 17:57-20230823, Simon Glass wrote:
> > > > > > > [...]
> > > > > > > > > This is how we have a common bit of rST for how to build N boards,
> > > > > > > > > without having to do a literal copy and paste N times.
> > > > > > > >
> > > > > > > > How about using this?
> > > > > > > >
> > > > > > > > https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#substitution-definitions
> > > > > > >
> > > > > > > I was not able to succeed with complex includes such as:
> > > > > > > https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.rst?plain=1#L89
> > > > > > >
> > > > > > > am62x complete build procedure defined once and reused in other am62x
> > > > > > > platforms.. But the am62x build procedure itself is reused from common
> > > > > > > k3 build steps.
> > > > > >
> > > > > > I followed through these instructions. I find the env vars quite
> > > > > > confusing, since I don't really know what it is doing. It feels like a
> > > > > > script:
> > > > > >
> > > > > > do $a $b $c
> > > > > > do $f $e
> > > > > >
> > > > > > it is pretty hard to follow. I think it would be better to write
> > > > > > everything out in full for each board, like rockchip does.
> > > > >
> > > > > Unfortunately, this is a few major steps that is repeated for
> > > > > (currently):
> > > > >     AM62x SK
> > > > >     Toradex Verdin
> > > > >     (pending: beagleplay - )
> > > > >     (once all the dust clears up, hopefully phytec)
> > > > >     SK-LP
> > > > >     ....
> > > > >
> > > > > I have no reasonable way to offer to keep them all in sync.
> > > > >     https://libera.irclog.whitequark.org/u-boot/2023-07-26#34662854;
> > > > > is kind of why I went down this path.S
> > > > >
> > > > > >
> > > > > > Some other minor feedback:
> > > > > >
> > > > > > - The 'make' lines should really have -j $(nproc) added
> > > > >
> > > > > Different styles of shells..
> > > > >
> > > > > > - The $ signs at the start of each command in the docs are a pain
> > > > > > since it stops me copying the commands into the terminal - can you
> > > > > > remove them?
> > > > >
> > > > > hehe.. "dont" let people blindly copy paste without understanding what is
> > > > > going on argument?
> > > > >
> > > > > If folks are OK, I sure can send a different patch series for that.. (or
> > > > > maybe motivate someone to do that instead of me ;))
> > > > >
> > > > >
> > > > > > - It doesn't build for me:
> > > > > >
> > > > > >    BINMAN  .binman_stamp
> > > > > > Image 'ti-dm' is missing external blobs and is non-functional: blob-ext
> > > > > >
> > > > > > /binman/ti-dm/blob-ext (ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f):
> > > > > >     Missing blob
> > > > > >
> > > > > > Some images are invalid
> > > > > > make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefile:1115:
> > > > > > .binman_stamp] Error 103
> > > > > > make[1]: Leaving directory '/tmp/b/play'
> > > > > > make: *** [Makefile:177: sub-make] Error 2
> > > > >
> > > > >
> > > > > ^^ Neha: This is what I was complaining about.
> > > > >
> > > > > https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?highlight=am62#sources
> > > > >
> > > > > source: https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
> > > > > is missing, we never used to break build previously binman converted now does.
> > > > >
> > > > > I am wondering if I need to explicitly call out git clone instructions
> > > > > out..
> > > > >
> > > >
> > > > Right... this does seem to be a complaint that keeps coming up.
> > > >
> > > > Simon, my intention at the time of sending out the patch was that anyone
> > > > building the board should "not NOT" have the DM binary. The way we
> > > > structured the filename was that it looks at BINMAN_INDIRS to find
> > > > ti-dm/ipc_echo_testb_mcu1_0_release_strip.xer5f but I guess this is a
> > > > confusing way to put it across. Maybe we should rework that. Or not throw an
> > > > error at all when DM isn't found.
> > >
> > > Well, is DM required or not? If it's optional, we have flags to mark it
> > > optional.  If it's required, we have flags for make and buildman to tell
> > > binman "fake it".  I am wondering if we still have the ability to have a
> > > more verbose "need it, can't find it" error message, and so that's where
> > > it should say that you forgot to set BINMAN_INDIRS or clone the firmware
> > > repository.
> >
> > If it is optional, use the 'optional' tag on the entry You will get a
> > warning but not an error. At the moment it is saying that the image is
> > non-functional, which is not good.
>
> Yes, and I believe these are non-optional firmwares, so do we still have
> the ability to produce a more specific and verbose error message?

Yes, see the 'missing-msg' tag and the 'missing-blob-help' file. This
should work for any external block, whether missing or faked, optional
or required,

Regards,
Simon
