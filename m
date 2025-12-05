Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEA2D116F1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 04:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7A684191;
	Fri,  5 Dec 2025 05:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=issi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=issi.com header.i=@issi.com header.b="PA3cufVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA6E8418E; Fri,  5 Dec 2025 04:21:21 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A58684171
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 04:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=issi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jeyu@issi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELx9wTly1NONQ9HzlDfO+5KEeoTpRQCtmH3pnx827a+ZyLEAdkDZKRLDhIvcSEffvh197o32SzC3vUMxPwiP00rxXsquq1Y+C0gKQhNfFikUIadNK3pa0KaxVc0pQPahAMODkxujrBpCgt6x09c2swgLyf+m2ozgVN6a7SeL4v+3/fMLGWpggCZddqZ881g4NOSBqn0dwrQKohdRflJqCxe9A6SliUJ+ojoJuH+xv5V8i2ZmKAEAzBCxWHw1CfUHvUiDkChrila2LuZVU/v90zrivWVPaOqM3mrLj4v/yzKK0YGJxE/6IDGyjYm2pzOFZkRZGXjnTmtDhQy/aqObXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qUWI2hDJ5ollvnlPEWUow9sBJEh78PaNIsBryPCEqE=;
 b=BFaB+YIcfDbXiirBvA6OBuhOXXWn3ke/5IezGHmXBxBq65SHaCyjrwRLJpGhSsjqxV85VebLRu5+r5wL8RB7fLLQzVhS3GWwCyC3d5KoejXmi8XHGqpTpBvUf+Ml88FJb7fl+MKqtNO3rLcVvrt6mjmi0goYdyNWZ3NFkSjznFbrGmDyaSbchMHTWFBOV3pM2UOmXi7eJAhhROaY6e7MJ7/PxHbsr99ehyDoteWJGDMK9bah7uTm4b3Re46HCUJcMFofMm2mUiUggl/ZVzwmeuPzxkIV1CJ+8ctXFbi4MyhqWx9+BMn5JDgyeJRF6BZRt74bz0t4MYCi/7r7vSSNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=issi.com; dmarc=pass action=none header.from=issi.com;
 dkim=pass header.d=issi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=issi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qUWI2hDJ5ollvnlPEWUow9sBJEh78PaNIsBryPCEqE=;
 b=PA3cufVzjMyrrfqR0gMV5g9dPDXfmymW16ch6TME8LRsKc7joBuQLmeRl33mBVp803NZMCJHKBbmTMTeEt0zCYVjsN84M5IBGAZ4FIn6ny5k6PmNIODSo/a5nqbH5kNycMBLHPKO6b1MYCU7hYz2Hujba2Ku7HQQiVTyYKAaDTg=
