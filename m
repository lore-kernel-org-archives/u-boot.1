Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57F4CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 10:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435DA83FF5;
	Wed,  3 Jun 2026 12:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UmdF4i5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46EFE840ED; Wed,  3 Jun 2026 12:12:16 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112AE839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 12:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dil6qID+m5kDe4bFFvtYuBRqulGJh5YECDk1GcEJfIUZEBXbRtjN6Mh9EpjSld4GiNPRwMHfC4mDw6Xt0bJSL09sRoPxUu1/wRAa+DyHH8wNfUryc71vjQZAtCTdZJjo6D8Yk5aVrDBKaR18K9emITZEykuF7EmloOdhrO9hMkxXfYLBgcKpFQL/nbCaBrSIdMkivZhxidJwpVXEY7d9cu4NBPymL8xxgsQoTQEOLyMiU6zGYFz3jf9Oo3UleW5kB156yESmRQ1dqG8mAp3U71yCXnCJjLPBE7Fq0+IBM17y9tKA5F6pHt0mtQoRXaCYqf5+L4+xhMPV3d/s3swcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atGWIF0pWPnUHvTWVwpuZ3VfikPamITav9xdEIXJZfs=;
 b=sBC4qJrymgEuBvAWQCdNXDlqaXuRGUbOqx5LvbYvQmo1wP4lcvS6O6pGbZtRmXZLItXgdFHv2fT3YOdk8p78bxCkaSOfvhrhmgRhhyS9VJKBMxQQIj2DwdQkf3qmGBc2cOv0/kcfBNKciuTavwW5pAuEHEOP4BMqyN5RaLmZMn7kMOoUMPzCyFw086l9VpKuEcqfaQKHk4NUIgP7YYNxKQmKOh2EwGs6XAKu3Gut0pkaSp8ZlvlidySfLodSanX9O5HQPvIG2j9P/Xdvs7XukhHhxoPyRWFBPzjpH1vIg2ukQElX97q87fdNUEsGfMvha0qx9kGdyLcExPqC1/ON3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atGWIF0pWPnUHvTWVwpuZ3VfikPamITav9xdEIXJZfs=;
 b=UmdF4i5z3y2CM1dcIIcza+Fse5vVjgnci2DtS8Qq91vEv8ahs4i578vs9FLCom0MS6qvUhDbHkB8xV3+jAvzqY6EJuOC517m5YvVr/d6VtGhb0kZxJ4QMokVvN8ZJoC4sa3Iv8vgjeeQjbEpQZzwFjz9JY3j6Xlg4Vg8dMTpySzt8EjiSrpHZz4zZO8yYrdhoT5POR4kpwFrxC6bBE1E2OJb4TysFaNg20+DnM/uF/wL5fSiTGr3u4BX7Fse9urmO8A2J2d7Qm4FWKV3B11gRXERniM8Clrppgx0orRXgkXKXS9CmmLoWw6nLQhPdp3oTg2W3Wa3spyXvra8mTTkuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SJ0PR03MB5696.namprd03.prod.outlook.com (2603:10b6:a03:2d6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:12:11 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:12:10 +0000
Message-ID: <ffb78fdb-4651-4166-a821-269f71edbbc0@altera.com>
Date: Wed, 3 Jun 2026 18:12:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
 <20260512064957.32497-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260512064957.32497-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SJ0PR03MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a45b4dd-365d-4787-7426-08dec1589306
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ml9gpX0Kn71//OMJFCYskXxbgrWYLAgg+la7gHSxH7hAIkN9ESdiWfNkIxPsgHqEHoPAUzFPWv8hZGrkK1wmuvBDNfeUUGl5lne+G1nmLYi+eStyr3ETqDUWCk28bNE3PN+MIRhjRT2U5Vibt85AklB+f3H1ipr89WkRxY4uFaCf0RFnCpDXzm9BoN1tGbdkXrFAzKHVeHUanWfsCdYaiRcFXmIcbgg0ogsTVFyEnG+3J35t/pNwq+U454HPas4jlPvhE2fxi4Hq3aPAvpLl8o8OSKGwujKGQOwBoZiRpF3or9k919H3gnJPMaEN3DOHRNpVkaamtu9COAbjmQYIuyuOUmYvG5sqX9UwEEh/YBSJ65jm4ZpIe2hmWNE/GnvAl7420KzTdtf9GxXtqrp0d97vOScCoUZUFOm/lq9zlJmhrhRNpzP4vsLlN+jjeXGqlT/9EkPnZy6wSNIVx4oUohSRnbm4HlcKHkj36gAbnKCCBXLWMvBK07gv+TmprARK4NidMC02UTzvwfIiQBOJAax8Jl0xLPvUJjmXEoZYgevyKRRSTsRIGSR9i/wQ0NXBfAI5iSEQVQZVUg6FTicYJCY2Oz2BHbJT4FNq4t6FwRO8WGDK2FrXmvuJFVMnfC+6R8gNvIA1tahmFb333AukjXqXd7jvJdg6++X5wmd/zOPI1OWCHa9lWKoQdA3D+7jO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGs0YmlHZE5HNXpsbnFiYll0a05UdGtMaEc2MmJ5S1plTm03cGlVekVFcGN6?=
 =?utf-8?B?UE9wdlJuR1ZYZk1TU3IwM3llbUp0NmpodzNyZ2lmY3YyOE9URk45bVNPeDh3?=
 =?utf-8?B?TVpSWkhjRUVqZjNCSnFkRS9yd0pFbUpjcmFybzVFdjRkWFJQTllmKzVUQ2Zp?=
 =?utf-8?B?L2hWdXZvaVpydzJDOEVxY0Vwd3NGRXliSHI5ZW1PTHZGcDcwbHA5TDczbDV0?=
 =?utf-8?B?SzVEWHZEdkU3VmJGSnJGK3ArelNpakRyckpxL0xFS1pQLzFjZyticmZHa21p?=
 =?utf-8?B?UUN2ODJCMExzc1VsRlM2VFpkVzJINGMyR3dzVFFOdTFhVC9URGJtbGJXWlI0?=
 =?utf-8?B?OUpURGVZdFBJRlAwMWpHaisyUVYzVHZYUmF1enhxVTY2dXJMK1JSaTRCRG1V?=
 =?utf-8?B?eWxxTDVUeTZYS2h3Wlp6MWUwNW1sUTZnenNrZkc4Z1R0VzFrVFNsMUhqcE8v?=
 =?utf-8?B?VXIxQllqd1g2Q2NQUGt0WVVkTTBmRW12NFVJc1VtcUpER0dGZGZlNTJsb0NK?=
 =?utf-8?B?Rm14UzZvMUtLVnBBeFdJNWN4VWJDMit4YnZRZGlKbmkrbFlsQmFZdWNWMUlw?=
 =?utf-8?B?TGZlWG1OeHFtTzU0UVhjTTk4NjNuNTZkNWpaOTluQ2poSXBYZ0tzUkFqOWlK?=
 =?utf-8?B?Q0F6VHY2SWErVmd2Y2crQXEzZGdrOU9lbGRkWEZ5NkxEdlVXeUZMbzRubGYy?=
 =?utf-8?B?bmZORnJ0T1FYOVZCNjJMY0ZhVnpVZUxodXJ4VXB0L3VHamo4WXFQZzBkZUlL?=
 =?utf-8?B?RGhYWTF1UnRYbmExdDlZMm1RRXdYOXdjZVRvTVJCa2xhRkhnekd3N0tyNlRs?=
 =?utf-8?B?Nis5dmcxTDdPK3RBdlF1YVhRSytLZ1EwbEZiN0FjZjQxV2RrbHZzR0RkSEVt?=
 =?utf-8?B?YWx2dUJHZno0YXdlM1lLL3l3dWpuaDI2WFMzV3p3N05rVVRsbW1HQnJNc2xY?=
 =?utf-8?B?bWlJa3NaK201WDNta3hvUnVZNnRwSUJscWFjVXQ1VEMvQVFNVzlMYms2bndB?=
 =?utf-8?B?VzRKMDJFdkhXSkN5VXE5TWZ4V1pPc1VPSFd6UnVhd2NMQVlVRWJBcHVSSXpI?=
 =?utf-8?B?d2dVc2pxUjRHOURQVFRpYzRCSGZZZ2ZmRS91Z1JCWlVJM3VMdEN2TVkySThr?=
 =?utf-8?B?MUJNbTREYURqbk9GMnczNnFSMzlER1ExWWtLdVZkN0hjbkd4Y3JYT1J1S1Nq?=
 =?utf-8?B?cFN2ejA3VDdXSjZ0Zk83cG5DVms1S3pMZ2dMRm1lVnY2eXFKSjZrVkV6RUVm?=
 =?utf-8?B?d2xGOEdqYTZ6QkVGMit6ZTJUVWZLb2g2bktBcHZQVE5kRFFNbUU3ellHcEpR?=
 =?utf-8?B?a3hESWRYcHU1N2dCdmQ3Z2VseTdQRHY0ZHhVM291SDBrTTBSOWJhM2xOSUtQ?=
 =?utf-8?B?NXJvZ3ZJUUx6VzN4bU1pR0NZVTJYWFEzODRtUVB1emM0cUQvNmZ2WXg5M0ow?=
 =?utf-8?B?K0ltR3crVnhuVkdZeVRsMklrNHBDUTFkQm9MdU03U3FxakV3SG5ybUV1L2J4?=
 =?utf-8?B?ay9LWm9zNmR0RXM0d2E5SWFQVnBTQVRKbys0dzhXUFozUEV0K2JMWHdUblhy?=
 =?utf-8?B?WkcvRHNydVY1K2Zyd1dGSWRrS0VkQ3BHZHNwZi9peHVOa0xibTdMRDI0M0Jp?=
 =?utf-8?B?dG9uY1laNGZGOHZGWXdrUnRHM1JIRENLL3FBRjBaYkRYRnUwRDZQK25Xa1ZU?=
 =?utf-8?B?aDlFajFZRzFKVFY2dXd0WWFCcks2aEZldXJrVkp6VDVXVFBhNzlHMmsxTVVR?=
 =?utf-8?B?cVFqaExxYmNsTlpQdlpmVThYRjRJWkxZZWlqbk1MaG9MNEs5UHJBMkZHVktQ?=
 =?utf-8?B?NmZ2ZEdSbWE2N3N1M1NiM3N0bk1IYUw3WW1BREpNeVM0eGpkekZnNUo3QUxO?=
 =?utf-8?B?OWI3V0xhSm1DWENEZXQwWVdLdHdtRVFmbWFYYVplRjBEWUVLRGN6OEp3WVRi?=
 =?utf-8?B?Z3JmMWE5MFhUWkJBNnFuRTJHOFNVM3Nxc3d2VldHVzFIZzh1QnUvclNTcUVV?=
 =?utf-8?B?cFBJbEVRcW9ockFjb3dIVjNUdFV4SXEwamxhelBnVHhhY0U5emhxUkgwYTlq?=
 =?utf-8?B?dHVtelc1SEE5OVVld1hmWnBQTnptcDVuUWRSVUtIRTUrczM3NXFQaDQ5Zy9W?=
 =?utf-8?B?dHRHdFdueXorTmJpb0d3enFnWkVOOHRjQmhUSlA0WG9FS2RDSlZiaU1PcjR6?=
 =?utf-8?B?K09nNG5yTEFrQjJ6OXJpWjNJeWxDNzZUSmRJZ0FaU0hjYnJPbFp3Yzg4NEtN?=
 =?utf-8?B?TlZRc1B5cDBoY1NpNUJ5YVBNeWlDMGZYMm5HUk1VTjhkOGtPYTBLZWVVUzNn?=
 =?utf-8?B?a2dmNjRHNklQeVVZR2Ryam9FN1I5Q25QQmZhbHNhaStjOGY3Z3dib0RHRVpB?=
 =?utf-8?Q?deXtBtt/owS+lKx8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a45b4dd-365d-4787-7426-08dec1589306
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:12:10.8561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCKkq18UB+h7Er6oRvJfzu0E7zf3bNq5Rm2IljVN6H8TmUa3Vij7nw3sj7oEe+LcnZiLwl7w0FGd38mTF6f6T0PLjJWXKR3JDt40K8wQmn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5696
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

Hi Alif,


On 12/5/2026 2:49 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
> the common socfpga misc.c and update the function to correctly handle both
> pre-relocation and post-relocation cases for DRAM cache enabling for
> consistent MMU/dcache setup across Arria10 and CycloneV platforms.
>
> These changes help to improve maintainability and consistency of DRAM
> initialization as well as MMU configuration for Arria10 and CycloneV
> platforms.
>
> New Kconfig is introduced to enable this implementation only on the default


no Kconfig in this patch


> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before relocation")


I think the commit message can be improved:

Share dram_bank_mmu_setup() between Gen5 and Arria10 in misc.c. Before
relocation, map OCRAM and DRAM write-through so SPL can run
sdram_init_ecc_bits() with dcache; after relocation, use default DRAM
cache attributes.


Fixes: 503eea451903 ("arm: cp15: update DACR value to activate access 
control")
Link: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before 
relocation")


>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v3:
> - Removed 'select SPL_CACHE if SPL' Kconfig guard from this patch and
>    applied this condition alongside SOCFPGA_ECC_SUPPORT on patch 3
>
> Changes in v2:
> - Shared dram_bank_mmu_setup() is set as optional via Kconfig and defaulted
>    on only for the reference Arria10/CycloneV boards to avoid SPL overflows
>    on size-limited Gen5 defconfigs.
>
>   arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
>   arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
>   2 files changed, 31 insertions(+), 26 deletions(-)
>

Best regards,

Tien Fong

