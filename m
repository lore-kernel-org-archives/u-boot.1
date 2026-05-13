Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07D4CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 13:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 584F883E36;
	Wed, 13 May 2026 15:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kuQgDqhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4BA8845E3; Wed, 13 May 2026 15:07:15 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7279836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 15:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT5vXCdAdrSYe+bDfJelxBaJF+28LQLbaTsIweAjUn5qOis3kOfAB4GGUWOH0V0cIaLI4RREFHNgukTCLBrFIgWdUVQ6lR6IFTtOAJaqzu8DHiJRFLy9dyqATf8dBHoDAJIe6gUZolDK19E4DvYTyLQ4edk64n0ic2GgmqTs+RK9Ba/5flFgh8qXFQytuCB9bvy+E/rbEUIR83WlnVmoSRB/LRACLQCMnSqGDiiSV+o5jImxJUqDj2zKzO01Tb/Z2NSU5geY4fbK2VpQk4xWMsrZ8a6tdf8YYgRWYRSQ/72XbeOhR8mA10xKHKFlwVpsukIaHJuAbAgwvmEcXtWxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KweQMghNDlw5Gd1fjbLsD1SKgmDIauZ1kQ3keskXbI0=;
 b=Btux9Sb1S/hpw07am24BZTpqd6s07PDhHivx/9u+QS9yTT+cIIxB/9SHvvRz+pMKVeQkzYI0NbD8gyen2YV3oRsrrOZjkjRrD5zUknkhQ3FVg8aqFUBtEdTATBTMBawM4zVx8gRIQvEY2t2fQqpdGmgAN6rjtJk1C3L2Q4+MZS9N9MYlwMF9F3sZBCcioJ8EwfrM0yXPc0giXlfJwGaecvxpC6+Vqgi7JRhfZH/p8lfCGro8dxanZ75Bq/Cfn0QhO1ogN4+q72un1FXb4CWcs3z+yKy0JX22O/aOJbtmZB2pZFYwSRd2tb6AsfB84tdyEfl7QOr0sZ/6cGdXLfkF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KweQMghNDlw5Gd1fjbLsD1SKgmDIauZ1kQ3keskXbI0=;
 b=kuQgDqhACrBMLTJso34/fsqWtDQ8AV8a82ylrOqsj69JKmYVM959CXg7iJsH6LICQnRlMbW0wDnFn8JNXzOMuBaV7i8Lya+ob7i77p1RMzb93ESr/uF2r5Ney25bD3tf0wwT6HzfKrUCK8cdNpYFV11LwMXZYFXMr0QXb6m6mdE=
