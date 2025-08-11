Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9914FCA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BFC831E1;
	Mon, 11 Aug 2025 18:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="eyqGIaUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B87831E4; Mon, 11 Aug 2025 18:37:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6573D82B07
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cf87=2Y=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754930261;
 bh=+IjSqwYQDHt1oALOH98wh/piwGa3CMni9+X0fxI0/w4=;
 b=eyqGIaULGsBdvml9yLrHOY+cAViwKFxnGEZHmTf9xZG9xqJeN000cUmUNrju46zghIcrj3am9
 L2os3sJSOTIQnj14ChwgrNNE8DUcBxMNTi8HnLDWd0KS/ZTOCokvMYibOu414qC05I2utQYMVLH
 KOMZpwoRkZ7WkcvYMw7Ui+8a+m6F9KaI38Y+uZxXi5IHObCl34GGqxwW/YHtmZKZGPZ3Y6w2YX2
 1XhpLnq7r44MPFhTVXDzBnWAZ6dTvtghcWKGed2YAwrsoZf/I/rtpbV23Z5crrApAn+EPUXi8Lf
 Oc9wa3zyhxDWhFc28iqQ57xglM18SL78ws4Lso18D0eA==
X-Forward-Email-ID: 689a1c2270d2d7c14f6729c6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8e9607db-2186-4d45-a713-8d215e200208@kwiboo.se>
Date: Mon, 11 Aug 2025 18:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: Add initial RK3582 support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250804181638.3855760-1-jonas@kwiboo.se>
 <20250804181638.3855760-2-jonas@kwiboo.se>
 <334d11b4-20c2-4367-9b3d-9720b2209dcc@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <334d11b4-20c2-4367-9b3d-9720b2209dcc@cherry.de>
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

Hi Quentin,

On 8/11/2025 2:11 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/25 8:16 PM, Jonas Karlman wrote:
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
>> Changes in v2:
>> - Refactor code to first apply policy to ip-state and then fail cores
>>    based on the updated ip-state
>> - Add support for failing rkvdec and rkvenc cores
>> - Append soc compatible to board model
>> - Not picking up t-b tag due to significant changes to patch
>> ---
>>   arch/arm/mach-rockchip/rk3588/rk3588.c | 221 +++++++++++++++++++++++++
>>   1 file changed, 221 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>> index c01a40020896..3ab0afe0979e 100644
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
>> @@ -200,6 +201,16 @@ int arch_cpu_init(void)
>>   
>>   #define RK3588_OTP_CPU_CODE_OFFSET		0x02
>>   #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
>> +#define RK3588_OTP_IP_STATE_OFFSET		0x1d
>> +
>> +#define FAIL_CPU_CLUSTER0		GENMASK(3, 0)
>> +#define FAIL_CPU_CLUSTER1		GENMASK(5, 4)
>> +#define FAIL_CPU_CLUSTER2		GENMASK(7, 6)
>> +#define FAIL_GPU				GENMASK(4, 1)
>> +#define FAIL_RKVDEC0			BIT(6)
>> +#define FAIL_RKVDEC1			BIT(7)
>> +#define FAIL_RKVENC0			BIT(0)
>> +#define FAIL_RKVENC1			BIT(2)
>>   
>>   int checkboard(void)
>>   {
>> @@ -245,3 +256,213 @@ int checkboard(void)
>>   
>>   	return 0;
>>   }
>> +
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
> 
> 
> Wondering if this shouldn't be something to add to the fdt "subsystem"?
> 
> With tests and all?

I have no idea if there is any other use for these functions, only
wanted to simplify the code below as much as possible.

