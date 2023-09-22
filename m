Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6633CD484D
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 17:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66BB86284;
	Fri, 22 Sep 2023 19:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cK1Ig2xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5F28647E; Fri, 22 Sep 2023 19:01:38 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C7285E44
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 19:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5335d9045b4so1793891a12.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695402096; x=1696006896; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prIJYO4UCCa6Vt94U+NHB8APLB3E/mezXQCP+edywR0=;
 b=cK1Ig2xcSiSOdhnBNlnAiAkOntetqiJ2LXtTzMW/UW7uAeKZm2WfnXNnuPNh71xJKI
 rulZunk2Ga8GMOglC9SxYTuFEV8D3I4VGy4ACL6Fswr6zYrUrYlYHwEp72s24/LUm9GM
 1S2uxppDMnnBousVH1UrLorb7NJwsSeyUOZLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695402096; x=1696006896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prIJYO4UCCa6Vt94U+NHB8APLB3E/mezXQCP+edywR0=;
 b=by2iSheXT9T9SAKLl6RzuRv3DX90xAnH/o8m3gIpnGzeTpYBV/crup2bRXZaBt/5FL
 KG1Y/+q1y/mfDwePfWwyw2l1toPADFWUfybKok8eSz1n5nIFSECqFWLTzqNxPt/PXu+O
 1slSwkvrCvUR1Zw7x6T8VXiJQP5PLtjCfflSJXlXAQDszQ8eAxmSu9lx50ey6ZcKH0Ut
 6JMvMMOHfycsCi7W4VNP0UWS7DIYNSsO9HHAEqqHBGGigvVIpc6L084vheiCRpj6X0Mq
 BLMjxjMkUNE/0cdXVelnqZMnbxG+xFDyPSpgzuhv5vh/P7dZ1g+iwcz6gYVnhhGD7hsE
 N0HA==
X-Gm-Message-State: AOJu0YwXlzYbVphR2b4w6Bi2WeoGw67JWFjp5z4PcG0FMs2Km0pa2gcL
 Bef4uqd3GCHZLlPx3jYIjwvNdzs+Lh/jRcBhzp4p6w==
X-Google-Smtp-Source: AGHT+IHHv1gP/4pypmekIUolVP4Bg2MyLQnwNSeSTQqinVXlc3czJqPwmHasOlWBXAyzd5YREZkr1Q8LAEn78+XhqMI=
X-Received: by 2002:aa7:c7d3:0:b0:523:3fff:5ce2 with SMTP id
 o19-20020aa7c7d3000000b005233fff5ce2mr42790eds.41.1695402095589; Fri, 22 Sep
 2023 10:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
In-Reply-To: <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 11:01:18 -0600
Message-ID: <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, U-Boot Mailing List <u-boot@lists.denx.de>, 
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
 Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
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

Hi Rob,

On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Binman[1] is a tool for creating firmware images. It allows you to
> > combine various binaries and place them in an output file.
> >
> > Binman uses a DT schema to describe an image, in enough detail that
> > it can be automatically built from component parts, disassembled,
> > replaced, listed, etc.
> >
> > Images are typically stored in flash, which is why this binding is
> > targeted at mtd. Previous discussion is at [2] [3].
> >
> > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromiu=
m.org/
> > [3] https://www.spinics.net/lists/devicetree/msg626149.html
>
> You missed:
>
> https://github.com/devicetree-org/dt-schema/pull/110
>
> where I said: We certainly shouldn't duplicate the existing partitions
> bindings. What's missing from them (I assume we're mostly talking
> about "fixed-partitions" which has been around forever I think (before
> me))?
>
> To repeat, unless there is some reason binman partitions conflict with
> fixed-partitions, you need to start there and extend it. From what's
> posted here, it neither conflicts nor needs extending.

I think at this point I am just hopelessly confused. Have you taken a
look at the binman schema? [1]

I saw this file, which seems to extend a partition.

Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.ya=
ml

I was assuming that I should create a top-level compatible =3D "binman"
node, with subnodes like compatible =3D "binman,bl31-atf", for example.
I should use the compatible string to indicate the contents, right?

Re extending, what is the minimum I can do? Are you looking for
something like a "compress" property that indicates that the entry is
compressed?

I'm really just a bit lost.

>
> I did a bit more research. "fixed-partitions" as a compatible has
> "only" been around since 2015. Prior to that, it was implicit with
> just partition nodes with addresses (i.e. reg) and that dates back to
> 2007. Looks like u-boot only supports the newer form and since 2021.

OK

Regards,
Simon

[1] https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#ima=
ge-description-format
