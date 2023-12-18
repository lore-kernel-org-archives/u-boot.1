Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5342EC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F1F687232;
	Mon, 18 Dec 2023 14:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x0Tai2Wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16BE487C9E; Mon, 18 Dec 2023 14:41:50 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1F3871CE
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chXYRf6l1jhZb5G01NPO+C/TrlBHmWdTm5eDIKQ19IzMWdTEg/Gse9WeMoGJK0vxHwwIMq71QncCczxW4DkrUfeGM1o24GoXWReqDEEMo2Cm2OjkHDpV/nQimGX2Ltan2kkVHqUKxiri6R5Oq4Kb1reMhUkInW78LWaZSUg7CS1WBsbTkpe7Xr05nW/tR6PX9P0Y2trnrQFuyzPIshRji7YjNzXy5CZLismgTsw/V2amZq3Tu+QAxXWlXo05XDvRNOYqxy3L843QQW22o0tjJPARl7YBvYP0cab6nxHFn5BK0bxXYhYIAdmBFDlklqu4DRTCDWCuOysJopQiwJxWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBk6Z6dRrFYLb57reAP5rrAdJMttqTBtizEmOX8pUpg=;
 b=e8GPcljSBUB6hUF+4etCA5kNPRhLVHXMmERY7ehwZpC7GavxLEg0wywLz08nYFjBWwPquHr8Vh9P1Lk5ZWdCKKQI7Q8Q4YBy9dbACeSbyCMEpm2XyqHTX9910f0hqcM0JzAoVhozzpy39CMB2yfDpFGn/X3tV+EqL6df2scdj98Pfa7Q+ydZ2xAOYmVOKCMjfApNYE2JgP1ylKDGSqPYOehm1MJJIoSNLAJC6ps7OrG5uLlZ5ZIryPRYFGjfEweB60Kwu9++Ly5vjUII2UChdRCW7VU3Mhlrf75oifkQ/hh5Te44zFSNJTZHGXE9tFIe07bp3eTdjzehhW9L0hhGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBk6Z6dRrFYLb57reAP5rrAdJMttqTBtizEmOX8pUpg=;
 b=x0Tai2WfusbgHxcVQxEOTc7k8zdFK7K7uZfs2IuTpcVDmwAvxWzMXk5LjkHKBh06N9CE6MoB+QJjTiUrgxRwappxe5H9No58YVS52i9mxom3t7PkaB3/ZQ/ioV+WRWdhQG2oDcSlnjIB56biaO+3NYtug1uPRS06McVWang73Dc=
Received: from BY5PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:1e0::26)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 13:41:44 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4d) by BY5PR03CA0016.outlook.office365.com
 (2603:10b6:a03:1e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Mon, 18 Dec 2023 13:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 13:41:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 07:41:41 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Generate dfu_alt_info based on multiboot
 register
Date: Mon, 18 Dec 2023 14:41:39 +0100
Message-ID: <5abc5f3047ce586b4d2740b5eea775d063295e28.1702906896.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/TiSikl1Pp9TMD6Y5arVg/FUhZsr51XTIsNufao0fyQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQGH0G2BzydeiEbsypP8ut3lv5cw/33rcjFub5HP6cpL
 Q97EfS7I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExkfTTDfK/DJ+0PRRlzzuUx
 8o7iUzxoxlwiwDCHY/G601k/fi16oLJs//Sa80lnridaAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 4582e1d9-b7f8-4c67-3d5f-08dbffcf1292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1Sr/6Nq+qRSQccJzxmhCHAYzxfUMTh2h+l8fm1vnxfC3JXvc0znNihRaJNYVDuVu2K6HN9Ldiv0DUGvZGIcIzUCOy0AJJTnsUqx/qJBiTulRaBoKsnWM5WbwIdY1v0G6kdCMQy56OI6TAKHXLfhlSyEOMZXscWlzPeZoepklPPySM3LSukoacFIH0FHRXFBSQYd/9TLtWjc2rn5Xm/fKdcE+foApATUTiEIUarKIy3w2IPWvM8EVAHwwn2UpmSkXARVlZeAp4qB9uhFZ3DP+zOlcnuOvowKzVLnvyzLq2QPDKLPZpgmvKTVqTldhCt6jyaVtQiX5OJAvyPDCj09lPU5u83JkI9K9OhTAeb7rwtXD+U+m4V6KwRgEkr8c7I6iaQ9P5vFrSfoJXKUcgNaS6bSv9KqcS+W+WbbpPlcPYGf3hxXdf47bzWQnD50k2e127hST+hdXRn09zJdd9COtBPXxZbVqUgGwRgW/xwSEQLK2U3k59YT4DoPlX0vsA/WHD7biDAyjO5Ebwn21otvJxqGsfgMbz+AUOdsDF2AO+vncDFQlskrWTvcCPDEpwfCXN8IL9YFTV5j5/t1pFXnxjbDtJUrDQxf7h8w73zLMgv17remz+x+B0ploUGcBn3DAkK+uajT08fWePgI8m+JVc5nhbxl8fw1swX+AzHl78yynXDGxBOuZZuGxPxwNpDwwx8BrKyec2OsSJ4Ejrh/MJhAayvbc31bcmZ5nqf7LcUC4sZEmSa8Q24SAjzR3zqw0V23NT6KDHepB9iNHT1Ldw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(336012)(2616005)(26005)(16526019)(426003)(36860700001)(83380400001)(47076005)(81166007)(5660300002)(44832011)(2906002)(4744005)(41300700001)(478600001)(316002)(8676002)(8936002)(70206006)(70586007)(110136005)(356005)(82740400003)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 13:41:43.6069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4582e1d9-b7f8-4c67-3d5f-08dbffcf1292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
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

Commit 2c8a09219cdb ("arm64: zynqmp: Add multiboot support for SPL/SPI
offset calculation") enabled u-boot.itb offset calculation based on
multiboot register. It is also good to reflect location of u-boot.itb image
for dfu_alt generation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 59feaaf6f32f..e3700f076bc1 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -670,7 +670,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
 			       ";%s raw 0x%x 0x500000",
 			       CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
-			       CONFIG_SYS_SPI_U_BOOT_OFFS);
+			       multiboot * SZ_32K + CONFIG_SYS_SPI_U_BOOT_OFFS);
 #endif
 		break;
 	default:
-- 
2.36.1

