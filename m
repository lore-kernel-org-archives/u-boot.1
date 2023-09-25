Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46274CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 12:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8472586B93;
	Mon, 25 Sep 2023 14:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e+tIn7Qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD7886BA8; Mon, 25 Sep 2023 14:33:35 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37EE786B89
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 14:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50305abe5f0so9816269e87.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695645212; x=1696250012; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOrEG4tfl75vIbxlTDfOPlF5gglTowT9ubBWOy0wGIE=;
 b=e+tIn7Qgc6/+CPFJHXKN1Ezqa1LUipTR+z+4bULdDpOblOXt4pyUPeNroNsrvPdRJN
 W7Et83PX3SaBgJqLASGW8G1nObdnVneLF5IcZ5V8v73xzUDuz2o091nsHTipAPnW9qBs
 zC/WRVcWja5TS1x65lPl5vkOVB0zXYdLvBQ5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695645212; x=1696250012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOrEG4tfl75vIbxlTDfOPlF5gglTowT9ubBWOy0wGIE=;
 b=aBOhOongAc893+qlntBiqapGB6RWDEarFfesnt4q8T2vdLfaUJRJ9LbfKQEMLL01vC
 etjHjOR2BbTywMsGtitoyXfoXjBvrciuAuW5QdP3quMEw9XPhygmy6+K6qcSg7ev66z4
 AzGAOO3Ulf3SeKXHqWGtoiJcowMF/g1rtS2sXALpr7Sb5cN/8mkgIpVnd//9ZvnZCvea
 sGeufOHKUUnEAjVJKGKO7yvX9gbcTsUmqD4gHGN0KPOfqLBqv29FKd04u6NUWyohQxkE
 TMSB+ntLzJ8pA0fNebC3rX1BY+DAQPr6V8ueP+BSiKboL1HbbkDaZH+fDeh2WgFX2qCg
 ldiA==
X-Gm-Message-State: AOJu0Yy6kwzz4jqB3bbedqrklM4nZTKDxeNiIUPu9tPyz5uPQ3/N3ePn
 Ir+eo6n7N5wORoDfZA4n6QIBpM2WoYPdJFODTRvpRw==
X-Google-Smtp-Source: AGHT+IHQ2mVoYf0gISCrXjW928D9kOOj+nnB4kchHzakcfJ5+nTvY6NHkpDiRDXDUhEg1TfER0INKlLUgGq8Jiet7Nw=
X-Received: by 2002:ac2:4c9c:0:b0:503:18c3:d87a with SMTP id
 d28-20020ac24c9c000000b0050318c3d87amr5120311lfl.21.1695645212082; Mon, 25
 Sep 2023 05:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org>
 <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
 <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
 <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
 <20230925092122.0b615f25@xps-13>
In-Reply-To: <20230925092122.0b615f25@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 06:33:14 -0600
Message-ID: <CAPnjgZ0Z5J_33HuQF-5XgDFmZim0nHHzvZJOOZobWw_cOJd=9g@mail.gmail.com>
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

Hi Miquel,

On Mon, 25 Sept 2023 at 01:21, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Fri, 22 Sep 2023 13:51:14 -0600:
>
> > Hi Rob,
> >
> > On Fri, 22 Sept 2023 at 13:43, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Sep 22, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote:
> > > > > > Hi Rob,
> > > > > >
> > > > > > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wr=
ote:
> > > > > > >
> > > > > > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > >
> > > > > > > > Binman[1] is a tool for creating firmware images. It allows=
 you to
> > > > > > > > combine various binaries and place them in an output file.
> > > > > > > >
> > > > > > > > Binman uses a DT schema to describe an image, in enough det=
ail that
> > > > > > > > it can be automatically built from component parts, disasse=
mbled,
> > > > > > > > replaced, listed, etc.
> > > > > > > >
> > > > > > > > Images are typically stored in flash, which is why this bin=
ding is
> > > > > > > > targeted at mtd. Previous discussion is at [2] [3].
> > > > > > > >
> > > > > > > > [1] https://u-boot.readthedocs.io/en/stable/develop/package=
/binman.html
> > > > > > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3=
-sjg@chromium.org/
> > > > > > > > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> > > > > > >
> > > > > > > You missed:
> > > > > > >
> > > > > > > https://github.com/devicetree-org/dt-schema/pull/110
> > > > > > >
> > > > > > > where I said: We certainly shouldn't duplicate the existing p=
artitions
> > > > > > > bindings. What's missing from them (I assume we're mostly tal=
king
> > > > > > > about "fixed-partitions" which has been around forever I thin=
k (before
> > > > > > > me))?
> > > > > > >
> > > > > > > To repeat, unless there is some reason binman partitions conf=
lict with
> > > > > > > fixed-partitions, you need to start there and extend it. From=
 what's
