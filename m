Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4555C369A6
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B01382C55;
	Tue,  8 Apr 2025 16:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H5DnPLV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB8582CAE; Tue,  8 Apr 2025 16:03:16 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75BBA82B7E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zcm9S2DIFrIN9dBJd5sYOJEhIrPEdONtrdLsn5cu7dUrPP3mVJCcrqyQe+aq5mIka4EE6RKoJyGEk0wcz9s9KurS7VhrJvB0jzf3CGEBLJ0xUsCPVV5Ylr609xM6g8JBG0d7us6EJhQdrqFHkVDXdsQnc9NWfp9cPw69WfjX+2+MEfl9RUJ0MMXtrSgKMqZAxqgaUBbUSr0/aLt9t8PcY+ozGeuhNfMdHCIJ0aiZPvhYkBxgPx28XtWqxNqOS5oNzhmXuFIBoKE5fXx6QO6zaDq4WzpP+XX+4HgrGFncE0TCvUZKkm/S7OAsORyTXyKMTXcV+OVCUwq7z2pV5uE80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAoUl8qOPzL43Pyg94WHuX+V2Al317Nll7V/+PQMO2Q=;
 b=JBqdGThzaK2ofNHomDugAE6dZnmnWn7/JBm1HpLtMD9RvYqRsYF4hnD1II9kIgTChMtgZ2EcxS69TTDZhyuwesTT/JFAqh9DF3ksj+SB198UDBO+NM3SQ/AZikil8nPOqCxsND7UKfOd6L7lsmoUSGRIfuxXurfsncHNcO4gmwo8ZkRl1uYDzeTUW2g+Ujp2e3s7c2D0nMUGZWOB6jPrD++YeRjKmOkBswZjjjhmNPCEOWyFHJRHh2c647/5XbCHFRnru0Uqa/9ZLk4Mwo9vx+DTJWVXSUuhgwK8ilTPL8XlmIyB9SbGs8RS43zeyofl9s6C3XpF6l/CGSVKjhZkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAoUl8qOPzL43Pyg94WHuX+V2Al317Nll7V/+PQMO2Q=;
 b=H5DnPLV8g7tUZKZNzRmjtWpy9gq8RRLq6j/4ScbQCSPcn4IvmxQnqz6WwQGFilw+yQZRj/N7f5a0k9+HbhMTeGQ8pd3QZCQwu+DjDQBly6P3NXD8S/Ou+SMg4fxufaUfo+WxBSSaYQ+5hOIr4sJhO0oWNSp7vjm42KRXsGUEooc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7555.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 14:03:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 14:03:12 +0000
