Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A65C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E5488723;
	Wed,  8 May 2024 16:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VXPXv8mX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C7C887CC; Wed,  8 May 2024 16:48:49 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EB8884E5
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-47f2f9f2ac8so689189137.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715179725; x=1715784525; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3a6IOys7qUViCYvqY1QOsB0aWmdZS/o9BBnR0pKATbw=;
 b=VXPXv8mX0Z/qmOrgIpmiajyNFWm5ipAoPTrMtcS6ne5SDXZCBf7NrZZESHfyO3+Vhs
 CvcR4rZtKzqZIGMuFAsMcUq9MBxiQNuTwArpp4WSwEqd2Gke4hTbzXWvd3gAazA2Hjw/
 7XUQpd39tsBWXws3BsowfhuaVTcT9FQVUSquREXgU2bZ23OXlYsk2pWrn7qDrJzQiA4q
 y/PH4DhFIK9pvZD76va8c0r/JnxvVk9v5bpFC8jgUZtnEXFQTArPbDubIUR7BmLefTlr
 j+SbFMUpx3PC+NVxyNJg+JzOLVpc7bmgWvnOIDTL41dsmBW4pwMpAsW3ZMfptdXVTVkr
 5q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715179725; x=1715784525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3a6IOys7qUViCYvqY1QOsB0aWmdZS/o9BBnR0pKATbw=;
 b=qeBHZRJrRja6pYCu2ku5aFCf61XwPWc7OzcS1/s9igZU5ZS+ZWuHXLDxEyXFWsI5Sd
 enoBczdAeWFDNZXYYEfTImC/f4tlubqouflyfjOF/y/Hf52Izqwh7q0ACI9q99niA/+i
 ZZQ4eTDoZ7Sogvb0Ri58G2opV5ncJbRmOIzlp1rm9cOe/XNMhXVsFAzwrGbiPyDWMKFb
 j1zL5lnxg1e4zLpQzt+7xN30hou4SNKV/2IJFzjqnv3hdscV8J22Wmqoaf0pIuawhMIH
 ZImZS8CIDX4ntu3oudeycq4jTPCHaENwvPOQ910JucKfuqP5kxyMPqzWbiJ/9E9QbXur
 J6kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYTlESQllISOHKbAUa2LLwX+7+vEy/0MTkw+bd9d3Umw62YfljTjIejInrqjEoL5tpnrFXmyemh0zjX+iC2cC3bjG0mA==
X-Gm-Message-State: AOJu0YzLygbrc6PwFJxWp9V55mmQwT3C5TbGbzPdwedYFskFxfpWMvE0
 0JFlodx7tav1QuocjIKcMKKPeJPZy+LEjP3/PM2edhqt16T6MeI+9WBmjNarCMsG3hmw3fnK4U+
 DBPLsHL4elWLCgEz2Mv5R5B/yQvQEgBtB3RqVPA==
X-Google-Smtp-Source: AGHT+IHxBA1Ys4Tp7WeLRwoTxkaTjtQkTjRGKvgqz5EXln7yfXE9Zh0SOVMmyAKPW41gPYLvd0vImCB5+ZYIJm1hxcA=
X-Received: by 2002:a67:e2c3:0:b0:47c:23b7:f50d with SMTP id
 ada2fe7eead31-47f3c3b5875mr2161250137.35.1715179723843; Wed, 08 May 2024
 07:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
 <CAFA6WYPEK0CeK-WATVymNSzYR6U3+gKxu0TpBeCQ7a03C7PObw@mail.gmail.com>
 <PaGjHRvdULVbxVZ6A0Mw4PKFhK2AmMa171TAjH-3X9skahkwpgp9AEvt_W7tfepnpu2cTHmJt0zhnaSo-ukBYGP0K7PdFieiiYUNaMpiG1k=@samcday.com>
 <81f02041-6cf8-439c-b7a2-9edbfe038de6@linaro.org>
In-Reply-To: <81f02041-6cf8-439c-b7a2-9edbfe038de6@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 8 May 2024 20:18:32 +0530
Message-ID: <CAFA6WYN+2wtsyAtKNw5C_JSQyjHLNH3Bcbdr1FtizGFtS-vg7g@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: do carveouts for qcs404 only
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
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

On Wed, 8 May 2024 at 18:09, Caleb Connolly <caleb.connolly@linaro.org> wro=
te:
>
> Hi Sam,
>
> On 08/05/2024 13:40, Sam Day wrote:
> > Salutations Sumit,
> >
> > On Wednesday, 8 May 2024 at 11:14 AM, Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> >>
> >>
> >> Hi Sam,
> >>
> >> On Wed, 8 May 2024 at 00:11, Sam Day me@samcday.com wrote:
> >>
> >>> The newly introduced carve_out_reserved_memory causes issues when
> >>> U-Boot is chained from the lk2nd bootloader. lk2nd provides a
> >>> simple-framebuffer device and marks the framebuffer region as no-map =
in
> >>> the supplied /reserved-memory. Consequently, the simple_video driver
> >>> triggers a page fault when it tries to write to this region.
> >>
> >>
> >> How does the corresponding Linux kernel driver handle this?
> >
> > Firstly: I'm something of a middle-man here. I would consider Caleb the=
 authoritative source on the carveouts stuff (since they wrote it) and Niki=
ta Travkin the authority on the simplefb handoff (since he originally wrote=
 it for lk2nd to hand off to Linux simpledrm and then adapted it to work wi=
th U-Boot simplefb).
> >
> > I consulted with Nikita on your first question here. He linked me to th=
is snippet: https://elixir.bootlin.com/linux/v6.9-rc7/source/drivers/gpu/dr=
m/tiny/simpledrm.c#L877
> >
> >>   Is the
> >> framebuffer region required to be mapped as normal memory or device
> >> type or something else?
> >
> > So I guess based on the link above, it's just mapped as normal uncached=
 memory.
> >
> > I tried to do something like this a few days ago in U-Boot, but a) it d=
oesn't work and b) I have no idea what I'm doing: https://github.com/samcda=
y/u-boot/commit/c100cb3711ddf5b01601691f3e6a9ec890d9a496

Can you start adding some debug prints as to what might be happening?
Also, look at my proposal below to hook memory mapping properly for
drivers.

> >
> > After talking with Caleb about this for a bit, they suggested the patch=
 you see here as what I guess could be considered a "stopgap" solution that=
 hopefully makes it into 2024.07.
> >
> >> Similarly would normal memory type work for
> >> all other reserved memory regions marked as no-map?
> >
> > I'll let Caleb weigh in here. My understanding is that the other region=
s *should* be marked as PTE_TYPE_FAULT because otherwise drivers might inad=
vertently speculatively access regions that are very much off-limits, such =
as TZ app regions.
>
> Right, carving out reserved regions and having the driver handle them is
> theoretically the "correct" thing to do here. But I'm not sure that the
> additional complexity offers much value from a U-Boot context.
>
> If we can teach the armv8 PT/cache code to handle this better, and teach
> all the drivers to map their regions on-demand, this would probably help
> us a lot (especially as right now if you attempt to access dead space
> between peripherals then you'll hang the bus...). But U-Boot is a ways
> away from that.

I am not sure if U-Boot is really that far away although you can say
the infrastructure is not hooked up for Arm. Have a look into
map_physmem() and unmap_physmem() utilized by various drivers which
are actually hooked up on MIPS. So I think the right way to approach
this feature on Qcom platforms is to start hooking up those APIs on
mach-snapdragon to begin with via mmu_set_region_dcache_behaviour()
underneath. We can always go ahead and make it more generic if needed
on other platforms too.

-Sumit
