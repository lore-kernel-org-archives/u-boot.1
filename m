Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA95AC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 18:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100C282139;
	Thu,  3 Apr 2025 20:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nasublU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5618F82140; Thu,  3 Apr 2025 20:03:24 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E894A8212F
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 20:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS0vF/W7ljAg7Kao2EWzYRLqEA4tpG5u4CV29mYQi2kq5sPw2mWeIi4k2JCC4NYgGjhiZ+K+sUm05fpD3PaQQ0xN8KB7aEDpG7vblEHg94K2+DGk3Gj3qbsthKQ9B3hdCJn/hulY8dUdJaPd+uUGgs9wQRqaLlQ1W/fjJyF4jFmP/L6hVBlExEInsqTOROfZN5Nel6ftf7JffEFuQWMZD7PlZVeiYcCPm1L0h8RE6sYP9KivRfD5W1J+FQFOzLSub9UvVy93SyxqFb9mJeDiXAEKjaqwmJJ+WrMLAv3K3LwAZoHYlT8HFkpmSE2lDLJsvEaQc4GZoYXNHkDjb8d7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ocbapvQg2MtvcJHYzr4PsQaP5R68O94b7QJKpzclkw=;
 b=WvpY4OOXoK5Ske6iNMnpBcY5BLIkjnUDtdgM45ep4iE7Y2ReS4XWkpgqtSSxEJssxtRAqvjgihqR+YHXfpTFcKibuJ6+MIqwZIG69QtqJAiUxGk9Df0yDP6jRldUzKEAlYHGfkMm2S48O9w4yRUKWGrO6VlVoUpfTA0X2PYjJELoCeHuHk4FWi1mC2+HaI2ydj9yalsLTYHOkwacs/HB060kbbuEUcekW0djH5Kt6hF+Ix7TXsrKI2c+xa9/EfI+OcrEXJJ1Iq/pxYnX65DiodeH8f7m3fKCPDtEudqXSK1ni9uJhyOTeNkDT7UeAIrelbFzo3MWLZ2WfzR/P/0rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ocbapvQg2MtvcJHYzr4PsQaP5R68O94b7QJKpzclkw=;
 b=nasublU4QAhOnsH9boYo+HDIbnWN2fLGMtO4T96OlH3eHpVuTorJsp73kqPPXNB4gaH82saZ7DFL+R9zQ7GpFLCZTfZjwzlDiZ2+bs/cmsZzxFIX0419kyzKBDDOkdkcG7yeXf+U/G/yrA+eveme83sOHpop+QMXT22SdCBb/JY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8160.eurprd04.prod.outlook.com (2603:10a6:102:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Thu, 3 Apr
 2025 18:03:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 18:03:20 +0000
Message-ID: <708886d6-ff65-4390-9780-34449678615b@cherry.de>
Date: Thu, 3 Apr 2025 20:03:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
 <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
 <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
 <20250327234959.GS93000@bill-the-cat>
 <CAFLszTgqU_h+212y4GcXHrm+N7mUoZAaz+E2v3483wzTwNEWkA@mail.gmail.com>
 <20250330144526.GO93000@bill-the-cat>
 <CAFLszTjNwtmBqiDUQZPChXYMQei2spTMobZvAu3cQeMfJwNkkw@mail.gmail.com>
 <20250401171933.GN5495@bill-the-cat>
 <CAFLszTiCYaHC1edV7kHF3rpzmtTvB09U8Z7txP_QAVaHu1=uag@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTiCYaHC1edV7kHF3rpzmtTvB09U8Z7txP_QAVaHu1=uag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b739dd-5b41-4923-95ae-08dd72d9d118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGZ3L3RvRy9PYjV5U1lLcjl3em1FUTEvUVNSbDBQM2lTRm85MEpvUVFCcTJ3?=
 =?utf-8?B?UFhmdExhb3ZMQUdwb0hxSGcyU2JVTVhpYU9zbjMvbllQNllZS2NNUTFIYy9k?=
 =?utf-8?B?UVNtcENzaG1lZUgzNWZsNmJOeFRncElGUWJEWGxuTEZPakZ1SzlWM09ZY2pW?=
 =?utf-8?B?eTMrMFdnM01Gd2ZyUUMrS3ljQnJtcFowWmg3OW5kT2pDdFhMREdNTUVwY1lK?=
 =?utf-8?B?OW10YjZOcjlXTHZ4UHNXS3dOeVNkSzlBdEI3VzdOeFZMcEJNMVlzaEdhWUxS?=
 =?utf-8?B?ZkpiWC9raXNwSXFqby9WV1o0MTVaWS9FTnNqWWUzMjByd2FQbnlSc0hQazQy?=
 =?utf-8?B?eGpvZUQySjhpbVJ0ZnpRYVlqMlRJelpBTHJ3aE5xbDlvZDRweE44c2tGb3Fp?=
 =?utf-8?B?TW1Nd3VQMHUrdkdkd0FJRllZcmZVc3l6aXR6MWFybVlxc20wUEUyaW9OeEcy?=
 =?utf-8?B?MnlFVjNtMW1ZVXJUR1ZMMGUrcTJaaFM5OE9JY0RrWUdFUkYyNTRwOWxmK0Nq?=
 =?utf-8?B?akh0Z1ovOE1tUTFsNGVRRVV1clNIOXM4UThEak45dk9Sc2tFRDdraGFubmNH?=
 =?utf-8?B?cU9sSFZMTm9NUklweE5WcFZXWU5TMG9vNHNyL3l0Wk5lWWM0TEtFSkhBd3lL?=
 =?utf-8?B?SGppb3VURkpHL0o5ZG1yb1dQTmZvQzg4OE5nOC9VS2Y4N0p5Z1l6ZFg4Z0sz?=
 =?utf-8?B?Zy8yTE54QmtoMTlYUUxucEVXL2VLc2F4NnVKL3FVbzZKcklCcGQ5YUkrM244?=
 =?utf-8?B?amplSm81cWJPVE1JQk5CRTh4NmhyYTl0Ymdnc3RQTDA4Z1IwVnBtRE9CNk9p?=
 =?utf-8?B?YTFvWGxneHFEby9QVEVOQzlRTWtMV0hjN3phaGVub044a0FkMXE3OE9xdnlY?=
 =?utf-8?B?S25tNE5maDFTb3k4VWJtMXBKeTVtWE03YlJ3bWFSaVVKY2dDbDZmRHpMTFRu?=
 =?utf-8?B?czU5Vzhwd2IxSTI0SHBFdnNIalRGNDlUeTg5VjIzS204UGdjZGZMcDdTNk1m?=
 =?utf-8?B?Y1NRRFdHcmlNYTkwZjlUdnRhR25jNlVvRVNtak9lakp5dDVMa1NKTC9YRkpn?=
 =?utf-8?B?ekVVcDcyUFRGMnNDWDEwNmFjdWlkSjZ0RDV3dHFJS1QwKzJ0UDhqcy92TUJI?=
 =?utf-8?B?SEFhYVZpVnhRT0VmdmF6UGpIaW9Db2Z4RWN3Z3JKYXlwSGxxUWdnNEZzL3Y5?=
 =?utf-8?B?SjBWTUZzeDAzYUliQzcrNVEvYmN4NFlKRUMyTm4xc3N2S3hYaXZRdlA2TnE3?=
 =?utf-8?B?YTdlOVZPNlhUMS9XeWV2dHNCdTZQelFXMEZuMk9ySlFWUVNsbDVQTXpueTJt?=
 =?utf-8?B?TlRJcnovd2U3Mk9lcDhRdTd6ekFaYkt1MGJBcnR3T3FmeUY3QkxpdVEwTHBq?=
 =?utf-8?B?UlFBTnJTZlpUc0t0TTBZSkxnQVVqd0FiUG5qUVdzMnN5aWdMTWM5dHZ0RzZN?=
 =?utf-8?B?Wk9MY0tENWxlcjBENm1CbUdLTldDOWFlSmpzR1dtejBPL2l5STFuL3ZMZ0JK?=
 =?utf-8?B?Wk4rRUlMQ3hpU1NTWUdxckM4OHdmOXZKSEZEZVluSGsyTXZJUDVoT3MwNDdD?=
 =?utf-8?B?RmE4ajI5RlA3VGFuYnZTY2s2ekRZMlNXSXZHSDdKR2dxc0VtTXVtZ21FczB4?=
 =?utf-8?B?NFdhb1lKdWhMYTBwYXNZSXZzQm8zeGVvQ2JIS3BLdS93MWhxbysyT1IyZnUy?=
 =?utf-8?B?UVZVZ0JDdGNGa3R5eE9OZEE4RWxFZ1VTVXk5c0RyZU5aM2RKTjN0dTBoUWpY?=
 =?utf-8?B?eW5mT0hMWUNjUWM0UUN5VTc0Q1lHcEl6L0RiekF5Y3ZkV0JROFJBQ1lWTjh5?=
 =?utf-8?B?QnpiSzJuTTZyRHRodnhicFJ2R1IrbTloSkpHRWdUZmFuZjFZUmhHaVRUWWVh?=
 =?utf-8?Q?fmlfaHc5veVhv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NZOVVOQ29pUHpNcGxpdHNKbDJXZFFUam5FazVOaHJHK1NDS1FndTZWdFlR?=
 =?utf-8?B?WWZDMldnLzlnQ01BN0hxdlBrbCsyUXU0OWo0SytiYVl0T0tRbDlVelJIdUVk?=
 =?utf-8?B?WVpnbFRIRGMxQTBOelNyK3V0K3NncFN4RGtzOC9PaDRiSlh4R3FGQUJKdEhk?=
 =?utf-8?B?K2hJaVNhY2JabHh4aEtPbVA2YnNaRTVZUmMwcWF3L3RkVXAycXdRbys1d0dh?=
 =?utf-8?B?a2VRZlRPZndPWVBCUWdoR0h4c1p3bTd1cXRpSTVXSXZWNFZveHdmSmw0eXFD?=
 =?utf-8?B?WXNITGJac3Q4Y0RadU1PU29hMENPNHRDSjRxQ004WURwL1E3RDhxWDg1Y0Zh?=
 =?utf-8?B?Nm9WSkRGNVg5UzRUbngzdFVVRlF0TlNNcVdveGNOellhQlc3cStDSmQ4NENn?=
 =?utf-8?B?T2NNZkxSM0dhb20xOFZ1YmRoOW5PbmNoeVBUWXFzSDFyQXh0QWNvNHo0czdy?=
 =?utf-8?B?bXhPemZCc3J3Tlh2L3p0NXhPQ2JheUs1Q2I5SDRMZnhOLytJZDgwOTQ0VTRq?=
 =?utf-8?B?K1JQY0FQVHlzSjh3RWJ4Uk1yemZrZk93czFraGJGVmJ4QkNEL2dUNzBmZTVq?=
 =?utf-8?B?amcrSnJDcVJmYmg3anNEQ2hHL2NMNG9IT0IybWczK0d2YUF5enZVZ3d0NE9u?=
 =?utf-8?B?NUtNbGs4QmhDVWNZNytvQUMvNW5lclhmak50cUJ3cXBDUW1qa3J2ck44amRa?=
 =?utf-8?B?YllRYTdZMmk2R01ETjZYTGRjRDJ4dk5CS1BuOTdKMmZzNW9hUkJPK3JFTHBE?=
 =?utf-8?B?Z3JFT1hiWVVIakpEdVc3R25BQnJnY04zM0VGUXdQcGVTS2xmR2RJS3JBRnVp?=
 =?utf-8?B?V1pSMjEvSjA1T05HbWZnWWlmL2plQloyQStlYUJVako0bTZrVnA1dVhFYW9T?=
 =?utf-8?B?dHY3RGI0dmNEQ3p2QlAxbmZXMHZSc0t5VjIveU0wOEtySVJHQUJyRWFTYmx3?=
 =?utf-8?B?UFNmRVpjOE5CK3d4SXRKd3FRMVBSNm1JY2tPT1NFNHdqL2tqNk82MlM5Vndo?=
 =?utf-8?B?SmFBSUhSYnkyOWZSTVRXWjN2bmRjQzlqdWgyZm5nY3dvdnN4b25WaEo2dmlO?=
 =?utf-8?B?MlYvdVhiR21RZmUyQ05WWFlmOFVicmRkbEQ1d0FwSlRGNTRnWmt4VmFqdWx4?=
 =?utf-8?B?dm04MDJPUCtCOUlPanQ3WEVZTytLanFNRW5ubzhWWERWZWpkYzl6QXAyZTJ2?=
 =?utf-8?B?WHMrYjkrYkpEcDZIdmkvejRuanpQTGdLZmd1SElTQU1FTWhnbWNhWmRBRTc4?=
 =?utf-8?B?ZjVSSldXaTViQ3RLY0IwaUIyRzdISkRVcHBpS2dIQUxPa1dFQU9pYnNCdDA0?=
 =?utf-8?B?cUx5UkltRlZ3YTF5ek15YVREZkU3MmRVSEpSNG1TL291SWpBRnZrSEZ4Qkgx?=
 =?utf-8?B?MHhpZUUwSEh2MXNoYzFpS29sSUd4enFRb1JHc3IwM1lkN0N2Z0J1RFduamtk?=
 =?utf-8?B?cThWaWdXRWd1bnBheWRrZUtpOEpGR2krVWM3RlUyS05zb2JRZC8zT2V3KzRl?=
 =?utf-8?B?NnRHSlRYOU1CV3YwWk56TEdHS2VvSkVBVVB1TXZ4L2tWcmxpekw4c2FOMEpn?=
 =?utf-8?B?c2I4Y1hXQWpNV2liUkI3MlBLcE0yR2VERFRNUmhxeFRjc2hZeG5ZN005VzFY?=
 =?utf-8?B?eXlBVXh3QjBxendyS0ZQOVJEWEpuUU5NYnJjanNocXhxNGNTQURINy9ESE82?=
 =?utf-8?B?WDIzeGl2TDgzQStNcUpCWFJtaDRmNXVWZ3RkUm9IbzdHV3RWeE4vN0tFVU9M?=
 =?utf-8?B?NldpTE03VTNoUy93azY0Y0FadHdyKytlbFJNVDRLZk1ZVko3T2NNN0l0REZp?=
 =?utf-8?B?SjQ1WG94VnorMGRvRlFVUFV0TW1DcFlhR2hpSlFsYlRFOVpNSGprODg0Tita?=
 =?utf-8?B?dnU5bVNjNVB5Y2xtZHVSZVZ6NU1JTWVPTUY5L1FHYmlTeUMyZTMxRE5hbVVk?=
 =?utf-8?B?Nm55TGdOWVJONGxCVWRnWDh5Z2tEa3lkOUxudWN1M1JkWFN5MnN4dGJjVFhJ?=
 =?utf-8?B?ZEw3ZTRzL1FpMmoreUMwYThYU21qdDZ0ZURZVlRWbHBuaTQxVGJndm9Remth?=
 =?utf-8?B?RHNpdnpVdE12Znpvb24xeWYwNGI5elV1bFN1WlJUVlZUZkNrZ25RZksyR3Fu?=
 =?utf-8?B?VDIxWnh2U21aK3I1dG5rZHhOZGlFUlZUdjZ3U0xoQ0NEMkhtaEpnMWNzbVRI?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b739dd-5b41-4923-95ae-08dd72d9d118
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:03:19.9670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niaNw77DvobsuOQZ97H68Lc2NOFdGPoXIrrRyztFBZA5GK2J7Mx9LOmV+fCmX4nAifeqjOt0MCX5V7QeYad8Cf7wnN7JPcUtgvZZ4iSYOi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8160
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

On 4/3/25 7:57 PM, Simon Glass wrote:
> Hi Tom,
> 
> On Wed, 2 Apr 2025 at 06:19, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Apr 02, 2025 at 04:48:35AM +1300, Simon Glass wrote:
>>> Hi Tom,
>>>
>>> On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Fri, Mar 28, 2025 at 04:44:53AM -0600, Simon Glass wrote:
>>>>> Hi Tom,
>>>>>
>>>>> On Thu, 27 Mar 2025 at 17:50, Tom Rini <trini@konsulko.com> wrote:
>>>>>>
>>>>>> On Wed, Mar 26, 2025 at 10:46:57AM -0600, Simon Glass wrote:
>>>>>>> Hi Quentin,
>>>>>>>
>>>>>>> On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>>>
>>>>>>>> Hi Simon,
>>>>>>>>
>>>>>>>> On 3/20/25 4:26 AM, Simon Glass wrote:
>>>>>>>>> Hi Quentin,
>>>>>>>>>
>>>>>>>>> On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Simon
>>>>>>>>>>
>>>>>>>>>> On 3/19/25 4:03 PM, Simon Glass wrote:
>>>>>>>>>>> Hi Quentin,
>>>>>>>>>>>
>>>>>>>>>>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Simon,
>>>>>>>>>>>>
>>>>>>>>>>>> On 3/19/25 12:49 PM, Simon Glass wrote:
>>>>>>>>>>>>> Logging of function return-values is used very frequently in U-Boot now.
>>>>>>>>>>>>> Add a few helper macros to make it less verbose to use.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It turns out that the log_ret() variants are not so useful, since it is
>>>>>>>>>>>>> not obviously where the error is coming from. So only the log_msg_ret()
>>>>>>>>>>>>> variants are worthy of these macros.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>
>>>>>>>>>>>>>      include/log.h | 26 ++++++++++++++++++++++++++
>>>>>>>>>>>>>      1 file changed, 26 insertions(+)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/include/log.h b/include/log.h
>>>>>>>>>>>>> index 4f6d6a2c2cf..bdda7af570c 100644
>>>>>>>>>>>>> --- a/include/log.h
>>>>>>>>>>>>> +++ b/include/log.h
>>>>>>>>>>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
>>>>>>>>>>>>>      #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
>>>>>>>>>>>>>      #endif
>>>>>>>>>>>>>
>>>>>>>>>>>>> +/*
>>>>>>>>>>>>> + * LOGR() - helper macro for calling a function and logging error returns
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * Logs if the function returns a negative value
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * Usage:   LOGR("abc", my_function(...));
>>>>>>>>>>>>> + */
>>>>>>>>>>>>> +#define LOGR(_msg, _expr)    do {            \
>>>>>>>>>>>>> +     int _ret = _expr;                       \
>>>>>>>>>>>>> +     if (_ret < 0)                           \
>>>>>>>>>>>>> +             return log_msg_ret(_msg, _ret); \
>>>>>>>>>>>>> +     } while (0)
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +/*
>>>>>>>>>>>>> + * LOGZ() - helper macro for calling a function and logging error returns
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * Logs if the function returns a non-zero value
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * Usage:   LOGZ("abc", my_function(...));
>>>>>>>>>>>>> + */
>>>>>>>>>>>>> +#define LOGZ(_msg, _expr)    do {            \
>>>>>>>>>>>>> +     int _ret = _expr;                       \
>>>>>>>>>>>>> +     if (_ret)                               \
>>>>>>>>>>>>> +             return log_msg_retz(_msg, _ret);        \
>>>>>>>>>>>>> +     } while (0)
>>>>>>>>>>>>> +
>>>>>>>>>>>>
>>>>>>>>>>>> Mmmm not sure this forced return call is a good idea, this would forbid
>>>>>>>>>>>> us from performing some unwinding for example.
>>>>>>>>>>>
>>>>>>>>>>> Yes, it is really only for simple cases. Without the return, there
>>>>>>>>>>> isn't much value and you may as well not use this macro.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I don't really see how that is better than simply calling
>>>>>>>>>>>>
>>>>>>>>>>>> return log_msg_retz("abc", my_function());
>>>>>>>>>>>
>>>>>>>>>>> That's not the intention. It actually replaces:
>>>>>>>>>>>
>>>>>>>>>>> ret = my_function();
>>>>>>>>>>> if (ret)
>>>>>>>>>>>        return_log_msg_ret("abc", ret);
>>>>>>>>>>>
>>>>>>>>>>> I use this a lot in my code. You can't always just return, since there
>>>>>>>>>>> may not be an error.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I see, I read too fast again. Only return if it's an error.
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> ?
>>>>>>>>>>>>
>>>>>>>>>>>> If we were to keep this, I would recommend to rename the macro and fix
>>>>>>>>>>>> the docstring because it does not only log if the function returns a
>>>>>>>>>>>> non-zero value. It does actually return.
>>>>>>>>>>>>
>>>>>>>>>>>> So something like
>>>>>>>>>>>>
>>>>>>>>>>>> LOGZ_AND_RETURN(_msg, _expr)
>>>>>>>>>>>>
>>>>>>>>>>>> maybe?
>>>>>>>>>>>
>>>>>>>>>>> Sure, longer names are easier to learn, but then it is so long I doubt
>>>>>>>>>>> anyone would use it.
>>>>>>>>>>>
>>>>>>>>>>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
>>>>>>>>>>> log_ret() and log_retz(), which I am actually thinking of deleting.
>>>>>>>>>>>
>>>>>>>>>>> I would like the shortest possible name to avoid spilling functions
>>>>>>>>>>> onto the next line all the time.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> It should be absolutely obvious from the macro name that this can in
>>>>>>>>>> fact return because missing to unwind code is among the things
>>>>>>>>>> developers typically easily miss already, so with this macro it'll be
>>>>>>>>>> even easier to forget about undoing things.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Yes that's true. We don't have a huge amount of tests for this 'undo'
>>>>>>>>> code either. I would bet that a code-coverage map would show that.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yeah but that's not a reason to make it even harder to spot issues in
>>>>>>>> the undo code :)
>>>>>>>
>>>>>>> I suspect people will just have to learn the macros, as they have with
>>>>>>
>>>>>> I would ask "What kernel construct have people already learned and we
>>>>>> can adapt inside the macro?".
>>>>>
>>>>> Is there such a thing?
>>>>
>>>> Likely so. This isn't some new and novel problem, and it's likely more
>>>> people have put thought in to this and come up with something well
>>>> reviewed there.
>>>
>>> What are you referring to here? I am not seeing anything in Linux
>>> related to this.
>>
>> Then it's probably more pain than help in getting everyone to write code
>> that handles wind/unwind/logging consistently and correctly and no we
>> shouldn't wrap this up in some macro.
> 
> I don't have my heart set on this patch. Having used it in quite a bit
> of code I think it has value, but it has drawbacks too.
> 
> Quentin, what do you think?
> 

I don't think the balance between brevity and potential confusion is 
appropriate here, I would prefer not to have this.

Cheers,
Quentin
