Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E721C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 11:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F4C87EBA;
	Mon, 12 Feb 2024 12:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sksxz7bd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131CE87EBE; Mon, 12 Feb 2024 12:16:38 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E9F879DF
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 12:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT9JwNyMsN37QXmup4m99HQiZHfjJoI1a1w4bEnvtf3qYkdMLQgSbVxUeSMadfWTFANI4bAY4zz2BiBpPJv3UYzvatdk59phAumg8c4whVdPWBPd+oDvh7V1e1Y46j9QldHQaDuGvIBUl8himLYsERxAIaFPd73yFmAg85VU5WgBE8xBbetZkd0Wg+3MBvsm6ZbFrvpmdHenlbCrb/tzalP1odPXhLMu5Gc5wP+x/a/1reLDvB8KvZgdMk/eJNH7kFLkkrr+8YpKIL9gmrOCQtt4Ns3qy/Z77eCde4cjGdH2pCdZ3wQITcJNJG9BYXx2l4WS6uknuZ8o+hWR4agtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWPfDV3Nf8446EM4grPiOmFjjkLousGgDDwGn9E/BeI=;
 b=iaegU/vyHwjFOD5PSDh0eWSYv7+O/uDL1kkPvV4l+9JaLRlK739PwFbZZNrbeqnvzH3s5R+2cgxsm6VaiWW59mZH9yXo8maZKS+t5kkMA/iHxtKymE7ijAEVK809nHPzBVnwqpNRBeOum/kfr0dV0+es3HunkDZ7j1mYZSs03iRauIwrel3PO5edIT+g731nn3aeplPFdxDSZ9wfnrTqY1ktRtVGuloi7MHSrmxND/R6CEjFtHzfFAcSC3Zvdw81NtE5e3qwYaH9wW77waWjBOfAQ3PJtr8y3EqgZWKm87lDPKv94oxgxk2/MjbY12zE3N1Zv3uO9z6GExm/epR+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWPfDV3Nf8446EM4grPiOmFjjkLousGgDDwGn9E/BeI=;
 b=Sksxz7bdFSMpWpFmjKVKT9gCm73gaN1trOcKMC0ixW5Mw0vkeHiLQPK8onrAxmlCthU/xcWXx0bNSTp2cvaVl2f5jPXiNUNYVs43vuVxrU+bXy0dxzjDo8lqnVXeU66aQYtd/1ldRokbVocyUPzgsVkSAWuBXvoUneXCNADD2cU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 11:16:30 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Mon, 12 Feb 2024
 11:16:30 +0000
