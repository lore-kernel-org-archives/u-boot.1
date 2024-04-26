Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4378DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 09:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE1188FE8;
	Fri, 26 Apr 2024 11:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="j0HGH/b1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63EB8903D; Fri, 26 Apr 2024 11:50:21 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F18D885C1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 11:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hqy8FtirVRvaSIvcN0hxyRsATF+XwrzcC6a8Y/48KyB3c/jxms5f5K93hOFHgTqW2MJZ/s6G7KjbKa7aDNv+B3NfHNLJauo1fw05aLgXnKlR94Bo8gSKDMp+kJRIiLqp0yGoJ0kFtac+bT8hhoI/BZVlcxDA8/2K8ew9I3IAAmEdDgs1mIQ3l05x+JAY0XA6SigAq9LQudIu3cj8p+mklMY4Rtzt438OvOLaAO6z7CUBSLUOKxlbEMrzXQoTdM7Q4C1BlUim6VGGOPA1nxHJp8DLCvaViLojKleYlxf+Wz+9ea6wlPuBQvReeVn8eKt6y1kfdkRppsTh2rEDCMvFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kiNKXZtrEDTBGpZZFViIC8NvguY63ET6nsREvPVgD8=;
 b=ZnwduMjnB/ojYs4ARCS+ztH4iYQOxWg+VPzUwvTjwTkdi0XiA1deymlt7Jzclcy0nGUjHWFyPmkTQfTDji2Tz+L8kIevyYgd7J3DDI53olrzHb8fg8s1953N2MmJskYz3+5Dylf1Cajb2KiVIrG0UWRF2XgIrs8W8mBLV9y4MV0t0X4hfdmrkotmRzHFddJqDMqWzS0z/NFqdca1E+sHp5MIDEvG+ZdQOEsgT2fQCz2dGpn0AlXCoK/nxwQGBe56fQAy4V1FlUcZTYjP5FeBBlYVE/vewAwki2oXvpik9hHIlc2exJJH/KQcd/q1BuN9Cbgt6j++Bsfmpi50SpNlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kiNKXZtrEDTBGpZZFViIC8NvguY63ET6nsREvPVgD8=;
 b=j0HGH/b1zIj1/xf/nbnx1FR7v93/3MTuWGnUB9jmUiyLrbKz8FINqsjdGhiYvsirFto6+ntnyPt50iOFjPj6VwyycHLm/T55DoRKZmZ42tXM+FCj2pv14ZkwP7iyA5UjRrxQtA88D+ygSG78t5hCjEXNzIPjnnIQzNU6MnhLtP6eb8pbIecJujc5FBunajPJKiLF5hWj7XDKK59D+jHe5JPubl4Pu8lPR0e8lAn7ohS8HjEaLqwhycz6kwKjBy8oFdthLwCjSOsDJIrwg1lh7YzTeIzkY2IwVEo/xdJiXnXRPWHkPUQwvAkDKBi6goRWd+GSaTQYR6Z7j1/PCCVrRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by VI1PR04MB6990.eurprd04.prod.outlook.com (2603:10a6:803:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 09:50:16 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 09:50:16 +0000
Message-ID: <42a5cda8-ff07-4083-a2c4-66edc5c06c26@theobroma-systems.com>
Date: Fri, 26 Apr 2024 11:50:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] rockchip: sdram: Support getting banks from TPL
 for rk3568 and rk3588
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jagan Teki <jagan@edgeble.ai>,
 Frank Wunderlich <frank-w@public-files.de>,
 Joseph Chen <chenjh@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de, Chris Morgan <macromorgan@hotmail.com>
