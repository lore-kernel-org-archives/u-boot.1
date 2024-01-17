Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56551C47077
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 03:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398CF875FE;
	Wed, 17 Jan 2024 04:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MLhckZfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4925E875FE; Wed, 17 Jan 2024 04:20:36 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B1487252
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 04:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG4OFgFipUh+QFNJdrcIyda7sCtrvb/2gZfTDdhR1EG4v77sRRoN4svK8lI5U/ohiVMisNyWjkZpCNJxQCps/212GqXCWtdFYOLHf1HuoituybMutB1kP22kR5g5hXs/g6Jrgrr4wZV/N871j1hPHWpw7S0MpZWUhfNt5IPdcHlkb6ErE1RQfcXRrrCW0ud2mBTsTw1sLvftqZBoSHgasO0F1D4C3lqWD9oXxN4Yd6OiYDh8QHIH26PIbnck92zCEDUxUm0o1u6YaZ7SWMBhZBo/vOcT1pj4azq0YJ+xDyQdDchwpQCfvqUHJRiyI/+u+paifXXkcJcPZGH/MTgOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBFp1U/lz5TrfjvjiA/igUFBJq5kdHQtzGW/xl89Ddg=;
 b=axehfZbZxF2z/Jc5mOkA1yGAlZfh8lZpJOh9c0DeowtAAJNSvTA4Fzmu7KKRDTkt8vS1KlMGSXId0AFCRsMGnurqznb9E3USwuz/YmaLw/YgJ9FNAQvNivbxx9ZYr8dzQueFg1ts+fFkWgLxHrmx+QO/2y9Kai5MjFQXKgnHtRTkLSq79oMZvpLpLhV131Hwp/+b5ykJwDjfVDP2rWbeurVVeRxQ6hdWI+xIpwWuyqFrEnPui4Qb+atNcAY+1pC3+iESLFCOqx4g30U0SxI4hJnL93n4lV6Oc4bC3G9i6Cwowx1Izzh4GG8KEiMgJC3HM6rYmO4U97azPQLFc/ICbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBFp1U/lz5TrfjvjiA/igUFBJq5kdHQtzGW/xl89Ddg=;
 b=MLhckZfTQgam2v2dtA5SsivECI2XcM0F1v209jRVmoPRnHfijulCEIuT63uJbRdbswpk0/QG3n9SKSLoJNktNE4ZUjA0Lr8U2TMMU21TxqWrE85L8HqFaIBPp+HOqiZyVVx12T6KJJEThTqvoLMabZIljFZZlPG+fsWZ+Stx6VI=
Received: from DM6PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:100::49)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 03:20:30 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::83) by DM6PR03CA0072.outlook.office365.com
 (2603:10b6:5:100::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29 via Frontend
 Transport; Wed, 17 Jan 2024 03:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 03:20:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 21:20:28 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 16 Jan 2024 21:20:27 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v3 1/2] xilinx: board: Update the kaslr-seed property
Date: Wed, 17 Jan 2024 08:50:13 +0530
Message-ID: <20240117032014.1014084-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117032014.1014084-1-venkatesh.abbarapu@amd.com>
References: <20240117032014.1014084-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ce4376-cdaa-4059-fe74-08dc170b41e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUO6XscFE4u/jjBzmza80m3NRtQIqsrh4/Joh1/MiYUCO72Hu8JAZAnplBKw397dLAhCERdLCa8//qcUaDCQY7Ae1atc6saONunlYoZZ0hVQ2MvFvedmYAxj1RYEtMQ48v68iqqw1MzrdnJwPuTW3pxr0EXhO7gpGzITBlUuBDfpwZQNxV7hscHPm5DVbelY5n/3onrlQZZVm/BWbZv1PzIEO+6iP3LukOzoG4yPk/Y9w89jNW77XL3kn6MvfnCJyAREeEmq6axHEqZATVtKuiRJgFoeF7+gU8w2TWqASOFYzr0gsAu13dEAYIb2MHJT8SjZAYV8VKLpwZ/MEkHsQu6djdZv7joTUroBkpcOLvCV08HxAnRPKItaj54GmRRUa8HyhPnywZF+VOlpAFxHLpkJj+ojwC61Wev4WKJnWc+sd5D7HsybSsWthASP7qJRJEwbKGfp9PyNcfLGtoad65sZdXVBlm5y4+EOx18wyuK8ZiWTrETxWak13KM3np9d049eIB2Yp+NYX7zW8gblNmtNn6F11MW2j+wFIfC0B3xlvxHDd6k5rJE8w/W65v+XPT530xi8t2MfHFKm4o142S/MJc1RMuahZrTGy4igRuI8BHsd5g59sFyUfshZ009czGIuEqmSJppM88fqm/GbjyMpJVrlQP17IR4U/zH+8aVi2dDM9+4Ku80/rCtwzK+zQcZnOXnpQP/fjpzsN38DpSR//YsbXdRdVaeLZLY3TjZs2g/l3GuWRKMo7KaH5PtBhwok5rabPAWMaLvwt/Rybg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(40480700001)(70586007)(70206006)(2906002)(4326008)(316002)(8676002)(81166007)(82740400003)(86362001)(8936002)(6916009)(54906003)(356005)(478600001)(47076005)(2616005)(36756003)(6666004)(426003)(1076003)(26005)(336012)(41300700001)(107886003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 03:20:29.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ce4376-cdaa-4059-fe74-08dc170b41e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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
 board/xilinx/common/board.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 12a877c715..9641ed307b 100644
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
@@ -682,3 +683,51 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
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
+	int nodeoffset, ret;
+
+	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
+		debug("No RNG device\n");
+		return 0;
+	}
+
+	if (dm_rng_read(dev, buf, n)) {
+		debug("Reading RNG failed\n");
+		return 0;
+	}
+
+	if (!blob) {
+		debug("No FDT memory address configured. Please configure\n"
+		      "the FDT address via \"fdt addr <address>\" command.\n"
+		      "Aborting!\n");
+		return 0;
+	}
+
+	ret = fdt_check_header(blob);
+	if (ret < 0) {
+		debug("fdt_chosen: %s\n", fdt_strerror(ret));
+		return ret;
+	}
+
+	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
+	if (nodeoffset < 0) {
+		debug("Reading chosen node failed\n");
+		return nodeoffset;
+	}
+
+	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
+	if (ret < 0) {
+		debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
+		return ret;
+	}
+
+	return 0;
+}
+#endif
-- 
2.25.1

