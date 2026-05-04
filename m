Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D85FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40B184694;
	Mon,  4 May 2026 15:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="52nYtI/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1509184692; Mon,  4 May 2026 15:03:24 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A2384653
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkUx98P8AYWy4VcW4a89rz6lYIWZil8Hcj0rsxgJZvIbHFU8FgRvcae7OOGGsrNV+7DrjsrSxk0Sqz86igxQPWotr3N7IlIM2uCx6H45Q+wAsgooVEmvwoJOYKzGqMCnF4r9Ec7HmEqCT8H3per3cIIzVMfq8ZgCKwva9urX23mnh9NmiXPF1Pv1SdKP+8qwHxUp2VWS0Jd704AJxZqLoPV/stYwn3yC/XzaNrtqhE9IbHkT3vBT0YhK0w+bTAibKe4ljKjzIUrnrz2T4/vN7x0SGBHxJTgaO0eInDVyuaAXIFcPeGR8fuoWwwiJwYvVOVgswYtbYqRZiBZ0QLfbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agd54caNBhEzMkHLlKcQasaa/ynLBZ08mPHCb0+u9v0=;
 b=PwHzlwvTplBqJfbC7OrU3XRiq/iqyv2NoPpyIATdZ8nS9HpOhiNtq7Ea9vFi9SeS45APm/XRU30csn25C1tEebVHquYXUb06iZOBc4ioq07KqgemdQvLnnL12oGIX0N8kQh/ZAhaENdBJNh4VkhWLf6+a1q5Fz5Zi2eRktjbOs4Dgvlcf9U66nXZ9for73rER6iVFZGwpA+p0jYEld/cn/jPY6ZqtQ7KuFNH+eWbxBwQ+8MlG+3xU5+UjFLnSwtLOXs9nj5l3m0xoDOQCf42UMfnrR2ipQERmUt2LoxBqa5y34b20s/F0onN6dUm2dP0ZEitcB5lfumcHdwzQvEY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agd54caNBhEzMkHLlKcQasaa/ynLBZ08mPHCb0+u9v0=;
 b=52nYtI/ShlH2tPTXdPn+w2mPGbyH/Dr+OOAvR2vV3CiXoLW6Pg2vv6bNBI/t6JyM6voJjcGJXja1oFnz7FAWcpejpIO1e6M27cNq/Jnnvk6CGBWQLBTUXfwTMHnAYm3nq7X7OKs4rKj61PT1Yxk/x8F3RA7ogJiIqjO8OqSNfE/wfPtPpZd+AEWQj4+Hbl6l0u1otUn4dpMyJXP4i4EyYKoQl/yytKYN0QzCpnwgEwdNnt8yiOt6DBIAWvSeN12ksocXjDKfc8LbGW7r7FF2Fjl7+qVPhZKV3J+crMXDbO2dMBjf1Dcc+ywqS4c3X7xBckcnrSNlZxhIbU7UfrD0ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8098.eurprd08.prod.outlook.com (2603:10a6:150:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:03:17 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:03:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 1/9] bitfield: Add non-constant field_{prep,get}() helpers
