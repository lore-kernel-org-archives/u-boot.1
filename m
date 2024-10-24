Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF9CE8E91
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 16:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C7688DA0;
	Thu, 24 Oct 2024 18:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P2dlSVJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE8EB88E63; Thu, 24 Oct 2024 18:39:17 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D496788C66
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 18:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a1b71d7ffso164423866b.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729787953; x=1730392753; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aM+uz/8XGrdDTiEwY+p7V0T4rS45nVzkRbXcbDG3G04=;
 b=P2dlSVJ+Ep5OTUNG1qXvgFvjx7tH7Hsg1EzlSUF8r/9VUzDn5jerjK30cjt+gR7Bau
 shcIYNBYzR3wqkoor3sdrI0rUWIvaXycSkg0v1ggnwjWyVFqVfiPi5cDmx66sUa9Cv61
 ZDr/jPa8l2aopqKC28pKvh98ZjEy2BO99bxTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729787953; x=1730392753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aM+uz/8XGrdDTiEwY+p7V0T4rS45nVzkRbXcbDG3G04=;
 b=S/PDAMYDzyzwJyTPFtzMWQPBxX2B+yKB5YM6yYU3598z0Qkte91PgFlzhOpKFfN5gm
 FBQSb0rFvs3LYuwgW0mTR2BSUjWEMNstig5HIdsOSSexzt/uoO2NnyiJItXbdDUsqslF
 QuzMZ93jmpexwh2EIINSSPDJp0+4hQs/eLMaZB6/l1c64lXCRrEJQ8zMhrrrOOGXCj5B
 mBz65sa3+GvwcOhiNNah4GVnzJQTFkPb3UVVPMSuLALdpNYyym8ICrZGiw89v0q0Auif
 3CoDOcbNi26s4gWeeSKrGasdArB1AXLIdyj1ZEVTSUpJnKUWOhT/ZBDwiOMnRyzhDP8A
 gekQ==
X-Gm-Message-State: AOJu0YwNB3/27RUwVUf1XhsROdnjZWXhNCFGEu2eSCQNXijfkWpZez37
 4S2PhZ5CVPloXae51CVKL+cHEATzIqRNxCu5+HWKbURoig3Y0L5NNJjA95JdWRX+dcxHPz6lDU0
 fYFlTRDZL9OFFJuO/2Vd0JT83GBQyVgiVbPks
X-Google-Smtp-Source: AGHT+IFZ1AqhcixIWt8NGItRo3ZInM2eMf4x/N6pRf1SRfAcE/9OzerY5j2pWxlmpPDcLTPxdF+mvH21vzJPhgwCcjs=
X-Received: by 2002:a17:907:7d8e:b0:a8a:6c5d:63b2 with SMTP id
 a640c23a62f3a-a9abf8759a8mr696774666b.18.1729787953202; Thu, 24 Oct 2024
 09:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
 <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
 <20241021173253.GO4959@bill-the-cat>
 <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
 <20241022140246.GB4959@bill-the-cat>
 <CAFLszTg3pkZ3z7vH1j-Vafmw6OKhzvLQ4=X9vd+kDzmmUjOw_g@mail.gmail.com>
 <20241022175427.GH4959@bill-the-cat>
 <CAFLszTg=DJWnMf7Lun7ga0+_J4Vw6rpf32LMkdRLSy-WY+2U7g@mail.gmail.com>
 <20241023184121.GL4959@bill-the-cat>
In-Reply-To: <20241023184121.GL4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 24 Oct 2024 18:39:00 +0200
Message-ID: <CAFLszTgQB3Axj_FQwUURG0+u+z3SM5ypo88CfBntq+xUrzfOGw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] test: efi: boot: Set up an image suitable for EFI
 testing
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Yang Xiwen <forbidden405@outlook.com>
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

