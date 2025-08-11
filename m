Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71079CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 17:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B75A82D32;
	Mon, 11 Aug 2025 19:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="b1jON0W2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFE7831D5; Mon, 11 Aug 2025 19:46:39 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B34F82B20
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 19:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cf87=2Y=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754934395;
 bh=kcmCbpjc0dawhYHiBWWG58s3NO5SeMNdOr6hoPq45OU=;
 b=b1jON0W2SKFxLK8j4Py/+Akiw8QMaFjxtYgLNPvK8ayGz5zg43MN1+0aAhQxbGV+sW7gNVBwB
 3IZtZvKWJAkrLHidR3Ec9LWgLpBiO6FKRnvmOvhexu+S1F9z4tgsRcLbLCZ/tQuUEvNrfwX4/oB
 wCdOkT1B+7/vWWl2M4HEXQHdgnIs656orQ3xNGTPP8Bomnd+hGhlq3fnxpdGyY0zV4zJrAQZlb8
 alQu+Z4nGJtunvrGwM1KYenIj9+qpzrEIKn7GEc71AUwid9U7HUHGiVtLjJGoIU46zogGQbiio8
 ZEN0zT4HNal/cxuiKLdeDcAf7WygFkRb50+AYRSR3Rlg==
X-Forward-Email-ID: 689a2c4170d2d7c14f67454a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <31f8ec7f-66e6-4761-9c9f-7252833f44ad@kwiboo.se>
Date: Mon, 11 Aug 2025 19:45:33 +0200
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
 <8e9607db-2186-4d45-a713-8d215e200208@kwiboo.se>
 <a0f4e533-9255-43c7-be25-9953d3585425@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a0f4e533-9255-43c7-be25-9953d3585425@cherry.de>
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

On 8/11/2025 6:58 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/11/25 6:36 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 8/11/2025 2:11 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 8/4/25 8:16 PM, Jonas Karlman wrote:
> [...]
>>>> +		/* policy: always fail one rkvdec core on rk3583 */
>>>> +		if (!(ip_state[1] & (FAIL_RKVDEC0 | FAIL_RKVDEC1)))
>>>
>>> You could want to only check FAIL_RKVDEC0 as FAIL_RKVDEC1 is a bit (and
>>> not a bitfield so we don't need to set the whole bitfield in the event
>>> it's only partially set like for CPU clusters). No strong opinion.
>>
>> Main reason for this is to keep all policy logic more consistent.
>>
> 
> Fair enough.
> 
>>>
>>>> +			ip_state[1] |= FAIL_RKVDEC1;
>>>> +	}
>>>> +
>>>> +	/* policy: always fail one rkvenc core on rk3582/rk3583 */
>>>> +	if (!(ip_state[2] & (FAIL_RKVENC0 | FAIL_RKVENC1)))
>>>> +		ip_state[2] |= FAIL_RKVENC1;
>>>> +
>>>> +	log_debug("ip-state: %02x %02x %02x (policy)\n",
>>>> +		  ip_state[0], ip_state[1], ip_state[2]);
>>>> +
>>>> +	/* cpu cluster1: ip_state[0]: bit4~5 */
>>>> +	if ((ip_state[0] & FAIL_CPU_CLUSTER1) == FAIL_CPU_CLUSTER1) {
>>>
>>> No need for the == FAIL_CPU_CLUSTER1 check as you'll have set the whole
>>> bitfield earlier even if only one is set in the original ip_state from
>>> the register. No strong opinion.
>>
>> Main reason for keeping this is that if you comment out the policy part
>> above, you could end up with a single core removed, so this extra check
> 
> No you cannot at this point in the code :)
> 
> Earlier you do:
> 
> +	/* policy: fail entire big core cluster when one or more core is bad */
> +	if (ip_state[0] & FAIL_CPU_CLUSTER1)
> +		ip_state[0] |= FAIL_CPU_CLUSTER1;
> 
> This means that all bits in FAIL_CPU_CLUSTER1 bitfield are set if one is 
> set.
> 
> This means that if you check
> 
> + if (ip_state[0] & FAIL_CPU_CLUSTER1)
> 
> later on in the code, necessarily if it matches it means all CPUs are 
> disabled in the cluster.
> 
> The only benefit is if you are anticipating removing this policy in the 
> future where then the cpu-map shouldn't be removed if not all cores 
> aren't failed. As it is today, it is not a necessary check (but I guess 
> it doesn't hurt, so keep it if you feel more comfortable with it, this 
> is really just me nitpicking).

