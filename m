Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB04FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC858432A;
	Thu, 30 Apr 2026 14:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B3eXS3CS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF8780F0E; Thu, 30 Apr 2026 14:20:53 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B879B841D7
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQCHzrU+D79ImzazVFo9Q8ZeJ0msbLFmnzYSl21QEySnnW/uVxD8yhRm/6Vk4yoaty8LV+ItmLdoH3EsIN4ZdmimNzgazgfquO2BeTyHtlxNQJYVGjwuRQvvEJ4kd2Kf7MiRSJ76bPxL9yZOhC2k+lHr8yWfpnmhtbp9colJZpymX5SqNyVHqNYhOpSla9gpIACt9CrfeCLIvkxKpFkETwfmaB/M1wvssKW9EOhr+d8uDj4oU8fbi+l/yt1Z1hbbSwG2KI7AMYsf0jEZXI0K/mBPZ3a8ceGLfK7GN4v1QJcXzQgkdj3wnI75uqoQ2StW4j8vQxpAa99FGyRE8F86Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzdcDPDQz5Hj3RaK93Fplr0sxNjFFkONVX6rHOw0Ocs=;
 b=SNgSmohwqHk+CXEHQc4KmaFLcoyqbcWiPXyrFprnit/I9cCpf2FbFaJEmE2udk68dqDj8z526tWNnGbvcEjd7GWnNJAOPmRwkyXziRiB/RhVpzej/EqMNYy8vbVdgTWKgSYCrLzKoYe6nuF0pJZulcjDqUoJuT8Ssb1ChYCIFu4ywG/cBoXBrwVwRCf1RyG3qL7otQ+pvXn893Jw7pw3eOOMeUhb7ilr3rD27dkdtp+7GDJgTXMlSJumkmeuYB7HmL011nbXRrlfmPb55XyffV7O8jV3txlSinM6r3218YqxAMUdJMmNOMXMOy5U9Xxw/rqr6RtEJPcpO6SIrYhmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzdcDPDQz5Hj3RaK93Fplr0sxNjFFkONVX6rHOw0Ocs=;
 b=B3eXS3CSAoSBFR6wPhpQ/7RNtm4FOMFVPsCYOXbdlrbPgvtk8q4zCbgrU/YMGtosAe/3CmjKNHLIaHG5XIVK7PNSjCYxF7keZEarFP6hakH8nnCmtz1Ogm27kk+uqPYdZah5M7qpJXjg64SETXFg9jK4qRb88QY2TlKLcC5uR88=
Received: from DS7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::10) by
 CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.17; Thu, 30 Apr 2026 12:20:46 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::f1) by DS7P220CA0006.outlook.office365.com
 (2603:10b6:8:1ca::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 12:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:20:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:20:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:20:34 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:20:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 3/4] spi: cadence: Use reset_reset_bulk() for proper reset
 cycling
