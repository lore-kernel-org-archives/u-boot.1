Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82800C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 10:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB89E839C7;
	Wed, 28 May 2025 12:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IuUP6ma5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66AF683A07; Wed, 28 May 2025 12:14:57 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA44A83091
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 12:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54SAErTv2063995;
 Wed, 28 May 2025 05:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748427293;
 bh=N4sunxm/KaPkEekadd2dhw8fAuPti1CgwrLqdbTysRc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IuUP6ma5t67zfU08BhUn/o0hlnE3mjXHtzAoud5ZKh+LFMFnB6fkjr7ZmSDWE7K/7
 PETb1VkA6GqU/HfnUDRAVIcX+LyjBgGXpg/uZqadvW5LGhUx/Girls9WuC6RSR575M
 tgByb0Q2cx+mFFjLK4j3KAqnOjNKqJ/BK/NCq62g=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54SAEqU03362054
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 28 May 2025 05:14:52 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 05:14:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 05:14:52 -0500
Received: from [172.24.227.139]
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.139])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54SAEnxN129887;
 Wed, 28 May 2025 05:14:49 -0500
Message-ID: <edf9c133-8f07-40d7-8345-62c5d9dff8bc@ti.com>
Date: Wed, 28 May 2025 15:44:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm: mach-k3: am62a: Fixup a53 max cpu frequency by
 speed-grade
To: Daniel Schultz <d.schultz@phytec.de>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <afd@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <bb@ti.com>
References: <20250430104236.2611089-1-a-patra@ti.com>
 <20250430104236.2611089-4-a-patra@ti.com>
 <e9ff8b0e-5aa7-44d7-a661-b21dd2643d95@phytec.de>
Content-Language: en-US
From: Aparna Patra <a-patra@ti.com>
In-Reply-To: <e9ff8b0e-5aa7-44d7-a661-b21dd2643d95@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 02/05/25 15:02, Daniel Schultz wrote:
>
> On 4/30/25 12:42, Aparna Patra wrote:
>> AM62A SoC has multiple speed grades. Add function to delete
>> non-relevant CPU frequency nodes, based on the information
>> retrieved from hardware registers. Fastest grade's maximum
>> frequency also depends on PMIC voltage,hence to simplify
>> implementation use the smaller value.
>>
>> Signed-off-by: Aparna Patra <a-patra@ti.com>
>> ---
>>   arch/arm/mach-k3/am62ax/am62a7_fdt.c          | 14 +++++++++++
>>   .../arm/mach-k3/include/mach/am62a_hardware.h | 23 +++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c 
>> b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> index 40833ca392..9526c5b255 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> @@ -81,6 +81,19 @@ static void 
>> fdt_fixup_thermal_zone_nodes_am62a(void *blob, int maxc)
>>       }
>>   }
>>   +static void fdt_fixup_cpu_freq_nodes_am62a(void *blob, int max_freq)
>> +{
>> +    if (max_freq >= 1250000000)
>> +        return;
> I dont think this if case is required. Just let if fail both following 
> conditions.
Agreed, will remove this.
>> +    if (max_freq <= 1000000000) {
>> +        fdt_del_node_path(blob, "/opp-table/opp-1250000000");
>> +        fdt_del_node_path(blob, "/opp-table/opp-1400000000");
>> +    }
>> +    if (max_freq <= 800000000) {
>> +        fdt_del_node_path(blob, "/opp-table/opp-1000000000");
>> +    }
>> +}
>> +
>>   int ft_system_setup(void *blob, struct bd_info *bd)
>>   {
>>       fdt_fixup_cores_wdt_nodes_am62a(blob, k3_get_core_nr());
>> @@ -88,6 +101,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
>>       fdt_fixup_video_codec_nodes_am62a(blob, k3_has_video_codec());
>>       fdt_fixup_canfd_nodes_am62a(blob, k3_has_canfd());
>>       fdt_fixup_thermal_zone_nodes_am62a(blob, k3_get_max_temp());
>> +    fdt_fixup_cpu_freq_nodes_am62a(blob, k3_get_a53_max_frequency());
>>       fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
>>       fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 
>> 0x1800000);
>>   diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h 
>> b/arch/arm/mach-k3/include/mach/am62a_hardware.h
>> index 0ec04a72f5..64e4a379fa 100644
>> --- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
>> @@ -28,6 +28,8 @@
>>   #define JTAG_DEV_VIDEO_CODEC_SHIFT            14
>>   #define JTAG_DEV_DSS_MASK            GENMASK(16, 13)
>>   #define JTAG_DEV_DSS_SHIFT            13
>> +#define JTAG_DEV_SPEED_MASK            GENMASK(10, 6)
>> +#define JTAG_DEV_SPEED_SHIFT            6
>>   #define JTAG_DEV_TEMP_MASK            GENMASK(5, 3)
>>   #define JTAG_DEV_TEMP_SHIFT            3
>>   @@ -144,6 +146,27 @@ static inline int k3_get_max_temp(void)
>>           return JTAG_DEV_TEMP_EXTENDED_VALUE;
>>   }
>>   +static inline char k3_get_speed_grade(void)
>> +{
>> +    u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>> +    u32 speed_grade = (dev_id & JTAG_DEV_SPEED_MASK) >>
>> +               JTAG_DEV_SPEED_SHIFT;
>> +
>> +    return 'A' - 1 + speed_grade;
>> +}
>> +
>> +static inline int k3_get_a53_max_frequency(void)
>> +{
>> +    if (k3_get_speed_grade() <= 'N')
>> +        return 800000000;
>> +
>
> ^ empty lines where should be none in this function.
>
> - Daniel

Will remove the empty lines as well.
Thanks!

>
>> +    else if (k3_get_speed_grade() <= 'R')
>> +        return 1000000000;
>> +
>> +    else
>> +        return 1250000000;
>> +}
>> +
>>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>>     static const u32 put_device_ids[] = {};
