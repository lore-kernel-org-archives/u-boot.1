Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F71D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5383283B72;
	Mon,  1 Dec 2025 12:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ISkdMEm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB2C83B30; Mon,  1 Dec 2025 12:01:36 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0AF83B55
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKeHirq3Ky9U72kzz+AOdv9/cgrZea9azN/noQ4eNs9uEpYoCJUM8fICWOJ/ULSasVUAyh1ROTXE8tXc0G2+BE5fX6DgZqi4tSHqaLUPSXj2v19vGUlwOMyXuw689mm8xQ6dbmfhkqXRgZLoEOqtr8HE5h4Qz2iuYdPFLVoOA+ZkFOIdo7bunaUFxyxQSLMUefHwBuxQlbiZGqIrjk7lL8FwUoQFm2/j0UdRHJ2J6De9fcilnSkC6LF+mqCc/VkKp55llmpfblaLEOZjgv2E/s7jPpEjKF5gHXIez3yd/pMJ2yv8/+/EiBKYX8d7ebXlZyffY5vDvnfT1jb016kyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2vpFSX3slLQaUw25wqfn57Mzw13fPGQyfY0QsLk1I0=;
 b=afD8lV0DtFx6zkAeNKaAWd6TgQgo9Q4eIjVcMhU6bHUhcmdWP68BAmD+eIq+OrKl0N95meItH+NQf530pOwIAOY60N4JkocgKUsg4Rbf2gFmRFgQvMSIeg1UY9Qj6Sj5AcTeoFNY9Hks2/Em1kgRTb/csnsd+ulVjzJtbmFwTcF9B9FPeZCv7u2uTITEzpuzgvy6P9sX7tahtDSDVej+Be2vqkSVNvyf7W20CLHLyTTp5EJ/Srn0VlP0s2FM2IZgkn3TZ8FgIk70SZKWCA/GOZRid8kz6a5v6Mi/1HwahdNieG7Lj11SBIdDq84CrK6OPP+pRyUkTCb/qfZNrhwdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2vpFSX3slLQaUw25wqfn57Mzw13fPGQyfY0QsLk1I0=;
 b=ISkdMEm8LjS0OpwYi+YTToWXHAUer7HDxzlsccy8gRi3NHkuoj4MmSsC75uz7yqBir8nQHBqfOGgsd4yXqVtlT9KEa0gC6L5PPMUflBzCc7UoQQB5MFg7th3WQhCgv7YqJgQ3H2zko0OqIWVWedKdZWA750wLWcg4crnITz3kio=
Received: from PH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::33)
 by LV3PR10MB7865.namprd10.prod.outlook.com (2603:10b6:408:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:31 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::cc) by PH0P220CA0018.outlook.office365.com
 (2603:10b6:510:d3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 11:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 11:01:29 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:24 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 05:01:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 05:01:22 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1B14qa306512;
 Mon, 1 Dec 2025 05:01:18 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <m-chawdhry@ti.com>,
 <c-vankar@ti.com>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <jm@ti.com>,
 <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v4 03/10] phy: ti: Add config to enable J721E WIZ SERDES
 wrapper at SPL stage
