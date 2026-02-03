Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01FDE8305A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8A783FDE;
	Tue,  3 Feb 2026 07:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ByByHnLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6031383FA4; Tue,  3 Feb 2026 07:36:15 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EEF83FD6
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kC8DV2wc5gBA3Xy3K42JunMRzM2HeE/4nA668KMNx+qKwHSYfBurE5BRGf3E0+EM0oWSP6g0uiID9MjR+begfP8wGx1KP2MD3C2+f85VPbT8kB56x4G9TEA6BeVfc/Q9JzWrHXMkIJqzx83z1hk34aqklNt8dxJLx8jYQCKI4ZIZC31Jgj4YtUlwp88IbvkYK6y/IudGgRomPTBJPj/9Q533PJR1rrnuQUZGGkHgjmqicHi1zhZKFvvDaLjfaqxZ16TsVnG5/WWQN8vuTI2OKsZ9lbkHHIRaQV6IPVX0gF9VecG/j8rXSP1t+q4s485kWFqUh/caEPV7HxjYcQ81gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NfD9STpz5odN0qNmI+bNr4Z0vSN89DtUUqY6ehkAJo=;
 b=qRs7PvuRq/Do9nSU7oZSuUIhHkQGIBFWUtUifemzvxQxQoC77w52tjlY6G7s3Q34n/Hij7AEiC3J75F/0ElA2qfiW+Pck39k05zRNthEAzanlVXXEcr+rN4cDuFbZ/9VspWZyvTzgYsMt7m+z4P+2dv0mNga/E1z4dVEacHE5MOz3XQWK4fDXjA3VNDUY1yXHEnqZxeOfafPPHuaSJ/P7JgGxBLm5t9ZgbetJQFgTudDR+by1Qw7e8xC5Nalxq8UBh5TrKHiEyUXHWGBRMOUf7Hf2/vUlhgZZVkYhh4oB7P/i5zxaJkgHSm2IFx1KtwK5IHGrEccsi7mEsFU2dptBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NfD9STpz5odN0qNmI+bNr4Z0vSN89DtUUqY6ehkAJo=;
 b=ByByHnLC9hchhfd/VoaSmozxXLKFo9Y4QP3IhXxhv+tz07X0Q37lgXW6LFzMshNlTWS7MY7OAC4iL3Az25RKwpm0X67kgL6oQQK3tMXX2yafJve3oyFCGn5Bus9e2MIMZrNSLg7/7n0cE+zRLwBbzew5SYKhs2RCINPME9ccdCE=
Received: from BYAPR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:40::26)
 by DM3PPFE9EDA11A0.namprd10.prod.outlook.com (2603:10b6:f:fc00::c52)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:36:04 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::13) by BYAPR04CA0013.outlook.office365.com
 (2603:10b6:a03:40::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 06:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 06:36:03 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:58 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 00:35:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 00:35:58 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6136Zn7W3483536;
 Tue, 3 Feb 2026 00:35:56 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH 3/5] arm: dts: k3-am62-lp: Update DDR Configurations