> > > > > > > posted here, it neither conflicts nor needs extending.
> > > > > >
> > > > > > I think at this point I am just hopelessly confused. Have you t=
aken a
> > > > > > look at the binman schema? [1]
> > > > >
> > > > > Why do I need to? That's used for some tool and has nothing to do=
 with a
> > > > > device's DTB. However, I thought somewhere in this discussion you=
 showed
> > > > > it under a flash device node.
> > > >
> > > > Yes, that is the intent (under a flash node).
> > > >
> > > > > Then I care because then it overlaps with
> > > > > what we already have for partitions. If I misunderstood that, the=
n just
> > > > > put your schema with your tool. Only users of the tool should car=
e about
> > > > > the tool's schema.
> > > >
> > > > OK. I believe that binman will fit into both camps, since its input=
 is
> > > > not necessarily fully formed. E.g. if you don't specify the offset =
of
> > > > an entry, then it will be packed automatically. But the output is
> > > > fully formed, in that Binman now knows the offset so can write it t=
o
> > > > the DT.
> > >
> > > I suppose it could take its own format as input and then write out
> > > something different for the "on the device" format (i.e.
> > > fixed-partitions). At least for the dynamic offsets, we may need
> > > something allowed for binman input, but not allowed on device. In
> > > general, there is support for partitions without addresses/offsets,
> > > but only for partitions that have some other way to figure that out
> > > (on disk partition info).
> > >
> > > There's also the image filename which doesn't really belong in the on
> > > device partitions. So maybe the input and output schemas should be
> > > separate.
> >
> > OK, I'll focus on the output schema for now. I suspect this will be a
> > grey area though.
> >
> > As an example, if you replace a binary in the firmware, Binman can
> > repack the firmware to make room, respecting the alignment and size
> > constraints. So these need to be in the output schema somehow.
> >
> > >
> > > > > > I saw this file, which seems to extend a partition.
> > > > > >
> > > > > > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-p=
artitions.yaml
> > > > >
> > > > > IIRC, that's a different type where partition locations are store=
d in
> > > > > the flash, so we don't need location and size in DT.
> > > >
> > > > OK.
> > > >
> > > > >
> > > > > >
> > > > > > I was assuming that I should create a top-level compatible =3D =
"binman"
> > > > > > node, with subnodes like compatible =3D "binman,bl31-atf", for =
example.
> > > > > > I should use the compatible string to indicate the contents, ri=
ght?
> > > > >
> > > > > Yes for subnodes, and we already have some somewhat standard ones=
 for
> > > > > "u-boot" and "u-boot-env". Though historically, "label" was used.
> > > >
> > > > Binman has common properties for all entries, including "compress"
> > > > which sets the compression algorithm.
> > >
> > > I see no issue with adding that. It seems useful and something missin=
g
> > > in the existing partition schemas.
> >
> > OK I sent a patch with that.
> >
> > >
> > > > So perhaps I should start by defining a new binman,bl31-atf which h=
as
> > > > common properties from an "binman,entry" definition?
> > >
> > > I don't understand the binman prefix. The contents are ATF (or TF-A
> > > now). Who wrote it to the flash image is not relevant.
> >
> > Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should we
> > change it to "tfa-bl31"?
>
> I don't really understand the relationship with TF-A here. Can't we
> just have a kind of fixed-partitions with additional properties like
> the compression?

Binman needs to know what to put in there, which is the purpose of the
compatible string.

>
> > > We already have some compatibles in use. We should reuse them if
> > > possible. Not sure about TF-A though.
> >
> > OK.
> >
>
> Also, I still don't understand the purpose of this schema. So binman
> generates an image, you want to flash this image and you would like the
> tool to generate the corresponding (partition) DT snippet automatically.
> Do I get this right? I don't get why you would need new compatibles for
> that.

It is actually the other way around. The schema tells Binman how to
build the image (what goes in there and where). Then outputs an
updated DT which describes where everything ended up, for use by other
tools, e.g. firmware update. It is a closed loop in that sense. See
the references for more information.

Regards,
Simon

[1] https://u-boot.readthedocs.io/en/latest/develop/package/index.html
[2] https://pretalx.com/media/osfc2019/submissions/Y7EN9V/resources/Binman_=
-_A_data-controlled_firmware_packer_for_U-B_pFU3n2K.pdf
[3] https://www.youtube.com/watch?v=3DL84ujgUXBOQ
