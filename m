Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F524CE7AB9
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 19:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5150865D0;
	Fri, 22 Sep 2023 21:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mkhJijmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEC386529; Fri, 22 Sep 2023 21:43:22 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EC18641B
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 21:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3046CCE2489
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 19:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7141DC433CC
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695411796;
 bh=A4YRRXIxZfuP4hSCrSlSbxBU3yaGfiOmZNf7I2N3gEk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mkhJijmgNzhzaiyJy0L2fdcWOoEyj7Xb33pKZQ6HWXtj/a62OqvRUfPfk+LozuoHA
 NAgz4bgZL0CeqyJD1vwf5rHLS5s5aIfQ6YwmqelUxJS6M4bK9P7MRK08C/UsZt++C0
 eOwNKWmFQRiA+TRVLMEEKtcomCfNqy6j+zap1dQDSsZjIAOHnkGZJXUdiRw+ryVj4o
 mYfYA7kowAq2XV/5PZ+TxWvb6jMVp1W2e6hYxLK1zdxDnvdXuKO0xIoCq5Wzq8z8kO
 wh/KJvjWxITTbXdDv/xgVvyUw6cFPcjoAJHKTHhT/k7x0INUdX5EskofeFXUMQm4R1
 jHIVHY2r5CQCA==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-50307759b65so4682230e87.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:43:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyFI6Mk6YopQtkZNM77xP2ISF0IyMh6MfLqCHa/EsTi+DaFDgTY
 DQTK4zjBSnj2E5cUfZTsYsM5ZAxSnssO521XrQ==
X-Google-Smtp-Source: AGHT+IHykPmoXWd5RfRa0OjFcxDuEZz0rP2JzY8ueouRM4ujoevuhdbvkTcM0rnlltiKoj8kM26YvC0aFr03f+Nlwzs=
X-Received: by 2002:a05:6512:3e1f:b0:500:daf6:3898 with SMTP id
 i31-20020a0565123e1f00b00500daf63898mr566690lfv.26.1695411794619; Fri, 22 Sep
 2023 12:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org>
 <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
In-Reply-To: <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Sep 2023 14:43:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
Message-ID: <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To: Simon Glass <sjg@chromium.org>
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

On Fri, Sep 22, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Rob,
>
> On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> > > Hi Rob,
> > >
> > > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Binman[1] is a tool for creating firmware images. It allows you t=
o
> > > > > combine various binaries and place them in an output file.
> > > > >
> > > > > Binman uses a DT schema to describe an image, in enough detail th=
at
> > > > > it can be automatically built from component parts, disassembled,
> > > > > replaced, listed, etc.
> > > > >
> > > > > Images are typically stored in flash, which is why this binding i=
s
> > > > > targeted at mtd. Previous discussion is at [2] [3].
> > > > >
> > > > > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binma=
n.html
> > > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@c=
hromium.org/
> > > > > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> > > >
> > > > You missed:
> > > >
> > > > https://github.com/devicetree-org/dt-schema/pull/110
> > > >
> > > > where I said: We certainly shouldn't duplicate the existing partiti=
ons
> > > > bindings. What's missing from them (I assume we're mostly talking
> > > > about "fixed-partitions" which has been around forever I think (bef=
ore
> > > > me))?
> > > >
> > > > To repeat, unless there is some reason binman partitions conflict w=
ith
> > > > fixed-partitions, you need to start there and extend it. From what'=
s
> > > > posted here, it neither conflicts nor needs extending.
> > >
> > > I think at this point I am just hopelessly confused. Have you taken a
> > > look at the binman schema? [1]
> >
> > Why do I need to? That's used for some tool and has nothing to do with =
a
> > device's DTB. However, I thought somewhere in this discussion you showe=
d
> > it under a flash device node.
>
> Yes, that is the intent (under a flash node).
>
> > Then I care because then it overlaps with
> > what we already have for partitions. If I misunderstood that, then just
> > put your schema with your tool. Only users of the tool should care abou=
t
> > the tool's schema.
>
> OK. I believe that binman will fit into both camps, since its input is
> not necessarily fully formed. E.g. if you don't specify the offset of
> an entry, then it will be packed automatically. But the output is
> fully formed, in that Binman now knows the offset so can write it to
> the DT.

I suppose it could take its own format as input and then write out
something different for the "on the device" format (i.e.
fixed-partitions). At least for the dynamic offsets, we may need
something allowed for binman input, but not allowed on device. In
general, there is support for partitions without addresses/offsets,
but only for partitions that have some other way to figure that out
(on disk partition info).

There's also the image filename which doesn't really belong in the on
device partitions. So maybe the input and output schemas should be
separate.

> > > I saw this file, which seems to extend a partition.
> > >
> > > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partiti=
ons.yaml
> >
> > IIRC, that's a different type where partition locations are stored in
> > the flash, so we don't need location and size in DT.
>
> OK.
>
> >
> > >
> > > I was assuming that I should create a top-level compatible =3D "binma=
n"
> > > node, with subnodes like compatible =3D "binman,bl31-atf", for exampl=
e.
> > > I should use the compatible string to indicate the contents, right?
> >
> > Yes for subnodes, and we already have some somewhat standard ones for
> > "u-boot" and "u-boot-env". Though historically, "label" was used.
>
> Binman has common properties for all entries, including "compress"
> which sets the compression algorithm.

I see no issue with adding that. It seems useful and something missing
in the existing partition schemas.

> So perhaps I should start by defining a new binman,bl31-atf which has
> common properties from an "binman,entry" definition?

I don't understand the binman prefix. The contents are ATF (or TF-A
now). Who wrote it to the flash image is not relevant.

We already have some compatibles in use. We should reuse them if
possible. Not sure about TF-A though.

Rob
