Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4338CD1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29FB184021;
	Thu,  4 Dec 2025 05:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cX8Zjjwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB3D83FE9; Thu,  4 Dec 2025 05:15:08 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A5E83F7D
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzJpkX8HtxaTnHoUPOK7O3c7YpXgrV72tmCQdA57bDOiPJdcZc2SUM6tR5JEyBiVw4pTd32/TVF3ohdlGX9opqHouY49sGHpDbdhRpWq4ELJSN7pdUsbS7zHgQtr1E9+ntSw2hMVZJrxWvekr6ExzORwF2MNBIJhteB//o/YD94MvLakI+eRpHKhcmFpOTZH3Pmguj+459BBLloCl6TA+POmdbcTlYXE3TqqPUKvy3kZTrf4ivN4leQ0SeYnhQWdF45szWgtEfcOLyo/0NUqbs0YYlmZ5xIAL4EY99FmQQ2BEdZ3cRf4bxCQUwpSs4bT3AdvCGLPIAAY/BoWIrBhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzeD8Ux5AQ8Cde0RUw/omHMRuyA2HhnbRhWEmejVStQ=;
 b=xAkYrPHn2yi2+Xu1pd5eIUH9KD/E6hnjJ4pz0SHWA5aYRm6wt5tilu0OPgFjItr8I5ZwC/8zO/J2o6qyBGgAeEpVywr3d9T4AULSgsywBb65pnkz4LDt8lj+VgZiQvzMFPyVefOarj3uNGXbOfBiwgBkOtK0IqTupDo4VgZISG5b/o7m5yDMsnP/rhdqO+RmMDjGUyIlqM56cD90j3GlpR2F5FliC8aYD1s7HDy3lbRWAh/gODBfIdF5mTw/D0Hnhlo7IZutfqPiYGWgjuhRc0W4htBhpDWsZqGlYEhJy/xV+qCWi6F2tuVDkdQvXU35sOD9j2l6ZXxF6O7taLOknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzeD8Ux5AQ8Cde0RUw/omHMRuyA2HhnbRhWEmejVStQ=;
 b=cX8Zjjwgjo9FWZUnvhrzMIAHQsQUCNMvkcIfgjzgXJEASv959o3XedvCFStakkdVlz4kJ3ZPJ885XwqBerlPv4gOjheYnLJtKqtCFdTg/tRmKDhLT2efu/Pz8CpXCB1U5n4ZWwa2NHOhlArHViIFO100qXwC7I+K+9fHsljWe7Og3ET5xaaEqoi6QosOalNQl2OxxnEzXZhQJDY8mMiECRUBhwSanp1CVEp9pI2TIHlN00/O+uW6Jn7FlZaOrRW2d2/fcB4P3FtoUUlNIc8AbEpJFJn2BcWGqU4O5yoXxuRU61EP3ZmiIEnSXQcZ9dvPWflfVlItProqrkEE29nkFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11134.eurprd08.prod.outlook.com (2603:10a6:800:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 04:15:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:15:00 +0000
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
Subject: [PATCH 12/19] airoha: add PCS node for AN7581
Date: Thu,  4 Dec 2025 07:14:26 +0300
Message-ID: <20251204041433.3459826-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11134:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f099da-b1f1-4f24-6961-08de32ebb129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZBOSSrQdEuB9R7lCLEF66n5ePr+vrolPdPnthzzBSI5mBXgBAx6yL6D9Tsm/?=
 =?us-ascii?Q?KCwCyG7MlF6/0lcpvY6XBs5WcEEVkXE6U52aihuCOW0RKI8YhMC/f90Q+A4t?=
 =?us-ascii?Q?AkTbx53CfS8VvjeO8VOEBl0hm0cX8MeQsFgqRTWKt5Kx2+6iBYiNmOrYjKgs?=
 =?us-ascii?Q?zipO2EEt0JGFB9YsrGgBX5gwNt7NHNTBcOscMzuK43zcz/x97ZJKZRHrz/AV?=
 =?us-ascii?Q?yFKf1rarSlZnSON+nBpm82FAjqbpV9VfuImeXp5KDj5vQ/P/+unK3wiYvovx?=
 =?us-ascii?Q?pmDptRzsgXNtjI38Sn+DiP4G7G7CrA4PUULXpQme8jB6YWbPzo/BdPDCoi5z?=
 =?us-ascii?Q?iHoumnMKkVv6MgIKfKwLNPDrYet5MrU0Gwykh3lYQ9q9CTnnSbU0OkGAg1FS?=
 =?us-ascii?Q?5HvqkFMlCr4RDvke/M/9ydw8IlyNTOlQkSn0WTq8bfrO0D2CiEPI/3Sju+UN?=
 =?us-ascii?Q?A4B+9eJWrc4NGfi67eltY6BFMzjBOPSofNa43BmwUaCwVxa6Jj6ze2Y0sy3I?=
 =?us-ascii?Q?oKwD3uU6DSnS+lhSqnZyyOSUPTpmUuLcyH+4YVeE0Lh0Zm9IeXVrb6hV2Mn5?=
 =?us-ascii?Q?SAnaaEN1WiLxEUa/RRj36GnOcknNh7V6Ca1y7j8vBmccJyh4KVOdj9SIbITm?=
 =?us-ascii?Q?KeuFu3XusVByKkPeIJgsLxKkpzcfb4gRn+c+p7iT9ymbpwB1OQJAqyhfwKnE?=
 =?us-ascii?Q?7nw2xmPjgMU0+T88LOpDPx3sXwvpNF6MDt2mHe8kFu0jImZ0YHhzwfQmmgcz?=
 =?us-ascii?Q?95yZSeEqV29U2ShTVMy1zyaZ+YXJtc6nS3/UICGhimMwJ0/BWyYQpxvnajvN?=
 =?us-ascii?Q?iD3HWXrWxKIpl8ecb2ekdARHzua/av1Sfs03hvEk2L5lZaMf1rTW+L/e4j5j?=
 =?us-ascii?Q?Fo6J5RwaqCV+3Q2qwDj9XnBoaC7PdnqRNX+8E0Plj2Kj3t0KK5C9bCZXhZG4?=
 =?us-ascii?Q?B6T/WuqINnn/aSxAap7h2wwigjgZYZDLvD4OfAxv3RuFAySk587QWBFc73XW?=
 =?us-ascii?Q?BzEHjAFD5P5t/csssXYQNy+IjPfJfygOv8n0GaggzUUaHoSk+ZiRUPacSh0I?=
 =?us-ascii?Q?LWG3tHgPONPQpRswZRLfzLD0AO9Taov3soPSws3waSPJSfetmMzXd65eMACn?=
 =?us-ascii?Q?wri9v+wsl/ynOUHMHlv5n9I7h+xiH38PgdE9UNALLu2PTWI7AUa/30Wukpsf?=
 =?us-ascii?Q?FOM/Fw/WgAiI/A1Evzygy/07gF4wh0M5ZkrKMxQ6JgN/SmGbgC4LerjgkXwZ?=
 =?us-ascii?Q?7EOe+bMtrXe8iBAjzXzwNZgBNUDrizAfHlykELw3KePpPOB9VSaWvhfgxykP?=
 =?us-ascii?Q?POGY3V+HqvS98epyUTkBj99yfNpl0cCaDfnhjRYe5g7EGknC7JnXrQaFM2YO?=
 =?us-ascii?Q?/PlnOMv5G4HPSYsYoKcDlhFZycMIbk83w/GREEPjfugXAif3v5PohXpRcGGC?=
 =?us-ascii?Q?lHArAjdzznf7jC4QLt4UEYc8fv4EsmB4hNH49v1M+mEt9hZSPBrPlCpS2j7o?=
 =?us-ascii?Q?VlFpsWXLvqZsOio7CiBZPJMIedAFOBOvzFHuT7aFWduyMFOFO9GJqvYEEQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOorafYOEYls6Oz1SVhkhQX4HGwsoWji2HYTz+JmlRc8hlAK0TjGytS081KF?=
 =?us-ascii?Q?PSCIkW2YcXQYeePCx4jvYVOU9oe7hAcKFEl1qrBH9nCuDNEBZ+R1dBjoPj/f?=
 =?us-ascii?Q?vim3XbdBnN0GsW9u9mI1s4xuHLdVaQXX7QRFNXCD40N4zV7DjCWDivXnMBff?=
 =?us-ascii?Q?yZMJ6tVreb8z9bfIXQRzG7/MISR1wvdZm8YYD/2e0mybn52H0QhUjyjCwkfh?=
 =?us-ascii?Q?96fDAlVNZnn2iBaGy3/d695LQH+apEPzZLjmWVh7ys9r4aEEt+Jxy7SkUesP?=
 =?us-ascii?Q?4ift6pYPBoEaDpgJL+f9EnwvGknavzJwI6ApEsomZCnO/cU03Yep2DpsF1O3?=
 =?us-ascii?Q?RIw5YHvfFnQbrOJlagT4ZBmbXpW10EdVP3tfopft26eAlNoyERS4z3lm+QnD?=
 =?us-ascii?Q?3D9JHsop783Tjb98gmqeshG5G640nE2nVM+7nZsxBUNtAzAEk1L3EQ1Ul6JM?=
 =?us-ascii?Q?2qEtSA5RDycFu1XodsSAhTfZKtWDa28gIRRNF5Syr7fKMhHtNQyx6p5n/E43?=
 =?us-ascii?Q?lbZRkXwuawDui903AlIOmgI3mBioGS0Ex7dOptNGFPyakvG/OZ32iUPgPaCb?=
 =?us-ascii?Q?xVwKbmfp0mjDbYdjwTWrzKx6UDRKy7hgO0Ct+6qcmyr1je5OAtf3UYMXPq5s?=
 =?us-ascii?Q?q99T1YjIR3t/G9Uo+/90XpoExMSSg54iVBA5aBXCGEAc2aHQ27G4Ruz+3FpQ?=
 =?us-ascii?Q?p5wZ9YcxNLRTeOfZKMA0ca1pkufikDMcTH0L7F9NI7Kdvz1djqz+4Bu75A96?=
 =?us-ascii?Q?INXEGpjPg+mgfy6f2uSoW/ilCeMLLM4FACDBh4GRapGbqFNI8ukNW41uUNva?=
 =?us-ascii?Q?h6bRz6UpAwCWRJbEdboHW3B00Yad3AX4iFtY5d/GeAa01TuWVEtkfvO00ldL?=
 =?us-ascii?Q?Evr+puPNQu0tQ1Wh1JZY/8pWRswR7nKGXQQFun4hnwMEBfh+68tlgVCTLhJH?=
 =?us-ascii?Q?nbafP/D2Mrel6+s9MA3WaswSrDKX0V4vggF8ABMx4Gb1LqgYPORIwbOjodoK?=
 =?us-ascii?Q?IoR2wVp+ud3E1/fGN0aPqteVEz8zHTbenfiCGRfhLfs33upvdVfX3IuZ36bx?=
 =?us-ascii?Q?V6toCEgqcOJU1HNmkWpptDWOIuHXo0aHd3l87KMgQuKudBJWWNxjNoVbju+/?=
 =?us-ascii?Q?NU5VCgAkjmH4NKFj/Ch0aywIxNK79W5hH9R92+oB3BuYqoyNn4SMe9aOkDYz?=
 =?us-ascii?Q?flKq1BLyXwokBXuI394wvuk/PcZGBr9g/+fnWJahd5S5h68SEgEcDwJZkvWa?=
 =?us-ascii?Q?CbS37Ol473D2b/1MitFgFdWL7HYfOz2nBaba5ljlTA0EELqo+0wvqEgD/uiT?=
 =?us-ascii?Q?U6IeGq1kTw2etH2xmnMeI65P+BQjIYSCEREFhTOpeFW5Mm4x/Lbhpn+IvtFN?=
 =?us-ascii?Q?v1h9sonIEdJBBj8VyPh4CIQwUu8PpbbhG8Or98QnCCU6ms7oI+0rAf5hO6XJ?=
 =?us-ascii?Q?4ouvwEMszJKiiE//g70s+CZdUuQdcoka3tr3uuXmRe9HPA2l5X0KgkPRyk/3?=
 =?us-ascii?Q?aGWztSRMflhHimRUKOBA879k79CK5bORakL3SKLrdAgCCkDLI+d5zsF9zGL4?=
 =?us-ascii?Q?zY0no1DmvtoKm7FefwcuzT0OABxfqP2pht2b2SEE9h4p2E/bCCJKEUJoEyfr?=
 =?us-ascii?Q?dPmMGtxtBL2c9WWzFq354no=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f099da-b1f1-4f24-6961-08de32ebb129
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:15:00.5960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt+IUUrHtCBDIumswFh/28dxFCPK0C8JQUHi/wVMlJHL+pA6N69JybtPs/0ZxXVtWg2PJL1kSuZs58+ViFgNH8rFdPVVMo4BQ0OR9SqbMU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11134
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

From: Christian Marangi <ansuelsmth@gmail.com>

Add PCS node for Airoha AN7581 SoC to enable support for Serdes Ethernet
and PON port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi     | 71 +++++++++++++++++++++++++++++
 arch/arm/dts/en7581-evb-u-boot.dtsi | 18 ++++++++
 2 files changed, 89 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index a9297ca6503..9ee0f808660 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -35,6 +35,48 @@
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
 
+		pon_pcs: pcs@1fa08000 {
+			compatible = "airoha,an7581-pcs-pon";
+			reg = <0x0 0x1fa08000 0x0 0x1000>,
+			      <0x0 0x1fa80000 0x0 0x60>,
+			      <0x0 0x1fa80a00 0x0 0x164>,
+			      <0x0 0x1fa84000 0x0 0x450>,
+			      <0x0 0x1fa85900 0x0 0x338>,
+			      <0x0 0x1fa86000 0x0 0x300>,
+			      <0x0 0x1fa8a000 0x0 0x1000>,
+			      <0x0 0x1fa8b000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk EN7581_XPON_MAC_RST>,
+				 <&scuclk EN7581_XPON_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
+		eth_pcs: pcs@1fa09000 {
+			compatible = "airoha,an7581-pcs-eth";
+			reg = <0x0 0x1fa09000 0x0 0x1000>,
+			      <0x0 0x1fa70000 0x0 0x60>,
+			      <0x0 0x1fa70a00 0x0 0x164>,
+			      <0x0 0x1fa74000 0x0 0x450>,
+			      <0x0 0x1fa75900 0x0 0x338>,
+			      <0x0 0x1fa76000 0x0 0x300>,
+			      <0x0 0x1fa7a000 0x0 0x1000>,
+			      <0x0 0x1fa7b000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk EN7581_XSI_MAC_RST>,
+				 <&scuclk EN7581_XSI_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
 		eth: ethernet@1fb50000 {
 			compatible = "airoha,en7581-eth";
 			reg = <0 0x1fb50000 0 0x2600>,
@@ -52,6 +94,35 @@
 			reset-names = "fe", "pdma", "qdma",
 				      "hsi0-mac", "hsi1-mac", "hsi-mac",
 				      "xfp-mac";
+
+			gdm1: ethernet@1 {
+				compatible = "airoha,eth-mac";
+				reg = <1>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gdm2: ethernet@2 {
+				compatible = "airoha,eth-mac";
+				reg = <2>;
+				pcs = <&pon_pcs>;
+
+				status = "disabled";
+			};
+
+			gdm4: ethernet@4 {
+				compatible = "airoha,eth-mac";
+				reg = <4>;
+				pcs = <&eth_pcs>;
+
+				status = "disabled";
+			};
 		};
 
 		switch: switch@1fb58000 {
diff --git a/arch/arm/dts/en7581-evb-u-boot.dtsi b/arch/arm/dts/en7581-evb-u-boot.dtsi
index ebd3b8b4958..9a02122fbfa 100644
--- a/arch/arm/dts/en7581-evb-u-boot.dtsi
+++ b/arch/arm/dts/en7581-evb-u-boot.dtsi
@@ -9,3 +9,21 @@
 };
 
 #include "an7581-u-boot.dtsi"
+
+&gdm1 {
+	status = "okay";
+};
+
+&gdm2 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+};
+
+&gdm4 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+};
-- 
2.51.0

