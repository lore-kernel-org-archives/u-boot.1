Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD5DC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2226D87F0D;
	Mon, 11 Mar 2024 18:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJ5baFPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE74E87F2C; Mon, 11 Mar 2024 18:23:17 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A940A87E6F
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrPWITD4fR8UkGFEJL5ybEgKHI1S3yjLQVPcwANHaRatnCVZBBDy9GUXxwms1PyXuJ2labIVWBuRjdLYKAEn34hSUcUZBGCho8oW/pk8ECYSn0o4VRPTKVRYHmZbkgOvMV9AV+1jHHmxAS7rRry2ftzRQyVRqjYmL+ZkBJubZy+yKhdeVWPlnbLtw2N8dYo5s+mQLdyNZHJVwWosz+moGX/LPiiyuwhQKBkIgoxkS+y5oGXRgpzV7AgZ0vJpyeUSguZUw73nKjpneOOXws/i43FxqnSlhJGh8gxQ4Lf0lDcI98PRRK8SpTUvkuvmsvMFENlVGMZ1gED+GjoXAIbsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkM6xbJ91OaR2pT4nDfxMcdZmMB8O6E5sA+0iVgWjBM=;
 b=jSl6CYyOpxwjnEYaN4c5baqCH+LDbxzpb+HNiZkCIDCqrgFgO0+MN/EbJfgm03exzKQ4k+e15SwBZoR/nXk2O8dfqDwYPbn/mFxzsD3Ns3Qqv4fLzhIv8ThLnAwqhFjiD0V9mLGiGEcGKE2aVkuT5/nrP2Xhu8vD6jaj7Hgp/TwequgzNlgcW/ZgwbZ7MmkH8Wu7h6eSzzn41pXjUBmUlo8naLTA0lz4AfuJP+yMlwLWY8YsK/DYOflkm9NBeCu+rubjx2nHRE7t4i7BX3psey84Dnivke/wHHFn5nRcrKd/S4z/ALwtyIDuf4HErpYAqDumiyGs55I4RXA95ISH2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkM6xbJ91OaR2pT4nDfxMcdZmMB8O6E5sA+0iVgWjBM=;
 b=eJ5baFPKZeEZ1z6vEg7dZY5UpewT+kVeCoMIO2DtMkTKxezUAT9tLNgksKPBhQZ1uRm4CtMGdGrNg6D4hhr/iMyKO64SStlMHgWesD8QHy8m9d3ngQJxM/ZacMxlflpgRFz9YTEjqlZYMhD1r+Bj8bCENq+DwugTECmICglS+7M=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Mon, 11 Mar 2024 17:23:10 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::2b) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 10:23:08 -0700
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:06 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 04/19] spi: cadence_qspi: Write aligned byte length to ahbbase
Date: Mon, 11 Mar 2024 22:52:34 +0530
Message-ID: <205e59ff5e08149e30c40c777ad6a3137825667f.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 021e5cca-e8be-454c-7858-08dc41efec76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1T3ndU4JcfNj4uSo/cFzF0sTvqsZeIXSPm9jU/9ATIpKHOhF/uob0bnDyAOpjFw41rqeD6oPtmsNdwrOfAqV05HTTopcndb3ZSvpt0pkHZfELgFoD3+iIDaA5nggUFzlzYyrSV50cJW8LGCwWGZx+Or45fd7vlZmdFJoMXAdNZtGZbJznGv7QuBB1fVZb8O6bXSI4zdNmZqd6XCo70kPOs0A8EK8wxYRsbKgnbmNTbHfbUtyqqXOZ777stis64cjfSRUydp0hBlXNjnozNzwN4DWIp8JTvrk6Iex/VHNlq8wo3I/q2b99Z92Lu1E5Q6Y1rsymdgXHx2v8G1uYkQyJrc6uLve9SG25n/wBUvMlM2ee971MHAewdxKdC5N6xEWvorqAodewRLpvxBAb3PiM1f7qjtP5dgiumL9v4irprfYm1yK77pIlAy7BLDnMWYokWhDXLsV+54yZOZFGw7ulLDuEgblErNfVuC+eU8ba6w//0uBdDi6xdii6ot4D/MCOi2MMa/yVxMGRylBTHhwtS0BBSpmI4TJy+0O3J+Glx5e6M5xcSurCq8SmVn+AUWueHvEggYfChcQOZ4/3h7mUtaBgUEmCZm0N/ZSFWrO6fNC4AtzAKGOtz8clYJt2FYuo4mo050KwVRSXPdNTaThbx4Q0SMprnD/Fs74E8OZvoCQUjsYrTkACmAQBUURt5u1cdTVigmDDOR8UYp4hDa+HUkq7ao8nDsR/X/wXTlQLA/tndXeHzJZyYKpqhQLs8q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:09.9006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 021e5cca-e8be-454c-7858-08dc41efec76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
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
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 4404b0ba07..7576dacfb0 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -891,10 +891,12 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
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
 
 		ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_SDRAMLEVEL,
 					CQSPI_REG_SDRAMLEVEL_WR_MASK <<
-- 
2.27.0

