Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFCDCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E9F83678;
	Fri, 24 Oct 2025 19:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NR6Pspis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10830836D1; Fri, 24 Oct 2025 19:00:06 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B1A683677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN4WxFPxaMHXserEig3J2F5gGCa4CPdWP/LqqziUZaPPidMbh8c9V3wKfnq4MGBgVA8WIb7f599cnMWlrDNvq+sz/VBdX5izpX4NW457QWaWpGhtFr+oPJfbnNZwMQMnsHwCyasrpIvcVxvRpRCGaHbgexcfw3kAt202dyWIAqQaD19/w3Z6KZsqAvPX6pgBq9OMCXtLT3GsUiq/Tl2gUyi7FZVP33fS5RY0ToD5WalFg2lugl++z7R1SmBG6ZiG40twoDOTY3Q04pF77Njc+lzgvFoL2OBytoYVWIKkv2CNAlI3Mz0boOkuPSwtD3UrdxcBxePp3GbkSDuUtkI5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvxLsXcxO213bz4w/DnavqvaZXpj41fczqDUwn69Cks=;
 b=LVWkuaFFYJxPSoawegw3d24XZAuF5hHUfIsRFHc8yjpHLxNNEtXKDBtM9taNGnmvuUzIbert+wJM6mhjbTt8qpvrZX/DrXIXO47uhtT4xUByzDj7n11Yh7h5wvH5X0WIE67MLfhsYurvSXIbirV5HGy44s20bI/TSuILtNVbjhSxcN6KDh3wU1x9o4YWGP60M2zi52zxQs8DjAosw8ZLr6jaUsI7G+fktFNNVPicZSNzsXhLp3kB9FPmIGFU85iV+aAcp4QBFDdMp0NbIZzSZ8iM3pRswEtd1c9TIwxzjHlwFGetCsJIaMQgl4iKzlGmychPH6XTgc7TtkilHSUXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvxLsXcxO213bz4w/DnavqvaZXpj41fczqDUwn69Cks=;
 b=NR6PspisuyKqCxRw5Cwml/2fghSms6AbisZ+n1v//8xuiGw9hK+kEutstmUYAuOnUGgkathoYKeaU3bx4Bp8Doh8Oph0wxMeKogNkh6TJ7YzP0jcsTCBJruB4/YLei0GONbLbbk24p91m7N7IE0DKkoJcZYfkTubjy/O7x6JgVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8688.eurprd04.prod.outlook.com (2603:10a6:102:21f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:00:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:00:00 +0000
