Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB12C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1951888B0;
	Mon, 15 Jul 2024 16:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W0LDJj1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A5E888B7; Mon, 15 Jul 2024 16:13:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 242B1888A3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQgGlYqr+RGv+TUPVjUdH9JbxbbEWJ9iFz9OqvKC0oO+6gp8F65cRPugp+VxHtal8GM6Bzgj9n3lhnf5cRdlI9xsA22MEG05xa2otoeEoxjp8DLiixMcUT9ZUddw4ZIKyNtoNp57mo9glWc3VL2QIKRxu1SoIVvrcztyChCKhrsD6Shs/MPqocDewb0UXRrusg/vWxPWgr7lPqaCW/4npHnlzOpVlKr8rRuH++0IEatelJ8csWLxjqBVVSAiws+PG//VfxSTAMaA5BF3LmJhV7jyGu2QLdknxyQQw/rIAUWPLdLH9+2xlUNttAKOSUzUE/B0OU0jZ1nHRdWPBLrkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fessw82mS+b1rhkWDfkT/9BORldWiET2tuHXZSC8Bak=;
 b=C34WkzV5Kt0FnmaoYoqBIVTpWVLryr8vDesKBU3Upl2gZdgKMThLPajZ5T/FiOkZR6T7psXAahnk0vCHwuH8sqoDsbUUFRveDQrAYgnxaf5fpPtXnKa8cnkI19MiIB5S2cf2+nKdI5RaZ6bFt1QkekveRq0dLxXIk8YAN5euELlU0I/td9lNB+nOfju+Sxg6aysmY9PWRHWi6Xo22K0j+Cx5KbmNUZ+OOmR8Qb9ylFuJ7IlKnGDmKx6f55xjskwWpofURHpG+Zp/PfskzHIFJvOtwTyakKVQrTYojl2vs7CWW9Z2ZXrqIlQ8LGmqsDfmqZhrhc7MYEZUb5e+54Wc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fessw82mS+b1rhkWDfkT/9BORldWiET2tuHXZSC8Bak=;
 b=W0LDJj1TnaewIwBplxu0Cmfr0xVDlCsE46mit7s7BSjJvZVG5f8DpEbUGAPMgzrGi9xyebyHQgempykQjUfG8tlaQ9a/vqQn4x067QJ2N9hYn9MIXAK76H2noWLIAdNdew+PSrEYqBLLiBJXS/dZNS5bSfr9PGvX3aYtHbX3OIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 14:13:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:13:13 +0000
