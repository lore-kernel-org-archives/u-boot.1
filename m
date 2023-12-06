Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19693C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 07:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206EF87032;
	Wed,  6 Dec 2023 08:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XS6/tHvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1A487015; Wed,  6 Dec 2023 08:05:48 +0100 (CET)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A728706F
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 08:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4b2ede7754cso703151e0c.1
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 23:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701846342; x=1702451142; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MgKLeghP/L9AG2DIJp+MavarKqNWuLlYNL11Buis+MY=;
 b=XS6/tHvVUENVwFaHaIpcOf+O5qqGxhACuid5ddtXB+xhq/Xii82ywM9b9lRpIV2ate
 Dwh3S/aFhirH6grWfCy0KRh6YWjkUWGpfOub+8BeR2VFLvfzRC76+XKMZSYvPKTB57ng
 KxdwB+sZZ2FWRCK0NJeMKzUR0ENFGnz3m2qH4sQRoaQhOSe52RdW4ogUMijutOTLs+SN
 kcv91Fh2X9DpSnT0VbPuIUNGdqzTaxnMNpW1xvFqT2UaayE3jLf0msOFBvDNSsPz4Q39
 b08zpFaRSj+8gtpDpVyBwP/5e5xsGAC0KJZ+sRN1TFinEIuN0cZCPTMAISQ6PnJouEGY
 K/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701846342; x=1702451142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MgKLeghP/L9AG2DIJp+MavarKqNWuLlYNL11Buis+MY=;
 b=hjlCGwHah/GZ5UORs5F1Jn0MxcpD6lztuKjFEz8VwbG3XZUGlGznFoTYQUnC1cQIWr
 saFW9vrxv2tD1QawnCpoSYMnsqI+mODdU3ZRnnvS1hwI9m+pxkasgXEfQzZLicUTcq4z
 lgDmcahCClpyCNspkQTdaYH1OZBH+aC0FcntSFYNZnyiEmZvQRj2Q7A5HGWBme92aSfQ
 73EgnC2rumRdQyNvVtuQ6bBRqMqkpmAtXmOR8d1k1eAXHjaBlHj+z6NznrfbjUSvr7Cw
 boBCD1xlQcu45l1bxiGDbOntCDj2hQiP3NbWBD9zJapejkI4VxnkZjaLdgQWmsH4tTd6
 vWbw==
X-Gm-Message-State: AOJu0YyeKx5L9bGGXU9b6rfbR53yyXzzF1t96LwqQniKoNTMg8YdoMNt
 nBvoObJyQ0UZjyFVDpx4ugd57QVPiWcvdGwCBzuosQ==
X-Google-Smtp-Source: AGHT+IFfALvtVT/5vkcKVCNImofiqXP/9F4sQXBPFQtQyL7/zDswmWmmjO8iaron+Co7+s7wUDdmTPAkyyrpcIqzhi4=
X-Received: by 2002:a1f:4ec5:0:b0:4b2:d5d9:d451 with SMTP id
 c188-20020a1f4ec5000000b004b2d5d9d451mr379544vkb.31.1701846342452; Tue, 05
 Dec 2023 23:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <CAPnjgZ03MEK_PeuaXcR1VuC-_tBmQmrzq3bo-jS3Jd22+rSgww@mail.gmail.com>
 <CAFA6WYOQX64jArOAV1W-8=174pru78SotGNVhjYth8qu=Swa=Q@mail.gmail.com>
 <CAPnjgZ0y9VF5Mpx2VVtDnR6NFhs7mi=aAaByV4jqgDvUwZH60g@mail.gmail.com>
In-Reply-To: <CAPnjgZ0y9VF5Mpx2VVtDnR6NFhs7mi=aAaByV4jqgDvUwZH60g@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Dec 2023 12:35:30 +0530
Message-ID: <CAFA6WYOxUm9SE9g7-ycp-ZyYn=JgABWJktbj4kaqEKiZGNq2CA@mail.gmail.com>
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

