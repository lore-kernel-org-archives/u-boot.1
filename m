Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1187EA4E09
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE3B83F2D;
	Mon,  2 Mar 2026 15:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H7EOOHnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F5183F3F; Mon,  2 Mar 2026 15:38:46 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7C183F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3yyNmNhbXUtYsIg2IXeAU6X//BLB6uO8/QeNclkKVSIVIDXCBtBwuSWMoCjVLSYuvWpYuiMOzWe7plHu7JpH2KWrVz1G7BEmesfEOxieb8jKTqT2+F7MRP0ot6UE/RaQSH9dyyypsdh2t/6xHazP83VQFAkZzHiEW5MfqvtxNf+ESHDqUZZh6DxdhT2DNK4O2DONxmU6O53x8aNDJ1BI3sV+ANH1Y58IoIuguk3KR6nce2WZEGe6S+eJBLIpMyc/T3x0uqLjibAVIDJCJIwDuBd9WSUv/vi/AoLyLG67Bpze2GL9q5ULMU55lyayXeY4d2ZxpmFJzMirrL5pEzSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QWA3fqzmXFvtt9U1pcGNOypb7pRFOVmsi3Q3XGJiZY=;
 b=COKELjKUAyfpYtg7Co52Vp5JQhFRlR/7tbnx4RIdswR273r2bj1S9RGsl5wSJqWLzCVVOwhwrnjIB+bGS6e9gDhnPikFXwem1ZW5AiXP1fmWqSATEZXVq0wq7hERBu3rlogQmI48VEwQrIk04JccNfQUO5VDevmtM31lZFtQoDqrvO8P0Sl2miMnoUaP8kfhBSEfzm5xEMRY2kkuoAe6bO6DkJThAwwdO4+2ZOnxYEr7M0sd2OUAB9jFukT1WH8/0MQ8RYOejwedUpfKWjODBNFmzDcMHNniOLAGbrkah4QnTgnPD3XlsuHcTca6DF9IIJrzuKcSPqM9UmYtRgacxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QWA3fqzmXFvtt9U1pcGNOypb7pRFOVmsi3Q3XGJiZY=;
 b=H7EOOHnFqhVcjf1bejuimeJTrD0JMRmgnLp4MLjWcVkv3Pg45kxx//envE7vViwSEZJ4Scrjax/bcbftkUpaoMEwONzgEgVhvzKPWliQxl9yEfoIkgmhz3jrTYPs2N0a6Zt6AnaPN5yaCzMLAbFDgUlaKI1UJRI8DEFm6Hk7Lys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:38:41 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 14:38:41 +0000
