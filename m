Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606FDCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E17A0834D4;
	Thu,  2 Oct 2025 13:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UqO/HIe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEBB835AA; Thu,  2 Oct 2025 13:46:25 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99CCA828A2
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMefa379qwB2VO7yLNrRDUtN0a69V7Sc5Ho1Mve2YeoZ5OO/prNFgfGEFHO6qTICf8QWdzJcbc46mknXAAPOpb5ibD9VzdYwLkqThk5FCRl3+njGjv5K9xfHy1ak+gW2ymNFjU94x7lONEQmmGMK/NqCqEhtj0ZeP1F4hnwA33jBVi2QzPclrbUGKtk4pnHSXaUK4qrGtaw7PIuHZEAzZBVBKexZGtc5mvqTrBXzJe4OxIwTnUYvSs1MlwBF5SFOgzlfL9owE27IUyUBibl0DYlSz4QZ+/Wp/L4HJJs5mNhbI/ZSx3TnS2GQ+ZNaah57drerWGzomJ8d680lNRF+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5qY1tH+fESsdTRbcoHDiIxiiAUgnk2kkhP7DuD6a28=;
 b=hRmXYkuxrhs2wtWnKZJf6CfzHQ8vFOqP0jrc5yRqvLkJSY5GOdslBNcFda3AtKzi0Dl6GwVyWyzOcKZVKUbG8f84O2GdewMO8XkqTUwK1AuSryqlRZ6OlA9Iga4y9XqSFVRAKrYPNsziorspNddq+jZ/kyO2cgJoZjyR09f6+3MwWwn8w3SpWCrIQwsZurXL+dq6q3fslYNMf+38k/Jiax4xCx9mT/wXe3Zrt8KxStQynOfBl7w2oJqfoGN5iAWI/bEFx82uZE9BCOlKqfP2ekM1YzRa30utAbbk17PNNvvVT9CmACujNwW3DqqFAUEFpqA1dd8Ras5yZ+OSmQaitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5qY1tH+fESsdTRbcoHDiIxiiAUgnk2kkhP7DuD6a28=;
 b=UqO/HIe8/yvQuT8a3hmLEfMfWrZjYwMXsEgnbdaUX0UgK1PfRz8dnlkAGoyIfzXJu1UK7Ne8omhIlc68OKYNJhMnJWfK7+cmPy9rcSY2C3TOddlg1JZgqFG78ye30YcU9VSa3HDVxT5HA6AJVxZ5VrRiXIyWcoZAK2fEMyfDEkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 11:46:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 11:46:17 +0000
Message-ID: <3cc67baa-d007-4714-a65f-d4272108eec8@amd.com>
Date: Thu, 2 Oct 2025 13:46:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] env: spi: Fix gd->env_valid for the first write
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, git@amd.com, 
 Tom Rini <trini@konsulko.com>, e@freeshell.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>
