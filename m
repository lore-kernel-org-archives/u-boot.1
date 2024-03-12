Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D573C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E68C87FAC;
	Tue, 12 Mar 2024 16:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xJ42GT4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D74D87FAE; Tue, 12 Mar 2024 16:13:19 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7843587F8F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU6ze57At9K5B5APIuZK9LAfFQzTiD6FmNSt8zBDz2KLFVkykgVnHuMaRmOGuv+MeecmB6m5mQU8wHsf254B7oWu77wvCe+DVz+F769b3QFqPjoa9RbuVtg+BKynEjUU8odZ0GH6EQN/2DoKKZ1kMSnf28HyFiG9XrGPRMaLZnVMKtqidCKjEmPUy06gPZ+Xm0k2IeOIJPsnJCbZbyLis4GTWpJZ8O149HGaSJffP7zn4P4aJEz7IcarH6sQnvdmOH5veEfELzxtLzlBNqbx3y3uBNLmo6P7uYU0kLsYQum0w2ekdKnSiS5m4DoprblUbRs7baeD9RNQKf5WZ55tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q22iDXSPy9KdZo0gK61Se3FT1KpmJl8WyNZkSbYb2XQ=;
 b=lytzVXMkX6L6z4YYUaqq0CdZF9GKsAuKe1gF9J7QEBRAoCQuZT76RY5Ewqgvs+gX4wq/RyJZSCkVdFkjC/6aoth9WyDYBQERl77/aJyiFjU5JP7C8KfvgXBS0nkizlRqxzUIsQMZEG1XsJ509MLBkSlhyXQCXrl0vUuMJpswQSs03+BdPrlVgAQgZSPz1tQ5W9otxuZfLV7/H5nBAjwzg7E8XNzhi67ZCoKF7LIz6zJAgwFTRARz15T6ffcNrwwGRo7/vCrb0aEDuHGY+uVVbKkUex5aDs/30y+YyQt9Zebcis69VMm3mumguMbIo4/RVsV4NouNFZjE898b/66H6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q22iDXSPy9KdZo0gK61Se3FT1KpmJl8WyNZkSbYb2XQ=;
 b=xJ42GT4ff9yJOhI/SwOtfC4w+CvEqCj2Lt8gKm5mOgjIbTc0/2ynNdZlQZgvut8dB0T4CZ2gTJbktUGDd47Y5GZ3nlSQNYXz84gA+5h4acbAI+rDzuLPcWzNgAU314hWF26nAaQXE5EiGlE640X/sSfF0rgeVJccxbKXF6YIoN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:13:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:13:14 +0000
