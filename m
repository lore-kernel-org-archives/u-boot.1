Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC118E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 14:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4391083CF5;
	Thu, 19 Feb 2026 15:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RAYO4m/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61A383D3D; Thu, 19 Feb 2026 15:34:36 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468C883936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 15:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65b9608a9adso1662369a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 06:34:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771511674; cv=none;
 d=google.com; s=arc-20240605;
 b=Sg/fR9w+ePTOjDcMPuJFLhh8e8MzyRryOcizd7GanHZbnmBNugE8jnTUaFBygikr1X
 x1DQwcEMdkjXt2v44okFHid6Fcms4lGcsmYI3RmbdI0nN4T0i9fWTMH0zza0XCJ+XW3a
 X+pyIynxubsGYqhT++MxP5r3Swll4qhreIBvbGZyI1q/1c0i8lDHTcthGE61EuisO2va
 ys4l+lU4JB6kLak7Ui9hxuGnG0dCFC18i2xnDRuCxZ667QbsaPBXVJmF7Foyq/MCWmbU
 k2eiBAUplM0MGqmd4DcwL4bn46RA4Rln9InLyJOEHxypy6pIS4ODdaXSIjcS7Woa9jOK
 LR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=INuBk0Jz50+5u0qx8OwkRN3+sVtDSP1gP4pppwm0Nr8=;
 fh=DDAk11SuFiQn3Od90A26D+KrexqslrkhzZ3WCPg98n0=;
 b=Y96fUXAEHlMrPHESQ7QHaPNaeyzUqoetqWLXdzQBR63Zm7n9xfTh7EwadOqCArCXV9
 /QStezN4Gt1ewH6G+r05hspAgATNf9L1FhIptVKwuNwBOEGFefH2tCuZC6j4JeAGDmA0
 +Aiz02OfpWCesVDR9u7UjLCroQFOAmfbnOHwLwJv6DtXAlJWfPcPxFrGmGPFdGrhbMoH
 WkxFbGzDPuWZ3uypjSf2zOsT05fbcaDzUnJ2NDDS5l807iTCjyYAUyVyD505CcQV8KlV
 CmvfnMoJok7LoUCM53oHEBEQAIL7ibfoh2Iu7chWgs609xIHYbeorVVIUeYvzqyKWxgL
 /TpA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771511674; x=1772116474; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=INuBk0Jz50+5u0qx8OwkRN3+sVtDSP1gP4pppwm0Nr8=;
 b=RAYO4m/xO+X1qbvtUbWZ2GzRojWX2uvjxvg/xTmJLs8Tjcw7H2hsqyEnVeC4PxqND9
 8i4I2FOZxYShzn4chMtc8BmJEG4gC+JuZBT6XTLfIzV6SSxiqhaE2yJiOSMhdaPo0jN2
 +LQyscIx+lowqz4z/DcpZ2AQKpKdxzq0NxSQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511674; x=1772116474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INuBk0Jz50+5u0qx8OwkRN3+sVtDSP1gP4pppwm0Nr8=;
 b=YRxc+wpxjRWbP86ZZj8xVFKK5WEZVSodehrXuMatCzvZWwPD2v/Xo6EaGinzGntypl
 t3HdifEa8ueMCoCAB1/wqlm1fLJdD8ByvunTQl7cCksqGDfe8Nai/YqDe/m6XlyMXF/V
 bTv4pYACCWJ9fIRgGozn2oJ1aS6yMJgk2pcGuH/hPc/W5AN3P30xSzx1bY8+GP3rIBjE
 Q7TUlT+4lbCNv4jNYEXttdWvWeqC6Qa3/4i1PqNxH2TsQcPMGix4BKiGrNVaOVMohgGj
 mF4E2gqnJd+KTIEUxykmherZ68pJLTgfqE+0686hxIFOB05bbijkRH+LCfelFdPF1X7V
 kWGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB444fJsYeUt5ctIWiC/82ojBP4Q7/X8jJlNlSOPV7hii5dd0+yVhA5a6K6GlFdg30mJ9H1S4=@lists.denx.de
X-Gm-Message-State: AOJu0YyXiTHuE2/0oe34c2YvjDd/JLSH4SQ7J6EWZsfql7FqHhhzdG8A
 9SfUfNLadJHl8etIdfAV1XMWg2jTf0HXEkomdoxv+TF6KvfMIokdrCgid8+2kXaOQLOR2noyEAj
 iKRSFL6rqwpXQInl+zPnSW0e8y9PmIoNJELE9xyvn
