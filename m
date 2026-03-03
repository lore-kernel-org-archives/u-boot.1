Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFECEC143A
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26A1838BB;
	Tue,  3 Mar 2026 14:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fe2b5yQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D0E83F59; Tue,  3 Mar 2026 14:00:49 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC4C8063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvJU2WumP1fcJTQ4wsSOa+O3NUj/nnvXXoG49S80SjDNJWEWy5Y7LJO+Tjzea8fhmaXln7VHo+8fx5izBX9kDb71KxkMt3WLG5T5TVXCbvNipi3MukHntbJuvcBZbxEq5BWqGVqz2YZQGR522EiwVn8SkjRxvJ391Wgt+1rdJtX28W66ICxvJqblzSKUv26WJGAGDCjD2l0q8gP/AZm3QKH2ha2IzNJqaXjqKsyUmVQ8yGGUJpiwdrtg5STeLe2k7RblZ4a68L2kFgjObpnhiXyqwKVY9LIYFBiY4QUaw7ttpU1TTUhfW1B8kOHK0UraUCHNiI0onF9POmqGQigYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX7Ea5dzWjF5o1TRUwvuH6Gk6otfxAk6OXvxcDb9O8U=;
 b=eVjfD+KUERETzYWoIls8eAIPlLj89KlaBDULnahUor2IdS5ICQ0Z1EA0k99SyZjtH5kBf4BbGyXTkhODRdAWzAav1d0+M8XBVLxM8d1bLEijvfbBOn544zeztAODRlv3Ulj3mMcvKH11E49DfAGLbZGs1jZn2JUYkz2jIPr+3U/kSKc7AwLVepTD2BJkHLPAyCEX3tfvyiNYkYsT6ef+9V/b60ab6WOWpArrxesCaacoDnS+s5GiL3qGcWWTyqwdxdADV1Pokg21HeA5twiKJIC28fO14kKEyhzPadKw4qwQFp88PELwqcr/rECuJCDprFPvBxX0FqJC6HWQyCS3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX7Ea5dzWjF5o1TRUwvuH6Gk6otfxAk6OXvxcDb9O8U=;
 b=fe2b5yQiSaCT0n7HuTgoEfCZjWX6US6pUTow/l4qAfG3qN68e3DEwLC6mbRz2gEQ18zszIjuA+XiQLEJHmRary2JmLXu5ED8lwrtL3GWcLnLlJD93XGFBO4RpCX0YU0xOII74BOqcTfkVM7bUiBnVfAcgjz63iql64IL+nyJtM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7580.eurprd04.prod.outlook.com (2603:10a6:10:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:00:45 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:00:43 +0000
Message-ID: <e4aa480d-353b-4a86-8dd0-19e0a859df50@cherry.de>
Date: Tue, 3 Mar 2026 14:00:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/16] binman: test: Move FDT/fdtmap test files to
 test/fdt/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Moteen Shah <m-shah@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-6-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0470fb-0e9c-4e3c-dac2-08de7924e12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: zsPfdjbZJG2VuUilyLyb6NKFCkIr/z61BVtc/Xx/5Kyi6PZR41cmA+CuHeLjwKDE+0pFrH4D4NbzTsinBXdIMSiVWlZgsCutsR2ngkFc+LwncZcYGS4MZxg35zEb6+bQBn/F5VE/yt/tyNfk1zT3PpXFLnCdxkAC7JPjGkH9BvC0zDkGKi6PbWdyYirx9iCWCv02OxCT6Wsn3HX9fDaN41DbVRXUqJTjGkxSrLCBfS85V6sxJNJQqrkPi+D8I9P7bPL0GHEVEO/0xY21Ditk4Zn90WxMCMrQv0hs0alfORwsf14HmsEEC2RhevfAf4mBt6xPrsFB7lV+JGcP1pxI1Q2huJYzYdMGnVpEGJeRTkW8fR884M047wxv81btMvlv25IUs8yu4iSZbtRHioR2vkMbv3+xYiucm37th/BNIvlV1Cx0oQWEwFgv1x5XZNrerocacxVC89AIvLyDrJmabr6PHAKHZGrKtubPfsKq89EZiTkPeTduY3jZk70sbLAX5a+CCMQHdRENDNwJh4MzN3JlX/5AS8Hg9eMHSLDSSo00WQgo1pbr8i1JpdtfBFLUkjuv9aoQDmlDM+mdrdb2JtAi1XXF2Hz7EHf3YRSMbnbJ3VsWODKmw1XlRjF9YQSGv/DJbvFSvmeCNvok/6dR/UbYx/lRc4K7oltbA9SejgXoM4fkpUDAsbtsL0v6a8Ztv7nsfobELbA5hLcU8xB75a+D/mwR7N0TFKRhAYcKTV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEp3dWx6RFl2Vmtvb3RjbFY5N1NxY3Nkc2o1ZkxheUdvdlRQVnB3ZDd1dThm?=
 =?utf-8?B?MmV1RlRPSndYMEk2MHFudkt1a0VtMTZkMk9OS2dLVE84Q3pzZis1WDZmbVp3?=
 =?utf-8?B?eXExODhBNkNBcjM0dCtPbkxKQ0M2T0xabVFwcm03TkV5V0tsSktWbFdKV0Zu?=
 =?utf-8?B?VUQvYkFSQWxVTU13Tit1Y2ZhMXN6dEloUTBxSE13UGkwaWtOME9vTUcwa0Fo?=
 =?utf-8?B?WVg2SGdoanRSU2RQcytWQ2hYRnJvSDFkVWxwWTRWSmhSSjJ2NVlFUnNST2l0?=
 =?utf-8?B?cDY1RWpqWVM5T3p0M0lSR1AzU0lSTndKTjdxQ0g5aHRkRVdnV3JrNkJHdkdI?=
 =?utf-8?B?N0liZWFsSGcwZ1ZtMy93UCtqLzBseWpWT0hFZXJPeldseGwyQm1lbU80RjI4?=
 =?utf-8?B?VXdmVWdzeWQyOTZCVGlmNm43Z1Bla0ZTeVd2amVscUlWdkhpT093V0xqODR6?=
 =?utf-8?B?b1EvRkY4OTYxc0M5UTcyenhSNFhMTWpqckw3bllaOVlKWTYxYWlZOUpWTXRp?=
 =?utf-8?B?ZC9GUGJuVVVpNFhMZGFLZEFIQlB3L3d6TU50T3VsUUN4SFcxM2wvZkNPVlo2?=
 =?utf-8?B?ZytvUDYrSDNrTjVobTdySXlWVkY5TTlYUWV1bXptajhHMGZMT05iRHgwWHQ3?=
 =?utf-8?B?YzFOblNwb3JpdlRsZGljQzZBS2luMzRYdy9NZ2xGcHdHdUd4bk5XZXoyOWNW?=
 =?utf-8?B?bFNUaGtZSXp2ZjNHYmM0N2hBRjN1cUs1TDRUYnRjRkZpQ015aFVYbnNJdTBK?=
 =?utf-8?B?KzJmKzA4Q1NiOWVycWdsZFlYM3c2UjF1RW5uRnc0ZDI2aFBzc0JxWnhTS0M4?=
 =?utf-8?B?ZmRxN1dhTmFzWnRyVm1Va2padmZ0VENDeXhUem5wZGJ3dm5QYmlydXM4WHBy?=
 =?utf-8?B?QXhrUXB1cEREaDlRUHlucUw4SzVXaXVkdm0ybVYwbXRNYTk2d1ZEd2N2Z0ZL?=
 =?utf-8?B?UVpFZFVVa1ZHWGN5VG9wSEhxdWZ0a1hJL3AyNkxrNVdrV1FGVVBURG9xc2tq?=
 =?utf-8?B?N3M4c1ZwcVdORFZueXRzRUdnYklTWW9KTmorL3daMm92OUJtSHdEcjNWOFFC?=
 =?utf-8?B?OU5iQUgrTk5nbW1wWHhRYTZ2UU1sc3RVTmp4SjE3MEtibFNnNUQxNmJ4UU5t?=
 =?utf-8?B?UUlHekNaUldIbUJDRnZoVEhuclR6OTJkTTRhMmFTeEtGVXJLODZXS2NpNHRI?=
 =?utf-8?B?NlBsQmNaVHltMlB5eW05Z01TRk9rOXU5MVkzM3ZIVUlxUU9MTXN1bSt5bzRR?=
 =?utf-8?B?RytVR0tkdTM1L1pQTHZRZFgzYXBUMGhXUnZxWkRhWTJabVFMNDlPdmY4cE9w?=
 =?utf-8?B?S1ZJaTlVYldqckNxRnByYVJJdCtuQjVHcFB4NWZFbEJRTW1aSmJQZDdoNVh4?=
 =?utf-8?B?TFVNSHVya3M5VDU2cTRsenFIajk3d3Z4cmFmRG5mVmV6WWd5b2pNY2plQm0r?=
 =?utf-8?B?OC9TT0UwVGtEYWc3TVNYOGNGUDNKL1ZJSzltWU04T3pXZGdieEMxaTVFOGNK?=
 =?utf-8?B?akFRMWJQdStSdGhJNW5xblI3QzY0REZueFZjQmpMQTAwZjJsMEJmWFJvUW4x?=
 =?utf-8?B?ekVaTS9ubXM3aUpXeXRzeC9CRlFWNWdJOFFTSGNXamRoTVVxcWVhOUVsdzhC?=
 =?utf-8?B?Qi9ReWk2Tm5Qc0tab2F6TTZwd09Jd3ZxUHNkRmJTNlJYVkZDRlBYSklhSUxN?=
 =?utf-8?B?dlVZRUM4VUhHLzFSWG9Zd1VJT3BVUnlWajhhZ3pIZDBDVGtVSHdUS0xIR0ZF?=
 =?utf-8?B?b0FrbVMvMXRQMTlsUFdnQW0yMTRiT2Y1U0tTOWdFTW4wYjIzRU5seGlVN0tk?=
 =?utf-8?B?SGNJdWtRcHFmK3R4NkRIbjBVcUF4KzBhQ3FhOXJIR2dOd3BIYTAyOStnQ3hq?=
 =?utf-8?B?bldsdDhucmRMWkJzQ0RrdkdDM3ZMSHI1NUw5czVrS2tuMUVuSkhuTDdtTEtS?=
 =?utf-8?B?TVdkR1JQSUZrK0VkMHVuR012Y2RXR0lLT28rZ1UwMk5yR1ZUNUhWVmlSNDgr?=
 =?utf-8?B?T0thbFhvcnpGWHZjUkRJTXRTajZZYWFrb1BXOHlGdzBmTlYwNWd2eFVxOHZn?=
 =?utf-8?B?UkE1YWltYUVkcFgvU0RvU00xcUFXL2swaUM1cVJJMHlQWC9INTNjcHN4Y3h2?=
 =?utf-8?B?WnlxYkJsbWp5RUxvZ2Z2YU1RRjhnUEsyZXRqamlzdEQwTGN2dXgwNCtIc3Ay?=
 =?utf-8?B?MEQ2bXQrSGdZOWFKNkI4aUxCRWtraFhwazI5a1BwSGtDZHl6QXpCWGNqcW5W?=
 =?utf-8?B?QWJ1cXdyWVBhanRiVGlpUUJHeFNzcHZGbjhRVkxlYy85WUlXRC9RdjNPRUlR?=
 =?utf-8?B?NHNPWnFLS0RlZHpQYzBnaUh1b1c0MklFbCtmZW5RWis0WFJRYWp3Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0470fb-0e9c-4e3c-dac2-08de7924e12f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:00:43.8515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XOdrNU53Pz6AFO7x8IblRKJB1tU88oHolsn77n/KbO8eMaTV8cLhj72YFty4gTvmBGF4ocbU/9HljekiQ7t1a5QreTKaIEW/XQyVm9iWXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7580
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

On 2/27/26 12:47 AM, Simon Glass wrote:

[...]

>   rename tools/binman/test/{214_no_alt_format.dts => fdt/no_alt_format.dts} (100%)

I don't see this file being used in any test. 943bf78a48ac ("binman: 
Allow extracting a file in an alternative format") introduces the file 
but I don't see in the diff where it is used?

If it's not used, please remove it (in a separate commit please).

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