Date: Mon, 1 Dec 2025 16:30:56 +0530
Message-ID: <20251201110103.845413-4-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201110103.845413-1-h-salunke@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|LV3PR10MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cb6b29-3b14-4011-c231-08de30c8fb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a3UDULGyMoQR1+UL1SWU9DNARBjkb0FSSAefJP43VS2yZGoeUMutAw+gjLyf?=
 =?us-ascii?Q?3HnsqZzXVG98gIlQh1Y1wJcihygawDca79jzmztygNrmxbl2hM9nIWcXn6Jx?=
 =?us-ascii?Q?Xvka4tGAcXJq+CIYadsOUpm2x8oCfsaatuZg4zpnzQMIP8EiSEfjk1c78fVu?=
 =?us-ascii?Q?ZvfESjDTF7WGJF7oBhC59SAfhJ9VVWwV4heQVozD0gmtmRnpBVF0qlo+EaIR?=
 =?us-ascii?Q?P1Ux4294F3Zu41cT/7+VtkNW+CDgaJdC3fk81oHQhad6w2lANYdWYPZHOXq5?=
 =?us-ascii?Q?7N/6oY32NIB5hnhEe5Z9/86xWiR/mQkFMteMGTonjC128nBuUQJM9t74Rqos?=
 =?us-ascii?Q?dAht2Ncz89UIRzNLNyyfAHI4NtSvQHBk/apm9C9hBuCVqHEMzoOuk5Boaz0J?=
 =?us-ascii?Q?0iC9bBda4nSs8kmx48kUVM2yMJ7BK6y4IcTiqY20fxpQygu2FDyEIjOgIb55?=
 =?us-ascii?Q?3XvMJiWhp+1YuKrQc+NOpCRMLR2Bm4v+7hX0uBCwmDYeFNNhfx8csDI5JTVP?=
 =?us-ascii?Q?YAKcJ/UK9TO0udEriKzPvJSvmx2hajmri64rtCTo2sfSc1/TMtcnImifadNo?=
 =?us-ascii?Q?oeXiKXQbSkfZzwQM0bScfVM8KM+tSKznWXQswUjjPQHrclSc0imBHRm8Sl34?=
 =?us-ascii?Q?r17zOnNOH/b0Avx5t4W8PKsVqzN/eaLhAxD/jpsCs6yIPclSYeQsfKTBg479?=
 =?us-ascii?Q?pf2/UQEO31EEHYuTAarfX+pR99bxfLqgWmDHLRc/Fcj1rPp4QyO4jsdNvpgf?=
 =?us-ascii?Q?Q46vPWoZbQvPyuJKp6vLvHoCs4ECIvA5cfn5xZF5O3QqyRS3dsGUotZ7D2Up?=
 =?us-ascii?Q?UDkf6omrXTkj28ZSM4QddV26qLMIKnYXzQ4tgmOM/BkGs2TEwbwIDvY3YP+y?=
 =?us-ascii?Q?xoCvnwnbG8tlH45lx7LtbIJi2lLQL1PxuugeRsVE6IBUYPIegWFjVXboUf3E?=
 =?us-ascii?Q?1JkjbskSI/SnuOTxPMOoVqbq0Jk0+wJG6xUnmYSREXevT2ZYsouNCay2C0cB?=
 =?us-ascii?Q?lAjrpDa39NZFx7kznescJU3vBoU7ED+QDE8l67cM1HuM4VaAXSMH0SnMaryD?=
 =?us-ascii?Q?gFnsmXizRoCfbsfcXlF8UZR4wkRCs/XgbBuEmrgs/w9nAKLknigsZizz4mEr?=
 =?us-ascii?Q?aOsVTUZZSTbjVzgtm9hoCotmtYnDTWo03B1ndhkHdkLze46x+aKIXa02C8NQ?=
 =?us-ascii?Q?aJTM3MVLGplOfodKOrnCGbA4SU3y07GxgxGh6Uo3R+oQlcHCO/eLAH4DrBIo?=
 =?us-ascii?Q?2a49HqO4BgGsTb2be0XKSNdSxZFEnviWfZ2lFuRP7FYEIo09f8/NB57U2ngZ?=
 =?us-ascii?Q?9v/0ME+N7ZOfgabUKducyZ4WZF8s7MZQz/8bQYlK8AO+qInw3mBbxUnRwqu2?=
 =?us-ascii?Q?j2J+p6m192ZUs4NTcpv2pw5nrw57sAo/l1ZaRPQWF6XtIVGgmNhFmDKO6tYw?=
 =?us-ascii?Q?Jy27JxKzj9JTcEOUlxVjO2JxzYeSl6FMPgn5+nsF9UpDtg67SRXxlq8I9iM2?=
 =?us-ascii?Q?CzIDA+GA4KksSabE2DMLhPzcfvKU+weyHtrlAw4RfUXSitn10HLABUdh1RIw?=
 =?us-ascii?Q?IU2c1fv4dh4XPhjQfzEpBL+y2vetpqrRfHHj0DBV?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:29.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cb6b29-3b14-4011-c231-08de30c8fb41
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7865
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

Add SPL_PHY_J721E_WIZ configuration option to enable the WIZ SERDES
wrapper driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/phy/ti/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 111085f235d..df750b26d66 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -7,3 +7,13 @@ config PHY_J721E_WIZ
 	  signals to the SERDES (Sierra/Torrent). This driver configures
 	  three clock selects (pll0, pll1, dig) and resets for each of the
 	  lanes.
+
+config SPL_PHY_J721E_WIZ
+	bool "TI J721E WIZ (SERDES Wrapper) support"
+	depends on ARCH_K3
+	help
+	  This option enables support for WIZ module present in TI's J721E
+	  SoC at SPL stage. WIZ is a serdes wrapper used to configure some
+	  of the input signals to the SERDES (Sierra/Torrent). This driver
+	  configures three clock selects (pll0, pll1, dig) and resets for
+	  each of the lanes.
-- 
2.34.1

