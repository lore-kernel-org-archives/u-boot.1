Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C437D1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D4483F9D;
	Thu,  4 Dec 2025 05:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NM2Xxj5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2418783B24; Thu,  4 Dec 2025 05:15:01 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E360283D9C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNtenUBZzOOWLS9vTjd9ymG62GBR8prDAXepfcETo4dMaQojxtNpzlvYvI2dy1eB/+hxzrdy6pqg4km38WvrzQXF5irV9r9/l9JboT04r4X2Rqljo63fJtHGI+pCBxw0CK3u4RxmFRyVMA2/Fkx0jT/YELPlSlFNniz0SO5ZVUiiHx6+mJmIQquJ/Sj69cxwToQmXSAstim/+wGSo6kwF2YeuTBLAR5vQT+JK2Wd3bfJG3yrkrHI6TLWyLdi30lPGIP3aHVdfGu4KYXOFDlRCvajgPo9HfOzW/PzJEtDrq7HTNoi4EHpH/z+yGpSX1ktZNsTp1dtuUeRD5DkUGLg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+UA/dnXIikNOMw12c2YZM0SABRB8STpo6hD7eQqcA=;
 b=oxioH3cNx5rUpXjIG3cytEyQKhsMD4fkhQ748qFSpBSlRxRGh4p1tzZ3/dmfBiUvyqDdBdTftDpqEnsAgomh++q1Hl9Hvd+pVvtx7PWllKIagyY46GIz9EG2AWTvEidsIw3Z+E2A0ruxQWOzDSBiMmsHq1kHMwbLRBS9S7E4wlWU/+f3H8LM4gM4JICNC1y6xo7Lv1+J/h1oZ12rhh3tX7z99x9//Hzk5LScxBwePjZH1n79zg32RI2oAOvR2MGULhkT7E5vNWNxZb/umpHyQ4gCsmCJyGhSyT4/G4DgYnR5L5+O6E8s+O+PDppaZTT7fECv0SLYwWIM7/HDHiVcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+UA/dnXIikNOMw12c2YZM0SABRB8STpo6hD7eQqcA=;
 b=NM2Xxj5P9X87UQToP8qMiNxO1H2bbvsuToR2BUbMkdcNnj/zAfTM6LMzPi2r63NIVzjsH1dx3AsRRKSKg0lZvnGWzeo3+q2S/HoAgLyqipeEQeXxfOZA4P0ztBbM79GYCErMnNVAbEhd9HDQRBM+9CrAuw1H8VS/J2y7bAGw98r2IWM4HR3+E/v9xxVQJsA2nMq9rqw9OdsGWIwqt08bt4kpOr4WvUuxrGZ/ioo3OwNsV/G/tkb6d7/1/6Ee6aac/ylZvPdgRQ3yne1NNEV7s8IYDxY9xcCo0SnFfSllTvZYnluxvX2CrlWLMitCYkhaO1GYfdeSPsxHpM6zFhMRZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 10/19] net: airoha-pcs: an7581: sync with linux code a bit
