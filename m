Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F7AC54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 14:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DE987F33;
	Mon, 25 Mar 2024 15:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JtM8Upmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104BF87F33; Mon, 25 Mar 2024 15:18:26 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C37D48718A
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 15:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ht1nqnb926fZ+NqAu9dkbRb+K5qiXnbzyEiwOmsnWe7653Y1uqq7kAJ2cONDdM5oQ2VB8jFQAGTWVAOSVvRJ2RN2N16HYVqbV3DerwkJjpDJFYqmqLkq8psbqfaQwPRIluHPKAw+mcKvFhwy+A+CNpURSBf8b+ctjb5EYwaf3gA6fjcV78HevS2ojHtdDkTGwptAVbAwQ3NORWBwsI/VivM9YQ9tz/YnuhZ4EAIrPTbP7M8Uh4SjWitlTXjFWQfAdW6oaHCuGuYhUNeqg45HNKBvhitIh4UkVM8EuKJ/9sUImR4bTO2VT7ASrllbfpojzq66SRcR4PhtRkc6qtgtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qL0Z+KUTMvSEdR6JdRNyxmyDBSsb4uHkkn07ToCWCKc=;
 b=HMXUDNX4uYhjlTDnceJLQTi5II5OBCjPDUnMZfK+hNv6IqoPkvKu13mpYdXAUNJGxzJHAuOCLoHGdiDFu3/XocncQ3pfAkKuEmIt6iLPP8osR6SQsm3Q7CFKXYN7Jpbj5SKOBMiMHl6ccCzgQDN7KzXyEiHABgQa04ijbn4/Uxzdq6dsrGQDnBj3bjRgNBFYW758pyW/Tu9zwZv/QZWmXAtynGIicugdzV/d1i5jbTdaJa9ny/KWTBnRQziwtuF9moiaQsXwgQYj5HJl5r61KeryVWrtHAT+XSZu7rt4CQltGSzFZ7tc+Vv5KF3l5/yqI1X8R6G6WyiiHM/suazB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qL0Z+KUTMvSEdR6JdRNyxmyDBSsb4uHkkn07ToCWCKc=;
 b=JtM8Upmd9TyUXfMIyz3N0NWQc3Q0RQK+8CKDwKIX9NcQSuSiX5oBd2+Bxs4IJmVp7muNBHwsI38aYfdzmSPj9YlXkt6JsOifLV4az9Mrn+5Mr8QbEQrUNELQmEBPaiAzxB1VzqCc1sthfEshAvlhevp+E5+fykG6oMwqtnUpmD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 14:18:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:18:19 +0000
