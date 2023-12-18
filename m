Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B29EC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 14:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 184D887D65;
	Mon, 18 Dec 2023 15:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0NEl3Oe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05C987DE0; Mon, 18 Dec 2023 15:00:58 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03DB68780A
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 15:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzGYPl6bFAzmE2DXCPDHrK6QpG1oMEODpjiGoohuEmyAdMnt72YYkxNvFjdf8x9teEP8EgwUtFumr7Y1ZBUW7ui4dksAM2ajh+S8lCp++Br3ZyCPh65e8mpGIvZgHqeswQNjotJTRylvWmgWlH9RgiUrcEkQbomwmXcml9bFYNnOa96SCf824hlbZfyCkoYw13kpxQ1nKQPzGKn432bhMinxBAnBDJqXoeS8rLjY1X9Kek4UICvlk5UAbhVYtgQ8f5IKlO+iuopH3ySq3xSyQ30TBKigtZ9aJUO343idswbkGjBEnTYxFKZWpf0w7A4cbN3pxSo0DPWGqEfbaoKHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAEJwWH6iK93lpZiZytdRG6iJ22UzMhgqdKc7WxsGWI=;
 b=MmuLltC2yRUr0re/Q17Pm28xDEXCzFb8SlCC4ls1LQOFf1XRJN6NecsnwJoKL0956qNCNXd2tkFaRx9sRNP39f5sxNlotfhUVw44zkfl1oX+WXp7lSCyHqdM4aBmHd5IEEKHDNZmc0u81ceaNDuu6tG1wSIammXAXMdJFPoYNcYPtWOd3WGw460i4Kke77kxr5cfYnIbAAdIyfqEbKT8W+LbL2NoMZ8dJFoPosay/W6ZWyZ44hqpu36fs0nLIJN/e+0wpS+Fj+uVX31SsJpqIDr9BF+EQmtvXmh+GYlpKxmO8rYvkRO+ns9wC0IhMIonjr7+0iyFpYnczC3rsipDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAEJwWH6iK93lpZiZytdRG6iJ22UzMhgqdKc7WxsGWI=;
 b=0NEl3Oe3Gv7/PeOqz/xdAtqkJa+v5GZDHBCaytRkMEhIHibGn5M5lofzbLWKQX+fRhQEJzuaMQ06PuTBO3H3RAeCUWQpUkcNUjBTMFfxB2HGz7KgfYPVX2CVlm7rykyM6fxIyzvlRPtifNlIdqCd8zQpLHBt/vDybZ4YnGHCE2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 14:00:49 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 14:00:49 +0000
Message-ID: <55fa6bd9-5c14-43ca-b9f8-b3935a316c77@amd.com>
Date: Mon, 18 Dec 2023 15:00:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: zynqmp: Enable usb3 for k24 som
Content-Language: en-US
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de,
 "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
