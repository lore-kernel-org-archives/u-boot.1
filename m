Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667C5C43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 13:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3A584A67;
	Tue, 30 Jun 2026 15:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oL08hXwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6537184A86; Tue, 30 Jun 2026 15:18:10 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFDE84A5F
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 15:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+BznOQZckchJar8YH2GPl84wbEklgkIz/QUHHwnpASWzPubOBbuzjTwEtTmbTP1DiOikoPJPx939SVEw8jp5n08aEcii6yQN5M2tZeTewB8JLWL6B/cWenDYLijZMFXCX0ByD3wURhF/+X89b8lmlwPtvk7GG06w4LJzTiZKojfHMVrv1CWwFwUw2riMLwWZUYERJZsixT5bBfkGo25tYZs1Zz002KFZr8HBMqna+QrHoA3VYPCw7eoTnIc54wOV3tXYN5QjvvtcJQS91loEM6TQdXHcH50b7B1va9m02wIEJ17LO9jZZoNDM1wKSP2XmZsNMV0zxh4ED6iOwB7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE78N8bTIu9bPomF1DKLLysS9g8ge0mE+fKnnvy3ZcU=;
 b=lbEHuOTGAE2G2y6LbQD/MFTsVmKMgCxGDuJoIvkGqjq3U7VV7EI1bTg2ctvPfwYGQOcaPkXvYc66nL+3e2RiHGYaWL2IaRf8yrJvVwBTVGW9Kw1ZXzsOktCa1xcZ4KwRtdQAKqKEul+7lcnX7h0i+Ko76aZuRXCDGWVeu4+H2/Y4GwJxryEoKksYSkWfZ60drFSySNuQMxFjUuAMxvMZ1ikr4zZTDJNxMTL1IsBKB+Dwxb7JM6zrQuBv/2IzdVYr9C+m331rVOgFK9Ag+2j2yAdnBvNOxLxWiXaqO4Nuk5gkP1uaIVN/3zy6rraupRiF316e5lBiE/z7uhRJ/zRRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE78N8bTIu9bPomF1DKLLysS9g8ge0mE+fKnnvy3ZcU=;
 b=oL08hXwprZPM/Gin9aHQ7sRmQIeGu+1kng/F3b/v/+CiDanOo0pUF6tfOGT47Zo5J0bzbGys63RpXlAcXA2ixEgvJIm64jT76F15KplSLWGqFqx9+gyRUTzHWlRN1stmP8ELdhes81XGAh4PDqxqTGJG/ghvdre6MeCmHQbeXVE=
Received: from PH0PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:e::16)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:17:57 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::23) by PH0PR07CA0041.outlook.office365.com
 (2603:10b6:510:e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 13:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Tue, 30 Jun 2026 13:17:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 08:17:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 08:17:55 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 30 Jun 2026 08:17:54 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] fwu: Make boottime check failures visible
Date: Tue, 30 Jun 2026 15:17:49 +0200
Message-ID: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=itzeUoF+YbR+oe7WEyXSb7EFi9tSIsULbSLtHDnr2QU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ5H/x/yUBviccBsQOaKnHOYV/O6HdVPHh3aOH8zCCef
 NOti5Q/dZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBE7lcy/LPLF4k/UOy57JKg
 qO8bDvPa2rc/V+XzMefI9QWx+vNpfGT476/Y6/z65WLJK7PlpuzO7LXpvenV/PFDwMW8Ixbtipb
 sXAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8fe25b-191a-4c03-2cd0-08ded6aa002f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 8mNG1FZxBoDwSqXLYKeDXs2PT94jIvXHIO+08LNpXAD3tASUQ8wwDfjtQHcGFXXBCu8eGfaFH6PmHq/Je+X+z9C6xoWLFSTnvEzFJwk0gUJ+0aNic7OnyAvSr7h1H4hM7tfh6PPQayhq4+vbwygd8rSeZOciht9msy1iqFnPZHPXgXGc0OyhyljL3RYkeSrJ7ulki5GV6Exz8oMMhgQvAo4ItXG1i/ZgWa8hoTx09CvSnPXGifawtzZVustpiCh4446KCG3X1awOOfOXq+T9OzLOcynYxErF9TMhwkgdBMFoeQKukpGM1lruXb5c7rS/5tyvE055urh00cjg40UVttzxb+9/snrIlEugZgFrHnpudV0ap1p2MasJAXkmZ/06z811PLZ6HcVImcA/GjhIh//yTSkk4puEoQdOjA2wpaiyAdRM/mNtjA8yNBBdJelyUrPXwBTKBVDlRO4enCIdgBFOwYYH7yIihc5RalPY1UFIa4NmodqTvEW7RYwYrKhnmX7SRY+NQlSfLaZ2uKGP6R1G8U9PDDo5fxXhBTmQabXPIOtNPySX8TX+y4D1XDVyz7idilQUTchvBSHmxpAuaWNxKMXSFXTp8UvU+A3tdvw7jEzJSC+VOU+yHw+qi9+fRFA2ecvVmvrsk2gF+CycxF0csvKHqoN8+OklzEMqxgkCemaxf6147Wbb0DjCk09/Se2pPqjEkRrfGjbfwW/xNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C6CA1lzA8mW9V1VBMGT2EnRSWMhr+D6TX4XeOSSgV8rs+BM0prE82GSJ1DQ88CvXe+S1mYcIudEwJVukbzurXBPBRTGPHlRUhG/yA4YbjT2zbtW+RZ41hy85K97sUjEHA9iXK/3kJUvLrFo0bIngvJrvA1HX9gl/8uH9KxOLCpX56K0kMLyLTeNbtuyQhIinM7hyIPx6Mtm3EaTTlOrdA8vIgOJlUDDtYwQ7z8VVjZSxTPA/b1ohiet/eQMl8aoM5PC0/T8FnfNSEY8Rm7A2p5dWCmAkj8NSVTsXshB+fKxFtblDq4xuy3OhRsypkUsuuF7emn9sBK4m1mx2fL8Zz/hzpvUTb7wJ/ZQFC7a3yMazwVmPeQHH1Xzw7mDYm9JCZs0miNaLVtKa6QzwbMMa3Cld6IeZOFs+PQAogfOvmyb21iJthhLobGO81zPMSnKG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:17:56.7664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8fe25b-191a-4c03-2cd0-08ded6aa002f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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

On systems with FWU enabled but without the required DT changes the
boottime checks fail. The failures are only reported via log_debug()
which is compiled out by default, so the user has no idea what is going
on.

Use log_err() to make these failures visible.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/fwu_updates/fwu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 2b11e5da061d..e9bb1b4fc656 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -759,7 +759,7 @@ static int fwu_boottime_checks(void)
 
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
 	if (ret) {
-		log_debug("Cannot find fwu device\n");
+		log_err("Cannot find fwu device\n");
 		return ret;
 	}
 
@@ -771,7 +771,7 @@ static int fwu_boottime_checks(void)
 
 	ret = fwu_init();
 	if (ret) {
-		log_debug("fwu_init() failed\n");
+		log_err("fwu_init() failed\n");
 		return ret;
 	}
 
---
base-commit: ea62096437b39ff9038f7169e461bfe7863ee85a
branch: debian-sent3

-- 
2.43.0

