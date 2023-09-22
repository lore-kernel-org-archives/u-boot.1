Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AE8CD484B
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3856F864D4;
	Fri, 22 Sep 2023 20:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oQYSxaLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7720886504; Fri, 22 Sep 2023 20:12:34 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BFAF85DFA
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so2476282a12.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695406351; x=1696011151; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKwr2XjhB87XY1eJcNFIWSnRqkfq4gGTTTV7rcfgoQg=;
 b=oQYSxaLfacc2UTwQC/8vjfMRFjACdSvC07WymecRryjlO4YM6iwR+E2hVD8edeldOZ
 lsy1bPDKZVt1QBWMk7nGNy5/pj8jsuPVQjFQgpK4vrKC59BiV9NE0Halvq02gWcTJhzL
 JoaeQWwS4dR7lfntY33cGYu4vXq7wRHixpU+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695406351; x=1696011151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKwr2XjhB87XY1eJcNFIWSnRqkfq4gGTTTV7rcfgoQg=;
 b=VQ66H4vjRkIS/Vf7Gyy5DEoddpHjqIA3sygb3HaS8TXe5f1bLC6z6j2CbHKNlOiByb
 kI6j34v/CWGRg3a+s7AeCxVRYoYTLLN4MM8C0bRCTA7jQrnlXceFcEnnfpN+DBs9Q6LH
 OBx8Z2q3eukqNDAuLoCUSJ1/BAW6wgG2iOVY2wfvhRdZPPT7pwP8VhwWFOHozMRFrb76
 dJJJg1t4gc7FkPVKeu2yah0lQF6KIYBYW51tThpGIiqi+Zd8JDpO4jSyYmX+lWyLyfXt
 hJF5sTRGLH8eZOayy3oa8Y0SilfCpq2ElvSU+UnGex+485UwRrIbK4qaqz14LsHMg2CT
 4osA==
X-Gm-Message-State: AOJu0YxGR+6epCQh5Q8M1Hesx7fQRh3wAVfAMCw0ZOJXUZdzeoY52Z3P
 Wx6t3wu9uXDzRwFhK1z0kHTx1H9TsOrhwgdY6gNd0g==
X-Google-Smtp-Source: AGHT+IEhGuF05gZ1ykRj7c0nOIVSMf034rK4oo9lAlBZB3RlBbcD+8isF0isGviqL5G0fBM/1IdwSOKb/LE2mWFyyHQ=
X-Received: by 2002:aa7:dc17:0:b0:533:926:da9d with SMTP id
 b23-20020aa7dc17000000b005330926da9dmr220253edu.18.1695406351489; Fri, 22 Sep
 2023 11:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org>
In-Reply-To: <20230922174649.GA3320366-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:12:20 -0600
Message-ID: <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
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

On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> > Hi Rob,
> >
> > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Binman[1] is a tool for creating firmware images. It allows you to
> > > > combine various binaries and place them in an output file.
> > > >
> > > > Binman uses a DT schema to describe an image, in enough detail that
> > > > it can be automatically built from component parts, disassembled,
> > > > replaced, listed, etc.
> > > >
> > > > Images are typically stored in flash, which is why this binding is
> > > > targeted at mtd. Previous discussion is at [2] [3].
> > > >
> > > > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.=
html
> > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chr=
omium.org/
> > > > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> > >
> > > You missed:
> > >
> > > https://github.com/devicetree-org/dt-schema/pull/110
> > >
> > > where I said: We certainly shouldn't duplicate the existing partition=
s
> > > bindings. What's missing from them (I assume we're mostly talking
> > > about "fixed-partitions" which has been around forever I think (befor=
e
> > > me))?
> > >
> > > To repeat, unless there is some reason binman partitions conflict wit=
h
> > > fixed-partitions, you need to start there and extend it. From what's
> > > posted here, it neither conflicts nor needs extending.
> >
> > I think at this point I am just hopelessly confused. Have you taken a
> > look at the binman schema? [1]
>
> Why do I need to? That's used for some tool and has nothing to do with a
> device's DTB. However, I thought somewhere in this discussion you showed
> it under a flash device node.

Yes, that is the intent (under a flash node).

> Then I care because then it overlaps with
> what we already have for partitions. If I misunderstood that, then just
> put your schema with your tool. Only users of the tool should care about
> the tool's schema.

OK. I believe that binman will fit into both camps, since its input is
not necessarily fully formed. E.g. if you don't specify the offset of
an entry, then it will be packed automatically. But the output is
fully formed, in that Binman now knows the offset so can write it to
the DT.

>
> >
> > I saw this file, which seems to extend a partition.
> >
> > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partition=
s.yaml
>
> IIRC, that's a different type where partition locations are stored in
> the flash, so we don't need location and size in DT.

OK.

>
> >
> > I was assuming that I should create a top-level compatible =3D "binman"
> > node, with subnodes like compatible =3D "binman,bl31-atf", for example.
> > I should use the compatible string to indicate the contents, right?
>
> Yes for subnodes, and we already have some somewhat standard ones for
> "u-boot" and "u-boot-env". Though historically, "label" was used.

Binman has common properties for all entries, including "compress"
which sets the compression algorithm.

So perhaps I should start by defining a new binman,bl31-atf which has
common properties from an "binman,entry" definition?

>
> Top-level, meaning the root of the DT? That sound like just something
> for the tool, so I don't care, but it doesn't belong in the DTB.

Sorry, I mean 'top-level' with respect to the partitions.

>
> >
> > Re extending, what is the minimum I can do? Are you looking for
> > something like a "compress" property that indicates that the entry is
> > compressed?
> >
> > I'm really just a bit lost.
>
> Me too.

Regards,
Simon
