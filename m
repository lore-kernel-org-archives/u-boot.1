Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B666C27C43
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 13:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26554883BA;
	Wed, 29 May 2024 15:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4I6a+xL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83815883F6; Wed, 29 May 2024 15:15:20 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C3C883A0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 15:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrlS6Atw4XYj7i9BSQoVjrbaQQzpHEmsrFm+Uod8e+Tp0mrlYADgPoiaIy4Le23xko3g7w54m7dAeFkGnHFiSjmYtfLyPxogZHSpUPBQRc9DKL4ZpJ992jJWGREx38xDYmX+1/IR7wriUpljIKM+yGTe/Q1D0shA0cVmpKaPCceFh/kvJWTPN5TO5KHElej+tezv0I74sri+eGHJR6j/NB9WKOTz5ScSYGGrDeKsausD/R/UqVgLJ+j6SjrRRGTUWmy/lyLNxNHKyn+3VTk8yhXDKnLZ1hnJp9UTNLIRuXpFYFleKtAwk8ZVPA8Y8kj31fYLFJSBSQtKjRUDnYLXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q24FU1nFra8pQ9jq+GSrb5qEOKtqrnB6rx3md0SBU2M=;
 b=H5nUVlVeYHOAkxTkR/xqZC/kPbdDfBu81Z2HyaQyIKPRMjec2f7hQ84t+eHWhASBiJG3yGDZPY9isBftV1RXGBRNHz2r22M2isl3zx9iT3xc2D4tgi5SjBgqUbHxjHccdqrRupjPhAVVSowNohHVajz7oblnC+UUEhr99ux9kBFLvE6EDpQTv55ejmusSEjuSsRgVeYTo13YSa6eAvKy821M/g/bKUXc6MdFjgHDQ42DXSL0xA6W1AQ4KxpvcIUXrR3nCclVEGWxh8MxZTzMoRJscL6YliR6qpE1+g8Kkn1949QAezFViTXo3CUY8vpXFHZCBm3/03KY2rpHIYf6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q24FU1nFra8pQ9jq+GSrb5qEOKtqrnB6rx3md0SBU2M=;
 b=4I6a+xL4AZbKXRij3et34sxkCEln6/3oebgdJ5pJZh3pGjjx6NZLsUFwOSCFj7FKjTdMNSUaWhkYGmzGPoXL9TV4ulPTJB8Y70c6mcLeeaP/E0NSD6jne3aL4j1foEwb0e4qhpK1I9Iag922AgGmePW7yKJl0h7WvwhGu21ekus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 13:15:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 13:15:14 +0000
Message-ID: <cc629eac-0e52-4d79-910f-92ecba66db44@amd.com>
Date: Wed, 29 May 2024 15:15:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ] mtd: spi-nor: Add SPI_NOR_OCTAL_READ flag for
 mx66uw2g345gx0 flash part
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de
Cc: venkatesh.abbarapu@amd.com, git@xilinx.com, jagan@amarulasolutions.com,
 n-francis@ti.com, d-gole@ti.com
