Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E273D59D99
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 11:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A478042F;
	Mon, 15 Dec 2025 12:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="k4o2JC8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63FD80050; Mon, 15 Dec 2025 12:02:59 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC778042F
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVjUuG6nYq7EkjtMxlu51zP+bGqiwLqQxfBMSFweSqQxLhZltaTHwCU0HGB/xG4A4YMzEBHy/KY2bD7xHvRP+jvWs4waVgO4VRbJXADEragfMkzB5E4kE+gJqb2ieQaiHgbGvipAgVWJomuHVN4KHptO+GqLP8RE8ajPFPN3GB98DTv9nFUPFxTvIsGlidE1BxduTyV25bvFqdhTveCMFpwVIumehtWBxps+u/F8jlbbeVBwY5oFSqVpTPbubXlczseJus/bhxeV5C3m+xJjQI21/fiwnCdwKejfV++EWcwqViEDgGk/FWj47kD7pRc6wJX3UgxhVO8gX1Gjn8JoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGI/0BxX/cfqaeGWj2OrJWEXM9Ff0vafl81mD9P0exo=;
 b=RX6pWWbEbNHIeVctrEE4wfmI4R62w+2+rpo8B4JB567kXVQ7ohoQl27OFc9plkEwZdD0mYATJ8Bjz1GJXZdQYUf2fHVxOOBElX/taQfL0q0quZpK1S1TZ3b/3pTEyoDdbPkOjstarQSdE+OIPBZjlhIXElD1PJImjefyC8+hDmNpAFuPoFdbZ+tIJxsfd5M6tO60wGm54y8qXyMRrlQU6nUqbfoAILWDGc1LxqHnDk24yWHE/oilKg8G5cBzfj+srVgyE/gPHOkxwFznEOHBM7rD2eYWme4rA6dU5Tjiefv/Apkxj4ZS2l16TBvIhFeO3iYCRcWAQqHB7x7/ziOl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGI/0BxX/cfqaeGWj2OrJWEXM9Ff0vafl81mD9P0exo=;
 b=k4o2JC8nTWL6qYE7MIY+e126mYzuida3Lzt5B4vCFc7vrs1Sj36CNIyZMg1IqMuvPjPcXyG53qWLe9dgAnSBLsbP2bvz6rs9O7nJIyU9hnpMVQt1bY61IYJ1GElRiXFXIXK7OhGB3ELbKv0FKW+UAHilwq6W1W7LYGY7feGgUYa+QM4+F95EpnzLJN1uvXbxHXDN/SIObgG3GYkZYsR8Xvt4x3HXanQN0cmVtu93NKkKFaqAFi08coo+qB92XkVecH9HShgho6O7IGNd5VmT6Ia77/G1moe/6wwfztJ4tmtazMcPl2bizEwsd+CVcOff7B9MICU7vj6wkNy2UoevsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV3PR03MB7658.namprd03.prod.outlook.com (2603:10b6:408:28d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Mon, 15 Dec
 2025 11:02:53 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 11:02:53 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 2/4] arm: dts: socfpga: agilex5: Upgrade SDHCI controller
 from SD4HC to SD6HC
