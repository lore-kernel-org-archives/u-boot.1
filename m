Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDF0F433DD
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 03:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA658407E;
	Thu, 16 Apr 2026 05:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WvN8tmV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 380E3840AB; Thu, 16 Apr 2026 05:30:33 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DCE83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US8+EZERMEhYJJaBNUEs1F40BlIZvAaTlHTf7EPCUDDGDUU9DLjP8vmhT9QxLEzOJL9YBOwgGXHofcfGjTJ0rqdh5Tox4i6Hscr36B470EqvTeU+jAVoBDKvaCOgFuFlyZn9qtInlEhQO8asJayFemmjM3TNfQsVMpPZFOJGVPN1AlSV/nhO2YOf31c4zNeYwSeH0WQYTBK9NKidqBJOHDvt5yXe7JfUU5scpkHKqPyIf20qxF5zoqNddLFXpcpPU2eQ+HyOXhI6es5PIywnKvRG3Ov1NDTN+hgdCJN7uuQ2K3bL1IVUeTigozeNdLxFeb6Cpyp932TGraY8oZOxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmI9yidK/qVmqkXx2jceQaCErj1fzxHJzXNx50QHKBE=;
 b=Vg/AsjmST+T/RRLG1H9ReAdyNiJtcLUhc5IrvdXUPAa/bFV0O1WHttAsmkuYAKucfj+YFMHx+C8ThVKveDH3rJsOpqAdaf9qOPuAf2uiCmnW0L/gcRX6rNMpCTOLobFCNTqY3U0qj/MlecNRH+PdWYMWkZROucKAAD1Gfp6jhLribQM1MSCgPiQireQJI6Y+6JrpHXZ9SvjsSswy2Xbh+BaC0/nk7qDvM++p0gWEF8utjH12CD8KTx6TfS6g6ZiH+pQ7pXWjng1uZB7LCZa6wr6z+B/mg1tYEhHQtvdjjOKdWo1a562lWQW0OUbr2JNYUsy/QVCCwyDXdazjv8dxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmI9yidK/qVmqkXx2jceQaCErj1fzxHJzXNx50QHKBE=;
 b=WvN8tmV6btjXSasJcctNlqai2vtauYn4GkiXFh98q7ql0kjucD4wCNf659pIrYz7qEwKoU1kgOvyTSXfZF35vCYlexty+F1kabsV5zdlbGjmszxHOO3ooRlBL286sPLtrNtGwL0PZf/o4r9M/fSaJ6d2owca+3pr7/anyb4t1/35se2q7f1bXRKltw6S02m9wQy9dDDjGUEKr0Abvcx10whXMgLIeIXgVjBO+HaeeV0sQKW3bufNdhdhbEYw38IXwY8Culf/2uwn2uDHDw6YgrHRGwJVeD1H6EZwkKQtbwnFXEc9YfxGj9yKoR/jBFKXkNLL1GnKdIAxger9L5jhcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 03:30:26 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 03:30:26 +0000
