Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CD8CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2B9883D9;
	Thu,  4 Apr 2024 10:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HT8h3GHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99EDF883F8; Thu,  4 Apr 2024 10:53:32 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A3388253
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUyV7JjO2bLVIa5acrSEDDjSHEB/dEZOmhPnrH8JPM7on/ouD8eU8OvfIFukHx8Efgh8iCnGn8doE14ryytv8mjxkgq0oKMPaw+New72vJiiKFIUu/H25aDcInIvPkhn4K4FFn6tMx8468nntSVyMRY5FZls1LRpOjJ79ywh66PaYZ8FV3mik6OOdp7muER1JhmRI4OWHVPGAlEH7L17C5TohV9vpBLWXBJ8vondvJBc6XvF54+wS24yb3tFzxu9LwDy4EMKmlleNuuTapdzi1B2ceL+htIRosMgIe678aO7W1dWTdbV+CijfzKEbO/CItT8imJY7TjO0o5DqLdrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6euhXM0Yv6PmslT0M2cv+20wh48vlVPwWqpvmPRtG8Q=;
 b=OXxenJUchIHWZ2EwIqxlNHu6bBPklOOGBR+EgfWR/Pp2NLSureLiym0z34+BSh5XkQDY3Kyqg6KquzNG3Wr3krIaaYq6Ef2MigewXMpIFnAMVcGFKjnBEdXGMG0PlENzpMcCZaJY8NkQEWrBshDSEyKtOpAkb86plAYMAlDvd4qOFcsySY2jkiJgxo4rZ7cn03DRWdORN8Kmq7AZgUdWzOxw5lRCWGbSYd+S7P5IRYyvYHGpzpagfR/vEtICXXwSx1qbeLbdoUW1JFS67xJDgboBqvQZinjwW5j9PmYTjzkVRXPLWl+9G0FpxZ1t5wh8lVUotPD8eovrCjecbM0iEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6euhXM0Yv6PmslT0M2cv+20wh48vlVPwWqpvmPRtG8Q=;
 b=HT8h3GHUUQbC0/TmZQ/tWlIX/+gcYze5pBw3FY1AZeD3DBtIDFVI4ol1Xstbh8Q8ArKY6aJHL76gW1O0WwVi2+CEgrlg7NFP3jrf960ln0IGvV5thaO/mYkQnkd1csfl1YlwSDFN0y4BlyIj6OMLEl3HguXYw8hMCPW1PDMMGMM=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 08:53:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 08:53:27 +0000