Cc: luca.ceresoli@bootlin.com
References: <20231215074012.483465-1-neal.frager@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231215074012.483465-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::31) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: d70747bf-4780-4eba-1dfb-08dbffd1bcaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzTvXRuVqB4ZZcE/KiqJkoaSETt2ZrdcuUggC5z6IDoCZ0gDcSF4AcSvJw5o2HZsUokzzGV8viSUrtfRwhVDLMppTkdIfZeRIeeG3W1Zra0YjP9hF/2z3dg9eoVZWU+LfW0eJ6sC1uAPRZwNdkYT+uHcjl+5xB1OqoLZd9nelGi5aJHfDXZovnieX7N1ra5NbdLzgFT8GZEFtXFOUHgAV+eMTyOqeAxS0dPKfSRnj+3S1vmkvq9yTcd3rMItxzuIob7n3BtzTrZdOLDM0QtbyUDQhOkpWwuPGML1Z/+3bgyWLpLVID0fZYAqszEYCaSzaLCR3tpBNu5c3Qz04Gr957EXyn555s0/5VGMRGZDe67fsJQB0I4cOBrFq1aEilWoveE/05KIaFVutnE2wPDODPS5OYX+C7HzI3NpZH8VOfH+e7mob1kx1XLltxve8gG7x3nGShB/cJ4iJescUjHPdEoUVoc0AkV8HPMT3JzJC67cKq9EPFaNIy9L7NC4XXlmv1WZUPGLfRR7CzZ6dPCJLPXXANYB1ZQKZCV4APSlF5y8KeEd1FlAfSrsjfKaIPx9oopEXtaIHIVbr643LavjIdva3DpIdZG7erdok1jsKMbzxQb9v41h+cKcp+1E4cWSFYtXmLeYy08LU7HfhFi4Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(26005)(6506007)(53546011)(6512007)(6666004)(83380400001)(478600001)(5660300002)(30864003)(2906002)(8676002)(8936002)(4326008)(110136005)(41300700001)(6486002)(66476007)(66556008)(66946007)(316002)(6636002)(44832011)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dSttQkQ3Mkg4MXU2Ky9aYjQ3d0ZlUE84SVFBWFFkK1pRajBDVDExdEVMa0Nq?=
 =?utf-8?B?d29xWWhzTjNsVFRzaVFnTHZMc01LWDFsZ3l2VERPWTQ3MVlWSnU2VFBmSlJs?=
 =?utf-8?B?WERlRm5BVWE4M0VzT1hXVVhESFRaK2RzTklOck9Lem9JWWIvSXJGNVR0NG82?=
 =?utf-8?B?ZWh1cEhIei9WSTJCTzk2ODRLTUd5akZpc2JDa20vcGJSWjhQSFM3TUdYZnor?=
 =?utf-8?B?VEhQajJJQUNoTG9VbC9SZHdGUGJTNVFaQlN1N3lCQkRvenZiTGo2MVBwQlRI?=
 =?utf-8?B?YWVCeWF3T2pCRG9ic21YbEtudC9NSUIwMDR3U1RTQWszaU04bGZVZ296ZE50?=
 =?utf-8?B?M212cnkrTUorUTlacThHWkxueUo2a2NJRHcxZDBlSFFJWHdzVkdWUVQyQXlj?=
 =?utf-8?B?d2oweGhtTGhOdlFCb1ZsMHc4U0NLcHZxSUY4RmFJYU14aEVvNERCSWkzcnlD?=
 =?utf-8?B?VWU4eUxQQUZRalVwdm1zbzlEWlc1cHh6d2ErMG9NMjhLZDBYUDZZemhVZ2xK?=
 =?utf-8?B?VXpoMGszakZ1YytMUHFlaDRYekFpeG9WYjVQUmthMEpPQjZJQVRhdk4wemc4?=
 =?utf-8?B?c3hDdHFYT2luZHRPVVJXeUJZeVBGTUJOZWFFLzRKemwwc24yRVhwSjNDQm5I?=
 =?utf-8?B?d3I0VkxZVFo2TlAvaERya1RSb0JPeG5FOEhxdTFwUjl3azRLbS90MVZ5MVhZ?=
 =?utf-8?B?NVMvb05mRm1pbXUrVG9SZkFWMytUVCtGM21mcFZQdVIzN0tHZklsWUV6ZVhO?=
 =?utf-8?B?OVQyQ1JYNlZSODhlWlFxTVRSUVY5MmtEWjJqTmI4QlEvazUwd0JPSDNCWXAv?=
 =?utf-8?B?UTN3R1VzRUZINEV2VEFhUEh1WlZQRHpJUHZ2YkoyQXJ6MjBvYzBXQ09iZis1?=
 =?utf-8?B?Y0oxL0VDbnZ3TURCZUdqZmNnVDhsVUlEdmpmcUdBUzEyd3AzWmZ0ZGljNVpC?=
 =?utf-8?B?NC8rc1VMTC9iNUExKzZjZDNBa3hMSFh1cGYvWUc0eVQrMFA3WGF4MDhvdWlS?=
 =?utf-8?B?YlA2MTk0dEJnK2NsQzBDK3dRVFJGRGM1T2p1d3Vmd1Z0Szh4TnArR0pNYjFW?=
 =?utf-8?B?d3B2YjlTZEk3b0FQQSsyZ1h6RG90TWlkaWNtQ3oxaklnRjVmK2JqYUMrOUhP?=
 =?utf-8?B?a0JoYSsveTd5SHFDWmpjeTNib1AzeFhXTHdUQncyUnpFc3hYSnpCVFlJUndi?=
 =?utf-8?B?bkI0SlF0QmpFK2lySURoZzBVb1FnTC9JNzF1TER4MHhJMzlzdjNvcy9rbGh0?=
 =?utf-8?B?RWZ5azhMRzdzS3d3WXlLWnVlcHV2K0szMlBwUU5leEwwcFUvZ29xSG45OGhs?=
 =?utf-8?B?R2lRS2VJZGZiVkdPMWI1YVh5VTdhakM2RCtFKytRQ3RwSk1BeHRUeUZyemlI?=
 =?utf-8?B?Y3RWZklDTlRhdXZmWWIvbXdzU3NFbFltMXgveDA2Q3BiZVJDeGp3NzVQRjZO?=
 =?utf-8?B?ZERseXNqWmpUQmF5MER5bUphbmNieWhqMXBIWjRNRkNYOFZud250OENTT3Vk?=
 =?utf-8?B?cXdhVlM2ZStBSlphWkxaUEVrNmhyQjQzLzJFTnhydFFIYUxwdkFuTXI2dWcx?=
 =?utf-8?B?dUVzdVgwVVRHOWRyZWpZR3R4U3YyRWpyNGRrU0RLOEtxeDhFQ0g0WlFiSUNG?=
 =?utf-8?B?K2pkOEVtc2FZbmthRFRtckZZN3lOOVZOM3F1K2FDa3lteFpTc3liK2l1TEIx?=
 =?utf-8?B?RkNmaW1VbGJFSVdNNWhXQzhwUDdpQnBVRVc5eXFOTEwzV0txWnRoWnY1a0Fz?=
 =?utf-8?B?WFVOUURxdEd6VTNtNk9uV1REZnc0QlE5R0J6OWRnVGxpTDE2OVA5ZUo3djhF?=
 =?utf-8?B?Vlpma0xKbVZQdVVTYkswTXpsTzUvM3JOL0xJeXI5UzNmbkxrTUR4RkRFdWc0?=
 =?utf-8?B?VitvNTN3S08ydFgwWXhZenVvMmFPUW82cXcycmtNSXdZa014K0V5a1hZbEJD?=
 =?utf-8?B?NktjRVBMUnVCVUgzdWZtOFNvU0RLdUtRVWREdVphVW9OcVhJNHJ1elBwVHhR?=
 =?utf-8?B?TjdOMjVkbXRSa1NKQ2IvMHUydkRJdnMyWUFlakhiS281bVJQams5TjQ0dWV3?=
 =?utf-8?B?aGpFdW5pUS9DK2NjTC84LytrMXZwVHVqUUJKbzVJVzAyMnJTVTU5TkFHUGxS?=
 =?utf-8?Q?5CI0jZlLWZ5d8DpoEA8TjMdHB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70747bf-4780-4eba-1dfb-08dbffd1bcaa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 14:00:48.5980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bphgKCo5KL7idlu1TaUPWyr2EtuWQnKs5Xx5c2JCkLlTujkwnmbcGU6YuoNNVPC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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



