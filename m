Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8029BC001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 16:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D6E869E9;
	Wed, 16 Aug 2023 18:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501F98697B; Wed, 16 Aug 2023 18:39:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E560986926
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0B1D75;
 Wed, 16 Aug 2023 09:40:31 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.36.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34DC3F762;
 Wed, 16 Aug 2023 09:39:48 -0700 (PDT)
Date: Wed, 16 Aug 2023 17:39:40 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: nd@arm.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v2 2/2] nvmxip: add sandbox support
Message-ID: <20230816163940.GA105907@e130802.arm.com>
References: <CAPnjgZ34z865voaKeShSJpdvWcFLbN0OEWBnus4qt0W_1P4jBw@mail.gmail.com>
 <20230816110551.86930-1-abdellatif.elkhlifi@arm.com>
 <20230816110551.86930-2-abdellatif.elkhlifi@arm.com>
 <2a74558f-1cf5-2333-a585-8871ea163e68@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a74558f-1cf5-2333-a585-8871ea163e68@mailbox.org>
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

Hi Marek,

Please kindly find my comments below.

> > arch/sandbox/dts/sandbox.dts       | 14 ++++++++++++++
> 
> Please separate DT change
> 
> >   configs/sandbox_defconfig          |  4 ++--
> 
> Config change too, separate patch that goes last.

This commit is doing 1 thing: adding 32-bit sandbox support.

The DT change comes into the same context.
It makes sense to keep it in this same commit.

In previous contributions I made, it was accepted that DT
and defconfig  are part of the same commit as the code.

Let's see what Simon thinks.

I'm happy to split if that has becone a new requirement.

> >   	int devnum;
> > -#if CONFIG_IS_ENABLED(SANDBOX64)
> > +#if CONFIG_IS_ENABLED(SANDBOX)
> >   	sandbox_set_enable_memio(true);
> 
> This should not be in drivers at all, this should be in tests/ , see
> 
> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commit/b07772226b405d6212d4faa9329d64a09708b188

Thanks, I'm happy to improve that one. I'll move it to tests in a seperate commit :)

> 
> >   #endif
> > @@ -62,7 +62,7 @@ static int nvmxip_post_bind(struct udevice *udev)
> >   		return ret;
> >   	}
> > -	log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
> > +	log_debug("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
> 
> Unrelated change -> separate patch please.

Valid point, I'll do thanks.

> > +	l_word = readl(address);
> > +	h_word = readl((u8 *)address + sizeof(u32));
> > +	*value = FIELD_PREP(GENMASK_ULL(63, 32), h_word) | l_word;
> > +#endif
> >   	return 0;
> >   }
> > @@ -67,7 +76,7 @@ static ulong nvmxip_blk_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcn
> >   	/* assumption: the data is virtually contiguous */
> >   	for (qdata_idx = 0 ; qdata_idx < qwords ; qdata_idx++)
> > -		nvmxip_mmio_rawread((phys_addr_t)(virt_blkaddr + qdata_idx), pdst++);
> > +		nvmxip_mmio_rawread(virt_blkaddr + qdata_idx, pdst++);
> 
> Separate patch please, or just use this commit as part of this series:
> 
> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commit/85a662e98c44921a0f5652fa4b170625424ef9a9

This is part of the 32-bit support work.
Before this commit, it works fine on sandbox64.

> >   	log_debug("[%s]:     src[0]: 0x%llx , dst[0]: 0x%llx , src[-1]: 0x%llx , dst[-1]: 0x%llx\n",
> >   		  dev->name,
> > diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
> > index 7221fd1cb4..faeb99b4ad 100644
> > --- a/drivers/mtd/nvmxip/nvmxip_qspi.c
> > +++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
> > @@ -50,7 +50,7 @@ static int nvmxip_qspi_of_to_plat(struct udevice *dev)
> >   		return -EINVAL;
> >   	}
> > -	log_debug("[%s]: XIP device base addr: 0x%llx , lba_shift: %d , lbas: %lu\n",
> > +	log_debug("[%s]: XIP device base addr: " PHYS_ADDR_LN " , lba_shift: %d , lbas: %lu\n",
> >   		  dev->name, plat->phys_base, plat->lba_shift, plat->lba);
> 
> Another separate patch.

This is part of the 32-bit support work.

> 
> >   	return 0;
> > diff --git a/test/dm/Makefile b/test/dm/Makefile
> > index 7ed00733c1..77172d9012 100644
> > --- a/test/dm/Makefile
> > +++ b/test/dm/Makefile
> > @@ -18,7 +18,7 @@ obj-$(CONFIG_UT_DM) += test-uclass.o
> >   obj-$(CONFIG_UT_DM) += core.o
> >   obj-$(CONFIG_UT_DM) += read.o
> >   obj-$(CONFIG_UT_DM) += phys2bus.o
> > -ifeq ($(CONFIG_NVMXIP_QSPI)$(CONFIG_SANDBOX64),yy)
> > +ifeq ($(CONFIG_NVMXIP_QSPI),y)
> 
> Separate patch.
> 
> Look here for some ideas:
> 
> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/ci%2Ftest-sandbox64?ref_type=heads

SANDBOX applies for both sandbox64 and sandbox.
This is part of enabling sandbox alongside sandbox64.

This has been tested and works.

Kind regards
Abdellatif
