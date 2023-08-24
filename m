Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2592C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765EA86529;
	Thu, 24 Aug 2023 16:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="HzMXImXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B777865AF; Thu, 24 Aug 2023 16:41:40 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E524E86414
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4ff9abf18f9so10545950e87.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692888096; x=1693492896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uLaJ/j8NxW6yR3qxt0lCqUZtbm6v9JpgWEwv3XtA6sM=;
 b=HzMXImXhKDOC49LTXyAdjUt+FbyMyoyDAUN9O61+TdxBMGCq78LdorOkbVbyLILu0g
 1cChcvTe5VRQ/RVBJ1IjnoqokGWBmxmeuVPjLJizgZIUWzJ1028UCkkwB6gpKqg57MqG
 E4rwV3q8zeKx7EAQsnvO7tB3e9RI7zZnfbNWSg6WGd09OO24H7T/aDgstq7OXB5ne4lv
 tPF24dI3uxVjC/EQRezPR6AnxNRlzt1hePRCYn7UDyvu+N5CynT3LwvFOe/9/x187J6Q
 Km/gf5kg4WSHFQc2f5ExIt0BLmRFKVKV8D5MUa9oBc+sjGVTE8GFf+Lm6Zqam+EmXjsK
 JU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888096; x=1693492896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLaJ/j8NxW6yR3qxt0lCqUZtbm6v9JpgWEwv3XtA6sM=;
 b=BZMMj3WzjTlY1o8Uc8OQc9ZEfJQ033k6RjsCBAyNxkn54mvcqxHSMCA1kUBtxJ7Yjv
 VVA+G2PhFnfPU7x1NH2qD0nNJvPYmp6ISPmV+9upF4vIxU+yvwf8uJ8w8xSgWSM5dWFX
 LVlZ/I4ITivPrNY03pKt2nfIt4j1r05Jp6/w8+E8p4b0PJ+mBoiMEeH0NPTMc38QGl9Z
 /hCainHa+oS95D7lhBaQ/MWYGF0xmlrWFcKG50T67YVLVnm1HNDq/oTFEwzUvnLfM09A
 Qq9a9uWZVRxTuu/m7z4reNodGpp0yGZG1uUSlg93CFJ+ef6ODSh5HC607viARRvbzr2T
 bHMg==
X-Gm-Message-State: AOJu0Yy4wrCwFvdAcT3eSaaUK6ZtMfddqCKXZGqSZzlgRlKsbvhQlF3c
 8V46XYIJcOJKdprWYfyqQKJ5gJBcn53ZZuhb4WDImg==
X-Google-Smtp-Source: AGHT+IF64ukT/xUKGuFOG6FpzIvk+5FagvDrLm7OH7oR09NrKaU0esX+JU2CwepZIJkkHGKABvcmTWwQyFrkD+X9n4s=
X-Received: by 2002:a05:6512:2fc:b0:4fe:193c:de74 with SMTP id
 m28-20020a05651202fc00b004fe193cde74mr10700706lfq.18.1692888095828; Thu, 24
 Aug 2023 07:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
 <20230824032709.phneggflsw2ps2dv@reanalyze>
 <a3af68c4-490d-f3e2-a9ed-acd650ac0452@ti.com>
 <20230824142050.GL3953269@bill-the-cat>
In-Reply-To: <20230824142050.GL3953269@bill-the-cat>
From: Simon Glass <sjg@google.com>
Date: Thu, 24 Aug 2023 08:41:23 -0600
Message-ID: <CAPnjgZ23_aCG6XqJBwnVkrm3kcuwkz=-geQTX5BbX9rP+w49fA@mail.gmail.com>
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

Hi,