Received: from MN2PR22CA0018.namprd22.prod.outlook.com (2603:10b6:208:238::23)
 by CH3PR10MB7529.namprd10.prod.outlook.com (2603:10b6:610:154::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 13:07:07 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::a) by MN2PR22CA0018.outlook.office365.com
 (2603:10b6:208:238::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 13:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 13:07:06 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 08:06:45 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 08:06:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 08:06:45 -0500
Received: from [10.24.68.200] (hp-z2-tower-g9.dhcp.ti.com [10.24.68.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DD6fKQ4099376;
 Wed, 13 May 2026 08:06:41 -0500
Message-ID: <677d1d7c-8276-44f2-b563-d2b0d0a263ea@ti.com>
Date: Wed, 13 May 2026 18:36:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
 <momeoh6chz4swvgj3oj36p57os2cejpbcx37qyc7f3pydvwdlt@gaucmqmtpjso>
Content-Language: en-US
From: Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <momeoh6chz4swvgj3oj36p57os2cejpbcx37qyc7f3pydvwdlt@gaucmqmtpjso>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CH3PR10MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fd6463-f5a1-4f65-3a52-08deb0f088a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Uypv0i1QkoTUV+Xx86CcSQ0eQg5ma4NTWFXj2l8jgeUZZvKS+8X5qKBkMdmDryB4ZeLHer0xsf5psVCXZXR7yKmJ969MWaBwMtBpScYjX2f51uoEWfnjRxHZ8jSvoP53sVMmbFFEj3Tl3rv+XhHgcUVTe9dYu0Fe7rgAgNfQeO5mEQLyt93p6Cu3WporErCqNIJUYKKXkWB6ekexeXg90HoOrhKYBWR0XG3bR/fIraYBgz/t8IPGxpyNGckf+WxsFtR5objhpc7LlrTAs3ueX3tAeQ0zLTvmq639SvDuw/T8f+zLg939dYwbZhAs2wmRmI/59RsZez95fopfu+qnRoGfVzaIjrpyYbghx3NAoCYhUHv6HcWs5qwroMcVXpIJELJ7rW2XSUzCU0DYrKYuPAH5IrEr+fKPBVOJdF8zI1QjLUQb3ZNgM8FGUL1sT7st/vMsol9rH/zXAyXkpiIAxKer6i98PbdwB5z/cLyPqd4R/Wa3zYQ4CdB6bmfuXjT94YjWoQAT9ZORsRQqc9MRbM50UFpGJgD8Po7mBh1heqpLviRclnu4x8z9ya0hYRiAqjqBfSO5iZ5esUCF3IFshovtk5/Jh2O3574J10tLZJSiRW8jRcRMnw9EhprIxKxE82jhMxQJ70GoKkSMqJeWPDat8P74V+wIZdyXG0d3fTxpi62NWOcpLoYYygQzduDRTa3nfMrUPVEk6h28Eq7UBcEEvlHq+r67O4Y7T3Gxaj4=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: afgfdcyXEgIG4MGYP6I2HZheoDKLTkJJ0QpQSgAMXMY62wcayTVm4ROTW5rKUdCN/1RNoP1cie/mKmz1pGPhv2dr8T3DL9GJUTK1MyBeiTYMbTQaTPHmaZwbT15Pzpn/8S02wG0xuK5MEkmCHQ9+hwwMGHJdKnihcr/vne1FKAFgTrKNVtY3TCT45zn6iQwpHsA82KGCYO65iJ3W+N51yCLMc8SsxQNxR2iNZkfcfCsmCAUSTPb43yk3YMpzKc2pGluyGJ78dGgi973JZNvR4DgEca370d8+GF/6KyhsrkbdrKqD8iik+Y2eU2MAbTgGMosR2umwpCffW3IVzNnoon9YbIsRH+5eMmOxeqZyQsbzKBnpCcxzloIus4XWS/kI1aO9Gp49kDN4ZyNd31Qk1ABAgScmXsaD6l36tVu0Lh06pWsX51ZmzdIe2p16HI/8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:07:06.2975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fd6463-f5a1-4f65-3a52-08deb0f088a3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7529
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



On 5/12/26 22:14, Ernest Van Hoecke wrote:
> On Wed, Feb 25, 2026 at 04:54:38PM +0530, Shiva Tripathi wrote:
>> Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
>> MMC hardware. This provides TPM 2.0 functionality through
>> Microsoft's fTPM Trusted Application running in OP-TEE secure world,
>> using eMMC RPMB as persistent storage.
>>
>> fTPM support in U-Boot provides the foundation for measured boot
>> and disk encryption use cases.
>>
>> The ARM64 condition ensures these apply only to A53/A72 cores and the
>> MMC condition ensures fTPM is enabled only on platforms with eMMC
>> hardware support.
>>
>> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
>> ---
>> Changes in v2:
>> - Moved fTPM enablement from per-board defconfig files to common Kconfig
>> - Added configs to ARCH_K3 (arch/arm/Kconfig) to enable for all K3 platforms
>> - Added command configs to TI_COMMON_CMD_OPTIONS (board/ti/common/Kconfig)
>> - Added MMC dependency to address concern about boards without eMMC hardware
>> - Link to v1: https://lore.kernel.org/all/20260223091314.586968-1-s-tripathi1@ti.com/
>>
>> ---
>>  arch/arm/Kconfig        | 3 +++
>>  board/ti/common/Kconfig | 2 ++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 5508fce796a..eb83b5c35f1 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -834,6 +834,9 @@ config ARCH_K3
>>  	imply DM_RNG if ARM64
>>  	imply TEE if ARM64
>>  	imply OPTEE if ARM64
>> +	imply TPM if ARM64 && MMC
>> +	imply TPM2_FTPM_TEE if ARM64 && MMC
>> +	imply SUPPORT_EMMC_RPMB if ARM64 && MMC
>>  
>>  config ARCH_OMAP2PLUS
>>  	bool "TI OMAP2+"
>> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
>> index 409454813f3..149909093b3 100644
>> --- a/board/ti/common/Kconfig
>> +++ b/board/ti/common/Kconfig
>> @@ -61,4 +61,6 @@ config TI_COMMON_CMD_OPTIONS
>>  	imply CMD_SPL
>>  	imply CMD_TIME
>>  	imply CMD_USB if USB
>> +	imply CMD_TPM if TPM
>> +	imply CMD_OPTEE_RPMB if OPTEE && SUPPORT_EMMC_RPMB
>>  
>> -- 
>> 2.34.1
>>
> 
> Hi Shiva,
> 
> Do these changes mean you expect any K3-based board to follow by
> building OP-TEE with RPMB support (and in production provisioning an
> authentication key on first boot) now?
> 
> I'm asking because we noticed errors in the below form appeared during
> boot of our Verdin AM62P and Aquila AM69 now:
> E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
> E/LD:   arch: aarch64
> E/LD:  region  0: va 0x40005000 pa 0x9e900000 size 0x002000 flags rw-s (ldelf)
> E/LD:  region  1: va 0x40007000 pa 0x9e902000 size 0x008000 flags r-xs (ldelf)
> E/LD:  region  2: va 0x4000f000 pa 0x9e90a000 size 0x001000 flags rw-s (ldelf)
> E/LD:  region  3: va 0x40010000 pa 0x9e90b000 size 0x004000 flags rw-s (ldelf)
> E/LD:  region  4: va 0x40014000 pa 0x9e90f000 size 0x001000 flags r--s
> E/LD:  region  5: va 0x40015000 pa 0x9e980000 size 0x011000 flags rw-s (stack)
> E/LD:  region  6: va 0x4005a000 pa 0x9e910000 size 0x055000 flags r-xs [0]
> E/LD:  region  7: va 0x400af000 pa 0x9e965000 size 0x01b000 flags rw-s [0]
> E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4005a000
> E/LD:  Call stack:
> E/LD:   0x4005b7b0
> E/LD:   0x4008f220
> E/LD:   0x40083298
> 
> Interestingly this did not appear on our Verdin AM62 SoM.
> 
> Of course, we can simply disable the fTPM until our support improves, or
> ignore this error if it is harmless, but I wanted to ask about your
> intentions before digging much deeper.
> 
> Thanks!
> 
> Kind regards,
> Ernest

Hi Ernest,

It's not expected for all K3-platforms to build OP-TEE with RPMB
support, some platforms lack eMMC entirely. fTPM is an optional
configuration for users who need measured boot, disk encryption, or
similar TPM related use-cases.

The Yocto SDK we release for K3 platforms includes the fTPM TA embedded
in the OP-TEE, not sure if the same is true in your case.

RPMB provisioning is needed for full functionality, but even without it
you shouldn't see these errors. Maybe the fTPM TA is missing from your
OP-TEE build, or something similar is causing loader error.

Regards,
Shiva

> 

