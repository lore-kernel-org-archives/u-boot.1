Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85160C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C52B87FBC;
	Tue, 12 Mar 2024 16:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/satq1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DCE087FBF; Tue, 12 Mar 2024 16:13:53 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA3C87F8F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Px1Klg5z4RJBX/abfmZ/Ol88YmPwFmbBU/ewxxW6X/RvSICApTZ0tJ1Ul9P3JruiXcutk9258Ssi77IjoJioPSzfWwqj8EBD6y/so9neIMS5dQAQjy0f7uK2A/MjcPTqlStvdEiofUAC46diqOXZZFqJpWFL+Xv7OBnhZnWXjkXmI4+8LHyWgEudNcSI/l6lk5a5EXAlg0GzjFqFAt7HSLg/MtZevDcguBatwaFzicYC9AhsYpGbEDeRSgqcieQsyoufx2b/vpiYCreZnLfuNnKOeZXpKoMfX7Q1u3FU/X6y2YPRmLoBZlEq/S7X4FfW6Ozff95PHzpL2an59f2H8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoJKUMnpUkJSgPY5gnEIAVOKc+2kQOYuRMUc9ni02Pw=;
 b=RUDR36CTGEmYNI70veyzWchL7MWnJ0LyT+5MsKMViS9/f15MTmCIHBCv7PTVsGXiwHYp9HRSEE2BGijnsz/w0BJznpO07i5qgofaI4N/Pmb8cf9PxdIXVRBW9peCxmc4DlUR7je18PANpY4CfvuZavz0nEp/ZHFL/ld4F0bExUhnbl980gDYzio1+WgqCUZUhm1W+u55OluysZuynKlVZ/5s8EQUNwpPXvZcuQlCWifo+PuqRl+uIeFaqEx1DIo3Y+7Tq+/wffkeu1YX6bWOU0we12DcVwOR1d9VX2w7XmWDm6ZqP5F3q19PG+HTkPM5WgafW9/APQnWqBbt3z4PYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoJKUMnpUkJSgPY5gnEIAVOKc+2kQOYuRMUc9ni02Pw=;
 b=z/satq1KKkCJxv3F0lukz7VnUToeUDrsjcfHrctD0gSThGqGxcM/EBVVdxZPZ5QsBFk2msqEq+8C2fOl5YpkrsVlshAj7SzydPzhtnSXDGdR1sLznKuYqPAkQrNPDXUn64MVJ38ouvvgGlM24NXtUVyoKWyVG9NR5+kekbgKLEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:13:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:13:46 +0000
