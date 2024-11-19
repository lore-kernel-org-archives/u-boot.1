Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C86DD44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF6189596;
	Tue, 19 Nov 2024 14:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lw6ksqTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B86489597; Tue, 19 Nov 2024 14:35:38 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B368956D
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deCuEb68q4zUGBbSpGctjcI+xtyeBfywHdhkSA1nk1rxjk63TBj4N1V1IOiJsNL4GSgr9gRN1alfzLQXdtGAYbfoP4CsQwytb1E38/yVBaauh2EsxSLecnXCdMYrix52rgBG5tkznBf9uq2bq/ZTu5P+hf7XBDVoT4BPD2OxniX96YZaNYCaCOvxcT0f5/RfJUs6Np+Cl/m+qOXDh8jMTRIV6sYGBSDikTV9caDgntBx9cZ1RJtrO7mxBCW6z3CH8XysAAMdvSX24/nQ+nB3PrmNIPH5S7hdzbHTkMtbLR59/HNsLlAheHGAWVdRT6Ztard4f7/YAbxuAw6sqHAJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhCow/h1eW3oBw0h3eAwHWp+7jBvXQccsWsc9tOgk9w=;
 b=i6uYz60KLp9zPxMYQT1/qlm5m0PCjrH/zj6w1yixDx7HYEHoEeTjfrzqjgxNAFGHffn3P/vyqlGGX2ynbQHsmCjdaBRYgWPuhM2N/QaqgZ4tKJjc73jq8yvtxc3F4dVA1LV1UPgcm2oNB/+GFoLaQ/2UpEDLYqI3NK/bDpwGHL6hyKAYU8P/5rzSX+PrkfgOZgvTPmcHv9aHiMA+jxd51/qclFOt5EODvbgdiW9Yf0h9RMSKid/gGW4PY6plnmxsA5uCbKI0LA6jZ1zZtC4s+HdJjy9CNl8tUGGzVoWm5PBixbw+GtcOZfLsqRFURyCx3hRl14Af5NGZYczhniem3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhCow/h1eW3oBw0h3eAwHWp+7jBvXQccsWsc9tOgk9w=;
 b=Lw6ksqTvH8kKQQSXtIbIYzfRZrKXOeeUxZrs5tXxnz++u2YMKYQ4po+zxHP8IBow74zzd5vX6Lrvbt0JoH9Y4vayys/hGMdyVLajybuox2Oqlridl6o5OMioUBh5ZkkV/kToMCNcZ6xnFZ+VGh6uVKJgXtpMweEmkJG+9oDsMnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 13:35:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 13:35:30 +0000
