Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DC0CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 13:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F2C836AC;
	Wed, 13 May 2026 15:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O4HuoTNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE3184099; Wed, 13 May 2026 15:50:05 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD40C8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 15:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9wxekwD3pXMXoM9nY7qnUO13xMBEU8jF/rDTto+wKQf6KH3u/kamYCSjqUDwKiv2/k4soLwzIMZFkbzsuMJewmfxvwcUtbeK5aDklbvQrh+TQl2uXEeqgvLbk79qT7wAjIevVdy2GEmzsKz9lzi3+leA6XKQjAt8ZCaHm8B15vzZf4+WzyxiNHyHJpdVJFVnrtal95YsFzr7JX9GYsyEFVWwcyQ2y0NHoA10jMe7ca81GAe5RNPE3ZiL98xDS3H+5MPPr9mYVagHMgKZW7JO4lcqm9Y2EGzEs5rozU6p1F7GMrsIiaUOauNItt0t+YAuznI9YeNDKx2s2SLX2FqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9smQbY8R9x8zdIQD/MLWyMHamZWO8LGkDerctyNNUA=;
 b=tYrsKFBley9phMYzSNgjpIqw971Rg/H4xUFjJ0QBGacBbRjrCybkauOozkKpYBHiKWZTtNzfmiOJj+Mj1CzRm95EBt3HAhzI6PhuzNy6lvcx/P6YDt3UypXWOkqzMC5yoq2ftZPVTOhTKprWEkkHw9QvyK4+C5Dg5fWcew8YePAUExaKkpJb93vs5flZaM3nxh5F8JhUdnfPqh8WLFYw+TK7we7vXSZg1aKe8wcT1YFYhi2d7QoVV98KTx24B4FFgHxEWEjwlzn9YUCd/4Gc8EDgmkXGikG1396Oqq9reDuB81s10LK4qct8A3f1wikEcOVWZFA/+ml/jOchj7zMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9smQbY8R9x8zdIQD/MLWyMHamZWO8LGkDerctyNNUA=;
 b=O4HuoTNz5vFhGRbi/HwV3LTB08IPfCSgZqhz6WWicQCVoDG45xN+TM/a11MuLwJcZKzgOjd9XjgiJDU7eGdHrCXsiHyohoNdOrkUXBYOrd09HkCeOugR9Ij0wypcl1L+JEOEBJ7wsYhMZwzGgIyVuDl3PtPpuyHGnowq0XAkFJc=
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by BL3PR10MB6020.namprd10.prod.outlook.com (2603:10b6:208:3b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Wed, 13 May
 2026 13:49:57 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::b1) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Wed,
 13 May 2026 13:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 13:49:56 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 08:49:32 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 08:49:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 08:49:32 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DDnWHY4165279;
 Wed, 13 May 2026 08:49:32 -0500