Date: Tue, 3 Feb 2026 12:05:27 +0530
Message-ID: <20260203063529.1551907-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203063529.1551907-1-s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM3PPFE9EDA11A0:EE_
X-MS-Office365-Filtering-Correlation-Id: 114a9ebd-20ab-49b7-1eb6-08de62ee80c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rj6384A1Gx9MhBPme/JMdiddPmGv7rlcLMf4MEXs/uLUuwGh7a00znPRco83?=
 =?us-ascii?Q?nJqgO35uGCS/7SHWckX912rWtfIpjKivi7UysUwroctaF/R+S8QKyA9kcx2F?=
 =?us-ascii?Q?nNiqKmL7+DgTmf3AOlNH+kKMLTPFu/4uY6mg17jpEN3RgeM7c0Yjc222kc+W?=
 =?us-ascii?Q?AePOS5O9oFzqp3t1gEoY8kkSLNlo/iJUadvm2HIHDL8ePD5bWkaJoaxq25Wb?=
 =?us-ascii?Q?TLfHhKKY50illd0gb8J9vC0ZmkrPHZXu/wjdMqBuOExFRS9EoG4oeLBo0o84?=
 =?us-ascii?Q?eARrQchF+DHTquK+7I4bU2ruDLsRCLRYQ7yRZ0ymgtFc34ieUmWxL+4EZcsq?=
 =?us-ascii?Q?nEucRnyOynkDRcxT8BNydq9dJF/O0qLsccqJyI0McmvYbi+q4xFBvofeIxhS?=
 =?us-ascii?Q?Dl/Y3dian+RN1+ZL0oLT4D+YUKV7k1UiQP9+vjef8ZaWgv3OaUDEJWDPwECg?=
 =?us-ascii?Q?pTbrj82EpKgDo0KAjpVUPQzM0LMtR3rfEQZFoQplzOlmwP6pZ5kPEhmDhSiZ?=
 =?us-ascii?Q?5Mme1pLssybWbOSEsCtSCh9SsdzVDk4EyUgRiRgglnrfkRM50IfeMab5ahJa?=
 =?us-ascii?Q?wM9s1A6bkxpPPBVFx58RPrUDsetc5R9fKU6ASGCx0gmTPsh0aojAaiCRJjoV?=
 =?us-ascii?Q?KQ+rnTV7NgIPP1RUHHTs9So2WEUZJm7UtCoxTjk60rWzLOlrckLIFMlKebkr?=
 =?us-ascii?Q?EJ23JIRi5pFGKyzqs0rOy4ANmowsPNwjtQdH2SXSjkVNNue85gXUvJclId12?=
 =?us-ascii?Q?JzvCIprUArC+BkKMTK9nOffHyWzbG4AEG3ootdk8c4Ew3ZPuL+oFkVLZVDt/?=
 =?us-ascii?Q?b2IfVfmRbTGF8yHMP1Zfe6LSCrjbNKf7Udze4gAb0B0B7ETJQUnITr/jZfz6?=
 =?us-ascii?Q?oE5BrBP21p3hRlM91s4I2yFUJ4YiSu0bIUFd/ftawut6FFl0tl6cVBMi7eh0?=
 =?us-ascii?Q?jigMGUyMqJt2MEclCbqTO+VO742eM2mqN9gxSsQdzEW5GpmoRlp/i+/M7ghj?=
 =?us-ascii?Q?m/crobyIIvP+0tGNk7sVEEqFypowfMuKDdEE+N9znim8ImvaXSO5A93botjH?=
 =?us-ascii?Q?iHbV1CCQ/uQzpYjngaiSLWSm/NWXMD0uRoChe32hWF+hHW8/KrCur+f5q9LO?=
 =?us-ascii?Q?1cXBA5/R5nbeMye91m1iaqbY2bF7D4FBclh+vGIbXtY1Q3fYTBFlqQAZ35c5?=
 =?us-ascii?Q?9G+DW/zx5TPbvP2eUiZJIeBS7OoL4zQ2b4lxWdrz5JnL/j0lnKH9PIoKKZYC?=
 =?us-ascii?Q?dtww3SZdKNi3j2SDu5aWknl+r/lgGecXHt5I0w5PGQkdK62hVQ/c+BL77/cJ?=
 =?us-ascii?Q?VCDkjsw8/tpLZLENVaahf/QVelLdYO0MOiwuvNUxJI2a5aqSHohyFnbN26S0?=
 =?us-ascii?Q?q84ot2bxTzXm6x+etDN4GviRZc6jbnsrR3TXRduWEyEVaHIGAWnEAk0/fV2M?=
 =?us-ascii?Q?qJ8kohfx/re+JWwfb/az+klEKAvidLdzj3MpFrln50nDsP+jQpig/mVds/YP?=
 =?us-ascii?Q?UVoBr0HO5KMPlAJCkuoPGDSvpagc6kDsj4mUU5YbLWcLvMgNIKag6+QYdyb8?=
 =?us-ascii?Q?QYSNGh0fwAnlxtC/ymvHNmtnV/mXqe1rLcnvTmEM6YDYDs8ARpG640ASBEw4?=
 =?us-ascii?Q?j254g/YhJvXcTdXaliy7onKqfh2/2BAyWG6qJvRSQmFJD/Z7xKbS1sZQMb6R?=
 =?us-ascii?Q?noscrA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qBLQjAQWvhtWMaG9tTk8q5KNMTjI5Btnmuw5Qf6Qm2NUc8DzIp6xprwRipx0JXS2ZtcRHULE63yA+HSg/P5nQw54ikfccVYGC0uUL3p/wmLKFojhZW6X8szHLyKK/4e/WJNnOTNuimW9aK6dydpREz7GximHgrY/tg/+VAqfWHjhnnAeZC0pYFWiPaWR3wPPirXGRPi1FhCUhJ4olcT9dPJSu/sRr7AsLmgANozgxjeXKYnxS4U5A5b8vvHAE3J/rSk65DiSUA3cmTLFh3eSxfuQhb1fFRtwMq3MwCZPsHQRBS6WyDy9lgOUh3niez+lKCNVcOPFu0MkL9kQL0FWD/ZMXjCsdeoX9ZRR7S1fEaqCaP7J0KwlGSwEp2NZ3ewGqX2jAhlwJWTgAbHhjenOnhm7xwKNUj4ShXTQ4eYGWDlOjxO1J0a4rWa9zOm/Ee0I
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:36:03.3879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114a9ebd-20ab-49b7-1eb6-08de62ee80c2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9EDA11A0
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

