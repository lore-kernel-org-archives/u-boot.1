Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADBCEC01B6
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 09:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B48184073;
	Mon, 23 Mar 2026 10:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6ZLqFTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9419F84099; Mon, 23 Mar 2026 10:44:55 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F320583FAF
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 10:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPaadumuw6w9p9IKuqbOBmt/kfdQYq7rf4ZAE3kyM6Xb6T66HNRCuAfPVHpBIudw2onsLMSVxFsflxz/rQf2IsImTIY6Bh8vXdFblceXa10SporyLZuqC4WKRIbSSu0zVFyJVA+MWk71c5zDILkHJYUmJ2G9XUMrvRvUVm8uYMjPUDh1Wggri9WQonymPOwO2LO9zbr21pEadO+B85kY445hytqzvLqxQhfOAO/wt5fJuXDwgPZxxUbhJP7Wbn3j4ODH+zbwv9UHLu8fDrmbUaOFdCYcAmSKfXrEdHSPElT3ZRjpm5fJwR7K+Lg+TXZq0xKmXqYjNhvSw5IsxAVQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdNNHnbOsw0nAnGtng0ZmV+wHttp+nPqAgvBYNS61cw=;
 b=Y4VW0e2SDYXdg+3mXgSFLmRMaFA0738Zns3udhd3veeSXrtaeiaO06g8DX1/A8o2M1lv/XuednTH8yQUh7D1Rp6JFytkjEe0cMXw7Fo1tDltZIE0YsdkLY/3RCIQFD0TW4KwJIcdmzFucx9J0/cJh9FQnxQ2ioz5AdaOeZlr4XzGqAmEhVq1X/yOZtqPdnEb1BF69BT2E1Dk+HNERIf0ZlvxCMuLQL41/GYd6WB6NIA45XyFVZmi88U4O8Rbog5w8ACW/GahmT++Wh/shoZTn9PsdqL57iPDKd08COsK9A0jnmkJ66WEfvE/T2X8eKgevg4vTLcq/TCTfqBy+U1lLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdNNHnbOsw0nAnGtng0ZmV+wHttp+nPqAgvBYNS61cw=;
 b=y6ZLqFTIZn6s/TO74nxkRt1x4UiTpey6TZ7Biu3TrDrBbGkHPtDhiP5iQmRCsq4dorBhJPm9liqkP7vth4NWy++nlUf0bAI3+XWN4WO2Qip4Yt96GExlsmzjfNWB47CGYWZszWBzBKRdfulH7erwOfPs7Yb9hHSpBKuYCI/FQno=
Received: from BL1PR13CA0120.namprd13.prod.outlook.com (2603:10b6:208:2b9::35)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:44:49 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::72) by BL1PR13CA0120.outlook.office365.com
 (2603:10b6:208:2b9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 09:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 09:44:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:44:47 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 04:44:45 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Jerome Forissier <jerome.forissier@arm.com>,
 "Tom Rini" <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2] net: lwip: nfs: fix buffer overflow when using symlinks
Date: Mon, 23 Mar 2026 15:14:14 +0530
Message-ID: <20260323094437.138927-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: a753bf9b-1a06-41a2-9fcd-08de88c0d310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: U6ryEbn9V4b5Sbf18sz4Su3bS9w/Gq71IvlraV9cMr0h5wHRVDxjr2qTRYKh8Ft5t4wPyF8t7zt7XofOoS/8Fb7QyzA9AhOIRtPEzBplSnv9htbRJEYv7Dke3vnm4NLIAh8GiDU9pbeP9WGHHsyUggOpyiiDf6aBLcIMebc9oQQ0PAjhSPMVUDTLJBaV9teFvEp7YLlRUX9AsnKOMmvyIeCKMv7Nr7vCcnWctqW3nAMYtt69ew2vNc/N0gfpiQP7Ke7eK663rHTczidclGrZhCJoyMXsF/1AtisQ5t7arAmn0GNoXxYJN9JXj8ShDwI1Jgo9wBzc/4nXHG6jXAm0yinYJxdxclQC/iJ3PcyuAlmHzByV7f9z/jy6IxDld+bKXdRNmyXQRrY/M/KdOUaOeoKRLarY3r22iDcTUsOdkarSC1fxi2A3mDL4P6Q/ogcaLbkEceiZCRbkEjO6qVJEZMwwMe+xnowi2lrnNnKoGfzTNB3Aj69PlgCazUyTcWnojsFTQPWuzIJ77w+qcVbADScuAX57Z/6U4wl27Vzl6ufNLIF4sNffNxQ+SaXLnhiE++OTJhY3m/LivR41SDL9X6DEATb75JODFcRoXjZh0+DaGrcTxdp1WQop9smpWV2BWORrxSmt3VL7a2V4lD2CJXXwMu4N3TRd6+EFjn/491I8oV/1M42FrCOL2l4md8MVLMpQZWXFWiJjih7ux+lng660hx378VKVjllnLqWUDhB/OURb3HdUTeN9tPlJBBKEB2mPTapJ8m2Lj0/a9p7oHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CSczgaRU63ziwZki5Jd+BZNLdtVOVw0sgHMIsywDsqg/3IOFXoK/cCOdxm21hu0pLymcE0pPoEqrSTvMOF8RuorVLPTVgiJYq6KpOLN8HUxIkhhUFRoHXkBv7VPNea9vSeVAe3DB+EkoTwYMKBXYI8uJZfpieTHncVxpmgcXUCUbW51mOh/Z4A+GybNTmmz52rw4ubrbobA8TgwAA3O6JOuh1L/s4pkPCscvSiJk4y4PNMVpk/wSk2odP8CsZzX+TF7QmZengzl2uMr3MSNC1hIJNrn1/qQth4IXfLYXN3oB3EIQnfGxWHdOdCfLjRHiyme5+Az9eWTjylA2N3+VEeBc1TTVSwzbfZTz2KDxvDgQHbqZuTKpi7fh5cn/GVIvA7Cq9HHcE+v4W7q0LdqsW57Xh+O8v4x1tOpNAZDHQo7e0usTJRXK0eGDOPVI1E/8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:44:48.8998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a753bf9b-1a06-41a2-9fcd-08de88c0d310
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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

When resolving a symlink, nfs_path points into a heap allocated buffer
which is just large enough to hold the original path with no extra
space. If the symlink target name is longer than the original
filename, the write goes beyond the end of the buffer corrupting
heap memory.

Fix this by ensuring nfs_path always points to a buffer large enough
to accommodate the resolved symlink path.

Fixes: 230cf3bc2776 ("net: lwip: nfs: Port the NFS code to work with lwIP")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
Acked-by: Jerome Forissier <jerome.forissier@arm.com>
---
Changes in v2:
- Remove redundant nfs_path assignment.

 net/lwip/nfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
index c3b819a091e..9e6b801e465 100644
--- a/net/lwip/nfs.c
+++ b/net/lwip/nfs.c
@@ -114,8 +114,10 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
 	if (!netif)
 		return -1;
 
-	nfs_filename = nfs_basename(fname);
-	nfs_path     = nfs_dirname(fname);
+	strlcpy(nfs_path_buff, fname, sizeof(nfs_path_buff));
+
+	nfs_filename = nfs_basename(nfs_path_buff);
+	nfs_path     = nfs_dirname(nfs_path_buff);
 
 	printf("Using %s device\n", udev->name);
 
-- 
2.34.1

