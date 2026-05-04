Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E449CD3424
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 00:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED08845C8;
	Mon,  4 May 2026 02:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JDF0cXX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4DD8460D; Mon,  4 May 2026 02:34:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE68384374
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 02:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+iGPN6yCDvIdLGTtscYWJ9fpQ7ogGv8usfIS/B/7Z2Gq5nYBc+WFSJBI7QvNxUCxLDcoslzikaGyVhOaWPePDMzOm7MNMPeKvO92Txu+9cz5T5D/yEmQBf2J8BMB4HkgzSYdIzvsITSRz0MQgouT0NfZHVVZiZmo+7u3zigQh8JQIHQw4KRtP2ogeZ1Eld+GcfoQzl6rfoHtrXKPjCMV1M8rCkU/iQRBU1HTy/OdruMCX2iJ8ZJtPBnOih36XO35XODt+ZH4DYGCoNmqf5toX0ARn9W7K8ojGoAcBjvwAnrT3TWd2Ahr1CdCXBHgsG8j4J6GXv5Xhu+GZRce4azgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agd54caNBhEzMkHLlKcQasaa/ynLBZ08mPHCb0+u9v0=;
 b=RxGFzK9Iy1eyuU5T1eBMz+LQHm1llRMKHUZOyt2BTfyjwkMdJzMpTSpWR0axBUm2OaU3+rxv/lj8K5D5zw2BfSUCBY6/244vCynHrzT+Syt+Fe12+GVWB36xk6LLJPSUlQ0GMArBlg9n4s96SQKqx6to6zl/Bl+VFib6rcfsScnPHuOkjMk+qXHygJmLpfmxcXkiscdbBiTDWuUWETacT7BbocON1iN76c50SxTn7fgeYNe7XrgKi0FRNGag9vyvtXyT18colckycDRfm7JYdmkD5GKmoVSrxb1Pu+fz/DLMkyumEL/N+K6AjgNFDFon33C3QrRIeJ1xgEzCYlRpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agd54caNBhEzMkHLlKcQasaa/ynLBZ08mPHCb0+u9v0=;
 b=JDF0cXX2rbAH9nPS9OK4m8bLB10I+qa1nCKZB+L40smJkLOAzqg0CChk4QwGKQFOcW+G6fOa+GqQwzWNtSB7Cg+Zh/MIQxc3UdMDfPEN3qccawiINrG3Q2KXQYbYpfYdJ7RFTgNMiHCQUYMzxPEkrtkX0mtwC8os3NanxvavX31GqCYu/PmdewS9sKgQw2U18v8gbMCcSmqzrg13rkmbScZf3HJAD9sC4aaCtDE6OtIiNyoGL/o983QRN+XZEMA4h89QpqlD4qNnQ6+7qfyuV87WqIaaIBRy4y/o5JkPK54ykIdblm+4qdXGi6gD91L5D6qRMA/CU+7s+g6wyJ9X5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by DU0PR08MB8662.eurprd08.prod.outlook.com
 (2603:10a6:10:402::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 00:34:40 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9846.025; Mon, 4 May 2026
 00:34:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 1/9] bitfield: Add non-constant field_{prep,get}() helpers