Message-ID: <484017a4-956f-4b1b-bebf-cab6dcfa860e@cherry.de>
Date: Tue, 8 Apr 2025 16:03:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: release_cycle: Use variable substitution for next
 version
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250408135421.1393991-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250408135421.1393991-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: ca187d13-e62d-486f-05ce-08dd76a61979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVJIWWhuTmJ0ZVFpRHoxUUx4OE1BdWZFMDNZMFVKWmFQNFlFcmlybW9nZklu?=
 =?utf-8?B?TmVuMFlwOHovRVRGME1sVER0aGl5cUEyK3JvQllwQzViR2szeGJlU1hVY2th?=
 =?utf-8?B?RSt4S2Y4bDQ2T1lyRzAycklnZkZIUDVmNHV1WjhUN2xkQjZXUVo5c05xY09U?=
 =?utf-8?B?ZmRMSTNzdXlPM0FlcFZodXdzTm9oeXQ4UVYvV0JMUG12UUxudldBTHIyVlp6?=
 =?utf-8?B?SEIyNmIwQzZ4blFKK3JqOFhlRHg5VFpUMXVQVS82OTlQbXBQM0h6MDZmbThu?=
 =?utf-8?B?SmFwL2JhN2hWUHBRTXNVZTNIcXhvSWllOVFkbk4vaW9iWTJKODBHYXRtZ1Zy?=
 =?utf-8?B?aVBMd2djWDhIamV0dDFSS1lzWlhDYzBuNXZIb3czYllCaEZ4c0kyQTZrbFFv?=
 =?utf-8?B?ZThDZm9KN1hNdmxCcjVqTUc2c1pjMWtjbVM1ZGIwV3lidFpkWjZhdUNBYjQ3?=
 =?utf-8?B?RnlROXd3cXZFOTNSdzQ4M0taVkdhZktjcnprMUFCazQ5SGZKaDhZOWlDQTMx?=
 =?utf-8?B?NS9xVVRnaGNnOEVub0tzSjFDSTdEZ1ZEVmx2RWY1dVQybk92cGd2ZFBmanVj?=
 =?utf-8?B?WldKdG1ESXJWQzV6VzJuWENmY2FjOTZFcTk1S0o1ai9LODgyeHBxQ2JJNHlU?=
 =?utf-8?B?VGc0T1p0UnZZK29GOWxENTU2V1kvdmhldkNSaWs0SXBQMy80R2FVQUJwdVpt?=
 =?utf-8?B?Ritma3ZYY1YxTkh5UDFNdWh1ZlF1clVIRHdQT1grM2RjamdqZGxLUnlTR0ls?=
 =?utf-8?B?QnFkVDZibVNQajNadmtCV0RrUnRtM3JzT3ZIK1JFOVBUSUh0cEx4Z1NUcHZo?=
 =?utf-8?B?ZFJKQk1DKzlXUklMZUR2RmR2NXlKZjljVlNpcmJESVBvTGVwY2MyaXdPM0pE?=
 =?utf-8?B?WVA0d1V4MXV1YS9XMWdnQ1NBQTFWN254Q2dLQkZXZnFSeVRKNFNwb2kyZEJB?=
 =?utf-8?B?VHdwcy9Vb0Q1djdPclpRRmFaSTlvcE9UanN2b00yV0l0ZFJWcmN3SzNiZlpB?=
 =?utf-8?B?NzBLZEdsNjJZNklhdmE2a3hjUzYwUnNkb1ROeDFvaWdJN3J0amlCN0VLVlda?=
 =?utf-8?B?TGpEZHdJYXZGMC9zYkhvRXJYUi8yekp3SHpOTjBLd3NNaDIwQWpxQXBza0Fh?=
 =?utf-8?B?cW9iTURkQStwenBmQ2M3Qjc1eXRhdWk3cjRvTytCWXhNZDIxRTFIeUQ3M3Ar?=
 =?utf-8?B?V0xHN2dHK1JtNm5RZWxSLzBDV1Jud2FsbG1vdFMvUzFDSTd1UmpkR0VqbEVp?=
 =?utf-8?B?SmpWVmxScG4xYjArNWlnSWMvOHV6dHFKZkk2ZlVldUlTZi85ald5dzdsQVRU?=
 =?utf-8?B?NDhZTCtUSGdmNmdoNW9GQmF6bUxKRWw3ZUxVeW1SU2p2cmN5dEVyeDVOTnhs?=
 =?utf-8?B?QW1DbDlPOHRuczEzeU52ZlRpUUE4UW0wL0Q3TnZ0MFJlcGgrK2dGZG1ZM2lv?=
 =?utf-8?B?TjNtQkxpYWc5am5EMEJwNzFBcFN2Q01OYzV4UDNYS2ZSM21YZWYxUDFyK1ZC?=
 =?utf-8?B?SGhyVkJuS0s1Vi83Vy9lSE1MYUFFY09aZUplS0pFbGI2OERMRWFtVWxzWkt1?=
 =?utf-8?B?dDZPempXY1BBc1YvSUNWbkJ1eTJ6YjA4S0NhQkhBVDdkdEdzT3JudVgvaGNk?=
 =?utf-8?B?NEJtaUE4ME1OR1BJTWwzSWkrSlRJVWt2VVVMaUMvQTZoZ2ZZWEVBQWJRekNE?=
 =?utf-8?B?UTA1NGVCc0xMdVlZRmtxNDBNSVZTZE4velEwZWUzNEJpaStXNktOOTVDQUY5?=
 =?utf-8?B?NGJKSlhQOXlRSE5xdFc1ZXRTSFRHOUxIbWVDQ2NIYW1lSnRXWUtPVW9tVnZY?=
 =?utf-8?B?c3VaTTJGVnVjZkQ2NkVPYmRNQ3QrUjhiZWo2VjdXT0s3bHV4T0Rsam9PUzVi?=
 =?utf-8?Q?9TI5O/TwuBZCv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JBRW1yUEwvRnlIaHZVcS9DMHYydFoxKzc2ZkNWa3NSNjBscGZVVWRSblRH?=
 =?utf-8?B?Y1pwNW1YcnIwNGRzYXUyazh2SjRIV2UzSXFHWFpQNEVVSDEwMjNra090OHpY?=
 =?utf-8?B?alZOYmpnV3huZXdhdThYbzlCZWg5ZE9mSllHYUdEa3prd29Va2ZTOWw0WTVv?=
 =?utf-8?B?aDhPaHRTeDNxWEpNRFcxYXB4MzFrOVdoend3S1dnRXJ1bk9UWE1MQXV6a3VI?=
 =?utf-8?B?bVFhejNMLzFOVDlvdVQrZStUR2JENWlTQUsrYjBZbVFncmVYbHdBcUNpbHVp?=
 =?utf-8?B?UDhOVG9LSFM5Q25NZjViL0IydjBMNDR6d3VNeWFqb3lhUmIvd0hRa05yZS9s?=
 =?utf-8?B?aWxOdlV4cnBldTNRY2p3RDdrVmNueVVYWHoyYXBPdXcraVFQNnoxODRESzgw?=
 =?utf-8?B?QTVKRlh0M2E0L1lad2hHRU9ZakloY2w1ZHZ5TG16NklhbTFySk9iNW50TTVB?=
 =?utf-8?B?N3VUbkkrRGdJSGhFdkM0MzZoQXhKUnd6cnJzQnlVakZmTi8rNVRHTko1RExH?=
 =?utf-8?B?M2JLNlA3aXhMVzgwZFdTNTNaUHBqZVNWMmZFMmdUNHNaZlpKanpJakZBM1dl?=
 =?utf-8?B?TFZiOGM4R3VyR2M4c1JWYWEzaTVJdHFKN3QxZnFGNkU5V3lmVm0rQTJIdzlx?=
 =?utf-8?B?N2IyT2NrVC9zcXRaeHBnTGo0R0NSK202ZXRtUUVETE1EdUs0L0w0dE5kbmNR?=
 =?utf-8?B?bGJ0T0Z3dEsxdHBPUzJ3NFNHa05zQlJxMFUvR2swUTd3UkhQVGlWTzBpNlNl?=
 =?utf-8?B?Qm5xL0Vua05IYzJYbnRGYW9VcHJ6U2ZxRlNNVEd0TlZqam1nY0tVYmRFMXdj?=
 =?utf-8?B?ald1QzFIekY3TnRJNCt5Qzl2SzFLaTNDOUwyZVNuRkFNVmlOTXFkRmhKVXBZ?=
 =?utf-8?B?VUVoNzFIZmlnNXRSdFdxeGJoeGw0NDJPZlZlRzBiVjFzOEFZWmVCN3Nnb3dk?=
 =?utf-8?B?aHNhMmhXdmNoRFdHbG1BSnlURWMvbXh3OGZvRjkwc1hsU2tqM3pUUTI1T1V4?=
 =?utf-8?B?SGVSTVUyQVJNbzVOTERmSmJsSTlYUHErcHRRWVVLcHc0d2Qwclp4aDNWTUE5?=
 =?utf-8?B?anB0RG4yUWhkYlkyUk9IaEg0bmc2NFRpZjlTMStQYW5vODk3WnB3TndLY01Z?=
 =?utf-8?B?NXkzQ2pJM3ZPRy80b3NabVRpS2J3ZWV6ZjBCNStxYS9ybmtTRTNqc2lJMzYz?=
 =?utf-8?B?WXpsbGtvREpORmZqdGVBbzd3UXlyU0djTkRoMnYzR0dTOXZrTDBEK0g4RjNp?=
 =?utf-8?B?UjNCWEZjRTVKQ1RHT1ZGbGsvSjkyVjJ4NkFBdjMvT2NpbGc0aldtL3hCTlhL?=
 =?utf-8?B?bDY5aGdOTzhnNnM5VHpvTkZYdXpsU2d4WFZjQm9EbUxXYzd2UVhiL2Yzc1hE?=
 =?utf-8?B?OThNRjM3MGlxeVh5dm5qMWpLUG9XVklZc2NickorSkU0djVmZzZJWUdWQXBB?=
 =?utf-8?B?MWllSG0zVDBZRnVPUTEzK296NkJsNEJXVHY4UUpiTVB0d1NOQlkweUZ6V3F4?=
 =?utf-8?B?SFNBeDJhM1VtdlJTUFBMcG1YTEdpZ2pKaXU2enVFa3VOMTl3dzU4R1R6OWRP?=
 =?utf-8?B?dU1DbHVBUDI3NXFnRzFSc21URTZQcVpNcUllaFVjY0F0Q2ViV3RRRjUxOUVO?=
 =?utf-8?B?aURUSzhSL1VReEVnQndFRkdxS0E2ZzZUL1hSNnR2MmNXWGxoaXhzM3BEZzRi?=
 =?utf-8?B?UVUyRWtvalcrZ2ZFMzN1NndoeFFQZ2htVTZGamM4dTJFdFNWNUxoMm01RFVw?=
 =?utf-8?B?dzNIY2NFTzBNZ0VXTkxnQkg0djhQT21uSXpJN2ZWeEJkTldDMm5vZm9ZVFdK?=
 =?utf-8?B?MVBibzdxTGhrQUx1MXR1RmtGaGpIYjg0Mkpmb3lOZE1DdWwvQ1k0K3A4ODZV?=
 =?utf-8?B?MlBINURiQlZueTVZa3hycVh5WFFPazhtT28wTm9rcUpqdmdJbVkvZkxySnVh?=
 =?utf-8?B?ZHB3L3hKU3hJOTZWaWZubnR0REQ2QkdiTlRFZWxDMlNMVmluci9MeW9WaXdC?=
 =?utf-8?B?aW9wNjVWWE85eU9xeW9wNk82RzFiTFpBTE5rMDl3R2ZRZFBaNjlJTFcwMlZO?=
 =?utf-8?B?VW80Wno3SU1uMkwwalJSV0l3SEdSMndTOGU2R0U1VzBDN1czT2NwdE0yTW9R?=
 =?utf-8?B?WHBlT2wwTGc2WENweDYwcEovN0xsWkhMS1dTcXFIYll0Y0VMNjFkamtRc1po?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ca187d13-e62d-486f-05ce-08dd76a61979
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:03:12.2363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +L7s1P8aLs3x7ZoeE+0/SoJMRFxVf0BiX5JLRLZMDhhhgzDC4dbpMQ0ziZqPYm5Poo8aT09mR2TXh8BvpmpklSyqvOxNkj0MNBlC3gXQ340=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7555
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

Hi Tom,

On 4/8/25 3:54 PM, Tom Rini wrote:
> To avoid the problem fixed in commit 57a95d522ca8 ("doc: release_cycle:
> fix next release version") moving forward, make use of the variable
> substitution feature of rST. This adds a next_ver variable and
> references it in all of the places where I had been listing the version
> being worked on.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
