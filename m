Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF82C021A0
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 03:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8405580BA8;
	Tue, 11 Feb 2025 04:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="bR3QKItq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3735B809D0; Tue, 11 Feb 2025 04:47:15 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C42806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 04:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6ZjiaGB0Gnk1vOWfc0Djf7rNB8J1CHmYC7ovydOjRby+6nWMTzHXRjSN7gSXHZ0bI6XCujdJ6+2b97xXk8LHCbNOm5qu0CCltTjhh2osjgMGtLHxDMUXC4yI1akTJ6O2Z+4/G/DLOdIDSf9Q28zfBbGyMO7/rkLx75V/k8t8p32s9c/Bno+Z97CUgnJz+KMWbCAHd0yeyeINyASo1cCax6tVpeRY1oVhPpPTNhGIS3MsmaW0twF6TT2pwMDCVh81pXz+GcmFi//FFFxkgl7c9FfTZJLKf2VHqNffxcOC+8ek60Ia4lh99CAd/YceIxs1T6peYSvMLhZzHv0aS04Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99lyi7YmMSAbuocPbvkblFfdjk69bB+SKd6F8naGsqQ=;
 b=fxGqP0xkG3wpnWC2/OPvd7cdzRwrYIlRoXlnvabs1i03NukbPkI6qMTeHQQSMLJZsUThaMfK+tfNX8ES+TCg2KdGRD5dO6dQO3Dir0PAXNnlowi0ZTChtLDDrX4zQVxtHVhOOx6UxqprBM+CwMHJA1koI1jpGKdVIOkPBxLr6YhhrEfx0sxP+YUs69Lt/ooAPOU1AphlO4SpEO3y7aAN4SkadMgRIvxoW30e7QmZ90miTJ4NjXvE5tEB3HiJTTqyy790TKGGvKMd9qXvzCI2CE2Jxkn+ky7dYz9L0er8xghWc/gBmvJh8qMAU7jOYHW9x8gVTPnqk6ipvAsKmU2yiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99lyi7YmMSAbuocPbvkblFfdjk69bB+SKd6F8naGsqQ=;
 b=bR3QKItqH19Hs9eNUbOmAXJkTtEgoBH3RhrBDgAT6xYnshXtXUFcAW9P/JUFIwUp3cgUdl4rC+ePRJVa4zXXMGF1KiuQr4t2wH5M4LLGkLXVWpzON2pqoTnFCCjXiDDdn2FzapQGGAyVafvTsSBwasS+4LU51XdmTgn/+5VyIWgREAy3ma6OsC6K5Qk76aVW8WmbZO834lLAPatjUdLit52yVHa4+Kqe5SLUiCfHgatuzcTPVa5HvpRCKdoJnuW26XFzgZ/EYeJIXgs0O1y3eo9Jw07kn7KUMcoEJmPyplDeNhJ+U8GXnCgm3VP37b9ZdMbwftpLj723omVFhcfNqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1779.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:39b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 11 Feb
 2025 03:47:12 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 03:47:12 +0000
Message-ID: <9dce4ba2-16c4-4154-bdd3-d65fe13e624b@phytec.de>
Date: Tue, 11 Feb 2025 10:47:09 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] configs: phycore_am62x_a53_defconfig: Enable
 ENV_IS_IN_SPI_FLASH
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: upstream@lists.phytec.de
References: <20250210152548.1263498-1-d.schultz@phytec.de>
 <20250210152548.1263498-2-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250210152548.1263498-2-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:820:c::22) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1779:EE_
