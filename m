Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBA1CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 03:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C829833AD;
	Mon,  1 Sep 2025 05:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EtFQ+5U9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A61833E9; Mon,  1 Sep 2025 05:52:46 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090CF8328F
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 05:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhCHNQk/o/VPlHb8f2CA9imu+AU4+jQw/rG31yr52I5/EVky+wk130tQ5Le1dWmJ4tV94EoSlRkn2oYTotZz+C5+QFmWDjZt1Xfv+icQbyy/t8qLLj29hYONCBwByUo/gUI1tgrNZQVn6cNrfqPK0zWeVP5te4qOYEEn9MkciTqMsCkPxJh3VPcD2Y6yjVWvL3lNMJIVXRosCs9YmXl8ureOvV5r/l2pXv3jl+kqM+PQ/kiuP09fDJ701EC5Kq7crUE9kPDAT0rqKI34bw6cuWjve8hYetJpLTyFYaue/e38yB5rfP05NDOx0NrALzWcBvfMu+AuZL5LZud8IREC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gg82MkGLHcLCoqobnfKF/ScKGuy3QrWtR+tZ2LNRyY=;
 b=mBn2yZfAiJ0M+grhT1Ub/mJctB9QL/PK5U2JGeauOzxLxXujASxSu9eJqdJpT51qXVe42KDmOXpn8WYfQRxFuX4aZIc1Nq6bTGRYsazpewaB/cFBJq324LJ6FXrVdka73S/Gt4OPmODkpKHTwswd5JYxzp6sJCFADkPfvLoudrMVXD+ccRuIIE89o6Hr0GnbpPm3aRFfmfTQ03wlW3mWgSDeM3axbkpE6Qf8+zYykIvAI8zqgrHJnekkSu89FbUZQyG/W2uqVjAn3p6bAg7VBb4MWnZ/scPQHu4Eoqg2f4jZuHd02gpolxkYm2R9sgoElKHqTotLB04t0d7nqT44+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Gg82MkGLHcLCoqobnfKF/ScKGuy3QrWtR+tZ2LNRyY=;
 b=EtFQ+5U9+2zyNMhbhN5515xivWMTaU2+lfTI7I66Afu1pguwnZ0iNgQbni6SLIGiKoA1pdd+KwIKDIwO3gdTKP1lY4ZkXPPOkWrtTpF4OIp47EyUlNde71YjYMIY/EGo7pIBYJcUINEbLB/R863uzXoeN2wQ3ZK4XAoboda0fzqRurOdJV65mIJDy0Ej8mChzBuGIe9YY4PgLpNpJPPnCtzhruT5ASQ3eY919gz8Y5q6dAM/VWjdAOx9O7v7dGWX4Zu4iffv1GtStZXOHEim8qlMU6P3bcqAQgwKmBhSMs02BRP6qavviZk/RCRJtuv8h/Dur1CKSiN/rS/rqZGVzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10355.eurprd04.prod.outlook.com (2603:10a6:150:1db::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Mon, 1 Sep
 2025 03:52:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:52:42 +0000
Date: Mon, 1 Sep 2025 13:03:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull mmc-power-next-2025-09-01
Message-ID: <20250901050359.GA31200@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10355:EE_
X-MS-Office365-Filtering-Correlation-Id: 513d6c1e-ca98-4db8-b37d-08dde90b0072
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hyqyp7uOEHyrguQbKPblRYhJgyBTOz3+nwLKUKt6xg3U2GI9AuwUIH1fXQKs?=
 =?us-ascii?Q?scpRkGse3A5o7kzSOIr5xHznG8QyqyvNoNgs5eKs5/4ECygUYmvG1f+8ey1P?=
 =?us-ascii?Q?IEs5OaFihmp9GTrVaQMfFvAtDv9IuUzRNJUqtm3XNvCWkgyY/KwhrKIFIWOr?=
 =?us-ascii?Q?pT1HwAB1DnzNWy1Jxs143egDrW7xNJS9g+SVl72vZAoIN3FJjU/CV1+X/iTO?=
 =?us-ascii?Q?hgwxRRM1awHhWyeVWdytORkEUTXyeGOnGNW6xXqXsJRj8CLmQZ0UziJO0VOQ?=
 =?us-ascii?Q?dLus51d0IKjYCe5NFkuRHlv8r8HGoQqJU4SiiitfwcpWrbFenQB4WuyZ1sNm?=
 =?us-ascii?Q?4jjiReKY+h0/wo2oEYhW5inkdHnG66gZsFTF/ViH9I0gV9wvBwz1vkxmMlGx?=
 =?us-ascii?Q?Nhq30m1U+a5oDHKtWrEZJxRnqjvZDDz+lacSzl00UADTyiRtALEL8GlP/TBh?=
 =?us-ascii?Q?eohf4hqUhBoX15EeZqsxRS9OqFK67z+FXz6DEn2W9osNAc9a9LSYMEgPtvrB?=
 =?us-ascii?Q?EHvauVJcttPkp/QZ4Pt8rM430+1VkRgMtgIExfZrEp4IKpOKLTEKq1xOBkZ1?=
 =?us-ascii?Q?4JNx6FtAvv+bXXvevORfILf5m+3HPgNy2C5w9eHVW4tT5DzxnNSIiT6izZEJ?=
 =?us-ascii?Q?/a+tv3j6FwZ2yG/Ykdhalfqd4pC9ZBJz/OmWRNWkEYXKXVilLIcMgpa0OIrj?=
 =?us-ascii?Q?GZoagkZo+Ls2OHjyUEG0O9u7FYw/2TfM664ON0/AsVkWzKElvt7/2MiSBcW9?=
 =?us-ascii?Q?RHhgg0bZ2hlzywSBqEHOM86v7T/my6kMdHBqI/ya0Uc0FLCOvfIelTSi1Hmn?=
 =?us-ascii?Q?DHCw8mhQ2GX02Mu2jkAZTkB91aRXSqyp9NR2BOYi0szofakxckvYDcACFzy/?=
 =?us-ascii?Q?kxDof+lKhSGsCUx7E4knsHZ0zNSqKCuMAaayzQRju4uKG5oHcbNQdXWZq1kM?=
 =?us-ascii?Q?S/czSdSSOWG0PYE8HStpQQJBN60jXlg+9soufpyhMiJE339fg9S1+05rg7Nj?=
 =?us-ascii?Q?u0bET19VvCpCmKOHPlwhMDnJjMz+dBbdV2Fm+X5jaVha62V0zCk+Yyyk0yH+?=
 =?us-ascii?Q?Z0iX3b0IdCdohh+vKbg/qcT8g5rDmw4cjFf8spruArIoUpVS5/WBjbEQiMPv?=
 =?us-ascii?Q?nlsSfMwwTmI7r5Ovj0/swc9qsM/qfy4W8ux/cjRpgLCvjERbMnZPSbTH9Cit?=
 =?us-ascii?Q?QcR1Q7c5QaneUvhfgLt7cd1+Urs4hcv1esOes5tK6kVSBbXPVdmLThQqMOMh?=
 =?us-ascii?Q?LUHpL58Jnd9jrTS/CKirSmA2aSQPp+r8iQXgdwMVYfwuWSezfeZCWDCY+9qb?=
 =?us-ascii?Q?XqOJOtD2GfrT87J7/y0G3nirr1NNOpCClJ1QvuQFAPz+jDvKkvxe6CJCwi6I?=
 =?us-ascii?Q?ADHqMYJjY4mWfFEBAuFTufoWmohFhH9HNiFEItRp/GURa1AcXY+jVAsGxb6h?=
 =?us-ascii?Q?xsY33Qoe2ws=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9bGrPUmsOxURvBlMtnHvi5bkS3IUVc6cDAhd4Co2QdiE9Z9uljqB07+b5tIb?=
 =?us-ascii?Q?mZZ6jKVmQOKE9/+9g0dyR9vBDRDnER2rSOfaIvxb6BODPmoQ8G3B5qHSYrpr?=
 =?us-ascii?Q?3fDNY5VJCW6KVHRBj/eE3Iq9UNnFuYNbNI3jXSIobk+SnOl3vHlF19u3WA3w?=
 =?us-ascii?Q?WzMiOmWQnEGrSICb3cIHaXl8delJpSOWrd4GGNXdAGaI5VHjBEcN0hSN7Q3M?=
 =?us-ascii?Q?QBsJtB83/aKsFnmtXva+cP4zfuSTrpF06eD6Wdj8PJlgZBKiQA+aoq3ebsh8?=
 =?us-ascii?Q?26449F6OhrUeODLetNZRb8pCn6DBrxOdQcDpxQ/yMD1xhpKFObnB1BighX3C?=
 =?us-ascii?Q?XDEDTgKa/4Rag3fskeEB+jmAfJ0VlC5vOSQlh7ufqFcFwgsGupYMKkYGbP7q?=
 =?us-ascii?Q?7B+HKRoiYBhqlJQFb3Kn0S66q6dr2TWIKLhJUpGNLk3ucXSLte495Ta+hg4v?=
 =?us-ascii?Q?zl7KigXkSvM8nWk4S+cYMylH79RzVkCR5YvHKciHbv5cp+Jxm1jiT4QsT+ru?=
 =?us-ascii?Q?zP8zAk9P4nf3R0Eg1W2+ilXLw0SMX0oxM/eFBVd29drneid86pRkUNZ1zQyv?=
 =?us-ascii?Q?NSq4vB/Cl6C2DyWdx/88oAwvP/6pWEr4jZv+uHBK50ucbS5r1TWM6av1uFWv?=
 =?us-ascii?Q?yHRU0BKRZz5z+nYRF9YB7+C3eYvpJCyNiJmE7u4h5XNdSq2byHfXhFZXxLEN?=
 =?us-ascii?Q?UAqAr1I9SK6Y97HdM14DP77r0atI7OCvO+PcPiOzFstFtD7QdLLwU5xFe2C9?=
 =?us-ascii?Q?gecgiFnurU46pN+0ASBBWBED4Oj4zr0e31InzgJbRFO52H6dbt30TcI7nGhl?=
 =?us-ascii?Q?uTDRdy5XX5rsfUypdk18Zk2P0Y6X0eOTv3MuH1KX4osv4UvGdhCAU19DmJDu?=
 =?us-ascii?Q?qDRepwXafXnECfBVhOQSjL30wil1dkqSk+eXbRmsd2bn3qwxOdkxwxkUQk6E?=
 =?us-ascii?Q?D0fTsqINxLKND8WxGGjvgWFJrNk/HWGwRDtbiFROyqvAED/k72u6F0vxiGXF?=
 =?us-ascii?Q?ckLUTL7VqdCC6SqYnPcC4Vc5kBT22zNox4f8PNoSudi4mMB1vm6fQbPuD+H/?=
 =?us-ascii?Q?CkQkJ8Idsqa2qmUFwhT795h0vsdiODHiqW1UG5F3DTHmhgV6dML3K90g/MpP?=
 =?us-ascii?Q?KdOT5WNKaYE/CVtXF1o9EdK5tn6okdY6lWLw+iH4wtWljS9iOa5WxqvB095R?=
 =?us-ascii?Q?Vff1xNXY22frlRFJcKwBC2OQ5tkx5HiOuTzhZ4DYrI002UdCkpoE5ViaUMHu?=
 =?us-ascii?Q?dhYYWr5WuhZ+5t+ceh9RxKtjCXsmEXnifNvnA763gUMyM44uF9GB85FPoIkJ?=
 =?us-ascii?Q?hDfzVaitwKB5mYiyY/Bc2IiAu6h4357txjEztPg45330rJ/Pw269Sos7mXqy?=
 =?us-ascii?Q?WVaFSmF1UMDL9sNyhsZ57LdLPCfJIQ87yTm9McOZGk8SLrbYqeIl8lAGHf/p?=
 =?us-ascii?Q?cqVii2iAcHvhH1v5HcmWDy906sQ6YbajfiYUnjOmKRe3H0+aX3Ql314Tc8Z4?=
 =?us-ascii?Q?okGaCCA81uMRR0hpJI6qBG0ZmGzoxBtup0tGBe4QF/9sV2Kmp45kSUz2dfic?=
 =?us-ascii?Q?m0BxHulJ8u42h6wE7CjAe6gCwgdv7X+LxdnmoyHK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513d6c1e-ca98-4db8-b37d-08dde90b0072
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:52:41.9759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OZ3yxnfY9l0Fbpua/PujnxC4BI3lxkbJ0x9XWgdYyYYyAIzHV1Cpq5TWzDg5TI6B7JkdtKTdHzS9vncsMiOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10355
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

Hi Tom,

Please pull mmc-power-next-2025-09-01

----------------------------------------------------------------
Update compatibles for PMICs used by exynos devices
Support system reset and reset status for pca9450
Fix for pca9450 LDO5 registers and drop deprecated sd-vsel-gpios
Two minor fixes found by smatch
----------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27536

Thanks,
Peng

The following changes since commit c9ffeefeb3efedd754e3ffa3440bfeb15cea00c3:

  test: Update logic for video test (2025-08-31 09:32:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-power-next-2025-09-01

for you to fetch changes up to 140562d3a2b447079499d773a7d21ec1728692cb:

  mmc: core: drop space before newline in trace printf (2025-09-01 10:33:10 +0800)

----------------------------------------------------------------
Andrew Goodbody (2):
      power: regulator: tps65910: Cannot test unsigned for being negative
      mmc: iproc_sdhci: Cannot test unsigned variable for negative

Bhimeswararao Matsa (1):
      mmc: core: drop space before newline in trace printf

Frieder Schrempf (6):
      Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
      pmic: pca9450: Fix enable register for LDO5
      pmic: pca9450: Fix control register for LDO5
      pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
      arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated sd-vsel-gpios
      arm: dts: imx8mp-dhcom-som: Remove deprecated sd-vsel-gpios

Henrik Grimler (11):
      power: pmic: s2mps11: look for both {voltage-,}regulators
      ARM: dts: exynos5422-odroidxu3: rename s2mps11 regulators node
      power: pmic: s2mps11: remove check for voltage-regulators node
      ARM: dts: exynos4210-universal_c210: rename max8998 regulators node
      ARM: dts: s5c1xx-goni: rename max8998-pmic regulators node
      power: pmic: fix typo and capitalisation in max8997 Kconfig help msg
      power: pmic: max8997: support maxim,max8997-pmic compatible as well
      ARM: dts: exynos4210-trats: use maxim,max8997-pmic compatible
      power: pmic: max8997: drop maxim,max8997 compatible
      ARM: dts: trats: rename max8997-pmic regulators node
      board: samsung: odroid: drop exynos_power_init

Primoz Fiser (2):
      power: pmic: pca9450: Add support for system reset
      power: pmic: pca9450: Add support for reset status

 arch/arm/dts/exynos4210-trats.dts          |   4 +-
 arch/arm/dts/exynos4210-universal_c210.dts |   2 +-
 arch/arm/dts/exynos5422-odroidxu3.dts      |   2 +-
 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts |   1 -
 arch/arm/dts/imx8mp-dhcom-som.dtsi         |   1 -
 arch/arm/dts/s5pc1xx-goni.dts              |   2 +-
 board/samsung/odroid/odroid.c              |  15 -----
 drivers/mmc/iproc_sdhci.c                  |   2 +-
 drivers/mmc/mmc.c                          |  14 ++--
 drivers/power/pmic/Kconfig                 |   4 +-
 drivers/power/pmic/max8997.c               |   2 +-
 drivers/power/pmic/pca9450.c               | 100 +++++++++++++++++++++++------
 drivers/power/pmic/s2mps11.c               |   2 +-
 drivers/power/regulator/pca9450.c          |  37 ++++++++++-
 include/power/pca9450.h                    |   7 ++
 include/power/tps65910_pmic.h              |   2 +-
 16 files changed, 139 insertions(+), 58 deletions(-)