Message-ID: <b42fe4a0-a0f3-4773-be29-ac881c750799@ti.com>
Date: Wed, 13 May 2026 08:49:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
To: Shiva Tripathi <s-tripathi1@ti.com>, Ernest Van Hoecke
 <ernestvanhoecke@gmail.com>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, <anshuld@ti.com>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
 <momeoh6chz4swvgj3oj36p57os2cejpbcx37qyc7f3pydvwdlt@gaucmqmtpjso>
 <677d1d7c-8276-44f2-b563-d2b0d0a263ea@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <677d1d7c-8276-44f2-b563-d2b0d0a263ea@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|BL3PR10MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 587b7fd7-4376-48f9-12e2-08deb0f68468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: EOwj9Mq0Nk+W4ACDFKpduT0NCCHJTr2sra6w36dn8eeeCRdqhMKYImuSO8QPB5WVEykrkvENJGFexaClurHHMlgEb/vCA0e2rwafc7grM8oNJAcixkyk8BDQG7FSQbAzsqaMNYpB58nl5cbFa3cQazSs8s5usGRCO73Z2BviaE9oypCYrTc8EplzvdTuoulILYwABBay0ONz+9Fyc+6Ha1Vh2jzIbVDgy1Hau+rf7imVGkebJc8pLSwZfebMdQepWmu3fCJCZkUS92hQZbxwEHLghHhsdNYPfcZ9OjD9MvZwUW4ww1BHlI7p9BFQcZyyQNdx/FRjLgbSZMKA323vfm2u+bYlUJ6c0L1lOSIpBUYZXZ0UqZgSUmYMi6voAGr6cWZc/n8cSA/AmY/Y+HzrLWrcKpdOMUyjrYJUrsFTs64oppiZXJWhDuSPdhSf4/b4d2waytJ9nU3oyhG1E8ptaki0631i/NCzYj6LQbyXXJvzludrA9OJfTyljCvd0jqms/0dewB92cuVJ9ZTmaOKnRmSyuj77xMPB03pMyYE6iULyuvWJFFFaZzthv7HSvkFUG7a1QKCvIL5KBPY+ZNay0jIMKmwfOgY8cTVD/GtketCm65mfj8ILgxLSJJDKet1OFCe9tuArwQ6s++7DUsqo8I7WuYNSF6kcr3/X3bteuDb9Tb9wAu3o111tWltYDIQc311YcsvlNR63+c8+Pn5Q3kjWzLsRxDi1tyj01vFJ5I=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tyl3fKvonDG7pxDZpgZlo9qiVxEysR04m828V17RYpMGdymSpRFneEIdzKDDd+PBjeJTrfaWRgEE522VWl907oaru3tSLRKhvO+dDhF0rAxGvlW9eg3HICSb2ZZIl04zf5h13CC+l69JwHHsu9kscf1SqPdYET4X3mWJ+FOmH/Afda75f5A0ZSk/HR6Z2aY+BGepM9i/6hmtzr7PSCMwiRRPPD9l34P7aiYd964SBQ5I+DIhiuYyTEOUqpd+uxDVVcqExMWjrb7IMuqfDabFwUcjcJ7IONm8PaXihR2H6Bz9vGWkyu45BRMMIREtJoXIaXXY8l8Qx4YP1EIjekhrdGUGV7rtDYfzodIzVu2Ynmh9m24KPBfAbtQM0yFJAThIxJxrE+XoJqZFmuaktFXxVB1Yd6vfhwrVwHwtrb4S4k58dditfy5sM1+G16jB7IzQ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:49:56.1899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587b7fd7-4376-48f9-12e2-08deb0f68468
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6020
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

