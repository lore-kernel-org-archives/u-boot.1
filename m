Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290EDC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 03:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE6487708;
	Mon,  4 Dec 2023 04:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OCKxccGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D54F1875BD; Mon,  4 Dec 2023 04:13:24 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C78787708
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 04:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnaAtly3UyX9wQAwhQUmxpcrwtNU8Phzum9gFVUGj852+f/odLQ9s6azXhwNhO2ua71W2VSOXw+8+YgU8ude/DgsX9c3ezjIFVSl4P4NKAv5fwPxistd5D6y5kl+F5J3lNdW8pEVbD8PXuSUQ8gCJQBBjfCy1IQNfszZ3vpWY26OMNQPS5ijTqweoKVmjYqRNf5/To0g8YI5FpmrubX0+NifbaQhxw/LgfYWJh0zm2wl//5GUgskj7iYAuJ1MySzuQa4T/95Ox5+ER3133MkLblFDk8PCOdUXmXwyivkRkw1m/vhY6ulQ37Vb374JT19ili7RXc0nKZMNYt7eiadig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01Eix/JUVl0oECZRkRp5C1G/GE7EA+YOti3JH/gQrXs=;
 b=GHPjg5GOFXiml14wln0R1sVckazfEehFAHrKDX4U7rcnpiRhb/P2V7ZB23z8ptQhWYuZQxhj/CnvcnS0Cyl0VePnk7Xk9c5GzyX2xUJKZtl6lzHM8+8kTKXldkdwofn/0s1myiu2E0gcUyGWYCsjwZndZQwi88Z9vrVLkn385ydIauNgFup/qNRatdjCI/SfJ/C2FD7xgosuFy5kS5Tq9Wt38E5Hfh1fhysDAEvvukvkTHYbWj/QSqn9SehijoDYAYIQCftZhwDX2m1EXAJYzMxSEkzif38xtYp1CuF5UvLojWuRtmBPnOHvZRQI2lvWnP166NRYQsO02geykfJXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Eix/JUVl0oECZRkRp5C1G/GE7EA+YOti3JH/gQrXs=;
 b=OCKxccGMCbbfrg0SdVweb+q4JcFix+dr8hiGCoP0hi7dB2vWNAlBvW5vxOM3u8O+Jnq44ykzqu8bm13kadsYaWXX4kQF+qHM5+H8zHqwxvS0PfeFvIMGu253GqvBBQlwzTU6ODORWdUuvIqELALx/3FkQQExXnagdWg3xcuPF4I=
Received: from CYZPR19CA0007.namprd19.prod.outlook.com (2603:10b6:930:8e::19)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 03:13:17 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:8e:cafe::ae) by CYZPR19CA0007.outlook.office365.com
 (2603:10b6:930:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 03:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 03:13:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 3 Dec
 2023 21:13:11 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 3 Dec
 2023 21:13:01 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Sun, 3 Dec 2023 21:13:00 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <lukma@denx.de>, <seanga2@gmail.com>,
 <git@xilinx.com>, sreekanth sunnam <sreekanth.sunnam@amd.com>
Subject: [PATCH] clk: zynqmp: enable topsw_lsbus clock
Date: Mon, 4 Dec 2023 08:42:48 +0530
Message-ID: <20231204031248.6938-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 088a059d-85e0-429b-9cb0-08dbf476f5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++eRGB7QeuZZ0wJwD99QfgbKFKisUAaeiHx+cnB+Ms4hftqIRxQ+jkgK8Np939mBMiO8FNI1eJY5d/smhMWCUHcMLLCkuRrSECmaLdeX/eL9JiyiboljMcjOzlP7OYfk+RweARvXP6odf7/k8Wmk5wqBJP6WrbldVkVzSVbMQWFLLtlsTaqL+cTuXoyDm9C+6drgNcDXggrYIDAumQSR69ygxqY6Gts8Mixzo4vimQHRdmxENB1Mu02NveEededb3f3fRFy7eXH55t/nPW7FlPTfIQ61lhzycKOSYTPhAsnnwy9POMuC079/u/cacTf9QxKBWVgfY8XPMs3QuKjUDj/h4RmmHtNjzPrjhJBdMpUwXbMc/E22YWe+4WMY1ibaKa8+NNvQdKHQRHAYYNcHjmxV5Wf3RDqFKTYQLCy9Y/uysswr9bFa+HAzpdkeuWrF/BgNkn3ilrQ4txZ7iKHF+wWUTXayHmZv3k15FTNszoiONABNm27elLYP30/C89K11p4EdyXP4Xi079Td5tHOAKEA5KHR5ato8eAwSFXlHDbdTLZU4MezoP9qogCrc2mUYfaqOnCSvSJ+hILTfhBAG+WpzQ3zoXTTP6eQDXhTBuNj7SUryGpCFzsg+VJ1xBLT0f3MbLSyHE4pP1KiSjfDt1kJBQukeAzuGjAUMTNT1ETTvMd88MGSePHcmKbTcEEHzGwfs++zDt5nA9/4nLFuEx4b1pHWVdXjDw9NgpHA7uE2SiFyYjk2grCELlynWkt8cbpnXuORtrqZ3ENCCtNahg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(70586007)(70206006)(54906003)(316002)(6916009)(478600001)(40460700003)(6666004)(4744005)(5660300002)(41300700001)(36756003)(2906002)(86362001)(4326008)(8676002)(8936002)(1076003)(2616005)(36860700001)(83380400001)(40480700001)(47076005)(356005)(81166007)(26005)(336012)(426003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 03:13:17.1533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 088a059d-85e0-429b-9cb0-08dbf476f5f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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

Display port is using topsw_lsbus clock, it is failing
while enabling the clock, so enable the topsw_lsbus clock.

Signed-off-by: sreekanth sunnam <sreekanth.sunnam@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/clk/clk_zynqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 1cfe0e25b1..c059b9e8e6 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -844,6 +844,7 @@ static int zynqmp_clk_enable(struct clk *clk)
 		break;
 	case qspi_ref ... can1_ref:
 	case lpd_lsbus:
+	case topsw_lsbus:
 		clkact_shift = 24;
 		mask = 0x1;
 		break;
-- 
2.17.1

