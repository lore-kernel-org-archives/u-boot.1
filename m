Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4017C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 04:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3486984A0B;
	Fri, 10 Jul 2026 06:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="WUVatYQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4618407E; Fri, 10 Jul 2026 06:51:47 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DAE1843B6
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L35wTiPpFbtVRSUD3vT5qQhT4SLTAoZSwU4dZYO7gujCfztBLpPdo+xpqE5Q0JF0UzMInHUZfIIie6BxN9724WKNfBmXXIGC+RZgsYzQAPv1mOx5ig9dEXqmSk4lJqmNwgg1lINNqS1e8aLsB2VphHZzxz6SSr0Uac4tHEA+5Wh9+dDPJP1C/RlXAZT4wG8vlzgIIeT5w/h6XeI+LjMFAx0e2OorGwkiuktQx6lR+m6WCKFq7H4qncqOR5B2jACTf8nhWZtCRfULyW77Hj0a9C73mmiOeNw8wXUw82Y7+6Yv8C+UD5LlyEi5RFcK49y71oXnJjIqvYJfVIM7CXCI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf0kAYygGrgCRXSSBn6fH1cgbYhxLuKuETT2JOPaSRQ=;
 b=tMVFr126S1ipCpUDik/9sKsJnxuYBwH+hRLFPMv0NEHQjv0cvyTkbuAsaEi6jEIvT4aOOZCifD6X2aHB66KIyKln2fvaIKU1TsITsCtGRif4sjXmDUKa9rdI8AyHVIBuwWDrLiLCtzenl2PyYqi0WUt7MA0JqIsYNdo/JXeUfnsOBUXdP4Zhah7AhJ91liviA9svremRFU7VTBiKs+uCsSl09UTrM7dQk7pP9yVe0pZ8UFBWoS0qkf5jacjXlQiBCDE3ullK74apLJXf7HnOeYW7zKWiktDTHas6IfkdvUltBzmsS3ZG1XZYHeiCnANpE/JcPx6iISixcX1xbENynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf0kAYygGrgCRXSSBn6fH1cgbYhxLuKuETT2JOPaSRQ=;
 b=WUVatYQy8xNF87TjC8Qf/kRLOPhbWgCxd4SAfkzo4K9CaIhHYg2Z9MeZ/Oltg5dOqOfA0ZL7EEwUIs6wSBdsjkQ9AiB0EtZduwGbBg4NBg+hDSzeAZsa387+DuWzgV+KsmCRYvTxThfPmWN5KVorwlUvJguiXjEveKCnzN8AxLv5H9FPCzl6wPYgm1kDtl7SKiO5FgnilswtJR6LLc4szG//7J10vSng1B0Mqrl94E6UBweVRYhV0YX98qm60VVg6U1je92xDRmN/UcagMVYxqBoncflQzklfVCKQ0AvB+YS0noOQmtf07dhX6MNRRIqQu6cbVsppBFnzNbwn1Sx3g==
