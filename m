Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD9ECCF2DD
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E7683A6A;
	Tue, 20 Jan 2026 16:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IzKWTw/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205C783A91; Tue, 20 Jan 2026 16:53:12 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E98883A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7abmQCoE21TgA4Y+oDX1TMESe7+YjTSFmJD5D92BAA2R0j4LB843qIM+jbJ8WnuW5Q3kEAB/+bKeVOWDICjGF52LqLfP1Z4fzLeOH8+uJGo3ydPJSp0h2101CyP9b8CJJX+xs3PqnT6yDYrCJNHxObkM/lrplczV8buozPOOIL/1EX5f4CXtgU/kv8ZNKToLbgqkB/yfBVsmHOw1nQFGebbnImXt2B5qhRMS/rNaBfuF6xC+55gaFW8o+9XSq7aVZ+KuCnzF1mpFYQRS5PBSqZipGWC4aHSvs405Epr3yZQrQo4u00BQVwTC+7NiLIQfrgbFin+vIJLBiKNO8H0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtXGifzAANIbKWiC99teg8VLZox5zqTZhNKLT/aSHDw=;
 b=lABmLr/ekMfr6RGL8x5j2ACUboMVJqqKha6Wxer+Kx0IlNr5onv2vJRqc+O5nAh5Y7NqlPOA2x2FA6K9fbUKXJvWCC43w373Wi2SJt3CH1a5EeeKxEgvGlawlBoGCbAhcRwsdtoUQhfflf97KoZp8dC7K7tpdrzT77A82is1vpyyvRx/yQR+PMZHiABCK1gCCkflhWraDqYgd1pfT4f44PV1zGR0RQK87M+LoXrLVG8GdUYKVE6Q6AllFxMsIVTOes4LEgtFve9BlkFEsI9zkBVrm+BFHagbY8mw41caZBaA5Zdj5EKUF4QTu+d4UngsqHSC203zQQ8O8xZ4Pb7Cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtXGifzAANIbKWiC99teg8VLZox5zqTZhNKLT/aSHDw=;
 b=IzKWTw/q7SWBcuxhDARReMlC44Q2AwXB8xNmAOp/8wo/UxePTCBriY/Ernr+fCyx6yupXCOuD2yWDGYwhTbmfzURNtnZ04+IpeRRTH39Nzf8TWa+G/otAiv2IhuS5bOTpnLcW2O8zEVK91X2A7CYF0Wh3+yYBOxRy9sNgUXKVBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB12112.eurprd04.prod.outlook.com (2603:10a6:10:641::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 15:53:07 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 15:53:07 +0000
Message-ID: <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de>
Date: Tue, 20 Jan 2026 16:53:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] test: binman: Add test for pkcs11 signed capsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, simon.glass@canonical.com
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB12112:EE_
X-MS-Office365-Filtering-Correlation-Id: 5666e5b9-39fd-4361-5d61-08de583c00d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWdvbW1ZOVpqM2V0S25BanBDSlNMUXZ1UVlVNFcxdUJTbUVib2hmWWNLNW44?=
 =?utf-8?B?Sm5vMnp2TUFZeGdpMmNhVklMUnRPejlManh1K3E0SmsxQlp0SjI4Nk56K2Fq?=
 =?utf-8?B?dlFJRzNoVkJKM1FwQjFnZTVEUW9oVlV3ZTVFdTVBYTVZNDlqcDgwZ28xd2F4?=
 =?utf-8?B?VmN3dE04RjROMldNSkQrcVVNcmZBUTM5WHRkZTZMZnErZmNtcVdZalo4aDV1?=
 =?utf-8?B?Y0ZwQjRzMGRIVUdBRFpkSDBaN2xxY0hyQm1IbXJqdGFFeWRhKytiR0VGQlVZ?=
 =?utf-8?B?cHArOVRhQ0VKU24zcWYrbkErSW5zVnNhUDd5YTg2ZlBNeWdaTTlNeXhQTXhy?=
 =?utf-8?B?UHJpQk5yQkRLL1ErVkwzcWRGYXBEMkFDOHkxcW5BQkVKVm02VUZNT1k1R204?=
 =?utf-8?B?L3ltN0llTXplaDdnSU1HVU1vKzZBcFZoRTczNGZsVUJ2Qy9iUEMxbWtmcVd3?=
 =?utf-8?B?Y2ZNQXNxUDBQYVdBcjZuWUdzL3l6QlIzTXl6czF5b1l4K0tXZW1Ec2RKb1BD?=
 =?utf-8?B?NWVDWERXYVlTbEllMUVoN24ySTNieUhSK3BFS0ZmdzlOKzlCdDBSSy9nRUZE?=
 =?utf-8?B?WFdNcVJNcDBHNG5UeFZMcjVuVUpscHBBN0wwZkViMVJqYjhoSzRJRVhvWHI2?=
 =?utf-8?B?L0hCakNLdTBPMS9SYjYwNUxiQ2pWZUdRQ2JoeDE3Njl0dFp1NEk5aGkyWjBP?=
 =?utf-8?B?Njg4YW1XejVrYmpXcHNzUkxJNjBEbEJLZ1RKU1MrbkZnZy85cTMyeXhFSmM3?=
 =?utf-8?B?TlV6Tzh0cVJBZWU0NnN3Q0NZbi9qRWVJbjR6eldXd3VXZEpYVkZTL0ZLTUcz?=
 =?utf-8?B?RkFadEVTZkY1cGpqTHg4c2pvK3ZIem1OUUZodFRSVEtKUVovdW4rS3pKNUNM?=
 =?utf-8?B?WTNyd0RPZ0p4amVJNHdBOGh3dDNvUGV3UEgyOWFqZnl4cGtrNCtHZ1pESFhz?=
 =?utf-8?B?a21NMlhIblVBOGRxM3ZzYnhvbjdNNFEwSEZPdEZJUU1nOXArdlRBbGFQVTZl?=
 =?utf-8?B?VWFWakdvVHdKclRyMmhBUU85TW1wclo5TVB6STBRVkd2dGNBZ3FTa3V6QWI0?=
 =?utf-8?B?QzREODBHRmNpVEVYRUl0WTVERCsvdTd1Slg4Qm9ibFRoVnV5TmxQNktFQy9N?=
 =?utf-8?B?c0Y3MWo0YTR1NXdiUTlocU9jTno3UkZ5dDFHSVFqUUdKMlo4enVuSTVrNFBh?=
 =?utf-8?B?RmdMUDVkL2lLeitLc3FnVks3eURlS3dUMmlUZy91ZnRlY0gycWxtMUk3eVo3?=
 =?utf-8?B?aGhKK1hxdGVKaCtJSEdxRGoyY2ZhZ1dkOUxsM0VlREtpakNuRWMzR2xuN1hi?=
 =?utf-8?B?dkw5ejMyOVBCLzJrb3NDK3MwWHhYVDg5V0liZjd3VkhLc2NhV1JDN3VQRWVZ?=
 =?utf-8?B?OVhmUzJnRDRKY2FVdnN0SG1KUWtLdlhSZExSSkpUNlZ0ZkhrMlhpK3pYeE8r?=
 =?utf-8?B?UlBTTU5iUklEUEVnV29BMWtESEFOaG9yNzJ0V1VnWFE0QzM4aFZ1UjZ3RTRU?=
 =?utf-8?B?RXlnNDQ0d1YxMmpCVXVJKzJJWFV2R3ZqVjZxT1ZCcGFIbzV0NDNHaUo4RldP?=
 =?utf-8?B?RVduU3BqNU9XdnBNai95bEFQLzNlVGhXU1l2ODZUK0pkM05WKzMzbldOK0Ix?=
 =?utf-8?B?eGdrLzZXZkpYNXppOU1zM2liR1JPQk92NmdVWEhCVUlRNmcxeTR3S3F1UzRF?=
 =?utf-8?B?dlVIbUdMUytzd1l3VGZveXZlLzZFNG5EcGFqUnI1di9GUzg3Qk9iZStEeDNW?=
 =?utf-8?B?U1k1T2FDZkVOdDJBb3JmUXRsL3R4QnVqSnNFQ3dyVDRuTDJLTlp5TWRXMHE0?=
 =?utf-8?B?OUZpdEF2TnVYZ0RSVmdoV3B5TnE5cWQ0alpOd1hubFhxbTBZa0E0eXpXQ2hh?=
 =?utf-8?B?WElpVWR4My9vRkJKK2l4UjJaVklsc255Um9pdjlxZUgvc0h5S0JJd2JlT3ls?=
 =?utf-8?B?clZMakI4U1JIcDR0MldzM2tvbWlvemhWUEw0QlVscC9HeEpvKzRLS3NoQVZl?=
 =?utf-8?B?NTlGMnE1VGl4VUJFS2lvZm9VTmFwSXdqR0paRU15dXM2T3BqNG1vYjNIVDg5?=
 =?utf-8?B?K0IzMlNOMWFSeWsxN0lIL09HamRSK2dBVlhyalBZOUhWSDliS0J1Qmt6aFJF?=
 =?utf-8?Q?XWDs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7142099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ZZc3Zsc2hwMmRHck5oeG1CQVZTeU9FbTdKTXNWZ0VGWllRZTlIeXZKT2h0?=
 =?utf-8?B?WXZ5c3kxMnorTGRHdnBaN2E3SmVnaDdYN1NRY2FDcG1wbFBPMEpqemVRamdz?=
 =?utf-8?B?SkFKZkJYeVF4cW9UTkpMVnVva2VGYmtCWHBmNkptVDZpa25RU0JQOWRucngr?=
 =?utf-8?B?YmZMMS9rdzB4ZFNVV0FEWjZqKzg4VUJRU2l2U1lYUC90VGh4RXlqUlhDV3ps?=
 =?utf-8?B?N3dQWHZXaTlzSWptN3NYdFIrOS90V1AzdDF5aVlrNkR4WjlqWHNwR3Q3WkVS?=
 =?utf-8?B?REZ1Wi96dlVtRjJ2eWExMGhDT0xiTG9QTzc3ckRrYmFmT24wdDNrVkNacERW?=
 =?utf-8?B?TEE2V1V5Q3ZYWWt0Y2VtL1hWN3hIY2dTazRRbmdMeTBvKzVjdnNHZmhXODlC?=
 =?utf-8?B?eHpnSnNtU1BuSXZudlZrenMyK3p0cnZ5UmxVRG80MGQ3Nk42cVZuWE1vS3pK?=
 =?utf-8?B?TkR1S0M3cFBPOXFjbDhJQitCRVFxM29FdUxuVXJrRDhDWmcyakhVaW9ZTTdC?=
 =?utf-8?B?YnVhVkdWWm9MY1EzcTVKWEtiMTd1YmFHNWw0elJvN1NRR09ieDZPMStEMUNY?=
 =?utf-8?B?VFgzM2tBK1lUMVpmUFJYU0lweWJKQXl2T3ZWUGdtM0IvSEU4dFBUNEFtQkV2?=
 =?utf-8?B?LzhKb0FPWjlMdU5qWDlsbTl4ckhPS2dZZ21FZytUOU1zNjd2azVYQzYzQzNV?=
 =?utf-8?B?NHBhZ1VPN25oM0tOaDV2a2ZVNk42ZDU0NnBHbEFlYUZMZ1Zndnd0OXR4NnU5?=
 =?utf-8?B?QlFSMVFYVHAySnA0RHJnZkhTc0lLSTdTOCtUL1Q0OExrMFRVNmZodCtBL1dP?=
 =?utf-8?B?ZlBKNUwvM1lnb1NPemFoK3NRNFNGcmdnK1BWaGJFR09jbjNlRjFBVGlkY0s2?=
 =?utf-8?B?cGxKVU1Vb0FOcGxEZzFPMk03WkZoR3JzWXk0aEM0M3JzajVxbGd1dFYxTEVJ?=
 =?utf-8?B?MTg5Z1d0cHowVnJxZXp1amo1Y1A4NFdaRXZZcHUzY2sxWjJpRENwRTZOUzRv?=
 =?utf-8?B?WGhzNm54YmNnYldDcElpZmVuNjg3Tit5b0tVU0dYREExbWhJZzE0djd1UzVS?=
 =?utf-8?B?RTVLeEw2QnZGZ1BUYmpheHpQWHlxY28vZWxzTkN1V25QRXpmZE9RaWdmRW9L?=
 =?utf-8?B?WUgxK0hVcHo0NktjSEg3NWFtV3FyZ0ROakd2VVE5UVo4VSthM2VWWmRIS3hV?=
 =?utf-8?B?MTB0QXBsaUp3K2JYbkRiNEpGVkxqbGU3RHUweEtXZlFRUHAybzBQVzhvMUo4?=
 =?utf-8?B?aGZ2QjVpTC9JQStDM3lhRTgzOUdwMnRXVmxXenZpcEtlbFRNWmJEUEtwb1Vx?=
 =?utf-8?B?WVFyLzZnSVlvTGtPdTc1MlNWQWdVTU0xK3hMMmF4RGNHeUI2eFJackJUZXJZ?=
 =?utf-8?B?a1pCL013blF3M081cU5NVmNxZXhCMVZRbHNVSmorS0taN3EvM203NjF4U3pz?=
 =?utf-8?B?akdGK21XbGJJNEhqYzN6WlpMNVU4T1oyRk51Sm1tdGFub1BFZjREUVpkMFli?=
 =?utf-8?B?amRyTHFuaGE4SXF1MVA3YjZWcjM1NGljZUpFbHZvZ0oyU0pILy9YQjlJa0wx?=
 =?utf-8?B?UGZ4Q2Q4ZVBFaTRONUxvMS9zWWpCWFFyL1dVZEh4L0wzUmZEVElEUkQ2cEhv?=
 =?utf-8?B?b1NaQklvUE9EZVJsblhPaC94ZWpZMTlIeGRER2JmbXRWdDFkOU1wM2xuZ2Ro?=
 =?utf-8?B?bWQ0ZVRYR1NuSTJWd3JLMU1rdk9BTzd3UkorN2RETGp1V0dXc01idk1DSEFq?=
 =?utf-8?B?ZWdkM21USmV6R3NLbzVkazJnRysrSlNKbXRBSVFDai9VQndnejFCeHZEVUJV?=
 =?utf-8?B?OGZTWHVTTnI1S0RrNk1MS2dsSE5LL0ducXJ0ZytnNEV4Uk9seGhLK2RVK0M5?=
 =?utf-8?B?RGpsMGNxdXpKWWJqM094bFA5NEdRZVpITXNrRjdGV0xKeHd5b1luc1IxR0U2?=
 =?utf-8?B?VGVvYXE5OTczS0s3V2VvU1liZlgxcytjWVJTREhRVW54UkFoSmVaRHZ3ZzVu?=
 =?utf-8?B?WDVlTU5mTWJqUEhlZHZzY0YyZVNYdjJEc3hXVHY3QzYyRyt6K3NxREhkMXpY?=
 =?utf-8?B?Ym1jbk53c3ZDZU9LaDBOMVUxaGI1QmtQbDVUaHZiZjE5bzZDM1YrbzZRVDlC?=
 =?utf-8?B?dUM5bjVBT3Yza3VGSnlOY0tXOWh6bTZtVGQ2aHlPNVBlbEVPRjVEaU5EQkZp?=
 =?utf-8?B?T2M0TGJRVGhwQnVQeU5CSlhvRktPQTIvS1JmVzNoeEJSMVZEa2JibjJpODBP?=
 =?utf-8?B?Vmc1UTZQMVMvbE9MOG8yMEhvckZYSDZkOG9TMmw1eFpSOUhlOTFOZ2xCQ0R6?=
 =?utf-8?B?d3ZCcmZUUHU4ZVA3WDVTUjk0Y2p5d05tMFl5UlJaTDF1b2hwN2QzamplWDNE?=
 =?utf-8?Q?3NHMBXfLo7ruIYW1rg2oWtN+vmQZ1C6o8JA2S?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5666e5b9-39fd-4361-5d61-08de583c00d8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:53:07.0540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6k4xsLTiUQ1yNSFC0VOJ39aOYy+af+FTG6RdG7Oj0KT42k8JZh+5xpAW6soCjTQrnbyQIjN6mwDHSacaJ7D3hWluuPNYnQsIWnMeSHBWqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12112
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

