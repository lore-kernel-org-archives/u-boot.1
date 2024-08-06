Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93230C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C8C88A3A;
	Tue,  6 Aug 2024 16:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bowZRD6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8DF88A3C; Tue,  6 Aug 2024 16:01:10 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770D788A10
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAzjnk4v2AVrU2z84C+mn7V/YCAqNOlH6IFsaSmsbScw/qXQcrSIJbcVSHyGFOeAPO08PYiStns6xikfm7MBsatD7sIAlqij4GaD6XvbF12PiIFKRKsGsDuhfjXWHD7n2hlDyN5YLIpiN1dJVCobDLmysT+cJNr3UJyQI7RWdMz5V7rTaJbz8kThMzT3JQMrdQcbT3vHodJvHKoqiB3rWJyunCMUlPQiqrOhJzwu7sf/g04szm0uWV7k2j5oOkQfBQfetFjeyeZP0vzgGROs1Lw96MnYctGRREx6Jx14wcyt5CSBSB3WOaUuxnSl9IhrPq/8rzAueHyu/TLaPHsxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUuWpi31+Pl3HxbOYUPfTHn78NUd2QqN3EpSMICC3gg=;
 b=yAO1zodYcdJmn/+u+xEb7r1TEUUWPgCk5j7iu7pwqfknDqhMptcOaIRsCQR/lCeBJAiBRSXvWCma4uS/ZviAgT4COb1X1N9tCwpFI5OZ01SRm1ZaPlaghsidQG+ewJPPb4Z0PgOuh5E94U/sWD0fgM0bbUZYf7SfE3MxIC7ahDdWI4lO9kL1YKtgPmS8++l++hw093obXJ0Bn6ctYpZvwM4EHzjJoUqCFEScipbqo98F6c89HavAi9uWUOU4c5m9QztnCBFwIf6Eq62JhQLVIWejWf4l/7nS0rpb8g569dr/NEHCZGW2dYRzifS/jn1auPsujzgWbSdrR3h4gebWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUuWpi31+Pl3HxbOYUPfTHn78NUd2QqN3EpSMICC3gg=;
 b=bowZRD6ZSiQYULjivxHnv8TdP1A1rWmoiL/3JBjGn1ZnBAxOWrGPBhwyoPI2FoTb/F/MOd6jeib/CnEuN64sks4p6RrlmDIKhMnNZ2705tKMHItYurYQBMJaEiOsC7MGjVsN73qimq57ZwzBT+x7lATa4p4/ONyvH5qHsokRuqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9724.eurprd04.prod.outlook.com (2603:10a6:10:4c2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:01:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:01:03 +0000
Message-ID: <3b1daa72-5259-4b6f-af5c-053d03dbf4ad@cherry.de>
Date: Tue, 6 Aug 2024 16:01:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] mmc: Use logging instead of printf()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-6-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0338.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: ad28e051-0eab-4181-4139-08dcb6203561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDdjU2dWRVBkTU5NYWhhcXJCekdJNUlCZDZNb2U1cnFaRXNHV2VGdHJrNkVw?=
 =?utf-8?B?d2lVTDFSVlpjZ3ZlZ1lJQU1kNjZ1SHZEVnVQeEtrNlZzblZIbkZmOVFZOHJ0?=
 =?utf-8?B?VU9BZFQwTzI3MjFrN0JWZEI5ZHVXckE0NDVxa3h1N0ZEUUtzeDZFVXpXZVRO?=
 =?utf-8?B?My9lWGlBNGl0VW9iYUpKbjV2a1d1M0Vla29TRFpZazBFU05EMjR2VG1uTlVQ?=
 =?utf-8?B?bERTaTBJaUNMR0xCZXdlU2I0a0xxOTNsejUza2Jhbk16WHBQNlozYWJQWDhZ?=
 =?utf-8?B?azZJUll6TTN1eFc2dFYyWGhXdm5keTd6ZnhNRHVpM0g1b0tBOVlwdVhmMkVw?=
 =?utf-8?B?aThZSkFKTS9FSER4c0NSWHA3VnpDbnM3NFp6bXJOUStqelNETG4xaFFmUHAv?=
 =?utf-8?B?bks3SlR0UmhLYlkxb0RlYm9KcEZKK2NKN0xIRjFnQmxkc1JkQjBJSU1lQXZG?=
 =?utf-8?B?a1ZhUlFhdVZXdGNvdmt4MjZlZE4rM2wydDlaTXVGOXJGSXE2TlZSaHo1R0wz?=
 =?utf-8?B?M0pMSlVKUUN1aSt4UCtEMjZBajlrR1hHa3hSTzBxbE45OXArekIwbVl6RkVo?=
 =?utf-8?B?RXR2Zy9iaDdjN3pjU2cvdmpjdkZKNm1lVUJmeU85eU5wKzVkZTV5MGc3UnVD?=
 =?utf-8?B?SlhvSGlEWkFvUXNjSEI0alB6aDNEN0htSmtZOXBuVjJ6ZlFMeTBjbFdBZDg0?=
 =?utf-8?B?TEIyMzJ1Z255LzFMbUhVNUU0TE5YamVvSTFIbVNjaWtsSzdkWXkyVTcvdEFU?=
 =?utf-8?B?alN5bUJjSlFya3BZRnBCKzdWSWFseXhyblE1d2p4TmM5cEdMak10eFczaEtj?=
 =?utf-8?B?anlKVEtYTHJQaDFDL0ZRRFl3dC9WSnpJUU1YVWQvRUw1ZzdpTGhlYURwTCt5?=
 =?utf-8?B?TXFNV3Y3UG4zaEwrL3VGQk0xa0RZK21NTWcyQnUwRzJLZ2twUXVRdDRWYWpK?=
 =?utf-8?B?dzhVbThqMUJqRVdLb3VBTjR0aVduUTJzb1g5QjFrQ2g0T3ZVOGl4aWxKcXA5?=
 =?utf-8?B?UWRrRnMrUHgwREZ3aUVYYzlQY0lOTTR6eXpiM3dXTWNIWHNWc0FWR1NYY2Rn?=
 =?utf-8?B?cUcrMUNHSGJOMWtnRGZCbzBBM3BNMDZYNkxURTY0QU0xM1IwT0lZenlscDRK?=
 =?utf-8?B?bzJVKzRjTXNFazJrWUo4VXlhbENzdkdkczJqWllwS1hTZVhxNDYwS0oyalQ3?=
 =?utf-8?B?R0loRTh1cGNuc0syR2UwNnROcXEvSmlXcTdodjRpWkxrNDVFQjk0eFNRVEhx?=
 =?utf-8?B?QzVqaG4ycys1MHpCTkhFREhrVFdyRVlrMmJVZmNaWFVNdTRZQ05XV2dqQ3Jr?=
 =?utf-8?B?TlUxZjlHeDg3Q0piaDBMYWwzbFBSV0N3a2doUnVxSjlkREd1dk14YWRRbit1?=
 =?utf-8?B?UTJra3hPQUxRQlJZUER0Nm1SYzhzZmg3UUdHY2N1OVpqSWNVeGU1QzhVTUtC?=
 =?utf-8?B?VVBBbUp4d0Rtcmh2dnZURGZjT1hMeGZOdWZGQ2lkZ2h0ckhFcm1UVHV0L203?=
 =?utf-8?B?ci9kOHd2ejVCcDV3L2VjM3BqaXVxdFVVS1pWWFVrdFhoenRUclg4c1VJbS91?=
 =?utf-8?B?akpFN2pscjF6UWpOaDhSQ3YyME5sUzNvbGNzVUxsUjdkM3c1TVo5MHRxUXVh?=
 =?utf-8?B?TkszeDJ1UzRuR0RDMHVUUHlmQjlZa21vbUlReTNFTGh2OUdiVDJnMVNESHk2?=
 =?utf-8?B?bU9YV2VWOEpKTGJ6dHh6bE4rOU5OTTdaWU82ekl1aCs2VWZwQXE2MFFYc2NO?=
 =?utf-8?B?dnZSRmU4MGE2ckZDaVlOYmZ2STBPTDZPMXJQckk2WEZIR3BxOE5KbEdBQ2s3?=
 =?utf-8?B?V3J3VjlvMHR6bHFjSmU1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2Z0NXV3T09UQ016UzNZczNISk9tUGR6RzRRRlNEdW1NTXp3cTRsTnZycHMz?=
 =?utf-8?B?WE9LOEJ2QUR5dC8yS0RBenVlUGpOcUdzZURVcXdQaENjdFZJVzFrNUVJZEhV?=
 =?utf-8?B?VCsyQ2VOMTlyTlNzUXhMaXNuTlgzVDFGZXhxRUU0QWlHWUxTZ2hTbVkzTWJi?=
 =?utf-8?B?cnJ2YmZzRy9vUkkzMUpNeDczWFpQZ1VKT1JKdEhtN3hTMGdya21CTGcrMmJY?=
 =?utf-8?B?dUNTeDR4TW9hMGluRndtVVp5SVRHYUphNWxXRC9XVXdMZEJmcldrNG14UDY2?=
 =?utf-8?B?WjlSYnYvazh0TXp0Y1V6N0RER2QzazJGZ0VpcjErNXh2aUJKVXdVcEh4Z0lM?=
 =?utf-8?B?SVFVSlpvTFhqK0dPZGYxZVQ2S3ZFNTRPS1hzeDloc29ITDZwc0xrQ1BQVEZR?=
 =?utf-8?B?d0pTcTNibWhkd2x4ZXFpckQ5SGx6cmpkR2tRSVhQK21MWEQ5UG9QZ3l6SFFv?=
 =?utf-8?B?T0hlVlIvZjROWlNib0hTQjhoR3hTUmh3M2NWZlMvbmozbkZxOXZ1WTN5S3B0?=
 =?utf-8?B?ZEY5Znd5RVhyMGFqTHMxWlp0RWR5eFU4bkVNVFlFdlRRRFJ0SlAzYWF3dzJq?=
 =?utf-8?B?d1dEQVpneHZmeVFmeVJHU3FtSzlrZG1mRjdnRFEzNHB5MGVaUWVtbTZsSlE3?=
 =?utf-8?B?SC9WZzRaaElIVGUvRno3QVZISmMvcFovOGpUVXQxVjN3amlkSkhVemozbklv?=
 =?utf-8?B?UGpsa0tiZFVVWnB4RVFSQXptNG9kdEJUK3Y3TmZEM0hUNGdSZlFZcXY5UzBN?=
 =?utf-8?B?VWpaY2ExazR4eGQxZVJnN0tsR25DbVhlQXdRcUQya25GSmRMWG56eU1VY1dX?=
 =?utf-8?B?TTE5NmRCdFF3RzZMekJTem5vdnFycHRTbkdyWWcyTzdrZ1ZobndCRmw3Yk1U?=
 =?utf-8?B?S2FtOVBBTENBV0x0YndTK3phZTVZVVphREVXaERCZHhraW1kVDA1ak9hRkF5?=
 =?utf-8?B?ck5IV2Y5RjRsdnpmMWY3YlNxaEtOc0psejZ0TGtnLzlDS3NVcmYwNDI4OWJH?=
 =?utf-8?B?cEVzOW5COWlJK3djbGFBUTZsRXU1cmE2Qm1obFo3OHNBZXd5U2E0aXdVM2VX?=
 =?utf-8?B?cENzcEFaVGdHWlNVMkplZnVKaElGWC9mbDFLQ2RFWkM5SjZiRjl1ODNaem5O?=
 =?utf-8?B?T3hXQ0tDTnJudDE5UTdGQmdTYlF0NDFMYjJvdVpHU3R3aFl3M1NBVnp1Tk4r?=
 =?utf-8?B?ZW93K2RMSVJsV29jSlhpbnlZV1dIQXhMTnRSM1oyc0FuelJycFNEQVRUWDhZ?=
 =?utf-8?B?cUZHMXAyNmlKalFOVGExQU1YdFhtY0pXcThEQzRBakdLdm9TemNzYkV2Slh0?=
 =?utf-8?B?QVpjYkhjY3RwOVBYb2dtRStZQVcycGUvMWhoYWhTYlVkZ1hkYmJsN01uTFk5?=
 =?utf-8?B?MythQmd1dm9kNHI5aHRHekhwaTk3SUtTMTNUbU5jenplTFE0WGxlT2hNY1ZP?=
 =?utf-8?B?dndyYXVWTWJpMWRRQ202SHN0cXBaNXR6YllQMVlmamltMEkwTHVvdkpIMG5K?=
 =?utf-8?B?STNCVnlCNWkvOHlUMURwYitPUERVTExZOXFhSEd0UEVVcFJUbHZVK2VJeEhO?=
 =?utf-8?B?WTkraktpTHhsK0NrdFloNVo2c1pOcHVqeVRiV29CR3ZkcGNrZnE5Vk9wNHhU?=
 =?utf-8?B?clcxaWd2OU54V3BvYkkrTXNsaThDWW5ubDlVazFlRzAxN2dJZnFMVXJlOGFu?=
 =?utf-8?B?bUk2eWpWNVZsV0k0Qnh6VWdoRlpZdDBkV045TzM4ZTZ6MDVnb05LSUorU29Q?=
 =?utf-8?B?MWVzRktuOUlPTE9Va2pYOVUwQnp3LzJ1SldSZ1ltUDFrZ0RvNUFGRWdNSGRq?=
 =?utf-8?B?eHVVanR0NU04Si85K1ZTU1RqNDVtS3NhWVZ6K1pPV3E2eGZoRXFLL1BuUnJj?=
 =?utf-8?B?UjVSTzJQWi9La3EybS9wQ0FXSXROelg2UUdRY09jWXZnYkxkdmN3RDMzK2V5?=
 =?utf-8?B?Rm1uRmRaMGN4Q1FNSENYdk8wRi9pOHg1NVdRbERqZlRDQ1VCdXkvS1JMSkFB?=
 =?utf-8?B?UFYyZnhXamU5anJHNkhTcVVZRkVCSU9iMUd6cmQzMGFUVFJSYUdOeWRHeHFC?=
 =?utf-8?B?MWxrM0hzeVJkS0dlaXFDeWNiMGVqUUVPQ0dBTkF5N2U4QXowUldKcHJnVVpS?=
 =?utf-8?B?K1MwLys4Y0RZTHBkcWtueFFZYzFmL1dESncxSzU1NFgvaG1GZnNyV1VSNGxq?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ad28e051-0eab-4181-4139-08dcb6203561
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:01:03.1902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2deIqMpipaFQYdkt2+Ms/886eCmAV/HflOx8LxsGxfmvwb34BQDyfwvKH/PCS7/DoTe1ob/6OAIoZaK5ZqgStvNK0dc6XT6D3E4HrQA1Fm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9724
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