Date: Mon,  4 May 2026 16:02:58 +0300
Message-ID: <20260504130306.2764862-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 139eac58-4080-4602-3c89-08dea9dd8273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|7416014|22082099003|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 5bu1zC22a2x3NT3NOirM2lo83dNrJ2NuQWhaBSv6s4dz6MTrJw03PM95WTDG+W6+naywij2aZUXnM/vurBxUuqLBGqggQhrwXuY5CSdz1dLLwu6gmdPkCrncqMicdmnv9InGRLNXhykya1FE0Vpg7ZKEGCrktYGLUL3DZ+AgsIYfHxL0X37QEkCZGnEwnSI4YgP+dek1CGwWteiA3pTZFraSA50//Nl4Xtpow1vP6SMsKavQN9sUzGQrvbqazR+ntM7TxVDSR3Ot1XmCS42sXW0wtFPumEGKMeleKwytMWoohdbbwC2wBYuH+qmjypsvIgFfEypXvLGMgLUat6pYnzpT0i+WNtzv1Jr+PaPX5rJFwVDziGaEKtlNA9/2FlU49DR7yQTb95O+cfk6X3vA6sK42bSbrnmPZX93Ny/et7iJQc0ozixmoyZYsd7Ul13gfTDA8TOn5heV5FTeHMLckInz5R1WbtaD/xo0b8cUL3pMhTZOlOoj9s7SItPRrY+21jQwl6inqGGlqvpdX0HSZpQQluGIiSBoPvwfmmP/ZCaoSucGucF486etGSQC7RGmROncZcwE3Gn41gaXYXGJj+r8d8vMwGkJ2p1SSluQVwfyMrTYTKF2zI56sTQGTQgEhKbCoauaNIgpi/jIL8ofzAMLhWH5f0tp1mxqNlCQA94snMmh9UKzdmYs9XcSytNPcQqjnz5pDcuGGgpKAevNY8YbN/egd33lEAVEMmjqj6dqGpW1HZpcGAYc/rkAWdSwJLBsq/c0mIl/K1wtqbDZ8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(22082099003)(56012099003)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW52QjNUOEtQWVNLSU0vMFZnUFlnU2Y1RTk0ckllcUlYbkk2SmtQeitiaXp2?=
 =?utf-8?B?TGM3NDR4NE9kYkRRS05XeHZBcUpTR21ReHNhM3JEN1VKTDBvSkhJUnlIL2M5?=
 =?utf-8?B?MStqMXdwbmowOFhjT21yN1dhdllTUWgxRkZ4ZWZ0SXdVZlQ3K1BHS3BUam9k?=
 =?utf-8?B?R3UwN214a3FiWEwybzBwL0VuYXNHS25IWVc1S1M3dWs0NFg0eTR6VHFMOWhK?=
 =?utf-8?B?dFRmN0VxcDBKNDFiK2Mwc0sxclk4bnZsRVhPSUlvRE54SlRSaVUxUE55aGVC?=
 =?utf-8?B?ZkxLS0pvMHpQV2t0RWp3QllmN2R6TXBzcG1nc28xN3hOQ3ZEd2hPR09McTJH?=
 =?utf-8?B?QXJBNTZlTnhLTG1SaVo4WHNYaEJkTlZZSllLTFczZ05TZ2V5eWwvODFjNFFG?=
 =?utf-8?B?ZmVqYWlqOWN0ZFM2RE1xVmoyU1plVkhyZnlwREQ1bnUwWVdsV3ZxSHBsS2dX?=
 =?utf-8?B?eUtHeHZwYSt2STExRVhXcERIRThCckYxcDc0enNvUUNiVzUxTVp1aHVVR2FF?=
 =?utf-8?B?d0hkRGcxb0pyaFYvNlBUODJWdmZ1MHBpVklCL1Y5c3IrWDNQK3BLS3Y2Znox?=
 =?utf-8?B?L0RkamJEREZ4SFBMaFRMNUhHM1BpeFRTMTlraElXYVMvMzN4TktyZW8vOVlW?=
 =?utf-8?B?TjNqOWdHNjR6TDhRNnBLNldOaHprcjd5ZjRGd0xxck9XY2ZyWExtMVFkb0dm?=
 =?utf-8?B?dWtNKzVKNk9PMXZaS213dXdtTEdDN1RqbkVyNTcrL2h0TzBvQnZ4YzJrU3R4?=
 =?utf-8?B?Yng5ZmMwNDNZMFBqaGhoMG13NHJIbUorMmliYkg1eXBhekxRMSt4T0R1ZDg2?=
 =?utf-8?B?YjZZbTVIV3R0d3NMV20zWVZ4UVlCQXUvdXh4WWcvLytKampqL2lEZDJvTWpF?=
 =?utf-8?B?OWdpTThsdE5HdlU3UEMrWmdpUjF0TURvNURMeEx6ZnB2ZHU5TEppKy92RXY5?=
 =?utf-8?B?a1FTT1I4NU1nek0xU1A0ekNWYUd6cWUvSk94TUlqSFpoZUYyRnR2MlNuUi9U?=
 =?utf-8?B?YzRCb2I3MHo0b0xuYk9mK3JyNWo0RVRvbk9RcVdaYnFiWXlNTEhzRXREN1oy?=
 =?utf-8?B?ejlRSDkxbXNvOTRrbmNuVVBrbjl6c3BYMHZ6ZUdwK3g3U3ppWkRrOFRaZy9i?=
 =?utf-8?B?b0Rxc0ZlUjQ0NTFNVXllS2lOQ3hRWTR6WHhiN0lTd2ZRK1o1TjU0cE42SjUx?=
 =?utf-8?B?Y1ZMTkt0eHFva3hFUWY2eGpKc3oreUhwOW1lWFloKzdXZG9OVEF5ay9US09K?=
 =?utf-8?B?NmtlRWthcGx0UlY0aFcrZ1pNMnF6czBaRHJSN0M0eUFQOFIzYXVtUHY3dWVV?=
 =?utf-8?B?YW53M3dMWmF2K1Bqa2w4VzRxQWNmcEZqL2xURWg3YTI1THM0ZldTZjd5QlVS?=
 =?utf-8?B?OHNLczNwK1d5QzRtL245R2dmNVNVT2tHSVV0RWZTd0trRTB3Y0tVdUYyYW8x?=
 =?utf-8?B?OGR5UEFjaUxVNmI2S3ZxZnJGRWpkNzhGSktWa1pSaHFuS1VnVHlXMUVpbEVM?=
 =?utf-8?B?MzlBRlBlcTMwVDNvT0JKSTFCelNobE5LZ3lxNHVlL0ovZ0NwaFUwRXh4Q1NX?=
 =?utf-8?B?c1Z3OGRPYnZrbmNYYjBCL2ZjZmwvcWJhSFB0ajhRaVJMTGIyZDBna3ZVbFBC?=
 =?utf-8?B?VlJTNnFrS3RmalF3YmhFbEFnQmFRLzRsMTJHa1FtaVJMazl4ZDhLU2JBWHlQ?=
 =?utf-8?B?dWV4Y2FKL3pLYzVuMi8vSGV0SmdEQTN2WFl2UTF2YXVuYUQ5dXBtdk5JWHNr?=
 =?utf-8?B?NVFUeEJzdE9TRTRiWEVlTTJJY0FqRDN1dllIZUpYbHROelBGNCtUbzRtRnB3?=
 =?utf-8?B?Z09HUnIyV0xhOUU0b3dDaE1EakxFRGRqWWl3c2QzUWlQdDh4dlMvd21sWlRO?=
 =?utf-8?B?cTNsY05Bd0JvQ2NFS25sYVE5S1VrR3pTajVvZ3JZb3d2b1N0eUFGRkVTbUxR?=
 =?utf-8?B?V3BuWDd5K2ZCR1V5N0JSMTNPY1pWTzRPSjdZWGtwMmtxdjBGNVpCTXR2RDVP?=
 =?utf-8?B?R1BudEhmRWowTXpUZlpPaStGWmlOOWREaklCbW03cmNHclNBSHhzUTR2ZTBi?=
 =?utf-8?B?aVlXTnZieGNMRFFJVzN6RGMyd1h0YUZEZ1R5UktNbGhweXJrbTZQS1R5dWdl?=
 =?utf-8?B?ZWo1TElKRXI5b0tiYlNPSjlNaWw4RjFPN0k1QUxBYS9wVE9aWXlqejFNcWJm?=
 =?utf-8?B?ME85cjFHMXVqYkFoTTB5b241QnJwNDNIV1NSRkhzNEtjN1VSVlR6M1Q2ckxX?=
 =?utf-8?B?eWxRSzcrWUZFSklFZGtTWG5tcTU1VWxRQWZ0bTVTYzBsVjc5Q1E3TjBrK1h4?=
 =?utf-8?B?em93eHlYZHRXc0ZQM05wclNTZ09vY3dRdXN5SithbTFCTUNRTGg1Qnd0MU9r?=
 =?utf-8?Q?9pilZcYIA0DpxsKE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 139eac58-4080-4602-3c89-08dea9dd8273
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:03:17.6566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5CiZUPRAm5zSEucWVPGDltgYW99ZA6JslVOWRtjnNrrHT7Bwk0E/XmXpIyw8HaWj+NVIKqPmgVS6xgrLqfyrjNbb6VDM4J62DMDCt37CNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8098
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

