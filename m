Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE508C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 07:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90E7940F35;
	Fri, 31 Jul 2026 07:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lrmIs7-kXE1m; Fri, 31 Jul 2026 07:53:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24D9340F36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785484431;
	bh=QIRLqaLRmQBBhVatqKQ/vuFGvbftn/YEjQbz9Z6KzCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cph3B1goF256Ge/Yt2IS4uwt/WDaapnotG88+eWfl7DHU7obbEAZ02xHXPnt0bnyR
	 pQbyr+obpPsjvVO5MPNwID7ICKnP8vNQv2nh0joUIB9iSKH2A9T4q5cWAtyctcv8v5
	 zSADWtTvjrFIheBT6aBrtTzknzKCiEnjK6zszIf4dFaIAXg6pIpB2wFRExUoZBXpk1
	 hV9jv/VVw84/hTZzPmB5bVGSxPweFztQ8o3b9EUzQX5ogwObt0FDwm5912N5WT7bZm
	 BS54XyL0CLZ4zOpaqiAZTqxiNMKKZOLb5YnLSschu1vNUNe/+vZIwfyQcH8vd/3DEt
	 pGwqaBWBEGPSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24D9340F36;
	Fri, 31 Jul 2026 07:53:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 021DD2CE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4DCC40F36
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4KZFVAStGl6 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 07:53:47 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 59D9E40F35
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59D9E40F35
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59D9E40F35
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3vMUwREa3UNrCn3l6ZBG+T1c0PGo+I5XPmgHTK6cDeCM4sZTdyjxGOvUfwaLBkBULDho7eQx6Fm/wlECuLoa0fmuz23OIm+FDsLhEqZ1k1Swjj5+ypz21XOQ/gtnaW2n9Ltn+KjCvjPM9qvoJLZl0ciRWkhxREIj6Vsl4DExnLRG1yt9fltMTFcByR2ueq4x+d7TSzGICZQsgkgmmBQy8MMQtMUuqSuiQ+W27lu2zGFq7G85Os9s98GHBe0brSpLYVgQlEvB56LoxGJ3BtGsdlfxrfcP7dhQ1ee59o2eeKVMYKVuCeGfyz9QXFW97nIM0wP7r8PL/w3zkGKCd089A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIRLqaLRmQBBhVatqKQ/vuFGvbftn/YEjQbz9Z6KzCE=;
 b=BpdjYv2As93oq5xA3MoP5T/fZ8YSrCv14FgcuZ3CsgfJdgvvAEDrLFyVZJq0+9txoYxqVc8JTJs504oHLilRKvKd/lEXQLfFMWgLVYgn7V52qwnAYPLQ20B52vPz8GlI/+mKCqhyCFGdX5tfhEE0IcocyQXmv5907PCMp0wGXR4tT8kSIAlhJwj9AsX7Rpzv7OohexOHqWTbkAbIVWUgmg+G3RC8KjW1wG5y6l0ahJa1eg3tDRfEBGE6lx3/+pZkgqJH4gFxrUnRENIMK1PPMGFmuAr8ouTpwJ9nae2V52Rmed97HFyBZ0Z848rOJGuyh/VccWVWtYhXsqmYj451BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB11954.eurprd04.prod.outlook.com (2603:10a6:800:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:53:43 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 07:53:42 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 31 Jul 2026 15:56:52 +0800
Subject: [PATCH v1 4/4] board: imx93w_evk: add board support for i.MX93W
 EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-93w1-v1-4-62d8459143e1@nxp.com>
References: <20260731-93w1-v1-0-62d8459143e1@nxp.com>
In-Reply-To: <20260731-93w1-v1-0-62d8459143e1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB11954:EE_
X-MS-Office365-Filtering-Correlation-Id: 9131741d-876c-4cbd-6978-08deeed8d755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|11063799006|5023799004|56012099006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: hsaWB2JD4wR6PmFAbPBbT4qE07mVqyUFdG1PH78oYfGO9TUDRHnDy0UTB4F3oh5Du2YiC8mwafh0Tt0V94xAzub84NpH/YBcOBr8xwpd5PpYLFicPfzCDUgAjjn44t2lwZaJXg2oeRLagZGYaQCcIVqUcP8XeJUfVlzxF8Sa7sZn+99E+vfXbbMPxmYpANFkgwp+HjASREqD6fpNoXUzSuvaeJUdRpFCGhPVhqYv1f8+kEKJ83tFdLc9BOT6KDDyON55exqs1vwwzmjFB0O8RRsuEfry73U/+mXlnucCXsA1TgDt5ifcSYNRzFdD54qyvraXSNLwkw4+IoQ5U3gYXC/i1Rt0GO6twIyfVY2NoZ+8+UB3OzEzJRQKSeztJLyIuf1dHmH8/xQntN8KQQqZfqkdQ9E+k15CTJqjnJ1rQRSg9ZCeMmICZtaMD12FtiUHKP1mSRaDoLpVxW0d5pAQncs5lPS70y/CRt1K5uczD/CfNUea2MhC86zlXvD+xjXtDfw6GWZxqyHytrO7H5BKtHnvoR2lZKmbYcmX0qvdZaZX9NQuIVrICKeEHzoAYI/rVW/GvLOsjBOvqkvwuLJpriGdQGO8HNEYqAfhPywHRth+hXI6qJ7E8E1bs9OC0uuyf7d7ch1PGJy8X1iYOqErodQ98yXisdYhJt9Q0oMV2Jw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJLNTVTQjU2cTZqeDQ4TzJ1ZjJSMXBwZngxL3FDQ3BnSXp3VGwwRXJPZmxr?=
 =?utf-8?B?VUFHWDhNNFpkUVNkUm5pRnpzcXFXNnhFWmU4VG9CVUxTdUZleXU4TC9CRFd6?=
 =?utf-8?B?eE82cjFpNlA0K2ZtQTJTeHRUMExVQ3RXMTdkQ0NGYXFRZ25FazlOUmI1RXRB?=
 =?utf-8?B?MGNtVDVncnNIRnhkMGFvQzE3aUJYRlpjYmV4VHJhSm16K2wySzY0b1VRdm4x?=
 =?utf-8?B?dWZvSDNPQ3hCbEZUeVozMFl1S1VDU2g1MkdGZEh2US85RnB4NzF2eUk3M25k?=
 =?utf-8?B?WkhvTDZsNmh1RS90UFNzQlRsTEpPNmF6dDlYNWM1SjZtUkczdksvZTBHQ1VI?=
 =?utf-8?B?NGhYay9NS0VmVkVkNkptTWpLV0Q3NnNITThJUm0rZnpySjNIU284VUcxY3JK?=
 =?utf-8?B?bVVwM1NZVm1zQ29Hb2RuZ25UUkJ0QmNTZkY4YkRYRVhlU1VDWGlGbzJlM3l1?=
 =?utf-8?B?b0NLQkR4Q2FVUEllbHZZQzJZK09DV2grYUpYM29RYUJJSGJQTmV2d2ZhQXN4?=
 =?utf-8?B?RGZhQ0hqM0h5VHFYS0FNczVtK3JMditac0RPdHd4VlJJOEVqNHp4STYrU0Yy?=
 =?utf-8?B?T3NaNnBZUU94aDREbGJnVUlnUFB1VW9EMHJFV3VuVnJDS2xkdVRoVmY3RXk0?=
 =?utf-8?B?V2FpT0hqTE81YVREKzNvUVo4QU1KZFdvUHJnTVI1K1c2VkovYVpBMjArbzFz?=
 =?utf-8?B?aTRvYWwxbDZxcUkxUW10TWoyQnlibGhGZFR4eDJzcUN0NWVnalhLSi95dDhT?=
 =?utf-8?B?aGlMenhmZENGRUZvTktjT2lBWWZraFIwRXkzT0dVNlpzRGJsYWZXc2FvVEJa?=
 =?utf-8?B?aVRtaWFXb0FhM1VWWHZGUTJzU1Yra1RzVFFtR29mZlFmUGJueUhjcG5lK0hZ?=
 =?utf-8?B?QkNxTDV0aVpHcFNqTEpLelFTVG84aXRjM3Rhdy9FTXVKN1loSEpBamc2bUxF?=
 =?utf-8?B?SWowRnZUVVpxZGJRWnc5a3pxWDBSSFkydUNSelpjdVNJZjRKV2Z1RXJHdlpn?=
 =?utf-8?B?NThPUytjS29lNWtKbjR1NDBsTWJITXNxbnQwa1FkUVYzY2sxV3FtR2ZqaFBt?=
 =?utf-8?B?Y2hYcDhrMThHVEZva01rMkpvUml2bnRtbUVtSEhyQmJuSXpHMVNSallTSDE3?=
 =?utf-8?B?QUgwd3hpWEZPWk93blhYeXlocU16akQ0WU8yQWM1anBFdjZRS29DQURVRUEv?=
 =?utf-8?B?bTliaVA1YmNVVFNTUlI5WUlNYS9Qa1BLbWxTemVOZjJONWRyNDNZM2ZTTFBi?=
 =?utf-8?B?Zm9taVFNZFhCZldKN2pUMGlZc2VXRDNtcWRWQytTVHFFSmFvR0djV0xwcWtj?=
 =?utf-8?B?enZhdzFsOXVqQmUycEg2dS91THpRVDdHMGtXTVg0d2VnU3dCV1NEcUdRbkgx?=
 =?utf-8?B?UkxxN0xOSDBXdE5seXljYWwrYzZGcHhRU0RQbHVYMEJGTml4L0FGai9sVkpZ?=
 =?utf-8?B?VjdOT3B5ckJYUnNZaWtEci8vMVp5b3BUN0VoZWJmR3A0ZlFwVHdFYWhGL1Ay?=
 =?utf-8?B?LzF6bjdrWmlRYUtxSUFaMHhKSVJKaFl1RHpmdkp1UFN2bVM5Znljblp2Tk5k?=
 =?utf-8?B?eTR3UGpyYm84YXlTQ2Q1dHB2R2VMRDRlRjNWaDdmWkMyRGxhNXpZMjNhcEdT?=
 =?utf-8?B?dWozWUpOY05FNUtsWGxSeHQwbEp4SUtweHZIYTl3VTVROXdubjRwY2VqZ2RM?=
 =?utf-8?B?ekx3Q0pBcjJGYUEzaU5PbUIyY3pCSGwrYkxBTzhYRmVWbDRSN3pxajczemJa?=
 =?utf-8?B?bThjV2VNUnE0QTNqTXdlWHFUWlZGMnVZVDYraDd5Q3RFekN3R0NDOWlkaTh1?=
 =?utf-8?B?aVMrejk2QVZubjdiS1RPSE9hellkM3ozbzUxcGJlNHBBRXNEOGtWQUZGWlJz?=
 =?utf-8?B?dnhuSnowK3VVYU1lT3ZCRXRxV0NKUFBreE1oUFIzLzNjT2t3Q1NGMU41KzVs?=
 =?utf-8?B?Y1NwenNPd3NvS2kvT2I4TkhHZWtpRzJBMXA0Z1dyM2F1Um5iSUhZZWRRSHdW?=
 =?utf-8?B?MUNUb3BZaHY1UmdPUnhPMGUxbXhUNUxkclBaYjh6MUQ1VVlvYzVBaU5JT0FB?=
 =?utf-8?B?ZTduUDVsbDMwWW42a1A3THVoUTFMdDR6NkUzbjRqL0JJTUtpeUJILzFSOHcw?=
 =?utf-8?B?K2wyZXdBSVNWbittQU1hWkRpdHI4TFZnUVpHU3N6dVo5QVZXei93NFoyM1FS?=
 =?utf-8?B?Y045MnVjbGhQbVJWdWRSNm52eVIrU01kS2QycjJvR2lVdEM2OXFmb3gyYVhG?=
 =?utf-8?B?SWFMK1dCbzdvU1N5S0JMcC9Jb2lwcWtEMDN5U2U0OVVpczJxTGRDb3dwdytP?=
 =?utf-8?B?RjgvRmRPTThGajhuWHVxbnBxZ2U1MVVwd3doTloxakdmdmprNFdFYnExUDBN?=
 =?utf-8?Q?BnA0NAb/b5e/TcO9NTd25cRM0MnG1BtpHEkKj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9131741d-876c-4cbd-6978-08deeed8d755
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:53:42.8566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3ORlXGEiu1FV6vQIBTZyFVTDEtWPeIF7lyaYsUQpEiXZEN8YLU0dgoLfijGvyO2L50rgZHyhFQn0KJRxDaL4XO+HLdS6h/qK+eHS3NhalcODH0qrIu8FJwC99bjsaaO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11954
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIRLqaLRmQBBhVatqKQ/vuFGvbftn/YEjQbz9Z6KzCE=;
 b=fWIxBYGFaQ2+x2DP3+V6hm+VkwyC2vPPQmzVH7u7pK0WacsZWHrr1ZhXIhPw5fHsxSKVSlXlEvD49B2fD7nEIkcJVoay6ISq21t+YSpo/KyvnqSSo5keu3mmNUYMYQNSEFAijaOdwIWujvi4sXxU92qE3ovxSvESfYnvwzm/rDYrDLAndcz8V57P337ROzSeznaDWlxy2eTNaV+N+ecFXoysS/NDsAAcWZXj51mM9w+A0YTMTQgmgYKtG7Q9mXjod4fsrgZ5XGbPnz4NxvZgRuVo/NW2eObYALxoNzYHgAjfKbALpItB8HFgyVNC/7pIAl5bCPFUJHWVGp/x3ZJ/wg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=fWIxBYGF
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alice Guo <alice.guo@nxp.com>

i.MX93W integrates i.MX93 and IW610 WLCSP in one package. The i.MX93W
EVK reuses the i.MX93 11x11 EVK with some minor changes. Since the
upstream imx93-11x11-evk.dts in dts/upstream does not include SDIO
and WIFI nodes, only the part of the kernel DTS changes needed by
U-Boot (mainly the I2C3 pins) is added here, together with a new
TARGET_IMX93W_EVK Kconfig entry, defconfig, MAINTAINERS entry and
documentation. The board uses the LPDDR4X 3600MTS timing tables
added earlier.

Function differences vs. i.MX93 EVK:
    Function        i.MX93W EVK                     i.MX93 EVK
    WIFI/BT         IW610 in i.MX93W                IW612 M.2 module
    MQS             N                               Y
    PDM MIC         N                               Y
    M.2             N                               Y
    RPi 40-pin HDR  Limited (pin conflict)          Y

Pin connection differences:
    Function  Signal        i.MX93W EVK             i.MX93 EVK
    WIFI/BT   SPI_FRM       SAI1_TXFS (spi1.PCS0)   GPIO_IO08 (spi3.PCS0)
              SPI_TXD       SAI1_TXC  (spi1.SIN)    GPIO_IO09 (spi3.SIN)
              SPI_RXD       SAI1_RXD0 (spi1.SOUT)   GPIO_IO10 (spi3.SOUT)
              SPI_CLK       SAI1_TXD0 (spi1.SCK)    GPIO_IO11 (spi3.SCK)
              SPI_INT       CCM_CLKO1               on-board IO expander
              NB_WAKE_IN    PDM_CLK                 on-module IO expander
              WL_WAKE_IN    PDM_BIT_STREAM0         on-module IO expander
              IND_RST_WL    PDM_BIT_STREAM1         on-module IO expander
              IND_RST_NB    GPIO_IO28               on-module IO expander
              PDn           GPIO_IO29               on-module IO expander
              NB_WAKE_OUT   GPIO_IO14               on-board IO expander
              WL_WAKE_OUT   GPIO_IO15               CCM_CLKO1
    I2C3      I2C3_SDA      GPIO_IO00               GPIO_IO28
              I2C3_SCL      GPIO_IO01               GPIO_IO29

In addition, the default iomux setting 0 of CCM_CLKO1 outputs the CCM
CLKO1 clock. On i.MX93W this pin is wired to IW610 boot config[3], and
a clock on it would cause an incorrect IW610 boot mode. Configure
CCM_CLKO1 as GPIO input with internal pull-up in U-Boot to avoid the
issue. Since CCM_CLKO1 will eventually be used as SPI_INT for IW610,
the pad setting is aligned with SPI_INT.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx93w-evk-u-boot.dtsi     | 171 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig          |  12 +++
 board/nxp/imx93_evk/Kconfig             |   2 +-
 board/nxp/imx93_evk/MAINTAINERS         |   2 +
 board/nxp/imx93_evk/Makefile            |  12 +++
 configs/imx93w_evk_defconfig            | 172 +++++++++++++++++++++++++++++++
 configs/imx93w_evk_inline_ecc_defconfig | 173 ++++++++++++++++++++++++++++++++
 doc/board/nxp/imx93w_evk.rst            |  72 +++++++++++++
 doc/board/nxp/index.rst                 |   1 +
 9 files changed, 616 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx93w-evk-u-boot.dtsi b/arch/arm/dts/imx93w-evk-u-boot.dtsi
new file mode 100644
index 00000000000..4cf6a4a71d2
--- /dev/null
+++ b/arch/arm/dts/imx93w-evk-u-boot.dtsi
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx93-u-boot.dtsi"
+
+&{/soc@0} {
+	bootph-all;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&clk {
+	bootph-all;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+	/delete-property/ assigned-clock-parents;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&gpio1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&lpi2c1 {
+	bootph-pre-ram;
+};
+
+&lpi2c2 {
+	bootph-pre-ram;
+};
+
+&lpi2c3 {
+	bootph-pre-ram;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	gpios = <&gpio2 0 GPIO_ACTIVE_LOW>,
+		<&gpio2 1 GPIO_ACTIVE_LOW>;
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&osc_24m {
+	bootph-all;
+};
+
+&osc_32k {
+	bootph-all;
+};
+
+&{/soc@0/bus@44000000/i2c@44350000/pmic@25} {
+	bootph-pre-ram;
+	bootph-some-ram;
+
+	regulators {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&s4muap {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+	fsl,signal-voltage-switch-extra-delay-ms = <8>;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&iomuxc {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		bootph-all;
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26			0x31e
+		>;
+	};
+
+	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
+		bootph-all;
+		fsl,pins = <
+			MX93_PAD_GPIO_IO00__GPIO2_IO00			0x31e
+			MX93_PAD_GPIO_IO01__GPIO2_IO01			0x31e
+		>;
+	};
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pinctrl_lpi2c1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c3 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index cbd0078ba2a..03dbcc044ed 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -105,6 +105,18 @@ config TARGET_IMX93_11X11_EVK
 	select REGMAP
 	select SYSCON
 
+config TARGET_IMX93W_EVK
+	bool "imx93w_evk"
+	select OF_BOARD_FIXUP
+	select IMX93
+	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
+
 config TARGET_IMX93_FRDM
 	bool "imx93_frdm"
 	select OF_BOARD_FIXUP
diff --git a/board/nxp/imx93_evk/Kconfig b/board/nxp/imx93_evk/Kconfig
index 305c3963f06..99df2079107 100644
--- a/board/nxp/imx93_evk/Kconfig
+++ b/board/nxp/imx93_evk/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_IMX93_11X11_EVK
+if TARGET_IMX93_11X11_EVK || TARGET_IMX93W_EVK
 
 config SYS_BOARD
 	default "imx93_evk"
diff --git a/board/nxp/imx93_evk/MAINTAINERS b/board/nxp/imx93_evk/MAINTAINERS
index da0540307c6..0c542aced87 100644
--- a/board/nxp/imx93_evk/MAINTAINERS
+++ b/board/nxp/imx93_evk/MAINTAINERS
@@ -5,3 +5,5 @@ F:	board/nxp/imx93_evk/
 F:	include/configs/imx93_evk.h
 F:	configs/imx93_11x11_evk_defconfig
 F:	configs/imx93_11x11_evk_ld_defconfig
+F:	configs/imx93w_evk_defconfig
+F:	configs/imx93w_evk_inline_ecc_defconfig
diff --git a/board/nxp/imx93_evk/Makefile b/board/nxp/imx93_evk/Makefile
index b077acc70a5..ec2a0af3501 100644
--- a/board/nxp/imx93_evk/Makefile
+++ b/board/nxp/imx93_evk/Makefile
@@ -8,5 +8,17 @@ obj-y += imx93_evk.o
 
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
+ifdef CONFIG_IMX9_DRAM_INLINE_ECC
+ifdef CONFIG_TARGET_IMX93W_EVK
+obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing_3600mts.o lpddr4x_timing_1866mts.o
+else
 obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing.o lpddr4x_timing_1866mts.o
 endif
+else
+ifdef CONFIG_TARGET_IMX93W_EVK
+obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing_3600mts.o lpddr4x_timing_1866mts.o
+else
+obj-$(CONFIG_IMX93_EVK_LPDDR4X) += lpddr4x_timing.o lpddr4x_timing_1866mts.o
+endif
+endif
+endif
diff --git a/configs/imx93w_evk_defconfig b/configs/imx93w_evk_defconfig
new file mode 100644
index 00000000000..9a1d134f4db
--- /dev/null
+++ b/configs/imx93w_evk_defconfig
@@ -0,0 +1,172 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x18000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93w-evk"
+CONFIG_TARGET_IMX93W_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x20519dd0
+CONFIG_SPL_TEXT_BASE=0x2049A000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x2051a000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x80400000
+CONFIG_SPL=y
+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
+CONFIG_SYS_MEMTEST_START=0x80000000
+CONFIG_SYS_MEMTEST_END=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="run sr_ir_v2_cmd;bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx93w-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x26000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BOOTROM_SUPPORT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x83200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_CPU=y
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_BMP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth1"
+# CONFIG_BOOTDEV_ETH is not set
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_ADC=y
+CONFIG_ADC_IMX93=y
+CONFIG_SPL_CLK_IMX93=y
+CONFIG_CLK_IMX93=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_IMX=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
+CONFIG_PHY_REALTEK=y
+CONFIG_MIPI_DPHY_HELPERS=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX93=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_SHA384=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/configs/imx93w_evk_inline_ecc_defconfig b/configs/imx93w_evk_inline_ecc_defconfig
new file mode 100644
index 00000000000..0d66f7529cb
--- /dev/null
+++ b/configs/imx93w_evk_inline_ecc_defconfig
@@ -0,0 +1,173 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x80200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x18000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93w-evk"
+CONFIG_TARGET_IMX93W_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x20519dd0
+CONFIG_SPL_TEXT_BASE=0x2049A000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x2051a000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x80400000
+CONFIG_SPL=y
+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
+CONFIG_SYS_MEMTEST_START=0x80000000
+CONFIG_SYS_MEMTEST_END=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="run sr_ir_v2_cmd;bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx93w-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x26000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BOOTROM_SUPPORT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x83200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_CPU=y
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_BMP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth1"
+# CONFIG_BOOTDEV_ETH is not set
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_ADC=y
+CONFIG_ADC_IMX93=y
+CONFIG_SPL_CLK_IMX93=y
+CONFIG_CLK_IMX93=y
+CONFIG_IMX9_DRAM_INLINE_ECC=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_IMX=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
+CONFIG_PHY_REALTEK=y
+CONFIG_MIPI_DPHY_HELPERS=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX93=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_SHA384=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx93w_evk.rst b/doc/board/nxp/imx93w_evk.rst
new file mode 100644
index 00000000000..24e994e2ee4
--- /dev/null
+++ b/doc/board/nxp/imx93w_evk.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx93w_evk
+==========
+
+U-Boot for the NXP i.MX93W EVK board.
+
+Quick Start
+-----------
+
+- Get and Build the ARM Trusted firmware
+- Get the DDR firmware
+- Get ahab-container.img
+- Build U-Boot
+- Boot
+
+Get and Build the ARM Trusted firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.14
+
+.. code-block:: bash
+
+   $ git clone -b lf_v2.14 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ unset AS
+   $ make PLAT=imx93 bl31
+   $ cp build/imx93/release/bl31.bin $(srctree)
+
+Get the DDR firmware
+--------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.32-1991416.bin
+   $ chmod +x firmware-imx-8.32-1991416.bin
+   $ ./firmware-imx-8.32-1991416.bin
+   $ cp firmware-imx-8.32-1991416/firmware/ddr/synopsys/lpddr4*v202201.bin $(srctree)
+
+Get ahab-container.img
+----------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.6-c0b284c.bin
+   $ chmod +x firmware-ele-imx-2.0.6-c0b284c.bin
+   $ ./firmware-ele-imx-2.0.6-c0b284c.bin
+   $ cp firmware-ele-imx-2.0.6-c0b284c/mx93a1-ahab-container.img $(srctree)
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx93w_evk_defconfig or imx93w_evk_inline_ecc_defconfig
+   $ make
+
+Burn the flash.bin to MicroSD card offset 32KB:
+
+.. code-block:: bash
+
+   $ dd if=flash.bin of=/dev/sd[x] bs=1024 seek=32 conv=notrunc
+
+Boot
+----
+
+Set Boot switch to SD boot.
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 52c8e85fa5b..bb5ce08b1dd 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -17,6 +17,7 @@ NXP Semiconductors
    imx93_9x9_qsb
    imx93_11x11_evk
    imx93_frdm
+   imx93w_evk
    imx943_evk
    imx95_evk
    imx952_evk

-- 
2.34.1

