Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AF7FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 04:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97398416F;
	Tue, 28 Apr 2026 06:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ub7sQI1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7865D83693; Tue, 28 Apr 2026 05:11:15 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284BC842C7
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6yZ4+bg8Vb6kDDEVAA4ahrBVTIrnrorgxzydjBn/5R9nkROG6kBO9voSsZothgp15QbC397qCEiXwB2RFLuD9ygdkj1RaszDmYbHnPD8+di/iyMa/SLc07MyRFKE8HaHGpJPRvfbXqMBtNES1kXu27eIvblrjSwDSy3eZvSI80wHBetD1k+OmxBM9yqbrJ+PODeU4nqTWoP6+0YKxj+r3R7o+JeImRTTk/WIH0ZBN79piHbvFiNMg1+UVnh10BgWYtaqQBJMAsQy4UifDw9ILBauquQFhOIh6HTH23GzfIrOZ8H7g6ztqbyVOS27Dj8j0A3SwIOoVOynW1ZsHdPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4tpZ+b0DwkwlYoIR2g4O2InyZ41XG9Mt3cT4Eulhfo=;
 b=Y3KI6UAtSWHQperIem5QAjx+kPSJ6Ae6+1wBgqXBVH0Vl/JjJd7Zindd4jrzUqMltPo1zhGHEjGkBCPgMsVU3lv7y4U+H6G7EN5YAZsdEACMtqVK9+Jiz5E8fDNRVL2f3uKsl//PC2LOZ5qaxdA3XBKKRUCPBCIXFPoCvBcBpMNHZpK01CYkX4ErhaXzS7cV35MnxPXQANnrhQEvDRn3UsKy6UB8npnhWAlowT1tTCSyC5V5Y3kkBV4ZFM66x9nXDTBVokcClu5Lfhvh0nDY/Jixp+BohtJyA4mQGXGj2GZCIYMFLSTQCNTjTQ9ZR3Xdhw0iLrMxbEFa+Ew7pbuWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4tpZ+b0DwkwlYoIR2g4O2InyZ41XG9Mt3cT4Eulhfo=;
 b=Ub7sQI1+DUmhRlt9KFJYZIpalLzhtJf7lOsRn4I3o3lLFtA4PI8qeD9eO6TMcT01gfblhbv4VM80KJpTdqO3TBCfrVsxlh99jjWbL9HaJGisxwnsqpYiFvE+Ba48DMchgXzSZdS12+8jJ8PoYfx4hrmAgtqGkgRqfV5U8ScyAU654e9KYl6P4wiOkIULWFd8MCK5bqS8i2G+RH58OFV437t1oqYJ1YmdY7OXTzrrraIofbi4HKBUiGFSoKvEsLhx4kyPE5IRgSq9FpyWxDDBTIwIrbBgz6L5UXkmtz67Y3Gzmzrh5uIxHskN/qFtahQv1YgDgESbVemaniIorcWZUQ==
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
Subject: [PATCH v2 2/2] arm: dts: socfpga: Enable 8-bit embedded device
 support in Agilex5 eMMC device tree
