Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21828C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780FC870F4;
	Wed,  6 Dec 2023 04:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PkaRxFVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 472F586D37; Wed,  6 Dec 2023 04:54:08 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 342E1871CE
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1d2f89ddabso42765566b.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834843; x=1702439643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r6suksuPzaZznt3p/M45woiBZYvjxAGxoekJ7+ThXMA=;
 b=PkaRxFVg8o5hh4ZhDGnxacjiz0CLhcaAiw9GR4X9CwwXAr3yoetJky6TMOKtbK/7uZ
 4BKXE8WK7FCstM41PAt+31YaTi6DiRUQvNFpw/aFv8svxKrY8p1GMGAF0xUX6oFxbsiN
 b4trx+DWOq2NM2/sm8/RTIzds5ok2kc1uS5zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834843; x=1702439643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6suksuPzaZznt3p/M45woiBZYvjxAGxoekJ7+ThXMA=;
 b=LHUQd6vT1Z9cIhKa1/t/tkGWz0yLBdRtijTP9YHzfZ9/yG7nWlnOgKwoWU8lClDAGx
 saKkYwtw+oL0nho4MaikrXw2TBOHs+n6TWbVfDWhdtsB+wjK4yoEcZ8sBDet7SQ3BqPS
 jXzPZ4TXJR2FuGNIT97I7wUIT6xEw4hy9F/0DqPChke7f3prLACDIye/nLTsj7MeFHcn
 GgOWj8/QER4wSN/wg3wlQzgdWvBA6dT6Nw/CW7B9FVdvY/Ri5ZNtD92ccj7zRJHRWsJ2
 Jp1uOaW879ITDopQ9e5pn4BZI8CAj/0RIKs5MqSHRP84BKcq2A0f6yl8yULkiyi7ya7d
 eDtg==
X-Gm-Message-State: AOJu0YwEMfKIVDHbyGU0JPPRha5agR4pTLuUbVQFxdObD7/FH73f8+fC
 gCjCa7SD+8sc7N12Lsdvjr8ExmC+WvSZipv0+jPvjg==
X-Google-Smtp-Source: AGHT+IHdpC6PWRxJZKflIKI1X7QmuYOoxaO3xlsHrlMm8pJlVsY8RBuSO63bEsuv+QTe5xApXuZAGR2/wIWGK9Yjjy0=
X-Received: by 2002:a17:906:7497:b0:a19:a19b:788b with SMTP id
 e23-20020a170906749700b00a19a19b788bmr143987ejl.78.1701834843483; Tue, 05 Dec
 2023 19:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <CAPnjgZ03MEK_PeuaXcR1VuC-_tBmQmrzq3bo-jS3Jd22+rSgww@mail.gmail.com>
 <CAFA6WYOQX64jArOAV1W-8=174pru78SotGNVhjYth8qu=Swa=Q@mail.gmail.com>
In-Reply-To: <CAFA6WYOQX64jArOAV1W-8=174pru78SotGNVhjYth8qu=Swa=Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:53:51 -0700
Message-ID: <CAPnjgZ0y9VF5Mpx2VVtDnR6NFhs7mi=aAaByV4jqgDvUwZH60g@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

Hi Sumit,

