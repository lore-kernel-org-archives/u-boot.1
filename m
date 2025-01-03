Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38CBE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D325280196;
	Fri,  3 Jan 2025 07:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="D348I2IO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0353C801A0; Fri,  3 Jan 2025 07:20:58 +0100 (CET)
Received: from mail-m15580.qiye.163.com (mail-m15580.qiye.163.com
 [101.71.155.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10733800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 7969b9af;
 Fri, 3 Jan 2025 14:20:48 +0800 (GMT+08:00)
Message-ID: <c4d00cfe-8ded-49dc-b9c0-a8eada2d682a@rock-chips.com>
Date: Fri, 3 Jan 2025 14:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
 <20241210222341.3537543-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241210222341.3537543-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxNQlZNS0hCHkpNTxkeSElWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ad2d77203afkunm7969b9af
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6Nio5FjIXFy1KHgsjVggO
 LQ9PCihVSlVKTEhOQ0NOSU9CSUJOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOTUNONwY+
DKIM-Signature: a=rsa-sha256;
 b=D348I2IO/SB5bdQMXanNN99oijttEMqNTXVE1qDfS/gFWMB7AeEl00XInwiUbeWQiYtM1/yZxjuZMymbC8QdnUGxjLFu+c4WmPZRUY3sb3vnHbBR+sKpn+WkSK+u98rjCm5j5ENMsq7l8gsbThjNqpPtUT8GXoEglQNqaeRISa8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=A9n5OIjIMWwFLmPive1Fwma6Ev0bP8Bh/KDjo95twrs=;
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

Hi Jonas,

On 2024/12/11 06:23, Jonas Karlman wrote:
> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
> What blocks are disabled/non-working is indicated by ip-state in OTP.

I don't like this RK3582 because it's no an official released SoC and  
is not suppose to be in public,

for you can't even find a datasheet for it.

Since we already have board  to use this chip and wish to support it 
upstream, them

it would better to follow the vendor U-Boot as-is to handle the dts, eg. 
seems you have skip

the dts handle for rkvenc/rkvdec?


Thanks,
- Kever
>
> This add initial support for RK3582 by using ft_system_setup() to mark
> any cpu and/or gpu node with status=fail as indicated by ip-state.
>
> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
> cores and the gpu is always failed/disabled.
>
> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
> the required DT fixups for RK3582 board variants.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 128 +++++++++++++++++++++++++
>   1 file changed, 128 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c1dce3ee3703..06e6318312b2 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -7,6 +7,7 @@
>   #define LOG_CATEGORY LOGC_ARCH
>   
>   #include <dm.h>
> +#include <fdt_support.h>
>   #include <misc.h>
>   #include <spl.h>
>   #include <asm/armv8/mmu.h>
> @@ -185,6 +186,12 @@ int arch_cpu_init(void)
>   
>   #define RK3588_OTP_CPU_CODE_OFFSET		0x02
>   #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
> +#define RK3588_OTP_IP_STATE_OFFSET		0x1d
> +
> +#define BAD_CPU_CLUSTER0		GENMASK(3, 0)
> +#define BAD_CPU_CLUSTER1		GENMASK(5, 4)
> +#define BAD_CPU_CLUSTER2		GENMASK(7, 6)
> +#define BAD_GPU				GENMASK(4, 1)
>   
>   int checkboard(void)
>   {
> @@ -230,3 +237,124 @@ int checkboard(void)
>   
>   	return 0;
>   }
> +
> +#ifdef CONFIG_OF_SYSTEM_SETUP
> +static int fdt_path_del_node(void *fdt, const char *path)
> +{
> +	int nodeoffset;
> +
> +	nodeoffset = fdt_path_offset(fdt, path);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	return fdt_del_node(fdt, nodeoffset);
> +}
> +
> +static int fdt_path_set_name(void *fdt, const char *path, const char *name)
> +{
> +	int nodeoffset;
> +
> +	nodeoffset = fdt_path_offset(fdt, path);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	return fdt_set_name(fdt, nodeoffset, name);
> +}
> +
> +int ft_system_setup(void *blob, struct bd_info *bd)
> +{
> +	static const char * const cpu_node_names[] = {
> +		"cpu@0", "cpu@100", "cpu@200", "cpu@300",
> +		"cpu@400", "cpu@500", "cpu@600", "cpu@700",
> +	};
> +	u8 cpu_code[2], ip_state[3];
> +	int parent, node, i, ret;
> +	struct udevice *dev;
> +
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
> +		return -ENOSYS;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +	if (ret) {
> +		log_debug("Could not find otp device, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	log_debug("cpu-code: %02x %02x\n", cpu_code[0], cpu_code[1]);
> +
> +	/* skip on rk3588 */
> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x88)
> +		return 0;
> +
> +	ret = misc_read(dev, RK3588_OTP_IP_STATE_OFFSET, &ip_state, 3);
> +	if (ret < 0) {
> +		log_debug("Could not read ip-state, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	log_debug("ip-state: %02x %02x %02x\n",
> +		  ip_state[0], ip_state[1], ip_state[2]);
> +
> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x82) {
> +		/* policy: always disable gpu */
> +		ip_state[1] |= BAD_GPU;
> +
> +		/* policy: always disable one big core cluster */
> +		if (!(ip_state[0] & (BAD_CPU_CLUSTER1 | BAD_CPU_CLUSTER2)))
> +			ip_state[0] |= BAD_CPU_CLUSTER2;
> +	}
> +
> +	if (ip_state[0] & BAD_CPU_CLUSTER1) {
> +		/* fail entire cluster when one or more core is bad */
> +		ip_state[0] |= BAD_CPU_CLUSTER1;
> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster1");
> +	}
> +
> +	if (ip_state[0] & BAD_CPU_CLUSTER2) {
> +		/* fail entire cluster when one or more core is bad */
> +		ip_state[0] |= BAD_CPU_CLUSTER2;
> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
> +	} else if (ip_state[0] & BAD_CPU_CLUSTER1) {
> +		/* cluster nodes must be named in a continuous series */
> +		fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
> +	}
> +
> +	/* gpu: ip_state[1]: bit1~4 */
> +	if (ip_state[1] & BAD_GPU) {
> +		log_debug("fail gpu\n");
> +		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");
> +	}
> +
> +	parent = fdt_path_offset(blob, "/cpus");
> +	if (parent < 0) {
> +		log_debug("Could not find /cpus, parent=%d\n", parent);
> +		return 0;
> +	}
> +
> +	/* cpu: ip_state[0]: bit0~7 */
> +	for (i = 0; i < 8; i++) {
> +		/* fail any bad cpu core */
> +		if (!(ip_state[0] & BIT(i)))
> +			continue;
> +
> +		node = fdt_subnode_offset(blob, parent, cpu_node_names[i]);
> +		if (node >= 0) {
> +			log_debug("fail cpu %s\n", cpu_node_names[i]);
> +			fdt_status_fail(blob, node);
> +		} else {
> +			log_debug("Could not find %s, node=%d\n",
> +				  cpu_node_names[i], node);
> +		}
> +	}
> +
> +	return 0;
> +}
> +#endif
