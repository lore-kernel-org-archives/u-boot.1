Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8299C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 14:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62473885B6;
	Thu, 23 May 2024 16:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IuWo1iVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B18885B7; Thu, 23 May 2024 16:52:33 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB5A885A4
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 16:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0fcJCLFxQriL6vKQRMP3w/mlfTQbNsctRnwAN6TDz1L/Jg1BPBLtGPxSPbPijAkiJj2jyYqDdXIkLCfG188okbxMUytS2Gu4Xc1Z1w8Ky1oRDKP6UevOnuhzZL1HWfGteaMplOdAor4uzbPSDZ3yYwYsqmYiSyX0IRj+Z/WwMnvsI5+Gt01+uTvD+c4tkBgK28LyP3psdkmP0JlzzH2nfOaZNlnCbdBy6YLodZjqV10Iqty2bRMGW1zjdE18XZA50piTkT/S3GYas8Cdk2fvuLMTBP/OXIEjpNjQgpXhmX0hhJFYDRDmTy4U6SpJlheQRWznIfPP3qtdRJyHGWSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr41kOTMAm4pxuG3hvGYs4Tg1tTlTKmbJhQrDETE+2M=;
 b=aHQo7PRcAhLZ00/cnpE8WV+Qs5tSKUh9A77GrsxP094sBZOnBr1jz9biGKjwuUc2jAQBJjVVa9AUIWJzO253o0a3c3Tf1IQwBeM4QooiLoJPzvlPB5pWHna3DJ21+1P3ej83rJOdqa4YK6IRCUf85VLqY2/QLpooZKSwEXWDWvxF0HullKv+VF1cQmBotBZO6jj4m/uyQmh3AGv7oQgSHhDabaupIKEEZJN6VgbIEhWdufXgXx1gsiWvNvrtSfz2xVR4/eEuBMJCVkBW7sYSoEOLa3iIOJVI+Ig//cM886VNJz0BoHZZMXJ4dPTEK7sOlh+7y2dF/auI4Aq8Qc6/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr41kOTMAm4pxuG3hvGYs4Tg1tTlTKmbJhQrDETE+2M=;
 b=IuWo1iVT7ZpaxHQxpfqhnk4IEnj7YcJ0cZXoiAAG16w71ia3gYuOVgslWMkf7jzfIqaMY1+hRhgqrQRjULtsHdaQtvK899EvypooIH7/+1ycanOK5I+mTUvBWTIsPF914SSxa2Yzt295TXzR9CkZtkT9UPjbzzJ2vOp5D9fHcPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:52:30 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:52:30 +0000
