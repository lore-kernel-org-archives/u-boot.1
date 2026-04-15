Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD7EF531FC
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 09:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAE583B99;
	Wed, 15 Apr 2026 11:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oc5WTBMQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A0383C2B; Wed, 15 Apr 2026 11:19:49 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD33183936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwzXnM8diEs9v1mDbYPtMnwZJOd0z3rUUAGoQsihAR5rVPvQuoVhb4Dap+HB7/v9eC5EMLXezrQN5T3MV/PIFt1hYfSpV97ZY+NpIhu5yAG+p26cUpVPTq66X8OU2nFqUyAWpKTY3d988TB9kA7FC//25HIogH0nwzhpqiwsft2iaDUs3qaxP1TypS9IGbQOlnz35ySjAT0ZXpV6uVh67CmEBF2sfDw530Bss+0oiDtuOP0zmSoJgeQvolhsWAnLnar4MLK63gsyXc8w4u3oYhycireZwXU4Cm88EdYUwvLYUsy42vvWvX3ET4j7lI8xgsrDPlw2y2NRw42kCUpq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9jsZSeF9eXfKT+QrIEV4/Dpj8tV36HvtUnVTTcRx3o=;
 b=GDXNzjbrgvoUwTGd5SkSpK1pg8OtC5nEqPrVpSlumD0W00LiI6rGyXBIEjcxEaqAzJQ1zPm9FhF4MP30+HsFYe1rZay8Uhb1bSBuurbtTXMY7TkO10wPOpZpLNJGsBJhYAOTc7PEgcQMZilIuewScbjG61IpospXYidh57gKRxnPgFmrmn1jX8ymquOd6G1LU0X+Dz6qbCxm9IMML1bcssyEHuffU6DutdRRuP9E4zBCZo4AK9E2Vwsvpn382vQwp55LGXJWAJSkiUzeN2tiPbLMhE3hR4hRjdTCPW5rwU8c1Rf1+37L62msOIG1E1p5DBUmz9WKu2CsSqlNAkReEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9jsZSeF9eXfKT+QrIEV4/Dpj8tV36HvtUnVTTcRx3o=;
 b=oc5WTBMQtLZoUXAiPuxM+hcLQVv1nJv/lXBIA/cdJZUfiPmOLTmpXp3aGZ3UVtexEWyLI/gu1L8HfFTBLYMC0DKG02oFChbZeP7steTtdgDoU4icwuJ9WatP25/LEZx9DMGlsSt3x2k4+qiBA3dbXCQU2Jm1s4c65NqmHREqyTdmVYLfAkltxoffkAN/DD7oXDBkGC2TzrLVbWzG40IWt15liVhj2rdek4sk12dzDLgDNISkfnFwisyIhrY4HTvbf5Mg6ITwXIYNAsPMeUWFlRGxCVkBTwZQZ0J48JMNoHw2mWmr2qAhs7IKQH1yAgZs89TQ2z27u6Z1ecnw9O4t4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by LV5PR03MB8363.namprd03.prod.outlook.com (2603:10b6:408:35b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 09:19:41 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 09:19:41 +0000
Message-ID: <02700148-f598-4c6c-8f3a-2652d02196b2@altera.com>
Date: Wed, 15 Apr 2026 17:19:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: dts: agilex5: Set DTB filename and kernel node
 removal for non-secure boot
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260304034623.13323-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260304034623.13323-1-boon.khai.ng@altera.com>
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|LV5PR03MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f53522-04e0-4d9b-bd5e-08de9ad01fbf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|8096899003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: TnBjk7RISWsO5ozxA8XGH+yZb8q6y1DP4YWQoyS9ICERRC8giJi/laAs3dvyJeVGn8hpeB6OgRTyaVQgwH6st4VxFY1wrnCzWBRxovhC5JMPJLXsxalFeFeOwPw2xZb1ok5H2ifm16LxQAykMrnCBs/aJVRCJ/dQcFbnf6QEl2VQrHD6wFIsC9PNcQGRnAoggeWoP/+1rsrMYn4jTRGqzhhMMf9FZluztjmP009c1LYjYvPCuUT/3kQ/cMVXQndRHtqK8279Mb6jMNvPlOK7UpoHRcbw6aHd7kYZJPOvzvack3GC0eCvycZUVESn6m/u3blrlTHASv+mICU4clbQFK2Zxirm/Kn+JBlM2ItzUpKYBb1ima6+BwZcMwdai9ZpBVkYwHtGGam7xrwa1B1U/d7afzRmIEOmrOnwQWDFx2sYkADVQO9oMp3HqnUUd62a5E6IB9DyjPv5C5BxqUuC68oas6eJThNQvuwRkEpV5VcFgUnZB/pam7gpwTXC8maJ+PWeeULtuWMhKhPCmf+UihUbfDuG6ijqldHXrjTAiaYQBdFqeT9N+rOkT2WFuwsbxe7mQhGai5MyPiE4qP+lXvQQdb+yZR0hSf83PVw299XKDwjQKNoafILrGp3jJL6P6zWtx04lVH4Fx/yfuRndNWu2LqSPPWseJ8kJlWpt8LnYKuyD0hfJL8syNbWoLHZkyF2V6ZREyAsRWxvIybYB+FHBeQp47qkjxqsHmD8gJgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(8096899003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFNHTDhDbDNidDFyMUg2OHZNTFRFZCtzRGtHUHhoWm1HTDU2UGp0MTJSLzNr?=
 =?utf-8?B?NjVzN0sza0swb2NHd0dhdTJhZXBIcDhmMTFNSjNDNDZLbnUzN1VQWjQ3T2Nn?=
 =?utf-8?B?b1AwVHRGZ003UUY0bzJyQWlVTTJhQUZWYVZVM1loNGJWZWVzOWlGRjBSVHhS?=
 =?utf-8?B?REdBVXVjWUx4aVVsbVVaSE9yYjh2SXYwaVIya2YrSDBvK3YrWFVSU1R1Sytw?=
 =?utf-8?B?UzFMYVZldUNMVEtjS25OQXZpNytWS29pTFJXL0VWczdyTUFGY1g1RGtBOHor?=
 =?utf-8?B?RlJZcm1SNW8zQ3ZQNFdnY1VFdGtCQ0dxWFJHU1lKNUlocEovNmVrV3U0QVpQ?=
 =?utf-8?B?dk40amlxanQreVM2YU5oMHFJT0dNMkNXL3JscVcrc2MyaHVpMEE2a3FJNXdx?=
 =?utf-8?B?MitCRUlvYmY3QmMyOG5yVnk0R0FJcHFpNlE0bEV2QzgzaWh0RXRxR3U1L2Zu?=
 =?utf-8?B?K2VnbzRqRTBsVHhxeXNleUxxZW1hM2JkOURUTTF4ZTNPVExIdUpHR2UrS3Rq?=
 =?utf-8?B?RVBSRXhGc1V5SndwbWJzWUJrR2IwQmNaL1dvdDRYcW9CZGFXNXROUVFkZDM1?=
 =?utf-8?B?NzFuWGxBRlplYXR5RFdRb2grTytkWGNHQXNpbVZCZ0pJMy9aVUo1U3FOUHBH?=
 =?utf-8?B?U3N3aU1ZeCtvSytrNlJqTlNOVFJPeDIrNUpFek4vMjhjMDRmQ2VaVVB4S3Jh?=
 =?utf-8?B?Q21TdW5ncXJONmZVRHlCOW5JbVFxVHpiV0IvSU9mM0ZPMi9XWFQ1S04zaSts?=
 =?utf-8?B?MGovNWloTUVkeEI5QzBLMkJ5UHZaVUhJd25HQXF3TTI0azNZcjVVQkk0NjVF?=
 =?utf-8?B?ekNjWk9oL1laTmRmcFhIdmZWbTU0RUNyN010bWlxRXZZaUJ1VzdzTnArMFJp?=
 =?utf-8?B?WVRrelVrR3ZNNXl4K2I0a0JBOU9KWkZBSnh4WnQrSGNRemlDNTJORUZ6dzk2?=
 =?utf-8?B?elR4blpGVFg4UFNwYy9rZ2FwWlZjb0ovc0R5T2t6cEtFSHo2M2FjaXRHYzFL?=
 =?utf-8?B?MGx0TU8vY09adUlQTWo4S1pxQXd0eW15S0I4N1ZBcDhIMzhjWU1HaDRzRVhr?=
 =?utf-8?B?WHBOZmRmTmNJVkF3V2hJVmlsd2VScVMraFgvdnlBYlM4d2RpS2xUNWlUYnNt?=
 =?utf-8?B?NDFJdWRsL0dtTUZBVkNwM1gwckFWTm1TL2tiblpDK3hDamFMMkxHdU9IVVNm?=
 =?utf-8?B?UGVMMDZFdm96WHVHb2Z1VlZ3aEhFUzMvaVg0VUs1WlkvMGtoS08zbTkvRWE0?=
 =?utf-8?B?TFVCMjlTa1Zkb0liZEJ2NTFqdVR3YmZUSDBKSTkvV2hEc2FYZGQ3bEoxSCtN?=
 =?utf-8?B?Z0pPd1dDUHN3N2RQL2JtRW92WENtdUJUbkNHMDl6S3JzVXpiYU10cmViNmF5?=
 =?utf-8?B?OTAzTFZVVGp1ckhGSWg0ZTRwTDJZQ0NUWGlFSElhZDdySzg3ZzVpcEVtTWR6?=
 =?utf-8?B?OVFmUDFjcmlKNHVNZk5xV1VsU3QrQWI2elZzRlZsWmpncWM0MmxNeVpQdFFp?=
 =?utf-8?B?Sko5Lzl3RTAxZ2UvczlpWE5JUzVHSjhmUkZZWGw3TGUwdlpTdFVXT2xrYzZz?=
 =?utf-8?B?QVdOdy80aDh4R1hyWko5eEZtSE0zcGhGTnlJTC9jSGhCc254VXcra1ZqQnRx?=
 =?utf-8?B?WFhTSHNtYlZPalF4YThrcFVyVE9EZkdzeXFsMXQrVWJMZEpGak9DK2ZyYmI0?=
 =?utf-8?B?KzN2ODF4a2RVdWo4TXRHaC9MNHpxY2ZGKzE5cUFiNGlOZnlFQ2ZLMmlJMzZO?=
 =?utf-8?B?NWNMMkxFT3NEc2NIRUFWU1U3NDNEd0hxRzhjUVdBOWRhQVlHSnlFQmUvQjFE?=
 =?utf-8?B?MVFZTE5yYWpzdjExUXFrTks2ODJRV1hGNkNyVzJXUStLM3JlWU9oZE8wd0Jn?=
 =?utf-8?B?cHVLbEFNUmtRZEVlcWJRTjhOYmRwWnFoa0tWc0g1eHQzL3gyZ2QzbTJTa2tr?=
 =?utf-8?B?Ykg5K0xKelNYM0V0UzYxSnFLTHp2cS92NnhVRldCUXljMlVWZ3Jha09KOWJF?=
 =?utf-8?B?aGJ5MVhaVGNXWXNnY3ZIZWQzaTByWTJFL3drR2FCS1JrWXNhbmtqUFg0ZGIr?=
 =?utf-8?B?cUx4UGZrS2tNaVNybVVsdHU2cWkySE1lUExuZlV1aXVhQ3lib3RhU0xBTXYx?=
 =?utf-8?B?T3pGbDhMTklPZE9pWDJmbVRKSWtvMDRUYXNGRlVkbGpGaWFyc1ByaEI5RzJh?=
 =?utf-8?B?ZDJuWjR1eEMzWG9xZTE4aU1FMHZkNkxWQ3gyaC9valdBMEZpZVZYNXBUWXRM?=
 =?utf-8?B?eHZRek5mZ0RqaGhoaE5FeENtRWZFVzYzUjIrR09uRFk0dzNrUUN3N2QvVXBx?=
 =?utf-8?B?V2RsYzk0ZDFMNUY3MXpEZVZhUkRXV1lBdTVkNzYwUDdNRjBMbFFLQ1JIdGJ6?=
 =?utf-8?Q?gELhLPOiE27nNeJo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f53522-04e0-4d9b-bd5e-08de9ad01fbf
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:19:41.3324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHO0C5VQajIAw4HgOXmwSt2aNXSWFPTMPKNHIRYktlPi3VwpNtW3tf/6wyrLz57/qJupSE4toZlfR1p3H+DS51oIMIHevdzHqjGlhtcY4Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8363
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 4/3/2026 11:46 am, Boon Khai Ng wrote:

> From: Alif Zakuan Yuslaimi<alif.zakuan.yuslaimi@altera.com>
>
> Set the DTB filename in fdt_0_blob node and remove kernel node from binman
> node for non-secure boot scenarios.
>
> Signed-off-by: Alif Zakuan Yuslaimi<alif.zakuan.yuslaimi@altera.com>
> Signed-off-by: Boon Khai Ng<boon.khai.ng@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> index c03f78b2fdf..b4b8f54b969 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -217,3 +217,13 @@
>   		};
>   	};
>   };
> +
> +#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
> +&fdt_0_blob {
> +	filename = "arch/arm/dts/socfpga_agilex5_socdk.dtb";
> +};
> +
> +&binman {
> +	/delete-node/ kernel;
> +};
> +#endif

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong
