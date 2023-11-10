Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9A7C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 12:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E27A8777F;
	Fri, 10 Nov 2023 13:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="hywu3Sv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B4F88777F; Fri, 10 Nov 2023 13:33:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536D787771
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 13:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAAkwEf030956; Fri, 10 Nov 2023 13:33:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=KBCCw9+KZeeMtwNdcUI3zPmoT1VM2EhQahJxHisyEjo=; b=hy
 wu3Sv/iExBmJTB1xqLN3MAEPCrpA91xvv6vaaCQHAuwUQ7fZGukDyAy8W/0fHr8K
 M+XgOhMn6FHwI3QxUOYgIoh6GI/a7HP+Gr0wjEq0KAA2gwMRizOYBajy2DkLWZKx
 KD/iLX+LJIlq4WXJHVjkKMr2hFca3inOauftmtIqNFaVu8qJoQ25/t7CLygwNlz/
 QF1fCHDSld2564qa+7zT5WnCd7WxXFluA8bqIuZNbuttxzgje1/rjv2CLYC10a3y
 euahO6BwqXHwMeUSf1FJ8QDBb2XNbOa0K8kNPAaO1kBfBDF06xmQMXdbgqACuCx9
 OgcQFx+hc3TOB3Aj8LZA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26p276-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 13:33:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C6B9100056;
 Fri, 10 Nov 2023 13:33:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 23CEC210F9F;
 Fri, 10 Nov 2023 13:33:33 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 13:33:32 +0100
Message-ID: <55c6dbad-7e7a-49e3-a398-061c4c8fa2fb@foss.st.com>
Date: Fri, 10 Nov 2023 13:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH v1] stm32mp1: read auth stats and
 boot_partition from tamp
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, <u-boot@lists.denx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>, Marek Vasut <marex@denx.de>
References: <20231106104152.140495-1-igor.opaniuk@foundries.io>
 <9df74274-1121-4f91-8662-d5297ccc54a0@foss.st.com>
In-Reply-To: <9df74274-1121-4f91-8662-d5297ccc54a0@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_09,2023-11-09_01,2023-05-22_02
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



On 11/9/23 08:47, Patrice CHOTARD wrote:
> 
> 
> On 11/6/23 11:41, Igor Opaniuk wrote:
>> Obtain from TAMP backup register information about image authorization
>> status and partition id used for booting. Store this info in
>> environmental variables ("boot_auth" and "boot_part" correspondingly).
>>
>> Image authorization supported values:
>> 0x0 - No authentication done
>> 0x1 - Authentication done and failed
>> 0x2 - Authentication done and succeeded
>>
>> These values are stored to TAMP backup register by Trusted Firmware-A [1].
>>
>> Testing:
>> STM32MP> print boot_part
>> boot_part=1
>> STM32MP> print boot_auth
>> boot_auth=2
>>
>> [1] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?h=refs/heads/integration&id=ab2b325c1ab895e626d4e11a9f26b9e7c968f8d8
>>
>> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>> Co-developed-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
>> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
>>
>> ---
>>
>>  arch/arm/mach-stm32mp/cpu.c                   | 23 +++++++++++++++++++
>>  arch/arm/mach-stm32mp/include/mach/stm32.h    |  4 ++++
>>  .../arm/mach-stm32mp/include/mach/sys_proto.h |  3 +++
>>  3 files changed, 30 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/cpu.c b/arch/arm/mach-stm32mp/cpu.c
>> index e07abbe21c1..ba5942848bd 100644
>> --- a/arch/arm/mach-stm32mp/cpu.c
>> +++ b/arch/arm/mach-stm32mp/cpu.c
>> @@ -40,6 +40,13 @@ u32 get_bootmode(void)
>>  		    TAMP_BOOT_MODE_SHIFT;
>>  }
>>  
>> +u32 get_bootauth(void)
>> +{
>> +	/* read boot auth status and partition from TAMP backup register */
>> +	return (readl(TAMP_BOOT_CONTEXT) & TAMP_BOOT_AUTH_MASK) >>
>> +		    TAMP_BOOT_AUTH_SHIFT;
>> +}
>> +
>>  /*
>>   * weak function overidde: set the DDR/SYSRAM executable before to enable the
>>   * MMU and configure DACR, for early early_enable_caches (SPL or pre-reloc)
>> @@ -371,8 +378,24 @@ __weak void stm32mp_misc_init(void)
>>  {
>>  }
>>  
>> +static int setup_boot_auth_info(void)
>> +{
>> +	char buf[10];
>> +	u32 bootauth = get_bootauth();
>> +
>> +	snprintf(buf, sizeof(buf), "%d", bootauth >> 4);
>> +	env_set("boot_auth", buf);
>> +
>> +	snprintf(buf, sizeof(buf), "%d", bootauth &
>> +		 (u32)TAMP_BOOT_PARTITION_MASK);
>> +	env_set("boot_part", buf);
>> +
>> +	return 0;
>> +}
>> +
>>  int arch_misc_init(void)
>>  {
>> +	setup_boot_auth_info();
>>  	setup_boot_mode();
>>  	setup_mac_address();
>>  	setup_serial_number();
>> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> index 1cdc5e3b186..ac0deced67e 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> @@ -139,8 +139,12 @@ enum boot_device {
>>  
>>  #define TAMP_BOOT_MODE_MASK		GENMASK(15, 8)
>>  #define TAMP_BOOT_MODE_SHIFT		8
>> +#define TAMP_BOOT_AUTH_MASK		GENMASK(23, 16)
>> +#define TAMP_BOOT_AUTH_SHIFT		16
>>  #define TAMP_BOOT_DEVICE_MASK		GENMASK(7, 4)
>>  #define TAMP_BOOT_INSTANCE_MASK		GENMASK(3, 0)
>> +#define TAMP_BOOT_AUTH_ST_MASK		GENMASK(7, 4)
>> +#define TAMP_BOOT_PARTITION_MASK	GENMASK(3, 0)
>>  #define TAMP_BOOT_FORCED_MASK		GENMASK(7, 0)
>>  
>>  enum forced_boot_mode {
>> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> index 83fb32a45fc..52aca1e23e1 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> @@ -66,6 +66,9 @@ void get_soc_name(char name[SOC_NAME_SIZE]);
>>  /* return boot mode */
>>  u32 get_bootmode(void);
>>  
>> +/* return auth status and partition */
>> +u32 get_bootauth(void);
>> +
>>  int get_eth_nb(void);
>>  int setup_mac_address(void);
>>  
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32

Applied to u-boot-stm32/master

Thanks
Patrice
