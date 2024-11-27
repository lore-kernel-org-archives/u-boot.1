Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCED6ACC5
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7156897DB;
	Wed, 27 Nov 2024 13:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FqVA5lwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751F0897F9; Wed, 27 Nov 2024 13:33:04 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B8F897EB
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIDJD428dQcWGNTKo9yXHLCUNQwyFUA7G7UrP+9bZXAMefwkfHGGo/c8AP8r5PwCThBDdgItz/2N8uxfV/MEQI3cT3YYR2F6ZtG9ghEdFHUOnwHpxvfasKVJaFNkQcsS8be0IIUYTb36XAUWxKXKlEmiWxlmaNLf14dEwAvPnC1CnQzs0aw0BpX3Jdg/IXAKGYcSwzoTa2jwVjj9CDvLL7KSwkhLY+qV3fiIY70LDSs+ck7UCHvL2IV/ylCJI2OHyJ9wnoNTYynK/+9nMyMC83iuDJQYvOh3BXyexMM7f+n4PwCwOmpSYSwpcVubiY5GP6C4K9c6ZAMx0TC4+8EiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih2xXfmoNASTVgPGHKEy/bbQUPoVZeZNJNOhYWAwxYs=;
 b=YTMC1Y+rkZ+qrUzeBaeG9Xk4L8q7PGqhHYJ0jozeUuVK/s4yJ+evsTMutDL++FvgL5Pq7UIa/nVzNAdty3Bf/mF4d9BA2vQSK1HaCTUMTZ9bQaVtMN7ROpfuCmi5/f3E0myhjx5+3njBW2fQBPyhn2CO1yUxBgt2tUFMVqE2bOeMmM0Srj7CqLTPSoL2jfAN5PrBR0Zu5ygib83UtfL8wniqGZAm1mRk3k2EuXO6F/wDlm+1RdR8axoW7pcfJYGstQm0KKBEtQg+z54icC/9cDkD3MXS9bS3BBjK2al5rgty/VQM6ITlWYrbIIoFomQ01KGIQfcy05tzeVPBhCJNZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih2xXfmoNASTVgPGHKEy/bbQUPoVZeZNJNOhYWAwxYs=;
 b=FqVA5lwNsorRNCnGcGh2icVNQcuxv6g/Mvf6OVfVTpae177YiiXRVi2PnOGSqARC2Z6tztM8bDIIHVaO+bafHQe+/s7HQU1ntnG7lG3lQQsQqjMhzYi9nIF+Su5E6NkMRvL+HZ96FfbXz9t/sKtIKq7FC1ODpe3PbbezNekLzbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 12:32:55 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 12:32:55 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 27 Nov 2024 13:32:48 +0100
Subject: [PATCH] board: solidrun: clearfog: enable ddr odt0 on write for
 both chip-select
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-a388-sr-som-odt-v1-1-ad51f46a6e9a@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAG8RR2cC/x3MQQ5AMBBA0avIrE2iJVWuIhalU2ZBpSMiEXfXW
 L7F/w8IJSaBvngg0cXCcc9QZQHz6vaFkH026Eo3SukWXW0tSkKJG0Z/ou2C9d5MplEV5OpIFPj
 +j8P4vh//oLp7YQAAAA==
