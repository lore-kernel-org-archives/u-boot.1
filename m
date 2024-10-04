Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3083ECF8842
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 14:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF3288B86;
	Fri,  4 Oct 2024 16:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="czC4wiGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E3F88B89; Fri,  4 Oct 2024 16:39:21 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3710788A24
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 16:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 494EdFG9071763;
 Fri, 4 Oct 2024 09:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728052755;
 bh=r+zCO5qDw9X0tueP3d4rZSla22qn3RPSsWyIW47amG0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=czC4wiGMhQn6hoQp0JOXvWCoSR/LHQoKo5C82bTVCxCIubv7mtoGhgT7w5jocMFUd
 Jsvqq5UZuv4OzBxXfEVjW9MtcImEO9dEA30E4TG4btWjT0ODgd3zfLIUp6ZxqCd8o/
 00JXNfQgKMgvXf+cWXYWfXaNU+9yUXfjn8wEUiH4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494EdFKN046120;
 Fri, 4 Oct 2024 09:39:15 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 09:39:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 09:39:15 -0500
Received: from [10.250.151.109] ([10.250.151.109])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494EdBFh020717;
 Fri, 4 Oct 2024 09:39:12 -0500
Message-ID: <3f9a080d-5752-4766-9ae1-2a1049d82cca@ti.com>
Date: Fri, 4 Oct 2024 20:09:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mach-k3: common.c: Add dma device remove in spl exit
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>
References: <20241004132057.1449909-1-p-mantena@ti.com>
 <20241004132057.1449909-2-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241004132057.1449909-2-p-mantena@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Prasant,

Thanks for series,

Could we update the subject of patch something like

Remove dma device in spl exit, Sorry but

Add dma device remove in spl exit looks little confusing , are we adding 
or removing ?


On 10/4/2024 6:50 PM, Prasanth Babu Mantena wrote:
> While exiting from spl, remove any dma device active through
> spl_board_prepare_for_boot(). This is required for cleaning up
> any dma channels being used in spl and avoid issues with overlapping
> channel allocation in the next stage bootloaders.
>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   arch/arm/mach-k3/common.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index df48ec8d47..982dc76b00 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -28,6 +28,8 @@
>   #include <env.h>
>   #include <elf.h>
>   #include <soc.h>
> +#include <dm/uclass-internal.h>
> +#include <dm/device-internal.h>
>   
>   #include <asm/arch/k3-qos.h>
>   
> @@ -246,12 +248,31 @@ void spl_enable_cache(void)
>   #endif
>   }
>   
> -#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
> +static __maybe_unused void k3_dma_remove(void)
> +{
> +	struct udevice *dev;
> +	int rc;
> +
> +	rc = uclass_find_device(UCLASS_DMA, 0, &dev);

Are you thinking to have DMA device optional ?

Second question, if we enabled multiple DMAs in u-boot, then would you 
like to remove all ?


> +	if (!rc && dev) {
> +		rc = device_remove(dev, DM_REMOVE_NORMAL);
> +		if (rc)
> +			pr_warn("Cannot remove dma device '%s' (err=%d)\n",
> +				dev->name, rc);
> +	}
> +}
> +
>   void spl_board_prepare_for_boot(void)
>   {
> +#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
>   	dcache_disable();
> +#endif

Please suggest , why we are protecting dcache_disable with flags ?


> +#if IS_ENABLED(CONFIG_SPL_DMA) && IS_ENABLED(CONFIG_SPL_DM_DEVICE_REMOVE)
> +	k3_dma_remove();
> +#endif
>   }
>   
> +#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
>   void spl_board_prepare_for_linux(void)
>   {
>   	dcache_disable();