On Wed, Oct 23, 2024, 20:41 Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 23, 2024 at 05:39:07AM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 22 Oct 2024 at 19:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Oct 22, 2024 at 07:00:35PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Oct 22, 2024 at 02:15:46PM +0200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > Create a new disk for use with tests, which contains the new 'testapp'
> > > > > > > > > > EFI app specifically intended for testing the EFI loader.
> > > > > > > > > >
> > > > > > > > > > Attach it to the USB device, since most testing is currently done with
> > > > > > > > > > mmc.
> > > > > > > > > >
> > > > > > > > > > Initially this image will be used to test the EFI bootmeth.
> > > > > > > > > >
> > > > > > > > > > Fix a stale comment in prep_mmc_bootdev() while we are here.
> > > > > > > > > >
> > > > > > > > > > For now this uses sudo and a compressed fallback file, like all the
> > > > > > > > > > other bootstd tests. Once this series is in, the patch which moves
> > > > > > > > > > this to use user-space tools will be cleaned up and re-submitted.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > Here is the patch to avoid sudo and CI fallback:
> > > > > > > > > >
> > > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > > > > > > > > 20240802093322.15240-1-richard@nod.at/
> > > > > > > > > >
> > > > > > > > > > (no changes since v1)
> > > > > > > > > >
> > > > > > > > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > > > > > > > >  test/boot/bootdev.c                 |  18 +++++++++-
> > > > > > > > > >  test/boot/bootflow.c                |   2 +-
> > > > > > > > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> > > > > > > > >
> > > > > > > > > This I think best illustrates the problem with "BOOTSBOX.EFI". This
> > > > > > > > > image will work for CI up until I can figure out how to get access to
> > > > > > > > > free arm64 servers to run some tests on and then it will fail.
> > > > > > > >
> > > > > > > > I don't believe so. Why do you think that?
> > > > > > >
> > > > > > > Because it includes the BOOTSBOX.EFI x86 binary file, and executes it?
> > > > > > > Or did I miss where we update the contents to include that file as we
> > > > > > > just built it (and so why have it included?) ?
> > > > > >
> > > > > > It works fine on x86 and I'm sure it will work fine on ARM as well.
> > > > > > The file is built with the host compiler, just as U-Boot itself is.
> > > > >
> > > > > Erm, are you saying the BOOT/EFI/BOOTSBOX.EFI file that's in
> > > > > test/py/tests/bootstd/flash1.img.xz doesn't need to exist and the test
> > > > > replaces that, as it goes?
> > > >
> > > > No, I'm saying that sandbox uses that file, no matter the host
> > > > architecture, and I don't need to create different versions of
> > > > flash1.im.xz for each host architecture.
> > > >
> > > > I discussed this with Heinrich and he seems happy enough with the -N
> > > > flag for his use case. I know how to replicate his use case and am
> > > > going to try it soon.
> > >
> > > Yes, I'm just confused as to how the same BOOTSBOX.EFI binary file can
> > > be executed as both x86-64 and aarch64. Because:
> > > $ xz -k -d test/py/tests/bootstd/flash1.img.xz
> > > $ sudo losetup -fP  test/py/tests/bootstd/flash1.img
> > > $ sudo mount -o ro /dev/loop18p1 /mnt
> > > $ file /mnt/EFI/BOOT/BOOTSBOX.EFI
> > > /mnt/EFI/BOOT/BOOTSBOX.EFI: PE32+ executable (EFI application) x86-64 (stripped to external PDB), for MS Windows, 5 sections
> > >
> > > Seems unlikely to work on an aarch64 host. Which is why I asked if the
> > > test actually replaced the contents of the file.
> >
> > Well, yes, for now the .xz is an x86_64 image, but I expect to be able
> > to get rid of that fallback once my EFI test lands, so it should work
> > fine on ARM.
>
> So lets just re-work things to get this right from the start then
> please.

My understanding was that I offered to tidy up and send [1] after this
series lands?

Regards,
Simon
