Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5F6C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FD8488A11;
	Tue,  6 Aug 2024 16:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nOKKiKsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5037688A40; Tue,  6 Aug 2024 16:10:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAD4C88A11
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxCsR/RwHrRDgyUUhfusyyyYGPUAZz0qc87V3XhhARNuuu1IVTYeEY3st3qX//TAbfAWsqtqyw4i/LcMWokSDXUvGr61HxYeEQJUxoukMJXjyFG7+zW7TU9UkdGSzusSaxSDNeyUIq9rt+ELpXQdRytn25UPBEMQm0tLok+gJM1jRUz2e99Rodoqu299MHuNyAYTEh1oz3N/67JsqRk1VoXrZlUHFJj8vxQI7KVQERvEFJO07676F3jUqSTXglQWXQkDYUxVfqA8mlzI8qk87pvxSuMyIplFYJTHcj38+uEqhyKaICwedFyJVrzvNt2xbI2/yQELMhjcbb9R+dkyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T7IZPsXoz5UO8bzJLirPYVepTIa4z7qfb9GROTzqmw=;
 b=oAsJdrOGla48DhJtm/BJqnGhYJLKCpSqahWqUfijsf9EashKY4QrDomRjY+foZ5qXkxdd7AFfT/IdYSLw25SiexNh1utPr36BcbCUKdg7lCbSIUxK4Psgd7NOu7t2CaB9hYhNcz4FnTMpW02m5T/uk6dyQw1BGenUMkOLD7Ct9BpIOxuVALHHeHVkCdzhas8AEyKjfGHexGNy4U20ySt+76203Cw3MW5j11RtPHJu5lystKARWCnmZq5XLADFXqtyRS2+2ZJE6thyjG07Ob/5JwXDBW48eNVP+jo3CS4Zllw2IvLb27GNdQRB8EGt1XDz/g6MzMA70VoP3lA/15A7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T7IZPsXoz5UO8bzJLirPYVepTIa4z7qfb9GROTzqmw=;
 b=nOKKiKsA1BZBDRHKfVWirsj1B5m7NIo6uKLI2D7b7cgQY4dwH4Mh01Y9MrwwvH8ehWaxRaZFlozzWhvnNjnSb8KB70U6ntpHZiD9b2rooXjrR3kwkYhoSjScLu3hno2EfYhyN2xbqb2RMNznY8cBszKcMNzsYOwdBCkf/TIroRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:10:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:10:24 +0000