Message-ID: <71b9269c-af3e-4533-b824-46de3247f8a3@amd.com>
Date: Tue, 12 Mar 2024 16:13:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Remove additional compatible string for
 sc-revB
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <54e77ad480c5de8703cb5b22408dc3bf72f3f431.1709887280.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <54e77ad480c5de8703cb5b22408dc3bf72f3f431.1709887280.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3d8ddc-98a0-437e-d9de-08dc42a6f032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zpu8YozCMP63/qHJ+W2tOP0XWNLzb02gYC9k5hxrTb8DLkIwMweN5/xqQZPmrZuA/u5yTfRFiK+sGP4sdM3GMmAWMKc9FsBzQj3A5w/RbugtS9M04qsKUdtxsYg9pk5VczkruWluvfPChfMqgn6WU6kpZlfslyAQ1NgErr62EwbzBvNszpY+uaS/DGvaET7oUGP1s8KdvYUCaA6NAhJgNw4b+457AsXBoHj97KoCPQ5wRV7mAUi2UfNH1OIfU7VW9hx/+UZiNRwOqSG8eDK7OGgKniOvjc42eOXvdHMK9+T17jPy6710DXdbWN3odI2qwMpAfh7oqlkWfamU4zqfhn1PwJMTQNXm1DzxfvGjwRJd6hde4dBE7Lz7nDeWxMDKWLBSUkzn7OYRV2zsagzmbz9JAvmf+4hwBeM1S5G61eIeocuY01qo1omzraTDECHVngj4jRP34qvYW18biTCmQ5o+0R9+r/UA+5UVCtn/q2kSq5zRqjW19sS7v1fjXpScBVTCEJ9Ir8EN8+mmsh+TY/BWjTW4SkuBqZmaX3jvgB0DUaQmXd3cuXIYgMqlFl+sZe+EK8WLo6TYfUQP13RCA8TJkLvPLAg2iey3B1VNrGJfXwGHejXgi1xtoA6MzvGVU2DvYDdyMIV0NHC7+phnW3t2U34oS1RcfjNcRCut300=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWRNSFFZR0NnMVNRcWlzaDJqNGF5UEVTcFlhb3gxY00wNlZqeDFueHcwbzY0?=
 =?utf-8?B?bVVmeE4vTVVHTWJCdTl4N3c2QWNCNDFjWExuT3NibksyaW8rbGlvMkNGUEZZ?=
 =?utf-8?B?UW9OamhmN3pSbEs5L1U2NkxHYTBTZ1pPb1JnSU5ROWtkTkR5VlpVYlJTS1FQ?=
 =?utf-8?B?TXlUWUJJVk10SkI2a0doeTVYcFdWSXE4RDZ1RkZpMEN4cmRKY1h0TTY2aGMx?=
 =?utf-8?B?T2V1U1VKb1h2SE5YbXpJWnQ1ZEdOTTFLOTJrUFMxdjNhTFB0bTVrK3QyOXU5?=
 =?utf-8?B?M2ZPTUFrK1dRbzExdmI2YTVSNHpMUENudGJnaUNwNHJsdWM0cW52Tm1yUlNl?=
 =?utf-8?B?S2M3aEhZQkNvcDZjaUwrdDNFYUZXK2hwY0poR3pwcDJFcGlaZHFBa2RuL1Qw?=
 =?utf-8?B?d3IwV1VTMHo0TTNRS3pXRkM2Um9yM1dSbm1SUXgyVDdGNFViaXRQYVc2U0kw?=
 =?utf-8?B?aXNCeVFqQSs2alFWRGhUSndHT29mZmt6ZFQ0N0hzR05ZSGswWkN2L0tDYVd3?=
 =?utf-8?B?dnJtQklzNmN6R0w5bmppUU5EMVgrU1lONldZdGVWT2d6ditUOTVyTVd2RCtm?=
 =?utf-8?B?VHI1QytRdGM1M3crTDA1VDdmVVR2R3NuV1pZVnZyd3NpQzhJQmt6aThsWHM1?=
 =?utf-8?B?MEMva3ZObUF5Qk84UHhZSlFnUlh0ZlFYOGZIVFRrYmdFQVlUZjBrK2RJWk5T?=
 =?utf-8?B?VlhYdWJvMmFEZXhIVzFxOVlVeHJkZzcyRW5hODNNNDExWUFkSmk4cnJKa1JU?=
 =?utf-8?B?L1NTVHU1VCswdHFvM05HWEFnVXo1K0ZZLy9NSTc0SHh5VFNCeDVHTjAxcVdh?=
 =?utf-8?B?NkZxUG0yblIrY1VRZHFTRFM5Um5JZmVVS2VhTmUrTjNpMWVUTGY2Z01nVHpD?=
 =?utf-8?B?SnRyYk9yaERCK3E0NHc3YkxyT3p5Q1JxNC9Id3FTMi84UDN2K1JjL0J4Vk5m?=
 =?utf-8?B?elRDeWpzSUhacldWd2hEd05DM2kxMk1QQ2ZrMDlwSTNBR2o1L09IWlJnUDE1?=
 =?utf-8?B?SnYwV1pBdFk3bHJDYk9IZ0hpVWREdHhhZDRId1Q2aldOQitUNTluK3pYSmVI?=
 =?utf-8?B?OXhPdEd1bjVRUFhxdURlSldRQ2dEOWsxZnUzZGRRNDNMZjNMY3dUdVpwcG9Q?=
 =?utf-8?B?NGVrOXo2MmxxT2REUmd4ZVNtMUxHdmI2dm9TRmU5eHVSdTF1dzRIVTFTaUsw?=
 =?utf-8?B?MlljYUZUSHlrTGNVYmlaVVZOWFRlaTNhaEdGcWdoVkpIRTduWTFvcUpaMlpD?=
 =?utf-8?B?bXZPaUNpeTVUL212TXcrRHEyMjVsRVlYd3VhelZ5T1hneldFYzFJVGxNcExW?=
 =?utf-8?B?RG4vcEpEbVRaVXdST0JGQmduQ1NFVy9Hd2hYc1JTbEpGdDdteTJpamNDV2Fo?=
 =?utf-8?B?OVhZb0JnSVY0OStlWUY2VEZSK1JEc3lEOXMvOGZXUm9Hbm03UksvTEdZdzFI?=
 =?utf-8?B?OW8yVEdPQ3NVWGZGamU3RFMzeHVaYWZyRVFYWG9SV0ZseWJyQTVEYzgzcVY1?=
 =?utf-8?B?NjRSMHV6SWhaNXdOWVBkVCtyT0lQL1Q2TlRsZmFDVU5pRWxFNnpkNkhXMmp1?=
 =?utf-8?B?UFZMMUc4Qit6dVJxZ3BUSkxrYkpLY1hySXVHQzdQOXA2WEhIaUFUcFpVWXJy?=
 =?utf-8?B?aC9mTmN3Zlo0emRnaGNDU1Zsd0lnYk45Q3pYUmFQLzI5UUlzKzRWYStwOGQ2?=
 =?utf-8?B?TTlwd1dwR2svZTFJdVNDeTg1ZTRYTFE5eGZRL29SVktVZDFvNm55Uy9aMU5n?=
 =?utf-8?B?eTVpakdOQi9KMGV4MGt3QXp6d1ZyQWtMVUIrcGtVVTBPbWRkUjVZSEY5SVd6?=
 =?utf-8?B?ZExJZ1BQUFo3Zm9DMmtNbjloaFBUeUFTaGRLaTdEUFh2L1d0b3Q1aUpiUGtk?=
 =?utf-8?B?SVhmMU1FaTUzeTJkZ1pGOWxOK1V6S3l3WDdKMUo4dko5R29nWlNTSjI4b1JF?=
 =?utf-8?B?R0RMQUxWcnRrR3hFeWVvOHp0M28rOG1aT3cyK290MVJpbi8vblJXbC8xN2gw?=
 =?utf-8?B?WXNxMUtHcEpwV2toVjBzdEZGVnFIQnFYM2tOcXFXNzhoUm93U0pwV1ZZKzNV?=
 =?utf-8?B?TjBnRXl3enpNY1hjODhxeVBMOVlHR2NQOU9IYUNBeW5QUDFxTm1QemtwR3Fv?=
 =?utf-8?Q?5GvA7MpeGJING1Kqc33aD/CHx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3d8ddc-98a0-437e-d9de-08dc42a6f032
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:13:14.4079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZydsgWyziv/uL9gRnK8b9D4hSeAVQi/NVE1PIDRTuWZFmgwQVB79jlZJZN9vrIzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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



On 3/8/24 09:41, Michal Simek wrote:
> Based on dt schema there is no need to specify flash via additional
> compatible string and generic are enough.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sc-revB.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
> index de2d7842ae28..c1d713b5d890 100644
> --- a/arch/arm/dts/zynqmp-sc-revB.dts
> +++ b/arch/arm/dts/zynqmp-sc-revB.dts
> @@ -192,7 +192,7 @@
>   	status = "okay";
>   	/* QSPI should also have PINCTRL setup */
>   	flash@0 {
> -		compatible = "mt25qu512a", "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
> +		compatible = "m25p80", "jedec,spi-nor"; /* mt25qu512abb8e12 512Mib */
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0>;

Applied.
M