Message-ID: <c2b26cc1-bfc3-40bc-bc54-9882b212601c@amd.com>
Date: Mon, 25 Mar 2024 15:18:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: dts: Add required properties for rs485
 support for KD240
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Harini Katakam <harini.katakam@amd.com>, Neal Frager <neal.frager@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <56e4e135ad796afd1370c3dfa2643c143ba758ee.1710847646.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <56e4e135ad796afd1370c3dfa2643c143ba758ee.1710847646.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0179.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f42de52-1bb5-4243-b058-08dc4cd66bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdj5D8D+RXeA7bKqxhxmxjFELVsmoe+lHLBFcotKQqQDQuZe9pYNyxL2Ms1xjPWs+sXqiOrHYIzTYlQaQm9hWH0WKEg+wduZSZ5M0ZM6r7gvgbkmSr94CpxsTWxGvLIW2/+wJTGRRwm/0ImpWCxhohRi+0uLGK+53K8w4acVVto/B8NMpCA413zNwCFoGU5670AOlT5LTlDfkKJkDtROCTeqE1mRTXlkTIJT6Z3ZCxCMa0kWXB0+It9k+d9Ati04dvEUXTLLhjTCbc1owi3fl6MjYuwOA21nO6Gysd963bLOaP4RMRNkm+ftD0ErhDscxiHXOpXcXnb8dok5RLa4L8EFwwtEesmbuUOMGTol30JwFFNMYXcJHn5JF6QnQeSGXux1DBSqSqICOksGTLKzbjXgMukiQlNDi5brok4fdhLwKUfQ7H1w1WFzvKvdb6gaoNERmBq1Z3aPtl7zJpXdLNsuZzG91MGeYWEu0lSVuBJAuVl9BsoGVt/KfHXflg0ur77BXfoTC/ti508z4folg/ji3uMntUI/Cs/7WO5SsHO+NNr6o1eM2bjb3OqLAnwABSOkiS6gNPRtt7b8VaqFDfPrs7tmkErAZqwGoqHLYHuGKa62KAffxpFKpDr+7vhvGnC2y4bTpHV/vnbLBAeV8D73aeCDlgRwV4ULFdwu/U8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wlk5T3R6L1A0bnlnT09IeWhXb054c1l6amR4NklDZWcwN3dkcHdsQmpHamxv?=
 =?utf-8?B?bHVJclRrd0ZxbE9TSldBb0tHQUtYWk5qTFdGMnB3dHBPRVdGR3hXdVpPNW9H?=
 =?utf-8?B?VmhOdldrN1pRN0xEanpCbzdVdC8rU3JYSk1OaUx4Z25WditPcUg0UmllSDBh?=
 =?utf-8?B?RWNMNEJKNnAwaUhzazEwOFpCcVd6NERyZVhvbDduQUE2RkdhclNMRWZ5KzF5?=
 =?utf-8?B?QUp0UEtOSTVzeE95QnpnSFczUE03K0xjUDVJdTJwRTU1U2tZQWVEZzJsNTV5?=
 =?utf-8?B?aVZGMXlvQk5Pb0NIYVFBVjJwQmJCMVVSVGJDT3R0RGhJWnB4QnVjVDZ2MEFt?=
 =?utf-8?B?SzFYcHRBSW8zLzJjRHFaUGtJL1o1bkhVUUo4YWJJbUM0ZWdiTnVua0ZoWnpt?=
 =?utf-8?B?VTBCM3BJNk1jYUZ2WkVqQU5wVGdjN2xzSUg1TllETms3STZnaUxlYU8xOUZJ?=
 =?utf-8?B?MHNKcGlHK1JyUGx0eG5uNHJoVkc5Szc0TE5UM0dxaHpHMDFNalRhdXpvU2N0?=
 =?utf-8?B?L3lhclo0THJxZkR6WE8rcXFIS1pDdHE1ZSs2UlVkMDR0cCs4OHprWHNxYnhZ?=
 =?utf-8?B?WFV3Ump0QnJ5SlFPa0JvL1dTV1NtWlJiOFRBUU9yeVBKc1pwVlNQODVYQjRG?=
 =?utf-8?B?ei8xV3VHK1BVVUltRW9HWG05ejVGK00yTldCaHdMVU9ia3IyMWswWVFncnRk?=
 =?utf-8?B?VmFaMHVDUVF0d1JHejRNcGJxWFIzRXpkZzlsWW1ZMzJ3OWxic0VvQjdsNEgy?=
 =?utf-8?B?Mm80YUdoRVk0d2gySEZVWCtNdU54Q3RmRXpnaUlwbjliRUd2TC9nSmJZcUFp?=
 =?utf-8?B?LzQwdXlmV0YvWHlZdUEzbFJaSDR6WGsvcndCdHR1SHNNN2FYSDh6NnQyM1Ri?=
 =?utf-8?B?TGc4eGlqNkNqUFFLRnZvOXhrSW9EYWJrUnF0Z1BwVGFhdncwU1I2YTYvSkhS?=
 =?utf-8?B?NGJpZFVxdklmSUJIT1BaNnlNQ3grMEdQS3d3UVhNUWwyUjJyWSt2Um80aDJW?=
 =?utf-8?B?cW14Q21lSVA0cUJEd01acFRZTFEwbEhRdE9WOGdtMlhpMjk0TlRVcnQ3L2FU?=
 =?utf-8?B?NUdhTDQ5ZTNCNWxwbXRQRE1HdXRucmtJQjBQWGY5TEo0d1Y0MzdyQ0xkWTh0?=
 =?utf-8?B?NXdodHRpdlN6UmVuSFpyaXU0NWhCTi9hZlBHMjlYdmcyYU8rZGFHd2FYeTJh?=
 =?utf-8?B?UVZrZVpZcVcxMVAwWVBIb3FpNGp0dVpBRnRYaUFUUnV5K3ZJT0k2c1VOR2V2?=
 =?utf-8?B?dDRwdzc4ZndPRzZRMkRGMTJwbEkrVDMxVDlmc2Ztckg5R2pxeHM3ZEpNRFhi?=
 =?utf-8?B?bnpsYVBUcktBeGppT2pRVGZ0bXloNFF6SHNvMk91bE5SZ1FZZTN2V3VYTDJG?=
 =?utf-8?B?d0RZRDdTc251R0QyZHhuVXU0TXM1cW1LYm5ibm5xY1ZKekVBeDl1dE5xV3Zl?=
 =?utf-8?B?Qnh0amNqeGNSRVlsVndmcHgyRG1OOGNpTGZlMy8xb0R0UlBzN200eVJ0UGhC?=
 =?utf-8?B?dVQ3L2tlS3Y2L0U2UjRsRElhckxvbldUbmpMREVsRjRyeXVTdS9FMFF2NHJK?=
 =?utf-8?B?RlAxUVVWdVR4UExIQ1BPdkNHb2orNXhrb2taMkc0RmJaVFRNZ3Y2WERKR09h?=
 =?utf-8?B?eWpNcjJTU0ZPT3J0aUVwbS9rS1Y4R0dCZzlDZ3VSbEZJWExFM3RyUUdDUkgr?=
 =?utf-8?B?QVNqYkdIRzVHQ0lNbTFnUWNTTWlFZ2NuNWJQNkZaendZbkNKYWxWU2NZeEtt?=
 =?utf-8?B?c2pDei9WWjFqNEFzREdueEllRkJIQXNaSnZFNFhKZzUvMS9rTGNobTUxekJx?=
 =?utf-8?B?bStOQXlNcFNoSG0rSW93b1RvdnYwamRMTXJzcHQrdWd1VGdVaFFxZjBSR2JH?=
 =?utf-8?B?Unk5SVQyZUliU0RTcXQwRzNmK2VlbTQxeWRRRTNmL1hnK3Rwa0Z6Q1F3Vmhz?=
 =?utf-8?B?N1J2cG12eEpDOGN4TkM3RDgvaFBnS3RiZVY1ckxzTUpoN251amlaY0FCYWR1?=
 =?utf-8?B?R0pqc3ZQRU50YmhDMlRNenZ5Um9haU9ycy9ERjBmNEdiYytKMThvVFU0Z043?=
 =?utf-8?B?L2J0UGxBaEE2em1Tc1dnUjNhWHdpak0ycndyQi90ZC9JNm5vNU5BY3l2b3Vy?=
 =?utf-8?Q?7XXf8VdV0bytg4fWmD857GqA0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f42de52-1bb5-4243-b058-08dc4cd66bc3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:18:19.5362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJBS9Apjs72k1KPk69RCKcdtL0ZDS3Jr59bzxwOTw9afBcJUQfelqZaLJWZfY4WH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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



On 3/19/24 12:27, Michal Simek wrote:
> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> 
> Add "rts-gpios" and "linux,rs485-enabled-at-boot-time" properties
> to uartps node to support RS485 on KD240.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index 5202b7c48198..1727a1cc15c1 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -356,6 +356,8 @@
>   
>   &uart0 {
>   	status = "okay";
> +	rts-gpios = <&gpio 72 GPIO_ACTIVE_HIGH>;
> +	linux,rs485-enabled-at-boot-time;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_uart0_default>;
>   	assigned-clock-rates = <100000000>;

Applied.
M
