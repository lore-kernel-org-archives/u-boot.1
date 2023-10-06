Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AB8E81DF0
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 12:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B2086DB5;
	Fri,  6 Oct 2023 14:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ezBdYIHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A6086E2C; Fri,  6 Oct 2023 14:39:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82C6E869B6
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 14:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b95622c620so390511766b.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696595975; x=1697200775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zSVbwuMngsJ15cLY6pR9vh3z/k0osdSclV2xxkOB8v0=;
 b=ezBdYIHMGMBrDWzMAkJP4AvOUQWGPXOhB1icosJ8+O4AoXE2MCQaSJfrpC27Tlkrfh
 qF//BnaZ8eMnw/AgWJeBVAkCq7QgDAO31kSPRIwCXtieElWXdqFqOGT/3Pfj9Hb6+ir8
 PcJ0g8FknghKC70D9L828/PhbD++0K6k8IXiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696595975; x=1697200775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zSVbwuMngsJ15cLY6pR9vh3z/k0osdSclV2xxkOB8v0=;
 b=jQK8QPD5VEOoEN5CcBlTxo6gyTwYENski7JN1QBxN/auiWOjMfyKWW35WsRNoSWj5E
 YXExEZnbvo3IAEcQis9MegytmMkn6YARLk39P0tTTvVIkMC+Gs7pFZh1oZ+ZMylvtkRB
 zYySriAPS3HBBXVg+R/uwWMjJqdujTdCi3x8DurG/akp4Bh8SiepyjX77TuWc5n7lfEA
 cd9Bb15fO6klBwTZ3n7PdjK13CvY5Sh4VujLsDGGT5Ci+UPXhnKPyBJptLXCwwJoI7Gd
 z2j+j3agdpGcIW6r08xx4pYBYArLLZNur0A9BUGLk6OUqvlvOf+XAVDgrtG72YpLyVqS
 MR7w==
X-Gm-Message-State: AOJu0Yyzg3ey4n4LHb+NgkVUtnFOMKnzBJQ+wWrH8fXjFq1jrvZJaTcj
 q/N4uXtxGySurVG9fH4FwYiaM32c8w7RrRJZB8hXJw==
X-Google-Smtp-Source: AGHT+IHF9InDrK2DzmRcPJNljvQBGZsJ+Z8ieD2aVFJnvMVrHvX/38WK/Aqqz8/EkfszHWgRPCHmcw5S2YTuy902ocY=
X-Received: by 2002:a17:906:5342:b0:9ad:ef08:1f32 with SMTP id
 j2-20020a170906534200b009adef081f32mr7684677ejo.37.1696595974780; Fri, 06 Oct
 2023 05:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231004093620.2b1d6917@xps-13>
 <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
 <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
 <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
 <a581ef73fa09c6ffeb83a1c1780053bd@kernel.org>
 <CAPnjgZ2PnKD5m0EgTdEAf-gcK3wuBZvWw_AO2iehb1dmfdoz3A@mail.gmail.com>
 <27d37d4c7cf353d99737a1e7a450f9f7@kernel.org>
In-Reply-To: <27d37d4c7cf353d99737a1e7a450f9f7@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Oct 2023 06:39:16 -0600
Message-ID: <CAPnjgZ0OZubVaj1RR6rWrJu2MWD=4PEPOD39zhaHgm6OzsyQnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
To: Michael Walle <mwalle@kernel.org>
Cc: miquel.raynal@bootlin.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, ptyadav@amazon.de, rafal@milecki.pl, 
 richard@nod.at, robh+dt@kernel.org, robh@kernel.org, trini@konsulko.com, 
 u-boot@lists.denx.de, vigneshr@ti.com
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

Hi Michael,

On Fri, 6 Oct 2023 at 02:37, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> >> I'm still not sure why that compatible is needed. Also I'd need to
> >> change
> >> the label which might break user space apps looking for that specific
> >> name.
> >>
> >> Also, our board might have u-boot/spl or u-boot/spl/bl31/bl32, right
> >> now
> >> that's something which depends on an u-boot configuration variable,
> >> which
> >> then enables or disables binman nodes in the -u-boot.dtsi. So in linux
> >> we only have that "bootloader" partition, but there might be either
> >> u-boot+spl or u-boot+spl+bl31+bl32.
> >>
> >> Honestly, I'm really not sure this should go into a device tree.
> >
> > I think we might be getting a bit ahead of ourselves here. I thought
> > that the decision was that the label should indicate the contents.
> > If you have multiple things in a partition then it would become a
> > 'section' in Binman's terminology. Either the label programmatically
> > describes what is inside or it doesn't. We can't have it both ways.
> > What do you suggest?
>
> As Rob pointed out earlier, it's just a user-facing string. I'm a bit
> reluctant to use it programatically.
> Taking my example again, the string "bootloader" is sufficient for a
> user. He doesn't care if it's u-boot with spl or u-boot with tfa, or
> even coreboot. It just says, "in this partition is the bootloader".
> If you have an "bootloader" image you can flash it there.
>
> If it has a label "u-boot" and I want to switch to coreboot, will
> it have to change to "coreboot"? I really don't think this is practical,
> you are really putting software configuration into the device tree.

I thought Rob changed his mind on that?

I agree that compatible would make things easier. We could then
continue to use 'label' for whatever it currently has.

Note that some kernel drivers or user space will want to look at what
is there, e.g. to provide a way to extract, check or update a
particular part of the firmware.

>
> > At present it seems you have the image described in two places - one
> > is the binman node and the other is the partitions node. I would like
> > to unify these.
>
> And I'm not sure that will work for all the corner cases :/
>
> If you keep the binman section seperate from the flash partition
> definition you don't have any of these problems, although there is
> some redundancy:
>   - you only have compatible = "binman", "fixed-partition", no further
>     compatibles are required
>   - you don't have any conflicts with the current partition descriptions
>   - you could even use the labels, because binman is the (only?) user
>
> But of course you need to find a place where to put your node.

Sure, but I was pointed to partitions as the place where this should live.

>
> > What does user space do with the partition labels?
>
> I'm not sure. Also I'm not sure if it really matters, I just wanted to
> point out, that you'll force users to change it.

OK I'll send a version that uses compatible strings and see if that
makes any progress.

Regards,
Simon

>
> -michael
>
> >> >> What if a board uses eMMC to store the firmware binaries? Will that
> >> >> then
> >> >> be a subnode to the eMMC device?
> >> >
> >> > I thought there was a way to link the partition nodes and the device
> >> > using a property, without having the partition info as a subnode of
> >> > the device. But I may have imagined it as I cannot find it now. So
> >> > yes, it will be a subnode of the eMMC device.
> >>
> >> Not sure if that will fly.
> >
> > I can't find it anyway. There is somelike like that in
> > simple-framebuffer with the 'display' property.
> >
> > Regards,
> > SImon