On 5/13/26 8:06 AM, Shiva Tripathi wrote:
> 
> 
> On 5/12/26 22:14, Ernest Van Hoecke wrote:
>> On Wed, Feb 25, 2026 at 04:54:38PM +0530, Shiva Tripathi wrote:
>>> Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
>>> MMC hardware. This provides TPM 2.0 functionality through
>>> Microsoft's fTPM Trusted Application running in OP-TEE secure world,
>>> using eMMC RPMB as persistent storage.
>>>
>>> fTPM support in U-Boot provides the foundation for measured boot
>>> and disk encryption use cases.
>>>
>>> The ARM64 condition ensures these apply only to A53/A72 cores and the
>>> MMC condition ensures fTPM is enabled only on platforms with eMMC
>>> hardware support.
>>>
>>> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
>>> ---
>>> Changes in v2:
>>> - Moved fTPM enablement from per-board defconfig files to common Kconfig
>>> - Added configs to ARCH_K3 (arch/arm/Kconfig) to enable for all K3 platforms
>>> - Added command configs to TI_COMMON_CMD_OPTIONS (board/ti/common/Kconfig)
>>> - Added MMC dependency to address concern about boards without eMMC hardware
>>> - Link to v1: https://lore.kernel.org/all/20260223091314.586968-1-s-tripathi1@ti.com/
>>>
>>> ---
>>>   arch/arm/Kconfig        | 3 +++
>>>   board/ti/common/Kconfig | 2 ++
>>>   2 files changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 5508fce796a..eb83b5c35f1 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -834,6 +834,9 @@ config ARCH_K3
>>>   	imply DM_RNG if ARM64
>>>   	imply TEE if ARM64
>>>   	imply OPTEE if ARM64
>>> +	imply TPM if ARM64 && MMC
>>> +	imply TPM2_FTPM_TEE if ARM64 && MMC
>>> +	imply SUPPORT_EMMC_RPMB if ARM64 && MMC
>>>   
>>>   config ARCH_OMAP2PLUS
>>>   	bool "TI OMAP2+"
>>> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
>>> index 409454813f3..149909093b3 100644
>>> --- a/board/ti/common/Kconfig
>>> +++ b/board/ti/common/Kconfig
>>> @@ -61,4 +61,6 @@ config TI_COMMON_CMD_OPTIONS
>>>   	imply CMD_SPL
>>>   	imply CMD_TIME
>>>   	imply CMD_USB if USB
>>> +	imply CMD_TPM if TPM
>>> +	imply CMD_OPTEE_RPMB if OPTEE && SUPPORT_EMMC_RPMB
>>>   
>>> -- 
>>> 2.34.1
>>>
>>
>> Hi Shiva,
>>
>> Do these changes mean you expect any K3-based board to follow by
>> building OP-TEE with RPMB support (and in production provisioning an
>> authentication key on first boot) now?
>>
>> I'm asking because we noticed errors in the below form appeared during
>> boot of our Verdin AM62P and Aquila AM69 now:
>> E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
>> E/LD:   arch: aarch64
>> E/LD:  region  0: va 0x40005000 pa 0x9e900000 size 0x002000 flags rw-s (ldelf)
>> E/LD:  region  1: va 0x40007000 pa 0x9e902000 size 0x008000 flags r-xs (ldelf)
>> E/LD:  region  2: va 0x4000f000 pa 0x9e90a000 size 0x001000 flags rw-s (ldelf)
>> E/LD:  region  3: va 0x40010000 pa 0x9e90b000 size 0x004000 flags rw-s (ldelf)
>> E/LD:  region  4: va 0x40014000 pa 0x9e90f000 size 0x001000 flags r--s
>> E/LD:  region  5: va 0x40015000 pa 0x9e980000 size 0x011000 flags rw-s (stack)
>> E/LD:  region  6: va 0x4005a000 pa 0x9e910000 size 0x055000 flags r-xs [0]
>> E/LD:  region  7: va 0x400af000 pa 0x9e965000 size 0x01b000 flags rw-s [0]
>> E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4005a000
>> E/LD:  Call stack:
>> E/LD:   0x4005b7b0
>> E/LD:   0x4008f220
>> E/LD:   0x40083298
>>
>> Interestingly this did not appear on our Verdin AM62 SoM.
>>
>> Of course, we can simply disable the fTPM until our support improves, or
>> ignore this error if it is harmless, but I wanted to ask about your
>> intentions before digging much deeper.
>>
>> Thanks!
>>
>> Kind regards,
>> Ernest
> 
> Hi Ernest,
> 
> It's not expected for all K3-platforms to build OP-TEE with RPMB
> support, some platforms lack eMMC entirely. fTPM is an optional
> configuration for users who need measured boot, disk encryption, or
> similar TPM related use-cases.
> 
> The Yocto SDK we release for K3 platforms includes the fTPM TA embedded
> in the OP-TEE, not sure if the same is true in your case.
> 
> RPMB provisioning is needed for full functionality, but even without it
> you shouldn't see these errors. Maybe the fTPM TA is missing from your
> OP-TEE build, or something similar is causing loader error.
> 

Given the above log shows the fTPM UUID, the fTPM does look to be
loaded and running in this case. Given a more complete log from
a different thread on this issue I'm seeing:

> Cannot persist EFI variables without system partition
> <error printout above>
> Missing TPMv2 device for EFI_TCG_PROTOCOL

This makes me think we are at the stage in boot where EFI variables
are trying to be persisted to some media, and when trying to use
the fTPM for this it fails (as would be expected without RPMB).
So this should be harmless, but why there is such a large error
printout we need to investigate and try to make it less verbose.

Andrew

> Regards,
> Shiva
> 
>>
> 

