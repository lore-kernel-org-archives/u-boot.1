Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B22C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD1EB88AF8;
	Tue,  6 Aug 2024 23:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d2ETEv7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F7088B02; Tue,  6 Aug 2024 23:51:07 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F0F88AE6
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b7a3e468a9so6861956d6.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981050; x=1723585850; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ol2Hua1VOCQbLhkJL8y3b2C1GKi2FfNBkj2rzTOfl08=;
 b=d2ETEv7AGb6fvfAGTSGjTKDWYHCrkYmFBeXZnXkE9wjR9FHbGwgiIKKYqn8MbRHLMt
 RHFRSooMXX05IQkyr7Xz/CEUBvralMiHdlNodKLMEBRCfgvlFpDPZZPcXTX/mSS0Gfen
 xpddzjjolBqspzpAGwk0VpjMRQoWTIwxpuoUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981050; x=1723585850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ol2Hua1VOCQbLhkJL8y3b2C1GKi2FfNBkj2rzTOfl08=;
 b=bFyAaf6DiruvaEuEAt/qdlMIsrSqraSRAvuGkFMW8KVionmjbVtsGcxqPVLeUN/Tjz
 LkkOy+WM6gvcKAcMTUCvhBY2UxfVJ7xJ+XG7bfckojMFCVlOAfZRuF/454YdjW0bMJxe
 uZa0z5BVxeQZ9RscxyFDRktFtnsvQ62A4WLowmuj/dmdTfjGEbcs9e56HlyFDu9pyuoM
 Pu6vDmdUXYQUj5VYiDJs2z6+zXcouHMtc9z/8DyCkcj1j5fTHPVNoyXdfnVEZy1F7wEy
 /j+/BXDpgKhxyOH//VUq3hVk26Ej1SXdJxPT10AVEemRNjbGptjIsfpjdssq2nkkkQ/A
 4y2g==
X-Gm-Message-State: AOJu0Yw0rv0MvyFcQIBDf+FBPmftc2RCnt5zKBG8KfdNE6cHb1+Y4vuS
 Tyq+uwwGVUcIzqRvqwu1wtpU5s67D3tyV049oTNdamLue3FwQezVH6h9GFLd3Zgme+qkR3pJY9Z
 kE7IvyNNDw01cIMHyXCqtLfsLsv7HQgHrDVZI
X-Google-Smtp-Source: AGHT+IEYSSYS/4f9lpFwnVw7yCWa1F1qiBNnirxhxXbOFB7P6s1gsrRFr+MIJfK2GgAAnTiEnNz2ZFIg1d3c7NMZMvw=
X-Received: by 2002:a05:6214:3d98:b0:6b5:d764:69d9 with SMTP id
 6a1803df08f44-6bb983a9940mr218286976d6.7.1722981049689; Tue, 06 Aug 2024
 14:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-31-sughosh.ganu@linaro.org>
 <CAFLszTg-hL9z3o68RigDFCE2=Cj-UVHv0xh0Y9=QuS=ZDq3FGw@mail.gmail.com>
 <CADg8p95m8w8hgsderBgDhMfNTv73RrTVGtNsu6Yh4wt6b1nNmg@mail.gmail.com>
 <CAFLszTh4CvysoS1njOtEP8NHd3avHQhbYr_Z0n1wMvDmnJT0fQ@mail.gmail.com>
 <CADg8p961G-FLGjot1Ur-3CoBvrHhnDLv5hv_c-k4NeBAZ598xA@mail.gmail.com>
In-Reply-To: <CADg8p961G-FLGjot1Ur-3CoBvrHhnDLv5hv_c-k4NeBAZ598xA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:38 -0600
Message-ID: <CAFLszTgh_T7Mf3r1vgnn5=Gp4G1z6s9wO=TmRd7XQeq2vRc-bg@mail.gmail.com>
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