Date: Mon, 15 Dec 2025 03:01:15 -0800
Message-Id: <20251215110117.19371-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
References: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV3PR03MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: f534ab1e-227e-4717-e15c-08de3bc97e2b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tn7bi5keQ26T3e4LD9ur+x6dfd37Hxhndr5edZtQLA9VFiro+I18Hb9ZWX4q?=
 =?us-ascii?Q?TanrNiOF/IWy2rTQr1gAaPCEWFo7BpyaGIcd9oWxPJkqCaVf3iBX1c4Tz7eI?=
 =?us-ascii?Q?Y2Q4oDW8VomMnU64TU/Tpx+NzHOfclTGkYb3xpsNpzn7juSxzYAo/18odMkq?=
 =?us-ascii?Q?9oA1qZJRkjFnYGsPBiAZQORkqVQKsC80LiT6EzkBSHCRUR1f8lvmoP+7c8PS?=
 =?us-ascii?Q?g2Q1tmEXFgEeRBZ44MzOhYCOVrRlzI7lZ+PP71UFdSi9DlrrFuPdWmy8Q7w5?=
 =?us-ascii?Q?jf4rx8NywmK2b1lzEI61ljj4LiKrKayvBCCJvOzqrS/75J8BvmzIYkYczoWf?=
 =?us-ascii?Q?5a/2/u6AtRpePyrN/UL/xxdbLvPcktJUASgw84vHeloACWpgtdfYawyf06R0?=
 =?us-ascii?Q?3floDTteX4RuS5Fbphhq7c43MAD0Yv8IMlPeWDObMeFLv2a3B6vVoWguYYJK?=
 =?us-ascii?Q?6xvV47GTvUX4yA7vL9EQIR6eF7GSArKuYautp5W1aqqlL+Pi6iUmhfotNLdD?=
 =?us-ascii?Q?fjyJ4xWTfmNYiKwSMX1DcrN8GGxE5stqBJ6GiEXW1t87uqoNiMDa9eM4A6FW?=
 =?us-ascii?Q?QipsNVTD61Jl8X9RftS9WGi66B6L12vomt8DW1lemYxJtXdTTB/NRMA8j/RD?=
 =?us-ascii?Q?yMzUaBEsHtgA2twSjanXMqBuP98M+09o9irSIPE41rF0HO3RgRDrDUtWqZ2t?=
 =?us-ascii?Q?zeHygpulLXenYX60aRoCqGih+L5+KH3o4Vh39aif5TewfVRR+5Bb0p1GGINf?=
 =?us-ascii?Q?mvKPW6E71gxo594LK77lCrpM6O3ZFxBOPKb1SgppKtraTvIv265JwVeES67J?=
 =?us-ascii?Q?CQoliMv0E6nfyf/zdCfkktyi7jUJy9j0De6nHlTEQJr94SnnNiBE8HSZ+35z?=
 =?us-ascii?Q?TTeUISxm5SU7OxSr2Hjct2wALVpxM2NRJp4MHqgFRMH6Mqt19pi2TqGQ+4bL?=
 =?us-ascii?Q?qiRhhVHSLnr4Y6v5l43kdKnFEdVt+HLEO19biY8z7DTg9cogaNYehAoYCIqk?=
 =?us-ascii?Q?GwxUlUF4KDdakMUmcTGBYybrBxXJo/i1UBssUwtLWNAJRi5y5fDyMlSca3lx?=
 =?us-ascii?Q?BZO3eGLtNepaZ7TMGG21yvHjk4gnKyt3r9Jt3Ns01IcIrz4C5oa7ntf2VwB6?=
 =?us-ascii?Q?X1FYeeMFopDV4xv6+mzvozYdjoWUgeI4F3c0At8qY8iOpEWymhxoT8dFLivQ?=
 =?us-ascii?Q?42rSrwCCtd+qDxbgv5IQ2QXeOcq0gAs2RkZ5buiuB0Pg824Xw9tzclrMZu+Z?=
 =?us-ascii?Q?j9Y9GoVCQq55YBj4o276iwWRnuGvU3UMGuQLVSl6pBqczeQwm7WloL6eDuCh?=
 =?us-ascii?Q?cOjXFn8MIxoDLh2AiOId3N7zqT8u1iOCzuH7Ddxwow9jwFFMlcDycLfO4rVn?=
 =?us-ascii?Q?c3Yrp1picn/A17zKguGdjJxrQLTxNsSdbgzoBCA8aBOEZN0fO2zTekBF53JX?=
 =?us-ascii?Q?yRlNqHOY3OJNqKIm0+OaEXDDvnOtuEyy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iU02TlbpaV7PzaBGFVuJHktE4nH/SVn9JaxqvtLT59VfC/jCMDbBekXebETS?=
 =?us-ascii?Q?1Gug9943GLJHMP/LK4okMzyEgMTfhQGMx71YnH4dfH02fX+b9EftY4Tf9KEl?=
 =?us-ascii?Q?tOW3N6LnpFQav2pEg3lNI7WsreMQxcXP3aFlMGWnkI5xrt5zRaR3VKYHgv/t?=
 =?us-ascii?Q?T0V2s/6P4ibs4JGwPUE0szkY9PBElhMyRFzgJhyVheQyF7smlKYVIt7HD6lA?=
 =?us-ascii?Q?W3MyazgNcWFGvSpfV4V+ZDvLX7Hyg1esxD1uEtAAGPbwNhMh87f3JpbRx/xZ?=
 =?us-ascii?Q?EkNfrVKRdx4e1mNtYvRsvxmA46nKBNMskaW+cTRzwukX/RBuS8yCAbuOfZMI?=
 =?us-ascii?Q?eo986qF6TlhKe1AyfJrwjGGYMBNQKPuQ6tqTLdaJ3kz9rcaAjyAQd1PBqfXP?=
 =?us-ascii?Q?K5WaLQSfEs2ENa/l1wVka3hD/KUsXUCDVR07RKY6Ex0QteHEWcBf0QWDxSWu?=
 =?us-ascii?Q?CaVdxM+nah5UJn3WHeQtNDx6pgi2OUhSaVuKdbEEtFYO12z3Hz0ko6T/UssO?=
 =?us-ascii?Q?HTPB5fCX1aN/7653T9Ala5NEsBZiRPkwCgFdPkMQnqYQzVsiW1sZkR24KdZJ?=
 =?us-ascii?Q?Q2xOjUoLwbXJA/MRiXIXKdLjX1hkujoR8nyH/TZSxidGgM/lThbON+oH86gl?=
 =?us-ascii?Q?qf70udYdbLzc1KmW8Mxa6qjFrsNNQDT5yuNjrIreBI07LjQlM7XJd6DWB4Rj?=
 =?us-ascii?Q?vo4VVHKFY4O4QKfFDo/hFtjNbTXVOwUWLCB6c4hZvKPLNxrXyvQG8ohKDWKC?=
 =?us-ascii?Q?IzrfApB36PzIXzyargRZXws3kR5qwcU3fdQlNcnP+PJlpQ2mFeS3uWdsR/yO?=
 =?us-ascii?Q?c7VVg2pCky2IQIa4LjiNIuCjOJG9uWSyx49bLyHTbf22eL44WR8fDBro5zQ5?=
 =?us-ascii?Q?9reoNsCpGLvCUWjxq66uuglG0kg0yXnXBuuPdEjTEGTJPo+pCR+b2/iVCAeb?=
 =?us-ascii?Q?/MlWYBInayES9Y6ayBvKRbgsWgR2w0jxLuS0JNe36rzDMCENzV6f0f4eW/bp?=
 =?us-ascii?Q?xxfCgWXwDLWLmAD1MFlmYLHkxS1tj2Gcm3kZmr/GHVhgrST7/+H2s5bmW0Ut?=
 =?us-ascii?Q?0H6IwoBUuF8ApuhhWYDw87RWmBsAKp9oXpWQls0aX9vGOFK6iF0OW3LjhcOB?=
 =?us-ascii?Q?bXueIt5sZLmE8OzxaEjjQ7jvcbYducxcRwU/v7+OfWlqm0neuKJmVAT236jE?=
 =?us-ascii?Q?yVlCrQiOOIeOSYlzk/gWGfO43TRlIspYPUaCdzHuY1JBSQN77TLbtMeGQDcg?=
 =?us-ascii?Q?S9YDanwO1Ot+lZOwavlh0Gyhz9u0Af+e6E+xWFju8Fzxmh9pDMAD9NI/+YMU?=
 =?us-ascii?Q?XA5Bz7CbVcKH9yOxs+dr/761hvb+sUt7DiEl79EMqK75i6ThLuBlW1wTNkri?=
 =?us-ascii?Q?j1CzPxTFeruhYi99ir/UJVDMvhci6jVgTDyMwtQXpDSQ7E0Y3KJEG910VVuz?=
 =?us-ascii?Q?g4hh4r5lmRoDJt0rKR6qDoEpHefsB+r7VmzZbo7cB1kM9T+zIkcYlJfH5Kkq?=
 =?us-ascii?Q?V3/egE3usHIVpjrolh7L6gX7TSm6w67Egq5E7FMhDy6QFMl0VWTvPYfND36y?=
 =?us-ascii?Q?olstcatwC8GyDfgMR7z+7ftNfyDCSLeA4yjLW2tWO8hcH5GJpMDGuOMmaGVG?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f534ab1e-227e-4717-e15c-08de3bc97e2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 11:02:53.0634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMMMp3YZVaCOpHWSZ1DwCTyQznY+HRqigrv9rOxlf1GKsqYFdZ+aNORSyBl0fTXXDLXsxxdqrJVZ2iXlNxFvmqUpCW7ZmPRNB3jSJqS/waQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7658
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

