Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E62E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 08:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8D28021D;
	Thu, 19 Dec 2024 09:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pt3vFcG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7EAE8022B; Thu, 19 Dec 2024 09:05:29 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511FF8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so563595a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 00:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734595527; x=1735200327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S3EzPYQxw5ZfHLYUauZspGXZEHYBa9xINhIeJmvMqtg=;
 b=pt3vFcG5QL203q31sNK5Q+NNpWflSKXYKPdAarOX1Bg6pavXtWIGfOwcqEqQ3zlnea
 pqt3rhMrk09ZrkVunjdYbG1ppv6tlRbfrh6IXjyqTAD3oH06oHfoJF+MRxMNCimj1Foh
 uGu0+8PNCDoQnslA/OahBn87dP0jAPngP2OiKn5A9pExYCOThp8dj1CIKPGECXqGujdu
 inRfUt86nfn0s2xQxeI64QyMVDy1chvWsLxnmPZ0aTFk8bugt+skj4oddCAj7ytV4eiX
 rT6ArdlEJvIL2oI0HpHk8wUuxAZaZ6oJhdlu+S7Qcj8fzKZlAsfj59yaRu/jqVCs/Ndx
 v4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734595527; x=1735200327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S3EzPYQxw5ZfHLYUauZspGXZEHYBa9xINhIeJmvMqtg=;
 b=aSlA9Qd+vRwCL+biJrnGs8kfl988ClKWHEFFkaSiySOpGy04f8MBqbjzba7YiXiVqB
 D6zKiUb/vq9KbWkMIO6GJnj1uDou2WKfq16CPS09JlvNLoWlK2mB36l3fs6ZeH+0KXg6
 X7CTq2/uSFWg+A7KOFh9uiXqiUsgY98he44pi/u3KUtAN9JEgR54408HXagVs1dYgJBe
 VictasujPY1UtL0DYGdcebQoThmiQl9FPY7fH696rIrbhwUgn1ZwWqvsa+Lb8sweOTat
 2q1VS2A8Xi6qb2p6UAdaBR3Amv1P/3wDsOeWP5cWB7OyArN/hEockM3GWRDpHkgddv/R
 /SiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/+8ugJu2dkTjdrnKAnMvKCEdPH7X6x5f5OamcNjceEzupcoRGIva9rB7ZUDLj8Sbqcgm3dF0=@lists.denx.de
X-Gm-Message-State: AOJu0YykzAwCqFqcd0geXwCdn+iGGtab6Q/uS7GDLD0gkgNdhElEQnz3
 Q3nvjMD46MM1YqL5YJFKsRerRRflMvtI2pUbpiEWLpHHuOogFHT+LRqcGBAv3C6X94yESJMsCKa
 tdvfrrgKJjlksSuu+ATOM3L5sjTxutft9BATgxA==
X-Gm-Gg: ASbGnctMjBtVotCHAwAyQPrHPe8rbsQVTyKtt0zdNj3niXqkCSHBXaCQo6Fvj216BXQ
 vHLewm2ecd5gxrQwzXGhdXa3LommTGsRpTXlD6Q==
X-Google-Smtp-Source: AGHT+IEReomYLyhkSVN0AwAJE+zbYJjaqEugU6cpXqjvmLC6HDZi871/4FUyBjmOphJZ2y6hkEPDtpUyNg1RR5XxmfM=
X-Received: by 2002:a05:6402:518b:b0:5d0:9974:7da2 with SMTP id
 4fb4d7f45d1cf-5d7ee3d5a98mr5544705a12.19.1734595526699; Thu, 19 Dec 2024
 00:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
 <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de>
 <87zfksr4by.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87zfksr4by.fsf@bloch.sibelius.xs4all.nl>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 19 Dec 2024 13:35:15 +0530
Message-ID: <CADg8p97-O9rZxucm6nONvZoBdwDo5L_oF+D5X4MxC4+OJLvEZg@mail.gmail.com>
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, 
 peng.fan@nxp.com, sjg@chromium.org, vitor.soares@toradex.com, 
 paul.geurts@prodrive-technologies.com, marex@denx.de, u-boot@lists.denx.de
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

On Thu, 19 Dec 2024 at 04:23, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > Date: Wed, 18 Dec 2024 10:17:54 +0100
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Hi,
>
> > On 18.12.24 10:00 AM, Ilias Apalodimas wrote:
> > > In the long run we should change all of the above and have 32b and 64b
> > > platforms define ram_top identically.
> >
> > Some more ideas for cleaning up the situation in the long run:
> >
> > * Get rid of board_get_usable_ram_top() and fix the drivers that require
> >   address space below SZ_4G.
>
> Note that in many cases there are hardware limitations that restrict
> access to memory above SZ_4G by these devices.  So the only way to
> "fix" the drivers would be to add bounce buffer support to them.  That
> typically isn't trivial and adds complexity, especially when dealing
> with things like DMA rings.  And it will make things slower.
>
> These boards all seem to have plenty of memory below SZ_4G, so I think
> board_get_usable_ram_top() is actually a very reasonable solution for
> the problem.

Up until now, most issues have cropped up because of the addition of
RAM above ram_top to LMB's memory map. And I believe that is primarily
down to different, often conflicting requirements of platforms. The
addition of memory above ram_top is being done so that the memory
above ram_top gets registered in the EFI memory map. But with all
these issues that platforms are encountering, I think it will be best
to have this addition above ram_top done from the EFI memory module.
The LMB module will then be concerned only about memory till ram_top,
which platforms are free to set to a correct value considering their
limitations, or placement of images in RAM memory. I will be working
on this change for the next release, and send the patches out once I
have tested them on some of the boards that I have.

As an aside, I believe, there needs to be some kind of an audit of the
value of ram_top that is set by platforms. By default, ram_top is set
to an address one higher than the actual highest used address. That is
what is being done in the setup_dest_addr() function. The LMB function
to reserve the U-Boot image region also works with this assumption.
However, some platforms are not working with this rule. The imx8m is
one such platform. Considering the fact that we have 32 bit systems,
the ram_top should be changed to a u64 type so that we can have this
consistency among platforms.

-sughosh

>
> > * Parse the 'dma-ranges' property in the SoC node of the devicetree
> >   which already tells us what address space is usable (at least for
> >   i.MX8M).
>
> We do this in OpenBSD to determine a memory range that is "DMA-safe".
> It isn't entirely trivial though.  Not all boards have the relevant
> 'dma-ranges' property in the SoC node, and some boards have a
> 'dma-ranges' on nodes further down the tree that are very restrictive
> and not really relevant for what U-Boot wants to do.  So you'd
> probably need a Kconfig option to override this.
>
> Cheers,
>
> Mark
