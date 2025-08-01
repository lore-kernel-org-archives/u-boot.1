Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842C8C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 08:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B388398C;
	Fri,  1 Aug 2025 10:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bzme8HQH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCDB8399A; Fri,  1 Aug 2025 10:34:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D2C8396E
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 10:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab54=2N=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754037236;
 bh=Apx/FnnDUyNrNxZkONW92fBDq6UU0KaNUs783/Z6haA=;
 b=bzme8HQHbKngoHXTQvvG5d8f2VH+tMs/I/0jyLsCshF9lvkLfiFNJ+loqOsjY70WW7bHb4j2p
 3tgNnAYF3iFecnXqsx8xVRX0pUBQKuJ/WXfoZ6jXLiZzhBl5okeKx9dc9aSh/sP3NBKEi1uBgUp
 PonM4UrT0q+U2QyPHsoAZPXFuaEwLu2AS8DLzLtvvDLWwXSOTcGbJ9GEVEDkZCs8P8KkE6gx1kS
 3NGlH1hMaHjR2/fPsEzNQlKgUEND6KNLNgB6jOTm7lzziE0iyarn94VUgMWxsdibq/45gtWEZeV
 Z+4hlHFzcYEn513LiSJFQzeN28uQpngB1MXRY4SMwudg==
X-Forward-Email-ID: 688c7bf2264f6a311d1da6f8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <20463851-de24-401f-ba38-3f1a75d0dcc2@kwiboo.se>
Date: Fri, 1 Aug 2025 10:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: Add initial RK3582 support
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
 <20241210222341.3537543-2-jonas@kwiboo.se>
 <6BBD9F3806DE52F0+ad523568-eb38-424e-9833-c6ad2b7c5ca0@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6BBD9F3806DE52F0+ad523568-eb38-424e-9833-c6ad2b7c5ca0@radxa.com>
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

Hi,

On 8/1/2025 10:07 AM, FUKAUMI Naoki wrote:
> Hi Jonas,
> 
> Are there any remaining issues with this patch series?

If I remember correctly there was some remarks from Kever that we should
implement core blocking for decoders etc. With the DT decoder node-names
not being "correct" and me not getting any confirmation on the Linux ML
this got put on hold / low-priority for me.

I think the latest decoder nodes proposed on Linux ML from a few weeks
ago are now correct, so I should be able to pick this up again and send
a v2, will take a closer look later this weekend after re-spinning some
of my other series.

Regards,
Jonas

