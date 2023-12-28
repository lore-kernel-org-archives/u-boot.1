Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC499C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 06:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A46587716;
	Thu, 28 Dec 2023 07:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oJO7CuBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227CD87873; Thu, 28 Dec 2023 07:53:13 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE53687716
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e759ece35so3330482e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703746390; x=1704351190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zINjG7Xub0/Gd9sijbWoOrYIztlJAq4kWSH5a1TN310=;
 b=oJO7CuBiBU5bR9KMp6o1fsu3rd3I/x8olek/GJj1tjJyG15191tuf6aGNy866W19/p
 0ef86wojWvvVh97m4haRYg7Ki7Q+7/8XAl0e7hw0XbicVzhGkUWM+O7MqfCUcVcptWhh
 mTZk3qSy4mE55tF+MzwVg3PTn00f6XtkBHRfhvC8MY46Ju8rWoycH29UKo0sptGVh/c3
 zLYpoZR44Eg1rufISf6vnXqM6w6mTxiz/4fxLwt20SE2ab8PMcqfAlvl5MOtkdQlKJrV
 KZ5pDPThC9sww6zPo4wYBYE/pVP7cwJP4klYSn30ulwKf7GHAxwLCZBETBtW4x4VatDu
 Msng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703746390; x=1704351190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zINjG7Xub0/Gd9sijbWoOrYIztlJAq4kWSH5a1TN310=;
 b=oI95SvOJ8thNljwgUpgpNQ5Sqv6k++BF86sxmMpppDKsGFwx9fZPUFEs8oAHnvvBqo
 rweyK5ss5eZdTJLW9Ki1VL25yMysp7JNrdOFTaysemQDpO64TRglOnHyqllY+pRdjbBZ
 jYUINAOHsVumUx8DcuoEG83Anv+oO75NiuBYFlcV/ubFCCXmwSZ0aHrO+MrfFaeDVFN5
 +CmXEIR3GWXRKl3U5Hnd3NtKwoQ0ZCGHsy7x/qtSZb925WnOMKqEBA9kfh9d5/QpqXVp
 M8BTh/0LBykpc5VUwgoWp26kJPQ99iHtsVGrjJQkBfpYHK6MSw/LNqEv5G38Z2dZNE8Z
 buMg==
X-Gm-Message-State: AOJu0YxdhTDfqekHBgs8EBcv1l6UNCBvQ+nf4JC29THZ2dizaocOU5v3
 5U0a6UqUuWvi64Uj+8sEHcviVJAaiCGa+ABl1hsZkgC82MMkxA==
X-Google-Smtp-Source: AGHT+IHkSZX/WzCEbJ863vQFT1xr7SAwoUyR5+iA2AyYDu3D8enpY/JZRMYt1ILrwnq0M3pVbBIBg0p3F+3ft1F5e0w=
X-Received: by 2002:ac2:4c14:0:b0:50e:698c:3426 with SMTP id
 t20-20020ac24c14000000b0050e698c3426mr3645498lfq.118.1703746389896; Wed, 27
 Dec 2023 22:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
In-Reply-To: <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 08:52:33 +0200
Message-ID: <CAC_iWjKTmG=16_PZr-5TgmmPL8e4VStX3E4nLGXSxt0pJzUS3g@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
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

On Wed, 27 Dec 2023 at 19:48, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, Dec 27, 2023 at 6:44=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tom,
> >
> > On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > >
> > > > Standard passage provides for a bloblist to be passed from one firm=
ware
> > > > phase to the next. That can be used to pass the devicetree along as=
 well.
> > > > Add an option to support this.
> > > >
> > > > Tests for this will be added as part of the Universal Payload work.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > > The discussion on this was not resolved and is now important due to=
 the
> > > > bloblist series from Raymond. So I am sending it again since I beli=
eve
> > > > this is a better starting point than building on OF_BOARD
> > >
> > > I really don't like adding another option for "DT is given to us". Wh=
y
> > > isn't adding another enum to fdt_source_t sufficient, and if we have
> > > bloblist enabled, that will look for and use if found? Maybe some oth=
er
> > > code needs to be restructured and cleaned up too?
> >
> > Same here. On top of that the bloblist has a few items in there, e.g a
> > TPM eventlog. What are we going to do? Add a Kconfig for each item?
>
> No, but that is just a straw man. The DT is special and U-Boot reports
> where it comes from.

The story is identical to the EventLog. It's 'special' as well and
U-Boot has to pick it up, otherwise the hardware and the EventLog will
end up with different values

>
> >
> > This has been going back and forth for a while. I've lost count of how
> > many times I repeated the same proposal, but here it goes again. We
> > have OF_BOARD and BLOBLIST options. The bloblist and its properties
> > are scannable at runtime. Can't we use the combination of these 2 can
> > be used to imply we expect things from a bloblist. If we want to be
> > stricter in the future and explicitly expect the DT from a bloblist,
> > we could add a Kconfig option failing the boot if that's missing.
>
> I would like to have that Kconfig option now, not later. In my mind,
> the boot must be deterministic, so that if OF_BLOBLIST is enabled, the
> DT must come from there, or it is an error.

And how is what I proposed not deterministic? What prevents us from
adding that Kconfig option now?
The only difference is that by default, U-Boot will try bloblist ->
board-specific method unless a Kconfig option prevents the fallback.
I've been working with vendors and helping them implement the firmware
handoff spec in their proprietary bootloaders and Raymond contributed
the implementation for TF-A. At the same time, I am pretty sure
vendors will need time to implement this properly. I don't see how
adding an implicit Kconfig option will help them push this forward.

IOW I prefer U-Boot to *always* scan for a bloblist as the first
discovery DT method (unless the DT comes bundled with U-Boot), rather
than expecting users to turn a Kconfig knob.

>
> Also, repeating it doesn't make the proposal good. We agreed that
> OF_BOARD would eventually go away, so building on top of it is not
> setting us up for the future.

No, we didn't [0]. In fact, I said I don't see OF_BOARD *ever* going
away. The only thing I suggested was to rename it

[...]

[0] https://lore.kernel.org/u-boot/CAC_iWjKrkTM4spyXpoDDartJ41a553VDE+XM5gz=
3+jsNTFqtbg@mail.gmail.com/

Thanks
/Ilias