Message-ID: <b1edfffc-21f7-429c-a250-31c13f1141be@amd.com>
Date: Mon, 12 Feb 2024 12:16:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] armv8: crypto: SHA-512 using ARMv8 Crypto Extensions
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Loic Poulain <loic.poulain@linaro.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Marc Zyngier <maz@kernel.org>, Tom Rini <trini@konsulko.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Simon Glass <sjg@chromium.org>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
References: <20240212104500.1098004-1-igor.opaniuk@foundries.io>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240212104500.1098004-1-igor.opaniuk@foundries.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0263.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::36) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: a493967f-4ab8-4bd1-7d98-08dc2bbc0fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4n8OG3+ZoLtQH+B9dddUfbTXLIY3MPyVz6y38Spi7yoDIPdjluRDWb078BQC/6/tvFOwc59j3FZchTEFWhs/zCwmcF8+2ZD+w6SA7PE77l7oliasUeT+LlVU/k9FbxLSOglYbXhgMcb8uObS4gLzSIBk2MhXzNKXKXR0hszufjNkQTis6bBoe4AoKPW7tepHHTFF7/Pvw4B8KrrBznNoho4qTHanwd/tRC8bFcPF5aNyzQJu8jhDGlraan+JFaXnkIG3DKQhAR8iSTtStOuISKbuQn2AkxXYCJQl0yogVGk2BhdBCO1oouAG24+dwjXIZmMqoiU2fn83MvQvt6JxDB221Sz4T0Ne5wAN64ilRrubHHVhQBAVRFeJRZ/ORXtsocUq8nXllmalj7xdcShbSlP20RAFNlpIW9xOJtDFFePcByApJqQW92ZcRHJFsApP2C9C4H3PoBhN3fHzaCPMw8syX5iTGIu7fMGyg2pHATtPorF7dz02CBUQc59j8ofLBOThRN5hCVZZZRG8R2ZMBFWsG/ZY7uG3hEpKsJli9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(86362001)(31696002)(38100700002)(966005)(6486002)(316002)(478600001)(54906003)(66476007)(66556008)(66946007)(26005)(2616005)(6506007)(53546011)(6666004)(6512007)(36756003)(7416002)(8676002)(8936002)(41300700001)(31686004)(4326008)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEM3bDFaZVErMFJqc2l3UGRZWTBVQjg0SDlvQ05xUHFITEswRFpyQ0poUFlI?=
 =?utf-8?B?YkxBakVRRVYwam9yeHppUDY3WTdtTzFFQ1NySEVQYjlzU3VkZGhSbDBOVEJn?=
 =?utf-8?B?V0VQSjZINTk4Nk1yOUxTcHd3czk4TGlMc2F3TklzVFl3R3piNHFUbVVMR1NE?=
 =?utf-8?B?ZHlwRmRnNUJBK3NjNGg5L2xhOVBiR0VuTDRZV3hPQ3pUNHNCT0grU0VPN2lT?=
 =?utf-8?B?RmpVUThVbk0xZm9KVlBjTmYxNW9zS2k3T2pLNlhHbm04TFJKdG9jSlp5WFB0?=
 =?utf-8?B?YjZWYmFEVzRTQ0lnalVpTXQ0bXM0d0k2VHlsYzh2NVVhVllyS3QvR1NJdHll?=
 =?utf-8?B?UldLL2dxVzYwY2srRVpNM1RrRERGQ2VxU1UxU2hlY0FYKzN3bUJ6bFlodk05?=
 =?utf-8?B?eVFhVVlOa0FWQzBXWXlnOVViQ1dmbVFTazBFaUNGMVV2bHlJTEFCUUtHNjEv?=
 =?utf-8?B?OU0vaTBqdGpGSm94MzVKbkVVSXhob3ZQSmhzRmhRN3grWHlKMzhiUmRZNWFt?=
 =?utf-8?B?SUp3Vy9GVVBRRmNyTTBxSlZidzVsMXExaDdvM0ZMeXl4N25YSTQ3dmpscGpz?=
 =?utf-8?B?THdqU0lqVGQ4dm5PdUhvaEV4aitHdGRnYzd4L0NvSXJIdHQwTU5BYytITzRO?=
 =?utf-8?B?VTQreDRzSEtEdStpS1FNRjh1RUZDeWZJYWZsVUovdUJPS3AzWi9sM0VKM2h6?=
 =?utf-8?B?NElSN1FrSFVMVXJWbC8zamVFMGg0UWMzZW5tdDVQZFV0c3lVRE5MbnVHZVB4?=
 =?utf-8?B?aWNUL1NteWdNZ3lNT2VzaDgyM0tXOHNuNnpnY211T1REZWUxOTJ4UFZJVzJu?=
 =?utf-8?B?VjdOcE96NkVQOU1ObmZQcDZ5LzJ1R2dXUFo5Vlo4T0E1TDF3Vzd5NG5La0Fz?=
 =?utf-8?B?MGpPeWJySVVJT3M1ZEh5UG5ZSmZ4V3RtV2dlM1NQbUxkc3VCQ29hTmtKbHpi?=
 =?utf-8?B?Qm9tTDFZMmRIQzcyejUwc2Z5ajVxYnNrN3VyZ3Z4NDhFYkMybzhrdk1zUEJF?=
 =?utf-8?B?U2FYQ2N1THhDSEhxMGJUM1p3YThRN2plNjJvM1lldVY3UlJxM0gzZ3dUOVRk?=
 =?utf-8?B?cTFHamwybTZ6amNuT1lBSHFBQmdIV0UreXdWK0FUb2JuenJLMWk5S2hpLzQx?=
 =?utf-8?B?VVVjanJYNTdIQkdVd1g0V1ZFOXNDVFBmSnVMRHVrTVBkYyt1dm1RQmM0N0Zy?=
 =?utf-8?B?eUhqT09JTkM1QWxKdEMwTEtHbEJnRCswR0ZablFDZDR4RDFGNVBsYzZyVXp1?=
 =?utf-8?B?ajBmdG1PQjVSekZSQlhKWWlNa2kwTUl3cnhEYkFkQ1psNVhvR05SNUZ3Nmty?=
 =?utf-8?B?WkJTeExVRXpSUWpjRXMzZi9IbkV0MVlZdWRuK3UrVG1KVmN5SG5LK3o2LzI2?=
 =?utf-8?B?a1ozTzBoUHUycWgyOFVIaHhXUHRMelZmeEhRa2Z4dnFqaXFQOXo4Zk1hblZn?=
 =?utf-8?B?aU1mM0dtTzV3MUNqL0pFZm5ucXJYTWVDRzNKNklHNzBmSjE3OE9MMHl3YUMx?=
 =?utf-8?B?RzVKOGZVZDVuZmJ5dnJBVXhlbVFpYkFxUUNmaEtWb0UvYlBHZnBhMUNSM2Iz?=
 =?utf-8?B?SExYQXNjQ2ZlT05EL28rVi8ydUdHUHlmQjdROWk0YTRGbEFhQitPR2NXTnZM?=
 =?utf-8?B?UUNTUDMwc0haeWpkdFMyYkM2NDY3ZUEwdXo0NXVmN2JlTFZMbitIcURkLzNh?=
 =?utf-8?B?NzVITTBWQ1J2UjlFYlN2cThaWjJhZ0w2akhmTUVuQVd3eUFnTW0rb0RxKytK?=
 =?utf-8?B?eHljTnhxK3hSaXNGaXgyNXZ0Qlh3L2Jwd3pmK3JjSTB6TElYTGdobG8zaHY5?=
 =?utf-8?B?WE9nbnJ2MWJzUGhLQUtGdWN3OW53V0gxL2N5NG1qcjlUWGh3TjEzR3c2R3pE?=
 =?utf-8?B?UEpjcFJwVHRMRFNUa3N2QlRzcldFYllWb1hyclFsdmdnM1dZTE8xVkk4OEhZ?=
 =?utf-8?B?M3FJV1JYb0NQUW9RWXJhTC9EK2l1UWtLZVZSc29aM0o0b2xybEg0UDA5RzQx?=
 =?utf-8?B?cXNSZnc4UE9sSjd0TVc1OElYUUNPVjZ1clBGbDJESWVWc0ZsRVBWWmwwN2hi?=
 =?utf-8?B?U2pqQXhlSWEwL0wrVkRoZlR5bUVYWkVjT2N6RXphYXF3K1J1SFpWNkJRZGhy?=
 =?utf-8?Q?e8Yj00PYsIC7J9/Mh42y51Trm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a493967f-4ab8-4bd1-7d98-08dc2bbc0fb9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 11:16:29.9441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7yMK5jgaQ8JApLW2gKEYTHPPVNMMZBKpt1m1/Hfr9FRrXr5bI6d6CM/BKjv7oBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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



