Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E3FFF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 04:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E27984236;
	Tue, 28 Apr 2026 06:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DSKDSsYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C3D83693; Tue, 28 Apr 2026 05:11:15 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7791584307
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+31tIqFJC3Xdjerbh9JXhWV1rTfjLnG/DP/ILN+bcpK1divuPrHn6SCL4U1ffH29uJI5J3WQxd+cgdgxGHzTo2CsAFSZJsQvLpjP9/OAwez0RGDZ67A4Vhi8xxqMy/K27/YLa/O1RCguTiCZfRhbRNK7MElP8eIfJMaj7DQbDSwAmR/3Z3yIZBJIZHRdG0MP9gnEAApFtTDCAUd6F0B16Pd85ON8YrCJ2oBYY2IXhPu7kmoK0KJKGDwtEiVRNIH/sYu/XtYmmrbc85LQI+jxOIUM3m9sQvW77+qjpdvSnlsntRE4cc/4mmplmA/25X4UvoJ1lLBRyXnTY5OEqTbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/MO+1xTk6PcBFm+qaSzXXUdz8y7hrzyoseyNuT7/Ck=;
 b=bkV9HEp35AGAdWTdMcT9hYymaGqBykLvS0Fn74Bl3S3SLWks45Alx5zgvoL3oF9OIo2aCRsslHRsXE53iK3a1Jsk8UTP4WPWCWKJW4/JXxGMXVxpAkushAQnyNKybmuu/Yo4DG/YYttGrv9bnNhpMejdLr93ctmkMYny2xvkzmwyxkjf+du0QS4xA45EvmiiTkGyrVwRlKZKExjv+RGEzpgHisRwRIp8zVe69ZS2BVgh3tVJZoroi+iyF+vX//dT2n8FQGQoBcS3F27jNSX6MbA6D3nTgnWqUnt0xAJeCawmGpTL2pwTgF85qKK7sSF8Mqu45mTsdGWiUUV2KwMK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/MO+1xTk6PcBFm+qaSzXXUdz8y7hrzyoseyNuT7/Ck=;
 b=DSKDSsYiJyiAiaLXJiLU0ifWn2DpmaymU1KuctMgiqptFd0htEZaLf4/t+pD/Wj3Y1KPCxF78tGkG/3780QRhJwif0iEO3yfpfIu+kTH6MnUOEsjolVa/IE9g4JDVpHHcv57MaNoWbecS1bAVPXT8J0mzm4OMt62l5WyMIyiBGMnlemjlY6e8Cvs32cUO0HDWR3BzFuHFW0cDdy0KnERwcoSMTNXig7jIYdYXKRKwmlrO2u9DP4UthegZ0vSDmCsqnvfWKBGwHraOXMe1SHWKBiH/ko2JAHpNCtnhrDtym7XWkmQfGtOCfMZYLFeccG0Q5lR8D8imGxPnQuIJF4JUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA1PR03MB6467.namprd03.prod.outlook.com (2603:10b6:806:1c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 02:53:36 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9818.032; Tue, 28 Apr 2026
 02:53:36 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tze Yee Ng <tze.yee.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v2 1/2] arm: dts: socfpga: agilex5: Move board-specific mmc
 properties to socdk dts
