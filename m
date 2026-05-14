Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD65CD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED13C846B5;
	Thu, 14 May 2026 04:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="U9PUzs1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A2E846AD; Thu, 14 May 2026 04:56:04 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCA3846AD
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcQRExD0mrVGxS1QmHQycyYoCc2DG+CfS2HiDDY4zrVQNR3vtyNRNAADTvXCSBx8FjjyO1hxm25I5M/UA1Mfw+8Jr0fZng2yLd6sGVLxsFXQxzeXqH7B9uaOkvUk3mqqW5G8ifUu2QtYd2jZauUUeMiCFRRjSH1PkBFWRfy7eNIwYenZHwBhx1PBxR0ujCuNzooa7w+OHIK1D82dXs4pvMtkOMTGtRmr/1PG8abJryh7b7GoynzgLfAYOzezlsAlJfRsgBn5tnazD+6fZvoJB+HJBNKORDbM+VpMu26GRE27loJDDvXiZ3LDSLdojbzsk6rZNFF/3lXGVSH+ZXwDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=h/TFZZkV5KeAevlnQEbb2GJcs0eYMssGy3P3Kw0HBd+vCi3fN/xi+UB2tcVhcdIHcZfAmQEjFjWPHhNuXWGgp09EjXQiwYoY5Qix/Ij2XQUql1WGJRU6bz6czVM2HKRkpyHXyDrYCytEJXkO2viz3ki3agyuZt/X7B0mr8nVjqJB86ZyVMi5CQ/Kf61YiU8jqH1uEh0LyO2/mkkFlesnx6EaWx9T7H+tukD74D5ufCS8JHzNwXrw/0j6T9veN1i2tsvn0WgsvprjnEoeqoMDzAhzqM//1IoabW47jrB+j0wSJaYsiVzoRKEIoRcG5u+BH4A4vbdnajruTUkii91hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=U9PUzs1QYPVX0ApqQQwSeVk2q6Ih1ZpOxsik5oVnJrTtljDAL70byELuPmqhzb/PgaOyUc7FUps/oj5CQgeIcnhPqAlRU3060Fh70ZPP7Jy8UtST89BRyE0ucaNB7HJrA7Frr1QyEcpBxIDAnciRgKa5kJ/bFI0ER5iRvcWRMjkVBxEMzpu/QDEsWmRJqYQm6tQZCD1ePAaejUzsXOJQu2QdpxjDtGL7QNPIk8Y4zHI+JzhgrIJkFIQj75xY6HmwfGSomhDT9IU/k0NPmgtgaVUuzt2hzjwMS5aRI7RSPauk2f4fPaS/5GCWNIPVOckIyh+opyHDXPBk106YNeBKqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:55:59 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:55:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Yao Zi <me@ziyao.cc>,
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
Subject: [PATCH v6 03/12] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Thu, 14 May 2026 05:55:33 +0300
Message-ID: <20260514025542.398469-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d39eaa-33d6-489c-88b7-08deb16453cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|3023799003|9063799003|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: hVmY9BrDKafIQGvA5/enzg0hgLE84WWxYb1SI/G5NScDiEtsj5LT4lS0qwsayhrGV1Se8Qb9/5Kc+o25vILCI5u6illKqEWcqWhRuSvg04yyEK/UvDD0AdTVOA6DHWElGSqPo8WMjoBoAQWpYNVYsUrc4pIy5Rj4M0BtJI3DSD823z5evTtwwUqP1l07x48jS/B3jCWt2T/Z2InZyo8KHuNHYPIzS/25dBMY5iPWDcArnK6Vr0/VSi1HJmzl3gGrIRrsTunDDOXCEwxPx2ojHkHrCAWtNH1OTPJRFGgn7LNqUYPWKiSsHcdKh+UxaV8xs/WltQWYDV2Rey2nhcTlYWxVJGEZEt8/DtqI9QvNfkxgLrRW3ZzyzJdupNbsBJ8KQ7ivYxd1LLd5FrpTkCens3PqwvhGDuC763193m78sGTha6QpjDIc1FRYvkMIMk+bPkLdXaeC205LXqzQXDyWoiTLaueVAf+sDbVkDmFsLh5FZILDRpWGBmO1vpt4cnNcMxErWMWdl3G2W/k6pb8oQENV4VjlKH7smhg6S7vUzT4BHO3B+2v3tX1eF1H154i4QLiIGLyUGqj9gG1nqzUWJKNy9HC9+mEBJ6iJKWpCY10og+1C/wuCBwwk3S6kayzFBhIGACIfr8r3qZGfgjxeEmGjo31g6vYGAUgf+aGyALN1hEyh8s2oO34/hVQ/FJbzcQU1Zte8FoYV+Tc81lPnrLCy56m79+Ug3Z1x5zPKkK+eq9bsVSIQZ5sAmM8R/P6+JoodDTnJy/cg0qvs7ptxzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(3023799003)(9063799003)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXIyMHp5QWZVZlFXS2N3ZVUvSHowdU1UVlRFSU1abmdDamoyL01zeUh1TTB5?=
 =?utf-8?B?dGliZTRSdkVSNXZrSGF4RE5qcjFGU0hMeU1zeEh0aDFka202ZUN4OEo1alAx?=
 =?utf-8?B?T1lrYjFjakN2dXZOdWphT2dnd3N3TGpZQmF4dTJabFNVNk9NYzhVRDZRN1h1?=
 =?utf-8?B?OWtGUEVrQzlSbVBSL29MZkFuaFc1MVZDZTlFOE0wUzU2bWZ3eldORnRVMHpO?=
 =?utf-8?B?K1VJZ0hYUnM3NVlhTXh2NVphOFBCTWtnSER2VUkvTk92M2FJdG5HK010ZWEw?=
 =?utf-8?B?Y1YraTQ3YXJjd0hnUGYrdU9XT3BnbmZnWkNPUG9LNzQydkhpLzE0cWl1bCs0?=
 =?utf-8?B?TFZ3alBLa2F2eHIwdHZPcGR2cE16WmJoZlJYWHllMmtKTzEvanRTVnpUNWVS?=
 =?utf-8?B?RTFaMVBJejJlczZ5eWRhMmt4NFJadWUycG9BOUFpaE8vV0hpZjVPbnI4cjhG?=
 =?utf-8?B?S0hkbHd0aE5BL0xTa0orcFc3ellzU01HM21HbTFGSkV4VVJQS1FnNFVwRzlC?=
 =?utf-8?B?TWJDalVaVlVrN1ZLWFArR1Z0dENIczB6VXlrRUhTakhERkY4TkllcmJnN3Rl?=
 =?utf-8?B?cEhDck5oaDFRT3pLeGtucjJUZEpRMkc4UXRBZ1VzNVhJM0g3dWJxVnRqU1V4?=
 =?utf-8?B?akpHNW94eUVGSmcxUU5CaXpFR3lhUkZZRTZiaFhZcmg4MkxqbCtxWk9OaDlt?=
 =?utf-8?B?Z0t4UUhhL2YzRGVTRllqUW4rY0JEVGNSSGJxWEZOUi9icTZ4M2VnejkyY1ZH?=
 =?utf-8?B?Z1FCT2NXTExTS1ZtRExxcTc1Z3IvM1hEeG5nSTlyanpNUGhwaElPRG8yK3Jx?=
 =?utf-8?B?UFJOM3EvMHlhV1MxZkx3cmxGOUJJcWpZdkNUamJVa25wUTl3V2Npc09YQjVL?=
 =?utf-8?B?SnRZblQrQ2w4eW0zdXJpYlFWMUlNaGhnVFRkMlJOU2VzcW1rMXVFWGYvQ3lJ?=
 =?utf-8?B?RlNZTVlVaDZDSnRSYjFhaHUrRkNIVFZmZng5SzhRaU5hSkVnTGUwQkU3RXpE?=
 =?utf-8?B?ZExrclhUQUFmcHlBMURvZlh5eENLVEJHR2hwdzEzNW5NQVJFSGY5MzRBTkt5?=
 =?utf-8?B?MFFaQmkrTWdNakVwVFlpU0RtSEs3VnJlOEo0SzM2RGlvQWY3d0dudWRIUnAx?=
 =?utf-8?B?OXFIdkVMQkN6NTZ4QWtENHp2U1RwaVZBQVNYTmZkSURaYUgvQ0g3Ni8xdWVZ?=
 =?utf-8?B?QnlJeE9KWCtFWUNNSUhkTWV4U2RLbHVWOWM2N3JOQmV0a0RjeXFDY2ltL3ZK?=
 =?utf-8?B?R1BEVzYxQXM4bGwvVEhJWnpQN0JjTmFKazV5VjhZeUdkMDhPU2lLZHB6eU1C?=
 =?utf-8?B?dVYrRzRpWThsM0xnWGI2MzY3Wmc2enVyV2dlNUZXOWw1bWFSVllpemdsZmlI?=
 =?utf-8?B?QjVWM1ZVWEhjTWw4OVFTWEpnWlFQVjAxdWFkV3RTakhYT1pYQnFvenNBT1dt?=
 =?utf-8?B?d2dtWHluVzczeGRyd0d5SjJXZlJONGJKZTFlWkpYSmZ6ZmR2dUgyakhzS1Vh?=
 =?utf-8?B?TkhPYW0xR2dMSjF4R0ZjRVlVSFZXOW0yVDE1elpOcng1RktFRmVWQ3ByZmE5?=
 =?utf-8?B?UEcxU1B5WjhRTWVZQVJza0dvRm1jY1FON09pb1dzUWQ5K2dsMG44M3dpVld1?=
 =?utf-8?B?b1lncFlpZ1RJTzBsMlQvTUpoQUNia3RMQU0zU09kcTJCNjBvWW4xUmpjUjhD?=
 =?utf-8?B?dnlLRkFIWTRpcWNHZWNVdEUyRGZHQTd6UkQ5eVpiMWt5akQvSzVpa0p2bk9j?=
 =?utf-8?B?VVY5RnlBZk42aFJPWjR5R2xLN3pJRUhwdkxQcHlkdU1DTkQ4cUVlWkFCNGZO?=
 =?utf-8?B?cGxabkZ2eXZjM3JacE8wTjVDZis3eW1xd2QwQ3JlaU1ZRkQrL1hTZ0dYc20v?=
 =?utf-8?B?Sy85K0lRbFhzaGZVQTgwNUl5VzJpeTJ1OE4vNStSSU4yTWhYRmVzZkQ4MTA3?=
 =?utf-8?B?MDVvMDNXT2hqenNieTVka2x1RmRFejBVVnI3bDAyWjd5YWxTOGk4algzcktF?=
 =?utf-8?B?bXBVTlZXQlplYngrQitVQlNpVHZIbzgySFN6ODZ0aXBWamVqYW16bHNHQ0cw?=
 =?utf-8?B?R1lkV2ZZMExuT1V3dG42Ny9URU5wQzF4Q0VWWWdSTDhteFJNcWY4MS9aWjdW?=
 =?utf-8?B?S09veVYyMnYzWVFxakpBc3VoQmsrSjh6NzlnQVlYb29XQmlzVENOQy9CMG9y?=
 =?utf-8?B?RVNvbHQ0cFpuVVRHUjZVbjNzcW9STzVHcm1saXdrY1BXZmhxV3BjRnZVcTRQ?=
 =?utf-8?B?a2ZMMnVLeElMQnBKZDJWK0thNlZTNFYzWEVodStXb21xdEpRZ2ZlZGFvaU1j?=
 =?utf-8?B?OVF2L0VVRXQ2NGpISEoyc1Fialo4Y2ZSZ0E5Wi9jemhLei9QeFlmMElKMWFj?=
 =?utf-8?Q?t50Vr/6HdZTN9YzE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d39eaa-33d6-489c-88b7-08deb16453cb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:55:59.5340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfFbCtxcqjtzwcADmeHB+tol10kExfnmgwhJLLAtC+1vuObfilJrFYHjx4/YJAXl4hEMbu+Z1EL0xe13FYlPZKfLSegHEjgeB17HjgxPO3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786
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