On 2/12/24 11:45, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@gmail.com>
> 
> Add support for the SHA-512 Secure Hash Algorithm which uses ARMv8 Crypto
> Extensions. The CPU should support ARMv8.2 instruction set and implement
> SHA512H, SHA512H2, SHA512SU0, and SHA512SU1 instructions.
> 
> This information can be obtained from ID_AA64ISAR0_EL1 (AArch64 Instruction
> Set Attribute Register 0), bits [15:12] should be 0b0010 [1], that
> indicates support for SHA512* instructions in AArch64 state. As not all
> ARMv8-base SoCs support that, ARMV8_CE_SHA512 is left disabled by
> default for now.
> 
> Validated in QEMU for ARMv8 with compiled-in SHA-2 support (because of
> absence of hw with ARMv8.2-A ready SoC at hand):
> 
> => hash sha512 0x40200000 0x2000000
> sha512 for 40200000 ... 421fffff ==> 1aeae269f4eb7c37...
> 
> The implementation is based on original implementation from Ard Biesheuvel in
> Linux kernel [2]
> 
> [1] https://developer.arm.com/documentation/ddi0601/2023-12/AArch64-Registers/ID-AA64ISAR0-EL1--AArch64-Instruction-Set-Attribute-Register-0
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/crypto/sha2-ce-core.S
> 
> CC: Ard Biesheuvel <ardb@kernel.org>>
> CC: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
> 
> Changes in v2:
> - Dropped "Default n" in Kconfig as Michal Simek suggested
> - Adjusted commit message about QEMU validation
> 
>   arch/arm/cpu/armv8/Kconfig          |   4 +
>   arch/arm/cpu/armv8/Makefile         |   1 +
>   arch/arm/cpu/armv8/sha512_ce_core.S | 210 ++++++++++++++++++++++++++++
>   arch/arm/cpu/armv8/sha512_ce_glue.c |  20 +++
>   lib/sha512.c                        |   6 +-
>   5 files changed, 239 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/cpu/armv8/sha512_ce_core.S
>   create mode 100644 arch/arm/cpu/armv8/sha512_ce_glue.c
> 
> diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
> index 9f0fb369f7..37b8b60914 100644
> --- a/arch/arm/cpu/armv8/Kconfig
> +++ b/arch/arm/cpu/armv8/Kconfig
> @@ -204,6 +204,10 @@ config ARMV8_CE_SHA256
>   	bool "SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
>   	default y if SHA256
>   
> +config ARMV8_CE_SHA512
> +	bool "SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
> +	depends on SHA512
> +
>   endif
>   
>   endif
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index bba4f570db..3894f2bb2a 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -45,3 +45,4 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
>   obj-$(CONFIG_XEN) += xen/
>   obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
>   obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
> +obj-$(CONFIG_ARMV8_CE_SHA512) += sha512_ce_glue.o sha512_ce_core.o
> \ No newline at end of file

Add that newline here.


M
