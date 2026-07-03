Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4A5C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF41E84A8F;
	Fri,  3 Jul 2026 13:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XWKPI2KY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDA184A8F; Fri,  3 Jul 2026 13:57:35 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FFEF84ADB
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTw58r8ljCi2lRq7v/gptoncEhWV83L7ZNwi06P8ZJz4emfNQXZjorr+pdUE5Sv7gmqOzIXYX237hqLxm8de6ahi34pRmd8WWCuetkdcHtEAgjailjjkkbKI9tUuJtih7v0Ec8pK1Z17AcjkIUXueAuhIMev8WafimUEmz/bmBlgTmMz3ZOA6Pm85SHLE0F+9stdzGFmNfLS9PBpy2PkOBmyjovIxDXOfSATWOW1PAe1o4QsWPzugK4EmVeK7VlcKSxwGkUvWGFqYE1H/9AyFbCeEoVIrGF6itHcEL/jVpV4jj1Cv40QgyWoOEe/zqOBnqpgfar9r/q4ZCYqg1plZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9AdjeQlgPobwKri47JXtPB5w8DysFCmTmPiatnGgeM=;
 b=fWT6gtApCKjhtjmJm5haL1oe+q/ncpUXsRCgnAW2gTrQxOaubJ78iqqS31+b0YU97aXq2aJ9DQIG3qEW9MDeOTM3NEQzpoSVBPPgG9EpI602DM7OO1shUgcdYELv9eXR1pSxM4sTirnQJliPMieNPuyQZ+ydBPXBHkvwAfSr0e+cTLaNAA8UwfOMkkvtVob5pRDnwu2rLMgfc4MH9S48SmYXesx4sNehotBPFPe82Np1bntoBp7ps8c8E2qACQ+MLp/MbbRfcrLDiIACHhzBiRJ6H2FqM41QiduOcuBr/vK4d9dowbbegy1kObSP+oMcV+APVR0pCuqpRCuJBjNvJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9AdjeQlgPobwKri47JXtPB5w8DysFCmTmPiatnGgeM=;
 b=XWKPI2KYV+AIfemLdwTD1k1mBRSpZT//i71CRLuTMQ0eOUZJQH8D8h5osgTere0EQVigNwhKN9iMz4PbRptmHkcxRQlN8iGBKHc1gLUJ9gGU3Z9wwwLpW/gNNFuYGpg22mHnI0Q8t0a8QN7bBW6L2Hg8T53ESKoe94GajdIKqt76s1fIYgIxiEvdvX800cbupod7mtjV0zlRfwIly1QLCrJ3l6CGkrmg4GkKeVpg809wC+ZzihB5Lujjq+3VG9TOVb+5/11Xf0qfCFfJV1iGrSl2wgrwhtGUeH7EBoQGKA6/R9cWECDqbRXwmSH3prABnmYrLGXz5L7wgF0ccdtPQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:19 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:19 +0000
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
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 14/24] clk: renesas: rcar-cpg-lib: Convert to common
 field_{get, prep}() helpers