Message-ID: <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
Date: Tue, 6 Aug 2024 16:10:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-7-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: 221b1681-1574-4c88-5cb9-08dcb6218382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGhac3RvRHQ0Y3dpSEVuZnBTZzhlSUhkOEczVUJLWm5kTGJSM2pIWFNmL3No?=
 =?utf-8?B?eEl0MEJCeWN5R05BRlZjOVJhQk9HUXJHakkrNE9CZW5lbFZkNlZpbVJLV2tJ?=
 =?utf-8?B?bnZoVm1MQXkwTkQ5ejBIVnFFbTdRVWlpR1dVcjNjRFVtYmVEY0RNbkgxMkFE?=
 =?utf-8?B?L2hJS2w1RkJHTmlyZkt3aUI0ZUhqRXV4WU9Zc21NeXlSeFNHL09BZ2loSTcy?=
 =?utf-8?B?QWY2MTJWMWRaYU80U2dEY2FjcGNXaER2d1dKYTlKTUhFQUYyUlE1dmpnV2VC?=
 =?utf-8?B?dVNnNGE0Zlc1WWhIN0hBUHlDZjdTbkt6SXVQb0hwbEFRODhmR0d4UFZGN0Nx?=
 =?utf-8?B?K0txejgybi85NWd3TC9aMXpBT0VjNytTSWJEUjBlcUZnd3JvN2xObUdRVFBh?=
 =?utf-8?B?MUZYNUtnS011ZG91ZUp1SlJ2a1A2dGNrcTRYdFg0TEpJV1pZOHU5UkZtSDdh?=
 =?utf-8?B?WXd5azM4L28zVVk2NStHR2dVYUY3NmlqcUMydWdJRk81VXdzQVd6aUt3TEx5?=
 =?utf-8?B?U3pGODlrRkYvS1diUWxKTUIvV2pVTU9FRE4ydTJyMzJETFBGaFllQWFDaTVs?=
 =?utf-8?B?VTkxNVh2K1M5aWxnUkgrRkJ1YWdldkZxL0lYY3BSeU1PZHVUWDgyZ1h4dU5V?=
 =?utf-8?B?Q2VRU0lPcTNkd0ZZNTRURWR0WEhielY3YkRNT2luN0JMMFN2UHFuWGhpVXNS?=
 =?utf-8?B?NldlM3hTTHFXenlqWGUwVmdSYWFqcGxiY05xV2NBUGNnbms3aHBJUlgvc0oz?=
 =?utf-8?B?OGdUdlJnZXRqVStXMUJDcUdTclRNYjcvWjJZTGpxWkZNZVkrNTk1Z09OajFX?=
 =?utf-8?B?NG1uWE9pU2E0S0MrbXdMQXFrT1BJUGZ6Y3VYVy9IN0ZlV0xhYzlvbno0MTJv?=
 =?utf-8?B?Z2UvZXhMTXpsWWpGaDlFVzUyb0o3UDhIejl5U2g2U3hSMW1ld25xaCtJWkFW?=
 =?utf-8?B?WklaZzRTMFUyS0xVcVFhSmd4NnUraTh4dFRicjRyQ2l1VlEyZlpsOG1XVUJu?=
 =?utf-8?B?VnBIYndiSlYveUVhR2xoWFhzcFlMdDhwcExlRFpONE9MbjM1aFo1aEpVemQw?=
 =?utf-8?B?RWp2TEg0RXpWRCtFdzFOSDJJaVlhNmM3czNFNSs0U3dzakVLNkFiQUJvbnBG?=
 =?utf-8?B?bkdkTGJmM2NZbkM5bklqajRFa1JLYTNTUEV6aEdSdStERVBEa1IyY0xWZFBs?=
 =?utf-8?B?cUJjVklIL3VYalR4dG1VWjVMbXFWUndEK1p1Zm96YTFGL1R0YXJCT1BqYkgr?=
 =?utf-8?B?MXBRRmE3Z01DTExlbTlhNEs3UkgyOGthcVNXeE52WjMyL3BCV1lJbXNjdHZw?=
 =?utf-8?B?NndESkw1aUM2ZFJIZUdzNnI1SzhxSGRUeWZVTEhrVXBDTEdjcjA2QzVBdHlr?=
 =?utf-8?B?V0grSTA2aDN3bFFpTmFQSk5nWG1STEdOUURtS1RPa2h6L2E5RHNPWFBZa1hP?=
 =?utf-8?B?aWlwWmRwUlhTVy8xLzRCTEp0UWl0VVNkb1htRHNUS1B6V082LzkwbVlZWG9F?=
 =?utf-8?B?bGJMdXNaRXNMSjVEVW0xMjh5K2JwWWtWWG9ITnhBTmNTdElVa2FwRHdjVUh2?=
 =?utf-8?B?Zko5cnlZYXByQmw0b3c0THNpV013akVBc2ZiQkE1Q3lVR3p3ZTJhQ0NiQm5n?=
 =?utf-8?B?dmlYSGJEQWRjbG1ZazBwbWNuZDhsbVBob3Q4U1FCVlBkdWZYSkdHT0dBbzgw?=
 =?utf-8?B?MHU1djhsbkpCaElrU3pkRHl6RFUzVHltaWwyUVB6aUx3TVM0Q1ViZlcvMGFq?=
 =?utf-8?B?WVFOQ0NxM2xmNGsvUk4vWVVaM1EzNjhibDZDTTYxWEE3a0R6M3MwS1ZzdVBU?=
 =?utf-8?B?QnFYc3FDZjhMczVyVUtjdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVkODRhamV6aFh0dGtRY2JXdUNHNm1Nb0s0MElpYTI5V0VmcFQ4dWM4eUQ5?=
 =?utf-8?B?N01STnowVGJJVGZkVy9iMnZBa1dLR1JRcmVGWkQzbG9GWXZ3RFdyYWtZeWRU?=
 =?utf-8?B?dGFPL1hWVU55RTVOd2NHaDNmb1JiRFQ0T25nYzdueStrdk5CaFFJUUtXa29h?=
 =?utf-8?B?RjQ2Y2d5SXowS0JtcXMrcmZtWG4xR1M4UEYxeXY2b011Qk15bE5NMVJXNkhY?=
 =?utf-8?B?Z2Z5ZGw1WXV4R2VJR09yWllRN0NrYnpyNGIzdHN3ZUltTkRCYjRieEozTTk0?=
 =?utf-8?B?VysvWGFCMjRjTzhwSEllYzRNK1lHUjR2RGFlQ0FsUVNDRzZJNG1oWGR6VnBO?=
 =?utf-8?B?VEtvc1RRZjFqLzE0WE4wQjhSaTAydXplVWxvRmo2SDAvWFhnVVZRbzlRaVBY?=
 =?utf-8?B?R0orQ1Uzanp5SlJDamI2NENZbGkrNVlrMnFjT014S2VVVk5qMTBjLzZQRXlm?=
 =?utf-8?B?NnI2eEtYZlpJN3ZlSlJQMHN6MDVBbDVjeHlEeFA5bzc0WmpuVDlKZnNtTllv?=
 =?utf-8?B?Ri85Y2dUUm9jTG9hSlRsTHVuejd3Uld4UVdmUGMwcklPTDV2Q2JaUUEzSkZE?=
 =?utf-8?B?dk9xaDlFRmVrZ25tSWdPZEQ0cWVlRkJWVlpnN25MdVNmWGFGZ24vZ2pxWTIy?=
 =?utf-8?B?Q1dRVzRXc2c4MG44RHpQTWdTVk4vK0ZSeDdMRE5ZcWFvU3BMWUROaWo4a3pP?=
 =?utf-8?B?RnMrSEw0cjhadkQrS2pYYmFRdUdOcUU4QzFoeHVpTTJ2SEVVcFlRanhhTEFO?=
 =?utf-8?B?eHNFejZiL2l5WldFaGgxbWFteDJSTndBWmNYcVN6WUMvUUpDaVhyYTZRVmZp?=
 =?utf-8?B?SmNvSEhZRlo0SVVNcjEvOWs3anpXcWhkNzAvWjBPYkYzRzVvNHQ1R3NUOCti?=
 =?utf-8?B?QmxqUkRlaHFyMWlScFFHOENCd3h4TXg0ME00OXJUZTYxNmJGMHp4MW1mVm1w?=
 =?utf-8?B?KytYeXdjLzZaQW1BY01GQWNmS3BsZ1Zhc2hrY0ZWZUtqSmhaRkt6djRGaVFm?=
 =?utf-8?B?OTlMNDhlUG14QTIyNnl1bHRDY0c1UExJdG9GNkFJTTZTU0xvR1lJanJrb3Zo?=
 =?utf-8?B?d09uSzdCMEhzTFZEZVA3Zy9pbTdYcHRnYytWb3IxemVldzRoQVR4QXZ2aVF5?=
 =?utf-8?B?MnRGWmZlMkErVTZmNWV6VlM1LzNoaHUvNHhlbE5KNndGczVnUUxtbmJtUEhP?=
 =?utf-8?B?U2FDSG9NTm9EWWc1eVUxb1RPaFhOWjBUcmNxekVEdlduL0tzQndvL1ZRd2ND?=
 =?utf-8?B?SDNiNlF1MER3eENiYXJCQTdzb0hlRytBcDhCZmhtelhRckJ4UDV4eGZLL3FT?=
 =?utf-8?B?ams3S0JTREtXQklUKzB2RlVKUVRGdWNDQ3hZd1lsYndsYXhKWXdXMDdSZGVF?=
 =?utf-8?B?MUJyYVpVY3ErMmpwMGxWVU5UMEhDbTlmRUFZenh4aHlQMmtYV2M0WG9tTjNi?=
 =?utf-8?B?ZVVjaHF5WExtcG9NdFcrYkpKTkxmMU54UlYvM0ViUUN0bCtuUE52TTl3dUVL?=
 =?utf-8?B?MTFPamk1OGNEMGU5UzAwQW4zVkxjaTcvQnpWbEdSQTBZblVHc2ZmWE9mZDNF?=
 =?utf-8?B?S1ZtUHJKMW9SbU0ycy81TzcyaE1QV0VhRmRiYjljWGZqalNqeFMvMWZyek9r?=
 =?utf-8?B?ZEh3V2ZCZ01lRlluOEZab1B3ck52N2oyYW03aVlNMUdMcjYzdC9SL0pOaE9u?=
 =?utf-8?B?Ui8yZVdPY0RoWDJYckRPeFhjWDJ6MDZKMVhycDlPbjI4bTJ4OTZ3MjZPNjhU?=
 =?utf-8?B?S3dvRDAzSGhIQStGQXEyMWhHZy93UkJYUmZ6UWJnNUZidnFSK1FnMDRXaEps?=
 =?utf-8?B?b0pmL2svdzZPUWJTSXFIbW1TaERrRmhFVE5SeGNGbDA0TWpwaHYxcFB3OHoy?=
 =?utf-8?B?VWg1TmJ3VFFpdW42bTN4UFRVaTdmUmFwT0JUTUhFNUk4QVhRTXJvZ3l2RmZS?=
 =?utf-8?B?MlpENGtOUDJZdUtKU1JjWVpPOVVscHAxYmZjQVpMV2pQdy9sSUMwUzNFWitx?=
 =?utf-8?B?TFQvZW9CR0VyS2JleUJMd1JLT21mL1czM21DZDZvZUJRVllxeTdaZVBuNWYr?=
 =?utf-8?B?K05xQlJYN2hBakUySUxNWjgrQmU5RnMxKy9UWmJ2TVFTRFBhVjJpbXQwbEpO?=
 =?utf-8?B?UGFSZDRDbjlRYk9IVVhMZmNPMzRjRVBiUm9YMnBkanljQ2hlY0JjZkFZV3N3?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 221b1681-1574-4c88-5cb9-08dcb6218382
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:10:24.1715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLN7gOnnLysAm8KTdLpXj4FRYvURNu5Z/S+OFi80Rjn9La8D8dLaRyEEQeIMQW4CIFGrrZ5wZimemPowFzHhw0S3Vmh+ilKLus69bcd9cDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363
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
> Use the log subsystem instead of dev, to avoid including function names
> in the code.
> 
> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/mmc/mmc.c | 49 ++++++++++++++++++++++++-----------------------
>   1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index b18dc331f78..b0105afe5d6 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
>   
>   		if (status & MMC_STATUS_MASK) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -			pr_err("Status Error: 0x%08x\n", status);
> +			log_err("Status Error: %08x\n", status);

