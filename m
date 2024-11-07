Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F4ED5AE71
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 08:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C50588A9D;
	Thu,  7 Nov 2024 09:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="MR/LrzEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5873A8855C; Thu,  7 Nov 2024 09:52:32 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE0088A9D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 09:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4u87zBAYNBF/7ZtX1PauctI4+ncmCzqGIfRmmP/Y3rlIpbmkNlJtXYGuGaG4donMUtDP5TsNcTRtad3t/UCjbR5p5g4K+qKH82RnCQRCYSsIgNz0bl7dNFRGCRhLGar3kNB0nFSNQgAnmlzuWhHH2nW0y8dbFAuQ/Dk4ZzzCYSW9EEgFxhNcjMAlamEPVQrlgaHtOt0m9qTS6Wt7GjHB2f+nu7/GmczkJTx320OWBX1pB8v1cejCZodIyddBIjFAvlSItjAjTtmoPIt55gGQS/cDpw6LP/HHA1om7OTvN89FoL+Ebvatw1a/ejIQJms9uNx6WyUQxRS7/BdQ+5Tiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKimYKU+vlWgxtt4htfYXKchclE25ZDUY/oxECCjzx4=;
 b=yNDvq4h9vjLyK9UR5uw33MZ4ykBbQrV+PaU9lz0NZUB+lNy8G8uNwE94o+IPEoEeRuD94J1SwwYnE6NrfmX3q7bvF6pAcY2+D4t3NHsyWPdNDTWquVkBxwoyVDQAG5k4x+Gu1hpIFPcK65urBVtPnEYlF0BHL275fg/NAte6MTmxILAlI1TBhRMVnVw9Os7k1DKNL+5IVsFXyYuaGRbMVLAfDcqLfxDfmBi7nmI5qrJRDjSDxJ7oVsmhVo//c58vGIDXSAS1N+JzGWoniZnInG4DZZ565b5FIvZFYWFKggxemkLlfXdPbY0uMn203DyIPtqyRAMnUdXP+hw8KJnTog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKimYKU+vlWgxtt4htfYXKchclE25ZDUY/oxECCjzx4=;
 b=MR/LrzEfhEsJgSMoNTHYubVxd20gPDDksvvxR2QzKMisI1M2Q0Jov0mdSoY1p9nKYsjk6t5qw6DAXu4vVAeDd1BGgRy7LcK4dFzOqAcB4WvRVsiWHsdSMSdWhh2XZvMJEpg4cw3FrlqfrNrUoHgEJ47xQuDX1onNa+Z3RgY09es=
Received: from DU7P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::26)
 by DB9P195MB1611.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:37e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 08:52:27 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::3c) by DU7P191CA0016.outlook.office365.com
 (2603:10a6:10:54e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 08:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:52:27 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:52:26 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:52:25 +0100
Message-ID: <34054407-c686-4ebc-bd38-77ddc0e89625@phytec.de>
Date: Thu, 7 Nov 2024 09:52:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v2 2/6] phycore-imx8mp_defconfig: add optee
 load address
To: Yannic Moog <y.moog@phytec.de>, Stefano Babic <sbabic@denx.de>, "Fabio
 Estevam" <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, "Tom
 Rini" <trini@konsulko.com>
CC: Manuel Traut <manut@mecka.net>, Tim Harvey <tharvey@gateworks.com>,
 <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yashwanth Varakala
 <y.varakala@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-2-bbc3747a60e8@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-2-bbc3747a60e8@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|DB9P195MB1611:EE_
