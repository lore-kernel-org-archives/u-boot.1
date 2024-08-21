Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F63C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 18:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8191188E17;
	Wed, 21 Aug 2024 20:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K66Hgg2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD1588E17; Wed, 21 Aug 2024 20:27:21 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2044588BAE
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 20:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf99fee82aso21292236d6.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 11:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724264838; x=1724869638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WnVe6mhXqXH/DvojCNq0IO4H8tB2OydCFTPv7R0kRPs=;
 b=K66Hgg2tvHfpmpxz4zdm5iJ04P+AJlPW/75NRLHtGKxCbKGFjKz+5Bjf+bQYZe1ERj
 m0L065lpcRpKDFcrjyCZP92+mcPfGQxTOAb7s8IP45gQ6YyRYiwDXcK88NhjQP56TB/s
 V36+9/ydgvA53avo9iox5avKBm3HAsDRDC+Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724264838; x=1724869638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnVe6mhXqXH/DvojCNq0IO4H8tB2OydCFTPv7R0kRPs=;
 b=NA1GHF6cI002M59BktUP4p83bHyHtm2uiL7shNA4qL0uCnwyyp3AIGb1YkkcZphJ3G
 tgdu3X+McKDZLT3OEd8dIhW8Ks4XRC7j5YIkFZ9AjrED93eB3NEKm8AAF1AJYtsF3BPr
 ZofG9ULx/Jvkbpp0x0blb7HLJrfmpTFTYUPUiAgM1I7TBW/B+/a5jI540oJVflVEjzKf
 7gAF2Y13BJ4uUdOxVzbktEsBYbJ+PDT98gE5Ie0G3/iAemASk42fnitQU6tOtCqHPpLq
 LiMhXfb3ZT9gi2w0utXMhU8ZYGNVxaqzPiHYTXlf/hL5QNLF0ZyfQO0vxvNSKs6tax1S
 HiKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYC7ksn9n2WKF3LpyzPGr2xp3S8XCByfWl54nNlF8DNj2zlnv8bo9+1XWsrzbYnxpIkQAgDbM=@lists.denx.de
X-Gm-Message-State: AOJu0YzKUyKZ7nz/Pd8P0uih8qCd+2tsngMpVI7xnGTcctGK7WuqrPFj
 SjwL6a+e21rMwxrQQSq72OT5Hjankd16haJcre7ygLrfi8yV7boj2nOsUNKI0SbzoNsHpymtLoW
 9iysO9KR43oebMPRWLuKXvT2EtdvXCMj9bJyC
X-Google-Smtp-Source: AGHT+IEWaSPce6gymZNijHk1XpowCDd82CrzTS/r3Fpf9yvvnsaxQx770ohY+BKO1TVPlG2qJDZtViulJSTiS7YcG9E=
X-Received: by 2002:a05:6214:4406:b0:6b8:5afd:8f89 with SMTP id
 6a1803df08f44-6c155e65e31mr32941176d6.37.1724264837688; Wed, 21 Aug 2024
 11:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
 <CAFLszTjjS8m2DsNp0nMEknM0ggu4QEET81iSyYFGDYWCwVjf2w@mail.gmail.com>
 <2a45562f-792f-4ad5-9871-bef82ccd2d18@linaro.org>
 <CAFLszTjwjUnGYMdujDUNePBiEU8_oMpkZYpSK8REKxrMYUadpw@mail.gmail.com>
 <eda3f2ad-d011-4ae6-b722-9114daafeae1@linaro.org>
 <CAFLszTidT+=wySmu1uo2auxnsbdvm0Qkav-vwu-3vbU9iuEhhA@mail.gmail.com>
 <c03c84a4-660a-4f20-8da4-e29d613600ac@linaro.org>
In-Reply-To: <c03c84a4-660a-4f20-8da4-e29d613600ac@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 12:27:06 -0600
Message-ID: <CAFLszThOJ_pYipxtqaBRCqU+npYrXy4nK4u8C+zM1cVxaR8fjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] clk/qcom: add initial clock driver for sc7280
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 21 Aug 2024 at 10:47, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 21/08/2024 18:16, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Wed, 21 Aug 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>
> >> On 21/08/2024 16:37, Simon Glass wrote:
> >>> Hi Caleb,
> >>>
> >>> On Wed, 21 Aug 2024 at 08:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>>> +U_BOOT_DRIVER(gcc_sc7280) = {
> >>>>>> +       .name           = "gcc_sc7280",
> >>>>>> +       .id             = UCLASS_NOP,
> >>>>>> +       .of_match       = gcc_sc7280_of_match,
> >>>>>> +       .bind           = qcom_cc_bind,
> >>>>>> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> >>>>>> +};
> >>>>>
> >>>>> This should use driver model, with a UCLASS_CLK and UCLASS_RESET
> >>>>
> >>>> Please refer to qcom_cc_bind() which binds the clock, reset, and power
> >>>> domain drivers.
> >>>
> >>> Gosh, why? Are these devices not in the devicetree?
> >>
> >> They are, the gcc block contains clock, reset, and pd parts. On Linux
> >> this is not an issue because a single device can be multiple different
> >> classes (e..g when you register a reset you do it for a device) whereas
> >> U-Boot requires a device per class.
> >>
> >> e.g. see devm_reset_controller_register() in Linux, it populates a
> >> struct reset_controller_dev which references the struct device created
> >> for the node. In U-Boot you have to create a new device which _is_ the
> >> reset controller.
> >
> > OK, I see. Rockchip has a CRU (Clock & Reset Unit) which uses syscon
> > to access registers. The clock driver 'owns' the node in U-Boot and it
> > manually binds a reset driver. It isn't great, either.
> >
> > Looking at drivers/clk/qcom/clock-sdm845.c (for example), I can't
> > actually find "qcom,gcc-sdm845" (for example) in U-Boot, except as a
> > binding. Can you please point me to the node?
>
> It's in dts/upstream/src/arm64/qcom/sdm845.dtsi
>
> >
> > Re devm_reset_controller_register(), yes the U-Boot driver model is a
> > lot more regular, e.g. we don't really want drivers creating their own
> > struct udevice. We want all devices to be created automatically by the
> > devicetree and most memory allocations to be done automatically. This
> > helps to reduce code size and execution time. You probably know all
> > this :-)
>
> Yeah, U-Boot's model is simpler for most cases. This makes sense. But it
> doesn't reflect the reality of DT so well in cases like this.
> >
> > To a significant degree, the devicetree bindings are created without
> > much thought to efficient operation in U-Boot. I hope that eventually
> > this might change.
>
> I strongly disagree with this mental model. This is the approach I see
> vendors take in their BSP sources and the result is not pleasant.
>
> DT should (within reason) never be written with the OS in mind. It is an
> agnostic structure to describe the hardware. I think the new power
> sequencing subsystem in Linux does a good job at embodying how we should
> approach consuming DT.