Message-ID: <811c948b-2314-4025-b0a3-af36f48d54a8@cherry.de>
Date: Mon, 2 Mar 2026 15:38:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] power: pmic: enable sysreset function with device
 tree property
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de, Andy Yan <andyshrk@163.com>,
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20260209183948.34807-1-clamor95@gmail.com>
 <20260209183948.34807-2-clamor95@gmail.com>
 <564aefbb-f2cc-4409-a9ed-a599f517fe51@cherry.de>
 <CAPVz0n1xP_HV70RZaBNXMgNdyo+nEbMc2DcfTeDPoXUweH6Dzg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAPVz0n1xP_HV70RZaBNXMgNdyo+nEbMc2DcfTeDPoXUweH6Dzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 72909248-c23d-4857-4456-08de78696657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: cXPWUpb6OwVfqhYCres863wmiiji21XNnyJlSxnZaJPt69lYXvAuWAa+OvK4w7ZCZBBKw2v4935OGQjUMlll7MOv1u7oxjwAzIX4nJHtnRN+JLjFLk6mQj3vP2E0VA27kzXlNl3X8PIRPf0w+CxwMEK3DrU+QE4UYFY8MLxYrriKhrxsDpgBsJI2GYXJvFNGySiweG0D0eZgoMuCjVQLmpEFw0qHR6i0rEMqbevZPlmLZ9MqGnuJCtnCVyfxbY33vES+zod7DbiQkxuhar9K7PA2URMJ5QdGZzQpGQKQLj+V4Ixl/y2KkY7O6HirJQw/4g4WmTxpEpqtje8CvFGyy8woOFMU1RtSo+Jo8LPdf6cDJqwshd72QZQ6RJtE3V48FUtHcXzuwjuHUJQ/8ZZd3sEmZDOMBev1dT1cPXt1xB0ZaRdfPpHmY3D/VV1R02ySOfZjY7Ga5iNbUWI0bT+0nQjYJy+g7ucSCLns27Dw13+eI4R6g33BTsjMKPqjHhIxWmk+u4vUTUzqK7PnG9POHHHy7jt9Gw9wbLmCqN6v5PyZTXGYWnOoKux4WJ7W0em8DXKwwhNoTP3RsuSDcAmGUGx7FH6OLWo3yffpQPZE22TNsVMj1HiEMcAIQlurKpgWAeZB8KnwvWHGw6w/1k/JtDT2Ew/pS+4Zo/bW413K62mRYGikTDSHFttoYFwxjAqEQLGsNJW3VKSiiND9+zvKQ4+cvOpEjlVKQIU0o0lnDnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUpEWFAxRldaUWtFVEFNUStKb3hLWXNHWjZyZ1FVSGZFRG9GMlBPblNaM1FB?=
 =?utf-8?B?KzNCZmxhSzA5clhoSXVLOFVjZEt0SHN3L2pVVk9MbE1kUEw3TFBoNDNndndv?=
 =?utf-8?B?UVFTVVRrZ01wNTJYTUV6ejZKMXRMQXp6b1JUVThuRFFUd3h6N3NMN1FvU3Bs?=
 =?utf-8?B?dXVNSVBGQm0rTTlpMWt2VFRZOEJmR29oN0M3eXhGdUdjSWJXcEl0aURicXA0?=
 =?utf-8?B?Q0haWGVFcGU0NFJjbkpyNm5obHdiNkFkSExQazFXaW1yY1RwTnR3K0VFallS?=
 =?utf-8?B?ZUtva21GYXd6blNUUzBBN1BZbXEvY0g1ZElaU1BEZXdxSmJXMDZrbXRhN29E?=
 =?utf-8?B?K3JyZEtYcTVOeENWakpJa0srMURQVnB3WU0vYlZNOXViRFJEblo1SUFyUWVY?=
 =?utf-8?B?aTNwYkpCR2Q1VmNlaWhNcjBESnBzQXZUUkQrQ3ZoTURqSHBZOUpCaVBRWGVa?=
 =?utf-8?B?V1d4Snpab1RtYmFYTTEySHNmNmFOU2hCS0R6Sk9zVnJ6a1ZqWGM4VkhqQnJp?=
 =?utf-8?B?azJhZzM5L2FuRUtzOFVXa1FpYzdFdTY5Y0RMdVZ2SHJmbE5xbTZXR1hlVWxS?=
 =?utf-8?B?dyt6cWw3SkkzMnJ5NFExbVN3NlRlaTF5eHB2REpGdzhweE1nc3YwSmM0ZFZZ?=
 =?utf-8?B?bHFpNE0wUXh5QTI1c2NFYjhjQnRkRi9HMkVKTzhaMkhXV3k2TEE2SmJIUjhz?=
 =?utf-8?B?Vm0vV1pqd1NyeGxTVDgxYU9ySWZHWFB2VkVBUGdZdjV3Z0FKdnBFZHNuQ2ZZ?=
 =?utf-8?B?MXR1blJuWkZMVVpkS0Z2QXZtZFU0VjF2RUY4emlNa2MreDNuQXgwaTFsc3ha?=
 =?utf-8?B?S3RqQVF1L3JMT3dWalphdURLUDdkblloQkNmK1ZWQVFPUnVLWXpYd1VNdWtr?=
 =?utf-8?B?WXhXSFNtY2d6UkJjZ2FuMWNqbFpTMTAvbGJhc2Rzd2JHUFVia2FWSUdSdEo4?=
 =?utf-8?B?aFk1TUZlT25EM01IbS9SYlJ3TzNtQVVkUzNoZUdvaUNIS20rK2VyMUgwakZW?=
 =?utf-8?B?YjdqU0t4Q2dFVTNsRFR0RXVlQURmb1N3QWVDNGhtYnorZVBaR2h2Q081UVR5?=
 =?utf-8?B?eHJ5ZWlYVXQzZXhtVU0xSkEzSDlESEZTNVM4cDRXeERXSFJ0NDhaSTFqVDVh?=
 =?utf-8?B?UFlmd3V0RkNMMXNZRys2SU1MdFUzTG5adFEwQW1WVjR2K0RBTXlpY2k4czBq?=
 =?utf-8?B?cllMcFd4Mnp1UHd1Tjh4Wkh5OHVRWHdHUGE1ajVBMFc2RkJQZFh0eDBzTWhK?=
 =?utf-8?B?RGdXK0lhSC9oSS9oK2l2MWY4U0RoYldOK0JKNEwwcEMxNjAxanl4cGIweTlY?=
 =?utf-8?B?T2JjWjFjWWl3UVZ2U3JGTTZNNFRVT3RPOW1OejhBZmRWVEloZkpHZDR0ME9I?=
 =?utf-8?B?VnFodmtsTjZSMk5QU2xsM1lzOW9KTzN1QmVpMVk4NitJVGd1SW9Vd01yQXpp?=
 =?utf-8?B?U0V3U1pmaWhQYVNKWW42U2dWZ3orTVZCNHMvT3UxSkVIMnMvemIvdzdISFdE?=
 =?utf-8?B?VEFZRFN4anFCQ1h0VFRNRWwzSVNuMERsUzZUM2tQVi82NEVDN1V1OXJzRTY1?=
 =?utf-8?B?aVpFMXpQRUJBNFFOTmZkUHFXYmNaSFBZZnk4VjFtejZrTmx4Yi8wSDNBaXFu?=
 =?utf-8?B?YnlIWEo1dTN3bWQvMlV6OWlqeENwV2JNd25ON2p1VzNEbFdEcVIzdlJjR1NO?=
 =?utf-8?B?SFJuSDVxQmJWajRZTXBILzJEV3duMzZBb3F2dU9MYXVVTGZhY09NRHBVQ2VL?=
 =?utf-8?B?b3lRRU5TaHBpRzZrbFUzTklYR1RieHc5eFVldXIrMDNoZ3hjbWw3OG5DRnd3?=
 =?utf-8?B?Q25tUHU4bWFLaWRpZ1Z5RUhTdVZGSndpeWpiVy9CanlyTVBlQTRBbDQzVXE1?=
 =?utf-8?B?aUM2Zm1iSHZLQzJGSHVDQWsvTHgxZHZ2LzUzUFZmbHk4MGJhb0pRdmR1NUVF?=
 =?utf-8?B?Tk5oKzhPbUxQckkvNnFQTXZPNjlBT0VneHp2dzN0VGhVbHRtQkI1N0lyV0RI?=
 =?utf-8?B?OFRWeXd4c2I5ZTlVaVdOV0JNdEorL0dkSW5WME42c3NHbWI5QlpnbDBwUmdQ?=
 =?utf-8?B?TXBsOEo2ZkpBak93b1hJY0UrMkFGZTl4Q0pvbFlHQklhNHlxQWFUY08zU0lo?=
 =?utf-8?B?YzF6U1JlMFljZ1dHVlJ6NW5PQWpYZ1lEQnFPTWNkVkFHOTFIcnJ4MmYycy9F?=
 =?utf-8?B?WFpwZUhRNVpWZUNib25Vc3BBd084d01nd1g4eEFGZEs5cE90OWZVWTh6Q3Iz?=
 =?utf-8?B?VkhuMUlqOXdSZEtCbURRR0lkVU5RT1F4Nys4cS9yQWp6VnZNNU9QT0RDbXV3?=
 =?utf-8?B?Tk1NT3lBWHhIcHdrSm1zeUR1WWNkSVJoSGxvMlZHT25EY1FrNVB4QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 72909248-c23d-4857-4456-08de78696657
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:38:41.8017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yuy+8FElQpQnRUJS9dGr0b9jvZlK+ws+tLcKaWUxKroCOE5L1+J/ObuhkzIePbTk5L2RrTXtdMl4xiXX8tlSlB1cVMWOuFGojCxO0RiVKPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552
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