Message-ID: <19dc7d12-f4d7-441b-b00f-0f2ec41945d6@altera.com>
Date: Thu, 16 Apr 2026 11:30:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Enable MMC secure transaction in SPL.
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Ye Li <ye.li@nxp.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260311050003.20955-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260311050003.20955-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH7PR03MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7b3d18-cb0f-4356-78d4-08de9b688011
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5Y2qstRSOnzCx6ANCBCqrOikg4Zx1/E2prc1ek69EXsHb1bWQkd3r92TKc+X7ytgGYn9h1tKz/1L4RrSaq8Iuxmtj1PMZ12YQCiv4ApGkV5fk4EnA/MwlLvXduoXFuLcpm+iKf9D0er/RBmtcv7A6n7Y9ei2EGrpE10rzyfNYKi/OS0K5JM1/JvU2uQ80uqmLI5sFyMdU14XJToUUxsuFzwLsbX1DoFpyINn3t466jZNSXF+a4Y3++WZJtrgba4Xe29DkPx0shmRAffzgtxCCkKFnbpa9q5ZrXgPeO2B9Gxy6+TRQHozWIvja0aKOOaLOHvLuadvm55+lTCJpNxfWc6o7VKzv1dW8pmRxFy9t6pMHCFLr1HfDOoOE4h/ua5sLva9/dp4S3x5xJLUNPQLLHDfuRccsseV2HbIwldRNhcHxJ0hqTRLIMEHG8T4gl+74dKBbP0XWQIjwNff3O0FCY8VaKViRQe51TFRrTKCNmDeMlZx3SR6PfUzfmEWEiQ/4cEytSNEmyTDDtjq7NbXJs1QBqomwQWjN3y/HwJvB+jlGpR4SUqV4C+3jnlEo+V1dDcx3uaLHgXn6brLBad/3whL4s4fpJPnsustMWFDfWiwpganiipy6wVCSfI+3SJAwxpB7oHaQH+ZHsJ+Oypm4s2RF17MMMFwKlGZ8Yr+kX9jrQ3rS1Gm5OErxMuQ49nLu8NExG8podKjP78TZm4qYQYwTywUkDlMjuNVVWr/Ej0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZwa2RaZHRhZWpuQXNXWjFtYXNuM0RGUGVicVVGL3h1NGxCcC9ZSEVYSUpB?=
 =?utf-8?B?NnFTVHNqSVFmdXpqYnBDZkNqeHprbXA5aDRIYXUrNjJTZXhTM255anFrNWxG?=
 =?utf-8?B?c2VCcHhhcGx2YzV6ZjhCbGczZXgzZWhRN08vTWFvdGRyV2lFNmxOVnYyZlZH?=
 =?utf-8?B?ZFg5UmRKZ0RFQTMzS0ZDUjl6cHZsUDg0YlEveUYyYk1pRnhZVVRzRDFrUUxx?=
 =?utf-8?B?ZlNsTnV6RTE3Y3lxbnc4MTFHaWxOUmxQdUV5MTBQVGFsQ0x0UDNrRStBNHYx?=
 =?utf-8?B?bDc0UFlBdkYrdmZKTVBLYWc1WE9DcUxhT1ZVMVphdVVjanZIYk5EMUR3M3BV?=
 =?utf-8?B?Sk5NNVA5QUk0SGNvZFBvck9DZVRtcVd4Mlpmc0RoN0wraVhJaHBXSll2ZUQz?=
 =?utf-8?B?aFNKdmZEbGlQMTNxemNCd3FBajlHK0F4TExLeFVSdEVJSjB2QTFOalc4NFhp?=
 =?utf-8?B?QmlWMGlmK1R4MHpGekoyU1YrWUJxNFZiQVlWQzRacHVKNmZDdERtU2JHUDVx?=
 =?utf-8?B?bTk1cTNyQlZhT0dMS0FrZ2xEKzI4WlhoMzZTUm16SDBmN0FOVFhuaXN4TEdW?=
 =?utf-8?B?bTVRK2p4ZHphOGlwMXZwYkJGZ0xGWG9Oa1pqRVBzV2s4WURVWW5UdzlhMW5u?=
 =?utf-8?B?LzdaRVhXb2FTUUd4Z0RsZXhRcXptVEJkeExCekttWXlreFI4OEpDWDVFRmRn?=
 =?utf-8?B?dVhFdWdkRW1HMFFIS1ZCTHJuRGI2MFpaU2hNQ0ZhbSt5QUtCcUhLaHVpRjZi?=
 =?utf-8?B?SEtsdEJrcGZjNTRUL3F6TzRNZHlkWUNwK2tMUUEzeUFYTC95cEhsQmNwcUZu?=
 =?utf-8?B?aitqQ1RBS00zVnZ3aitSU1NhUnN0UnY5cmU1eHpURmpXcnpkR0Jlajh1UXlx?=
 =?utf-8?B?cGthZHF3Rll4bXpTYmNQbTVEdEl5bW9MRk54UFRUcUVGc1F3Q00yK09NVDJt?=
 =?utf-8?B?ZUR4WGRzS1pEY0F6MjVlbFViWkE5MzB4aWdCVi9LV1F0dTU0clNLdkQ4OEtq?=
 =?utf-8?B?ZVUzWFFNemw1bHI4WFFJcDlpOGxyc2h4N0pQbUNyMm5WNVVDNHZxcFR6U1lp?=
 =?utf-8?B?b0dsdVNoZ2Rsa01uVU9YZjljc2JSZmQ2VE1NWG10cTdNWVVYM3VjRnc0VDBo?=
 =?utf-8?B?TnpzRE9ZMlpmdFVXdDJiaXo1VDA3WHJ1cVBIRTNza0RjN3d4MHU2NGswU3k0?=
 =?utf-8?B?WjdKNmNHY0dPR3hBVG81aFgxR1pJZUs2QXhjdDMwYWFSMWFnVjdnQklIQzBk?=
 =?utf-8?B?dnZkQTlaZ0hEckFQSDlKalRhTW1rblhwb3paWmo2SktrNnZtU2RiYUZaL2Vr?=
 =?utf-8?B?KzU0U0FvR0MwQTRBOUdLRUp1Ti9uV0t1RmlZYjhpNUZiUElxaTVJcUUvTENP?=
 =?utf-8?B?K1JsTGtKekNsSjI0Y0ozem9VYklzd3NIZWN4VTRxaGxIM0xyakVReXZTTzdU?=
 =?utf-8?B?MXhiYklINGhTMjFoR3d4WWRJUVdIejVjVmJYRXdtV2VuVU9DYTRmdHFGR1lq?=
 =?utf-8?B?Mi93ZVcyQnhaSXYwckVkaUpoVWpKY2lWQW5Fb3gxMmtwL3pyU25xbGpWbFpj?=
 =?utf-8?B?NmhudkRLTTVycldjYkNYUENaZ2NFYmVDTHlZODV2Vk1lZGxHUVM3eG1OOGV3?=
 =?utf-8?B?UDJiZ1JFbDFjc2pwcVFveXJ2a3ZNWHU1aUpMRnNLc2Nnc2xVbFYxZGxGSmVV?=
 =?utf-8?B?VndEZlNrK3pKUzIveklOZTBkQ1BoWUREQklha3RRVTRKUkJoS0czOUp0UjM0?=
 =?utf-8?B?VTByZUYvMlR2WTAyVXpmMElzOXNPK3FKc3o4OVFQeG84RXE0SFpuZDcwc0J3?=
 =?utf-8?B?Z1E5MUZLWnJwVjFUa2J5Zmk0dUc0RWkrMS9SdFJyWHViVjlzbEprbmpRTWhs?=
 =?utf-8?B?UmdHbkFZaTJkTC9tYjZuaEJSTWUyOWdKd0ljYnRQN3p6blZGMi9BYU1Va3N1?=
 =?utf-8?B?SjF6c3hQbHR1SUozK3dMUExEc2h2U1VkMG0wSHBtZnBMOHQ0eVIyaDVYem5I?=
 =?utf-8?B?R3JzUlNvWHpsUS8rNithSWFLRUd3VmJ3bDZ2aWxNL3BzSTJvQWg5RmhOZXNu?=
 =?utf-8?B?NjBKK0NFM0xoY2ZRdXRCVG52bGxrYndjdkdoTDVWL29LYlhKaXBRVnJ5Mm1q?=
 =?utf-8?B?ZStYTDJGbUpGTnE0UWFGNUJUVmJqekRhYnJRbDQxakNLNW83Q29McS9EYmdD?=
 =?utf-8?B?K291cmFiSmxOZ2plYnI2MW9Hd1RZWTM0VkZyMjJ2dXM5blRqNkJzQmxlUFVU?=
 =?utf-8?B?aGVVbHZvSGVpV3EvVHdtbUlQZ2I0WXNPMzkvM2xYZDBHYmNPcmJiZWowZ1RB?=
 =?utf-8?B?b3d1QkJTWjRKc2RJZ3JlTGIvdW9uaUp6dFhZd1JhMFIveWFBRzN1eEpQRlM2?=
 =?utf-8?Q?3avLWFlxOGeEYu8E=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7b3d18-cb0f-4356-78d4-08de9b688011
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:30:26.6929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8xASmwVS+Ve7ALrmM548jfKcWXgOODT8aiSGTpmJXkaTwF8nUi/VwwtKauO+fD5k8Nsvu85XXEfBwPK/B5meK1SGjOLG+nC+5OfHr1MGuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6942
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


On 11/3/2026 1:00 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>


The subject could say Agilex 5 explicitly (spl_agilex5) so it is obvious 
it is not all SoCFPGA.


>
> Program SECURE_TRANS_REG when CONFIG_SPL_MMC is enabled
> to allow ATF loaded from MMC to access the secure DDR region.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_agilex5.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
> index 1be347360f5..d0c2af795de 100644
> --- a/arch/arm/mach-socfpga/spl_agilex5.c
> +++ b/arch/arm/mach-socfpga/spl_agilex5.c
> @@ -110,6 +110,14 @@ void board_init_f(ulong dummy)
>   		}
>   	}
>   
> +	/*
> +	 * Set secure transaction for mmc, so ATF image from mmc can be loaded


  capitalize MMC, minor grammar (“so an ATF image loaded from MMC can …”).


> +	 * to secure region reserved for ATF in DDR.
> +	 */
> +	if (IS_ENABLED(CONFIG_SPL_MMC))
> +		writel(SECURE_TRANS_SET, SECURE_TRANS_REG);
> +	}


That extra } would be a syntax error


Best regards,

Tien Fong

