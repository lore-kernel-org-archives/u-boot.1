Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E602E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 15:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56055800C2;
	Fri, 13 Dec 2024 16:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="boqDvW+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AEA5800D6; Fri, 13 Dec 2024 16:20:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2CD4800C1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 16:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6390=TH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1734103226;
 bh=CR05AuCK1VKe8YAD6xwNeiuzue+8rFQfH7TWgeZXuCQ=;
 b=boqDvW+OBWxDMAjjceqcs1b8xwXeA+KeJ/ZDDgh4CNTjiEJY6sch02KBAdgp6gNHSuHlA7bMP
 w6j2HMNR17C47MFogEsCoRkwZ18YIdi/hhlH5Xp/0mir7IfVaYEygv5BOLfgd7MdLQSw2o9jDLD
 R2uqYY1ODErAWK0MQYolAzVVJR4S4OjY+cx1EK17puMnhg16fJp2B6OphXEo7gDcaA3uVbJhfQt
 sCqei35K+qfvaptTc5nJlKUO4lDy2PTWrxDHGYFbM1gxM1A3eOFUXYGhZVJKnMALUYQgJ1F6QBN
 5FVnl1MPXkFllMyOdg/4wgeIbvKsE5G1sduhg+SpfKYg==
Message-ID: <223d5d07-bc97-420c-810f-bbf967ec5af7@kwiboo.se>
Date: Fri, 13 Dec 2024 16:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: Add initial RK3582 support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
 <20241210222341.3537543-2-jonas@kwiboo.se>
 <e10f729d-cc77-41ba-b165-e32f6e058422@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e10f729d-cc77-41ba-b165-e32f6e058422@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675c50b896abc14790b84f7d
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

Hi Quentin,

On 2024-12-13 14:43, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 12/10/24 11:23 PM, Jonas Karlman wrote:
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
> 
> Do you have information about what;s in the third byte? It's not used in 
> this patch series for example, so wondering if it really makes sense to 
> read it and dump it?

To my knowledge information about rkvenc is stored in the third byte.

Vendor U-Boot [1] lists following:
- ip_state[0]: bit0~7 - cpu_mask
- ip_state[2]: bit0,2 - rkvenc_mask
- ip_state[1]: bit6,7 - rkvdec_mask
- ip_state[1]: bit1~4 - gpu_mask

However, vendor U-Boot also #if out the entire gpu_mask so not fully
sure if that is correct or even filled in.

[1] https://github.com/rockchip-linux/u-boot/blob/next-dev/arch/arm/mach-rockchip/rk3588/rk3588.c#L1393-L1404

> 
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
> 
> That's a very interesting choice, wondering what's prompted this 
> decision (which I assume comes from vendor tree :) ).

Not sure myself, my rk3582 boards only have a single rkvdec, kkvenc or
cpu core marked as bad, have not seen any board with multiple cores
marked as bad.

I did a simple tests with only disable the exact cores that was marked
as bad on the board with a bad cpu core and left all 8 cores enabled on
the other boards and that seem to run fine.

Could be related to marketing or thermal, the policy was copied from
vendor as-is.

> 
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
> 
> Nitpick on readability (to me at least, matter of a taste :) )
> 
> Could suggest:
> 
> if (ip_state[0] & BAD_CPU_CLUSTER1) {
>      /* cluster nodes must be named in a continuous series */
>      fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
> 
>      if (!(ip_state[0] & BAD_CPU_CLUSTER2))
>          /* cluster nodes must be named in a continuous series */
>          fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
> }
> 
> if (ip_state[0] & BAD_CPU_CLUSTER2) {
>      /* fail entire cluster when one or more core is bad */
>      ip_state[0] |= BAD_CPU_CLUSTER2;
>      fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
> }

Main reason for separation with above rk3582 policy handling was because
I added the rk3582 policy last second, and it also made it possible to
easily remove the entire cpu_code == 3582 block if one wants to use all
cores not marked as bad.

Also in the vendor U-Boot there is a mention and different policy for a
RK3583 variant, so current separation may be preferred but will try to
add some comments in a v2.

> 
> For CPU clusters, it seems the bitmask matches how many cores there are 
> in a cluster. Right now we are removing the whole cluster even if only 
> one core in the cluster is broken. But I see later that we only disable 
> the cores marked as bad. The dt-binding says clusters are for one or 
> more cores, so maybe we are too eager here to remove a cluster even if 
> not all cores in the cluster are broken? Do you know what are the 
> possible side effects of removing a cluster but still having one of its 
> cores enabled in DT?

The code do ip_state[0] |= BAD_CPU_CLUSTER2 when one of the cores in
cluster 2 is marked as bad, so both cores will be marked as failed.

Howerver, the code should probably just remove the cluster if both cores
are bad, should make it easier if one want to test without any of the
policy. Will try to re-work this a little bit to make it more readable
and easy to just comment out any of the policy lines.

> 
>> +	/* gpu: ip_state[1]: bit1~4 */
>> +	if (ip_state[1] & BAD_GPU) {
>> +		log_debug("fail gpu\n");
>> +		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");
>> +	}
>> +
> 
> Here I'm a bit perplexed. We don't define multiple cores in the GPU node 
> on Linux kernel IIRC. I have not a single clue why the bitmask for the 
> GPU is 3 bits, do you have any idea or information?

The gpu_mask in vendor tree is not used and the gpu is instead always
disabled for RK3582, and left enabled for RK3583.

Was not sure if we should try to use the ip-state values or just, so I
went with a similar approach as for cpu cores, fill all bits in policy
part and check for any bit in the fail part.

> 
>> +	parent = fdt_path_offset(blob, "/cpus");
>> +	if (parent < 0) {
>> +		log_debug("Could not find /cpus, parent=%d\n", parent);
> 
> Any reason for not making this an error message? Are we expecting this 
> code path to be hit in "normal" behavior?

I do not think it should be possible, maybe only if the code where to
run on the xPL control FDT.

The return 0 is probably just something left from the early code I
tested where it just printed what should happen. Will check what happen
if we return an error here and adjust for v2.

> 
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
> 
> Any particular reason for making this a debug message rather than an 
> error message?

This and the /cpus debug messages was added last second before sending
this out :-), will change to error messages in v2.

Regards,
Jonas

> 
> Cheers,
> Quentin