Date: Thu,  4 Dec 2025 07:14:24 +0300
Message-ID: <20251204041433.3459826-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: b92564d6-ba6c-46ac-7305-08de32ebaf75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?64T88iQwnTdRbCZi4+oxK0dy4UxM3+bqqNS9JOAVwoIB6wIX32nkpbkXKH+Z?=
 =?us-ascii?Q?dJr58ESaewURskZrMkcR7/c87fFcL8DHDUd32PDunJ785/Fn62ROP38n9yw6?=
 =?us-ascii?Q?xVX3uFjUNyBX+SfFyPCGgLgLXG6zcyiFQ6LVkZyBTvm7uc46kc+ZVHF15iCl?=
 =?us-ascii?Q?sLw20H1u8K1nuasfevIP38CUPwHvKv+oSNQQUGYRXbwanG0fmeJUEy192C8v?=
 =?us-ascii?Q?4O7kzfrPph8unjvEgVeVPtQoLpD3WJ2uJ5zSITdzYrCqXtcARaSpgi4IrP/v?=
 =?us-ascii?Q?KwDKzpCmYROdWhdAnqd8RbjIkbwd6HHKtRlibVaJCRdUJ4HH/6WAnD/iNZl7?=
 =?us-ascii?Q?yplR3+VJXlFBzhiC/yFIAkSmqSUID5UD7/y0SlHBXLvaUbNmr0eWuGVyb94o?=
 =?us-ascii?Q?lHVDzhkGW0e4bVFHxQEPie26X8LErsOJS8zPhfM3mPJP9lrvNFHOSWYtXidY?=
 =?us-ascii?Q?VeC22uyOVis3HRhpMg3ppPycuWZbb2I4rCS/gKiwkxed7qEGqVElDXse19Nr?=
 =?us-ascii?Q?wRQ+gSCZgibrVbBuA1mLHcrK/KPdQYg99gZL116Zkz2Akl1fvdWz0GqgeTJL?=
 =?us-ascii?Q?/z98aBrEFvgRxxXB4smK9x1tIazOkuboNr9BAaDh2O7NRL+CiGfKyq/CatM/?=
 =?us-ascii?Q?mtBasLtV3hFEK3OhRUHyXu9CYTF6whgbEuy+W+0mblub9zfmEY/MZRNTpwNm?=
 =?us-ascii?Q?NjxFRKq/Vshd3pZktHJlP7+3q8G7tnbBf3opazFKxhFUYxqomeNwdCosvGLe?=
 =?us-ascii?Q?C2xmagtW5fIfS6fxNEQ4D0Z3iMSYYw294p308ZLSPBBPjBrBJI9DbxZIUg5J?=
 =?us-ascii?Q?e2qtnA422P6gSQS+dmGej+dT5E0Af6t44C1DGi1kQsstVoxWujyQ8NUlriZS?=
 =?us-ascii?Q?anJT1EfsYQzlD1VrCEhQ8aZaq20L01fVLt+raAd5MnCeNebxv9fOewcoJqaZ?=
 =?us-ascii?Q?aELNNcGKWBTlQtGiS9vETy6dMAIHUUjXbstZDXutczrXYaPD6/9xUQgAEW1s?=
 =?us-ascii?Q?b3AYcV52TVjK07plBlNBh1e+uegT3gn4Hhvh6DHGeK1DOeGMc9K/nsUBi4HU?=
 =?us-ascii?Q?lViPU7TkfWHHCg76BN9oySuIkVNHs+Pt5GgEbwnKQUivXurJqTYUm2GiWAh8?=
 =?us-ascii?Q?Ls05rPQdjRE3Rv0RUyPibxt51MtswnJ4B++J7NC9Xejr6ppwA3rMbEMZEZxC?=
 =?us-ascii?Q?Psxb4CWIZNGgo31J0dn7rlGyNxoj/buvyZoOIAPBKmFYaClpQ0F/S7SnbP42?=
 =?us-ascii?Q?fAA2GXFipK2I4dbfCnioqitYgsBlew6lGfI4RJz4x2X17jbU7j6LST4kLQrO?=
 =?us-ascii?Q?74+13qGUnqP/i2mK+PLP2VS9MrX6xsL936Gc8/ADgUXdPwA6FvzE97WDKAD5?=
 =?us-ascii?Q?vtGvhrqq5P3To1jFeq6XmT6O4vDzXc0vkAi78aCska0BplbvMLvFTvCM5B+8?=
 =?us-ascii?Q?pwlswTd6N2bdjk9DOpq4xZj4dOo2Wdy1nIHWIT18X5/pK/ZCWXMi2EWNM5zv?=
 =?us-ascii?Q?cu+3DWAaVypK1qX2qKoxcBgRIfP4moCc3+eogkwrGQnWfrW+HAR11B6ctg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rqsAMo+eFODbyzrNXXTUC1gutmGlQQtjQ2ustqcyTwzs/ya6JpGxulccWs7o?=
 =?us-ascii?Q?OO+kad0QlKzWhmCLZH8HCt3q5mQM+vod2LD7S2XNUi8qTL7U0e2kbVmxVlDo?=
 =?us-ascii?Q?u6QslzUlU7K8aPGbgW9OdCDxbSDnIqxHxWVXmKWELkFjhCg0B8c83Yba8cPu?=
 =?us-ascii?Q?VjDfGw9brOaRPFjbMnZjj/H6UVjfNDSe5QTRIQWkmf6pPdyc307CHm3X5TMX?=
 =?us-ascii?Q?1gbmYbAytA0Oxv425TtGLp7zI07I7Td0sFD9fV+tTwjVFHJeputqOn2V5mkt?=
 =?us-ascii?Q?xtHqb7EEriCuBrlQaUlqPH+XHTEVIN7PKECVVdbOLlGdL6Ehj+WZah+W+0fq?=
 =?us-ascii?Q?nLX41V79GHOp1iBxH6zDnHmFIOOXzUWCZl8TMAHJyTePOWrZ9DaG/BK4KS2n?=
 =?us-ascii?Q?OxdoKhGmwGqR6N2iHDmc6jRMT1Lbwx4tEtiL3TUfM+H3BDd/QTpOuvi7FrFD?=
 =?us-ascii?Q?WrO5S7LFaSsVVBpg2ZxI+DEnYRvTR9atPOfpD45acjXUFc1NyGXnnqDxEXxj?=
 =?us-ascii?Q?Yuy/9I4DcRT0GHeZwpHl35WjqenaipP4mwXjWhTGK/jNkaRGtkQKJZQYfPkS?=
 =?us-ascii?Q?knpAxclyUDruiRpRJ5jBgmjm1IVfQ9pcsNCwJCeQZHVhaLzjtaFuylRxTTez?=
 =?us-ascii?Q?bUTz8xZ1c5+Kt91T+8ET9oyi7orRX2G6gkXLTBmkCHnON0fXFdDtwaqBiaU8?=
 =?us-ascii?Q?0ARkt2GsjXLiUgEv+BJ07olzQAqxtPEjlwkEW9GpceYdZBRk9wUcQoW/c2z+?=
 =?us-ascii?Q?zf4s+EODBUujKRKxXJz1KU39cap1lfVGopUHCV97JiQh6VCZSlS7+CRnb3Qw?=
 =?us-ascii?Q?1mXU3dApegYYeg/DzI9FC4y2KoChE/oT/IdHmrcWlwIl+bJgw+HUusGcnXKc?=
 =?us-ascii?Q?nxWdn6e2CnfIYaSZf7V0axMsRWK8oQdura0AnVM2GAbuq5IR+ilpVuBuWC9y?=
 =?us-ascii?Q?+LoGkCXMBOctAsO5gSHiO/LXi6CGT/jZedybmi1ufC2FktleqJECZVrBGWCC?=
 =?us-ascii?Q?aT4LzUszZ3TfaFt+4yODUYw0BcRs3bwBsjREm50ExrvvxqU37KbR7+xC2OZg?=
 =?us-ascii?Q?vebuBz0RxGaBIs+Yio1v2E3BrzSfEAaNCRiRbicKcfFv7khD7AFGmgdBxKsM?=
 =?us-ascii?Q?N9N09irj4wsYPIgPKokyrdhg8hIyzVIFHpkvVUXNVWYCSNCEOTL4f5dkl3BR?=
 =?us-ascii?Q?cLBYDLxmlgJxSAXTnkaAss8m9tx/xlrNpcY1k8IjDv5gLmP1xzFIeXp9uNSV?=
 =?us-ascii?Q?yk6JJOBk0+FlSMTF06+CgfR6Qvc1WwOQtkV8o+rUcTw3+BcLV460SXXeqhz+?=
 =?us-ascii?Q?LQlhu+2lLjyUnN70fn5368vCxDH7ouKRqk6Zzd7Cka+j3MpdHKnWOYjHMMVi?=
 =?us-ascii?Q?zkO9+Zp5V0Z2nBJsnAkC6MjJxXBuDvwHfyej8CVa/AU48jgjFhBIbETISlLs?=
 =?us-ascii?Q?JMf1fYYSVqMedel9E04/KGABQNZcBCTS0f69NMCJx7eCPl8QHSsr9+e8oCXU?=
 =?us-ascii?Q?jZlhiFysiPnQQG7NmqvaMLHizNvc2it7X+UmnOXHMhqetmvhXqCOeP+kv1ox?=
 =?us-ascii?Q?ncfwCmivOsdyChDDiohqSUJPOdUG5rpA5BqpkpObKkdYS6FQTy45Jn+jebnn?=
 =?us-ascii?Q?bm8kVCtKThwrJ270Jhsn7Ck=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b92564d6-ba6c-46ac-7305-08de32ebaf75
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:57.7313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38IkcSTruUtSUN8wg/m3kL8K7q2iYe85QKT6DvSRFWX5zYsO7uIG9cqjH2/oFWT1QoXBd3vHc3Nd3IGDjTh1zsQhlMItCLj9VjXy7NKtlTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

