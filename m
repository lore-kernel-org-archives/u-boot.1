Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3878C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCDF84C8C;
	Thu,  2 Jul 2026 07:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="18ZCWD+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1DCA84C90; Thu,  2 Jul 2026 07:58:11 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1891F84C87
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skhAAdib3rtRU0qSyj2FVXZasjgCpjdZscIJPOzq4trUP3T5BXaKuy6bRBFCuATAtEA3bjDq/Tuv2gIT+fhPXwG6NO5m03n12Qyl8wC8qCl0uNYzEGlIwh/pbDXPp7A1BnArf85Zswux8/ojqF9810SD7+OCOF+28J19P/8nooiFa+4M2tVjv3sGFQU6SoHcJTnujZmNs3HVLCAvHdJmwrLe77rr/D/GJEGPkMUnsd8pZfTKO2F8M4ZPs0Ajhjcmgv8iYMxYrqM2HDDRWAuowFCVlVdJrJ+1H/u/RLIi4LaoBeblDGQe+wq8ColRTanuTFEytTVeG+UiQwoROYBcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=genttrLxqJgNi03MxvqSQnWq2WTv5nDw3CjCXhPhAyI=;
 b=C1uDmTPsl/qdrMzGohxn9FbXoDKO1ZsWhumnLxiTeI9JmywT6BxRE7P8lGhbxHxD/dMvQJXwkh2xX9J1rZlOhs/f2kEQPcBKllsQ1+qxPizTV1mJcwtREC9I2FgJI0fyRHnFcXTzcKaS0C/t2J2Z/C5qBW1yp1LvmLYL1XbUM97WNXk7xeEAlcxwyKxse0/8AxuIi8+LoUR9J6FUs/A+Ixq3erhfLIM3HDQL05CnFJKYny+DCiTibmNcpg1K/RcaQNdqRiacNYUzjcVUJ6Cs+xQjO5PIYPoWB2LYHH0BiYAq2LVLepzHiYXh9MnVz4fSUm2ZQ+QoefN8PREheAgaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=genttrLxqJgNi03MxvqSQnWq2WTv5nDw3CjCXhPhAyI=;
 b=18ZCWD+EkSbAujGfFPtHMlWF+igjO1hbqNhZ2obphuKy/438bTqU+vdxwRPAWSrdAN2siyNwQdVlsemscCdASlNxL9H/ZDZncBtzUXXaratGfl+YgBnrqmVuaghP35kY9dPNfhoFfeydUqx6iVMhnzI380y56fDJ8K4HLP4TWpPXAHgSkM5zRmCcuulEMltwt9XRtwUtChjidNswow6ffApgYPtq9MYpO3wzoM7fgI8e96+IqimXSjk/F5WrwDaJd1yJdeDR4U0Rqt1wf+r7vgNRI10MHjKPkXtbmhILYIf3DssBub+kIXcdz3NPb1xK4uUokND7LL5qggZGQIlYJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:07 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 05/18] power: domain: renesas-r8a78000: Convert to common
 field_{get, prep}() helpers
