Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE08D13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E58488F4F;
	Sun, 27 Oct 2024 18:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GsFAWAuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4AF88969; Sun, 27 Oct 2024 18:16:42 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0609A88E78
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so4444098a12.2
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049398; x=1730654198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ackm2UyUjdf4gVTp7yK4E/kHYe3WNdkU4Tj69HHZhCU=;
 b=GsFAWAuktXytQ/3ltltU+0hvFR4oLiHAWogFUI/yR9asv9Nt0a9XrdfmBi1Dk2gASg
 j1fRf50cb2kc/lyfcLK5howGe6tJgY2N18hJLfVsrqw8EDXBYRFgNAPsJAT3cJzZFtUa
 B/7J4Cb9tivYsCoshMHUMeGPdFLrapBLC6CJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049398; x=1730654198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ackm2UyUjdf4gVTp7yK4E/kHYe3WNdkU4Tj69HHZhCU=;
 b=b5mbqMikF4IVtkv9V7VJzIij3K0QPZi+Oeh61y0U5OPkjz1U3Gpn26GKsvKKWWZ7+e
 zS6jb9qqz/hQnrRSKEXPB8gfKQMD8SeuI//3pvkOCzRg/8E1lgSgbSaWx680NVrdKzh4
 Q4tbU+ON6ttskI89PqbjG00zXzH3jvIcV/hEcydwf6YrQ7c/mEkkcl6RNcxJEKIq3LZs
 JQwedlWzv9TrHQ2tnWPNVId28V6gEI0o+y5KM5vcEX9XCogho7mqqJ2ok+aR/aAc9ySR
 VkV3GDcn/lGS/AllKucgePyQglb/j4gUY+abVj29X6qNQRDWhJE+mb5qBaJpYSyoddBe
 FESg==
X-Gm-Message-State: AOJu0Yz49x/e6tgOPPCPVS6V/1bjqOwOI0jpTOHmGnKCL+aALDF64hPR
 lwziBqyyZo6PAcwt7RJK+/Ed18FJxnAEOBkM0KQr3dmA8waI57rZrNOqSbA7R9Mft5MAkgGwY2V
 51PlArPpxBg7XTzhHhl1bO+XfrYlfMLJKWZ3h
X-Google-Smtp-Source: AGHT+IFNBll9Hnp/qa3Va4ysXNUfeokfTHiDz/GwSkhji6pKci1p3n9I2ySbv+aMRym8OKfQp6nO/WB8jP1lJ19fq7I=
X-Received: by 2002:a17:906:6a04:b0:a9a:3ca0:d55a with SMTP id
 a640c23a62f3a-a9de61df149mr592817766b.57.1730049398377; Sun, 27 Oct 2024
 10:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
 <20241021173253.GO4959@bill-the-cat>
 <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
 <20241022140246.GB4959@bill-the-cat>
 <CAFLszTg3pkZ3z7vH1j-Vafmw6OKhzvLQ4=X9vd+kDzmmUjOw_g@mail.gmail.com>
 <20241022175427.GH4959@bill-the-cat>
 <CAFLszTg=DJWnMf7Lun7ga0+_J4Vw6rpf32LMkdRLSy-WY+2U7g@mail.gmail.com>
 <20241023184121.GL4959@bill-the-cat>
 <CAFLszTgQB3Axj_FQwUURG0+u+z3SM5ypo88CfBntq+xUrzfOGw@mail.gmail.com>
 <20241024173706.GU4959@bill-the-cat>
In-Reply-To: <20241024173706.GU4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:25 +0100
Message-ID: <CAFLszThr_LSfF1JGOe8gPnkwN9amxsQ-t8mnzDV92LMuxh4esA@mail.gmail.com>
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

