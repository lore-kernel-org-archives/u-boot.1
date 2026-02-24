Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E810EFB7F6
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 04:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D836082BF2;
	Tue, 24 Feb 2026 05:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oq+Tj/F5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E674183642; Tue, 24 Feb 2026 05:06:53 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360558063E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 05:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXZUFjeJI54zRFDByDjDXXKb0uwxr89gq7Fi9GtURkR8m9oI5xDfoH4NhtbqnWMSiM5+SJEXfFbA3oOqvCT0R6lI1r2Blu1NUQZMlUpKtvQBAJYGmmfuFHq83RHh0XCHJMYrrYs0BRrfZe4I/rbKvfh5dvBguQvEmnSnT42suSrk8v/pDb54oDc4/YtchnpTav7q4YZ/9it3HbYg2erbV59UJNoMz2nWgq04qbBdRQoVBrIsS6oi0kd57CmiGXrMi7M32I6r6cfkgkxMiNOfe0KVLIl7Av5Z6AIeX1kzKeWpQ1jI5/9ijLd/8bQBHqBmAu0xcZ1c9wvIRIlqKfI/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4ijM3NPFOSkYsOTuEwhg7ntUpdleLONdmlbr759Ldw=;
 b=CHv92FCNBjfT+jyUkmh8CBKRzwkoEhVTiO7IhmHP3ItwGbY4+5sRCAM1yU5yCcH+o1URHw0Lw7YsU9ShqWey0JauU9YDUZXyWXtfr79C+lmQsAaRuTTvEI6hq0xs1mIlRlI2OwapGJzhWf3WILAgZxSx5X2Aw0Vxwe5Now6tymYfXCoxa5TXwucOIah6dOmH+BGEzfcu9cCG14HnuVnFlVfTWDdoltvOUJfqxutTTfWF/PlcQMLyGRlTTSgC4Vi0YaL4Io5460kLYOJw26Bc9jRIxy56GxDaijBPxkYdvqs9CUDfNFtLak9TbSlCGuSvd5/N2vSOfWzPnD28NmCXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4ijM3NPFOSkYsOTuEwhg7ntUpdleLONdmlbr759Ldw=;
 b=oq+Tj/F5PxS7yWwjlMzJoSzVl/jpPhQREvkQBtU2PKuweSlNkDmlPqaZqonl941BLAZu0xik2boS3JTVcs+SbhF+z/uwNoNA+0S9lVhkfzL6gad2WAib7mi3XesONCjd3+SGqqXKIrGZKPgdsQSJLfKFD1IXk5dYkH/vrTKo7f8=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 04:06:48 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::c8) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 04:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 04:06:47 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:06:45 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:06:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 22:06:45 -0600
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61O46hWQ1552395;
 Mon, 23 Feb 2026 22:06:44 -0600
