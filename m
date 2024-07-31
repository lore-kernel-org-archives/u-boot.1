Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444F9C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 15:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFBC884A9;
	Wed, 31 Jul 2024 17:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HpT3fTc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6532882F0; Wed, 31 Jul 2024 17:11:09 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8929884A9
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 17:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52efd530a4eso9227375e87.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722438667; x=1723043467; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DdLSVmldl5JKW1FAOn1BmNdVh4SuisNeq3PmRW8mprY=;
 b=HpT3fTc1Pa7E7cN6gjLT8xohmUKAiTmQ3dZUviNuJRC4yBjplOOWyO6h4aXh0zBn3c
 o4a8b6hY09bq48RkA9118K4P/7TBpWthNkkCu80WhZi1BdMh4/iMJXpmwiXcx0SCYBJP
 RMjOSrpZbBzyMSB2+Vdg6Tb2WMD0gI9brXFlBSQ/oZiK+UrcKSe0/qTduGSq2Nx9Lx/Y
 a9kJB8jGTKn7y7pjBVRTpev2X1xjs+wszGbT863oDiaNYNWxumP+8AbXKXs9DIjaPmIH
 tpYDxuRpaNWLkdpjrakjIx/KscyXcmK1vAeTL1Pue2ngQV2HPA3dj5Gyne7m45+As+pw
 qEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722438667; x=1723043467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DdLSVmldl5JKW1FAOn1BmNdVh4SuisNeq3PmRW8mprY=;
 b=H6SHLSs3VI5LmGEYGXFPWcLMc7bS8PwgkIAWB9j7kqFOvxRYdi8+9f05ynqXAoFYxX
 M4zXpZBk4noyOZRkrKf0EFkcaAswdy8pG6YtJl2oWVRFle80raup8uG4fC2g9wj70rWM
 Ul8DhznSQ2pp3+ucg1OgDR5ParZC7MGPWOaLAQtQtWEpCoRSw2cRlnCLGRP2JhmUixCV
 CZqxWzpSELEhTlZRdvYCkdZ8PHH+KxBtbyuPOSnO5NfA1ZKqAUMcIoz6ic6rjuTiXlXh
 muEahDucKEx7kGB2KwxI8tjppgYvzDfI1p4znLDggypCM9r1BS80ilPz+zWBFn3GRanQ
 boBQ==
X-Gm-Message-State: AOJu0YyFks4f4B2ELYPu9vgAlKL6nefIKYJ7F+ipPtPdD8RguS2b5yPN
 BeeUa22sls3np8oKYdbWNPw57x8GOTjQEMzC14clnxAI2+zS5NArbv8hYBFPvlmkL9KLQqyGc6p
 EtilEiMKP9Zqpb6TzsFmpwMIPd5rrI1EFpg6MJA==
X-Google-Smtp-Source: AGHT+IGKOesFkd+DHSqc/uGPxDhFaSL3tUwJ0S9Aj3jG+5W2tSnMSpXkGd+/GiS6+5hzp6r1RCafpdPq7VxW0bMo9dw=
X-Received: by 2002:a05:6512:3990:b0:52c:881b:73c0 with SMTP id
 2adb3069b0e04-5309b27a19dmr10537191e87.17.1722438666690; Wed, 31 Jul 2024
 08:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-34-sughosh.ganu@linaro.org>
 <CAFLszTg1nywmyXRJ2Dgsg97Mfbps7P37jDD72dNafo0wHF3RZQ@mail.gmail.com>
 <CADg8p97S84J7wrEchCfP-Y7L8qdC4F=koyuhzV0+jYxiM=YhRg@mail.gmail.com>
 <CAFLszThRiRLXE2Nz7CM4_tDCM6=6d1v4snsDfYBCnvPnoXVPYg@mail.gmail.com>
 <CADg8p96UnUpeV51Dsr82rKs6vz-9TPBmoz6HTq+i4G0me6MR8w@mail.gmail.com>
 <CAFLszThbvjMqQVCJ7gO0zd-21Xj2Y_uJE8ribzNRKhhrgYHeYQ@mail.gmail.com>
In-Reply-To: <CAFLszThbvjMqQVCJ7gO0zd-21Xj2Y_uJE8ribzNRKhhrgYHeYQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 31 Jul 2024 20:40:55 +0530
Message-ID: <CADg8p978jK_hvmYEULh1_QJjCs7QuuDoOXuBfdcX1gC6AT=S6A@mail.gmail.com>
Subject: Re: [PATCH 33/40] test: cedit: use allocated address for reading file
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 31 Jul 2024 at 20:08, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 31 Jul 2024 at 01:26, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Mon, 29 Jul 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Mon, 29 Jul 2024 at 02:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > Instead of a randomly selected address, use an LMB allocated one for
> > > > > > reading the file into memory. With the LMB map now being persistent
> > > > > > and global, the address used for reading the file might be already
> > > > > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > > > > address from LMB and then read the file to that address.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since rfc: None
> > > > > >
> > > > > >  test/boot/cedit.c | 6 +++++-
> > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > >
> > > > >
> > > > > No, we should not start putting lmb into tests like this.
> > > >
> > > > The test fails if the address is not allocated through an lmb api.
> > > > Although I can check why.
> > >
> > > Neither am I, but you did put the tcg in the same region so perhaps
> > > that is an issue?
> >
> > I now remember the issue. The cedit_fdt() function uses a random
> > address(0x1000) and tries to load the settings.dtb file to the
> > address. The load command uses the lmb_alloc_addr() API function to
> > reserve and use this address for loading the file. This worked earlier
> > because of the local nature of the lmb memory map. But it does not
> > work anymore, as this clashes with some existing reservation resulting
> > in the test failure.  So this change is very much needed.
>
> OK I see. Do you know what is clashing? I wonder if we should have
> strings associated with lmb records, to make this easier, if there are
> going to be so many?

Regarding your point about making use of strings for lmb records, I
have something similar on my todo list. I plan to use the strings for
the lmb flags associated with a memory region. The current flag values
shown as part of the bdinfo command are not very helpful from the ease
of understanding pov.

-sughosh

>
>
> >
> > -sughosh
> >
> > >
> > > Sandbox is designed so that low memory regions can be used in tests. I
> > > pointed you to the memory-map docs.
>
> Regards,
> Simon