Hi Wojciech,

On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> Test pkcs11 URI support for UEFI capsule generation. For
> simplicity only private key is defined in binman section
> as softhsm tool doesn't support certificate import (yet).
> 
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> ---
>   tools/binman/ftest.py                         | 53 +++++++++++++++++++
>   .../binman/test/351_capsule_signed_pkcs11.dts | 22 ++++++++
>   2 files changed, 75 insertions(+)
>   create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> 
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 21ec48d86fd1..a005a167e414 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7,6 +7,7 @@
>   #    python -m unittest func_test.TestFunctional.testHelp
>   
>   import collections
> +import configparser
>   import glob
>   import gzip
>   import hashlib
> @@ -7532,6 +7533,58 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>   
>           self._CheckCapsule(data, signed_capsule=True)
>   
> +    def testPkcs11SignedCapsuleGen(self):
> +        """Test generation of EFI capsule (with PKCS11)"""
> +        data = tools.read_file(self.TestFile("key.key"))
> +        private_key = self._MakeInputFile("key.key", data)
> +        data = tools.read_file(self.TestFile("key.pem"))
> +        cert_file = self._MakeInputFile("key.crt", data)
> +
> +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> +        self._CheckBintool(softhsm2_util)
> +
> +        prefix = "testPkcs11SignedCapsuleGen."
> +        # Configure SoftHSMv2
> +        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
> +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> +        tools.write_file(softhsm2_conf, data +
> +                         f'\ndirectories.tokendir = \
> +                         {softhsm2_tokens_dir}\n'.encode("utf-8"))
> +

