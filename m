Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E15D1813F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D0C8918A;
	Mon, 14 Oct 2024 22:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hfmuh4hX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A8F88917B; Mon, 14 Oct 2024 22:20:19 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED3A89166
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbcd49b833so38924526d6.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728937216; x=1729542016; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6jEJvsr+XIpp827O3l052SS8l1sEtBL4j2GD6TCMXU=;
 b=hfmuh4hXByNAt/UOviZhYK5LAP/c+MQU1E0MSaCow8ImOP1DK6qdlgeU9LpP7JkdUb
 gkUlOdfjP71mVAlVwItOxP+Y/bUlZYim1cv2cIoU+rtt0DC+bANCnOJN8i+hMUMYv65b
 7pkhNNEaKUecLZObr7TDIiuKkK+LgwinxPO08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728937216; x=1729542016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6jEJvsr+XIpp827O3l052SS8l1sEtBL4j2GD6TCMXU=;
 b=sEnZTcw4MtZk8v8hIFCrEq+12x/0smRDKRy4LXz+DHAPui4N/JMoktd33dMIAPmYg+
 ga06VgG5P+eMlMAs4ghPgx4Efj8Td2Dvw+Q0B6N2DvUT7nkiIWOuU0CUk0mXCZ8uyGir
 /Vo7p6Rd0tArb2jkC4K4IamIaT5i50f/h0OHUQ8AXLKrTzZ3Vrfz4xW50fm83+lQGIzH
 Rayq+U8CQ39XjSmRkusSKqv4JDlohznRM6dlaJZ6z4QvUfbQy4OMsiiIsNVGJrTmFxlX
 MdN8u5IWRcQSVC6wCehX8VFeUO8SSXQIHg2jk6yDL/bhmgIZp5BhiYenOPudD9Q2sqDv
 xJbg==
X-Gm-Message-State: AOJu0YzjR9LvPfajQSbDrhTD9dzJ3wg17epw3y5nooT8ZWrYUKNPS6cA
 OPEeiRPErcwO67eGj2ngwRDq7wzIYAwKDi7p9CHb4vxH+9O64fDndZWi4McQM5DZaIxC0aNjwNm
 z+6dMHy1OmE7lnFnrYF6CLlWGbQaBM4M6KdWq
X-Google-Smtp-Source: AGHT+IEf3nGnvULUpCfzEnph2Yrndghu/tL5qP7KlVcBwo4WA9g2nKbAsuhH6hVaBcYQZRY3K+gvuyQ8rnq8YAVQLFM=
X-Received: by 2002:a05:6214:5a02:b0:6cb:4b65:950f with SMTP id
 6a1803df08f44-6cbf9e9683cmr115515306d6.50.1728937216144; Mon, 14 Oct 2024
 13:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3wz22Ni+Kqy=NuFiEYPdrRkzjRJDNhYGJcCdDsLpbvBQ@mail.gmail.com>
 <CAFLszThkQ4pVmko8PPK5Yyt5RXFQkSatMycjH7GU5eN-_8L7ZA@mail.gmail.com>
 <CAJ+vNU0auiPUeqbAAFy2K4LhVk3ufU586gJYsZJ4f06wedyfCA@mail.gmail.com>
In-Reply-To: <CAJ+vNU0auiPUeqbAAFy2K4LhVk3ufU586gJYsZJ4f06wedyfCA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 14:20:05 -0600
Message-ID: <CAFLszTgioVANXZVUTCzHip-gaAVUEyEgO0MsHczLwyNfoBQMqg@mail.gmail.com>
Subject: Re: modify live DT with OF_LIVE breaking phy_connect?
To: Tim Harvey <tharvey@gateworks.com>
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

Hi Tim,

On Thu, 10 Oct 2024 at 16:05, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Tue, Oct 8, 2024 at 6:56=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Tim,
> >
> > On Mon, 7 Oct 2024 at 14:16, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > Greetings,
> > >
> > > I have a need to adjust the U-Boot device-tree live with some board
> > > revision specific fixups. It would seem I need to enable OF_LIVE to d=
o
> > > so but when I do this on imx8mm U-Boot proper seems to fail
> > > phy_connect() called from the network device probe.
> > >
> > > The board I'm working with is an imx8mm-venice board and using
> > > imx8mm_venice_defconfig (without OF_LIVE) results in:
> > > U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:58:38 -0700)
> > >
> > > CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> > > CPU:   Industrial temperature grade (-40C to 105C) at 44C
> > > Reset cause: POR
> > > Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
> > > DRAM:  4 GiB
> > > Core:  226 devices, 32 uclasses, devicetree: separate
> > > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s tim=
eout)
> > > MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> > > Loading Environment from MMC... Reading from redundant MMC(2)... OK
> > > In:    serial@30890000
> > > Out:   serial@30890000
> > > Err:   serial@30890000
> > > SEC0:  RNG instantiated
> > > Net:   GPY111 eth0: ethernet@30be0000 [PRIME]
> > > GSC     : boot watchdog disabled
> > > Thermal protection:enabled at 96C
> > > Hit any key to stop autoboot:  0
> > >
> > > Yet as soon as I enable OF_LIVE:
> > >
> > > U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:59:35 -0700)
> > >
> > > CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> > > CPU:   Industrial temperature grade (-40C to 105C) at 49C
> > > Reset cause: POR
> > > Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
> > > DRAM:  4 GiB
> > > Core:  214 devices, 32 uclasses, devicetree: separate
> > > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s tim=
eout)
> > > MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> > > Loading Environment from MMC... Reading from redundant MMC(2)... OK
> > > In:    serial@30890000
> > > Out:   serial@30890000
> > > Err:   serial@30890000
> > > SEC0:  RNG instantiated
> > > Net:   Could not get PHY for mdio: addr 0
> > > Could not get PHY for FEC0: addr 0
> > > Could not get PHY for mdio: addr 0
> > > Could not get PHY for FEC0: addr 0
> > > No ethernet found.
> > > ^^^ phy_connect failing
> > >
> > > Any idea what I'm missing here?
> > >
> > > Are there other ways I should be modifying the live dt in U-Boot?
> >
>
> Hi Simon, thanks for the response.
>
> > I am not sure, but the best option would be to debug the PHY stuff and
> > try to see what is going wrong.
> >
> > Since the number of devices is smaller, I suspect that there is some
> > code which doesn't use the ofnode API. But it is hard to say what is
> > going on.
> >
>
> ok, I will look into that
>
> > For modifying the devicetree, you can do it just before relocation
> > using the flattree if you like. The reason livetree is better is that
> > the nodes don't move around when changes are made.
> >
>
> Where is relocation done in this case where I'm using SPL and U-Boot
> proper for imx8m based boards?

It is always done at the end of board_init_f() in U-Boot proper.

>
> If I want to utilize dt overlays in U-Boot proper can you point me to
> what is needed or some examples?

You could use a FIT in SPL and select the correct DT there, avoiding
needing to change it in U-Boot. But if it is really run-time behaviour
and not described by different models, then that won't work.

There is board_fix_fdt() where you can find some examples. We should
really tidy up all the DT stuff...

>
> I'm intending to detect the presence of an add-in card that has a port
> expander on it so as to allow that port expander to be accessed via
> U-Boot. As a bit of a hack I'm currently using flat dt (!OF_LIVE) and
> putting the port expander in the board dt and attempting to disable it
> via dt modification in board_init(). As a better approach I could
> attempt to add it to dt but using an overlay would make so much more
> sense.

Disabling it in board_init() seems OK to me. Unfortunately this is the
sort of problem which can be solved many ways.

Regards,
Simon