Date: Mon, 27 Apr 2026 19:53:30 -0700
Message-ID: <41ef35e20aaa0a3bd37a153fa88a36fe3f6ba74c.1777344421.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1777344421.git.tze.yee.ng@altera.com>
References: <cover.1777344421.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA1PR03MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 218bf992-2557-4ca1-c72b-08dea4d15773
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: delfvXZcznqxQraR7IV8Y4e0JV0TgPVqse+1C2IVhhy49n2OnNCoEev6P+/Lv6yz8fkhHerxJ7Uk1Bsv3XO1H0qATm6bWXv+7nrgEeolNtlwVK0mZ2sqDl49TnmReJCUAs59jEjA26m9YCSbkOdLUE2m2xS4NzQa7EUxLUt/iWgeUCe26BShYXTe9NYO9nw/kDuDgpKmKcxYecZ/MuNIKOlvs6DyJilKziVErC2zwFCDf3J1IjeJUzCJpDARUobI8IM7tg8lwGavUW4Q1eDW1m5v/Ie4fT6uFgXmZXHuXeEdS3QtxgN1H5hX5tqfDDSkbSCNB1w9DkAnEtDWhGsPbDlAmzuMcYkW0+XLw9mLiNqU9ZbVDl+c1QUEmIjZz3DLLq+FMD/JGQmSGiCM9IdwaJswJE586g2iiAj+II152/6ZsE2RXRejJc0Vm70PgJ4FfKGdKkuFCNBy55utAd+1H8MSciaZBHQH7u9DkbMtT/23PyKI8EcqxItLyw+sjvMg2qhw9nMg9UPc1waByWAh3kUyDSatD1v6C6QqJZ9oYD1lAso7sUR7y1xYNPLlYmctbyFdtSO4faRoRSYX2Ceoh2Jf7OV+0ctJCrg1rwvcNzkAZ48f8qTW0Bc3SfBit1PrZxb7Q4zffvAwysjp2z7FlZq9OOwMuIbLgBPCGBgccy4xjmrCAR30K7gHdT7yxx7optobcz98OuyTVBrxXnJ2hKCzXnbYBYVGikGrT0riPUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/K9U+j+RnKWq6XLjpDQUXlQoey72uK4XzEkPq6Vwi1iKg5QEHb9KWE8hU8Cc?=
 =?us-ascii?Q?T1qEd71Cw4UeBMWj6PwtfsZs9HWPN1jWDn6izMD0z2sfKnJbW7fQQ7ZSCNgo?=
 =?us-ascii?Q?hj2qf8ClFwdn+AVFwTstomWHusiqHevF3UMRYoggwEtBM2cjf3q4Pu6F2XKM?=
 =?us-ascii?Q?xOSqWObjWVnjgyNKlXun8vNUnAmaMgd/JOAMKh+WWrMjsApNp0iSeneOYAUg?=
 =?us-ascii?Q?5JCsEi9NqC9fv0vFcEl9MLo2Ff2ZngWrLKkoWddzMXSqHsLM2wrGZZsGuMzc?=
 =?us-ascii?Q?BEoUcqtpcnBEz78f0s9bDD6exCj5Uyvfo9pTN9k/L9mfax6kNIC7OegJ8YpE?=
 =?us-ascii?Q?BJKXzuqKVAJHPsmhuuspywE8WF8lsX2Xy3iE29DkaNJnzziVMFwXfDfJaVSP?=
 =?us-ascii?Q?A50Z17rnkJJREXCsjclezS0mVsKgfkMr641uStAMJxHlOcp4rK2kIa3UATsj?=
 =?us-ascii?Q?XA4XfgN4xFj3ZgSLsv2xzkrS/nwtpemVMDFNLlyenLGlfjrdAEoTksrE3uc6?=
 =?us-ascii?Q?lgIBghhgU91kmLJ1nhXibgse/iJOHwrpcJ8X8meKsw2Wgu2U6a0ugmUUATOB?=
 =?us-ascii?Q?r4UEVXByJFJnNr/LWCzgebNJQAkrTaTxVv0ZIUWPqKcMpl918+TQ/l2x7sMI?=
 =?us-ascii?Q?oAZVxzUvzjgkhLMx92g7wanBvg8kvQWz6xI/U/wtvtkOtP0csZtjlWDHELZa?=
 =?us-ascii?Q?GyQkOwlq+rSWRh+YRkWw9FndzyUJ4Js6tJQEYtc2i0esr6QMgYoA9r60uiQa?=
 =?us-ascii?Q?sDhH98VwfiPPPF+VXd79Sj/m98qGf8QKhbEY/Il/vUmoBL35MOsHt6c2u8+W?=
 =?us-ascii?Q?l8tzpU/ttB68KrhIkWauwdb4FdQrG6sjVSjLL4twfKIizUn+hWxTZ3A6DsKk?=
 =?us-ascii?Q?AplWoSxeljzYKIuxHBCs4nZVtJSkBY72v43mOTJzTh1IZcJlKEWPSWaeFMar?=
 =?us-ascii?Q?dxJq/BFOb1suaYsKw5bad3PsMCMbiDbN45xEgAnXf1/eKA0i6KtbsNdYxDsx?=
 =?us-ascii?Q?Syj/NnaxacOKxzKl3MwhU1C+QkdLspl9uiO4Przues6fjPOaDOnRpM3IP+3m?=
 =?us-ascii?Q?JAy0QBHtalG0zw4VM01QwI+Ovmk9yHYZeL6ggsZpHJZJ2QKSxmtMcP3Eeq8o?=
 =?us-ascii?Q?s1EOp1bJ+v4wv1hgLY8834ybkUHH8+fqwM6VAmdUlZBH/1DtfNjNjpwWNOtL?=
 =?us-ascii?Q?O+2JwHdPFx+JhgPb8e4OmLMIXUOxytI+T24CxTYrMm6T7BQDy5dTRv70XorM?=
 =?us-ascii?Q?zlb9owS1O/BrVZEojMhDqULYxw3ILyP6rbxIUhPQc58dYd8pfaU4jzfg0bT0?=
 =?us-ascii?Q?+EqYvfzXjZ+yM0LuNHG6SjqaI4VPYBlBPh06t0mZE6zUeye4rqUBXli+GqZO?=
 =?us-ascii?Q?1Acr/P2Di+qn5OXS8G6zZFYL/4HaevDKfz+9/6MG+pcV8jABTUv+h3p5ddup?=
 =?us-ascii?Q?r3muRj3jLZ3JhEkCrAYq2VEPot4bDTLZzQIO90otJLq2BpuHL55ccFVxAkLP?=
 =?us-ascii?Q?WawiRCRAXNbzUY8ZxvICgKph9Q/x4wsNRwWh9cFMQDzl5R8td8mflPW778+e?=
 =?us-ascii?Q?dGnbJBtd+KyYj07qYKQQ7MtcRj9CQ+T56i+wkv9LSeDnzrxLij3YEjRSKjQh?=
 =?us-ascii?Q?uA842M4XJNAO3gnKcbVXDh1em3whubuz//YVekv9kMtZbA/8msM+REGISU6q?=
 =?us-ascii?Q?jfrjb0gAy+kif72xVhOQlMOxowxzz47MypvjM9jJTgkQvWdUkmMAL+IZrelD?=
 =?us-ascii?Q?pcoZ7A9h9Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218bf992-2557-4ca1-c72b-08dea4d15773
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:53:35.6927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73nF5x+zQ5CWJiGvdEExp8sGci3Aitu/msjihaDxNAKZIz7G6JNs/VE3sd19EKBWO9uAV5pUASIFlYumygW8mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6467
X-Mailman-Approved-At: Tue, 28 Apr 2026 06:27:12 +0200
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

From: tzeyeeng <tzeyee.ng@altera.com>

The purpose of this change is to keep common configuration in
socfpga_agilex5_socdk-u-boot.dtsi and move differing properties to
socfpga_agilex5_socdk.dts.

Signed-off-by: tzeyeeng <tzeyee.ng@altera.com>
---
Changes in v2:
- Remove both sd-uhs-sdr50 and sd-uhs-sdr104 from dtsi.
- Fix commit title and commit message grammar.
---
 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 3 ---
 arch/arm/dts/socfpga_agilex5_socdk.dts         | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index c03f78b2fdf..7300a54b223 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -112,13 +112,10 @@
 	no-mmc;
 	disable-wp;
 	cap-sd-highspeed;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
 	sdhci-caps = <0x00000000 0x0000c800>;
-	sdhci-caps-mask = <0x00002000 0x0000ff00>;
 
 	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 886cc89fdb6..cbb2bfbe3b4 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -74,6 +74,12 @@
 	status = "okay";
 };
 
+&mmc {
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.7

