Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C472BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECAD88865;
	Mon, 15 Jul 2024 15:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N7drQNdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BEA88890; Mon, 15 Jul 2024 15:34:26 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B083388894
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPdUBJyvhXJxEugPcGfBYoGLKq81qrfZXpYXd1Us0p0gkGBfZyj9YJWMJLUgYWniI24dTWm8g+AyoEVmJ5V0PGBrUnuMDbIZR+SjY7icmogMAZZe2rcHmmF3si3Go6fAtiOijb4hom6a8YqxWgYg+i3ex/ty1BXwx5fV0dsGXjFUT1aDuZ/D5MD6BMtAlSQLZ6CHCpDiP4+6S3v1u3Hqda8cKex1cTEBTNE0BIZJ50xghbovi2sd50xHYnYXspSZn1tf7msD7EYHYntUVn3d9IGK9tFMxVg9hrf7tGX4tH60xaYjKHq+IcGNF29MUtAOalV46XQieH3hPnEOYRKGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc8lse9fa/i2bDV2TbHKizVPENBuQzCG8nlU0aeqUyk=;
 b=RG3uMayNLIW8My/lNM//Jo1JdfkBazf91AeTvfolRt6e407Eo4s24XDX0/3wqWdf2LS2/mOzniaY9hq+w799lkBA7D1kT4TKf9rc6ofH+iHh577ttO3akmoNwJBVic3FKGid4IlGsH4ywsCbHVFJxyT0apOLzbTO+X4BywV7zuJ2YAUyZlyCg3XF1HcnAQxTK+CYU29FhLXHikUR7Jrw3efRUqlCUJQheSRzJE1LLS7vmwqNvE0xm8YaEYVWSDz+DSWCxMDSvnVFkZE7grD64y+pdZlsVQqITqP7jXhNCCmxaYbXXbxDwI3ChkiWIU7u/3zG6afZBSEXlZItrXC8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc8lse9fa/i2bDV2TbHKizVPENBuQzCG8nlU0aeqUyk=;
 b=N7drQNdPt69du+lqP7a4tYgEz/1zBELQDV7PLwQeHnyHSjhquTLSnBfo+/wNAftjDgh+WXoyjh1fAbqcyeFPYD56xdVC6DHv4EoF07NfdbYECUkztMQb6ORXYT9CMKd5HbjgxINEfI8/kh1P8NTzOEy6xV08U9Z2rlcZJzVodJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Mon, 15 Jul
 2024 13:34:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 13:34:21 +0000
