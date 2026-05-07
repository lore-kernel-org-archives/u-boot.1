Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3655CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 06:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CBE84A17;
	Thu,  7 May 2026 08:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uU5WQS5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A643684A19; Thu,  7 May 2026 08:07:31 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8921D8490D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 08:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vb0eAA4ZQf12uEAO1dRwWEs8I4dRHQwBSKoiMnNUOQrJDW90olc7fN5UzImB1UvVyShEz6eIWUcPla/0pdeXKwf2P6ZYUOUg/GqUd+lqNJCPORNIO6o/qp+hInLT9EfEoPwW5SX9j8iUUJ2xtxF/nN0c6qEtUtE3yUUnr/BcKfyE5C5oqKuBti0OaxhyDLr06x+h6l7eTfahXLVFQ7l9Mn7AOYyrUc16CkRoAGdpo3F44XQJV/4xnZf1agdB5WOLJwstMj39DadV6qy/5HDPewwfCCg/0lbkmm7mv/g1KytvdwvNLXIZJQyXwsUmTw7Kr4t7x8AhL33mazFYdlRZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT+w0/KlV9ppIcgzYrWLBtVheaR24LOumssDPdmKAn0=;
 b=YBLFgI+rEnLDZBZhL1E6zpSBiwbwI2tqKFU+87GiDXOsCDN3sDCeP8LSgGa2p0tpmeG1u1h/AhclFwsyMQl2QFq/ftcvUC1gV8cTJxCD2JLFFteXGEBf6F9/tCKv8P7S6Lb8Yg2Vv8TcbvpSZ0vk3SJIwmBndxu5tRk9gtmnLlid3o+A6L39zP5DQYHHUskNlG/wnrdF71ezP7lnWTOLS+lTNysk/qats83jLCm4oRRCbfmKltnZd3OrSKCh1Z4fLUHzmIVGBtfMhhTda8YgrZ5GXiLGesRlI/hgGBjTxn5hTg08YmYcWKwC0Tzx4g3dpk1WT+NniKFdOWhN78aswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT+w0/KlV9ppIcgzYrWLBtVheaR24LOumssDPdmKAn0=;
 b=uU5WQS5c0xstxBiNhG12dNdZMgqxwjWexxb5wScUQ6b4arJDjebmvHRmnHRDNMKOHXqwKr87RPfPcVmDfi01l2P2d88GXWt7+fj8Ixp5PSRZn3uJANpyLcrJBze0ady88cKZbXAJEVSVxijnrKLgWdr+F13xBybWop5wVC6fn3yWRPbCBpYs4IGRUlQ72cSa7zs5Ar6Q/pZzR1FeeHLGL23dw7+oBD7maGmMxpW0dMf/kokO4T6u/+rEXLRjZzB4ezrSe0F7pizVoapmWjwe0tYwgzW7dgCaggjDDvNYjaAjyUmtPLEYCd9MCuMVrfNltbZj3l3iqbWCzf9BJ1D9ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA1PR03MB6529.namprd03.prod.outlook.com (2603:10b6:806:1c4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 06:07:25 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:07:25 +0000
Message-ID: <b6ffb0c1-aaa3-4a59-a470-fc3edf2df4d2@altera.com>
Date: Thu, 7 May 2026 14:07:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: Marek Vasut <marek.vasut@mailbox.org>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
 <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
 <755b13b4-604d-480a-84be-000316eaf5a5@mailbox.org>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <755b13b4-604d-480a-84be-000316eaf5a5@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA1PR03MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e2f99e-c81b-4f3d-6089-08deabfee89e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: W7RG2xtSo+Noktt0pZgUJyoRfTBhDK71lU3cTE+RAgmKl0n7D+Huogu7b2t1HtsY+zuK9HxN+ShH9S/Vd715g7h3Kdkbyf+s1hOfNZ/NsRedm8Dtc8j7REnYPZgU88NDa/y+E8eLveQLLnIsh1sbKWHxFH4FbbLFD+WDaSv4kf4eQVklIfwSRUSQE8ZaDmsv3lS6gMcsA6WEuKEC9CvKS7O+XE9lbn0HDHRo/zCQ0UB8T8kXEqEXAGnyMKiv4D2Y6QUWdrqxi2G+jcMLnilLcUrlh1e+Pj57ILEcwYTFVOLvj3Ic8KzmUuf2TGrpH2NDZOAotrNq3d4IY6XGCKxgqmX0/4KOxyBuSL7DXBWZ3gfZBARcg20jGVltaFEFu7v+wV1jSTvXEQLdS5mEF2rVrjvTrE1fUhCb2rwCEDVkE8JcjUE0kD9yGiEWpM9pcSYQHSNuUgx1fVh948Oq+s0LcdnQWNe8WLD6Z134ff+iQp477GdzTh6jugSRT/kpUu5XwSnN2deLUi11ePCvFdmrpv9FDH08ePIsF+l3SosGvnKKReNIEYII4tJL0rHCBk/NU5d31b267DXrn5RGaUvtBM4n2yXpzTOahbO69tuZLCSahIfRCfwDaIz3iN5MIgO6Ou0pXXGliYc4L1KDfVkm1u8mz2IWi2YFEaoXIHdxhwVppmm1IZyRSBypLyUd0fmx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjM4N1hXZWtsb21udVJzSmdsZ0NvNCtISmJjaVFnUDZsSUtBSitGVmxzV3N5?=
 =?utf-8?B?WXJ2Ri95dzl1Q0Zib05XUXE1YWNuUmw5N1JYRkJVV3Rna2lHTmRhNVZ6T25O?=
 =?utf-8?B?L1pMYSs2SFg5SDZvT2xXTVRmZ2VTVEo5Mi9Edmt1ZmpUSXZwY3NKODYvODNu?=
 =?utf-8?B?bElvNVJRSktJQzBUKytXL25MZTdkUEZGQ0dRaDNlYk1JbWxyb0pLaWJxTUd2?=
 =?utf-8?B?OWhCWkxTVHhZVkM3YzVKTlNuZXVBcWZKYi9YcWVBQWpQb211OFVNbER2aE5y?=
 =?utf-8?B?bXNJL3lab1FZekhKbWlRc054Vkk1cFl5THd1Z2RoK285ZlFpUzNMeTVndWRR?=
 =?utf-8?B?UDVqVzFWeU5xS3cwOTI4bnNvMnhxVHVZZnJ6c0RBOXo4RkpuNXgrUjJjVlZ1?=
 =?utf-8?B?cjEwR0xReFRoYTM2dStCL2dOMWo2K1RyaXNnVFpDQUF3WnJiOFJWRUxodlIr?=
 =?utf-8?B?Y2g1Y1U3cHl5VDU5Zloyd3FRQ2NvRGRNMzRicythVS9MZkwvcUkxME5ZU1R0?=
 =?utf-8?B?OWxwekRHdTRhMDc2QlYvVW0yU2NMWlFYeVVNQWFLcDdXMWsxQWcxR1BVMWxa?=
 =?utf-8?B?RWl1Z2s3QlVMQS8vLzRCYTRIY0Q5WmloNUtMeGRuMTBVZElFTmZBTmdTQW91?=
 =?utf-8?B?aTc5NWFUclNxMVZqL1ZpZE9nYksybVRmdWpGZ0U2bE4ydTRjUDExREdqUHpp?=
 =?utf-8?B?WlV0NWhTTFZuUTd5OERoeE1oTWdVeERWc2RTNVFpblBTMDR0RDRVK2ZGaXdj?=
 =?utf-8?B?UDVjRk9jU1hWS0lpaDNwb09UREt6SmNJRCsramUyZFFRd0hLQ2wrTXZyclhU?=
 =?utf-8?B?M01ZNGd0WGtvQVRFT1BRWlJXdCs0azB1VkRoWXZPNnlMZklPbkk0RlZzQlpQ?=
 =?utf-8?B?VXl0STVzOEkyRmxKaUdWNFFlbzhKaGJKSWJuZTBYbmd0TXZFcVdHbkhKQ0Vm?=
 =?utf-8?B?SjEwdjJVQ2JTWk9ZQUNDb2hYT0ZJQ3VpQ0lUMDBMYlZ5ZHl2UVA4dnFqWVBZ?=
 =?utf-8?B?Y3RZZG5YNDRNVmZXQ3I0VG55OUo4Tm0ra1lhcWV6ZUxsenY4cXNxRnJRdXQv?=
 =?utf-8?B?RTZlS2NZQ3pjMmpHRDdSMktVY0x6bld5Nzc1QzRpYk0ySGpuNUQxcEkzWm1K?=
 =?utf-8?B?VmdSR3ZlRjl5RHJ3djJ0c1VRYU0vZW4zK1cyRDMyS2g4R1RUM3JyK3dxR3o2?=
 =?utf-8?B?dE53M29iSXdTVCt2bXdnWWVMelBIM21WUldsOHV3OFZjdWdOUHhIU05WcVpT?=
 =?utf-8?B?WUZvcmRiUzVSOVlFMVF0UncxZnE2bU5WeDkwZ0N6Zy9FRVRSOFNlRjArZFRQ?=
 =?utf-8?B?THJ1OFJHRUhaN3N1SU1jc3Rrbzdiem9udEl5UUVuWnV6Q1pRUk5NVHJzVlND?=
 =?utf-8?B?UGpFM1lDQ3F4V0VhdDhXVVVoMmhXWkNjbVFkWnMrTEdFWUFCQVAyWlpuWk9L?=
 =?utf-8?B?a2NKUUp4YWRGVmxKTGxjK2UzcDZ1ZmJDaS9XT2pNS25LdDhxZnFPS211TEpJ?=
 =?utf-8?B?dVhMRnFuaHhJZGdNUVVnY1NFWEl4Q2tXUHdmNFZEbzZFc1c2bTRTWFYzd0RW?=
 =?utf-8?B?ellQemMyRWh4bDlCOTVlVlhBblorQjFnUVBaOUNNUTkvaHJBY2xSSXIvaWRi?=
 =?utf-8?B?OTFIcUl6OUdIRHRlYm1WaExzVHluT0FHOGpXbkNuN25UVk5RV3hXVkdBOFVT?=
 =?utf-8?B?MnNuQldVVWhkaXYvR3NKaDZDTVhxU3VXSGlQUVVYVHlKUzVhK3JKcVM4STBt?=
 =?utf-8?B?R09hY1FZWjlCOVRMTzdRemFVRWVDeWYwczlpT0JHSFNaL0pJdFBvTVVGZUlS?=
 =?utf-8?B?N2R1S2lrQzNGbmo0dHBCNkNDeFFmYWhIbFpveCtEMGptdWlpckwrUnJ0TmFj?=
 =?utf-8?B?bEU0QzVRMUxjWHZLMmRuZlFNZFVTNmdwSTNTZWxuWVRFcUE0KytiZFp1K2t4?=
 =?utf-8?B?TDlta0VWb0FPU1Y1K2VHUE1IZHphaG1qL28rSi9zUlJtdlNWNTFzeTZTemFq?=
 =?utf-8?B?UUR3VWlkK2E0ZTBBVXN6QlhjNllwcHNUMlIvUG5pdVYrNFdLMWtxak5OcTlt?=
 =?utf-8?B?RUhLNUNzVXByR2tyTFB1b1UyRm01Vi9BMWIrZ3h2K09tMVZBaWpxS2JvYTRT?=
 =?utf-8?B?bzM3YWFGNVdndTcxMGs4dHhPVFBIWlR1ekh1OTBWdUF1YVdNQkttR1FmVlhr?=
 =?utf-8?B?Q3lpMU9vZVd1MmtjdTdGcitlUmxUZk1HUjlEL3ZpdVVFV3lYM1o5M1kxcGY4?=
 =?utf-8?B?ekwvTGdTbFVHaGNTVmNOeEFUaW1URkpvdzJZM3FWcXZSUGdGRm1LOUZRWm0w?=
 =?utf-8?B?UzljblJlU0xwcmRlR2M1TzNHODZZL3krdEdCWTYxeVMyTklhbXorbHBjSGlD?=
 =?utf-8?Q?/gT1nPv3OpnG/yzf/Biary80AKCHgL0CvXcgj?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e2f99e-c81b-4f3d-6089-08deabfee89e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:07:25.1096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 910AXwr8YY8JBeYLiK47UWKT8rZjIoHTfVez3bRk/2kYPdw7wphIVmrvIGb21RWWVJ2UvOqANTY7RsDojyrNtfQcc4JPe4oANmLcGu95Ag0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6529
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

Hi Marek,

On 7/5/2026 11:51 am, Marek Vasut wrote:
> [CAUTION: This email is from outside your organization. Unless you trust 
> the sender, do not click on links or open attachments as it may be a 
> fraudulent email attempting to steal your information and/or compromise 
> your computer.]
> 
> On 5/5/26 8:54 AM, Chee, Tien Fong wrote:
>> Hi Alif,
>>
>>
>> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>
>>> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
>>> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
>>> case.
>>>
>>> This implementation turns the caches on temporarily, then overwrites the
>>> whole RAM with zeroes, flushes the caches and turns them off again.
>>> This provides satisfactory performance.
>>>
>>> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
>>> Preparation for Gen5 uses the same memory initialization function as
>>> Arria10.
>>>
>>> New Kconfig is introduced to enable this implementation only on the
>>> default
>>> Arria10 and CycloneV boards as this will increase the SPL size which
>>> will exceed some Gen5 devices' SPL size limit.
> The subject is severely misleading, the ECC scrubbing was upstream since
> 2018:
> 
> 07252f6f7e37 ("ddr: altera: Add ECC DRAM scrubbing support for Arria10")
> 
>      ddr: altera: Add ECC DRAM scrubbing support for Arria10
> 
>      The SDRAM must first be rewritten by zeroes if ECC is used to
> initialize
>      the ECC metadata. Make the CPU overwrite the DRAM with zeroes in 
> such a
>      case. This scrubbing implementation turns the caches on
> temporarily, then
>      overwrites the whole RAM with zeroes, flushes the caches and turns 
> them
>      off again. This provides satisfactory performance.
> 
> Even the commit message of this patch is a duplicate of that one in the
> commit from 2018 ? What is going on here ?

This patch was derived from the original commit you have mentioned.

The intention of this patch is to bring over the ECC scrubbing support 
to Gen5 as well via a new common DDR driver shared by both Arria10 and 
Gen5 devices which is sdram_soc32.c. This makes ECC scrubbing support no 
longer exclusive only to Arria10.

Perhaps staying close to the original patch subject and message to 
describe the original functionality might have create some confusion 
here. I can rephrase the subject and the commit message for v3.

Do let me know if you have any suggestions for me to improve the commit 
message for the next submission, I can add your sign-off as well with 
your permission as you are the original author for this feature for Arria10.

Thanks,
Alif




