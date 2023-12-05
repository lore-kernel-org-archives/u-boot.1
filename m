Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0E5C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 07:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3585871AD;
	Tue,  5 Dec 2023 08:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LYBzb6Xn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D0F871CE; Tue,  5 Dec 2023 08:44:53 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5440C871AD
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 08:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4b2ede7754cso372569e0c.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 23:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701762289; x=1702367089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P9xCm4UvPwbTYxDJOw89anYe8v0DG4TB8qWv36t89pU=;
 b=LYBzb6Xn7YThMAgN2kGL7ErKHRe1AsSp05buK9/jRoCKpDEnGXI+WNsi3bXH2L3bBE
 etYTTAjjezzcJwaC3I/fHL9loit8LecaXTOR9knrWGw+QgjUOePZ+vxdXQznIxKn+y3m
 S9o8JAXHqX+NjfQ88lbL2moCdm1OL0gg60y3xZQHnd++XS9b6yL1TWEDQ39JogVTaslW
 PbJgO6MTKYe9+GzAWk+2Kgi3OXIZdlMijxl8pSqTp0Lh8JnYoIH/s3UGV9i+6lvbu0nq
 ZOzfLKiQozO/HTpyQR4S2rPSlxQqSi5di4wkx3AcIERfCGGRPvIdo8M5Jt6BDvLx4Az3
 l44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701762289; x=1702367089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9xCm4UvPwbTYxDJOw89anYe8v0DG4TB8qWv36t89pU=;
 b=mPsOsU/xl5FZmgdtPH3A3KoOBEvWMEiM/41rL8h5+MkHyy68KlWSAlBNFVuRspKp46
 z0QVpijTLgpPjLtXcNthcWiGS4jWDrq/iBAIgBm0hl3ZDd87LDWONdIzyWjX6X4RyQms
 VJmagTAum2KyCHg1PD/c7q5IsKvL/A5p5F9e0xy46TF8LByPYoVJ5j+aisv8w2D8Ap0c
 R3PT1E1Vg057swjIZH/4Ov73ed1E62ysTiFeccpXkzJW3h4SQhDOA+/g63mLP/E5xS60
 G7h6xsb1vZOswzSjXnuzNL0BULZRMoJkN2X4XiJ3b9QJYQTzygyE6uf3/vadyi/hdJKW
 3B3Q==
X-Gm-Message-State: AOJu0YzXITiigwDM3h00/gqHd0fwApq3nLPB70LAdy9IIyyGq/ZI9qB+
 eSjyHm/VjlJV8RU02bXzt7snJ0ODvo4fGvnPjx6NNA==
X-Google-Smtp-Source: AGHT+IEl5xSkNo3AhaQIA0g+qbzTtG+gvl2z3oSK0Hf9wTT12wrO81YcNwCNqKdpHt3Me+Woy7YZxZ7vNNTrGtAvC9Y=
X-Received: by 2002:ac5:c2d1:0:b0:4b2:d9e4:cba with SMTP id
 i17-20020ac5c2d1000000b004b2d9e40cbamr2366654vkk.25.1701762288930; Mon, 04
 Dec 2023 23:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <CAPnjgZ03MEK_PeuaXcR1VuC-_tBmQmrzq3bo-jS3Jd22+rSgww@mail.gmail.com>
