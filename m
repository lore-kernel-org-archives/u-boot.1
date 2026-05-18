Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD1ECD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E746846CC;
	Tue, 19 May 2026 01:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PCud0FfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20FBE846D1; Tue, 19 May 2026 01:51:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44801846BD
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN2Q7FKK1VuUXW5NMoUJGrBpzU1NczPQJKdL8udehfnxLlCycwMe1K1D8gUHAapPxHZple3NClEvg05GG4jx17yEc12pxIUDedZyqKXKhPfVXBRqeQ6XVxL7EJrtd5VeO8JjJp4Mh0Aq85MXlp+fmKYVIExCHgj4e3xIcO6q77s1NUINPPG0mhEWIAZGxQ2hTaqkGMjLxfkbr5LDp+Aaidesw9mpQJx4dT+wkhlH61RPfdbCKA1wnU+wtYmAL0asX3Xgql7c6B9Im2OlkaFBQZSaD1xls5svJaNAefqMq4RK5nAtmcI23333XLckfTepFxXcLgkCD8wg3UtM6SR+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=SiMUDhbSNDl1I5t4Ty1FxaaIPw85aSegv3owOdSpDc21kzmX/QUmnW0X8Ls7Vn4LOpbYmz3hdPa85kYXme7j3Zws2ruvXywmRD2n2jOKMBK8lpsnj+rVX02hrrQ4Qg0naCyKnkt1uIrUFv0+Jfxpl8bGxMLCxqgTRrUxy4VVaUkHvzF7OtoiVB1avMlfT/07+e0D8rR5bagmiW4W86ilGbePuJ+LAcDSd5Pyh+ibHNAw/KhDOXRq7s8myA6e+crlPF5ca7vwteheDToH7gvO5Rhbk5n2ttuj3ZCX75AXHQ/xpHfQvWgCU6gXijQic/8b6BJIcPFXM0KxRVCshMmsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=PCud0FfN/6KtBGCueNgcDetr6xQQzbrvJSEcaGaZaUsq6cR0hKhbRuCaNmTcqYjIZGZdqCgce78xUQCEUkC8Xewp0VMLvoOyT/a4Wd+D0ovNDsDgfi5OhOZM1oUA8xzX4RLeuuHb8+NUWCLZNM4WMXyGfAVBWEGbFEkJROHZWaAi1y+OZHQLJND/ppjL7Zp9lvxoi+OuetpX/4jAzHXEPVWMnPNqgaZMT5ctULDut7y1n2V24Oggj8wlMdPbLEZk9QX2cGosTfUWzHyFe8UpU3lw8JB2DI4cttZdu86Hg/3mWK6Yst6H8l0ZRt/Qr3DGW2NE4N4s+YCgIO0rxRNGzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7794.eurprd08.prod.outlook.com (2603:10a6:10:399::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:25 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v8 01/12] bitops: import BITS_PER_TYPE() macro from linux
Date: Tue, 19 May 2026 02:51:04 +0300
Message-ID: <20260518235116.2664557-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: e34723f8-bd45-405d-8b20-08deb5385f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: aMws7+FPjEjKG3QJDN0ikCyYc6m7NCIvwua33mB/+RPQ2QIkx78aAwZEbKpoMbqlDoPSduqw91uuMYbYig6gDzXt9X6OBsISwFVSjaaHE6fYSpe7yeBoUk4djnjGtp9HB3Mj+6bPFg+WtIeIV18jDW7phKJLhFTdhPu87XO/s2oTxFGEX0wMNp0Q6t+25hkZ+GBBOE27+u7Oo6RbdMaH9PEgicP56b8aMQfPCNnQTT8ptRBAj2Ne9BhQOI46+9vzb/XsFKrI0OWZ+uXkqbo2uo3IcHSsXvuuJm92fnEnMsDshr3UCMVd2wisjB9Z63WQABiKRdqUx+LKOpr/tBOUzlqSQAIzFtWvhxnXOokPJyTRQBlzZKDLWUZ2XtOCWdX02RoAIWdblv+InqeD569wX8ce3hB1jx3haJts1DEe33aeJAKgEQLm6oqSvwkfanXQO+XyhOGmAVxJKWLHkV0/pyp5F9X+MqiRIT+LtrZIUpTlL8esC8VO6+DXdskOHU8/47GEoqgsnEfk9HrwCUSrc8vzn80d5Ho41iJ66/IlP5T+jq4UPs4y52jkHzB/BoYAW2TiCaqvJ+mWFV6rLg6XLQaS4q079KzM3QR5Sy7SU1sZukVtuZhcmEKCuu9E+tcyaRZkyRZ62/uzbD0+mQAoTsGiTf3CThVrvJ5OfqpbQN03VhALr+sL3reQN32K6QLO6dbWusDMvh3JZo8h1RCYshdcoYFpSQGjeRmu+nNf/7zFBkyoIj6a1tJ4UV4u5MtJRQeJDOJBfBesOz5BCsqiOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hQ0PjV/4wKcsMpFuPX0v6IGJmy24AeaVei0Jss6DmxxC1ixkf1qfyXIVT73y?=
 =?us-ascii?Q?rKvtR8YkzN5Roo6udyNYLTr+Oi4GQobRStd5nlFEiD6gthi30GVrKZS/PkeN?=
 =?us-ascii?Q?O3KDzbgdumi/iANfwkDd2kz118O7/sUNvwgYLViNmAl0+/fcT1tqFtfT4jA4?=
 =?us-ascii?Q?rH7pFI79DeUnfGDZG7rdQrasNJMqiPCJ0gIQWCc1YD32UZcUa4J6rOkbN/zA?=
 =?us-ascii?Q?QDNzGoonsMQwYxj/t7MMtf9pjBGBeKqWwZsxRVDwXUbz5mtahdaa/qJO5lPr?=
 =?us-ascii?Q?x2fMJ+CDFYD5Fmecv3k5emmJGIQpXhVrs0yO5aWrpFM67mSgnEpbNbDme+kb?=
 =?us-ascii?Q?N3fS4esvtZZX1OEpfb+uHeiLm5N1hwT+0XvJ7dFKv+J1AzImvb5lZgV0Nhf3?=
 =?us-ascii?Q?awsmbCz/O2lMaiSA9gLSijVFBjEcJUNxw/9yLx36Gn3C1GthcCIFO3lG2XHM?=
 =?us-ascii?Q?FIO5anzF8XuLgKPo1zjgqGHlfiJgMVN8gbof5q92uHRZp4ujrPryENgzkIDF?=
 =?us-ascii?Q?dDWcxpgsXvt3YNs+Nm6SyEgjfmPB9BK+y/fi3gTLqz4APoRvdZCZP4HKZ3pK?=
 =?us-ascii?Q?ITeBRqTx30FMRWZKAI7PuvdXG8T4WLvQLQvXMt0w5ghZcirm54lCtlgO7qMV?=
 =?us-ascii?Q?Rpq9u/5ZnmYIY+ODvd7sJn6BM1YxbYOmnaxpoLOJkbJj3gDIc44N3meAvxtM?=
 =?us-ascii?Q?Z5ApoSvbSBUYmbgaVMAh/PPWNxhdc+Kw3JPSteXHXvrmPTKiNYqOv826g2J7?=
 =?us-ascii?Q?5+grwPXQkmdqvJhxKQFPt/WJVCUnsPE4mQbL3en5RKrqT6jb1Pw3QgUjtngE?=
 =?us-ascii?Q?RVKFZzLlvhoFcwS0Lqn5mcbsHZKFSz99JEMxyMAmHlXtiqf2EtPZ2r5LxaSm?=
 =?us-ascii?Q?xUpQ3iWp93Z3O+zc71nJIr/prXXvo/XFulgit8cvyAo3m0TMg+h8aNc4y/8N?=
 =?us-ascii?Q?r7TmUh1xTZc7JWUib7BfZS/1owZP59WyUyKnh2FP2JRLYuyU5MK7bDryn6sS?=
 =?us-ascii?Q?JNzf7KyUI9cyXHbT2hqixcm/bIKlgoadG6PI/25Ez0Gw/AD3nga9R21ZYUMU?=
 =?us-ascii?Q?FhzlrmW073wd7PchLGRWJIkAjkx8bcT20A+Iq5G49SyG422IxKMbH6OC9Dgx?=
 =?us-ascii?Q?DCfeYKggPGHot9ZRiOhCLR3EoYaTbakSshBoI6T6QKT5ILieB7VOmQZXQAUR?=
 =?us-ascii?Q?9RtmAnnjSbxiY2Q7YvPj6lA/XTpCFB4dp/3SYtVok/JPilVW6dFFfhK0pkpK?=
 =?us-ascii?Q?eok7el0jfG4ZJiOcHZSowhoypaZPuxrp+WfhGYC2wp6AJ1oU7Wr9YlTLVBSi?=
 =?us-ascii?Q?toa9sYLqBYyZD9aV95G6thxFTPDZSTHw8cY3V/TOm2gDzGDgLwuUL9OUObSW?=
 =?us-ascii?Q?DU3idCnQGlmdLFxpR8LZHbImt0bAHQoLRWnQEb6WmJzg6BO/ivhaJ7E4fwpf?=
 =?us-ascii?Q?sWBsXvVaywUGvqbhol7pNW/5hn8UfI7w1YT5ssWbkWawun/2IfsdsPrT8dLh?=
 =?us-ascii?Q?bBC0zzarHJF2XUxmZsp3IlODlLa498QiudFDoQwoxmt640aJcW7MKBbeCd6M?=
 =?us-ascii?Q?Sxsq6A9W/yf1+MURCADhO8t5hPRC+Qa+wefQ4YUl2bgAAgfR78rgfwhF23xf?=
 =?us-ascii?Q?2PA9poixCp8+gfg9X9e09ZjErXma7BkqhM1k7IvyUckH5OXr34FjJy8TPCl3?=
 =?us-ascii?Q?PFy20TbYalGgUildhBboTKpvyvxUn2GpoGLPKBUTuHe/Nj4blwnWknyNnKBK?=
 =?us-ascii?Q?6VHEEKc7J2zIDGoNQKEk19uUmQNppIY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e34723f8-bd45-405d-8b20-08deb5385f5f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:25.7368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6Not9WD5isJhSxY5TTZjB97q31adyQGKdgQUy1AoX8xcdkj1cLTexu8nOuvMZFdcuE9UHpEomyYP/yG27UuI1cQlnSxRSm7vMap/c5B8r4=
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

