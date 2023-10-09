Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3505ACD6130
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 19:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9F386489;
	Mon,  9 Oct 2023 21:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YWoOvKKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D45864A0; Mon,  9 Oct 2023 21:52:23 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCFC3831BE
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 21:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso50053505e9.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696881141; x=1697485941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kW7oULOl0tcK0vEB5NqrNsw6lYYhHfwAHHaIwEUxMyM=;
 b=YWoOvKKbUw11nI8hbsqycwR7St4cVV0JpwBpWUiyJRywr6KUOpHzMAzc6a5NoM5p+e
 BuTaPbJXIcctajMGXTObSQg/U1mWR6mt95/ym4ArMzAyEWDU6V2LkRDjjSTqdSDvvvJT
 lG052HW4191Py7UaiMsuTEiOrfMU0+EMwYKiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696881141; x=1697485941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kW7oULOl0tcK0vEB5NqrNsw6lYYhHfwAHHaIwEUxMyM=;
 b=TX1j6F3pRWI1IXd2gKUuwaa/UyOBWVAX7Ga2+L05MIXpQjwQHMH0RSICDAdIDleBpo
 uFi/DkQ4oEyIBcvvfXYlfSiv7tVMUXIJqUsy9Lfik59Rv0X44pwJZkLs9z1roIvv+75M
 MjiN6lKG8R71JJLjKO/16DAwOtoMMsL6DIRHBNb8/QKEwZzQ7ZXoffAuxrukXzzoSIA4
 FzE4tU8E50K7dIxrw3xtsbH5UuGd6gISM/Gf0KLwxv+JUhag/CCkso/rHwvpiSEh2jCy
 uOT+krYSj7eN4QgC1vj09blUnIjnTYnQGt+mb1UFaN9tsJcC8qEhfu+vFdb9PkXP0+3M
 9peA==
X-Gm-Message-State: AOJu0Yz16HzOzROuptUTs0f2sA6ZHY6DUSpaQO3zHCc+qx/RfExkJGr0
 4uN0nUnPjuKnDx8Qtm0j89vlLuSsUCAk5QQ8JJy3Zw==
X-Google-Smtp-Source: AGHT+IEpbVNLiUNALTUpufwGdDawkPR2f/8t9G/X5X4usMASTCQ60W7JTnA2pm9BLCF8M4nViBTM4/u72lvKsnfVy+0=
X-Received: by 2002:a5d:680d:0:b0:319:83e4:bbbf with SMTP id
 w13-20020a5d680d000000b0031983e4bbbfmr15498175wru.20.1696881140946; Mon, 09
 Oct 2023 12:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231004093620.2b1d6917@xps-13>
 <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
 <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
 <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
 <a581ef73fa09c6ffeb83a1c1780053bd@kernel.org>
 <CAPnjgZ2PnKD5m0EgTdEAf-gcK3wuBZvWw_AO2iehb1dmfdoz3A@mail.gmail.com>
 <27d37d4c7cf353d99737a1e7a450f9f7@kernel.org>
 <20231006161113.GA3983739-robh@kernel.org>
In-Reply-To: <20231006161113.GA3983739-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Oct 2023 13:52:02 -0600
Message-ID: <CAPnjgZ0jb0Y1dyVm9FX42G-xYr+8FE01n5GtzoKA-WCe0pa5oA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
To: Rob Herring <robh@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>, miquel.raynal@bootlin.com,
 conor+dt@kernel.org, 
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 ptyadav@amazon.de, rafal@milecki.pl, richard@nod.at, trini@konsulko.com, 
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

Hi Rob,

On Fri, 6 Oct 2023 at 10:11, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 06, 2023 at 10:37:41AM +0200, Michael Walle wrote:
> > Hi,
> >
> > > > I'm still not sure why that compatible is needed. Also I'd need to
> > > > change
> > > > the label which might break user space apps looking for that specific
> > > > name.
> > > >
> > > > Also, our board might have u-boot/spl or u-boot/spl/bl31/bl32, right
> > > > now
> > > > that's something which depends on an u-boot configuration variable,
> > > > which
> > > > then enables or disables binman nodes in the -u-boot.dtsi. So in linux
> > > > we only have that "bootloader" partition, but there might be either
> > > > u-boot+spl or u-boot+spl+bl31+bl32.
> > > >
> > > > Honestly, I'm really not sure this should go into a device tree.
> > >
> > > I think we might be getting a bit ahead of ourselves here. I thought
> > > that the decision was that the label should indicate the contents.
> > > If you have multiple things in a partition then it would become a
> > > 'section' in Binman's terminology. Either the label programmatically
> > > describes what is inside or it doesn't. We can't have it both ways.
> > > What do you suggest?
> >
> > As Rob pointed out earlier, it's just a user-facing string. I'm a bit
> > reluctant to use it programatically.
>
> In general, yes, but the partition stuff has long (and still) uses
> label. As long as the values the tools understand are documented (which
> we don't normally do for label), I don't care so much. That's my
> opinion as long as this is shared with fixed-partitions. If it is not
> and there's little reason to use label, then absolutely, I think
> 'compatible' makes more sense.

OK I will try to drop the sharing with fixed-partitions

>
> > Taking my example again, the string "bootloader" is sufficient for a
> > user. He doesn't care if it's u-boot with spl or u-boot with tfa, or
> > even coreboot. It just says, "in this partition is the bootloader".
> > If you have an "bootloader" image you can flash it there.
>
> These days, there's generally not just 1 bootloader in the boot flow.
> Maybe there's 1 image, maybe not. Being more specific is hardly ever a
> bad thing. Only when the number of specific things becomes multiple 10s
> or 100s of them does it become a problem.
>
>
> > If it has a label "u-boot" and I want to switch to coreboot, will
> > it have to change to "coreboot"? I really don't think this is practical,
> > you are really putting software configuration into the device tree.
>
> On the input side (to binman), yes it is config, but on the output side
> (to the running system) we are saying what's there.
>
>
> > > At present it seems you have the image described in two places - one
> > > is the binman node and the other is the partitions node. I would like
> > > to unify these.
> >
> > And I'm not sure that will work for all the corner cases :/
> >
> > If you keep the binman section seperate from the flash partition
> > definition you don't have any of these problems, although there is
> > some redundancy:
> >  - you only have compatible = "binman", "fixed-partition", no further
> >    compatibles are required
> >  - you don't have any conflicts with the current partition descriptions
> >  - you could even use the labels, because binman is the (only?) user
> >
> > But of course you need to find a place where to put your node.
>
> And remove it. We don't need 2 sources of truth in the DTB.

I would certainly prefer to have one...I think using 'label' for the
existing case and 'compatible' for the new one could be a reasonable
compromise, so I will send v3.

Regards,
Simon