Message-ID: <d98330f9-d4e4-48e9-9971-298c3cd84f21@amd.com>
Date: Thu, 4 Apr 2024 10:53:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: zynqmp: Add the IDcode for TEG variant
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20240402142314.7353-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240402142314.7353-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0103.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB6722:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvMr+4/yi98TVcMRQkM0bm7ZYAJJEmUxPc1iPB51wmYKGNnkDuyr5f+obCIiKi4OLYwFe3CskoEtH0Kx8qo8qBnopTOUAUEzTNmN7Nw4/XkCY5nsy0Zvpw5oflVDciUfaEgcpH5GpzHn/cBsgi2RltTEvgXannWIduVY3TSr6Ax74e40hKmggOU3a07Zyj+Es7r2gd0cFF7uR2ZLUNhetVwr/14teJ3X7HFeb/yVU4xb6DXmwJSKd+MHngy51YkjPThSE5YlpCM4EbeVZXO7HSDohbToXDjlUu/PZovCUp2SXQvUU5d+ErAvGq2kSfuCs6mxumK/xcSnyC5OAmnpX8MvNlNSBzat2kcYijzdoMGCXtmUvOF7FTXiKqsljdEn/wDzPUhFhGUSuXA6XkWcvH1b8tTb2pCD6cfnR4tttPUX2PMLGNjlRpkr+NaAqJy7HQiWtkNorhXhMcIb4jFXCgDdamgNmwpBGK2g7sTMzVi1WI700mT+Vwj38Icufk9aD2e91+IMxuUujVcVM+0CQwwetRzFmi92yWFoe+1afSFzbIBB5GNNhfewFRxgqf23Ex+iwVdP6Tkr8/03/UFVHYyQYnj/fXfeSJVAOXxv4kaBIJGiJyghIKDctpQ2w8kgFDquBugI+RbOwrLe4ovQGpT1dEGuoIDAl8jdIMCpyHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpmbHY0blpFV0lqL2o4VUs5VjhEVG5DTDRhTnBoVnRUSi9mbW5BY3hmeitk?=
 =?utf-8?B?RmEveVlyZmp4NUhSMDhqcHludmNPWVNFZUtqajkzRHU1b0g0ZHQ5Y09GQWtI?=
 =?utf-8?B?b29zNVVRa0tCRFk0N05ML2s0UnYxU2JTeVRNb3dIMEIxS2toSHNHRzRlZTZB?=
 =?utf-8?B?a29WdDc0ZDh5R3V2TXVoZi9ueTV3cXUxMDUyNWZubE9IMkFhaUltaEkrM1U0?=
 =?utf-8?B?dFVXbFgzRWNacnNTQ2x0UXRPYzQ4S29BbmhPODlPd3dITVlqU3IySFB1NlhT?=
 =?utf-8?B?dnA1UVdVREF1RkptUFpNQ2IzZm11Sm5FS2NEOXlDbzNIdFhad0dNL3VudUd1?=
 =?utf-8?B?QXo5MXpLYnVDcThQaTY2cEtXa01OaHZycFVPQ1JnM1B2SXBLUlRNVkw4dVp5?=
 =?utf-8?B?TThzSzNFQnY0NFI5VlVMbUg2czFvNWxWOUwzc09Gc3B5S2VpM3BiRE13T1FF?=
 =?utf-8?B?Q2RTY1JJZ2pvWFBNSzNLUXR6NkxWaG9PQ2Jlc3FMckZ0VTZqeWdvWVZXcnNJ?=
 =?utf-8?B?V3diQ0IzOWF2YWsvVVVMVFhaVnNIY1BTbGs0SFhYVnZGVk0yWkoraU5mQXA1?=
 =?utf-8?B?Um15YTkwVXgxc3Bvalh0Vnd1ak9hYnJ1VkJoT3lxNHRPRjZWdDR5M0RYOXVI?=
 =?utf-8?B?V0VtUHAxTEgzWi9URHJVU2tnVFlxYVU1eHpBQ2RaUEhLd1NiNm56RGJUOHJQ?=
 =?utf-8?B?TkdkTldYSVpseVBPMXRtSjdhaVNKZXNtaEhJZlQ1anJDMTlsSktRUkMvSE53?=
 =?utf-8?B?NS9YN3FVZmgyak5saVd2ZkpSM1Nrdkg1d1hjOXVMNE5uUytSbDRDZnRlUHoy?=
 =?utf-8?B?bTNNdUhKSjVtcUxUc3dIZzMreHJKdmJuVjYvTnVEUjZSWjB4Zk1HZ0dRWDdC?=
 =?utf-8?B?VHBwaUw0d0R4ZHdHVUhka2dBOWx0blhJV24wVlhoZFBUN3c1Q3dsMUQrSWZN?=
 =?utf-8?B?MlVWejhzSHdibXBuWGZkLzdZbDR4TXZjZ2tuWlZYbksvNWROMTM5VmhRNzg0?=
 =?utf-8?B?bWR5c3FPdXh4ZmpCbUpOWWhqRXRBdHIweFF5Z3Q5bG1La21vRmlaTVVBY1Z5?=
 =?utf-8?B?eWtwa3NoaUozYWpPMk81RFVxYUsrZW9ORmxKQlROYzN0dmR5SHpNbGVQeDFY?=
 =?utf-8?B?U3RJQlduYW01WVZ6MW91OUpFaTRKN25aUGwwZnRYZVgvZ3czT1Ardy9TOFBl?=
 =?utf-8?B?dlpyUUs4UTBGSHp0TFNBM3BuMXU2VVNoVEYrNXdYVlBIOXY5TldndmU4SEEy?=
 =?utf-8?B?Yms4R0JNUmVLTytsalE1L2tmbTdJYzFaWEM5MGhwYnJ1dEhyK2ZwamRYTFVC?=
 =?utf-8?B?OHcveGFHUDFkQ0NhRzhvN1RoUmFKWXFOOHJDWEhVcWRTQy9YV0JTeTczTWNW?=
 =?utf-8?B?OFNDWDdiUnE4S0RRekJDeUkvMUNGOTRaanJ0RnB5WXdRTDZ4TGtKMGgwVEx6?=
 =?utf-8?B?eWlnR2ZxRlRjR0hld0E4Vlk0M0RtV1RzbmNHL1c2N2kzNmlBSnA1WUV4c0h6?=
 =?utf-8?B?SXhvd3pzbTh2ekVjbUkzaUE1dEx5REExQUJwNXJ5TTB1Q3lDellpS05yY1FY?=
 =?utf-8?B?NnVnenlLV0FuWDZlRFRRNkZ3bmROWlRlZ3FBUDgrQUlkbDdVTHErZkxqZXZr?=
 =?utf-8?B?d3N5SmdKTUo4aWdKWmNRb2w0eFh5cVQ1Y3VURVNlNW9sQTBibFVQUjRQaWpw?=
 =?utf-8?B?RG1FaFZ1UWM5RlNPWW03cHo5a1RMRFR5UGFnb2t2QS9rSDBoQUVjZ3o2MTdH?=
 =?utf-8?B?S0tpd2FPMWxzczE5TTRub3MweWcrc0NVOGVSZFVkUU9kRm5YZEVFR1B5OE9i?=
 =?utf-8?B?NE5kYUhwNnB4cVRpb0pKKzRjandyT1E3OEc1MWtaV1dCeTVJd2FDamZ2bldB?=
 =?utf-8?B?N3J4b1FSekU5NVpFNkcxNGd2Sm1UTXo3WFVvOEpDZFNhYlJ3eDRPSkd0eGxh?=
 =?utf-8?B?d1owVVRNU1lOY1BGT0pPOFgzVUtXckwrdG9wNFdoY1ZDRlB5SDFrTXVYSEgv?=
 =?utf-8?B?TlhqUnJESG5TWWhQaVBIaXBURjFzZzNjMGRVSi8zeXh1RHB0YlZVR1h4bFNS?=
 =?utf-8?B?djhBRU9kVng3QzhrZ2N2MktadWVpbVppZ0dFUDVtVURFM3g5d01jRjZtNC9D?=
 =?utf-8?Q?uqxiJ8dCxwcqZw6QvV89pJxg5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73843bb-bf59-4e35-ba83-08dc5484b168
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 08:53:27.1007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMztSI+IApfEJbnmQgiwu3qTnieJJ0yVgVp2mRuCSpmx17oVsdhqe/8cCeI2M2CH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
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