Hi Simon,

On 7/21/24 5:25 PM, Simon Glass wrote:
> The code makes quite a few uses of __func__ which puts the function
> name into the resulting SPL image. Use the log subsystem instead, to
> reduce size.
> 
> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> 

If I didn't misread the code, I believe that __func__ is **always** in 
the image whenever LOG is defined, just that it may not be printed?

c.f. 
https://source.denx.de/u-boot/u-boot/-/blob/master/include/log.h?ref_type=heads#L196-L206

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Various updates to log messages
> - Drop an unnecessary cast
> 
>   drivers/mmc/sdhci.c | 46 +++++++++++++++++++--------------------------
>   1 file changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 560b7e889c7..eb5a144f8d4 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -32,8 +32,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>   	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
>   	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
>   		if (timeout == 0) {
> -			printf("%s: Reset 0x%x never completed.\n",
> -			       __func__, (int)mask);
> +			log_warning("Reset %x never completed\n", mask);

If log_* functions aren't changing the meaning of printf formats, please 
keep the 0x prefix to highlight it is hex digits as there's some overlap 
in hex and dec digits. This applies to all 0x%x that were changed to %x 
in this patch.

>   			return;
>   		}
>   		timeout--;
> @@ -139,8 +138,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
>   	do {
>   		stat = sdhci_readl(host, SDHCI_INT_STATUS);
>   		if (stat & SDHCI_INT_ERROR) {
> -			pr_debug("%s: Error detected in status(0x%X)!\n",
> -				 __func__, stat);
> +			log_debug("Error detected in status(%x)!\n", stat);
>   			return -EIO;
>   		}
>   		if (!transfer_done && (stat & rdy)) {
> @@ -173,7 +171,7 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
>   		if (timeout-- > 0)
>   			udelay(10);
>   		else {
> -			printf("%s: Transfer data timeout\n", __func__);
> +			log_err("Transfer data timeout\n");
>   			return -ETIMEDOUT;
>   		}
>   	} while (!(stat & SDHCI_INT_DATA_END));
> @@ -232,7 +230,7 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>   
>   	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
>   		if (time >= cmd_timeout) {
> -			printf("%s: MMC: %d busy ", __func__, mmc_dev);
> +			log_warning("mmc%d busy ", mmc_dev);
>   			if (2 * cmd_timeout <= SDHCI_CMD_MAX_TIMEOUT) {
>   				cmd_timeout += cmd_timeout;
>   				printf("timeout increasing to: %u ms.\n",

I would suggest to migrate this to the same log level as the busy 
message. Same for the puts(timeout) which is outside of this git context.

> @@ -316,8 +314,8 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
>   		}
>   
>   		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
> -			printf("%s: Timeout for status update: %08x %08x\n",
> -			       __func__, stat, mask);
> +			log_warning("Timeout for status update: %08x %08x\n",
> +				    stat, mask);
>   			return -ETIMEDOUT;
>   		}
>   	} while ((stat & mask) != mask);
> @@ -358,7 +356,7 @@ static int sdhci_execute_tuning(struct udevice *dev, uint opcode)
>   	struct mmc *mmc = mmc_get_mmc_dev(dev);
>   	struct sdhci_host *host = mmc->priv;
>   
> -	debug("%s\n", __func__);
> +	log_debug("sdhci tuning\n");
>   
>   	if (host->ops && host->ops->platform_execute_tuning) {
>   		err = host->ops->platform_execute_tuning(mmc, opcode);
> @@ -380,8 +378,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	while (sdhci_readl(host, SDHCI_PRESENT_STATE) &
>   			   (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) {
>   		if (timeout == 0) {
> -			printf("%s: Timeout to wait cmd & data inhibit\n",
> -			       __func__);
> +			log_err("Timeout waiting for cmd & data inhibit\n");
>   			return -EBUSY;
>   		}
>   
> @@ -397,7 +394,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	if (host->ops && host->ops->set_delay) {
>   		ret = host->ops->set_delay(host);
>   		if (ret) {
> -			printf("%s: Error while setting tap delay\n", __func__);
> +			log_err("Error while setting tap delay\n");
>   			return ret;
>   		}
>   	}
> @@ -405,7 +402,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	if (host->ops && host->ops->config_dll) {
>   		ret = host->ops->config_dll(host, clock, false);
>   		if (ret) {
> -			printf("%s: Error while configuring dll\n", __func__);
> +			log_err("Error configuring dll\n");
>   			return ret;
>   		}
>   	}
> @@ -456,7 +453,7 @@ int sdhci_set_clock(struct mmc *mmc, unsigned int clock)
>   	if (host->ops && host->ops->config_dll) {
>   		ret = host->ops->config_dll(host, clock, true);
>   		if (ret) {
> -			printf("%s: Error while configuring dll\n", __func__);
> +			log_err("Error enabling dll\n");

Is this really only about enabling the DLL?

In rockchip_sdhci, the function does a lot more when enable=true than 
enable=false so I feel like it's a bit disingenuous to downgrade 
config_dll(..., 1) to "enabling dll".

Also not sure what made you decide on the log level but aside from the 
aforementioned issues, looks good to me.

Cheers,
Quentin
