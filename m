Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A237C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A776E88835;
	Mon, 29 Jul 2024 17:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W/edxwSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D30D488835; Mon, 29 Jul 2024 17:28:14 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE2228883F
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d5aecbe0a9so2235153eaf.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266888; x=1722871688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UnGIyLKuEtR+ZZrl5WDhv/Q6WPBWJmP7kBvWZMw+ziA=;
 b=W/edxwSsO7P/ntEU1H0JOflLuOsX3I0UftBuR9aXJsy+MNUFCKaKIaH8MD3fXMe5Fa
 qbAUfzNEbIZ+Ti2EZZSEir3Vyq5H2JtVMoxzOzxanmZIdcXTG96+VwfK9gO4SDCL9eMt
 Gp4pVGy53cczZlK273UCzQIXxtQNcREIoXQKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266888; x=1722871688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UnGIyLKuEtR+ZZrl5WDhv/Q6WPBWJmP7kBvWZMw+ziA=;
 b=NRhjGge8nl5cvQTxCsPuhA//ZSRASgVnqg+KPNq6P7e2fNutaaNhpVtGI2XQrjbHET
 s0oIL9bVFFRKx8WU8NhWn4n43cM03LNoW68ZpXNB+rikEkCTv9wf89rWIgxD41op5gC2
 vYgVSEcqKuLnpYImzMd49JUZrV/H0j1uxePvQ9X/zCWCX2WFrLWcSGNcwz37i89oEbf1
 ql1enFw2FTx1KrQ/xukc+xq+11n/p1FfJXQEiuKp1XHSCr08Te8kZKEIp3r55PeRQtfJ
 kHzlMosg6nKROiHJ9Qp5prlThT+xPU7AD6gW3eurelYV8nUu7IXtcbbs0fp0ZgAmZiRn
 dhOA==
X-Gm-Message-State: AOJu0YyWgKUeciYSbkRnvfM3UwuoRsrfRlOOzyiOqgLGN2DyqbtwDRYj
 ZrkEoeT5Nqg4sgmDKLH6xndO9+8jJ+ERTLtXIOQr1K8B+DZRGTgPYavCutvJIRDEz6HUHXggIRs
 lcHfVS3LW5KVNw+geNZsVmoXaQygMZX8X8xTQ
X-Google-Smtp-Source: AGHT+IG82e1JouTKscgc4RQ6nI0x3L3r7n1ZeN74a8F2zGUu0xZ3tGkGZsvIcLeKd0r/Xc3X8RjbM5MF4ZSZPEy1WEs=
X-Received: by 2002:a05:6358:9045:b0:1aa:a19e:f1a4 with SMTP id
 e5c5f4694b2df-1adb243b8ddmr1100328255d.1.1722266888390; Mon, 29 Jul 2024
 08:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-31-sughosh.ganu@linaro.org>
 <CAFLszTg-hL9z3o68RigDFCE2=Cj-UVHv0xh0Y9=QuS=ZDq3FGw@mail.gmail.com>
 <CADg8p95m8w8hgsderBgDhMfNTv73RrTVGtNsu6Yh4wt6b1nNmg@mail.gmail.com>
In-Reply-To: <CADg8p95m8w8hgsderBgDhMfNTv73RrTVGtNsu6Yh4wt6b1nNmg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:27:57 -0600
Message-ID: <CAFLszTh4CvysoS1njOtEP8NHd3avHQhbYr_Z0n1wMvDmnJT0fQ@mail.gmail.com>
Subject: Re: [PATCH 30/40] sandbox: iommu: remove lmb allocation in the driver
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

On Mon, 29 Jul 2024 at 02:52, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > The sandbox iommu driver uses the LMB module to allocate a particular
> > > range of memory for the device virtual address(DVA). This used to work
> > > earlier since the LMB memory map was caller specific and not
> > > global. But with the change to make the LMB allocations global and
> > > persistent, adding this memory range has other side effects. On the
> > > other hand, the sandbox iommu test expects to see this particular
> > > value of the DVA. Use the DVA address directly, instead of mapping it
> > > in the LMB memory map, and then have it allocated.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: None
> > >
> > >  drivers/iommu/sandbox_iommu.c | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
> > > index 505f2c3250..15ecaacbb3 100644
> > > --- a/drivers/iommu/sandbox_iommu.c
> > > +++ b/drivers/iommu/sandbox_iommu.c
> > > @@ -5,10 +5,10 @@
> > >
> > >  #include <dm.h>
> > >  #include <iommu.h>
> > > -#include <lmb.h>
> > >  #include <asm/io.h>
> > >  #include <linux/sizes.h>
> > >
> > > +#define DVA_ADDR               0x89abc000
> >
> > This is a very strange address. You can put this in
> > arch/sandbox/include/asm/test.h and check it in the test. I suggest
> > using something like 0x12345678 so it is obviously meaningless.
>
> You will see that I am using the same address that is being used
> currently. I did not want to make any changes to what is working, nor
> did I want to spend time debugging if this logic can be improved --
> that is not the purpose of this series.

Please just move it. You can keep the same address, but put the
constant in the header file.

>
> >
> > >  #define IOMMU_PAGE_SIZE                SZ_4K
> > >
> > >  static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> > > @@ -20,8 +20,7 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> > >         paddr = ALIGN_DOWN(virt_to_phys(addr), IOMMU_PAGE_SIZE);
> > >         off = virt_to_phys(addr) - paddr;
> > >         psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
> > > -
> > > -       dva = lmb_alloc(psize, IOMMU_PAGE_SIZE, LMB_NONE);
> > > +       dva = (phys_addr_t)DVA_ADDR;
> > >
> > >         return dva + off;
> > >  }
> > > @@ -35,8 +34,6 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
> > >         dva = ALIGN_DOWN(addr, IOMMU_PAGE_SIZE);
> > >         psize = size + (addr - dva);
> > >         psize = ALIGN(psize, IOMMU_PAGE_SIZE);
> > > -
> > > -       lmb_free(dva, psize, LMB_NONE);
> > >  }
> > >
> > >  static struct iommu_ops sandbox_iommu_ops = {
> > > @@ -46,8 +43,6 @@ static struct iommu_ops sandbox_iommu_ops = {
> > >
> > >  static int sandbox_iommu_probe(struct udevice *dev)
> > >  {
> > > -       lmb_add(0x89abc000, SZ_16K, LMB_NONE);
> > > -
> > >         return 0;
> > >  }
> >
> > If this function is empty, you should remove it.
>
> Okay.

Regards,
Simon
