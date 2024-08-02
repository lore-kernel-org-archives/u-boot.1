Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4E9C52D70
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 07:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFD2886B5;
	Fri,  2 Aug 2024 09:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zkTRgpab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 559E288641; Fri,  2 Aug 2024 09:44:48 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89932886B5
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 09:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ab2baf13d9so10892355a12.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722584685; x=1723189485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=csfNNJxR4avMISXi2f1Po+GZIXDzq02ctzItTFALplw=;
 b=zkTRgpabb9UZrXzORmvzVdbQfIguGBz25buuKDxkSksqrRIWQdIJM9fzaQ8QNOXRaA
 ebm0caoSG9Tu21Br1ebkBuwmfXfuW7d+rUgM3gLyO47qTkJ2cmCoromsj+ah7oQ7ivrw
 UYsxPzFt9DqCEWjkslZHCaIjGfjFtHcXgsx2RXr6WlhFRZ3pbArPPnzmAhIsFc64URpa
 Tc0gXK9WVGTpd+W+YUtbsxRBWW+B14nSxOu+yEtT+0Odvgc/UOUiAWqvSC8lXwb1W5yj
 44DJMSdQ+GnDN9OTNZLKUvlKJUVcNJEfOACkZKdUUxCFM9NEy1Z8dT5kH3Z31l5wSjxA
 K4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722584685; x=1723189485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=csfNNJxR4avMISXi2f1Po+GZIXDzq02ctzItTFALplw=;
 b=EzPFF9SiYCGUMP2ORaHrVchZVltLmMqakccz71lkZzN9ac10vK/LdMtMs1ZGqIWnv6
 Yjy8T7Vg6yYapMsemPmVTTWkcm7OyDVYNYITgVvOkCOmC2XMFZ/oHHZblAm5rFzUrxcd
 KgqK9hFSInPonDQ5p6OtHy0NGbs+bZy/XGkNhHAWyMYdFM+QXtUti9+QYj7Ttdp2qab3
 /cj0O1hl+hi89QrqpTgpFe+kIs78aerzC8IHTcq69ogBlrUmBTJyEml5GjcZIREtiP1O
 AUuE4jI2jiMI+9Xb+6wS4jgDWHUPafgeY0grYShZhlKFajPmOkgjfHneoUM3sbAphysM
 gShA==
X-Gm-Message-State: AOJu0Ywq8maHpODmRWKXiRZr4LNYwjNEWhqi87hU7cxeAiNG+wUfIuEY
 2MLlF8MeFGOaIy4PRtTLWXCuLY5mVknT4XohmNzYpOFPidV8klbvEiqCOX+qiiKWc8esfdNlgER
 Sx0o7HVviWWQVcT0U1sbibax7IOuNGWTtp2ABDA==
X-Google-Smtp-Source: AGHT+IECfH26lW2xGGQngRPU434uvDQdrYWp3ACJGBtWSMC+kTpDKTI6MO5NZkVUTnNrIsbdmzFe8G/QM7ZuSEEKUS0=
X-Received: by 2002:a05:6402:2032:b0:5a3:a4d7:caf5 with SMTP id
 4fb4d7f45d1cf-5b7f5dc13cemr1621494a12.36.1722584684776; Fri, 02 Aug 2024
 00:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-31-sughosh.ganu@linaro.org>
 <CAFLszTg-hL9z3o68RigDFCE2=Cj-UVHv0xh0Y9=QuS=ZDq3FGw@mail.gmail.com>
 <CADg8p95m8w8hgsderBgDhMfNTv73RrTVGtNsu6Yh4wt6b1nNmg@mail.gmail.com>
 <CAFLszTh4CvysoS1njOtEP8NHd3avHQhbYr_Z0n1wMvDmnJT0fQ@mail.gmail.com>
In-Reply-To: <CAFLszTh4CvysoS1njOtEP8NHd3avHQhbYr_Z0n1wMvDmnJT0fQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 2 Aug 2024 13:14:33 +0530
Message-ID: <CADg8p961G-FLGjot1Ur-3CoBvrHhnDLv5hv_c-k4NeBAZ598xA@mail.gmail.com>
Subject: Re: [PATCH 30/40] sandbox: iommu: remove lmb allocation in the driver
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

On Mon, 29 Jul 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 29 Jul 2024 at 02:52, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > The sandbox iommu driver uses the LMB module to allocate a particular
> > > > range of memory for the device virtual address(DVA). This used to work
> > > > earlier since the LMB memory map was caller specific and not
> > > > global. But with the change to make the LMB allocations global and
> > > > persistent, adding this memory range has other side effects. On the
> > > > other hand, the sandbox iommu test expects to see this particular
> > > > value of the DVA. Use the DVA address directly, instead of mapping it
> > > > in the LMB memory map, and then have it allocated.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since rfc: None
> > > >
> > > >  drivers/iommu/sandbox_iommu.c | 9 ++-------
> > > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
> > > > index 505f2c3250..15ecaacbb3 100644
> > > > --- a/drivers/iommu/sandbox_iommu.c
> > > > +++ b/drivers/iommu/sandbox_iommu.c
> > > > @@ -5,10 +5,10 @@
> > > >
> > > >  #include <dm.h>
> > > >  #include <iommu.h>
> > > > -#include <lmb.h>
> > > >  #include <asm/io.h>
> > > >  #include <linux/sizes.h>
> > > >
> > > > +#define DVA_ADDR               0x89abc000
> > >
> > > This is a very strange address. You can put this in
> > > arch/sandbox/include/asm/test.h and check it in the test. I suggest
> > > using something like 0x12345678 so it is obviously meaningless.
> >
> > You will see that I am using the same address that is being used
> > currently. I did not want to make any changes to what is working, nor
> > did I want to spend time debugging if this logic can be improved --
> > that is not the purpose of this series.
>
> Please just move it. You can keep the same address, but put the
> constant in the header file.

Looking into this, there isn't an appropriate header file where I can
put this constant. And creating one only for a macro seems like an
overkill. Can you propose a header file where I can put this. If there
isn't an existing one, maybe I can keep the macro as is?

-sughosh

>
> >
> > >
> > > >  #define IOMMU_PAGE_SIZE                SZ_4K
> > > >
> > > >  static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> > > > @@ -20,8 +20,7 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> > > >         paddr = ALIGN_DOWN(virt_to_phys(addr), IOMMU_PAGE_SIZE);
> > > >         off = virt_to_phys(addr) - paddr;
> > > >         psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
> > > > -
> > > > -       dva = lmb_alloc(psize, IOMMU_PAGE_SIZE, LMB_NONE);
> > > > +       dva = (phys_addr_t)DVA_ADDR;
> > > >
> > > >         return dva + off;
> > > >  }
> > > > @@ -35,8 +34,6 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
> > > >         dva = ALIGN_DOWN(addr, IOMMU_PAGE_SIZE);
> > > >         psize = size + (addr - dva);
> > > >         psize = ALIGN(psize, IOMMU_PAGE_SIZE);
> > > > -
> > > > -       lmb_free(dva, psize, LMB_NONE);
> > > >  }
> > > >
> > > >  static struct iommu_ops sandbox_iommu_ops = {
> > > > @@ -46,8 +43,6 @@ static struct iommu_ops sandbox_iommu_ops = {
> > > >
> > > >  static int sandbox_iommu_probe(struct udevice *dev)
> > > >  {
> > > > -       lmb_add(0x89abc000, SZ_16K, LMB_NONE);
> > > > -
> > > >         return 0;
> > > >  }
> > >
> > > If this function is empty, you should remove it.
> >
> > Okay.
>
> Regards,
> Simon