Date: Mon, 27 Apr 2026 19:53:31 -0700
Message-ID: <aa3bb421d60965e147f201d1739830b42ccd7124.1777344421.git.tze.yee.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5098e6e7-0b78-4ad0-0fb1-08dea4d157c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 6mNLFUgPBzpEcm5U5xQZZk91PvcntLdPj/d09W3tXbft6rjRfP5Rh20FdT0wqHBvJlLF31OFBoYTglFqynmsoOvRE/9OzJN/lKVlUtDp30DUHHXjSExUd44k3WDLBcHn+XFqs+doCcM4FrclMKD+cSwoEjwqLkjBHYVomfOML/B22R4Y7c/UOkJ3XoGEd7MeNHhbJMgmH0uyJKg9/6lr03hOy7bMd1kITvqSasgVcMKgLLFASAzfsMPt/qYPsdcTZll/sF95dCEkQeVI2SbYQad0RmcLf4BBEsqRTkWV+n6XLk9kwAJCwhVZzPRm0AjXsiMZcybFC/bh8okIN0gJahRWT7gShQJ7aI4nxjk+DVS+azfvHecoOLlVtNBOIfSQoi4BNWLLqxr6MbBEk8NhcM+BxAabvdt0SAzCkgHkjV7zPgUlzV72DnA4kQYnPQFCEZ0fLRWXND4px1P5qO4yQ7aILmiqm/voggqqJDeoBoqa0qI1sbf+SVVmcE3SFuMi+pi8mOyfBTaoJcuJsz1obT2KO1X1wkfpGIa+MtBnuTRTdBzCdhx2V/5G2gNnR97V93GPfBUnjVD4tWQt0BoKad//wjs9Ie31QwQEsaFCM+i6wKYOqt/3ppbufwCrLShR2rYqEON7zTt+x4f7iYcqE/kYiXVYpwX+0+UbYJUpEbHm0n0PgYLRPrtWhZx7Pu30UwZXWbe+2fdfkTupIu3dpgxJdxJa+x6dhblmgRJ9QEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4HvttbT3LBjSABRVVjg7IayVP3ZKFeXntMSJuaSudbeJi6UE0Suz7opKkYiR?=
 =?us-ascii?Q?SHanTvD9XkRPNGaUU7Qr8tZF7LPNEQwGG2r82nSrzjVGmlRaDOs5CxgOtiJF?=
 =?us-ascii?Q?f8twpMywXSAmaA/hN6yku4dAAmLP65v/ulJiLadmminNWYNYE7rrc1sLhg5i?=
 =?us-ascii?Q?lsP9XOgiTPu3MG+frHdFCt9xlz0NzLqxREOl+SGS51Mn8CWuT80E6WR8LZk+?=
 =?us-ascii?Q?ac7Hv7yuYFiBrsmSM9LjCNsntmrMFz72dunr7N/ED7dyd/6g8ShBMZ37ZnTL?=
 =?us-ascii?Q?hHki4TX0SS6yaXQBSsc9j+G57HqxSkuWoqnfq8yS5BzR5c4g2c2YkCxaVz0p?=
 =?us-ascii?Q?fpCcOm1apkpXkOprxeCW6yQ7SysZEFdSaycJvcoLlyxeSAp7n54sugcCYdYP?=
 =?us-ascii?Q?8mtznw0HRHJqwxMlkeeTp/0BaQ9RCx5CcEE0gt5u6PuTy82mYAJiRP/0Ky2L?=
 =?us-ascii?Q?wllxa4Yt3yoizmlUHD3ZwbMw49X9cpnUd7TBXnthjZU8k+uR8jG2+/QaUjIo?=
 =?us-ascii?Q?SnAIVnRDypkW826OcCOJhJDowk3sOOPRafvrxL0Wh6rU7RSsGfWYk9N+nmUI?=
 =?us-ascii?Q?SuTW5PFs2fQytvKklJI4C1Yv+Bo56cMvZk88FgroU2YJ8K7i1+k0Pe9gHpYX?=
 =?us-ascii?Q?RZRFbkfH/umXK0PxORmPsvbnJ2gkczFW1Rk6FNrENX6seLr8bCfSDpOA/AZt?=
 =?us-ascii?Q?Gh1t4cOXSd40kNPF7cNC0s5mildwnawVb2eoqZIY/yZpoM6ySuqjt0V3dVXv?=
 =?us-ascii?Q?MDpV+5NqxAnTOvtGz9EsrLQSUkdqV4HleWaVXL2Q5m8ZUX72/S8Z8Bxzc3+3?=
 =?us-ascii?Q?7VBB33fMjY+rv6r+kv0iZTE6J1r73LCbePA/NPuUdIox3J9N2hgSZovX8eKW?=
 =?us-ascii?Q?uf/PEJJB/nE74tBBcgYPJN4zay8xaR5OT8TsFPs8ZkWMDLyO7eHUEswZ4atF?=
 =?us-ascii?Q?vYnbCPNmhBWGPpUTmEceY3Q+Fs4rNSb7fDXXIyp1oKHj7OBqwtH9Ctlci3lM?=
 =?us-ascii?Q?21rKAHE8xLmjH+R4zgBN2oY0LCRcqJFNpnBzNDsIw/2yqk4+ndITWcETKlSo?=
 =?us-ascii?Q?RbnqKs8C9ruUdPJCApS3QYOud+46x1PkjmU3O2iiq+T2mjeaoYvgrDA1tiNe?=
 =?us-ascii?Q?/7YCsvawUHsNxwCn8o31hTC4+SgPFIS42is8HyZs5jUS9/dZzTcyYGzLsPS6?=
 =?us-ascii?Q?vCGatcOXHEvz+z7vUJ019gckycG4sbDAOPPDKa+zgs8ZOkEh0CWPYWBt/jvg?=
 =?us-ascii?Q?DfXvRhYbBHJcIkIP+N9ewg3886dtoEtjHLUDvDfu1p0nEg7EJzLX0Jt/TO9T?=
 =?us-ascii?Q?fHnBv5s3OuXjcfosnySCHAeCNgOZzY7txfm/0rdyFNuLaFcnpJumaTgNQLgq?=
 =?us-ascii?Q?TV2R/ZntORYfGfAywd+/z+rZUGLIsH0eBm3xgkAIpQK4a0yiXQGDSordYzeL?=
 =?us-ascii?Q?WBLYRJboDRRpsYqHBBALrvTO5QTLBdDYKK1ctyPSqCp/k5wOP53JJHE59/R+?=
 =?us-ascii?Q?0FqOAZKHRzqcgVJ0+/odAIxLRXOz5x+ej0EKPxFq7rb3NwgyVPnzxKZEfc3v?=
 =?us-ascii?Q?0o4R6+x2CyJ68dNLRy0IRB5b3n7kWJaLaPnwl2ArEl8R6qDJotOmTpqK3FA2?=
 =?us-ascii?Q?OOUv5GN+z8+taZCiPJLhogTqpaJA+Ay+r0MFRjS7G7poAOMHlYY+KG5O5Uml?=
 =?us-ascii?Q?mb7uLlJ8oGt4f7T6YKRRTERiCxl+a0r1nJ9fozWm1Kx1FgDRiwvnO5lAnB/2?=
 =?us-ascii?Q?uMMj7C0DqA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5098e6e7-0b78-4ad0-0fb1-08dea4d157c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:53:36.2649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+2kZs8cQlNPt7JEdjs5FZKlAOmBrZt48ZUcc7f969ScTIgHXtrxohQm3vqr/TyJDrzdGx5RI3Q3jfy1lF1I5A==
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

The eMMC device tree inherits the configuration from
socfpga_agilex5_socdk.dts.

Changes:
- Set SDHCI Capabilities bit18 to enable 8-bit embedded device support.

Signed-off-by: tzeyeeng <tzeyee.ng@altera.com>

---
Changes in v2:
- Remove /delete-property/ sd-uhs-sdr50 and /delete-property/
  sd-uhs-sdr104 from mmc node
- Fix wording in commit message
- Update commit title
---
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
index 92ff8b4acf2..52aa92e4292 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -18,7 +18,6 @@
 };
 
 &mmc {
-	/delete-property/ sd-uhs-sdr104;
 	status = "okay";
 
 	no-sd;
@@ -32,8 +31,8 @@
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&emmc_io_1v8_reg>;
 	max-frequency = <200000000>;
-	sdhci-caps-mask = <0x00000000 0x00040000>;
-	sdhci-caps = <0x0 0x040000>;	/* SDHCI_CAN_DO_8BIT */
+	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
+	sdhci-caps-mask = <0x00000000 0x0004ff00>;
 
 	/* eMMC legacy mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
-- 
2.43.7

