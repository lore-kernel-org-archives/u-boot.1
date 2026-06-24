Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966EFCDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 17:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707538460E;
	Wed, 24 Jun 2026 19:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Yr79ljFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8C784659; Wed, 24 Jun 2026 19:04:31 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A2E80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 19:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuuKb8Hc4OkRA+bkPOjftOTKKU004GKsGTakcozbduQ1Qrl5BjpkG/ZoDaWEfhTLiQM0gvprDKPemvA5n31J32M8mttsuA8rJD62o0K7wdBBAfwYpV2+7zfZQ6AixEqZ63Atf2mkua7oGludLKvvDes/w/yY8fD2ccgJB+CfXyZOIAHDspwG6ey2V5K2kMQCvu1l5yPsNPvXLjD4GgwF5fEy/pEDk9HIKFLpEj/+Mt1zjTkng95c9aiFh0yoHAZpWrRoMaTcrsC3cll6+g2wFSqAn17cXCJbbxlBvMileOwE+0+7U8mCHT/UgbKzbAWjp/W7zbhG6CpXYSBskL8Zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TV/80Oe9W3MBhHiZIx8zqG9rLLW9D+nOhHDOkVdpYY=;
 b=j4EIVx90kVkewmsoBvZnUEMg/BjuhqVVLSKWCjIYmnkLpaB2RQF2zWEmYNIefF16lcPzkXuyA49BtvaImLniaCjQRFF6HkcYETCHCM60W/EvRjAKHu4apK7AqYmWBYFegORHZOV7pLdMK3ZqcXqzIDlGTI+LJuCirSF4NCq2gRBTokQAmfPlVHm0cFn6KrNg7G3BirvnGDa1vKONflAq8pr6zl1dOGZ+rQ/LpO+VIUbjJTrurILdSd8hwwkrrP/Is72rltZn9jqqfsXW79SQY8mLCz3Be0Gzb4gaVHH8gPUq+UXsieoigqTrlzRZhEfV9Sd6T3OXjmn7k9KrPdJdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TV/80Oe9W3MBhHiZIx8zqG9rLLW9D+nOhHDOkVdpYY=;
 b=Yr79ljFTcRkhXuO/v0RPSU72u3RQsu+xyUkE0+/lohQUnh2V9abx5SmDwL5g+ZTMVMsp9XaZetBZUkBnZJpe4yY/n9QyX5zLfUF9fEagQSnMJY+M/uZAxrrJ75ITj+vZM+Mg/OfY/41IVBPdEw/zrUMnD4oZH/nWZrTNctS8wd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 17:04:27 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 17:04:27 +0000
Message-ID: <4adb13c9-13e4-40d8-82c7-022f17489297@cherry.de>
Date: Wed, 24 Jun 2026 19:04:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: gic-v3-its: Fix LPI pending table size calculation
To: Ye Li <ye.li@nxp.com>, trini@konsulko.com, u-boot@lists.denx.de,
 peng.fan@nxp.com
