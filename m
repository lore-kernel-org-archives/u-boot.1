Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D49103E160
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 11:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B4D84118;
	Wed, 18 Mar 2026 12:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TFkwN4bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7627784118; Wed, 18 Mar 2026 12:01:33 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F5B78405F
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 12:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oe8izJovuKHyETc5i3EZzDVlBBhDOnwpbwNn9Stb63v/DYEh2qhMhgKT+JstV0nqLXXuDrV+fcKrJp90Vt5K/C8nNn5tYFvXrV6AzxDxgwxyKVQ5sJ+pLWWRIrC8DbqQpe1IMBP3S4ogPKvY3+B+YnZOueVVGALoUPIlJQdXxj0jJJOqOvCvJn+uZYUMJKctmNDzNWuGLNj16+kE7hvHncbrj69FDN509jjImSURMC4MBERVqlqng8Es6dLmy4NOztJk8v2EumikE/2qUvzVKLI6blmodGeosr9dIARszC3ma5jNT+L1REBcHZF/CTK/jP8+YUnJlYpH4FsAgDkDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrKm3Dtgh4mQSJFFbEcb5r3mWhdosLynUp4fosX+Swo=;
 b=SQ9Jq6t3z3E6NOEYKelCeucSxicXuBdn9CRD6k8z//xiyndlLDYuPKyyuK4pMhJgevG7MVwJK7rv6QwgvTbhScf2Vr35dGUp9+dFz7lvnyKeHePDvN/t1bbWiHU/sufze/pkvLW5tn6pKZ3EB46ddTl56zIS2hovJJ9FjjI1rqvf0XpkLqz5MZt0Hh6/HrnzZHNOmugj5Gq8+Ua6+QFepTi909eUzeze8Tfbn97K4Idh73R4L7b1Lkorf7OhSiHi9e/kyaMxd7cM65Tb6OPrNCUQ9CfBKMw5H7vmc0w6oMdQR6qk6+ZIHjoQzbgZakLuj/nmTk4tX1cbS+V0cRM1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrKm3Dtgh4mQSJFFbEcb5r3mWhdosLynUp4fosX+Swo=;
 b=TFkwN4bc9JyrA2yI3lJJh3UqP38ZtA8wEnUoY82VA3FW2WvwjMGnuW9Sex3sLO1pyZ/0VZnYiHbu3WufHIB6+XlTMhEbzy++dDxy2pQhxTKeDOm/zmIjTQfDn7CWtCv1mGmRSK2Tq5C4F9SPHg1+DZ70hOdw5rrEK9UuXbkNXEQ=
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by SJ0PR10MB6421.namprd10.prod.outlook.com (2603:10b6:a03:44b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 11:01:27 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::71) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 11:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 11:01:25 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 06:01:24 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 06:01:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 06:01:23 -0500
Received: from [10.24.68.200] (hp-z2-tower-g9.dhcp.ti.com [10.24.68.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62IB1K66228593;
 Wed, 18 Mar 2026 06:01:20 -0500
Message-ID: <29730316-cdce-4ddf-852b-74b839459c2b@ti.com>
Date: Wed, 18 Mar 2026 16:31:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <praneeth@ti.com>, <kamlesh@ti.com>, <vishalm@ti.com>,
 <k-malarvizhi@ti.com>, <afd@ti.com>, <anshuld@ti.com>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
 <177317553318.23044.13643896894203476698.b4-ty@konsulko.com>
 <5e6a045c-5d5d-46e2-a7a1-1fd89ae64e3b@ti.com>
 <20260317140755.GY502704@bill-the-cat>
Content-Language: en-US
From: Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <20260317140755.GY502704@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ0PR10MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: a42ab10b-f321-4e91-4cb6-08de84ddb29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I+ukJyqU5LCaZHBnTfBUzlNyDK6Owe/05gjv2WkuaLn11zukPYHK6TiS8aH3mZCzcGonJ4k+jqHvtX/imPOQfFmR7nHGmUitGV/xHQ0BRFTxRJarrf3JVSQwCJM7rpAVaLbevRTVmHdlizx5k8b6MnAsAUZoFKa8yYpZtFO29Qc3inc19YdgSFrui3JuMU07DW3wE9Iu2T6wbXGt+3evulotuWKUFBwvGN4m/wFFhxNZOJ/pGxLrtI9NnQzYfD1rnJtiw3SigEhoE0+zqMQDgDG4egeXjATpkOByW/n4gu6fMt3HaADaVpJtgVLkNyTk9PMK76y/CWcwUz6JlPSJZlH4Acdi4falhkq58o6D4Q1X7BlU8qvywIepO0Ufmz3ZxiphyqFymWlVq8EObIqM+9UBRomxc4Uq3Fba3VTD77ZYMpdiksuIVFB2ZmuWNll/l4Dl1NFQUMPJozJ4wShtF1/MyHdDswY4sZm3ro1YW2iBfntp/7XnOSnoc6Je8QtwSF54X31QW3XluziqYWfS90rYRci3Nyf1hn/iHXWUK8VsZBDtxT7Xn2AiXMYZNCdvCL0lxHZNQ0A2xchTqWSapgvJWR8+jTnLEe+sz1QUTCz211rIGkZ9h1IefWWj3oEb12maG2C6RFFD8EStK9VCGrGJnj2JSPbOm5vFgulsfX4owIhF+ZZgGggoeBA/whJA248ofoTGHBNjVI4Pij2TcKwPjACYZgT4dXLJvMiiRuU=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HrTMq43+cBLRLMcRf78dx17yi20Rk1jPsEXKP6X5JbVXlJ8zvByLwQeMt1wobzveEXSizCZUDOCgEL7lSEaYf/v3N9ledl2wpVY1fPfdS7D8s9fAl6elnz9+N6gdslCE5xQJ7komnlUQ2VD+VV4jCrdLrsRWWDskBOYb0ziO6qWdZdhLVCNQXNVclw0XsccDNITl8rDrHlbnONPX/PWupC8H3wEF/HuO90n4FwIMB9eNu2zTwEy3xOg40Zn1h+O05gF7TD+QNulQ7dqAK3PZ7nM52Lri8ITBX7aj+F1UB0QhORRvEgolFZLyvz9HS31c4ZIOKjNrz3jJxnvAKAbjWDdDpRjZ7gXSpMgXRVPBnnTAR6SB03wnQUKW3T2i06HQnbm4FfFAbCAPaNjPJGCEv0/IAxc+2BNiYsS5pYZ6bkw36AjlvtTvpiKyjo8xnHa9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:01:25.1157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42ab10b-f321-4e91-4cb6-08de84ddb29b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6421
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



On 3/17/26 19:37, Tom Rini wrote:
> On Tue, Mar 17, 2026 at 05:04:29PM +0530, Shiva Tripathi wrote:
>>
>>
>> On 3/11/26 02:15, Tom Rini wrote:
>>> On Wed, 25 Feb 2026 16:54:38 +0530, Shiva Tripathi wrote:
>>>
>>>> Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
>>>> MMC hardware. This provides TPM 2.0 functionality through
>>>> Microsoft's fTPM Trusted Application running in OP-TEE secure world,
>>>> using eMMC RPMB as persistent storage.
>>>>
>>>> fTPM support in U-Boot provides the foundation for measured boot
>>>> and disk encryption use cases.
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/next, thanks!
>>
>> Hi Tom,
>>
>> Thanks for applying the patch. Following are the steps to test these
>> (I'll soon update the relevant docs for this):
>>
>> a. First step is to generate fTPM TA binary using ms-tpm-20-ref [1] and
>> optee_ftpm [2]. I have been using yocto to generate this fTPM TA Binary,
>> for reference, the binary I used [3].
>>
>> b. Second step is to use above fTPM TA and build optee-os with RPMB and
>> early TA enabled:
>>   make -j$(nproc) \
>>        CROSS_COMPILE=arm-linux-gnueabihf- \
>>        CROSS_COMPILE64=aarch64-linux-gnu- \
>>        PLATFORM=k3 \
>>        PLATFORM_FLAVOR=am62x \
>>        CFG_ARM64_core=y \
>>        CFG_RPMB_FS=y \
>>        CFG_REE_FS=n \
>>        CFG_EARLY_TA=y \
>>        CFG_RPMB_ANNOUNCE_PROBE_CAP=n \
>>
>> EARLY_TA_PATHS=/path/to/bc50d971-d4c9-42c4-82cb-343fb7f37896.stripped.elf
>>
>> c. The optee binary can then be used to built final u-boot images,
>> testing logs for reference [4]
>>
>> [1]: https://github.com/microsoft/ms-tpm-20-ref.git
>> [2]: https://github.com/OP-TEE/optee_ftpm.git
>> [3]:
>> https://github.com/shiva-ti/ftpm-binaries/blob/main/bc50d971-d4c9-42c4-82cb-343fb7f37896.stripped.elf
>> [4]: https://gist.github.com/shiva-ti/8ac6aded2bf0a3c9bd99627a45b50f6b
> 
> I will try this manually when I have a chance, thanks. Please update the
> generic TI K3 documents to include this as well, too.
> 

Yes, I'll update the TI K3 docs.

In the above steps, I missed mentioning the eMMC RPMB must have
authenticated keys programmed for fTPM to work since it uses the RPMB
persistence storage. "CFG_RPMB_WRITE_KEY=y" while building optee-os
enables OP-TEE to program the eMMC RPMB with authentication key on first
boot. This key is derived from the HUK (Hardware Unique Key).
Programming the RPMB key is a one-time, non-reversible operation.

Thanks,
Shiva

