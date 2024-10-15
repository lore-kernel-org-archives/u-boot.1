Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84705D1F9DA
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 21:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCC388966;
	Tue, 15 Oct 2024 23:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="TO5tQ9RG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9275C889E9; Tue, 15 Oct 2024 23:55:03 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EFB388916
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e28fd8cdfb8so5336658276.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1729029300; x=1729634100; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7A+Ger5SD16saeKNXsnp96pPLFwVKPnn4G74GOoGiW0=;
 b=TO5tQ9RGnmLeFNv1R8sr4ebuGcHjw1pnzmYJVODuBaoYTBR0q0tCkBesLdWUHrsewm
 4bB/k6ZvSTvsMzjAOiAEpWjYWD5bR2g5Cfq90wUPpxN0O/oroQ5Du+dlBRk/y7DfqrNj
 igm23HTXXCGwA393cmRIssor0cUg34dFsoCJKeFQ6MICf7wb3FTZx+tN728Emb5PIve8
 Df4UQ/5p4I/M4I4eSxe9H+t8cDz6iCkjP4Voodz3z8ayOOz0X1LWjnoyWOd5tSPPDpCJ
 3PYxb+1wam4GW+CJIREOHcCejOf6RGe2IFrkdchlYkaJ0l2dmwSWD9gjsB7yropUkpEm
 03PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729029300; x=1729634100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7A+Ger5SD16saeKNXsnp96pPLFwVKPnn4G74GOoGiW0=;
 b=UTfXBnlE9yrYCHIdls+Di5F7a7nlP/nLJ2jWnY/wliDafEYcLm9P5c6Cem/xXDowXu
 pzV5HWYiKvP+oU9S5pUMNp9+I/9kLSflExKKW/c+Fb10hgUU0Gh62pfJzlyYpoPCK79V
 /1z8rV7mJe4bEdZ/WZIfjEmXqxWLV99Mo6FAY7Q7QtROmtcA0R67MY3+Mnj7GnX6D+W4
 DKyZJc2SamL4JbmKwSc/iXHCkW8BFAc8aMkmB/TwBNTo1zOe3cfw3gQcMfATADOarR8+
 BQhRdkXjxwZvqHYMzc8n5sC6j051h+7Yt/WfwGM2KXpyOCuX7CoHFtmqI6GvCD9RhMpJ
 CC9g==
X-Gm-Message-State: AOJu0YxdwG5qY74dJ2LLZsWdJOp9BD2QOaHH33LuU8BdW4qmfQf4mtr7
 yI6H/OHUyEvh8yfH/mb7prksBjcgui8tBMO/rkaXVThtQ2d4cXmO2rQ9DsokdQzNiitqNnC5O4t
 CwEL0vp//Ion2QTpMymCpmjFJGfM1yoNcijR6TN5q4+2FdRVtWdA=
X-Google-Smtp-Source: AGHT+IEHZF2LZKKz1RwOWt8mxhbFhfX19D6zoonCrcGuwbGBkNlxJrarviHLnq9w5lex0cPQkBVI7t9UkrlYCDjhK70=
X-Received: by 2002:a05:6902:1584:b0:e29:33d1:a3ac with SMTP id
 3f1490d57ef6-e29782cce1bmr2055872276.11.1729029300124; Tue, 15 Oct 2024
 14:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3wz22Ni+Kqy=NuFiEYPdrRkzjRJDNhYGJcCdDsLpbvBQ@mail.gmail.com>
 <CAFLszThkQ4pVmko8PPK5Yyt5RXFQkSatMycjH7GU5eN-_8L7ZA@mail.gmail.com>
 <CAJ+vNU0auiPUeqbAAFy2K4LhVk3ufU586gJYsZJ4f06wedyfCA@mail.gmail.com>
 <CAFLszTgioVANXZVUTCzHip-gaAVUEyEgO0MsHczLwyNfoBQMqg@mail.gmail.com>
In-Reply-To: <CAFLszTgioVANXZVUTCzHip-gaAVUEyEgO0MsHczLwyNfoBQMqg@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 15 Oct 2024 14:54:48 -0700
Message-ID: <CAJ+vNU16wzb6jwiT3sZdZmR=xZytDHGZKk+S-8zJ0ZXiH-rkbA@mail.gmail.com>
Subject: Re: modify live DT with OF_LIVE breaking phy_connect?
To: Simon Glass <sjg@chromium.org>
Cc: u-boot <u-boot@lists.denx.de>
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

On Mon, Oct 14, 2024 at 1:20=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tim,
>
> On Thu, 10 Oct 2024 at 16:05, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Tue, Oct 8, 2024 at 6:56=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Tim,
> > >
> > > On Mon, 7 Oct 2024 at 14:16, Tim Harvey <tharvey@gateworks.com> wrote=
:
> > > >
> > > > Greetings,
> > > >
> > > > I have a need to adjust the U-Boot device-tree live with some board
> > > > revision specific fixups. It would seem I need to enable OF_LIVE to=
 do