> 
> Best regards,
> 
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
> On 12/11/24 07:23, Jonas Karlman wrote:
>> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
>> What blocks are disabled/non-working is indicated by ip-state in OTP.
>>
>> This add initial support for RK3582 by using ft_system_setup() to mark
>> any cpu and/or gpu node with status=fail as indicated by ip-state.
>>
>> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
>> cores and the gpu is always failed/disabled.
>>
>> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
>> the required DT fixups for RK3582 board variants.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/rk3588/rk3588.c | 128 +++++++++++++++++++++++++
>>   1 file changed, 128 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> index c1dce3ee3703..06e6318312b2 100644
>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> @@ -7,6 +7,7 @@
>>   #define LOG_CATEGORY LOGC_ARCH
>>   
>>   #include <dm.h>
>> +#include <fdt_support.h>
>>   #include <misc.h>
>>   #include <spl.h>
>>   #include <asm/armv8/mmu.h>
>> @@ -185,6 +186,12 @@ int arch_cpu_init(void)
>>   
>>   #define RK3588_OTP_CPU_CODE_OFFSET		0x02
>>   #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
>> +#define RK3588_OTP_IP_STATE_OFFSET		0x1d
>> +
>> +#define BAD_CPU_CLUSTER0		GENMASK(3, 0)
>> +#define BAD_CPU_CLUSTER1		GENMASK(5, 4)
>> +#define BAD_CPU_CLUSTER2		GENMASK(7, 6)
>> +#define BAD_GPU				GENMASK(4, 1)
>>   
>>   int checkboard(void)
>>   {
>> @@ -230,3 +237,124 @@ int checkboard(void)
>>   
>>   	return 0;
>>   }
>> +
>> +#ifdef CONFIG_OF_SYSTEM_SETUP
>> +static int fdt_path_del_node(void *fdt, const char *path)
>> +{
>> +	int nodeoffset;
>> +
>> +	nodeoffset = fdt_path_offset(fdt, path);
>> +	if (nodeoffset < 0)
>> +		return nodeoffset;
>> +
>> +	return fdt_del_node(fdt, nodeoffset);
>> +}
>> +
>> +static int fdt_path_set_name(void *fdt, const char *path, const char *name)
>> +{
>> +	int nodeoffset;
>> +
>> +	nodeoffset = fdt_path_offset(fdt, path);
>> +	if (nodeoffset < 0)
>> +		return nodeoffset;
>> +
>> +	return fdt_set_name(fdt, nodeoffset, name);
>> +}
>> +
>> +int ft_system_setup(void *blob, struct bd_info *bd)
>> +{
>> +	static const char * const cpu_node_names[] = {
>> +		"cpu@0", "cpu@100", "cpu@200", "cpu@300",
>> +		"cpu@400", "cpu@500", "cpu@600", "cpu@700",
>> +	};
>> +	u8 cpu_code[2], ip_state[3];
>> +	int parent, node, i, ret;
>> +	struct udevice *dev;
>> +
>> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
>> +		return -ENOSYS;
>> +
>> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
>> +					  DM_DRIVER_GET(rockchip_otp), &dev);
>> +	if (ret) {
>> +		log_debug("Could not find otp device, ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
>> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
>> +	if (ret < 0) {
>> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	log_debug("cpu-code: %02x %02x\n", cpu_code[0], cpu_code[1]);
>> +
>> +	/* skip on rk3588 */
>> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x88)
>> +		return 0;
>> +
>> +	ret = misc_read(dev, RK3588_OTP_IP_STATE_OFFSET, &ip_state, 3);
>> +	if (ret < 0) {
>> +		log_debug("Could not read ip-state, ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	log_debug("ip-state: %02x %02x %02x\n",
>> +		  ip_state[0], ip_state[1], ip_state[2]);
>> +
>> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x82) {
>> +		/* policy: always disable gpu */
>> +		ip_state[1] |= BAD_GPU;
>> +
>> +		/* policy: always disable one big core cluster */
>> +		if (!(ip_state[0] & (BAD_CPU_CLUSTER1 | BAD_CPU_CLUSTER2)))
>> +			ip_state[0] |= BAD_CPU_CLUSTER2;
>> +	}
>> +
>> +	if (ip_state[0] & BAD_CPU_CLUSTER1) {
>> +		/* fail entire cluster when one or more core is bad */
>> +		ip_state[0] |= BAD_CPU_CLUSTER1;
>> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster1");
>> +	}
>> +
>> +	if (ip_state[0] & BAD_CPU_CLUSTER2) {
>> +		/* fail entire cluster when one or more core is bad */
>> +		ip_state[0] |= BAD_CPU_CLUSTER2;
>> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
>> +	} else if (ip_state[0] & BAD_CPU_CLUSTER1) {
>> +		/* cluster nodes must be named in a continuous series */
>> +		fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
>> +	}
>> +
>> +	/* gpu: ip_state[1]: bit1~4 */
>> +	if (ip_state[1] & BAD_GPU) {
>> +		log_debug("fail gpu\n");
>> +		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");
>> +	}
>> +
>> +	parent = fdt_path_offset(blob, "/cpus");
>> +	if (parent < 0) {
>> +		log_debug("Could not find /cpus, parent=%d\n", parent);
>> +		return 0;
>> +	}
>> +
>> +	/* cpu: ip_state[0]: bit0~7 */
>> +	for (i = 0; i < 8; i++) {
>> +		/* fail any bad cpu core */
>> +		if (!(ip_state[0] & BIT(i)))
>> +			continue;
>> +
>> +		node = fdt_subnode_offset(blob, parent, cpu_node_names[i]);
>> +		if (node >= 0) {
>> +			log_debug("fail cpu %s\n", cpu_node_names[i]);
>> +			fdt_status_fail(blob, node);
>> +		} else {
>> +			log_debug("Could not find %s, node=%d\n",
>> +				  cpu_node_names[i], node);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +#endif
> 
> 