based on linux kernel patches from
https://github.com/Ansuel/openwrt/commits/openwrt-24.10-airoha-an7581-stable/
created by Christian Marangi <ansuelsmth@gmail.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/pcs-airoha-common.c | 16 ++++++++++++++++
 drivers/net/airoha/pcs-airoha.h        |  4 ++++
 drivers/net/airoha/pcs-an7581.c        |  8 +++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
index 16f0dac2951..1263092fcdd 100644
--- a/drivers/net/airoha/pcs-airoha-common.c
+++ b/drivers/net/airoha/pcs-airoha-common.c
@@ -775,6 +775,22 @@ static int airoha_pcs_probe(struct udevice *dev)
 
 	priv->xfi_rst = devm_reset_control_get_optional(dev, "xfi");
 
+	/* For Ethernet PCS, read the AN7581 SoC revision to check if
+	 * manual rx calibration is needed. This is only limited to
+	 * any SoC revision before E2.
+	 */
+	if (device_is_compatible(dev, "airoha,an7581-pcs-eth") &&
+	    priv->data->port_type == AIROHA_PCS_ETH) {
+		u32 val;
+
+		ret = regmap_read(priv->scu, AIROHA_SCU_PDIDR, &val);
+		if (ret)
+			return ret;
+
+		if (FIELD_GET(AIROHA_SCU_PRODUCT_ID, val) < 0x2)
+			priv->manual_rx_calib = true;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/airoha/pcs-airoha.h b/drivers/net/airoha/pcs-airoha.h
index f9e325511af..714d2ebe520 100644
--- a/drivers/net/airoha/pcs-airoha.h
+++ b/drivers/net/airoha/pcs-airoha.h
@@ -9,6 +9,8 @@
 #include <reset.h>
 
 /* SCU*/
+#define AIROHA_SCU_PDIDR			0x5c
+#define   AIROHA_SCU_PRODUCT_ID			GENMASK(15, 0)
 #define AIROHA_SCU_WAN_CONF			0x70
 #define   AIROHA_SCU_ETH_MAC_SEL		BIT(24)
 #define   AIROHA_SCU_ETH_MAC_SEL_XFI		FIELD_PREP_CONST(AIROHA_SCU_ETH_MAC_SEL, 0x0)
@@ -1173,6 +1175,8 @@ struct airoha_pcs_priv {
 
 	struct reset_ctl *xfi_rst;
 	struct reset_ctl_bulk rsts;
+
+	bool manual_rx_calib;
 };
 
 struct airoha_pcs_match_data {
diff --git a/drivers/net/airoha/pcs-an7581.c b/drivers/net/airoha/pcs-an7581.c
index a95eb8d54d1..746ff55d72f 100644
--- a/drivers/net/airoha/pcs-an7581.c
+++ b/drivers/net/airoha/pcs-an7581.c
@@ -1261,7 +1261,7 @@ static int an7581_pcs_phya_bringup(struct airoha_pcs_priv *priv,
 	udelay(100);
 
 retry_calibration:
-	an7581_pcs_cdr_reset(priv, interface, true);
+	an7581_pcs_cdr_reset(priv, interface, priv->manual_rx_calib);
 
 	/* Global reset clear */
 	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
@@ -1300,6 +1300,12 @@ retry_calibration:
 
 	an7581_pcs_cdr_reset(priv, interface, false);
 
+	/* Manual RX calibration is required only for SoC before E2
+	 * revision. E2+ SoC autocalibrate RX and only CDR reset is needed.
+	 */
+	if (!priv->manual_rx_calib)
+		return 0;
+
 	/* It was discovered that after a global reset and auto mode gets
 	 * actually enabled, the fl_out from calibration might change and
 	 * might deviates a lot from the expected value it was calibrated for.
-- 
2.51.0

