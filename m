Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB34C10DC1
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D001787158;
	Wed,  6 Dec 2023 04:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B7SudAg+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B345870F4; Wed,  6 Dec 2023 04:53:20 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1165871AA
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so73772666b.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834797; x=1702439597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qArB1BPSoUSNxX+vKBpeALqbwXe3AKNHY7IlmQsGGG4=;
 b=B7SudAg+EBSReo+2qNu7mZIfK36R63ZsMuD1aXdrLp+1mNU3HqFRLuW9rPuXeREpSB
 iwldZuelCBen2WL6RWAzsvWkbEG9yak5JfYeeJyPEo029gHpl6JHaBkqtfFkNBCA22oh
 4MSZKfW7UtOc2Nr8Qoo0lylG6LnfOHehfxseQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834797; x=1702439597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qArB1BPSoUSNxX+vKBpeALqbwXe3AKNHY7IlmQsGGG4=;
 b=OVoDQJnId+owABqMRCFgA1IbHhjyyyhhjFjyZD9ojQXfWhHt0EdGNuxo26IwPpby3z
 kh8BH1b3lGtklkoFBagAAteC3Wp0JpJsnWExbsKgXdkt2o064kilRcLJf9TrgxJA3lHK
 jpobtFoy1UQcrQ1uDIT3Zcj/8ZYiB2rjy+mG17/8Fwkac1uXDK3W14ChdEq4dlN4863m
 i6D8WjqoxLBRmBonA9epyDZhKy13RkyAGFDxQ0GVMCX0GHKaw3ycHtpVrMwX3hbi/QWD
 KyG/s1pR77eDWGX0LdWOTu0dwwszy/Ai7qbjLQfGgAmUW78BiEbQ4hvBxqW434cKyXrw
 rZpA==
X-Gm-Message-State: AOJu0YwpK0Pb7DfUqMWN54k7mOFrPguDKs331AfkRjuMS1bm32y1cMQR
 n4SQqnudelhz+KyKC/OtqI/7xf9PS+GuknnHrEEgpA==
X-Google-Smtp-Source: AGHT+IHcdTdgXBVnYyblMch++BAWqDKYooVkpXDmxq+jDSnOC/DfxMHTZZT6EWotQYZpzlC68208RC2v4XpGd2YFTk8=
X-Received: by 2002:a17:906:1419:b0:a1b:de77:7ecd with SMTP id
 p25-20020a170906141900b00a1bde777ecdmr2489440ejc.18.1701834797260; Tue, 05
 Dec 2023 19:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <CAPnjgZ03MEK_PeuaXcR1VuC-_tBmQmrzq3bo-jS3Jd22+rSgww@mail.gmail.com>
 <CAFA6WYOQX64jArOAV1W-8=174pru78SotGNVhjYth8qu=Swa=Q@mail.gmail.com>
 <b93994f4-40a7-4e1c-9e15-1dcaa16d900f@linaro.org>
In-Reply-To: <b93994f4-40a7-4e1c-9e15-1dcaa16d900f@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:53:05 -0700
Message-ID: <CAPnjgZ0uPZ7m2jZY561dNGVb3MjnuSqCMtcuQj2G9LMwOOGwFg@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>,
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

Hi Caleb,

On Tue, 5 Dec 2023 at 03:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 05/12/2023 07:44, Sumit Garg wrote:
> > Hi Simon,
> >
> > On Tue, 5 Dec 2023 at 06:22, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Sumit,
> >>
> >> On Tue, 21 Nov 2023 at 23:21, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>>
> >>> Hi Caleb,
> >>>
> >>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> [...]
> >>>> == DT loading ==
> >>>>
> >>>> Previously, boards used the FDT blob embedded into U-Boot (via
> >>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> >>>> bootloader, so we can instead rely on the first-stage bootloader to
> >>>> populate some useful FDT properties for us (notably the /memory node and
> >>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
> >>>> map changes above, this let's us entirely avoid configuring the memory
> >>>> map explicitly.
> >>>
> >>> Since with this change, we don't need to embed FDT blob in the u-boot
> >>> binary, so I was thinking if we really need to import DTs from Linux
> >>> for different platforms and then play a catchup game?
> >>>
> >>> IMO, the build command would look like following if we import
> >>> pre-built FDT blob from Linux:
> >>>
> >>> - Build u-boot::
> >>>
> >>>        $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> >>>        $ make qcom_defconfig
> >>>        $ make
> >>>
> >>> - gzip u-boot::
> >>>
> >>>        gzip u-boot-nodtb.bin
> >>>
> >>> - Append dtb to gzipped u-boot::
> >>>
> >>>         cat u-boot-nodtb.bin.gz
> >>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> >>> u-boot-nodtb.bin.gz-dtb
> >>
> >> What is this?? Who or what uses a gzipped image with a single DT attached?
> >
> > The gzipped image is loaded by Qcom proprietary bootloaders (ABL or
> > LK). It is the usual way Linux is booted on these platforms. U-boot is
> > being brought into this chain to leverage standardized EFI boot
> > processes.
>
> Yes, just to clarify, this is the state that _all_ non-WoA Qualcomm
> boards/devices are in right now (with the exception of db410c), with
> production devices we can't modify the bootloader without vendors
> releasing their signing keys.

Or perhaps a shim? It would be good if vendors could provide an unlock
mechanism eventually, but I understand it is challenging.

>
> For devices that haven't been locked with vendor keys ("Secureboot off"
> in Qualcomm terminology, note that this has nothing to do with UEFI
> secureboot) we can work towards replacing the bootloader entirely with
> U-Boot, I have done a PoC of this on SDM845. In that case, we have to
> embed the DTB into U-Boot.

OK, I see, that sounds good. My concern is that the open source
approach is preserved and made the easiest option. Decisions which
accommodate private binaries while making open source harder should
generally be rejected.

> >
> >>
> >>>
> >>> This would avoid the maintenance burden to keep DT in sync with that
> >>> of Linux. And since DT bindings in Linux are backwards compatible, we
> >>> can say u-boot should work with DTB picked up from any Linux kernel
> >>> stable release.
> >>
> >> That is not the current situation, unfortunately.
> >>
> >
> > Hopefully with efforts from Caleb and team we can reach that point soon.
> >
> >> U-Boot is moving to using Binman to package the firmware. There needs
> >> to be a description of the firmware image for each U-Boot boot. To my
> >> way of thinking, rpi is a degenerate form, not something to be copied,
> >> due to the closed-source nature of the firmware and its inability to
> >> be changed. We do have (in the works) a way to pass a DT using a
> >> standard firmware handoff. Perhaps that can be adopted by these
> >> closed-source projects?
> >
> > Why should we really need firmware handoff if the DT can be passed in
> > one of the u-boot boot arguments? Linux kernel does support this
> > method to retrieve DT as well.
>
> Unfortunately the chances of Qualcomm releasing bootloader updates to
> adopt a standard for chainloading U-Boot on their wholely deprecated
> platforms of 5/6/7 years ago, and then having OEMs/ODMs (who have no
> reason to care, and may not even be around anymore) apply these patches
> to their own hacked up fork of the bootloader and ship it to end-users
> is honestly even less likely than OEMs releasing the signing keys for
> devices they don't support anymore.

Yes, I understand it is challenging. Somehow it works better with
Linux, despite hacked up kernels, etc. so perhaps Linaro can help
here?

Regards,
Simon
