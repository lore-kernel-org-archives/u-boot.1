Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84907C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 06:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1973B81F54;
	Wed,  2 Apr 2025 08:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MtJq8niH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2FA80584; Wed,  2 Apr 2025 08:27:40 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A205781FE8
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 08:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5326RWse3160640
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 2 Apr 2025 01:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743575252;
 bh=hO+EitWtZlxZ/g9VICfSNkuAAFYbysYVdY8SBEYJwZ4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MtJq8niH+jsstT4lsRBBJPJE0EcNpVk6ygBSLkqLUI3u4MzTNdXUYlbTGHLxHI6Bu
 zE/oPfr1fBLg5eKp0NrYvE7hrDuqwukAbFNm4FsCd+axI6zBOsygHsImOW1cTsFJQv
 NAKOP7tIgFegOnazLpNJ5II3lSiq4JpQXJ5H4AiQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5326RWZv043525;
 Wed, 2 Apr 2025 01:27:32 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Apr 2025 01:27:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Apr 2025 01:27:31 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5326RVcD032636;
 Wed, 2 Apr 2025 01:27:31 -0500
Date: Wed, 2 Apr 2025 11:57:30 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Neha Malcom Francis
 <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Andrew Davis <afd@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Jonas Wood <jw@ti.com>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] firmware: ti_sci: Scan all device instances when
 releasing exclusive devices
Message-ID: <20250402062730.vgmqbxczm2aee67z@lcpd911>
References: <20250401205515.4078312-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250401205515.4078312-1-nm@ti.com>
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

Nishanth,

On Apr 01, 2025 at 15:55:15 -0500, Nishanth Menon wrote:
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
> As a result of this, the cleanup we intent to do with

s/intent/intend

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

Firstly, it seems to me like this issue is mostly specific to the
AM64/ DM+TIFS combined core arch K3 devices? So it would be good if the
commit message can specify that for better context. People who are more
used to the R5 core running DM architecture may find this description
slightly confusing as there's no TI SCI calls that the R5 SPL can make
to DM since DM isn't up yet on those devices...

> 
> As part of this, change the prototype of release_exclusive_devices to
> drop the handle since that has no further meaning now.
> 
> Fixes: 9566b777ae0a ("firmware: ti_sci: Add a command for releasing all exclusive devices")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Test logs:
> ========
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

The other thing I am slightly not comfortable with is this.
The release_exclusive call is going to be common to every K3 device.
With your changes, will it result in any sort of increased boot time
penalty? I feel like it might, unless I maybe mistaken.

Also, to fix just AM64 style devices, we're touching a K3 common piece
of code like TI SCI. The issue that you described about the TI SCI
probing the second time causing issues seems more fundamental than the
fix being offered here.
Quoting the commit message,

> At this stage, the exclusive devices such as i2c instances used to
> probe the board information is left in the old info->dev_list that is
> no longer used actively by the system using the replaced dtb.

Can we instead try and fix the TI SCI driver behaviour from the first time?
Like is it possible to implement a .remove for the TI SCI driver such
that when the old dtb is now out of context, the driver gets cleanly
removed, and with that calls the release_exclusive of all devices that
it requested? 
That way the new instance of TI SCI driver doesn't need to worry about
doing cleanups from any of it's previous instances right?

To me that sounds like the right root cause to try and fix. Let me know
what are your thoughts on this.

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

Nit: Just update the copyright dates of the files you're touching...

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