On Fri, 2 Aug 2024 at 01:44, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 29 Jul 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Mon, 29 Jul 2024 at 02:52, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > The sandbox iommu driver uses the LMB module to allocate a particular
> > > > > range of memory for the device virtual address(DVA). This used to work
> > > > > earlier since the LMB memory map was caller specific and not
> > > > > global. But with the change to make the LMB allocations global and
> > > > > persistent, adding this memory range has other side effects. On the
> > > > > other hand, the sandbox iommu test expects to see this particular
> > > > > value of the DVA. Use the DVA address directly, instead of mapping it
> > > > > in the LMB memory map, and then have it allocated.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since rfc: None
> > > > >
> > > > >  drivers/iommu/sandbox_iommu.c | 9 ++-------
> > > > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
> > > > > index 505f2c3250..15ecaacbb3 100644
> > > > > --- a/drivers/iommu/sandbox_iommu.c
> > > > > +++ b/drivers/iommu/sandbox_iommu.c
> > > > > @@ -5,10 +5,10 @@
> > > > >
> > > > >  #include <dm.h>
> > > > >  #include <iommu.h>
> > > > > -#include <lmb.h>
> > > > >  #include <asm/io.h>
> > > > >  #include <linux/sizes.h>
> > > > >
> > > > > +#define DVA_ADDR               0x89abc000
> > > >
> > > > This is a very strange address. You can put this in
> > > > arch/sandbox/include/asm/test.h and check it in the test. I suggest
> > > > using something like 0x12345678 so it is obviously meaningless.
> > >
> > > You will see that I am using the same address that is being used
> > > currently. I did not want to make any changes to what is working, nor
> > > did I want to spend time debugging if this logic can be improved --
> > > that is not the purpose of this series.
> >
> > Please just move it. You can keep the same address, but put the
> > constant in the header file.
>
> Looking into this, there isn't an appropriate header file where I can
> put this constant. And creating one only for a macro seems like an
> overkill. Can you propose a header file where I can put this. If there
> isn't an existing one, maybe I can keep the macro as is?

arch/sandbox/include/asm/test.h

It is used for quite a few constants.


>
> -sughosh
>
> >
> > >
> > > >
> > > > >  #define IOMMU_PAGE_SIZE                SZ_4K
> > > > >
> > > > >  static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> > > > > @@ -20,8 +20,7 @@ static dma_addr_t sandbox_iommu_map(struct udevice *dev, void *addr,
> > > > >         paddr = ALIGN_DOWN(virt_to_phys(addr), IOMMU_PAGE_SIZE);
> > > > >         off = virt_to_phys(addr) - paddr;
> > > > >         psize = ALIGN(size + off, IOMMU_PAGE_SIZE);
> > > > > -
> > > > > -       dva = lmb_alloc(psize, IOMMU_PAGE_SIZE, LMB_NONE);
> > > > > +       dva = (phys_addr_t)DVA_ADDR;
> > > > >
> > > > >         return dva + off;
> > > > >  }
> > > > > @@ -35,8 +34,6 @@ static void sandbox_iommu_unmap(struct udevice *dev, dma_addr_t addr,
> > > > >         dva = ALIGN_DOWN(addr, IOMMU_PAGE_SIZE);
> > > > >         psize = size + (addr - dva);
> > > > >         psize = ALIGN(psize, IOMMU_PAGE_SIZE);
> > > > > -
> > > > > -       lmb_free(dva, psize, LMB_NONE);
> > > > >  }
> > > > >
> > > > >  static struct iommu_ops sandbox_iommu_ops = {
> > > > > @@ -46,8 +43,6 @@ static struct iommu_ops sandbox_iommu_ops = {
> > > > >
> > > > >  static int sandbox_iommu_probe(struct udevice *dev)
> > > > >  {
> > > > > -       lmb_add(0x89abc000, SZ_16K, LMB_NONE);
> > > > > -
> > > > >         return 0;
> > > > >  }
> > > >
> > > > If this function is empty, you should remove it.
> > >
> > > Okay.
Regards,
Simon