Please don't remove the 0x prefix (will not comment on other patches in 
this series if it happens again, please check :) ).

>   #endif
>   			return -ECOMM;
>   		}
> @@ -307,7 +307,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
>   
>   	if (timeout_ms <= 0) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -		pr_err("Timeout waiting card ready\n");
> +		log_err("Timeout waiting card ready\n");
>   #endif
>   		return -ETIMEDOUT;
>   	}
> @@ -449,7 +449,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
>   	if (blkcnt > 1) {
>   		if (mmc_send_stop_transmission(mmc, false)) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -			pr_err("mmc fail to send stop cmd\n");
> +			log_err("mmc fail to send stop cmd\n");
>   #endif
>   			return 0;
>   		}
> @@ -500,8 +500,8 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
>   
>   	if ((start + blkcnt) > block_dev->lba) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -		pr_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
> -		       start + blkcnt, block_dev->lba);
> +		log_err("MMC: block number " LBAF " exceeds max(" LBAF ")\n",

DOn't remove the 0x prefix please.

> +			start + blkcnt, block_dev->lba);
>   #endif
>   		return 0;
>   	}
> @@ -997,7 +997,7 @@ static int mmc_get_capabilities(struct mmc *mmc)
>   		return 0;
>   
>   	if (!ext_csd) {
> -		pr_err("No ext_csd found!\n"); /* this should enver happen */
> +		log_err("No ext_csd found!\n"); /* this should enver happen */
>   		return -ENOTSUPP;
>   	}
>   
> @@ -1109,17 +1109,17 @@ int mmc_hwpart_config(struct mmc *mmc,
>   		return -EINVAL;
>   
>   	if (IS_SD(mmc) || (mmc->version < MMC_VERSION_4_41)) {
> -		pr_err("eMMC >= 4.4 required for enhanced user data area\n");
> +		log_err("eMMC >= 4.4 required for enhanced user data area\n");
>   		return -EMEDIUMTYPE;
>   	}
>   
>   	if (!(mmc->part_support & PART_SUPPORT)) {
> -		pr_err("Card does not support partitioning\n");
> +		log_err("Card does not support partitioning\n");
>   		return -EMEDIUMTYPE;
>   	}
>   
>   	if (!mmc->hc_wp_grp_size) {
> -		pr_err("Card does not define HC WP group size\n");
> +		log_err("Card does not define HC WP group size\n");
>   		return -EMEDIUMTYPE;
>   	}
>   
> @@ -1127,8 +1127,7 @@ int mmc_hwpart_config(struct mmc *mmc,
>   	if (conf->user.enh_size) {
>   		if (conf->user.enh_size % mmc->hc_wp_grp_size ||
>   		    conf->user.enh_start % mmc->hc_wp_grp_size) {
> -			pr_err("User data enhanced area not HC WP group "
> -			       "size aligned\n");
> +			log_err("User data enhanced area not HC WP group size aligned\n");
>   			return -EINVAL;
>   		}
>   		part_attrs |= EXT_CSD_ENH_USR;
> @@ -1146,8 +1145,8 @@ int mmc_hwpart_config(struct mmc *mmc,
>   
>   	for (pidx = 0; pidx < 4; pidx++) {
>   		if (conf->gp_part[pidx].size % mmc->hc_wp_grp_size) {
> -			pr_err("GP%i partition not HC WP group size "
> -			       "aligned\n", pidx+1);
> +			log_err("GP%i partition not HC WP group-size aligned\n",
> +				pidx + 1);
>   			return -EINVAL;
>   		}
>   		gp_size_mult[pidx] = conf->gp_part[pidx].size / mmc->hc_wp_grp_size;
> @@ -1158,7 +1157,7 @@ int mmc_hwpart_config(struct mmc *mmc,
>   	}
>   
>   	if (part_attrs && ! (mmc->part_support & ENHNCD_SUPPORT)) {
> -		pr_err("Card does not support enhanced attribute\n");
> +		log_err("Card does not support enhanced attribute\n");
>   		return -EMEDIUMTYPE;
>   	}
>   
> @@ -1171,8 +1170,8 @@ int mmc_hwpart_config(struct mmc *mmc,
>   		(ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT+1] << 8) +
>   		ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT];
>   	if (tot_enh_size_mult > max_enh_size_mult) {
> -		pr_err("Total enhanced size exceeds maximum (%u > %u)\n",
> -		       tot_enh_size_mult, max_enh_size_mult);
> +		log_err("Total enhanced size exceeds maximum (%x > %x)\n",

If you change the type (why?) to hex, please add 0x prefix to explicit 
the base.

> +			tot_enh_size_mult, max_enh_size_mult);
>   		return -EMEDIUMTYPE;
>   	}
>   
> @@ -1205,7 +1204,7 @@ int mmc_hwpart_config(struct mmc *mmc,
>   
>   	if (ext_csd[EXT_CSD_PARTITION_SETTING] &
>   	    EXT_CSD_PARTITION_SETTING_COMPLETED) {
> -		pr_err("Card already partitioned\n");
> +		log_err("Card already partitioned\n");
>   		return -EPERM;
>   	}
>   
> @@ -1876,7 +1875,7 @@ error:
>   		}
>   	}
>   
> -	pr_err("unable to select a mode\n");
> +	log_err("unable to select a mode\n");
>   	return -ENOTSUPP;
>   }
>   
> @@ -2254,7 +2253,7 @@ error:
>   		}
>   	}
>   
> -	pr_err("unable to select a mode : %d\n", err);
> +	log_err("unable to select a mode: %d\n", err);
>   
>   	return -ENOTSUPP;
>   }
> @@ -2921,8 +2920,10 @@ retry:
>   
>   		if (err) {
>   #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> -			if (!quiet)
> -				pr_err("Card did not respond to voltage select! : %d\n", err);
> +			if (!quiet) {
> +				log_err("Card did not respond to voltage select! : %d\n",
> +					err);
> +			}

We still don't need the curly brackets here.

Looking good otherwise,
Cheers,
Quentin
