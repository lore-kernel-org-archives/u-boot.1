Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6873C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 10:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5293787698;
	Wed,  6 Dec 2023 11:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="afybLKV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16066876B1; Wed,  6 Dec 2023 11:45:27 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E515B8766C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 11:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50bf4f97752so4402428e87.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701859524; x=1702464324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O9JxkC3RJpzfPWr3SEqBGB1CSfYA7D1NKc7qYHPamTU=;
 b=afybLKV23KXdQAqstqdsaQUO3RxtvaCB/pLBzT4T3484BiW0Inqp9rr96NtgFcGxtb
 hHhEbAdxMxKYep/InacMx/nmrx2Xdz2q4bDjhbSES+YvOQFX1rZQLciSjo/S9UQR2Wzc
 G8XHVon6OMTkisalOxgI96j13rkUS4Pl5t7IJMIsbE0yucqy7iNbNYcTg2Qp9qprAihw
 JwoKuZV5KS1UhR2w7PQ1qbB/DtiqElgOvxx9uXKU7HM3RocW7toQwStJgEF5u/yUd0DH
 V0Wdn7Xr17R4nKR0uV0iryZaQwkFi8f3SFArHwJsNIO/ehdJIxY/rW8OZcVh+dtMBXMK
 9iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701859524; x=1702464324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O9JxkC3RJpzfPWr3SEqBGB1CSfYA7D1NKc7qYHPamTU=;
 b=DaYPttat4OMAT8b2Tl+P1wOXa/pMIuaf4NvLcQjNUF/K11OEgaNEQOH7a6nqUxS2BR
 DfSZgD9E2ntLny/8tYe055/JGHlXXkb9zUDwsFRqK+3E3xlbx0Y8yxmtQk5n1xpr5cAx
 Opmp1r2H4/V5gBp5SLT4Xr72wF8TBdDmAxElLgbirUiv+rImrkrXgYZ9e8xMUTLo0sLA
 wdj4jH6DOwOri5CzxwUoL/Sj7LYzPXssoMvvkfsW0gOkqWb+K7b8Wdl9HhYRLr7W8t2X
 jw2udvoIP+7xTMNDB6OIcJvsNGDZ/3Kx6BVRapxMbOYJ7jZ0/33TLvr0/5mRwZzsGlsl
 xTcA==
X-Gm-Message-State: AOJu0YypoQ5+uEfpcXvpzLNYGsgKYR9YJxqi23DDWum8ID4/Ev4zMczR
 2n01fRXBWRVTKIS3qq/tXQX8F7JPwCNovXeCIEYO9Q==
X-Google-Smtp-Source: AGHT+IE7nrqwu6AGmbUapf6FPkzhyCGtFJoXEonlNIFg3gK9s8f4MDL10A0imMs2Q2JQ50ymvCyFzAaaI+akPfeFWhU=
X-Received: by 2002:a2e:9550:0:b0:2ca:1a41:adeb with SMTP id
 t16-20020a2e9550000000b002ca1a41adebmr432340ljh.34.1701859524185; Wed, 06 Dec
 2023 02:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
In-Reply-To: <20231122142758.GU2513409@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Dec 2023 12:44:47 +0200
Message-ID: <CAC_iWjJ6KKJH=oBcXD7gb6f8KcK+OQV4Qo=B=UNeEUk-w2q61A@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Wed, 22 Nov 2023 at 16:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> > On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> > > > Hi Caleb,
> > > >
> > > > On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > [snip]
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
> > > >
> > > > This would avoid the maintenance burden to keep DT in sync with that
> > > > of Linux. And since DT bindings in Linux are backwards compatible, we
> > > > can say u-boot should work with DTB picked up from any Linux kernel
> > > > stable release.
> > >
> > > I guess one question I have is, are we being passed the device tree
> > > (since we're acting like the Linux Kernel)
> >
> > Yeah that is the case here, see patch #1 in this series regarding how
> > FDT address is being retrieved from previous stage bootloader (ABL on
> > sdm845 and qcs404 SoCs).
>
> That's what I thought.
>
> > > or knowing that we have the
> > > dtb attached to the end of us and making use of the old kernel appended
> > > dtb option? We're fine in for example the rpi_arm64 case of just being
> > > given a device tree from the previous stage and not needing one in-tree.
> >
> > That's good to know and we can replicate that for Qcom platforms which
> > are chainloaded and don't need an embedded DT.
>
> So yes, moving these towards the direction of rpi_arm64 and specifically
> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
> the dtb must be provided to us) sounds like the right direction to take
> these platforms.
>

IMHO that option isn't that useful.  Grepping for OF_HAS_PRIOR_STAGE
shows that we use it to print where the DT came from unless I am
missing something...
On top of that having implies in the Kconfig to control those prints
makes little sense to me and it's a half-baked solution anyway,
because may boards don't fill this properly.  This thing was cleaned
up in 2e8d2f88439d, 2ea63271e522f, and d6f8ab30a2af46 but then got
reintroduced in 275b4832f6bf91 without anyone acking or reviewing. I
am fine with Caleb suggests here, but I think we can do way better.

Instead of having that imply we can get rid of it and only have
OF_BOARD(and perhaps rename it). So a general cleanup I have in mind
is

CONFIG_OF_SEPARATE -> rename it to CONFIG_OF_APPEND because it is
actually appended at the end of the binary.
CONFIG_OF_EMBED -> Leave it as is, it's there for debugging mostly.
CONFIG_OF_BOARD perhaps rename it to something more useful, but the
semantics are 'The DT comes from an *external* source. A bloblist,
some EEPROM location, CPU registers etc'
CONFIG_OF_HAS_PRIOR_STAGE -> Get rid of it again. gd already has
gd->fdt_src, just add a FDTSRC_UNKNOWN as default and delegate the
responsibility of filling this properly at fdtdec_setup(). The boards
that use OF_BOARD can fill this in properly, instead of relying on
Kconfig imply options and we can even be more explicit on where the DT
came from.

I can send an RFC if anyone thinks this is a cleaner approach

Thanks
/Ilias



> --
> Tom
