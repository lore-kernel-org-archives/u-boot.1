Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41776C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78AB0875EB;
	Wed,  6 Dec 2023 10:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fhiSKLwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3716871D7; Wed,  6 Dec 2023 10:32:24 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D788761C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arYTK+pnFHwPFJ5PhVQ2oG1BivMb8q7wGoFytim/0LnfiWHfBx8XI9EWPPzIyXM+FnjC/3QeJZlk3LgRkehVV1zRzExiSpha+6dd5mY6ZpGLtLPl9P3dQTKp068OLBo2FM5G707eMCNPomDLpRjPX1374zxuMa7dQ5Ad9mfxPOrHpMlWywYq/zno2D06muZ8biJb70JZSWd4tlhTpXRZ9G3QhK0uzUPE+UsTvcJg+cDCWgQodqf/mhCaY31lzZEFC0Qc+OikYL7hjFoOvMWFLyFKsq/FfVnB7hXSZbzfVZwG6eHrXpKqWY/lVn/XqLHmO3RFy/H7gTqG3kf8U1va6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqBJRaeByGb+I+hyhX9O54Cs/hVOi01imTQWmnMj5/U=;
 b=kx6yit0qk/3VC8QkC7wTcEK9w02frAd3KreDM3ZBhzK5yj1rRiDJ7DfdRQ3wHOouEmMpFJMmKX/FzsPFeXrVWCeQ5mtmcopmd/jwt6OLP3q4GkafvAQ7KRO9wqEbxAHHjVO1Pvj1P08G0lc/Wn5kBWzwQNkUMqqrjn3hkNYkGcVddlvNw8WzMLiM0e7dyHqI95povkwrhTZAeNnYbUvp447h2eLzoPAnXf6+1RGSg3gBXS4mFtfdCazHocbZ73PkTf1snwosq0npkqy2HouXWDnPCUpgxxfcO5xVEVLHVFXT6WTOwJk/geKyNbE9TSDXRkWoMX8laahY438e8rh2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqBJRaeByGb+I+hyhX9O54Cs/hVOi01imTQWmnMj5/U=;
 b=fhiSKLwxhtbHZnr17cFQ638Bbm4DVETPJnd/CQ76yXxrGvJvdEVRLrl6CNcoGi+PUxaGDsJr1PVv6+LeeWCQMs/EnSRS4BeekGj88EnEMjI7TVXmeQp9C3cVmHrlm4CMBnVYdPGLFy1/imM7Gk1+iacmBG3B+1/wEkVYysl/9bg=
Received: from CY5PR19CA0130.namprd19.prod.outlook.com (2603:10b6:930:64::17)
 by PH0PR12MB7471.namprd12.prod.outlook.com (2603:10b6:510:1e9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:32:17 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::e2) by CY5PR19CA0130.outlook.office365.com
 (2603:10b6:930:64::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 01:32:14 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:12 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@xilinx.com>
Subject: [PATCH v2 07/30] spi: mtd: Use split reads if multi-die flag is set
Date: Wed, 6 Dec 2023 15:01:18 +0530
Message-ID: <def598add87aeaa7d3f460e44c0386b19c4f8dcd.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH0PR12MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 833c2757-8bb5-4ecb-cc1b-08dbf63e3d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTVCNQaI66GBdmpru0MTKst/NpKIxEE6Acst7dIL+gofm+Sp8q7C7uDv7fsdzmWe0Z/1Q38+erBNtHwoFenzOD5tvrsFsQKhMW8WA87a+Vf3oOz1vhCt71lf56SxgkrdczOC2XtVwpWV5nwL5Y6XKK7Gggbaa2sDxGYRCK6oPMCeIvHtkFdufWimbDbIBQbDKYC349lfJ9CoP5uxFru2vDeW+Ta0VaBufQTtJUTxQC2/8RZtkyXguhVcw99W+cGUaTL0qjuwRd4xeftFMyScoKMBf1YabPaMvmYUmpEUTgs+AtbjZ5Dx+pI27xEbEkFHJObfCh/0KfjJSq+HEXaBR2KgdibyzMVeJM9fZe+c32bUm4Q6EoRZnYwIeKQLuThaEVTB1Mj5alv1F3fa+d7AdNc3LCJYzODglJtSHa692ZcBrXFCkrgdV740U8GGjDGyFbhlpyq/g+YsZmyLQrJxgWop4XN1Lxx1G0XV5VZdHChWGN6xLIbihTyRwY5igPKSHLrbcrVr+rCZHkhFVtQoSAy3fxCr6E2F5SwtBIHTBU5HfEvP8uUo2+DWWzReaJzweq1n12N26HH/kATJ1pvpNFDNvm+j8yWkFalfBpXXBBCXBzmixNE6e7TLlS6REqVWX1ngoVARxLHAORNu5ndxFARUpGJdZyf5hCvhNHzK7rvl0FfLIhO800qnd2fXHf3XB0TvdFUn+oNmAkG4CBrqk5bB8Uyxs/AfdsWPWT3PKbDAZCo0aQsZ0eOjEl39fj/jTIwE4bBEkowZk4CgK9L28Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(2906002)(26005)(336012)(426003)(356005)(86362001)(47076005)(82740400003)(81166007)(36860700001)(40460700003)(5660300002)(36756003)(2616005)(8936002)(8676002)(4326008)(41300700001)(6916009)(70206006)(316002)(70586007)(54906003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:17.4945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 833c2757-8bb5-4ecb-cc1b-08dbf63e3d11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7471
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

Some flash devices have multiple dies in it & has die cross over
issue. When SPI_NOR_MULTI_DIE flag is set in flash id table use
it to enable split reads to avoid above issue. Define SPI_NOR_MULTI_DIE
new flag to flash id flags. Remove SPI_FLASH_SPLIT_READ config and
related code from the zynq and zynqmp qspi drivers as it is redundant.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/sf_internal.h  | 1 +
 drivers/mtd/spi/spi-nor-core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 9c09f97ce2..2cbdea60b0 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -70,6 +70,7 @@ struct flash_info {
 #define SPI_NOR_OCTAL_READ	BIT(16)	/* Flash supports Octal Read */
 #define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
 #define SPI_NOR_OCTAL_DTR_PP	BIT(18) /* Flash supports Octal DTR page program */
+#define SPI_NOR_MULTI_DIE	BIT(19) /* Flash has multi dies & need split reads*/
 };
 
 extern const struct flash_info spi_nor_ids[];
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 63f78baaf4..ace5da9591 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4485,6 +4485,9 @@ int spi_nor_scan(struct spi_nor *nor)
 	if (info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
 
+	if (info->flags & SPI_NOR_MULTI_DIE)
+		nor->spi->multi_die = true;
+
 	nor->page_size = params.page_size;
 	mtd->writebufsize = nor->page_size;
 
-- 
2.27.0