Date: Fri,  3 Jul 2026 14:56:17 +0300
Message-ID: <20260703115627.2317120-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d14f9b-cb84-4592-a9e5-08ded8fa3c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: EUCJFYgjyU0ram7C0O2Fv26Wd0Yw6qnyBI8mAYPy46uWEnG/BdA7+k9QDqUl35HZfdcCNm09Ww1qKq1zOcS2RuIbIepR+9WDeLPzobaDUnj4Ev+vefcYDQ+rRlfGflllHEzAGYTVlmSNT2uVHL5xLWsL1k6gWzHn18qNI5pRZoRm8ZzHvxsGbupCL5efinl+Rq1Qjg5lXciIu+vr/EqpT2knBFCTLDDf8AjpfJmXzPSMTehWb/RZJYHM9Y28XJPgIpDJG6b1IFweoT9ib9Bum6WFi9Z3LSgyoELLD8HD8qCjkv+nLVHxGjYk1c5SrTdQZ1ELStNQ4AupDG2+r+BONJeGvd97RAnfEXgpqb8KSivp/cEgmbCTl1aJ+GGP4MZNHp9TUVFSemkjBNan1OjmCG8QZjVKU22vOKTTqL2RmjKzogJ94vI6/WL4FzTHhZ/9fMaAUXAvy8KRsZjaThK7St5V3YDe4Es5cBjl1VbbdCVff3xtkUNw2xjw0FD63ofLUFCYQIdPEK95ybHgcMixjk+97d0ySyL0a6AK180YHP0a3Yv0L8A1cs/2sm+Eag9hvH3lj82AOLJjk+C6QSDPsZJOdB3iIUyf33+4KZ2EY87txHqgCrdiRp27vybI4QmZAKkSpbCJrAZLJ9AunsO7ePyA3Bkah4h2OYsC66cbspbuuYN1VeoVDkdl/qhoKSPODVGI9g6h7xAL3/QuYYXGG0zr4dITpRzCgfV7ji42BuYz0lQCq1ScntG1tBkPsRQx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0LKRnLd+WtjjKEqae0nS0es7Hs5zCWX2f0K95gAo0jT96kI6usre4Gpv0g4F?=
 =?us-ascii?Q?PU+IJlyUp24NdnmKxGv2u7ml1aP0XC73AyMukKyU/D+/ydXPf5uGxKd8fyZg?=
 =?us-ascii?Q?R44xX4rlFt+C6HzaM6oXDSC6OFp/pAngOyLUgf89GWX9r25Xwiz65z1l1wrm?=
 =?us-ascii?Q?FyeuakIwwe2ZG04kqPqBNhoio4dceilk+K+0t+OMOmMih5LyxRGhnRXuEsUB?=
 =?us-ascii?Q?DsBa7ECEw/jbbY/0StyN1+faOGJawm9mSHlNHrWrR79xNnCWM9fPqhtoJFPO?=
 =?us-ascii?Q?zxDWsCrd+bnyzlqAfc95bCiILbJk6XAzFjnCfkEWGG46YSKMQYJ8i5BpCDKo?=
 =?us-ascii?Q?R08NXeX7R/rejbTm8PahnjsG5ZLdRl3xq/4In8lIHMviK4HRaMimMKxKZWJX?=
 =?us-ascii?Q?wpsI//pwGyYfLaepvcWhB1H7wR4N5bWECaFcgqpQVtDjmK2bOAdDgIoJlj8v?=
 =?us-ascii?Q?QgZSW5CVknpif7G98WHmHzoilr0u32H7whebccP4BqPUvBd+n6gSv82QNM5P?=
 =?us-ascii?Q?lGUMRhqBso2zlfjbpQb6aN6H06O48HHM8/RckC/QV4x5VKq3S6YtORsOT2x1?=
 =?us-ascii?Q?kM4M9y9PZIeDu9djEnQF/RQSa90tEmH01M2iyZ4AQod9WXg2GF2r7/j4syOR?=
 =?us-ascii?Q?9NbFaBi0sD8A9wlIelVgh9ac13WNTSEvpr4xPpxCN3X9+u20RKI/kYowVDg3?=
 =?us-ascii?Q?spUWPErSrhOyiXdtlDGBWPMem6HdIAjKUS743zNJtA5BKCHkDYLprf9LTAJc?=
 =?us-ascii?Q?1yIe64ulqvu/SCBdJwlulcS0EsUJcbBBd5ktHoJGPSlniEE8TOWE8WYCS3w/?=
 =?us-ascii?Q?XnjOZXqAVC608co8xT4bDU19SzF1NVpZwux6D00NEa0rd/3MeOCMHIMYBo+G?=
 =?us-ascii?Q?LcQ8Oxj8f+jKSbgKtmIz8sMl3Vu7CGRDe/pIn29dORvu4pK110idD3o/L1k2?=
 =?us-ascii?Q?HDTOrH46xUahWSdW8fDIS3qj/ENP0HLuLw6B2LG/E3rwd4CbRssoeEL3+LJi?=
 =?us-ascii?Q?tRIN4xsTDgrzUXzA4pkbq4RfneeAi6/uPYN/8n9wZo7y/ZjWXEAZIrrfSQoe?=
 =?us-ascii?Q?yUOdEB9b9A3loBAM5TAkmZLzuZq8vkOHrMblJjXq4pPSz8A1BxTBak1QgJrl?=
 =?us-ascii?Q?0XGi2qVqATAA73gaY5bD4dCXm6Vp0xbPZaYfUzLR/FKbFaMmENCzBkYjFULT?=
 =?us-ascii?Q?0TCc+wVWUY95WnaTVIPTEkzwcQCkBXeJSOyMEyLbRKt/fnp5dvuLrKkl5oIH?=
 =?us-ascii?Q?tasVcrc4GFvM02nEfgV3ykCwsmsSZqFc1QwZ8SS02lg5yQ2kCcVC1FgNo45H?=
 =?us-ascii?Q?0jqfvS+vGC0mjut5Axqog5cSc0UzNBweaA5harYSbZeurs97GEexFFA3hiUu?=
 =?us-ascii?Q?4u7SG4nDFVHbEInJPMveMqdNjUyNRqITgI0AjKetrFYFnZOORt5L+pQs5ljv?=
 =?us-ascii?Q?1dpNoD+73tc6HwyVoLhpsn6W0a9HVjtevdHYD8zeRfDeFsfeIYqF5j7DnCnO?=
 =?us-ascii?Q?6VgMSXiprjhEmv/JrV/u4O9ke4ZR5BzPRJpcC2QYY5xb0Nez2ckFOxkK/l9W?=
 =?us-ascii?Q?NfT10PfVkmgModSFXyGhF1gBgCT4d/bqITuw9WpuhyoHso3402bYrtRvKp3N?=
 =?us-ascii?Q?rlV9Ej2j/JQmJ349pj25Fz736pNlf22oGi27MVGVo/Sf55Qmt/4vaxezdyaV?=
 =?us-ascii?Q?fX01GWStSihEED/wmO9tgj72+12tXkXYPPfJT+IBOCPmrk966wtY40pRx0KY?=
 =?us-ascii?Q?aDm5580lFh7+4+WrHnuT4TqoXK2fjm4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d14f9b-cb84-4592-a9e5-08ded8fa3c2a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:19.7156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKltKn6VZRGu7oPWgUgPASV7YSIC2MJJbuxjl8lipBDhTzz3KIWSy3tNpjfiP7xmhIoJX3ysSE4WreHj5LwaVTFLygvOERtsgsTbQ+0NJwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8172
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
 drivers/clk/renesas/rcar-cpg-lib.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/renesas/rcar-cpg-lib.c b/drivers/clk/renesas/rcar-cpg-lib.c
index 5d1c8514adf..8e992d2c2da 100644
--- a/drivers/clk/renesas/rcar-cpg-lib.c
+++ b/drivers/clk/renesas/rcar-cpg-lib.c
@@ -30,12 +30,6 @@
 #define SDnSRCFC_SHIFT		2
 #define STPnHCK_TABLE		(CPG_SDCKCR_STPnHCK >> SDnSRCFC_SHIFT)
 
-/* Non-constant mask variant of FIELD_GET/FIELD_PREP */
-#undef field_get
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#undef field_prep
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 static const struct clk_div_table cpg_sdh_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { STPnHCK_TABLE | 2, 4 }, { STPnHCK_TABLE | 3, 8 },
 	{ STPnHCK_TABLE | 4, 16 }, { 0, 0 },
-- 
2.53.0