Upgrade the SDHCI Cadence controller from SD4HC to SD6HC for Agilex5
platform to support the newer controller version with enhanced features.

Key changes:
- Remove combophy0 node and associated references as SD6HC doesn't require
  separate PHY configuration node
- Upgrade MMC controller compatible from "cdns,sd4hc" to "cdns,sd6hc"
- Add Agilex5-specific compatible string "altr,agilex5-sd6hc" for
  platform-specific optimizations

Hardware configuration updates:
- Add voltage regulator support:
  * sd_emmc_power: Fixed 3.3V regulator for card power supply
  * sd_io_1v8_reg: GPIO-controlled regulator for 1.8V/3.3V I/O switching
- Configure proper reset control with named resets including combophy
  reset
- Add GPIO control via portb pin 3 for voltage switching

SD card operation:
- Configure for SD card specific operation (no-mmc, cap-sd-highspeed)
- Set maximum frequency to 200MHz
- Configure timing parameters for SD modes:
  * Default Speed (DS) and UHS-I SDR12 mode timing:
  * High Speed and UHS-I SDR25 mode timing:
- Add PHY timing delays for optimal signal integrity

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |  3 +-
 arch/arm/dts/socfpga_agilex5.dtsi             | 29 +++----
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 77 +++++++++----------
 drivers/mmc/sdhci-cadence.c                   |  1 +
 4 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 35b198b79ef..0f0f457de54 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -698,7 +698,8 @@
 };
 
 &mmc {
-	resets = <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
+	resets = <&rst COMBOPHY_RESET>, <&rst SDMMC_OCP_RESET>, <&rst SDMMC_RESET>;
+	reset-names =  "combophy", "sdmmc-ocp", "sdhc-reset";
 };
 
 &porta {
diff --git a/arch/arm/dts/socfpga_agilex5.dtsi b/arch/arm/dts/socfpga_agilex5.dtsi
index 7f4266dd5f1..769678af31a 100644
--- a/arch/arm/dts/socfpga_agilex5.dtsi
+++ b/arch/arm/dts/socfpga_agilex5.dtsi
@@ -303,30 +303,33 @@
 			status = "disabled";
 		};
 