On Tue, 5 Dec 2023 at 00:44, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 5 Dec 2023 at 06:22, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Tue, 21 Nov 2023 at 23:21, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi Caleb,
> > >
> > > On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > >
> > > > Historically, Qualcomm boards in U-Boot have all had their own
> > > > board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> > > > own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> > > > devicetree with little/no compatibility with upstream DT.
> > > >
> > > > This series makes a few final prepatory changes, and then replaces
> > > > almost all of the board specific code with generic alternatives. The end
> > > > result is that all Qualcomm boards both current and future (with the
> > > > exception of the db410c and db820c) can be supported by a single U-Boot
> > > > binary by just providing the correct DT. New boards can be added without
> > > > introducing any addition mach/ or board/ code or config options.
> > > >
> > > > Due to the nature of this change, the patch ("mach-snapdragon:
> > > > generalise board support") has become pretty big, I tried a few
> > > > different ways to represent this in git history, but the other methods
> > > > (e.g. adding a stub "generic" target and removing it again) were more
> > > > confusing and made for much messier git history. The current patch is
> > > > mostly atomic, but requires regenerating the config.
> > > >
> > > > The QCS404 EVB board had some code to enable the USB VBUS regulator,
> > > > this is dropped in favour of a adding a new vbus-supply property to the
> > > > dwc3-generic driver. This will also be used by the dragonboard845c in a
> > > > future patch. This handles the common case of a board requiring some
> > > > regulator be enabled for USB host mode.
> > > >
> > >
> > > Thanks for your work. It is a good step towards a generalized u-boot
> > > on Qcom platforms. Although I would like to give it an in-depth
> > > review, I have a common discussion point about DT, see below.
> > >
> > > > A more detailed description of the changes is below.
> > > >
> > > > == Memory map ==
> > > >
> > > > The memory map was historically hardcoded into U-Boot, this meant that
> > > > U-Boot had to be built for a specific variant of a device. This is
> > > > changed to instead read the memory map from the DT /memory node.
> > > >
> > > > Additionally, most boards mapped addresss 0x0 as valid, as a result if a
> > > > null pointer access happens then it will cause a bus stall (and board
> > > > hang). This is fixed so that null pointer accesses will now correctly
> > > > throw an exception.
> > > >
> > > > == DT loading ==
> > > >
> > > > Previously, boards used the FDT blob embedded into U-Boot (via
> > > > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > > > bootloader, so we can instead rely on the first-stage bootloader to
> > > > populate some useful FDT properties for us (notably the /memory node and
> > > > KASLR seed) and fetch the DTB that it provides. Combined with the memory
> > > > map changes above, this let's us entirely avoid configuring the memory
> > > > map explicitly.
> > >
> > > Since with this change, we don't need to embed FDT blob in the u-boot
> > > binary, so I was thinking if we really need to import DTs from Linux
> > > for different platforms and then play a catchup game?
> > >
> > > IMO, the build command would look like following if we import
> > > pre-built FDT blob from Linux:
> > >
> > > - Build u-boot::
> > >
> > >        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> > >        $ make qcom_defconfig
> > >        $ make
> > >
> > > - gzip u-boot::
> > >
> > >        gzip u-boot-nodtb.bin
> > >
> > > - Append dtb to gzipped u-boot::
> > >
> > >         cat u-boot-nodtb.bin.gz
> > > <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> > > u-boot-nodtb.bin.gz-dtb
> >
> > What is this?? Who or what uses a gzipped image with a single DT attached?
>
> The gzipped image is loaded by Qcom proprietary bootloaders (ABL or
> LK). It is the usual way Linux is booted on these platforms. U-boot is
> being brought into this chain to leverage standardized EFI boot
> processes.

LK is Little kernel, I believe. That is an open source project, right?
But I suppose it is BSD licensed so in fact the code is not available?
Is ABL obsolete?

I'm not sure that it matters in any case. We should be able to
standardise the U-Boot part and let the private projects implement
that, for a seamless boot.

What you have written above is not a good way for U-Boot to be
packaged or invoked.

>
> >
> > >
> > > This would avoid the maintenance burden to keep DT in sync with that
> > > of Linux. And since DT bindings in Linux are backwards compatible, we
> > > can say u-boot should work with DTB picked up from any Linux kernel
> > > stable release.
> >
> > That is not the current situation, unfortunately.
> >
>
> Hopefully with efforts from Caleb and team we can reach that point soon.
>
> > U-Boot is moving to using Binman to package the firmware. There needs
> > to be a description of the firmware image for each U-Boot boot. To my
> > way of thinking, rpi is a degenerate form, not something to be copied,
> > due to the closed-source nature of the firmware and its inability to
> > be changed. We do have (in the works) a way to pass a DT using a
> > standard firmware handoff. Perhaps that can be adopted by these
> > closed-source projects?
>
> Why should we really need firmware handoff if the DT can be passed in
> one of the u-boot boot arguments? Linux kernel does support this
> method to retrieve DT as well.

Here I am not referring to Linux, but to the firmware stages. We need
firmware handoff so all these nutty binaries around the place can
communicate with the open source (firmware) projects in a sensible
fashion.

For Linux we can pass the DT using existing mechanisms.

>
> >
> > BTW I am very pleased to see this series and I hope that Qualcomm (via
> > Linaro) can continue to improve its U-Boot support.
>
> It's good to know, thanks.

It is the hiding of the DT that I object to. I would like to see these
files in U-Boot, so we can build U-Boot for the platform and boot it
with its local DT. Otherwise many of the innovations U-Boot provides,
such as firmware packaging, become impossible. My feeling on this
might change if the bindings process were easier.

Regards,
Simon