X-MS-Office365-Filtering-Correlation-Id: a99608d9-8436-43f0-b421-08dcff098194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWtrRDF3cGJ0MjJseForTHpxSnVwaEdDb1JVQUw3KzV5RG0wZVV4YVNTL2Nu?=
 =?utf-8?B?TzhpdnJiZzJCYlZjRGJ5bk9STS9veDRsVmdBbmp4dXJEOTFsc0NxKytFSldz?=
 =?utf-8?B?aEVHYXZCNkdvU1dIcjFyb3liYmNpYW5ld3FZamxEbzhNMjlnZTVNV0kwRlRz?=
 =?utf-8?B?M0tpRDg5MUZJOHFOa2ZnMjNqWmZSeG1qMVQ0bS9rZmxjQW1MMktKVWlLL282?=
 =?utf-8?B?dWYwVXRBSkhiaDVJRXhZWDgrNDNoUllIRmdUQVVSeGF0MndaRTVpVldaNkZ4?=
 =?utf-8?B?dnZoUDl1dXhFVUpYZG12Qmpab1J6Mkc4aEYzek5WQW54VXZKMTVJaVZXOTVx?=
 =?utf-8?B?akJCUUZKVFJwK0hFUW5EKzZUT3FKeWRTVWM2eUVPOXhFUGNLb3J3cUhaWnoy?=
 =?utf-8?B?aGtTdnpwbDhOQUN0TEgzUE5aWlVNdFFhYm9ndGczV2VXTmRYV3pKRkx3aFRo?=
 =?utf-8?B?QUpWN2tzdU00TENMdTErcjlqeW1uUDNlY0EvMjBoVFBpQ2NmU0t1Qlhxc0o0?=
 =?utf-8?B?cUltb2Rwam5LN0NZZmhya2FZSlZqMGhHUC9GWStpQ3FzREZGc214NHk3M2ww?=
 =?utf-8?B?WnFtRGdtZHFzV3hkY0oxZjBWbVdjZ1ZLQzcwcXZMVTFmZSt2VXRPcnZ6RWVu?=
 =?utf-8?B?UytmVHBJRzdkOGxoQ2RuV3JtRUVSWWUwV1lLajVTN3RtNTlDKzE4MEdHYlR5?=
 =?utf-8?B?WFp4T0R4disxZ3JzdVFaL3RMTGUzWUtZbU5YRU51Rk1SK3FzRnYvQUFYUnhh?=
 =?utf-8?B?RmQyLzRRSzhnWGlGQWNsdlgvOEY0NUt1RGl5MG1rZWdXRUtkUzN0cmFybGJk?=
 =?utf-8?B?VXhHaEJsK3lIQldzM2tyaU00YlppSlBmU0YzZlNHQll1VVlJWVloZnVrTVR6?=
 =?utf-8?B?VlhpQzRSVi9BYTk5ZXAxZmwrSkJxbDdrc1dtN0x1cUdoQjc2dURPVW5pRG5B?=
 =?utf-8?B?bE12SDhuU2pSSEF1eFBMWmZBVTkrTjdRcG8vRXdTeW9rLytUVkJjcGJJci9p?=
 =?utf-8?B?eFJDQlNUMkR3aEpScjlVeFRydXUwdUtkR2IyQXUrZXk4N3JDRUlnbGFwM2Zu?=
 =?utf-8?B?cDdqU0QzNTdISVJsWnBQYVYvY0I2c2lJRDF4ZUJDVit2cWEwL0pSNFp0S0xr?=
 =?utf-8?B?T0YxTnpnUERYRUpXWHRsMXdpcVlCai90bTFxU3hId0pUNi9UVGJ1RnVqVW14?=
 =?utf-8?B?OXNhWmdmTnhPcXN2QWtXSWJsQTROaWxhVXhGNFZ6M2ZaNFphQVVvZlJUZE53?=
 =?utf-8?B?MGJYODNpTk8weGZzaEtlY3krbTc4RUNCWExPYjJ3VDhqaGV0VEdYREpnajRS?=
 =?utf-8?B?TFhqclg2aTVEVGFNS2o4SkdVS21hUEU1a0VyUWNITTE3S1d3a296dHNYanla?=
 =?utf-8?B?eWNyL2tvUXcva0tRYXQ1Z2ZlNGw5WjR5aWd0Z3A3QlFXMTJwRWQ1NmpiTjdn?=
 =?utf-8?B?aHljVjNSTEJoYmordXFYZFpaRzlYNVFqNEh3dXZudVArNjB5Z1M1THJ5WXdX?=
 =?utf-8?B?dllRVk5WRGNzMldGakJhS2J0V0x5TUoyVTBXUVhZMVhJUCt4ZnpFWE1Ld1Rw?=
 =?utf-8?B?SVd4dFM4NzZpQlhMOTdBMk50VzFqRXBxMXdLZlkzcmtoV0RWNHlvVGdzL1dw?=
 =?utf-8?B?U0g5c00vWGRZVU5hcDExOFpsRTFhcFUwRVVZeDRHQjdrRURzR2Y3RWFrMlo5?=
 =?utf-8?B?a3pZa1RvQkt2bEFrNVpBZThldnRMbGZyWjBEdjFpSVBCaURuUis1OUlwd2sz?=
 =?utf-8?B?amtZSFU2UlQ2UDlzaFRwTmRFc0Q1VzYyM3pycUI1VzQ2RHo1cGlTWEpSSGw4?=
 =?utf-8?B?T2s2Slh4UGFVWS9ueC9HTng0YzZLVVVwRzBJOCtGejlITk55TVFYYW9TVUlW?=
 =?utf-8?B?NHNaRlpER3FZTVgrVC9ONFFaVjg0WVhDMVYvMldtTHJwT1E9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:52:27.2937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99608d9-8436-43f0-b421-08dcff098194
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1611
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

Hi Yannic,

Am 07.11.24 um 09:23 schrieb Yannic Moog:
> The phyBOARD-Pollux expects 0x56000000 address to load optee.

You are already defining a default for IMX8M_OPTEE_LOAD_ADDR in the 
mach-imx Kconf. You can drop the patches touching the defconfigs.

Regards,
Wadim

> 
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>   configs/phycore-imx8mp_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
> index 1240c7fcbd0..910109afd80 100644
> --- a/configs/phycore-imx8mp_defconfig
> +++ b/configs/phycore-imx8mp_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
>   CONFIG_SPL_GPIO=y
>   CONFIG_SPL_LIBCOMMON_SUPPORT=y
>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
>   CONFIG_PHYTEC_SOM_DETECTION=y
>   CONFIG_SF_DEFAULT_SPEED=80000000
>   CONFIG_ENV_SIZE=0x10000
> 

