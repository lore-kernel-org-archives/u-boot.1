Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DFBC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E63C84AF5;
	Tue, 30 Jun 2026 14:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="m35j6T2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC7284A48; Tue, 30 Jun 2026 08:57:05 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F11984979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncvrH6AvuQgW3ltAXQL5bcRg5thgS9evHWk9+7VE+5gU5CGsYpLD/tQw5wm2W3JD1UyevRWVxKnOrNW+w2G6b9PAdSNeKCzMXxHTlSEcrUzm0p5SgbLkr8IQuIiQmdxFNKavgm6pjvYRCCKya0vc9yyDU3MZwORe9bKQN3x8OPGwGVx3sx2OXSQkzWStmG14lFr7GudW8YMoDsKqyTEhsnIYRzzz2IdkWWhGCnuZ6l02G8tWSHTjwcnTyb0c18kVae//QmfQ5V5AUqdS9qW1bMNCEc1Dn6a30tPx0GkrAQowAgyrylS2TH1r0SxH5dn5ly67S6U5s3jVMnpd0M24dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/67lmYi+voOMGLp1Ed9FQa+oyDIhl+zKp+ccoJZ7yY=;
 b=PcEWTg50pLjezCve+JKwHx+jsPB83EPNbLXyCu+YgYBEFFRPfcrejOKZBh+EhV7kjMB1pbJofBTHC3DfA1lUJQ8iwp83pCRTtlK71t9SQgila8RxmLp6/GBvGFn3WXnpv4FDfvFZJg4OOAgIpeBFYI74Q7nd9/Tafq2AaQ1oy0uzCpQB7xJRc8xS0C5aMUJyYnHuCH2YHMQgruxYmKcmecz0YFa6anrNuS5oz3OZxCspkgWgajxd+LtQjrcK3aJNZ5YswmvjyCVBQJozAJLHBYLNlwUQ3etmOOq6QzEflM8zMe2tTZ0qEHv5pra7Ll97RvxQckvMYwpTXZ7HNeVlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/67lmYi+voOMGLp1Ed9FQa+oyDIhl+zKp+ccoJZ7yY=;
 b=m35j6T2vxFCReznhRSDqh2RrlaO50mW4t5AXWa18RQCy8y0J4K3oWyI5fz53ZdRww3GvIbzmI1OYpbjtDYcse54o3fQLR5Edq5lyMB+L/t5k3qB5xhSxyMXXQE9cSWGFTNGU4yLg1IbwEoV7uOEDZLV4WVvmQWwSGaapnkqYpdV4cS93a85172SUzvwpoEEMZMPFvlKnvBDjoNNIh0p5Aqo99qzuZz64B5dNFWTJjcEYUiy63rbAzaTzHCcVp5lgTjdU5XJJV0viT3o05GG1UUCCik5zQR/0PEEPnHJ7V/jrObc91RlNtomdwCRlxu0QQS950EdKfB46RoLk6HLMPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB5085.namprd03.prod.outlook.com (2603:10b6:208:1ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:57:00 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:57:00 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Fabio Estevam <festevam@gmail.com>, E Shattow <e@freeshell.de>,
 briansune <briansune@gmail.com>
Subject: [PATCH 7/8] arm: dts: socfpga: rsu: Anchor RSU DM node across SoC64
 families
Date: Tue, 30 Jun 2026 14:55:23 +0800
Message-Id: <20260630065524.27680-8-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260630065524.27680-1-dinesh.maniyam@altera.com>
References: <20260630065524.27680-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9dcfdb-fad8-412c-ac96-08ded674c813
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|11063799006|22082099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info: cCWPMRj536hN4w/HdmRHs4N2BVe2aD/3MTWe17ra34UUwVOCXJesqarQBkXh/u2yKOMhcS4WAhfEWV77ONEBiibp/OhEaKHDKiNeKVrD5LRm2zGgZj4CBgHa6V608XeC6LXEWMNVT36WvgSW2S36pbaYVVyZ/CQyOqhkztOrdwl+7HWDp/vIQUp2UOBMtsqBpS+JXyYey+7fg3aZLjo9MggmfvFa3bL4blS+6mRYD2ox9Ssf72YSPW3zPDjRoXbzR/G7fpRatSHRvbqOD57al43QRGmm3Hkf0lzkGChpV9zTBnE1WiWHefefk5IAG/EniKMZr12Zk5nC6W2dhVliPjLKjtgpw9jA7jT1RycmmtL91vvFVD3wVquj5wC7f4ykrg8OaLFFErTGN6o9kBsJ6M3OKYxm172YhBeDvNmg7hQXNnZOxXky5Ppyu5ONP+QfZQvrrMLnV33Say3LwB0AvBYQ1eJ0GwMhcpxSeS0lsxGgmRocCKkT0yQBM6UD+6RAv7r9iJL4sQgblg02gEVffsqlHXFKY+HMpX91sY8HuHwWR0FJVlrfJeVWDvuwT8sKStqqPybxNJCbYt7tN4/OruINJiiC7jRou5ndAJYNspCgxRvUTlCKKkNuyNNQ8oYXZdWrXmg69P9L/l0s/rhON7X374oTyaFxT8NH9rh0lRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(11063799006)(22082099003)(56012099006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+gzmQi8G5GtwDqS+9CIksatTm2jJbhaG/rvj6BAQVW7XdbO434SS4dLSH+qA?=
 =?us-ascii?Q?GZyMMjX1fPufrD1HwnbFmlt1S5u9XnhIICICe1Z373VlqWGXeqAGjNHV2wps?=
 =?us-ascii?Q?flQIVKjVX/zCtoYSa4XKUdZiB6z/IB4HkNkRG3bimoISBNjaCEr7JV1NdLxT?=
 =?us-ascii?Q?sQGz3V5MuI6jv9TxfEJ6U+zOg9UuqFFeh6oslv5a+lYEFbChLepYzaW/mv1d?=
 =?us-ascii?Q?xwxzwI69BhcGK8506+BQq9QiN/cCjLxphGWDzqaO8Yycidpm2sY3YpmaRydF?=
 =?us-ascii?Q?9KfGKvmXmM/mlV6lcSThN2YB6Fub5O0N9UrFfSXDbI7g2xUNIBSNYauu6/z+?=
 =?us-ascii?Q?K1L8cXqbxRN/SX4hZfxVuQOYP+kqncjtzRzfRVHuf6GH24Y1mDfiM8j0vxrS?=
 =?us-ascii?Q?SZd86vFENDtTSyZMc0o0y7Nrzs6J2DhDj9EprxRo4NwFkCIGzgryaT7Q5+eY?=
 =?us-ascii?Q?nA2lotBCJBn5azo+pvsCJzYzOFLb9Avr5wxDqE7jOwY7oVTS6vvVFb6+l9eh?=
 =?us-ascii?Q?99hLWG+BVQSAj8JZt9RGoDV2cFxUj+VfJRWqKBRixP2FxvpJVcIEH/B1PqFL?=
 =?us-ascii?Q?rDssaDPvGFY0pbQn2wlYt1SIROCMLnCz06vMSAlELBLtZswBylBRbxnv9MgS?=
 =?us-ascii?Q?8GlcsEIReEuBcNP3LQKgzjklzPgtKXUzQHCMU5HAuEXkR/7X/LPc57JjToPD?=
 =?us-ascii?Q?hzlin7cWrIvL0kPFC6tbIz54Gb1EN9iEh5deHT80CGG9r5J18zC5qbxiN+/I?=
 =?us-ascii?Q?99mYBdEy0QK/P7/Ge1isLqm0d1J+SABVdxsPZFLUaXU0mddV9XV5TNO63F8/?=
 =?us-ascii?Q?cj57w6dwSFNQach+6gPlYlf9HCU1A476T3OLYQcR4cPknTl5ROdDwxc2EF4A?=
 =?us-ascii?Q?1Jbex2G7dc0qd5yReBDvsdpLjg/jNI7x6NetKBrIF7MNg0kHUnJo+Z2kBIJm?=
 =?us-ascii?Q?qgEQFRJ0m8V3d9/wqTKZfXDfPTWBnF5aqoqcR++nRubqjcTUYtaY2+LKy6lD?=
 =?us-ascii?Q?r+F1mz8lGw4IfHGDaWQ+Z0N8i3E8PZvXD46N4B/n5k5Ys1jk7dkVazrUFTJj?=
 =?us-ascii?Q?z2XF3prN7cv/Nq1pC0zV2cTYlmeuRaorDGoRsunnwOt4LirHLeJv/kW+seEY?=
 =?us-ascii?Q?sgE2PWsJuJSNhJo2+gsG6JhbafA9jTmYIS4qYeP0313gxp9iTRGp3hKunO3J?=
 =?us-ascii?Q?NeOYtvZny0iJwFLuDlEkQc1SRzV6s2dDIBh9XASxRRvd+jtylxRVROhpqbG1?=
 =?us-ascii?Q?nBH19ZhXJq7Uk2yEcDOmm1L0oYtNMmHObLYxDgkfwEw2Vdc+OTWWMSDFqNFW?=
 =?us-ascii?Q?XW8XXwbdO7qZLCSy3vVEGU5LJJIGINJwjAlS5kkrgdMKXp2ckydA6b8BGAV7?=
 =?us-ascii?Q?C2iyGLRh1Iqrep7yKcVYuO3XldKouQG1uUJsriN1oQwMsf5ULW9/dDu/X4rv?=
 =?us-ascii?Q?+KCgJLYKKwGp4ZRIL8Mbyj40J16i9bfGh7es77MJQfIyT++ingXaX+WqfGd6?=
 =?us-ascii?Q?U5/Ag3IqetWzRR/YjSXZ4hWD8xOcEWWghzary9lOqJiYhTLxpk2hB9odakAt?=
 =?us-ascii?Q?mCU7ZSCYYQSKe2Z1Iv/7xyWuSaYrKB2FPlc4XvvNkp01TGQKrAtwbrZbP93Z?=
 =?us-ascii?Q?copHmvdNrQVVpsolbzlFoTxigjk+hXWp0iDfvIyN3lo/NVH3sHp9DheNnUg0?=
 =?us-ascii?Q?hpHKGEMP/GwJ6yawwshG4oTUt7Lo7GcoJhzlTvgjnZZkKP+6OThSxiTUvWGQ?=
 =?us-ascii?Q?0oyKMIG0kQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9dcfdb-fad8-412c-ac96-08ded674c813
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:57:00.2173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWz5tuY6S/beqqYcbkgPgA57Zu6xJD/955ThhYV14neCUUCSP8D9vFZZ61xPe338XMq/WM5GEsp082MSd36bnlU1T27AfcDSbpHjye6lND4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5085
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:28 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

The RSU driver-model anchor ("altr,socfpga-rsu") is consumed only by the
U-Boot-proper console command, never by SPL. It was previously present
only for Agilex, via the socfpga-rsu node under soc@0 in
socfpga_soc64_u-boot.dtsi.

The other SoC64 families assemble their devicetree under a "soc" node and
pull in only the FIT image overlay (socfpga_soc64_fit-u-boot.dtsi), which
carries no SoC nodes, so the anchor never reached them. With
CONFIG_SOCFPGA_RSU_DM=y that left rsu_init() returning -ENODEV on Agilex5,
Stratix10 and N5X even though the RSU command is enabled there.

Add the anchor node to the Agilex5, N5X and Stratix10 U-Boot devicetree
overlays, and drop bootph-all from the Agilex node so the anchor is not
carried into the pre-relocation/SPL devicetree; it is only needed by the
proper-only console command.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi         | 4 ++++
 arch/arm/dts/socfpga_n5x-u-boot.dtsi             | 4 ++++
 arch/arm/dts/socfpga_soc64_u-boot.dtsi           | 1 -
 arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi | 4 ++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 0f0f457de54..90f36d42923 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -18,6 +18,10 @@
 	soc {
 		bootph-all;
 
+		socfpga-rsu {
+			compatible = "altr,socfpga-rsu";
+		};
+
 		socfpga_ccu_config: socfpga-ccu-config {
 			compatible = "intel,socfpga-dtreg";
 			#address-cells = <1>;
diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index e27a64651e1..0b38d1e8f70 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -18,6 +18,10 @@
 	soc {
 		bootph-all;
 
+		socfpga-rsu {
+			compatible = "altr,socfpga-rsu";
+		};
+
 		ccu: cache-controller@f7000000 {
 			compatible = "arteris,ncore-ccu";
 			reg = <0xf7000000 0x100900>;
diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
index 5ec3c0662e3..91b4fe28624 100644
--- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
@@ -9,7 +9,6 @@
 	soc@0 {
 		socfpga-rsu {
 			compatible = "altr,socfpga-rsu";
-			bootph-all;
 		};
 
 		socfpga-system-mgr-firewall {
diff --git a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
index ef0df769762..701433cbc35 100644
--- a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
@@ -14,6 +14,10 @@
 	};
 
 	soc {
+		socfpga-rsu {
+			compatible = "altr,socfpga-rsu";
+		};
+
 		freeze_controller: freeze_controller@f9000450 {
 			compatible = "altr,freeze-bridge-controller";
 			reg = <0xf9000450 0x00000010>;
-- 
2.43.7

