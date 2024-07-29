Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A5C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D9988747;
	Mon, 29 Jul 2024 10:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fMR16Gqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC2088747; Mon, 29 Jul 2024 10:52:15 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79668887B9
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so4981219a12.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722243133; x=1722847933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hJ6CS7lqqjqjO1KZ9iJfHDi23887n6tKHywRZD+GIL8=;
 b=fMR16Gqkngnqk6tbwhfZscNJp98+7M5O8WY0m7KXQ0vP4FSNx62yl0fl/nY1hb7o9o
 MLukKyFS1UzkAX+Z6YI7CNGBG4v5m/6QlhJXc8Yt5lGabJipNOgL6FhFccxTaWVYwvB7
 SLq7hLM8VqVjBjUu8fYIYrCvnWi+an5Z6gEiF1qGPNUbdcW0SylPOeXS6xDYk5k45Fra
 huhyoZ9XanTjKqyTIuPGLE0EUtPzrq10FuWkDIKwzYUPAK7a7T2Al09Frpl2XpTKtU5+
 uZdEwPYTgmCZlD4zwJFXb48rfYgB+Fz7DND8PnH0f7FHbbitXauYRWByDlzZ6yBGZ2ze
 ASNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722243133; x=1722847933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hJ6CS7lqqjqjO1KZ9iJfHDi23887n6tKHywRZD+GIL8=;
 b=TwWwcn2NI13A1/rn9//4TeAYn2F+ktSPkXU7BAPOMdqt6dXxA4mJTwYG5opyJKCFB8
 8yM27EWI1HOf5yBRLETRmdGsHKzpjHb0ddbqDZ43r2HMsLP8uOvclltQtYQbq7pUZ6Ah
 VAeceAybzsbQPwVDre9mXZxVx3kVojqq7gvRBEiUf0v1vqd6RVCAsTrohy5prl6qp5td
 GVtCuKuCnssGmK+gtbLyY0P0p8BMWwBdByiKTEZPBHoZHLVyeF6UklfG6mbxASi5UzbS
 ISD4iULhRbOUTMdsKwkNFN4AQRLDNSRgt6fQowIzeypgzhh1EFHhmXvnCQvCjuTwWBBy
 6jEg==
X-Gm-Message-State: AOJu0YwU0t82z+pMzUw/w+cjVc1iy6p91Ja3RycfZ6Jakg3SN2wTFvNe
 fk6LALe3vn9MVwjS/Cp6FWvtYAvXNNLfBfJMMY+aHct0AX7asQtqtX23WZUQhlZ13UV4uzPEo10
 PS9lZHc2wOwcJZRw3jq8xVkg6ir1GnhZlPWX/Fw==
X-Google-Smtp-Source: AGHT+IGvaeuRhpr07O417dWmI1wvB36o4TJ52KJ6HdlS/2ZKwM7HKlu+OV7wCx31aZNSJ7qK1XVpIb1BsM/6SeE91Vc=
X-Received: by 2002:a50:d7c5:0:b0:5a2:1f7b:dffa with SMTP id
 4fb4d7f45d1cf-5b020101f53mr4205602a12.3.1722243132901; Mon, 29 Jul 2024
 01:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-31-sughosh.ganu@linaro.org>
 <CAFLszTg-hL9z3o68RigDFCE2=Cj-UVHv0xh0Y9=QuS=ZDq3FGw@mail.gmail.com>
In-Reply-To: <CAFLszTg-hL9z3o68RigDFCE2=Cj-UVHv0xh0Y9=QuS=ZDq3FGw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:22:01 +0530
Message-ID: <CADg8p95m8w8hgsderBgDhMfNTv73RrTVGtNsu6Yh4wt6b1nNmg@mail.gmail.com>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The sandbox iommu driver uses the LMB module to allocate a particular
> > range of memory for the device virtual address(DVA). This used to work
> > earlier since the LMB memory map was caller specific and not
> > global. But with the change to make the LMB allocations global and
> > persistent, adding this memory range has other side effects. On the
> > other hand, the sandbox iommu test expects to see this particular
> > value of the DVA. Use the DVA address directly, instead of mapping it
> > in the LMB memory map, and then have it allocated.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >  drivers/iommu/sandbox_iommu.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
> > index 505f2c3250..15ecaacbb3 100644
> > --- a/drivers/iommu/sandbox_iommu.c
> > +++ b/drivers/iommu/sandbox_iommu.c
> > @@ -5,10 +5,10 @@
> >
> >  #include <dm.h>
> >  #include <iommu.h>
> > -#include <lmb.h>
> >  #include <asm/io.h>
> >  #include <linux/sizes.h>
> >
> > +#define DVA_ADDR               0x89abc000
>
> This is a very strange address. You can put this in
> arch/sandbox/include/asm/test.h and check it in the test. I suggest
> using something like 0x12345678 so it is obviously meaningless.

You will see that I am using the same address that is being used
currently. I did not want to make any changes to what is working, nor
did I want to spend time debugging if this logic can be improved --
that is not the purpose of this series.

>
> >  #define IOMMU_PAGE_SIZE                SZ_4K
> >
> >  static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> > @@ -20,8 +20,7 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> >         paddr = ALIGN_DOWN(virt_to_phys(addr), IOMMU_PAGE_SIZE);
> >         off = virt_to_phys(addr) - paddr;
> >         psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
> > -
> > -       dva = lmb_alloc(psize, IOMMU_PAGE_SIZE, LMB_NONE);
> > +       dva = (phys_addr_t)DVA_ADDR;
> >
> >         return dva + off;
> >  }
> > @@ -35,8 +34,6 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
> >         dva = ALIGN_DOWN(addr, IOMMU_PAGE_SIZE);
> >         psize = size + (addr - dva);
> >         psize = ALIGN(psize, IOMMU_PAGE_SIZE);
> > -
> > -       lmb_free(dva, psize, LMB_NONE);
> >  }
> >
> >  static struct iommu_ops sandbox_iommu_ops = {
> > @@ -46,8 +43,6 @@ static struct iommu_ops sandbox_iommu_ops = {
> >
> >  static int sandbox_iommu_probe(struct udevice *dev)
> >  {
> > -       lmb_add(0x89abc000, SZ_16K, LMB_NONE);
> > -
> >         return 0;
> >  }
>
> If this function is empty, you should remove it.

Okay.

-sughosh

>
> >
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