In-Reply-To: <CAPnjgZ03MEK_PeuaXcR1VuC-_tBmQmrzq3bo-jS3Jd22+rSgww@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Dec 2023 13:14:36 +0530
Message-ID: <CAFA6WYOQX64jArOAV1W-8=174pru78SotGNVhjYth8qu=Swa=Q@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Tue, 5 Dec 2023 at 06:22, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Tue, 21 Nov 2023 at 23:21, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Caleb,
> >
> > On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > >
> > > Historically, Qualcomm boards in U-Boot have all had their own
> > > board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> > > own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> > > devicetree with little/no compatibility with upstream DT.
> > >
> > > This series makes a few final prepatory changes, and then replaces
> > > almost all of the board specific code with generic alternatives. The end
> > > result is that all Qualcomm boards both current and future (with the
> > > exception of the db410c and db820c) can be supported by a single U-Boot
> > > binary by just providing the correct DT. New boards can be added without
> > > introducing any addition mach/ or board/ code or config options.
> > >
> > > Due to the nature of this change, the patch ("mach-snapdragon:
> > > generalise board support") has become pretty big, I tried a few
> > > different ways to represent this in git history, but the other methods
> > > (e.g. adding a stub "generic" target and removing it again) were more
> > > confusing and made for much messier git history. The current patch is
> > > mostly atomic, but requires regenerating the config.
> > >
> > > The QCS404 EVB board had some code to enable the USB VBUS regulator,
> > > this is dropped in favour of a adding a new vbus-supply property to the
> > > dwc3-generic driver. This will also be used by the dragonboard845c in a
> > > future patch. This handles the common case of a board requiring some
> > > regulator be enabled for USB host mode.
> > >
> >
> > Thanks for your work. It is a good step towards a generalized u-boot
> > on Qcom platforms. Although I would like to give it an in-depth
> > review, I have a common discussion point about DT, see below.
> >
> > > A more detailed description of the changes is below.
> > >
> > > == Memory map ==
> > >
> > > The memory map was historically hardcoded into U-Boot, this meant that
> > > U-Boot had to be built for a specific variant of a device. This is
> > > changed to instead read the memory map from the DT /memory node.
> > >
> > > Additionally, most boards mapped addresss 0x0 as valid, as a result if a
> > > null pointer access happens then it will cause a bus stall (and board
> > > hang). This is fixed so that null pointer accesses will now correctly
> > > throw an exception.
> > >
> > > == DT loading ==
> > >
> > > Previously, boards used the FDT blob embedded into U-Boot (via
> > > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > > bootloader, so we can instead rely on the first-stage bootloader to
> > > populate some useful FDT properties for us (notably the /memory node and
> > > KASLR seed) and fetch the DTB that it provides. Combined with the memory
> > > map changes above, this let's us entirely avoid configuring the memory
> > > map explicitly.
> >
> > Since with this change, we don't need to embed FDT blob in the u-boot
> > binary, so I was thinking if we really need to import DTs from Linux
> > for different platforms and then play a catchup game?
> >
> > IMO, the build command would look like following if we import
> > pre-built FDT blob from Linux:
> >
> > - Build u-boot::
> >
> >        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> >        $ make qcom_defconfig
> >        $ make
> >
> > - gzip u-boot::
> >
> >        gzip u-boot-nodtb.bin
> >
> > - Append dtb to gzipped u-boot::
> >
> >         cat u-boot-nodtb.bin.gz
> > <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> > u-boot-nodtb.bin.gz-dtb
>
> What is this?? Who or what uses a gzipped image with a single DT attached?

The gzipped image is loaded by Qcom proprietary bootloaders (ABL or
LK). It is the usual way Linux is booted on these platforms. U-boot is
being brought into this chain to leverage standardized EFI boot
processes.

>
> >
> > This would avoid the maintenance burden to keep DT in sync with that
> > of Linux. And since DT bindings in Linux are backwards compatible, we
> > can say u-boot should work with DTB picked up from any Linux kernel
> > stable release.
>
> That is not the current situation, unfortunately.
>

Hopefully with efforts from Caleb and team we can reach that point soon.

> U-Boot is moving to using Binman to package the firmware. There needs
> to be a description of the firmware image for each U-Boot boot. To my
> way of thinking, rpi is a degenerate form, not something to be copied,
> due to the closed-source nature of the firmware and its inability to
> be changed. We do have (in the works) a way to pass a DT using a
> standard firmware handoff. Perhaps that can be adopted by these
> closed-source projects?

Why should we really need firmware handoff if the DT can be passed in
one of the u-boot boot arguments? Linux kernel does support this
method to retrieve DT as well.

>
> BTW I am very pleased to see this series and I hope that Qualcomm (via
> Linaro) can continue to improve its U-Boot support.

It's good to know, thanks.

-Sumit

>
> [..]
>
> Regards,
> Simon
