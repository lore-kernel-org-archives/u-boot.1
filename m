Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F62C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 00:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CCB87FB5;
	Fri, 28 Jun 2024 02:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lPY2SvGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA2687FB5; Fri, 28 Jun 2024 02:02:54 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7B487F9F
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 02:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so47171e87.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719532972; x=1720137772; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wkz5217NCjFZnSx5Wyqplqc2rnSCBbvMGYhJM/ob7KQ=;
 b=lPY2SvGriatunJ3G05nHoM+ZSoFxYJP8rUIBsTR6slZ6klQb65suhCZvCxct5lYfsZ
 vmQodbB3BTmDxN2xw7PM3CGjOM/PUq+Fa3dqd7o0cntc0f0YfzXBPjznkn9OINBwf3lz
 g9I9ldK+YQxtvMwh7Ia4/B8u0DfWyQ42UXAMwv8ifSaYJMweCJZ1oOv0i+lZcmKQMwVz
 F89MaEBMcFG5jVhC5AakJYxhF9Ym2oFvy/RqbBxzKgK5zK2Fsrl3vIAgxDcgL7LJEU9r
 vdou7z5iK/HIppaqsEVh1n2SDJlY8Xzkoq6nKipMV+kQ2Wfy7Udw25/FYknIzLZeJCZn
 xgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719532972; x=1720137772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wkz5217NCjFZnSx5Wyqplqc2rnSCBbvMGYhJM/ob7KQ=;
 b=B7C53pJ3mKQKHCGJfCdD9rGkYevhd6pja7iApu6VntxomY3CelMcUz86WdWf6U+MAM
 ad7nZPVsbeOHZomxsjk3zVMDG/gyd2Kpls+BWKMVTDgujSNymhElqPvbEX2kHZltDXlE
 fHcAt0ibv8iOX94E3GdWQJDsTD8oTgnzfGwN7M/P5/3Y39TJsIzSPFB7l/Y+qw7tNXkh
 hpL4bTgPSXRd9kFfCHGQwpq8m7DtQ8oPziZaN3QLnSMbyxT6q56LFF0QWfOQT3hZBiCo
 dhCI/unCKb4nfNug3QfUQ3dkBDkQiW5/H1g85hsjJM86HoI29AWkEvdypE3gMervM4TQ
 Pa5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD0BLoZvPmWJy5xNBsnvdm99TnuhdlEcBbss/DALnpGDmFy4zXN1wLQfU8tiqixey6VhzyFv/iicHFEITJ3sZxBgUSEQ==
X-Gm-Message-State: AOJu0YzUW6B2aPHv3OF3aWvTqE2q+Rel1R5zeEhHqDvTTHiAwNmtvtxJ
 CnlxiH5Xo18WxFCz9qBC7uNO+eB90AKvFU/MnIo19Jh/ioPp3wf5cj1cMMlez/Y=
X-Google-Smtp-Source: AGHT+IH/54Z9D5QfBpRqGv0w4FrUFiV04aohVKJ1kF2sAarL3STEJtRc6WmJwAVlltnICG+OSun7nQ==
X-Received: by 2002:ac2:4315:0:b0:52c:c9bb:2ba4 with SMTP id
 2adb3069b0e04-52ce06414d5mr10025258e87.46.1719532971549; 
 Thu, 27 Jun 2024 17:02:51 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b571fsm21604266b.208.2024.06.27.17.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 17:02:51 -0700 (PDT)
Message-ID: <200e17af-d703-4dae-90ac-508712d55c68@linaro.org>
Date: Fri, 28 Jun 2024 02:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dm: core: support dtb switching without
 devices/drivers unloading
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
 <20240627113546.100333-2-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240627113546.100333-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 27/06/2024 13:35, Mikhail Kshevetskiy wrote:
> Consider a case when we have several similar boards but leds & buttons
> connected differently. Some of leds uses gpio, other pwm, third gpio over
> spi bitbang. Also different board may have different gpio hogs. And last
> but not least: board type stored inside a ubi volume.
> 
> We want a single u-boot image that will support all these boards (we are
> not using SPL). So we need runtime dtb switching.
> 
> We can't use MULTI_DTB_FIT and DTB_RESELECT because they tries to switch
> dtb too early when flash & ubi drivers are not loaded/activated.
> 
> The following code do runtime switching
> 
> 	ret = fdtdec_resetup(&rescan);
> 	if (!ret && rescan){
> 		dm_uninit();
> 		dm_init_and_scan(false);
> 	}
> 
> but it have several nasty issues
>   * additional code required to reinitialize console otherwise board will hang.
>   * MTD subsystem is not cleared, we need to remove mtd partition before
>     switching to new dtb
>   * spi-nand flash will be named "spi-nand1" instead of "spi-nand0", thus
>     flash becomes unusable
>   * some drivers are unable to deinitialize properly (ex: network driver will
>     not release mdio interface)
>   * some memory will leak, because most of drivers assumes that it will never
>     be unloaded
> 
> To avoid this nasty issues the following hack was implemented
>   * Full DM and console reinitialization was skipped
>   * Only missed device/subdevice added from new dtb during device scan.
>   * Some driver renames their devices. As result we can't use device names
>     to match old device node with a new one. The special field was added to
>     struct udevice for this purposes.
>   * Driver must be binded to the old device one more time to add missed
>     subdevices.
>   * uclass must be post_bind to the old device one more time to add missed
>     subdevices.
>   * We can't use old dtb anymore, so replace old device node with a new one
>     for existing devices.
> 
> The following restrictions are present:
>   * initial dtb MUST be a subset of a new one

