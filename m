Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2BEC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 07:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E87C870AB;
	Thu, 30 Nov 2023 08:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JV75t97z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D87FD8758F; Thu, 30 Nov 2023 08:32:40 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E3A870AB
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 08:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7c4a41372d3so209545241.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 23:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701329557; x=1701934357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/Ec7+JMjhjaUnD61nyC4k/qzIAYJu/lC3xeXaEB9k8=;
 b=JV75t97zexE+Cfu/dbXFKFcpWp2HzDOqXm8pGiEX2xTbOe1Y3ci8O0EW4r38ON/Q5x
 8KqpgFcgvmDATwmr4kSX0iIHZFMY2NwwB6E+yGkq14cY+IQErNHGZ4donbS0w4jY7nQ1
 VGheDO2P4PpcF24HANd8TkTvEbsYvBeQ0q69lDjDxcj26uQzbpSjs2GIb/MHgeEfAsNA
 DhtF7tAeIrBvW1znlpJ3UFWIWNzIrRsoh+YeFmVq0ydRY+d6THvgkzLjY9n9YYbyrbqm
 Q8RgtnlWf4PxEPn3SOfrlJCPDbdsQjxj6j0hof9IbxvWWwZu7WKgvb/mbY22jmzG3euN
 GmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701329557; x=1701934357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/Ec7+JMjhjaUnD61nyC4k/qzIAYJu/lC3xeXaEB9k8=;
 b=exV83i49ATNGRTZwv6PNZFWj1Jcn0Ivz5DSBkCguhZorHOA6+qRAZ/l/R2CThZdWuF
 huos7w9RqtBVCEcaMoMdQiD0G4KteqC9TD9JYfO8FpBRXlaGd1c/7mNeIlX63lPZksWD
 UPRg4zvzAvMtkWSWs4GBAyHU4w18fg2U54a0OoObIAlxKHHskwJhPrSY0REC/wI9079+
 je/45cbzFfKY3CBFO4BZg6CY8KH+jKvCUm/RdiKTe1cuXZJlNU+OBORPuELgHNaWmaot
 8BmZPSEa/hVekEbIoOzQTPoCkGdewhk4qCY6rIckJC8S0BHQKy13aX48de9/OhHHUwC1
 6GaA==
X-Gm-Message-State: AOJu0Yz9JUtmE+GLKWOcgL1u10EM2z3XqoqutW5b6zUg7c2CpMeySzGK
 C8hy9autYKiRhKZFacvspN+LaiTUDGJ0SsvaXBNyGg==
X-Google-Smtp-Source: AGHT+IFQfOCD8WAd0IMcnHjd0NeJZWxHp/7IoSQQ7azGmsuBdpb0bAW7MlIVhTDh4KVUA94k7b+3n+qFbbT/6tsw27o=
X-Received: by 2002:a1f:c581:0:b0:4b2:9abd:75cb with SMTP id
 v123-20020a1fc581000000b004b29abd75cbmr1609861vkf.14.1701329557151; Wed, 29
 Nov 2023 23:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
In-Reply-To: <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 30 Nov 2023 13:02:25 +0530
Message-ID: <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>, neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
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

On Wed, 29 Nov 2023 at 22:06, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 29/11/2023 16:34, Caleb Connolly wrote:
> >
> >
> > On 23/11/2023 07:04, Sumit Garg wrote:
> >> On Wed, 22 Nov 2023 at 21:34, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>
> >>>
> >>>
> >>> On 22/11/2023 14:27, Tom Rini wrote:
> >>>> On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> >>>>> On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>
> >>>>>> On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> >>>>>>> Hi Caleb,
> >>>>>>>
> >>>>>>> On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>>> [snip]
> >>>>>>>> == DT loading ==
> >>>>>>>>
> >>>>>>>> Previously, boards used the FDT blob embedded into U-Boot (via
> >>>>>>>> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> >>>>>>>> bootloader, so we can instead rely on the first-stage bootloader to
> >>>>>>>> populate some useful FDT properties for us (notably the /memory node and
> >>>>>>>> KASLR seed) and fetch the DTB that it provides. Combined with the memory
> >>>>>>>> map changes above, this let's us entirely avoid configuring the memory
> >>>>>>>> map explicitly.
> >>>>>>>
> >>>>>>> Since with this change, we don't need to embed FDT blob in the u-boot
> >>>>>>> binary, so I was thinking if we really need to import DTs from Linux
> >>>>>>> for different platforms and then play a catchup game?
> >>>
> >>> For now, yes.
> >>
> >> But why? Is there any value added by larger u-boot specific DT (most
> >> of the nodes being unused by u-boot) than what currently u-boot
> >> supports? The more important part is to get alignment with Linux DT
> >> bindings. If you need to have memory/reserved-memory nodes in u-boot
> >> DT for generalization purposes then you should import those particular
> >> nodes only.
> >
> > I've been thinking about and hacking on this for the last week or so,
> > sorry for the delayed reply here.
> >
> > The value is in preventing any of the existing bindings from regressing,

That is actually best addressed in Linux by checking the DTS against
yaml DT bindings. We don't have that testing available in u-boot and
only depend on careful reviews.

> > and simplifying the bringup process for new platforms (just copy
> > SoC/PMIC DTSI and write a minimal board DTS to enable the needed hardware).
> >>
> >>> There are quite a few features which aren't handled by
> >>> U-Boot that it shouldn't need to handle (rpm/h resources for example).
> >>> Also the fixed-regulator / regulator-gpio binding differences.
> >>
> >> IMO, we should fix them first and then use Linux DT as it is.
> >
> > The biggest blocker here is USB, on sdm845 and the 4 new platforms I
> > have working, I only support USB high speed, this requires removing the
> > superspeed phy and adding a DTS property.
> >
> > I tried using OF_BOARD_SETUP to make this changes during boot but this
> > approach really isn't scalable (and I couldn't find a way to make it
> > work anyway).