Received: from PH7PR19MB7361.namprd19.prod.outlook.com (2603:10b6:510:270::22)
 by CY5PR19MB6471.namprd19.prod.outlook.com (2603:10b6:930:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 03:21:15 +0000
Received: from PH7PR19MB7361.namprd19.prod.outlook.com
 ([fe80::a7aa:919:7b51:2e07]) by PH7PR19MB7361.namprd19.prod.outlook.com
 ([fe80::a7aa:919:7b51:2e07%5]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 03:21:05 +0000
From: Jeffrey Yu <jeyu@issi.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Mutya, Havish" <havish.mutya@amd.com>, "Kumar, Love"
 <love.kumar@amd.com>, Ron Kalakuntla <rkalakun@issi.com>, Ji-Ho Kim
 <jhkim@issi.com>, Johnny Chien <jchien@issi.com>, Anand Bagchi
 <abagchi@issi.com>
Subject: [PATCH] spi: add support for ISSI flash uboot 2025
Thread-Topic: [PATCH] spi: add support for ISSI flash uboot 2025
Thread-Index: AQHcZZCqxVIdfNu8IU6FZ2Cs3XkydQ==
Date: Fri, 5 Dec 2025 03:21:05 +0000
Message-ID: <PH7PR19MB73617F02C51FF5AFFA7AC0C3B6A7A@PH7PR19MB7361.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=issi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB7361:EE_|CY5PR19MB6471:EE_
x-ms-office365-filtering-correlation-id: efc34b1a-c346-46f5-70d1-08de33ad5392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rs80ejcepZ/cT7DiSJVlAOy6XY1U0LPu6A5iSueJlcdd5v8oH3nXFKd4Z7?=
 =?iso-8859-1?Q?LdkZK97h7TiMa1uGpWtNMrx48+4+6HGLciDCqElmAP+tVEf/sxvVdsPOpM?=
 =?iso-8859-1?Q?sOGQQwpHwyLUQoxMe+/p9U9Vrqab1UQUXH6/vFbIjzdG2Dbk+JoHHF0HUS?=
 =?iso-8859-1?Q?B2FU8O+cX2YRDKeKZjJKhixA4MuZr15Mr8A7Zg+7to8uNFYffH/Fy7rJAl?=
 =?iso-8859-1?Q?KUExFgfVTxK4uosPabzayp3Ed3Gm7j0Embeduj6N/4u3I0oSDtn8C0V2aL?=
 =?iso-8859-1?Q?ChqdGu5yaRFSFZ84piYYjs3r5P3fHbVhmm+et7wkhEaROr8N4ITMIemfbt?=
 =?iso-8859-1?Q?ihGQcY6gQI18by8Om4/Ijw0Njrcp+nLxPU2iVYAHo7tnXBDjQh0rCI2MdB?=
 =?iso-8859-1?Q?GVr8s/3kH6FAXtBE/RuiC+wBGHH245P7oj/hHh4B7fdqcsYhXS1On75frN?=
 =?iso-8859-1?Q?kHI1k8yNCW7c9Ujqo/Gg/xoeUISpo7SxupB9ergeTLgHAIJ+LfTXYh5/Rq?=
 =?iso-8859-1?Q?5ejs+oLJmscLsR0Crhzq8oDl0evH5N+I7Y3DSHEZIAQ/KyzmYtfsfc1EzU?=
 =?iso-8859-1?Q?4lC52gDspaADxIu82nrWqVi3wExJANbhR0cfmmAgSaFObzgdbIKQSkJ3sC?=
 =?iso-8859-1?Q?YDWHQV4zJtSO/iqQQUPeDUGciobGWaYBxq/C3hh6HMXJOTidKCzZ9+k3Ni?=
 =?iso-8859-1?Q?+G+ygaEv1yAxd6rdMMm8+jdroH74tVGJv4aUbw++/8I4JmEHFsGsfKRgro?=
 =?iso-8859-1?Q?oAIjfjT2MvylCzBc+IFZLRop8Dx8uId6pF7CqNQCcIcK296ECW5/vwFkga?=
 =?iso-8859-1?Q?RfHgdPVPJJ1ZLUdgvh0V99V62w22ki+n7+yEa3EHE82ho+lOO7ZSCCH8f2?=
 =?iso-8859-1?Q?xRd5NpSl0/YE6e6KS3EuXMZSs+I9GdffsbLl97lLZsXibpaS4W43+241WD?=
 =?iso-8859-1?Q?jfWtCQJSdQygummWBH+W4D7LMYMeEy8Jbs1oLkmrVH2iFph/2K0ICq2a7x?=
 =?iso-8859-1?Q?wyPU+sTXaJzR8FnsBqeHHom1Vp2jk8WAHb2SRsxS6203r+HuIw46g7i7bi?=
 =?iso-8859-1?Q?mh/bN9gEPaEmjfbSXA30yLH7H3/u9zVKNbNI3A0NVRAc1PnoZWMjONEi9I?=
 =?iso-8859-1?Q?DZgxSFVifBK3evWy2zUEFNFVGLj1RSjQ5p8hyyvq4OGQ49cUs1y7mBpYr7?=
 =?iso-8859-1?Q?mDwOlWajhiSp6rp2opUXvL7iNJCv86o+14NMn/ffjlFyOACUZC2/gmdLkV?=
 =?iso-8859-1?Q?hmTjKI0sOHYy/f3E2swPQ08AkpsVR/k/A6IP5PlKCvWiHBQao3VUKcI80f?=
 =?iso-8859-1?Q?UKrcbT2OxB9imL8QGtmWXWxIjcKO+/AVd8TnFoepyVqnE88ztgOO+IcOww?=
 =?iso-8859-1?Q?ynE4UHrbxkFMVVIUHsmsmaq6cJRRi+uUemzCyMOpPGDp5Wn6R5VeowmIYs?=
 =?iso-8859-1?Q?WuFnroz/XehfLOfz58ostzACQuFIOc6FX7sgJYyOTIuHzHUZiD0s0Oheio?=
 =?iso-8859-1?Q?W7/40Efj8skX4j+tYp4osZ6A//NhSNdSXNnoUH7PIn8jsoZWPH58wN+dl4?=
 =?iso-8859-1?Q?6fm/fAJjtN5kQ7dRIvuS7JWvnS2/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR19MB7361.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h09gIPJHj3hyc26+uGPwz9clHZ//92V6NJszQaOSCJEySdFPY7aScxJN0t?=
 =?iso-8859-1?Q?VI2MJlqQGKE20Otg1KAH0UxNidUBKbOFO59COEgJDhsi2uphq0Okr7VUi0?=
 =?iso-8859-1?Q?j1mLR9GKA0DIMntRuZG/exDdKNyc/++YfwYNkUjT+2M6tgjO7Xtdz9tgLK?=
 =?iso-8859-1?Q?ypkxhwKvD7yNTnC9g44khvXocUalXqsAjBYxR3XxuIpMm/1MPNLa6BuTq/?=
 =?iso-8859-1?Q?oSzUSpy26HCvpb8RydKeqsxzn8XmekM7YSofoei7kPOqrvZawRksqRQp22?=
 =?iso-8859-1?Q?Ym65eh2gLNioE49rZQXBQOhw9qGERU5SzAQApCfPxt8dFerjjz+fCL4BCw?=
 =?iso-8859-1?Q?6ZsE+6wpPXVA9ONfA7ZeAMzdcG/6dyDWSWgfJdHKG+QvZtJUvmTR+tB4pv?=
 =?iso-8859-1?Q?At6ZqXZZ/WfRL1n2wBxH1kL88HWjq7M2ig5HE+SipQcwgL4Hdph9uUgWB+?=
 =?iso-8859-1?Q?V9x6Gx/2tasHJgrgNcpH5d5ziIIx9bjFkXz/aN2NWAlCeyqXmN9+0zpGO9?=
 =?iso-8859-1?Q?PnOd9flFIxBwqGM26vn2ULkvotKES1XyIXWVqQEzMXH3n2H6EWaMj8Few9?=
 =?iso-8859-1?Q?35fHLXw7Abu7+ZXPqAZ0uspwi/6Rbvp+mIVBJg6pcGJl54fidzBZSlHZyl?=
 =?iso-8859-1?Q?HZ3/Xptegp9p7AWofcF9jNRlLjm8VxHHG/sCwFwRL8oj02G/X9VP7O4+Kf?=
 =?iso-8859-1?Q?+m8T1ZUSFZP4IfMxec66RdvYKo94ghxgY7OOGIEJQh5DAOOd+1gIWVVp/C?=
 =?iso-8859-1?Q?46iRG3Dl+8TwACcmg2xw4Bf7K+j0T4wHgEnnOGVeZY4R27o+jBhsGxOgJf?=
 =?iso-8859-1?Q?eADHS65ERTXNJmHAdc9L19G/BN0TsowsCpunoXUNYmIOLUdUXMRpTjWJ/Z?=
 =?iso-8859-1?Q?PHgv1wZTFMJ6Gg8PQVtI0w2/7LVLMzyUIz+MC5symeAAKg4szjJmYw0XuE?=
 =?iso-8859-1?Q?2JGDzfniwGsGNg7tN9AV9znTTWo925+Ger0FgA5Hs0LYG0kdp77mefCyko?=
 =?iso-8859-1?Q?mmDSfO+o+tdIlKO288QadTBrgd8XiCfRgX0xobeVOMdY8oSypkRPxYzIPM?=
 =?iso-8859-1?Q?ZDr9+gVJEaG8E+cjXju2h75BvEO/SN+hcr13lhm2N6jR/crZFngd5kEkpm?=
 =?iso-8859-1?Q?yEuZkGqegbSul3xQsYpxYCoJq2nbT93ZEnNqwHvpXdyHTQK98/awRDddXI?=
 =?iso-8859-1?Q?VffC3fgV1a/3+xkMOgP/KyirIWlOVf+Zm0hmMcJN7kV19NUCUpgpfOi6Zh?=
 =?iso-8859-1?Q?vBXTfYQZO3cZF1waT2V++lLMgZuFqgEgAwobAhEGqccAZetOlNEYm6MDkY?=
 =?iso-8859-1?Q?ZUA/NxukkNM/bLYUrvOh7w/+U8RxlHrz7xVRXHNetxzVhMUdaADSSuDXRy?=
 =?iso-8859-1?Q?xKQtLo/cmvdf+hMUxV55UX6U8eF8LsCcNGKkVWpoMmnSWG5xxppTRfGwbA?=
 =?iso-8859-1?Q?EtraBV4Pe0ikU/71T8AQYYYzFTLSuOSgb20NlHslZtygmnunf0r7zgVRnl?=
 =?iso-8859-1?Q?Ufofs/iv40m7fheNLJWD3OTCkqxbbydk2WW/3C9qJnKEx741Y0rGlBsopP?=
 =?iso-8859-1?Q?+e2AV/MrGlakJjhcCjOW6xnQHpUZPyuya0VsqLX0dgAtyBqLXBOcKlzDid?=
 =?iso-8859-1?Q?w4PcMRncfGnmI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: issi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB7361.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc34b1a-c346-46f5-70d1-08de33ad5392
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 03:21:05.7376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6af618fc-4f7d-45f1-a2f2-8c59a26d2c10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYU+bI3J20XV6kFR1XF0siKOT3FAaRXkMwlULYSS4KuNQr+bk/p+Q/yuEbNpRwud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6471
X-Mailman-Approved-At: Fri, 05 Dec 2025 05:23:59 +0100
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

Signed-off-by: jeffrey yu <jeyu@issi.com>=0A=
---=0A=
 drivers/mtd/spi/spi-nor-ids.c | 26 ++++++++++++++++++++++++++=0A=
 1 file changed, 26 insertions(+)=0A=
=0A=
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c=
=0A=
index b4221a82e01..c6d65196ebc 100644=0A=
--- a/drivers/mtd/spi/spi-nor-ids.c=0A=
+++ b/drivers/mtd/spi/spi-nor-ids.c=0A=
@@ -222,6 +222,8 @@ const struct flash_info spi_nor_ids[] =3D {=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_HAS_TB) },=0A=
 	{ INFO("is25lp512",  0x9d601a, 0, 64 * 1024, 1024,=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25lp512mj", 0x9d6020, 0, 64 * 1024, 1024,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
 	{ INFO("is25lp01g",  0x9d601b, 0, 64 * 1024, 2048,=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
 	{ INFO("is25lp02g",  0x9d6022, 0, 64 * 1024, 4096,=0A=
@@ -239,6 +241,8 @@ const struct flash_info spi_nor_ids[] =3D {=0A=
 			SPI_NOR_4B_OPCODES) },=0A=
 	{ INFO("is25wp512",  0x9d701a, 0, 64 * 1024, 1024,=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
+	{ INFO("is25wp512mj", 0x9d7020, 0, 64 * 1024, 1024,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
 	{ INFO("is25wp01g",  0x9d701b, 0, 64 * 1024, 2048,=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
 	{ INFO("is25wx256",  0x9d5b19, 0, 128 * 1024, 256,=0A=
@@ -249,6 +253,22 @@ const struct flash_info spi_nor_ids[] =3D {=0A=
 			SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },=0A=
 	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25lp010e",  0x9d4011, 0, 64 * 1024, 2,=0A=
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
+	{ INFO("is25lp020e",  0x9d4012, 0, 64 * 1024, 4,=0A=
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
+	{ INFO("is25lp040e",  0x9d4013, 0, 64 * 1024, 8,=0A=
+           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },=0A=
+	{ INFO("is25lp01gj",  0x9d6021, 0, 64 * 1024, 2048,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25lp02gg",  0x9d6022, 0, 64 * 1024, 4096,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25lp02gj",  0x9d6022, 0, 64 * 1024, 4096,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25wp01gg",  0x9d7021, 0, 64 * 1024, 2048,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25wp01gj",  0x9d7021, 0, 64 * 1024, 2048,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25wj128f",  0x9d7118, 0, 64 * 1024, 256,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25wp02gg",  0x9d7022, 0, 64 * 1024, 4096,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25wp02gj",  0x9d7022, 0, 64 * 1024, 4096,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
 #endif=0A=
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */=0A=
 	/* Macronix */=0A=
-- =0A=
2.43.0=0A=
=0A=