On Wed, 6 Dec 2023 at 09:24, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sumit,
>
> On Tue, 5 Dec 2023 at 00:44, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Tue, 5 Dec 2023 at 06:22, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Tue, 21 Nov 2023 at 23:21, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Hi Caleb,
> > > >
> > > > On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > > >
> > > > > Historically, Qualcomm boards in U-Boot have all had their own
> > > > > board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> > > > > own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> > > > > devicetree with little/no compatibility with upstream DT.
> > > > >
> > > > > This series makes a few final prepatory changes, and then replaces
> > > > > almost all of the board specific code with generic alternatives. The end
> > > > > result is that all Qualcomm boards both current and future (with the
> > > > > exception of the db410c and db820c) can be supported by a single U-Boot
> > > > > binary by just providing the correct DT. New boards can be added without
> > > > > introducing any addition mach/ or board/ code or config options.
> > > > >
> > > > > Due to the nature of this change, the patch ("mach-snapdragon:
> > > > > generalise board support") has become pretty big, I tried a few
> > > > > different ways to represent this in git history, but the other methods
> > > > > (e.g. adding a stub "generic" target and removing it again) were more
> > > > > confusing and made for much messier git history. The current patch is
> > > > > mostly atomic, but requires regenerating the config.
> > > > >
> > > > > The QCS404 EVB board had some code to enable the USB VBUS regulator,
> > > > > this is dropped in favour of a adding a new vbus-supply property to the
> > > > > dwc3-generic driver. This will also be used by the dragonboard845c in a
> > > > > future patch. This handles the common case of a board requiring some
> > > > > regulator be enabled for USB host mode.
> > > > >
> > > >
> > > > Thanks for your work. It is a good step towards a generalized u-boot
> > > > on Qcom platforms. Although I would like to give it an in-depth
> > > > review, I have a common discussion point about DT, see below.
> > > >
> > > > > A more detailed description of the changes is below.
> > > > >
> > > > > == Memory map ==
> > > > >
> > > > > The memory map was historically hardcoded into U-Boot, this meant that
> > > > > U-Boot had to be built for a specific variant of a device. This is
> > > > > changed to instead read the memory map from the DT /memory node.
> > > > >
> > > > > Additionally, most boards mapped addresss 0x0 as valid, as a result if a
> > > > > null pointer access happens then it will cause a bus stall (and board
> > > > > hang). This is fixed so that null pointer accesses will now correctly
> > > > > throw an exception.
> > > > >
> > > > > == DT loading ==
> > > > >
> > > > > Previously, boards used the FDT blob embedded into U-Boot (via
> > > > > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > > > > bootloader, so we can instead rely on the first-stage bootloader to
> > > > > populate some useful FDT properties for us (notably the /memory node and
> > > > > KASLR seed) and fetch the DTB that it provides. Combined with the memory
> > > > > map changes above, this let's us entirely avoid configuring the memory
> > > > > map explicitly.
> > > >
> > > > Since with this change, we don't need to embed FDT blob in the u-boot
> > > > binary, so I was thinking if we really need to import DTs from Linux
> > > > for different platforms and then play a catchup game?
> > > >
> > > > IMO, the build command would look like following if we import
> > > > pre-built FDT blob from Linux:
> > > >
> > > > - Build u-boot::
> > > >
> > > >        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> > > >        $ make qcom_defconfig
> > > >        $ make
> > > >
> > > > - gzip u-boot::
> > > >
> > > >        gzip u-boot-nodtb.bin
> > > >
> > > > - Append dtb to gzipped u-boot::
> > > >
> > > >         cat u-boot-nodtb.bin.gz
> > > > <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> > > > u-boot-nodtb.bin.gz-dtb
> > >
> > > What is this?? Who or what uses a gzipped image with a single DT attached?
> >
> > The gzipped image is loaded by Qcom proprietary bootloaders (ABL or
> > LK). It is the usual way Linux is booted on these platforms. U-boot is
> > being brought into this chain to leverage standardized EFI boot
> > processes.
>
> LK is Little kernel, I believe. That is an open source project, right?
> But I suppose it is BSD licensed so in fact the code is not available?
> Is ABL obsolete?

ABL: Android Boot Loader. I suppose it is somewhat derived from edk2
ABL EFI application. It's not obsolete but rather the one widely used
proprietary bootloader on recent SoCs (qcs404, sdm845 and all later
SoCs). Infact LK is somewhat obsolete which supports db410c, db820c
etc.

>
> I'm not sure that it matters in any case. We should be able to
> standardise the U-Boot part and let the private projects implement
> that, for a seamless boot.
>
> What you have written above is not a good way for U-Boot to be
> packaged or invoked.

I agree but we have to live with that given the challenges Caleb
mentioned in the other thread.

>
> >
> > >
> > > >
> > > > This would avoid the maintenance burden to keep DT in sync with that
> > > > of Linux. And since DT bindings in Linux are backwards compatible, we
> > > > can say u-boot should work with DTB picked up from any Linux kernel
> > > > stable release.
> > >
> > > That is not the current situation, unfortunately.
> > >
> >
> > Hopefully with efforts from Caleb and team we can reach that point soon.
> >
> > > U-Boot is moving to using Binman to package the firmware. There needs
> > > to be a description of the firmware image for each U-Boot boot. To my
> > > way of thinking, rpi is a degenerate form, not something to be copied,
> > > due to the closed-source nature of the firmware and its inability to
> > > be changed. We do have (in the works) a way to pass a DT using a
> > > standard firmware handoff. Perhaps that can be adopted by these
> > > closed-source projects?
> >
> > Why should we really need firmware handoff if the DT can be passed in
> > one of the u-boot boot arguments? Linux kernel does support this
> > method to retrieve DT as well.
>
> Here I am not referring to Linux, but to the firmware stages. We need
> firmware handoff so all these nutty binaries around the place can
> communicate with the open source (firmware) projects in a sensible
> fashion.

AFAIK, firmware handoff is an alternative way alongside DT to
communicate among firmware images if each firmware image can't support
a DT parser. Qcom proprietary bootloaders support DT parser and hence
they can communicate information (memory/reserved memory nodes etc)
via DT. Don't you consider DT as a sensible way to pass information to
u-boot?

>
> For Linux we can pass the DT using existing mechanisms.
>
> >
> > >
> > > BTW I am very pleased to see this series and I hope that Qualcomm (via
> > > Linaro) can continue to improve its U-Boot support.
> >
> > It's good to know, thanks.
>
> It is the hiding of the DT that I object to. I would like to see these
> files in U-Boot, so we can build U-Boot for the platform and boot it
> with its local DT. Otherwise many of the innovations U-Boot provides,
> such as firmware packaging, become impossible. My feeling on this
> might change if the bindings process were easier.

I agree with your current perspective about DT bindings. As you can
see from my conversations with DT bindings maintainers, it is
difficult to maintain local u-boot DT copy unless you can easily
validate them.

-Sumit

>
> Regards,
> Simon
