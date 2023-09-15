Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7FFEE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 14:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C4F86672;
	Fri, 15 Sep 2023 16:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cXHXjA1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A71786680; Fri, 15 Sep 2023 16:10:52 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E406863CF
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 16:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD/whvCinImkWygZ6mcPT0hrpGmeL2Vo5s6mn1CY7321PyeDQzJplhZxQdWDldU+aqsN8tRYTaDaCAw655W3PJmIItHil4t3o2OhQ/ynS4LQ/b6Lz/SaNN9TgViwiEKaCEHo8o0YErOipudU2UtWzP6+aT04Jp3bf94h36Ui/pkZ28dCZSsc/zzS/TnARgZv0yOlf7t6NxILFCBsC9LeIbxaXrfG+x3Sy+wf+Iwbblxz2QtpAkoiuxfXq3ti32+exXNr5tSEqC/Z9YH4oXUVgVeKVZnZA+nLtLjMMTYg7s+qoULILBSanbF3IPYBPf3zp+30yq+t7blZduaROvMPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVGTn04eY+uigXqkjO2PTe/vxbZhd/7eAdbLOwkEo0U=;
 b=Z9UIH/aYQZOU5k3KRB/4mVjsXXkG7AZEP/+gicBX5BiYNS+I3DBT7FbdqCVVljJ6wxU8opRRhO0iAMA/HFfB8pHFlpiY66Hnxbn6pxyZm0pjJwDyl/RqsL+rRWE945qUDCgof+ViGagh6fZy4GIYzrXgIjguRHa0AWZoHvl0dP4mh6+K9NEl9whWMnWau8RlsVQFjCnGT8OUfxjnqb6CM6dI88pxPaD0lGjjWqZDb+OpfjTWdRR6Mu2PfjtiY1ypCZf8nf0jwRzOI7Vk8GAaEl5WKOROy7FzOHofah8JRjdz3tGa6+eAIYFOdbn+8FtHjN0nl4Jet/J2L2IWnIRuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVGTn04eY+uigXqkjO2PTe/vxbZhd/7eAdbLOwkEo0U=;
 b=cXHXjA1bPWkD5SNIMlu/CGJfLOwz1Q9pH3S48WcMtOQZk7W2yfvRzgagTetZr1AZF8cTYz+2WwexnDeyoU8OGeiiYBfm1stGga9pjgL859vrLUfnlxXjqcU8xxEaTfYkVVxL/5S+pa/UwoCZGnUlcecs26WYTFfk4PbvQc7RB8M=
Received: from CYZPR05CA0006.namprd05.prod.outlook.com (2603:10b6:930:89::10)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 14:10:44 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::ce) by CYZPR05CA0006.outlook.office365.com
 (2603:10b6:930:89::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.22 via Frontend
 Transport; Fri, 15 Sep 2023 14:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 14:10:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 09:10:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>
Subject: [PATCH v2] net: eth-uclass: Setup ROM source only when ROM reading
 passes
Date: Fri, 15 Sep 2023 16:10:06 +0200
Message-ID: <7fb2d512973481cf412a622deb747758bb539c48.1694787003.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=vBhzj3+eZbTdN5plRR7lmkMDoPFWTH4eQsfadEqOUmE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSW1N2T1Fv/l4h2hfyN/LdG/Oq2FT0av062N24VC7Lfp
 9i85JhFRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIoj/DginO+StVfe6Fha7J
 flh/Nju/OPdPCMM8nU0icS8uTb5+Raq9TDe6tSA1fs4JAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CO6PR12MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 672b3b25-9cd6-42ee-124a-08dbb5f58bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9/LSTdNEkzlW9NUQewf7ftICu3S6xR89E0Ak+LWmE0swV+xREWrxA+4mjxoWhl1Q/FBfjtsWP6k9gwUdLDqgW583FtLzE4IZaoa8jMSQmRTrdLaYfeknrqawFal2dqLJQviNlglqsOhMRmCc6w/c5Swa11mOpkDzETMxmgJ0jX/eApXDgfAE8/DDue9ZMl5+ATmab7k06VejcRGyOqyuWzpT0ocBrAf2mF3jLsTxWiUNnlXwqncvazastzHVxa3vfiXh7L+yeQwInboPqfLSNvBfubL9re9V7+2z03QVEp4LyPyZWDWKalQjOusD78ZwHXQbTkc7+uLieOTCeJfQNltc4nPYjjlR4Mi1p31GzX2HX7tQqmNMgGjGAd8ZAxEKoubSih4UaSGxsCXTU/CCbvWPMPMcr1ZMyE5PtR+rZHb2+iQodTFwAg0cG31o2OKH+gcJKHeKUkERegTtbFX0ZHSuQAGOUwD2o595AzBHteLsa5iPvfOItz+oOsjlbCIfdcBIFFrgOPCIiLmGgzhz+IDEfgbeaP10lRArIO4ZAvztcChoTe+3zJubl6ysJrL2qEOrGTXIz8G4XZouaHELL21LvpZ3eVg7KNU9ScVVQUtEYCvR4friufnk0O7vSIlTOgCiQq8P5mMGxmyOWStxJZmRRDoVXbP00hHdn0ZtP4FimDf9wq3EKcvFR8ltioi2vMMEA12/ut1hMVeXWnibEIWGFI/2vwY+ZlKTgo/utOPpF4QSBYFqbO+Qj5+HvNADKTcE/3f0I2JLkdm0gC42A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(41300700001)(36756003)(8676002)(4326008)(54906003)(86362001)(70206006)(110136005)(70586007)(83380400001)(47076005)(5660300002)(36860700001)(316002)(8936002)(26005)(478600001)(81166007)(2906002)(16526019)(2616005)(336012)(426003)(44832011)(40460700003)(356005)(40480700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 14:10:42.0229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672b3b25-9cd6-42ee-124a-08dbb5f58bdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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

There is no reason to setup ROM source if read_rom_hwaddr hook doesn't
exist or reading mac address fails. It is ending up with confusion about
mac address source.

It is nicely visible if you put mac address to DT as
local-mac-address = [ff ff ff ff ff ff];
but also save ethaddr to variables
setenv -f ethaddr 02:18:31:7e:3e:01

Before this patch U-Boot prints that source is ROM
Address in ROM is		ff:ff:ff:ff:ff:ff
Address in environment is	02:18:31:7e:3e:01

After that source is DT:
Address in DT is		ff:ff:ff:ff:ff:ff
Address in environment is	02:18:31:7e:3e:01

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Fix commit message

 net/eth-uclass.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index c393600fabcd..e40b869e1c31 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -588,10 +588,14 @@ static int eth_post_probe(struct udevice *dev)
 	/* Check if the device has a valid MAC address in device tree */
 	if (!eth_dev_get_mac_address(dev, pdata->enetaddr) ||
 	    !is_valid_ethaddr(pdata->enetaddr)) {
-		source = "ROM";
 		/* Check if the device has a MAC address in ROM */
-		if (eth_get_ops(dev)->read_rom_hwaddr)
-			eth_get_ops(dev)->read_rom_hwaddr(dev);
+		if (eth_get_ops(dev)->read_rom_hwaddr) {
+			int ret;
+
+			ret = eth_get_ops(dev)->read_rom_hwaddr(dev);
+			if (!ret)
+				source = "ROM";
+		}
 	}
 
 	eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
-- 
2.36.1

