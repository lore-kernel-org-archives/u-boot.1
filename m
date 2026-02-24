Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B68EEC2B8
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 01:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C299C82BF2;
	Tue, 24 Feb 2026 02:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xcQAmgb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FFE583642; Tue, 24 Feb 2026 02:13:11 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2E78063E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 02:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8wRu5emX9ncXwbmMgluiFlf9D3Rcv2tjB8eoEFhxR9e4uFEhe4ANKjsUmmo+j50sZnIwtaFpR96v/y/pjP3+I4wqnMINy9ADBcMcVzV35DShvemk5NRc92MIXFhzrXK7JLp17GilwvDCB/9oHhgUQT9Ep+HD0Icd5J/Tm2MxdSrTd8R7QuKe3L06qMY6JOeeemue9FHJlBmN8cM/LPHwoCsbqblKhhYEnkoGEpjvkA/8jCq+RWCQi/D61aOZxxAhAM7EedCHIWNgx7uzvdtypo4gfJRjL5PjNPPJbb9wmwkS5YVsymm3RznCMm+TKYIecu2QLYjO90CIxz6xkGxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhGajmEwV5ZPf+zMuXOuUdN40xebgpefAKTlW1aAfsQ=;
 b=peJzN1+Cehkxfa1esO3O23+RxenQW7IqPOc9NGgvt40lAsKkIrRjuHSZjHopOCYdlaIblkgVNXEo3mlD1YwvA8WQoilRZ8+VO3IELQjPiIr2RJKLWcxYq0t5NhtnatA7wMzwylrJyaMaBKFMVpARs6ofnIcQpmW1fhO5AF8IYpfhao+zbRpeYtM/YumQbuT/nXgs4NYnq6Vn1vpAiF4tvZFZhYcXS4S2iS2ytN3eREE02vtmhen451I7EQYebmmy06qIT2VLDDHSFWJ/B7y+cZN1+0Y0hLyBhQr08L+ZnspzMC0znuILrEBeILu6zUkYVbmOtEF7sVovmJAiNLE/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhGajmEwV5ZPf+zMuXOuUdN40xebgpefAKTlW1aAfsQ=;
 b=xcQAmgb/NK/byM1OmBp86I95qHXyxcDAfeSiNory37T4iyfWbNqVr+t8K2I3NuxfHetX9HxzXSf2ltKuZkbf2w/Q3iYEgJ7PW9SbnASjuuimumqKV/8m7xpPBEtebw8vrf1IAWqIOaCVzqVpCdi+cgMNn6XEYybVDVVx3FYOxpY=