Message-ID: <d41cd78a-f585-40c1-ba14-095ab7cc7f5a@cherry.de>
Date: Fri, 24 Oct 2025 18:59:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] doc: usage: Add general rule for `$?`
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251024160557.2317081-1-trini@konsulko.com>
 <20251024160557.2317081-2-trini@konsulko.com>
 <b79c4e53-e7f7-47bd-9134-4943ef2e5138@cherry.de>
 <20251024165522.GQ6688@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251024165522.GQ6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: 55271d89-72b8-4bf1-0c8b-08de131ec4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnlFYVBhYXNvOTY3aTE3T3UybWFaYWRaOGtnSTRqV2RJM3l4cWVTZmJVM2ht?=
 =?utf-8?B?eTJBdjNjM1JnRXc4WmF0OFBxeTRxSkg3L1JnOVg5ejRoNUYxeG96MmhWVytK?=
 =?utf-8?B?NkF2YUl3WkVkUmtmWk5keUpydzlJVXBqZXRFVVl3bC94L3JzTEJFeFgwQTdB?=
 =?utf-8?B?T0x5YWQ0Rnkrc3B1ZmI1bVNNMWZqTkk4M3RnZEUvM1hIcHRscVV0Q0dqekJv?=
 =?utf-8?B?NGhjb2dxanUzYWRaM2kxMGVmMThSazV3WnljVXROVVRsVVJLOE9XWE1xUEdJ?=
 =?utf-8?B?RExNc0IzUS90Yjc0OVhsS1pOaFRjNE9GWU8zMTJwYUM2ajV2ZTdoSndOVmxY?=
 =?utf-8?B?WkJPa2RGcU1iZ0xlWVp3QmN0aHdKOVluNExjbFRxejZZVU1xS0trQXdqOFNY?=
 =?utf-8?B?OTgyTDh0WmxaZTAvUkNobHBPa3h1L1E2a241TjdjVEVIWWNuMFNuYUg4RkZr?=
 =?utf-8?B?V1ZOZzgraVQ0V3lTdmRXRGdYbGtaOUJLQTQ4MGdVaFlIT0FxT283Vk5YVkJB?=
 =?utf-8?B?a244Q3ZsKzVYWTFqUUpYWWdHL0QxTytXR2ZvaHc2WEhXSUFOVlN1OWVScDcy?=
 =?utf-8?B?TEhjTytBenpQMWFlRlZiRm5rNTg3SXRYL2RwZGora3dtUFJYN1NCTldUbWJ3?=
 =?utf-8?B?cFpQMjBSOXJ2NzVTUUIxTEUvQU5ZWnQ5L3BpVy9KajFZYUZ1MHd0S3VjRjdp?=
 =?utf-8?B?amtIalVpSUhkSUROUFpObmc0SjExeHNvQUkrbjJRbzBFeFY3NzFPT0dBS0N5?=
 =?utf-8?B?M2lEMVFsejdMNzFJU1Y2YWFVN3RwdC8wRzNaZ21qbVNUb2RZZGRROEdwVldh?=
 =?utf-8?B?bTFkWXNVdTEzbGRqQWNmNUtRekhWSFJEa01qS0JsMklhUkRFM0hOT25xRUlE?=
 =?utf-8?B?OWtoMlVBUysvK1RSdEptZ3pWSU5GM3NQdkxNbmd1RkVOWlczUFNOMmE0MGhv?=
 =?utf-8?B?cnhPVnpxTnFUanVEUElpNzdXNGJpRlF1SHFDdXRyVE9zdUV5NGQxVVdvNTJt?=
 =?utf-8?B?bVV3anhJL3JYSGQ0VTFqbFBlaU52MTNmOHZyU1B0RkJoV0o5OWF3MXdwTUd1?=
 =?utf-8?B?dW5BemVKcGdpd2dlcmdtU0lxTU5iUGpwaGFDUlZ6cERaS1h0TkI3V0NlRDIy?=
 =?utf-8?B?T245SEh5bkM1L3phQ0hRTFB4WE1VT2llRFFWalhqbVpLWVJ0aDliTFdIa1Vr?=
 =?utf-8?B?RnpuZ2hEZjRSWStTSVFyUHNkandtaDMzaENpTzlVa3A3WXJNNXNKeWsxRjhW?=
 =?utf-8?B?MDlPTDBRa09HOHpobWc3Tmc2cUtta240VkwxRGFKcmNadG9uSEhXSE1MeEZz?=
 =?utf-8?B?SDhrVGd4Zm5VaWlzRFRFT0RtRTM5Q1VHd0d3endZYVNscFhIcms5Q3N4T2h5?=
 =?utf-8?B?T2hveU5EMFlrSGd1MDMvd25jR2toRWo3KzhYdmlKb1B3RW9CbmZPMXZLQ2RH?=
 =?utf-8?B?WGFCNmRwMUdPMGI0SnExOTY2aGlNek1ndW1PLzU5N3F0K1JDYzcweW9Cdm4w?=
 =?utf-8?B?aVNtOWxUaUNaZkVhN1RKYVlIVXZ6N3dZN2EwdGEyS2dlL0EvV25CaVZDL2ZE?=
 =?utf-8?B?eDJpNjNmMWdGcG5ZZW1PcnZOUXUvUHQraWFsenFUYm9UMUZ3TzRoa1VSaFV3?=
 =?utf-8?B?eDdPdmt2SlBnUWdvNG5ETWowN3krSHA4M1IwUzJsYnY2WHVVY0hFVE5maWw0?=
 =?utf-8?B?T2xtSUh0RXlQMmMrVk1LdW12VWtXeGdyMGQwR3JEdGMrSkMyOEZyTlBuVUxJ?=
 =?utf-8?B?Q2d2ZWVUdWJrZkdScHpJZ3E2c0dhM2ZYRmh5eFUxNEFxdU1mL09hV1ROK3RP?=
 =?utf-8?B?ZlJmeUtkUEl5c2pVemkxRUt6eDJHV3ZWRjRGVURiU3NVWTJmTXNQZkxwUjlO?=
 =?utf-8?B?NnZZakNMMGVQTXoweXExTFBKa0hiTTRwVGJIVHc3em1pT0dtU0NOZkwxajJO?=
 =?utf-8?Q?fymM8+xf8Qqqq6jLm+9Dt1a1QukB71SJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXJXdlc1THZJMW9kNDFWaHF2UnYwSlovbjliR080ZnFuRHNGbkdqbS9WQXBW?=
 =?utf-8?B?WEpjQU95SDV6bEhYYmh3OXdoTTdNOWk1R01LN042RElWRXBJRjFpVmZoOVg0?=
 =?utf-8?B?NnRvcHVwU1BVOHJDbm1DVzU2NmgxTEIwQUdsRVcvZjhPSkxaWGs5cEFxYzk2?=
 =?utf-8?B?Z0xJVVJwakV3SkhRaUtyZjNINkJ1ZkFCUXZ0azJZbzNvdDBtMGZycGZ1SldQ?=
 =?utf-8?B?STNqZnlRK3VUOHFXY21Wai96WUZUQUlDWGtVcnM2RlRDaXh3UlNxWmN2S1JB?=
 =?utf-8?B?cVRJNmtVOUlzVjFlclBOQkR3OGRXNnVSbE5KR2FGbHFVZmFXUk1KczIyWWNx?=
 =?utf-8?B?Tk9NWEFpRlJ3K1F0MHpwOWlkWDQ0OFR6cktoMDJWb0tYWmFwRkhMcEowREtK?=
 =?utf-8?B?d1Fhb1F4bEo5UjhZTkZmeGJXUEg1aGJpdHVJNEdsQXYrRFdva2R2dzUyWDdt?=
 =?utf-8?B?Z1dHeFIzRytEUVhPM0M5UExiL2tzWlY4R0U3dWdYQ3owSUl1Y29vdEtuU0oy?=
 =?utf-8?B?WkNsQlZDcDhhOFVMc3Y1aVg4NWJOM290V1FZU3F6ejd5SEVyVlJIL0xlMGlh?=
 =?utf-8?B?RzVRVjVQQmlDcWMzK3lJUHJ2a1VzenpNTnlFcXduU2svcHE3clc3YmhnUyto?=
 =?utf-8?B?MXhISEdPS3c1b0VYSk9WdkNlTFNzL0hYTi9TRVdwSElBd3RQUStycWs3YkJq?=
 =?utf-8?B?ZEVpWjU0SW1FTS9oOGQxRzZJTXlUcWc4SmF1MEg0SVJMOG8xNGladENrTzVL?=
 =?utf-8?B?UUdpSXFTRmhnQVNTVTJzaWp1Z0Q4dzdXUHdlS1I3VXFQeUJZTUNWc3ZvOW53?=
 =?utf-8?B?VFJWRFdNN1FCc3RBTFluOGZueHprWmUvVlpzVmZOK054UzRjQVczUjlmaE96?=
 =?utf-8?B?YnZZS3hQL0Z3UlU4UFNKcHoxbm1rVC9ZR1NkanRSdk9QUkphbHE1dDkrenFV?=
 =?utf-8?B?VWxDUzBReDVLMzBiVFJxMVhIMjRZL09HOXlGUnJKWVFOSE4rTlFIeXVmT0Vr?=
 =?utf-8?B?WHRiSDVPRHYyODllbW0yaTZWRks1enc3ditNWGRJL0cvU0w1VjlSNFpjY3Rw?=
 =?utf-8?B?MkVZY0FTYXRFSGNXb0lSZ2lvdmtFUzJHRHZvOHdRemFBL1B5NWE5dWU5eWxG?=
 =?utf-8?B?dEI3eDgyeFhlbnB6dHFDTktKdmEvVGJhSlltWnVlYXNxNDQ2NG82L0RtQnN1?=
 =?utf-8?B?MnZkNHIvYnlOU3hVRm0yTHdOZ2hubGFoQnJpWE9UZjM2MitmTVBQMi9zUnZR?=
 =?utf-8?B?TWlTNmxpSy95cGU1QmNqdmVrY2IxNTB1TTJUSlFHVHUrVkdlZk4wYUdESTcw?=
 =?utf-8?B?Vit4UDNCcFI2V0FUY1pPWTNhZDJ3S09jUzhUUnp3ZFcwUW95Y3c0VWJkY2Jk?=
 =?utf-8?B?Sm03NGtteEtOM1E1ZXpvU1RMUG5HWEQzVWVrcjVqbEpxMi9ZelZ3WWRCL1Ft?=
 =?utf-8?B?ZFlyTVVFZjQrcnZtZENod0hycXIwYWQ4cXBuU1BhNXlqVHpVQ3gzbHFURWFa?=
 =?utf-8?B?MkEwN1dOTmlhQVA0UXNHc1RpZXp5NXdKbGhWTml0UHhleENIS01lYk9US2xh?=
 =?utf-8?B?NFRXL0N0dkpmWmI5SUNGTEZJazJUa2tTUWFERU5WV1c2RWNhN01USmJmekxk?=
 =?utf-8?B?T2tlTEkrTmZmemlRTGpnMDVCQm1OWVJSL3lVYklRckMyYTRmMThJYnBGQXZH?=
 =?utf-8?B?SXhFY2JJbE5icGFITVRQTm9wb0NDTjhRTW02UCtkbmphclRwOUdSck5Fd0U0?=
 =?utf-8?B?QUJZM01RUzRBR2pNQ09OMzFqc2g4ZERRSHJocklDeEFMbEVKUzJyem50UkpW?=
 =?utf-8?B?SU1mVDFJeDl3VXN6SzF5alhpNUVkOVpsMVdMZVB5TVZYb1I2SjZxVTJQSzZX?=
 =?utf-8?B?S2RmRHl0bFBhUVU1UzhnYWdkTzg2TjVKTDdramxock1Jb0tpeEoxMXhkY3N5?=
 =?utf-8?B?ZG5ycUtLK0RXRC9wK2grUGZ4aGlRUnd5MDU2Y1Q0ZVZXN21ORlprYmxsMWov?=
 =?utf-8?B?Smg0SXZuVnVRY1NNaStNWjkrcTVzelFOdENuOURURXBhRFZabmNHOGNBR0tF?=
 =?utf-8?B?eTZwOTUrYXpYbkQwMUhPYTZpOUNJdmN0dHhlaWpxcU4rczNkckd2d2xEcm5k?=
 =?utf-8?B?MFZSckFrMXBYbm1FRnh3NFQ0eDlxT1M1VGZRZkxvOVNQRHMwQ1VwNkdOQ285?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 55271d89-72b8-4bf1-0c8b-08de131ec4bd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:00:00.5184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2VrSRpdfzs00s5BPYv8UYtmjPu7zAsNjBSNyLMfpXyJGpmxfulE3LB7FfxHhlzHOd14yW1I/AZgG4Rk5jkKnx5IloM5nkPEoLcp9Ftl4oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8688
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

