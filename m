Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B53C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5154A82B2F;
	Thu, 15 May 2025 13:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ABwzYDZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7BE82B53; Thu, 15 May 2025 13:16:07 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E9D82B20
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5d5+j6l9YPMmlKnAf7/kZ9G1YctgWaoaMccIkK3cJAySLDxczesqsWkfDBB5s0X7lwIe5+jJnI8mH026pTzGpDIfbTC1fyE2/u4BMtxvmbo/DboLsAgviL8uT7cyP4k6uOqflQOiK4uN0hPUrYD1AqSwWHdQbZEu+yHOkkM00+k9tMzLCSlgTDoIRXk+tvPERoqSi6dL90Q4eR7OxkMUNUpIkK6qWnk3wFTiLAEXuudXVfDCIV6GVmPHnJ4l5mSMqtxKiH8XFN4668RfMHOp9zgw5q3oeZ5h4npRBNsLQuzPW4d/Kp3bh/sHb3xANwAlCuewzCDGdt8o1HnN4NeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRP6i6pgMZYjc6p5RAo83staygVO36+YDzB13f9i4z0=;
 b=wyaN0u38E+dzS7kgyOpSTGW/dktJyPSdec0hG3Cg2twKOdSCwtWlxjZs8RrY0vNJholbWr07RJWaWq9o74IPFYgJHV3hKRKo7DI8PPUNluqzYH5iQRfc3iKajzMODg7JtnHPGdCzIn77EqLSkjZAdIeH5pRE/Yjio2A189TGak2HmOH7tJbYK5Dzn/B9Ni4hhuHmxQ4rGmbcL2Bp2B/98+1uXjXyr059Ezy54cwtKBRI43txvCXufHhd6jNSixjOb09ZTQG14RJJ8nAcoLvVSmZogtUq+WYgZH6pQ2oK2bcLRUTA+CAtaS1K5Oth5sFmSMKSCmsoOl0uBjTI+rE1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRP6i6pgMZYjc6p5RAo83staygVO36+YDzB13f9i4z0=;
 b=ABwzYDZ26rQiIdAuAChQTDh5iszo3QwUb5y0emBytMpL3/FGbyXCILNjWCjx5ePu5EaB+/qqiBIm+uTV94WUi6h3OKbvY7anXtaxQKy2931DdqDDsKP5n6/KVcPUVVtm6ddiaw3iLbCQ3yBrlqMT1I80nS2AXz/hbOgWMIn7yz5W5xtmzEgK2w1PjEhBSu5LcycHe0aEiq7OcZ1NRIfSM5BtCd6TNcC+ja2tClpQlMoP59YQOQGkIWJOs5zYpqGz5Cy3SMnaYns3xXjzCoujTbQQ0CJ+8KHkf0c3Cg1YZRIKpLx/9iD0406mbUBCLrVy3Ri05pnojseMl74Php1Mzw==