The main reason is that end-users may want to remove the policy and just
disable the cores that are marked as bad and not the entire cluster.

E.g. for my personal builds I will be able to just remove or comment out
the policy part above, or if there is a policy change in the future the
removal part will handle such cases without having to be also changed.

On my RK3582 boards there is typically only one single bad core in cpu,
vdec or venc. To get most out of the SoC I may want to skip the policy
to run all working cores without too much code modification ;-)

> 
> [...]
>>>> +	parent = fdt_path_offset(blob, "/cpus");
>>>> +	if (parent < 0) {
>>>> +		log_err("Could not find /cpus, parent=%d\n", parent);
>>>> +		return parent;
>>>> +	}
>>>> +
>>>> +	/* cpu: ip_state[0]: bit0~7 */
>>>> +	for (i = 0; i < 8; i++) {
>>>> +		/* fail any bad cpu core */
>>>> +		if (!(ip_state[0] & BIT(i)))
>>>> +			continue;
>>>> +
>>>> +		node = fdt_subnode_offset(blob, parent, cpu_node_names[i]);
>>>> +		if (node >= 0) {
>>>> +			log_debug("fail cpu %s\n", cpu_node_names[i]);
>>>> +			fdt_status_fail(blob, node);
>>>> +		} else {
>>>> +			log_err("Could not find %s, node=%d\n",
>>>> +				cpu_node_names[i], node);
>>>> +			return node;
>>>> +		}
>>>> +	}
>>>
>>> I would move this closer to the renaming/removing of cpu-map. No strong
>>> opinion though.
>>
>> Sounds good, I think this is just leftover from thinking we should
>> continue to load Linux in case of an error, and just trying to fail as
>> much as possible before there is a chance of an early return.
>>
>>>
>>> I'm wondering why you aren't using a direct path like for other
>>> controllers, e.g. fdt_status_fail_by_pathf(blob, cpu_node_names[i]) by
>>> simply prefixing each node_name with /cpus/ ?
>>
>> Good question, I think it may initially have been that I updated the
>> ppi-partitions affinity using phandles to the cpu nodes. However, that
>> part was removed before sending this out, will rework this for a v4.
>>
> 
> Then you would be matching the same workflow as other removals earlier 
> in the code and won't have to mind about the return-early scenario you 
> were concerned about just above.
> 
>>>
>>>> +
>>>> +	node = fdt_path_offset(blob, "/");
>>>> +	if (node < 0) {
>>>> +		log_err("Could not find /, node=%d\n", node);
>>>> +		return node;
>>>> +	}
>>>> +
>>>> +	snprintf(soc_comp, sizeof(soc_comp), "rockchip,rk35%x", cpu_code[1]);
>>>> +
>>>> +	for (i = 0, comp_len = 0;
>>>> +	     (comp = fdt_stringlist_get(blob, node, "compatible", i, &len));
>>>> +	     i++) {
>>>> +		/* stop at soc compatible */
>>>> +		if (!strcmp(comp, soc_comp) ||
>>>> +		    !strcmp(comp, "rockchip,rk3588s") ||
>>>> +		    !strcmp(comp, "rockchip,rk3588"))
>>>> +			break;
>>>> +
>>>> +		log_debug("compatible[%d]: %s\n", i, comp);
>>>> +		comp_len += len + 1;
>>>> +	}
>>>> +
>>>
>>> If it happens that none of the expected strings are found in the
>>> compatible property, we should probably return early.
>>
>> If none of them is found this logic will just try to append the two
>> compatibles at the end of any existing compatible. Should be safe?
>>
> 
> Mmmmmm, you're right, it should be fine I think, but maybe we don't want 
> to add rockchip,rk3588s if the DT only has e.g. myvendor,rk3582-myboard?
> 
>> The four main scenarios I try to anticipate is:
>> - rk3582 boards: <board>, rockchip,rk3582, rockchip,rk3588s (do nothing)
> 
> This you aren't doing at the moment, maybe we should return early if 
> soc_comp is found in the compatible list?

