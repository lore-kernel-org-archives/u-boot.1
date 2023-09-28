Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5000FE732E4
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 15:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37AFD86B95;
	Thu, 28 Sep 2023 17:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gM02yUO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCC586E3D; Thu, 28 Sep 2023 17:20:19 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18367864D4
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 17:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so15994756a12.2
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695914416; x=1696519216; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhGCCrTPz3qD815DrUTz3QFvoilWcLj84jeEgBAbn4g=;
 b=gM02yUO3cKsTx8jhTA9XCZNYmp4aUHoHZlzsv+furkUkCXwxY9DGBZOmndyC6sINlU
 og/CxysYO1HBLAUu8Z6I6/eKNCs24qXcqcSs5rS4JSm2T+4FRyrIMjF9dr+wH79vmsgU
 pm3yi0qzb6vBh5A4K6kFfjLGzpZ4IudfF+ppA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695914416; x=1696519216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhGCCrTPz3qD815DrUTz3QFvoilWcLj84jeEgBAbn4g=;
 b=vVV1mnLf4FV7HiZnAwafY1hu4KO/smkVRQwdMmV/rYMZuG8lWxIoUc8X7OIvIm10fs
 Q9IMf9zeSpCgYvUOrlevE9+vMMvrBBo/QJfgR1jOlTNbjUYMX29rczA8O4DO1M3KuSQY
 vl4OBmgIAGaaf9pczXDyMXYTzyjNiiY1pzlJMcFrem95CrUf5+hU4rAACXlTm1R77Y1F
 +y8FnBDTWGV0EvBE7pFznZ/nisP9B6QbMFg52cHhTCX03jDgORGvHWnscFuCyfUHU7QF
 qiNyRb/uuQc2PmGWdDwi6gkFwumg3N6ISpcSZlywByF+udymuBGH+HFlWm0l1vyvB4vN
 rArw==
X-Gm-Message-State: AOJu0YwYRjBCD4VWomlP56Ocg09eJcxHRecmcVQbLoZt9B6IA5o1n+oY
 Hmkberivydn7Ck8rdTUG+4eZVEx2WZFSnjeZOACbCQ==
X-Google-Smtp-Source: AGHT+IGCrTzWYKPGz8+625kDs0eQi51Ow82elgipH2Qu5W+6QmLi6g4eOr361Yni2q+KJAEShzSViau1oDvFTplMmIU=
X-Received: by 2002:aa7:c1ca:0:b0:533:926:da9d with SMTP id
 d10-20020aa7c1ca000000b005330926da9dmr1505968edp.18.1695914416372; Thu, 28
 Sep 2023 08:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org>
 <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
 <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
 <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
 <20230925092122.0b615f25@xps-13>
 <CAPnjgZ0Z5J_33HuQF-5XgDFmZim0nHHzvZJOOZobWw_cOJd=9g@mail.gmail.com>
 <20230925164736.5efbf4c0@xps-13>
 <CAPnjgZ3YCQHJ-eXuX8rYx2Qb6QEL+XviFmXYTON6M-sGPWSBBg@mail.gmail.com>
 <20230925172447.43dcef88@xps-13>
 <CAPnjgZ20c9FsYVjSrQ9qbFy9Y67BqDP2zxMyATx===PFhO69Ew@mail.gmail.com>
 <CAL_JsqJfjHqtTB2qfLmNxmQtn1rZewNyNe+Knu_Z4UCdPoPhSQ@mail.gmail.com>
 <CAPnjgZ1npHPpwPmw2f4=E3U5=RH0m4R+W_MZ7+oXdmDF=EeUjg@mail.gmail.com>
 <20230926094815.5802e184@xps-13>
 <CAL_JsqL_8bhHkHOFL8a8=g1dYL4OY8hGuNDyc0Jz22rEuJzXtQ@mail.gmail.com>
 <CAPnjgZ3TJLaRzv_cXyLdpRBtc2-FBYQ=gk-_MhEDH47HvO71FQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3TJLaRzv_cXyLdpRBtc2-FBYQ=gk-_MhEDH47HvO71FQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Sep 2023 09:20:05 -0600
Message-ID: <CAPnjgZ2eUcgevpS7Ak5p=7bhm0aHW3taLO8Fq_EcpDDQidJFVA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To: Rob Herring <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, linux-mtd@lists.infradead.org, 
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor+dt@kernel.org>,
 Dhruva Gole <d-gole@ti.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

Hi again Rob,

On Wed, 27 Sept 2023 at 10:43, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Rob,
>
> On Tue, 26 Sept 2023 at 11:29, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Sep 26, 2023 at 2:48=E2=80=AFAM Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:
> > >
> > > Hello,
> > >
> > > > > > > > These are firmware bindings, as indicated, but I
> > > > > > > > took them out of the /firmware node since that is for a dif=
ferent
> > > > > > > > purpose. Rob suggested that partitions was a good place. We=
 have fwupd