Surely dtbo is a better application for your usecase? Switching out the 
entire dtb and "rebooting" the entire driver model seems a bit overkill 
to add some LEDs? If you can just pick a dtbo at some point, overlay it, 
maybe re-generate livetree, and then just devices that are affected by 
the dtbo?

Maybe that's a bit of a naive idea... Perhaps it could be restricted to 
some specific situations, like only support dtbo's that either add new 
nodes or change just the status property of a node?

Though this seems like more or less what you're doing in this patch.
>   * old devices will NOT be reinitialised
>   * no devices will be deleted or deactivated
>   * only new devices will be added
> 
> Typical usage:
> 	ret = fdtdec_resetup(&rescan);
> 	if (!ret && rescan)
> 		dm_rescan();
> 
> The code was tested with: gpio, gpio_hog, leds, buttons.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   drivers/core/device.c | 31 +++++++++++++++++++++++++++++++
>   drivers/core/root.c   | 15 +++++++++++++++
>   dts/Kconfig           |  8 ++++++++
>   include/dm/device.h   |  3 +++
>   include/dm/root.h     | 23 +++++++++++++++++++++++
>   5 files changed, 80 insertions(+)
> 
> diff --git a/drivers/core/device.c b/drivers/core/device.c
> index bf7f261cbce..4f575ca82e7 100644
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -62,6 +62,34 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
>   		return ret;
>   	}
>   
> +#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
> +	if (parent) {
> +		struct list_head	*entry;
> +		ofnode			dev_node;
> +
> +		list_for_each(entry, &parent->child_head) {
> +			dev = list_entry(entry, struct udevice, sibling_node);
> +			dev_node = dev_ofnode(dev);
> +			if ((dev->driver == drv) && (dev->uclass == uc) &&
> +			    (dev->driver_data == driver_data) &&
> +			    (strcmp(dev->node_name, ofnode_get_name(node)) == 0))
> +			{
> +				ret = 0;
> +				dev_set_ofnode(dev, node);
> +				if (drv->bind)
> +					ret = drv->bind(dev);
> +
> +				if (!ret && uc->uc_drv->post_bind)
> +					ret = uc->uc_drv->post_bind(dev);
> +
> +				if (!ret && devp)
> +					*devp = dev;
> +				return ret;
> +			}
> +		}
> +	}
> +#endif
> +
>   	dev = calloc(1, sizeof(struct udevice));
>   	if (!dev)
>   		return -ENOMEM;
> @@ -75,6 +103,9 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
>   	dev_set_plat(dev, plat);
>   	dev->driver_data = driver_data;
>   	dev->name = name;
> +#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
> +	dev->node_name = name;
> +#endif
>   	dev_set_ofnode(dev, node);
>   	dev->parent = parent;
>   	dev->driver = drv;
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index d4ae652bcfb..4bf1ff80636 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -340,6 +340,21 @@ static int dm_scan(bool pre_reloc_only)
>   	return dm_probe_devices(gd->dm_root, pre_reloc_only);
>   }
>   
> +#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
> +int dm_rescan(void)
> +{
> +	int ret;
> +
> +	ret = dm_extended_scan(false);
> +	if (ret) {
> +		debug("dm_extended_scan() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return dm_probe_devices(gd->dm_root, false);
> +}
> +#endif
> +
>   int dm_init_and_scan(bool pre_reloc_only)
>   {
>   	int ret;
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 6883a000a05..ab486b21fe2 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -292,6 +292,14 @@ config DTB_RESELECT
>   	  config allows boards to implement a function at a later point
>   	  during boot to switch to the "correct" dtb.
>   
> +config MULTI_DTB_FIT_RESCAN
> +	bool "Support switching dtb without drivers unloading (experimental)"
> +	depends on MULTI_DTB_FIT
> +	help
> +	  This configs adds possibility to switch from initial (minimal) dtb
> +	  to a "correct" one without devices/drivers unloading (ex: board type
> +	  required to switch dtb stored in ubi volume)
> +
>   config MULTI_DTB_FIT
>   	bool "Support embedding several DTBs in a FIT image for u-boot"
>   	help
> diff --git a/include/dm/device.h b/include/dm/device.h
> index add67f9ec06..409b1c4861a 100644
> --- a/include/dm/device.h
> +++ b/include/dm/device.h
> @@ -170,6 +170,9 @@ enum {
>   struct udevice {
>   	const struct driver *driver;
>   	const char *name;
> +#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
> +	const char *node_name;
> +#endif
>   	void *plat_;
>   	void *parent_plat_;
>   	void *uclass_plat_;
> diff --git a/include/dm/root.h b/include/dm/root.h
> index b2f30a842f5..dcab28f6c47 100644
> --- a/include/dm/root.h
> +++ b/include/dm/root.h
> @@ -155,6 +155,29 @@ int dm_init(bool of_live);
>    */
>   int dm_uninit(void);
>   
> +#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
> +/**
> + * dm_rescan - Rescan ftd and add missed DM devices (experimental)
> + *
> + * This function can be used for switching from initial (minimal) dtb
> + * to a "correct" one without devices/drivers unloading.
> + *
> + * Restrictions:
> + *   - initial dtb MUST be a subset of a new one
> + *   - old devices will NOT be reinitialised
> + *   - no devices will be deleted or deactivated
> + *   - only new devices will be added
> + *
> + * Typical usage:
> + *	ret = fdtdec_resetup(&rescan);
> + *	if (!ret && rescan)
> + *		dm_rescan();
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int dm_rescan(void);
> +#endif
> +
>   #if CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)
>   /**
>    * dm_remove_devices_flags - Call remove function of all drivers with

-- 
// Caleb (they/them)
