Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77BBF8DFE9
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B522084223;
	Fri, 17 Apr 2026 10:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WpYw1WvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F6B983EEF; Fri, 17 Apr 2026 10:42:27 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0929883B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZakigzdKJrB/AXGqMZxCVq9FnfFFfIeBCjmtTceOMLgrDvvi2+sycQn65EGyTAWHS57HFkw9L9Wu5bePuydqRLGhmJZ/PktQI6C2NpDLSt4b+4d1dh+9iFvy1Gk+dik0rK7WLmBMSH95sJHhv4M6feJU86MHjrZ3PNDYVJY8Ia7F6vd+25NeMEfoECpno7kUsBRXA+lCwQfZ5yldlqxnlj/7jByZlYGgHIjirFNOYhB5G/QNvLkktZRtSUZzz2S7Sq6Mbqx/+RESD0Fkx/ooAy4jZG9Tv/5jQ45blEu5q1awWEYlQfCqDHkutB9YiQc/+FFWj3NXafLEcOyvdg8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83/xYCXOCZIT91sdgWnBUoGi+enaSJ5Lkqmva/YfSek=;
 b=Av7xAlPb6AS9j4KrGwhp4RPfxEEMpKfAe4PIiB7b93JL2j+BTkCc5w8RDCMWa1j4dsiLzBdNzKoQiQHazyoOYrCe4s+6oOgHqio6pvH8M73ZCvRYdV0Dnw5Z4S+NqpuJ9sDnCcHruFooK3HIBfIf9IBDsqQ8pUXZh8XzFsZkb/b4WwhQJFhdNTtnaO2uoqrx/YWM4NRcDANF3CRsp2cxGsTnkDdq3Vr1Vc8hhigOj3LoCL5i38R8OUTQlPYITnpaJm7IUCCIDiRdt2ciaveYIbL5WzQru1iN1tpiN7gIBTION6kCDtuE44txd7HOSgajsu+pJ8Ha/pHaObpyEvGKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83/xYCXOCZIT91sdgWnBUoGi+enaSJ5Lkqmva/YfSek=;
 b=WpYw1WvIHqSYEUOjP6eg75zzHuePk6xzrhPuHVGj46EU/Veet0LyQ2rHuSeJuRjIbZj9P+lsTNxZKnwjRgeJUbaAZMRrDraxjvBjdUu7pctBMoipmEsBipTG58jpCRBysKopGyDBNHxFx2+m1GZANwEleTPjaLxYN6Fstnnic/YgAfAvzzx0YSEivaTLM8T3WTRuABt5V6ka+JIp9vwiJh25VUFYoS90NOvLCcpbqprVPZSRS/nrerYJrlOidPa8Ror8JCuUxcFBdNX0HiUuOzHb/0rTLBZdcRA2xlky0DieienuwMx576iouMHkVCFpdv/D2Izy5VtJdUVvvyAyjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY1PR03MB7946.namprd03.prod.outlook.com (2603:10b6:a03:5b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 08:42:21 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 08:42:21 +0000
Message-ID: <4d496d68-a6ca-4ff0-a463-aeaca0febf3a@altera.com>
Date: Fri, 17 Apr 2026 16:42:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Reset MPFE NoC after programming peripheral
 / combined RBF
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260325054638.13533-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260325054638.13533-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY1PR03MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: e64a2949-5c49-4b06-8b5f-08de9c5d3d72
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: brbNsGbTJnXKw6ICbo1nz6h6XcxCS7SrTGlE855Qf1/j2G0rZOxbebo+JyTf1wdYHnjNiqtMxNgiRbx7CcEZShkw+2S0hJIL4320VKqceyXmxs7wsDwfta8Fnai7nJfSufGf/jMWlTuToxdR8zD1fQWBxFYYVwNc1an4GsuKdU21KaRDnXSUHQYCOoM1r42BLLkh6pAbrtC9gnH+Nn/Ic1YAxDPQB9u61oJSDOF3Auxeh+4iGE5c9U6Ep6nUV1rRuA2eMrQkfnZjYnWPpS9K9zuE3w0ZeozfH4jbO2K/SOtJhbB+8Kbwe6hTjAp/Hrd2uxvsmbVJ41Biz/7okSEgTjgGS8WrWTvmLckTWH9fkBZqFxLqlCU7gs91BrBz9wn6C2kXyj7mw6HSxEDqxlxzxiZ4Z3Hxh7UO55adKmDH3fXypeXKa6GhkidAhRjauUAlg1LT0eyAogRZezTBPQX4cQ6+S7LVHQf5b2JKnwOk+mL3IQW+BUlPbm/PqNZmMFkBIYNCnN3Rkzlhppjs3qp3HtevkWMDXIkc3bOzqqe0ALKEgbFmtY5MOWkVuFwuTVDsZFKd/59AvKBjdYWY5YYD4m9EvYWf/V1M507M0QOXiDJEWUghdmsesssY0KZK3YU5ffPA6wFpi2POIe2gbYmdAnVMTKS6njIPYeiDDzY4ZIhM97xY+ORepW/8cs453ZwJOumi2TLHSPJ4uXSVtUzboCjhspvX3NHg/v2dopgY0KA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUx6ZjE3R3pGRDRwWWlZQ25xTnE3YnZ6bk1tNGppOXhZVFhOWmpkRzBtbld4?=
 =?utf-8?B?amRDeERPM1c4WXdNY21SY1QrTmNNWTZuOHFSazc3dVlnMjBzYkIvRkxyRWJo?=
 =?utf-8?B?RmppMEVTV0VFWmhkSEIwMFp0TlYwWm1iZnVrdWRPbWQ0bm11T0I4WFpvb3FR?=
 =?utf-8?B?Z1RscW5NWFM0YnlDUElCa3ZIZWd5M05pbjl6amtuODRYT1RPUGZpdVowSDlD?=
 =?utf-8?B?amNoY1R5L1pUN3lBZHBzQkJ2ZFl5MmVnTWpWL1k3eGxnZ3BISXZ1L0dtZ1RN?=
 =?utf-8?B?bllUYlN3Mks4Ui8rS1llK2JSa1hISHFZME5UODEyQzJqa3hOTW1aeTU2Si9V?=
 =?utf-8?B?a3d0RXRRMUIyUWhWOUFSZE1LYWZOM29YNEtPWko2ekwwU05SMUZQMC9NRTQz?=
 =?utf-8?B?dFNFaW0rTzh3YmN6YUlGNHg5ZmlEbzNWV0JFZ1M1R3VMMlFaWFZIbmROdXU3?=
 =?utf-8?B?Q3NuOTV4TUMvSDJnbmpobjY2cEdzaURXa3J2eUh0OW1jUmVHSmswNXdYbGln?=
 =?utf-8?B?RlFLcW5FOG9LMDVMS3IyY0dHTGFiMFhTZ1ovaTFRTGU3NEs5dEV4OWpNNnJi?=
 =?utf-8?B?eG45YkY3YUk5UlJxdUZoekM4RldnUUtKT2pPUWFzM3FRbzZYb09QekJWT2Jz?=
 =?utf-8?B?Vk54alhKTDdKYk5lWWlBckZNalVPT3ZTTWpEZGV4QTBJYkRPNEd0MUNZeDRD?=
 =?utf-8?B?aGw1RlRwSy8wMnBaTDVMVTVOS3dVTXdXbW1lVWx2c0picDB2WlE0ajhSckNi?=
 =?utf-8?B?VHVmNXZmWEYydXlWWE52YlJxbkx4eWl3SGFIU25Od0c2OVN3VHVhZDEyblg1?=
 =?utf-8?B?NGFoY3FRUEI4eUlLaHF6dWFrbmJrRkQ2WXp4dktGdXJHK3hwQ29HSzBMMWhu?=
 =?utf-8?B?UkRRNlR5UHYyWSs2NGZoaUliSFJ4RE5FNVA5VDJzZDRBTm9zd2c5ZGdhZmU0?=
 =?utf-8?B?ZURranFkbmlKK3hhZFpBdlBtelgwdzhlMnA0UUpQbCtJekM2SjJ2eVplUXFW?=
 =?utf-8?B?dXFHMFM5MkI1ZXpaMisvTk54cUJzSzV4and4U2ZIRTYreTlqMXhkMm9LQng5?=
 =?utf-8?B?QitVZW14aFhpMFc0Z1NOTDlleklzL0lqRXBrL29FSmZDcnBpM1U3d1dkUWJD?=
 =?utf-8?B?RnFEN1dyQzBQK1poL2NuVUlLTGc4Q2diVkZvQVMzRzB3QWRTeFVsejQ2VHZl?=
 =?utf-8?B?Ri85dnZzcHlLeE05bGhNR00yVjBHRFBlYUJUaDhmaCtRelM1bUlPM00yVWh2?=
 =?utf-8?B?ZHlDVFRyb0tVbU1rbHR5eW5BOHEyMzBha28rUitHZjdHcFRHVU1xTFJzTDZ6?=
 =?utf-8?B?T2VOanpEVGdWd1pqUW9EbHpva2c0ZWRsMUhvenZXTHh3eXFUbi9Ic3hyeEJ5?=
 =?utf-8?B?SFFVaHhGWTVsY2xnSEt6MlFYZGdpRFVDQmhzVXRjTnNuSUdkcXJuNmNUbXpn?=
 =?utf-8?B?RXA0aW1PaTQ0eisvdzYvdUE1YkJxV2xrSkhhdXJlUUlwZi9oN2RCemE1ZFRq?=
 =?utf-8?B?c1dTTDFWMnJhMXdWdTV1VU96Sy9mSVNTUHVVd1hHZVkwN0JncUFjL3RlU1Ey?=
 =?utf-8?B?Wmw3WC80V294YndlWk9RamVlb3YySEdFVFJNTHZLa3NLNXUxR29rdHZBZXd4?=
 =?utf-8?B?RXdMeFFKb25zdGdURVJkVUJqTUdZNzNHQ3AySWpGUlNtMXBNSnNMWm1NdmYz?=
 =?utf-8?B?dkVhMlBDemN6elpMM0ZSdjVMbDFEcEhTdDJPeGVYV0VlaUpCSDhjSUhXSHRp?=
 =?utf-8?B?MExra3RTMkJ1d20xMkc3dlJVYVVJMDNyeFVPUjBsMjVVTWk0SEZOZ2laVVFD?=
 =?utf-8?B?aWFlYlk4WWFXbEVpZFFVNFgrNVBKeDZuUk9iN1JvWmFrcG4rQ1ZKQmpyTjZr?=
 =?utf-8?B?dVVtVkRBekJXMWJ0RjduMlpWTEFCdlBLaWliK1dQOS9ZLzlhay9DOHROZDlx?=
 =?utf-8?B?cW5VcTEzZml5ZVVuVGlqbkludERCTms5a0Z6TWp1cTViYXVKL29YMzZMK3pV?=
 =?utf-8?B?TjkvdGlJNEhobHlVazRETEdvM3ZPUUZoT0J4QkdXSElqa05aRzdvZ2ZHUnh2?=
 =?utf-8?B?MEFPYnFQem1FV21qa3J0eTNLRHF3Mk9uaG9jZGxHVU8rWmlDUDh1YjJRaytU?=
 =?utf-8?B?L0RLbXpuclQ5bnc3WFNhd0F1UWlkTllQR0xtcElvRUtMUTJ2VGtFTjV6K1lE?=
 =?utf-8?B?aGkxbDN4U2FzdE0vQVBwVjNJdm1vUUNKQmZBSFBpOTE1eFpQbnoxVkRWSmp5?=
 =?utf-8?B?NXhBQ2JuNlBoMUM1SytGNVllbWJ4UTcrYTNiY2RlM0p6QXA2SzFLK3FaWE4z?=
 =?utf-8?B?RWdjWEFGUXYwaTlpbFdPdGF2Y2QzSkhDM3BxUjV6TTUxY3hwa09LSWd2dUdK?=
 =?utf-8?Q?0DGVUEAz5lJGGrn4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a2949-5c49-4b06-8b5f-08de9c5d3d72
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:42:21.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/fIqA3KnnisX111Dv+S+pzjWODvIEU52P16zXD2N6pOutrNhCe9BsqyqZCW1gUNHot+x87/zqsqM9m03wR6KozigwHNA4TqbwtegotyE6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7946
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

Hi Dinesh,


On 25/3/2026 1:46 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> This patch triggers warm reset to recover the MPFE NoC from corruption
> due to high frequency transient clock output from HPS EMIF IOPLL at
> VCO startup after peripheral RBF is programmed.
>

As described in the commit message is not acceptable until the 
warm-reset / NoC recovery logic appears in the

series or the message is narrowed to “add SYSMGR ROM-code offset 
definitions for …”.


>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/include/mach/system_manager_arria10.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
> index 0afe63e647e..73e953465a4 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
> @@ -37,6 +37,10 @@
>   #define SYSMGR_A10_ISW_HANDOFF_BASE		0x230
>   #define SYSMGR_A10_ISW_HANDOFF_7		0x1c
>   
> +#define SYSMGR_A10_ROMCODE_CTRL			0x204
> +#define SYSMGR_A10_ROMCODE_QSPIRESETCOMMAND	0x208
> +#define SYSMGR_A10_ISW_HANDOFF			0x230


Redundant offset / naming: SYSMGR_A10_ISW_HANDOFF is 0x230, the same 
value as SYSMGR_A10_ISW_HANDOFF_BASE

> +
>   #define SYSMGR_SDMMC				SYSMGR_A10_SDMMC
>   
>   #define SYSMGR_SDMMC_SMPLSEL_SHIFT	4
