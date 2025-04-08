Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A99C3601E
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 03:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D71833C7;
	Tue,  8 Apr 2025 05:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hg6dYsb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39A6833D3; Tue,  8 Apr 2025 05:24:21 +0200 (CEST)
Received: from mail-m49231.qiye.163.com (mail-m49231.qiye.163.com
 [45.254.49.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF41833DC
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 05:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 110208c50;
 Tue, 8 Apr 2025 11:24:14 +0800 (GMT+08:00)
Message-ID: <de795ecb-0e90-4b80-a37c-47e7a431bffb@rock-chips.com>
Date: Tue, 8 Apr 2025 11:24:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/30] rng: rockchip: Add support for rkrng variant
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Lin Jinhan <troy.lin@rock-chips.com>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
 <20250407224743.2423921-26-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250407224743.2423921-26-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09KHlYfGB1CTRhNSB8ZTR5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96136d540e03afkunm110208c50
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06Vhw*GTJWLUICP09MOEIP
 SxIwFFZVSlVKTE9PS0NJTU5OTE9NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTkxPNwY+
DKIM-Signature: a=rsa-sha256;
 b=hg6dYsb5h286pIe1nPzEMRBQOsJHRpydz1gWnVk52S5Mw5bce83pJQiVyYxwvldLuhdvhEjPIwydpFN9nzabElGlK9kSxohUzq5z/lCaCVE0he0vDNmIjtXXZG6/LbSXQgVozEgksge0T7wHUuT0ClcTVh49wEG+2GulAVoBtxY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Dq4bMkmXXAu4tGkBm5M6/sYSHrw2sn6bt8PBDUnxP3M=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/4/8 06:46, Jonas Karlman wrote:
> From: Lin Jinhan <troy.lin@rock-chips.com>
>
> Add support for rkrng variant, used by e.g. RK3528 and RK3576.
>
> Imported from vendor U-Boot linux-6.1-stan-rkr5 tag with minor
> adjustments for mainline.
>
> Signed-off-by: Lin Jinhan <troy.lin@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: Rebase on "rockchip: Update rng compatible for RK356x and RK3588"
> ---
>   drivers/rng/rockchip_rng.c | 73 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
>
> diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
> index 6e4e3abf08c8..d854ea900442 100644
> --- a/drivers/rng/rockchip_rng.c
> +++ b/drivers/rng/rockchip_rng.c
> @@ -70,6 +70,27 @@
>   #define TRNG_v1_VERSION_CODE			0x46BC
>   /* end of TRNG V1 register define */
>   
> +/* start of RKRNG register define */
> +#define RKRNG_CTRL				0x0010
> +#define RKRNG_CTRL_INST_REQ			BIT(0)
> +#define RKRNG_CTRL_RESEED_REQ			BIT(1)
> +#define RKRNG_CTRL_TEST_REQ			BIT(2)
> +#define RKRNG_CTRL_SW_DRNG_REQ			BIT(3)
> +#define RKRNG_CTRL_SW_TRNG_REQ			BIT(4)
> +
> +#define RKRNG_STATE				0x0014
> +#define RKRNG_STATE_INST_ACK			BIT(0)
> +#define RKRNG_STATE_RESEED_ACK			BIT(1)
> +#define RKRNG_STATE_TEST_ACK			BIT(2)
> +#define RKRNG_STATE_SW_DRNG_ACK			BIT(3)
> +#define RKRNG_STATE_SW_TRNG_ACK			BIT(4)
> +
> +/* DRNG_DATA_0 ~ DNG_DATA_7 */
> +#define RKRNG_DRNG_DATA_0			0x0070
> +#define RKRNG_DRNG_DATA_7			0x008C
> +
> +/* end of RKRNG register define */
> +
>   #define RK_RNG_TIME_OUT	50000  /* max 50ms */
>   
>   #define trng_write(pdata, pos, val)	writel(val, (pdata)->base + (pos))
> @@ -228,6 +249,49 @@ exit:
>   	return retval;
>   }
>   
> +static int rkrng_init(struct udevice *dev)
> +{
> +	struct rk_rng_plat *pdata = dev_get_priv(dev);
> +	u32 reg = 0;
> +
> +	rk_clrreg(pdata->base + RKRNG_CTRL, 0xffff);
> +
> +	reg = trng_read(pdata, RKRNG_STATE);
> +	trng_write(pdata, RKRNG_STATE, reg);
> +
> +	return 0;
> +}
> +
> +static int rkrng_rng_read(struct udevice *dev, void *data, size_t len)
> +{
> +	struct rk_rng_plat *pdata = dev_get_priv(dev);
> +	u32 reg = 0;
> +	int retval;
> +
> +	if (len > RK_HW_RNG_MAX)
> +		return -EINVAL;
> +
> +	reg = RKRNG_CTRL_SW_DRNG_REQ;
> +
> +	rk_clrsetreg(pdata->base + RKRNG_CTRL, 0xffff, reg);
> +
> +	retval = readl_poll_timeout(pdata->base + RKRNG_STATE, reg,
> +				    (reg & RKRNG_STATE_SW_DRNG_ACK),
> +				    RK_RNG_TIME_OUT);
> +	if (retval)
> +		goto exit;
> +
> +	trng_write(pdata, RKRNG_STATE, reg);
> +
> +	rk_rng_read_regs(pdata->base + RKRNG_DRNG_DATA_0, data, len);
> +
> +exit:
> +	/* close TRNG */
> +	rk_clrreg(pdata->base + RKRNG_CTRL, 0xffff);
> +
> +	return retval;
> +}
> +
>   static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
>   {
>   	unsigned char *buf = data;
> @@ -295,6 +359,11 @@ static const struct rk_rng_soc_data rk_trngv1_soc_data = {
>   	.rk_rng_read = rk_trngv1_rng_read,
>   };
>   
> +static const struct rk_rng_soc_data rkrng_soc_data = {
> +	.rk_rng_init = rkrng_init,
> +	.rk_rng_read = rkrng_rng_read,
> +};
> +
>   static const struct dm_rng_ops rockchip_rng_ops = {
>   	.read = rockchip_rng_read,
>   };
> @@ -324,6 +393,10 @@ static const struct udevice_id rockchip_rng_match[] = {
>   		.compatible = "rockchip,rk3588-rng",
>   		.data = (ulong)&rk_trngv1_soc_data,
>   	},
> +	{
> +		.compatible = "rockchip,rkrng",
> +		.data = (ulong)&rkrng_soc_data,
> +	},
>   	{},
>   };
>   
