Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82F3CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2ED4846D0;
	Tue, 19 May 2026 01:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DJcrdNE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB67F846E6; Tue, 19 May 2026 01:51:32 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C25846AE
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/S0oao3+vz3CUZjUwgDtPMpCvIi46RGNjGaT1eqKx46HR+lBwKC5Tc/1EKc9PbGd0/8fcxRASR3mChgzdcc3ZlQVJuDw+sKPNlzUomNNPNOW56yGmJzWCyXAnQhjZijcSlDQ9F1P9gYJ1DAL1UJj8hxjlgZn69SwniWc7YzO+oNMT8aHrp+lezXyD0RIvBvmCMgJq/QuFvpMHgSMDo4KH2Cdwd748IknzIwnteCYiWBl/o4XPbQbpwZt2nYv1Z+S7fOlTaog8x0eSeTjZPrEEi6nc4urw7M/Ps83uaPDwI7tMWVH7B9mGG0FDsxTCJ4/123OEehW6huCP/uz5FRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=h5TrtPVbb3mtbODA3mT8893EbJyuhXnZOu6ijUh5zRKRkZSj1rKD5B0kiOOrSteALMPhpPLLbFBmJrDvVlWNQ5I+Xm+tgje0s73EHwaybOy7J9nropbFzFUMqEBGvNozfJktJ98l8qYyE0iN0snqixYQ+yC69qOrSHoBRS+vdkPDP4MQs4CchnXyc4pGS5SESiR7dY/TllRz+1BQ4T6y+ql5mgC2hwJ/t7xb8O1yjwbqiZ1UYUtwUH6HInu367QrRUBkt3LKogXl6kMW8I9tHecE4uACKGlma/99XMWIswk04nS8PqEzn4WdGr/w6sfTv1M0RcRzgvRu4tl8dIOVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=DJcrdNE/6tGSHVfwcfZXRiu4rl1yaqhlZtuSVsypitBJ70d07cnqpov3BNpc4ocplM5Sm2vPTlOir2V4mvgJq/7+IjMb1GasiwGGRMYACS62hw78Wi3njY+yR4KI2Hd2gF4OH461F4qM0lYt7KfFsWHtvvkO7m2VRnBVm49/UGfvWvKdB7RJCUpOZ04faXwr+shhR5HJSQmS/AxABMtDwluiP1flbusqrRGvemFA+C5wNs2IqO9+udifEvCEBQJI84aEsWY8b0wgGPagYNmVv6C2MaESb876NLEIJdnobCfXWh3Adj1hj/qsi+rsfqo9ld/LdDJ+pshED9Ys71fnCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:29 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v8 03/12] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Tue, 19 May 2026 02:51:06 +0300
Message-ID: <20260518235116.2664557-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: c072742a-7e3f-43d2-bc8b-08deb5386186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|9063799003|56012099003|38350700014|921020|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: 4/6Y7Fe6K90XhtWr7tyfw2p3WFFkTFMg28xjcRFKshDzRxPuRCofX9fTRCbTpZ+kmnYC9DrQaB6R2M47Bf0AsUUUFne2jrxjrdOe0ESBZacTmlYFKJ/g2iPiRAvHou1NbV7e/kOmIz4YSv9g7M/0viC+hloRUb8Nw3aSOI97yaUpQAzIcbbwlmhqFKgOATWsHtIrqsn4lhlxtOzyi9nQ0VYqMbDFe3sl7q37N7fWQY/LXM/TCbu3jwA97hoR0fqpsnQKDi/W051fHv69FziVmjNIPvCgzsNc6+//bxb4tLhfvTP5rYkiYXjRDyMnoSNwECGOAfbuSumJbIuss+R9fLLOuSeiPbN10wOE5Kl8+Rx8GNkeNg0QmSmlBfTuba48X3xKT9buanYf0Ktp4NGESAC3u+YtxL4oIyvjiQa4j2NFxppsSk/t8Np0OBfqvk3BOzeSr8z+vksxxsZ7Og7VZeX5VNtaR2QvoXJ6rlrVvjnA68F4fDjI4dSVPGQ1vNwXnu20QIIl5ds+9R4d2UigD6wspOv0k6C4FMJuiE0ZU1C+JAdZ5bXRvqJ+ZJ3GlJACUN4mciKcrju64BnsFwMwt/27aznqVWZpH1HX4SatsdF1rQ93uCv2TwZI7KQfZFlsmm+yvzGG+c0ZUnBPdyeloQ8mBDCh628wm7MtxF/Jw/al4N+Lv5cWf5eSCz2VUd59wPAdFp+jiAcVZhcM4dVQpbiiC5h55STq+ooldqzI3qPIKvioQIqDLd14XlaEtP4UegODmcQ8Rb0EknAVtCa3kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(9063799003)(56012099003)(38350700014)(921020)(3023799003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnk2bnlsN0tDd0Nkek41ci8zbjFkR3NsekhOMVBXMFRBdEhGaVQzaUJzd3NV?=
 =?utf-8?B?UmRCZG9NQURhSmx1NkhnUGJkLzZaZ1hzRWZhZjQ1akNxUHUwa2pEU1VJbGdD?=
 =?utf-8?B?eWRFN09hTEJtNlBkb0tqRkFBcnIrRXZlRFp6eExNZGVSakhPbm9MSjY2M0VG?=
 =?utf-8?B?R1E0N0NlUVUwQlhIZ0FSaWRQTnpFWFQ3RlNZV29zMDF6Z3lLOHp4cEZDbkxv?=
 =?utf-8?B?Y1krdURnc3o0a0dXWkg1cFUyenYvdERyZ1NlOGptT1ljZjNiV2ZPbklzZXJN?=
 =?utf-8?B?Rk4rc0YrLzk1L3BOd2E3T2FIQi9wWHdQSG5LL2s2N1hLSnlOeWtKSlU5aEFt?=
 =?utf-8?B?SmtaRzl6QU9MSUlTSWUwZ1JkeStuQjZwUUFFUkRiRjFkZHpZSkNPZjRpZnhZ?=
 =?utf-8?B?VmNWNDRxUUJleVVINzl1amdqRlBpSHlGU2h4Mm93WEVleGZ1dFJjVVVJbkNS?=
 =?utf-8?B?Tmd4YmJGaTl5NFQzVWd6V01nbndVTTNqRnpvOHBVbUlvZHNuenN1T3ZjZjU0?=
 =?utf-8?B?K2dkVFRCeVlCNk9xcFdyaFY2T21JOFVjM3Q1S05IUGJBWXhYTElSa1czYmZF?=
 =?utf-8?B?L3ArSFdBTEJkdVVwS1d2SzduWElidHhVUXpHNHY0eG1aMC9xVWxKNy96eU5Y?=
 =?utf-8?B?NkJ1ZnRPVUdRUTREY2dHOWllZVBySW1iRGg1eW1iODBhWUJnVDBwbHNGc2ZU?=
 =?utf-8?B?SU91ZEttczc2cEEvSHBFOWtoYm9lQU1nQTRXUTQxb0ZCdGo2TUpZZFNvT1Ux?=
 =?utf-8?B?eU5xcVpzZGRyRlErRnZYbmJXdlpxcTk5Wm9OUzBwRTFQckJ6UTM4ZWxmeDlt?=
 =?utf-8?B?TlpCQzFKZjlITjh6MUJmQmoxSWVJK3ZRSEVNUTRsYVdiM3VlWE1BeW1FeVhU?=
 =?utf-8?B?ODdlRDZ6MHBQZWFpWjZ0TXpTT042OWtVeEZoQ3JEOFBYUnZzNjBVOFpSb1d4?=
 =?utf-8?B?UEN4b056OTNTcXhYMldiSUZuRmpVTXJ4UUxLRkx3MGticFZTZ2Y3eUs4ZWJw?=
 =?utf-8?B?dHd4V1o0c1VTYWFOK1RJNjh1U1pnaWVxYmNDUkMzbGlUdXREZG5Xd0ltQmhO?=
 =?utf-8?B?ZmUzSGxCRXhnMVFpWGNVU29qTjJ5MGFNaS9PODUxOTN5Q1ZLeS9mRWJHL0Ra?=
 =?utf-8?B?VVlkRWYzZm4wSkQydG1TcE5tWmdaM2ZocFRVOUgxWVdSUElnSUQwb2IxQ3Ni?=
 =?utf-8?B?eC9GLzFwU1I0RFlLSEV6bDkvVHJ6cW9JNkthcGw3WTdZRXpZdW5mTUNYM1F0?=
 =?utf-8?B?TU9qRm1BRjEvSndhSXFNRExOaGVSU09YeHRObnZGVGVRbHB2Rlg0ZXEvQ0FO?=
 =?utf-8?B?M3hDQUJGUENRK0FMQ0E5N1YwOVZDSEJBTmhTMVlZTE5zM3dqRWNPREg2N3kz?=
 =?utf-8?B?OXlHdFB0RXRYNHlLaVVBWUYzZll0T0RiZHZoSHpwSE52WTFUVEYveXo5Z1p4?=
 =?utf-8?B?OUR1Tk1YSUUvNERlRU5KTjRYaTNIR1ErNXIyVzVWbnZSdGVtS2xqZVc1ZGVS?=
 =?utf-8?B?WjVSamxUTkEyVlVKVVZqUlo1SlRQcHlZMVdIVlE4MzVMU2JzZHJPamZXYm9Z?=
 =?utf-8?B?UHJJRGExRGZ2Z2tmRHhCUkk2Mkx5WjczNjBJb0lzVk1adUdQK0NyeWZ0a3pG?=
 =?utf-8?B?UHVidmkwdFZzdTFyRTV2L0puZ291Q2ErUDlOVk9UUnQ5ajNEaFZUNG9TZVhX?=
 =?utf-8?B?YktPQWQwSmVEZlo2Mk9uWVRBMkZINzdFM0NPZFJSYlExVlBCQ1lxM2ExMmJW?=
 =?utf-8?B?c29vTmZURmZSYklMbk44djFPclByVDd0dk1vNk11WDFVS2hxRmhncmN6TDNE?=
 =?utf-8?B?OHd1ZWQydGtZUitQdGZhSWFHRWMzeWRGQWRLQmpNL0RyejcxNjdCaDdyRVM5?=
 =?utf-8?B?S0wvOWtCK0I3eGpqWEhmSzQ2M0VnaitmWWlRTFhCaUxhS3dIMm5lY2wwcm1T?=
 =?utf-8?B?WklBR01Db2dPVjdsR2Y2UGFsdDFYVFE2Wk5jMDl0LzdHRmR4M1gyOEx1eC9l?=
 =?utf-8?B?YXBxMzg1eWNqRmtZMWtwd1B0VFBoOTdRc2N6UVI0M3Bua1QyS2U2ejRoUE95?=
 =?utf-8?B?VmQwOTBpR0NnY1FvYWcycTk3MEs1eUpRc0RLN29sTlk0eHpMQXRWaWY4VjFM?=
 =?utf-8?B?L2pPUFVLRlpEWEFhbE55Qy9nT0xSNGdXMUdLOCt4L3BPY0dPMkhaa2w4L2tr?=
 =?utf-8?B?QnZiOFFoQ1J2Y3lvdm1mUDRrSDlLTUNpZm02YnY5a0FtVGkyNFQ2dk1ib1lI?=
 =?utf-8?B?SXFyRWpBNURQSlVEU21PYWhQNWt1aGlIZHUxUURBNUd3cHdpMlB6Tm93VCtz?=
 =?utf-8?B?QzZMeGZseUplWUQybVhGZzVFbVdJMlU4eUYwa0NXQWRvZDA4bzNmZDhqejZq?=
 =?utf-8?Q?8bgt8otPi96kzMfw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c072742a-7e3f-43d2-bc8b-08deb5386186
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:29.3436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZcZnn1AwqpjkbJIx8xOBiWwUWVObfTZ55nYEEWMDsybqIo3PmJKm/xse4wUGza0EFBPMBfwXmHix4gSWMH/8SxUaZytFIty7IX3h5rEASA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7794
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