On 12/15/23 08:40, Neal Frager wrote:
> Currently, the u-boot zynqmp psgtr driver is not connected to the usb dwc3
> driver.  Without this, the only way for u-boot to be able to use usb3 is if
> the psgtr serdes clocking is already enabled in the psu_init_gpl.c.  This
> patch enables the psgtr serdes for usb3 use, so the u-boot dwc3 driver will
> work properly on boards based on the k24 som.
> 
> In addition, this patch correctly configures mio76 and mio77 as gpio pins
> which are used as reset gpio pins on the kd240 starter kit.
> 
> This patch is needed for enabling u-boot to load an OS on the kd240
> starter kit by either usb3 or the sd card interface connected over the usb3
> to sd card bridge.
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
> V1->V2:
>   - rebased patch to latest u-boot master branch
>   - improved git commit message
> ---
>   .../zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c  | 283 +++++++++++++++++-
>   1 file changed, 270 insertions(+), 13 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
> index 166e61431b..591f093752 100644
> --- a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
> +++ b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
> @@ -72,6 +72,18 @@ static void dpll_prog(int div2, int ddr_pll_fbdiv, int d_lock_dly,
>   	Xil_Out32(((0xFD1A0000U) + 0x0000002C), pll_ctrl_regval);
>   }
>   
> +static int serdes_illcalib(u32 lane3_protocol, u32 lane3_rate,
> +			   u32 lane2_protocol, u32 lane2_rate,
> +			   u32 lane1_protocol, u32 lane1_rate,
> +			   u32 lane0_protocol, u32 lane0_rate)
> +{
> +	Xil_Out32(0xFD409914, 0xF3);
> +	Xil_Out32(0xFD409940, 0xF3);
> +	Xil_Out32(0xFD409990, 0x20);
> +	Xil_Out32(0xFD409924, 0x37);
> +	return 1;
> +}

 From here

