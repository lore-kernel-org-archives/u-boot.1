Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A314C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2EF88995;
	Fri, 23 Aug 2024 15:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="QV/eUtb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF3088549; Fri, 23 Aug 2024 11:50:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDE187E30
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 11:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cS1x7lIjW1OnUdKuSv24vvyN59W6fxgBGViDnOuTZe9iAWH5XY4uzIEwrbIpgu71QWwj+DTyfPtV9KuiHclVASjDs9mSti152ZEmLWPlbu/BYCbuuQd7i3gMi4E5+S9wcgCzEwSxHTfRrLOoZZv5t/TgnzQVz1SZ5uq73rk3dmNEwRpLmhLhO32onPv4emvCYRPLx6/czr+ALaPtBzt5YkwAkNY9zsdFKBtEHDpNEhYVY0leSCGgfBS6Bj1YE5FDfi8pyjHSK23C2GLuYZWJ0TejoLtLfVZYeXYI4yotAm+Hh44M52WU+VByn87V8AaTXEnXbDpUx8E20rX8UoGS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZBsSFejSez5127zt4pNbcG2ArPHUaw/HZ0nU8yw3LE=;
 b=FtIdxyG3wMwwihxR1pJ0iunv0PjQP/GuDv30KBXXCSvDpOVeMkM5xfqdiBYiM+cP5frcnn1OqRCgy0aFlbPnTwVgKnZhLgpmxHPQ28BxuIBq1v62nqNJJG836wJA3WA59lrzdx08neZI7rH6305feqqjHB/2f0flIlN96zncZTjMKizoaHg8UV+SnfSOls2jEPmJoxBIfQ3n62fTL8NFKy824fRVK1qWZmfsFJnycjoMnfv9v1+SaaGwF6+TNMQIx85zJoEdwtIh4Hw7H6aiN81YnxAzLnfyvjGJVXIKr8IAxPADBjEL8XPQyw9V8yU7GECyyTSUZHyBwTdGJZdA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZBsSFejSez5127zt4pNbcG2ArPHUaw/HZ0nU8yw3LE=;
 b=QV/eUtb6ggN8RqD99G92sCxt8Ixqm6duFKRBTwnZT1RqfHu+eOljep/jQ85ZO/KtD/V945k9yqG6PLhho4/A4Us5idstFgFEGh4WnSDD6hpQEtmmXea+wTopiimU0BzSA5CxuJm1NAEJO6pYl6zV7KjQUG2CG6uWimSbxz3mlxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7604.eurprd08.prod.outlook.com (2603:10a6:20b:4ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 09:50:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 09:50:00 +0000
Message-ID: <e5072baf-ab59-4ece-af60-bb826aed7314@genexis.eu>
Date: Fri, 23 Aug 2024 12:49:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 4/9] net/tcp: add connection info to tcp_stream
 structure
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-5-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTgNG6hWXMxbLv1pw=bzm6D7SskZKL9+=dbD100hyn-dPw@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszTgNG6hWXMxbLv1pw=bzm6D7SskZKL9+=dbD100hyn-dPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: aa73b578-5672-4614-3ade-08dcc358f404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azdNNlQxdFRyeFU2aVp0UTc2NjFlL2N1WE0rd0xXcmRjZmZ2ZUYwYW15bFVS?=
 =?utf-8?B?UElDaUtKN3I5VGFxamhJemZGa2NtSSs5dC9LS1FFU2VzU2pvQTdRUDJnM1pi?=
 =?utf-8?B?c25SMHNTNTVUUDdtWW1ZOWl4bEIwTEYwMDBWOWUrRUxrVXBQVVlXbENDeE5j?=
 =?utf-8?B?SXlGUEIrWmFuSG9mclo1TzVzWU41ZEl5MWtleUc2c1cwaTZjcWlpTElEa2hn?=
 =?utf-8?B?K2hZQTIxY000cU01WUNXNGQrVDVUZjUxRXVPc01XdkRiUnczRlAzNDAxRmFi?=
 =?utf-8?B?ZXQyTHBlamVaNERVRm5mbnRKczBrZVNOVzV4V0wxS0xWaW1NcEdNSDcyakZq?=
 =?utf-8?B?MCtNcFhIVG5UaHp6dXZCSkVMcWhKbS9yTDRRTXpPcUhPbTArbVRBWG5oUUhr?=
 =?utf-8?B?N2h0ZEtDL3JWN1JPR1ZocVpYVDhwbytkVHZ3cU9iT3RSQzBuUFVBZVprbEMz?=
 =?utf-8?B?YzJDcDdoQUNIWTY4SktmdXRLMkNid25hcjBSMWVhZlpKaW5ObGZldkRvZ1hs?=
 =?utf-8?B?RE5lc3V5Zmg0MnhIcGl4LzFiaHRGNHp6amN4c3dHaGh4SnhhU1RSbzBnR2dZ?=
 =?utf-8?B?WHhERm14OWtSVWxteVVobDNjRFVNVW5CY0FUbVB2L1FhYURoRDRnM1pCSWZa?=
 =?utf-8?B?bzNBbmtKVmxMWmZXc0hEdml2OEtzNS9nSVA1Wk82YjNEcG9ta05BWUo1bGt4?=
 =?utf-8?B?Y2QwR3JVRnJnbTJsYnJES1hXWm9YY0p1QTZ5SDdKYmN6R3BMb2MvQ2tOQUZo?=
 =?utf-8?B?ZzV6T3JVa3ErQzBrcHBmR2ZnNFJjRUVjVTE1RHNKTEJvK2VLOHR5K0NWNm9Z?=
 =?utf-8?B?MFNJMXhGd3lWNFZXS25mKzJqMlpPbFBnNnVHSURoTGR2V2dhSHZJVVdpK0c3?=
 =?utf-8?B?YlJzNEpUSlU5MGZzU0JWbjNxcXB2VWQ1b1lEWGwwOWxVbXZxU2dKTDVwREF2?=
 =?utf-8?B?aVM2U3ZZQVJKNXZ5TGFQQXFKRWhrdnVwOUJUK2lHWjlaRnQrNVY1TnlEV1hM?=
 =?utf-8?B?TzUrK1BVMFlwaGpwMm9EemppMXB0WnZnenB3N296U0dvOE45SE5oSUw5c0tV?=
 =?utf-8?B?WlNFT2d3K0thOXVuKzd3QmhIUU43Wjcyc3MrODgxdDFEdjF6UEpQa3BlU29J?=
 =?utf-8?B?TTlqbm1wMStpUFE0NWNUbUYyOHNmeTVoUEpxZERHTDJaa0NROXlSWno0Ry9G?=
 =?utf-8?B?SS92NTFPZHpTTDVFaVhqcm96SXZxRHdPWnpueEFCWDk5SW1VTVhYbE85R1Rl?=
 =?utf-8?B?SXlESXg0dGdlV041ZXAydHJkRTM1U1hkNmIzVDJvZGtTciszczJTVzg3VC9U?=
 =?utf-8?B?Um1ncmcxVjVTSTE4eEloaGdSMlJITVcyZjRQbjNncCtGVFNkS2kyOFpOK0oy?=
 =?utf-8?B?a3I1OXBWdlRzR2w1WU5yazJDL21La2h5Q3B5ZGlrWXVrRmNyeVdmelgxWmEz?=
 =?utf-8?B?SmhNQnE2UGhLbURDL1dSam1QaFZRUU9aMDhMWWR1NlVOZDF3Y0pneWN4Vnpy?=
 =?utf-8?B?dHFiRExyeDdsZk5KN2JKVjBqWHliajVIRjdEOGYreHBFOEs0ZEpIUzk5NmlJ?=
 =?utf-8?B?ODZKN1AzOWkySWRYZWdIbEpLRk9kNWxqL0pwZHkyMW4yUXQ4RWpUN3kvOFBQ?=
 =?utf-8?B?WmIrQVZTK2ZXbW0rbWVFL1hPeDBFV2pCL2EyRXFycU4wU2lUaXVrRnRNWUhQ?=
 =?utf-8?B?QjF4UjIvUlZTbGRlcDdZcWpJQ2pvaVZuLzJSWlVyZW9aa0s5S0xuMGRtTjJx?=
 =?utf-8?B?Z2RhRDJVT1RzUnhTL3g5WWhZVlF2U251Q2VOaXR6VWVkWWFSc1dCR1FTTUFN?=
 =?utf-8?B?MTVxc3JGZXpwY0pjYkVWUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHBhd3RVTUJTQXVmeXRudjhuSDdsWllHdk5tamRzZzBJMHJiOEJUNEIzQ250?=
 =?utf-8?B?UERaV1o4VVl0UnJpVTljbWJOR0h1c0gzN3BkaXhUVG9ZNVUzaDdzaVRlc0lh?=
 =?utf-8?B?clZER1ZTenVxNEVXdzU0KzNpeWZiNHpabTJXd3Q3TjdTOGZBS3VJSllyUGNr?=
 =?utf-8?B?ZDllOFBqQVdUa05jb0Q2cXo2RUtrbUh4amRmVjBlN2JxZmVwM3VOdFRwczcx?=
 =?utf-8?B?Zy9mNnh4Q1VzR0c0eHdVUkozMm02MWs4dnp3aG55YXFBaXBFWk9UNGx0VmUw?=
 =?utf-8?B?ZjlHdlBDUWw4bnVvRmUxaHlaWUE4d2plY3FxUStueFhTbjZLVTJwZ2xoOXZw?=
 =?utf-8?B?YkpWRkl5UTNYYkhaZVUvWllPNHhzRFN2aWhReVpiVzZ4VnY1UXNMM09UczRt?=
 =?utf-8?B?WW9qMW02YXJZOXloSGJ3T2hvRzJZdVp4NTNPTUFLOExvdmN6WDVoS1Uzb1N4?=
 =?utf-8?B?WmdBOVAxVStZZ3hScm82UWRPcDZobVVESU1nbHc2Y3NuNThVYkR1Z1NLY05w?=
 =?utf-8?B?bGZ0dlVyZFZNYnVYTUtqc0ozVzNzUFpBcURxZ0dyZkhaVStxSU44aXlheTY4?=
 =?utf-8?B?ZURYaytNRUUxenAvcmRHb051WHFIQzl0MVp2cEZ1UjBHKzMya0Y3TGxZeUVq?=
 =?utf-8?B?bnNZQllYUWd1UWVDbnhsRFljVVF4NWlwcnFKMDZXY2pXT3Zrc2M2d3hmSWht?=
 =?utf-8?B?YUtWK24vRXpqYzFlRkg1UHhBbjJVVjlzT1ZleXR6Wk42VUR5SGxMY05XbmlH?=
 =?utf-8?B?RWYySkJaM29kaEROT00xQ1l3VndrUXcrUHRBREcweU05Vks5RjFFK3g1VnBs?=
 =?utf-8?B?cXNVYlRmSHhRVHlqSmFzVmZDU2RBclFxRXlHTXYyVldLWlFxQzdGSjJLWHJx?=
 =?utf-8?B?ZnlwWG9VRnFsS1BIOGE0OUlYdVJzRzBZTzV2T2NGNkh4U0JpK1ZSVTQrYlVj?=
 =?utf-8?B?ajl3QUN4YlVBZFJna3QzdFFCb1l5ZnJSMEtXNEF0U0FzUkh4QncySXdva1dx?=
 =?utf-8?B?MXRUS0lhZ0NNYTF1ZmlneW1SRXEvMW9NMHJtam5pUTBnT0k2Q1ZFRERJTnIr?=
 =?utf-8?B?QXRlZ2krWjFTQkJ5SGh3M0NyTXNHSmJtSVUzK3duRm8vQWNjMHJRVDE1NXBa?=
 =?utf-8?B?d1BES1FzWS9KYjVIV3h4YXk4ZVN1a0U1ZVZqdUdYOHZPdUw4MnpldnZkNTkv?=
 =?utf-8?B?WWhpUlR2RytjWGVaa3lDUUVlMTdiUFJIdkQ4Q3JVQkVDYjJWZWpqUlZiVkxy?=
 =?utf-8?B?Ykp3Z2piQ0tSb21xQ0xTZ1oraDNqbDdGdnVQQUVlWU1KK1JML0FXbFdVL01h?=
 =?utf-8?B?aDZ3a0s4Z01oeEZjc09GazVUYnVJUWNFaFlEV2E4WWRoWEQ5ZFE1bE01WDVk?=
 =?utf-8?B?OVdRRXdiRXYzTm05b1ZVTEZNMk1aY3NGMlJ3cmxPT1RRaTFiVktTVnB0dGdm?=
 =?utf-8?B?SkJpQ0JsMjlFRUZJTEZXQWNtQ203VG5GZUZRRDVYMUJ2K0FrWS9qWkRSSS9O?=
 =?utf-8?B?NjJjTWlma1BQYnpQZXpUTnJsM2NlKzI1V3gwZXlETjEyODhLQW40YkEwZXJa?=
 =?utf-8?B?aEpoRlZvT1FnblQ5bjY2K0tuazAza3g3WjdMRmorcm1YdjZHSnlxTi9rR3lI?=
 =?utf-8?B?dzQ4QUVaN2R6YVVFbEFFT2o3Z24rZjNTNWJSbEV4VDRTVkhRMjFscURvSUhO?=
 =?utf-8?B?bEtwWVQ1bnJrUnFuK0loYjhBYUVycTlRTlcwalNpVWZ3MW40TWwzVC9RZ003?=
 =?utf-8?B?NUh4OGdaQW9CTk9UZFJYaGFXNU1lRGdiTTFRQWVtMG8zcW5UV29CSjcwelZ2?=
 =?utf-8?B?NHBFOXlrQWJwVGxRMnhBRzBVSk5KZGJJbmY3amJhZDlWWnJkVjdrY3k3dEFo?=
 =?utf-8?B?eURLVUU3eEZLdVlSTDlNZFYzRlRNRkV2dzdxdzhxYjFyVGtZVlNxeFZIVEhv?=
 =?utf-8?B?NmU5YkZXOGNDQmJWSGcwNjFNREYyUDExOEFSeFBxSVgwb0VaaC96WklrcGcx?=
 =?utf-8?B?dGV5VmpZc0g5bnhGbzVQRFVFM2hzRzY0TXJtQURwcUlybjJic2cyOWhRMFdF?=
 =?utf-8?B?VlJqQm4wQ2U0WnBmZ1BHbXo3NHNwTUxDakU3UU93bnNWeFVTMjhpYnpqT2xz?=
 =?utf-8?B?cWlpTmVKN3hLMHpnN2ltWlJYeFpxQ3FpaHlOK2V6MXdHTyttUmJnL0hqaEpO?=
 =?utf-8?Q?+50ow+B44cEvuQA0arEOxDI=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: aa73b578-5672-4614-3ade-08dcc358f404
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:50:00.1526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAvHTOLRcL4n8GEM8fn4VNRlmjooSIkkCeG52JJlV/4k/gfepD6j4r3cFEZAA9n1YMCWvrsXGPsH0aB05GA0ElT9aqVuDV3cPFA8xBoTtPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7604
X-Mailman-Approved-At: Fri, 23 Aug 2024 15:36:19 +0200
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


