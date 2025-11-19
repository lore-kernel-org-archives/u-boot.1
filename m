Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61613CF256B
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 08:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34858397A;
	Wed, 19 Nov 2025 09:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VijAHFs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A219F8397D; Wed, 19 Nov 2025 09:50:50 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB6583979
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzksqcYHxF6t0rYysyEj4Eyf9BUPwrvrZANpSKFR7UbaKd3OWL6fANXg33UmJBlZpRhiTNNi3FZcb0qwQySOir7P/TaikR+57MeDrkhT7Z/1BcxKYZGaO/iHDAcj+iCyi2Qp/MWU7qX/4EGqBxRx4O1GN5zwsJlm/8/NhwA5dIYVUAEqQVntYMDoHXO5jpIeqb/cOl7bvPQWk6L1R6bbK5G47EQDeQVw+ASwgvqTLtTtl4aGf/rVDhMww13zHOY+ab1JMnLFhFkXP99R7vNNdDRZn48apeI+OCVYm6N2WjCI1sik1v+EBZl4oW3JHroqrMQSf+SINMIUHXYCBJhRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De7hplPvkjvl75Z8v/26ZKHhDdI4qLoGYVx6lmWmM2g=;
 b=H2P/HzYfwh5Os+BwUIsjQthZ57bcbNVBe2dL+klHkvSyJZTwqCjfWFaZFwkijKiz5aJnv7xWWhMhZbeV+pr4VAoKT/6cZ2hLHeixCepFifk6W249qCmVJzVJKXGz/CPS4bBRkBRdb2Hcrw2QLZpvLZVnf/HRSx094BdUfbKwyTFM6YfQ5caCCgwyYTB8fRlfXViq23IRiu0QhbMJKq1VR/Iy/GP8Fr+F+WAu2vgWEcJpPxk85uCz++d93tFFIqtG2NvF7fQoSgNarY1l1HcopvD4H+dVZw8FKCis2MWvM+7YUXy0nW4gljcIsYhrYUvE75ZHPtiKy/eNNhN7IeclQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De7hplPvkjvl75Z8v/26ZKHhDdI4qLoGYVx6lmWmM2g=;
 b=VijAHFs6TfEYC0VfgZE1EFYEDsRVBB8p263hw6Kx1sOiUfFEytMJJDtZw3Y1lNjyf05aMh9sP9s64mdhHEwkFLPqbdpmvYwrnposFQagvjVQ+8ajGU5km4I+NIZKj3sRbjSahoRWqce6Z35LZpysJjcrYtXudOgQwSdPK9KE0kk=
Received: from SN7PR18CA0014.namprd18.prod.outlook.com (2603:10b6:806:f3::26)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 08:50:33 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:f3:cafe::3) by SN7PR18CA0014.outlook.office365.com
 (2603:10b6:806:f3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 08:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 08:50:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 00:50:27 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 19 Nov 2025 00:50:27 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Matthias Brugger <mbrugger@suse.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH] board: xilinx: Retry FRU EEPROM read on timeout