-		combophy0: combophy@0 {
-			#phy-cells = <0>;
-			phy-type = <1>;
-			compatible = "cdns,combophy";
-			reg = <0x10808000 0x1000>;
-			resets = <&rst COMBOPHY_RESET>;
-			reset-names = "reset";
-			status = "disabled";
+		sd_emmc_power: regulator-fixed-3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "card-power";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		sd_io_1v8_reg: regulator-1p8v {
+			compatible = "regulator-gpio";
+			regulator-name = "sd-bus-io-power";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+			states =	<1800000 0x1>,
+						<3300000 0x0>;
 		};
 
 		mmc: mmc0@10808000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "cdns,sd4hc";
+			compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
 			reg = <0x10808000 0x1000>;
 			interrupts = <0 96 4>;
-			phys = <&combophy0>;
-			phy-names = "combo-phy";
 			clocks = <&clkmgr AGILEX5_L4_MP_CLK>,
 				 <&clkmgr AGILEX5_SDMMC_CLK>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x800>;
-			resets = <&rst SDMMC_RESET>;
-			reset-names = "reset";
 			iommus = <&smmu 5>;
 			status = "disabled";
 		};
diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 938ddb04c04..5a7aa5841e3 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -91,53 +91,46 @@
 	bootph-all;
 };
 
