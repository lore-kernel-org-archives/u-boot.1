Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7928CFCE068
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBC283AA9;
	Thu, 26 Feb 2026 13:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J1THOLo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3B583D1A; Thu, 26 Feb 2026 13:39:26 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9DDF83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEi4CwA5i+saeVTNKPQPZF+1qK0FoG5JLrd9LE7lTaFRWYcXL2lMm4NagoxWfGT8I/mib9H/N+ip5SXG/h0t7vyT67T+FkGPyG0fU5jO0mzkoRCbfT+gz7G54n8Xc3OlwLZXt3K1gXNXudB1g8fOxa5dL8fg+ij408UmkKj2+GLNwy6Hie1f6zqi8twcGmAYOEqWzdRZXbP+Ul5eT7WjeQDaBqyCfV7XjjEZMSbpFM1l76+wWZ9VjewJCCzoeWNsV8h6J3IUSgnPvZczT09SXXE20aqfxByKZm4YpBXSL9/aeccGwWDBCxEs00SzZsGUE7yO2A6HvsSKx4rFKi8gpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1anhqom1LbJyqBBZ8bUXGCT8rLlCNqSr50doEvyTg4=;
 b=x9wVuJ4VJtUnze2Y/yJOV7c5tvC9Ggtj4FdcDT+TLirDabfxGUxi14PXl1fgWHX7XwWic20v1Nv8xwAFTV0RNQwk9bWjuFNF/tSn3WaOel5o+05Drzn3Za5XuJpOtIJZXk4E0vLgwjUAVSP5uCpqe3CSjSH4Y+Q/Hc71A7EnPsYV1wMXPCH9k2zdoXUDaoW5Sqi3crlnqMb+XDJD4koGtFYEesGK59IrMUyyjllRHtgzTbQwiUS/hZv7tZkssxbxujcuma0YWtnMxD4LdDZQE8066mCctyb+da3fOrPmpinvuHMgjuvEkDjWgrXTriXKOzMJAPb9yfSoHTcuUuJEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1anhqom1LbJyqBBZ8bUXGCT8rLlCNqSr50doEvyTg4=;
 b=J1THOLo1zzlZHVbfBTdn8FUArupWtTG4SrRg19vEeKkGYNz6QqS//+7yk87/J/wzQkG+O/rBOlO/nSwax3JXwX+ZnRLHaK2pE8LUKHTStVdwlYoZjGzd605S882r0onpNrV3mkF8vlBJsrt7dl6QKOwObp8DQBnJIQv2SkDsJGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 12:39:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 12:39:19 +0000