Date: Thu, 30 Apr 2026 14:20:03 +0200
Message-ID: <0880332fd0d61e2f4d497da8dd7fd10c9d65dd9a.1777551598.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777551598.git.michal.simek@amd.com>
References: <cover.1777551598.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=aDBzux14Uqhs4it5zfGmwEPklBvVPBOPXJhXQYq9GCs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+9vjN+UZKnHWF/AS7/2eqMx55MMw0nPJ7zwe7bgcug
 XecwWXPO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAindoM/yuWaAdPs7c8tq2p
 Yrr8DYvK45l5giI5z5rlpntMuXtn2mxGhi9Nvxb86P9dv+LcD5ky0clMWWJHax7PtOn4LBCzcsX
 b56wA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cca7db-c09b-40f6-cc90-08dea6b2e7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Sce0luRAcUvc2aCaLemrcdbIugLxepaF/T8958vecGjJS0d21enMj6q41UiQ5sPT4Ajldb7LcsQRqoRP9/mmjguR7ezwyq1csAzpJKxmG1v1wkzr5AVSxTeBzATo1NhPsuAwNMpVnd0JrXj5x5Ga6EcyYmK282DeFAYVc22LSKWnXR87tBQ9lEBhVLQhvjsYTv9unoilZYi7GHg1/hDrvCLOlU3eK0v1XXJ8r2E008WltRAjCpZs5re0/DvO060l2hgqI9TjzQ7Ei7WKZH1fP7NsUQtBFN+IKvDCXBzzBCSicK4Nkx6MoAFfYzk/qsT2+HMWQpwqOsVpVCQBVTRvdAVetlwRSLDTv+Ox2oxCWf7xlVZKWkqE1sqHa+Buy6ERODKdvNUp16T/rZqYJPelCKvsZ1jZiEV33UAe6++HQOv4gWhyyWrt4Y4cZ3ATJCgPxVcnhZ0iPYCi/nD4ZvKfuW6u3NB0/FTJQZY/wE7dBzG9sy5Sr92+w7bJNm0v6G8vGSXfQKnHO7VO5z82ARwqhBfBGskheuh0SjJeVpeoOtAH+BWUtc1dWThE65VzX1jEQSB0bEEnz4a0otclz9LS+0W1poAKsQV5LNmafosqDys5Zw8yF55S2UaFmYCXRYVac8DT/ziaFBt7F9j+ZFMP3Xkn7zlefz47wsUrtC33VAqO3RYV+yOglE9+Av6mx7E1y9YNPBpLzEj2pu4FsYZwbQGkPojSAv2POYC1rpBFj4xEoOxOsfycwngay/GhelOmI8/W0bZrJ+dGJh6smg1A2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n6uwS6JYrAB29jCLMaEQRXiH5vdpM7You/Mo/Y5ZI2uN1bjWC/2wBSAprRvt9YxLpuEcl9rlfDh++zVEY8ZsJVmEouOx1FOKRz8nj0sKZIFQqHJnAT3/0m/TsMY5hQCAj60mAOw3/+4VtbeFd5jk++Hi3HPVsN8rq10G1N5hoBA0Oyy4jeONRbTe4Pz4Okv+UNWQ93zk9a/iaX6GIizoSQcqNc7X8ztXMmNIoF7aYjO1pFvtEctsqdeqnoGtZmBW21+5KhkOihmEVZ1kvDcj1ghQPEgtPqhkDX3H4lSmi8o2FY351gyvDRBBe2EP4zwaSsR2KLWOanjFOtfR2iMrTqbSyUxkOYU71Xxk1+7vgXkaDs0lgeFD8ecZXA8MMSHDOfYoqpEwDnDUZOz/0e/B4LYmK7NYgmI4uD6XXqzBcjkYcJHarUJQzkH7GpvDB++P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:20:45.9475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cca7db-c09b-40f6-cc90-08dea6b2e7ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Use the new reset_reset_bulk() API to properly cycle reset signals
during probe instead of just deasserting them. This ensures the
controller is properly reset before initialization.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/spi/cadence_qspi.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 2a4a49c5f1cf..b9f2481b9cd3 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -255,23 +255,8 @@ static int cadence_spi_probe(struct udevice *bus)
 	}
 
 	priv->resets = devm_reset_bulk_get_optional(bus);
-	if (priv->resets) {
-		/* Assert all OSPI reset lines */
-		ret = reset_assert_bulk(priv->resets);
-		if (ret) {
-			dev_err(bus, "Failed to assert OSPI reset: %d\n", ret);
-			return ret;
-		}
-
-		udelay(10);
-
-		/* Deassert all OSPI reset lines */
-		ret = reset_deassert_bulk(priv->resets);
-		if (ret) {
-			dev_err(bus, "Failed to deassert OSPI reset: %d\n", ret);
-			return ret;
-		}
-	}
+	if (priv->resets)
+		reset_reset_bulk(priv->resets);
 
 	if (!priv->qspi_is_init) {
 		cadence_qspi_apb_controller_init(priv);
-- 
2.43.0

