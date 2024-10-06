Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E651CFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 08:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48B5A8897F;
	Sun,  6 Oct 2024 10:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oIlGr96l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F92C886B1; Sun,  6 Oct 2024 10:56:21 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB82E88670
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 10:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4968uFtx069464;
 Sun, 6 Oct 2024 03:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728204975;
 bh=YNlr1xGK7tWbbrletBWZor7NC+2PAjzaxg503430ODk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=oIlGr96lb9KhyC/mHddTX1db+EojVD0Xlo64hp4RZvJY8igjmgpbecUBOLZKFshnK
 +re/W/pH/ignVBYtntAEucyZX5VznEmzNh1KUaCCmiR5ITTM9QK1/JSD86b5KvAkoW
 ZK1Rs12ogz0ZI+gyZqAhCjAnA81Nl0qtUV/RSx7s=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4968uFiK022696
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 6 Oct 2024 03:56:15 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 6
 Oct 2024 03:56:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 6 Oct 2024 03:56:15 -0500
Received: from localhost (uda0496754.dhcp.ti.com [10.24.69.171])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4968uEiw116643;
 Sun, 6 Oct 2024 03:56:15 -0500
Date: Sun, 6 Oct 2024 14:26:14 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: Re: [PATCH 1/4] mach-k3: common.c: Add dma device remove in spl exit
Message-ID: <20241006085613.obqtad5x7e3xut6s@uda0496754>
References: <20241004132057.1449909-1-p-mantena@ti.com>
 <20241004132057.1449909-2-p-mantena@ti.com>
 <3f9a080d-5752-4766-9ae1-2a1049d82cca@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f9a080d-5752-4766-9ae1-2a1049d82cca@ti.com>
User-Agent: NeoMutt/20171215
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 20:09-20241004, Kumar, Udit wrote:
Hi Udit,
> Hi Prasant,
> 
> Thanks for series,
> 
> Could we update the subject of patch something like
> 
> Remove dma device in spl exit, Sorry but
> 
> Add dma device remove in spl exit looks little confusing , are we adding or
> removing ?

Understood. Should've been more simpler like "Remove dma device in spl
exit". Will update in next version.

> 
> 
> On 10/4/2024 6:50 PM, Prasanth Babu Mantena wrote:
> > While exiting from spl, remove any dma device active through
> > spl_board_prepare_for_boot(). This is required for cleaning up
> > any dma channels being used in spl and avoid issues with overlapping
> > channel allocation in the next stage bootloaders.
> > 
> > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > ---
> >   arch/arm/mach-k3/common.c | 23 ++++++++++++++++++++++-
> >   1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> > index df48ec8d47..982dc76b00 100644
> > --- a/arch/arm/mach-k3/common.c
> > +++ b/arch/arm/mach-k3/common.c
> > @@ -28,6 +28,8 @@
> >   #include <env.h>
> >   #include <elf.h>
> >   #include <soc.h>
> > +#include <dm/uclass-internal.h>
> > +#include <dm/device-internal.h>
> >   #include <asm/arch/k3-qos.h>
> > @@ -246,12 +248,31 @@ void spl_enable_cache(void)
> >   #endif
> >   }
> > -#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
> > +static __maybe_unused void k3_dma_remove(void)
> > +{
> > +	struct udevice *dev;
> > +	int rc;
> > +
> > +	rc = uclass_find_device(UCLASS_DMA, 0, &dev);
> 
> Are you thinking to have DMA device optional ?

Not really. Sorry, but didn't understand the question completely here.
> 
> Second question, if we enabled multiple DMAs in u-boot, then would you like
> to remove all ?

Considering this function is specific to k3, here we have channel
allocation done in probe and there is a need to clean that channel
resources which has been done in remove function in this series, call
that remove function here. If there are such allocations done for other
dma devices as well and have their remove functions implemented, then
they should consider adding those as well here. I don't think there is
any such case with other dmas.

> 
> 
> > +	if (!rc && dev) {
> > +		rc = device_remove(dev, DM_REMOVE_NORMAL);
> > +		if (rc)
> > +			pr_warn("Cannot remove dma device '%s' (err=%d)\n",
> > +				dev->name, rc);
> > +	}
> > +}
> > +
> >   void spl_board_prepare_for_boot(void)
> >   {
> > +#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
> >   	dcache_disable();
> > +#endif
> 
> Please suggest , why we are protecting dcache_disable with flags ?

This is carry forward which was already present. This patch removes
the protection from whole spl_board_prepare_for_boot() function to
dcache_disable() only. This alone looks like it has been added in this
patch, but if we see the whole snippet, it can be understood well.

Thanks,
Prasanth
> 
> 
> > +#if IS_ENABLED(CONFIG_SPL_DMA) && IS_ENABLED(CONFIG_SPL_DM_DEVICE_REMOVE)
> > +	k3_dma_remove();
> > +#endif
> >   }
> > +#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
> >   void spl_board_prepare_for_linux(void)
> >   {
> >   	dcache_disable();
