Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E085DC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5FE87CB7;
	Thu, 28 Mar 2024 16:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IlPeUoyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC3188194; Thu, 28 Mar 2024 16:37:49 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAD0683CF3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjnqdolFBN1Ac21bvrCzIHBeCzmgk/f2jHqAf+upONCi+MjQ6PXQ8YTjOxTbwtXcD5dmjqHg7nsCE/nueXO0MakMeOtMbNyOGMM2itmTdu0aO2+Muacqt7zC7+1tH7fAaeoIyOGwvV9gY2QaeG7UOpbHqkoo6FzqLqdfU/ASEHmQMRrNLVas3K+BB/kmjkVzxWgx73AME7DGf295EKti5A+4EKzrgu/9fCVmqIFialUz8IIWTekFQVc6YjEYrZA70iXizkuhGQ2LcYFcjLeFEerruVWbgvYCBS87BgrXU4pclCSfFOEe1OxRTJsjHSSjHhImuRtbUhivejspVt9pBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0YEGkHItyXtRqeSEA94uGji6Hb487yCsVIslAqqOto=;
 b=jj91w77d18/xzXHkzHOga0RUgZq0TBUYHPiUZezEXV3KMQfNBLo/AMCNgv1s5FPmh0lzJYowZDZesgNFnteRSHVa9C0MwhpUEwLEauSe7iuqLUNa1IzSn+ei1gKd5j28tkAmBjIusKMhnlf7rgA+hrhwpGmPeymq4U1cxT9kBn+TDy+0YrHhpAqVpSbGfaWDVo/OEyEmm2kRixVeaLrlkLLfRwswswG4MxEcqmnN6xOSd6qxieS773iCO4PyNiw0zN5LoP7D6bne1nICMWoDrEA60okKjfW+IKgeBMHoEhSXYWJKs5nw+LxKINyo01yO43oSvgoCfUT6CU3Y3jnt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0YEGkHItyXtRqeSEA94uGji6Hb487yCsVIslAqqOto=;
 b=IlPeUoyqLQECPKQ/pRM9DVakWrutFTTa5POK8jzUD+1vu3arsiiBpLPeGb7xLOwBv1SG3GoQDgfCT7RhCV8n9yfWjzwX1kETurXy28WSYememL0ze2RvkUURqy4yUaMOj/oEDDNQF6EavFeghmJvLwBTi3hNRkxPk8sLjBdjdVQ=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 15:37:42 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::54) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 15:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 15:37:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 10:37:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 10:37:41 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 10:37:39 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH] mtd: spi-nor: Add support to exit 4-byte mode
Date: Thu, 28 Mar 2024 21:07:27 +0530
Message-ID: <20240328153727.2939697-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.37.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a465a8-fb00-4bad-d163-08dc4f3d0232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bgrq0I+EITxxGmlpZngglmr0xz1A115yAFSnbL9dJb1KIf0OjxLwwLZhDS+N9Ma/L+B4GWkFsSCaRNpSkZAMRCiBKSj6dQpWz1+mEvr70pd1jUon6psbNmwk1q/U0RYK9bKc4rOpZ0g3UVDnWDEGuIvvUC9X43JJtnrwZ8BawEe9FOFYddg0Fnl/d4pfYEfBUMQs8c9g+04puL+oi2BcPbJMvIdwLg1bFQa8SOh9nDNL9srJH+gP2XBIpDjvjszy6CBBVjEYSFWF0YOBasyQ4wy0NirI2k6K5Kc4BrLS9LPT5f/8W1mqkuDJ6L0yswLQWcFVAXNtnl+Rc/4NZbcnR1v28fSVFj5QkbjPWuxfeyjK4zoTbDR/CXw0N4Xo+2xTb2zGtA7/Xjaauujibr2nDQWW86K/oXjmw8JleQh5a6eeorRv59cxPcmg4yzlbIFzktgz+9EL2TzT4+2rnltkEKD4jssRavox72AsEepbcnQxR3DNSsOrAz862c5ywXmN75ElCb7Lb1lWY6rfzTAybfj35cA4kgW2ve8EGzCTjx0No1pWAQg++ufZihj8PZ7NssPHtYl8cOJg4VAkQkO9OvD2YYyiJvbqliliuEZ4mlICp7Lep8HgbJuyoKDxxhxxIK13SNF2cgAPMuhInTCxgRDRaY6H/G9oYVSEDHknRCEqIcNAWEfqLj+10EJOFoQkpPhctQsp+0im+AWt+JIAIjx65oX/C0bs0tvt9xPRo87NojlghW+37/caxqEMkcB/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:37:42.7001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a465a8-fb00-4bad-d163-08dc4f3d0232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

The Kria board features a recovery application that activates
when the FW_EN button is pressed.
Upon power-up flash operates in 3B mode, However, the recovery
application changes it back to 4B mode.
Following a reset, u-boot activates the CONFIG_SPI_FLASH_BAR
and expects the flash to be in 3B mode. However, there's no
code to handle this configuration. to address this issue, changes
were made to disable the 4B mode when the CONFIG_SPI_FLASH_BAR
is enabled.

Additionally, spi_nor_wait_till_ready() was included because there is
operation that places the device in a busy state before performing
a nor read.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f86003ca8c..47f65a4f5e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1464,6 +1464,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		else
 			read_len = remain_len;
 #endif
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto read_err;
 
 		ret = nor->read(nor, addr, read_len, buf);
 		if (ret == 0) {
@@ -4161,6 +4164,7 @@ int spi_nor_scan(struct spi_nor *nor)
 #else
 	/* Configure the BAR - discover bank cmds and read current bank */
 	nor->addr_width = 3;
+	set_4byte(nor, info, 0);
 	ret = read_bar(nor, info);
 	if (ret < 0)
 		return ret;
-- 
2.37.6