On Thu, 24 Oct 2024 at 19:37, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 24, 2024 at 06:39:00PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, Oct 23, 2024, 20:41 Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 23, 2024 at 05:39:07AM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 22 Oct 2024 at 19:54, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Oct 22, 2024 at 07:00:35PM +0200, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 22, 2024 at 02:15:46PM +0200, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
> > > > > > > > > > >
> > > > > > > > > > > > Create a new disk for use with tests, which contains the new 'testapp'
> > > > > > > > > > > > EFI app specifically intended for testing the EFI loader.
> > > > > > > > > > > >
> > > > > > > > > > > > Attach it to the USB device, since most testing is currently done with
> > > > > > > > > > > > mmc.
> > > > > > > > > > > >
> > > > > > > > > > > > Initially this image will be used to test the EFI bootmeth.
> > > > > > > > > > > >
> > > > > > > > > > > > Fix a stale comment in prep_mmc_bootdev() while we are here.
> > > > > > > > > > > >
> > > > > > > > > > > > For now this uses sudo and a compressed fallback file, like all the
> > > > > > > > > > > > other bootstd tests. Once this series is in, the patch which moves
> > > > > > > > > > > > this to use user-space tools will be cleaned up and re-submitted.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > > Here is the patch to avoid sudo and CI fallback:
> > > > > > > > > > > >
> > > > > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > > > > > > > > > > 20240802093322.15240-1-richard@nod.at/
> > > > > > > > > > > >
> > > > > > > > > > > > (no changes since v1)
> > > > > > > > > > > >
> > > > > > > > > > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > > > > > > > > > >  test/boot/bootdev.c                 |  18 +++++++++-
> > > > > > > > > > > >  test/boot/bootflow.c                |   2 +-
> > > > > > > > > > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> > > > > > > > > > >
> > > > > > > > > > > This I think best illustrates the problem with "BOOTSBOX.EFI". This
> > > > > > > > > > > image will work for CI up until I can figure out how to get access to
> > > > > > > > > > > free arm64 servers to run some tests on and then it will fail.
> > > > > > > > > >
> > > > > > > > > > I don't believe so. Why do you think that?
> > > > > > > > >
> > > > > > > > > Because it includes the BOOTSBOX.EFI x86 binary file, and executes it?
> > > > > > > > > Or did I miss where we update the contents to include that file as we
> > > > > > > > > just built it (and so why have it included?) ?
> > > > > > > >
> > > > > > > > It works fine on x86 and I'm sure it will work fine on ARM as well.
> > > > > > > > The file is built with the host compiler, just as U-Boot itself is.
> > > > > > >
> > > > > > > Erm, are you saying the BOOT/EFI/BOOTSBOX.EFI file that's in
> > > > > > > test/py/tests/bootstd/flash1.img.xz doesn't need to exist and the test
> > > > > > > replaces that, as it goes?
> > > > > >
> > > > > > No, I'm saying that sandbox uses that file, no matter the host
> > > > > > architecture, and I don't need to create different versions of
> > > > > > flash1.im.xz for each host architecture.
> > > > > >
> > > > > > I discussed this with Heinrich and he seems happy enough with the -N
> > > > > > flag for his use case. I know how to replicate his use case and am
> > > > > > going to try it soon.
> > > > >
> > > > > Yes, I'm just confused as to how the same BOOTSBOX.EFI binary file can
> > > > > be executed as both x86-64 and aarch64. Because:
> > > > > $ xz -k -d test/py/tests/bootstd/flash1.img.xz
> > > > > $ sudo losetup -fP  test/py/tests/bootstd/flash1.img
> > > > > $ sudo mount -o ro /dev/loop18p1 /mnt
> > > > > $ file /mnt/EFI/BOOT/BOOTSBOX.EFI
> > > > > /mnt/EFI/BOOT/BOOTSBOX.EFI: PE32+ executable (EFI application) x86-64 (stripped to external PDB), for MS Windows, 5 sections
> > > > >
> > > > > Seems unlikely to work on an aarch64 host. Which is why I asked if the
> > > > > test actually replaced the contents of the file.
> > > >
> > > > Well, yes, for now the .xz is an x86_64 image, but I expect to be able
> > > > to get rid of that fallback once my EFI test lands, so it should work
> > > > fine on ARM.
> > >
> > > So lets just re-work things to get this right from the start then
> > > please.
> >
> > My understanding was that I offered to tidy up and send [1] after this
> > series lands?
>
> Oh, so replacing the file is blocked on not having sudo in use on these
> tests. That wasn't clear, sorry.

OK, good, thanks. It's just CI that has this problem, since sudo doesn't work.

Regards,
Simon
