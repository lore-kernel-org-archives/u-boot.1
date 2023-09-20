Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBB5CE79AD
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA22486C16;
	Wed, 20 Sep 2023 05:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yaOXvzcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F8C86CC4; Wed, 20 Sep 2023 05:01:10 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E65586C0B
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgwrpQGKMW8jq5IqfvWDkJzeKxCne/9wF7KcT2FEM2Fd0uirkJ6kLV/oP+q3X1QFPJxOYyqhwcM/G1rRTRBOj1IkQ3fWfDfLyOHN9AzyLvMtNSIndh6LSccHkcX4DmXvyEUMcTNCNEqi5T2cSVif+3D2ho7ID9uHlMo2dswIMt6cEFdZw3xJqVMMWFpOkcyQoGIdfZdj5kwGHJOnEIwAEW5IvzljrJkehF5lM1Nsx8LsaA+vY4y9/gxt/yUfd2JVlxgET1M3lJ7KN1oKtCcVZFph45sgm8cKmydPKWDySBmPkzbw1eK1fdwoHboZ9rJViC5winkubGwr9YckH4z2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJJvi4zwNj2jkYhzNnxbTNfUIupakwewvtiZOS5R2y0=;
 b=TGJzC13CM++JcXI4bDKrkxNvZK3jp4OSf7vaICDIwJvoGn/0YD1OsQaW98IzaEfgUsj4d5Vicw+opCN/jFwqvDFCDN0R6aorZ4VRk4VRx4AiTHVrmNT2sMRKDfeSAbEjmEPZMDQSB9x06Go4ntFlKI+uDa9Y1syCw1oB5Nq0tkM1Fc/w2AeGANPhBjUcK8/FWI5Ev2YsgYrZ+67DltgrDZcUGUVRc8lUVMiXTg1BkPYDY2bE0eE4d0xYTkVIdD9y26YtmkURbgqQVBJ9mcxk+r8vl/RDdM8P7QX8FKzE5feksGnZ0+1Noa1VIdlp52JjRxYWCI6S3JW+jIo8bKpxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJJvi4zwNj2jkYhzNnxbTNfUIupakwewvtiZOS5R2y0=;
 b=yaOXvzcBmZACq7bnEijvccKtZnzu51vgCCL7mJMlsg/z4ZrwmI4bmIf9zujbeo2Io1wVH3tWrEm+LZAyYnZozQwluQlIVe0LcAVrfC6jHydH0HVKSKaA8Ups6OBuGBVWxUzsPVEj86SW8rwYGKxkRb2X8soo+SgKUAghgQdVQyA=
Received: from MW3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:303:2b::21)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:01:00 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::b2) by MW3PR05CA0016.outlook.office365.com
 (2603:10b6:303:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.0 via Frontend Transport; Wed, 20 Sep 2023 03:00:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:00:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 20:00:19 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:00:18 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <git@xilinx.com>
Subject: [PATCH] pinctrl: Increase size of pinmux status buffer
Date: Wed, 20 Sep 2023 08:30:06 +0530
Message-ID: <20230920030006.6488-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 421aec42-dcc4-495f-9cf9-08dbb985d17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OGaD9tPx5KaGSym62Tb6+PmtJ7mIl3/oGzCxbf865dsujAL0ichrf8ejzEWcXAB+1hMDyOf13Z5CDlu/+nfFAnQhHjlUPgoTHeDwOSALAuRzKleSXnk+J5e1s+YPZttWYfVg9oArMncMUcBCIolBtD1Uf1iZi13KGLTvDRYwa42dMf05JBCblbhhDA6Ctm3Zwj8C7BNcO10EdtScdDW8okcrJdJ6Dg/oMWCJweyK3hP93/y9wDUWcDbqUiCBzKCffYkKoNwB6+dGlqhsLl/iVPK2qVHa0alzMAd8QxqIZM8AXJ+3ZSmu3cBkoIuu+q0b5jSOMzTi3nyC7YeKNuSjodXvpuQ2tyRMhsCckR/TO1i4JYH38QJPNebQfoFJ/5uJjWcqYEa7mA9Eucogd29doKu5yd/HtIcll+N8VI34ZpbppnBwYld7CU6ywGjyyNymI6bRT03LP8IiCCFJ9D4c0I8SaCD6sZgVwm2dA4acPBj3wFtCXzfmIozPkEqYIHSWdzx/V7Wgg3VeC3aZ38DmOSI9zjakrsM4CM3KKuHYobuAWWlnY/QJ4ZgqFviCoauOxlnTnVSNd+c12tmrkvS/vE48VLf1HdCC3kt30TQCEutc1Z/kKIFb9vDePxPKZelzTylTvJ00WiwGAutsUGRbwo0YOcXT8z21OpnZgR8+ClS/7H436zskMU7MHXgPtk80pMtakT5J/SKZMzEL93wFqQRrNOmgygSfzPNwmAEYBxLa3wgirn+WO4HrJx8MrVz0fgcIHTItz7Dv4SGDe0CG34n2Va1rc71AD1f7XBaGZk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(6666004)(40460700003)(356005)(86362001)(81166007)(82740400003)(40480700001)(36756003)(36860700001)(1076003)(26005)(4744005)(2906002)(47076005)(2616005)(107886003)(336012)(426003)(83380400001)(478600001)(8676002)(5660300002)(8936002)(6916009)(4326008)(41300700001)(316002)(54906003)(70586007)(70206006)(106533001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:00:59.7757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421aec42-dcc4-495f-9cf9-08dbb985d17a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
X-Mailman-Approved-At: Wed, 20 Sep 2023 05:42:43 +0200
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

For Xilinx ZynqMP SOC new parameter was added and now it can
set 7 parameters for its pins. Pinmux status command will
print the status of these parameters for each pin. But
current print buffer length is only 80 characters long, increase it
to 90 to print all the parameters without truncation.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 include/dm/pinctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dm/pinctrl.h b/include/dm/pinctrl.h
index e3e50afeaf..70d8cc5eca 100644
--- a/include/dm/pinctrl.h
+++ b/include/dm/pinctrl.h
@@ -7,7 +7,7 @@
 #define __PINCTRL_H
 
 #define PINNAME_SIZE	10
-#define PINMUX_SIZE	80
+#define PINMUX_SIZE	90
 
 /**
  * struct pinconf_param - pin config parameters
-- 
2.17.1