On 4/2/24 16:23, Venkatesh Yadav Abbarapu wrote:
> ID code is added for zu3teg variant.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/soc/soc_xilinx_zynqmp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
> index 786825d920..d8b4f172a3 100644
> --- a/drivers/soc/soc_xilinx_zynqmp.c
> +++ b/drivers/soc/soc_xilinx_zynqmp.c
> @@ -44,6 +44,7 @@ enum {
>   	ZYNQMP_VARIANT_DR = BIT(3),
>   	ZYNQMP_VARIANT_DR_SE = BIT(4),
>   	ZYNQMP_VARIANT_EG_SE = BIT(5),
> +	ZYNQMP_VARIANT_TEG = BIT(6),
>   };
>   
>   struct zynqmp_device {
> @@ -74,6 +75,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 3,
>   		.variants = ZYNQMP_VARIANT_EG | ZYNQMP_VARIANT_CG,
>   	},
> +	{
> +		.id = 0x04718093,
> +		.device = 3,
> +		.variants = ZYNQMP_VARIANT_TEG,
> +	},
>   	{
>   		.id = 0x04721093,
>   		.device = 4,
> @@ -299,6 +305,8 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
>   		strlcat(priv->machine, "dr", sizeof(priv->machine));
>   	} else if (device->variants & ZYNQMP_VARIANT_DR_SE) {
>   		strlcat(priv->machine, "dr_SE", sizeof(priv->machine));
> +	} else if (device->variants & ZYNQMP_VARIANT_TEG) {
> +		strlcat(priv->machine, "teg", sizeof(priv->machine));
>   	}
>   
>   	return 0;

Applied.
M