Message-ID: <71269d87-6ab4-4386-a04f-126abc63fb61@amd.com>
Date: Tue, 19 Nov 2024 14:35:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_qspi: Fix OSPI boot issue
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, git@amd.com,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
References: <20241114062045.17581-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241114062045.17581-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dab19c1-d508-4184-d71a-08dd089f0907
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zkhaa29PaDNJVkVQS1Z1b2hjM1V2UDFQWW1tMytQK0lVdHRJL0trLzRNV215?=
 =?utf-8?B?eG82cXBZc2oxZ25pUHRrWnNFZUZuY0RZdndHMWZ5T1ZhWUxMd2Mybk9ZQmdG?=
 =?utf-8?B?UnFzNklXRGZhRlhNR3dHVUo2NU5ZV3VkYUhLRjVjZGxjVVgza1cvV0EyelU4?=
 =?utf-8?B?TE4wSVdwU3g5WGhHaHd5cU81d284LzJkRlRSZDRQcHMySWw4L20vMEJSdWJx?=
 =?utf-8?B?MU9Oc0IrbUFYOEpSSGJZNER6andEekZzaVlXYktibDlaWTlnYTNFNjZiclVX?=
 =?utf-8?B?WGpGWFI4U0NPMVRuUEI5enJwYTZlemtSMW0wRVZYd2htUjhLc3dFbGx6by8z?=
 =?utf-8?B?N2t3MXJBbklqbzdxYUJvVVhsY1JJQlYrRnFkRFFVMjhtUm4ybWl1TmkyY0tm?=
 =?utf-8?B?b3F2WDJVbGNhZ3R6T2pCT2dsQmJqRk1OR1lBQ3N2UDBaR2x0MFM2UEpyMU9x?=
 =?utf-8?B?bEdLS1V2K2xIL2ZRejJsMWEvNTQvRzZTcFNkQVlQa09wWW1pQ0c2TWgwQXpD?=
 =?utf-8?B?V2M2cjJoWno0ZmRlTnVkRU9SUTNWdllIakJvK0N2OWwzcEZHYkF2SElCdnBw?=
 =?utf-8?B?OXlOTVNYVUI1SGcxNWlvN3N2MTdyQmpnemU1UFUyQ1pkRm04L095eGdhRndx?=
 =?utf-8?B?cWRDOHQ5Zk5xRFdkbllmK0tNa241YW50eUhnazBwNXByKzVNNTBrV0NiZkkw?=
 =?utf-8?B?bER3Q2xIeTlmUDU5b25CQmIwZzVkeElDaXRjMW1wN3lQSkcza1c5S2ZUTVRm?=
 =?utf-8?B?V0pRaDJZbEtKeVRHdjlzTEN1bElvaXZ6VVA0T1RkbDgyUmFpaGxKVzZOM1py?=
 =?utf-8?B?OWVmMUoxQ2ZNaHZydjdJSUJxTFd0b2RTQjVFWEFWUkZOY1VDZG9zTnZEdndk?=
 =?utf-8?B?cnJXRUh4SUNiQ0F6dTY1TFZSRGJrOWtZek1TYWFLWkJjaWpHZ0JubXBhRUpv?=
 =?utf-8?B?aFVKN09ZRXNtQ2VpTW1iWlhxclRBdVlTdEZ2Q2JWKytWMm5xR1VsQXRoZUc1?=
 =?utf-8?B?NS9HZmZJVjdBRnhDSlZuc1FpcS9BN3NUejBva0NzWWNBQ0t0UkRNT1ZkaXhO?=
 =?utf-8?B?R3UrS3NmWkQrQkJUN3VIU0NRUUR3R0I1SnFzbkdqOExRS09pNDhUOXBZYmlv?=
 =?utf-8?B?UG1vbVZwdjBrQUZQT0dGSFVCZ3Z5eUJOSUZQWjhGK0lQWENUbG5Ba0FoLy9z?=
 =?utf-8?B?cU5hTHAzWWZ0Vk9FRlkrSFJMZ2hPd3pnTVV6cFVDdU5xOEIzZWpldTNkR3J5?=
 =?utf-8?B?bUtKNzZiZDFhRGUxcjJYSERUSW43NXhyV2RxSUxXaHc4NHMzdGtZaTFwblM5?=
 =?utf-8?B?Z0xDNTJ6MHU2R3N4dkxXQVpOYXVIZmNDVGd1Q2VsTk9sZW4xMytVbEhQUmMz?=
 =?utf-8?B?eVJWck0yWUlNZzkwMDQ3cXpxOEY4S2QxSDZvQit6aUhlNnphMWp4U1Q3U3lN?=
 =?utf-8?B?a0lCdTBRTW1Kc0p5Y2Z6UjJscStRNkpoc1RSWDNVa2sxekF1Q2tiZEh5MzFT?=
 =?utf-8?B?eEtqUzN1NDhFMnNYSjRzM1VnTSt1NnlCMERKRi9CeG0wUlNoeFh4dEhCNjdB?=
 =?utf-8?B?RVFUa2FCV2hjUFl6M0I5cW5mYUd6NUdLMTZkcy9MOXNBUkFKc1hSWjJGejJE?=
 =?utf-8?B?U0NUQUtaV3BHYmVLdjYveEpIcDBFZUJweUdURm50c2w0NWh6emhVdVgyTWQ4?=
 =?utf-8?B?bjBJWjJHaVByR0NpR1FkaXE5dFR3QjJncUJ3VTh0WGZxdzFEcmY2ZHRCbEd2?=
 =?utf-8?Q?bVfwA784MTBZUiks6nxwJO5k6UpfvEll7I00Evs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFRbkE2WTBtZ3pVcUU3VkFkYytDMmhmbWdaMlVjOVhnWjNjNi9mc0M1aG8y?=
 =?utf-8?B?d3FoSDNtazZRKzg2RFlsclh1TWN4cjdQUWc1cGdNZ1I3VGJkZURLYlJDYnZo?=
 =?utf-8?B?cURMQXZiK1E4VFZUcm9mKzkwNWtmc0FPWFhGdHc5dW9EVms4UGVCZ3ZyNmlM?=
 =?utf-8?B?WUVIbVc3d0xhTWpnRTZrem1xd0ZqVDJvcCtUQS9xejE2QmNIbnprNTJYNGYr?=
 =?utf-8?B?OWdYV3FGNmk3RTNjaE55QXRGZnZCL2RGMnMxSFdCYzRRM1RzcklyMGRCRmpM?=
 =?utf-8?B?MGJJUHVNNTBhUkJGOHRpOEZNMlBPWlVVYkc4S21zdEp0anF6Uk43cDU0emh3?=
 =?utf-8?B?VW5OcTNkNVgvRDlSNUw2Q2ZnbjArMktEL053ZXZYd3J5VVZ3VEowTXlJSGRZ?=
 =?utf-8?B?QW81SFY3TThiOWZoL25YY0MxajlzRFQrV050UnBiM043VmJEK2s5TlhoR3Jh?=
 =?utf-8?B?WFRDeFJtbzAvaHMxT1JjWG9GSGt0RXdVNDJUV0xUakJRS041RlMwck5GRHNT?=
 =?utf-8?B?TDIwMFZMdnA3NEhBdis3S2xwMVZLTEFCK2d0M1M5U3lPeW9RVlpISm41UlpD?=
 =?utf-8?B?d09qTEVkelFmY0JTYnUxTXhSakxaVFpSOHVGdi9mM21UT1crNE1FK3Z3UExR?=
 =?utf-8?B?YnBWckJ3b3MvTm01aVZmeDU1aTFZNzFiTGxhTHUweW5QWUdHeWVacDFrZnFs?=
 =?utf-8?B?amtLQlBuY3NpT2NOenhDUytNVXQ2dEExMWk0MFJVREtQVUZkMCtScWJCWUYw?=
 =?utf-8?B?bi9MTzFXSHVDcVFSa0phc2RLaHRXSk5ibVRCNm1QRE9FY1A4cHJ6czNGbmxG?=
 =?utf-8?B?a1ZFTnN4TmVTNVFEN0NCb1NZSjJSYitsNVhCNzVCa2wzSnFXVTFUM01WSU1B?=
 =?utf-8?B?SXlxNHEyQnJLYVVQUnZ1TVU5M0tmcXhOQnk2ZldDUDQ5OE42NlN4YWJWNXg0?=
 =?utf-8?B?Vlhxak8xem9JbUUrZWxwd1FqeDBzZkZkc0VmdWpHU1JMckR4S1lKV2tzWHlt?=
 =?utf-8?B?VnpmSzVoL0xSdDZzUEkza2k0RHpiUEVReGxjSmZxblNIUDR6bmtyTDVWU3Rm?=
 =?utf-8?B?RWJXbVlJenE4bE5OOGxLZzhzZmxQdWgrT0liMW1iOXNwM28zdVNSVStlelI2?=
 =?utf-8?B?aEJZd3lCbWdrRFduczVIQm5Wb1VFY3hjMHdjMm1RMmV6TWdRNlJ3YmhoVjFv?=
 =?utf-8?B?M2ZZaS94aTkvV3FYTlV4Nnh3YmsxMFFNWGpwSTRLdGkvdUJXKzlBVDBseHFG?=
 =?utf-8?B?cGF6MUM4U3dMR2pQV2pOZWdiWEJMRWYrTi81WHJNNGdWdDRhbVVMcVNRblVX?=
 =?utf-8?B?d0Z6ODh2endLTWw5aWJoSWQzTG1IUk9vRGVtdllISHFWbmZmQ0J3ckpJd0k2?=
 =?utf-8?B?NmdCR3NBenVZZ29qNVNIYmhkY0pXYm1Uc3V4S0gvM2lxY2RMa1E5MEMxWVdK?=
 =?utf-8?B?ekN4cDY5UnFseFZqKzFaU1ViL0x2aVBwSjMvaWg3cGMwWlNEVmZ3MVg2SGtO?=
 =?utf-8?B?SkoxcmhQVzlhZVNvd2V3QTg3dzR2VnZHZHdzbFlJRVM4dFc3SzJUZ3FDSnJI?=
 =?utf-8?B?bGxzYVpLajc5NXprYkdERy9FR2tCM1FtbnZVS3h1NWdDSVhmeFU2TFg1b3BF?=
 =?utf-8?B?aFY5eDJUTzh1ZDBtZlFUeUkyV3diVWlHSG55NGxTWXN0L1FsbURZVUZkZ1Fw?=
 =?utf-8?B?VGhTRmRRSkZrV2s1aGZFeVlVdUFrZmp5a2FoWTFUcUFCVVRaWGhkYVc2Yyt2?=
 =?utf-8?B?c0xaQncwN2tveXhTU1Q2VTRzWmRPZXdRNE9zVVV4SkIwZnpuWCt6Y0pmM3Rp?=
 =?utf-8?B?NHE4TnJYM09xZjVBVXRDR0ZjMlZVeDNWcnc1U0p3Z3RvUWQzTS8rR1kxa1Mx?=
 =?utf-8?B?VjF4RkJRNUFBWmFaUDlyeGQrblJmNGRQaysrNnJjV3VFdjF1ZXhJVlRWS1Jw?=
 =?utf-8?B?WW5CYWNoQWNNOTNNVTl6WUVMOUtXUTNFbTVsUW43eEkzT0tnWnpnYWxTNi8v?=
 =?utf-8?B?RjQ4SStub09Ubml2ZG9BYzJZSHpuamhpT0d2TmtjOUhuNWVScG9EYW10S0pk?=
 =?utf-8?B?eTZKNjZKOWhnRGpqNnYvRCtEOERlS1M3MFBhQi9GdEU4WGFjRGVPVjdWRmxa?=
 =?utf-8?Q?0uDVch11OzL8szX9qEUX6xYvY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dab19c1-d508-4184-d71a-08dd089f0907
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:35:30.3295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RLg+Xju8a8NwMu1MjYbU4CjWeNSvEjfNPQfImH2JAlq5QAEXYJxJdvp42jiu78W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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