Message-ID: <da29a322-4c4b-4b7e-a0fc-fda6e323b32c@cherry.de>
Date: Mon, 15 Jul 2024 16:13:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] doc: Add a description for bootmeth_pxe
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-5-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 99457d46-af60-42af-e655-08dca4d84356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1FBL1J3QlloaytNMDJmb2Fzb0QxUXdHUHorRjNRYU16QWhBRG5HN0UwajNl?=
 =?utf-8?B?eUg4Q2JjS2h3UXB4QVB3aGgrbktqZG1XVFNlK0YvOGdST1UwY1IvWE1rUHo3?=
 =?utf-8?B?TXdjZzcrNnRJNDFtNmJtTG1YaVc2M0F1U2k4OWlhTWg2c1djdFVQRFY5bXpi?=
 =?utf-8?B?MmluZ1pLZjBsQmpNK1AyYk5pc0YxUjg3MHAwSGdhSDBXQlhQaHhhMmw5dEJr?=
 =?utf-8?B?SWI5N1VGZU43ZUFmTnpzREhHZkVnVFhqTHFnNytkYVZuVUVkVVdNS1hNdWp5?=
 =?utf-8?B?WS9IMGpNVmVqNC94TzFsMEU3dlY0SUJObFBGNDJsN1JheE04NEVUdjU1YXk0?=
 =?utf-8?B?b0hJNmMzbVRyd1VlWHFCQmtIeVQwNHNWdHNsVmpRSWJYMjQ0UFYxTGFvTGlj?=
 =?utf-8?B?Si9HZ3VEOVVDRG5GZ3BGMmI3OHRzOHB1YzhCVnpWczIxR0EvaDJZYmpDeWZ6?=
 =?utf-8?B?eE5TcWtjaTluTmo2OXVJcVEvZDY5cjdqYXJZS3VJQXhEYi9KQzlBa09rNG9t?=
 =?utf-8?B?MFZBR1NJbVJraWJ5TkdrN2kyZDNMYk4zWi9NcWpjcG1FMXJiR0dOUXJaM0p3?=
 =?utf-8?B?ajh1Ry9IdjViNUVvVlVwQXZwYmRFRjVvN0N4bUgyS3Nwd09YUXRNakphQ1NE?=
 =?utf-8?B?TWJnT2EwTGpTTUpvWk5uZlU5RlNLN2xUV3ozQlhJNUNqVThzUDA4OEZyRUZh?=
 =?utf-8?B?NXRWeXMyZ2JGcHpFQWFVc3JBbzQ4bitYZFBoM0hYZE0yQWZoQ2NWVnZOa2lD?=
 =?utf-8?B?WnBVTzFRdm8vK3pGTmJLN0FlY0lhRis2MFZPZ2pYQ3lIOU5YaDBGZnRkUzJG?=
 =?utf-8?B?YmNyMklqRUg0QmdjUE1SbjNvQmlGRWdZTXpPOFJJMVBVT0o5OTFHR0dPcFMz?=
 =?utf-8?B?Y1h5N1NmQytyL2FvbVA0S2QzMXpGbmt5NG5BNlY4UE96MWZZdlpYcTZ2MzNH?=
 =?utf-8?B?SC9mVmpQaVd4MFdLbk5jRFd5UXNHUFdHN2c3U1hZRXEwRk8xMzNNZU9INVU3?=
 =?utf-8?B?M3dTdlYzUHJ0WmNRRisvN1ZaWC9LdW94T2h4ZW9ScHZvQklzR3A0RjNTdmNt?=
 =?utf-8?B?eHBzenJ1aCs3cHdSRDVWVVRySnBPcUpxZm9TNG12ZlJJb2dpbzFkVmliTW1R?=
 =?utf-8?B?TkZBb1gxSUJ1SkxVcTg2aWozTUNEMldyM3JTUjRGVjR3a0FiRktRZUI5d3Fr?=
 =?utf-8?B?WldTMXgzeEVoRHVSRkhtNXl2d3VtdjBjWEFWTU10VU0rZnM5c1c3YWNQbVR4?=
 =?utf-8?B?cjBzQVZFSThEZnpJZlFPUHVzc0NFV2c5ZjJ1OHlzSUc1SjBSbmZSc0NhbU5D?=
 =?utf-8?B?QmtkczIwZG40MkNNK09YOWt3QkZEbDRGVVpPUlV3T2V1M3FUSzhkcGY5UnNT?=
 =?utf-8?B?eHJYKzBsclpvZmlsQjNBRitVQlBGZlVRVzdjNUFUVjd3WEVqZmdwM1YyY2sv?=
 =?utf-8?B?a0J4dzQyTmFFZHBzZ2VNeTU0YVdXMzJxNDBJRURiZTlLczNTY2I3dUlhUFd5?=
 =?utf-8?B?OG1KU2l3SEtKQUVxWFJPVXNWcDMzZ2RVeC82NFVJRFU2YmFxZTRBSmR1bm44?=
 =?utf-8?B?djhKcFJVUUVvYXlNaVFOV0R5RWozeW4rWTZmMnNWZGlZa0owcmJ6ZktIZWhu?=
 =?utf-8?B?RElaM2RsemhXVU1uUzVHd1JINysxRWVCVWpCcWZVMlpNNHJLbEQ0M3RNdTFQ?=
 =?utf-8?B?aWhzQ3NhTXhaQ3hubUlEaHdZTjIzcmY1aUh5bmNkL0JmWmQrNEhGK01qbC81?=
 =?utf-8?B?STA2K0dlQXU5NnROMzlFc2krUXRYd3dJQldnSXRFbEl1Nmd1Nm1ZVGxvQkYw?=
 =?utf-8?B?SE40ME5PbklQeU5OanllUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDFSc2c2L0J6MnBoZkl6MGRzMm00K1lPcldIZ3VNTVlNTko5VHJueUlqdEFo?=
 =?utf-8?B?OU83U3pJdGpveGprL2FLb2I3YnhqbFRDbmNkQXhaNzFOcnd3VHF0dGdVVEpH?=
 =?utf-8?B?UFYrQTczNXdvTzRVNmRpZUxRN1U2OCtNSS9jV3I4NlZkeUU3MnhhVFF2d3Jn?=
 =?utf-8?B?UjBLVlVJT0ZwbURFa1VzSVN3RDByVVNRSy93alZUODZEb3FwYmJwUWU4em9p?=
 =?utf-8?B?eExqSUdQMVVlZ29FV0tlSVorWFJUOEY2aGNOMlZrRnM3WjhjenFEd2FtNGxx?=
 =?utf-8?B?ampYMWxZTWR6M2NtVkNaak96ODErWVh5K3ltMHhUS0JQalRyWGQyMVZmeENI?=
 =?utf-8?B?MHhLbkxVajVhYlpUYVY1TG0zMHlIeWJGU2lNZG82WlZGTE5XK1dSdmpHazZ1?=
 =?utf-8?B?WGd4SVRSQmx5U3ZWb2g2T0c0ZlBJTWNqWklsRzcvUVg5bTQvWGtuVmM3ZE9t?=
 =?utf-8?B?czRBcnhRcDhrQjdoNTNucDQ1dStDVEtVcFhKYlJPZ01JUzlGTkxHbUlGTk82?=
 =?utf-8?B?RmtsNHZubXFUTVROVkZiMkhvSkxEMXRNc3lNTThlU2hYb0NLTmNMU1hQWnJl?=
 =?utf-8?B?QUswY2N6akg2aUNpQmlyalFqeVlxWGVaTGFCdHMxYmJTQW5oNzk0c2p5b0tJ?=
 =?utf-8?B?djQvSjhzWG11dFEzMzN0NURzNUJ2WWVLZWZ3b0w2TTE3TThOSWVmM0JuUlpZ?=
 =?utf-8?B?MXM0N2JOdUEveFVvb1B4VFlEdUtCdGZvZ2dkS2dHM0pGNmpJbE9aYTJ1di9H?=
 =?utf-8?B?T2xaUnBlRFRGaHpjRDk5dWE4UnlNL1dvSkdsSWdsZzlaaU1YSEZPa0p5T2NC?=
 =?utf-8?B?R0lFZUZkcGFhL3l3ZUJETUEyNGJ6MVlCSU5pTWdCT0kzMWtId1M5Rnd3QVNr?=
 =?utf-8?B?Z3NGUWFmenUzam1EY21tT3kyN3B1SHR3U29PMlBVSitjdGx6RHRNc0VwVFpF?=
 =?utf-8?B?ZER1OXpVbEZhM0hKTExSUFY0UUhRTUZSVVJnRG45akxySlVPcUxteGg4WFhz?=
 =?utf-8?B?NmdNbmttZmg4T1FHQjNpaysvN0ZmT01lYWpDUkdXWXp6djJ3MkQ3bmc4S0RM?=
 =?utf-8?B?QUJRbWtUM3RBYTdMYjA1UjNhVVVJeVZHT1R0a3lzRE1mU0pTVCswbElycHFO?=
 =?utf-8?B?MTZwMXpsMy9rakp4c1NVYm95R1Qzc1I3YzBMd2tsR1BhSTNlR2pIVjNSS3VR?=
 =?utf-8?B?TU5waE5FK3pxclkwUWE0TlRxSWJSUUxaY0VJWDNlVkRZWno4Tk16SkN0L3Zt?=
 =?utf-8?B?djJScHhzQmNpSW90aGthUWZnY01Kc0FoclpseFRmYVJYcVU1c3R0MXoxR2py?=
 =?utf-8?B?aWt1VXJWNTVOQkZGcVpFUkViNHVsTS83YWxrWE91T0V0L3Z6eHdMUlp5Q2ds?=
 =?utf-8?B?d0RrdjhoMXBoRUh2em1qK3VjL1luNjZmaTltc3QvLzNTYkM5QXRTL2hzUnNj?=
 =?utf-8?B?TjlUc2Y5RE1HUEtVZEdOdVpQUDZ4NjI5VStsSEs5RHB6RXRNdUdTRjc1NlJH?=
 =?utf-8?B?ak43WWhjdnNETXVheHl5K1lGMWRwdFc5UWpNVmwwTUtSaGFiRWM3SS9qM3ZR?=
 =?utf-8?B?WFhpL3krY3JqK3lHa0xnODhBNU9ZZE9rcm9jcXpOMENudDdyeStHUmtVemNy?=
 =?utf-8?B?VkVEeVRaS0dVS2o4cUZ2dUZLc1R6eE85aStEbHlONzdqYUZXOGxZR3NkU3lu?=
 =?utf-8?B?bjVaMDhKQk9QOW1MYjRmTEtTVGZOL3JNQlNzNDJwajRhTHBEUTRhWUlWWkRX?=
 =?utf-8?B?eXJUZ3lXN3B0bnl0Qm5oZ3dLQlFoemsya3Y4RlZINFJ6YjBIUG5WbmZ3VFQ1?=
 =?utf-8?B?LzlYb1ZFRS9PV1JtZThLdmpXbkFlcHpDZzk4ZHFPbVkxVyszNHNQd2UyWkF3?=
 =?utf-8?B?ZVZOUHNzOG51MS9hVjRhc0FiS2ZCK0J0bGZWRG05ZDMxcFRNSGY1ZGhUMkt1?=
 =?utf-8?B?Y0lIRWlHclRvcHBoUjhiQ0dVLzNhbU95NUNtNkZ2Q05TSUsvR2NMN0Yvb3do?=
 =?utf-8?B?OElmYkxnRmtBcGF4ZTNLNlU2WmFnaWNXR1M3Wkp5TTVWZTlrR1FSNzJMaWVB?=
 =?utf-8?B?NTU4ZTIxeEdVTHdvSW16d1oyZTk1eU9QZmZzd0lMQ3Vtenc3dVZNVXF1c1lL?=
 =?utf-8?B?WlQwbFVHTjBkbzhRVEM0SGdFd1BBczFRQ1RuSWt6dm5iWFJRbzBSWDZCRXNH?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 99457d46-af60-42af-e655-08dca4d84356
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:13:13.0657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijuRGV4cXL0JDTjN4eFA08nCvi1uJbVFcNHXVwlowAqL8d9xSyG0n9MFw6rdWzXnBSv8+dYTW7xv61ZzFuzZdDyqlDTsxy+0MAkzXctmKAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
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

On 7/15/24 12:13 PM, Simon Glass wrote:
> Add documentation for the pxe bootmeth.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
