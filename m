Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACECC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 08:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 154978399A;
	Fri,  1 Aug 2025 10:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFCB839A8; Fri,  1 Aug 2025 10:08:08 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9D48398C
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 10:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip3t1754035664t4f80664b
X-QQ-Originating-IP: vxbrPFpIZI5jRV16L5/wQatvevOc04yqXp+W13J7wBA=
Received: from [IPV6:240f:10b:7440:1:603f:d22c ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 01 Aug 2025 16:07:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5408025396888937516
Message-ID: <6BBD9F3806DE52F0+ad523568-eb38-424e-9833-c6ad2b7c5ca0@radxa.com>
Date: Fri, 1 Aug 2025 17:07:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
 <20241210222341.3537543-2-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241210222341.3537543-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ODmRr9XAsEUIFSroNfEmeWqqN63xTinVXNjPQ+LzxbyoeVISSFJgYExM
 KFeFdRsA3zxJRuEFD4L7d4v2Cj43Iy3lpqW8NY7Utk9V2YkBifQuTScrZBRy+pf5exm4OeU
 x/JDXoUI+zdbRO+wWOk2MnQps5q6dIH0EkhsI9oqedWJbHjoPvMAMPFisyPbZugVUz20uzw
 LCwP4LkyV5sz09k5N5A6wT+mz9ghWmpNoXJ04i1di9Llpkm1/jkXvF4WVkLofmsrqGvEFZb
 I8RyMBkRnpHnJ+BbKrFm+aA50knAA0p0za+fkqKGUeeDnmssLoq7zdJ4SKSjP5N3sp5SbA1
 jZ5Q9jO9t2xmBdbTJ1RzWwvDTTuY+RAAXoc1Y8LCg+bC0IqZHJfGc5EKkJCpnaWco0skoF4
 ep+IfVfPklkUFtbhr6vviLas+FGNsMk2Z6WqOv9UcO3bOkmjw/QOQ8AjLIH86uPWly+KRt8
 Usx+RPy0kULJtUSfUVQCwLRF/5/ariVH9w/3Lp634ABmn24lfQR+MJjOiDED4X9MsdyDCrJ
 u96hRZPz1y3WvgDUOHjGIepD5+3yER5cwBQ2l1GIAY32UP0SW+U22B5i1VLfRckzj45bZZq
 0jKgTUN7X7d2ZAeokXz7AuzglA41ROULLTMy9tqS6XCaBRdXnzvPmed/utx9rOM3C4PrS1o
 jZcaizNe0m0iEPxP3FXW+XkTe5TRzkTsboRdt0Vduvr+et8o1DY5ic3G0lY3etK95+sqoZc
 8xwEoY/z+2khvLaKiLaOviVhoLNNnjegBz1O863/ydkF2iU1kbAzj+qCJ6SFVFKkU8z4pFS
 8KxF+sVAEUI0OTtusVovzFJ2LGcydJKc8RUGa+RPG+DOnnRbhI1ppXFFugb4blksOhiHOHs
 7sKkx8mIl/pgRH6P9O1qwEbt1xjbJbqC4NLFnrxgnZC2cTPR22dFlhhKWtPyz2tGJLCN8ao
 7O8hri4UuuhI4DA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
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

Are there any remaining issues with this patch series?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 12/11/24 07:23, Jonas Karlman wrote:
> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
> What blocks are disabled/non-working is indicated by ip-state in OTP.
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