Message-ID: <d8e7a0c0-b470-4099-8669-890682f7a8d2@cherry.de>
Date: Thu, 23 May 2024 16:52:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/42] mmc: dw_mmc: Extract waiting for data busy into a
 separate routine
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-5-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-5-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|DU2PR04MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f13109b-08d3-47d3-4a49-08dc7b37f846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjlEVC9xUHYwMm8wUnZjN0EzNWg0VmJLMlZSbE5uWU8zYThPSDJMN1RUWEF0?=
 =?utf-8?B?Q1ZIbUVpbmxmTFNudHNtdGNHN1F0TnNSQVRYdW1BQWo5T042R2NTMnRxQWtI?=
 =?utf-8?B?YkZTbkhXcXJlZmZlNEJhWGNXeUdabThOejNEcllwT3MvYlVLekdjaXprUmpJ?=
 =?utf-8?B?K0Y5RFBENzZSTkFIMGZVL3RUaUpEMEF4NjZrVWRyMkJvbVlQcXNxb2hUcVJm?=
 =?utf-8?B?VDJObTZkckpqMW9EbFRVb29JblpOTHk0dm9CYmhEa0hsMU5PdE5YN2orOVYz?=
 =?utf-8?B?WkFjU2dScTlKOTNnTjZUampUZVFuYW44MXIrZTZWN0pxWVZTN1Y2ZUUwRm5X?=
 =?utf-8?B?TWRDQ1BSc2dVUkQwTGRVYXE1bW9ocTJoMDhISjBzc0xodmJFbkduMExxVG9G?=
 =?utf-8?B?YWJmdEVSVlRjT2NWdTVMWHUwaGdRZnhWMzI5aU5VcHJyVTdTc0gwZUlqWk8v?=
 =?utf-8?B?NXkwNEI4L2IydERXaWxxVnZhVlNkY2xkbG5nN2RyTUxkZitvR0hTMDlmWGgx?=
 =?utf-8?B?Q2lLc0g3a3V3aVNlZXN6UEVTWjZBTFJMOGdXek5yVTZKd2hmQmNUNlRmclYx?=
 =?utf-8?B?d3krUlRyRkhJcWtkS3M3RVd5aDZFN3IrQnJCaHhvWm43YUdvdkpWU3B4R05p?=
 =?utf-8?B?QVgwUUxQM3BPdjBVOEF4UjR0ZWkxeDZBNXVqYnhDVzRkK1k3YWNDYkw5L3lz?=
 =?utf-8?B?MEpQclFCak02NHI2NXZyaWRmVVNEZWxha3B1OStQR3Yrd2pReHJ0Nk9kcWZS?=
 =?utf-8?B?d2tueW42V0NRa2FLRktaT0FiTmdKOThMQ2Y1c2J3NHp4N0RHK24vYThFdVhK?=
 =?utf-8?B?RFYrcGhQeVZjMkdBejQvRGVTdEtsZzYvc2hIUy9pYVBnUWRXakN4TGh2UXFh?=
 =?utf-8?B?TklzSkN0OEFUQ1lnU0hBczY5L0NGN1drVDk0a3JkcGZnOWhub2RnbTgvclp3?=
 =?utf-8?B?MWFQRTlDTVJxY3hhWmZ6ZVo5Z2dPL0d5L2dZYWZoU2ZUcjZuOFJMWTJ1dzdq?=
 =?utf-8?B?SVN1Q1Q2UjNRQTIwcW1DcVVRVTFqV1EyT0J0S0o5ekhoSEplYlhQZjlhV0xU?=
 =?utf-8?B?cmthOW5VVVRJU1RQcGZPcTBNMURhL21VUndMbHZJcnh3YzhyWnF5emtMT2py?=
 =?utf-8?B?TnBPUTEvK1RmaktSbW9rR0FoSC9td1Q1b1hab2lsdGs2dFo5cmNWVzE4OFE4?=
 =?utf-8?B?cUJUWlpQQnM2MnJyUGxSLy9Ra0w3akc3WVhPbTVpa25TTVQvMFc2bGhiczRx?=
 =?utf-8?B?aVBkMTk1YytGbmE3NzgwclhTUmJzZktrZDdPeldmaEN5Um5TdGtDNmEzeFFQ?=
 =?utf-8?B?U0FuTHc3SjJFRTRzSit5Z0dLTlNWcnMySUZqQmdqcmIzQmIvT0ZnU0V3MEp4?=
 =?utf-8?B?RzVSUUpmcTArK2cvVk5aRDFreEx0SlFaaEs2RDJtUE5jYW0vTmpoZUZnMGVY?=
 =?utf-8?B?UTdoUExISVJGYVcxb0JFeVczV2pYdTFWdklDM3JsdTN1TkRSK3o3N1hydzNx?=
 =?utf-8?B?cUEydVllOXkzeXUraE1OR05LNWZpV3RHWm5ZZnlOWWkzZGptZFFDWUxzTlZh?=
 =?utf-8?B?SDRHajh1eWF4Zy9QVDFDN0RQTDdWcy9sVGI0MTRFNldrd0trSk0ybEdKMVcr?=
 =?utf-8?B?OHdQdnE3UDh5U0VhK0pSblUxZ3RyN1V0WkN5bkhRY0h5SVdzajBIYkVxL0JG?=
 =?utf-8?B?L0d4ZVFLUU5UTXg2cGRJY3RHaVhERnZQMGlpUTVxYVVBRGNSWjM3NTRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGdKUzE3UG9kQjh4VTNVOCt3c3BTaHVaVFpnbFA5WG01cmtSa0FHcHlHN1FC?=
 =?utf-8?B?V1dtczRIUFdqdTRNMlpPWjJSc0xFTTUzVTZkbmV5NmdDRmZxYXorN3RYL2ZV?=
 =?utf-8?B?d3gyVGJFRm05V3VSRmlLeWo4QWpVYTcyMHZFWHBZM2VYSzIxaVZUR2ZoNStK?=
 =?utf-8?B?K0s3OVU4VVQ1Y2h1TXh1UjhEWE9JYnIvUmI1cUxpNWF6elZHaFZlbVAycVk4?=
 =?utf-8?B?d0VZdnFXWnRTUkVjTlRjWHUyNHREQmE0YStYeVFYbXM3bGx6bzcrTlhuck5w?=
 =?utf-8?B?NDJGR0RlemxtUmI0c0RXcnc5aktlNmkxR05xK3FkcEpQc2Y4YXVBMVZtRnho?=
 =?utf-8?B?TlRQYkNTWTViV3g2azlBUEJuUmxTSTJBbVBlb05RRXErQ0FXZUlSczUyMWxv?=
 =?utf-8?B?WUZtbDYrL1cxdFg3enk5VGJpYkpNcUVwdGZpeWJLR1hGN3c0MGZVTFFCM1hl?=
 =?utf-8?B?THhRdUs2V1hvNlcrTjlla3VEckdmTy9jMlQ0Z3IxdHUrQ3ZzdUlpNnExVm1B?=
 =?utf-8?B?RklUckg4R25vRVJjRzFIcDd2ODlzcGw0cXlkMnVBMk1yanJrU3cydEhJTjdS?=
 =?utf-8?B?RjdETTFTbmJ5K2QydWx5RXdKQ0ExL2hKbEQ1SElyU1MzTHdleWZ4TDY0YkJh?=
 =?utf-8?B?QndEdDd5N1J3dmZDMlZZdUNuajcvcXo2eU4vNHVxSXN3TlU4VkZZVzI1bmlM?=
 =?utf-8?B?NnZ4NGtTaGMrQ3g1emlxcmIrSmlQK2VrNmd1Q3FHTjZUSmo0cHpaR3BzbzNt?=
 =?utf-8?B?YVdrWmxVN3JuVGM4MmZrbEtuSEdsS2xvd1FJK2Y4cWMzQ081WkZkZUpiZm9a?=
 =?utf-8?B?R0szWjdGZVVLYXl5L2MrMU5rRDM5MkRVYWUyQWwzWUVQLzBqSmFyT3FBN3R3?=
 =?utf-8?B?M1lsWTAzZGNQS0dhY08xTnlJNEN5OGo3ZnpmbWhDRmNJeWZXWVpwRU94TXZG?=
 =?utf-8?B?ZUthRFpTMkR6YU94NitWQnIwd1B1OWhVd3VqVEpZUU1WdW5pRW0rKzZzZzlI?=
 =?utf-8?B?MTRBTWE3SzdpbnZnRm9HMVNlRDNYQ0h5T2ZpWFkxbWFsYjdqaUhUbk9QTUpX?=
 =?utf-8?B?TGkyOVZnbzYvYUlPaDRmNXdLaXhpQ2VLZ2J6TXNmQ21MUnFjRXBwNTllUjlG?=
 =?utf-8?B?bmw4cVliYnVaOCtjenpHcWlJZzllaG9nRDY0SnMvSlp0d1dFTjBkUmpvd01a?=
 =?utf-8?B?eEJiNlZ3V1N6R21FSG11QUM3TGt4VjVJbVVnTE9EZzRmS2dtcjd1WU90WXpi?=
 =?utf-8?B?OU1NbWpiMTRxd3cvMUJEVUpuM0RzcVFiWU8wOE1YNjRrRHAraFFDSDllNU5Q?=
 =?utf-8?B?RzVQTTFNZXVObGY5cEF2YVZ3N0dVQjhEbEs3QjQ4clVMWnpXY3paTUlOMnAr?=
 =?utf-8?B?amlOdmRzbVU3QVd1cmlTM2hpQnYwWmc3WWdHOWxha1VjK2hHS0h1WUlnSmRN?=
 =?utf-8?B?bjJqSzl6Kzd6cXBrUTQyeDI3VlAyVWYxUW1WZXYraGRJU09rVnBpdXFNRW41?=
 =?utf-8?B?REU3TVhWRVZSZVZjd2l0Yk9aNUZnK0RveXlNU2hpZWlLRTEvalpIdlh2OEZY?=
 =?utf-8?B?c1lSMjFrUzdDOWN6aU9KZnFOUEJ6TTRHSWZBMUFhYzVVRWt4aWROWm1pNmNM?=
 =?utf-8?B?dGVzdlFTUlErcHNoWFhRbjRCZnNwbERIb0dnT3k1Q05xcTNoMWdNbk5jWmdF?=
 =?utf-8?B?NU1ZNEx2ZThGRVo1dGNMbmRLaktORTEwU2FRYUN2SmJ0SmdtdWMzK2UvRWtH?=
 =?utf-8?B?MllMU1RDTEsrcTl0RXN4ZFI4S0s3ZXJPN0QzRWJ6SU5DWk9jaWxrSVNBZ2ww?=
 =?utf-8?B?MzJPZjF1UUZHbDRMYWl3MkZSODg4QjJuOE5aN20veXhmOTFCY1NONUFncVlI?=
 =?utf-8?B?aW1EY0w4QXpWMmtuck12SXMxemRPN3Zja1dLbjBDc2NpV1g0MEJPTmRid1Na?=
 =?utf-8?B?c2dweXZJOWpROEV6T1QyblN3V3JNZGpCU2JFOC95bDRNVWdDZld6aDhjRmhs?=
 =?utf-8?B?RnZZTmIzY1dGM05BZGJoMHpnQVBGUDlXT2FKcXJYbXFVQVkydzkwSENYSkVy?=
 =?utf-8?B?TkxWN2k0Z3hoYUdVNDdLSkZJSU1nbE5NSDhKOUQ2QUFYTTVmSW5aeVB3aEpY?=
 =?utf-8?B?dmh6VVEyN3BaWUN4QjA0ZTZKWUlvVmMzSFJDV3Vlb3FWdTlneHpOelJ5bWdx?=
 =?utf-8?Q?wxNpgR9GWmGlJAeSahdmHyU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f13109b-08d3-47d3-4a49-08dc7b37f846
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:52:29.9967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaehNf7Texl/jAfah2ZoNzKJkJD0bM6JPTsq/WR1NcLIBVEGVxYmEYm8zphl1o0ynNH8qQHJlO+432BoQpwkrkBBtBWJl/RJ3NOmlZBFMbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
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

Hi Sam,

On 5/23/24 1:30 AM, Sam Protsenko wrote:
> Waiting for data busy is a logically separate operation and should be
> implemented as a separate routine. Follow Linux kernel example and
> extract it from dwmci_send_cmd(). This way it doesn't clutter
> dwmci_send_cmd() function, and can be reused later in other cases.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