> > > > > > > > using DT to hold the firmware-update information, so I expe=
ct it will
> > > > > > > > move to use these bindings too.
> > > > > > >
> > > > > > > I would definitely use fixed partitions as that's what you ne=
ed then:
> > > > > > > registering where everything starts and ends. If you have "in=
-band"
> > > > > > > meta data you might require a compatible, but I don't think y=
ou
> > > > > > > do, in this case you should probably carry the content throug=
h a label
> > > > > > > (which will become the partition name) and we can discuss add=
itional
> > > > > > > properties if needed.
> > > > > >
> > > > > > I believe I am going to need a compatible string at the 'partit=
ions'
> > > > > > level to indicate that this is the binman scheme. But we can le=
ave
> > > > > > that until later.
> > > > >
> > > > > Perhaps:
> > > > >
> > > > > compatible =3D "binman", "fixed-partitions";
> > > > >
> > > > > Though I don't understand why binman couldn't just understand wha=
t
> > > > > "fixed-partitions" means rather than "binman".
> > > >
> > > > Well so long as we don't add any binman things in here, you are rig=
ht.
> > > >
> > > > But the eventual goal is parity with current Binman functionality,
> > > > which writes the entire (augmented) description to the DT, allowing
> > > > tools to rebuild / repack / replace pieces later, maintaining the s=
ame
> > > > alignment constraints, etc. I am assuming that properties like 'ali=
gn
> > > > =3D <16>' would not fit with fixed-partitions.
> > >
> > > I am personally not bothered by this kind of properties. But if we pl=
an
> > > on adding too much properties, I will advise to indeed use another na=
me
> > > than fixed-partitions (or add the "binman" secondary compatible)
> > > otherwise it's gonna be hard to support in the code while still
> > > restraining as much as we can the other partition schema.
> >
> > Agreed. It's a trade off. I think we need enough to understand the
> > problem (not just presented with a solution), agree on the general
> > solution/direction, and then discuss specific additions.
> >
> > > > But if we don't preserve
> > > > these properties then Binman cannot do repacking reliably. Perhaps =
for
> > > > now I could put the augmented DT in its own section somewhere, but =
I
> > > > am just not sure if that will work in a real system. E.g. with VBE =
the
> > > > goal is to use the DT to figure out how to access the firmware, upd=
ate
> > > > it, etc.
> >
> > VBE?

Verified Boot for Embedded, an EFI alternative with no callbacks.

> >
> > > > Is it not possible to have my own node with whatever things Binman
> > > > needs in it (subject to review of course)? i.e. could we discuss ho=
w
> > > > to encode it, but argue less about whether things are needed? I
> > > > kind-of feel I know what is needed, since I wrote the tool.
> >
> > What we don't need is the same information in 2 places for the DTB
> > used at runtime. If the binman node is removed, do whatever you want.
> > If you want to keep it at runtime, then it's got to extend what we
> > already have.
> >
> > I don't think anyone is disagreeing about whether specific information
> > is needed or not.
> >
> > > > > > So you are suggesting 'label' for the contents. Rob suggested
> > > > > > 'compatible' [1], so what should I do?
> > > > >
> > > > > "label" is for consumption by humans, not tools/software. Compati=
ble
> > > > > values are documented, label values are not. Though the partition
> > > > > stuff started out using label long ago and it's evolved to prefer=
ring
> > > > > compatible.
> > > >
> > > > OK so we are agreed that we are going with 'compatible'.
> > >
> > > Still strongly disagree here.
> >
> > Miquel is right. I was confused here. "label" is still pretty much
> > used for what the image is. Though we do have "u-boot,env" for both it
> > seems.
> >
> > My position on "label" stands. To the extent we have images for common
> > components, I think we should standardize the names. Certainly if
> > tools rely on the names, then they should be documented.
>
> OK thanks for clearing that up.
>
> But at present 'label' is free-form text. If I change it to an enum,
> won't that break things? If not, how do I actually do it?
>
> There is a u-boot.yaml but it doesn't actually have a "u-boot" label
> in the schema. In fact it seems that the label is not validated at
> all?

It looks like I can just add it to a separate schema file, which is
what I did in the latest version.

>
> >
> >
> > > My understanding is that a compatible carries how the content is
> > > organized, and how this maybe specific (like you have in-band meta da=
ta
> > > data that needs to be parsed in a specific way or in your case
> > > additional specific properties in the DT which give more context abou=
t
> > > how the data is stored). But the real content of the partition, ie. i=
f
> > > it contains a firmware, the kernel or some user data does not belong =
to
> > > the compatible.
> > >
> > > I.e:
> > > - The first byte of my partition gives the compression algorithm:
> > >   -> compatible =3D "compressed-partition-foo";
> > >      or
> > >   -> compatible =3D "fixed-partitions" + compression-algorithm =3D "f=
oo";
> > > - The partition contains a picture of my dog:
> > >   -> label =3D "my dog is beautiful"
> > >   but certainly not
> > >   -> compatible =3D "my-dog";
> >
> > IMO, compatible in this case should convey "JPEG image" or similar.
> >
> > > I don't see why, for the binman schema, we could not constrain the
> > > labels?
> >
> > Yes, but those should follow what we already have. "u-boot" for
> > example rather than "data,u-boot" which I think Simon had in some
> > version of this.
>
> Yes, don't worry, I had some feedback from Alper but have given up on
> that approach.

Regards,
Simon
