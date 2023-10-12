Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970D4CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5F786DCE;
	Thu, 12 Oct 2023 15:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cvFubdNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E421F86E02; Thu, 12 Oct 2023 15:03:02 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284C586D0C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIR2shdnqIxE+EI4Oh+z8M1J+KtDp5MoYPi0Og/CrZMpwt+oJZw7tNyG0xYxg/8gJcUEcGVLP+XTRR21ABxShQ6JJ00HlFNVZYkKEYe6TRHrbxn5cVuKCZuNfk49nd50+LMUJteiNbRTsISQMh3ZFSZDRrizZt21B5odiJ40dfwigYUteIyMpD8KzP3Xczk9/JF0xRgjjIHHG7uSAjo9xi2OaQU1gCB2TY635bDyKqx/yaZdaQ/lcy7V5i8hd3hvsD1EVI3bfaiQqeYEHivwNnP+X7uk2mPxwdDh5RlKcaubXd8hwi7AIwkgNfSRt2nmDmRwPtIn2xrfwrDCjp18Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=290lXY5fUaP5hYR9LuOM0BAgS927aSrgyXaPdavgybk=;
 b=c89YS0zH4FczjoNlPKLmUG7knk6rUhpyAB9TUqrf3f1/DqxMWdSh6GBagW07aHfxBMpW2WnvjCLzyvUh5DZ+soDyDyjDMFzOnqDLnEjs8jIWygvY1Hx196wDqAbjGETbPTcSlsd/Jm5Y+lLFx6oEa3JhRjiB/g6WokwZV/GRv1d1HtwVw12z6z67YZFfixiaBx4i83aAhLojIBev/G7AIbucqCvnq916mK8mN1o99i9CADP4fjU71UqlIadArEgE7LTLwS7oBxTAujC3IAMdKB2OFrvVq9H/AVbtGqKtyEf4+S+I7IuJkTxaC77TkfSurXeHyokvJvCmNEyuh0Dzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=290lXY5fUaP5hYR9LuOM0BAgS927aSrgyXaPdavgybk=;
 b=cvFubdNisDGjDPM6ds9QnZLt0lmn0J5pnLTQcHWIhg87J4ziM6+qXSMIALdoDog6pz009RynRJ0aKQh2aVYdi6U0Dm2j/T6+4z/lsC7VhK7KVD6GQVFYzyLBaobGiGqNvx9bfsINE6UeJkFB0V1mZcULP7pA14nYD/QqPoAqEGk=
Received: from BL0PR0102CA0001.prod.exchangelabs.com (2603:10b6:207:18::14) by
 PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 13:00:44 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::ab) by BL0PR0102CA0001.outlook.office365.com
 (2603:10b6:207:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 13:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:00:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:00:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 2/5] arm64: zynqmp: Remove xlnx,zynqmp-aes node
Date: Thu, 12 Oct 2023 14:58:48 +0200
Message-ID: <eaf575a6ca92f8c10cefb447c08c1292025deb74.1697115523.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1697115523.git.michal.simek@amd.com>
References: <cover.1697115523.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=651; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=8xFijdZg4XWrtB+bBvhBIrJvN+cUbJfTYSw/7283UGg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT1tx2Nda9qz2gVXt7Wnqn46tXmQ8xJXZ/NP+slxz6+e
 dF9cWd3RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIU3GG+Rmb9/enbfksJhSo
 J/uxOiLarSH5IsM8u8y6lO0JkXOW33+pypZ4wFzGo3M7AA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: e579eafe-3bda-4327-940d-08dbcb233e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiphfNIirR2A7hSc6rI0qDb4AOICvutKGBQDbEBOu1kyTMEzDGJcWTndi3PfyK/e56XZP2213W4y9O78IfUrqsIwTFW58vKXPUo4FwBw2SQh3pvFcS/yK5NCVoU3sptP2h6AkKTG7aZJJRhVK3Ba5VSpIHNf2pQ+l18WukR+EExBjyOBacquAeshItapJ9UXZoJzxuVkiavo+9bGNF2FRXJy1p2/nos6CwWs88xY1voFDfIOkNoayjkpCQpdZVwEoN68uplzRpDgQltv3OD3VIyoD28Ie3qgoRHFsG1gB42I0mhUDO4EH675qyD/dQrsKqhfBXFpwoCrLAzbcVecNrMp0qk/SZ3Ivn1y63QHlPywsdhN8GvhFD2v+Q9iD2DwuJdNXOYpOgb/6jIejkCnDgsJqa9y+Ea22TfT2Uol1DJzqW1jsIYq8x9DpJ/oUFQAhxcvTohEvioCn4WD0gyR7rO0NC+ezTWw6BIT9tU126uszH0y+9g7qihsGekyhEqkvl4f9LxoC+0YdRsQPBM4Ktpl+FaIV1BH2Bu2bLFQM5P7draP4TVR3cozYkCeQ6t1tH1dWrEt4eclUobLYXt0/cy2dWxhPUtH+OCocsOB+gg1LDArp2G5XVXUgbylEis9Re99DL8VSOUeUva0d7Nukh3ifwt8rXFG8+FJBVsWn7YJcN2uaXyuS6UimH6M65eTsOJzn86pWjkojtPVtJpLEfkAaVW0HcHJ0GzdrepqbcBDUPbJHjQAx4VJBZXdujyd4dCQ9kHzEiz3ECgHoC1poA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(110136005)(70206006)(54906003)(70586007)(316002)(8936002)(4326008)(8676002)(41300700001)(426003)(336012)(44832011)(81166007)(82740400003)(356005)(5660300002)(4744005)(2906002)(36860700001)(2616005)(63350400001)(63370400001)(16526019)(47076005)(26005)(478600001)(40460700003)(36756003)(6666004)(40480700001)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:00:42.4814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e579eafe-3bda-4327-940d-08dbcb233e3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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

AES can be discovered via firmware interface that's why remove node for it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index f03c201caee9..463ac14f4b59 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -220,10 +220,6 @@
 				compatible = "xlnx,zynqmp-pcap-fpga";
 			};
 
-			xlnx_aes: zynqmp-aes {
-				compatible = "xlnx,zynqmp-aes";
-			};
-
 			zynqmp_reset: reset-controller {
 				compatible = "xlnx,zynqmp-reset";
 				#reset-cells = <1>;
-- 
2.36.1