References: <20240425-rk35xx-dram-atags-v4-0-331401a58e8e@theobroma-systems.com>
 <20240425-rk35xx-dram-atags-v4-1-331401a58e8e@theobroma-systems.com>
 <fca5f37a-1f50-4628-bbc0-d9db7c18f3e2@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <fca5f37a-1f50-4628-bbc0-d9db7c18f3e2@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|VI1PR04MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: d75504a2-75d7-464a-108a-08dc65d6464c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|1800799015|7416005|921011; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWZxaEFMalBraFBPVDViTXFZNm1KbzBUK1FZR0MwRDdYbUJqK2JrUExTMThX?=
 =?utf-8?B?T0owODM3Q1RXUU5JMXd4RzdmM2ZiaWlpOVdZSDdSNUVjSFpwTGl3WVc4SFl3?=
 =?utf-8?B?bVFEc0xQL204REduWDZDNlB3Mk54UkpFbS9Yam9zYTVFNTZ1VFdtVXZ0by80?=
 =?utf-8?B?SzdNQnYxWTk2ZXZjdmZmNHdhTitySVNUcEZRK0E1VDVac1FUTnNXRElmNy81?=
 =?utf-8?B?eDZxbkNIcjk0ODBnak9nVWtGY3NFZE5mTHhFOTdlOEhPdHdsWEpSZTVOd0NH?=
 =?utf-8?B?UGk2NmFSd1hzakV2ZnVHUmp1MXdyWlRzcC9aWGtaNzFwN1JjbnhISzU2SkNT?=
 =?utf-8?B?akpWOGxaYy9ocUlJclZFVm1NUHEzVEQvaDJEQ0R5VE1wN09qNGs1Wk9VQXJm?=
 =?utf-8?B?WkZDVll4enZHeVB4Y2hscUpPTWc2RFpjU1g5OFJSMzR5b1pMVG8xMlBMZ1JL?=
 =?utf-8?B?cG9UMnBxWXFVQXk0L3A2TG9xUS96WE5mS3ErUzIrOSs0ZW5XT3p1OW14WXNW?=
 =?utf-8?B?MU5QSDZadEhDREE2K3MvYWJrMTdRNVdsNmh2MzF2M2xjbS9paUNUTjhjMDVm?=
 =?utf-8?B?VW1BeEJnZjZqanNtZTMxNWg4dXIrUUtGRXVjOU1Lc2VmN09ycWpnb2FNckRo?=
 =?utf-8?B?bUszczY1aCtRV0Nldm9hZkxvdW9ROTUrUTZ6c1AvUlVVcXlwQmU3QlRIbWoy?=
 =?utf-8?B?ZmxKY25Ca003OVlod0swd1FIUnkvWjhxTFlZTVFGNHNaYkNwWGp3ZUI5VFFy?=
 =?utf-8?B?Z094eTBVUVZIeWdoUU04b0gwTDRsQk55TXRlSk9FbjAzSURqeDlBai9RUzU5?=
 =?utf-8?B?QTRXV0hBdnJ2cVBibDFpbkJYMlZwK0gvVjk4am5OUWpaSUN3YXdtU0dKQ1ND?=
 =?utf-8?B?MkNMbFBoczl1b2xzMENSTVhFSC92T1p2SUY1VTF0ZzlZVTByVkdsbCtKbzVS?=
 =?utf-8?B?SjVJMjlHUHVHeXhVR0NsSmpVU25zbTFJT1BaOGRrcUJZaGVrRTk4bkhnWWdw?=
 =?utf-8?B?MDgzZEMrTkJmTmp6Y2t5TWpyL2hzOVJEMFl3MUJ6ekJYUmhUL1I0V0JGb3Qx?=
 =?utf-8?B?aWR5bUpmczdxU09wVmpNMFl2YTRsamtMMGNCYnpIUkhDOUlSTDJpQ3M3bWRY?=
 =?utf-8?B?bUsrMmNIbHdlRzBpVnRuZ1lrNWpEVnV6S093MytLUURVWmJqSkhPQzdIVDBS?=
 =?utf-8?B?SXVsNE40YTMxSHZKUDlSczFYak1Wdy9HejM4NE5wU0NhbVF0YnQ2MHpxVDVY?=
 =?utf-8?B?eGgzVlZMbHhuWXRnMnBIQXoxRHMwaFYweWZZR0RNckJXUDZESEozcmg3d29N?=
 =?utf-8?B?RC9oRStZOGxQUVJ4TkJhN2ZHeTZ2Mk9CTzE1OU9ldUJiY09NM0JlNUx1MEho?=
 =?utf-8?B?a3B2R09ENnZ2cW10OXlqSXBhdjZLRXhXeTVBYUhoYjg5R2JOMVBERm5sVGk4?=
 =?utf-8?B?TkJtNWNUTk5sSUpVT0JiSjY2cTI5a1dweEVBLzZPeXRZSmZHOTNwQlRjMG9F?=
 =?utf-8?B?UnY5dUxzTDQ3eHphNjRzSktsa053Ny9KMVBaa0ovVzY4RFBlOEF5ZlFxS0xh?=
 =?utf-8?B?eXZDY280ZzVMVkZ1clBGckVvL08zZTBBakNHa1E5UXExNzNUYzBrZ042V3VW?=
 =?utf-8?B?NFZpWEVLT0tNcmU3aVYzVDZEdWpOMmUyc29tWmZCdWVIMlpqQ0o4V0tSVTNw?=
 =?utf-8?B?eHBkRmdNN1dNWDBuMG1kNk1wVDBKVHdmK25VeEcweEhrUlVuSnNqc25ONU1D?=
 =?utf-8?Q?S5d4hxDcj+J2f5bA8F1gVVqhkE+zdOCD8b4iq2C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZaWkpFMHA1S2txcUw0U252ejdMRnZWa3JnWFRHNXdFYnN3dWtIblc0K3pW?=
 =?utf-8?B?bm8wdEoyVEk2cFR4eURIcjg1T2pXN2RlMnhsM3ZSV0JtNFErVDg2TUtZbnlS?=
 =?utf-8?B?cXRRUHpkUjgydC9ZRCtOcUswMUduVTloUkUvTllQRVd2MWlOL1l5ZGwyYUw5?=
 =?utf-8?B?RlBWQXBHSDhkbkVzTW5sTGtobkpRMldTRWZLa08rT0ZUVnlPclFwNUtjT0ly?=
 =?utf-8?B?Nm82YnkyT3F1SzVzVG1yc2tsTXVhb1YvSGJxYXNiL1h2bldRTncrb1h4VjRX?=
 =?utf-8?B?ay9mNVdmeksxY0haeVE4QnpDYTV4ODZtaHhpNmsvV3hhMlVRcUNEcUlNQ25K?=
 =?utf-8?B?NEdjcmwxUjFmS0YyR3dWUHAwL1hkTGF3blN1SWFuV1V0MnpURlNiUWsxNUsx?=
 =?utf-8?B?WmVDOFhFRjRtdk04eDFzUTU4dyt0WjF0R055MXluNlplNlZYTGk1U2xwU2c2?=
 =?utf-8?B?NUpzeWYzclB0WXJ3SGsyNDJ6N2dHVlJubldUeTJJQnlkbkpuVDdBUzdYeVU3?=
 =?utf-8?B?NlJCUkhoVjQ4dDdyZW9uRkFHbWY4eC91REkyT3YzRGpXdTFLWkg2WFkvT1JM?=
 =?utf-8?B?SnFLNXAxV2o0MFY3dE1nYnJVNndpSWlnbkwySSt4MGdwbjFQaFovM0QvdlNH?=
 =?utf-8?B?ODRyeXpvM01aRUdYaDN4ZWxDMy9OVVQ3TlNZMDk4QXJYWE5RWlRmNjhFaXgr?=
 =?utf-8?B?M1k1NENlNVNacDM4UkJrRTlqUXBmcEUxRWtZQkxPYTRvUTlFaUkrUDZZZ2Fh?=
 =?utf-8?B?aVhseklsZjFvSGx2TEQ3SXQ5Z1dXYUFIaGRGdWRNMk5RY2tzZjlBZElGNDgv?=
 =?utf-8?B?Qy9PVjBva05oczYxc0Y4bTdHOWdBT2ZzK2ErOUZRaWtZa1hYSGNSbkpYRWxE?=
 =?utf-8?B?WFA1a2c0MWJUZjNtOU5VYjBkeFRPMkx4Z3BDdCs3RVdLOGVmajRwV01aMUN3?=
 =?utf-8?B?NE53TVJnNy9tc0tFYVpCS3lxWSt0ZXRpNFJhMHFId2x0ZUpBWEZEMHZnSTl1?=
 =?utf-8?B?UVEyY04vaGFjdERiN2ZldkRrcVQwdHhTN3dZNWZNZDBsWWFxY1J3eURJWGho?=
 =?utf-8?B?T3dTOVJrU21ZQWVGNk5rNjFqSURWT2NjWmdQR3d4WE9TZUFGcUdJeWJVdVdx?=
 =?utf-8?B?SnhFbWlISlVCcGJiaWJUaEo2TmFWcitLZ003NC96c2hnWDJUKzVNUXBEVDhY?=
 =?utf-8?B?a2pZTVR1WUZzcjg1UStoZUlldGRpWlhqWmtHWDRFTEZvQko4Vll5UXFiK0pB?=
 =?utf-8?B?eHNaaHIzN3FvU1FkbldCWUFiS281T1hxWmRzdk9MQU1GclJjK21hQk5zaHJp?=
 =?utf-8?B?NEZCVGpQQ2NTaG1pOUxhVTJNTUh6dHNITmFYQXlzM1k5NjlOQTBqVWNVbTVq?=
 =?utf-8?B?dzNVb01EVThWVnNNVXp6aWZvMkVTbVNDaGxDY1crT2hyRU5wK1lyWG1peHE0?=
 =?utf-8?B?UG5MWnluTW9GeTZWYUVUakR6RTUrN1lCMDJWNjdsaVhoN3FpSE81S241dHh1?=
 =?utf-8?B?S1NOOU43M3IrWWt6Qmw2cXZGc1ArUERyUFBiczJXZXJHd0RUd3huUXgvOGtx?=
 =?utf-8?B?ejZIVXp0SHhPakZndFhIYnVYcHo5MUE3L0FYb3BpWWNPZis3VkkrcWxlczVl?=
 =?utf-8?B?Q294Tkhwa2VoRGNXS29hSXJudHo0TUZNYWNSM3YybnpGNXZKNDVQK2VwVHov?=
 =?utf-8?B?ZzBxenpPd2VSK3plUGcyYW5vNmwrNU9CT3d3dW5MRGVKMThVa25QY3duZlBv?=
 =?utf-8?B?Wm5pTjF2azhIemdSVkpjbXRvbVhTRXVPejIvaEdKSzM1cGpBUXJGR29HckVp?=
 =?utf-8?B?a0pXQWY2NlNsU0d4R0pxWFBEaWRYQU0xU2VZdjAyalUzbWdlSlpoVVpMcmRQ?=
 =?utf-8?B?c1BLeVpVTHlZNDZPV2Q2MUxuM0dkV2VZVkxtdG5XaEhuUXJqbHZlWEVFdWJK?=
 =?utf-8?B?Z3ZYbGg5TkFsU0ZBWkk3T0IyM1FFUllaZlVBdDduYzFMM1Q1WjNHc1dJSmdl?=
 =?utf-8?B?V29tUjRKTFFqMVNIMDFMclZEa0QzRzQ1WWZPQ2c4eUpsOUhYVDUvSVFpdVRa?=
 =?utf-8?B?bE9PVTNwcDcyTTB0V3V4MCt3cUhOc2ZUVFZ2eHJhRHhpWGdLMm1ZWnIzVGxE?=
 =?utf-8?B?cDNiamdLZ3RjNGczWlhBOVpNY0RWSTJDZnhLaThYQlVMalpTNUhkQUhaTVZa?=
 =?utf-8?Q?alonXAt7q40+s1GkO6kajfI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75504a2-75d7-464a-108a-08dc65d6464c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 09:50:16.0554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aumGMWFkB8wiOnjXlcGlIt7bgLyjZk+qmXIiM28li0+MLHrA4kjd//PLMgK994oIzc7COpFoJED7T6bdfJChEYLFVEMyNRi4W+jAT7UWJUpDqfxk7nfo8dNZcore6gCA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6990
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