On 10/24/25 6:55 PM, Tom Rini wrote:
> On Fri, Oct 24, 2025 at 06:47:45PM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 10/24/25 6:02 PM, Tom Rini wrote:
>>> For nearly all commands in U-Boot the '?' variable is handled the same
>>> way with 0 meaning success, 1 meaning any failure.  Explain this in the
>>> general rules section of the cmdline documentation (with a link to a
>>> counter example) and then remove the redundant wording from most
>>> commands. We retain a section about the return value in a number of
>>> places where we are doing something such as always returning a specific
>>> value or we have useful additional information to go along with the
>>> normal return codes.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Changes in v2:
>>> - Rewordings suggested by Quentin
>>> - After confirming that invalid syntax also always returns 1 and not -1,
>>
>> For example cmd/scmi.c do_scmi_set_proto() can return CMD_RET_USAGE which is
>> a -1 enum and the function returns an int, so I assume this would be
>> propagated properly?
>>
>> I don't have time today to check the cmd function call stack to see if it
>> is, but this seems odd to me.
> 
> I spent a while Tuesday trying to dig in to this. We always pass
> CMD_RET_USAGE internally, CMD_RET_USAGE is -1. I ended up getting stuck
> on where we actually set the '?' environment variable. I don't know if
> we have ever actually passed -1 to the shell. Testing things out in a
> real shell, "2" is the value of invalid invalid syntax for a command
> (e.g. /bin/bash --keyboardsmash;echo $?).
> 

Curiosity got the better of me and I believe we probably set it from

get_dollar_var() in common/cli_hush.c where we do

sprintf(buf, "%u", (unsigned int)last_return_code);

which anyway is an unsigned int.

More things to add to the todo list for next week :)

But I did verify with askenv and indeed the shell reports 1 in $? while 
the enum value is -1.

Cheers,
Quentin