Message-ID: <b60c6758-716e-4a91-85b3-8cc9f5398ea7@amd.com>
Date: Tue, 12 Mar 2024 16:13:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Describe USB wakeup interrupt
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
References: <d8109a218f70c257e4fc52b5032b7df68fc00786.1709887312.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <d8109a218f70c257e4fc52b5032b7df68fc00786.1709887312.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: cac22b31-36e0-4fad-743e-08dc42a7034e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7QOWzc3qoWUbM6xg5Z2cK/jpDGQmC4TqkFXQGFXpi/HglgTFpGMR0RMZs/29E29U3H5L4Mh3pC90rMcsd7jbjwid2vtqlZsZOaN2THv6ineoP6un1fc+X2RdXbaDvjp5LKJZrXG0/BBmAxr16tUo8da4UJxUYpwI7ye0T+4Aq3WGPUvrGAoq9943XfvxYy8PLnGGf4Zs0ttTiZULOkPxzxCkhpxgVY3YI8KKt5RmJVFC+sy4y86tjHWqtBGp5DW29fyKVhdD97itgnEnnsaviCsqIpYw6h8zREsV4i5xn0ZzBoNq5iUjOVngQWYhgB2OKcPfPm7ErKIJGdt+3E9ms6a1XXtq/vVBi3JUJUc+keeQQ87ywjo8gGnBM+8yFMA7sxlQk5CXfcJo97eUL0TSOmMZh3oakYf2q4aCp2LfEqX42L45kJ1cxTJxV2iAREooZFFxyELt1qjD+M9UY44NZErMTl0bVhaTsMQNG0eELWukXd5+aTX0nLtVNahWYbecPwoTmc23m6op6lCg7FjFI3V3DqboLtiti86+ZKx5Q7WV3fgiQ6RAQ7Cn38QEnDjDXn258gilIcfFwIulbsVbW/kJGoB0ASELPjgpVuQh/ONSkJidukGY/dWL2LytLxx2lFftyZwgN3qOswW8tX9rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpCcThrL2N4cmxSaVQxYUgxcUdhVEt1YzRUSDM4Y0x5anhlL0ZzY0NvWlBx?=
 =?utf-8?B?VXRNUzY4VG00RzJnSlgyU25NWk5yVXovMkRTR3VPaVd5OFhVblZ2b0swdW5u?=
 =?utf-8?B?cFJ3cWhXUEZ5MHY4bnFtc05sOEFQTFZMcXBVWG84L0pDU2NnM1RhRnRHOWk0?=
 =?utf-8?B?bXQvQmFMZmhIRFpUUGp4Uk5PN2x6N0c4QkNVdmdqM3NBNVpoRjFkQ1VXWnZI?=
 =?utf-8?B?QUlFZWs3WmcyM2cveDhBOFg4L3lDa3M2Zld2T3V5VGZocFFKK2NwVEkrTjRq?=
 =?utf-8?B?MG5LVkNjcTZiZVNKd0ZRUTRUS0pZZlQ2b053ZGhIK1AzK1VuZlpjblNydjVn?=
 =?utf-8?B?Rm9pdTBMMVhMVzJLWTJUWWQ5dUtEN3V1Z3I0OHhuWW9JSEYxdzNiakUvaDh6?=
 =?utf-8?B?Y2MrMjgrd0hVaGJFWEtlSzJ3eEFLcXNNRWNXTXQ4MmZ2QW9wMFNmNVRUUU02?=
 =?utf-8?B?Yk9kaERNK3ZxTUFLTjZvY1hVbWpPZWpxWGc1aHB5SlpXaGNHZ1dtUE1HZmww?=
 =?utf-8?B?enRyRGxUS280N2ZHa1VQWHcySEhMZXV1eDEzOExDeGxrWHY3SjFIUWhmemhT?=
 =?utf-8?B?Q1lNSFFxSjRxTURYRTN5cEVHdFFTUnAvRFd3eEV2Wjg2T1Zrdk5JMlY0eGFx?=
 =?utf-8?B?bkMrcnZqaXJjN1NTZG5mMzJNekZoMTNnL2U1MTEwUTNSeXRUTHBpelVHTXBU?=
 =?utf-8?B?emdqbjNYOWwvdGwrYk56KzBER1d5UHdvUWFFU3pndW5MYVNMZDhMdExTcW54?=
 =?utf-8?B?aGdtTExlUzZITWNqSW4wMGRHVmZxVGYxTC8zNzRaZ3FPcnc1Y3M0UzNSS014?=
 =?utf-8?B?S0EyM0c0bk9FNVk3SitwbnVEUlJNREgzRGdWNVA4eGx0bkNvLzBkcENqMEJO?=
 =?utf-8?B?NDJNUWxNWldPSmoyUmtWTmJabGJRUVlGeUY5VVlVNU9lejRFaFNoaGNNUjhC?=
 =?utf-8?B?S1c4RkhJd0lCZ002b0xmT3I3aVQ2ajJuSmYzamp0a1YwazFLaldGSFg1a0c5?=
 =?utf-8?B?SkRjVVBwS1NjTzkxdGxYdHNZZ3UzUlBJd2YvdVFrMjc2R2d1YkVEWHBvSEJU?=
 =?utf-8?B?ZDA3RUJKNmd3SFY5cFBiZ0JNVmdqajlBL1h1MFZYdHQ5S2MwUWxXR29ZdEVT?=
 =?utf-8?B?QUdkZTM5alhyZkZzMHlxUWNCZE1UcUNJQU1hajduay9DLzhZak9GZy9OSTVP?=
 =?utf-8?B?SmM0NDZ1bmx2ckxYcnNkZitkd1VGTjIzYVZmYnlScXQ4cmZZVFRMMXZrSUtx?=
 =?utf-8?B?bHl6NGRIVEJVVWYrNnIrZThDMEFiNWJPdkg0WXNEdFlZMzR3M0ZOVzlmMXhS?=
 =?utf-8?B?WG9JQXNSWHh5a2dweVpLSFVrU1hFSWJNSEswNFpSUlZCQTdocGFzL0djMiti?=
 =?utf-8?B?MGE1cTdRVHpVZks3OWEzRTJqSWJ2c2lwZDlqSkR0VmxuNE9IK3JaaTV1Z2sw?=
 =?utf-8?B?aXVEQVkxazIzQ3dlQ0ZROWhWUG5VbmxvRzFZb3U2ellZZ09keFZteDAwd3J0?=
 =?utf-8?B?YVRCaXpUTUV6c1ExQTJrZFJXVCtYN3pHMUZHb3FQUlF2Y2ZwamFmZ0V0ckM3?=
 =?utf-8?B?djN2K0pETTUyajBLelFZWnhVeTZBN1FHYndkNlRzK2VLZ1gvRTZxS1hzNmg2?=
 =?utf-8?B?cTB3Y2VPSjB2dGJNeHpCNTRnTkNaektBeTVtcHlnU0huZGp5UzI2bDFOL1Nt?=
 =?utf-8?B?a3lVN0JaS25HTk0zZGlzL04yK1UybGNsVnhjU3A2NnZxS3RFY3Aya0F4Qk5M?=
 =?utf-8?B?bkx5ZGE2WWIyRmptS3c1L0Z6dEdrTkY1UDNFbmZxdzFGUmI1T253aDFRblR5?=
 =?utf-8?B?dE41THJNS3I4TEthSmg4Nkt3VHlLZEJGaXk3NnNOSFJ1d1pJWUNXN1lTd2M1?=
 =?utf-8?B?YW9zdStqZXJOdmRGb3lsT1pIaSt6SlF0aG1JMDF1L1NpUTBqMU1VdmxmNTE3?=
 =?utf-8?B?OUl4OGZRVlo1eVNaZDVqWWFEZXF1MFp5OWtoTndSU3NRNTFTWmwxMVhNeWxV?=
 =?utf-8?B?TEQrZTJJZlpZaVhrL3pvZkNtaVVaV3E2bnpHdjhMQThVM0NlSzR3ZUtmTHB5?=
 =?utf-8?B?UDEyNUF4U05nN1lKcVU0b1BrWE9BUWtQWXE0SEcwSGRhT3pHbUI4elJKODM2?=
 =?utf-8?Q?rKmx7dJ27Kx0XEeSt89vpDOqf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac22b31-36e0-4fad-743e-08dc42a7034e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:13:46.4649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bICHDJVGLl4+ahqgL8HEF5voXWsa9vPdovMLJq3ZRCszdlvUQE90YpP9y/5ZTdtN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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
> Describe usb wakeup interrupt.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp.dtsi | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index daae23c12b79..c19d86e5a0c4 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -1001,10 +1001,11 @@
>   				status = "disabled";
>   				reg = <0x0 0xfe200000 0x0 0x40000>;
>   				interrupt-parent = <&gic>;
> -				interrupt-names = "host", "peripheral", "otg";
> +				interrupt-names = "host", "peripheral", "otg", "wakeup";
>   				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>   				/* iommus = <&smmu 0x860>; */
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				clock-names = "ref";
> @@ -1032,10 +1033,11 @@
>   				status = "disabled";
>   				reg = <0x0 0xfe300000 0x0 0x40000>;
>   				interrupt-parent = <&gic>;
> -				interrupt-names = "host", "peripheral", "otg";
> +				interrupt-names = "host", "peripheral", "otg", "wakeup";
>   				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>   				/* iommus = <&smmu 0x861>; */
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				clock-names = "ref";

Applied.
M
