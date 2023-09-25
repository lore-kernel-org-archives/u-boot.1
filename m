Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9435CE79A5
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 22:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A900A86BA6;
	Tue, 26 Sep 2023 00:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kGWxpGGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC8986BE0; Tue, 26 Sep 2023 00:26:09 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EEE86BA6
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 00:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so11671106e87.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695680766; x=1696285566; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHB5IL1T88qgL4XItKYJYwf3rmjKIe0AB+bW8EbZuVY=;
 b=kGWxpGGll/7eGWLLUU5IkjZAGyEbKzcn+Jdbje1U4ex9Qq1BWU/cIuH/jSej+O07dq
 UgmopMHHi1IAW/iBy+JTlnB7lN0NuBrG6bgRouXy8CVaV2JmvSb6yQcFL2uSEgsA6yKd
 mSXX7DdWr28mq+4yuMSFt3uFTzMvzWK9UJsv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695680766; x=1696285566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHB5IL1T88qgL4XItKYJYwf3rmjKIe0AB+bW8EbZuVY=;
 b=gJv+9vUsyW6Hk/Paer36+JLn9vrPgYJrZA5l8vHQ2/5TvnEjnYK5wcXpK8TbNDVNIU
 KjZyenwtthYFkLPLJobVwNdT7/51UaA3UkYRgCoqngj+1t+EMlTs/eC46E2Ao2kssWOP
 FfOF7Jq2A+wp5DsAP/BwUBxMQvmdMT0bW6r5WMjdiqkcgVrw+xCyMsJ/8ITlgTYkgnOM
 UuwcxgJ3XV0mEeYGwhqOCp0t57nKz7s8XX8W2yidXSPq98/xcPgOdlBpQcbFZMymfAbY
 v0sS3Fr9ZJkFn+8aRSY8letuyX1lmRsilfR8rC3Gv4D4nKjdCtnAQ5Rv9jPYVMPJhMxy
 sw1w==
X-Gm-Message-State: AOJu0YxmHGf4JGb9nSLsTYYSljJPtE5Do6StVPy0RSUmREVim4twFhdl
 35Hyk7lQF64jxdhOsCfmrwiCV49ixNKxAG7vtO1Zjw==
X-Google-Smtp-Source: AGHT+IFuDsUZ/C+JOgCrSAxNKjCJEH0stsapm18e9nwK4naev+5fQkTG+WFNiy9706sZDwBh+w1k4UJRO29flm15igk=
X-Received: by 2002:a05:6512:3b12:b0:4fa:da4f:636f with SMTP id
 f18-20020a0565123b1200b004fada4f636fmr8482017lfv.32.1695680765816; Mon, 25
 Sep 2023 15:26:05 -0700 (PDT)
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
In-Reply-To: <CAL_JsqJfjHqtTB2qfLmNxmQtn1rZewNyNe+Knu_Z4UCdPoPhSQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 16:25:47 -0600
Message-ID: <CAPnjgZ1npHPpwPmw2f4=E3U5=RH0m4R+W_MZ7+oXdmDF=EeUjg@mail.gmail.com>
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

Hi Rob,

On Mon, 25 Sept 2023 at 12:49, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Sep 25, 2023 at 11:25=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Miquel,
> >
> > On Mon, 25 Sept 2023 at 09:24, Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
> > >
> > > Hi Simon,
> > >
> > > > > > > > > > > > I was assuming that I should create a top-level com=
patible =3D "binman"
> > > > > > > > > > > > node, with subnodes like compatible =3D "binman,bl3=
1-atf", for example.
> > > > > > > > > > > > I should use the compatible string to indicate the =
contents, right?
> > > > > > > > > > >
> > > > > > > > > > > Yes for subnodes, and we already have some somewhat s=
tandard ones for
> > > > > > > > > > > "u-boot" and "u-boot-env". Though historically, "labe=
l" was used.
> > > > > > > > > >
> > > > > > > > > > Binman has common properties for all entries, including=
 "compress"
> > > > > > > > > > which sets the compression algorithm.
> > > > > > > > >
> > > > > > > > > I see no issue with adding that. It seems useful and some=
thing missing
> > > > > > > > > in the existing partition schemas.
> > > > > > > >
> > > > > > > > OK I sent a patch with that.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > So perhaps I should start by defining a new binman,bl31=
-atf which has
> > > > > > > > > > common properties from an "binman,entry" definition?
> > > > > > > > >
> > > > > > > > > I don't understand the binman prefix. The contents are AT=
F (or TF-A
> > > > > > > > > now). Who wrote it to the flash image is not relevant.
> > > > > > > >
> > > > > > > > Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or =
should we
> > > > > > > > change it to "tfa-bl31"?
> > > > > > >
> > > > > > > I don't really understand the relationship with TF-A here. Ca=
n't we
> > > > > > > just have a kind of fixed-partitions with additional properti=
es like
> > > > > > > the compression?
> > > > > >
> > > > > > Binman needs to know what to put in there, which is the purpose=
 of the
