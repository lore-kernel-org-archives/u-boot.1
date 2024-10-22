Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E25D2CE05
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C9A88F62;
	Tue, 22 Oct 2024 19:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i9V2sa6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA2D88FF1; Tue, 22 Oct 2024 19:00:59 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564C187F19
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a16b310f5so756911966b.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729616457; x=1730221257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6rdCaYmto43azjkX8MbjV/pWo5HOo7uhWbuW5SuKFDY=;
 b=i9V2sa6lf/MjwKesRbJnuscKmEQVimxFqB1F3+KmFGgh3gpRkvGtJsHu+eiTzE5DVG
 SqWeXeW4cw/7fVv5scdE/mFI8rKRlDWwKnMS841fGNgc0+rD9U61gzXkc6sS7WIS6zHZ
 LBemNSiZya965Oc1dzAINRqYlkERYGOtRQino=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729616457; x=1730221257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6rdCaYmto43azjkX8MbjV/pWo5HOo7uhWbuW5SuKFDY=;
 b=vzZDVlKGkVqrT+E5iBnUjJJedSSjH2nh4kjjJnX+4rmqvgWIKAzK1nConX/p304rMi
 Tvjv4DdOrmUHLdTMEMAWNyI/W+cwcSWZeIJ1fDH7161Q9MQ+Bn79EMWtLkagTj3KjNlX
 60NaOPsbG4Tx1E82djXA1h+L/kdQp7oy/xzi01aZ6ZnPjHSP/PGnDEhmgQdV1PbDfIK8
 YcYbf5ylTbvvSclRsOKu80KIWm3nlHb9IK7p3kulheDhehH4M9eUUxAeNlFV69C146zM
 e/mkO22fru5c26kD2FW+QQoqJsXORVGC4Lf29OpwQdTubq+6sagzit1SgYxlJjrtGeTL
 IKog==
X-Gm-Message-State: AOJu0Yz+2RJbg/lnk+PJ+y88sTzbUAqgXl84UW6vs8iQ4bKaYeBT2P3l
 kxUbvwRjmkV0A2AluX5HRmMcr4ECAmGJRjPyuptSyhHXw8EyusXMY51Olv4ynQ26P//QoHQ+8JW
 CeNcTJ4PQhfzEG7sM+BxWzTCpKvJDVFVN1b8D
X-Google-Smtp-Source: AGHT+IEDwlhLTCswRvk7ncRh8IHHwjQEPXKOQeVMRZDs6arCE42rnPbK/QVkWh6u+my5k4MDUrh1hbwfkYYWdHybIUc=
X-Received: by 2002:a17:907:1c87:b0:a99:f9e6:1d0 with SMTP id
 a640c23a62f3a-a9aace726aamr334580766b.27.1729616456612; Tue, 22 Oct 2024
 10:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
 <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
 <20241021173253.GO4959@bill-the-cat>
 <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
 <20241022140246.GB4959@bill-the-cat>
In-Reply-To: <20241022140246.GB4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:35 +0200
Message-ID: <CAFLszTg3pkZ3z7vH1j-Vafmw6OKhzvLQ4=X9vd+kDzmmUjOw_g@mail.gmail.com>
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

On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 22, 2024 at 02:15:46PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
> > > > >
> > > > > > Create a new disk for use with tests, which contains the new 'testapp'
> > > > > > EFI app specifically intended for testing the EFI loader.
> > > > > >
> > > > > > Attach it to the USB device, since most testing is currently done with
> > > > > > mmc.
> > > > > >
> > > > > > Initially this image will be used to test the EFI bootmeth.
> > > > > >
> > > > > > Fix a stale comment in prep_mmc_bootdev() while we are here.
> > > > > >
> > > > > > For now this uses sudo and a compressed fallback file, like all the
> > > > > > other bootstd tests. Once this series is in, the patch which moves
> > > > > > this to use user-space tools will be cleaned up and re-submitted.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > ---
> > > > > > Here is the patch to avoid sudo and CI fallback:
> > > > > >
> > > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > > > > 20240802093322.15240-1-richard@nod.at/
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > > > >  test/boot/bootdev.c                 |  18 +++++++++-
> > > > > >  test/boot/bootflow.c                |   2 +-
> > > > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> > > > >
> > > > > This I think best illustrates the problem with "BOOTSBOX.EFI". This
> > > > > image will work for CI up until I can figure out how to get access to
> > > > > free arm64 servers to run some tests on and then it will fail.
> > > >
> > > > I don't believe so. Why do you think that?
> > >
> > > Because it includes the BOOTSBOX.EFI x86 binary file, and executes it?
> > > Or did I miss where we update the contents to include that file as we
> > > just built it (and so why have it included?) ?
> >
> > It works fine on x86 and I'm sure it will work fine on ARM as well.
> > The file is built with the host compiler, just as U-Boot itself is.
>
> Erm, are you saying the BOOT/EFI/BOOTSBOX.EFI file that's in
> test/py/tests/bootstd/flash1.img.xz doesn't need to exist and the test
> replaces that, as it goes?

No, I'm saying that sandbox uses that file, no matter the host
architecture, and I don't need to create different versions of
flash1.im.xz for each host architecture.

I discussed this with Heinrich and he seems happy enough with the -N
flag for his use case. I know how to replicate his use case and am
going to try it soon.

Regards,
Simon
