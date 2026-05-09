Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA6CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E0B84D13;
	Sat,  9 May 2026 13:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cIDdEDm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EAA84D0C; Sat,  9 May 2026 13:12:19 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A195084CEC
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THh5jOvPuwvZsdebQzB9GGwdLpIpf0uBTVjEYLEqPwOhDmB/mhy6qOXC0ySkhy3aSoheGG4L2PYfsBoVbudIc1N5o3dJ+LuHFZG2/N9jgmaRgdjid735NWtOHrt2yV4L51JWC5ZOB0BEPfShzf8aJ3klsFoUXjQi3Zug41EbN/O0Hxx5a28m30CXbdnBD77j78SorlIuunaEuTyhnWsctcZmsEcHA1nue+f5z1SolTHkpqTQsSvxEIKdbwHsvG8zAM9LN/5WFxPORwxY/i/1VDDhR3hqbgjBRLg2kDZ0dYDfr9M5sbCRjNwsO24AVQmr+bj/MwUDqeGai5AhkpnAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMseN64sQS3/akme9GC8k6TTFuD1XTJQiYv7y5TQt/U=;
 b=aUdLkAGEypdx0HuBWiVo43kEvpY1Fs2N7dobDLib5yLI5FjRckraN+HmjMilTsaPz7EHS6FGSTOc0SUqQ3vAOl8oyF5YDFhTyiQvISR/ES5vjxEd2XIagq1izx15fiyf2sYjx+tTKd6UcTPL3cUIllZ3yf9nj34418grWPFUBO75wHzdR4dJX36+C3auf6OWO5rA7oYFRpZek5JT/H9qx0yHkEgaIOx65VwaNjeY+QwjgzP5RiUHuRDGqlOilVyDUZwZnPmUu/9MWW/Y3lEq6e8aeSSnVa4Ml5jfQ5KgGTYDVzdtXipV1s+n+3kMxnKza0mLPcSJfBU7FtroGwUKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMseN64sQS3/akme9GC8k6TTFuD1XTJQiYv7y5TQt/U=;
 b=cIDdEDm0n2BoLWvOCfOUm/6SN67JE9CrxGKvkXzaVxU5JoKlbcR6tQLD+tzWpGkmTXTgTfYihnExrPNpJ/Lsknj9U6MNrld7xQqueC3kWAF7ghQoG6b3xK0QYslIP0Y1MpXntQWT1S3p3yO/A5QX9LVz6aZZ6TS1G8P8CcdcoziXNz2tPsbPpjA83hNUaSDHlWTSy01dDK551WdoO8fmXIrrBPA9XAIwgmA+TWbNPQGgG7eMISWKPlrU2WOV2Qfip/kJnjAqpY9u25hkdGviKQWWH6d0iC1flzeSILE5ljStObqcRzgex/bZKpPbENiXQ3qImOLrf4sFclGeAg0ZYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:15 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Crt Mori <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 03/11] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Sat,  9 May 2026 14:11:49 +0300
