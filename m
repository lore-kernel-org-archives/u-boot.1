Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181B606B34E
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v1zc9WGN;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=U8htlvuX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2195A60DC3;
	Fri, 13 Nov 2026 18:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q1YtI9_QljKu; Fri, 13 Nov 2026 18:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 764A160DAA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794593011;
	b=jRcgqu/9pQQnfDmiub0WtS60I7yQOEzVkZPnCBpZAlpPhumB2/18VI2NqlNMPBUeQG8V
	 Mj4x7OIujqb+kdTBLPvblanDWkQMBpOkyh2m2Y7eV4ISENtWA/V32gxC06Hz1w2Sc3im1
	 KudL6wxnN469V3v7msE2fY+7xP4DVU8knO3JnQYl7aGBYFu+JSP9+gnK2AkmsOjE2P8NH
	 bZD6FXhadtnNJ1STzhhd7NX0hPcKzTt0abNtXY+/UwcTY1nE0nkrMxYnA6Em7UF5BOmhI
	 wU4TZRztbnJoSUZn4UXO1DeTC2EpUOnjC5cUNhstFtppDp5vD6tB9YvwPpjlgD8jYvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794593011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Yi/IPm3IUZ2Xp383QTusdt24b/mppr4ErUs3Cl69Yzs=;
	b=D9YBpap3P7WVDp2C5T8FAlMga92caj3dnhiLLuEdQcgtcvNC/e0BNx+3tJ8wn/coDD2c
	 XK3TpOEn7FxOojjTPfssNqwMYrmAFzogaTJoRnDd1db2so+Amsb88rF968VCdeBSmit8x
	 zO32UCU50e0bN/BDh/5XR6Woz4w39BLMJjaUKGaqZ3xVDEEZ2jWEJIdcuthpfZq8wLSH7
	 mSWNLrgRzjWW/ur4UNga2kon77qbV5eDamkQK4/e+q2Ix6jw2YqJJCpZ+eyIF6o0YhtJ1
	 zlPWJ57Dwv9WoFQGC8Wk29dJl534H3GD7zLiVdBWMaoH/cGRwPGQQNslBQ7ZOtvL4LQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794593011;
	bh=Yi/IPm3IUZ2Xp383QTusdt24b/mppr4ErUs3Cl69Yzs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v1zc9WGNAohOgAJn98KQZiL8JZAG0ep/yNyA4GbXlq7x2UkUybFugf7DZDHU8Peq3
	 x+8bS+5Jkub4B3OO3yPsWIZi3QWfK0OmlEAscuRUSx5VE7hI1oICbGurlcYrFo6LgX
	 iSORWBeGbZLuaQkn6gH6Ab1rWR81nKQrLiuwakl+LlI3vEhUTpMMDyJpn2Qs9U3TIS
	 XxR1hYC9EtPnc0Lnp7f7kdPaXlaH+dSRQKFJdy+r5Ba8DqiCfzvYwwj37PIxUMh8ow
	 Sjho+stAad6cNxCF94SSR08/9lJRREv7DzabsSKC8gB+1c81HzClKi7rYD5ciShp/S
	 2fsB39vy4O/CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 764A160DAA;
	Fri, 13 Nov 2026 18:03:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C08D6F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDA2F40E17
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rr99-1oqTXA0 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4AF940E0E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=U8htlvuX
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4AF940E0E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi/IPm3IUZ2Xp383QTusdt24b/mppr4ErUs3Cl69Yzs=;
 b=U8htlvuX7yNPVCtUn1Pr8z9YYbd56+5c0JHjliNeeJnGiAKxFC1VmGxiKi+Jpos8rYmzd6XDmP/6qyRAgrtvREtnfvC7z4UOwxAWADKqSJKskqVxxjAfejuxTkk7lj6LDx15r4t4fHi1gHBQZH7awJNSsaf+k4Ie69AXJurQm7k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:03:25 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 18:03:24 +0000
