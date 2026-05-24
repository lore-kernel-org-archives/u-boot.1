Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51E1CD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 20:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624DE8490B;
	Sun, 24 May 2026 22:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jwyhs1+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347218490B; Sun, 24 May 2026 22:00:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229E3848DD
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 22:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT8iUZ0McUc12YG8cRK2/RiD8M1pVjd2rkqCUnI/ermtKpyQWOkR1sGjRcu3EyJa5BV1i9Vpao9VPCFwd7iaaUg6Ot7IqhdtIx/ySKe2fhTbhcHrXRFGEcoTOSNqc10GsgNHCCHz4gK350YEsRrW4aTI4DfQCNcTDz4DDiBKYTp1tZ8miZtcZwNGmb0vBDzA9rpH7oSE8w2oDH8mq9PTSnd39x++feKr3LhWq0WaRMZgSm/cwaF/4EtH+w2H8w9xfZMrMj5N4RQXmO/zWjMK3HjxMAQXX/Acci1W25mNurvTUw7z4FV7o4DTOMdKWqpZGNgkuv27S/wqeJFSMGgLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=DR+Q4S8Zzz0tDrmiW21nluVUPfimIE6DhoPUqIQJhT5z7050wZVc2ClhJU2n1A1c2wv2QJB7W2XcSNl/SodMsMAIph4zjmjKT18czUpeILCVrqbMbNbsqNAI2SjMg55MIIOLjFsRA3p2VU6HYdCFAPlbETehJJCkbQIj5FUzzVsu8VjXUG/njLCa/w7Bnn8BCMhKwksWbdmtkIJO5jhAWdaZdcC6Z9j6Xj6zEuTkAUTGScCl+wt9ltKsrPibHBRfDBiGaHuTibmo2xj0lATkWIw/ex6U48hSt5cYfIXOxwQ7YSeJ3yo0dSDyH0UEPPIZuZzjzQuU8VvesUdYQ3q3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=jwyhs1+hocL4fHswbVEq+COZh6wC9ue5gM/3fwIDNBFYz/fEXJ/k1uS8DzUAUIMe8UMqL5njlF0JRmDG8cWCZONHVgNyD3QMGf2ED14ntqwX4WmNuQIQXjW5/VEfW3uNFWQw/rVV1PL/r4EaUho+84Ff9GTSi0nmaZn+bgduhte3YVWcw4nnXkjAkGWSGog7oOTcAf1HQ2M6TvqzgdU7MscRCaC2E0VixU1b3fm7XG/mYLacbaO8Sam8mP8oaQpE0RiElmy8/BcyvxCxYvA7teZKGK6IbUlqsB8OdGZENsxlDsfgR4SVrx1+qYnTk4AvpoLW9lOI6NESSFV8UR6TFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS2PR08MB10266.eurprd08.prod.outlook.com (2603:10a6:20b:62f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:00:53 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:00:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v9 3/9] bitfield: Add non-constant field_{prep,get}() helpers
Date: Sun, 24 May 2026 23:00:32 +0300
Message-ID: <20260524200038.47826-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS2PR08MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: ec82e957-9591-415a-6b2f-08deb9cf28e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|9063799003|38350700014|921020|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: D2KPt4GKouPZKhxuafxbI0c9O80ssK8YZPETpxDzan30l2KAswmbBcbvi6pCi8EQ91sog3BjF8iexhglsy76Uc3qKTysLYbHJsd0ieH64/SUGoz7sl+rzLP/s2X5drdn7vYimYzDB7lcT/bpGMdkLIk16RR2x1Kyx7PNZbgi70qcXZ+plUlo4HKIOVw0kBg1OSGH/cebRE0eaokw+Rs6vLpSYf8Y8SITeO3wgyKnVCphbd2CM0jDdLGEm3w4Jq6CL7VzcvKN20uIPvw+QXdXCtKz/XtS98lWdKpqQwWTZnuJK5ulfEwkDtolbSNMJV/E9MfaFJM55h0byzbAdeFIvw6/dwb2WQGG5dnnMDalrZi86+2z4jX7x/B35mlqu9yNcTd/BLONMcmTU6FxCzmJUzT2pqDZd8RHXU9X4VOSxeggNLC7EixLJ6S+KfFYPET7YIGfztEGktgZjf/pKsigT3zoZueSCnAcr+dHe39fvWqWJctSt2uUju8MKW1wcK9I+KgSRYybTw8I//QUxS4PxV3bRh9p/a1XFan981yS988wNKRbwr/f3TOeMVg8PVshy68BD179lqB5udX7C51t9IwYYe7di5U7WWbhW/aKJhZFf2pKLukjykQYhCO0yEdFvSsluadwq407ey79FEh0pfhSpW34vbEjRoG7fO9OiNDXcCB0bmVSR5h31JrlvoUxr6Q4mM2ND4qotw4065kYYMUp9eRkkSVsNsDamqxDChqwkbQ8Wub8nerRNi3VYgEXe9gLGNUnigRDe+pqLDLqvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(9063799003)(38350700014)(921020)(6133799003)(11063799006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clE0STN1ZVptU0k5OE0vcy91SjEvVkYwaW9UV05Vb2lySGc3TWFXd0pFa2NX?=
 =?utf-8?B?RzdHTXVjY1o0dzN3Tk9SR0xSd3NPSmZwS0xKeFVmM3poZEttYlBxSFh4dnly?=
 =?utf-8?B?aWttdmJOM3VJUlU0Q3RmYUJ3OUpjT01GSlpFOVdVcC84SThocllhNjZwdjZu?=
 =?utf-8?B?TVlWRW80MlVUMDNTd3JFLzIzTTUxWTVLSlB1TmpMV1FXMzlja3B3MGJmUWRC?=
 =?utf-8?B?bUhiS012VXdnYWo5UU42MHoxWEtzR2lSdUlOYlBVbUFFMkh4dU56SzVzdVll?=
 =?utf-8?B?cVlNditFYWx1b2VYbWtvc0JEMUxxSTJmUnZoemN1MWtMV21TcTBDemxPa3VZ?=
 =?utf-8?B?MU5lbHNXaUJTblNGSU5SbWxTTnJKcTduZkwrSWNPbXBKSXUrRHhicEc4RVB6?=
 =?utf-8?B?Sk5VcVN0UytvQkliUnZab0xFRGRZL081dGRQU0JVeTUyYnd3dFh3ZWgybzl1?=
 =?utf-8?B?bkIvWlZjc0ZvK0x3ckdTc3NKSEhhV3laTGVTVkNzVUJSQWk4cWxFT2R3b1Fw?=
 =?utf-8?B?S01YMGFYajJSR25nOW9BKzJSaXlHY2NtOStvSDJmWldXY1hvbGVTSFMzVUVX?=
 =?utf-8?B?NmxoU0plMXJRNWlITWgvcGl5dzAzN2pzQmZ3M2NwOVo3dEV3UUJMU0RxeWFq?=
 =?utf-8?B?cC9YUWhkS0ZyeWFZQ2p6ZmsyL3k4QVpqS0hRcUhBWklkbE9GT0hSOWh2Rzd2?=
 =?utf-8?B?ZGFudmw5K2ZRdkMwUXdRYlRsNXJLckIwb1ZEUFFHRkxIMHJXSjZXTjlTbk9j?=
 =?utf-8?B?Z2FnY2xKaENIci8zVTVjNFZSZXdEdFVCbWQrVXNNSGlKT01GcFJYTlJjWUg0?=
 =?utf-8?B?amRPYVE5Rk5NS2FzcHJBVDRDR1hxb3N1Q3V3NkdrNDVOdHpHNVhXNURUUFJv?=
 =?utf-8?B?TFd4RnpRREpUKzN2Z3Z2TnVLb00yOE43dHB5dndMOUVYNkNoc2pVeEtOZFpt?=
 =?utf-8?B?dFhjSWlXUXlUTExHUFZPdkVQaDl4ZTFiK3JwWm9BWHp4eEJUeGVTNm1JYzZ0?=
 =?utf-8?B?MGlqWEJ6VEpXWHBFd0FJTXN3d0Z1TjIrY211N1FLaVNmQlFSNlV5WUc2WWlC?=
 =?utf-8?B?MXZ4ZzdoQklzVktuWkltQW1oQ1BuRUxEMEQ0WkxHTUxtQmxMZVgyZ2xwMThX?=
 =?utf-8?B?QmZvSDV3bC9xSjNnZkIvZERpMVhxeXFrUnY4eDFQcFQ2SmNJUDZhck1qT0M5?=
 =?utf-8?B?WGthWFZNS1BKRUN4OFVoaHArOHU4NktnSkxIalBEQnlIcXE4TXZxVVJRdlll?=
 =?utf-8?B?d2J5Sng0MEpnS2I0aVZwSjBpVEhZYllLSFpLaWJYeEVxRXZEenhrTVNVQVRn?=
 =?utf-8?B?cENXRm8vTnJXemdHc0E0Y2hxR0R0TjhoK0lmN296MmZuMjJwcEFteUtieS9z?=
 =?utf-8?B?TG56anpHdWxQSnErWEt2TWNzalRDMGZybllDQlBXUXF2TnM3bjlsajBTMmRn?=
 =?utf-8?B?TU92YWhTbEsyakhyZzYwZjFiWm43N2dNK0YvMUNRQ0grNEdnK3pSSC9YdjAx?=
 =?utf-8?B?YzVEemtNTHpQMWppcnBFaHRtYjdqejNFcFpPQnYvbkRIOGpqZStZRUovdzlB?=
 =?utf-8?B?cCtnZjAydGVDWVJaOEtqLzBjY3cvOS9DRTZjNmE4SXZwaHRpK2NhUncvQlNo?=
 =?utf-8?B?Y25LK3VXVHdCTCt6QnVPbmlKMWtzOCt5bjAwTkg3enB2TEJoOWJTYy9wQkdP?=
 =?utf-8?B?eURNWUNqSVJMMU02UStiNFRHdTkxeE40clA1eFh3N05hNjBYTm10KzJVS2xW?=
 =?utf-8?B?M3I5N2J5c0M4VmNKZVRoNmNVREgzcVo3RTg0OUpyMVIrck52ZG9LN0tmUkJz?=
 =?utf-8?B?R2x4Y0R4M0YrT2FFM2dsdU5sN2ZYMGkzcmdpejcvRENaRDJrS0JHZ05HR2wy?=
 =?utf-8?B?d25aWlpLUmFDSFZwYXM2UGlGYTJUamVZWnpWNDNNZm1yTytCL09tTjQ4UGJF?=
 =?utf-8?B?eG05a0NuSEN5SHN0MWN5RUZUOU05WTZxNnd0KzN0ZnZRd0dMY2FvMGpkODNP?=
 =?utf-8?B?OFlQekNHQm1QWVgvL0VSNkd0U1hiRTdpSUxRdTRUbFVZK1FWZ3NMNDcwdHo2?=
 =?utf-8?B?N2l5TXE3SElzclNUbGlQbU84RXBFSjAwUXVUdC9LTVF3NUdkS0U5OTM2RTY1?=
 =?utf-8?B?ZGNMNklpdnEzUUJDY1Q5c1pncVZ6SUt5cFhjWStJUmtPM042OXdKbCtIcGh5?=
 =?utf-8?B?Vk5ZeWZpdUNwWGVxTjBXc0FQSmJhM2JvMDhCRjNMM1Zyb1FBOGNpRmRDZEJv?=
 =?utf-8?B?cG9YK2xQb3MyakNVME9OblpCd2srZk9rYVFqUWQvZ0ttMVJlR0tDY2ozM0Zt?=
 =?utf-8?B?SnNqUm5Eanc2Sm9udWs5WmZGb1FYWHlCSkxVUkY1QXRVZTJyRG5MMTlzMUpL?=
 =?utf-8?Q?fiJJdk5uwkfLiymY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ec82e957-9591-415a-6b2f-08deb9cf28e0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:00:52.9978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAHEclv7p6Ov+e3gPAFM5cT30xpwH0KViGcuiT3jL76zPKbVHUh7zJ1+XPoaG3a7250jkaZ/Z0xgJl2yh1hE1XzPwAuH21G96bsQ4Pkpdx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10266
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by adding them to
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures,
  4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
     actually constant.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Yury: use __mask within new macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Crt Mori <cmo@melexis.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ef81901bc41..18cf57aeb2c 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -16,6 +16,7 @@
  * FIELD_{GET,PREP} macros take as first parameter shifted mask
  * from which they extract the base mask and shift amount.
  * Mask must be a compilation time constant.
+ * field_{get,prep} are variants that take a non-const mask.
  *
  * Example:
  *
@@ -223,4 +224,62 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+#define __field_prep(mask, val)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __val = (val);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;				\
+	})
+
+#define __field_get(mask, reg)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __reg =  (reg);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;				\
+	})
+
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @val:  value to put in the field
+ *
+ * Return: field value masked and shifted to its final destination
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_PREP() directly instead.
+ */
+#define field_prep(mask, val)						\
+	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
+				    : __field_prep(mask, val))
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @reg:  value of entire bitfield
+ *
+ * Return: extracted field value
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_GET() directly instead.
+ */
+#define field_get(mask, reg)						\
+	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
+				    : __field_get(mask, reg))
+
 #endif
-- 
2.53.0

