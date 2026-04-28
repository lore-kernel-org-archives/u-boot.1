Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683FDFF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 04:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46637842C7;
	Tue, 28 Apr 2026 06:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hRVcegH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703A9841DF; Tue, 28 Apr 2026 05:31:29 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880F683BC4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjMnnED115u9l+GCiyQmfpJxmtwmXRBRzTqPnkFTmhSRaJ9OleQp69/Zd9YVme8oiGMb3V6h6b22XotDYX4OVQp+aMLN/k3vcgbQTKRHIXCT2nEjettA8GmVb5NWCf7tjqGe6lSnuxXtpkIlpZvrkeZUy+uVjYBQJ4HujdA0Y9pb+ZdFeCOnjXfPYgm9MYwhfhNU+RFBGpW3XSPSWttJWSAcrYPM1rXhlijjQ956eosPYb0ZXYeo46EcCpAQesY++7ZPIcLOb1UU5QDxIFzE+mvm2/Z/gKjDSuuQCKSKuzerVmXoRcGj/4t9y1SAtU4frp9px7wZKaiBXeCObGTILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuwiF4pUNUlJQtHzp2R0DGKr8tveY5M6Yn7OZq52Uro=;
 b=YID14UAbnbrMhwBPmG6PzibV+yb4DPgpY2pm97mgVM9MSlZ7idbxSdSms8DYc70JC/ko2t1XX9oMmd5yeKc2Dv+hzAfHgYBjUEhG39QC4StLXWGO0wTkuGYCuxmrtBPJRkV2FSa7kBTbVBMB/gO5Jcwy2kAEkY8l7NDLOsPl8U0QPordtWUBdSaDGUtgbNTFYO7J57ImS7nkYmd+16RzNFxVUO/oA5LIX6+OnmVEWT4/bhpcXy/+V2dST4TRmz8ilWkqSYlg4l/2hwO7ZABQbQ5uXJ0ZgmmWM/rSbYQWVO2Tb3ClVG6V1Z+UfSCnngQauK1qTBrYb5HDaG6+K64M8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuwiF4pUNUlJQtHzp2R0DGKr8tveY5M6Yn7OZq52Uro=;
 b=hRVcegH1BR5jPFP8u/XsGcj9diTUhj8g1BdLslo6DrMDOe4QgmXxRCuYLHq7ayden8Oe0TSBpq6iSRPR5UTaeEjpYnGsSr0YM1QSf3NeAwUiyHBY1aXE2xhXqql7g8jNDLFtQdDmEvBmvhhpNNLRYtOOSgrR53yGv4mdlHunqB2vIduiAagpOix500dtX3FnZWwc1cVdeXjdleYCzMXFEio031C59+vmI4ahh22xmJwaOVEhMrYaG2FE1xpu7bUyagaD6dLT90XBCrgnZNC5RMd7oEmh6hf27qSUS1f53/7UIKTH6S8MAQbUlRsZzwGEc9uCOBPqJWM26d52NPX/LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by PH7PR03MB7297.namprd03.prod.outlook.com (2603:10b6:510:24d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:31:21 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 03:31:21 +0000
Message-ID: <a2e5ff75-6022-4a9e-b647-b32933044335@altera.com>
Date: Tue, 28 Apr 2026 11:31:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] arm: dts: socfpga: n5x: enable DT register
 settings and update GMAC nodes