data is already in softhsm2_conf due to calling
self._MakeInputFile(f'{prefix}softhsm2.conf', data)
you can simply do the same I did in testFitSignPKCS11Simple and append 
to the file. Or you can append to data before you call _MakeInputFile().

> +        p11_kit_config = configparser.ConfigParser()
> +        out = tools.run('p11-kit', 'print-config')

Please create a bintool and call CheckBintool so we can skip the test if 
p11-kit isn't installed. It'll be a bit awkward because there's no 
--version, --help, to print the help text but not have a non-zero exit code.

> +        p11_kit_config.read_string(out)
> +        softhsm2_lib = p11_kit_config['softhsm2']['module']
> +

We probably want to have some try..except here, or a more forgiving 
.get('softhsm2', {}).get('module')
and fail the test if we don't get a path?

> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf

This is wrong, you'll be messing up with the environment of all tests 
being run in the same thread. You must use the "with 
unittest.mock.patch.dict('os.environ'," implementation I used in 
testFitSignPKCS11Simple.

> +        tools.run('softhsm2-util', '--init-token', '--free', '--label',
> +                  'U-Boot token', '--pin', '1111', '--so-pin',
> +                  '222222')
> +        tools.run('softhsm2-util', '--import', private_key, '--token',
> +                  'U-Boot token', '--label', 'test_key', '--id', '999999',
> +                  '--pin', '1111')
> +
> +        os.environ['PKCS11_MODULE_PATH'] = softhsm2_lib

Same issue as with SOFTHSM2_CONF, you must mock the environment and not 
write to it.

> +        data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
> +
> +        self._CheckCapsule(data, signed_capsule=True)
> +
> +        # Verify signed capsule
> +        hdr = self._GetCapsuleHeaders(data)
> +        monotonic_count = hdr['EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT']
> +
> +        with open(self._indir + '/capsule_input.bin', 'ab') as f:

Please use self._MakeInputFile() and prefix it with the name of the 
method so there's no possible name clash.

> +            f.write(struct.pack('<Q', int(monotonic_count, 16)))
> +
> +        try:
> +            tools.run('openssl', 'smime', '-verify', '-inform', 'DER',

This means you depend on openssl being present. Should we maybe do 
something like

openssl = bintool.Bintool.create('openssl')
self._CheckBintool(openssl)
[...]
openssl.run_cmd(['smime', ...])

to skip the test if it isn't installed?

> +                      '-in', tools.get_output_dir() + '/capsule.efi-capsule.p7',

tools.get_output_filename('capsule.efi-capsule.p7')

> +                      '-content', self._indir + '/capsule_input.bin',

Reuse the path created by self._MakeInputFile().

> +                      '-CAfile', cert_file, '-no_check_time')
> +        except ValueError:
> +            self.assertIn('UEFI Capsule verification failed')
> +

I don't think this is valid. 
https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIn 
states you need 2 (or three) arguments, only one's provided here.

I'm assuming we don't need the try..except since the raised Exception 
will just stop (and fail) the execution of the test but continue with 
the other ones? Can you check (locally) by purposefully using the wrong 
key for example?

Cheers,
Quentin
