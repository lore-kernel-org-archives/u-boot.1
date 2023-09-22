Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2AACE7AB7
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 19:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACEC386199;
	Fri, 22 Sep 2023 21:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bo3bEub5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBF38640F; Fri, 22 Sep 2023 21:51:28 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC4885DFA
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 21:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50435ad51bbso2551938e87.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695412286; x=1696017086; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcpcIFJ61Cgs0SnYetl6zxlaNczsC0YBO5OwWuuMpjg=;
 b=Bo3bEub5BxuiH2LZgjnrw6Xc1irIWj/kd3WtfdnYQxdeRdHrT3T6pY3IHyDTpCRp37
 X90aPbfOpAmFUh4NtNfvZW5roym1DjlS2Kz4cgxJuPLIEEQML/P+0/Z0nTQBTQYdO6uG
 0WF82tgryTLNjQ+9lp/g0nOa/fFSHxz/8hF5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695412286; x=1696017086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QcpcIFJ61Cgs0SnYetl6zxlaNczsC0YBO5OwWuuMpjg=;
 b=DRis4C8S9s3+WR57L3UCbTYzcoqeTUNBPMUkzUWlEm77/uJPfLZaXvloRzE/IuPUQu
 5c5UJWpk0ziqhgzCjlqsW9cjkid60iM5KbgNyOOILZDNLU8AbPBmiRIR11qNyy8GV7xk
 U0NeDfhuGw49L6snGjRFdz5F+Z0ljr5RqOktN+0ymCIZUpFdeCyduLa5WTEzzndg5wkD
 efk/5SVZc3FIFCaAZHvxLc1Mq2DRs/3YhlMANO2+j87Y38hh0kOFxtT0jUd+9wZGdHGE
 4zpMS03TLCINZbbX4H+zXD/ttybTA65008oM+bSoH3r5hAHjBs9Qh4TojYDiyVR1LTnj
 1uBg==
X-Gm-Message-State: AOJu0YyDIF6CgBSiEx8PUOTLtDzunEbE11Bv6ETGgEDHesFabA+AnrdW
 1xTSopd6WoJ0ihxLKMzHHM4gcsksMoGmKFdmNGQJFQ==
X-Google-Smtp-Source: AGHT+IGL6fQHrX1AqP0gkgxhmMGrRSypGWx3ZtAcsfH7zlp8ROCDaeJq0vczx5UZ4LzUj+CQKnM3WMIgnpzbaTlIv70=
X-Received: by 2002:a05:6512:32a2:b0:503:2a53:7480 with SMTP id
 q2-20020a05651232a200b005032a537480mr431345lfe.49.1695412285461; Fri, 22 Sep
 2023 12:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org>
 <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
 <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
In-Reply-To: <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 13:51:14 -0600
Message-ID: <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
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

On Fri, 22 Sept 2023 at 13:43, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 22, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Rob,
> >
> > On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> > > > Hi Rob,
> > > >
> > > > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > Binman[1] is a tool for creating firmware images. It allows you=
 to
> > > > > > combine various binaries and place them in an output file.
> > > > > >
> > > > > > Binman uses a DT schema to describe an image, in enough detail =
that
> > > > > > it can be automatically built from component parts, disassemble=
d,
> > > > > > replaced, listed, etc.
> > > > > >
> > > > > > Images are typically stored in flash, which is why this binding=
 is
> > > > > > targeted at mtd. Previous discussion is at [2] [3].
> > > > > >
> > > > > > [1] https://u-boot.readthedocs.io/en/stable/develop/package/bin=
man.html
> > > > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg=
@chromium.org/
> > > > > > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> > > > >
> > > > > You missed:
> > > > >
> > > > > https://github.com/devicetree-org/dt-schema/pull/110
> > > > >
> > > > > where I said: We certainly shouldn't duplicate the existing parti=
tions
> > > > > bindings. What's missing from them (I assume we're mostly talking
> > > > > about "fixed-partitions" which has been around forever I think (b=
efore
> > > > > me))?
> > > > >
> > > > > To repeat, unless there is some reason binman partitions conflict=
 with
> > > > > fixed-partitions, you need to start there and extend it. From wha=
t's
> > > > > posted here, it neither conflicts nor needs extending.
> > > >
> > > > I think at this point I am just hopelessly confused. Have you taken=
 a
> > > > look at the binman schema? [1]
> > >
> > > Why do I need to? That's used for some tool and has nothing to do wit=
h a
> > > device's DTB. However, I thought somewhere in this discussion you sho=
wed
> > > it under a flash device node.
> >
> > Yes, that is the intent (under a flash node).
> >
> > > Then I care because then it overlaps with
> > > what we already have for partitions. If I misunderstood that, then ju=
st
> > > put your schema with your tool. Only users of the tool should care ab=
out
> > > the tool's schema.
> >
> > OK. I believe that binman will fit into both camps, since its input is
> > not necessarily fully formed. E.g. if you don't specify the offset of
> > an entry, then it will be packed automatically. But the output is
> > fully formed, in that Binman now knows the offset so can write it to
> > the DT.
>
> I suppose it could take its own format as input and then write out
> something different for the "on the device" format (i.e.
> fixed-partitions). At least for the dynamic offsets, we may need
> something allowed for binman input, but not allowed on device. In
> general, there is support for partitions without addresses/offsets,
> but only for partitions that have some other way to figure that out
> (on disk partition info).
>
> There's also the image filename which doesn't really belong in the on
> device partitions. So maybe the input and output schemas should be
> separate.

OK, I'll focus on the output schema for now. I suspect this will be a
grey area though.

As an example, if you replace a binary in the firmware, Binman can
repack the firmware to make room, respecting the alignment and size
constraints. So these need to be in the output schema somehow.

>
> > > > I saw this file, which seems to extend a partition.
> > > >
> > > > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-parti=
tions.yaml
> > >
> > > IIRC, that's a different type where partition locations are stored in
> > > the flash, so we don't need location and size in DT.
> >
> > OK.
> >
> > >
> > > >
> > > > I was assuming that I should create a top-level compatible =3D "bin=
man"
> > > > node, with subnodes like compatible =3D "binman,bl31-atf", for exam=
ple.
> > > > I should use the compatible string to indicate the contents, right?
> > >
> > > Yes for subnodes, and we already have some somewhat standard ones for
> > > "u-boot" and "u-boot-env". Though historically, "label" was used.
> >
> > Binman has common properties for all entries, including "compress"
> > which sets the compression algorithm.
>
> I see no issue with adding that. It seems useful and something missing
> in the existing partition schemas.

OK I sent a patch with that.

>
> > So perhaps I should start by defining a new binman,bl31-atf which has
> > common properties from an "binman,entry" definition?
>
> I don't understand the binman prefix. The contents are ATF (or TF-A
> now). Who wrote it to the flash image is not relevant.

Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should we
change it to "tfa-bl31"?

>
> We already have some compatibles in use. We should reuse them if
> possible. Not sure about TF-A though.

OK.

Regards,
Simon