References: <803db0f01d568fcf702368a64eed007bde1d8bf8.1759397673.git.michal.simek@amd.com>
 <930f951c-d2ae-48e8-b8c1-680e2b5b3985@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <930f951c-d2ae-48e8-b8c1-680e2b5b3985@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0092.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: b86e8489-d5b3-4155-1209-08de01a94c3a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0pabTdQRTVWK1VHZEkwRi9haVU3RmF2a0ZRc1NldU5PVkpSVnhtZlBlTnFs?=
 =?utf-8?B?OU5iSkt3S05DcE1mWEVwZG14WUkvVnlKUkE2WlR1WC9nbHdoMEdmR2FVV2gz?=
 =?utf-8?B?UUVBbFpmWWRkdWR4a1dhb3BtQzlhSy9ySFlZQW15VkRINTBlb2F3RU5MaFpX?=
 =?utf-8?B?bmpuNmtlNEI2RW9NZ0tkdlh1L0pKZHNEclNXa0xzb21MeEhTQmZMZTZ5SG8z?=
 =?utf-8?B?YXZadHRCTm1jOUh0c2VVWXRpbTgrajliaVplNDBxKzdaeGxRUHJsSHYrRE1J?=
 =?utf-8?B?cVYvSWNyOXJlMk0rdVBLeU1YL1JXYUJQSkNXdEwybGlUTll2UXRuMXhoYkVR?=
 =?utf-8?B?dTM0MG9vWFpVSGk2RmNVZk5zSDVjcnE1UjZHT080eWU0UXRxMmFXTHFNQzNm?=
 =?utf-8?B?SVcxWml0T3VMWUZTZVoybG1ZWkFuNHNpdERTcTJ1S1A2bjY0TTBacFJXWVRX?=
 =?utf-8?B?clNTMlY2TkcxRHZjR1FmcnF2aWplK0lMcGsrbGVKbzlzMFNYSWV3ZFlQS3kw?=
 =?utf-8?B?Z3NCeGkrcHJhSTYxQU1GVk9wZjJ2czA0S2NocWlsbHFpTjc5TGoyRVBmL0lm?=
 =?utf-8?B?TDBXenZ2UHhIYUNwMW4rTGtITnVNUURwcEEwaE9mVWRtY3ZQOHJVWWJ4Z2E5?=
 =?utf-8?B?Yk1FbzJkczJEOExlTVY4WjlOT2hTNENYcWtwOFdlVlpDZWZjOUhjeVBBWnho?=
 =?utf-8?B?UHphdkU3NHR5SGQ0czBZTGV3QVhydEo1L3B6R093aFRYQnJxekM1K3pXMjNF?=
 =?utf-8?B?RmJGbUtHeTFqbmNOUFdGcUh2NnJpOGVvQ1Q2MzB0bytMb0hkSndPUlkzM2hH?=
 =?utf-8?B?ZUF3TjdLUExmYWk0LzIvOGVQRWF5MnJCN0c0VkxPbjJUUU9DcFM3ZCtYaWxR?=
 =?utf-8?B?SXFaeWVmS2wvMUpmVUtqaUJVZTE1YTRMQ1JoYU42d1FhM08zeTJiWWVkUXMw?=
 =?utf-8?B?enpoTHdtazR0Snh1SUQ3TmVoOGt6VTh5Wld6THRvdkZsbGNidGV5K0NyK2s5?=
 =?utf-8?B?MDZNOGVvRyt4MmdxbVZsdlF0YzIxb2lCU25ObWk5OEt5YnU0bFVNMm1HaWkx?=
 =?utf-8?B?ZHpudE05Mjd2dFBUSWg0dndVUmNzdmovNS9kYlYwNmQ0TmJ0U3BpTlM1dFp1?=
 =?utf-8?B?S0xsRHNXckJmYzhuQWh6WFhwUDVnUHZkWk1JVElQWGlSeXhza2Z2TmRXWWJy?=
 =?utf-8?B?YklGMmVUZWJkZ0hIeWtEZ080YWlaTW5BNWZWTWNiOTAvckdFNDI1Mm9tNDBw?=
 =?utf-8?B?bXh6QmdKQ1RRNk1UUVlGTUdLN2h1RHM0ZTh2V0g4aVJaN0ZjS3FqNm5TQWIx?=
 =?utf-8?B?VVM5UmNOT2JqVzk3THdibUJLeldGckRoOHd1T1lsb216YXJ0VXMyN2JzcURI?=
 =?utf-8?B?NWd3VEZzTTBYeFFuVld5bzFDYTZlWHRhZVp2M3BMdFQ2UGY4ZWc0TnJiY2c4?=
 =?utf-8?B?NFpuNVVBVjRSNUFGY1RMTXRFVUthUXlxTVkwcjdOZnJ3OTd5eWdhNmhGeXE2?=
 =?utf-8?B?K2d5Q3FVWlVOUktrclg3QlZwYnBpMi9mR0NsUEJySGNhVU5JY0xLTnJrQ0hr?=
 =?utf-8?B?Z1pYZUFvbCtkbTUxMithUitCYmY1OTNyUjdnSzFZWnkvRTUxcWF3YTB0REFY?=
 =?utf-8?B?elY4cjVzRUg3YkdYRGtNT0xLVFhydVB4VTNqRWROb1VuVmxDZTBFbHl2MC85?=
 =?utf-8?B?dmJvTWM1cHphN0RCYmFXd1JtbzJub2xYRzVUTmdJbnF3SktLZjArWGo2ajc5?=
 =?utf-8?B?Z3BpQ2hERVl0RGZGNHJjSGh2ZjhCeGYzR25LcUlQZ1FyR0trdTQ3czYzKy9W?=
 =?utf-8?B?alRidkxraVRscWpQKzRpNXY1bFVHKytsUzZqTENVbHNtWk9sYmdpU2RaMm5K?=
 =?utf-8?B?SzJ6N0xPUFA5cHNWaENSd0FTb1VNa1VBY0JhcnU3bEszNUJWckwzTzhFOEY5?=
 =?utf-8?Q?2b40WqWPoCBVvFSoGVSXIX1tUdAtAtll?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWY4TUtJTTZVQ2ZnZXkyMDlhdnRLNkJsdWEzVzE1YytZRGcxQ1NheEpGU2pH?=
 =?utf-8?B?Zy9HZnlGa01aMUhJOCttS2tRQ0ZmRG9weEhQTDVqMG50Z3JaSW52Q1dDZEVB?=
 =?utf-8?B?bTJ3QjFTOHZLay9nNUx0TDdJbE82eDhyUHBGZmp0RjEzNE9DcHBKQlMycE42?=
 =?utf-8?B?SnpUbm5ZYy9RaFVLZUt4bGtTUXpyTDd0ZXVIQUhUVUtJZ0lmYWQ4VU5pQTkr?=
 =?utf-8?B?UjdjNzlvdW52SWtmOG9OdkF2dGV2bFp4eHBTdjFaK1VtTUN2dkl3Z0IzTDB3?=
 =?utf-8?B?UDUrbXQycmFqa0pnekZxbW1EeTVCTGUvbEN5eUwzVnVnb1RENWJnZXNxQ3RS?=
 =?utf-8?B?WkhZL3Q5TVNzRlRteWs3SU1pTi9VdytCMUgxRHVFYUZBUVlNcFNFS2Q5TUdV?=
 =?utf-8?B?REFSdjFiS3FKM2UwSnBrSE1QS0VlWSt5cUwyem1YaVdJU1lnNTRoTFlQb2d2?=
 =?utf-8?B?Y3VwS2xhbnlnYlFrOVMrczhsWHJnbFBlL3IrRDRsRTk5RmUydDRGbm5ZbUt6?=
 =?utf-8?B?UVJXZ2ptUmJmbE1SQ1ErWTFCRUV6RGxMT0VaU1l5Q3d1WWtIdGpSclpCVUl2?=
 =?utf-8?B?WDQ1eFZDMzJwY0IyVmY2QXFBeGdURHVtZC9HWTEyVDB0dml4UnFkd0JhZ1Vn?=
 =?utf-8?B?Q1dJaUFSMTFidElQNXdZMDRLUEkyQmh1eCtva01lZ21LaVp3RWFCUFh5MnB6?=
 =?utf-8?B?TTFYQ29BVzlaWGZydmdMcU5YTVF0V0dJTkovN3RmRENVUWFUUGx0MHlsRmg1?=
 =?utf-8?B?OWRlTko0bTRCYWRtQWt1WjVuUk1aN3RpOGhQM0xVZFJ6Z1NLVEFhL2NQa21D?=
 =?utf-8?B?RTJvYTd1a0NTa3h3bVVsbkFJOS9NSlZpQVB6V1lWV3NaSnd5Z0drK3Y0VWFU?=
 =?utf-8?B?c0FVeFlJNm1ELzNOeUIxajBoQXNXdU5IZG9ZcnArMVZyTzk2Z2tISzFyOU92?=
 =?utf-8?B?N1FUbzlYbXJJbFZ0NHJJdWZIcVJINnp0NWMvdERCeW9wRUZHSlhHTkphajNY?=
 =?utf-8?B?UWUzcVJYVGdMMjhjamhFTVZBMDBVV1pBNHVGMnNvOU0yaU5rV2RWbzZnK3NV?=
 =?utf-8?B?cURHUEJzV25mdEZQTjFLdGpieExOOTlKbXVTdUN3SGlpbkxobFJBWGpjT3BI?=
 =?utf-8?B?T2U4NjlTWEovaWswZGh0Y3BvWWZiU1VTTDhwMHNISEZyaXZLaG1nL3ExaUdu?=
 =?utf-8?B?anR2VXNyN29xWG50RUdVK3NJKzhrYTNBdEFTeThrQm1JS0Z6TjFUMEtYaHNF?=
 =?utf-8?B?MmRTd0lyY2RaTnNMT2I2Z25CTHNVb0NFbUZKbTBNMldyd0xxT3FmV3pOTW9L?=
 =?utf-8?B?anp4RHo4eEhVSzJuQ3Bjb2xBTjRsS3lvOFNXNUNDMUp0UkVKMmp3Mm9EVDAv?=
 =?utf-8?B?L3UvOWpTTE90bmovNjVTOHppTk5ZWlFLUFpnWnJDRGhueXBvMjZ0NTZLU2tm?=
 =?utf-8?B?aXkvRGc5RHJzd2x0aHRnVkFIY1V5ajBUNEZhbzViMlRQcUNKTGcrZkduQUxM?=
 =?utf-8?B?K3Z6WVoySWM5SVRWSnV1alhKOW9RTmVsVEpxQlVpeTNjTDQ4V0JGS1REOWVB?=
 =?utf-8?B?NjhsOGxIV2pPWUxsNVhjc1F6NXZoNHluZEJ1YzFTV0hXT2p4Rlp5MWNQdzFk?=
 =?utf-8?B?d3M4WVFsUUdpanEvVGwvRFM5UTJ4Z1l2YWxWTHhJUkQycWRNaVZRS3VqWUFG?=
 =?utf-8?B?N3dMLzhLNVJ1MnJsdk90S3I1LzJtWERtekFhSXZEM252TmtyclFYNFNiTits?=
 =?utf-8?B?VjZvRlkzOFdBR0NQL2JaamxNZVAwMTliWnFQUjNrQy85RitkYlZXb2ppazdx?=
 =?utf-8?B?RTk5WS92Y2FCQWNMckRLU3Z1ckhEWktFVlZzajJSRXc2YTdJaUxiUjlPZkpz?=
 =?utf-8?B?b0dVL2JYVGtMNWdQbzJZanRnSG1qb25adlhJUnU2UHV1VVNPZDhldUhwVzZl?=
 =?utf-8?B?aW5kZzdXOGZwVnVsUmRwdWhIbUluUnVJTFFRN2RBZnUxL3pUK043Z1lrdFZ1?=
 =?utf-8?B?SmJ2ZmJualYzbzU4OFFzbVMyMkJ5dmM1T25IenA5cVI3enV3QTJJTGhXQ0h5?=
 =?utf-8?B?RG96SkczSENKWnFCVVV6b2FwbE5BVXZtNTl5Q0pRaE1mbDlmb1EvNXkxZzBE?=
 =?utf-8?Q?TyjEqPsb3gHRdON/s9B39W/RE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86e8489-d5b3-4155-1209-08de01a94c3a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 11:46:17.5921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egaXAXs0DN8frFZL5Ifx0c5VPRCQ7SSNGVZhgBz9nnZqgWTdT1SSWIXTHxylXxI2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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



On 10/2/25 13:42, Marek Vasut wrote:
> On 10/2/25 11:34 AM, Michal Simek wrote:
>> Update the environment location selection logic to perform round-robin
> 
> We only have two copies of the environment, why round-robin ? That makes no 
> sense to me. The actual technical information about the bugfix is now lost in 
> this churn too.
> 
> The V3 commit message was perfectly fine.

Tom: I did what I could. I don't really mind if v3 or v4 version is taken to tree.
But please let this patch to go in because it is wrong behavior which should be 
fixed. And feel free to adjust commit message as you like.

Thanks,
Michal