-&mmc {
-	status = "okay";
-	bus-width = <4>;
-	sd-uhs-sdr50;
-	cap-mmc-highspeed;
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
 	bootph-all;
 };
 
-&combophy0 {
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
 	status = "okay";
+
+	no-mmc;
+	no-1-8-v;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk_ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk_ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
 	bootph-all;
-	cdns,phy-use-ext-lpbk-dqs = <1>;
-	cdns,phy-use-lpbk-dqs = <1>;
-	cdns,phy-use-phony-dqs = <1>;
-	cdns,phy-use-phony-dqs-cmd = <1>;
-	cdns,phy-io-mask-always-on = <0>;
-	cdns,phy-io-mask-end = <5>;
-	cdns,phy-io-mask-start = <0>;
-	cdns,phy-data-select-oe-end = <1>;
-	cdns,phy-sync-method = <1>;
-	cdns,phy-sw-half-cycle-shift = <0>;
-	cdns,phy-rd-del-sel = <52>;
-	cdns,phy-underrun-suppress = <1>;
-	cdns,phy-gate-cfg-always-on = <1>;
-	cdns,phy-param-dll-bypass-mode = <1>;
-	cdns,phy-param-phase-detect-sel = <2>;
-	cdns,phy-param-dll-start-point = <254>;
-	cdns,phy-read-dqs-cmd-delay = <0>;
-	cdns,phy-clk-wrdqs-delay = <0>;
-	cdns,phy-clk-wr-delay = <0>;
-	cdns,phy-read-dqs-delay = <0>;
-	cdns,phy-phony-dqs-timing = <0>;
-	cdns,hrs09-rddata-en = <1>;
-	cdns,hrs09-rdcmd-en = <1>;
-	cdns,hrs09-extended-wr-mode = <1>;
-	cdns,hrs09-extended-rd-mode = <1>;
-	cdns,hrs10-hcsdclkadj = <3>;
-	cdns,hrs16-wrdata1-sdclk-dly = <0>;
-	cdns,hrs16-wrdata0-sdclk-dly = <0>;
-	cdns,hrs16-wrcmd1-sdclk-dly = <0>;
-	cdns,hrs16-wrcmd0-sdclk-dly = <0>;
-	cdns,hrs16-wrdata1-dly = <0>;
-	cdns,hrs16-wrdata0-dly = <0>;
-	cdns,hrs16-wrcmd1-dly = <0>;
-	cdns,hrs16-wrcmd0-dly = <0>;
-	cdns,hrs07-rw-compensate = <10>;
-	cdns,hrs07-idelay-val = <0>;
 };
 
 &qspi {
diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 7d169efa476..6cdb7f95cc5 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -260,6 +260,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
 static const struct udevice_id sdhci_cdns_match[] = {
 	{ .compatible = "socionext,uniphier-sd4hc" },
 	{ .compatible = "cdns,sd4hc" },
+	{ .compatible = "altr,agilex5-sd6hc" },
 	{ .compatible = "cdns,sd6hc" },
 	{ /* sentinel */ }
 };
-- 
2.43.7