Cc: uboot-imx@nxp.com, ye.li@oss.nxp.com, lyrix.liu@nxp.com
References: <20260522080622.1291963-1-ye.li@nxp.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260522080622.1291963-1-ye.li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0025.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 33753656-85a9-41a7-7a09-08ded212a629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: cU7WO/Qyj+ykBhao49fLuHzTjq513ZM9A8kSVlkDW6WmF5OUCnpAzDsrIJ96v5PgLgGLI8OP6EBYYWNHGayQEwMAOMcSAW7uBKFS8GbzhtkQIidCbOwItGNqLUWddG5tQeagAhUdjag6gSWzf576dypoF4vqwmk9SdiWm0PQSttSCPcFqg2QglztFI8p3gqYYGrRAvgs+Hl+DoGGuhNc5me1W1mnMo+8+IVImMiL6zgVMS3HE7YZADs5XPxgtNPjfrNwC73nFIyi48d0TClwbJJEVaer9bqJOqPlDAPlwHNuIYjjGDKS9hoc+VBTbyJryF/N/nXxfm9K6VwBuOM9zCiOOpIXPHoRi0UGg9wLjVvMXYsAf4SbgrrZVGyobhXgO0AE9ul955AQ0H/xgR/5CwfMx46LtUrCcNTLdaAuYFovWnyUdw0VUVoz6m4xUGzvxm5Cd/aUcPX2IWHODV56yZRCxB03rIQuu+XSR734tM4aQxNxscVE1hQHhcR2901ZEwsPJcs0egP2bafSOb3DH1ktisNBeRM6l69+a/Ug4mTIfEVV3clebuLlCPNed/Zyj0zcm4metd7+/p+mg6m3YJZo0n+q1uSAFvpVUKARJOJkGdsuoYagPNw2/C1xojdjcKwcvjr6WMGOKp3pdA+tOUgtf2PqxJ1RWsXbpDVf/X8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5PNmlxLzhQaUdFUHJiZ010TStlRkJxNWh5blh6WG5uZVhnczVObjc0dE5I?=
 =?utf-8?B?KzR2QkZsYitHT3k3VklKMHRxRVpmMkNlZkV3UDA1S3V0UFI0dUdyazc5TzZq?=
 =?utf-8?B?QlZRRlNmcWRhTTU4S043c2paYzRCbktmNWhrVi93cGdOSjNrQzdFSTVwd250?=
 =?utf-8?B?SzBiTlA3SnNBcS9tZVFxYzFyNXlsVysyR1p5OVV1MWFkcHh4dnR3S3FkSytB?=
 =?utf-8?B?bE9DR0lMRVNTTHM2eVVmMTI2SURnUDlyYkVpdHlGQTZDYlR0cWRWb3RJYzJY?=
 =?utf-8?B?UXBBcWlMd1pOSUdNMWZmbHVhODI0azYrRzl2Nm51M1ZPMlFiTHVkVGRJWmdx?=
 =?utf-8?B?VGZ4aHN4VCtrR2I4ajBhWmpHWE1ocnJiemtTakZyc29ZeENXci9TNERhVTF6?=
 =?utf-8?B?MG80ZG9XdkdZclczL3hlMDVLazVGd0FzLzlKeUhwbi9HaTR3K0c2MWhmYkR3?=
 =?utf-8?B?T011ZHdObmNJeTFmWTBaNWtsYjdTdXBUNG9xSDVsK2VEMlgrTFRtUE5jOVcz?=
 =?utf-8?B?bUNFY3FJRk5PangwOUsvY25Jbm5nZ3RtRUtaTkdJcXgweURGSW13Qi9pYitt?=
 =?utf-8?B?RE85aWxxdkg4ZDZBaGRIN0lXOUwxRmhZemxIMzRvbldHcS9ZT3RrbXFzNWlE?=
 =?utf-8?B?MjdvcUlpb25vcjJtTmwvRVVwcVNEZW1VZlhNd3Vva0hLQmdMWEU2cHZ2anhM?=
 =?utf-8?B?bXN5N2x2S1p6UGFXRjlNaDRFU3Zrc0F0dFQyTWpTNlBPQ2IrY090cW0vUXRq?=
 =?utf-8?B?RVNoeSs4ODhiMDA1SFlRdzdIUmtnbklEWTk3MzFTeEI0NE1EaE8zbUpwU0FO?=
 =?utf-8?B?RGZuYVFpWER2a0hXRUtwQTR4RkpjdXFqRUlHZlFXQVRCaUQyYTZlcFlGSkxF?=
 =?utf-8?B?MEU2M0FkOUgwWm0vSkpGQXJGcDlXR0Z4dkNra2FSQll2eERtSGkxSDhXWHhh?=
 =?utf-8?B?cHI0UHRPeWxpNDcrTlJWdmVMKzVhS2ZJMDZhcHF4RHhuWkdLU0tjN0JUWnFm?=
 =?utf-8?B?bXVwUnJXSWQvS1REM0Q2YU0yTEJxcUE4bWNKY2FzUVdpRlFESXU2MmYwV3FX?=
 =?utf-8?B?Vy9vTWpUVGY1MFVTQk5lc2JIR1N6d00vQndtbzFQSDRXVlZrQnJVallOV2ZK?=
 =?utf-8?B?cENya0VQa2tDZlpVWTg2UjBTaHVnZGlPUDZ4Y0t1UCs0MXc0Ui9vbUdMSUxV?=
 =?utf-8?B?NlRHM29mVXZKa01KM1B6akJQRWdBeEk1azNoUnZmMGt3VS9POUJ1WUxrSXhF?=
 =?utf-8?B?bkRVRTV1ck5RS1czbk4wQzVRMENXNjBwWTRpWmZrME5HMEEwSFBOaFlrWHBj?=
 =?utf-8?B?MGNZd0ZDLzdHRUpKaThoc1RNY3BjME5iclVzUnA0bWw2bGVqK1UvVC9yZTd6?=
 =?utf-8?B?eDU4ZHJvell2R0k0dlQzd1JvNFZVWXJLTHJnUEIwTjZja0RLUVR3Y25BaDdV?=
 =?utf-8?B?Nk52clNPSHpGRWFDVmExTE4yQTZsbmUyNjV4UHdmdi93aEMzTWtGdVBtYmZ4?=
 =?utf-8?B?WTQ4QkwzbzZlcFRoVzk5UXc5L0lnYUh4NGY4cG9XQWRpS2pLZENac3VHWEsx?=
 =?utf-8?B?YmlkNWRwenJ2b3g4ZVZMY1VNMzJCbHJYZ0R1TTdVSy8wc09GUkZYbDAyTHMr?=
 =?utf-8?B?cVczUTY5RHFDNDR5Ym5RNkhoZjlrcXpERHFNVGtzcUcrQnJUeVRSd2ZCODha?=
 =?utf-8?B?Z01FY1lJWVRmUDFtd1RybUtjRmp1OHFsWWJFY1h2NUp6UXN4bnJQWjh5T3lV?=
 =?utf-8?B?SEI0aCtRZmJqUklvY0RmODZ4MHNJVmRLZm56TzFqTUhoRTNFKzJjTGtOa05q?=
 =?utf-8?B?bVljbFFEdXBXTFgrOHVrL2RraE12OC8xZmJVWDBja3k1amFoUzErWGppRWFL?=
 =?utf-8?B?R09WbVZFWmdHN2xEaG8xeHZZdUMzUmxQYnhOaG4xeFMwZXdjczVMVExkVDh5?=
 =?utf-8?B?Y2xJOVgvcm5GR1pGMGV2ajlmWHh5U29pWnc4NjYxLzdSUFIvcW5FZmJSUXNU?=
 =?utf-8?B?VFd6dFRqbi9HVWF3d3dTUzdaRForaFFJMDF0VE5VR1JkOUROd1RXWEQ3Qk52?=
 =?utf-8?B?MHlUVjRoV3BlRkpXaUU0YWRzWUZaTlljYkdYazJhbWlGbloxN2lORm1YN25m?=
 =?utf-8?B?M1pPUkRrR2hROGM1cWg2a1hXMHppY3N0VkgwY1FsRERrd3VRWTRQeTJVMU8x?=
 =?utf-8?B?WmxhblA3S3hCMXlMMUpKWDNDeEVwUFpUVUhqWmxMdFNxN1M4MjdubWJ0VjRj?=
 =?utf-8?B?a0ZzSkNuN09GRXZMV0xMUUNHSUhiQVZuOXY4NUpaa2FaNzdOR1IxZ3JmS0Z5?=
 =?utf-8?B?Y0p2c0JGSTdTTENxa0dpMklQcmdaaGhLd2lxbHgrZ00vd0c2WVppZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33753656-85a9-41a7-7a09-08ded212a629
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:04:27.3577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxUNycEwGpgXsF5vd0Dg0NtUD0yJsQXYQaIr8djsVNwK5Huc/Zu1g1gDWa+v7/ua3GPoZHAvE9U5AXJnaMBIxnkCTsY6qtZKPB7X8zPLaF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
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

Hi Ye Li,

On 5/22/26 10:06 AM, Ye Li wrote:
> From: Lyrix liu <lyrix.liu@nxp.com>
> 
> The variable `pend_tab_total_sz` is calculated using the macro
> `LPI_PENDBASE_SZ`, which depends on the global variable `lpi_id_bits`.
> 
> However, `lpi_id_bits` is initialized later in the function based on
> the GICD_TYPER register. This results in `pend_tab_total_sz` being
> calculated with an uninitialized `lpi_id_bits` value (0), This leads
> to the LPI pending tables being mapped with an incorrect size.
> 
> Fixes: 60b9b47d295b ("Revert "arch: arm: use dt and UCLASS_SYSCON to get gic lpi details"")

I came to the same conclusion and this matches what was implemented in 
commit 6f6876a0c030 ("arm64: gic-v3-its: Clear the Pending table before 
enabling LPIs") before the commit you point at. From a "mechanical" 
point of view, which is the only thing I can do as I know nothing about 
GIC :), this makes sense so:

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Cheers,
Quentin
