Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D297CD343F
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5806C848A4;
	Sat, 16 May 2026 03:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VZ3+Xncy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF7284868; Sat, 16 May 2026 03:00:57 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6059684713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t297gpWoGfWBQ+IORInZbrOe/qxQWQ4Xx+XtQmqDZYpDlsgq1eb9n+4+nLZd6xZ4/GM8lHjPYo0kouMyeBYrX53hapeJ3SqC4VzBdvBpEp38VkNRV/g1aU/rHt7q3Nlq30TDc99stwszQRs4pxGPotxahyqDDUJd1NvBYNJv+abrQqYmJwHyhH2kC0KHicO5zcF7JHH3nYk8qpaE+/zKiBrADqu80EOL5wFOapetLLeH3Rm/wVXWucZV9WjJImq9CoR4Tw/nMChGD2pqpoHs742OVPe5t8T/Yfum4CND1WmbhO8tyZPxs5+4cDUBT6m7B050q+AJgIm8W4xev8FjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=xaCUYDxQjLjg0LeHVPaRbv2pt3X0C5Ein90apScizzk8LdtXvUZYhhm4IH4DBNKsYyOmJXxk/Egsrvhg97Nrbi+DpR3tCOxVEgenutYmXeWD5YTn67VhrUisGbNisPmZlFUJaCIeKfxw9b9UBvbTGO6ss8XIBLboHJeIGdw6X8md14IQfNLqWr+cqzxv2cIqz5lChBnF0LCYBYLeml6OB+WlbRyd4e8JuT20uxaCp8kjD+ug+JP0bkXpcEtrLrHPgiguFfAwLb8v4bVi8L3or8k32Bot8x4JPKbtzg+Gl1/lGjdr6HI+cpUCvGxMsjndOFWXHXcS4XScjwTjDLEglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=VZ3+XncyoPGvdPnsCQVhxRSfMWm69baEMX5TsZpQU6SIu+URrenq4I14OwS1phVh5h0R7sy1OFKMVbDuUAqDn+KZ5sjir6utDHAYhekJ/24/sxuTRPseGkGJ4OuhZG0BOUqWOiWFMbTrgdiq2Hkj2uV7J1qX3m0JfXWuAuoru2KpZAxcT0NA0qG9uB+PeS4s/nbJW2hM+z9HIn6iz9fRODtFg0DRRFwoiZ78MuAxmSjGVJsWjFV1ayr8R3LYow4iZOBwrOZMreFfG19fAxsoUhrpEnyxC+eSVQ0CGommFasymTxHfiA5DQHmXgEEOdsrcsxhjntCgI5uhVa4fXisJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:00:53 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:00:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v7 03/12] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Sat, 16 May 2026 04:00:26 +0300