On 17.08.2024 18:58, Simon Glass wrote:
> Hi Mikhail,
>
> On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> Changes:
>>  * Avoid use net_server_ip in tcp code, use tcp_stream data instead
>>  * Ignore packets from other connections if connection already created.
>>    This prevents us from connection break caused by other tcp stream.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  include/net.h      |   5 +-
>>  include/net/tcp.h  |  57 +++++++++++++++++---
>>  net/fastboot_tcp.c |  46 ++++++++--------
>>  net/net.c          |  12 ++---
>>  net/tcp.c          | 129 ++++++++++++++++++++++++++++++++++-----------
>>  net/wget.c         |  52 +++++++-----------
>>  6 files changed, 201 insertions(+), 100 deletions(-)
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> nits below
>
>> diff --git a/include/net.h b/include/net.h
>> index bb2ae20f52a..b0ce13e0a9d 100644
>> --- a/include/net.h
>> +++ b/include/net.h
>> @@ -667,6 +667,7 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
>>  /**
>>   * net_send_tcp_packet() - Transmit TCP packet.
>>   * @payload_len: length of payload
>> + * @dhost: Destination host
>>   * @dport: Destination TCP port
>>   * @sport: Source TCP port
>>   * @action: TCP action to be performed
>> @@ -675,8 +676,8 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
>>   *
>>   * Return: 0 on success, other value on failure
>>   */
>> -int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
>> -                       u32 tcp_seq_num, u32 tcp_ack_num);
>> +int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
>> +                       int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
>>  int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport,
>>                         int sport, int payload_len);
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 14aee64cb1c..f224d0cae2f 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -279,6 +279,9 @@ enum tcp_state {
>>
>>  /**
>>   * struct tcp_stream - TCP data stream structure
>> + * @rhost:             Remote host, network byte order
>> + * @rport:             Remote port, host byte order
>> + * @lport:             Local port, host byte order
>>   *
>>   * @state:             TCP connection state
>>   *
>> @@ -291,6 +294,10 @@ enum tcp_state {
>>   * @lost:              Used for SACK
>>   */
>>  struct tcp_stream {
>> +       struct in_addr  rhost;
>> +       u16             rport;
>> +       u16             lport;
>> +
>>         /* TCP connection state */
>>         enum tcp_state  state;
>>
>> @@ -305,16 +312,53 @@ struct tcp_stream {
>>         struct tcp_sack_v lost;
>>  };
>>
>> -struct tcp_stream *tcp_stream_get(void);
>> +void tcp_init(void);
>> +
>> +typedef int tcp_incoming_filter(struct in_addr rhost,
>> +                               u16 rport, u16 sport);
>> +
>> +/*
>> + * This function sets user callback used to accept/drop incoming
>> + * connections. Callback should:
>> + *  + Check TCP stream endpoint and make connection verdict
>> + *    - return non-zero value to accept connection
>> + *    - return zero to drop connection
>> + *
>> + * WARNING: If callback is NOT defined, all incoming connections
>> + *          will be dropped.
>> + */
>> +void tcp_set_incoming_filter(tcp_incoming_filter *filter);
>> +
>> +/*
>> + * tcp_stream_get -- Get or create TCP stream
>> + * @is_new:    if non-zero and no stream found, then create a new one
>> + * @rhost:     Remote host, network byte order
>> + * @rport:     Remote port, host byte order
>> + * @lport:     Local port, host byte order
>> + *
>> + * Returns: TCP stream structure or NULL (if not found/created)
>> + */
>> +struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
>> +                                 u16 rport, u16 lport);
>> +
>> +/*
>> + * tcp_stream_connect -- Create new TCP stream for remote connection.
>> + * @rhost:     Remote host, network byte order
>> + * @rport:     Remote port, host byte order
>> + *
>> + * Returns: TCP new stream structure or NULL (if not created).
>> + *          Random local port will be used.
>> + */
>> +struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport);
>> +
>> +enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp);
>>
>> -enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp);
>> -void tcp_set_tcp_state(struct tcp_stream *tcp, enum tcp_state new_state);
>> -int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>> -                      int sport, int payload_len,
>> +int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>>                        u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
>>
>>  /**
>>   * rxhand_tcp() - An incoming packet handler.
>> + * @tcp: TCP stream
>>   * @pkt: pointer to the application packet
>>   * @dport: destination TCP port
>>   * @sip: source IP address
>> @@ -324,8 +368,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>>   * @action: TCP action (SYN, ACK, FIN, etc)
>>   * @len: packet length
>>   */
>> -typedef void rxhand_tcp(uchar *pkt, u16 dport,
>> -                       struct in_addr sip, u16 sport,
>> +typedef void rxhand_tcp(struct tcp_stream *tcp, uchar *pkt,
>>                         u32 tcp_seq_num, u32 tcp_ack_num,
>>                         u8 action, unsigned int len);
>>  void tcp_set_tcp_handler(rxhand_tcp *f);
>> diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
>> index d1fccbc7238..12a4d6690be 100644
>> --- a/net/fastboot_tcp.c
>> +++ b/net/fastboot_tcp.c
>> @@ -8,14 +8,14 @@
>>  #include <net/fastboot_tcp.h>
>>  #include <net/tcp.h>
>>
>> +#define FASTBOOT_TCP_PORT      5554
>> +
>>  static char command[FASTBOOT_COMMAND_LEN] = {0};
>>  static char response[FASTBOOT_RESPONSE_LEN] = {0};
> It will be 0 anyway, since BSS is zeroed.
>
>>  static const unsigned short handshake_length = 4;
>>  static const uchar *handshake = "FB01";
>>
>> -static u16 curr_sport;
>> -static u16 curr_dport;
>>  static u32 curr_tcp_seq_num;
>>  static u32 curr_tcp_ack_num;
>>  static unsigned int curr_request_len;
>> @@ -25,34 +25,37 @@ static enum fastboot_tcp_state {
>>         FASTBOOT_DISCONNECTING
>>  } state = FASTBOOT_CLOSED;
>>
>> -static void fastboot_tcp_answer(u8 action, unsigned int len)
>> +static void fastboot_tcp_answer(struct tcp_stream *tcp, u8 action,
>> +                               unsigned int len)
>>  {
>>         const u32 response_seq_num = curr_tcp_ack_num;
>>         const u32 response_ack_num = curr_tcp_seq_num +
>>                   (curr_request_len > 0 ? curr_request_len : 1);
>>
>> -       net_send_tcp_packet(len, htons(curr_sport), htons(curr_dport),
>> +       net_send_tcp_packet(len, tcp->rhost, tcp->rport, tcp->lport,
>>                             action, response_seq_num, response_ack_num);
>>  }
>>
>> -static void fastboot_tcp_reset(void)
>> +static void fastboot_tcp_reset(struct tcp_stream *tcp)
>>  {
>> -       fastboot_tcp_answer(TCP_RST, 0);
>> +       fastboot_tcp_answer(tcp, TCP_RST, 0);
>>         state = FASTBOOT_CLOSED;
>>  }
>>
>> -static void fastboot_tcp_send_packet(u8 action, const uchar *data, unsigned int len)
>> +static void fastboot_tcp_send_packet(struct tcp_stream *tcp, u8 action,
>> +                                    const uchar *data, unsigned int len)
>>  {
>>         uchar *pkt = net_get_async_tx_pkt_buf();
>>
>>         memset(pkt, '\0', PKTSIZE);
>>         pkt += net_eth_hdr_size() + IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
>>         memcpy(pkt, data, len);
>> -       fastboot_tcp_answer(action, len);
>> +       fastboot_tcp_answer(tcp, action, len);
>>         memset(pkt, '\0', PKTSIZE);
>>  }
>>
>> -static void fastboot_tcp_send_message(const char *message, unsigned int len)
>> +static void fastboot_tcp_send_message(struct tcp_stream *tcp,
>> +                                     const char *message, unsigned int len)
>>  {
>>         __be64 len_be = __cpu_to_be64(len);
>>         uchar *pkt = net_get_async_tx_pkt_buf();
>> @@ -63,12 +66,11 @@ static void fastboot_tcp_send_message(const char *message, unsigned int len)
>>         memcpy(pkt, &len_be, 8);
>>         pkt += 8;
>>         memcpy(pkt, message, len);
>> -       fastboot_tcp_answer(TCP_ACK | TCP_PUSH, len + 8);
>> +       fastboot_tcp_answer(tcp, TCP_ACK | TCP_PUSH, len + 8);
>>         memset(pkt, '\0', PKTSIZE);
>>  }
>>
>> -static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>> -                                     struct in_addr sip, u16 sport,
>> +static void fastboot_tcp_handler_ipv4(struct tcp_stream *tcp, uchar *pkt,
>>                                       u32 tcp_seq_num, u32 tcp_ack_num,
>>                                       u8 action, unsigned int len)
>>  {
>> @@ -77,8 +79,6 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>>         u8 tcp_fin = action & TCP_FIN;
>>         u8 tcp_push = action & TCP_PUSH;
>>
>> -       curr_sport = sport;
>> -       curr_dport = dport;
>>         curr_tcp_seq_num = tcp_seq_num;
>>         curr_tcp_ack_num = tcp_ack_num;
>>         curr_request_len = len;
>> @@ -89,17 +89,17 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>>                         if (len != handshake_length ||
>>                             strlen(pkt) != handshake_length ||
>>                             memcmp(pkt, handshake, handshake_length) != 0) {
>> -                               fastboot_tcp_reset();
>> +                               fastboot_tcp_reset(tcp);
>>                                 break;
>>                         }
>> -                       fastboot_tcp_send_packet(TCP_ACK | TCP_PUSH,
>> +                       fastboot_tcp_send_packet(tcp, TCP_ACK | TCP_PUSH,
>>                                                  handshake, handshake_length);
>>                         state = FASTBOOT_CONNECTED;
>>                 }
>>                 break;
>>         case FASTBOOT_CONNECTED:
>>                 if (tcp_fin) {
>> -                       fastboot_tcp_answer(TCP_FIN | TCP_ACK, 0);
>> +                       fastboot_tcp_answer(tcp, TCP_FIN | TCP_ACK, 0);
>>                         state = FASTBOOT_DISCONNECTING;
>>                         break;
>>                 }
>> @@ -111,12 +111,12 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>>
>>                         // Only single packet messages are supported ATM
>>                         if (strlen(pkt) != command_size) {
>> -                               fastboot_tcp_reset();
>> +                               fastboot_tcp_reset(tcp);
>>                                 break;
>>                         }
>>                         strlcpy(command, pkt, len + 1);
>>                         fastboot_command_id = fastboot_handle_command(command, response);
>> -                       fastboot_tcp_send_message(response, strlen(response));
>> +                       fastboot_tcp_send_message(tcp, response, strlen(response));
>>                         fastboot_handle_boot(fastboot_command_id,
>>                                              strncmp("OKAY", response, 4) == 0);
>>                 }
>> @@ -129,17 +129,21 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>>
>>         memset(command, 0, FASTBOOT_COMMAND_LEN);
>>         memset(response, 0, FASTBOOT_RESPONSE_LEN);
>> -       curr_sport = 0;
>> -       curr_dport = 0;
>>         curr_tcp_seq_num = 0;
>>         curr_tcp_ack_num = 0;
>>         curr_request_len = 0;
>>  }
>>
>> +static int incoming_filter(struct in_addr rhost, u16 rport, u16 lport)
>> +{
>> +       return (lport == FASTBOOT_TCP_PORT);
>> +}
>> +
>>  void fastboot_tcp_start_server(void)
>>  {
>>         printf("Using %s device\n", eth_get_name());
>>         printf("Listening for fastboot command on tcp %pI4\n", &net_ip);
>>
>> +       tcp_set_incoming_filter(incoming_filter);
>>         tcp_set_tcp_handler(fastboot_tcp_handler_ipv4);
>>  }
>> diff --git a/net/net.c b/net/net.c
>> index 6c5ee7e0925..b33ea59a9fa 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -414,7 +414,7 @@ int net_init(void)
>>                 /* Only need to setup buffer pointers once. */
>>                 first_call = 0;
>>                 if (IS_ENABLED(CONFIG_PROT_TCP))
>> -                       tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
>> +                       tcp_init();
>>         }
>>
>>         return net_init_loop();
>> @@ -899,10 +899,10 @@ int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport, int sport,
>>  }
>>
>>  #if defined(CONFIG_PROT_TCP)
>> -int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
>> -                       u32 tcp_seq_num, u32 tcp_ack_num)
>> +int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
>> +                       int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
>>  {
>> -       return net_send_ip_packet(net_server_ethaddr, net_server_ip, dport,
>> +       return net_send_ip_packet(net_server_ethaddr, dhost, dport,
>>                                   sport, payload_len, IPPROTO_TCP, action,
>>                                   tcp_seq_num, tcp_ack_num);
>>  }
>> @@ -944,12 +944,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
>>                 break;
>>  #if defined(CONFIG_PROT_TCP)
>>         case IPPROTO_TCP:
>> -               tcp = tcp_stream_get();
>> +               tcp = tcp_stream_get(0, dest, dport, sport);
>>                 if (tcp == NULL)
>>                         return -EINVAL;
>>
>>                 pkt_hdr_size = eth_hdr_size
>> -                       + tcp_set_tcp_header(tcp, pkt + eth_hdr_size, dport, sport,
>> +                       + tcp_set_tcp_header(tcp, pkt + eth_hdr_size,
>>                                              payload_len, action, tcp_seq_num,
>>                                              tcp_ack_num);
>>                 break;
>> diff --git a/net/tcp.c b/net/tcp.c
>> index 6646f171b83..9acf9f3ccb2 100644
>> --- a/net/tcp.c
>> +++ b/net/tcp.c
>> @@ -26,6 +26,7 @@
>>
>>  static int tcp_activity_count;
>>  static struct tcp_stream tcp_stream;
>> +static tcp_incoming_filter *incoming_filter;
>>
>>  /*
>>   * TCP lengths are stored as a rounded up number of 32 bit words.
>> @@ -40,40 +41,95 @@ static struct tcp_stream tcp_stream;
>>  /* Current TCP RX packet handler */
>>  static rxhand_tcp *tcp_packet_handler;
>>
>> +#define RANDOM_PORT_START 1024
>> +#define RANDOM_PORT_RANGE 0x4000
>> +
>> +/**
>> + * random_port() - make port a little random (1024-17407)
>> + *
>> + * Return: random port number from 1024 to 17407
> Where does 17407 number come from? I see that this is code you are
> copying, though.

This code comes from net/wget.c and exactly the same code exist in
net/dns.c.
Probably we should place this function to some common network header.

17407 = 1024 + 0x3fff

>> + *
>> + * This keeps the math somewhat trivial to compute, and seems to work with
>> + * all supported protocols/clients/servers
>> + */
>> +static unsigned int random_port(void)
> uint
>
>> +{
>> +       return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
>> +}
>> +
>>  static inline s32 tcp_seq_cmp(u32 a, u32 b)
>>  {
>>         return (s32)(a - b);
>>  }
>>
>>  /**
>> - * tcp_get_tcp_state() - get TCP stream state
>> + * tcp_stream_get_state() - get TCP stream state
>>   * @tcp: tcp stream
>>   *
>>   * Return: TCP stream state
>>   */
>> -enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp)
>> +enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp)
>>  {
>>         return tcp->state;
>>  }
>>
>>  /**
>> - * tcp_set_tcp_state() - set TCP stream state
>> + * tcp_stream_set_state() - set TCP stream state
>>   * @tcp: tcp stream
>>   * @new_state: new TCP state
>>   */
>> -void tcp_set_tcp_state(struct tcp_stream *tcp,
>> -                      enum tcp_state new_state)
>> +static void tcp_stream_set_state(struct tcp_stream *tcp,
>> +                                enum tcp_state new_state)
>>  {
>>         tcp->state = new_state;
>>  }
>>
>> -struct tcp_stream *tcp_stream_get(void)
>> +void tcp_init(void)
>> +{
>> +       incoming_filter = NULL;
>> +       tcp_stream.state = TCP_CLOSED;
>> +}
>> +
>> +void tcp_set_incoming_filter(tcp_incoming_filter *filter)
>> +{
>> +       incoming_filter = filter;
>> +}
>> +
>> +static struct tcp_stream *tcp_stream_add(struct in_addr rhost,
>> +                                        u16 rport, u16 lport)
>> +{
>> +       struct tcp_stream *tcp = &tcp_stream;
>> +
>> +       if (tcp->state != TCP_CLOSED)
>> +               return NULL;
>> +
>> +       memset(tcp, 0, sizeof(struct tcp_stream));
>> +       tcp->rhost.s_addr = rhost.s_addr;
>> +       tcp->rport = rport;
>> +       tcp->lport = lport;
>> +       tcp->state = TCP_CLOSED;
>> +       tcp->lost.len = TCP_OPT_LEN_2;
>> +       return tcp;
>> +}
>> +
>> +struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
>> +                                 u16 rport, u16 lport)
>>  {
>> -       return &tcp_stream;
>> +       struct tcp_stream *tcp = &tcp_stream;
>> +
>> +       if ((tcp->rhost.s_addr == rhost.s_addr) &&
>> +           (tcp->rport == rport) &&
>> +           (tcp->lport == lport))
>> +               return tcp;
> Drop the internal brackets
>
>> +
>> +       if (!is_new || (incoming_filter == NULL) ||
> !incoming_filter
>
>> +           !incoming_filter(rhost, rport, lport))
>> +               return NULL;
>> +
>> +       return tcp_stream_add(rhost, rport, lport);
>>  }
>>
>> -static void dummy_handler(uchar *pkt, u16 dport,
>> -                         struct in_addr sip, u16 sport,
>> +static void dummy_handler(struct tcp_stream *tcp, uchar *pkt,
>>                           u32 tcp_seq_num, u32 tcp_ack_num,
>>                           u8 action, unsigned int len)
>>  {
>> @@ -222,8 +278,7 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
>>         b->ip.end = TCP_O_END;
>>  }
>>
>> -int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>> -                      int sport, int payload_len,
>> +int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>>                        u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
>>  {
>>         union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
>> @@ -243,7 +298,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>>         case TCP_SYN:
>>                 debug_cond(DEBUG_DEV_PKT,
>>                            "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
>> -                          &net_server_ip, &net_ip,
>> +                          &tcp->rhost, &net_ip,
>>                            tcp_seq_num, tcp_ack_num);
>>                 tcp_activity_count = 0;
>>                 net_set_syn_options(tcp, b);
>> @@ -264,13 +319,13 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>>                 b->ip.hdr.tcp_flags = action;
>>                 debug_cond(DEBUG_DEV_PKT,
>>                            "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>> -                          &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num,
>> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
>>                            action);
>>                 break;
>>         case TCP_FIN:
>>                 debug_cond(DEBUG_DEV_PKT,
>>                            "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
>> -                          &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
>> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>>                 payload_len = 0;
>>                 pkt_hdr_len = IP_TCP_HDR_SIZE;
>>                 tcp->state = TCP_FIN_WAIT_1;
>> @@ -279,7 +334,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>>         case TCP_RST:
>>                 debug_cond(DEBUG_DEV_PKT,
>>                            "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
>> -                          &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
>> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>>                 tcp->state = TCP_CLOSED;
>>                 break;
>>         /* Notify connection closing */
>> @@ -290,7 +345,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>>
>>                 debug_cond(DEBUG_DEV_PKT,
>>                            "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>> -                          &net_server_ip, &net_ip,
>> +                          &tcp->rhost, &net_ip,
>>                            tcp_seq_num, tcp_ack_num, action);
>>                 fallthrough;
>>         default:
>> @@ -298,7 +353,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>>                 b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
>>                 debug_cond(DEBUG_DEV_PKT,
>>                            "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>> -                          &net_server_ip, &net_ip,
>> +                          &tcp->rhost, &net_ip,
>>                            tcp_seq_num, tcp_ack_num, action);
>>         }
>>
>> @@ -308,8 +363,8 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>>         tcp->ack_edge = tcp_ack_num;
>>         /* TCP Header */
>>         b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
>> -       b->ip.hdr.tcp_src = htons(sport);
>> -       b->ip.hdr.tcp_dst = htons(dport);
>> +       b->ip.hdr.tcp_src = htons(tcp->lport);
>> +       b->ip.hdr.tcp_dst = htons(tcp->rport);
>>         b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
>>
>>         /*
>> @@ -332,10 +387,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>>         b->ip.hdr.tcp_xsum = 0;
>>         b->ip.hdr.tcp_ugr = 0;
>>
>> -       b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, net_server_ip,
>> +       b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, tcp->rhost,
>>                                                    tcp_len, pkt_len);
>>
>> -       net_set_ip_header((uchar *)&b->ip, net_server_ip, net_ip,
>> +       net_set_ip_header((uchar *)&b->ip, tcp->rhost, net_ip,
>>                           pkt_len, IPPROTO_TCP);
>>
>>         return pkt_hdr_len;
>> @@ -616,19 +671,26 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
>>         u32 tcp_seq_num, tcp_ack_num;
>>         int tcp_hdr_len, payload_len;
>>         struct tcp_stream *tcp;
>> +       struct in_addr src;
>>
>>         /* Verify IP header */
>>         debug_cond(DEBUG_DEV_PKT,
>>                    "TCP RX in RX Sum (to=%pI4, from=%pI4, len=%d)\n",
>>                    &b->ip.hdr.ip_src, &b->ip.hdr.ip_dst, pkt_len);
>>
>> -       b->ip.hdr.ip_src = net_server_ip;
>> +       /*
>> +        * src IP address will be destroyed by TCP checksum verification
>> +        * algorithm (see tcp_set_pseudo_header()), so remember it before
>> +        * it was garbaged.
>> +        */
>> +       src.s_addr = b->ip.hdr.ip_src.s_addr;
>> +
>>         b->ip.hdr.ip_dst = net_ip;
>>         b->ip.hdr.ip_sum = 0;
>>         if (tcp_rx_xsum != compute_ip_checksum(b, IP_HDR_SIZE)) {
>>                 debug_cond(DEBUG_DEV_PKT,
>>                            "TCP RX IP xSum Error (%pI4, =%pI4, len=%d)\n",
>> -                          &net_ip, &net_server_ip, pkt_len);
>> +                          &net_ip, &src, pkt_len);
>>                 return;
>>         }
>>
>> @@ -640,11 +702,14 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
>>                                                  pkt_len)) {
>>                 debug_cond(DEBUG_DEV_PKT,
>>                            "TCP RX TCP xSum Error (%pI4, %pI4, len=%d)\n",
>> -                          &net_ip, &net_server_ip, tcp_len);
>> +                          &net_ip, &src, tcp_len);
>>                 return;
>>         }
>>
>> -       tcp = tcp_stream_get();
>> +       tcp = tcp_stream_get(b->ip.hdr.tcp_flags & TCP_SYN,
>> +                            src,
>> +                            ntohs(b->ip.hdr.tcp_src),
>> +                            ntohs(b->ip.hdr.tcp_dst));
>>         if (tcp == NULL)
>>                 return;
>>
>> @@ -676,9 +741,9 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
>>                            "TCP Notify (action=%x, Seq=%u,Ack=%u,Pay%d)\n",
>>                            tcp_action, tcp_seq_num, tcp_ack_num, payload_len);
>>
>> -               (*tcp_packet_handler) ((uchar *)b + pkt_len - payload_len, b->ip.hdr.tcp_dst,
>> -                                      b->ip.hdr.ip_src, b->ip.hdr.tcp_src, tcp_seq_num,
>> -                                      tcp_ack_num, tcp_action, payload_len);
>> +               (*tcp_packet_handler) (tcp, (uchar *)b + pkt_len - payload_len,
>> +                                      tcp_seq_num, tcp_ack_num, tcp_action,
>> +                                      payload_len);
>>
>>         } else if (tcp_action != TCP_DATA) {
>>                 debug_cond(DEBUG_DEV_PKT,
>> @@ -689,9 +754,13 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
>>                  * Warning: Incoming Ack & Seq sequence numbers are transposed
>>                  * here to outgoing Seq & Ack sequence numbers
>>                  */
>> -               net_send_tcp_packet(0, ntohs(b->ip.hdr.tcp_src),
>> -                                   ntohs(b->ip.hdr.tcp_dst),
>> +               net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
>>                                     (tcp_action & (~TCP_PUSH)),
>>                                     tcp_ack_num, tcp->ack_edge);
>>         }
>>  }
>> +
>> +struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport)
>> +{
>> +       return tcp_stream_add(rhost, rport, random_port());
>> +}
>> diff --git a/net/wget.c b/net/wget.c
>> index c0a80597bfe..ad5db21e97e 100644
>> --- a/net/wget.c
>> +++ b/net/wget.c
>> @@ -27,9 +27,8 @@ static const char http_eom[] = "\r\n\r\n";
>>  static const char http_ok[] = "200";
>>  static const char content_len[] = "Content-Length";
>>  static const char linefeed[] = "\r\n";
>> -static struct in_addr web_server_ip;
>> -static int our_port;
>>  static int wget_timeout_count;
>> +struct tcp_stream *tcp;
>>
>>  struct pkt_qd {
>>         uchar *pkt;
>> @@ -137,22 +136,19 @@ static void wget_send_stored(void)
>>         int len = retry_len;
>>         unsigned int tcp_ack_num = retry_tcp_seq_num + (len == 0 ? 1 : len);
>>         unsigned int tcp_seq_num = retry_tcp_ack_num;
>> -       unsigned int server_port;
>>         uchar *ptr, *offset;
>>
>> -       server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
>> -
>>         switch (current_wget_state) {
>>         case WGET_CLOSED:
>>                 debug_cond(DEBUG_WGET, "wget: send SYN\n");
>>                 current_wget_state = WGET_CONNECTING;
>> -               net_send_tcp_packet(0, server_port, our_port, action,
>> +               net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
>>                                     tcp_seq_num, tcp_ack_num);
>>                 packets = 0;
>>                 break;
>>         case WGET_CONNECTING:
>>                 pkt_q_idx = 0;
>> -               net_send_tcp_packet(0, server_port, our_port, action,
>> +               net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
>>                                     tcp_seq_num, tcp_ack_num);
>>
>>                 ptr = net_tx_packet + net_eth_hdr_size() +
>> @@ -167,14 +163,14 @@ static void wget_send_stored(void)
>>
>>                 memcpy(offset, &bootfile3, strlen(bootfile3));
>>                 offset += strlen(bootfile3);
>> -               net_send_tcp_packet((offset - ptr), server_port, our_port,
>> +               net_send_tcp_packet((offset - ptr), tcp->rhost, tcp->rport, tcp->lport,
>>                                     TCP_PUSH, tcp_seq_num, tcp_ack_num);
>>                 current_wget_state = WGET_CONNECTED;
>>                 break;
>>         case WGET_CONNECTED:
>>         case WGET_TRANSFERRING:
>>         case WGET_TRANSFERRED:
>> -               net_send_tcp_packet(0, server_port, our_port, action,
>> +               net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
>>                                     tcp_seq_num, tcp_ack_num);
>>                 break;
>>         }
>> @@ -339,10 +335,8 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>>
>>  /**
>>   * wget_handler() - TCP handler of wget
>> + * @tcp: TCP stream
>>   * @pkt: pointer to the application packet
>> - * @dport: destination TCP port
>> - * @sip: source IP address
>> - * @sport: source TCP port
>>   * @tcp_seq_num: TCP sequential number
>>   * @tcp_ack_num: TCP acknowledgment number
>>   * @action: TCP action (SYN, ACK, FIN, etc)
>> @@ -351,13 +345,11 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>>   * In the "application push" invocation, the TCP header with all
>>   * its information is pointed to by the packet pointer.
>>   */
>> -static void wget_handler(uchar *pkt, u16 dport,
>> -                        struct in_addr sip, u16 sport,
>> +static void wget_handler(struct tcp_stream *tcp, uchar *pkt,
>>                          u32 tcp_seq_num, u32 tcp_ack_num,
>>                          u8 action, unsigned int len)
>>  {
>> -       struct tcp_stream *tcp = tcp_stream_get();
>> -       enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
>> +       enum tcp_state wget_tcp_state = tcp_stream_get_state(tcp);
>>
>>         net_set_timeout_handler(wget_timeout, wget_timeout_handler);
>>         packets++;
>> @@ -441,26 +433,13 @@ static void wget_handler(uchar *pkt, u16 dport,
>>         }
>>  }
>>
>> -#define RANDOM_PORT_START 1024
>> -#define RANDOM_PORT_RANGE 0x4000
>> -
>> -/**
>> - * random_port() - make port a little random (1024-17407)
>> - *
>> - * Return: random port number from 1024 to 17407
>> - *
>> - * This keeps the math somewhat trivial to compute, and seems to work with
>> - * all supported protocols/clients/servers
>> - */
>> -static unsigned int random_port(void)
>> -{
>> -       return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
>> -}
>> -
>>  #define BLOCKSIZE 512
>>
>>  void wget_start(void)
>>  {
>> +       struct in_addr web_server_ip;
>> +       unsigned int server_port;
>> +
>>         image_url = strchr(net_boot_file_name, ':');
>>         if (image_url > 0) {
>>                 web_server_ip = string_to_ip(net_boot_file_name);
>> @@ -513,8 +492,6 @@ void wget_start(void)
>>         wget_timeout_count = 0;
>>         current_wget_state = WGET_CLOSED;
>>
>> -       our_port = random_port();
>> -
>>         /*
>>          * Zero out server ether to force arp resolution in case
>>          * the server ip for the previous u-boot command, for example dns
>> @@ -523,6 +500,13 @@ void wget_start(void)
>>
>>         memset(net_server_ethaddr, 0, 6);
>>
>> +       server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
>> +       tcp = tcp_stream_connect(web_server_ip, server_port);
>> +       if (tcp == NULL) {
> !tcp
>
>> +               net_set_state(NETLOOP_FAIL);
>> +               return;
>> +       }
>> +
>>         wget_send(TCP_SYN, 0, 0, 0);
>>  }
>>
>> --
>> 2.39.2
>>
> Regards,
> Simon
