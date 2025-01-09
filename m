Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11258E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 14:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE9D8005B;
	Thu,  9 Jan 2025 15:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ewNNjf4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD698060A; Thu,  9 Jan 2025 11:23:38 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29BCE80601
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 11:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 509ANRL83148526
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 04:23:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736418207;
 bh=VAzGDa8iFUPfi2INHWFAtFHWMl2di+98c7Z+gBSjxHE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ewNNjf4jWwnzjEv65rkuA6XpPZ0m5rYvSge8ugS8DmS8NPrdgshZ/crMupLKTTl3b
 Xd8TzaKvFbb9QNrQrUlYLPV/dJdzWPx+JnpkX0JbX3xAS8bHqUB81cxwV+puFdz0Vf
 MDoeeFFx6xopbeZ1S9bmlv4dVOl92IUcvVpl/Q+0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 509ANR43057059
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Jan 2025 04:23:27 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Jan 2025 04:23:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Jan 2025 04:23:26 -0600
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 509ANNA8003872;
 Thu, 9 Jan 2025 04:23:23 -0600
Message-ID: <251ea7ec-03b9-4f73-9951-0f89f9cf2959@ti.com>
Date: Thu, 9 Jan 2025 15:53:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: j722s: j722s.env: Set remoteproc firmware names
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
 <rogerq@kernel.org>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <u-boot@lists.denx.de>, "Limaye, Aniket" <a-limaye@ti.com>
References: <20250108102516.2103132-1-b-padhi@ti.com>
 <20250108141659.rsvnmlurqdyxnocc@bryanbrattlof.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20250108141659.rsvnmlurqdyxnocc@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 09 Jan 2025 15:10:50 +0100
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

Hi Bryan!

On 08/01/25 19:46, Bryan Brattlof wrote:
> Hi Beleswar!
>
> On January  8, 2025 thus sayeth Beleswar Padhi:
>> Include k3_rproc.env to access rproc boot commands and specify rproc
>> firmware names for adding remoteproc support in J722S SoCs.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> This patch is independent and puts the environment in place to boot remote
>> processors at U-Boot stage.
>>
>> However, for successfully loading the firmwares into remote cores, rproc
>> DT node definitions are required. These DT changes have been merged into
>> Linux and available with v6.12 tag[0]. Once the DT Sync happens in U-Boot,
>> remote processors can be probed and booted with the help of env commands
>> enabled with this patch.
>>
>> Sample Boot Test logs after manually adding DT nodes in U-Boot:
>> https://gist.github.com/3V3RYONE/0b5c7df5b5c88d2a2f273b6a04a3dd46
>>
>> [0]: https://lore.kernel.org/all/20240830161742.925145-1-b-padhi@ti.com/
>>
>> Thanks,
>> Beleswar
>>
>>   board/ti/j722s/j722s.env | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/board/ti/j722s/j722s.env b/board/ti/j722s/j722s.env
>> index f8b6aff2c2f..10d62034e1a 100644
>> --- a/board/ti/j722s/j722s.env
>> +++ b/board/ti/j722s/j722s.env
>> @@ -1,6 +1,10 @@
>>   #include <env/ti/ti_common.env>
>>   #include <env/ti/mmc.env>
>>   
>> +#if CONFIG_CMD_REMOTEPROC
>> +#include <env/ti/k3_rproc.env>
>> +#endif
>> +
>>   name_kern=Image
>>   console=ttyS2,115200n8
>>   args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
>> @@ -13,3 +17,5 @@ mmcdev=1
>>   bootpart=1:2
>>   bootdir=/boot
>>   rd_spec=-
>> +
>> +rproc_fw_binaries= 0 /lib/firmware/j722s-mcu-r5f0_0-fw 2 /lib/firmware/j722s-main-r5f0_0-fw 3 /lib/firmware/j722s-c71_0-fw 4 /lib/firmware/j722s-c71_1-fw
> For SE devices do these firmware have that *-sig suffix?


Yes, for all K3 SE devices, the "*-sec" suffix is appended to the 
existing firmware paths[0].

> My thinking is
> this seems fairly specific to yocto with other distributions like debian
> or QNX will have different names or paths. Should this be put in the env
> that yocto builds?


Debian currently uses the same firmware names like Yocto. But yes, 
thinking about multi-distro, we can leave the default firmware paths as 
empty, and leave it to the user to override these paths according to 
their distro. That will have to be done for all K3 devices, as currently 
all those define Yocto based firmware paths in the U-Boot board environment.

However, if we leave the default `rproc_fw_binaries` as empty, rproc 
boot will fail silently without complaining, which could be confusing to 
the user. Whereas, if we have Yocto (or any other distro's) firmware 
paths as default, rproc boot will complain "No such file or directory" 
and fail when using with a different distro. What are your thoughts?

[0]: 
https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/k3_rproc.env?ref_type=heads#L18

Thanks,
Beleswar

>
> ~Bryan