> +
>   static unsigned long psu_pll_init_data(void)
>   {
>   	psu_mask_write(0xFF5E0034, 0xFE7FEDEFU, 0x7E4B0C62U);
> @@ -528,8 +540,8 @@ static unsigned long psu_mio_init_data(void)
>   	psu_mask_write(0xFF180124, 0x000000FEU, 0x00000002U);
>   	psu_mask_write(0xFF180128, 0x000000FEU, 0x00000002U);
>   	psu_mask_write(0xFF18012C, 0x000000FEU, 0x00000002U);
> -	psu_mask_write(0xFF180130, 0x000000FEU, 0x000000C0U);
> -	psu_mask_write(0xFF180134, 0x000000FEU, 0x000000C0U);
> +	psu_mask_write(0xFF180130, 0x000000FEU, 0x00000000U);
> +	psu_mask_write(0xFF180134, 0x000000FEU, 0x00000000U);
>   	psu_mask_write(0xFF180204, 0xFFFFFFFFU, 0x50000000U);
>   	psu_mask_write(0xFF180208, 0xFFFFFFFFU, 0x00B02020U);
>   	psu_mask_write(0xFF18020C, 0x00003FFFU, 0x00000FC0U);
> @@ -569,21 +581,16 @@ static unsigned long psu_peripherals_init_data(void)
>   	psu_mask_write(0xFD1A0100, 0x0001807CU, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x001A0000U, 0x00000000U);
>   	psu_mask_write(0xFF5E023C, 0x0093C018U, 0x00000000U);
> -	psu_mask_write(0xFF5E0230, 0x00000008U, 0x00000000U);
> +	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00000001U, 0x00000000U);
>   	psu_mask_write(0xFF180390, 0x00000004U, 0x00000004U);
>   	psu_mask_write(0xFF5E023C, 0x00000400U, 0x00000000U);
> -	psu_mask_write(0xFF5E0238, 0x00000040U, 0x00000000U);
> -	psu_mask_write(0xFF180310, 0x00008000U, 0x00000000U);
> -	psu_mask_write(0xFF180320, 0x33840000U, 0x02840000U);
> -	psu_mask_write(0xFF18031C, 0x7FFE0000U, 0x64500000U);
> -	psu_mask_write(0xFF180358, 0x00000008U, 0x00000008U);
> -	psu_mask_write(0xFF180324, 0x03C00000U, 0x00000000U);
> +	psu_mask_write(0xFF5E0238, 0x00000080U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00000400U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00008000U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00000010U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00007800U, 0x00000000U);
> -	psu_mask_write(0xFF5E0238, 0x00000004U, 0x00000000U);
> +	psu_mask_write(0xFF5E0238, 0x00000006U, 0x00000000U);
>   	psu_mask_write(0xFF5E0238, 0x00040000U, 0x00000000U);
>   	psu_mask_write(0xFF4B0024, 0x000000FFU, 0x000000FFU);
>   	psu_mask_write(0xFFCA5000, 0x00001FFFU, 0x00000000U);
> @@ -591,13 +598,111 @@ static unsigned long psu_peripherals_init_data(void)
>   	psu_mask_write(0xFFA60040, 0x80000000U, 0x80000000U);
>   	psu_mask_write(0xFF260020, 0xFFFFFFFFU, 0x05F5DD18U);
>   	psu_mask_write(0xFF260000, 0x00000001U, 0x00000001U);
> -	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000202U);
> +	psu_mask_write(0xFF0A0284, 0x03FFFFFFU, 0x01000000U);
> +	psu_mask_write(0xFF0A0288, 0x03FFFFFFU, 0x01000000U);
> +	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0100U);
>   
>   	mask_delay(1);
> -	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000002U);
> +	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0000U);
>   
>   	mask_delay(5);
> -	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000202U);
> +	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0100U);
> +
> +	return 1;
> +}