Received: from AM0PR02CA0221.eurprd02.prod.outlook.com (2603:10a6:20b:28f::28)
 by AM0P195MB0532.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 11:16:03 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::11) by AM0PR02CA0221.outlook.office365.com
 (2603:10a6:20b:28f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Thu,
 15 May 2025 11:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 11:16:03 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 15 May
 2025 13:16:03 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 15 May
 2025 13:16:02 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <bb@ti.com>,
 <ilias.apalodimas@linaro.org>, <n-francis@ti.com>
Subject: [PATCH 1/2] arm: mach-k3: Detect and print reset reason
Date: Thu, 15 May 2025 13:15:53 +0200
Message-ID: <20250515111554.2916254-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250515111554.2916254-1-w.egorov@phytec.de>
References: <20250515111554.2916254-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|AM0P195MB0532:EE_
X-MS-Office365-Filtering-Correlation-Id: eeea312f-6407-4ec2-fdfc-08dd93a1e18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ncMHoUJzQI3gdwkydjILhhF43zfo0I3j0/d34wNuesqdnU/odRiaB7y55RhU?=
 =?us-ascii?Q?smIqmqFdu9E2E0dDvBfUxy/iuJWBw8N/ZAi/k/px8A+Gbz8jKDVVdjh2PcDD?=
 =?us-ascii?Q?MpfpaWfVF5NCoQDU5QKYDt+PqKqA3AtaYivXjt350zrUDZsIHMpGA2TTrDIM?=
 =?us-ascii?Q?gXJRuQArS1dYlLv+bh0mMVwBF93Tkr2TiGqOE6ifInY0+3DsYsRBCSyWCXdP?=
 =?us-ascii?Q?On9biGkaB4+yIZG/HTqu6EEr044Zl0o/6QwepKyFvg1wa++u2fBM1P4Qir+1?=
 =?us-ascii?Q?LOMlRnErUyc2MY+hdpOWbOZDhB2t/gjpXGKppe7s7QG/nYoEvSozhMJTZkdP?=
 =?us-ascii?Q?xRi24YDXzZHLtJTGRLaxp7oeUTgXMYcKS7LVvH7ChqYW90FxTZ5AQl6oYFYm?=
 =?us-ascii?Q?fCUmMxf5bZaMbgl/JvTVbojdr7XzdmI5EtfKY7r/C3Tv1zbi9eD+HioW2CuO?=
 =?us-ascii?Q?LG99BF27wX9MrAF5dh/Al6KoVvgh58ImViGkA8ftbp15ESDYlhg0uUe96Fc8?=
 =?us-ascii?Q?g7UyXiGn6jnwhe+YZePqDf/POxA/2QkvwE8tufdS6024vrKFFjUTY2QGs8CW?=
 =?us-ascii?Q?kNBaYHEfwyMx/WCSG9Z2StdmK1aevskptQaE0/JVjBbEVhZvUYeaVFZGUbTd?=
 =?us-ascii?Q?XUFQfhXYyHAWW/7nZn6i+zUYm753hne46EDVBoxPJIawNVrrJVxswh9J4Qgt?=
 =?us-ascii?Q?iCNlddBPou+1IuY4iunQdW0+rVnvzTSArHQGr9uR+zX90ncLWJgVM/b3O9tU?=
 =?us-ascii?Q?wjy57rXnfAWF5ZG5PlkY82tx2SFwmEu4V+yL5zDVgOcEeF6FarDQxIREWAH7?=
 =?us-ascii?Q?FRapmXRzSFDetRkcQGYSAUGbaB5MsQni1PpK4r3nIYf2B3ijRgu2JKjX9x9t?=
 =?us-ascii?Q?c1oYNx4FKaEWRIFk0yhJEjm7BgYCwvKPaCrb5YAuvxopY7Eq9KaeF4xbayTh?=
 =?us-ascii?Q?JkURwD/y+TCYJbYCOaE3wZQekLiv122C+CZznYFHdUckDIb+urQZRA4fx91w?=
 =?us-ascii?Q?0GfvDlc9KwQr6pCaSer7vaPz1AYdlHceflM+Z6QMYBZsI2p+Wq7weXJdN/Iv?=
 =?us-ascii?Q?jeeJKVHpHV9y7L0GFjFshBcIr+onU2+svU+fodZzA0Jil92VLJ5OjbMgXKSj?=
 =?us-ascii?Q?xKuWfKM08MqNVm1zE88Hz27u5NA8v0qLy5FtZsulQ+GvSIcD1GHiWmANhsQk?=
 =?us-ascii?Q?sxNy9inoxX5oNQBI0n/ySvUwj+l5wPcAYZia1nGfYypD68g2z70JVFUwakk2?=
 =?us-ascii?Q?VSRz9KWmNBbX/CqZhJHKhb4QS27eKnFxeNgUyirJIAem53ykwL+iBsynQezp?=
 =?us-ascii?Q?/y4Ea7qRFRFT8H5F2L55jQDq4rbrx5moMtR9J0FMGTpexUcsXjWxuvncHagO?=
 =?us-ascii?Q?El17vdcGyzFktbeNDxsd7zidyPHlwzqFXSOsk6bWxL8IzWbhryi46lcaRHxH?=
 =?us-ascii?Q?yraUrgixSuR66fh0AHTRxvFY1t1YlIxVpfyudbcShYsBRi6dFnTKBFrUyl1k?=
 =?us-ascii?Q?8vix900tPS+cNdTo/zbs3Xv81aj+UjkHEqOR?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 11:16:03.9096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeea312f-6407-4ec2-fdfc-08dd93a1e18b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0532
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

Call get_reset_reason() during CPU info output and display the result
if the SoC provides the implementation. This helps in debugging by
providing context on the last system reset reason.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/common.c                | 10 ++++++++++
 arch/arm/mach-k3/include/mach/hardware.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fc230f180d0..0323001d6d3 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -175,11 +175,17 @@ static const char *get_device_type_name(void)
 	}
 }
 
+__weak const char *get_reset_reason(void)
+{
+	return NULL;
+}
+
 int print_cpuinfo(void)
 {
 	struct udevice *soc;
 	char name[64];
 	int ret;
+	const char *reset_reason;
 
 	printf("SoC:   ");
 
@@ -201,6 +207,10 @@ int print_cpuinfo(void)
 
 	printf("%s\n", get_device_type_name());
 
+	reset_reason = get_reset_reason();
+	if (reset_reason)
+		printf("Reset reason: %s\n", reset_reason);
+
 	return 0;
 }
 #endif
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index fc7bee4d00b..81b5f1fa45e 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -125,4 +125,5 @@ struct rom_extended_boot_data {
 };
 
 u32 get_boot_device(void);
+const char *get_reset_reason(void);
 #endif /* _ASM_ARCH_HARDWARE_H_ */
-- 
2.34.1

