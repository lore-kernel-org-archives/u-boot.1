Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD37D60074
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 07:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE1789514;
	Tue, 19 Nov 2024 08:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hZlVNQua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FDB89503; Tue, 19 Nov 2024 08:32:30 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2744089519
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 08:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ7WQ36122252;
 Tue, 19 Nov 2024 01:32:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732001546;
 bh=Bwo/qfxAFpU4G0CO2WRQxIGu/r3DBe9plZUPrXM4fRQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hZlVNQuaCmgHCdjivVkFfRRHpVgH27R8b+G7LjzHtCHP8NTmPmXZamdWUt9vvpey8
 tfMYwL0n5ylp6BIC8dz8jRGkFSBMfd4BERGp3euBFVp6SucCmP3N59B7rnEXj9SKKB
 tcopBLFYWbn3lkuHB62fAW9tbyrbYgWA5Q4b+yFs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ7WQBN028102
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Nov 2024 01:32:26 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Nov 2024 01:32:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Nov 2024 01:32:26 -0600
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ7WNwQ064384;
 Tue, 19 Nov 2024 01:32:24 -0600
Message-ID: <cb780efa-ef28-49ea-9009-86424390d136@ti.com>
Date: Tue, 19 Nov 2024 13:02:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] arm: mach-k3: j721e-init.c: Add support for
 CONFIG_K3_OPP_LOW
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>, <n-francis@ti.com>
References: <20241119003617.1871183-1-a-limaye@ti.com>
 <20241119003617.1871183-5-a-limaye@ti.com>
 <20241119061214.gcruepd4yimqgz2p@uda0497581>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20241119061214.gcruepd4yimqgz2p@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Manorit,

On 19/11/24 11:42, Manorit Chawdhry wrote:
> Hi Aniket,
> 
> On 06:02-20241119, Aniket Limaye wrote:
>> The default j7200 devicetree and k3_avs driver set 2GHz/1GHz frequency
>> for A72/MSMC clks and the OPP_NOM voltage.
>>
>> J7200 SOCs may support OPP_LOW Operating Performance Point:
>> 1GHz/500MHz clks for A72/MSMC and OPP_LOW AVS voltage read from efuse.
>>
>> Hence, add a config check in board_init_f() to select OPP_LOW specs:
>> - Check if OPP_LOW AVS voltage read from efuse is valid.
>> - Use the device IDs and clock IDs (TISCI docs [0]) to find the A72 and
>>    MSMC clock frequencies in the devicetree.
>> - Fixup the clock frequencies in devicetree as per OPP_LOW spec.
>>
>> k3_avs driver programs the OPP_LOW AVS voltage for VDD_CPU through
>> k3_avs_notify_freq() callback from clk_k3.
>>
>> [0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
>>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
> [..]
>> ---
>>   arch/arm/mach-k3/j721e/j721e_init.c | 92 ++++++++++++++++++++++++++++-
>>   1 file changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
>> index e9ed8cb267c..805b28af8e4 100644
>> --- a/arch/arm/mach-k3/j721e/j721e_init.c
>> +++ b/arch/arm/mach-k3/j721e/j721e_init.c
>> @@ -19,6 +19,7 @@
> 
> [..]
>   
>> +#if defined(CONFIG_CPU_V7R) && defined(CONFIG_K3_AVS0)
>> +static int get_clock_index_by_dev_id(ofnode node, u32 dev_id, u32 clk_id)
> 
> I think the following function can be re-usable by other K3 socs too,
> can we put it in some common place instead of j721e_init? Maybe clk-k3.c
> and exported from there?
> 

Yeah that does make sense to do... There are already similar usages, I 
think, in other k3 platforms. Having said that I would like to take that 
up as a separate series since the DT index search is not directly 
related to OPP_LOW Perf Point setting for j7200.

Let me know if you think that the k3 DT clock index search belongs in 
the same series itself...

>> +
>> +static int fdt_fixup_a72ss_clock_frequency(void)
>> +{
>> +	int index, size;
>> +	u32 *rates;
>> +	ofnode node;
>> +
>> +	node = ofnode_by_compatible(ofnode_null(), "ti,am654-rproc");
>> +	if (!ofnode_valid(node)) {
>> +		printf("%s: A72 not found\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
>> +			      "assigned-clock-rates", &size);
>> +	if (!rates) {
>> +		printf("%s: Wrong A72 assigned-clocks-rates configuration\n", __func__);
>> +		return -1;
>> +	}
>> +
>> +	/* Update A72 Clock Frequency to OPP_LOW spec */
>> +	index = get_clock_index_by_dev_id(node,
>> +					  DEV_A72SS0_CORE0_0_ID,
>> +					  DEV_A72SS0_CORE0_0_ARM_CLK_CLK_ID);
>> +	if (index < 0 || index >= (size / sizeof(u32))) {
> 
> When would we encounter the second if..?

Assuming you mean:
	index >= (size / sizeof(u32))

The RHS is the count of "assigned-clock-rates" in the node and the LHS 
(index) is the id of the "assigned-clocks".
It's possible (and I see it in a few cases too) that count of 
"assigned-clocks" > count of "assigned-clock-rates". In that case the 
"index" here, even if parsed correctly, could turn out to be outside of 
the bounds of the array "rates". Which should be check against.

Regards,
Aniket

> 
>> +		printf("%s: Wrong A72 assigned-clocks configuration\n", __func__);
>> +		return -1;
>> +	}
>> +	rates[index] = cpu_to_fdt32(1000000000);
>> +	printf("Changed A72 CPU frequency to %dHz in DT\n", 1000000000);
>> +
>> +	/* Update MSMC Clock Frequency to OPP_LOW spec */
>> +	index = get_clock_index_by_dev_id(node,
>> +					  DEV_A72SS0_CORE0_ID,
>> +					  DEV_A72SS0_CORE0_MSMC_CLK_ID);
>> +	if (index < 0 || index >= (size / sizeof(u32))) {
>> +		printf("%s: Wrong A72 assigned-clocks configuration\n", __func__);
>> +		return -1;
>> +	}
>> +	rates[index] = cpu_to_fdt32(500000000);
>> +	printf("Changed MSMC frequency to %dHz in DT\n", 500000000);
>> +
>> +	return 0;
>> +}
>> +#endif
> [..]
> 
> Regards,
> Manorit
