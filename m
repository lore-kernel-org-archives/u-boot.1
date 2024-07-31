Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE39EC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E022F88A1C;
	Wed, 31 Jul 2024 16:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VvczvCmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4285A88955; Wed, 31 Jul 2024 16:39:02 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D5988A21
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d5d0535396so2906747eaf.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436739; x=1723041539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YeLtVzx9O+ygBWzPy9/o7d5N3uLDSeximlzx9H8G1dI=;
 b=VvczvCmwsHhPLcEKXjrlbrfgQ6QwC15W+wi1oYlESQSAH0Z10FiaIjilYA8mN3bQ9q
 Hgk/7bbx1U0vpMPaZeT4AExfvBMGKd6vxpM1CLOOwlpuNtJIORCz1vMrlaGm/mBjYy0a
 SAt0C2hHldKKqjLgNA8WAt9coLB1B89k1bmJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436739; x=1723041539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YeLtVzx9O+ygBWzPy9/o7d5N3uLDSeximlzx9H8G1dI=;
 b=bdVWALwswIEdaeYcp5GULfHA+/T5UZKzSt7ZwEcS1Q3bakFntUWjFHvKt48kof2DVW
 RLqADKFuO+uf8ucvHGjxMmzz9NRZkU3G5EeDsE+0SC89Td8Ey4/fp++qQvQt7XfL8Guf
 G3XhThJti/hsqJMtUivdOz5n0R6Fh1CLs3rxDXD30kgWDvvLcDDXoHWNTEEVG8/AFNlj
 mkoNari4vd4gCrCsKE4RQCcEcXnmkyrBEmeF1M6YH07jZC5rYhOeeuQCAmxrp25MUeM1
 JrawgF4c4XBNqS5DRZMFfDgeldFIem4kk4G53iJ7hb6xjuUeZXSGUi6Wjr9q71zndcWD
 pQbQ==
X-Gm-Message-State: AOJu0YyIpwOH1818e0sVWtbvcSlEt+L+cUXNIy/VCYw2Ri+rg8D3mJjj
 05HBqS97NFbOKiEBDeJzV9K978ASj5ZVm5Co1IBED9l80LEVq7gntbh+vleaSMwg9zqWY3UmrmH
 twBO6C6GOSVYNAcHT3LEEswvQ3+TvJD/5cPhV
X-Google-Smtp-Source: AGHT+IHTmm704N3BqnenaLBNnV51Cju4ruPNuCdcDhG1vVfPrXGXax1gVWUPXFJE2YgSPvwkw4KIlnnH7m/yUl/Tlkk=
X-Received: by 2002:a05:6358:715:b0:1ac:65e7:919b with SMTP id
 e5c5f4694b2df-1adb24225d4mr1870087755d.6.1722436738730; Wed, 31 Jul 2024
 07:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-34-sughosh.ganu@linaro.org>
 <CAFLszTg1nywmyXRJ2Dgsg97Mfbps7P37jDD72dNafo0wHF3RZQ@mail.gmail.com>
 <CADg8p97S84J7wrEchCfP-Y7L8qdC4F=koyuhzV0+jYxiM=YhRg@mail.gmail.com>
 <CAFLszThRiRLXE2Nz7CM4_tDCM6=6d1v4snsDfYBCnvPnoXVPYg@mail.gmail.com>
 <CADg8p96UnUpeV51Dsr82rKs6vz-9TPBmoz6HTq+i4G0me6MR8w@mail.gmail.com>
In-Reply-To: <CADg8p96UnUpeV51Dsr82rKs6vz-9TPBmoz6HTq+i4G0me6MR8w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:48 -0600
Message-ID: <CAFLszThbvjMqQVCJ7gO0zd-21Xj2Y_uJE8ribzNRKhhrgYHeYQ@mail.gmail.com>
Subject: Re: [PATCH 33/40] test: cedit: use allocated address for reading file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Wed, 31 Jul 2024 at 01:26, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 29 Jul 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Mon, 29 Jul 2024 at 02:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Instead of a randomly selected address, use an LMB allocated one for
> > > > > reading the file into memory. With the LMB map now being persistent
> > > > > and global, the address used for reading the file might be already
> > > > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > > > address from LMB and then read the file to that address.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since rfc: None
> > > > >
> > > > >  test/boot/cedit.c | 6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > >
> > > >
> > > > No, we should not start putting lmb into tests like this.
> > >
> > > The test fails if the address is not allocated through an lmb api.
> > > Although I can check why.
> >
> > Neither am I, but you did put the tcg in the same region so perhaps
> > that is an issue?
>
> I now remember the issue. The cedit_fdt() function uses a random
> address(0x1000) and tries to load the settings.dtb file to the
> address. The load command uses the lmb_alloc_addr() API function to
> reserve and use this address for loading the file. This worked earlier
> because of the local nature of the lmb memory map. But it does not
> work anymore, as this clashes with some existing reservation resulting
> in the test failure.  So this change is very much needed.

OK I see. Do you know what is clashing? I wonder if we should have
strings associated with lmb records, to make this easier, if there are
going to be so many?


>
> -sughosh
>
> >
> > Sandbox is designed so that low memory regions can be used in tests. I
> > pointed you to the memory-map docs.

Regards,
Simon