to here that's key part for getting things up and running.
And these are not serdes related configurations.

> +
> +static unsigned long psu_serdes_init_data(void)
> +{
> +	psu_mask_write(0xFD410008, 0x0000001FU, 0x00000008U);
> +	psu_mask_write(0xFD402868, 0x00000080U, 0x00000080U);
> +	psu_mask_write(0xFD40A094, 0x00000010U, 0x00000010U);
> +	psu_mask_write(0xFD40A368, 0x000000FFU, 0x00000038U);
> +	psu_mask_write(0xFD40A36C, 0x00000007U, 0x00000003U);
> +	psu_mask_write(0xFD40A370, 0x000000FFU, 0x000000F4U);
> +	psu_mask_write(0xFD40A374, 0x000000FFU, 0x00000031U);
> +	psu_mask_write(0xFD40A378, 0x000000FFU, 0x00000002U);
> +	psu_mask_write(0xFD40A37C, 0x00000033U, 0x00000030U);
> +	psu_mask_write(0xFD40906C, 0x00000003U, 0x00000003U);
> +	psu_mask_write(0xFD4080F4, 0x00000003U, 0x00000003U);
> +	psu_mask_write(0xFD4090CC, 0x00000020U, 0x00000020U);
> +	psu_mask_write(0xFD401074, 0x00000010U, 0x00000010U);
> +	psu_mask_write(0xFD405074, 0x00000010U, 0x00000010U);
> +	psu_mask_write(0xFD409074, 0x00000010U, 0x00000010U);
> +	psu_mask_write(0xFD40D074, 0x00000010U, 0x00000010U);
> +	psu_mask_write(0xFD401994, 0x00000007U, 0x00000007U);
> +	psu_mask_write(0xFD405994, 0x00000007U, 0x00000007U);
> +	psu_mask_write(0xFD40989C, 0x00000080U, 0x00000080U);
> +	psu_mask_write(0xFD4098F8, 0x000000FFU, 0x0000001AU);
> +	psu_mask_write(0xFD4098FC, 0x000000FFU, 0x0000001AU);
> +	psu_mask_write(0xFD409990, 0x000000FFU, 0x00000010U);
> +	psu_mask_write(0xFD409924, 0x000000FFU, 0x000000FEU);
> +	psu_mask_write(0xFD409928, 0x000000FFU, 0x00000000U);
> +	psu_mask_write(0xFD409900, 0x000000FFU, 0x0000001AU);
> +	psu_mask_write(0xFD40992C, 0x000000FFU, 0x00000000U);
> +	psu_mask_write(0xFD409980, 0x000000FFU, 0x000000FFU);
> +	psu_mask_write(0xFD409914, 0x000000FFU, 0x000000F7U);
> +	psu_mask_write(0xFD409918, 0x00000001U, 0x00000001U);
> +	psu_mask_write(0xFD409940, 0x000000FFU, 0x000000F7U);
> +	psu_mask_write(0xFD409944, 0x00000001U, 0x00000001U);
> +	psu_mask_write(0xFD409994, 0x00000007U, 0x00000007U);
> +	psu_mask_write(0xFD40D994, 0x00000007U, 0x00000007U);
> +	psu_mask_write(0xFD40107C, 0x0000000FU, 0x00000001U);
> +	psu_mask_write(0xFD40507C, 0x0000000FU, 0x00000001U);
> +	psu_mask_write(0xFD40907C, 0x0000000FU, 0x00000001U);
> +	psu_mask_write(0xFD40D07C, 0x0000000FU, 0x00000001U);
> +	psu_mask_write(0xFD4019A4, 0x000000FFU, 0x000000FFU);
> +	psu_mask_write(0xFD401038, 0x00000040U, 0x00000040U);
> +	psu_mask_write(0xFD40102C, 0x00000040U, 0x00000040U);
> +	psu_mask_write(0xFD4059A4, 0x000000FFU, 0x000000FFU);
> +	psu_mask_write(0xFD405038, 0x00000040U, 0x00000040U);
> +	psu_mask_write(0xFD40502C, 0x00000040U, 0x00000040U);
> +	psu_mask_write(0xFD4099A4, 0x000000FFU, 0x000000FFU);
> +	psu_mask_write(0xFD409038, 0x00000040U, 0x00000040U);
> +	psu_mask_write(0xFD40902C, 0x00000040U, 0x00000040U);
> +	psu_mask_write(0xFD40D9A4, 0x000000FFU, 0x000000FFU);
> +	psu_mask_write(0xFD40D038, 0x00000040U, 0x00000040U);
> +	psu_mask_write(0xFD40D02C, 0x00000040U, 0x00000040U);
> +	psu_mask_write(0xFD4019AC, 0x00000003U, 0x00000000U);
> +	psu_mask_write(0xFD4059AC, 0x00000003U, 0x00000000U);
> +	psu_mask_write(0xFD4099AC, 0x00000003U, 0x00000000U);
> +	psu_mask_write(0xFD40D9AC, 0x00000003U, 0x00000000U);
> +	psu_mask_write(0xFD401978, 0x00000010U, 0x00000010U);
> +	psu_mask_write(0xFD405978, 0x00000010U, 0x00000010U);
> +	psu_mask_write(0xFD409978, 0x00000010U, 0x00000010U);
> +	psu_mask_write(0xFD40D978, 0x00000010U, 0x00000010U);
> +
> +	serdes_illcalib(0, 0, 3, 0, 0, 0, 0, 0);
> +	psu_mask_write(0xFD410014, 0x00000007U, 0x00000003U);
> +	return 1;
> +}
> +
> +static unsigned long psu_resetout_init_data(void)
> +{
> +	psu_mask_write(0xFF5E023C, 0x00000400U, 0x00000000U);
> +	psu_mask_write(0xFF9D0080, 0x00000001U, 0x00000001U);
> +	psu_mask_write(0xFF9D007C, 0x00000001U, 0x00000000U);
> +	psu_mask_write(0xFF5E023C, 0x00000140U, 0x00000000U);
> +	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000000U);
> +	psu_mask_write(0xFD1A0100, 0x00010000U, 0x00000000U);
> +	psu_mask_write(0xFD4A0200, 0x00000002U, 0x00000000U);
> +	psu_mask_write(0xFD4A0238, 0x0000000FU, 0x00000000U);
> +	psu_mask_write(0xFE20C200, 0x00023FFFU, 0x00022457U);
> +	psu_mask_write(0xFE20C630, 0x003FFF00U, 0x00000000U);
> +	psu_mask_write(0xFE20C11C, 0x00000600U, 0x00000600U);
> +	psu_mask_write(0xFE20C12C, 0x00004000U, 0x00004000U);
> +	psu_mask_write(0xFD480064, 0x00000200U, 0x00000200U);
> +	mask_poll(0xFD40A3E4, 0x00000010U);
> +
> +	return 1;
> +}
> +
> +static unsigned long psu_resetin_init_data(void)
> +{
> +	psu_mask_write(0xFF5E023C, 0x00000540U, 0x00000540U);
> +	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000002U);
> +	psu_mask_write(0xFD4A0238, 0x0000000FU, 0x0000000AU);
> +	psu_mask_write(0xFD4A0200, 0x00000002U, 0x00000002U);
> +	psu_mask_write(0xFD1A0100, 0x00010000U, 0x00010000U);
>   
>   	return 1;
>   }
> @@ -911,6 +1016,157 @@ static unsigned long psu_ddr_phybringup_data(void)
>   	return 1;
>   }
>   
> +static int serdes_enb_coarse_saturation(void)
> +{
> +	Xil_Out32(0xFD402094, 0x00000010);
> +	Xil_Out32(0xFD406094, 0x00000010);
> +	Xil_Out32(0xFD40A094, 0x00000010);
> +	Xil_Out32(0xFD40E094, 0x00000010);
> +	return 1;
> +}
> +
> +static int serdes_fixcal_code(void)
> +{
> +	int maskstatus = 1;
> +	unsigned int rdata = 0;
> +	unsigned int match_pmos_code[23];
> +	unsigned int match_nmos_code[23];
> +	unsigned int match_ical_code[7];
> +	unsigned int match_rcal_code[7];
> +	unsigned int p_code = 0;
> +	unsigned int n_code = 0;
> +	unsigned int i_code = 0;
> +	unsigned int r_code = 0;
> +	unsigned int repeat_count = 0;
> +	unsigned int L3_TM_CALIB_DIG20 = 0;
> +	unsigned int L3_TM_CALIB_DIG19 = 0;
> +	unsigned int L3_TM_CALIB_DIG18 = 0;
> +	unsigned int L3_TM_CALIB_DIG16 = 0;
> +	unsigned int L3_TM_CALIB_DIG15 = 0;
> +	unsigned int L3_TM_CALIB_DIG14 = 0;
> +	int i = 0;
> +
> +	rdata = Xil_In32(0xFD40289C);
> +	rdata = rdata & ~0x03;
> +	rdata = rdata | 0x1;
> +	Xil_Out32(0xFD40289C, rdata);
> +	int count = 0;
> +	do {
> +		if (count == 1100000)
> +			break;
> +		rdata = Xil_In32(0xFD402B1C);
> +		count++;
> +	} while ((rdata & 0x0000000E) != 0x0000000E);
> +
> +	for (i = 0; i < 23; i++) {
> +		match_pmos_code[i] = 0;
> +		match_nmos_code[i] = 0;
> +	}
> +	for (i = 0; i < 7; i++) {
> +		match_ical_code[i] = 0;
> +		match_rcal_code[i] = 0;
> +	}
> +
> +	do {
> +		Xil_Out32(0xFD410010, 0x00000000);
> +		Xil_Out32(0xFD410014, 0x00000000);
> +
> +		Xil_Out32(0xFD410010, 0x00000001);
> +		Xil_Out32(0xFD410014, 0x00000000);
> +
> +		maskstatus = mask_poll(0xFD40EF14, 0x2);
> +		if (maskstatus == 0) {
> +			xil_printf("#SERDES initialization timed out\n\r");
> +			return maskstatus;
> +		}
> +
> +		p_code = mask_read(0xFD40EF18, 0xFFFFFFFF);
> +		n_code = mask_read(0xFD40EF1C, 0xFFFFFFFF);
> +		;
> +		i_code = mask_read(0xFD40EF24, 0xFFFFFFFF);
> +		r_code = mask_read(0xFD40EF28, 0xFFFFFFFF);
> +		;
> +
> +		if (p_code >= 0x26 && p_code <= 0x3C)
> +			match_pmos_code[p_code - 0x26] += 1;
> +
> +		if (n_code >= 0x26 && n_code <= 0x3C)
> +			match_nmos_code[n_code - 0x26] += 1;
> +
> +		if (i_code >= 0xC && i_code <= 0x12)
> +			match_ical_code[i_code - 0xC] += 1;
> +
> +		if (r_code >= 0x6 && r_code <= 0xC)
> +			match_rcal_code[r_code - 0x6] += 1;
> +
> +	} while (repeat_count++ < 10);
> +
> +	for (i = 0; i < 23; i++) {
> +		if (match_pmos_code[i] >= match_pmos_code[0]) {
> +			match_pmos_code[0] = match_pmos_code[i];
> +			p_code = 0x26 + i;
> +		}
> +		if (match_nmos_code[i] >= match_nmos_code[0]) {
> +			match_nmos_code[0] = match_nmos_code[i];
> +			n_code = 0x26 + i;
> +		}
> +	}
> +
> +	for (i = 0; i < 7; i++) {
> +		if (match_ical_code[i] >= match_ical_code[0]) {
> +			match_ical_code[0] = match_ical_code[i];
> +			i_code = 0xC + i;
> +		}
> +		if (match_rcal_code[i] >= match_rcal_code[0]) {
> +			match_rcal_code[0] = match_rcal_code[i];
> +			r_code = 0x6 + i;
> +		}
> +	}
> +
> +	L3_TM_CALIB_DIG20 = mask_read(0xFD40EC50, 0xFFFFFFF0);
> +	L3_TM_CALIB_DIG20 = L3_TM_CALIB_DIG20 | 0x8 | ((p_code >> 2) & 0x7);
> +
> +	L3_TM_CALIB_DIG19 = mask_read(0xFD40EC4C, 0xFFFFFF18);
> +	L3_TM_CALIB_DIG19 = L3_TM_CALIB_DIG19 | ((p_code & 0x3) << 6)
> +	    | 0x20 | 0x4 | ((n_code >> 3) & 0x3);
> +
> +	L3_TM_CALIB_DIG18 = mask_read(0xFD40EC48, 0xFFFFFF0F);
> +	L3_TM_CALIB_DIG18 = L3_TM_CALIB_DIG18 | ((n_code & 0x7) << 5) | 0x10;
> +
> +	L3_TM_CALIB_DIG16 = mask_read(0xFD40EC40, 0xFFFFFFF8);
> +	L3_TM_CALIB_DIG16 = L3_TM_CALIB_DIG16 | ((r_code >> 1) & 0x7);
> +
> +	L3_TM_CALIB_DIG15 = mask_read(0xFD40EC3C, 0xFFFFFF30);
> +	L3_TM_CALIB_DIG15 = L3_TM_CALIB_DIG15 | ((r_code & 0x1) << 7)
> +	    | 0x40 | 0x8 | ((i_code >> 1) & 0x7);
> +
> +	L3_TM_CALIB_DIG14 = mask_read(0xFD40EC38, 0xFFFFFF3F);
> +	L3_TM_CALIB_DIG14 = L3_TM_CALIB_DIG14 | ((i_code & 0x1) << 7) | 0x40;
> +
> +	Xil_Out32(0xFD40EC50, L3_TM_CALIB_DIG20);
> +	Xil_Out32(0xFD40EC4C, L3_TM_CALIB_DIG19);
> +	Xil_Out32(0xFD40EC48, L3_TM_CALIB_DIG18);
> +	Xil_Out32(0xFD40EC40, L3_TM_CALIB_DIG16);
> +	Xil_Out32(0xFD40EC3C, L3_TM_CALIB_DIG15);
> +	Xil_Out32(0xFD40EC38, L3_TM_CALIB_DIG14);
> +	return maskstatus;
> +}
> +
> +static int init_serdes(void)
> +{
> +	int status = 1;
> +
> +	status &= psu_resetin_init_data();
> +
> +	status &= serdes_fixcal_code();
> +	status &= serdes_enb_coarse_saturation();
> +
> +	status &= psu_serdes_init_data();
> +	status &= psu_resetout_init_data();
> +
> +	return status;
> +}
> +
>   static void init_peripheral(void)
>   {
>   	psu_mask_write(0xFD5F0018, 0x8000001FU, 0x8000001FU);
> @@ -927,6 +1183,7 @@ int psu_init(void)
>   	status &= psu_ddr_init_data();
>   	status &= psu_ddr_phybringup_data();
>   	status &= psu_peripherals_init_data();
> +	status &= init_serdes();

And regarding serdes initialization itsel.
When you do this.

diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
index d1288bb17f3c..5d2fe0e4991d 100644
--- a/drivers/phy/phy-zynqmp.c
+++ b/drivers/phy/phy-zynqmp.c
@@ -9,6 +9,8 @@
   * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
   */

+#define DEBUG
+
  #include <common.h>
  #include <clk-uclass.h>
  #include <dm.h>


And run it. You will see that actually serdes is initialized already with using 
psgtr driver. It means pretty much serdes code is not needed at all.

ZynqMP> usb start
starting USB...
Bus usb@fe200000: psgtr_phy phy@fd400000: Checking name: ref0
psgtr_phy phy@fd400000: ref0 clock not specified (err -61)
psgtr_phy phy@fd400000: Checking name: ref1
psgtr_phy phy@fd400000: ref1 clock not specified (err -61)
psgtr_phy phy@fd400000: Checking name: ref2
psgtr_phy phy@fd400000: clk rate 26000000
psgtr_phy phy@fd400000: Found rate 3
psgtr_phy phy@fd400000: Checking name: ref3
psgtr_phy phy@fd400000: ref3 clock not specified (err -61)
psgtr_phy phy@fd400000: lane 2 (type 0, protocol 3): init done
psgtr_phy phy@fd400000: Waiting for PLL lock
Register 2000440 NbrPorts 2
Starting the controller
USB XHCI 1.00

If that serdes code is required it is pretty much because there is different 
configuration somewhere else.

With USB3.0 and upstream usb stack I see usb not to stable but I see the same 
behavior when u-boot phy driver is not used and sequence above is used.

Anyway I am definitely interested to get MIO values sorted it out because they 
are not correct and should be fixed and pretty much via pinctrl properties at best.
What we should actually do is to take psu_init and simply remove pin 
configuration for all MIOs which are not defined by spec. That would prove that 
our pinctrl setting is complete.

Tejas: Can you please take a look at it?

Thanks,
Michal