Message-ID: <578013ec-1f37-4d66-8d6b-c268a5b660be@cherry.de>
Date: Thu, 26 Feb 2026 13:38:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ufs: don't select non-existent CONFIG_PHY_MTK_UFS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, u-boot@lists.denx.de
References: <20260225063100.46962-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225063100.46962-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV2PR04MB11799:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8d9908-2865-48e8-9051-08de75340f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: 38BOW7uqE5Xn5KxyEp7Uvc321hP97y6eiexx4XAh6geL3KklacDLudgzdF42Ernpo4G3JOpJnF1YPGjqd9z58M69gbVggK7bZSdRlzEvSRkbUs2bMFco7Nlvj4umsLAYEWD4HE27QFto2TGeL0FmhLmL8fPmcwOX4uD2uB60E2ei6lJzMppX1HQdh6vq3fs6PGWruBTwJhHYJqDagQMVOP286W+Ovs49NyH9ZbHRe2VYHbAKToAS93MkjT7//aLfmRerdWXTyykD+0TtpulybKI18npbETCUqSkQQD/9Sb20l3q6b1Gm6gSbqTRo9ZTlWZOEmwOG37E+lXebAxev2/kk+83IhFQMKTDwrtuoMtHa3t+IrZQfnlvn0PZUO65G1Zj56mNGrRfawV+sRWZjGNiB8D84Rnm8vVCpyKBmbYFNKzxuTyTBI9Af22IKOa3dKDMSRDz1E3Fu0nmk8c5Y1Xf705xesIexCaAJPBIwHSbp8vh7qQ/GkwCEX+3OdLImL0h+xtryAoi5FGWgA4PCsshIG/y9HE5UneOk6PQGEN5Oh/fCiMHdyMOuqNgzh23Hrxkf4qP/tdKQmh5QIChG3W4B0OiNLGBg4WnbIMhutA+IY0jpLQadWhYx1uc2ik3Dd+hFo4o1wF65DhFe/VNphrjYXAOW3SVrGTcXUbxHRSzmMta4A2p1ANNZ6DD1T1Ng
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzV4bHFFZUdBUWp2SUREL2RtMXRWcXFmV24rWCtLNElqUDFYd0EzTHh0cHRE?=
 =?utf-8?B?Nmx5SmxJOTZib29SZGEzYlpadjFIQm43aEVRYVNwaUhLQ0R5OWtmOVRRMTIz?=
 =?utf-8?B?UmJ6U2l1RWthYldrVmRQQnJ4dUI5ZlFtb2RPTGNNWWNPUWF1UHdDalV2QUcv?=
 =?utf-8?B?Nmc3MEV1RzB3ZFhNNVkxQ0ZRQ3ZGaDgvYU41T0xZSjcrVmlNYTViSytMcXlJ?=
 =?utf-8?B?RFozTlBIWVpKZGphSTRDaFFHQzg3UkZwemE4bUxERGZKWDB5MjRLQnJJb1I4?=
 =?utf-8?B?cnRuQ1VMUU5uenowb2ozTE80NnVtMy8veHR3cFlSckRucVlWZ3BBMzlNaTFO?=
 =?utf-8?B?Z09DM0ZtL0pWNkZnLzVTbW9hQmh0NmtSbE5lc3JzVktRWUpqS1BHVXJ0OEt4?=
 =?utf-8?B?QUpKOUNUelpzQm40enF4N05taXpDVXh5OVZRNC9qZmNFYTV6VnVLMzFYT3Fp?=
 =?utf-8?B?TExnR0U5UnVxdUpGem9vTTVVYmxtRTZWeUVaMktSRVB0UCt4MENJK3BzdGF1?=
 =?utf-8?B?eWpwNlBoNE5HemRoV0Q2UFVMQlJPUmM2bzc5M1FBVm1NRWV0MmFzQ3lldWRw?=
 =?utf-8?B?ZHNPSy9LbDJ0VUlVcUUvWkV6aGtRQ3NybU9pNHdsMS9XcENTb3hmY0xCVkdJ?=
 =?utf-8?B?Uk4zbGhCczNRT0ZjYVZOQnN1ME00UnhBb2I2ekVMS0RGanJhVmsxR3VRNEsv?=
 =?utf-8?B?QU5tL1VSUXlXdytEWUlkZ2hSYVM5dmphUVFJd1h5enp6ekN1bXVpbXp3dndX?=
 =?utf-8?B?RlovdjdXd1JTSisrQkptVW1WeFdqZ1RHK1RNRVZsajBlNk1oSm5yK3UvYnFB?=
 =?utf-8?B?SGUvbEN4U3doTnlNbERIckNQYkJKTVJjSkgwalM4Nkw2bXcrMStEdStDVTNP?=
 =?utf-8?B?T1FTU2pSUjVyYmE1K3p6bGFmR1RodUN1eTQ3VXFZNFMvRFc1ZjhzSmpJOWtu?=
 =?utf-8?B?YVlOd0NYZUpYblNBRXhZNEZnMk1ZYWg1MGdUSXJtK3NmWmtWOCtLUUlQTjV1?=
 =?utf-8?B?NE5zSVd6QjVFYmtkN1dPcDNIL05sR1RVbEFCQlhjYk5xTWtqelA4STRBV2xJ?=
 =?utf-8?B?cVhKMzJBNEMwdGZNVU1KY01KNGxadDJLSldXckw2R1NWckdURklWZ1NkQnBL?=
 =?utf-8?B?M3lsVjJTaytRSVF2UitOVk9aME54NmpyUksxbjZqcWJwRitLZExOSEljNVQr?=
 =?utf-8?B?TStnTEJsdzk0bGprSUZBbzRBRUJkcGorUzhzR1UvMWU3Y2x4WnplbiswaHhw?=
 =?utf-8?B?bE9zVGxJSnZYMTN0VDlQVGJIRDRvemhYSWp4bGJqdlBoYWpydkNtSHVnYk1R?=
 =?utf-8?B?ZTJISFZwOEw1SlBtRWdQYVRYNFQ2Y1o3Z2pzVExCL3I5cVRLVTM4Ri9oM0tm?=
 =?utf-8?B?dXRZbEd0bWFPRUd1YjhYQWtMZGZxcFJGK0ZBT3YzWWZDTlllVllQL1ZlU0Vv?=
 =?utf-8?B?T25abVZRUHV2Y09rdWk3aC9qVUNrVURTKzYvdzU5T3h1ZS9iQ2REendiYnZi?=
 =?utf-8?B?bHVvWWVRNjBPdUYrL3Vwa2NvV3lQZ2tINE5vQk0wVm9jMlhsakZyZkJycjdz?=
 =?utf-8?B?WWRoU0NkRCtYeWdES25md0ZzdmdYOHV3cHZxeGVaOGgyalF0S3EydWsvZVYr?=
 =?utf-8?B?ZWhoNWRvemlqbytGVU5kdU1VcnZkVWNSc0M5ZlRiTTF2UWNBRHhFZVg0WGwz?=
 =?utf-8?B?QjYvbFphczBGN3hTa3FEWTlIbEppUjVJZSsrdGpwQTdRMmgrMk5rWlU4eU93?=
 =?utf-8?B?RTJYYWQyRUgvVlVISjNJOUcwQ3J6UkxLaE1ZVVFVdy94T1VaaDlkZW52Nmd1?=
 =?utf-8?B?T3BEOU1ndTFtaVJmMG9BQkJiN1FjcERtSHNPZjBsRzMySTZ4RmUwRC9jaXo0?=
 =?utf-8?B?YVVvNUhoQTFxWlBqK3VxVm5GVDlNZDlRTjlQMFN0Smx4TExabUpQTmEyUldP?=
 =?utf-8?B?L0lteDRUUTR5Z054Um1SN09YTEc2V1VXL0hSNTN1cG54MG94dy9FL2dVc2Zu?=
 =?utf-8?B?bmRmT1UxN0IrQ0NwMTdpb0ozVmpvK1lhTHZRa2pyUGRLVmZiWkJFaVExYU8z?=
 =?utf-8?B?b1dLUjBpS1JuLy9pVzFYaCtqZUlSeTlJTHVYWkVnTEdVSjd2VkhGdFhLNzRB?=
 =?utf-8?B?cUlvbzNNeHV4OVBJK0lQNUZzUXFrVXM4d3JUbkdLUjVRcTFTeFBYbVJYUk9N?=
 =?utf-8?B?ZEp1TzNtcUVHOUpVbTNhUjV3dVZyWUgwNXhSWGhGa25uVXp2K3l2UjJBRS9j?=
 =?utf-8?B?Y01RSXpLY2N6U3M3RTMyaU5ya3pTQkNrbDhMOUpqTGxaYnNxRXBJN0FvbWhs?=
 =?utf-8?B?NEhqQ2ZCNUZXbnVPT1BjMC9HWnh2KzM3UjJ0NDl4TjF1ZGIwa2tpdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8d9908-2865-48e8-9051-08de75340f6f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:39:19.2441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/1PHTTQXy40fYtm/kfWkF/cpm4zEA/NMsC8c6ReTO1hHkY7g2R8Qli+Fft5xkdk8F37AF82U2b7rM/ct9ingefA1yNGlOBn37XtUF17aSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11799
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