On Thu, 24 Aug 2023 at 08:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 24, 2023 at 06:46:57PM +0530, Neha Malcom Francis wrote:
> > Hi Simon, Nishanth
> >
> > On 24/08/23 08:57, Nishanth Menon wrote:
> > > On 21:01-20230823, Simon Glass wrote:
> > > > Hi Nishanth,
> > > >
> > > > On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
> > > > >
> > > > > On 17:57-20230823, Simon Glass wrote:
> > > > > [...]
> > > > > > > This is how we have a common bit of rST for how to build N boards,
> > > > > > > without having to do a literal copy and paste N times.
> > > > > >
> > > > > > How about using this?
> > > > > >
> > > > > > https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#substitution-definitions
> > > > >
> > > > > I was not able to succeed with complex includes such as:
> > > > > https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.rst?plain=1#L89
> > > > >
> > > > > am62x complete build procedure defined once and reused in other am62x
> > > > > platforms.. But the am62x build procedure itself is reused from common
> > > > > k3 build steps.
> > > >
> > > > I followed through these instructions. I find the env vars quite
> > > > confusing, since I don't really know what it is doing. It feels like a
> > > > script:
> > > >
> > > > do $a $b $c
> > > > do $f $e
> > > >
> > > > it is pretty hard to follow. I think it would be better to write
> > > > everything out in full for each board, like rockchip does.
> > >
> > > Unfortunately, this is a few major steps that is repeated for
> > > (currently):
> > >     AM62x SK
> > >     Toradex Verdin
> > >     (pending: beagleplay - )
> > >     (once all the dust clears up, hopefully phytec)
> > >     SK-LP
> > >     ....
> > >
> > > I have no reasonable way to offer to keep them all in sync.
> > >     https://libera.irclog.whitequark.org/u-boot/2023-07-26#34662854;
> > > is kind of why I went down this path.S
> > >
> > > >
> > > > Some other minor feedback:
> > > >
> > > > - The 'make' lines should really have -j $(nproc) added
> > >
> > > Different styles of shells..
> > >
> > > > - The $ signs at the start of each command in the docs are a pain
> > > > since it stops me copying the commands into the terminal - can you
> > > > remove them?
> > >
> > > hehe.. "dont" let people blindly copy paste without understanding what is
> > > going on argument?
> > >
> > > If folks are OK, I sure can send a different patch series for that.. (or
> > > maybe motivate someone to do that instead of me ;))
> > >
> > >
> > > > - It doesn't build for me:
> > > >
> > > >    BINMAN  .binman_stamp
> > > > Image 'ti-dm' is missing external blobs and is non-functional: blob-ext
> > > >
> > > > /binman/ti-dm/blob-ext (ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f):
> > > >     Missing blob
> > > >
> > > > Some images are invalid
> > > > make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefile:1115:
> > > > .binman_stamp] Error 103
> > > > make[1]: Leaving directory '/tmp/b/play'
> > > > make: *** [Makefile:177: sub-make] Error 2
> > >
> > >
> > > ^^ Neha: This is what I was complaining about.
> > >
> > > https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?highlight=am62#sources
> > >
> > > source: https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
> > > is missing, we never used to break build previously binman converted now does.
> > >
> > > I am wondering if I need to explicitly call out git clone instructions
> > > out..
> > >
> >
> > Right... this does seem to be a complaint that keeps coming up.
> >
> > Simon, my intention at the time of sending out the patch was that anyone
> > building the board should "not NOT" have the DM binary. The way we
> > structured the filename was that it looks at BINMAN_INDIRS to find
> > ti-dm/ipc_echo_testb_mcu1_0_release_strip.xer5f but I guess this is a
> > confusing way to put it across. Maybe we should rework that. Or not throw an
> > error at all when DM isn't found.
>
> Well, is DM required or not? If it's optional, we have flags to mark it
> optional.  If it's required, we have flags for make and buildman to tell
> binman "fake it".  I am wondering if we still have the ability to have a
> more verbose "need it, can't find it" error message, and so that's where
> it should say that you forgot to set BINMAN_INDIRS or clone the firmware
> repository.

If it is optional, use the 'optional' tag on the entry You will get a
warning but not an error. At the moment it is saying that the image is
non-functional, which is not good.

Regards,
Simon