Message-ID: <8e740d1c-6358-44ac-90f2-890b257e6b3f@cherry.de>
Date: Mon, 15 Jul 2024 15:34:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] MAINTAINERS: Rename BOOTDEVICE
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-2-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a1b2cd-77a9-4cd1-fbe9-08dca4d2d5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2dJVjl0ZWVXS3lXT0svMWN4OU5tQytEcFc5ZFZSUDhvSXdyY0ZCR2JnQ2VS?=
 =?utf-8?B?N1BrMWkzVkJTMHZnWDdKRVJWTDhOdFl4ZXZWcUZiMDEvWUlHNzRlVDJhcUxp?=
 =?utf-8?B?R2pXUzVjSlp1bVdDN2hVelNsVTNISSs5djdzNWZKMjlHWWpzVXA0OGNXVUx2?=
 =?utf-8?B?VUQ2M2NkalFwT01QUXMwUlQvckJOVUVYVGx0WnBNd2FrVWVNa2ZjdDhJY3M3?=
 =?utf-8?B?WU40Nit5aWlGQWZScWdrMlJrejhiMzFLc3Y1S1g4UW1OQWJBaXBNWWdEZmxa?=
 =?utf-8?B?RURtK1c1dW1keEtPSzl2cGNwZlZreFpZdi9VZTdTVHVEV25SSEl4MUdiVE1r?=
 =?utf-8?B?ZG5iMDR2V3dQczVUamFPWkk5bTlwNURWVFdNb2VZTVB4TWFidmpHL2RDMWtP?=
 =?utf-8?B?eTk5UHpUN2U0eHArRlR2dTFzclpjR1FuanJ2cU9VeEJvVm1TK3cySFY3b1k0?=
 =?utf-8?B?czJTOW53ZzF0UGxBamhLY3hQT0VCOGJMNU9wYUJlSFRvVTFLOG9SUVBwTFY5?=
 =?utf-8?B?Tzd4Y1RzSmcvLzZsbGkzMGFHeTlwNHVobnl1Zis3cmsvN2ZhVC9STjVpMFl4?=
 =?utf-8?B?REkxZW51ZEhzR04zTkFwRXArYmtML20zd1JuQ29qOW5PV2pvQnh2SlhMc3ZO?=
 =?utf-8?B?TzlYdkxqcnhIckVIQUR6VnZvL2d6clNmU0l2NVE4bFRwZkdRNWdXY2kvM0Yx?=
 =?utf-8?B?b0dNRXlRbkFyVTlXRStVMFdvall6SkdPdTRiMVlJUkgwSWFrdFozRUpOVlBC?=
 =?utf-8?B?cXFBbUxDM1J4NllHMTIwQTczYTM4KzdpS3RWOTdhL3BIWVVmNnhIVGJ2bWtO?=
 =?utf-8?B?bThRREw4cS9saVU2N2xMbjg1WlBXZ2p6d2IxSU9WMGo1b0krSTg5TnFCcWZV?=
 =?utf-8?B?aGdmNkhQSkRCTU5nTDg5eUtlMDdLWFZ0RFI4NXl2WDVaZHhwTmJRVVhLelpU?=
 =?utf-8?B?bzFiR3UzT0lpbWZaMTdjbkJKblE1NjhRWitwS21pL3Y1UVU1aHFHeWxxUTRG?=
 =?utf-8?B?MTFaUElBekpzSzYzUGQxK29sT2dJcTMyZnRmNnYzUys4WlVLc3g5ZzVWNU8z?=
 =?utf-8?B?YnRXRUlVZEtKLzZ1aFdqSVVrMkU0ZXhsL3I0L1poWGdSaXF1NlV2anl0WTBR?=
 =?utf-8?B?Q2pGZ3p2MXNVaEszbTE4SUJYbXN4TjNmTzdISHR4NTZKQ1F1Nzc1UHlHMjRH?=
 =?utf-8?B?RS8rWEdvR3I5ckRLMmVRUWdVajduaTl3OVExN2x5N2pJOHc3VW9vK3A0K25F?=
 =?utf-8?B?eGNiZnQ5eVVaa0ZOeUlNYjduUCtyYzVIc1Y2QlJWZmR1MFdBbGJBR1N1R0h1?=
 =?utf-8?B?cWFMZ3l2MHh0M2lDb0FiVnJvbEhDaXNsTldUYmNZamlxaUZjRjVBOVVXYjhM?=
 =?utf-8?B?WXZBQVpsbHkxbmVzKytGUlJMa1B5d3ZhK3RtTDEwR2lrUzY1Rk9aMko0dDll?=
 =?utf-8?B?SElpQUpUcUNJQzE2SmpYM2FkL2hwVExxZ3IrQjljL0ViNnVSVmdwT1dXTTBB?=
 =?utf-8?B?dkpQUnJjcllzUjNOeE9HZmE5UnRjbzMxZEhoaXhDU1piUzJlRDBvUEtkYzBu?=
 =?utf-8?B?enhuM2hjU3ZydkhvWDR5OFRYa2drVWJhKyswQ08rUFJVMjMxdFVxRTVNamxN?=
 =?utf-8?B?aVV4RW1tRmowRmJIdmRxK3UrTm5BemFiaUZLV2l3YU9mK2JTSEJtbSs5Z3Vp?=
 =?utf-8?B?V1VaSlR4U1ZwSS81cjFTaDBQbFdaNis0dzk5SnBRVEhPek9EamJPaUVCUzcw?=
 =?utf-8?B?OGNjL2pINGxMTEp4R3hHQ2dXSGUzK2w5QW9VaEpCVnE1dkcrRUlDYzFaQ2Qx?=
 =?utf-8?B?Rmx2Z3dFSVBIazBVdnRkZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JZbU9yaFc3UWNXNk9sNWNGcTk2N1g2YVZYUjExQ0ZMeFdTOHp5a2p2QnVJ?=
 =?utf-8?B?ejN1VGlIQUUzWmhoMi9YT1JYSDc1QUVBTVkzMEZQV1Zkd0hNU3A4bnJyU2hj?=
 =?utf-8?B?NkZkMERsTHcwMHF4ODFsTDJGdjQ0S1VkdGFIdkg4TW1obEgwbjhXbWN6eXRv?=
 =?utf-8?B?VmNmQ2dsWnVxb0RiVEpKVkR6c0lsYnVlc010Y1FnN1FRWG9vRnNDQUs2RkY4?=
 =?utf-8?B?cC8zOHpIUC9UeFlONnlNb1FMY2d5SWJ3WWpnN1k3ejBnZVA2TGZhSlpzNzIw?=
 =?utf-8?B?U2pWQTVEOU9QUWcrV1plcHovdzArSkNJV01zNjlEZ2JGSmpBSHRnY21Bakcr?=
 =?utf-8?B?eVJRdG9EdzArZ04za3hBcGp5bGZiRlhlNThHKzFzMUhuNVdjMmExYUNRQWFH?=
 =?utf-8?B?S2t4ZDJ3UFZhMXFwdWtRbi9FS3ZjVW5mcWlha3liSlNNU0JXNzBsY2h1dXUv?=
 =?utf-8?B?YlQ1azdBajQ0dFJWVU5vc09weEN0SnRFYUFBYmlZaUJtUUUzaVNIZE9mNnB1?=
 =?utf-8?B?Nng3YnVzT3ErOEtoV3RKNDhiakxJV1dvcVM2b21uTkJld1owdkNBMnVtemhz?=
 =?utf-8?B?czlZT29oQTBWRkVoUFF6TTZ5YjU2Z1R1WTdyajN4amVReXAzVEdvb0lEMUNX?=
 =?utf-8?B?NEhueFpaNmVwTWR5OU5xcUlTOXFmbzdyY2dQQ2oyVjh2VTBDeGNvUEpiSTNV?=
 =?utf-8?B?OS9EV0JjV0V1aXY5N1lKMUIxeDJXc1gyMEUwcU1qODlHT1hWb3JzbWNabmh4?=
 =?utf-8?B?cmJCTzk3K1NQbjhFdXkyY2FZTGVKa2RPYVRJMlFoRXdjaTF2TlNXK0VlN2JO?=
 =?utf-8?B?RDAvMVg4c1hZV21lUkZKdnpqOFM5Q0YvdjJxKzFSNThSWjNhTUNFdU9TaGhq?=
 =?utf-8?B?dVgrcC9hc2FSZDQzTTNQV2lSb1ZyTXd6bkYrTnJsamlPdDdUbnN6eXY4R0Vt?=
 =?utf-8?B?dVVlb015STc2VkJUWVZiVlAvR0lEMG54eU9wUVRidldtZUNrYUJrSG15OWx3?=
 =?utf-8?B?cTQ2dmk0Z3FiTHJrcVlpdm1tU1F5RkdJUjVuUHltaGF5MHlWaTh4RWdPTkZy?=
 =?utf-8?B?dG05S2h4UHUxeUk0UjZMWFdmRlNJS01Zb1gyTi9MbTZRQi9OcTh5cVBWUkI1?=
 =?utf-8?B?TXhBcWFKSGNGRUx2VXFwVGRwRDZhTHdUaDV4ZWVyYUl2dDUzSEN3dDZMcVpX?=
 =?utf-8?B?ZVhPYlVNMFlSdUZPOC80TGZNc0l6SGh6c3BxM2s3N0RhSXo1QVJZeGN1YzNF?=
 =?utf-8?B?aHVhaHF2eXFDYmZ6bzZIaGMybWVna28rVmFUdGcxZm13eEFiZDRpZysrZDVT?=
 =?utf-8?B?eVRZS1U3TTMwUUNsSDdlVVpPUXppaTk3cktFRmhBODhpazdLZHV6NnZKaGdi?=
 =?utf-8?B?S0N0dEZGamlJYW45bGZiMWkwd1hCTkVVcFVOT0pYK2tBamE0QThHTjlTN3NF?=
 =?utf-8?B?WjhNL01wc01nQi9jV1FyTGt3b3BOaDdmbzdnMEx2MWJwdWQvZ3NOR3RPaUJS?=
 =?utf-8?B?YkdmRDM2MmFtTEJ1VWdlR3BUOUpsa0o1LzFDdlMza2pLcVF4T0gweFRPL203?=
 =?utf-8?B?OVlqb0J1MTArZWRzbzFXVTZjK2JPZFVhbzNGOTVnVlVDZDUvRmlFNE5mcmdM?=
 =?utf-8?B?VGY5R1BOVTJOdHc1UjBUVEppZTliakVuREJoY2VtdUpxcHVaME9Vd1pUakV2?=
 =?utf-8?B?UEMyVUpIZklYMFBBSk8vNGJ5b1ZHN05EdnozQm92aEdRZWVKTnJJTDVac0hF?=
 =?utf-8?B?WDVndVJIcThZakRFU0lLWm9CeTRRVll5dzkweDVYSWwyQnVCYXpJT3hpOUNH?=
 =?utf-8?B?NFl4dzlZT3RsdE5TWWw3TGtrdnEwSVp2L2JRN2djNE1HVXVQdVpYdHAwbVBi?=
 =?utf-8?B?dkRac012cG1tRVZnV3FnVlFUWmJpRG5VRlV4SXp3WXBiUHh5bjY1UmZ2S1Zz?=
 =?utf-8?B?czJRTTJDUkFZOEdIb3dIL2FlbS9UMmpnbXpXMGE5MFAyYVQvQkxnaGNUUng5?=
 =?utf-8?B?cGF1RkdiVUhnNXp4YTdLemhINWxLQ1JyWUFsSk5KcnNuZ1NWY3dCb0lmZ09M?=
 =?utf-8?B?MXJFVEFHTEIvamFQbldXYmNzTGVDQjJkUWF5QkdZWnJBZ2hiVjI3THF5RGF2?=
 =?utf-8?B?ZGdiZ0ZJZVRvWVFRM2x6ZTlLL3VoeGhnTThWeXhxd1FiU0ZyRldjVkM4WlBI?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a1b2cd-77a9-4cd1-fbe9-08dca4d2d5c4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:34:21.7993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DRiXtqoabaaxD83rAOFLvLK+dLEIkQO8cX+PnLVRkuffZ6nHLBhjTZQLVuzGOTBU++h6Rn7UmZwcvndt8YWaopOMBy7vJNVlb9QiAHfdhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218
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

Hi Simon,

On 7/15/24 12:13 PM, Simon Glass wrote:
> Rename this to BOOTSTD which is the normal name for the feature.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