> 
>> +/*
>> + * RK3582 is a variant of the RK3588S with some IP blocks disabled. What blocks
>> + * are disabled/non-working is indicated by ip-state in OTP. ft_system_setup()
>> + * is used to mark any cpu and/or gpu node with status=fail as indicated by
>> + * ip-state. Apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
>> + * cores and the gpu is always failed/disabled. Enable OF_SYSTEM_SETUP to make
>> + * use of the required DT fixups for RK3582 board variants.
>> + */
>> +int ft_system_setup(void *blob, struct bd_info *bd)
>> +{
>> +	static const char * const cpu_node_names[] = {
>> +		"cpu@0", "cpu@100", "cpu@200", "cpu@300",
>> +		"cpu@400", "cpu@500", "cpu@600", "cpu@700",
>> +	};
>> +	int parent, node, i, comp_len, len, ret;
>> +	bool cluster1_removed = false;
>> +	u8 cpu_code[2], ip_state[3];
>> +	struct udevice *dev;
>> +	char soc_comp[16];
>> +	const char *comp;
>> +	void *data;
>> +
>> +	if (!IS_ENABLED(CONFIG_OF_SYSTEM_SETUP))
>> +		return 0;
>> +
>> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
> 
> Mmmmm we should probably think about adding xPL symbols for 
> ROCKCHIP_OTP. No required for this patch as we already have code doing 
> that same check.

Agree, both ROCKCHIP_OTP and ROCKCHIP_EFUSE could have use for xPL
variants, something for a different series.

> 
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
>> +	/* only fail devices on rk3582/rk3583 */
>> +	if (!(cpu_code[0] == 0x35 && cpu_code[1] == 0x82) &&
>> +	    !(cpu_code[0] == 0x35 && cpu_code[1] == 0x83))
>> +		return 0;
>> +
>> +	ret = misc_read(dev, RK3588_OTP_IP_STATE_OFFSET, &ip_state, 3);
>> +	if (ret < 0) {
>> +		log_err("Could not read ip-state, ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	log_debug("ip-state: %02x %02x %02x (otp)\n",
>> +		  ip_state[0], ip_state[1], ip_state[2]);
>> +
>> +	/* policy: fail entire big core cluster when one or more core is bad */
>> +	if (ip_state[0] & FAIL_CPU_CLUSTER1)
>> +		ip_state[0] |= FAIL_CPU_CLUSTER1;
>> +	if (ip_state[0] & FAIL_CPU_CLUSTER2)
>> +		ip_state[0] |= FAIL_CPU_CLUSTER2;
>> +
>> +	/* policy: always fail one big core cluster on rk3582/rk3583 */
>> +	if (!(ip_state[0] & (FAIL_CPU_CLUSTER1 | FAIL_CPU_CLUSTER2)))
>> +		ip_state[0] |= FAIL_CPU_CLUSTER2;
>> +
>> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x82) {
>> +		/* policy: always fail gpu on rk3582 */
>> +		ip_state[1] |= FAIL_GPU;
>> +
>> +		/* policy: always fail rkvdec on rk3582 */
>> +		ip_state[1] |= FAIL_RKVDEC0 | FAIL_RKVDEC1;
>> +	} else if (cpu_code[0] == 0x35 && cpu_code[1] == 0x83) {
> 
> Technically, we could have a simple else here as the code path before 
> the if is guaranteed to only be reached in two cases, 0x8235 and 0x8335, 
> so if you test the former and it doesn't match, it's necessarily the 
> latter. No strong opinion.

I sent a v3 of this series yesterday where both the rk3582 and rk3583
policy have been merged into a single policy to match upstream commit
from linux-6.1-stan-rkr6, so this has already been changed.

https://github.com/Kwiboo/u-boot-rockchip/commit/5566d7d920d20932d2188c0cec57cb9036a9eefd

> 
>> +		/* policy: always fail one rkvdec core on rk3583 */
>> +		if (!(ip_state[1] & (FAIL_RKVDEC0 | FAIL_RKVDEC1)))
> 
> You could want to only check FAIL_RKVDEC0 as FAIL_RKVDEC1 is a bit (and 
> not a bitfield so we don't need to set the whole bitfield in the event 
> it's only partially set like for CPU clusters). No strong opinion.

Main reason for this is to keep all policy logic more consistent.

> 
>> +			ip_state[1] |= FAIL_RKVDEC1;
>> +	}
>> +
>> +	/* policy: always fail one rkvenc core on rk3582/rk3583 */
>> +	if (!(ip_state[2] & (FAIL_RKVENC0 | FAIL_RKVENC1)))
>> +		ip_state[2] |= FAIL_RKVENC1;
>> +
>> +	log_debug("ip-state: %02x %02x %02x (policy)\n",
>> +		  ip_state[0], ip_state[1], ip_state[2]);
>> +
>> +	/* cpu cluster1: ip_state[0]: bit4~5 */
>> +	if ((ip_state[0] & FAIL_CPU_CLUSTER1) == FAIL_CPU_CLUSTER1) {
> 
> No need for the == FAIL_CPU_CLUSTER1 check as you'll have set the whole 
> bitfield earlier even if only one is set in the original ip_state from 
> the register. No strong opinion.

Main reason for keeping this is that if you comment out the policy part
above, you could end up with a single core removed, so this extra check
ensure that we only remove the cpu-map node when all cores in the
cluster will be marked as fail.

> 
>> +		log_debug("remove cpu-map cluster1\n");
>> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster1");
>> +		cluster1_removed = true;
>> +	}
>> +
>> +	/* cpu cluster2: ip_state[0]: bit6~7 */
>> +	if ((ip_state[0] & FAIL_CPU_CLUSTER2) == FAIL_CPU_CLUSTER2) {
> 
> Ditto. No strong opinion.
> 
>> +		log_debug("remove cpu-map cluster2\n");
>> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
>> +	} else if (cluster1_removed) {
>> +		/* cluster nodes must be named in a continuous series */
>> +		log_debug("rename cpu-map cluster2\n");
>> +		fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
>> +	}
>> +
>> +	/* gpu: ip_state[1]: bit1~4 */
>> +	if (ip_state[1] & FAIL_GPU) {
>> +		log_debug("fail gpu\n");
>> +		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");
>> +	}
>> +
>> +	/* rkvdec: ip_state[1]: bit6,7 */
>> +	if (ip_state[1] & FAIL_RKVDEC0) {
>> +		log_debug("fail rkvdec0\n");
>> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdc38000");
>> +		fdt_status_fail_by_pathf(blob, "/iommu@fdc38700");
>> +	}
>> +	if (ip_state[1] & FAIL_RKVDEC1) {
>> +		log_debug("fail rkvdec1\n");
>> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdc40000");
>> +		fdt_status_fail_by_pathf(blob, "/iommu@fdc40700");
>> +	}
>> +
>> +	/* rkvenc: ip_state[2]: bit0,2 */
>> +	if (ip_state[2] & FAIL_RKVENC0) {
>> +		log_debug("fail rkvenc0\n");
>> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdbd0000");
>> +		fdt_status_fail_by_pathf(blob, "/iommu@fdbdf000");
>> +	}
>> +	if (ip_state[2] & FAIL_RKVENC1) {
>> +		log_debug("fail rkvenc1\n");
>> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdbe0000");
>> +		fdt_status_fail_by_pathf(blob, "/iommu@fdbef000");
>> +	}
>> +
>> +	parent = fdt_path_offset(blob, "/cpus");
>> +	if (parent < 0) {
>> +		log_err("Could not find /cpus, parent=%d\n", parent);
>> +		return parent;
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
>> +			log_err("Could not find %s, node=%d\n",
>> +				cpu_node_names[i], node);
>> +			return node;
>> +		}
>> +	}
> 
> I would move this closer to the renaming/removing of cpu-map. No strong 
> opinion though.

Sounds good, I think this is just leftover from thinking we should
continue to load Linux in case of an error, and just trying to fail as
much as possible before there is a chance of an early return.

> 
> I'm wondering why you aren't using a direct path like for other 
> controllers, e.g. fdt_status_fail_by_pathf(blob, cpu_node_names[i]) by 
> simply prefixing each node_name with /cpus/ ?

Good question, I think it may initially have been that I updated the
ppi-partitions affinity using phandles to the cpu nodes. However, that
part was removed before sending this out, will rework this for a v4.

> 
>> +
>> +	node = fdt_path_offset(blob, "/");
>> +	if (node < 0) {
>> +		log_err("Could not find /, node=%d\n", node);
>> +		return node;
>> +	}
>> +
>> +	snprintf(soc_comp, sizeof(soc_comp), "rockchip,rk35%x", cpu_code[1]);
>> +
>> +	for (i = 0, comp_len = 0;
>> +	     (comp = fdt_stringlist_get(blob, node, "compatible", i, &len));
>> +	     i++) {
>> +		/* stop at soc compatible */
>> +		if (!strcmp(comp, soc_comp) ||
>> +		    !strcmp(comp, "rockchip,rk3588s") ||
>> +		    !strcmp(comp, "rockchip,rk3588"))
>> +			break;
>> +
>> +		log_debug("compatible[%d]: %s\n", i, comp);
>> +		comp_len += len + 1;
>> +	}
>> +
> 
> If it happens that none of the expected strings are found in the 
> compatible property, we should probably return early.

If none of them is found this logic will just try to append the two
compatibles at the end of any existing compatible. Should be safe?

The four main scenarios I try to anticipate is:
- rk3582 boards: <board>, rockchip,rk3582, rockchip,rk3588s (do nothing)
- rk3588s boards: <board>, rockchip,rk3588s (inject)
- rk3588-generic: rockchip,rk3588 (replace)
- other: <board>, <wrong soc> (append)

> 
>> +	/* truncate to only include board compatible */
>> +	fdt_setprop_placeholder(blob, node, "compatible", comp_len, &data);
>> +
>> +	/* append soc compatible */
>> +	fdt_appendprop_string(blob, node, "compatible", soc_comp);
>> +	fdt_appendprop_string(blob, node, "compatible", "rockchip,rk3588s");
> 
> I would rather insert rk3582/rk3583 before the rk3588/rk3588s and keep 
> the rest untouched instead of truncating to rockchip,rk3588/rk3588s and 
> then adding rockchip,rk3588s back only.

That is what this is trying to do without having to add too complex code.

We can only replace the full nil separated string array, and adding
logic to re-construct a single working string became too complex. We
already had helper functions that could be used even if they are a
little bit inefficient by causing three fdt prop value replace.

The truncating changes the string length to where first (or none) soc
compatible is found to then insert correct soc compatible.

> I wouldn't want my device tree 
> to be modified too much and we don't know what we'll get from downstream 
> )I'm not necessarily talking about Rockchip's vendor kernel here) DTBs 
> for example, so truncating doesn't seem to be the best plan? What do you 
> think?

We could possible make this very simple by just appending soc compatible
when it is missing and not care about the compatible order.

My intention was to ensure that we always end up with:

  <board>, [<...>, *] rockchip,rk3582, rockchip,rk3588s

With a simplified append it may instead end up as:

  <board>, [<...>, *] rockchip,rk3588s, rockchip,rk3582

Does the order matter or should I just drop all this and replace with
something simple like:

  ret = fdt_stringlist_search(blob, node, "compatible", soc_comp);
  if (ret == -FDT_ERR_NOTFOUND)
  	fdt_appendprop_string(blob, node, "compatible", soc_comp);

Regards,
Jonas

> 
> Logic-wise aside from the "compatible" changes, this seems fine. I do 
> not own any RK3582/RK3583 so cannot test this.
> 
> Cheers,
> Quentin

