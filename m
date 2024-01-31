Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22535C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 22:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BBA87626;
	Wed, 31 Jan 2024 23:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dRI/oedf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65A787626; Wed, 31 Jan 2024 23:03:16 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D7D8760D
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 23:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BE9BCCE234C
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 22:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD5C43390
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706738591;
 bh=NrURalmEDB8QSQaNJAOtpDGB0/SdbPwjFYWSRsBH0cI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dRI/oedfprzgFEjtY+K8niKUu65BM91eAEORQdc6+vijISBASpkMqvFKXuI0sw6Tn
 VxI4zcAP9QrbPWr6lCnOb6YGL8BacDxujq7faSXrIHsp3KKI8Q9p5WPuqZzNJoI3ND
 WoQ6BziisWWI3lbnIqdeePrfBh2E4kfAJ1FW2ho7EZ80ka1Xlxj+pU74n4o/jUwR10
 D2678IDi9bGEzOm2pshQlXIZdm19swPmjrHIzieAg6cbJTlOE4eMw+yutHmz4mo3Sa
 fIkVCioFMGRah9Gpy1g6mWRgKYPt8DBXL6OgoHdYmDV+ZykOGJ3Ox3CRkvs93RxQdz
 HkcTwF9b0RtXQ==
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-2cf5917f049so3987021fa.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 14:03:10 -0800 (PST)
X-Gm-Message-State: AOJu0YzEvHixv6fBVeYbx5h/7sxBgiRshd5cW76gymS1DAQ+tReMnG36
 t8vjdtUguzRbyBFyzxyZEToJ+Mput08JHmako2j/+Nz6PN3V+UHLi5c9c64AzKOZRBw/s+Ch4hr
 OJWmHIRPKmQQz3TNdCOHQZWQMgA==
X-Google-Smtp-Source: AGHT+IGN+6UIGTC1ipujzA/GBue9J6kFeYE1znoIhCLxcIkIvfGo7/NaxtZgSn087dBm68j+dW+OGSQohBpvVyM70us=
X-Received: by 2002:a2e:87c4:0:b0:2cc:d3b4:18f2 with SMTP id
 v4-20020a2e87c4000000b002ccd3b418f2mr2175581ljj.41.1706738589193; Wed, 31 Jan
 2024 14:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231213121353.GA31326@willie-the-truck>
 <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
 <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
 <20240109143349.GR1610741@bill-the-cat>
 <CAFLszTjwhy24UiT6kUJABMC1Xn0h9Q1q9fYpZZJg9DX8Vss9cA@mail.gmail.com>
 <CAFLszTjPAHd6RdO1mvatXC=yRS+h=sgJ_pMdyEnkROTx7yRpog@mail.gmail.com>
 <CAK7LNARsY6-rrx=sNFq6oFqpqf0s5S_=3DrUsCOS7zF0BXcoTg@mail.gmail.com>
In-Reply-To: <CAK7LNARsY6-rrx=sNFq6oFqpqf0s5S_=3DrUsCOS7zF0BXcoTg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 31 Jan 2024 16:02:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYB0D5wAfedsb6tQp4EmD1AROgxiCncwO7gvA2p1C6Lg@mail.gmail.com>
Message-ID: <CAL_JsqLYB0D5wAfedsb6tQp4EmD1AROgxiCncwO7gvA2p1C6Lg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Will Deacon <will@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 workflows@vger.kernel.org
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

On Tue, Jan 30, 2024 at 3:16=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Jan 26, 2024 at 1:04=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > On Wed, 17 Jan 2024 at 06:14, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Masahiro, Tom,
> > >
> > > On Tue, 9 Jan 2024 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jan 09, 2024 at 11:01:42PM +0900, Masahiro Yamada wrote:
> > > > > Hi Simon,
> > > > >
> > > > >
> > > > > On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chromium.=
org> wrote:
> > > > > >
> > > > > > Hi Masahiro,
> > > > > >
> > > > > > On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > > > > Add a script which produces a Flat Image Tree (FIT), a sing=
le file
> > > > > > > > containing the built kernel and associated devicetree files=
.
> > > > > > > > Compression defaults to gzip which gives a good balance of =
size and
> > > > > > > > performance.
> > > > > > > >
> > > > > > > > The files compress from about 86MB to 24MB using this appro=
ach.
> > > > > > > >
> > > > > > > > The FIT can be used by bootloaders which support it, such a=
s U-Boot
> > > > > > > > and Linuxboot. It permits automatic selection of the correc=
t
> > > > > > > > devicetree, matching the compatible string of the running b=
oard with
> > > > > > > > the closest compatible string in the FIT. There is no need =
for
> > > > > > > > filenames or other workarounds.
> > > > > > > >
> > > > > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > >
> > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > >
> > > > > > > > This features requires pylibfdt (use 'pip install libfdt').=
 It also
