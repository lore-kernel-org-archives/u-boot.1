Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9205CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 06:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 132D983FEC;
	Mon,  8 Jun 2026 08:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tjlg2TWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A6D88405A; Mon,  8 Jun 2026 08:06:35 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C140807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 08:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T81LeR/11f1Nvbb/ykbM4sTfAlAK+AIM+lwCYuVRmLb3ZfwGPtcR+r2SzEH74D710gmzsYD1xd3VGPW2EJtK2zwWCQAE7ssaX1l0bFXcGSBrYarRP+C4I7DQ5cRLeLHnXHKYiJFkFTg+6lTwVm+iKfkC6x4rwSgtT8FO7NddQU8v98lG3NmPpza7yrMSBXEL3hVnVxjMjEqo20Kp+kHTvUD2TGiVcWdlmssg/LgjJ+q/3QhSA2RyfXqj7mH0dINho9Yac356cHnzVBvkGuYxG6i/wvyKgIqvaxBFNxUyBDsYKXM0XQ3qhulqdFX+cD5mw1Xa70OmXhKtceWoTWSdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1joHo1yDNFP/R7Z0Y3j8Fhj6MT3GAVTmaE4N7ebOww=;
 b=IrNFGB7nImdS3aihk4f0NBvNlJnZyn8Ul58KrbCgesypPauWRjbdm7TnzO0K48hSfx/gIAJHHf0j/chCK20fJoZXyG77RBoeAGkbcbG53pBSJxxC36ZJBaYjU42498mygfmSl/1ewIRc7pPN1ksJfSoo3iYtVCAXQcx0Yw+nfGTe02unrqS1K8pSxEzGf04ALqixihQubkjMOeegfPrZE0t+3uIXSgDUIIpK2RYpJT+lK/Z3kBR14VSzHRz8TLTEpzXThTenHbl/GTgdwYfZPYwAR9M8HRkm5nOS+bPO7MLIS5GZ9+tNgfPTyih0iykHESXWZ+Vr1FC/euNDlMI77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1joHo1yDNFP/R7Z0Y3j8Fhj6MT3GAVTmaE4N7ebOww=;
 b=tjlg2TWj3bPbEvzoXuDgRNO6qVra9VgD9k2D2AZAKmqIQztIBc8RVLES67FGWRkQdeRBYxur6wemhG9VaEOBS1r9ha/TvtF0XnupEwrluPTYSky7i24rQ1Go0K9Cbta27FvERUIggIitLc0fdzmCBg+KMdluaSH6thx/Dv+fOKeus0c0auiystN6xb3IL8hveTIKOu/nBeWSGh42yK83yOIkq+3CgiNwJEyQ7f0ZdxkVs3Sd/ApK/Q3Kaz+Pk4GdGu5QhDmdmjaowegzgbEKqSgSx+g140Xlf+6AkLraS2JFuMAAQlp07uzyb0CsblVgzKEDRCD6gfaWOi2DcxRitw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7443.namprd03.prod.outlook.com (2603:10b6:806:39c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 06:06:29 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Mon, 8 Jun 2026
 06:06:29 +0000
Message-ID: <bf474dd3-8db3-44b5-993f-3047ea7ef460@altera.com>
Date: Mon, 8 Jun 2026 14:06:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
 <20260512064957.32497-2-alif.zakuan.yuslaimi@altera.com>
 <ffb78fdb-4651-4166-a821-269f71edbbc0@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <ffb78fdb-4651-4166-a821-269f71edbbc0@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:4:297::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA3PR03MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 00754175-efcb-4867-4438-08dec52414d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2JZlswUhTq13BuCOQNzY3+W57EQ9nlEUkf2r9pbsn4nyRHL4iFxrjN6ZLoPv0GTWbojgZqKhapdAzp5FW6xVb2i6zVEkSJyJlrgIrDM7G3FH8yoHieM5u0sOoq6iWhpPOnkWu0ZlCPhn9R7Ywsb4Ymjr0524MERArAiDymtdbyJK3H3PSJVAlEDgJsCu0Lz7rtofTltKJ5xhT3E/f0zEFh6qhnvVy4qi2MBKP07iMOy2qKjZY4Q/RhnZr5GRW564OipuCEqwJVZMLD2rSiYAZSSKXrvmomEKGBADCq3bc9/uMV38v3DUueYZtDZXpOzRWkYt3OaHcChORK2xrCSJG0S5z9DfBiZVdvb6ZryB0wKyqmMFS/RK9WNZpCryxhrVGPrxba0bL+BT0o5/nHiZguAFcWycAS8zc0OZfXJsxd2TQWRd7cNt6wxM9zmh4NKK/nQBNq4GThHvo8pAvSZmpDgOZkS4IxjYu84EKhN7z0qVgthZ7ynN0p7PJWkUio3cN9zbZMGA7QQnWmuDChOQBcRA2QSnPPSWpMhuDcLnfXT5grf8GvqxNhyV2b+t2YEyg7GYso0/v2ZriVxPsyUgguf+o1X29vslM+FD/gkXffhLzSkTP43XkR8W1IQMlxp0jA5wnUDJ9DG1bSQ3sWtDtveK06XbeK0XBESnsGYpDIh++SF1KBbFNiplqGHw1U7x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVJIc0NVZ3J2M2gybTc0blRFcDJrUE5tQmxzWVpUakZQYk05UkhxOTB6cHcy?=
 =?utf-8?B?WXc2eG1lVTNzZ044Ty9yZUFnRlBkVTgyWFo5QVB5Z0xlRHRlYXluYWFHdG0z?=
 =?utf-8?B?cWRxQVk5aS9XejhFYy83QzI2NnE2eTc3UEYwd2ZPZm5TbFFKR2hwbU1rNm95?=
 =?utf-8?B?c1N0MVUwTHBNa3c5QmtaMVlLSWFIa0xqYWprTzRSMUJwY2hXWUd3ZDFuMUZm?=
 =?utf-8?B?QlJEdHRHeUdBWnhjWVNXcXcvRTZ2YURrcE01TFd4eTM5MEdUMjZFL1RwcmNE?=
 =?utf-8?B?QktuMjV6eWFlUXl0OVpoemliRVFReUNmVWtFZUJIelVISEtrNjhORndxMHZ1?=
 =?utf-8?B?QXoyTlkrOHVBZlFXMjl1MWNpUzRWRnBnTGxzWkRnU1p0WWNhYVRVYnVESUQ0?=
 =?utf-8?B?d1N6VE44SWpMamM1dUFiSWgwVzNCeE5Ob1Mxd3VpUVM4MjB0THBBUmF0WGVp?=
 =?utf-8?B?TUk0MHhsdHp5dWlKOTdIanhkZWRqVnNEenNnNExHT2Q1dlpXYVcwYU1jVGdj?=
 =?utf-8?B?UDhTdU5lcFJHVVVLMDVkTlZXUnRpMVN3azZabHc1Q1R0bmJXVjFkVEpDZ2hR?=
 =?utf-8?B?R1dTMmZxcENKek1zQWNvM0dlUFp2WUU2REoreU9rdjYvN3FjR3JFT2UvdVB6?=
 =?utf-8?B?N3MvQU5vWWErNml4TStOWDNlR2hNM252dlVWcmtQdTNNUkg0YXc2QWNEQ0s0?=
 =?utf-8?B?YkZHbWxZVTUySHJTTVZaSUNkY1YxZGNjOFNPQk1Pc1d6b0Vnb2ZBSEcrV3Y0?=
 =?utf-8?B?bTFmRTJBZ2pHL2xmTkZ1UjRCUUpHNXV0b3o2TWlxSklyMnNlbVJnTCtVSFNo?=
 =?utf-8?B?d2Z0THQ1dzR3cEszU3BXeGtCMXUzayszdEJldEdodHBxWHhoSUxFdFEreHgw?=
 =?utf-8?B?SFE3Vmg4TExwSUVFSjdVWHIwa0FFMWM1dmgwSjB5b1BSdElzd3U5cE01dnhH?=
 =?utf-8?B?c1FaK1hQWGdQQTd6N2JDaFpOK0RWRDlFemhPQkNlcHl2VWovQlNsY1NkWTBh?=
 =?utf-8?B?a3dxdGdpSDVZZktzWG84bHFpTm9Yb09mZGdraGJPRlJqQjJhTHEwL2VkZkFO?=
 =?utf-8?B?MnNMbHdkOERJRUhwUkx6UzBSUWs2M1I3d0h4ZU1PS1NLVlU4T1A5azhNZVpF?=
 =?utf-8?B?RHZVZ2pyTDBhWHRQYTNEQUxPN0hhZHVqSUsxaXAvcUFyUTlqcVdSQ20zbE0y?=
 =?utf-8?B?MjI3bkRPVG9PN1RXZE1CaENudWRESVBkY0RtRmJMeWt4WEtjTHZXN3hJd0xt?=
 =?utf-8?B?RGZndUlPaFJWaEMvdkY1S0dXeFVZZDA1MWVTQlVZZEF4Q2NrVWVpMWFYNE94?=
 =?utf-8?B?REJSTHd6K2VHZ0ZoSWRObWhnYXg0RTNoWGZtbzcvVHE4TEJRVlN3UmVkQ0Ir?=
 =?utf-8?B?NWJSYTRYenJ2bGk1RzJTVnd0TVUzS2pBZnRVTysybHVZdWFZVGJpdEhJblN3?=
 =?utf-8?B?Q0JjSGlvZ3pFQ25XazlpNjhtYUE2Vnd6Qmk5WTZGZjdNL3N6WGNLbmNDZm9P?=
 =?utf-8?B?OSs1WXYxVUJoL2F4d24zMVFybno0aWRwclhkM2p1QjdYRlZxSjFrd05zR2dD?=
 =?utf-8?B?K2s0LzIrZGh0MHpzVVlYQkR6QXFIWER0YmprODJ6M0E1SEROV1pINUZoc2J6?=
 =?utf-8?B?bGpGVTRXTlVoRy9JbEZKSnFkSWM1a2wzTEMyTXBvWldxUThTUjFXdUFoa1c3?=
 =?utf-8?B?OVJWVmF5VExCdzNCdHdyRTY4cjdpck01bXM5TjU1TG1tVmxIc3JkMlZKVUhX?=
 =?utf-8?B?YXhqbS9makdLQXFvenFNeVA2cVNESnV2WmJmek9JaGxjY1hEYU1NSDVvNDk3?=
 =?utf-8?B?MG93cm1LR2JwaDgrclBSRU1JMnltY2c0Q0ZucTVxNnFyVFVoV2huaG9seXFI?=
 =?utf-8?B?MWxpNzZrcnBGenNnSTlEcnJsazdTK2lGZHBka3VBRXBKUTk2UlFiN2Z3Y2hM?=
 =?utf-8?B?OVZoSkdrVnFjYVhucXFWc0trZ3pNdUdhdzlIWDc3NGZ0QTNIVm9CSitpQ2xS?=
 =?utf-8?B?dm16bGl3bVo0bFlLdGdnYVQyQlBZdlUvRjhpUE9ud3JCNlkrZnN3Q3JObDRz?=
 =?utf-8?B?WHlWU3R0YkVtb2dGbXRCNWhaRU5pT0JCYjk5WjZnZVBJQksyeGhobWdMblgz?=
 =?utf-8?B?SXordVVXTHJucFg1RWduSTBNRVFCRS9wcWx6aG1pZkMxajFDWjBXQktPNVM1?=
 =?utf-8?B?SmNTWkZBY3pjeDI3NXZSOVJPQlZtVmdqRWZvOEl5aVJ3YXhGUlFCekdkMmFk?=
 =?utf-8?B?cW14YkUwd3gvRkZtVTMrQWNKK2dZMGE0RzV5L2dtMzdzNitLQzErZU5GdjYx?=
 =?utf-8?B?endlVUROaXQ5M25tcVBTM3ZSbHlyWW5FNVpFNzhtU0NOYm16V2llVWRYY2ZI?=
 =?utf-8?Q?E2yPNx3A5v3GM4OaN4+1BgamJKehaSbrLD7K6?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00754175-efcb-4867-4438-08dec52414d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 06:06:29.6906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knbg713iigFSEkvI0ZAKtt0ADI+kSvrrRlkSxkyVUxIYCy4tzMgb7+pMOyX7j7i6a3peIOY01B3FIVU8hYlMP+sS4GhT5f4JHTgI6n/3pts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7443
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

Hi Tien Fong,

On 3/6/2026 6:12 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 12/5/2026 2:49 pm, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
>> the common socfpga misc.c and update the function to correctly handle both
>> pre-relocation and post-relocation cases for DRAM cache enabling for
>> consistent MMU/dcache setup across Arria10 and CycloneV platforms.
>>
>> These changes help to improve maintainability and consistency of DRAM
>> initialization as well as MMU configuration for Arria10 and CycloneV
>> platforms.
>>
>> New Kconfig is introduced to enable this implementation only on the default
> 
> 
> no Kconfig in this patch
> 
> 
>> Arria10 and CycloneV boards as this will increase the SPL size which
>> will exceed some Gen5 devices' SPL size limit.
>>
>> Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before relocation")
> 
> 
> I think the commit message can be improved:
> 
> Share dram_bank_mmu_setup() between Gen5 and Arria10 in misc.c. Before
> relocation, map OCRAM and DRAM write-through so SPL can run
> sdram_init_ecc_bits() with dcache; after relocation, use default DRAM
> cache attributes.
> 
> 
> Fixes: 503eea451903 ("arm: cp15: update DACR value to activate access
> control")
> Link: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before
> relocation")
> 
> 
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>
>> Changes in v3:
>> - Removed 'select SPL_CACHE if SPL' Kconfig guard from this patch and
>>     applied this condition alongside SOCFPGA_ECC_SUPPORT on patch 3
>>
>> Changes in v2:
>> - Shared dram_bank_mmu_setup() is set as optional via Kconfig and defaulted
>>     on only for the reference Arria10/CycloneV boards to avoid SPL overflows
>>     on size-limited Gen5 defconfigs.
>>
>>    arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
>>    arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
>>    2 files changed, 31 insertions(+), 26 deletions(-)
>>
> 
> Best regards,
> 
> Tien Fong
> 

Thank you for your suggestion. I will update the commit message based on 
your input in v4.

Alif
