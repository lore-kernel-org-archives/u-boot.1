Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F6E7E657
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 17:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF23D86C5D;
	Tue, 26 Sep 2023 19:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pGw9GCyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C383E86B95; Tue, 26 Sep 2023 19:29:25 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1AC86C71
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 19:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B1E42CE12FE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 17:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0654C433CA
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695749360;
 bh=qrBeQ51Dvxv01D+MaeOf5SpdgRWicIvEOSKVURSSzjA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pGw9GCyYBWxdk92513dYnqiRP04Q2Fn6ZkYKyTutg1q/MOSyO2IpBx6COPCOcrHI5
 f5LYZpKDcDXIy/BjuoUKMmkRpzEIAB29Qy21OEajq4XuVBf8Z6q2PJF1fn9Clovs7s
 PLOuKeIVbXmRwaPpgv7Y99jr5za3EizUJsZ52h7yn0cQLy1aIeOSVPeu7brlji+wjo
 Tv1sihBAKjE8xHYSgugAlIIhEq/DAuu9YsY/OrF2upuhnjVV9xVO0jO+0L1hldk6+Z
 UIyJyIIuMKtHKd0Ut5ZQQZSqax8Z7Z8NfwTaiaz+r62zsR5ElA8g6xUXP8ZoBtyUou
 4pN/j4lF2jAfQ==
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5041bb9ce51so14942195e87.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:29:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YxHgkmThAZBiA+4C+gZ1l0PhCFzP0E6JwESUSI02PKFOesb2w3C
 2KCpswxFf8lRyxuw0IQp10mRsYCIMlFvKOd0jw==
X-Google-Smtp-Source: AGHT+IF4jsYIOlWRMaDBVtY1ZGg0bMgAPx9E8v3RDGUGPZuPx/gUDtti2upRNZGqjvQTlkNrF5gZRcr/muks4aGOsIc=
X-Received: by 2002:a05:6512:2520:b0:500:8022:3dc7 with SMTP id
 be32-20020a056512252000b0050080223dc7mr9331056lfb.10.1695749358093; Tue, 26
 Sep 2023 10:29:18 -0700 (PDT)
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
In-Reply-To: <20230926094815.5802e184@xps-13>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Sep 2023 12:29:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_8bhHkHOFL8a8=g1dYL4OY8hGuNDyc0Jz22rEuJzXtQ@mail.gmail.com>
Message-ID: <CAL_JsqL_8bhHkHOFL8a8=g1dYL4OY8hGuNDyc0Jz22rEuJzXtQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, U-Boot Mailing List <u-boot@lists.denx.de>, 
 linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
 Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>, 
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

On Tue, Sep 26, 2023 at 2:48=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello,
>
> > > > > > These are firmware bindings, as indicated, but I
> > > > > > took them out of the /firmware node since that is for a differe=
nt
> > > > > > purpose. Rob suggested that partitions was a good place. We hav=
e fwupd
> > > > > > using DT to hold the firmware-update information, so I expect i=
t will
> > > > > > move to use these bindings too.
> > > > >
> > > > > I would definitely use fixed partitions as that's what you need t=
hen:
> > > > > registering where everything starts and ends. If you have "in-ban=
d"
> > > > > meta data you might require a compatible, but I don't think you
> > > > > do, in this case you should probably carry the content through a =
label
> > > > > (which will become the partition name) and we can discuss additio=
nal
> > > > > properties if needed.
> > > >
> > > > I believe I am going to need a compatible string at the 'partitions=
'
> > > > level to indicate that this is the binman scheme. But we can leave
> > > > that until later.
> > >
> > > Perhaps:
> > >
> > > compatible =3D "binman", "fixed-partitions";
> > >
> > > Though I don't understand why binman couldn't just understand what
> > > "fixed-partitions" means rather than "binman".
> >
> > Well so long as we don't add any binman things in here, you are right.
> >
> > But the eventual goal is parity with current Binman functionality,
> > which writes the entire (augmented) description to the DT, allowing
> > tools to rebuild / repack / replace pieces later, maintaining the same
> > alignment constraints, etc. I am assuming that properties like 'align
> > =3D <16>' would not fit with fixed-partitions.
>
> I am personally not bothered by this kind of properties. But if we plan
> on adding too much properties, I will advise to indeed use another name
> than fixed-partitions (or add the "binman" secondary compatible)
> otherwise it's gonna be hard to support in the code while still
> restraining as much as we can the other partition schema.

Agreed. It's a trade off. I think we need enough to understand the
problem (not just presented with a solution), agree on the general
solution/direction, and then discuss specific additions.

> > But if we don't preserve
> > these properties then Binman cannot do repacking reliably. Perhaps for
> > now I could put the augmented DT in its own section somewhere, but I
> > am just not sure if that will work in a real system. E.g. with VBE the
> > goal is to use the DT to figure out how to access the firmware, update
> > it, etc.

VBE?

> > Is it not possible to have my own node with whatever things Binman
> > needs in it (subject to review of course)? i.e. could we discuss how
> > to encode it, but argue less about whether things are needed? I
> > kind-of feel I know what is needed, since I wrote the tool.

What we don't need is the same information in 2 places for the DTB
used at runtime. If the binman node is removed, do whatever you want.
If you want to keep it at runtime, then it's got to extend what we
already have.

I don't think anyone is disagreeing about whether specific information
is needed or not.

> > > > So you are suggesting 'label' for the contents. Rob suggested
> > > > 'compatible' [1], so what should I do?
> > >
> > > "label" is for consumption by humans, not tools/software. Compatible
> > > values are documented, label values are not. Though the partition
> > > stuff started out using label long ago and it's evolved to preferring
> > > compatible.
> >
> > OK so we are agreed that we are going with 'compatible'.
>
> Still strongly disagree here.

Miquel is right. I was confused here. "label" is still pretty much
used for what the image is. Though we do have "u-boot,env" for both it
seems.

My position on "label" stands. To the extent we have images for common
components, I think we should standardize the names. Certainly if
tools rely on the names, then they should be documented.


> My understanding is that a compatible carries how the content is
> organized, and how this maybe specific (like you have in-band meta data
> data that needs to be parsed in a specific way or in your case
> additional specific properties in the DT which give more context about
> how the data is stored). But the real content of the partition, ie. if
> it contains a firmware, the kernel or some user data does not belong to
> the compatible.
>
> I.e:
> - The first byte of my partition gives the compression algorithm:
>   -> compatible =3D "compressed-partition-foo";
>      or
>   -> compatible =3D "fixed-partitions" + compression-algorithm =3D "foo";
> - The partition contains a picture of my dog:
>   -> label =3D "my dog is beautiful"
>   but certainly not
>   -> compatible =3D "my-dog";

IMO, compatible in this case should convey "JPEG image" or similar.

> I don't see why, for the binman schema, we could not constrain the
> labels?

Yes, but those should follow what we already have. "u-boot" for
example rather than "data,u-boot" which I think Simon had in some
version of this.

Rob