> > > > > > compatible string.
> > > > >
> > > > > But "what" should be put inside the partition is part of the inpu=
t
> > > > > argument, not the output. You said (maybe I got this wrong) that =
the
> > > > > schema would apply to the output of binman. If you want to let us=
er
> > > > > know what's inside, maybe it is worth adding a label, but otherwi=
se I
> > > > > don't like the idea of a compatible for that, which for me would =
mean:
> > > > > "here is how to handle that specific portion of the flash/here is=
 how
> > > > > the flash is organized".
> > > >
> > > > But I thought that the compatible string was for that purpose? See =
for
> > > > example "brcm,bcm4908-firmware" and "brcm,bcm963xx-imagetag" and
> > > > "linksys,ns-firmware".
> > >
> > > These three examples apparently need specific handling, the partition=
s
> > > contain meta-data that a parser needs to check or something like that=
.
> > > And finally it looks like partition names are set depending on the
> > > content that was discovered, so yes, the partition name is likely the
> > > good location to tell users/OSes what's inside.
> > >
> > > > > > > Also, I still don't understand the purpose of this schema. So=
 binman
> > > > > > > generates an image, you want to flash this image and you woul=
d like the
> > > > > > > tool to generate the corresponding (partition) DT snippet aut=
omatically.
> > > > > > > Do I get this right? I don't get why you would need new compa=
tibles for
> > > > > > > that.
> > > > > >
> > > > > > It is actually the other way around. The schema tells Binman ho=
w to
> > > > > > build the image (what goes in there and where). Then outputs an
> > > > > > updated DT which describes where everything ended up, for use b=
y other
> > > > > > tools, e.g. firmware update. It is a closed loop in that sense.=
 See
> > > > > > the references for more information.
> > > > >
> > > > > Maybe I fail to see why you would want these description to be
> > > > > introduced here, if they are not useful to the OS.
> > > >
> > > > Well I was asked to send them to Linux since they apparently don't
> > > > belong in dt-schema.
>
> That is not what I said. I said fixed-partitions should be extended. I
> prefer they are extended in-place before moving them rather than the
> other way around.

OK.

>
> > > > These are firmware bindings, as indicated, but I
> > > > took them out of the /firmware node since that is for a different
> > > > purpose. Rob suggested that partitions was a good place. We have fw=
upd
> > > > using DT to hold the firmware-update information, so I expect it wi=
ll
> > > > move to use these bindings too.
> > >
> > > I would definitely use fixed partitions as that's what you need then:
> > > registering where everything starts and ends. If you have "in-band"
> > > meta data you might require a compatible, but I don't think you
> > > do, in this case you should probably carry the content through a labe=
l
> > > (which will become the partition name) and we can discuss additional
> > > properties if needed.
> >
> > I believe I am going to need a compatible string at the 'partitions'
> > level to indicate that this is the binman scheme. But we can leave
> > that until later.
>
> Perhaps:
>
> compatible =3D "binman", "fixed-partitions";
>
> Though I don't understand why binman couldn't just understand what
> "fixed-partitions" means rather than "binman".

Well so long as we don't add any binman things in here, you are right.

But the eventual goal is parity with current Binman functionality,
which writes the entire (augmented) description to the DT, allowing
tools to rebuild / repack / replace pieces later, maintaining the same
alignment constraints, etc. I am assuming that properties like 'align
=3D <16>' would not fit with fixed-partitions. But if we don't preserve
these properties then Binman cannot do repacking reliably. Perhaps for
now I could put the augmented DT in its own section somewhere, but I
am just not sure if that will work in a real system. E.g. with VBE the
goal is to use the DT to figure out how to access the firmware, update
it, etc.

Is it not possible to have my own node with whatever things Binman
needs in it (subject to review of course)? i.e. could we discuss how
to encode it, but argue less about whether things are needed? I
kind-of feel I know what is needed, since I wrote the tool.

>
>
> > So you are suggesting 'label' for the contents. Rob suggested
> > 'compatible' [1], so what should I do?
>
> "label" is for consumption by humans, not tools/software. Compatible
> values are documented, label values are not. Though the partition
> stuff started out using label long ago and it's evolved to preferring
> compatible.

OK so we are agreed that we are going with 'compatible'.

>
> > With this schema, would every node be called 'partition@...' or is
> > there flexibility to use other names?
>
> The preference is to use generic names. Do you mean without a
> unit-address or different from "partition"? The need for the input
> side of binman to have dynamic addresses seems like the biggest issue.
> That's allowed in other cases with "partition-N" or "partition-foo"
> IIRC. I don't think we want to allow that for "fixed-partitions" at
> least in the DTB (i.e. the output side of binman).

OK I suppose this is the problem with starting small. I was hoping to
build up the schema piece by piece but now I am wondering whether
every little detail will get redirected and I'll end up with something
that Binman cannot use.

So far all I have is that I can add a 'compress' property and a
'compatible' which describes the contents. I suppose it is a start.

Regards,
Simon