X-Gm-Gg: AZuq6aLvSDXh+dMKzBF7I5sZTl+tzokrYNgOQKNWHKU5pqv8J2mNW0XXMK32PAuTB4f
 2CymKNVmZKZCUp9UmfgtTAQZfNtjDfm/eC94PD5rahCLH7RBdc1heOzIg6pkm0QEB99RIm9vN9P
 n56BZap0rNE4DzV7xNGsdhyjnUC2C3ZAUhKDoWfP+AQ91c7/yhSj7O1buBsylhMwSTDA2zfsSSF
 8XhrGS5PVFMZVCno7PZwz190xBPL/eYOS6O0URM7J4RuZqV2MEZdpfjE6fKhpuPjcSHsjZwfC5C
 xmv6PQ==
X-Received: by 2002:a17:907:3e8f:b0:b88:5b21:b16b with SMTP id
 a640c23a62f3a-b8fc3b59ed1mr1159792766b.25.1771511673664; Thu, 19 Feb 2026
 06:34:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <05cc2003b7e0951a80b0078b3824d14466979b3d.1771275704.git.daniel@makrotopia.org>
 <CAFLszTh3FiMF+eCSxHq7b6hszKphWxyZZpeKrfPAAqEseLhNdg@mail.gmail.com>
 <20260219140421.GJ3233182@bill-the-cat>
In-Reply-To: <20260219140421.GJ3233182@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 07:34:21 -0700
X-Gm-Features: AaiRm53Z6cX9GefzO6Qb_XOdG9mUtbNnXp8r2Kvgq_-eKs88j-vxc3GBHuoBYJM
Message-ID: <CAFLszTjkdArCnEWPc5MkA1rVH1xnTvyQ+eeeWRkXiPPuSkbvwg@mail.gmail.com>
Subject: Re: [RFC PATCH 11/20] test: boot: add image_loader unit tests
To: Tom Rini <trini@konsulko.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Tom,

On Thu, 19 Feb 2026 at 07:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 19, 2026 at 06:10:58AM -0700, Simon Glass wrote:
> > Hi Daniel,
> >
> > On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
> > >
> > > Add unit tests for the image_loader framework covering its core
> > > logic with a mock storage backend:
> > >
> > > - map() allocates, reads and records a region
> > > - map() returns cached pointer for already-mapped range
> > > - map() returns correct offset within a larger region
> > > - map() re-reads when extending a region to a larger size
> > > - map_to() reads to a specified address and records it
> > > - lookup() returns NULL for unmapped ranges
> > > - alloc_ptr advances with correct alignment
> > > - map() returns NULL when the translation table is full
> > > - cleanup() calls backend and resets state
> > > - map() with multiple disjoint regions
> > > - read beyond image size returns error
> > >
> > > Also fix IMAGE_LOADER_MAX_REGIONS Kconfig to depend on IMAGE_LOADER
> > > and default to 16 unconditionally (the previous 'default 0' fallback
> > > caused the regions array to be zero-sized when IMAGE_LOADER was
> > > enabled after initial defconfig generation).
> > >
> > > Register the new 'image_loader' test suite in test/cmd_ut.c so it
> > > can be run via 'ut image_loader'.
> > >
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  boot/Kconfig             |   4 +-
> > >  test/boot/Makefile       |   2 +
> > >  test/boot/image_loader.c | 429 +++++++++++++++++++++++++++++++++++++++
> > >  test/cmd_ut.c            |   2 +
> > >  4 files changed, 435 insertions(+), 2 deletions(-)
> > >  create mode 100644 test/boot/image_loader.c
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 1f870c7d251..efc06f3cd1a 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -1179,8 +1179,8 @@ config IMAGE_LOADER
> > >
> > >  config IMAGE_LOADER_MAX_REGIONS
> > >         int "Maximum number of mapped regions in image loader"
> > > -       default 16 if IMAGE_LOADER
> > > -       default 0
> > > +       depends on IMAGE_LOADER
> > > +       default 16
> > >         help
> > >           Maximum number of distinct image regions that can be mapped
> > >           into RAM simultaneously. 16 is sufficient for typical FIT
> >
> > As Tom mentioned, this is in the wrong patch. But really we should
> > just remove it and use an alist
>
> Lets not have another argument about your alist stuff please.

Then perhaps another type of list that can grow as needed.

Regards,
Simon