Content-Language: en-US
References: <3e607563-c61a-494d-8875-b1d51634fa23@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, chen.huei.lok@altera.com
From: "Lok, Chen Huei" <chen.huei.lok@altera.com>
In-Reply-To: <3e607563-c61a-494d-8875-b1d51634fa23@altera.com>
X-Forwarded-Message-Id: <3e607563-c61a-494d-8875-b1d51634fa23@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|PH7PR03MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1bd43e-bbb3-41cf-1183-08dea4d69ddd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: tKbt1FTVAE+dSSOPvJGdKsBWvo4z0rFwV5xPI5aam+ftMv/acLr/eVXMyC+IqDdPnrKEQ/Hzx/bUuOiClLHeAWUGYXNp8HeV97QtrBEBXro5Z/cQP7yhdsQd4S3VSVuRWxOLCebCmN3Np57QB1VMtjQxUAfnx+7C9lxhncxbCUnE1K5jqQ5FIanOGrLGtofTNpjph9YGX6Nl45aXq0CGxO5fngkwd/y04nGXPmdNtHhG9HPB7xAjLQuezmg1V82niN6Ibw5dP3UuSYP+gSgWu5E+xMLLwbZNnRKySun4sj2udPlJ/dIv2kxg3qyxAdQG4/UXww6eC49gGogJFbfdv+OzvLEGD9dm+c5kuQmVIyvrLVqvpe225tKLGg5+pXZki/67nK45RqaqsbJM1EZDYrzBUXBZxwMDyB7jZbALMKObCApb74GlNYeWZn6/wxkSfTqucYRgJl9SvR56884tiN6SMRIYPrBXHG3wo+jgRfZy+e4G8ymOfIxAXY+XlfgFTx/gA6qEGFaeDFtX3jehlZe+xyUj/mhpuC77aEhKYUx4CvPo22I/VNWHrvM5ahC0qcy4NhhrG5b7yCH2dMguazhYa01e9X8Q0hjQEtPvgSYu6yOdBZOxPwX18CCyqF8u5fjE83M3si8dVGcMcwnyBE/CFwLfBX2kpmMXbW+2GGo3XCs+g4SYVprSbQCMAVXQRmNV2HXycxsaNbCX/Dg3Pecos0zHt7aVgY1ys9Qfz24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clUrVFUwWUZRSEdTS2ViaU8xUExxTnZ2THo2Q0JHeC83QmNkcHNWdWM3MUxE?=
 =?utf-8?B?ZFhKcFhBeVB1Z1VFaTR2Wm1yRTh5UzVCNm5NdnFudjlIUW14eHVSaDEzaXhn?=
 =?utf-8?B?dXRKQTRiaCt5bHhpVWhjNjJZZ0hDVEZQK2ZBL0tNVmZ5Yi9wdmdyeTN3aFQy?=
 =?utf-8?B?cisxcHM2VnVFcW9UV2c4UDdHUzUxc2dnNGNYUVVQNVlnbk1UekRjUnl0eEhm?=
 =?utf-8?B?WDFXenIrWXdTL0cvZmxSNmI0RGRJNmFSazlVREM5am9TRHNKVlJ3Ulg3Wlds?=
 =?utf-8?B?YU9PRWdTT1BSREt1SkM3RTBDTEdxTUpVZjNNanJYRUZEOHY5aEpENVFZRGRr?=
 =?utf-8?B?dCtTVDhjcElyQVdPT3cyL3c4bk44Ui9RM3Via1NxMXBzbkZOUi9uYjNWZXdH?=
 =?utf-8?B?cCtrWklINFVyNU91YVVuOVBDR2RiYWQ3NXVBTWVXeW95ejd6OE5KcmpiNkE0?=
 =?utf-8?B?Wm5hQmhneFo4VTcyQzVlQkZ1bGk3L1pZTXJ0MFNGaHBRQWFMS2RXelY2M21Z?=
 =?utf-8?B?S2RQQ3hHTjh0dHU4YUNFeVROdkt6RTF1VWZNZXp6YzQ4ZEpkRnRCUDd4RVpN?=
 =?utf-8?B?cTNZNTl0VkNuVG9ibHl0bnFuZ0FKa3B2Q0dsUWJBeEVDL3FrQXJSUEtENUZl?=
 =?utf-8?B?M0tFbURUY0hZQ2pIMlVQNVk4b1g3TjVnTmVYZmlPWWpHcjlGT3N2Y3hLYk5S?=
 =?utf-8?B?Mkc3M0dzMDdBQWNCcCtrKzB5ZUltcnRWazViNDdIQ0NsWXdacE9pT0V0U09h?=
 =?utf-8?B?N25PcDY4R2hLUmtkRzJQMmlrMndXVHJNaFJEN3puZStFaExWd1RZSFdRckJL?=
 =?utf-8?B?dHBNU200YWxIK1N4SDQwTFVld0RGMHByUnZIREVhOXN2dVJhZTZZUm5lMDBp?=
 =?utf-8?B?M2lFUjgyWER3dWltbjRobVhFUWJ5b2tybVFGOXdGeU1UYnlrYXdPcUpQdjZi?=
 =?utf-8?B?SUxobjFDUHROYUppT2ljMWRIZGU5Z0UxaFF4WVpJOEsxZUVYWDFqSkNaSUxN?=
 =?utf-8?B?Y2NSMDhnQUwvemFMMVdiM29iT29qdlVkaElIL0xBQnZBNWkwcktxN0djOEpu?=
 =?utf-8?B?bXVrdUZWTGV0ZThuWkFxRmFNc0NMYkMyYlRiQmNKZzBDeW5yd3FoNTJCWDhG?=
 =?utf-8?B?b1pCblNNRVAwQTNjclpKY1QzMTVoTkordnRUbmhsaEtyL25MR2xMam9lelI3?=
 =?utf-8?B?VElVeGRpaFNhTXUrTkZTQTJkOTc4UVZpb2tPTzh5OFNHVTFsUStSSk5rVUxn?=
 =?utf-8?B?bmhpQUJ2SDZDeTlFNmpDQXJhV2YrNXBFYndwN1Q1TDQ1ck1iMFJ6SE9kK2VJ?=
 =?utf-8?B?dDdWQU9JOGR6eE5iRmhYaHdyeHlkaUk4T05GSkhhN3JCWjhYLzlFUGpqdFZY?=
 =?utf-8?B?WHFtYUk2dFMrdXlSQ2FhUWFLMUJKK2laeHJKbTFvOUx4cHc5K2FvcU96bjA0?=
 =?utf-8?B?ZVZUd25WaFdVemw0ck54djAxN3NLUC9jbTQwME9CZE5ZK1VmVDhycDRKRk9i?=
 =?utf-8?B?RytQU1Y5SENaRlZjU29ueFVCSVBuNFkzemxzS3hTVFIvOUFJK05jcDlIYmRD?=
 =?utf-8?B?S0J2U3BTMWJlQmtQVUxOTXJOVDl3K2JaZ1FMaHBHcUlEa1lHOVBPN1lLMEFZ?=
 =?utf-8?B?ak8zbzBaTkFYNzBkYnpZVGxpQTI2dFROVkxhL09ET3ZMR2JPZEFvUmFyeHFo?=
 =?utf-8?B?NThyTitFUlo4KzhhRWxSeFJCUzlJN2ZoazBDbGh1OWVIN3pWL3NZaDcvRXBT?=
 =?utf-8?B?Z0Zld0kzc0tnOWF0UHdOK1pjbWpxUmYzWTd6SGNGbE1ZQ3BJWUY2VXZnai94?=
 =?utf-8?B?c3JIL1FGM3Z0UDI1Wk5QdzZsTXVNZGpDRmNIaHlQaHZsREViNTZpd2FST2Z2?=
 =?utf-8?B?V251bFhQT3N2SDlvTVoyYmN1RjFUeldkdkpmY05yODh5SWoraWRCekkya1Za?=
 =?utf-8?B?SkNBb2p1OHR5dHZFSHIxSXpLeThjSHFkeVhKVEhYbGJQeTF1S0JlSGFOei9w?=
 =?utf-8?B?U2x5KzBSN2xSckZBRHB0ZWNPQnloWGhGNGRDUGsyRGI4VCtkZFdVWEVINGRJ?=
 =?utf-8?B?ck5NSFhUMDBXRUdkTDd6QjFlZTgwaVVBdFpJS1JxWXU4a2hnWklWUzJaQjF4?=
 =?utf-8?B?c0Ixb3N2SmFpekYzbEhKcWdxeElZcDNQbW5qWDkxendrL2IwMVRJdWUvci9H?=
 =?utf-8?B?WHFjSjg5M3paYVViNFVjVDAyaVhzcll2ekJRLzF6dy9PUU9zSWZkTlowc0RS?=
 =?utf-8?B?emdJalUzcjBwcTVSb2ZuT2xiY2FrcGdTUHBreDg0ODhmVjdyWUlUVUUra3N2?=
 =?utf-8?B?VEEyWmtJZnZoWjFJWldwSTU2N3ZDMmN6YUpkbytUQnc2NTZnYysvMTRjaG8x?=
 =?utf-8?Q?kqvy8ex5GU2cv0wU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1bd43e-bbb3-41cf-1183-08dea4d69ddd
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:31:21.5847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Er1wr9+IWZu9/yLM79jyG6zp/M33cvJRUNQEy3TQhK+HOCH8Gje0FqqHw4+aAUlhYo5+68YVW2gCqSQp54gLOdjAHTKHdqF4Q60qNddHTxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7297
X-Mailman-Approved-At: Tue, 28 Apr 2026 06:27:12 +0200
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

