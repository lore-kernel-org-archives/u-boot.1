Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3A3C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 15:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 800C483B32;
	Thu, 10 Apr 2025 17:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bFNoUUd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949E283D0C; Thu, 10 Apr 2025 17:50:18 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFAEC82A85
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 17:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AFoEsV1827838
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 10:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744300214;
 bh=J7CYF4EkoFWWEF+FXGGupptYPhKb1IPIYQE8w/VIDWQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bFNoUUd5CIWejvp/45HQFm5p2naDoQR4VzKHxCWPvhQWJDa+H/Gxwq57o+GuBX08W
 Rgf/3uNxTdUfWfJCzsbllD2O5RTYPdJfgmMM+Nhoem7VW6WaxzaEIbZXRuZlKB4cyc
 ql74tGuo++3MPSckSuB8M3JuTcQQ8EqfKY07LwUg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AFoEi0070058
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Apr 2025 10:50:14 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 10:50:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 10:50:13 -0500
Received: from [10.249.136.157] ([10.249.136.157])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AFo9fI118380;
 Thu, 10 Apr 2025 10:50:10 -0500
Message-ID: <4bb83e2a-9eb9-4982-a5e3-dda533dc7f51@ti.com>
Date: Thu, 10 Apr 2025 21:20:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] firmware: ti_sci: Scan all device instances when
 releasing exclusive devices
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>
CC: Andrew Davis <afd@ti.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Jonas Wood <jw@ti.com>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 Dhruva Gole <d-gole@ti.com>
References: <20250407121554.1010490-1-nm@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250407121554.1010490-1-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Nishanth

On 4/7/2025 5:45 PM, Nishanth Menon wrote:
> When FIT image with multiple dtbs are involved for R5 boot process,
> R5 SPL starts off with the first instance of dtb to probe the
> eeprom, then once we have identified the type of board, invocation
> of setup_multi_dtb_fit will replace the gd->fdt_blob with the proper
> board dtb match. However, when we do this, two things happen:
> 
> a) Prior to the invocation of setup_multi_dtb_fit, as part of the eeprom
>    discovery process, i2c controller device is already probed and marked
>    as exclusive with the match of the very first tisci match (from the
>    original boot dtb). This list is stored in the info->dev_list of the
>    first probe.
> b) When the second dtb is loaded, tisci is probed again (since this is a
>    new node) and the new info->dev_list is empty.
> 
> At this stage, the exclusive devices such as i2c instances used to
> probe the board information is left in the old info->dev_list that is
> no longer used actively by the system using the replaced dtb.
> 
> As a result of this, the cleanup we intend to do with
> ti_sci_cmd_release_exclusive_devices is no longer complete and
> leaves the instances such as i2c for eeprom marked used as we scan just
> the new info->dev_list.
> 
> This creates a problem when Device Manager(DM) firmware starts up later
> on in the boot process and identifies that this instance of i2c is
> already marked active, so it assumes this can no longer be controlled
> by software and is marked internally as reserved and HLOS can no
> longer control these instances. This defeated the purpose of
> ti_sci_cmd_release_exclusive_devices.
> 
> NOTE: This scheme works just fine if the FIT has just a single dtb as
> the info->dev_list is upto date.
> 
> To fix this, let us make ti_sci_cmd_release_exclusive_devices scan the
> all registrations of tisci instances and cleanup all exclusive devices
> that have ever been registered.
> 
> As part of this, change the prototype of release_exclusive_devices to
> drop the handle since that has no further meaning now.
> 
> Though this issue was identified on AM64-sk, this can be present in
> other builds which use multi-fit-dtb for R5 SPL startup.
> 
> Fixes: 9566b777ae0a ("firmware: ti_sci: Add a command for releasing all exclusive devices")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
> * commit message: s/intent/intend (review comment)
> * Added comment to indicate am64x-sk
> * No functional changes.
> 
> V1: https://lore.kernel.org/r/20250401205515.4078312-1-nm@ti.com
> 
> Retaining test log:
> 
> Test logs:
> ==========
> prior to this patch:
> https://gist.github.com/nmenon/8ce817ac991b6ff898734d15ae5ce623#file-before
> With this patch
> https://gist.github.com/nmenon/8ce817ac991b6ff898734d15ae5ce623#file-after
> Notice that 20000000.i2c is no longer deffered in Linux.
> 
> Test of platforms (on c17f03a7e93d  Merge tag 'net-20250314' of https://source.denx.de/u-boot/custodians/u-boot-net)
> 
> https://gist.github.com/nmenon/917e15b397e5249dd76664ea62e9e662
> 
> Though this was uncovered in automated check in upstream testing, this was also
> independently reported in:
> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1459509/sk-am64b-deferred-probe-of-i2c-bus-using-sdk-09-and-10
> 
>  arch/arm/mach-k3/r5/common.c           |  2 +-
>  drivers/firmware/ti_sci.c              | 23 ++++++++++++++---------
>  include/linux/soc/ti/ti_sci_protocol.h |  2 +-
>  3 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index 0f6c294f1eb2..fd188e7c90e4 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -144,7 +144,7 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>  	int ret, size = 0, shut_cpu = 0;
>  
>  	/* Release all the exclusive devices held by SPL before starting ATF */
> -	ti_sci->ops.dev_ops.release_exclusive_devices(ti_sci);
> +	ti_sci->ops.dev_ops.release_exclusive_devices();
>  
>  	ret = rproc_init();
>  	if (ret)
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 190a1e3f5fc3..54d6689ce783 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -696,20 +696,25 @@ static int ti_sci_cmd_put_device(const struct ti_sci_handle *handle, u32 id)
>  				       MSG_DEVICE_SW_STATE_AUTO_OFF);
>  }
>  
> -static
> -int ti_sci_cmd_release_exclusive_devices(const struct ti_sci_handle *handle)
> +static int ti_sci_cmd_release_exclusive_devices(void)
>  {
>  	struct ti_sci_exclusive_dev *dev, *tmp;
>  	struct ti_sci_info *info;
>  	int i, cnt;
>  
> -	info = handle_to_ti_sci_info(handle);
> -
> -	list_for_each_entry_safe(dev, tmp, &info->dev_list, list) {
> -		cnt = dev->count;
> -		debug("%s: id = %d, cnt = %d\n", __func__, dev->id, cnt);
> -		for (i = 0; i < cnt; i++)
> -			ti_sci_cmd_put_device(handle, dev->id);
> +	/*
> +	 * Scan all ti_sci_list registrations, since with FIT images, we could
> +	 * have started with one device tree registration and switched over
> +	 * to a final version. This prevents exclusive devices identified
> +	 * during the first probe to be left orphan.
> +	 */
> +	list_for_each_entry(info, &ti_sci_list, list) {
> +		list_for_each_entry_safe(dev, tmp, &info->dev_list, list) {
> +			cnt = dev->count;
> +			debug("%s: id = %d, cnt = %d\n", __func__, dev->id, cnt);
> +			for (i = 0; i < cnt; i++)
> +				ti_sci_cmd_put_device(&info->handle, dev->id);
> +		}
>  	}
>  
>  	return 0;
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index 8e4c43cef311..aa4d105ee988 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -143,7 +143,7 @@ struct ti_sci_dev_ops {
>  				 u32 reset_state);
>  	int (*get_device_resets)(const struct ti_sci_handle *handle, u32 id,
>  				 u32 *reset_state);
> -	int (*release_exclusive_devices)(const struct ti_sci_handle *handle);
> +	int (*release_exclusive_devices)(void);
>  };
>  
>  /**

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

