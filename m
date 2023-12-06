Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25A1C10F05
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B06876F4;
	Wed,  6 Dec 2023 06:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jM2G+tGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB745877B3; Wed,  6 Dec 2023 06:35:29 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12ECA876EF
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJjWAtSQcBUsZWE8LjYxNOVvy3qJCispobH9f6ku3LGRi5acIOJwpukGz+Vzw/Q2jUZLfKfgRlgqOvXfVGZ+EMvVyr3hjbLQ6A90kw/NjjOxTcEN+JSLRvVNd1VuKtwVoyQQCF3DT78YC3atGzNpY0fHdorevo9MW2W3S681xg1SPVrjZadY+iT8AvgzXAZE6+rjFsRp2m5WGI8rKHnpVbxpsAOCPexUWoOcA62PSpFtX2cGOr7oFP399o1TFhXyJtotRxu4ZYUTHsQ6Ikn4oO1ov6CWIFlPweJR0gYcogUs9cMNLi+UjSQnBhA9BwrdHoM+Anox/Jl/RinL49VR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2fZ1tBtoVJQXoXkVEH6FRw7Xg7K1N/Vy0S+VL8IAvM=;
 b=cRpoK++9R7NnftTVKTvuL4Sx3ONe4nzoNF4egS1Rtn7K9KwocsX8Qr6mMLW6ptPy21cLAWB5Mx/rWFs7eJZbqt192StFMN/hLAUgDV8yggDXcGkpO9BB7t93XUju/6cx8kv89XgYqKnlS5DO5YAm/bDqANLAvviwm61r8RWBBqq50bdDEFaXn7e1Q5g+nx3tcTQHWe+dKCUvZLSaKVkP3R8f4KN2v8hwpwTed3NoUhMQg822iEgROO5UlsKZuJdB/lOd0Cg7W3OnWQ2DkOSHT+RzPZd5n8jYW8oYBBp6hJ1LUhJm7zbS83brkPKJIKD9DvL78htFE41bC4PU0u4c3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2fZ1tBtoVJQXoXkVEH6FRw7Xg7K1N/Vy0S+VL8IAvM=;
 b=jM2G+tGoL8ER4dQ72Ym/6h2UvK6kFQwg6eEgAWl4dn+h4Rs7c1uIGAVfWHCYRm+g9QSCdGffdRJW3DwuDeuy6VaDk5cgLV8A4paCBniP0xo/nMW/gm4W+7BXof17PxFaKmHeqAtWxWo0DCvH/wDfB5TtOddoemMsCshcLAXAw/k=
Received: from MN2PR12CA0031.namprd12.prod.outlook.com (2603:10b6:208:a8::44)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 05:35:02 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::2a) by MN2PR12CA0031.outlook.office365.com
 (2603:10b6:208:a8::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:35:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:35:00 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:58 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH 23/30] spi: cadence_qspi: Write aligned byte length to ahbbase
Date: Wed, 6 Dec 2023 11:04:37 +0530
Message-ID: <20231206053443.3746237-4-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: e988ebbb-ea83-4a40-57d8-08dbf61d184a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDmgQiAgMxAyEECNUuPNn/HlFSOV16qd94MkhqQSthNuuGBcDYsQCDQAgzX3TDpXRdhoBdlx/uG97fDc8dAf/p3jP0ydqqVL9w02lBsZ/IoGmmNgHWK9E+D809bwUDibPC/NwMbFDpBFnNQaHQstlswDc3Y+dNX7DRIr+OoL5zqRggCMvIY8jGpW4yW5J2TYwXNn5iHkaDJaL4hMRTo71kpMLErM3Vpm3g0QWYtzsj1QtUo5iShelf7eRYWBSVvbW2jiAtNLIontPtQV9KE3WdIR6O9gtYqcHZOfDbUVdkugRZw73JxddKdGIW/YMCdi2N/0Sf+YGBdu2IW5hXlVP6sv53WqTDEm/Ekya4BZ7fqgTj0lXhxoEHjcUkk9KMJ3fGUS3dQZI5wqZnvdCFe74RcPCOOQyRx642EVX6xzB/diMsrk3V8D7zLAzP2ovaPrCfdOhfF6z+IhJaFkpdXU7pp6MBIF1Wwzb0rdgS+DngNhaJ/U2YYsygR0cAw6cjS9IGEW5MEErUZ3Dx5m40/o1yxDIwSFEzRZJ3cKaWheEOMgBSzKP3YJ0EyAS7VnPzGf1UBBKZ11TQ4Cs3vIZ5cqYwDPk2YT/8V32oShRf0AMRkpgj6i2xRU2No0lCBY0m8PBhb802cjCapQ5LhEFHmkbo3/tOUngOsOnpOD4ZKqixaU6gFa+FT/yyjgyANmnxAnkz0XcpdNs+kdzOOm0NulZSZ58vkE44gWF2dyJKuokl6OxAtWM0vo43vPMmmD53Ht3MAn9g5TpnQbW4NgD8q/lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(8936002)(8676002)(4326008)(5660300002)(6666004)(36756003)(2616005)(316002)(6916009)(70206006)(70586007)(54906003)(478600001)(41300700001)(2906002)(40480700001)(82740400003)(81166007)(47076005)(40460700003)(36860700001)(26005)(1076003)(83380400001)(86362001)(336012)(356005)(103116003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:35:02.4598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e988ebbb-ea83-4a40-57d8-08dbf61d184a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
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

Incase of non-aligned length of flash data, ahbbase address is written
directly with byte count. This is causing AHB bus error's sometimes and
resulting in kernel crash while booting linux. To avoid this write 4 byte
aligned byte count to ahbbase address.

Also use a temporary variable with 0xffffffff data and overwrite this
temp with unaligned bytes data before writing to ahbbase.

The value 0xffffffff is chosen as this is flash memory, worst case we
will write 0xff to any location which doesn't effect any bits.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
State: pending
---
 drivers/spi/cadence_qspi_apb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 43dc4c6e70..1d0e6c2180 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -934,10 +934,12 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	while (remaining > 0) {
 		write_bytes = remaining > page_size ? page_size : remaining;
 		writesl(priv->ahbbase, bb_txbuf, write_bytes >> 2);
-		if (write_bytes % 4)
-			writesb(priv->ahbbase,
-				bb_txbuf + rounddown(write_bytes, 4),
-				write_bytes % 4);
+		if (write_bytes % 4) {
+			unsigned int temp = 0xffffffff;
+
+			memcpy(&temp, bb_txbuf + rounddown(write_bytes, 4), write_bytes % 4);
+			writel(temp, priv->ahbbase);
+		}
 
 		/* Wait up to Indirect Operation Complete bit to set */
 		ret = readl_poll_timeout(priv->regbase + CQSPI_REG_IRQSTATUS, cr,
-- 
2.27.0