Hi Svyatoslav,

On 3/2/26 3:24 PM, Svyatoslav Ryhel wrote:
> пн, 2 бер. 2026 р. о 16:13 Quentin Schulz <quentin.schulz@cherry.de> пише:
>>
>> Hi Svyatoslav,
>>
>> On 2/9/26 7:39 PM, Svyatoslav Ryhel wrote:
>>> Add a condition to enable the PMIC sysreset function via the
>>> system-power-controller device tree property in addition to the existing
>>> Kconfig dependency, provided the PMIC supports it.
>>>
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de> # RK8xx
>>
>> I've added in Cc people who have contributed to devices that will lose
>> support for sysreset once this gets merged.
>>
>> Because they are missing a system-power-controller property in the RK8xx
>> PMIC Device Tree node, the following device trees will be impacted:
>>
>> dts/upstream/src/arm64/amlogic/meson-g12b-odroid-go-ultra.dts
>> dts/upstream/src/arm64/rockchip/rk3326-anbernic-rg351m.dtsi
>> dts/upstream/src/arm64/rockchip/rk3326-odroid-go.dtsi
>> dts/upstream/src/arm64/rockchip/rk3399-evb-ind.dts
>> dts/upstream/src/arm64/rockchip/rk3566-anbernic-rgxx3.dtsi
>> dts/upstream/src/arm64/rockchip/rk3566-powkiddy-rk2023.dtsi
>> dts/upstream/src/arm64/rockchip/rk3566-powkiddy-x55.dts
>> dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
>> dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
>> dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
>>
>> If it's an oversight, you may want to add the property in a -u-boot.dtsi
>> and upstream the property to the kernel DTS to avoid carrying it
>> forever. From my side, this patch does what's expected based on the
>> (lack of) presence of the property so this is a green light for me
>> regardless if the above Device Trees are actually wrong.
>>
>> As far as I could tell, the sysreset driver only implements the poweroff
>> functionality which can be called by either the poweroff CLI command or
>> the efi_reset_system_boottime function (no clue when/where this is
>> called, some EFI thing I guess).
>>
> 
> I actually expected such an outcome. If you are fine with it, I will
> drop the Rockchip PMIC change for now. It would be quite unpleasant if
> a bunch of devices suddenly lose their reset function, especially
> since updating upstream trees can be a long process. Once the trees
> are updated, anyone working with Rockchip can submit a similar patch.
> 

Well, how does one know whether the property is not there because it 
shouldn't be there (the PMIC shouldn't/isn't capable of controlling the 
system's power state) or because it's missing?

As far as I'm concerned, we can keep the RK8xx part in this patch. We 
shouldn't need to account for broken Device Trees so we can only assume 
the aforementioned DTSes are correct. The U-Boot-specific Device Trees 
all contain the system-power-controller property so those are fine.

As for the DTSes coming from the kernel, they probably would have 
noticed by now since the kernel also adds a poweroff (sys_off) handler 
(and for a few PMICs a restart handler too) when this property is 
present. Thus, this patch syncs behavior between Linux's and U-Boot's 
implementation.

I'm fine keeping this, I just notified other users in case they didn't 
know about the property and want to add it to their device. It shouldn't 
block this patch though in my opinion.

Note I am only speaking about devices with RK8xx PMICs, I haven't 
checked for the other PMICs touched by this patch.

Cheers,
Quentin