Received: from DUZPR01CA0294.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::13) by PAWPR07MB9735.eurprd07.prod.outlook.com
 (2603:10a6:102:37f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 04:51:43 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::d) by DUZPR01CA0294.outlook.office365.com
 (2603:10a6:10:4b7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 04:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 10 Jul 2026 04:51:42 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 654DE23A95;
 Fri, 10 Jul 2026 07:51:42 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Subject: [PATCH 0/6] watchdog: report effective timeout and add gettimeout
 command
Date: Fri, 10 Jul 2026 07:51:16 +0300
Message-Id: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAER6UGoC/yXMywrCMBBG4Vcps3YgRknVVxEXY/qbjmAqyXiB0
 nc36vJbnDNTRVFUOnQzFTy16pQb1quO4ig5gXVoJu98cFvfc9Fswi+xOA5T4gQzvYGDwMNJH/a
 7DbX4XnDR9298PP1dH+cron1vtCwf/431AXoAAAA=
X-Change-ID: 20260427-rinta-watchdog-gettime-6ae2e0a76983
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783659102; l=2526;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=O3GwvNXS8SQhYEtaTgNC/XPckMJ4KIAiXJLKJ3TRGSM=;
 b=mCy+k5N/VN0yolhvn23xfzSoG7v7jsuFeTJ5vexwHgHhubkXMhu1v5XIYr8fORIFqCEmHiT0m
 UqdT8gZDiILD1/3H9s2jP56rTk3NPsA3LTA2GpcVhmdJsf4IUHYdjpQ
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|PAWPR07MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b51b28-b923-43dd-40e2-08dede3ef006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|18002099003|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: cRrAFnbEXlGBlAxqk7qhs2Ena+klOzu2Jxqa2LplJoPYBUUT/9KVhgDl7c0lbvPoxstvhXMolyrLxs05toba65EMiZzUv/nCp0gr4Mknu18K2JsyLDkiDtWmyNyB0nlsxn5jbOJ8XDqmZndjkz1tEHTCmq7NpOtdZxSAaNdWzOmq0FvBfdqLVQlbXy22O3x4n4VSm+bTnqrReNXo45jQ+KZHpFYlF+hTKvT2peOlQm3bekBRe4qky4MK46ux3Mu8Tllld1iLiUBhbKk7wCdOU1WvX8t39m+es3Y+Wk9amrTNtBTXVY4kV2gROdau48mwmYC7q3v0i0eks4gj55c8tUMrm7KvajCfj7Y0361DVyFhSTqlH5slxkiRszwIQM2FkdKRsnE5+cQbAKMd4FNu+bllCqk9fc2kmlOezCiVO/0xSFfmwkh/WKwGy6qYjRiJLHLttLmj4UvDqDRnNZiTfNL5ebGRDPSRSd/rGaoGpSfDZqRcOPP/Y4KXQTMJB/riBuvLw1+XCAYec9j+ofOoEReAUVeTVX7QI5Fd8SAj12Ekbu8nbhyL244/7uajoZMcdxnsS1OQI5BWYVyQ7BYD/u1Par1LCGizMO67QD2/WPR6FrCHKHFOwXGN7Vt0t/9o5NIW58hE3d6h2SFGSiwulU4UNG1GnU4l6P6iqxViyMWH2q7/KOFkg7Qxs87NoQV9P/uyYBHgpILzUZuyE0l/Vw==
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(11063799006)(3023799007)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G2kGiHxqdU3iHROclk/3sDJw0tpEnfCl+emcSIVU0TmgT6GCh+IVrx9IEvk2ryYhoVyHqZPxBdxbhhFLvtbFoJryiUHfdXv7XTm2BNe3OtbWqckaGY5Tq5C28lu0qXzeutNBvnQpbJAYlpo5GyhYAEHIaM22paQy/F16CcvXEgCaeHvzmBLljZFeGcvUDHsSQ+idRqKt6ONO0Lg1WYyeIayfon4TUnposjji7f7fnnd9YY7hiujaMARFN2Oj2VbQ9gO3C/g3nlR/US1QdN02mg2IPHn3SlDsgumu1doey63fkNuGzrD8t7WhJXD0Dst8QZt3T0GIFa071Kt1dHaX4rL9UREq7THwmwmrkPoGljyK9Uqp8hAHx5tyNHSZcFmEvpXYU9z+fWIGxulbcc+uBDbSsAdr4rnFuJY1QL7HtWHuUFYvjO8YRYsFA9ITRBqu
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:51:42.8405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b51b28-b923-43dd-40e2-08dede3ef006
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9735
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

This series provides a fix for wdt_start() function, which can
print incorrect timeout values in cases where the function is
called with a timeout value greater than the hardware-supported
maximum. The current implementation prints the value the user
requested, so e.g. the console print may show that watchdog
timeout is set at 60 seconds when the timeout was in practice
clamped to 10 seconds by the device.

The series introduces a get_timeout operation in the watchdog uclass,
which is used in the start-path console print, exposes the operation
with wdt gettimeout shell command, and implements the operation in
sbsa_gwdt, octeontx_wdt and sandbox_wdt drivers.

This fix improves the overall correctness of the console output, and
can be helpful in debugging cases so the console prints reflect
the real timeout on the device when the operation is supported. If
the operation is unsupported on the device, the print remains as it
was before.

Patch summary:
- Patch 1: Add a get_timeout operation and wdt_get_timeout helper
function for wdt-uclass. Update the wdt_start function to use this helper.
- Patch 2: Add a gettimeout subcommand to the wdt command in cmd/wdt.c
which exposes the wdt_get_timeout helper to the shell interface.
- Patch 3: Implement the get_timeout operation for sbsa_gwdt
- Patch 4: Implement the operation for octeontx_wdt
- Patch 5: Implement the operation for sandbox_wdt
- Patch 6: Implement a test for the wdt_get_timeout helper

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
Juuso Rinta (6):
      watchdog: wdt-uclass: add get_timeout operation and helper
      cmd: wdt: add gettimeout command
      watchdog: sbsa_gwdt: add get_timeout operation
      watchdog: octeontx_wdt: add get_timeout operation
      watchdog: sandbox_wdt: add get_timeout operation
      test: wdt: add a test for wdt_get_timeout

 cmd/wdt.c                       | 26 ++++++++++++++++++++++++++
 drivers/watchdog/octeontx_wdt.c | 17 ++++++++++++++++-
 drivers/watchdog/sandbox_wdt.c  |  9 +++++++++
 drivers/watchdog/sbsa_gwdt.c    | 11 +++++++++++
 drivers/watchdog/wdt-uclass.c   | 35 +++++++++++++++++++++++++++++++++--
 include/wdt.h                   | 22 ++++++++++++++++++++++
 test/dm/wdt.c                   |  4 ++++
 7 files changed, 121 insertions(+), 3 deletions(-)
---
base-commit: 5a7117b0a2e3f41475945a4443a4e3adf8799024
change-id: 20260427-rinta-watchdog-gettime-6ae2e0a76983

Best regards,
--  
Juuso Rinta <juuso.rinta@nokia.com>

