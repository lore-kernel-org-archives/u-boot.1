Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB7FFD88CC
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 23:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4235483FA6;
	Wed, 11 Mar 2026 00:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AaZZRIBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 566CD83FA3; Wed, 11 Mar 2026 00:18:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BA583FA6
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 00:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fc7c=BL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773184716;
 bh=TcCpaKgSuYuZzc4OXE1LJXIjQgRpARSLLNCTPPVqijM=;
 b=AaZZRIBtpd4rMhXjfHAaWNTNENireV/LGXIrqmhBwomAvJkfJIe12iFS0CoqK6L5CbW7km4kL
 KxCq66toJnIsUkdRROCJTdeVLLnMWYSaRZW3/Pepox3atqICteB1lWNXveS/1uzbHSQPxg0QOCP
 ay1TaVVbNjSOCoBOweYFjxAgqfMeUV4OWjJjwcqkeYk4tfhz7vpgIua+ttQHFZTT55H4w6+ropx
 qfUGve56NkHTKQXoLELIDFReq4smkwqKB173USnCCYP/hlKX3FtEdSkc68NvRvr/oxhDW4+6tVX
 L8clBVWKknNfoyiwM1z/4JZ8UIySp+qx5S5icM1TJO2w==
X-Forward-Email-ID: 69b0a6c93cc84e2a49a2e584
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b65b484c-8d1d-4efb-97e7-d6337e087a26@kwiboo.se>
Date: Wed, 11 Mar 2026 00:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] rockchip: spl: Add support for booting from UFS
To: Alexey Charkov <alchark@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, u-boot@lists.denx.de
References: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
 <20260120-rk3576-ufs-v5-4-0edb61b301b7@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260120-rk3576-ufs-v5-4-0edb61b301b7@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Alexey,

On 1/20/2026 7:09 PM, Alexey Charkov wrote:
> Add the required architecture-specific lookups to enable U-boot SPL to
> load images from UFS storage devices on Rockchip RK3576, which has a
> boot ROM capable of loading the SPL image from UFS.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  arch/arm/dts/rk3576-u-boot.dtsi              | 16 +++++++++++++++-
>  arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
>  arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
>  arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++++++++
>  4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> index dc3771b556a3..e442e94f7132 100644
> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -12,7 +12,7 @@
>  	};
>  
>  	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci, &ufshc;
>  	};
>  
>  	dmc {
> @@ -81,6 +81,15 @@
>  	bootph-some-ram;
>  };
>  
> +&gpio4 {
> +	/* This is specifically for GPIO4_D0, which is the only 1.2V capable
> +	 * pin on RK3576 available for use as the UFS device reset, thus
> +	 * &gpio4 is required for booting from UFS on RK3576.
> +	 */
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};

Please wrap this in a #ifdef CONFIG_SPL_UFS_SUPPORT or similar, we only
need to include gpio4 in spl/u-boot-spl.dtb when SPL_UFS_SUPPORT is
enabled.

> +
>  &ioc_grf {
>  	bootph-all;
>  };

Please add following UFS related pinconf node to SPL, it is referenced
by ufs_rstgpio:

&pcfg_pull_down {
	bootph-pre-ram;
	bootph-some-ram;
};

> @@ -176,6 +185,11 @@
>  	bootph-pre-ram;
>  };
>  
> +&ufshc {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};

Please add following UFS related pinctrl nodes to SPL:

&ufs_refclk {
	bootph-pre-ram;
	bootph-some-ram;
};

&ufs_rstgpio {
	bootph-pre-ram;
	bootph-some-ram;
};

Above changes depends on the 438f1fe833e0 from devicetree-rebasing,
please pick and include that in a v6.

With above fixed this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Also feel free to pick "rockchip: rk3576-rock-4d: Enable UFS support"
from my rk3576 branch [1] in a v6. That branch also include FIXUPs
with the changes I have requested and tested on a ROCK 4D.

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3576

Regards,
Jonas

> +
>  &xin24m {
>  	bootph-all;
>  };
> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
> index b15938c021d6..f9ecb6858f04 100644
> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> @@ -51,6 +51,7 @@ enum {
>  	BROM_BOOTSOURCE_SPINOR = 3,
>  	BROM_BOOTSOURCE_SPINAND = 4,
>  	BROM_BOOTSOURCE_SD = 5,
> +	BROM_BOOTSOURCE_UFS = 7,
>  	BROM_BOOTSOURCE_I2C = 8,
>  	BROM_BOOTSOURCE_SPI = 9,
>  	BROM_BOOTSOURCE_USB = 10,
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index a1e8a7572fa4..46cf60dc77c7 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -46,6 +46,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
>  	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
>  	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
> +	[BROM_BOOTSOURCE_UFS] = "/soc/ufshc@2a2d0000",
>  };
>  
>  static struct mm_region rk3576_mem_map[] = {
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 6572dde29f65..d2dd5e10935f 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -76,6 +76,9 @@ static int spl_node_to_boot_device(int node)
>  	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
>  		return BOOT_DEVICE_SPI;
>  
> +	if (!uclass_find_device_by_of_offset(UCLASS_UFS, node, &parent))
> +		return BOOT_DEVICE_UFS;
> +
>  	return -1;
>  }
>  
> @@ -231,6 +234,17 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
>  		return -ENODEV;
>  	}
>  
> +	if (boot_device == BOOT_DEVICE_UFS) {
> +		ret = uclass_find_device(UCLASS_UFS, 0, &dev);
> +		if (ret) {
> +			debug("%s: could not find device for UFS: %d\n",
> +			      __func__, ret);
> +			return ret;
> +		}
> +
> +		return ofnode_get_path(dev_ofnode(dev), buf, buflen);
> +	}
> +
>  #if CONFIG_IS_ENABLED(BLK)
>  	dev_num = (boot_device == BOOT_DEVICE_MMC1) ? 0 : 1;
>  
> 

