Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C5C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 10:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F6B83208;
	Wed, 28 May 2025 12:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZXyj6nV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2CF83939; Wed, 28 May 2025 12:22:30 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C230383091
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 12:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54SAMQcC3236620;
 Wed, 28 May 2025 05:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748427746;
 bh=XHKe0Pp1pGoFm1caQz5swpyxGy2f/sKa/0HgZpoFguo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZXyj6nV2w2EVbnYJhnsSAuactB2frolMszX8sfPNipuG62hL8e1Y8EZF8rusKmhVs
 oFxuoYal1MKu/HfNSKAtVBKJIuob+6raOQcARn6UbTna3WGQqC1Eb2lPr4jJ6arUeZ
 r5kulizFeBvQAyZtsHtp+UMrYHe0eVApCUNgkIuY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54SAMQKM3541823
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 28 May 2025 05:22:26 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 05:22:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 05:22:25 -0500
Received: from [172.24.227.139]
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.139])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54SAMM4q009471;
 Wed, 28 May 2025 05:22:22 -0500
Message-ID: <5d7fab64-1403-489f-9a0e-3f49d0ac7202@ti.com>
Date: Wed, 28 May 2025 15:52:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: mach-k3: am62a: Fixup CPU core, DSS, CAN-FD and
 Video-codec nodes in fdt
To: Daniel Schultz <d.schultz@phytec.de>, Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <afd@ti.com>,
 <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <bb@ti.com>
References: <20250430104236.2611089-1-a-patra@ti.com>
 <20250430104236.2611089-2-a-patra@ti.com>
 <20250501122848.jaun54umcun6ijs7@domain>
 <235f58b4-6c3e-49ea-9a16-4eb0582b472b@phytec.de>
Content-Language: en-US
From: Aparna Patra <a-patra@ti.com>
In-Reply-To: <235f58b4-6c3e-49ea-9a16-4eb0582b472b@phytec.de>
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