Hi Kever,

On 4/26/24 09:41, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/4/25 18:46, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Allow RK3568 and RK3588 based boards to get the RAM bank configuration
>> from the ROCKCHIP_TPL stage instead of the current logic. This fixes
>> both an issue where 256MB of RAM is blocked for devices with >= 4GB
>> of RAM and where memory holes need to be defined for devices with
>> more than 16GB of RAM. In the event that neither SoC is used or the
>> ROCKCHIP_TPL stage is not used, fall back to existing logic.
>>
>> The logic handles creating memory holes from reserved memory areas
>> defined in mem_map data struct in SoC C files, but only if the DRAM area
>> overlaps with one reserved memory area.
>>
>> Since mem_map data struct is used, it should be rather straightforward
>> to add support for other SoCs if needed.
>>
>> The logic is taken from Rockchip's U-Boot tag linux-5.10-gen-rkr4.1
>> (e08e32143dd).
>>
>> Note that Rockchip's U-Boot/TF-A/OP-TEE modify the ATAGS at runtime as
>> well, but the DDR_MEM tag seems to be pretty much stable (though BL31
>> seems to be reserving only 1MB for itself at the moment).
>>
>> u32 for ATAGS is used because it simplifies the pointer arithmetic and
>> it's expected that ATAGS are always below the 4GB limit allowed by u32.
>>
>> Co-developed-by: Chris Morgan <macromorgan@hotmail.com>
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> This breaks rv1126 build which is non ARM64 platform, I can fix it and 
> apply it directly.
> 

Thanks!

Cheers,
Quentin