X-Change-ID: 20241127-a388-sr-som-odt-89f8dd6b6410
To: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: b857d49d-b7f9-43f0-eda0-08dd0edf9e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3JlMGc3eTJhQk9OUnhOWE1EVXo2VElvUGJsb3NpTzlXaEVUK3EvMTBwUXUr?=
 =?utf-8?B?OFhzbkVWdG9jOTJWZnU1WjYvSEl0SzhLSk1mNGlOZlNWTU0wcFV6ZW1iVGFs?=
 =?utf-8?B?a3Mydzc0OFpLbEFmdDFTYldvdkF1eTkwVzhTcGc3WjFCNFpBb25va2JqNXJm?=
 =?utf-8?B?SmE1SEpCUDFHMHdMYnVIWm9hZUNndmhaZ0VVNmowVFM1Q01LcTc3TmNkNFhS?=
 =?utf-8?B?TzV6b1Z6dXlGNDhiZEF1OGxMQ0VWbDV6V3lIVTZxSUZvUEtsMVR5eEUzMTFH?=
 =?utf-8?B?YUpYY2hJWU9MamJGUVI1U1V0M2krV2hSbUZoeTluVDMyNm1ubVozZU9kUHZO?=
 =?utf-8?B?NXM2SEcvRmdFUjQwdVlyM0ZJeVZhWldDRXZBaVdoQ3JaRk9WZk5iaUt4OEtE?=
 =?utf-8?B?TkMrY3hqNnQwaUsvSFpIZGdWR0lJWVJicUZrSlcyUzlrV2duZlFxMDRWYlBS?=
 =?utf-8?B?Tzhwa2h6QTNhWHFuNjF2NjFyQm0xdmxubzFSSlpMaUhHM0VZanZib3BheXpm?=
 =?utf-8?B?R0crdU02L1lUd1ZkaWtDeEdPbEJvNjE3VVpkNy9lREZMQ0hpRVA3NG9Gb2pP?=
 =?utf-8?B?dU9tOXVEd1c0cGlhZWJSMWI5M1Q0K3hCK0ZDUzFOcFJnRWtvNFJMM0VieDlp?=
 =?utf-8?B?SklDWUFIRndoYnp2VkR1NTQ2a2FXTWJxZXVLOEIzNTM0Q3lEdFgrTER4dHRN?=
 =?utf-8?B?L0E4V1BTQS81ajY5SFpvWldZMFU3cWwzVVcvUS8vMnN1ekFDUWZBUWROZXNh?=
 =?utf-8?B?ZXZPY0RlU1g1TzlmSW1HL1RnNEFlZW9VemR3dXZKTmJKQmxSTjkxK0wrMk1E?=
 =?utf-8?B?NDlHbUdGdjBMT2FuMVJVNHBXTXQvOTVacUNuUkZERjIvWkd0MnA1dmliV0FF?=
 =?utf-8?B?RzlMbG15TUUrS3BiMUl1WU1XOXk0a3pzVUVuQ2tGYlNvbldaSVoybmhVKzlX?=
 =?utf-8?B?bllVMjNmMDF2UFZKZWFSNkdhWjBYQndZTWNsd0ZjMEFCT01WeFkwbmpzQW9U?=
 =?utf-8?B?N0taN3NnMGJJZkdERHI5K2RtaHRjTGJVVFJwQWFrTk5OMldBamdJeFN4ZURu?=
 =?utf-8?B?NHIwNTBHQm1JdkdZa1Zxakkzc1ZHQkR3cytGbXpqYnZ1T3BybC9WZFZBaUIy?=
 =?utf-8?B?V2wva0FxWkdTaG5ueit2V0xXRklaVG9kai9JUUhKU1paWTNCRGJORFUzeDNi?=
 =?utf-8?B?RlMrV3lUWmdja1Z4N1NoVllEY3E1THpWdHlzMU9za2ZzdFc4VjVLVDZZancv?=
 =?utf-8?B?Z1k1dGJ0ODRJcEp3VXpWVTRXR3FnY2xqQ1NQRm5OeDE1QjFEYlJhWE1oTFlW?=
 =?utf-8?B?cFVsUGpKZTZwR1hKRWtZeDM4WkZpQVMyajZldm0xdTA2RzMzbjRVc2NPM0k3?=
 =?utf-8?B?VVVJcFJzWmxvc0FXTU1iUldTMU5IMEpBcGZVVmRKZ3lsZmVuVlpsWHNsRHR3?=
 =?utf-8?B?UzYyR0pPR3RiWU5GWGVwVjZRdXRMTmo3T0pDZWtuQ1E0T2xVZ05QR0FETW5K?=
 =?utf-8?B?eVFXY09xN3NFUjYvUk4vbmdDaFRzbHpDdkFWVDZ1SUt5VzJncDhRN1YwaTJH?=
 =?utf-8?B?WlAwWTJQQTEwTkZaN1IwK0JnY2hTYzllVlFsWm94S3B0Q0JVYmQycnJlT2d3?=
 =?utf-8?B?NVNtSEJyazhwTkdzbkM1RFBnc24ramt0MU50aTRsTWtnRElqMEszVC9xd3Vk?=
 =?utf-8?B?b2pMd1JubjArd1JXaWUza1MxbmF1blJWZDVYWUNVanI0OWQycTVQb1ZVS1NC?=
 =?utf-8?B?UFY0SXNWWGdnMkZ0K3VoK3hCSnRtMnNQeTNoakt6N0lBNDJubmJKd1FJV2gv?=
 =?utf-8?B?eUxjbHJWaThsaFVpc0gxRERxNlZzYWRCQ2lzenEzVzlwL3p1TEt0ZXZ0Z2dE?=
 =?utf-8?B?RGQ3Zm1Yem9WeUE5UDZNQVc2YjIwM1AwRGZvT3E4azBGYmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHB6Z0JOK1h5c28wRzVTNHM3ZW8yM3VHUEdNYXlLU3BCdEo1SDV6TFNCYk5V?=
 =?utf-8?B?OENnUGJLbkE1WUpkSEJkUGdhT3VQWnRXNkxKSTlsZjFGNFF1dmRTNG9NSXM3?=
 =?utf-8?B?VldHVy9xK0tCNkJxdjVsK0ozQVRIWDd5YlhuVnd1MmZabEhSY0R3UExnR3ZJ?=
 =?utf-8?B?c3hLMEFuRG5aWnhTdmxuOGszTTJ5dmRzYzNoOE9RVTgwdFJ0OG44YzJGaUkv?=
 =?utf-8?B?ZjRtRUIzeXZqZXBmZ1lDTkZFUmJydGRGZWFzVWkvOXQvN0RKc3hTSFRHRk44?=
 =?utf-8?B?MWx6ckdqeEVDU05nUS9lNGhickdQVllTOUFEWEtGVmxZL1Myb1VGcytxanU3?=
 =?utf-8?B?dkhCbGpQNWhkMUZ2Z3MzZ2MxM3RWZXh3SCtuS0hLV3AyandBNGhKeVhYMGZY?=
 =?utf-8?B?NUYraFhxRmpEb1RQTm5pSUU4TEtqcDlvNTJkNEtzRUFSQmxFTHk2RWg5b3dO?=
 =?utf-8?B?ZGxicm1rSWNlT0ZpeXpuTU5FVmgwK3c4YXlkN0pvTktkYVZSQlpYb0hFalVn?=
 =?utf-8?B?Y2JJMFNtZDB6Y3UwREdHSkZ0dmY4bVkxK0x5OTNzTGNqTmJ5UzFNQlkrL3Qr?=
 =?utf-8?B?ei9qQVlTYTIrNVNwLzNBeGcwdVY0QUlTTGVpMC9FbFkxQ2RKOFYyUUN0YXZa?=
 =?utf-8?B?WkU0MS80UVVFdW8rTUtOa0k0SW83L3oxWmx6THFzemF1MHVLdGlEOFdYbWV6?=
 =?utf-8?B?TytrWEtBd1ZvdkdmQ081RlR5dWpZTHk5THozSjQ3MzlxYkt3VVk3UXFRNmEr?=
 =?utf-8?B?M1pGOFUyUnkwYUpvdU01TlVmVXM4L0JJQk9Db3dyWnViK1ZacUdrQytleGNN?=
 =?utf-8?B?Wmx1Yk83TXluYlBnc3ZMMVcvTGNUM0IvMkUxVHMzV2VsQkYwVXVmM3VRdmV4?=
 =?utf-8?B?dkphb0lMREFnSlY2QkMwNkt4TlNhdEdtOTdWSGFoNzc4M1N3Uk8rMFFhdzA1?=
 =?utf-8?B?WVB5L3R6YjBya2tIS1h6TWdWVUJLTUVvZEQyNHJ3azljUW44TDlvY2VOUE16?=
 =?utf-8?B?Q1AxZFlFclMzeFRtSjcyQ3dLSHNyTzIvL3FYSTcxS3c1ZDNkaVNUNWU0V1ZY?=
 =?utf-8?B?Y01TNGhxK05LemxDNHN1bnVqdTZtK2pOdFowUXp2dnFVajQxOXhONjRBM0hU?=
 =?utf-8?B?TGExRVc5dnJwQVJqdVZWZlNrK0hqRlpnTjVIOGRmcTZsTThtQ2Y2cGR3eGlw?=
 =?utf-8?B?ZTdjL3NKWW9iTkM2bG9sS0R6MW1WdW1UTUhaWGIydkJxeTd4UGRyS3dIa2dI?=
 =?utf-8?B?R3A4aHZweDUzRmVRY2d5T3pZRHNLRzg1YzVYNWxXZTY2aXI5RDl3eVBaS09r?=
 =?utf-8?B?QzFpU2M2bklJcEhJcHBEQXQzSGRCNHRIRkE4M2xKbEFOTzZZT3UwaGhVYlls?=
 =?utf-8?B?anRKKzR1R1JYZ2R1dHRmOVV3TkRXbHExNWxpKzFBSzJLdEFXdUNDYU9NanhF?=
 =?utf-8?B?ZTliWXBJYTg3Nk0vSTJReXZndDdEbGEvUzNaaGxsTXUwOUtFSjNYZFVKQUw0?=
 =?utf-8?B?TTBscXorKzY4TWJ6dTRIWVNKdUViZXhNWUdGTmJuaFZjeWw3TlVmV3pLT3Z6?=
 =?utf-8?B?bzQ1bVJhY1ZTWFpUL0lORXNtY0ZxZ1Fzai8rclFwQjBrNFZ5SVNRdnl0QXQ3?=
 =?utf-8?B?eDFyWFpOelVaQk13Yktlb0gveWxHUmZvQkFTdXMvaUNCZ09wVU9WSXAvdkNQ?=
 =?utf-8?B?bk5VQlh0bHFENGY4SjVlYUtIc0xEdFRTbFErbVpjOGZJa0ZMU0ZSVUFNTnZY?=
 =?utf-8?B?WWtPMFphQkxaakFhRStsZHZWdE1Idk9mdlhpVDl3UU8vME5TZlJQL3JVYzNJ?=
 =?utf-8?B?THh3ZmM2QXVnbGRiTXdTODZORFBxRTFwQm5aYzNBWmxkOG5Pd05WcUh5RTJZ?=
 =?utf-8?B?ZlZqZXlvZFRkdjBtTXBaNlpOblhuY2lEbVcxY1kvQzdGVURaaHRGSlFuV3hn?=
 =?utf-8?B?UlQvYmJHWWlITHZUUEVpUXVseEtqdXZjNDdib1NkMkdCTmdqMHIxNnQ5YXB2?=
 =?utf-8?B?cEpJRGJpQWQ1UTYvSnpLSXhVOWdHNmZPT3pzNjVLS1pqNnk4bnVVMnBQa1Zj?=
 =?utf-8?B?QWQ5YU56RTBKK2J1L2ZDdlBLM1JRcjRudndWYVlGLy9yMUVTdElLMDVoQkRW?=
 =?utf-8?Q?SieGLOEBDYv9GycHSzSmG0aOl?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b857d49d-b7f9-43f0-eda0-08dd0edf9e28
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:32:55.2044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu7Tni9CKkii8H+Auv42+7yrz+U31LxpW6eIlpntyr6dvwuQNoPRwcXSNd9nw0/FoGeyr724sXZLeVH3wsiMLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
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