> > > > so but when I do this on imx8mm U-Boot proper seems to fail
> > > > phy_connect() called from the network device probe.
> > > >
> > > > The board I'm working with is an imx8mm-venice board and using
> > > > imx8mm_venice_defconfig (without OF_LIVE) results in:
> > > > U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:58:38 -0700)
> > > >
> > > > CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> > > > CPU:   Industrial temperature grade (-40C to 105C) at 44C
> > > > Reset cause: POR
> > > > Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
> > > > DRAM:  4 GiB
> > > > Core:  226 devices, 32 uclasses, devicetree: separate
> > > > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s t=
imeout)
> > > > MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> > > > Loading Environment from MMC... Reading from redundant MMC(2)... OK
> > > > In:    serial@30890000
> > > > Out:   serial@30890000
> > > > Err:   serial@30890000
> > > > SEC0:  RNG instantiated
> > > > Net:   GPY111 eth0: ethernet@30be0000 [PRIME]
> > > > GSC     : boot watchdog disabled
> > > > Thermal protection:enabled at 96C
> > > > Hit any key to stop autoboot:  0
> > > >
> > > > Yet as soon as I enable OF_LIVE:
> > > >
> > > > U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:59:35 -0700)
> > > >
> > > > CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> > > > CPU:   Industrial temperature grade (-40C to 105C) at 49C
> > > > Reset cause: POR
> > > > Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
> > > > DRAM:  4 GiB
> > > > Core:  214 devices, 32 uclasses, devicetree: separate
> > > > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s t=
imeout)
> > > > MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> > > > Loading Environment from MMC... Reading from redundant MMC(2)... OK
> > > > In:    serial@30890000
> > > > Out:   serial@30890000
> > > > Err:   serial@30890000
> > > > SEC0:  RNG instantiated
> > > > Net:   Could not get PHY for mdio: addr 0
> > > > Could not get PHY for FEC0: addr 0
> > > > Could not get PHY for mdio: addr 0
> > > > Could not get PHY for FEC0: addr 0
> > > > No ethernet found.
> > > > ^^^ phy_connect failing
> > > >
> > > > Any idea what I'm missing here?
> > > >
> > > > Are there other ways I should be modifying the live dt in U-Boot?
> > >
> >
> > Hi Simon, thanks for the response.
> >
> > > I am not sure, but the best option would be to debug the PHY stuff an=
d
> > > try to see what is going wrong.
> > >
> > > Since the number of devices is smaller, I suspect that there is some
> > > code which doesn't use the ofnode API. But it is hard to say what is
> > > going on.
> > >
> >
> > ok, I will look into that
> >

I did manage to get livetree working on imx8mm (the documentation in
livetree.rst was very helpful). There are several imx drivers like
pinctrl that need livetree conversion updates which I'll submit when I
get a handle on this.

> > > For modifying the devicetree, you can do it just before relocation
> > > using the flattree if you like. The reason livetree is better is that
> > > the nodes don't move around when changes are made.
> > >
> >
> > Where is relocation done in this case where I'm using SPL and U-Boot
> > proper for imx8m based boards?
>
> It is always done at the end of board_init_f() in U-Boot proper.
>

Is the reason modification needs to be done before relocation simply
that it can't be expanded without relocating it again?

> >
> > If I want to utilize dt overlays in U-Boot proper can you point me to
> > what is needed or some examples?
>
> You could use a FIT in SPL and select the correct DT there, avoiding
> needing to change it in U-Boot. But if it is really run-time behaviour
> and not described by different models, then that won't work.
>
> There is board_fix_fdt() where you can find some examples. We should
> really tidy up all the DT stuff...
>

ok thanks - I see good documentation in fdt-fixup.rst and several
boards using this.

> >
> > I'm intending to detect the presence of an add-in card that has a port
> > expander on it so as to allow that port expander to be accessed via
> > U-Boot. As a bit of a hack I'm currently using flat dt (!OF_LIVE) and
> > putting the port expander in the board dt and attempting to disable it
> > via dt modification in board_init(). As a better approach I could
> > attempt to add it to dt but using an overlay would make so much more
> > sense.
>
> Disabling it in board_init() seems OK to me. Unfortunately this is the
> sort of problem which can be solved many ways.
>

This method seems to make the most sense for my use case. However
board_init() is called after relocation so I assume that is where you
are saying you can only change it at this point if using livetree?

If I add a normally disabled io-expander in the dt and during
board_init() I enable it (using ofnode_path() and
ofnode_set_enabled()) I find that when trying to probe it
uclass_find_device_by_ofnode() won't find it as it thinks its
disabled. If I instead enable the io-expander in the dt and
dynamically disable it based on runtime-detection I find that the
disabled gpio device is probed when a 'gpio status' is done which
causes a failure.

I assume what's going on is that the enabling/disabling needs to be
done before the device bind but I'm not clear how to facilitate that.

Thanks,

Tim
