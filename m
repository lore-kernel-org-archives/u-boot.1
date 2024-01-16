Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C58C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 04:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A25787732;
	Tue, 16 Jan 2024 05:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BnQvEekM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E84A4870B4; Tue, 16 Jan 2024 05:50:55 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3675875A0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 05:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFIkETOqwerv7XBDJY8A/kPZ4PUqNVIMEJj3XgqC5Cp8OdYO1zH8sh8sj9Sh0o2e5pfdtom30R0Wk1PijT4S10d65OPuRLfw47g+fTK0Z9Idr3ALJsT7/5GL3TjHgRkPU1GPG0kDsoyCREH/qcT4X4nDF0Zd+edi6Puna4xIQ5l2d8lJqhCWQ1F0fJHfwVkzG8H7ggHp5Tci3hfS8Wn6qv6clvV0QDhtdaUA6XZotjmrcf9ZAyLUhDqDpGmLNUX/kZduvBvXYvp3gtIuizS7IcigyyVQThzLyN4/j8Ogpng1Y6vWt2D2Z06rjz07slrWaMr2zMIQVyx2iSgWjVy/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r86ZffNC6FKkO8S6wWGo2kvSMaZtE38LKNtq+sW528=;
 b=NZwzPsZYYrEHZK4hpSfQBoMy1b3BvkmFSUVG0ZfPiswd2l5nFw0gIqmcGWR1Dlc4ukU4AIASIApbYLJEiTzbGKVlNGV5j0/8Woo7gTXUJ8lyT7XA0XWG6Os6/lZLYR3xL4dHJTyXw2Cu0SCcx/LpK5l3CRWWMEbi3NbPx4xlB/6ATqSR9TILA995HbyrlIBdMAt9umFkAB9ss/RnRgKdonBcTy2jlIWShSCTyinouyMsn4OzoJDL5IwWaeLugXhfj37GMgI3g4Jkgsfx5KDqmuTHbDIYMYxbRTfkdf+5GSFm3kO9o8ajezvqxrGLekfn+W4vra7nCngaJhRk63WbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r86ZffNC6FKkO8S6wWGo2kvSMaZtE38LKNtq+sW528=;
 b=BnQvEekMDncFWuVPRKnAYeqxwSYxdi2ltk1oKInYmJz0GQOy0G438stiGGcesnQogEicJx1RwE4fOeBV5WDKl2VbNSWLrgU3ZJrVbiol2HjnrJ1LhZT1ntfo4fr/RLCZoF00FcA51GEZpfxrUsLtYTvhcEeHGUjew3ZjvjS0T4E=
Received: from PH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:5::25)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 04:50:50 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::b6) by PH0PR07CA0020.outlook.office365.com
 (2603:10b6:510:5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.24 via Frontend
 Transport; Tue, 16 Jan 2024 04:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 04:50:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 22:50:44 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 15 Jan 2024 22:50:43 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2 1/2] xilinx: board: Update the kaslr-seed property
Date: Tue, 16 Jan 2024 10:20:22 +0530
Message-ID: <20240116045023.580837-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116045023.580837-1-venkatesh.abbarapu@amd.com>
References: <20240116045023.580837-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a19522-9f3e-4d28-03e0-08dc164eb603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkl6n+2AfdnwYxOrVzBvvAyzyF4zF2MumrmsKqjb95ipDCaG5PqzDkbRehZa0KavPkvmgTbh0VKpuTMuJsbFdWqKjKuYl1HHE545sL5B35nz6Z7hQ13NUiZ+2Lm2ZtP/YHHvFn5chwCmV9vCaP3Ax0D+hz9QOdTsdjYwMnu3AK28S0MybiC08oD2uMaWb8encq/VIRZp3+qWTaaGjcjOhO/7kYrwjdl13R3PIIsD5CkrsnUKuF4U5U23iwQWra1KgqEmsdILHF2fH8aPX1osMAPp8y54OIIL6K8hUv26PH7VPQm1wftAq8FcjwjuY9XNa+346S0KacxCFAcC1Tvwy4/sCzTlvKibrpUz1wgsJfTSdZlsW3PRhWRzFudJ61u/F0vtzk5IdtCQQlx5mVb9l2X0Cf6yPdXpEIpayJS9uCXajr8oBIXDVngYQwI0yKHFUTFnNnna4BtyTQF9CjtDR2JH3RKzFWybZSheYIo04vb77dFykwbkmtSV9HvZpYlhp5IP1gdq9FLIf6QhHzs9Bxl/hvZnBd3cTKQddjjUDapBqWDUynZRRQVew52NiXqeEgk7Fzjv0dLGuErUC/12rreabHn8vUrQzbfJzkWP9sLDGl9t411xFppq9TskW0nyke+9NV9iaYesBjE5x9vIWT1OsROQxxwUCfxBYqYXZN8m4RHeySI5Dr6aYMnC/xB1K91F/mU/SYUMMOLGfn7K5JdRGHFaWgmimhxO4NecM6dWwZJzf4fR7J1dttr4XIlk8OwtheuRpAJLnRuC8ecfYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(336012)(356005)(70586007)(81166007)(36756003)(86362001)(41300700001)(70206006)(1076003)(36860700001)(47076005)(478600001)(4326008)(426003)(26005)(107886003)(2616005)(6916009)(8936002)(54906003)(8676002)(2906002)(6666004)(5660300002)(316002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 04:50:49.6053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a19522-9f3e-4d28-03e0-08dc164eb603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
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

Create a ft_board_setup() api that gets called as part
of bootm/booti before jumping to kernel. In this
ft_board_setup() callback that will inspect the DTB
and insert the device tree blob with the "kaslr-seed" property.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/common/board.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 12a877c715..2796d45351 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -25,6 +25,7 @@
 #include <i2c_eeprom.h>
 #include <net.h>
 #include <generated/dt.h>
+#include <rng.h>
 #include <slre.h>
 #include <soc.h>
 #include <linux/ctype.h>
@@ -682,3 +683,52 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return reg + size;
 }
 #endif
+
+#ifdef CONFIG_OF_BOARD_SETUP
+#define MAX_RAND_SIZE 8
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	size_t n = MAX_RAND_SIZE;
+	struct udevice *dev;
+	u8 buf[MAX_RAND_SIZE];
+	int nodeoffset;
+	int ret;
+
+	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
+		debug("No RNG device\n");
+		return -EINVAL;
+	}
+
+	if (dm_rng_read(dev, buf, n)) {
+		debug("Reading RNG failed\n");
+		return -EINVAL;
+	}
+
+	if (!blob) {
+		debug("No FDT memory address configured. Please configure\n"
+		      "the FDT address via \"fdt addr <address>\" command.\n"
+		      "Aborting!\n");
+		return -EINVAL;
+	}
+
+	ret = fdt_check_header(blob);
+	if (ret < 0) {
+		debug("fdt_chosen: %s\n", fdt_strerror(ret));
+		return -EINVAL;
+	}
+
+	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
+	if (nodeoffset < 0) {
+		debug("Reading chosen node failed\n");
+		return -EINVAL;
+	}
+
+	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
+	if (ret < 0) {
+		debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
+		return -EINVAL;
+	}
+
+	return ret;
+}
+#endif
-- 
2.25.1