Enabling ODT is required to suppress reflection of the data signal on
DDR write operation. SolidRun Armada 388 SoM only connects M_ODT[0] even
when both chip-select are used.

Enable ODT[0] for both chip-select during write only.

Original work by Baruch Siach [1] and Chris Packham [2].

[1] https://github.com/SolidRun/u-boot-armada38x/commit/aba763a611e69fbcc4e229659da9d84f16b39814
[2] https://github.com/SolidRun/u-boot-armada38x/commit/dbaf09590df9add19e738d2de03c0f2d0d8f5433

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 board/solidrun/clearfog/clearfog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
index 2dbd071abd9f29cee97fb813a67d0190a620bd32..67b60d2e7b43331383b6a01b13693b29b21129be 100644
--- a/board/solidrun/clearfog/clearfog.c
+++ b/board/solidrun/clearfog/clearfog.c
@@ -161,7 +161,7 @@ static struct mv_ddr_topology_map board_topology_map = {
 	{0},				/* timing parameters */
 	{ {0} },			/* electrical configuration */
 	{0,},				/* electrical parameters */
-	0,				/* ODT configuration */
+	0x30000,			/* ODT configuration */
 	0x3,				/* clock enable mask */
 };
 

---
base-commit: 3881c6b90350b0b04085ad46ef64989b43967eef
change-id: 20241127-a388-sr-som-odt-89f8dd6b6410

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