X-MS-Office365-Filtering-Correlation-Id: 275d9a0d-f1c7-417d-865e-08dd4a4ec43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFlzVVpTTEx1cDFtWlFTNXF1bWlwQllETU5nVS9Bd2E4VFRhQlNjQUh3ellX?=
 =?utf-8?B?Y01QRituU1hIa3JQeTFHUTROVnZpQ0dkbnNlYVlmSURqcGFWc2gzUXpFTitP?=
 =?utf-8?B?QllBYVFEVnh2V3pXa203WXFFYjhEbVRzMEU3bUdHSUxvczFjMDFGMFNFSEdj?=
 =?utf-8?B?OGY4ekVUOHdIVlVrcU5KQVp5VmZ2Q1F6ZXo5eUgzdmk2djZ1eXdRTXNyeFdv?=
 =?utf-8?B?cmczV0xndldrMnNYYUl6Z0dpcldUNXJWTUFqV0NsSVdGVUhkdjBWM0IyWWNz?=
 =?utf-8?B?SnZRd1J3Y3JxNkN6aTh0SlZNNnNKNUFqZUtueWpYM1BWMFkrcG5yTE84Q3NK?=
 =?utf-8?B?MGtmWE5JalUxTy9NaWRCNGZ2a0cvUW5GUjYxeEZpVmRRN3puNGIwajByckxM?=
 =?utf-8?B?VytsRWZucTgvMkdka3dmZlhJZU8veDFyc1NKQkI0L2l5a3dadHI4TXhQNWFU?=
 =?utf-8?B?WTJuWCtOaFJ4K2ZoN3NJSlZlTjh3czEyT0w0clBiaWRjcVh5anlyczJ3d2d1?=
 =?utf-8?B?YTJWeTUveWMxRUl0ZDRkdHA4d2VVSE5leFBmWjJleXYxdmRud1VzczV2dlV0?=
 =?utf-8?B?Lzc3YjNuVFVsZnUvdEVTY25ya3E3S0IwdUVGM0Jpd0NiRVhQUk53dzNWTWZu?=
 =?utf-8?B?aStXOGZvOWpiQUdYdGRDSlJZL2p3SmJJMEFmVUpXQ0JENGJLbUt3K2VMYWJM?=
 =?utf-8?B?SzFkYlhmaFp4QUN1NEdPK0FmU05TSjVsai9leUc2ZGdDRjBPR1ZKY21Fa2FI?=
 =?utf-8?B?RnBTUW5ic2RzekExdW1EaWJsdkhJV3lsMHdVdHI5MUdrWWREanN0U1NTdmFI?=
 =?utf-8?B?ZkJ5RlFLNHI2aVpFN0k4dkVYb1dwYlRqQVNEZ0hFUHlPY3lLREsvQkhxcHhh?=
 =?utf-8?B?WWhpVXd2SFFuOXFXaURSSnpHd1d0THRGcEFMVTVXaEQ3OWVMRHNZWGt6MzEx?=
 =?utf-8?B?dlF2cmE1V212VWhXOVpiREdhbXFCQ3hzOVlqRWhUbndCRVVtN2pCeDlhenhw?=
 =?utf-8?B?bTNmdDhDN01KeGtnL2lqNFpVOTUydGlzL1BySzlpQ1RwSXJNQ1NrZ1VTeFY1?=
 =?utf-8?B?VSswMGJzQVE3SEtCaHAwVmVZRE5GbXpTb2ZSZmJWcUU3K0Z1WVNlbnRxbjRh?=
 =?utf-8?B?TWJBVzNoeG1TZnN2OE5rNklDR0VBVHNTckpGRUxPbnI1b29XYm5JbDJnTjRh?=
 =?utf-8?B?ZVZLSG4zU2JUQ0FoVlk4ZFVXZ0c0V3FORWlMZXZuVE1ZRGVITlhnYklncnpT?=
 =?utf-8?B?TjFBY1Y5d1JSL0VMK0hJcjA1bXVUdDBteHkvbzRsc1dNNVRubmluTFY5bGFv?=
 =?utf-8?B?bmt5RURiT0pXVnk4T0hGcVpaOG1sOGJXcGtCNVh3M1haSkx6OW9MdDRhbG1k?=
 =?utf-8?B?VWkwOGpmK1RvaEZpQ2xVTTZiRmw0cmdzMHdxR2FQRnNFcmJONmQvRS92azM0?=
 =?utf-8?B?S2JiN0ZaZ0dXOHByRlVXU3F3SDlUVDdOM011RGdLeVExakEra0xpZFdrVDda?=
 =?utf-8?B?dGFtL1NHV2g2Ny9lYWorY0NzWUN0V0thZjc2Q2Z6ZWVsV2tMTzMzQVJhMHEw?=
 =?utf-8?B?MlJUaFVMckREK3RnczFGTSs4SkdKaXF2NXhJelJ0aVlsTkhnb3V4K1NsKzlH?=
 =?utf-8?B?NUtFbmZQUVVMcGttMkdpNUp3dW1QRmtBL2dQWExXeW5WbGRxTis0aDJac2pG?=
 =?utf-8?B?RUNEVVNqeEhxazJMQ000YjdXYnZPN3NjaW9KdW5vSjN0WlVPeTRCWWVpSGJj?=
 =?utf-8?B?UjZFT09LSmF2bWxOYytNeWZpVTljYTV0KzhJdmNVTkNCcC8xdTl6L3A2Y3Ar?=
 =?utf-8?B?dmdwTTZKb29laDNKaXZ2SDU5cWZJcTQ0dG82T0wrQ1lUakdnSDU1ZW9VMXJk?=
 =?utf-8?Q?/Iwe1OgvIMuo2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZKV3pGMCtEeG9LVmFKNXoyeFRCQzhiM09EVUcxQkdPSVNxVFFRVkNWR3RW?=
 =?utf-8?B?ME54QTlGc0FvaFQ3aXZMZ29VbzFRVW0velNHQ1ZOMldnTXk4S24vOVY3UEJn?=
 =?utf-8?B?MTlMRFpPOCtzTHpuOE1qajZpUTJkeUlBRjJ2eXlQMXNBOXhoOE5CbnFWbXlj?=
 =?utf-8?B?MGo1bW1uTU4wbStRUC8wU3ZnWjV1MDgwQ2MwSDQyZFZ1K00yK1huL3NJeUdE?=
 =?utf-8?B?MlFvU1FoZUw4bUNKUXREL2dpUlYzN2hUUkN5S3RtNnFNU1ZGM3N0Qlp3bjlO?=
 =?utf-8?B?WUlCdmFoQWdxVzBSaTkxZU5Ta2lmU2FoRFdpQitlZ080clhjSytxbGc3Nlls?=
 =?utf-8?B?cUZ5WklPdmIyWTk2UzNzeTZqd3lNR3UrVk9xUWluR2w1aVBlTmZHVC9zR1NK?=
 =?utf-8?B?THJnclN6TERoNEFmYzl4WkNlck5yZThNelhhbllISi9ReFN3dk0wcGlQMHhI?=
 =?utf-8?B?MDl2a0ZmeWxIbVBibFhVTnRmVHFSYnN4SEp2UzBTdjFscHdKK2NNdUY3VkZ2?=
 =?utf-8?B?eEg0eTh4R1pBV2dsdTU5cVk2TWFJT0FLdmFRaGQ0Snl0b3crQ2FDTVo3K29i?=
 =?utf-8?B?NW8zRnpYcGtwazl4S1VZWDdYblM5d1JSUXNsR0FLLzFXZkYwaHJ4WWZkeHps?=
 =?utf-8?B?VlBCV0REc09XejZybWtJME0wY0RNSGVsUHBHUnNObFFOdE83MmM0VTRSVFUw?=
 =?utf-8?B?SktSSGxTN3RtbXdCdXo2YkZTUEx6MEpQaHQ1QlZ5b0tKSmhCRTc1MUZuLzR2?=
 =?utf-8?B?Ty9oUDk4aGdJQ1NRc204aytocUg2NkJtL3FPb2YyK3dlQkhYb1RyYW9OTlZR?=
 =?utf-8?B?UkdHam41OGlsa1lsVHBSUis3V0MxOE4xaG8rWXAwUU44Z2ZrdHpKMHdkMERB?=
 =?utf-8?B?RzhnSkQ1ekwrdjVPSkJTWnVmenR3YTlCTmx2QjBneWttK0RQNnJUdC9xVnRl?=
 =?utf-8?B?T1JHV0hnRHVOaU9CR1FWei9jd3VVK3k3WmRFQW9NWUQ5d1ByYU0xQWxlMDdG?=
 =?utf-8?B?Zmk2SGdOemtNcS9TRkFyMEN5czY4SjNzN0hrcStBZklzN3hWblByMW9BaVRP?=
 =?utf-8?B?ZTNta3p3V3RDRVBLdDI3MkRvUjgwTE45ckllZFNZdEJyYldPbEhHblIrT2w2?=
 =?utf-8?B?bHMrUWh6MnVJY1JuU0ZZRWNMa0pubU5Oc1gvVXAyR0MvWVZwWTBXMXZxa0Uw?=
 =?utf-8?B?S2p0QVNUT2NBM3hXZTFSN0hBVDBXR3FBelpudERLVEEwTlE3VTBmcjRYY3Jp?=
 =?utf-8?B?V1RPYzA0dUpUZC9renNOYklRL0tveDZTTTNkNkhIRWdzSExycmRQbVQyZGE0?=
 =?utf-8?B?cFFscUNjaXpYS2N6YktESFkreVhmeUQ0aUgrR1gvdGxEZ1RqUkVlSVZjUTU1?=
 =?utf-8?B?SGRIUnJxZXp4dmUxZEdzTjZ0enNmNnViRGlSNGJORmQ0dmdFYVFsZW5jcFlu?=
 =?utf-8?B?WHFpbmlaQWF3T1h3aHFobnQvOURkYUVIY2hBZ2RxTzhOSHpnSFhaVkRIaDFG?=
 =?utf-8?B?YzdaeTlCVDdtUzczUnBvaEk0aFRLOUtScEtXTEJKVS9Ha1h3YVQzZU5BU0Zh?=
 =?utf-8?B?bEJBUkMxUTE5d3d5b2VrcXl0WTdvQ2lRZ2ljREl5Ymx0NjRFSENDWktyQVZE?=
 =?utf-8?B?eTRPVEN6dHFGQkI1UUducmNmeC9YNG05dXZyV1dhRGZ5Q0dEWnBKdnI4VXFv?=
 =?utf-8?B?czVILzNlQm1yVk9UaDN2RWdaLzJCaTRSZTZoY25kUmlXOXhURDRxVGNXZDgr?=
 =?utf-8?B?azZheVJ1WU0vM29uMDVYWjVnR3NYQ2RYekdCR2R0Rk1lcTFveW5GMDRjQ0VH?=
 =?utf-8?B?VUFVWi92WVFQNmZzcXk4V1NiWitCbmFHanZZMWlxOG1aSHorU1FDcnNGNlpr?=
 =?utf-8?B?RlA0MnpaNnc5ZytaN0xIbGtLNldvWHg0NGsvdFQrY05COWJpU0lhSXlFTnFu?=
 =?utf-8?B?Y3Y0eFBGTkhYcisvZm9mcDlRUnJRVU1JNktidFdRVDFDZi9OSmtJcUxxUjIz?=
 =?utf-8?B?Q3F4Q1ZpRzNLMmpUUGxoemgrRVVKNmdiZG1xL2pEUERBQVdESVdpVlh2ZXZm?=
 =?utf-8?B?eWFpK2lOOUh2UTAvczdvbnlZYWZPZkdLajdmT2dhVkJBbE9lWFY4UzZYbFB5?=
 =?utf-8?Q?tW0Au/oHRf/ZIHCBjhFxTTgGM?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 275d9a0d-f1c7-417d-865e-08dd4a4ec43e
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:47:11.9901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZmUrEwTu6Ru/EfXHFQGioWsxsUCDFY1P2pzEhWVT1bvMy4j9d4K7GUJdmksILruz+mYpRwTojxFI8u+YMQMhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1779
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

Am 10.02.25 um 22:25 schrieb Daniel Schultz:
> Enable ENV_IS_IN_SPI_FLASH to read the environment from the SPI
> flash when booting from it. The oftree, kernel and ramdisk sizes
> are located in this environment and therefore required to boot
> an initramfs.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   configs/phycore_am62x_a53_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
> index 0494fc408b7..d7aa59bf1dd 100644
> --- a/configs/phycore_am62x_a53_defconfig
> +++ b/configs/phycore_am62x_a53_defconfig
> @@ -13,6 +13,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
>   CONFIG_SF_DEFAULT_SPEED=25000000
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x680000
> +CONFIG_ENV_SECT_SIZE=0x20000
>   CONFIG_SPL_DM_SPI=y
>   CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-phyboard-lyra-rdk"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -84,6 +85,7 @@ CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_NOWHERE=y
>   CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_NET_RANDOM_ETHADDR=y