> > > > > > > > requires compression utilities for the algorithm being used=
. Supported
> > > > > > > > compression options are the same as the Image.xxx files. Fo=
r now there
> > > > > > > > is no way to change the compression other than by editing t=
he rule for
> > > > > > > > $(obj)/image.fit
> > > > > > > >
> > > > > > > > While FIT supports a ramdisk / initrd, no attempt is made t=
o support
> > > > > > > > this here, since it must be built separately from the Linux=
 build.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v9:
> > > > > > > > - Move the compression control into Makefile.lib
> > > > > > > >
> > > > > > > > Changes in v8:
> > > > > > > > - Drop compatible string in FDT node
> > > > > > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > > > > > - Turn compress part of the make_fit.py comment in to a sen=
tence
> > > > > > > > - Add two blank lines before parse_args() and setup_fit()
> > > > > > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > > > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > > > > > - Add 'mkimage' details Documentation/process/changes.rst
> > > > > > > > - Allow changing the compression used
> > > > > > > > - Tweak cover letter since there is only one clean-up patch
> > > > > > > >
> > > > > > > > Changes in v7:
> > > > > > > > - Add Image as a dependency of image.fit
> > > > > > > > - Drop kbuild tag
> > > > > > > > - Add dependency on dtbs
> > > > > > > > - Drop unnecessary path separator for dtbs
> > > > > > > > - Rebase to -next
> > > > > > > >
> > > > > > > > Changes in v5:
> > > > > > > > - Drop patch previously applied
> > > > > > > > - Correct compression rule which was broken in v4
> > > > > > > >
> > > > > > > > Changes in v4:
> > > > > > > > - Use single quotes for UIMAGE_NAME
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - Drop temporary file image.itk
> > > > > > > > - Drop patch 'Use double quotes for image name'
> > > > > > > > - Drop double quotes in use of UIMAGE_NAME
> > > > > > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > > > > > > - Avoid hard-coding "arm64" for the DT architecture
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Drop patch previously applied
> > > > > > > > - Add .gitignore file
> > > > > > > > - Move fit rule to Makefile.lib using an intermediate file
> > > > > > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > > > > > - Pick up .dtb files separately from the kernel
> > > > > > > > - Correct pylint too-many-args warning for write_kernel()
> > > > > > > > - Include the kernel image in the file count
> > > > > > > > - Add a pointer to the FIT spec and mention of its wide ind=
ustry usage
> > > > > > > > - Mention the kernel version in the FIT description
> > > > > > > >
> > > > > > > >  Documentation/process/changes.rst |   9 +
> > > > > > > >  MAINTAINERS                       |   7 +
> > > > > > > >  arch/arm64/Makefile               |   7 +-
> > > > > > > >  arch/arm64/boot/.gitignore        |   1 +
> > > > > > > >  arch/arm64/boot/Makefile          |   6 +-
> > > > > > > >  scripts/Makefile.lib              |  16 ++
> > > > > > > >  scripts/make_fit.py               | 291 ++++++++++++++++++=
++++++++++++
> > > > > > > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > > > > > > >  create mode 100755 scripts/make_fit.py
> > > > > > >
> > > > > > > I'll need Masahiro's Ack on the scripts/ changes before I can=
 take this
> > > > > > > one.
> > > > > >
> > > > > > Any thoughts on this request, please?
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > > As I mentioned before, I am concerned with having
> > > > > the same "compatible" entries, with different contents,
> > > > > as you use the "compatible" string as an ID to selecting
> > > > > the target config node, right?
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > $ fdtdump  arch/arm64/boot/image.fit
> > > > >
> > > > >         ...
> > > > >
> > > > >         conf-10 {
> > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL=
 carrier board";
> > > > >             fdt =3D "fdt-10";
> > > > >             kernel =3D "kernel";
> > > > >         };
> > > > >
> > > > >         ...
> > > > >
> > > > >         conf-25 {
> > > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > > "tq,am642-tqma6442l", "ti,am642";
> > > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL=
 carrier board";
> > > > >             fdt =3D "fdt-25";
> > > > >             kernel =3D "kernel";
> > > > >         };
> > > >
> > > > I had asked Rob a while ago about if having the same compatible for=
 two
> > > > functionally different machines is a feature, or a bug, and I don't
> > > > think either of us fully agreed either way. I'd be leaning towards
> > > > saying the above example is a bug in the dts files, it's just not b=
een a
> > > > bug people have worried about before due to (sadly) how little the
> > > > top-level compatible has been used.

I much prefer being able to use compatibles over filenames.

> > >
> > > Yes I believe this is a bug in the files.
> > >
> > > What should the script do in this case? Print a warning, perhaps?
> >
> > Is there anything I should do here? Would a warning be helpful, or
> > just confusing?
>
>
>
> I do not think it is useful.
> You would almost always get a warning, and there is no way to fix it.

The above case is due to overlays. Why would you have a FIT image with
both a base tree and applied overlays?

In any case, maybe we need to record in dtb overlays that have been
applied (which you asked about recently on dtc list). Not sure what
that looks like though. Overlays have a 'top-level' compatible that we
add in either separately or merged with the base's top-level
compatible?

Rob