Hi Heinrich, Igor,

On 2/25/26 7:31 AM, Heinrich Schuchardt wrote:
> Symbol CONFIG_PHY_MTK_UFS does not exist.
> Don't select it.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> CONFIG_PHY_MTK_TPHY seems to be the only Mediatek PHY driver symbol
> in U-Boot.

This binds against mediatek,mt6878-ufshci compatible property. We have 
no DT in U-Boot with that compatible. I couldn't find any mention of 
this compatible or this SoC's support in the kernel mailing list(s) 
either...

The PHY symbol was actually defined in patch 1 of the series, see 
https://lore.kernel.org/u-boot/20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org/

Considering the kernel binding for the Mediatek UFS controller requires 
PHYs, I'm assuming the series shouldn't have been partially merged, 
especially the controller part without the PHY. (Note that the kernel 
binding still doesn't list MT6878 as supported).

@Igor, maybe you can work on a v2 for the first patch in your series so 
we don't need to revert the UFS controller part since it's unusable 
today as is (first because no DT with this compatible is found, and that 
even if it was, there's no PHY driver while it is required for the 
controller to work). If the PHY is not required by the code, then it 
doesn't follow the Mediatek UFS upstream binding (providing 
mediatek,ufs.yaml is where MT6878 support would be) and shouldn't have 
been accepted as is. We do not want to drift apart from the kernel 
bindings any more than we already are.

Cheers,
Quentin
