Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E01C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 13:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB39282A9E;
	Wed, 28 May 2025 15:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CPIWxrfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F60A82AAA; Wed, 28 May 2025 15:46:13 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F01282A8D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 15:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54SDk8eh2074895;
 Wed, 28 May 2025 08:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748439968;
 bh=cAVyq8YB8mi35nO441o8/fHF7vw54NxHSAG5MKMHVtM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CPIWxrfXFOsEvHhAIEPLHrTjrBq0ZpXCu0VaqAR7ZkVQ88sKOfPWH+1WuBAtb+/j4
 sEIqSvvfaqb1vdK85Z96PGCHSlyJHKGcK8K9HLLScu4VZlaGuSvOdYgkC/Uze6+IQ9
 UCXzA/b30hUhVQtv17UhQSLWJ3kUy7s6t7zNDvnI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54SDk8QF3602975
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 28 May 2025 08:46:08 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 08:46:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 08:46:08 -0500
Received: from [172.24.227.139]
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.139])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54SDk575038830;
 Wed, 28 May 2025 08:46:06 -0500
Message-ID: <e79cdc1d-17c3-4efc-9bb9-fd0cec726d82@ti.com>
Date: Wed, 28 May 2025 19:16:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: mach-k3: am62a: Fixup CPU core, DSS, CAN-FD and
 Video-codec nodes in fdt
To: Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <afd@ti.com>,
 <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>
References: <20250430104236.2611089-1-a-patra@ti.com>
 <20250430104236.2611089-2-a-patra@ti.com>
 <20250430152002.juh2hmy6weph2jt5@bryanbrattlof.com>
Content-Language: en-US
From: Aparna Patra <a-patra@ti.com>
In-Reply-To: <20250430152002.juh2hmy6weph2jt5@bryanbrattlof.com>
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


On 30/04/25 20:50, Bryan Brattlof wrote:
> On April 30, 2025 thus sayeth Aparna Patra:
>> AM62A SOC is available in multiple variants:
>> -CPU cores (Cortex-A) AM62Ax1 (1 core),
>>   AM62Ax2 (2 cores), AM62Ax4 (4 cores)
>> -With and without DSS, CAN-FD & Video-codec support
>>
>> Remove the relevant FDT nodes by reading the actual configuration
>> from the SoC registers, with that change it is possible to have a single
>> dts/dtb file handling the different variants at runtime.
>>
>> Signed-off-by: Aparna Patra <a-patra@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_fdt.c          | 41 +++++++++++++++++++
>>   .../arm/mach-k3/include/mach/am62a_hardware.h | 40 ++++++++++++++++++
>>   2 files changed, 81 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> index 7f764ab36b..56fd658202 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> @@ -8,8 +8,49 @@
>>   
>>   #include "../common_fdt.h"
>>   
>> +static void fdt_fixup_cores_wdt_nodes_am62a(void *blob, int core_nr)
>> +{
>> +	char node_path[32];
>> +
>> +	if (core_nr < 1)
>> +		return;
>> +
>> +	for (; core_nr < 4; core_nr++) {
>> +		snprintf(node_path, sizeof(node_path), "/cpus/cpu@%d", core_nr);
>> +		fdt_del_node_path(blob, node_path);
>> +		snprintf(node_path, sizeof(node_path), "/cpus/cpu-map/cluster0/core%d", core_nr);
>> +		fdt_del_node_path(blob, node_path);
>> +		snprintf(node_path, sizeof(node_path), "/bus@f0000/watchdog@e0%d0000", core_nr);
>> +		fdt_del_node_path(blob, node_path);
>> +	}
>> +}
>> +
>> +static void fdt_fixup_dss_nodes_am62a(void *blob, bool has_dss)
>> +{
>> +	if (!has_dss) {
>> +		fdt_del_node_path(blob, "/bus@f0000/dss@30200000");
>> +		fdt_del_node_path(blob, "/bus@f0000/pinctrl@f4000/main-dss0-default-pins");
> So for a little background on the upcoming paragraph[0]
>
> I completely agree we should remove the dss{} node but don't think it's
> wise of us to start trying to unwind the allocation or configuration of
> the hardware when the hardware isn't there.
>
> In my eyes because we can't really trust the names for the memory
> carveouts, mailbox and, pinmux nodes as they are just describing their
> use and are fairly unstable as the boards age we would need to keep up
> with each node's bindings and follow all the pinmux, mboxes,
> memory-region phandles via their properties to undo all those nodes
> which leaves us making too many opinionated decisions on how best to do
> that in my opinion.
>
> Anywho from that first link I'm trusting Andrew has a plan which from
> what I've seen could look something like an overlay[1] But time will
> tell.
>
> ~Bryan
>
> [0] https://lore.kernel.org/all/20250419150451.v3jgtgp4yisou65u@bryanbrattlof.com/
> [1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?id=95010a7c186b86f738615231016aa017ac527612
Sure Bryan, I will test without the pinmux fixup, and send out the 
modified patches.

Thanks,
Aparna
>