I'm only really involved in mainline and don't really see vendor trees
much. An example is where pinctrl has a GPIO controller but it is not
mentioned in the devicetree. It would be better for U-Boot to add a
subnode for each GPIO controller. In general, if the SoC has a device,
it should be in the devicetree.

Part of this difference (between U-Boot and Linux) comes about because
Linux device setup is fairly manual, whereas U-Boot tries to put all
of that in common DM code. Whenever you are including
dm/device-internal.h that is often a sign that the binding is causing
issues.

I'm happy for you to change my mind.

>
> >
> > Anyway, with the devicetree we have, I wonder how we could do this better?
> >
> > Some ideas:
> >
> > 1. Allow DM to bind multiple devices to each devicetree node, perhaps
> > as a Kconfig option (to avoid time penalty for all boards), or by
> > requiring a new DM_FLAG_MULTI_NODE flag. The devices would then be
> > independent, with no common parent device
>
> This would make sharing match data hard, and likely cause issues with
> generic compatible strings.

You would have to repeat the same compatible string in each driver.

For generic compatible strings we could a) worry about it later or b)
restrict this technique to only nodes with a single compatible string,
or c) use the driver flag as mentioned

> >
> > 2. As 1 but have DM create a parent 'UCLASS_MULTI' device
> > automatically. I am thinking that we should have a new uclass for
> > these things, or rename the NOP uclass. This option would allow easy
> > access to the parent device, if needed.
>
> This is the current approach, we just bind the clk/reset/pd drivers
> explicitly, allowing us to create and share common data. I don't believe
> there is a sensible way to do this generically.

How come? What is qcom_cc_bind() doing which DM couldn't?

> >
> > 3. Implement devices which are in more than one uclass. There would
> > still be a primary uclass, but others can be added too. This would
> > involve declaring a list of secondary uclasses in the U_BOOT_DRIVER()
> > macro. We would then have a struct dmtag_node for each secondary
> > uclass, containing the ID and the uclass pointer. Certain functions
> > would need to be updated to support this, and again it could be behind
> > a Kconfig.
>
> Many device classes in U-Boot rely on going from a struct udevice to
> some uclass specific data or ops. I have always found this to be a bit
> odd, though simpler to deal with than Linux.

In U-Boot the uclass is a stronger concept, e.g. you can generically
iterate through all devices in a uclass, and all devices have one.

> >
> > What do you think?
>
> I think if we're to try and solve this at all, the Linux model is by far
> the most sensible. It is already tried and tested, and would have the
> huge bonus of simplifying driver porting.
>
> barebox went with this approach and it seems to have worked out quite
> well for them.

What is the Linux model, in this sense? Whenever I see barebox I
wonder why we can't fold whatever new features it needs into
U-Boot...perhaps the code bases have converged too much...?

>
> All that being said, while it's taken me some time to get my head around
> "the U-Boot way", I think there is still value in the simplicity of
> U-Boot's approach. I also think the solution we've ended up with (after
> many iterations I might add) in clock-qcom is clean, simple, and easy to
> understand; though I do agree that U-Boot's DM is definitely hitting the
> limit of what complexity it can handle.

Well I would like to tidy this up in DM, so let's figure out which
option makes the most sense...once I understand what you mean by
'Linux model' above.

>
> I would honestly be much more interested in seeing early init get
> cleaned up, OF_LIVE becoming the default, and the ofnode abstraction
> going away.

So far as I can tell, you are always going to have a flat tree, even
if only before relocation or in SPL. How would we get around that?
Also, what don't you like about ofnode?

Given that Qualcomm is only using U-Boot as a second-stage loader so
far, (please, not for long!!) everything looks quite different. But
most platforms use U-Boot from SoC-boot-ROM handoff, so the
constraints are different (tighter).

Anyway, certainly OF_LIVE being the default would be good. I have
often wondered if we can (at build-time) convert the devicetree into a
'live' version, where the pointers are replaced by integers, such that
the early U-Boot code can easily compute the pointer value for each
node. It should make the unflattening much faster. For pre-relocation
and SPL, since we know the load address, we can (I am pretty sure)
have Binman put a full, live tree in the image and avoid the
unflattening code at all. Relocating a livetree is fairly easy too.

Regards,
Simon
