Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00412C54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18FF38796B;
	Mon,  4 Mar 2024 10:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="XqmRCBWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE70C87F3B; Mon,  4 Mar 2024 10:45:12 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DBC87873
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUovFtDnWxn4UQZe0IHqSRZ1ewE55jh66J3370M+h/Y8aKxXKzQYMpPVenz+3co29U7SzAjPtvTsLFlQaV8B2GtxCY6Cw/SzeDExUPIaIpfXr+TvAU4HpAU6r+9kwHfbl7raWPL8Xumj6iU9dQuRCkQhaS2qyjJ8H1ssZeXU4fENT8lOKMaM7+kSls3YgSE990P0E9BxJFc6BGmEh1LMFR7iWLQlppbD7pXH041QNBl1TdTV0n26FsSz4KpNwRob/gcd/6b7w4D/F4euDYFvs1VCAyY7KhXt+fqXLMZEAwkv9Us02teiWbLAuSbcKBwmv15mAQdzEqWaHQFnJu2LrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF6hg0+pVszf//U2tZ+leTDv+MFrEaNSf1Zh8ZOlj38=;
 b=oHy2roTtnS1tHlkxCJ03ykJRrsGXtY8wVtbVlW6rZbTvhThs7cdSfdZG/sDiecwSG0J/+nvdOhbN6t49Ne1jljJU7ked51lt9dfRPI8NPLO9hi/4YxlPw+40KitWk3n/CTlQwSdJKJ6QMolyx5v58lFGply1fNy7AnfYk6TbVTTST+7CoYSsVXRVFev7rNwNGyaY6Jym9pmug8A5kMH6vIQ0gyJWc0j9wigse0zo/FnXTNvdgbe71+P0+WldwLqzSDbULhoSiUtUWhXjzOuONpdTjSk6cemQipBlDS2Rekw/dkVmlZ3qjCGcWK+xDafJiMF4a5WB4sa1FdXXmiKyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF6hg0+pVszf//U2tZ+leTDv+MFrEaNSf1Zh8ZOlj38=;
 b=XqmRCBWX0Ih6LljsVSt3ea3/RwHhHOTTPrrw1w2lbV+cnKxNvIbBJ6MFfNCE2hR1xgZX3+KCXLg7LATOF/rz97fqYlLq11j4NMC1P07e0gZqebIb6eBXMclSTDaz1nwJeW6U7KvPIDMmIDwinn8jznqYf2fghzuMR2njpTu1O9UdoqwkO5cgcc8Se4MxEWMnbORsOUGs/Vd+lWd52DMFzBizxr+uTLCBjYqaDL8GrQkiE43+DQLxE33EEsHUVZE7QMo28aGaCGjktb0+KCthfEYv/mje6FmmDWXNQWP2lncjGFiZPf4fkVmnE+V7L3+utCXF3HyDh9/2WXAGt+QXHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by GV1PR04MB9152.eurprd04.prod.outlook.com (2603:10a6:150:27::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Mon, 4 Mar
 2024 09:45:02 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 09:44:55 +0000
Message-ID: <f19c29e3-9964-4034-a17f-8768fe2d9725@theobroma-systems.com>
Date: Mon, 4 Mar 2024 10:44:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] rockchip: spl-boot-order: Improve debugging
 message when device isn't found
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
Cc: kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240302145107.168080-1-chris.obbard@collabora.com>
 <20240302145107.168080-3-chris.obbard@collabora.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240302145107.168080-3-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0204.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|GV1PR04MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f107ed-8830-48de-79a5-08dc3c2fbf74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaGLzpz3MrgHwmoEHAIoY3qlR7KzZN61egtl7i6B3H0qaQdIO0FBjGItxgVrn/ZEy/JFYcWgB7f3ALy5i2vyzyFpn99Hsq/ybD7kKDi9JQFvSzlhMSMFI5Lroue2GmNS9tERQtUqpLRGMnHgy1YNpHf6WMwPykd7Iap3mLRS1xnODI6IZ65MhrT1ZfT62A81NiPiPwMz4AwcumZ+BtYJ8gBCae6BfbwN4iYMoDC1axruzqnGmnZQMAmP5s4sWsHViRvUfsHzPcwZ6RoxGE6j8CyhKpN7Lr6kn6Pg/gch5k8TRgCCnlIx8HMlBCW1uQ2JuVitUp6kHOKByMWDBA/YTr7IXGl0uu/e69ix9gf+6j9rjpvPjDXv41A1pBhB+LfY604SIiLLevJxVMKIXeXYAl56TQrNVIAw8nu1YauVidBtGeSyhg9pS3QYwuhi2JoWNcbPelplW2i1DnqOHYx1TOpDI/1E0CfnF5uKQvpYhHgFX0283F6hQreD8o1h5iEub0aVak0s8DXQYhGMHQOAgB6pO1Lt9/Ljmlp/AeU8lYL0KW43IKsP6np7Flv//HbnJr8MmMBPIQCwVk0hAFOSAdY6cHpqAztmNvUGtKYnQtJD8V01bl1M6bJYfChxQB+gbERjtktg6yyvEn872MtKoiA33v32qevCiF5TzDf1eFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0piTml5eUwrbDYwby9zWVNYYkpHSFJza0xtcU9GRHNCUnFoeU1QM2E4bU1V?=
 =?utf-8?B?WE1tWTE4dUlkMkQwT040K1IvUzlSeUI0Y01XazZFNVVGVG52ZEdCVWNVdXRx?=
 =?utf-8?B?SkR0NnRCVjcrSjB5U3ViOHRWdFZXVXNSSkVUbnBzN1k0UC9YSlUyUWd3eDRP?=
 =?utf-8?B?ZlJhL1BlZVBDNlhacXNKUENlK0VjUThySG9EWW1RdTFtNmJ3eUJUL1VEa281?=
 =?utf-8?B?S2tLam9BNFlEM0NXUy9pUzgzYzk3bWNFL2VLTDQ4M2hPSWVYZzJoaFZlNEZN?=
 =?utf-8?B?R2hkY2t5RTQ0QUJWWVYzU2xJd0lGNmU1K0dmM2pWSHFGYmFMaXlqZ2FWYzkw?=
 =?utf-8?B?S2lxMjN3S3RrRFl0MjlUdEU2L2ZVVmVJZlBPTFJBQmxzdVhnZmNHRGZxTGI1?=
 =?utf-8?B?MGJjR3hCMW5tTE9takt2eWxVMlJNQ1lBemVpNzJTaVlHUEcvT1R3azNHNXoz?=
 =?utf-8?B?bllnMEhsWUpRYXNTYmU2T1NzSC9NbjVYRUxQTVVYSldjVkdjYkV6QWRzYnZz?=
 =?utf-8?B?QUVFclc2TWc0TzBJUlJMRGVyVlc4SG9XQjhKWEg5VGRTOWVkcm40RkhZVmgy?=
 =?utf-8?B?VXhWcG5oN1dzaVF5aURXeVQ0RWU2djBuc28vVXk1YWFvQi8yM3hYRFdJS0JI?=
 =?utf-8?B?eGhHZmcwZTFhOGR1QVR6UzdINlVoMmxpbWsxMk5tbGNIT1k5Tzl4TUZhc3lp?=
 =?utf-8?B?cTcrc2VpY29lTE1nQUpRN3JScmhJVmJaOVNubklPVVpka2FMRDNYWSs2RE1x?=
 =?utf-8?B?RHFpUzFtNEp6aUh5WEZldDZzRDNhOWMzSTYzTFIyVGttVVk5QU90SEhiU1Rj?=
 =?utf-8?B?SHNxbTRDL3FKSTlNTnBmbUFIdWR2Z2pQVDBUSTRBM2x4R0hZK0JZVXMxa2oy?=
 =?utf-8?B?c3hxMnJwR2tINFRqL1RrSENMY0sraStHQ0VhZU5zYXY2QXVSS3k2UFNZbjIx?=
 =?utf-8?B?RERRbUJyZXFHZ0ZVMS9NNnBveFI3eFJzaHFqNjZZRFhnTXdwQ0txWUd1dDdR?=
 =?utf-8?B?RTB3TEEyWk9nS0VDakZ2S2ZtTGpoZ2ZYbnZnSlhWL1BqT0dCa09rbERnaEZH?=
 =?utf-8?B?bko4YTlQNmhueVMrWmtvWUNMKzVadE1DOG9QQkZqaitJWmhjQzBkSk9hRU5m?=
 =?utf-8?B?aVNSTWlyMkl6MDhtV01NeW9mN0Z1bmp3aXpyaEh6TDFMY3k5OEFxVkdaNHJC?=
 =?utf-8?B?OUxueVNkemtmNHZOTjNsdWQ2MUNNNDZWVEZuYmg3clVQajdpNyt2U2pTYS8v?=
 =?utf-8?B?UHhYVUJHSkxUaC9yVjBpM3R5R1ZYTHYzYzkxR1p1bUNqNFd6QmNsK2RydXM0?=
 =?utf-8?B?NHRKNEFVL2pDQUpNa1VuaWlBQ1dMZlUwYzQxQXNtekZ3SVB0aGxQclY5RmQr?=
 =?utf-8?B?cnBHcnNpbkVGUjFnR3BiUlAxOFdoSEFFYmg0WHYxdEFYY3pBaDBNTVRqQUhL?=
 =?utf-8?B?OGpiUHQ5b3hXVUYwb3FHTFdFUlpGeFI4aGZuWS9lemVveStMR2RmUndqaWd4?=
 =?utf-8?B?SWN2ODlsbG8wVllBUU9MbG9DTURaNXVqTm5iZjd1WmJRSFdqU3JJVzJpRFJt?=
 =?utf-8?B?TEhtUGpsVlpIbHpERGU4SXpac2xvQUJsaHJlcURjcXRpVW1ZZnBrZlpxVGUx?=
 =?utf-8?B?d0dnL1hSVjZTd2kxSDBZMW9xUEUyQ280UlBPUFpOUzJoL05pK05sajFnNng4?=
 =?utf-8?B?anlYeTRiTVBJQzJ1QjI2WHZSR1FXNm9nditzd3VsaTMrWFlYRkFvOWhoczRu?=
 =?utf-8?B?YmxpSlNTL3gzVDdvUDh4bWl2WTlZZ0VnY3dNeTQ4WVg5VmNKaEd2ZlVGODhm?=
 =?utf-8?B?UWFIRmRGWXNjYzZSNDN0YklKamtEQlVvRnZ3b1Z6TnRZNU9JWFM0TEppL1ZT?=
 =?utf-8?B?d0FqVGs5N1ZlOWFCQlJjUkVjK1VqcS9jRFFXdEFiSlkxOEtKNFFIVitlejNK?=
 =?utf-8?B?dTdWRDJURmFCeVFocGVIS0V0UGpsa3pLQzMrZGVnYUY1SlpRc082MlpnMVpz?=
 =?utf-8?B?cUNRUkNVZmlNSkRHbisrajMyckRvYzlMSS9DYVB3YlNEMEIwcFIyN2JzMXJU?=
 =?utf-8?B?cS9lYjFmdmNHaE1JYUFrOFdJN3JtQ2QwNU5XbFRLYXlJYmxWbWROWWVBcGlJ?=
 =?utf-8?B?TnZkRzhVSGg4bGxDOXhVVFJYUXdkeTVyYjcxTlBoL0xqK3pieWFNMU9hYWp3?=
 =?utf-8?Q?HKLPu0+bDMbZ5vs0cHYNdBE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f107ed-8830-48de-79a5-08dc3c2fbf74
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:44:55.4316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgR9EXxK5xJiBlQnTAZT70lQoN4AzECtWtyYbhkDtPPElF5R20bszZJa/kJoZOyyQJgARKsbFgogWYFLMZRGwajw9O7ve+Hs7tpi9lzLs01YuK19bQD4rNzXP+ZPtnrM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9152
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

Hi Christopher,

On 3/2/24 15:50, Christopher Obbard wrote:
> [You don't often get email from chris.obbard@collabora.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> When debugging the SPL boot order, the node ID of a device which hasn't
> been found is printed but it can be quite hard to relate that to the
> specific devicetree node. To aid debugging, print the node path as well as
> the ID.
> 
> Original debug message:
> 
>      board_boot_order: could not map node @73c to a boot-device
> 
> With this patch applied this becomes e.g:
> 
>     board_boot_order: could not map node @73c (/spi@ff1d0000/flash@0) to a boot-device
> 

Does it actually make sense to print the node "number" here (I have no 
clue what it represents and if it's useful for debugging)? Can't we just 
replace @%x with the node path (conf) directly instead?

Cheers,
Quentin