Message-ID: <20260509111157.4039434-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: b51488a8-0472-4232-41a4-08deadbbd360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|3023799003|56012099003|9063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DEKxczSNSUi8zueKbFbjyLBcnXbYupn4UqdK1aItX2EEJYG3qAWshAhKcpSbnfIo8s6VsejmQNYgXPpalJ48CpVsyi9jgaa+X85CGp51LxTdSgS9IQcMAEc6drbWb/Xahp/75HMASd0TeDqJzJdD2SO6h4v6yDU2fw6kC2CXcqiPkJAr2Add2wlwJdVMWd5e2eXvYEVwHySZzXM+ZsgU1rMcJsQiRLWZwJmIXVIUwrMPpRQM5pPGQNjRI3HYgIfYQzWjRpjBK8rhz417RUye5Bt+/uZ45hHAWh+giT7pN2nUMoeO4kZv+zsPktksWtoUYkjXDb7m5B4bcceYJp6GamC25uWhI/jMsYIUWnYYAaHbXkSe6cyF3L8ZpbyMjP10eON/DppuiG4WbT2IHqPepDkGI+lBFKLBJ9Tzrh/913KWqVjvHe2uSnlXH5QJGZYGreEuvu3AiHIWDbbV6uXVimHRFsKyFNyO2nNpmqpq6IlB1iAxNYCzz0ra8M8xx3Q1wm1S86lZey0xu1o6ATOZ792gTmfSLMOboS1RX2ecrs8CG7k5ixChDAey00rxCIymFi+Lj+oeZO64SvTTWodttD19MNK7Lu1X8fwUIpYZvgwY/0Se5YgrMyL2lpHDkupAA1DCWFpN/ksFQt0rmtQd8UoQs5p/6Rtz6DlXofdptB7GCNlRsxrNIzM/nSHfyfJtc13R/8d8BcbFFdwZr8DuVeBF0sjblDADaRnXKXzv0oiHqny14hIj68j3TlLoRXH1BLiRuAhCmmuxdSyQsR4Ybw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(3023799003)(56012099003)(9063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJFbXlyN0ZFcStiOVBkU3ROZlhFZVkzY1JHSldOK2ZEWUlBL3RBVnU0eFNz?=
 =?utf-8?B?RERaa29tcE1aaDUwY2VMVUhzZHlENk5CWlVIeFREZnhGem0xMUZ6UFlCd1h2?=
 =?utf-8?B?VHYzUE04emcwWXB6SWczcm15VEQ5WDVWYXFYNTcrcE5OcWhZWkZSZERRU1Vm?=
 =?utf-8?B?OXpyV20ra1lZaXFMY3VYd1JiSTF1aUEwdkNSMlFmTVg4czdsOFdzVVMwdnAz?=
 =?utf-8?B?YklScVhDOE9rQ21SbHVwNFdxVlBSNkQ4QlcwNW5DV1QvSng4Tm03V3NVRkNC?=
 =?utf-8?B?ZFlURjZWUDZZcGU0c2xZeEw3VFFuMnJ1bCtKRlNYcHRJUWlCbXQ1eU84bFVI?=
 =?utf-8?B?eDJjUnNIMVRIQ0NVOGUrSzhITjZTbFUydUhOeWF5L3pYNVdScVorSUt5Znh4?=
 =?utf-8?B?amNpUzRtNTFGSUZCWUZkZHZ0UzYyMHVuekVsVkR6K1NkQjJQL3JucDlKWDVw?=
 =?utf-8?B?TFVrZWNscFZiSzJweWRtajVyQ1BEZzFPdnhrVXd3S05JdDB2RGtCSEdtWjYr?=
 =?utf-8?B?M0ZOZzMwZDByamgyUVRxaE1CZFV0MDBVaGtOTU1Td2kzWUVLclBYQnR2cFdY?=
 =?utf-8?B?R3lDU0NrTlpPTVpTUmVzWkt3MnJybGtPajkvT1RNOEFQc0lZdUgwdU52cVNt?=
 =?utf-8?B?YUVkWjRwQzZqTWpyaFhCNlpaMmRNOTArRi9PeVZnYk53aXl4alo0K0M2djND?=
 =?utf-8?B?M0U3V2pXZVpCU1AvaURwYU5DdCtWNDBmMEQxSk5YemtaMUU0bXdTREIyT0pS?=
 =?utf-8?B?R0JXNXhEWlNyaWdPMEZ6YlBmVXVkZGIxYjBtV0RpMW9TT1R4VW1VNjlQbzdK?=
 =?utf-8?B?NFVuOEZINHBLTi9YbmNwZFRUZndzQ3lSM2gwYVFXaTJia2tVQmFXSGZCUlV4?=
 =?utf-8?B?YzBqYzlEdWVYUVdkMEFScTRJcGRacU15NG1rSWZheDJ0K3RZdjJHdVNVcnpD?=
 =?utf-8?B?MEpEVkFrV2VVbXZUdm9sRlYwSStLa2JrSTE2c1htTTNsQWxxdUFsQzN5VXhR?=
 =?utf-8?B?VVhOdjBCOThrMmNoQWloVHVWRGxPVFp1M0RWbUdObFdPWlhwTHN1TVVxUTJL?=
 =?utf-8?B?VTJvMXdqTlA1emljcWl0ZWgwQ0w5Uml6RFRDK0NhY1BURmtPbFcrVjdpL1hr?=
 =?utf-8?B?NzhVZzJHb2l2dnEwbGJvYmk2M3VoQnY0UWVJMU9JY3ZiWnV6VmJ6cjZIQWxJ?=
 =?utf-8?B?eEtreEphOW16cHRIWXl1Z29UKzRYME5teHdqazZScHMrdkUxQitQNzZUWWhD?=
 =?utf-8?B?Q25QR2pPTFpPdUdIVFVEbDNBd1BNTzF4TjlHajVySi9FMVExSDRFQktQK25l?=
 =?utf-8?B?ekFoSDJZa1JKZHZOR1IrOVQ5NVFtQ241OWlFMDdmTDFDM0ZjazVQSjF6STBl?=
 =?utf-8?B?L04wZk1VamVjTHI5NzUvZS9KR3JvUHppTEZMaFZ1dXdSQVc1eHIrWWdBWWtw?=
 =?utf-8?B?UEVLUGUzNVQ2RURLSEwwS25ONVVHTERPdWNvNy9xYUhrZXEvVkszRUxDNmVU?=
 =?utf-8?B?QUE4QnVzVEFjREFKV0QyMnFpNG00amVJempxSEdJV3BFMnlzbUxVc3ZGSHZW?=
 =?utf-8?B?UXBYbGlHNmNDUEpDckpZYVBDZTJ2VDVvL3JkQlNJL0t5Mlg1WXBvdjdtcUdU?=
 =?utf-8?B?VWRtRmVnYmdFOUtMN2I0b05lQWJuUFFvTmttR1dJV1ZyMVJ6blFHU29ESSs5?=
 =?utf-8?B?V2xxL3B2UHk0TDM3KzJiWGpzM3lIR2N0RDQ4dmhoUWQyUTlRNGJjRDU1dXIw?=
 =?utf-8?B?M0xIZEdqMGxINHd5Y0c3b1lmYUh0Qkl6YUNwWVNvVG14UjdWMTdIaHdzWVJO?=
 =?utf-8?B?WWlTQ2xRSjZONjZxMXRBQlNzMjJGaXllWFVBM3AvdWlqQ29EdzdwU3hBYW40?=
 =?utf-8?B?QW4vVWlkcEdpRmQrWjErN2JYQWRhdVJaRUgxblcrQzY0TmJNUE5Veld0ZDVi?=
 =?utf-8?B?ekxIZFIrV0xuSGdOTE9ETkN3Um9kbUZSdkg0cHBVcVJiTFp0VnNHVHlWb1lk?=
 =?utf-8?B?L2JwaFI3eTkzUHVFS093eHZlOWVmd1pjS1lmaWNOZHZ3dW1TY2FaMUtkMm5p?=
 =?utf-8?B?dmEvemNRellMdS9CT1c0NTRVYWdEUmRDd01TSHpUWS9BUngxakxKb0NxR01U?=
 =?utf-8?B?akJRTzc3aE9KeGkzWlBodUxaVDdlMlZLUGVTSFhVa0hzeVU1VFR5K3dqQ2xa?=
 =?utf-8?B?RWNpWEFWS0trcXI2MGZQWjg0MEthMlQ1b3I1RlNzYk1pM2Z6L2puc2NYNTFT?=
 =?utf-8?B?dkV6U1lvU1o1SHZEN0VvU3EzUnRES1crRlBONFJqSFJReTRpS0dSMEJxNVR0?=
 =?utf-8?B?eDBkMmtJUHRHYy9WdUk3RnkxNmxpckJOSzJ5VFZIMis2Z0hHV3VwUENUTG9N?=
 =?utf-8?Q?7c9UoJNBWubUA9qY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b51488a8-0472-4232-41a4-08deadbbd360
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:15.1534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jC+3dpbh8zfjPOuBXRlnBu2VO/zeNB4YVvJcoCUX6IM7E7syh5E8FU/hb0WV9yjTCLfN+coxPs0dmzE9ubpE49kWDJ50Ul1Sq4o4nQ5RBzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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