Date: Wed, 19 Nov 2025 09:50:23 +0100
Message-ID: <9556d204c351d2dc40176a31dab11f789fd1cc7f.1763542221.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LiVHw/eEIewhH0LGw1kF6U3SZSQOqnzFh1OOm/4XqHU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTKtlwofcepp/2t6K6vb7Rfqf07o3+MDVefc7VsTiuMY
 45/kzSto5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACZSvI2R4YbbabPMz/rfz4rs
 bra4N/Wrxb3f34UvezGWGjw8s1/u3FKG/6ERiY81JjyMmuN29P02/szlTXErUvUyj2ku/tnzXdA
 ugQ8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1bfb66-e6cf-4b33-99c2-08de2748b35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jkdFIwGHresZH+DsEDTv1SXhxo35rmZXjVjs5Tv3I3pkd3tVFbsnZm/GBoT/?=
 =?us-ascii?Q?8RyKVYuky1+faotG9N0elTvRGj7fRTerRFAmFplPj60C1ToNaRt20rivJfR7?=
 =?us-ascii?Q?oItEKRbVEus7FD5e7tR8PybNQTdOEjCY6ThUb3RXC6mPdiRVMcqlLrwsCtWL?=
 =?us-ascii?Q?eREnVLRgny9UQUAgB95cSzUTy06R3ZlTcMozD7H3y0HM7IljIcbCCdQ49Zhe?=
 =?us-ascii?Q?qMZsPTzm3KeWEMQpuxxamAUZXVE/mz0ZqKLXaw1HiQTHWD83C3eszyByizvI?=
 =?us-ascii?Q?hsdxRfyT+nUKmwykr8O5sIir9625evX80FQYdr9nCdNcJ9oYib482ue3KMGm?=
 =?us-ascii?Q?4wioXdsv98vkty3vQfcgmq1rSZjmEPITPNjp6VCF/RxiztoOHvnHTLfEcjnS?=
 =?us-ascii?Q?XPieWGZx+HbxVhUcVTUWQgnmSiurVs/FQu/whiO54TxAKev+5qazWLMvfPmy?=
 =?us-ascii?Q?Ibn1L9alpdnISf4GLAONkQNRfwr5qeSstBjUSijC+WDz/ANaTUqykrnXTE11?=
 =?us-ascii?Q?XnxNQsWZQefltyQxJYzQLhGCKEMHQ7arWREfCfZPo2Q0QBeCSXDlDnDaUaKF?=
 =?us-ascii?Q?H+SjPDCfTVCgpQtz7JfdlTTXQgaflg8537rPquo1r7t8uZASH6hi46W7HUCJ?=
 =?us-ascii?Q?ujZb94lRmx7qVvLTv0AdgpDr9rQSDvfAfH0+SnKqohXLWKKR0kYShxi772Ex?=
 =?us-ascii?Q?KwDvkOrbKJgyq+3w7HGqIOiGfFQmBoIFtUqVCYW6l9n0kEAdFIAfxgPZEPM9?=
 =?us-ascii?Q?8Ltsc0ap3Yv+Wn4Chy48hPi3OFKMKDlHJhT/Aikjk1evZfycvMBwJLN+581l?=
 =?us-ascii?Q?VuZeza6tZxzp0dt6aNWhfu6h+iS0MWvaGQCXlxcj//Ru5XfriVhDQlthw/Ra?=
 =?us-ascii?Q?khF7n7a1bF6O7l/DiJ4LGk5wm4bPFGD44c/ZzctMUPusrQemF7n+Qt9kW03/?=
 =?us-ascii?Q?KpVFU9G8cXpUrI126Vv82H0Loy+FDFvU42nUTof/CB1JwV64XwfvdVI3ri4P?=
 =?us-ascii?Q?T9nIsfbaJoLQEiuEgkGLP/Qarhgma625QWA6aF1Mxi6JJeysuzS63vfILIuX?=
 =?us-ascii?Q?Fh4xw+QRYoKBjMtm++6A9JBpxXx4dqlefbacj5fMO5IzjaeIXjRw74pIpwtu?=
 =?us-ascii?Q?48MVkcrpkH5IEtlZYgXB48U2EuFhAcxTB4QMIdacEvxsCzwYzIVTqywLkvnD?=
 =?us-ascii?Q?rq4TYztuLLPwzF/wPvSB5jrg3oO8r+jgwNQwueczea8iBrpj8htDxPAmNloF?=
 =?us-ascii?Q?ugDRykx8wwHHuRGZdTCAHHLPgDuevrYk9/fuwhyBJT6P0aAhbLDCUTYi1fze?=
 =?us-ascii?Q?grGTaZcS0YCFQ84fKq7xUfWoF1V0WPSUhzRRNjZ8afpQ9CHLlCQNk8/uhzY/?=
 =?us-ascii?Q?tKnQKECCypeLRxrTmEoxbdtOMRItkH9BR+BYwZ99TubngRT86UfXdbr68X1l?=
 =?us-ascii?Q?oGNTUu2ay+mJIVlSy0ddl9kbzzoyLS0w0e4cuIjEvMJLGY16QMLyq36hDtVB?=
 =?us-ascii?Q?ePCModMOrXkEW4sVWT9e1tEVBPF5I75qUyLNvixDBPmPYr0UyGXsWvnJaJAL?=
 =?us-ascii?Q?qcxYBS/uJ8ov00AkL2I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:50:33.2797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1bfb66-e6cf-4b33-99c2-08de2748b35b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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

From: Padmarao Begari <padmarao.begari@amd.com>

Wrap the dm_i2c_read() call is used for FRU EEPROM reads in a
retry loop, attempting up to EEPROM_FRU_READ_RETRY times if a
-ETIMEDOUT error is returned. The loop exits immediately on
success or any error other than -ETIMEDOUT. This improves
robustness against transient I2C timeouts during FRU detection
and decoding.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/common/board.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 26facb6daeab..4735b6ab58d6 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -70,6 +70,8 @@ struct efi_capsule_update_info update_info = {
 #define EEPROM_HDR_ETH_ALEN		ETH_ALEN
 #define EEPROM_HDR_UUID_LEN		16
 
+#define EEPROM_FRU_READ_RETRY		5
+
 struct xilinx_board_description {
 	u32 header;
 	char manufacturer[EEPROM_HDR_MANUFACTURER_LEN + 1];
@@ -207,8 +209,14 @@ static int xilinx_read_eeprom_fru(struct udevice *dev, char *name,
 	debug("%s: I2C EEPROM read pass data at %p\n", __func__,
 	      fru_content);
 
-	ret = dm_i2c_read(dev, 0, (uchar *)fru_content,
-			  eeprom_size);
+	i = 0;
+	do {
+		ret = dm_i2c_read(dev, 0, (uchar *)fru_content,
+				  eeprom_size);
+		if (!ret)
+			break;
+	} while (++i < EEPROM_FRU_READ_RETRY && ret == -ETIMEDOUT);
+
 	if (ret) {
 		debug("%s: I2C EEPROM read failed\n", __func__);
 		goto end;
-- 
2.43.0

base-commit: 2e86581d055bff8335d7e43d58617db16f11384f
branch: debian-sent3