Update the DDR Configurations for AM62x LP SK according to the SysConfig
DDR Configuration tool v0.10.32. [1]

[1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am62-lp4-50-800-800.dtsi | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/k3-am62-lp4-50-800-800.dtsi b/arch/arm/dts/k3-am62-lp4-50-800-800.dtsi
index ee9e213be840..2122cf6dbdac 100644
--- a/arch/arm/dts/k3-am62-lp4-50-800-800.dtsi
+++ b/arch/arm/dts/k3-am62-lp4-50-800-800.dtsi
@@ -1,20 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM623/AM625 SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px v0.10.02
- * Tue Sep 17 2024 13:07:19 GMT+0530 (India Standard Time)
+ * AM623/AM625 SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px, AM62Dx, AM62Lx v0.10.32
+ * Fri Jan 30 2026 13:45:31 GMT+0530 (India Standard Time)
  * DDR Type: LPDDR4
  * F0 = 50MHz    F1 = NA     F2 = 800MHz
  * Density (per channel): 16Gb
  * Write DBI: Enable
  * Number of Ranks: 1
- */
+*/
 
 #define DDRSS_PLL_FHS_CNT 3
 #define DDRSS_PLL_FREQUENCY_1 400000000
 #define DDRSS_PLL_FREQUENCY_2 400000000
 #define DDRSS_SDRAM_IDX 15
-#define DDRSS_REGION_IDX 16
+#define DDRSS_REGION_IDX 15
+#define DDRSS_TOOL_VERSION "0.10.32"
 
 #define DDRSS_CTL_0_DATA 0x00000B00
 #define DDRSS_CTL_1_DATA 0x00000000
@@ -646,8 +647,8 @@
 #define DDRSS_PI_204_DATA 0x00C90100
 #define DDRSS_PI_205_DATA 0x010000C9
 #define DDRSS_PI_206_DATA 0x00C900C9
-#define DDRSS_PI_207_DATA 0x32103200
-#define DDRSS_PI_208_DATA 0x01013210
+#define DDRSS_PI_207_DATA 0x321E3200
+#define DDRSS_PI_208_DATA 0x0101321E
 #define DDRSS_PI_209_DATA 0x0A070601
 #define DDRSS_PI_210_DATA 0x0D09070D
 #define DDRSS_PI_211_DATA 0x0D09070D
-- 
2.34.1

