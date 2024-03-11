Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EF5C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA4987F6A;
	Mon, 11 Mar 2024 18:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OOFLVUO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BB3A87F5A; Mon, 11 Mar 2024 18:23:30 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEB987E6F
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksZbOLMG9/pGzYZzwkCCq8kUhioFt+x5NF+3An2WOhCJEMJL8Ud7roswyee2BctrudQ7MjsowcfJScw41DHYeaWVvMTrp7XnMn3SATU2If7p9ToB2YjLbAurFUiy2tC/lhuDo1sJlwf1gOrC5qcHlS+Yo6GNqz0m0r7WfwWUMuuDi1exPnhSCOMYDbaewICPZbnRKe+3sFvNePTRNgsI8R9S2NMcMRwpPa9FHYpxmp68hETI1wpCiI1QSiYQA/VvxDgQJyALrzJjbPgbS05m7AWJV6SK6G4kr6hD3gQ/qwl7R5DEzmg/lt5LZSGdVwlNnPpZq76hBtRXTRd4p7F6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhE0iW4M/56cnJF5CMBwX4yx3IOPZ2zX/SgKgKkYuN0=;
 b=bugHyZYsph3ObhjEDf2bmr4l1wJdgs+FUU7bm925s/O9g7O9OuCSQVBaLQVkdEl4QjQmrlYOH9q1kN63A/qX4/wbSQJqd9ZEs5n3kt8nT/fcJ5csOJKB7Mv8XJZo0tJYrQJ7s0bPvZFtWXy+DT2qOX90y3qk6heLC2emHsJovUHuRdFjI0nkXWbfZU6yyuFJEhgGp+v6q4fTUnoTvUjFjaIAvm15ALVuQkm0F7tyUIDWfdRl03eElQMRZvK+HWfuOcMRi2zLv+i6BzQhpic4GPNzwowsaTLxWxafn0BTzdDL91GwRllmbiTgaiW+N6QzKtGpF3dc+iU/lBDeNh4TOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhE0iW4M/56cnJF5CMBwX4yx3IOPZ2zX/SgKgKkYuN0=;
 b=OOFLVUO07UsRlN7KVsW15P+k11YuoGWRq+zKplUBO4IgeGIW8LWgY+y4WejxB+HP50cvbeuqfxA4soBmJC13ysfTEbZe1gsyHtX5UwsV1wuTuzQVNIYzC3TpsSGpGL2+Yofsho6Uii3Z1ai9VWLC/FA29JgXmH4hXeizLWbPhec=
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:24 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::66) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:23 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:21 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 10/19] mtd: spi-nor: Check SNOR_F_IO_MODE_EN_VOLATILE only if
 SFDP is enabled
Date: Mon, 11 Mar 2024 22:52:40 +0530
Message-ID: <a7b3f0b6792ef024c1614a81dabe9dcb27e4880c.1710098033.git.tejas.arvind.bhumkar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 470f5562-2aef-4150-191a-08dc41eff4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrYDnEUQQ2axuVzrRiuSwAL6Zks+0Vj00rCmoE6LZxsm8smM0AllScK3HCUYj6fLu/yQMe/yJbPWn+04XA/VuiAxrtim2cqwBAjUB5KexYcoKCHpTAQpCSw+56J48aGJ5M949XGUsvDnUg3e8HmqEnnDbFYHvyji3HazSIyrsOeVL15P3rRZjwe9/+V0noIjLWseIeT/iItDkhaPSEhM0VonJCKhb9XwVx8ve8ktkO3gIDPhiZEGZZqxZKQ19nzr0s8HIXRzywDjiNTgsKHmpc1LELV3ndklu3kMsTfGMqifiPR2KXhHLL9o/fGi+wB5/IqmlZVdzUaSQ8IIvsbMoyyMp7uZovw4TTwPTSVRYscOki2U/CSrdyzd08sDrNEwXFgwiF7OXoKxjpWvA/o8b00iEHN4UJkm4tPLzlNsDSiv4j2VzeTEPVMnT0Ekfsi3rQNM3nF2Nbkx4rliAEkHnZSS/WeTzq+jhuuJG0YmPteY5QxYZXySoD3QzO29h22yCfX+OjN7VvOsT8VASwJ6H7zEGFlbviWknCtqGQDmbF/X0PtwUOadJCNc8yze558ZBP4gNW1SlhpdlTOSNi9PXIT12queDg4PCb7Xu/aQXlZIn7xSc/JMzHEXQoOHF+/4V8SAbd0BwnOHJ+HJuPc5Tq9eZAJp0EGsmVcF5rWiUsihTZN0omTt2l+4RDDZp5GIfAY8qqO0qXrxS/DsvrJxTk5GhXvwtDlgWlTItX3neVVZpIP1TDtg3+nXtvDt6jA1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:23.8271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470f5562-2aef-4150-191a-08dc41eff4c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

With 'commit bebdc237507c ("mtd: spi-nor: Parse SFDP SCCR Map")', support
for spi_nor_parse_sccr is added under SFDP. But the flag
SNOR_F_IO_MODE_EN_VOLATILE in spi_nor_octal_dtr_enable is always
checked. Check this flag only if SPI_FLASH_SFDP_SUPPORT enabled.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index e8640cbf07..b9326d2b47 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4135,8 +4135,9 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor)
 	      nor->write_proto == SNOR_PROTO_8_8_8_DTR))
 		return 0;
 
-	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
-		return 0;
+	if (CONFIG_IS_ENABLED(SPI_FLASH_SFDP_SUPPORT))
+		if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
+			return 0;
 
 	ret = nor->octal_dtr_enable(nor);
 	if (ret)
-- 
2.27.0