On 02/05/25 15:08, Daniel Schultz wrote:
>
> On 5/1/25 14:28, Nishanth Menon wrote:
>> On 16:12-20250430, Aparna Patra wrote:
>>> AM62A SOC is available in multiple variants:
>>> -CPU cores (Cortex-A) AM62Ax1 (1 core),
>>>   AM62Ax2 (2 cores), AM62Ax4 (4 cores)
>>> -With and without DSS, CAN-FD & Video-codec support
>>>
>>> Remove the relevant FDT nodes by reading the actual configuration
>>> from the SoC registers, with that change it is possible to have a 
>>> single
>>> dts/dtb file handling the different variants at runtime.
>>>
>>> Signed-off-by: Aparna Patra <a-patra@ti.com>
>>> ---
>>>   arch/arm/mach-k3/am62ax/am62a7_fdt.c          | 41 
>>> +++++++++++++++++++
>>>   .../arm/mach-k3/include/mach/am62a_hardware.h | 40 ++++++++++++++++++
>>>   2 files changed, 81 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c 
>>> b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>>> index 7f764ab36b..56fd658202 100644
>>> --- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>>> +++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>>> @@ -8,8 +8,49 @@
>>>     #include "../common_fdt.h"
>>>   +static void fdt_fixup_cores_wdt_nodes_am62a(void *blob, int core_nr)
>>> +{
>>> +    char node_path[32];
>>> +
>>> +    if (core_nr < 1)
>>> +        return;
>>> +
>>> +    for (; core_nr < 4; core_nr++) {
>>> +        snprintf(node_path, sizeof(node_path), "/cpus/cpu@%d", 
>>> core_nr);
>>> +        fdt_del_node_path(blob, node_path);
>>> +        snprintf(node_path, sizeof(node_path), 
>>> "/cpus/cpu-map/cluster0/core%d", core_nr);
>>> +        fdt_del_node_path(blob, node_path);
>>> +        snprintf(node_path, sizeof(node_path), 
>>> "/bus@f0000/watchdog@e0%d0000", core_nr);
>>> +        fdt_del_node_path(blob, node_path);
>>> +    }
>>> +}
>>> +
>>> +static void fdt_fixup_dss_nodes_am62a(void *blob, bool has_dss)
>>> +{
>>> +    if (!has_dss) {
>>> +        fdt_del_node_path(blob, "/bus@f0000/dss@30200000");
>>> +        fdt_del_node_path(blob, 
>>> "/bus@f0000/pinctrl@f4000/main-dss0-default-pins");
>>> +    }
>>> +}
>>> +
>>> +static void fdt_fixup_video_codec_nodes_am62a(void *blob, bool 
>>> has_video_codec)
>>> +{
>>> +    if (!has_video_codec)
>>> +        fdt_del_node_path(blob, "/bus@f0000/video-codec@30210000");
>>> +}
>>> +
>>> +static void fdt_fixup_canfd_nodes_am62a(void *blob, bool has_canfd)
>>> +{
>>> +    if (!has_canfd)
>>> +        fdt_del_node_path(blob, "/bus@f0000/can@20701000");
>>> +}
>>> +
>>>   int ft_system_setup(void *blob, struct bd_info *bd)
>>>   {
>>> +    fdt_fixup_cores_wdt_nodes_am62a(blob, k3_get_core_nr());
>>> +    fdt_fixup_dss_nodes_am62a(blob, k3_has_dss());
>>> +    fdt_fixup_video_codec_nodes_am62a(blob, k3_has_video_codec());
>>> +    fdt_fixup_canfd_nodes_am62a(blob, k3_has_canfd());
>>>       fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 
>>> 0x80000);
>>>       fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 
>>> 0x1800000);
>>>   diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h 
>>> b/arch/arm/mach-k3/include/mach/am62a_hardware.h
>>> index cd61abe018..ab281129d7 100644
>>> --- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
>>> +++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
>>> @@ -19,6 +19,18 @@
>>>   #define MCU_CTRL_MMR0_BASE            0x04500000
>>>   #define WKUP_CTRL_MMR0_BASE            0x43000000
>>>   +#define CTRLMMR_WKUP_JTAG_DEVICE_ID (WKUP_CTRL_MMR0_BASE + 0x18)
>>> +#define JTAG_DEV_CORE_NR_MASK            GENMASK(19, 18)
>>> +#define JTAG_DEV_CORE_NR_SHIFT            18
>>> +#define JTAG_DEV_CANFD_MASK            BIT(15)
>>> +#define JTAG_DEV_CANFD_SHIFT            15
>>> +#define JTAG_DEV_VIDEO_CODEC_MASK            BIT(14)
>>> +#define JTAG_DEV_VIDEO_CODEC_SHIFT            14
>>> +#define JTAG_DEV_DSS_MASK            GENMASK(16, 13)
>>> +#define JTAG_DEV_DSS_SHIFT            13
>>> +
>>> +#define JTAG_DEV_HAS_DSS_VALUE            0xD
>>> +
>>>   #define CTRLMMR_MAIN_DEVSTAT            (WKUP_CTRL_MMR0_BASE + 0x30)
>>>   #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK    GENMASK(6, 3)
>>>   #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT    3
>>> @@ -86,6 +98,34 @@
>>>   #define TI_SRAM_SCRATCH_BOARD_EEPROM_START    0x70000001
>>>   #endif /* CONFIG_CPU_V7R */
>>>   +static inline int k3_get_core_nr(void)
>>> +{
>>> +    u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>>> +
>>> +    return ((dev_id & JTAG_DEV_CORE_NR_MASK) >> 
>>> JTAG_DEV_CORE_NR_SHIFT) + 1;
>>> +}
>>> +
>
> I can see these three following components are optional but I don't 
> see any silicon devices without them. The AM62A processor data sheet 
> only lists devices with different A53 and C7 options.
>
> BTW: C7x fixup is missing in this series ;)

Daniel, table 4-1 only shows the classification of AM62A family.
please refer to table 9.1 in datasheet for device grades information. 
There are device grades which doesnot have DSS, Video-codec etc

For C7x, upstream does not include C7x device nodes as of now. Fixups 
will be added once nodes are included in dts.

>
>>> +static inline int k3_has_dss(void)
>>> +{
>>> +    u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>>> +
>>> +    return (JTAG_DEV_HAS_DSS_VALUE == ((dev_id & JTAG_DEV_DSS_MASK) 
>>> >> JTAG_DEV_DSS_SHIFT));
>>> +}
>>> +
>>> +static inline int k3_has_video_codec(void)
>>> +{
>>> +    u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>>> +
>>> +    return !((dev_id & JTAG_DEV_VIDEO_CODEC_MASK) >> 
>>> JTAG_DEV_VIDEO_CODEC_SHIFT);
>>> +}
>>> +
>>> +static inline int k3_has_canfd(void)
>>> +{
>>> +    u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>>> +
>>> +    return (dev_id & JTAG_DEV_CANFD_MASK) >> JTAG_DEV_CANFD_SHIFT;
>>> +}
>>> +
>>>   #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
>>>     static const u32 put_device_ids[] = {};
>>> -- 
>>> 2.34.1
>>>
>> We should do a proper framework for this that scales multiple devices.
>
> I agree, this should be reworked afterwards and moved into a 
> framework. We have literally the same logic for AM62 and AM62Ax. I 
> also have temperature fixup patches for the AM64 which are identical 
> again. Would be nice to move most of this logic into a common part.
>
> Thanks for sending those patches!
>
> - Daniel
>
Thanks for reviewing the patches Daniel. We will soon define a common 
framework and reuse APIs wherever possible.
- Aparna
>>
>>