Okay so let's try an alternative intermediate step then. We import the
Linux DT files *as it is* and then keep the u-boot specific custom
changes in <soc>-u-boot.dtsi file which is included by the board DTS
file. This has been the approach that other u-boot platforms follow
and allow us to easily sync them with Linux while reducing custom
u-boot specific bits. Eventually we should target at dropping u-boot
specific custom bits and then directly pick up DTB from Linux and boot
it.

> >
> >>
> >>>
> >>> I would definitely like to move towards supporting Linux DT directly,
> >>> but this approach gives us a nice middleground of minimising the U-Boot
> >>> specific DT parts.
> >>
> >> I don't see any real benefits here apart from the maintenance burden.
> >> If it had been an actual Linux DT then that can be passed to Linux as
> >> it is. However, the current modified import you are trying to do
> >> doesn't solve that purpose as well.
> >
> > Ensuring that we don't introduce non-standard bindings (by using Linux
> > DTSI) is one benefit, simplifying new platform bringup is another.
> >
> > The amount of work required to switch to upstream DT is too much to
> > block this series on. We can work on improving the situation there once
> > we have these Qualcomm improvements upstream and new boards added. I do
> > admit that this is quite an awkward middle-ground, and I would not like
> > it to last for too long.
>
> I'm a real supporter of targeting support of unmodified (or very slighly)
> Linux DT, having a reduced version of the Linux DT will be a pain at each
> sync, and you'll need to do this manually.

We have to choose the middle-ground carefully here. It shouldn't give
the impression that it is an actual Linux DT that you can pass
directly to Linux via EFI. As otherwise users will hit problems due to
the partially modified DTs in u-boot.

>
> Simply having to copy the Linux DT without any changes will make sure you
> are in sync with Linux's bindings, and will help making sure you'll boot
> unchanged Linux DTBs you get from previous loaders.

Once we have the previous loaders (ABL or LK) providing u-boot fully
fledged DTB then we don't need to maintain Linux DT copy in u-boot
which is always a pain to keep in sync.

>
> And in bonus, you'll be able to chain it to the next loader like EFI.
>
> So I don't see why any work toward this goal is useless, and if an
> intermediate step is needed, let's do it.

See the side effects of an intermediate step mentioned above. Having
<soc>-u-boot.dtsi clearly separates the changes we have to make for
u-boot.

-Sumit

>
> Neil
>
> >
> >>
> >> -Sumit
> >>
> >>>>>>>
> >>>>>>> IMO, the build command would look like following if we import
> >>>>>>> pre-built FDT blob from Linux:
> >>>>>>>
> >>>>>>> - Build u-boot::
> >>>>>>>
> >>>>>>>          $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> >>>>>>>          $ make qcom_defconfig
> >>>>>>>          $ make
> >>>>>>>
> >>>>>>> - gzip u-boot::
> >>>>>>>
> >>>>>>>          gzip u-boot-nodtb.bin
> >>>>>>>
> >>>>>>> - Append dtb to gzipped u-boot::
> >>>>>>>
> >>>>>>>           cat u-boot-nodtb.bin.gz
> >>>>>>> <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> >>>>>>> u-boot-nodtb.bin.gz-dtb
> >>>>>>>
> >>>>>>> This would avoid the maintenance burden to keep DT in sync with that
> >>>>>>> of Linux. And since DT bindings in Linux are backwards compatible, we
> >>>>>>> can say u-boot should work with DTB picked up from any Linux kernel
> >>>>>>> stable release.
> >>>>>>
> >>>>>> I guess one question I have is, are we being passed the device tree
> >>>>>> (since we're acting like the Linux Kernel)
> >>>>>
> >>>>> Yeah that is the case here, see patch #1 in this series regarding how
> >>>>> FDT address is being retrieved from previous stage bootloader (ABL on
> >>>>> sdm845 and qcs404 SoCs).
> >>>>
> >>>> That's what I thought.
> >>>>
> >>>>>> or knowing that we have the
> >>>>>> dtb attached to the end of us and making use of the old kernel appended
> >>>>>> dtb option? We're fine in for example the rpi_arm64 case of just being
> >>>>>> given a device tree from the previous stage and not needing one in-tree.
> >>>>>
> >>>>> That's good to know and we can replicate that for Qcom platforms which
> >>>>> are chainloaded and don't need an embedded DT.
> >>>>
> >>>> So yes, moving these towards the direction of rpi_arm64 and specifically
> >>>> using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
> >>>> the dtb must be provided to us) sounds like the right direction to take
> >>>> these platforms
> >>>>
> >>>
> >>> --
> >>> // Caleb (they/them)
> >
>