Message-ID: <fb7dcc4f-0b82-4950-8541-39abee87efc7@cherry.de>
Date: Fri, 13 Nov 2026 19:03:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/37] clk: rockchip: rk3576: Remove unused BPLL
 register macro
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org,
 Elaine Zhang <zhangqing@rock-chips.com>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-29-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011222930.1085075-29-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:802:2::34) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 016e2ef7-0682-4b0b-bb57-08df41b068d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|261022105027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pnvaoKJXrmRBd0uA5lYiwn3Kezc4Vy46q1wkHkSIQ5J4v2DRSgAUMHaJy/8TX5B5cfw00as+jkdDAsdxUrToozY4bTIe2tkNbYIUCZTrmLOmNOgVIQvyCj3upZ5OioGDFzLzvUzqCZbXy+qDtHvti1ovVSAliob3ku2YVIAdk2sEOMfnsjRBZ04vK/cSs9XpPO4QHngAcmXmmiWjykCI/rE0JD0KVKs7iJlDyyighl/lM4C2HzzHFS3pGx0m3iEL86NmmqhSuGPzlGrLx2eDvnqnokgEwXovt/+WHpFZOmOxpPH02fO/WqQel4m+IKdfhfftzGPhW4MsLHiQ1eSMCg5hhL+skGBMCnzWk8FcNNczDReZzMN/2mI5XtPXe/UpnbRy6d66zeWj4Mi0UWgcMxos8V3OS/uq6DbkfuGsnlfWneOPisuP3JOQTzvGm0HAie4tgNgcyALgUqm/PHgdb3pX1eLyqDu+UFAXeoD/BpqZoKTH+7yA2ZQy4kcYQ9ULpahYJYmBG0fo3biErSdV/LnNxTjt4Wmv/Yo4msPCMa0h5EiFInWZ+c03hX6zUfYccpDuSQHUb574pmwL1JoNx3Xggh9wN+9aL4Qf4hxzFt73yugyXvtrADQQBtZvfrygkYs1OUmGCEcoYBgmCZU9woGSAZE+/CLkM1xZPTB9ZH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGQvdTYyc1JJNjhiTFRyazU3ejNrUjZocU5LcENwQnlaOU43aVlCMkRtQUJi?=
 =?utf-8?B?Vmk0V2JaNlF1ZnlRWk9rUVN6N2gvbkllUng3bDNGQXJsQ09sUVVzRHhrVzZL?=
 =?utf-8?B?U1lBaWNENnJBOWdrbVRwTlIxY0Z4RmJUaDh1b1VSaitXcDdXbEp4TXE4N280?=
 =?utf-8?B?d08xTmQwQ0ZXazg4L05rN3M1bDh6MS9qeEkwOTBzbi94RzUvQjlXZ0YwTUZz?=
 =?utf-8?B?MDIrMGpoMXRKRFFRL0ZCNDFBdmM1U3M0WlFnNE5HZjdIOU5YczV0UUl0V1dT?=
 =?utf-8?B?L2x4STlpQTFGb2liMFViWVBiaW95ajZUQ2FmWG1LclMwY0p0ai9QREhWSWNR?=
 =?utf-8?B?QW5Ha0huWnRJRWFVZlp0Sm5ZVTl2cDdyc2d6RkJ0Q2pmazNDVzV6TFJNMGla?=
 =?utf-8?B?aUF3RnBTTTkybWhtaFVnN3QxTDNPSnVtUHIxSUkzcnJmRmluSU5yYnl4RDBh?=
 =?utf-8?B?Z2ZKaitNWWp5KzF2WWtnb3dRTHI4MG1xa2p3STJuS0p0ZWt3UVZEaXJTdXlY?=
 =?utf-8?B?N01WLzNXZEZldFlnZ0czbFdyRVVydmdEcTJhcXNyNU53Nzh0bWdRWk9sR1Mr?=
 =?utf-8?B?NG1xNHZNeGlQc2VDc1BTRk4rc3NmYzFGR0V3djdUMXorS2doU3liVVVJK1JX?=
 =?utf-8?B?andkL0NNSVlFbHF1dktNU3U2L2cvZUpLYXdrWG83SVBvZU5iS1pqOWFaMThz?=
 =?utf-8?B?OXFjMkczcE9wbUFLOS9OZW5FcTZUdHQwbmkzSHpuckg2ZVhUVnBIdm8yb0pY?=
 =?utf-8?B?aStNeHluQlpHZnVscGhsVlQyWmpNNGk1VTM0L0IyeDUrSWJ3VVFnamdBNGk4?=
 =?utf-8?B?VFVJSitaT3FzNVJHa0dPOXZmRnkxYmxsTll2NmswdktjRko2dU1iN2tkYTJH?=
 =?utf-8?B?T0t4UndEWFZKWFFjZ3cySmlmc203aWxXZDcwbTh1T003OXMzS3pGczRMMGxl?=
 =?utf-8?B?WlhLSUZvM2hiNFFrTlhrc0NTaFl2WkxuTnN0ekFka3lDakc5K0R3NDF4VmFk?=
 =?utf-8?B?RE9UdDBORkhTNHdFWXowaGI1S0NmcE5aNEkwTForYkdPV0tuYmZ4VS9WK0hl?=
 =?utf-8?B?ZFU1alJ3dHRSQlhaS3ltU2FBWk85UmFkc2djcms0aHlIRXVyaFdoT0pGT1FT?=
 =?utf-8?B?ckQwUkRBQXBvUWdMcGtqY0Z5R0ZLQzlKbWYrcDJuYXFEQ00rQmNRc3pOM3dB?=
 =?utf-8?B?emI2SDlXbFZVUkMrYnFxZXplRVpHSW9Eb3Y0SGFVbElkVlJjdmkyRlNrZkFM?=
 =?utf-8?B?QlpPRVNsK2lQU2wyUzZFOTNBb09rWUxkNkFIaHltYmQzcUZMM2hnMkJHUE5o?=
 =?utf-8?B?WUFIRlZESXFPaWxud2J3QitZWDgwbHFrbGlOZmpaZmYrdU1BUnJMOGJ6VStr?=
 =?utf-8?B?QVdyWGJFNXlsbEI3YkVZTkJWUlRpcWhidGlmdC9RMWJEWnh0eVlLM2ZXbFYy?=
 =?utf-8?B?SUF1blZJU3piSXg1WjFxaVVQMy9Td0dWNGlOME9ObkEwMGRRNW1WVHk1MkFJ?=
 =?utf-8?B?MkV1czFDL0RSMTQvN1RJVU9DYzB1NlRnK3JxdVowOEVON1Uzdm92QTlCMEVG?=
 =?utf-8?B?ZDBOY2o2OU5JVmRjZWdjY0tlc1Z6cmJ6VE43cXB2S2VmOFJaRHlsNk1id0p2?=
 =?utf-8?B?Mkd6ZnFtcG9kUG1uYnEvYjRKVHJpczMxM1dxeDhrakNBNmdNZFQ1N1RpMW9u?=
 =?utf-8?B?bVJGZW5PcFYwcUJIQTN4aWo5REZsdHFEelh3aWlPckVBVktJc3M0VEw5YmZQ?=
 =?utf-8?B?c0E2cjczNFcxS3F0WFo5T0MrS1J3M0Nhb3h6Vk5zWnM4RXR2QTI1S0dPUFdh?=
 =?utf-8?B?OWk2NWJPQjNyUUQ3K21LenJpRXpPQlIvbTlWMEZweUNvZE9NUit6L01OdmY3?=
 =?utf-8?B?UjVOZXJCbHYwZDRYMEpBM2ZYam95aUdISXVEVVBWZEV3RURLeE02S2VmVmw0?=
 =?utf-8?B?TW9oa2tnLzgyZ0ZXVTRmYld0Tkc2UTdrS1IwbWtJeWhKSjNjZmdvSVI5ZFRu?=
 =?utf-8?B?UXZUdTlpbzdZcjlkWXozc05pYWVxbVNNMDJWTUVuZ1U1d0tQMDlNdjFmVGJR?=
 =?utf-8?B?a2FycXlXUm9tL3B5UlY3MmRoUHFjb3ZPaG9Xc0ZVZWtJUVk2VzAyRzlPODRy?=
 =?utf-8?B?U3JhTmhkQXp5bTA1eE1RQ2w2cDgzWU9mUFZtQi9ud1dOdTROWFBjb0pQQThj?=
 =?utf-8?B?bXlrYkNVVURuQW1ja3dxT1BkektNMkNkRWFSN0l6a1cvME0rTkM0aUVic2I2?=
 =?utf-8?B?T3BKSlJXOC9ZRE1TcnZ2RTQwOWg1WGlucnhKaE9XTW9xR1ZUZjIzNzVIRGZK?=
 =?utf-8?B?bGUyN3NRKzRBSC8wK1ViTVNsUHBoTVdqWk04RFhnOEZYVkU2N2Mwdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 016e2ef7-0682-4b0b-bb57-08df41b068d1
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:03:24.1468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20yYZJ0wVx5cYIeomL4zzogB4CFgMWQiSRINovOPgS3QzPCzcKxDyYty5x4vtuXbngxszllCuNZeH/AjnC7r76BLowIOYamr5pEylnRk1u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/12/26 12:29 AM, Jonas Karlman wrote:
> The BPLL con registers are located in the main CRU and not in the
> BIGCORE CRU.
> 
> Remove the unused and incorrect RK3576_BPLL_CON macro.
> 
> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
