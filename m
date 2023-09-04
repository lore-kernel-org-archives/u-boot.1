Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4ECC83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 07:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D778682B;
	Mon,  4 Sep 2023 09:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC328689A; Mon,  4 Sep 2023 09:03:27 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A28386415
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 09:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38473HYa023645;
 Mon, 4 Sep 2023 15:03:17 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 4 Sep 2023 15:03:16 +0800
Date: Mon, 4 Sep 2023 15:02:24 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chanho Park <chanho61.park@samsung.com>
CC: Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] timer: riscv_aclint_timer: add timer_get_boot_us
 for BOOTSTAGE
Message-ID: <ZPWBAKPO5HBAzFRK@swlinux02>
References: <20230828094938.2061606-1-chanho61.park@samsung.com>
 <CGME20230828094953epcas2p3fc191dd7a0d387cfd987240b972c79b5@epcas2p3.samsung.com>
 <20230828094938.2061606-4-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828094938.2061606-4-chanho61.park@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38473HYa023645
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

Hi Chanho,

On Mon, Aug 28, 2023 at 06:49:38PM +0900, Chanho Park wrote:
> timer_get_boot_us function is required to record the boot stages as
> us-based timestamp.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/timer/riscv_aclint_timer.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/timer/riscv_aclint_timer.c b/drivers/timer/riscv_aclint_timer.c
> index e29d527c8d77..8b67745bb4a2 100644
> --- a/drivers/timer/riscv_aclint_timer.c
> +++ b/drivers/timer/riscv_aclint_timer.c
> @@ -6,6 +6,7 @@
>  
>  #include <common.h>
>  #include <clk.h>
> +#include <div64.h>
>  #include <dm.h>
>  #include <timer.h>
>  #include <asm/io.h>
> @@ -44,6 +45,27 @@ u64 notrace timer_early_get_count(void)
>  }
>  #endif
>  
> +#if CONFIG_IS_ENABLED(RISCV_MMODE) && CONFIG_IS_ENABLED(BOOTSTAGE)
> +ulong timer_get_boot_us(void)
> +{
> +	int ret;
> +	u64 ticks = 0;
> +	u32 rate;
> +
> +	ret = dm_timer_init();
> +	if (!ret) {
> +		rate = timer_get_rate(gd->timer);
> +		timer_get_count(gd->timer, &ticks);
> +	} else {
> +		rate = RISCV_MMODE_TIMER_FREQ;
> +		ticks = readq((void __iomem *)MTIME_REG(RISCV_MMODE_TIMERBASE,
> +							RISCV_MMODE_TIMEROFF));
> +	}
> +
> +	return lldiv(ticks * 1001, (rate / 1000));

Why is this dividend 1001 ?

Best regards,
Leo

> +}
> +#endif
> +
>  static const struct timer_ops riscv_aclint_timer_ops = {
>  	.get_count = riscv_aclint_timer_get_count,
>  };
> -- 
> 2.39.2
> 
