Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE85C47258
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 03:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D6EC8798D;
	Thu, 18 Jan 2024 04:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MPYz1hVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD47187A14; Thu, 18 Jan 2024 04:11:49 +0100 (CET)
Received: from mail-m12745.qiye.163.com (mail-m12745.qiye.163.com
 [115.236.127.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA68987971
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 04:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MPYz1hVLphTF3c+S+ak+R8x22N+8nLGN4SlaMWXL3RR7rxN3EOPUyK8IdsF0b9hP3JCUHTWu5arxh1B4O/uZRIJ4cGfHXJ7tvoxr6dXSD4Kv246WZ2HluL5AKxj6LvkKH9cleQYHi9nlT3T2RbBTC8EAuY5uS8t/HyozGQFU/Hg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=9D8hESEN6khMr2nGxjGoVc/iwVgVMf6td7i37OZZyLU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11880.qiye.163.com (Hmail) with ESMTPA id D434E203C0;
 Thu, 18 Jan 2024 11:11:36 +0800 (CST)
Message-ID: <2f24bedd-3a6d-44b2-ac6f-afa9ae62ef9c@rock-chips.com>
Date: Thu, 18 Jan 2024 11:11:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] rockchip: ringneck-px30: do not hardcode MMC
 controller paths
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240117-env_default_theobroma-v4-0-12019172b482@theobroma-systems.com>
 <20240117-env_default_theobroma-v4-1-12019172b482@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240117-env_default_theobroma-v4-1-12019172b482@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk0dTFZKGR5CQk8ZSUkfSE9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1a8d7ec42eb6kusnd434e203c0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODo6Kgw4ETwaGBEBNxVNPS8q
 GiwwCwJVSlVKTEtOTk9MT0JMTUNPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTU9KNwY+
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


On 2024/1/18 01:59, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> To prepare to put the similar logic around storage medium selection for
> Ringneck PX30 and Puma RK3399 in common, let's not use hardcoded paths
> but use uclass functions instead to find udevice based on their DT node
> full path.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../ringneck_px30/ringneck-px30.c                  | 37 +++++++++++++++-------
>   1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> index 537ce0d1d11..5d2c76ab902 100644
> --- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> +++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> @@ -68,11 +68,16 @@ static int setup_boottargets(void)
>   	 * Make the default boot medium between SD Card and eMMC, the one that
>   	 * was used to load U-Boot proper.
>   	 */
> -	bool sd_booted = !strcmp(boot_device, "/mmc@ff370000");
> +	struct udevice *devp;
> +
> +	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp)) {
> +		debug("%s: not reordering boot_targets, bootdev %s != MMC\n",
> +		      __func__, boot_device);
> +		return 0;
> +	}
> +
>   	char *mmc0, *mmc1;
>   
> -	debug("%s: booted from %s\n", __func__,
> -	      sd_booted ? "SD-Card" : "eMMC");
>   	mmc0 = strstr(env, "mmc0");
>   	mmc1 = strstr(env, "mmc1");
>   
> @@ -87,8 +92,8 @@ static int setup_boottargets(void)
>   	 * If mmc1 comes first in the boot order and U-Boot proper was
>   	 * loaded from mmc0, swap mmc0 and mmc1 in the list.
>   	 */
> -	if ((mmc0 < mmc1 && sd_booted) ||
> -	    (mmc0 > mmc1 && !sd_booted)) {
> +	if ((mmc0 < mmc1 && devp->seq_ == 1) ||
> +	    (mmc0 > mmc1 && devp->seq_ == 0)) {
>   		mmc0[3] = '1';
>   		mmc1[3] = '0';
>   		debug("%s: set boot_targets to: %s\n", __func__, env);
> @@ -102,28 +107,37 @@ int mmc_get_env_dev(void)
>   {
>   	const char *boot_device =
>   		ofnode_read_chosen_string("u-boot,spl-boot-device");
> +	struct udevice *devp;
>   
>   	if (!boot_device) {
>   		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
>   		      __func__);
> +#ifdef CONFIG_SYS_MMC_ENV_DEV
>   		return CONFIG_SYS_MMC_ENV_DEV;
> +#else
> +		return 0;
> +#endif
>   	}
>   
>   	debug("%s: booted from %s\n", __func__, boot_device);
>   
> -	if (!strcmp(boot_device, "/mmc@ff370000"))
> -		return 1;
> -
> -	if (!strcmp(boot_device, "/mmc@ff390000"))
> +	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
> +#ifdef CONFIG_SYS_MMC_ENV_DEV
> +		return CONFIG_SYS_MMC_ENV_DEV;
> +#else
>   		return 0;
> +#endif
> +
> +	debug("%s: get MMC ENV from mmc%d\n", __func__, devp->seq_);
>   
> -	return CONFIG_SYS_MMC_ENV_DEV;
> +	return devp->seq_;
>   }
>   
>   enum env_location arch_env_get_location(enum env_operation op, int prio)
>   {
>   	const char *boot_device =
>   		ofnode_read_chosen_string("u-boot,spl-boot-device");
> +	struct udevice *devp;
>   
>   	if (prio > 0)
>   		return ENVL_UNKNOWN;
> @@ -137,8 +151,7 @@ enum env_location arch_env_get_location(enum env_operation op, int prio)
>   	debug("%s: booted from %s\n", __func__, boot_device);
>   
>   	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
> -	    (!strcmp(boot_device, "/mmc@ff370000") ||
> -	     !strcmp(boot_device, "/mmc@ff390000")))
> +	    !uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
>   		return ENVL_MMC;
>   
>   	printf("%s: No environment available: booted from %s but U-Boot "
>
