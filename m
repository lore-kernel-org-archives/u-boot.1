Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D53E732DB
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB48286E76;
	Thu, 28 Sep 2023 16:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="2XPlTBH3";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="2XPlTBH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE3386E5D; Thu, 28 Sep 2023 16:45:22 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD13686E5A
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPUZSpuq56AV6UfStoLp7dp9l1ubcWbUL8cDDAoe0X0=;
 b=2XPlTBH3mgAI+S5hkXoFnv0DEZSenQw78SKK8Bv373giH/vfw3+FfI6ev7U19GyE7tqPS+vaNCOjwKRFHN6hFUfvRWlORk67Dxe4Z0ZWRLrDE1p0QF0zIUkw9NIbDFkxffWB4CN1nYL4wVs+k0b9oOCjzX+Zn/cREpZ3W1nAiLDqyje3G3IB9oSDEQIfafYq/AddQPDygDHC+Je6dzHB9nCNgu/0pylwhtQciAynp1fSUeBAUaigoy4kcDyrp3TC/DcY4WI7fOONcaHbFHIsFjGuB74pMmpA1eew/Y2bnpSb8eC39QXZOCdGOnvMN88nPrS7RQzeRNNgzyR4Ccz64A==
Received: from DB9PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::29) by AS8PR03MB7285.eurprd03.prod.outlook.com
 (2603:10a6:20b:2ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 14:45:18 +0000
Received: from DB8EUR05FT014.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::49) by DB9PR01CA0024.outlook.office365.com
 (2603:10a6:10:1d8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24 via Frontend
 Transport; Thu, 28 Sep 2023 14:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.81) by
 DB8EUR05FT014.mail.protection.outlook.com (10.233.238.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 28 Sep 2023 14:45:18 +0000
Received: from outmta (unknown [192.168.82.135])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 E31A2200813AA; Thu, 28 Sep 2023 14:45:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown
 [104.47.17.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 53D972008006C; 
 Thu, 28 Sep 2023 14:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVydDt7w9748rNiNjJSeEtju72mPat70obap3kMcaAcwDn3hm/MYAijRRwfh4Mcn0SW5mthM1UUDfNmt2x5OKGLdX8Qc98lQYRzpejqZV8dYZCOUnT8f8LGKt5kh0sL4XHOzDM4rY2bGjVgI/Kyucy4LABaSgtsUM8EioO6LW2hmlM21H6DyCDlNrUzGkqblJd5wdt+c/mkfI2MyEi/3NDdZJciy5jZUktDtYFqpbL3ZugakP2I3eftGunVXF1j8gORo/j6nQPILJ+yU810z0j0d+xOEYK/+7AcYk4/qBf+nb9d9+uHD8WUibVhvadA4Fd/6Bcr2o4S6gYceNQzWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPUZSpuq56AV6UfStoLp7dp9l1ubcWbUL8cDDAoe0X0=;
 b=QWMufJ1asHfOoseC2aAZ2aUdEfJ1DWqadY9RuPcJYUfJ1lbacxbuWgCDd7v2FY1Q4QmFTxiQLADqwp85yqJd8X6RwvHKFzU8mORGEvoIrE0XAwO6ua1nm8361uWTvxZ720YsSs4Dlmql9IhzWk4CkjS898D9ngQTg2ScrtxcYGHlhC98maTLqqE5qR5s9Qk8zpBVzmjAJcWYCLDPJTVwzpcSGhZEDp/idg68ZgPi5s1+RC01xZwHWvs+/f9OHNiRMsK1/h7xd21qpIxLlujEDLYb+uYJ5/UpCGVgfDQAprVvDeuvvJzHWq2s2OyYbY/X3eJGJuLDYTn8eK7wIbI6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPUZSpuq56AV6UfStoLp7dp9l1ubcWbUL8cDDAoe0X0=;
 b=2XPlTBH3mgAI+S5hkXoFnv0DEZSenQw78SKK8Bv373giH/vfw3+FfI6ev7U19GyE7tqPS+vaNCOjwKRFHN6hFUfvRWlORk67Dxe4Z0ZWRLrDE1p0QF0zIUkw9NIbDFkxffWB4CN1nYL4wVs+k0b9oOCjzX+Zn/cREpZ3W1nAiLDqyje3G3IB9oSDEQIfafYq/AddQPDygDHC+Je6dzHB9nCNgu/0pylwhtQciAynp1fSUeBAUaigoy4kcDyrp3TC/DcY4WI7fOONcaHbFHIsFjGuB74pMmpA1eew/Y2bnpSb8eC39QXZOCdGOnvMN88nPrS7RQzeRNNgzyR4Ccz64A==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com (2603:10a6:20b:56e::11)
 by AS8PR03MB6870.eurprd03.prod.outlook.com (2603:10a6:20b:29f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 14:45:15 +0000
Received: from AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5]) by AS8PR03MB8832.eurprd03.prod.outlook.com
 ([fe80::afab:7dfd:192:dee5%5]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 14:45:15 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 4/4] malloc: Enable SYS_MALLOC_RUNTIME_INIT by default in
 SPL
Date: Thu, 28 Sep 2023 10:44:58 -0400
Message-Id: <20230928144458.2511087-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20230928144458.2511087-1-sean.anderson@seco.com>
References: <20230928144458.2511087-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR03MB8832:EE_|AS8PR03MB6870:EE_|DB8EUR05FT014:EE_|AS8PR03MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 037d81bd-676a-4cc9-238e-08dbc03188af
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PzrjJoPUFY/kQiamQE2TUjlJBG1wJzxn9rkfIHCpydNqsqatqYFW/6f/B2UqFXZUIrtFYIFJ1dgFozM0RKoe0aYukG3YQAaMTMldhM9nx6kKnn62v5bNWG17oRjo9Y8z0B5XOwUHTEZB7BwYq16olEfUbtobc56T6LeNPqICuoA4xM0h2bE7dm2qZkKVCLsUVzqRF0sJjShDmvJxmj7Mhn71ILwH/r28T6/uiJDUKGRm5ataQRZGogAGQrSm4CmVIOLoFud4j1GVwYUVL7HrJd7oHtcpTBFIfR23j2mnZS3Kgkm3HtRXJRtFRr+b7sv++zWMzzVoTtOqviPuKhAiVMdHg+7tVp09P2Br1OzvGrqMbuaNH+ScbawPluTpSFt8lzEpa1dLnLdHNTgQsnhWB0tZaftclMU+uKjOW1Jpwr+kvF+VUQHWtcevlgfVOmrww9k5mYxCTVbtib7W40yd7Mibir1ljZjNaWlT5kWM/rvAXezVbRGbjqziHHIpru5Tz282xG1nFQvoDPSwOZszgLo5zXD1RNDaWUc2HhCwcxMkakXGbpkUJItljCHyfKPBJ99vWdx7KNsvcHXSKC0pQc/9j8AFEvG5efdcaX+OuHY3gtIkv4H8xqee/KyqiZ2+
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR03MB8832.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(376002)(396003)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4326008)(41300700001)(316002)(8676002)(8936002)(44832011)(36756003)(5660300002)(66946007)(66476007)(66556008)(86362001)(478600001)(1076003)(6506007)(6512007)(52116002)(6666004)(2616005)(107886003)(38100700002)(38350700002)(26005)(83380400001)(6486002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6870
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT014.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 31953179-73c3-4c22-5a79-08dbc03186c0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOUVOlCtORNrG+44qpAjrAXojpQ9SKUfEQ7dwxa7jWttcM9Pm+lFpOEi1N1UIilvi4ZK0h/5vsvIN+x/jLde3cTqjWBL4z6Q2xUt5TiNno8W6t4Jq7cnhQeu2eDUcJ2q0uRrWS+XrNw/qqCK7+crdbTvzaaKK2V5hawIMOaKPZRTCj65gF8k5QDEkP/PNnfa+NpActoTAjihXIkwmIQSlExpgqOnF4q7uv/9JkieL7GhOgIjvh8uX/JMVSH31uEDQ/guAoPRTHmnvSN2OyPIJLdz/NT3Fn4ZzRyiJiDBl3zkrmTZrRL3JLwjPNXsvpqUnMnTexYvrF9IUoeuajJOQ1Y4jw6aEpwmCZp1mMlMP7bl+ttxVsuJDjoNZcPs2DbTL2bwyobLlAvvSPjl1nDKg5ZSQsy+pHgjB4Vuk4arftEsuNY0EWhYDXPqFvCRF4YEHzr0hPMQM8RXSSXvE2LmE9UzqQNHME4kjnPWLkqwxupmfM6qSIM/OLF5wnR73ezaNMJSkYoKIObqXDRXLzbhu+JY+kxR8VP0xIw0L5bT8nmxSNXDT40K+AsCdHrIiMvvGAhScxibmJrzXg1UbPZVTBpuJbzChm1Ir7J00u2qmJDyz6UUyviBXsC9dzffAkppEdlgTiEVxmoKgKKWsGtzHNYJyM2/ZaTOMf2WYc/QZzYBcoeF2tq06W5yqhjvsSeZWAO5u3QzccgsN3WEJGXDMw6B63WxXcE/e53i/Rg6SgQEpHVV9Y/ahEwD1bOTGhRQh2XC303CVvuc00o34lUcMg==
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(39850400004)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(40470700004)(46966006)(316002)(41300700001)(336012)(40480700001)(26005)(2906002)(5660300002)(8676002)(44832011)(70586007)(54906003)(70206006)(4326008)(8936002)(478600001)(6506007)(6486002)(6666004)(6512007)(40460700003)(107886003)(1076003)(47076005)(36860700001)(34070700002)(2616005)(36756003)(83380400001)(7596003)(7636003)(86362001)(82740400003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:45:18.1385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037d81bd-676a-4cc9-238e-08dbc03188af
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT014.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7285
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

On boards with size restrictions, 1-2k can be a significant fraction of the
binary size. Add a new SPL version of SYS_MALLOC_RUNTIME_INIT. As this
trades text size for BSS size, enable it by default only for boards with at
least 16k of BSS.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v3:
- Don't enable SPL_SYS_MALLOC_RUNTIME_INIT if we are short on BSS

 Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Kconfig b/Kconfig
index 3967613b232..da5986e2fe8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -414,6 +414,17 @@ config SYS_MALLOC_RUNTIME_INIT
          reduce the size of U-Boot by letting malloc's data reside in .bss
          instead of .data.
 
+config SPL_SYS_MALLOC_RUNTIME_INIT
+	bool "Initialize malloc's internal data at runtime in SPL"
+	default y if !SPL_BSS_LIMIT || SPL_BSS_MAX_SIZE >= 0x1000
+	depends on SPL
+	help
+	 Initialize malloc's internal data structures at SPL runtime, rather
+	 than at compile-time. This is necessary if relocating the malloc arena
+	 from a smaller static memory to a large DDR memory. It can also reduce
+	 the size of U-Boot by letting malloc's data reside in .bss instead of
+	 .data.
+
 config TOOLS_DEBUG
 	bool "Enable debug information for tools"
 	help
-- 
2.35.1.1320.gc452695387.dirty

