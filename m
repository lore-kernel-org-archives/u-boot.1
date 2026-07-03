Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948EAC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE7184A7A;
	Fri,  3 Jul 2026 13:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aPhCzgbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C66A84A6F; Fri,  3 Jul 2026 13:56:54 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4018F84A4A
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLcpHHPvr9g78E7COrOIIJVyIEPsRDCEQzeOX1pj5o0Re/w1z5uj+egFma08eAT3EZ1z2wnF9hGtsFeKUhfX9h9GkJfKQLokTmJcBhxBRxLsmktTMYHVbDt2B4wNojVkwj08CjnewKbw3O/OB9oyzswJwABQ51yIciXtBkohSIXhdRz0i7eEFeyuk6ID4tpmjMr0iVPchJPIMHhYvEo258lDD+5qvglnf36wbXNxeVbjcAaWcN09xtloYhk/xhqXAVaNC5PMvTGTh0SWaB1H1nDlDNn2mBkSR3hSkwKWmiOMgwcp8J0BSct2RbXdv39OF0Lk22G6FH+eLFdreem5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDRi2uCMF3TeKWtwk3MPBpPkvvjTc7GJov1sWycIH68=;
 b=LHW16B814ueFXCo9BlHJ//OXH8vNUtx4CroewdJmuiLAuPP+iv/VXtt2TlOL81v72dTdn2Tw1oqixprPnvMH8+Qx3rX/JuiHiql4fuLLZSu/I/d4ZfMkwzfDIb+PJNkg0LPnSqdEbr/GgQvsJyKaPsjlBCoo0qe5Yi1nLpfvJ4rOqHdzIF4X5sKwYmbXFgTl92CvdjRo9idcPh4eNLCgdv317m4W1J6lwF+hRE9lIRZLDd5pnQo89O47OQB7og0kQ+dJ+gnbqVbbHgphwtOzmT65SxUbv1bABT0FHipuqVJBp92GVQn2lSuZoFy8ciTQ+Bqv8rTqiUz5tiqP8mMGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDRi2uCMF3TeKWtwk3MPBpPkvvjTc7GJov1sWycIH68=;
 b=aPhCzgbw5++/QPA9bNhvaQ9wCR1SJui5AJZu2X7rIXtKvDJ1WXh3ZA9JCAYNsm4z7fv+OTjmPUUDUqrECmp2UQrqM2HUcvGnL7ftG5llDzrlRcaPcMng6Z3BvSVv8eI1mkyu+YLXi7qBfxwIqehr075KE+KgKZgd+xtFe25biAZTFtnHd+NeOptM8z3cdB0dygbGt0886qfWFtAGhBB9xWvcr1hURbo9L2tJhgMq14C5yu1uo3W07P1luvmfAdsED8uNepxZ5xtHQncCcIF6r+hKN/WYp3PBHw1ZzsmrbpLJrNoXF9+sMoTMJ8iTqz/Q2XfS0wr0GUHHyCoYXLmybg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:56:49 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:56:49 +0000
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
Subject: [PATCH v15 04/24] mtd: nand: raw: sunxi: #undef field_{get,
 prep}() before definition
