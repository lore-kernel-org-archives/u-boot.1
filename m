Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA75E7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC44875E8;
	Wed,  4 Oct 2023 20:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GNIqyQVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D843875B0; Wed,  4 Oct 2023 20:10:09 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C9A875B0
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 20:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so110301a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442944; x=1697047744; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w5W+DRsl6OjglAC7XyeJBSxFDq32iO4B/LzeqS+l/1s=;
 b=GNIqyQVAjzIpTBh7iSbpHIG/1A2u7mYk1pRMlxjU1MwhMtlzHKbi4RzLh2JzkDEGP/
 BiZTPlgXcQyJ5Qw4RR/4fp8rh0biuSEaWx8biQ/q7y43NIgKFNLgg5mjH0LFPf3rtycI
 s/q8uajFTOCZpyUtA740CpmcWzoH0dmJM+saQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442944; x=1697047744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5W+DRsl6OjglAC7XyeJBSxFDq32iO4B/LzeqS+l/1s=;
 b=HjHDkWEn9PcP3Yj3wC3RXpsDGW1eCU26xdSwU/TnOh1MW/U+F4ZOpWYaCeTGvl74Es
 Vu/vgpQasgjU4+k6Qpuq70NumRRtIc9tur5Azt2kEtEXlgRD9mdr92HJJ1bHBhCC3XC4
 VZLdepuk/JWrQ4JYquQZBpnub5WuLxu3IyFR2O6NHuPWAauU++oU76Cci0TlHWWwPoPy
 Tdovjrqa4bmbD+FYVTqgQXJ3DSIjMfZUhOpu3y2mfPqD2Aa+DPfVTl+v8EL1RnBw5CZA
 hNlntNWxX94UW5NfNFDbf4zrrkEUDu/xIgH56mdJpDKR6zZCerMSyggzzx1X/bKopKi/
 jEvA==
X-Gm-Message-State: AOJu0Ywu9gPFYRjFZ6FudSfjjTA8vkn2YLfd7kjxXeXZEoY00sCEJmNL
 VZWM1MWFL43o8jcfHCK+0+/xfSAa7bVmQ6FGJZuOZg==
X-Google-Smtp-Source: AGHT+IHJlWNCUprSTsy/mi7E27yDL7LOdfmyTuqtZ+hKQqyfalMc4s2i7/u3zX2OuEnZBbKnARbShh/CVYkbdMcM8rE=
X-Received: by 2002:a17:907:7f26:b0:99d:ddae:f5d4 with SMTP id
 qf38-20020a1709077f2600b0099dddaef5d4mr3289336ejc.44.1696442943851; Wed, 04
 Oct 2023 11:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231004093620.2b1d6917@xps-13>
 <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
 <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
In-Reply-To: <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Oct 2023 12:08:52 -0600
Message-ID: <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
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

On Wed, 4 Oct 2023 at 11:17, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> >> >> Add a compatible string for binman, so we can extend fixed-partitions
> >> >> in various ways.
> >> >
> >> > I've been thinking at the proper way to describe the binman partitions.
> >> > I am wondering if we should really extend the fixed-partitions
> >> > schema. This description is really basic and kind of supposed to remain
> >> > like that. Instead, I wonder if we should not just keep the binman
> >> > compatible alone, like many others already. This way it would be very clear
> >> > what is expected and allowed in both cases. I am thinking about
> >> > something like that:
> >> >
> >> >       Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> >> >
> >> > this file is also referenced there (but this patch does the same, which
> >> > is what I'd expect):
> >> >
> >> >       Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> >> >
> >> > I'll let the binding maintainers judge whether they think it's
> >> > relevant, it's not a strong opposition.
> >>
> >> What is the overall goal here? To replace the current binman node
> >> which is
> >> usually contained in the -u-boot.dtsi files? If one is using binman to
> >> create an image, is it expected that one needs to adapt the DT in
> >> linux?
> >> Or will it still be a seperate -u-boot.dtsi? > Because in the latter
> >> case
> >> I see that there will be conflicts because you have to overwrite the
> >> flash node. Or will it be a seperate node with all the information
> >> duplicated?
> >
> > The goal is simply to have a full binding for firmware layout, such
> > that firmware images can be created, examined and updated. The
> > -u-boot.dtsi files are a stopgap while we sort out a real binding.
> > They should eventually go away.
>
> You haven't answered whether this node should be a seperate binman
> node - or if you'll reuse the existing flash (partitions) node(s) and
> add any missing property there. If it's the latter, I don't think
> compatible = "binman", "fixed-partitions"; is correct.

My intent is to make it compatible, so wouldn't it make sense to have
binman as the first compatible, then falling back to fixed-partitions
as the second?

>
> >> Maybe (a more complete) example would be helpful.
> >
> > Can you please be a bit more specific? What is missing from the
> > example?
>
> Like a complete (stripped) DTS. Right now I just see how the individual
> node looks like. But with a complete example DTS, my question from above
> would have been answered.
>
> What if a board uses eMMC to store the firmware binaries? Will that then
> be a subnode to the eMMC device?

I thought there was a way to link the partition nodes and the device
using a property, without having the partition info as a subnode of
the device. But I may have imagined it as I cannot find it now. So
yes, it will be a subnode of the eMMC device.

Regards,
Simon