Message-ID: <3d37b448-0a89-42b9-a7e8-abe53ae02da5@ti.com>
Date: Tue, 24 Feb 2026 09:36:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-am64-evm: Add "bootph-all"
To: Tom Rini <trini@konsulko.com>, Santhosh Kumar K <s-k6@ti.com>
CC: <u-boot@lists.denx.de>, <a-dutta@ti.com>
References: <20260223061906.1794872-1-s-k6@ti.com>
 <20260223061906.1794872-3-s-k6@ti.com>
 <20260223152432.GC3233182@bill-the-cat>
 <cb0c4c33-4e09-462a-9848-3bf4e0a092cc@ti.com>
 <20260224020011.GN3233182@bill-the-cat>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20260224020011.GN3233182@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CYYPR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 56afeb8e-fafb-4b2b-00b0-08de735a211f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWZvRGFjcTFheTZ5UDF2a0JtTmFPcFMwclY3eVBXZGgvbzZFZy9DaXJ0eGY4?=
 =?utf-8?B?R3dSaVJPZDJsWWVSMkp3N0cwMCsvUTFRcHI1ZjVYYjJZSkYveXc3aUdRaFln?=
 =?utf-8?B?RDNjTzRiZzdhdWNGZ3ZKbitFdnVKSzJvVHp3NUVNSlZrRWJWUjhrYzVVR0RO?=
 =?utf-8?B?Y21aOHk4UUFEL0s4d3I4ZUYzaE9wNzBDV1JMUEZ6dWJjS0p0dDNZdmlHbXpi?=
 =?utf-8?B?ZGtia0JUWlZqQmNRTUd3Vi9Kd2FIUWtEUWFlR0c3WnhEaFJML2ZKenpicnBD?=
 =?utf-8?B?V0lXSTBjWnMxQVNBQm11c2Y2TGRPRHpSUWlKREJlUUNxVmp3S1BVM3Q0YTRz?=
 =?utf-8?B?N1JPN0tXQWs1L3ZXbEFsUGxqbkRSSTZPYk5POThnMi9EZkFxMTc5K3FXU1R2?=
 =?utf-8?B?ZnVGN05welFUck5QMXlKTFJNT1N5STYwSkltKy9HdzhRTU91V0hhTjk4V082?=
 =?utf-8?B?SFdIOGMzZWhIR0RmNktBQlJFUS9ySHdTRlE5czVLcmVnMDlCOUJHdVpYdVpK?=
 =?utf-8?B?eC9pcVhNN1BxbVA5TDBnZm5GOTA1R1NocjlRTDRYTy9pN3Nzajl1VEUwbHA0?=
 =?utf-8?B?aThJeUoyWWJvcmVVZElqWGJiWEpqMUtnODhhZFZSVngzZ25EMDdOU0xCL2VT?=
 =?utf-8?B?VlYwczI1cnM1cHliRnFzTWJQU0ZlUDJxRnZaODVrM21MQkhRM1hCRXZWSExB?=
 =?utf-8?B?M3ovV0JqTUo1WmhreDI0aC9kcmpndXpGRUVKRG9Ib0VFVTFMUzRzbUg1WTVP?=
 =?utf-8?B?Q3JJMmlkclVRWUF0R1dsYitCT2YzRmphNDBmdjlLMkR5UE9TV1c3SmRlc01m?=
 =?utf-8?B?c05JZCtRWisyU0E0em5BV2JyZGF6cWZzNysybHZXN2Urd2Z2N25HeXhtNElQ?=
 =?utf-8?B?cnFlN1BlbnJZQmJHVmR6T3dvcElrZE16VmI5ZktRYkF0ZFVodzR0a1BDY2Rk?=
 =?utf-8?B?OFZ0TnRiSVV6ZGJHcHlVcktrdzlKSDZETjlOajlVeUlTVHNGeTVtSjl5MEZL?=
 =?utf-8?B?V0VOQ1ZUZHlTcHdSYkttQ05WRGdGbGVodDJlRVI3dXRiNmM0YWpIY2VWTEk5?=
 =?utf-8?B?RnZFNHhUbmJxQmFYUUd5ZmMzQUFvOWVwUUdxRHd0TGxTeHp2amtRWXdjMS9F?=
 =?utf-8?B?VlRRWG4vb3FYcncwT1BtUEc5Ny8zTUgxK01vaklVRHMrUVUwaVExMDZqZmcw?=
 =?utf-8?B?bEtXcmxXZDVYaXB1NUVXd1hmc2xWbGR5Y09TVHhVS2hYRFoxbzRTUjkyaWc1?=
 =?utf-8?B?ei9ObXlNenY5YlFITXFWWFNZYk9MQjdWMndUMVBVaGJVQ3I5S1Z2c3ZqSjVB?=
 =?utf-8?B?N3JTa0JXTm84ell2MXQ2bU4xZGIzakNYNGxwc2JJcGpteXFEK3BmTGtDSlND?=
 =?utf-8?B?UEFySm9MUFRXbHNyK0VCOWlPV29CeUhTSU43RHcvVUVPYXJkVjJnQ0ZvT0VR?=
 =?utf-8?B?M2YweXRlcUxRRElXUTlDS2tlVTA2TnRFTW5XV0pRcTIxN1FsRmRGaGFrczRH?=
 =?utf-8?B?anFPaWw3cVl2TTdGWUsvQjFqcjFNMS9CUXV2cFhWS2RxMnIxVmZqbHNpMCtv?=
 =?utf-8?B?QzUvZ2xDWjBvMjMrRjJwOUo4RnhjWk1UbDludGFocGV6WmhFTjF0Qlp1Qkd4?=
 =?utf-8?B?Z3F5Sno0Q2RuSVNucWE0WktSZDh2dkpsREo5WGdZdTFxV1BUTjRYL0ZmWUhk?=
 =?utf-8?B?cVdVN2MyYUxuK2xSREx2SHdWdlFUaC9YbGh4aGxNekVRWnNXRWNwS2RMNDVL?=
 =?utf-8?B?UG5WV2ovNjgwSEFEamR3amhFSHp1SjFzSU5NRzVSZ3VlZjJqV29icGhPS3RZ?=
 =?utf-8?B?UzhUbDlVMFFGdHNTOTBWYUR4SG9SSEFyQmhGWjcvUXFmR2k5cVVtQ05LRFhE?=
 =?utf-8?B?ZmN1VmttZVV2TXNETE11MjJxT0dHWXF0bnpXOEM1dHZ2VGdVOTdPWGVaalVT?=
 =?utf-8?B?NUhKRUdXY1kzTXlZbWNDOUVEYy82eHNFVjdYWkZIa1orUExNUmpBWWJpQnRL?=
 =?utf-8?B?bTZKR2p4cWpyQmJlZzQ3U0RabExMaFUxTmJjS0JJRjNqZmxmNU00M21QREdP?=
 =?utf-8?B?bytVdm0rNThYMFRwQU8yTzVWSGNXN1Bub3hiRTNrTkpTbUhQUDRFMkhKMnlL?=
 =?utf-8?B?Z3VUMVZ0c2ZOQXFPOUcvaVVQMWNZUERLRTFQZTU1Ykx4MXI4Z29NTkJ3cTBD?=
 =?utf-8?Q?3QqqOn6D05DDrLC5gzZVyo0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PoukfWdYns9RnQuzzhKdhuC3wfTfIi7FeqgbWQXGJyQs3OkJddGSNv3s5o/7BXDVBXH5v99bXAGFtQSKfqojWpQg1SZFEvUvYtCsmxV6fe2icGfD+bcbEEKZ3K0s+1pk4Zv+H0662faxUwK4MrdSHSqed77OxarizOW1+M/7+oD3tGVLDZcRcaJ99aoeyOPpHBBhX78Du1Yl3tbwkyGg+IYtLL4Mazde6wAA1FZQqyrpfUy3Ccfr1CDj3KyPtC6N4ZSsK1BDu2O15INduI/lignF8WCkQqdBw2PehY+7GaJWVObpQA1hzlgDyTKd9yXYxiMCn6o9Q4il6sgVSDnmS9t5r7uyC+gMINpqznpe5pH1a8CD4iWE96uAY9FVaG/XW5WFKohlvPt5CTsdZGkJivhwos04HpKAWxOCbDAqJEzDdt60W7tRWTtNa4AGT3hq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 04:06:47.1912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56afeb8e-fafb-4b2b-00b0-08de735a211f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
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