Message-ID: <20260516010036.1034352-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0001DBD3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a5) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 931ad37c-c5e2-430c-b7fc-08deb2e69422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|9063799003|56012099003|921020|11063799003|3023799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: fhvx0ieVA5Cy8MrNwG2LQMKY2IxvLzKnHks/MF4Xz0rog41qMjFbxaRX9GgdHYWKM0v4bJ+QtcJQ2SK+i7um0dCyp1WuLgQtQ3+ZbVyva0ARCDliyU+GCY3ifSqoQP81fnR+yhiIGD8O0m7xZK3CM22x/dzOj4st8Ac3S2che4B5+awZyXPW2tvdMmNgOgadPLNhIEiX/F8jFHtTPTx/2T2Bm4ZUNQ9OC8LJMcoNzaz5p4cR3HPoSJ5iFX9pq6KYbj9PdxftG/9DuFLQphG6nxtPsiOCtbXDYK+lTsG7gJ91fz6IWzLjMLIwtLpW/ahShCZQ8GMNnZuHS+mEGyk6mFxC/RCMZzXFNvlVwST3iAE2bNfvOMHnTrw9JGWV0mMZreRIiXEgbU770Fak7NvU+Y3to3VIzXssAV8+efyfsnxdLfScyKiYg+BKvhdL8WrPu+pCsyFfD1mtnDWmxmHmHgRzwDyCfbY+zopVRWPqm9Jgt2p/sTjG7Rf6Zb22s76Eb2l3OkVXOuMygA1JwjxpHixCFQE3Xbzkw3DlboyVrPs0N+ttAJReUoasjZX/D7VgKUax//O5mLCXk0PaYpVdAw5UVUEYSIoBdR5BBFV4tJozC+YU/9UlrodbWMWszID9Vz3RhkNFfFYJKf//x9bZA+UB6/QFMxNVB0lMy0RUc3G5fxasDSGUxR/+XDhVZmE3WSCuB9uSnT2WGUjUtboU0tqkoUNZnpecEDHbKc9FkmHE/2GLFNo0W5Ip6bkuNaRLO/30ThyfWUPkjRDfmMxCgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(9063799003)(56012099003)(921020)(11063799003)(3023799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M21YUENybEdQQldhSFNVNXFCcVlYTTE1MmtremlRMDVnbHF6QzZXS1AvKzVw?=
 =?utf-8?B?MmY1WTNBc2JzNWlYVlJmNm55OTBZMGdSTVNwcjluU2txSFVaQ3lpTktJNmdC?=
 =?utf-8?B?cGhzVW1qWTVpa1E4c211K1psUW80akNlSFJGY1IvWlBYdFVMcXlUM1MyMnFT?=
 =?utf-8?B?UlNZMFI5ZXlMTlJpYWdmTGR1cE9jRDVHRkFia3VNVkpickxjVXZhZE8yRWZV?=
 =?utf-8?B?QmUrT2tZNm5RVEJZM3NkVDhzZDU0aHJnZzZWQ2xuSm5ETU9seGhIcHo1eGhn?=
 =?utf-8?B?VE83VGRITmZSK1l5K3F3UnJlSkJjQUU2bjhQNkNFb2o5N3g4VVBudU5odXhs?=
 =?utf-8?B?cnJiOS8rcURiQmFHZEt3NzdGLzMvV1lIQkhXeVNCSitSdmxvZ0hxTjZDRU51?=
 =?utf-8?B?a21KMG5oSHprdVBxNWltcmMyaDRZNHY2cHlqNUxYVVRmQUI2TDkxMzZpbDh0?=
 =?utf-8?B?ZVdGUE56ZHU3ODZBa3k5ajNSUXBTNVVUdUpHVUJaWXlBMEhnVko5WGtjbk5V?=
 =?utf-8?B?VFNhYlNKK0JMc3dSaWNBSEgvN2k1b3ZWcUZrd2c2YjhQdW5KcE1DYTN2WnU4?=
 =?utf-8?B?TStVRjVtNXdNeDBhT0YvRGZBWFlRYjk3UzFmQ01ocWZkRUFvait5SGhFRTN0?=
 =?utf-8?B?SEFTRnA4ZGVMYkhpSC81THBwZXVkbGt5WWVtdVZJVHlRWHdQL2hmZ296bFh4?=
 =?utf-8?B?SVpuUW8vUEptS2Y4TGVqN2wwMXRWSjlXRUJ5d0ZvcUFBc1dlNnY5Q1hZa29v?=
 =?utf-8?B?U3B3TndZeEd5cVZ5dkZQWDRySUdoODh2NHp3QnJ0SHlmbkJqR21wZEEyRUxk?=
 =?utf-8?B?anJOY3BaRW41U3J0ZUVqZGQ4eDV4aTU3SFlRdXkzbFdOWFU0Nm80cENYME96?=
 =?utf-8?B?a0xqcC92bGt3UDJSZDIyZzNueFlkVHJwNXdQcEYySEkxRDVycDhiTlBqN0kv?=
 =?utf-8?B?L2h2VURxejdYREhmZUxPYmVXWXBNVEh4Q29qUzZrUlRWay8rd21NT1k5ekxO?=
 =?utf-8?B?WXNUWjM3R216eUNmMisreU5UaW1OcTI4WXRyM3ZUL1lxWnIrMVZ2YzBNVWlX?=
 =?utf-8?B?a1lkVnl5VllsMFY0YlhwaUM1MTI4dkdsRUdxeUF6MnQreG9mYUtHcXErUTN1?=
 =?utf-8?B?dWxDWUszVmlwd2JBMU9hcmFtRGg5UFNYWUlCTUgwdkNmUXJpcURESTY5aUtK?=
 =?utf-8?B?bjA1c1hsT3lkbnhLWWxMYXBVamxVNTRrTVZFS3FvWXdHSUR3aXF6ZlBxaFFD?=
 =?utf-8?B?RHZEVEdMY2VhTjhna2hFMExIMHd1aHNxUmVWL1ZNZkdlcFJaeldBc3hJY3RD?=
 =?utf-8?B?RGxUNWNNUGw3djh2UVhFSDN6ZzF5UEdCalp5WW5SRy80aG0xT0lLSVpiYVlZ?=
 =?utf-8?B?REcyTFJjVkV6ZjRPU292MnNVUlJzVVh2c0Yxa0xzM01uRlZvclByUW5MZUsr?=
 =?utf-8?B?Q3FoTlc4dDExVlo5Qm9yN2d6K0dqRTQ1MVlKS1o4MXp5MWo5VzE5ekZCWk4z?=
 =?utf-8?B?dGJrV0REVmRQVG5RWVIzRlA5Ti8rT0dBTk8wOGE2MWVWY2htK0p2TVN5UFhV?=
 =?utf-8?B?M1Q3QVNBWEFaY0FFVjhZUFFTMzZ0NG0yN2hXRDJJd0c3azVtd1VGekFEUE5E?=
 =?utf-8?B?U2d5Ty9zbHo2aFE0REd4NXc2UlJTN1JjK3d3dDdIcDNLV3Y1VGhnUk53eGRX?=
 =?utf-8?B?dWhyQ21UME5NWjNMNHM2aUo1cms2TFlGWldqVXZnbnM3bjh0bm4xWlRjRCtH?=
 =?utf-8?B?SXgrTFJSd3lTZ1NXY1B2YVZkeFkxS21BL2FrMVA3UXhMTVB5WEdjbTE1bXRQ?=
 =?utf-8?B?UVAzNG9YbTJMMS96NjJXRURCOFNDU2FzbWxOWUg0WCtJN1RlUk9vbzh0MHZ4?=
 =?utf-8?B?S2RtM2hvY2YrSDlhM1U2MVZ1U0NJQTBMZHVQM3ptS2NkY2NGRFRyNHgycWs0?=
 =?utf-8?B?aTZGeStPYXR2bjJTQi83ZzUza2ZBOEdJRjQxYzNRNTBvODlkNmRXRGR0NUJU?=
 =?utf-8?B?QTE5NlJrTjhWWmxlK0oxVWJxWXdhSmYxZnpIVGprSWtoZytkbzlMU3l1dEZv?=
 =?utf-8?B?ZG1nUEt5U0gxakhDODBpK252Q2tIbHY4UHMrSi9QUzZKdGwzSWwvOFVpMm9J?=
 =?utf-8?B?ZHZkMFBkOFNsUjdvRGJHQkMrVkdqVDAxcmZlMUVMYWl3RFVRbSsvcnlIbDAx?=
 =?utf-8?B?aUVnVjQ5U25YQlRISTU2OXVlNkgzYkJadEFLS1FTdXBOSSt4S2VYTis5S0VN?=
 =?utf-8?B?cEh1aXRLWElTRnlEK3NiN0JuZHpoT1AyRGNYT2ZWTW5VOHVJT3ZMdnpmS1dw?=
 =?utf-8?B?dHFwd3VjTW1GU21lTU1tMmRiWnNhUlBSOSt6eDJsOGw4U0tSNFVzazRhM1Zs?=
 =?utf-8?Q?cdCImVfqPG3enCLE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 931ad37c-c5e2-430c-b7fc-08deb2e69422
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:00:53.2815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t35mdq5jKMqih5/0r1rlHxMc52qQ8RcPxnFnTXkdG5gWXY0rqksSRrKAxIbIHVxTu+Y0EsGMaD0acD5chb7FzL2Yfx+RgoFo/hO+7ZtIe7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
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