Date: Thu,  2 Jul 2026 08:57:31 +0300
Message-ID: <20260702055744.2164975-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0541ea96-31ed-4626-0638-08ded7fee3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4qd+/NRhSHDf980+aHWHFDyjUqXZ4KzkmV8X5hcgvD+qDOPUhtWdrscVTfREc3LLrSKeZx1OCd/GgN1OY/AObHwLAvisan6Uq/P0dLQbn56iGkrqZr0FwY+55QpwOka10+jd5+x7ik+W0gjZPWrSAW65juGn+Hi66ZGptleMJ7AuqdcEJ+n89fCVur1Q/rbMZUUZFyCbOhiJRIMV92FXLPf6Tt1pcAlzxTYH3t2QplEQr/tkGsPAzXphmk82TyYTGRcmKAyECYPQp9xbsOq1sEqdFzm54R7pADqJT1PcFHv1scZ5LFunZt6eBZCQ91tMnfAhlBrTdCwP7uYrlzLvFgAwGg4mA2NFLJmVVTO1W58bisnjVvEY34WjH3ZNJFuCjkzsVxa3VIyqxvkwantIPKE8FxpqMTRAf21QPF/NtlzhpwmBTUAmZQqnYbId/BN8xDZFPzh0MVRLjDg6sBnz70RMZNBMqQJ4nrbOllp4Yl6tVfvSna+b26q7CXJQ8eUKwEr5ZNULCmasr4wqQCQ4aBAjfyEeAk+gh1zHgEHj9M4oZhkdhyBhmo1vgrTIaX5y63Rzuikelr2T3+o7kAf+owcHNZ/Yf5qB1POowpapfH+AyB6TsZRjmY6Q2Zkp8Ck+qHZeqeb8xeT1X1HL03wO9bGmkedDE7auyYhJQjpP52HRd8fguW3J5l+RPDODU/g5aE1eYk1f4o/SVrE0FIYyWnyCZz3qcZf+PiEKDHjkp+F545WugPVAoFVyEAhXECbP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GIxxmAek3fLoxMEZSG/Ages085iSda/VQ0/ZpBKrIIYhZNfFiMU6eXT2ZnBk?=
 =?us-ascii?Q?yRmOScFfrWxV/mfn8+4UxsEXVAVlD4yuaVGbQK3kvzOAgcFiLhYS8J9ftC2I?=
 =?us-ascii?Q?BcimNGJtiUS5137gNsYiYHQI+P/7Kvi3lIkoRiAYaed3UGq6zkhCC0ZCsiu2?=
 =?us-ascii?Q?vOejaEVaAvoG1LaVr721oUKWqHflHeWTgWUVGcWo2qISgNJt1NVNYJIHmiG0?=
 =?us-ascii?Q?kEDXl/4gtZBE0plZK0LCj6Xcb5uaTSGKB/uycIEZl9BZuAUzvepLO88XjhZF?=
 =?us-ascii?Q?IVkt8z1Kn5RzSIqVPuGhEaso8MK+8DUk28PbgdnqtneRQ8YC1a1ryfnFle4/?=
 =?us-ascii?Q?6MDAdEeGcNKeDFHc19x8sy7wSBlh1BFDSnOGNwg5oErs1oRYpS/mVj1/OiZs?=
 =?us-ascii?Q?6E2fooNZ/7uwCzoGjFlKQ6nlRWWphvDQb37D4KfRqpNhMoiZ4QAsSZeIVv2W?=
 =?us-ascii?Q?+Ep2fSk0DPcAClR0nWaK9PcIYprMT4FK/Q/A/nSXi/AfZDd1PO7q/2EzEW9O?=
 =?us-ascii?Q?4bCzPCaftvcVz6cQdpvi2wLDHv1e76ekJmr1CouOzgqLxHz+/b4wz17E4+n2?=
 =?us-ascii?Q?HTDhJB4RrDUlbOTTIFGbaU9jH7u7kwWU0KPj/rrU1G7dtsBqffTzuWqCnBdI?=
 =?us-ascii?Q?Chl3LsqWgCZ/zPtunbOlntaTulP2pFWxSPYnyl3ZKaZEs3rLAIPIUTc8K6nQ?=
 =?us-ascii?Q?Q6SdA/DUNMXlnjztJLSjeKvTPIWOH31BApIsBol3IaQzxrbvQJbAVDfotkpH?=
 =?us-ascii?Q?SF+uOPoc7d4h3EbDIM8ZgjbaJnF3SfVcXUtrVB9nO1lFpo/yyrp5ba4P3a/E?=
 =?us-ascii?Q?IY0gGSjkQvThk002r/5r3OKzCueAG4+vZsC9mq71Td9PLp78+jCTDeq315Oe?=
 =?us-ascii?Q?KoHZw6pZikXtPdruWI3FLTHsYdbFVLvgOwdYuNDEAYOQvv/6Ik9VHDCyxQb5?=
 =?us-ascii?Q?Hejb/pBBIF/zePgNIHo0sQWlCY159jdCz0dzqe7CxmcieoW36vMjLFzQTjZY?=
 =?us-ascii?Q?UYXMjr852Hgxls+fBRBMAdyCjXZDjmtwfnsyfiMLJnl9v1HtLVNbK7GEn9Ya?=
 =?us-ascii?Q?+4NUpqTjpjotSgzflS3y8mL9RxTzw1I9tolZ5bV+zepulJ7qvuQgwxSAo55G?=
 =?us-ascii?Q?n0kyayDTglUzf0Ofhd+6CVyG9TrmfGpGFyKyc9kHIVLy2nAsc/tZdoVXpCJF?=
 =?us-ascii?Q?hLnhi/60SlzZH/4Pm0wNYRfHaPEu9+Tf9w7ZBsECS9VelHS8ISoXisx4BNZs?=
 =?us-ascii?Q?0gLkkmIHCvg62OgBJFEHfjZn6IVvTY040EdjhOqNdUKEOMgefO4KhfXQp+Ao?=
 =?us-ascii?Q?39EMYjVUAnYmsR1JZUsZU8Kv4MG6NTNI9gvma9nwkOPoGuL7WpgOtEJx4MwG?=
 =?us-ascii?Q?jswd0onh9Xhhb903rI8t6phf4AAPIS/8BsfYq1NyG+ESvRFn9tx9gf9UmpLm?=
 =?us-ascii?Q?kdNjMRR9iCdEQF0A10FovDn2wmFqybQeZA9A9NuL3FOPcRru5X2nXgx4MOZU?=
 =?us-ascii?Q?i8OV/frSrxqxsidNC9pkr7S7e6IXE+NbXNXBqNLLta+RPWh0pnH4Sfru7nMA?=
 =?us-ascii?Q?fyGwE1dDriEDweUtM3cHorNc7gba/HRGsIX0N2w/kSXc7/LwSvOAdoOFalqZ?=
 =?us-ascii?Q?tVT5IhOn5GK0ov383PXhQR/1wkbvbzXJK166nETklfganVpRWDbI5/fo1EQQ?=
 =?us-ascii?Q?s8tYzrvEXyp3D/egyz6QCtJ9V8ycSoPCpcP8PwFYDXRqszWpZcMvPpuyCIWH?=
 =?us-ascii?Q?SwPwpGf8j2loqL9Mn8h4VXb5fFJ67+Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0541ea96-31ed-4626-0638-08ded7fee3c6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:07.8722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stM/uCdR/GEtSkkQL+o9GdRDb6ZLzM7vsfCtScPcMKf5yO1uVK+d5vqmEgCUqPLZ7rqLCKodTRAaqMdwJNK2KwATy6tjL+Y7EQZUoR67IkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/power/domain/renesas-r8a78000-power-domain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/domain/renesas-r8a78000-power-domain.c b/drivers/power/domain/renesas-r8a78000-power-domain.c
index d621373f90d..57b3b56b2d9 100644
--- a/drivers/power/domain/renesas-r8a78000-power-domain.c
+++ b/drivers/power/domain/renesas-r8a78000-power-domain.c
@@ -11,6 +11,7 @@
 #include <dm/lists.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 #include <power-domain-uclass.h>
 #include <reset-uclass.h>
 
@@ -21,9 +22,6 @@
 #include <dt-bindings/power/r8a78000-power-scmi.h>
 #include <dt-bindings/reset/r8a78000-reset-scmi.h>
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define PKC_PROT_LOCK			0xa5a5a500
 #define PKC_PROT_UNLOCK			0xa5a5a501
 
-- 
2.53.0