Yes, will fix this for v4.

> 
>> - rk3588s boards: <board>, rockchip,rk3588s (inject)
>> - rk3588-generic: rockchip,rk3588 (replace)
>> - other: <board>, <wrong soc> (append)
>>
>>>
>>>> +	/* truncate to only include board compatible */
>>>> +	fdt_setprop_placeholder(blob, node, "compatible", comp_len, &data);
>>>> +
>>>> +	/* append soc compatible */
>>>> +	fdt_appendprop_string(blob, node, "compatible", soc_comp);
>>>> +	fdt_appendprop_string(blob, node, "compatible", "rockchip,rk3588s");
>>>
>>> I would rather insert rk3582/rk3583 before the rk3588/rk3588s and keep
>>> the rest untouched instead of truncating to rockchip,rk3588/rk3588s and
>>> then adding rockchip,rk3588s back only.
>>
>> That is what this is trying to do without having to add too complex code.
>>
>> We can only replace the full nil separated string array, and adding
>> logic to re-construct a single working string became too complex. We
>> already had helper functions that could be used even if they are a
>> little bit inefficient by causing three fdt prop value replace.
>>
>> The truncating changes the string length to where first (or none) soc
>> compatible is found to then insert correct soc compatible.
>>
> 
> Yes, but if downstream decides to do
> 
> rockchip,rk3582, rockchip,rk3588s, <board>
> 
> We are screwed :) as we'll return only the first two. Does the user not 
> following the spec deserve to have their DT broken? Maybe /me shrugs

I guess we could relax the logic to return early if rockchip,rk3582
already exists and only truncate and append if rockchip,rk3588s or
rockchip,rk3588 is found last, will try something like that for v4.

> 
>>> I wouldn't want my device tree
>>> to be modified too much and we don't know what we'll get from downstream
>>> )I'm not necessarily talking about Rockchip's vendor kernel here) DTBs
>>> for example, so truncating doesn't seem to be the best plan? What do you
>>> think?
>>
>> We could possible make this very simple by just appending soc compatible
>> when it is missing and not care about the compatible order.
>>
>> My intention was to ensure that we always end up with:
>>
>>    <board>, [<...>, *] rockchip,rk3582, rockchip,rk3588s
>>
>> With a simplified append it may instead end up as:
>>
>>    <board>, [<...>, *] rockchip,rk3588s, rockchip,rk3582
>>
>> Does the order matter or should I just drop all this and replace with
>> something simple like:
>>
>>    ret = fdt_stringlist_search(blob, node, "compatible", soc_comp);
>>    if (ret == -FDT_ERR_NOTFOUND)
>>    	fdt_appendprop_string(blob, node, "compatible", soc_comp);
>>
> 
> 
> Nope, this doesn't follow the DT spec then:

Agree, and I think that the "radxa,e52c", "rockchip,rk3582",
"rockchip,rk3588s" already defined the proper order we should use.

Regards,
Jonas

> 
> """
>   The property
> value consists of a concatenated list of null terminated strings, from 
> most specific to most general.
> """
> 
> though this is said for the "compatible" property of a device node. For 
> the root node the following is said:
> 
> """
> Specifies a list of platform architectures with
> which this platform is compatible. This prop-
> erty can be used by operating systems in select-
> ing platform specific code. The recommended
> form of the property value is:
> "manufacturer,model"
> """
> 
> c.f. 
> https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf
> 
> Cheers,
> Quentin