On 22/4/2026 5:44 pm, Chee, Tien Fong wrote:
>>
>> Remove the clocks property from the QSPI node in. The QSPI
>
> The sentence ends mid-phrase. It should say "...from the QSPI node in 
> socfpga_n5x_socdk-u-boot.dtsi."
Noted, I will fix the truncated sentence in the commit message.
>
>>   &gmac0 {
>> +    compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", 
>> "snps,dwmac";
>> +    reset-names = "stmmaceth", "stmmaceth-ocp";
>>       clocks = <&clkmgr N5X_EMAC0_CLK>;
>> +    clock-names = "stmmaceth";
>> +    status = "okay";
>
>
> Enabling a peripheral in a platform-level dtsi rather than a 
> board-level dtsi is wrong.
>
> Not all N5X board variants will necessarily have GMAC0 active.
>
> The status = "okay" belongs in socfpga_n5x_socdk-u-boot.dtsi
>
Agreed. I will move the GMAC0 status enablement to
socfpga_n5x_socdk-u-boot.dtsi.
>>
>>
>>   &i2c0 {
>> @@ -132,6 +145,29 @@
>>       clocks = <&clkmgr N5X_L4_MAIN_CLK>;
>>   };
>>
>> +&socfpga_l3interconnect_firewall {
>> +    coh_cpu0_bypass_OC_Firewall_main_Firewall@f7100200 {
>
>
> DT node names should follow the generic naming conventions described 
> in the Devicetree Specification: short, descriptive, hyphen-separated 
> names.
>
> These look like register block names copied verbatim from hardware 
> documentation.
>
> They should use names more like firewall@f7100200 or 
> ocram-firewall@f7100200.
>
> Also, the mixed case in OC_Firewall_main_Firewall violates DT naming 
> conventions.
>
Sure. I will address all the above comments as suggested and resend in v2.
>
>
> Best regards,
>
> Tien Fong
>
Best regards,

Lok

