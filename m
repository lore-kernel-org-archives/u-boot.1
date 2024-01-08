Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2457C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71DA87A39;
	Mon,  8 Jan 2024 11:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kPl7njDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54BF987A30; Mon,  8 Jan 2024 11:11:04 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CEDF87A24
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjFdktgc3DtMJ+ljfvWN9CwciEFzIoAJtj7oWi6Gu/FMQDymgSAzRehJyAtNNMP60oUv1OKrcHK3U7lPqPHlz3672adMQtzfN+XLvnSgXLPzHw7+UMyEmRQIl7dFcj/F3UhAP1Wlyx3XM3LDiXcSowoNWgu2bKPOrNm2yOb3qVKTPLcFSaUVEt7XNL4C8tpxpDnPvv2byGhpmKSJhcwZ6qwfa+V5VZr9VSibyO/IRb0sR9Xz0el5mBtYiQYQ87f3qwJs8sZSluu9Xs0ehx/3vtNlXBX6tV4jo/V56npXtkGwXi6aiMCbfqtCYUMOXIbhqpbgVAmuZnsHd5NKZ69Oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk9mq672Ewgw81XTDWygY8Co7hrdwthZ+jx9beoUbdM=;
 b=lFjOX5aU8TfSZrUpn6vkI7f5hzz40Sw6GoPQZwHVdFH3xaCo7w5ET4ng90HTVf/eucIYXb5+ps3hBl03Cot9ryma1P44H8z5Z3d6aaN/ztFgGlbJRJ5B9gxuv9EgRryDHOE7TipNpszyckwULdZIQWFSejiBRKL1o2srAWaIM3cNlVv/zW7m9tx1aqcPhzz1JYebKJs95dl4JEOQV8nLXSvHltUJTmCHicefjIxkYN8NihpYmnMQX6yvXlg7RwtNcJBGKZZ4B1hLsi41CHTi9jnrFxR7QvXLIn0XEErxCgupS+lFagDKGURq7l4K0B0rPLwmxS1BExQvEAABtsQj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk9mq672Ewgw81XTDWygY8Co7hrdwthZ+jx9beoUbdM=;
 b=kPl7njDwQFhQBQBoY6yIf/ezKOxiAodmbddTtn25nT0ZyC8jTxQ3hgbzEUh1PKGKi9RhWzWLi5mQPG8qaGALdNErhbA4FHhyC03N/NjTF/j1eg7ufrTwlQ34n3RWUtfhoDjudBwD1k82es++wQdqs6TZCYEBpisAJRr4sg6NCUY=
Received: from MN2PR19CA0049.namprd19.prod.outlook.com (2603:10b6:208:19b::26)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 10:10:54 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::ff) by MN2PR19CA0049.outlook.office365.com
 (2603:10b6:208:19b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 10:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 10:10:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 04:10:51 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>
Subject: [PATCH] arm64: xilinx: Remove multiple blank lines from DTSes
Date: Mon, 8 Jan 2024 11:10:47 +0100
Message-ID: <6aaa9fa91c88ca3d3e5645d66a795ec09b8cec61.1704708642.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JMzdyrfB+QNBZUJPkfYJsa91TTSexBznv7E40EYgT2Y=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTZp1RZ9P38G2fcT007k/syVF5lq+Lyt9dWvrohL/iT0
 Vezw5ylI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExEegXDgo6lInWtU1gf7k8L
 t+CeL7FDIodZnmHBhF+O1lMyoxUyBPm/FHW6LKyfsvweAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: b163c1f7-bb15-4fd6-f1bc-08dc10321960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8UiDsda2JYGmUsAfPgF4AnDIdDJn0d+Fh0zy/INo+v/gRaujgo/Wg3fT9F1h6nBcrLQqy1Azj/s/WTNlFi+aqlh0Of9qdr+MNP0hl6wAtCIvbN9JoF41nOL1b6rrEipnUL8dqAI/zPiLnyYKVUaYUbFZrtXAK7IlGTly31+bVB8f+1JtlUAEMX5lRfJxeyOR/mS4FGsbB/4igENY15BdcHyjzj0GL7JatPImYjrgcZ4KQT5B3BNqbbBtzcdv5sAoJ4dlesmqy7Pwpp7mERTWl0S4HCaTBftjbtwDLE1YRFxx45B7MNoUVNdMjZ2npRPPTrOkXy3XKL+Y+PvUZVCMXA1pDTgnrcDMBKoQlk5lsN9lUojX/r9pNjm81bsFHyVvFXNjhCLHXvTx7seKb1puPljxvxfKdQGxa28jwuMdLKfANbdAGvduCMcAfWcpqgCPfPzqMS0S+tc1D7f8DXChADJSNCqoLrX8DQs/MCXa8zt1dT7Rm6SQxkMs4E5PdgE1ZBSxi/YA8cfU3UDdcJyWe40z7DG8MA9aAOs5j1R0JHmdi7IloUV1fGfQZmE1f1hcOa0axp0D0CqZwhnVqhuxn41690//TrqiZ8UnjLmNRpt+Sp2qulEd6Cjw/cYMLqsxATyRhDiyWKZkXYXV1plxL+GdlbVoxt+9zVngbBqvUPF0atXpnJWwJ+ARtR/hUb8qc/hf0JDYYoBiwtv/Jm7hNRKR4y7yCL/J4lT1plXld+eHS+7iOpaXBrMkLvDcmsVF8KxXNIuoz09pXfUMVcgCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(81166007)(41300700001)(2906002)(5660300002)(82740400003)(110136005)(40460700003)(44832011)(36756003)(36860700001)(86362001)(356005)(40480700001)(6666004)(316002)(8676002)(8936002)(4326008)(70206006)(47076005)(70586007)(83380400001)(26005)(478600001)(16526019)(426003)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:10:53.9492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b163c1f7-bb15-4fd6-f1bc-08dc10321960
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

There is no reason to have multiple blank lines in DTS files that's why
remove them.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-dlc21-revA.dts      | 1 -
 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso | 1 -
 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso | 1 -
 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index f737004d7943..b28dab0003ac 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -155,7 +155,6 @@
 	/* u138 - TUSB320IRWBR - for USB-C */
 };
 
-
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
index 750bc39139cc..853d9817dd2a 100644
--- a/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
@@ -13,7 +13,6 @@
 /dts-v1/;
 /plugin/;
 
-
 &{/} {
 	compatible = "xlnx,zynqmp-sc-vpk120-revB", "xlnx,zynqmp-vpk120-revB",
 		     "xlnx,zynqmp-vpk120", "xlnx,zynqmp";
diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
index 551341f31bd1..18625933ad3d 100644
--- a/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
@@ -13,7 +13,6 @@
 /dts-v1/;
 /plugin/;
 
-
 &{/} {
 	compatible = "xlnx,zynqmp-sc-vpk180-revA", "xlnx,zynqmp-vpk180-revA",
 		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
index e70eb4dc9478..3990d053c351 100644
--- a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
@@ -13,7 +13,6 @@
 /dts-v1/;
 /plugin/;
 
-
 &{/} {
 	compatible = "xlnx,zynqmp-sc-vpk180-revB", "xlnx,zynqmp-vpk180-revB",
 		     "xlnx,zynqmp-vpk180", "xlnx,zynqmp";
-- 
2.36.1

