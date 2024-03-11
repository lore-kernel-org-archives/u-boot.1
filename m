Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD76DC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA08D87F6E;
	Mon, 11 Mar 2024 18:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ftncjb4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A3F87F6E; Mon, 11 Mar 2024 18:23:35 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D02287E6F
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab0S+2y2dre9wpw8mhM9xZDR9n0cviTzVXaHmbAg46rG98qUwWoQeFQrJ90Saka/dnQQzQJ8aTUGpKyn5ncX+eU2ZFt8JVhSCUwB30qDU5jfen28lSDl2vFJxibXSnaw0BBzPyGrfQMNP69bn50oszLtd7+Trq71lCkee6RKN5Qt7y5ROS7U+LWIWYcyUgMT0B60X+P2Qw/UrPaAB0tP3f2VBj149hQB1g9gkz7HBaKiE9oI3ooic7RMT68C2uljeZa+uVSzKrzWPXoiGf1bwzbQsEv7CUOa+IsOfBEj7fgJEa3FCKDn4Xo0N1bBJ+spZHqVDy32y9PgXYkLxHlDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydEeABmu0yUNdbZWaOVFjtIKcL5BLlfwI7627LhA8KM=;
 b=ZJn2kxmZcf2BYs5T+09sfGcYQX9oPUrMO588dcIiDoagDD5RqwV+eM6aRSKp36I7M/UYafNPSx2pM+t1mnCTGlPxF59J4Fpeyx2AlDo3NCCHCT+sOR6tNINfiFaBw5Lljs50kPnqedk+4FUeHFQvj5FezfwU0o6vXGYjZZ0jjDxjD3x/NtS/kW5Cbf82btEE9F5TX7TBLlQduXGe56nUE0c8oWpixqrGdWVTbvxXlSPkihB5p+DwkdAjKKhFN2LwhYLj3jV9iaEUCb/si0qjt4oei38JajFmjH7Nelmfw5DZFIEc230sNeQ5PRSgZRNtoDnP/kTcqZhXdBlVPgo0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydEeABmu0yUNdbZWaOVFjtIKcL5BLlfwI7627LhA8KM=;
 b=ftncjb4Ggq7AY21tBFoymW0j0saYOTV5OGOVCi/Eo10fTmm0XP1zTVqblnxX/bPVbhjmCqmVzc5G0B29TEDQ9S3ma9EF9Bkc0+xVy5W73mhd8vTq3cYWsgMeRiqgyEbx7RXAdmfaGS6a/cJo7Npj7nWCN5xX9KPc+j2AFU7+wIs=
Received: from CH2PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:52::20)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 17:23:27 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::2a) by CH2PR04CA0010.outlook.office365.com
 (2603:10b6:610:52::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:26 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:24 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>
Subject: [PATCH 11/19] spi: cadence_qspi: Add spi mem dtr support ops
Date: Mon, 11 Mar 2024 22:52:41 +0530
Message-ID: <ca5f82393540524764bf9eeab93177916aad7153.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1e1324-c27c-48a0-ea62-08dc41eff681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/lJmZDO25oPAh0rHX8FKgho8pmDtFmQpjm0cUAGDOYR1u/8S/Zj5Fcwmv8tvILWLYbYEtGnKqIWWT4MfCrHaBU9P1BFE8d6vlAVhrAynbU2S+wNUPTrxGOtjfajLY9OC/2jKoKFJVx8sLxITygWUAbROpKoos7mdOBA9+kxt/5lLzG4qjL9EAimEe6YyDTUc/UOZu4yXvtj/Ba5zeo72qbQCawhmG7VwEDnMdqCk6r66c8depkU0KNF/IFsjiN2iiD2K6wWjBRkh+amlXMC5uQQUHFm0mUTP512kXjXf2HIK+002F64j/fOUq1Jsa0cHpaXZtvTHxy5upvRojDka9ZqrtZs89iyyY3BT/ZN73ngIvVHF6wPni/Mwh4qHQb8DDgdm8PDiyywfBzwufmd0ThYRFKD95FXGp911ub4omurZ/5G+0YpPbmezogNm+Mfv6HnRrGpFbciD/jW7PkxXI4khLCC5v/29j71ypSi1v1ckiKW8ixlkKo0cQ957RMj3PqriBCluABARApd+Zgb8yc7AOsji/owPIEx/4CNQtjQP4qPy7w9d28NarrPNJVUDDGonkZBv2jwx4TIrph4obiw3/uxFZgMwl8RbFz9RzT4zB5zaiLspwSKgW2Vk/qDACJPcj6s79rgDjh7904p4sWAH+YeHHkUTZrPakgWD3hXx5s3jUSpeaHKgPk7DNYM+y8bEfzO+mnYO5x5zr0/YaO3M5bO6wq4mZEDKZe3ciBfMZo+JoJbSK7EfnFkO7EN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:26.7841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1e1324-c27c-48a0-ea62-08dc41eff681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

In DDR mode, current default spi_mem_dtr_supports_op() function does
not allow mixed DTR operation functionality. So implement cadence
specific cadence_spi_mem_dtr_supports_op() function to verifying only
the command buswidth and command opcode bytes which satisfies the DTR
protocol.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index d312bafd90..f1c8efe59c 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -708,6 +708,21 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	return err;
 }
 
+static bool cadence_spi_mem_dtr_supports_op(struct spi_slave *slave,
+					    const struct spi_mem_op *op)
+{
+	/*
+	 * In DTR mode, except op->cmd all other parameters like address,
+	 * dummy and data could be 0.
+	 * So lets only check if the cmd buswidth and number of opcode bytes
+	 * are true for DTR to support.
+	 */
+	if (op->cmd.buswidth == 8 && op->cmd.nbytes % 2)
+		return false;
+
+	return true;
+}
+
 static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 					const struct spi_mem_op *op)
 {
@@ -730,7 +745,7 @@ static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 		return false;
 
 	if (all_true)
-		return spi_mem_dtr_supports_op(slave, op);
+		return cadence_spi_mem_dtr_supports_op(slave, op);
 	else
 		return spi_mem_default_supports_op(slave, op);
 }
-- 
2.27.0