Date: Mon,  4 May 2026 03:34:13 +0300
Message-ID: <20260504003421.2545713-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00023A03.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2aa) To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|DU0PR08MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc2430b-fb50-4005-2c98-08dea974ed2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +lVOkWtY0uYWmeoVkimL0tvSW9gpRrYYmkS+X/C6LjhSOrGxFS+giI3wn+YELh7VE0HeVwSqLn2tdhqB+IGt1C9XQGguRpkyUH8pt02zpXWYi/rQvX0VlPyt+GuIKm4Dqj7UIDwQFJorRZdqC2+yHMykdj0gl7B7qo/WvMw8OEv6qDz6UlbCytNNRDpf40k04B/Wic5tBnLMlXjI8BqTVeLcZzqWd3Pnnb8+1W+2ZDhlhwi+C0U7srxe4QfWk+ZKWZnN7lFIh94t5ukporCrUSJAnvQBiMWcQZfkDAWiBVsVdH0v+GHqQZoVbtwnSd/sNhWLHeksAVJ+yg9yiuyvO0AM6zi1LiItRWDVtvOmMRIaXws9ff7ZirxM0H++TmVI9Ze2yM/DqgcDx1op++Wz8BqT8lNr904KicMR0WQHnHcnikuN9r4fGXg1GaBgSGvipiJzqNObQ24S73ccUNR2zBVAurBnt0/lgpLEQSnJV6OvPb9AoYOoou32Lvoz3SCbLwsTRO+xofkqsT/gyu/H4xX3u1MRCA/EbibGWa/Muhg8jNoWiH9FF3YOu6Be3jjni2i/qmFJDz1FJOJcggB+4tG2OkhgD3m6BVYv7CLO0ni1IXuNVZC+NEUO4Vp18ecjVi9jU9xyoqVI1RJfOVPfVGf8CoHE5u8nYwwuN8005Bfzfl25bL3AwWjPAyM8g6UMN41t2aCLazt2qdgkftfGzrs4Wjna4z2fo9AMylUI18ZYMtekGVRg01obF2EEVlxRQ6HBGVxRqOVznlRIc7VS5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzlZWkV1Nm16SmQvenpmSjFmSnNQa3FoQkFGR3kxTTYxQVZySVVmUjZRZStl?=
 =?utf-8?B?OFJsOVpwRzNEcFllV1pJVnRnNm5uRXV4amJEd3pVckVnNVpweXk1QTVlYkda?=
 =?utf-8?B?M09FdEhVQzRNZ2pJRXYweE5RR0Q2UGdVSU0wSTVSYUwyV0ZldlN2c0xLRW9L?=
 =?utf-8?B?aU5iNk5KQkRnd3BFYnZybHdvQU9Ha1h0MHQ5K3dRamR4MG14SXhFak1sb3Zr?=
 =?utf-8?B?cVM2Y0dINVBWREFVV2txMy9NNnJXY2FBYTlQUjVCY1hrdGpvZWlabDJENjZX?=
 =?utf-8?B?d1l1TCtyS0owR0ZpcFI2K283SVdOU2orSnBvZHZXcFVqS0hOSTVzTXo5ems3?=
 =?utf-8?B?RkExRGcwWEYyUFhCYlIrMEtVWEpsdTFVSTZTMGdDNUpOaEpDL0NLSm5YRWlT?=
 =?utf-8?B?U3A3NEJjbkRnd2tTeE1OcTFOSTEvL0xFVXFGazhzQjJscE82N0l4ZDNXaCtP?=
 =?utf-8?B?eEhZR08ySFdVN0c4NUhEMy9TUm5KaTNUQlAwL3lZVEkyM2NjQlJoNThmVjYy?=
 =?utf-8?B?YlFtcWovOFN5TldjWDdrQjFGdUZ5UmVySEowOVJ3aTU0YXNjMUEzT1ZiVkJn?=
 =?utf-8?B?cWF3NjV3K05JTUJVQy9RNHQrcmJpWC96M3g1ZStIcVl4N0RBaUlleUF0YjJ5?=
 =?utf-8?B?NnNJNEdWTVFCM0VOMXA2Zk8xdXBXYmRNSFZac0d5ZmZYT2FKM2VDelAyZzh3?=
 =?utf-8?B?TlhKbE14MUI5eW9WZnNIU3NGTWkvUW1ORDQ3K0QyZmZPTWZZQnIxS3BaVDhL?=
 =?utf-8?B?cFJuSysrSU1zMlJDNjAzRW9LeURqOGZqRG1sSkJZQTN6WEcxcHZOTEF0WnRw?=
 =?utf-8?B?bXl2TkJjaEFiN1Z0dFA5cE01NWtoQmI2M2hwN1ZWNkdXbzVydG5DcW9CeWE0?=
 =?utf-8?B?OHZvTWlROE50aWo1QnJ6ZUFsUFFLT0VJOGpKWm4yWVExL3BrY3NCcnQ2Z1Yv?=
 =?utf-8?B?cTA3VnU2OFVzMjl2RVMxSUxNWnJKMVJkVDhqUXAydDhjamRLT0pJTGZsTUIx?=
 =?utf-8?B?R3RMVlVSL1lPa294WUcrOHRTU3dBQjNBVTVvRURhYXdmSit3M2NFdkdBdS9X?=
 =?utf-8?B?OE54d3dxTnhyUTBFanlTU1J5QWtOeVh5NWFDanFDQmJUOHhiaWwwbFNyWHFT?=
 =?utf-8?B?Nm5SMTVlWDNTN28yUGRwRzNvZEdXR05Tbk5oN09rTm9JckEzejFzY01HNzRG?=
 =?utf-8?B?SHVadER4ZVV2NzFsTngzeHpLYnhRRUwvSXh3YVRSb0pVRldoSjBTRHMvcitG?=
 =?utf-8?B?OGwzYkhyWlNMYXdLM3ZPUE5sL3R5NEJZa3B5UTBMN0U1R2Z3N2w4Q0ZGeTVJ?=
 =?utf-8?B?ZnFydXJqVmxwZURFMVpXTHN5SUwxZ2pHRWVWMlZMUjRNQU5iVFJHaHVoK1V6?=
 =?utf-8?B?Q2E5c283NWVGTUpLRldQNmFuaEIxTlU5U2JsRjE5dHFmcjQxSEhlQUkxZDVF?=
 =?utf-8?B?eW8veUNaRzNYOGM5bUpwMHN2aDczK3NnMEp2azFMemYvZEdwK2E4K09ud2lE?=
 =?utf-8?B?OUl5bHpNV2JVam5GRnA5ZmlwNXUzQzRMUW1ZV25pWlJzK0ZaK05kQWc0M3JR?=
 =?utf-8?B?ckpRTk1ERWNCcGJrRzdwWUo3alhvdmpjaXRsVFREZWtQZGpJYSs1LzVLK29o?=
 =?utf-8?B?VmlIdXlDdmpoVmhsSGNoK2RoMFFJa28zV0NwcjZZZEpCVk1XQXVwS0xMM3Uy?=
 =?utf-8?B?K1Q5NGt2S2toeEt0MllBMkxrb2lYU2JZOFZiZTZUWFRud3RLVFB4WTdnbWYr?=
 =?utf-8?B?OUxwOWlxbDZZd3V1WGlSWDZ6K3FTN25EYkNkTGJjZXZQenFGSG1zQ3IwSytP?=
 =?utf-8?B?djlGSFEzaFdYRU84NEtMREZXUFdXdnU5SjVZNDFtMC8zNENwN2tqVm9iMVZJ?=
 =?utf-8?B?ejNoQUlmeTdNempqeUYzOE1VaDd3cDdWeGF2WFFJbWpQUmgvcSt6QkRFVCta?=
 =?utf-8?B?TnRvK3pJSW00d2pkRGhZSGY0OHFOUjdrMGxWOEpYV3hUUE90TUp2ZzBkQVJG?=
 =?utf-8?B?SHNVbGprYXdrM2l0ektvN0Q0cS8rdE1wTHcyUFozVDVWMTg2ZVViS2RTRThE?=
 =?utf-8?B?T0dPQ0ZPOC9EdnJtaVp5VHE3UWdOenJOMjNoSCsrSkUvQkhiMUdodU4xbTAr?=
 =?utf-8?B?Z1Robml6elgvekhMbWZsVm1aeUhVY2k0RHJPbnJaMktCZmV2YjZ4SE9PdHFs?=
 =?utf-8?B?UlEyU1VJVUI4bC9vVUtmYlQ2aTRDbXh4Ti92OG5obFp2N3dOSW1uNnBjeVlQ?=
 =?utf-8?B?SmNqOThJVFR2V2xtaHpMcnVJRTBxTXdvM01WRWFLQ1NwZldEU2lKNnNTRTFP?=
 =?utf-8?B?QnluYVdPTTV2WEUycnhmZGdDbU1VRjZjLzVUZFFDMTY4WjRvdVRFM1lOM2Vy?=
 =?utf-8?Q?1ajNQPRSWXfp9iCY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc2430b-fb50-4005-2c98-08dea974ed2b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 00:34:39.5455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axXuUCXgjrmg2bR5gXVVg4p7vy5rCbzuDxF/Szy+F3jjYiYc5pEggYggRjIIgqmpQYmLpblWsS3UFahpqfJvrM4gq410JQlgPQolfF0UGOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8662
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
---
 include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 63928f17322..efad7227bdc 100644
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
@@ -203,4 +204,62 @@ __MAKE_OP(64)
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