References: <20240508052749.214286-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240508052749.214286-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0307.eurprd07.prod.outlook.com
 (2603:10a6:800:130::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: a08e41bc-69ef-42bc-e711-08dc7fe16096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXNqaFN1enpwajFYWGF6OVJmejBiQ1huQjA3enltMldWRzlxUkZ1R3orOFJC?=
 =?utf-8?B?S0JQK21VQmJMbHFyL283U3o1SnZqc2Jkc0JWUjBwWkpscWE4eFI2ZjlkMGFv?=
 =?utf-8?B?ejJHR1ZkVVk0d2RNeHRxR3dFUUx4aWN1dm03UDN4Um40N2s3djlBT2gwVktl?=
 =?utf-8?B?aXZZTzFiNEcveXNSVFliUFBJaVJRa2EwNFEreVdDNEttSkZRYzEzTWlBQlds?=
 =?utf-8?B?Z2xXMXVYTVM1ckhNNkpBQzhBN3oyOXFITTVZZDhRVHJmY3ZkNUpjWWtxdTJS?=
 =?utf-8?B?a296eExCZjdXUS9ZaFpqQlBYRWhEZEdacXV1ZEdEZG9Hc2RTbXNhRFplNU9R?=
 =?utf-8?B?MlgycDZMbHdZbVRXZk1PSjdCemVuNENPQmNwUXBXaVdRdVRJOEhKbUMwVW5h?=
 =?utf-8?B?WVh5NnJuOFlaMDRKSjdRRGJwU2RwYU9QdnNjSGNBQTZjRnRDWlo1SWh4aThy?=
 =?utf-8?B?NGRCK3gxVlNzVFpPbk5TcVBBdDE2M0tRZjRxUnc4THNYQ2tkWlMvR05ZLzhN?=
 =?utf-8?B?QXNzRnpTRSs3MElWbDM5c3k3UVc1elZLRFUwaHdiSE9KMXY3ZnBydlFya1Ja?=
 =?utf-8?B?bnRpZ2krbWFrSVQ0c2J4QVNjVS92YVg5UkJTWVRiYTdkdkxvekJWZEJqdk43?=
 =?utf-8?B?TjhZbWZ3NG5pTVI1a3B3S1ErSGs4VnhHRWlCNVI1RnRoT09oVDROVWR3ZnZs?=
 =?utf-8?B?WjdiSTN3TTVCVXhDaDhYT0NQeFdtUmlva2tjbG1STEorY3FuYi9iMVVGeXcz?=
 =?utf-8?B?WEhSMit0MXdibkJLaERFazgvL2FQWnhZZ1VKdGlORUpaL3gzNjl3WUFVT0gw?=
 =?utf-8?B?WnE2bzZPOVBNdkhORzBtR1NlUDhaVm43Y3gyWjlPTitDaDFRSWxkUFljYTc2?=
 =?utf-8?B?OWhPYi80b1N4NG5BZHp6ZXB1bG5pZm5waktPSU1HMXYyZFFVeWFMZDF0SXht?=
 =?utf-8?B?emV3QkZvMnhrMmxPb0FNL3hPOGYyemZVQ3JPMk9tTlJhMnlSTThuSXpGNGd5?=
 =?utf-8?B?QytFNXVnNDd0TnZIblpzdTh4R3ByR3dxZWpMMVNhWWtaNVNJRUp4VnllakQz?=
 =?utf-8?B?bkhabnFFaDBYRVUzS1dwbUNiZHMwOVNtaW9MZVJGWXBZQWVmdEV6Tm95Tk9N?=
 =?utf-8?B?Q20vLzFSMlIvOEVPUm53aUptdXFDMDBueWpkcjNDdDd0Z2NYUEFiZWZ4aXA4?=
 =?utf-8?B?VURJU1BEUW03S2dSeEVBVmpLcitpUDgxTkJvQU01OVhuTDUzM01Ob3E3Z2RK?=
 =?utf-8?B?VFg1czZVNjdDNDByc2FKcloyV3gvbnBPWE5nM3hhVE8yc3pUc0I1Q3dLSFhJ?=
 =?utf-8?B?N0FKbXlBZ3BRbGFJbUwvakNULzFCbFY4V0dSbXo3ZlFxS3UyVlh3VlNCaHU2?=
 =?utf-8?B?ZjZodkJyT2pRZ2swVHVYV1FybG1sSHB3NUZXRWRwUEZaUGRqb2RXQzc2akdw?=
 =?utf-8?B?UmNSLzBjMFloNXN3NjliOW9SVEhTR1hNTUpFeXVZY204OS94QnQyZW5ZV09j?=
 =?utf-8?B?OW9CN0pQVWs1cUV6WTJadVNRRjlxTFIzRm0wV2prenVTalRkd0NPem5aOGo4?=
 =?utf-8?B?aUZSdm54SURwWTBWUmRacDMvTktxUDliUDRNcnlJTlZzVVlaanY1Yzdwcnd0?=
 =?utf-8?B?YUdkY3R2SVkwc2FmZUd2NGdvL2tPQkdMOHhqR3Jvc2FYeldVTlZjeWhpMXBx?=
 =?utf-8?B?VkVPd3dsWUl2cGEvNGxTeFNzSHhlY0xxdVlHL0ZrWk5XdkNuSXJlNFZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNOSTNraW5EUldrbmthb0NUTkczT0ZzRG9sOHRyem9CTUtSa3JQYXFCeGpZ?=
 =?utf-8?B?T0MxQVFmMlFldFFKY3FHcytsbWJLTkNUTzdNR3U5WTYxelFBMTZBSXJmVHBX?=
 =?utf-8?B?QWNLOVhPN0krTVl5N2N1eTd3ZmpnOW5rZ0UxM1N4VjV1dmdibUdhZDA4YjZR?=
 =?utf-8?B?b1lSQk9LbmFBZHdZNk9nRld4R1hXWUVDV2hLaDg3U3dZQmJGR3FieXRMSVlX?=
 =?utf-8?B?QTZ4NWlSR0h2MlpkSVE5U2RIOVBlOEQ0S3FmdjFHRmx5VnBMUUhlaFUvTTV0?=
 =?utf-8?B?WFZIY1pwV21oUjUvejRPZmYxZlF6SnhjSWlqN25VN2tvbm1XeEpjZS9UNFhM?=
 =?utf-8?B?cE10UlErSks4cHdvNmhRN25Ka1FScEZkYlEreGRpcTZHd21xZzduY2M3OWtP?=
 =?utf-8?B?eWc2cE1GVjBsMHJoUm82OFA5OTBFQ2N0cnBmZjZxcHhUVUtIL21uUzM0bHlN?=
 =?utf-8?B?aWl3UTEyWVl5NXBKajUrNHlueFRpbGZZOXo3TkhjRzQwY21MaCtUZFpXdEY1?=
 =?utf-8?B?aW1zN1djclhocjdEZ21YYTREV29vVm83eDNzeXBqb1lRbnZTVHE4THZuZE5q?=
 =?utf-8?B?MmNITDJHRVl3N2lHaVZHVDVCL1VRdnJ0Uzd0NEhJa3lQMjExQVR3YWR1MW9O?=
 =?utf-8?B?NDFxM0xqMTFEK25XUHNmSlNVZnlyTE0ySEpQNlBJKzA1b0piSzBzblpXKzJj?=
 =?utf-8?B?YmU4TVJrbHhTWUtHcEhiemhuQytWY2x5Rk41ejhNNHF6NmVWRmtvZjlsMUw2?=
 =?utf-8?B?cEsxR000RXRuUFcwaFU4R0NEYThLc3FLVE1mME1LS0dqMS9yaFdHYlVQSlQy?=
 =?utf-8?B?UEpmRk5BU0dseW1WRjI2WUZHYllmOUtjODFKWnA3dU9FQmxENnUwSGxyYkVV?=
 =?utf-8?B?amQzSmJEUVh6SzdwUWV6MzBMcCtldGJHR09lSkpDMWcwTXoxSDJKdWw3ZkdP?=
 =?utf-8?B?Z05hMUZDc0gwQmZ6OW1hQlQ1dHUrQ1ladFR0ZkIyUDM1ZTZTcERBZWdadkJC?=
 =?utf-8?B?QzdrMGtuc3lUZEJBK1RTcHVvOU0wU2t3Uk5ISHU4WUtYd1hTWXNnQXQ5THJv?=
 =?utf-8?B?MHNnSzNRT3c1ZnFmeHVMQUV1MnpvRzUvc0t2cHFjQ044L0F6Y1E1eFZFb3gz?=
 =?utf-8?B?WWFRR3Q3b25Odmg0TFNmdm5PZjdzYmZMNkx3cUE4TWkyS1hnOVdUa3J5T3dX?=
 =?utf-8?B?YUd5TjNnLzQrd1ZueGlpTXlNc2xHUnZCQzE3NG5vZmxtSG9VaDRQRERtMk9t?=
 =?utf-8?B?TzFxZlByUVlpclNSTU9sSFZld2xDdHlsTVR6czd3dkMzQjZuUzFkbHJTcTNP?=
 =?utf-8?B?K0hCRGtzaUZubHFYRVJXZDgxK0NEQjV0R3RFSFJTSDFXRDlKMnpnZEZiL09t?=
 =?utf-8?B?WEpFNkVhWGhiZmE4eHh4dGtmQW94K2p0WGxGMytlZDJHL2pRWW1QZ3QyUmhI?=
 =?utf-8?B?UWJrYmtRM1JQa0tKNUZGRDNPWVZleXdDVFdsN2ZVMXpqMmVNempTeE5EWWpm?=
 =?utf-8?B?SWo4R09pcGZwZGhhUy9Nb0RoTnhYckNCUkZ4SU5ib2pRcHFwRUMvMmx0SjNW?=
 =?utf-8?B?NVBxbWQzZ3duRU1mR3NFaDJSNHlBZE5uZno5b0p5WXNkekRFOUEwVXVNckc3?=
 =?utf-8?B?b20rSVh2NmNXZUY3YjVxL3dyYzNEbHV5NTVmVEp6OS8yeUlKUWMxUWk3SGIy?=
 =?utf-8?B?NUlzaVhvbUtrblpkcEYvSkttNXBTMFl0cXNTZVJMOUlRWnVocVgxWlpXRFlS?=
 =?utf-8?B?RnpCc2ROOXY5aCtSNXNRREd1cHNDVllQR2lPN1ViUU45dHpwVXVsbkh4Zjlq?=
 =?utf-8?B?Z3UwdnA1RmRiVWwzemg5SU9rRGFwZnZESURCQWhXZ1cvdTUvdUVvcWZsMUtL?=
 =?utf-8?B?RE1HaGpKT1JEQmpqSCtTbVBrV01HM0UyZzk0QStKcFhUTHFOVWhFSjRZYXdl?=
 =?utf-8?B?MzFWK0RxTGlPU2ZXd1ZaUWkwbnVKODJ0TkJoMXRWa3FQeUprK21FNmMzeEdh?=
 =?utf-8?B?MVZzcy9UeHpWZFA0QzRoUnJRL2FheE5Kdm9FYjNxeTZma0UzR0hDMjlWV2Fv?=
 =?utf-8?B?dHI4WVlWSE5nRnRWc1owQ2N2Tm8yem1PWHRIL1k5NlowdVJXcXQ3QjkwRXYr?=
 =?utf-8?Q?IZxm3yplBrsy8fST9qUGj0899?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08e41bc-69ef-42bc-e711-08dc7fe16096
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 13:15:14.6921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZcJjezENF9dT1nKPP3F1P7izuRNKX6L2VbYuPWQu83dVvFslXoKxJPduFunY8g9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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



On 5/8/24 07:27, Prasad Kummari wrote:
> Added SPI_NOR_OCTAL_READ flag for Macronix mx66uw2g345gx0 2Gb(256MB)
> NOR Flash memory has been added. Initial testing was conducted on the

I fixed this commit message.

> Versal NET board using SDR mode, which included basic erase, write,
> and read-back operations.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 4e83b8c94c..dacc26d7b3 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -275,7 +275,7 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("mx66l2g45g",  0xc2201c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("mx25l1633e", 0xc22415, 0, 64 * 1024,   32, SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | SECT_4K) },
>   	{ INFO("mx25r6435f", 0xc22817, 0, 64 * 1024,   128,  SECT_4K) },
> -	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
> +	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_READ) },
>   	{ INFO("mx66lm1g45g",    0xc2853b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("mx25lm51245g",   0xc2853a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("mx25lw51245g",   0xc2863a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },

And applied.
M
