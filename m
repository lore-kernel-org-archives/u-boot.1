Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49592E776F4
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941C786E7C;
	Wed,  4 Oct 2023 11:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C2486E95; Wed,  4 Oct 2023 11:11:02 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE7286E77
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3949AcdD009385;
 Wed, 4 Oct 2023 17:10:38 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 4 Oct 2023 17:10:37 +0800
Date: Wed, 4 Oct 2023 17:08:37 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chanho Park <chanho61.park@samsung.com>
CC: "'Heinrich Schuchardt'" <heinrich.schuchardt@canonical.com>,
 "'Simon Glass'" <sjg@chromium.org>, <u-boot@lists.denx.de>,
 "'Rick Chen'" <rick@andestech.com>
Subject: Re: [PATCH v3 3/3] timer: riscv_aclint_timer: add timer_get_boot_us
 for BOOTSTAGE
Message-ID: <ZR0rlZGlMkTEY0gY@swlinux02>
References: <20230906051814.1393464-1-chanho61.park@samsung.com>
 <CGME20230906051831epcas2p2641bd65052f96115e5d8130f1974ad18@epcas2p2.samsung.com>
 <20230906051814.1393464-4-chanho61.park@samsung.com>
 <641ab172-256a-4d38-84d8-bdf871adddd1@canonical.com>
 <000001d9e156$1e85e9f0$5b91bdd0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <000001d9e156$1e85e9f0$5b91bdd0$@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3949AcdD009385
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

Hi 
On Thu, Sep 07, 2023 at 03:39:57PM +0900, Chanho Park wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Sent: Thursday, September 7, 2023 2:27 AM
> > To: Chanho Park <chanho61.park@samsung.com>; Simon Glass
> > <sjg@chromium.org>
> > Cc: u-boot@lists.denx.de; Rick Chen <rick@andestech.com>; Leo
> > <ycliang@andestech.com>
> > Subject: Re: [PATCH v3 3/3] timer: riscv_aclint_timer: add
> > timer_get_boot_us for BOOTSTAGE
> > 
> > On 06.09.23 07:18, Chanho Park wrote:
> > > timer_get_boot_us function is required to record the boot stages as
> > > us-based timestamp.
> > > To get a micro-second time from a timer tick, this converts the
> > > formula like below to avoid zero result of (tick / rate) part.
> > >
> > > From: time(us) = (tick / rate) * 10000000
> Still typo 10000000 -> 1000000
> > 
> > Where is the old implementation that you refer to?
> 
> I referred it from timer_get_boot_us function of lib/time.c
> 
> lib/time.c
> 55         else if (timer_rate > 1000000)
> 56                 return lldiv(count, timer_rate / 1000000);
> 57         else
> 58                 return (unsigned long long)count * 1000000 / timer_rate;
> 
> > 
> > > To  : time(us) = (tick * 1000) / (rate / 1000)
> > >
> > > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > > ---
> > >   drivers/timer/riscv_aclint_timer.c | 23 +++++++++++++++++++++++
> > >   1 file changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/timer/riscv_aclint_timer.c
> > b/drivers/timer/riscv_aclint_timer.c
> > > index e29d527c8d77..73fb87912851 100644
> > > --- a/drivers/timer/riscv_aclint_timer.c
> > > +++ b/drivers/timer/riscv_aclint_timer.c
> > > @@ -6,6 +6,7 @@
> > >
> > >   #include <common.h>
> > >   #include <clk.h>
> > > +#include <div64.h>
> > >   #include <dm.h>
> > >   #include <timer.h>
> > >   #include <asm/io.h>
> > > @@ -44,6 +45,28 @@ u64 notrace timer_early_get_count(void)
> > >   }
> > >   #endif
> > >
> > > +#if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
> > > +ulong timer_get_boot_us(void)
> > > +{
> > > +	int ret;
> > > +	u64 ticks = 0;
> > > +	u32 rate;
> > > +
> > > +	ret = dm_timer_init();
> > > +	if (!ret) {
> > > +		rate = timer_get_rate(gd->timer);
> > > +		timer_get_count(gd->timer, &ticks);
> > > +	} else {
> > > +		rate = RISCV_MMODE_TIMER_FREQ;
> > > +		ticks = readq((void __iomem
> > *)MTIME_REG(RISCV_MMODE_TIMERBASE,
> > > +							RISCV_MMODE_TIMEROFF));
> > > +	}
> > > +
> > > +	/* Below is converted from time(us) = (tick / rate) * 10000000 */
> > > +	return lldiv(ticks * 1000, (rate / 1000));i

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

> > 
> > I found similar code in drivers/timer/cadence-ttc.c and
> > drivers/timer/omap-timer.c with
> > 
> >      us = (ticks * 1000) / rate;
> >      return us.
> > 
> > Either their code or yours must be wrong.
> > 
> > What I am missing in include/timer.h is a documentation that defines if
> > timer_dev_priv.clock_rate and timer_get_rate() yield the frequency in Hz
> > or kHz.
> 
> 'rate' seems to be Hz not kHz. So, I think they need to be corrected.
> 
> > 
> > Once we have added the missing information in the include we can start
> > reviewing this patch.
> > 
> > I really dislike that we have code per architecture and don't update and
> > use a implementation in lib/time.c (where we also have an
> > implementation) or drivers/timer/timer-uclass.c. Can't we have a single
> > implementation which is driver model based and eliminate all others?
> 
> Actually, I tried to use lib/time.c's implementation or make a generic function in timer-uclass.c as you mentioned.
> However, there are different implementations in cadence-ttc.c, rockchip_timer.c, tegra-timer.c, omap-timer.c and tsc_timer.c.
> The basic codes seems to be almost identical if we can get a DM timer successfully but fallback codes look different.
> If timer_get_boot_us can be implement in the timer-uclass.c, we still need per-driver callback function for supporting these different fallback codes.
> 

I think we could merge this patch set first, 
and then think more thoroghly about how we are going to clean this up.

Best regards,
Leo

> Best Regards,
> Chanho Park
> 