Date: Fri,  3 Jul 2026 14:56:07 +0300
Message-ID: <20260703115627.2317120-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f86590b-5214-4d4b-08d9-08ded8fa2a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Z/5Gtfs6Zwl2rqyhWFhUJMbLp1Yyb/RgQc4OE2dWAl69Awp6xgfH2YB7ujdrOAVEuS9KDcz1sZ6DRzVWo4EquME0YxBtkZShJY4o2+BpQ3tNHfC5I1FZgWWDFNGwKo3FEao2zJoESUgH+j+ECbNQRt84x6kAuMEXIKHQxFOC3+UVprPnICLLQsK9HETSUEgCGUnfOobF42rvTvxexFyt0TSyH0+s1Cb2TVgV2alagKDOhkGNl0mtFFJA2mvZTvrhBSbDvJGBcurWAbJIJB1fczw9iNdetM5ka4F6E0fzyFrqhA7zwb/kG+1kC+9aiCbB+jPidQnU2mebl76khQh5ABrI9Th+eDc+5YXR52RRYUYX2riCiBL3LV4bJvofUlBa7zEpug4vyApv/BNSogRBSnW+ejqMA3/lKXx8hpif1q37Rho6SMOf9UV9IDhduW6NH2A3hb1CNqyTCq/2ue944FraqOM06oFq7Nwah6KLbZ/g/9NOU5Z2SrUHAqYCTUNId1KkCrwsItWJrf6QrCXMs/Aw+3ZLSJtS8cyGe+wnUD2pJ9kbtUBZoFMSpFso17Ldw7bPUJIswwMTKc7LJOlEiPCFm8+JtuAQHimSht5D1gTYcavy+J1CVfNrfdgocj6kpBlXCt53mfB5Z/+FTKPPaom8NQNBDzwDP06jLlxhadr8e8mDOLsB9Ttlr8SVwCEQ7b48cOZb0oIrIftn7Le87P5S4ItsJzCTBHntbqNRboP8/LmMK13G8TSYAmfEINur
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AkN6R1u1N0vGb/gHSoDYM25CcNCdu0WL3GkdRMAz5hiT2Tzh3uTcTfMcZFFe?=
 =?us-ascii?Q?ZyhiOk9zTfw4rssgeZ7eN/13io4WMaiCwxJo4rAxaFTe2RCASj1NOiriZNnS?=
 =?us-ascii?Q?0NJI0okextOlS6WL6Wgk8v0jfxwaW2UiJlWPtKYjsRxejFao03nw6uwvfOiy?=
 =?us-ascii?Q?0mizh0y90MKRhgsx7JWcaS4XE1qoWApnTh3nie5VCMj5ICyqSMnfmytdFoPl?=
 =?us-ascii?Q?d9NQUyC1xzbiSc+OWlk1SKBdVTRIdRqNi2chc76i5V8FiOAaW8x23P2Mol8w?=
 =?us-ascii?Q?+Z6UEYQEwBsSwnPIFZOE6vo8dIXrBK2VF9s2kUZq3a/jRFF4sErcp836CXW+?=
 =?us-ascii?Q?yRZi0XdtCC/SOa4dKh5ySAEMtHKWc+bhLL3aPZWN7CvW5F/0XQ3ADKHjjwnJ?=
 =?us-ascii?Q?u5gz8UF4W9qZ75YUUu6VcW2tHK0ZjtgewKwDexcXIv7gI1PqUxdoVyJLFFiq?=
 =?us-ascii?Q?6oJ0VYB/fAbC6ItUyDmrj+9BisOVJvb5H5mX4XmgtqOg7alRBGcpp333SsPr?=
 =?us-ascii?Q?bDSmmMWHZEVlD0zGVcj8hhLR6au0yKe1orxKMqUlw8QAUjcoGfKuWZMSP+sS?=
 =?us-ascii?Q?RcokS42zW5Gy9W2ty2xa0ZWilDVU0KRcpb1XyJlSzkdQ47YkH9OzQO+xXdqx?=
 =?us-ascii?Q?2WOZH+B0O6n10FYYvDiWxkTawQNGucS9IauLdRFWRqjyhimRpsu1CV1SCBUi?=
 =?us-ascii?Q?FxjrhJGgDJ8wSGn/SKN1bpTbosonWCnlQl4BveAt1TX1MJmcEH/oRSO7SLSN?=
 =?us-ascii?Q?41WmZ347iWYicxcOt0/xRCv3ET8NlmdZsnRzoDAvQNSHZBZGckgme7jeQxDt?=
 =?us-ascii?Q?FMApC3SSiRhfiyjAU7TYN/NJ7p2F9D1EiFj64B4W+iD+QSJIqFci7UGRLWfI?=
 =?us-ascii?Q?UHeWJso3gnS1nx7Wi2C9AI1MnQMR5KeGhSgnLa0u34hkHkkl/IGlALZCq9K2?=
 =?us-ascii?Q?5gbNYjawDsnnOPJcNCtsAydASxTRk1M4NAVqtqif7YMd0d7noxBXVv/Yj+Oa?=
 =?us-ascii?Q?0MPdAM32uukAkT/h4ZUW6KfLcxM/qiQudvIvFbsoLUFwrg1dz5ma9RUwOWIc?=
 =?us-ascii?Q?+ZqmVUfN4C4YeBH3qTO/fwUVZBekzIbPdSN2zZkw7hX80WMpO8hYMkdRbaBE?=
 =?us-ascii?Q?lOViXvBVlrYZhVJxFL7F/4sn+XE/F4vm13bfbyjwtwpdCEfY0CbagYrZ/8vx?=
 =?us-ascii?Q?vbuDo4SmV6H+cZFOtNlIbaseKprfdsX91viHHLMkZAjVu2ACVr3xAm+fZGBz?=
 =?us-ascii?Q?xZXOMimehNNjKzW4FGQi3+Z1git2O5ci0tfVWBaXf5k1wDJLNcEPqCSAI1rO?=
 =?us-ascii?Q?idF5boE2dq4FzJGgueHye4ngNrqM5fOi9h4PpjjorVAIvjxcwiO/1S6d10QQ?=
 =?us-ascii?Q?Ljm62/lLRX7g0hiLS3qixnxLaKk5c7po2zZ9+AQHdLhmo4DahJNkeA+T9/cL?=
 =?us-ascii?Q?RDWAoyLzkk4/Y9U4oKTX7BxfQQSdG4D+T3NY6Ie6ae7MPzxtA74swWLp5AoC?=
 =?us-ascii?Q?wIRkhkBKB0zzNO67X94sEK7y4QqsGrQYWer3XMsu+at3qrkQ2rTq2MSg9UL/?=
 =?us-ascii?Q?3Fj2XknW34EfDApaqe6+fikAR1JKKxVIHrUU+dlthGOYF2+IxaxCVRLjke7U?=
 =?us-ascii?Q?+dJYfk2qs1ukZGyinQkdkmwrcFkkKb+xcr6j0ZmrJk+w5qeH8t7VQohB43T7?=
 =?us-ascii?Q?9vUZHoZMqcYJtt1OrvVm6R92Y6rN8FlD6Nt44rGJYsHrKi9kEVJLDXh00u5A?=
 =?us-ascii?Q?t1dEXWxcVyFS0cnZlZBPK0yiLpnBhH4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f86590b-5214-4d4b-08d9-08ded8fa2a3b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:56:49.6624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2r7U9z1RF3YNxBBKhYHaf59wDQNCW+7k/tcmvf2xCnon8VfKW+TrwPbsRtaRMOo0JlL1ZZ3CoMVVtQotHRxNWNQic70uRYYUI2pD7w1sj7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9448
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

Prepare for the advent of globally available common field_get() and
field_prep() macros by undefining the symbols before defining local
variants.  This prevents redefinition warnings from the C preprocessor
when introducing the common macros later.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/raw/sunxi_nand.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index d7a8b3dd40c..b470e1d3368 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -26,7 +26,9 @@
 #include <linux/bitops.h>
 
 /* non compile-time field get/prep */
+#undef field_get
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#undef field_prep
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 #define NFC_REG_CTL		0x0000
-- 
2.53.0

