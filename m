Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694C6C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 00:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B4287763;
	Tue,  5 Dec 2023 01:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6Y3939p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41064876AE; Tue,  5 Dec 2023 01:53:01 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1872387899
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 01:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d8a772157fso15191767b3.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 16:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701737576; x=1702342376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IH4q5EtfiaRRiCj7uaqq03G+Tp9MauySL94U/Xq30Yw=;
 b=c6Y3939ptGiSqazWaHaPOyj7+wShOIslaxYggXxwLolJ31yasy34Fn8Pr3zHUdCdmT
 Jt/8hvWJfxSdZvxpP779pOPxRMdeqpYK87qHCt7KJeIYFG0g0rFEmXF6u/JN0xvyeo74
 2BXhsFNhHQCs2SXKCh9axHNF4ldXOh4voDcEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701737576; x=1702342376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IH4q5EtfiaRRiCj7uaqq03G+Tp9MauySL94U/Xq30Yw=;
 b=WqzEE9ZkG8bClJFYlWWZcNpJNhk4nxl7oYXUdxcIyOO/DwAzf2fAwHvYeSBl/nHYRW
 lNZSWTf8S1kFE0qDsU70najIOol6zKLc2LY7CuZc8S29JynTX77ZbOhaZ+wWCcV2L+ZD
 MQDFcJ0Dlay65mUtsxsowEzjroELqeGYgJr5UaSdcPtZiUcACOUbPf8X48Zip/OGj7kI
 ycUDVNiG90osxpAJI67tqTfxIOOjegcLpGtV3m1Fjh6+ZqL+BB1yruLEoib9RT9dEB4O
 sIbUfFsZeJU7kwuWkBwOnvsBhafENbDBL+sDqXW4K08SdQypKWT3Fri24m48xc4jTHR5
 vm5Q==
X-Gm-Message-State: AOJu0YyZa23YSuH4+4LbWrhVNMisg3rJJ2gWw9jExFZvZTke9pvJBvHC
 7s9afri0mv99XfAX85gysx/dxlFGOdRMV6tBdmvfEQ==
X-Google-Smtp-Source: AGHT+IHj/1wO1imWiRrDhy7NvWExFdV+kQLy95/4ODYG9L/6CkCYK5m5QXYW0kFm+YzyvdiNGurvwrX+FFgs9TNTUNk=
X-Received: by 2002:a05:690c:338a:b0:5d7:1941:ab4 with SMTP id
 fl10-20020a05690c338a00b005d719410ab4mr3935784ywb.79.1701737575583; Mon, 04
 Dec 2023 16:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
In-Reply-To: <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Dec 2023 17:52:19 -0700
Message-ID: <CAPnjgZ03MEK_PeuaXcR1VuC-_tBmQmrzq3bo-jS3Jd22+rSgww@mail.gmail.com>
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

On Tue, 21 Nov 2023 at 23:21, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Caleb,
>
> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >
> > Historically, Qualcomm boards in U-Boot have all had their own
> > board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> > own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> > devicetree with little/no compatibility with upstream DT.
> >
> > This series makes a few final prepatory changes, and then replaces
> > almost all of the board specific code with generic alternatives. The end
> > result is that all Qualcomm boards both current and future (with the
> > exception of the db410c and db820c) can be supported by a single U-Boot
> > binary by just providing the correct DT. New boards can be added without
> > introducing any addition mach/ or board/ code or config options.
> >
> > Due to the nature of this change, the patch ("mach-snapdragon:
> > generalise board support") has become pretty big, I tried a few
> > different ways to represent this in git history, but the other methods
> > (e.g. adding a stub "generic" target and removing it again) were more
> > confusing and made for much messier git history. The current patch is
> > mostly atomic, but requires regenerating the config.
> >
> > The QCS404 EVB board had some code to enable the USB VBUS regulator,
> > this is dropped in favour of a adding a new vbus-supply property to the
> > dwc3-generic driver. This will also be used by the dragonboard845c in a
> > future patch. This handles the common case of a board requiring some
> > regulator be enabled for USB host mode.
> >
>
> Thanks for your work. It is a good step towards a generalized u-boot
> on Qcom platforms. Although I would like to give it an in-depth
> review, I have a common discussion point about DT, see below.
>
> > A more detailed description of the changes is below.
> >
> > == Memory map ==
> >
> > The memory map was historically hardcoded into U-Boot, this meant that
> > U-Boot had to be built for a specific variant of a device. This is
> > changed to instead read the memory map from the DT /memory node.
> >
> > Additionally, most boards mapped addresss 0x0 as valid, as a result if a
> > null pointer access happens then it will cause a bus stall (and board
> > hang). This is fixed so that null pointer accesses will now correctly
> > throw an exception.
> >
> > == DT loading ==
> >
> > Previously, boards used the FDT blob embedded into U-Boot (via
> > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > bootloader, so we can instead rely on the first-stage bootloader to
> > populate some useful FDT properties for us (notably the /memory node and
> > KASLR seed) and fetch the DTB that it provides. Combined with the memory
> > map changes above, this let's us entirely avoid configuring the memory
> > map explicitly.
>
> Since with this change, we don't need to embed FDT blob in the u-boot
> binary, so I was thinking if we really need to import DTs from Linux
> for different platforms and then play a catchup game?
>
> IMO, the build command would look like following if we import
> pre-built FDT blob from Linux:
>
> - Build u-boot::
>
>        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>        $ make qcom_defconfig
>        $ make
>
> - gzip u-boot::
>
>        gzip u-boot-nodtb.bin
>
> - Append dtb to gzipped u-boot::
>
>         cat u-boot-nodtb.bin.gz
> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> u-boot-nodtb.bin.gz-dtb

What is this?? Who or what uses a gzipped image with a single DT attached?

>
> This would avoid the maintenance burden to keep DT in sync with that
> of Linux. And since DT bindings in Linux are backwards compatible, we
> can say u-boot should work with DTB picked up from any Linux kernel
> stable release.

That is not the current situation, unfortunately.

U-Boot is moving to using Binman to package the firmware. There needs
to be a description of the firmware image for each U-Boot boot. To my
way of thinking, rpi is a degenerate form, not something to be copied,
due to the closed-source nature of the firmware and its inability to
be changed. We do have (in the works) a way to pass a DT using a
standard firmware handoff. Perhaps that can be adopted by these
closed-source projects?

BTW I am very pleased to see this series and I hope that Qualcomm (via
Linaro) can continue to improve its U-Boot support.

[..]

Regards,
Simon
