Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24215D24456
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 22:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5AE89283;
	Fri, 11 Oct 2024 00:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="rgYUdRF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C88489289; Fri, 11 Oct 2024 00:05:18 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5847789283
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 00:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e290d5f83bcso1152806276.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1728597914; x=1729202714; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OVQ6Bmh2YqBb9ST+gEGYgDeoqM72w81bsLF+DUmhZc=;
 b=rgYUdRF/TYtz1vn3C+hfJRfQYLW4QstaCa/s+chdQ+e71ZsFjTrHhwUKG7IYVyro50
 G66P/aZlcbiAlvDG4v3C0SVuEi3G+NvGVeArWMn593hl1B7Oc1zhhi8QgO7Vh6Tuas/U
 Q7usNKXS2mkRyqIibQOi0VymhkrDcoE/vWK+Yp6G0ohQg1IBP4XvUZcGvqOA6Ar5OpLf
 HbQbdySifbelgn8uc5F55eImOtFHbBtSF7zRJryrZa2U6tp94EYaQbkme72ydRyhWbBo
 3s7exUndSSTQVvkywM/mxle3/1EcGFNrrpHy5SAw5HH4T9wibdX97y902t+K4cixUzml
 TMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597914; x=1729202714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OVQ6Bmh2YqBb9ST+gEGYgDeoqM72w81bsLF+DUmhZc=;
 b=Pka+eS0qab4o3pumDkiifL7V4OLZ0zhgtbRrl55i9Y7LkQhn1l7+qU+ihEqIY62DFA
 rupodz1tEHAQG20KLjDBdvCUvMMtHxbD1z9Gja1/OgM3X+b7lDg1Xoq/YRoDDwXJK/R4
 wlQrzzMme3Yln+aJH5125045gs6lVzDCb5gg8Lv/elF+DYftcLYDjKpnXZlBAqYDcOta
 sKm71EShoGlQtBZx+Ek63Hj4Flic+EmTf67hWoVe1wQ9WRpH4VA4PpeOZV2IpeT4Ea0C
 TjmxKv5JzgNDv5vBLjkGgDjnyS97+4PxQOG2lOfiiGCWVSrR57epRJUyl/XEGEE99g5V
 /KHw==
X-Gm-Message-State: AOJu0Yze0y606qrgxJM+ze5hgo3QgstebBwWi7wXPzZ82B021CfXXZvA
 OPAMDdigWCArOrlZFWT8+Zc6g56BVVMpgfYV40P5M/KpPveWDkuQsEyaObA4/71BSco2ozBZFHN
 c3lQe3QnpbGYecm9ApQSmFBOnuBu0Mri3X+SOM2T9TDyFzLFC+4Y=
X-Google-Smtp-Source: AGHT+IFdMz+tnEPRyg0k6Hmx5Vdyg8ie5VMcRh/0c1QQ4KxbfoIpzBf+vWxZ0P4nKpB1Fz2QkO6UxHyjNxylaMUsM1s=
X-Received: by 2002:a05:6902:15c5:b0:e29:1374:6dff with SMTP id
 3f1490d57ef6-e2919db6c80mr397772276.33.1728597914150; Thu, 10 Oct 2024
 15:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3wz22Ni+Kqy=NuFiEYPdrRkzjRJDNhYGJcCdDsLpbvBQ@mail.gmail.com>
 <CAFLszThkQ4pVmko8PPK5Yyt5RXFQkSatMycjH7GU5eN-_8L7ZA@mail.gmail.com>
In-Reply-To: <CAFLszThkQ4pVmko8PPK5Yyt5RXFQkSatMycjH7GU5eN-_8L7ZA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 10 Oct 2024 15:05:02 -0700
Message-ID: <CAJ+vNU0auiPUeqbAAFy2K4LhVk3ufU586gJYsZJ4f06wedyfCA@mail.gmail.com>
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

On Tue, Oct 8, 2024 at 6:56=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Tim,
>
> On Mon, 7 Oct 2024 at 14:16, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > Greetings,
> >
> > I have a need to adjust the U-Boot device-tree live with some board
> > revision specific fixups. It would seem I need to enable OF_LIVE to do
> > so but when I do this on imx8mm U-Boot proper seems to fail
> > phy_connect() called from the network device probe.
> >
> > The board I'm working with is an imx8mm-venice board and using
> > imx8mm_venice_defconfig (without OF_LIVE) results in:
> > U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:58:38 -0700)
> >
> > CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> > CPU:   Industrial temperature grade (-40C to 105C) at 44C
> > Reset cause: POR
> > Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
> > DRAM:  4 GiB
> > Core:  226 devices, 32 uclasses, devicetree: separate
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
> > MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> > Loading Environment from MMC... Reading from redundant MMC(2)... OK
> > In:    serial@30890000
> > Out:   serial@30890000
> > Err:   serial@30890000
> > SEC0:  RNG instantiated
> > Net:   GPY111 eth0: ethernet@30be0000 [PRIME]
> > GSC     : boot watchdog disabled
> > Thermal protection:enabled at 96C
> > Hit any key to stop autoboot:  0
> >
> > Yet as soon as I enable OF_LIVE:
> >
> > U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:59:35 -0700)
> >
> > CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> > CPU:   Industrial temperature grade (-40C to 105C) at 49C
> > Reset cause: POR
> > Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
> > DRAM:  4 GiB
> > Core:  214 devices, 32 uclasses, devicetree: separate
> > WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
> > MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> > Loading Environment from MMC... Reading from redundant MMC(2)... OK
> > In:    serial@30890000
> > Out:   serial@30890000
> > Err:   serial@30890000
> > SEC0:  RNG instantiated
> > Net:   Could not get PHY for mdio: addr 0
> > Could not get PHY for FEC0: addr 0
> > Could not get PHY for mdio: addr 0
> > Could not get PHY for FEC0: addr 0
> > No ethernet found.
> > ^^^ phy_connect failing
> >
> > Any idea what I'm missing here?
> >
> > Are there other ways I should be modifying the live dt in U-Boot?
>

Hi Simon, thanks for the response.

> I am not sure, but the best option would be to debug the PHY stuff and
> try to see what is going wrong.
>
> Since the number of devices is smaller, I suspect that there is some
> code which doesn't use the ofnode API. But it is hard to say what is
> going on.
>

ok, I will look into that

> For modifying the devicetree, you can do it just before relocation
> using the flattree if you like. The reason livetree is better is that
> the nodes don't move around when changes are made.
>

Where is relocation done in this case where I'm using SPL and U-Boot
proper for imx8m based boards?

If I want to utilize dt overlays in U-Boot proper can you point me to
what is needed or some examples?

I'm intending to detect the presence of an add-in card that has a port
expander on it so as to allow that port expander to be accessed via
U-Boot. As a bit of a hack I'm currently using flat dt (!OF_LIVE) and
putting the port expander in the board dt and attempting to disable it
via dt modification in board_init(). As a better approach I could
attempt to add it to dt but using an overlay would make so much more
sense.

Best Regards,

Tim
