Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F46010A1E60
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 10:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23C083A1B;
	Thu, 26 Mar 2026 11:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cGvdFrfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D56783CD3; Thu, 26 Mar 2026 11:42:23 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F8181E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 11:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOgAbNtos40x5J/gZkwpNgqhVF2Ku2GfDgPgpvVZGQOcjbREUFevxNRi1dd4ax3i2vBYyWBTa+FdB4jSdVJavmFCMRz1hrQ2VSXEWjyQzy+hMVU5giwqdoZSPH5Xer1y/XUGS5DQlmiUlxd58rKK1zn9QEH/YNHPkRMwCq2Co/o/xeEtWBQ1sjIp+wHRkffU3AvD3jB0AH/9oEvKXtE4PolCgttYvpatiIcakaYrxhS/xvVPl3ICQYgTpCdY4fHaiZS9h4WCaCeN8yVfAoItXeEBCsbGq6Qzkf+z+MOkgS8IO4lumfpPs5CjQPEoY2JP2GrU18wDjUqX+B9kMaIn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ2uOW50RZ/Tm7LFQfROcyqx1yxWtIiqsMqoRqVSg9w=;
 b=PXpyPhjE635vQ7VCunmL7JO5arL5v0kWRzqE02QP/TG/bFvy/VET/E7CHbP160gnyh9rCEwJjt+4YEQqVGl/OZodOWNK5rJm2KJ3mEjDz0vdzu/9x9Dgvlw0RdsxhJb3plNlFfRt54VHJqcHUnsYjRlsak4pTricG4rZuJdVSqmKjL5ZMZMIg7hw622dlGK3Ge4B2+DY0ddyEiptRFKVKFjBEJFfx3Suzjef3QUKAzLRBd1gahaoWkKmNN+LLQfSycS8AIhMjHNDuIrioNz3zQbQqxc2tszBD8oKEV1uMbzFdFCu7EnyvraqCjomOSIJZJxLKIn71RHaLRB7cCuWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ2uOW50RZ/Tm7LFQfROcyqx1yxWtIiqsMqoRqVSg9w=;
 b=cGvdFrfn4rLPhBUWUWnvThvuhA5YtWI6VlZeQ1JJqdklsJWlLSoH5kk78ps9vnYpdeMozja+QfkN6qNgJRj2ltJE4m/Cx6Mn6tqT9NJYpsL9d7ArWfsyXnRCVu3HyUeGXgtfHEP5fdz+/sq/nCDjSSrg0Q0EducW5ydjWswkxmE=
Received: from SJ0PR05CA0126.namprd05.prod.outlook.com (2603:10b6:a03:33d::11)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 10:42:14 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::12) by SJ0PR05CA0126.outlook.office365.com
 (2603:10b6:a03:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 10:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 10:42:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 05:42:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 05:42:06 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 05:42:05 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH] net: lwip: tftp: update image_load_addr after successful
 transfer
Date: Thu, 26 Mar 2026 16:11:58 +0530
Message-ID: <20260326104158.4182723-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 51820dd1-b782-43a4-217e-08de8b245782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: r4JW0Rlw3HZ1gRkE8Jqi9vKf34/Lsf7tZ5VAExXt173mz3rbi6qkzfrTZnznbmes51fbzlnNMEoWXhZXabv/NY7bla7N9Z/xBQ7QM98Sasc9Rd8+plM4qPKrL/gvzfhetNeM2cRRo2Ba6no7YZdHCzdPIOvpiW1y+1Z66rV5g6rgn6SGOw4X440DZLgyF9tEDMIw9w65NPT6A5CODgESwXDjY0v8sbKhITSoVEBKLdYKZCRvZO6ZYpi7AqMqP9Qp+xpvqu3qwZPRHo/3gNc+MRSzIAPy7Lje5sRJV6/m+qOOXo0NQQ4a9uy7AXrFebNH/ySOc1oIuUJIvpTR+QKUCD9xZzXyHoRw3nAewizCP249AZxOvWFFYFs5PcgY4nVrVVN2banltCqcCI9u4XlodzLLGhUP31lRkI2jKBw7z5/G9siFquK6xoeQlnT3PqZrRK47ZUhgoPVpW7Ci602J67GrilJ3tdLBFJsHOgFyHw0MKKvnTEKMCXRo60OV5I96EzmWK0F4xVLN29MgcAtR4NnvFMWCjHQgYCSZHynP94uOx7N/7PGvbrhSHWmvS3Jbs15PAf9MRqNNdPtZVr4hvBoz5IPaGvrGv6CGpcBRDi21b91J9obv/MYSn1IFXgUZmkxu7/C8WBY+7WlTSkG0H5tr0SywZmGX65eGkJ9+ImorO2/9PjQXDz6XzLrbPGs2VLxub74FoU/dY+e/XaunjLAZqVNNYsPupET57/X56Hqo6R5ALssX6zBsOKgviy0ztdVJnhXH4SRB2Ib+rbsReA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ONVOdWdzudrDIPvJWcH0gKNdd7cQvkqOjSBoC3ET8LV7QcUVtv0qk+jekBbI6pT8Fx8a7XfUSUqpm/A+LHRgEOtTEzcYEYuNos07WpCblPAFQ/lCgLk1D4yGZ0fSVbBQTn1r8B2DNTR7AOFlh5JPZpayqxZcvR9FqY92f7RsZx8b3p/kJBQvAHABE1FU1dK0/623kMcoojK2gGrICIIDd37bDxs/XgcOESAI3Zjc20Q9j9ScbNlB6YAEyrTHKRUZIjXtPrpJDuEwbOXkQzChMVAzrwuEUZc+NeW5MgtD4X5aWnFKxwM2JocdVeVMzzQtWWelSIUtpVtUVO+UEQiWYSZDLiNFIiZlOWUxx4piWEaYCjdS2H7d3W9gwt5kb0cEv2k77o2DzvZrtmwmxvKx4SarsR8XSXHp12ZhsmkJxrIopGMge/+lJrpFnmhJW9tE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 10:42:13.5432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51820dd1-b782-43a4-217e-08de8b245782
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
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

do_tftpb() parses the load address into a local variable laddr but
never updates the global image_load_addr. Commands that rely on
image_load_addr as their default address (e.g. 'bmp info')
therefore operate on the wrong address when called without
an explicit argument after tftpboot.

Update image_load_addr to laddr only on a successful transfer, so
that it accurately reflects where data was actually loaded.

Fixes: 4d4d7838127e ("net: lwip: add TFTP support and tftpboot command")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 net/lwip/tftp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 5c3becc68c6..7f3b28b8507 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -368,6 +368,8 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
 		ret = CMD_RET_FAILURE;
+	else
+		image_load_addr = laddr;
 out:
 	if (arg != net_boot_file_name)
 		free(arg);
-- 
2.34.1