Received: from SA1PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:2d3::15)
 by SA2PR10MB4812.namprd10.prod.outlook.com (2603:10b6:806:115::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 01:13:02 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::6f) by SA1PR03CA0012.outlook.office365.com
 (2603:10b6:806:2d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 01:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 01:13:02 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 19:13:02 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 19:13:01 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 19:13:01 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 61O1Cxgw1325374; Mon, 23 Feb 2026 19:13:00 -0600
Message-ID: <cb0c4c33-4e09-462a-9848-3bf4e0a092cc@ti.com>
Date: Tue, 24 Feb 2026 06:42:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-am64-evm: Add "bootph-all"
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <u-boot@lists.denx.de>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260223061906.1794872-1-s-k6@ti.com>
 <20260223061906.1794872-3-s-k6@ti.com>
 <20260223152432.GC3233182@bill-the-cat>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260223152432.GC3233182@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA2PR10MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: b9446f49-d4f7-44f0-e5ac-08de7341db67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW0yVndFTFhtS3dMaUVVVHUxQXJHZTVsRTUyMHdDcGttWmtKWjBKTTlFandP?=
 =?utf-8?B?MTVpeTFYYzBEejB5ZTJMVXJFSU9YNkp2M1JXZjhDb1FlQktzdUltK2JxQmxl?=
 =?utf-8?B?SWR2bmx0SGpyVXJMOTBCdGlnZ29EZ3Q3YXp2dU5IMUxxeUNNbTl4U2NaV0J0?=
 =?utf-8?B?K3ZQbDlkSHFMRW9DclZicTVXNkNCeTFZemJPNTQzNEZSOTU5TWdBeExMQVBv?=
 =?utf-8?B?cjVvRlR0OUdhNTZmQlhIbWZzUG9zdGNnQzh1WXN2bEtGdDhHTnZtcHpsWWU1?=
 =?utf-8?B?NEFiMWlyVFVINzd5YTdycktxa1h1a2dTL1dkR011U2cvTHlLZXAxa3lrS01E?=
 =?utf-8?B?bHRiS053T0pjakFxYkFDMzllZmRVbFRZT04zbTJLZHFGK28vQ3ZETk9yWG5p?=
 =?utf-8?B?QVIzeU13VVN3ZHRmL2hrVk5qYmlJcjlJMDUrejVHdmVKZit5K005MFpkSWI1?=
 =?utf-8?B?VTZ4YlJTUEZ2SEcwVStPT0d3UlU4alM3dUw2dXFocElJdERvQmN0RVFKb2wr?=
 =?utf-8?B?TGY3S3RTSWpqK2lmTEhweWc3dGdGTHpLMmpvd25BRFhmK3pnVkFIWjRvWHhZ?=
 =?utf-8?B?VW12a3p6d1U5aWY4NGttQm5HTzU5TmVJOERpWFhyMmZRa05RVHprWmJ2ZzBQ?=
 =?utf-8?B?QkZEd2RQcWtNUmI3VTZlbVM2S25QQ0Q4QWorc3JCVzRjSkUvUWFSN0FRRkg1?=
 =?utf-8?B?M0cxQkk2VjJvV29aTkJlL0JkbGNyK2hqNzUwdThGU1JhSEhhMFN0VWlQSlBR?=
 =?utf-8?B?RXpZclBZTEpZRzk3NlRLVDcvc1d2SFBQMjVvZ01mWTJ2ZVFQN2FGNVlCa2xv?=
 =?utf-8?B?V2xjSFBjY2pYVFB4cG9JcjErcWoxUGY4VFBUVFlZREtodkxOMlRjb3dGOGZ6?=
 =?utf-8?B?b0I1dUZkTjJXU3F6eW9id2w0eXVlTUthVHlNV2VYbytFbmsxWmVSc0lpbEZM?=
 =?utf-8?B?VGIvbHErZGh0YitBU0ZiOXg5ZXdLbk01WHBSVThZYmJjNlpjYUYwcTNyMStM?=
 =?utf-8?B?UjNaaTkvR2ZXRFNaMm5XdjFhM0dwaWpSRUpsTzMvcUZUYWV3TitDVmVDVzUy?=
 =?utf-8?B?WTViMlRMVGdqcVlXK2NDQllUS082bkkzcVRpeTZoNUhsamRiNlFqdUNMS0xO?=
 =?utf-8?B?L3hvWWR4TG5ra1AvRkNEYXJDZzFwVCtDUFoxMDIzYTFaTXFBS1FxTFFQYVpF?=
 =?utf-8?B?cnlkYXcwTlFSenJUOHpZclFDUEVKM2EybDNoMTZyaWRHbGh4c1A2cmx3dHU3?=
 =?utf-8?B?VG5pNUpPSi93blJ4TnBmTWZ5TlVHRFBrTHlXaG9sc0RZWHF3QmpHNWJiTnZt?=
 =?utf-8?B?TEdMSnlhQjdCZ2RndHk5Sk11TjV5MSs5ZE5yZnVhaTBpVTRIcXNxK0grWjEw?=
 =?utf-8?B?cXVEZkhhNW5GU2VKcVVPcS9SNXd6RjQyWDlFT2UvOWxBL2Z0eXpiblkrOW05?=
 =?utf-8?B?MHdYQ2toUE1TVUJ5cW50ZWVNc0VZUXRvOFJBaDg1bWx4MjNFTnFxZWRTalh3?=
 =?utf-8?B?WE1CUDgwS243Y2ZYWjdUaEprY2VLZVB0V21VV01mMGFhU0t6VWlaZEkxZGMr?=
 =?utf-8?B?OEZGaXZndEdoa0lhOGVQbDY3ZXY3V2lyc3ZURXJQK3VybDF5WUtUaXE2QkEr?=
 =?utf-8?B?czZMMmI5dVpVVFp3V0hXWTRnMGlqNnlIOE1jR3Y0VXhLUGFmdTVKUWVHeXVR?=
 =?utf-8?B?WWpnVHJReXFGMEU1SzB3WHBvT29FRHlRN2k3dnFOTTNMTzBqVm1ESEw2M2Va?=
 =?utf-8?B?cTQxRHVyNEFkdWZKK2d4UDhHQ2t6d2NqcGsxMjVsVENWMnZoeFYyT3l1TEpl?=
 =?utf-8?B?R0dMdHRZUU5xalIwSFhFWlBIcmh0c0kwMDltQjVlSjg1YTc1MTQzZVU3RCtv?=
 =?utf-8?B?aHJ5SWZtMDZOMXVzVEpVZFFib2ltOW91YXNaUER3ZnJ0djVyZlZaRjJEa0E5?=
 =?utf-8?B?cVd3bW1FZFgrVi90cVl0b09heUxITGpmeUlZbWN3YjJ6akVBR0ZpME9jZG9z?=
 =?utf-8?B?QktxMVZxc1RYM2c5NnR4a0J4ZE9jQkFiVDArcGo4cjhQQlY0amhUbTZzK3Jw?=
 =?utf-8?B?L1Q5ckhlSE9HTVZKckpydFVyWTBSMElqT1N6TCtBankvUlZVYzh1NWRSUk9V?=
 =?utf-8?B?YndpL054dXdVYmhTVkl5UlZVVHRXLzBxdHF6NDg2VWMxU3BRdkdxZWcrYWFw?=
 =?utf-8?Q?bREIb4cgSSvzov1WLOaOHqA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oLq6//6aGZfixm4tTywLtOUk7ZKYj6uf1Usrmtm7+VXwxpZ2iA8WeLZ/Rxc9uFVrVJbf95KzZTqOyxLVsUtn84ySKQ5cjm8YF0DPyxuOZKFo01B/yRxPlpNEzD2rdFuosG+NxjiT3d/PrbYeFRpm11evQ9NtUQ2ZHNx7lHFRYHg92fA7voSSxtXkwNQZ/ZdyVsUMZ//5efLHBUTe5rYaMMJ8xWf+KQd4Cyn4bXSWkxW/e8W0n7t9qiPBvPqrt3Lc61kMGb8StszsmhU4Wb3M5+Rlgd+THbKY2peO5xzL3jyAQ2zg69sT+abSSBU0txVJEuOmbxv8MZ1oHZc+tx9U7g/yqIane64aypkrs8ImGIE9ZUBnW00hw+LxKf9LEf4xs6k5zYxKn60gAuElvCleRYJaEacz03r1gBrvFawVCZxez1zd1701iB9qY/jde6xm
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 01:13:02.3619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9446f49-d4f7-44f0-e5ac-08de7341db67
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4812
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

Hello Tom,

On 23/02/26 20:54, Tom Rini wrote:
> On Mon, Feb 23, 2026 at 11:49:06AM +0530, Santhosh Kumar K wrote:
>> Add 'bootph-all' for 'main-bcdma' node to pass it to the FDT in early
>> stage to allow the BCDMA channel 0 to be allocated for OSPI NOR reads.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   arch/arm/dts/k3-am642-evm-u-boot.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> index 6469f43fca81..5048432ef8ca 100644
>> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> @@ -42,6 +42,7 @@
>>   	      <0x00 0x484c2000 0x00 0x2000>;
>>   	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
>>   		    "cfg", "tchan", "rchan";
>> +	bootph-all;
>>   };
> 
> What's the status on upstreaming that whole node right there? Thanks.

'main_bcdma' node is already upstream [0] [1]

[0] 
https://elixir.bootlin.com/u-boot/v2026.04-rc2/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L141
[1] 
https://elixir.bootlin.com/u-boot/v2026.04-rc2/source/arch/arm/dts/k3-am642-evm-u-boot.dtsi#L34

Thanks,
Santhosh.
> 

