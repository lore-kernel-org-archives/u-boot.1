Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AABD2C541
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4CBF88F4B;
	Tue, 22 Oct 2024 14:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fMkBD8Ya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B91C88E89; Tue, 22 Oct 2024 14:16:01 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF35F88969
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a99f629a7aaso1004695466b.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729599358; x=1730204158; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c2XAtq9AzT/LCywNY5QGTkudOjXzpm7bWK5woKhYzMo=;
 b=fMkBD8Yap476VU8/2DkPxeMnF9KBqDhUENakvXrB934QtwzyG4i/epZ5TnOOv5z0zb
 EKdUJtHdVnCmFhfCIo9flnFp/g26VQyDddaTeJXjsq1DG2KILkMCPZpH0CXuWR01/kMn
 916rcYr4R2Xcfdw5crOAeEBRJlbi62sxPJzUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729599358; x=1730204158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2XAtq9AzT/LCywNY5QGTkudOjXzpm7bWK5woKhYzMo=;
 b=Sztqunqk2l/JByt3cHqSJaQFQfIO4iPN8Z0lU5Luji02FrKUwrcOSxPjRQnbtPVZ0d
 OicBTZE0QYhDB9vWGlt1KX7oreeIgD/gJcciCcprEExQhnGB+4QxKcQw0l5Iym29TsbC
 URQHo6j2GDRbR6Fd1JtWshDJkCsa8zFvqoZSI41TlbSpXP0sZhRS3MXl9cTctIRZvVKW
 RjeXn4gqKrJJYL2MoM0Djd0RuJZEHAb2f7jdFbI5AsQ6bhEMs+qhzEyfGjoNeSItcMQc
 GD8s7kQWLqOXT7mY9n+7swS7enehNwHXCn5fs7YODRTCmPThxyVcL6tjRgnOLJuCXuYj
 tn+w==
X-Gm-Message-State: AOJu0Yx3Zmw3DOtYdJ5TM3BtF6njTN0mL6Yhxts/FlYmEwUtLOAt0e7T
 IHVBigL4+pTcCyh2L8MD36tN2yQJlyZQa27UiHbPpadi3JHGNHaftbPDj/xXKvoxgcuTpEiK0C5
 L5LplpFOdX6CtoizIjztJoY5V+nQgrNiBD4Ds
X-Google-Smtp-Source: AGHT+IHzoILtJgkf41qeGswbh2q+YCFbfIY1ZIqAeGdNstWSqQeIdP3HAN+pEeFIdacoyEzPMJvEQ5CAhe2nl0BAzSA=
X-Received: by 2002:a17:907:86a1:b0:a99:57c3:1fbb with SMTP id
 a640c23a62f3a-a9aaa5190b8mr318688766b.9.1729599357674; Tue, 22 Oct 2024
 05:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
 <20241019175121.GA4959@bill-the-cat>
 <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
 <20241021173253.GO4959@bill-the-cat>
In-Reply-To: <20241021173253.GO4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 14:15:46 +0200
Message-ID: <CAFLszThgsF5BL8aSGozA3nAeox=g8bVARmSaBFedM=dbLT=UWA@mail.gmail.com>
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

On Mon, 21 Oct 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 21, 2024 at 08:31:10AM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
> > >
> > > > Create a new disk for use with tests, which contains the new 'testapp'
> > > > EFI app specifically intended for testing the EFI loader.
> > > >
> > > > Attach it to the USB device, since most testing is currently done with
> > > > mmc.
> > > >
> > > > Initially this image will be used to test the EFI bootmeth.
> > > >
> > > > Fix a stale comment in prep_mmc_bootdev() while we are here.
> > > >
> > > > For now this uses sudo and a compressed fallback file, like all the
> > > > other bootstd tests. Once this series is in, the patch which moves
> > > > this to use user-space tools will be cleaned up and re-submitted.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > ---
> > > > Here is the patch to avoid sudo and CI fallback:
> > > >
> > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > > > 20240802093322.15240-1-richard@nod.at/
> > > >
> > > > (no changes since v1)
> > > >
> > > >  arch/sandbox/dts/test.dts           |   2 +-
> > > >  test/boot/bootdev.c                 |  18 +++++++++-
> > > >  test/boot/bootflow.c                |   2 +-
> > > >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> > >
> > > This I think best illustrates the problem with "BOOTSBOX.EFI". This
> > > image will work for CI up until I can figure out how to get access to
> > > free arm64 servers to run some tests on and then it will fail.
> >
> > I don't believe so. Why do you think that?
>
> Because it includes the BOOTSBOX.EFI x86 binary file, and executes it?
> Or did I miss where we update the contents to include that file as we
> just built it (and so why have it included?) ?

It works fine on x86 and I'm sure it will work fine on ARM as well.
The file is built with the host compiler, just as U-Boot itself is.

>
> > BTW it would be good to get CI running on arm. I believe Linaro might
> > have some servers. I keep thinking of getting an Ampere device but so
> > far have resisted as it is UEFI with closed firmware...
>
> The problem is more, for GitLab, getting anyone to maintain and provide
> a runner and then for Azure, waiting for Microsoft to include some in
> the free tier. I think for the former, at one point I was thinking about
> using one of Oracle's always-free tier ones and for a small enough
> subset of things (like a host tools and a sandbox run) it might be fine.

OK. I suspect Ilias might be able to help.

Regards,
Simon