On 11/14/24 07:20, Venkatesh Yadav Abbarapu wrote:
> Moving the hw_reset function from the controller driver to
> the NOR framework has caused the OSPI reset not to be triggered
> in the Cadence driver's probe function. As a result, reading the
> flash ID during SPI calibration is incorrect, and the
> CQSPI_REG_RD_DATA_CAPTURE is set with an invalid value.This makes
> it unable to read the flash ID properly.
> To solve this problem, it's suggested to skip SPI calibration and
> instead retrieve the read_delay directly from the device tree.
> 
> Skipping SPI calibration doesn't bring harm since there's no need
> for the flash golden values stored during SPI calibration.
> Instead, they are now read during the spi_nor_read_id call in the
> NOR framework.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/cadence_qspi.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 9c466f8695..331a46d88f 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -251,13 +251,6 @@ static int cadence_spi_probe(struct udevice *bus)
>   
>   	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
>   
> -	/* Versal and Versal-NET use spi calibration to set read delay */
> -	if (CONFIG_IS_ENABLED(ARCH_VERSAL) ||
> -	    CONFIG_IS_ENABLED(ARCH_VERSAL_NET) ||
> -	    CONFIG_IS_ENABLED(ARCH_VERSAL2))
> -		if (priv->read_delay >= 0)
> -			priv->read_delay = -1;
> -
>   	/* Reset ospi flash device */
>   	return cadence_qspi_versal_flash_reset(bus);
>   }

Applied.
M
