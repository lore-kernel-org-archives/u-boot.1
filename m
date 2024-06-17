Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2C7C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5490A882B8;
	Mon, 17 Jun 2024 15:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="h7UCgpRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB52F88271; Mon, 17 Jun 2024 15:17:02 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7340882B8
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPv+kS+Lz1Z6UY1FcHspCjNX2s3H7rdLVJ7/gmifSvJV3nNN62OtYcBFYezeTAhXmnJ+xvr3NpQBevHUB0MwKr7qVlAGPdtTZASmUY1eLA1v/rAxEx/M7c9S62qg6G0S83rZ3BV9UcBCDq+qOkvGHmC0OnOZh2bQmVG+IwVCN09Wa75wkw0E6uwi1Ox37/90qMzIlLEKXFT8vhaph6QBOMSK/oP6Q0houDhN4Vy0oy9FrcUmtIxHiwCXSocVTRKVNixsfBp0Wj7VvG/4P7uTJCNpN5owyb4xl3UQH2kMXa0m5sepNfYAJ1SE7qheYrTkXKCT6iZB6DeC4cLLzCogqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR5uSPZeT/NFDGreJq4KvrswwWXbJst65skW/nuORJs=;
 b=WBwmkYV1sEkRKXAXElOh5vDwqVWxtDlc1RvRm/ElgymSujYO7xtNTZdIr5t1eNLFLV1Q/CuS0RMoMk940wzSYmUD9bxhogJAU7sqNAJ5ey5YunS4M2yHO8OZ6s+lhfVVE/DSeAcW6/xZORtKUejzfR5ElPv51Z8erCnGT8neeAOggAYqAxov8m2suKMyEFGrXLMmiC3FMp+sduWo1Tv3yAHAUBmeu7CMLJLq3erseivlfAqgAMdRtM7/G1UDM+RGGSJrKuDnuzu8lPdbtHqVYLjWPP8jraG2Uq93ytcUuClnglmEiS12W8/R5seBAWdHz7n6YgqKI5H7W7GmjSXj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR5uSPZeT/NFDGreJq4KvrswwWXbJst65skW/nuORJs=;
 b=h7UCgpRxWoQnWMam0TD7Wq2SOGGz8dLTm+ULcGt7Ljp6l3uoTniTUbouwJ7q67M0fRrWlelPg3cZzgfTPGJLEqZZGB2ZtM+u0WwIpSW8dMqm9oPOuTmVAseyToQZCvHFmkjDUzhIWAaQQbiOzmpxZSslDnPcTHhe1QcOr2mWNb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DU4PR04MB11007.eurprd04.prod.outlook.com (2603:10a6:10:582::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 13:16:58 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:16:58 +0000
Message-ID: <bf000d30-ee3e-496e-8c8d-de7f5ed48a08@cherry.de>
Date: Mon, 17 Jun 2024 15:16:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DU4PR04MB11007:EE_
X-MS-Office365-Filtering-Correlation-Id: 173bc2ce-2e1e-4c25-4220-08dc8ecfc47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTN5ZnVzcVloMEtHaTBadnpJMlJYLzEyWElzZVR5bzVlVExYL1p1L0swQXlu?=
 =?utf-8?B?TTA4MmsyMURJRzlvTDdkUmpWQmhzbUhOOUZKYisvOFdMcVVoWlptVTNpZWJK?=
 =?utf-8?B?OVlReWZQMWJKdmpEY3B0NzRqazg2VkRBSVpwT0FJSHN5Uk9mU2JXRi9obDll?=
 =?utf-8?B?M1A2bktJWHRsODdPRFFhdEJQUjhEa1FCVWREUDhRTDVwLzNMYlZMTUVHVEYv?=
 =?utf-8?B?cGh1YW1CQWhuUHBoY1hRZXNvZ0NJMGhaVFk5NkxKR0hzdFhSejk2SmhuQlE2?=
 =?utf-8?B?ZW4xZnBUVC9WOVk2R1VzZU03ZnVMMHEvZXNaazNub0NManM4WVlNbXlwTFhB?=
 =?utf-8?B?MkpwN0hwVWUvaUVvbWpPcDVKY0VZMW9ySlhQdnVjTG9iOXlhUW5DT1craTBq?=
 =?utf-8?B?Z3dLVm9ZZnJtNFFYL2N1N3BHNSs3am1HNW0xOWVJZ2F3TW5sUStPVXhHUXJk?=
 =?utf-8?B?cnVvRFZlVzVnNEd5N083dUxGU0E5MWd4SytrYUM5OW1BVFpPZXJJZS9aOW9D?=
 =?utf-8?B?Z3BmUTNUbFBsSTBTN1BUcklON2liQmVEUWhMVGpuc3JqUWJBYTE0Qzhia3dV?=
 =?utf-8?B?ZGlmUVVPSFdPdk9rVlRFOHBINmxVUTR3Q1llQjRMNENua1hkbGloWHdRZTNz?=
 =?utf-8?B?eWppNVhHWFFPT0szY0RwMldBNDVKMThOaVRHUTRaRlJvUW5LU3Mzc284L1Vk?=
 =?utf-8?B?NkVLOEx0dkVxSzA1bTZTNTd1OWhkbWd2NHR3Y1V6d1hleFJzVzllQi9EV2ND?=
 =?utf-8?B?L1FpZjZvblBYVGV3eldpVlI4ZmdIUXNRcGErS3FTTGFuSHliTWhiV2pXTU12?=
 =?utf-8?B?WXkwMTd1aTZTemw4aHc5VTdsc0ZnOGQrYjdPWUdpSS84ZmtLajViUkhHd2tH?=
 =?utf-8?B?NDBNWXV2WVk3MS8zbjhwQWhWWks2SEhFVFNtb1pUSjBYY3JQTU5HdGFZRksv?=
 =?utf-8?B?bTg2ckdCUWx5L29ad0dIQ1I5VXIwcFBkbU5hTzNITXIxV2d1NHNHYnhsZ1h1?=
 =?utf-8?B?MG5uaTJvUHB5eGhNaXNNbVZHa2JzUTNZWHVlYnZYNWJLdlB1QnJQNVRrRmxy?=
 =?utf-8?B?VWYzSDVNK0s4Ung2K0RUWk1WQ3pPMlVuZUs5T2tBb3FhMzk4Z3dzbFRmSXJw?=
 =?utf-8?B?VjNoT24xUEtoVnhFbElIbFgreVpiWUNIRzNTR0pjdDQvYXcwdFI3eFJqOVdi?=
 =?utf-8?B?RDVwb3VUQ3dGM2Jvcml6U2FNaUNWL1FobGJiVHFxdUhBTzNxNVA3dDFPcTZt?=
 =?utf-8?B?U0svR2V0NHdKYWloSVVmbWZabmtvd3pwSUppNWQrZ0VwZnFkWGVIMERHUjQ5?=
 =?utf-8?B?d0FLWEt3bGREdGJURUQwaGl6dFRXRU05eFJVbWhRalhmZU9pZnhkWlhRcXBx?=
 =?utf-8?B?NkcxRC9IYUpISEx2WW9Hd2ZORnFzdkhyTXlXYlB1cVFkQXFlV1kzWFNuaEYz?=
 =?utf-8?B?SlkvM2lia01PbHpVTm5pRlBrS3Z1cElvNFBWb0J6YXIwaC82TWhEN3NEdGda?=
 =?utf-8?B?dnJhZU5sRnJMa3FYTUs1VnF3SjBmOUJIZ29sV0RHVmxIN3lEMlFOTVV4ZTJ1?=
 =?utf-8?B?SnZJQm9FaGtzREQ3TnlGUHVhME13bVJYUXVqQkpGMHFYRVBVZGJKMHhTVjUr?=
 =?utf-8?B?VUYvZDB6aGFuZGhXVE90blkyUHNSWlpOWnM2QVdEcnpvRUk3V3phcXJsUmRq?=
 =?utf-8?B?cGNMbXdrb3ZKalFpc282SUY2KzJkMm9IWHFON2V4N2FhU2kycVFEeXB1d3k2?=
 =?utf-8?Q?MK1bPUQxe4U81eMujSfSZoDhASwve26reljslFo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWQxNG9QMTZBbGdDcEJhV2xLSkI3YjFybmIyOXFHWlY2eUxuT0svcC96L1lz?=
 =?utf-8?B?eVRTR0RmYmI1bVNsSTBFY2NRTmhGb3dVbjM3MkRzeXE2Tm04VklFeit4WVpj?=
 =?utf-8?B?THVPWk5Rbnl1TGw2SnNwSTVGWkpRWTlnYzJMNkVMUzBrQ3REMHRLa3d5Y2lh?=
 =?utf-8?B?ZTYrMUY2cUJyaEtHWFFJamtzaVVVNnBHcTYxNnhhaWNJdWJnVCttTDRyWWQz?=
 =?utf-8?B?bFNab2ExblZ2cmlweXMyRlg5SjVXVzZzSlh0QzVUWTZCZXJ2TzVwWTF2Nlhh?=
 =?utf-8?B?WTUzWVY2RDhNcTJSMTNYSmxTb1JKdU9hMk1BUWtVeFNwZzViamUwZXk1cG5C?=
 =?utf-8?B?U1lNMTdpN2FTZlR5Z3BXS1dyNkV1cWcyME95VENDd1JKRW5abjB0cW5WZ0Zo?=
 =?utf-8?B?NXN3YUZjdjRCdGI4U1dnQjhxZnVNLysvV01ZYnI4L3hKVVpSYjdIMTNwQXNJ?=
 =?utf-8?B?VzgyMWtWL1Jyd1RlMi8wenJ2cFU2NjRQaUYrUGkzY0UvTFBjUDhXOC8xRkRT?=
 =?utf-8?B?ZmRPczlncmFSVGVtdy80Yzg2N3prdnFXQ3FEeTBpUWxkbjRjQXhzVDNjMzhL?=
 =?utf-8?B?TGtZQ3dEMnpoQnUxY1ViL2ZZRlJvdGVsNm13Z2V2eFZSSFFwL3hWeEhYcFor?=
 =?utf-8?B?Yk1ueUlNZjdHVnJzbVhlNUpkOXRNSGVGYVpra2FOU2dxcE5ocHZxVlI5dFpx?=
 =?utf-8?B?QVRrMW9aRGhBVmZubUNhM0RJdVI0VlVFeTBNNmFMaXFsZ1lPbFhwMENIS2o2?=
 =?utf-8?B?Ty9WNTVvTnJrWTA4c3c1OXp2RHJ5djJ2eFdWZmZmYktaNkw2Q0RZSXpIU05V?=
 =?utf-8?B?eHAvZ1RLRkRWNlBLR0NhY0dBUkxWV0tFOWtRaEVTejNlbnRmOUphQ3Jna09p?=
 =?utf-8?B?WTk0RUpFRTlkZmVhdlVpandxZWFyVE1ub1pVdk9xMmZ4YzZyZFg5UU5tZlhE?=
 =?utf-8?B?c2lzaFl3Ymh0NGUwV1ltWXlvc3JtZ05XUFpJOTNBS3NVQlVnTm5EY2tIR0Zs?=
 =?utf-8?B?RUtTRmQ3T0NUbzY2UWZzVnNzWmt4end2T2hzdWxBdjdQSFRBWU5uK0srS0Zj?=
 =?utf-8?B?Tk1wdWNnMjhLZyt1VjhrdWJscFdaaTd4QUVraFBqWnYzanFZQjNieVJ5ejMy?=
 =?utf-8?B?MmtFdGhOckd3T1ViekJzUjF4WlJDTkZrK1VJS0Z6Wklod3BmQTl3QWJaLzRq?=
 =?utf-8?B?NTZFMzEwVURGeWdvQlkwMlZ4M0M4eTlwczdhdGsxU0xqS3ExVWk3c051Ulhu?=
 =?utf-8?B?NWtTQS9QNm1BQk1xWStIalJqa2hLOUtWY0c1aExQaUp1eTNHTWxRei9ETUVs?=
 =?utf-8?B?L001THl0R25HbDNES3M4MjlzTVhwbjl3SjBUVTRISHJMRVlqMzJhWDBMVXhH?=
 =?utf-8?B?SGh3cWxoemhsV0VXNC9KaU8rREpaeWhrK3BUc0lkb25qVjAxdDhUTWRXelhx?=
 =?utf-8?B?WmwxdW1FYmhGYlRqUGltMzd2UXV3bGhORnkzTTBCUW1UOUxFYnl0N2daOTNW?=
 =?utf-8?B?RmFMUnExcUd0YTRpa0hLRTVMcVVGanB2bkNtMHd2dUEwVlhrQWNhMlVWUzli?=
 =?utf-8?B?UFR0b3pFUUVJWU55eitKKzl5Z01SRk1MYkEwSThIbWFhK1RaRE5neE5BcFA0?=
 =?utf-8?B?WkxveVV1QWwweVdxaFlJV3pYeGZRQ1FWWlhRMC9tdXVzQytaUVk2V2h1a3lr?=
 =?utf-8?B?MnFmWThRV2kxT1REeGNLUkY3SmJGcHozK3E5YmFnVndkU2RhcjNhMkRucmlI?=
 =?utf-8?B?Q3NLTkZTNUoxZkQ2NEJSd3Y1YTZVSWt4aXJCYjk3TzY5Z2J3RjdNeWVWYWZ5?=
 =?utf-8?B?RW1kMEVoMFU5bUkzRjF2Tk9DNER0TTVodFVQTnBDVmMxVjVHYloxdWJqU2JX?=
 =?utf-8?B?dzFJa2VIWEVXeUNYNWdiVWFQUUdZZXhhZzdhQWVnVEpSMWpSK1hWVUpGd2pp?=
 =?utf-8?B?dXBlSW5zOCtqUVE4c3JURHI3b0doT3RzalVVejVKK01nd1p1cktzODVDUSt6?=
 =?utf-8?B?YnI1ZHRXV0xaL2xYeUNKdE1pMVZKWS9pMlNYZitFa1V4a2d4eWJFWWJaZDFB?=
 =?utf-8?B?dkp2dmx4a0F6TVZCQWNPL09uYVFWM0hxZ2NURTBUY0tMQm1VYk5kVEVGZjZl?=
 =?utf-8?B?dWZqWlpSdkpJcWYydmYyYS9NNWoxWTNQNS9PcEFlL1QydXRZMDFoT09KSGdP?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 173bc2ce-2e1e-4c25-4220-08dc8ecfc47b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:16:58.6944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/aTEWg3KG9p6rqhtm6bfoALZ5CMIYrBNatoG3fJICPmC3zDLzrDYjcGljohG7og34wE/ETIVtLTnzjuvWVrkXcZULMnXs4PVA4Z4epjRZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11007
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

Hi all,

This is a patch, even if the mail subject says COVER, some regression in 
new b4 release.

Cheers,
Quentin

On 6/17/24 3:10 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> In commit 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card
> when booting from eMMC"), the spi1 bootph properties were mistakenly
> removed meaning, so re-add them back to fix SPI-NOR flash not being
> found in U-Boot pre-reloc as required for RK3399 Puma.
> 
> Fixes: 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card when booting from eMMC")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   arch/arm/dts/rk3399-u-boot.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index b6b43271172..2bec139d833 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -145,6 +145,11 @@
>   	bootph-some-ram;
>   };
>   
> +&spi1 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>   &spi1_clk {
>   	bootph-pre-ram;
>   	bootph-some-ram;
> 
> ---
> base-commit: 2248c96ea1cf0b65377040d9f87ce7d8cf534c63
> change-id: 20240617-rk3399-fix-d8c8d3ce844e
> 
> Best regards,
