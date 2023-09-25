Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4477DCE7A9F
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 16:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 779E286BE7;
	Mon, 25 Sep 2023 18:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K4vBHNMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCFA86C37; Mon, 25 Sep 2023 18:25:47 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD4D86B4E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 18:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-532784c8770so8182596a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695659145; x=1696263945; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I7B0RUifDFieWMfWXnkwhXX401TR2vA2nTDQCCR8Y30=;
 b=K4vBHNMRGJK5pXyxen61X8e2kmodWrRFTunAMQ/aE+QOfKdR64Yz5+t+rURKV92CLJ
 MWoUu3+Y3iVVR0JQG8kYhFbaDquHCBz5bCNpMVa1WJuvPbMg/XcCk2aU+qsf5/loxnpn
 phicTK0inLTUrDm6nKEF06L89eTGiwyblyfTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695659145; x=1696263945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I7B0RUifDFieWMfWXnkwhXX401TR2vA2nTDQCCR8Y30=;
 b=o4BxJm5laJrU82poGKyKA/tR7cyMRKGUOCB29yG2R/v4baNX7tg40N5QLVtb3msT7p
 8TY47VIyNY8y3I+eViSiAXqrs0WYYoTXlxp4buIlwPUxl3jcUXQKLSQP3s9cTK/MvLr9
 J1X00pGmfbGDU2eTUUmjBkKN+bXzhA8q9h8//qIvxkZanBWRSlGcX9gwtl5h5oeTw4Bc
 M0qWuIaXjcvzwiU5v7QLVr+7wdBa5Ztx6hqrl8sQAGOBSo42x5XRNCieFJf2AbwsMR0j
 Mw9n0odrYB+o/wnoOkWwd1kKoqyyShaRBKRiHgf+Dr36ppfyKpWkXmoR67S7h6eThwJM
 QGxA==
X-Gm-Message-State: AOJu0YyyhOFLC8Ef4rBdIAsqrkQTgpqT4pK39iugwWQkYkfzmRizUN8L
 zHub8vEO8bKXT3b1HikzCnOeJTh1n9xyhAVTRPqa/w==
X-Google-Smtp-Source: AGHT+IFpDPy47xvBsLVS3qz0xwzjWQQKDNvGB22OhGv49Ye4weixbW/ojGlV0Tkpm1x70z/zgeZpESgzUMe3S9sc8UQ=
X-Received: by 2002:aa7:c543:0:b0:530:c363:449c with SMTP id
 s3-20020aa7c543000000b00530c363449cmr5877025edr.40.1695659144735; Mon, 25 Sep
 2023 09:25:44 -0700 (PDT)
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
In-Reply-To: <20230925172447.43dcef88@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 10:25:33 -0600
Message-ID: <CAPnjgZ20c9FsYVjSrQ9qbFy9Y67BqDP2zxMyATx===PFhO69Ew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, linux-mtd@lists.infradead.org, 
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor+dt@kernel.org>,
 Dhruva Gole <d-gole@ti.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
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

Hi Miquel,

On Mon, 25 Sept 2023 at 09:24, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> > > > > > > > > > I was assuming that I should create a top-level compatible = "binman"
> > > > > > > > > > node, with subnodes like compatible = "binman,bl31-atf", for example.
> > > > > > > > > > I should use the compatible string to indicate the contents, right?
> > > > > > > > >
> > > > > > > > > Yes for subnodes, and we already have some somewhat standard ones for
> > > > > > > > > "u-boot" and "u-boot-env". Though historically, "label" was used.
> > > > > > > >
> > > > > > > > Binman has common properties for all entries, including "compress"
> > > > > > > > which sets the compression algorithm.
> > > > > > >
> > > > > > > I see no issue with adding that. It seems useful and something missing
> > > > > > > in the existing partition schemas.
> > > > > >
> > > > > > OK I sent a patch with that.
> > > > > >
> > > > > > >
> > > > > > > > So perhaps I should start by defining a new binman,bl31-atf which has
> > > > > > > > common properties from an "binman,entry" definition?
> > > > > > >
> > > > > > > I don't understand the binman prefix. The contents are ATF (or TF-A
> > > > > > > now). Who wrote it to the flash image is not relevant.
> > > > > >
> > > > > > Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should we
> > > > > > change it to "tfa-bl31"?
> > > > >
> > > > > I don't really understand the relationship with TF-A here. Can't we
> > > > > just have a kind of fixed-partitions with additional properties like
> > > > > the compression?
> > > >
> > > > Binman needs to know what to put in there, which is the purpose of the
> > > > compatible string.
> > >
> > > But "what" should be put inside the partition is part of the input
> > > argument, not the output. You said (maybe I got this wrong) that the
> > > schema would apply to the output of binman. If you want to let user
> > > know what's inside, maybe it is worth adding a label, but otherwise I
> > > don't like the idea of a compatible for that, which for me would mean:
> > > "here is how to handle that specific portion of the flash/here is how
> > > the flash is organized".
> >
> > But I thought that the compatible string was for that purpose? See for
> > example "brcm,bcm4908-firmware" and "brcm,bcm963xx-imagetag" and
> > "linksys,ns-firmware".
>
> These three examples apparently need specific handling, the partitions
> contain meta-data that a parser needs to check or something like that.
> And finally it looks like partition names are set depending on the
> content that was discovered, so yes, the partition name is likely the
> good location to tell users/OSes what's inside.
>
> > > > > Also, I still don't understand the purpose of this schema. So binman
> > > > > generates an image, you want to flash this image and you would like the
> > > > > tool to generate the corresponding (partition) DT snippet automatically.
> > > > > Do I get this right? I don't get why you would need new compatibles for
> > > > > that.
> > > >
> > > > It is actually the other way around. The schema tells Binman how to
> > > > build the image (what goes in there and where). Then outputs an
> > > > updated DT which describes where everything ended up, for use by other
> > > > tools, e.g. firmware update. It is a closed loop in that sense. See
> > > > the references for more information.
> > >
> > > Maybe I fail to see why you would want these description to be
> > > introduced here, if they are not useful to the OS.
> >
> > Well I was asked to send them to Linux since they apparently don't
> > belong in dt-schema. These are firmware bindings, as indicated, but I
> > took them out of the /firmware node since that is for a different
> > purpose. Rob suggested that partitions was a good place. We have fwupd
> > using DT to hold the firmware-update information, so I expect it will
> > move to use these bindings too.
>
> I would definitely use fixed partitions as that's what you need then:
> registering where everything starts and ends. If you have "in-band"
> meta data you might require a compatible, but I don't think you
> do, in this case you should probably carry the content through a label
> (which will become the partition name) and we can discuss additional
> properties if needed.

I believe I am going to need a compatible string at the 'partitions'
level to indicate that this is the binman scheme. But we can leave
that until later.

So you are suggesting 'label' for the contents. Rob suggested
'compatible' [1], so what should I do?

With this schema, would every node be called 'partition@...' or is
there flexibility to use other names?

One other point to note is that some entry types will eventually need
other properties, which vary depending on the type. For example a
signature entry will need to hold the algorithm name used to generate
(and therefore at runtime check) the signature.

>
> > > > [1] https://u-boot.readthedocs.io/en/latest/develop/package/index.html
> > > > [2] https://pretalx.com/media/osfc2019/submissions/Y7EN9V/resources/Binman_-_A_data-controlled_firmware_packer_for_U-B_pFU3n2K.pdf
> > > > [3] https://www.youtube.com/watch?v=L84ujgUXBOQ
> > >
> >
> > Regards,
> > Simon

Regards,
Simon

[1] https://github.com/devicetree-org/dt-schema/pull/110