On 24/02/26 07:30, Tom Rini wrote:
> On Tue, Feb 24, 2026 at 06:42:59AM +0530, Santhosh Kumar K wrote:
>> Hello Tom,
>>
>> On 23/02/26 20:54, Tom Rini wrote:
>>> On Mon, Feb 23, 2026 at 11:49:06AM +0530, Santhosh Kumar K wrote:
>>>> Add 'bootph-all' for 'main-bcdma' node to pass it to the FDT in early
>>>> stage to allow the BCDMA channel 0 to be allocated for OSPI NOR reads.
>>>>

NACK.

>>>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>>>> ---
>>>>   arch/arm/dts/k3-am642-evm-u-boot.dtsi | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>>>> index 6469f43fca81..5048432ef8ca 100644
>>>> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>>>> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>>>> @@ -42,6 +42,7 @@
>>>>   	      <0x00 0x484c2000 0x00 0x2000>;
>>>>   	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
>>>>   		    "cfg", "tchan", "rchan";
>>>> +	bootph-all;
>>>>   };
>>>
>>> What's the status on upstreaming that whole node right there? Thanks.
>>
>> 'main_bcdma' node is already upstream [0] [1]
>>
>> [0] https://elixir.bootlin.com/u-boot/v2026.04-rc2/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L141
>> [1] https://elixir.bootlin.com/u-boot/v2026.04-rc2/source/arch/arm/dts/k3-am642-evm-u-boot.dtsi#L34
> 
> Then we are we not upstreaming "bootph-all" and also everything else in
> our local node here? Thanks.
> 

As Tom mentioned, Please required bootph-all in upstream (kernel) DT
first and let the nodes sync to U-Boot DT via regular DT sync flow. We
need to clean up -u-boot.dtsi over time and not add  more code to it.

-- 
Regards
Vignesh
https://ti.com/opensource

