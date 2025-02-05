Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6A2C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 04:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B223C80104;
	Wed,  5 Feb 2025 05:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hs9joJoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7561805E7; Wed,  5 Feb 2025 05:30:27 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C515080087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 05:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQGi8Qck3dtwTmCydBJWeRYPCdt4iZOWP1hIhMm+PljGAEwT5YEmNN9CkiGXhYPpiN5/3VCjd65gqPF2bhB2KXxIYTdsk9qWuwqHL1jh8Xdcy2CpGh/Pw/IPG2UqZkRFhPZPjW7FosBRKX1aDAq6XNBwyHqhKNW/+GWpLy/HDsf9YVELFO5hlCs6EuZfFwFvBj3amnxk0BcCjHUyXeYXhqupAffzSpK91N86RXgSxCM7d/PIyFPOqDwXGpx7djNUOBJ9kwfqJZiA+1Tf/jW3V6OzVMaAwgFP13+vv0qc/B/agOpYL9XqSCDNFphfx4BQKr/1PiWVl+iqic3fKSd/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5ihxJtLPgn/7k5NYIpZ4tfx6wMS0jJcq/kWfwMDta0=;
 b=hlluMhtzLpAq41tbngM174VYOY4/BFF/mHk+VANRCPwqlvW+AlmXIEjL9dK2wdU9ScADmwrfd2NOru1I+4PJRH1AfFv87z9AbkSb5ISnNAyE3L3JEZ0gLFmBk5Bb4nmSE2UDy+BbRDaUA+ZnJbu4iwdz79EysXgf8FQf3URqKKGn3+cy1EMU5XLu2GImzUdJWWcpOTebGf+KcXNHYfKaRmBm2ZZyIS1p3qm0ugZs/rfJjlKMpyURrJa0MgFxldJpy3/eq2hXe11ThUzKwtc+B5SzijUlFgZk3vzwR2nSyFq+uESSpYXI8DsDSELNYc+a5OpqYc8Cqf8/65+fk7kiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5ihxJtLPgn/7k5NYIpZ4tfx6wMS0jJcq/kWfwMDta0=;
 b=hs9joJojxY5+KeHaqzsTBfq/XdWF3j+3d4NCmhDfKckjG4nABOH9LCTJn4P6RRNF9PVhMxFki0IuenDwdUJza6SsDU8Cp/91FejOgvHmgZd3mZ0mw8ZPJQ+t1wnvZuZtroA5HEDMITE7Q/C3ZznswMOwCb7Bgb2HM5YX872NelDtZmceSMA4A+hQIaxI0ltkTHPdLiwNxk9IOKoLvgtMnAwrgdx53N7bUg/A59vP5nYnaAYwmjXC9Asyhi8lYi0duVAxR4pNjC0GUOLjQ1Szc4DvpK7xAkxfCxZ5cb6e7kH8kP+bnfn4NIpQeWoyqbA1qGhjT6TPRn9W17hG5GrpiA==
Received: from DU6P191CA0061.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::14)
 by AS8P195MB2096.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 04:30:22 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::2d) by DU6P191CA0061.outlook.office365.com
 (2603:10a6:10:53e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 04:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 04:30:21 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 05:30:21 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 05:30:20 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <sjg@chromium.org>
Subject: [PATCH v2 1/3] arch: arm: dts: phyboard-electra-uboot.dtsi: Add
 bootph props to i2c
Date: Wed, 5 Feb 2025 05:30:11 +0100
Message-ID: <20250205043013.1404917-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|AS8P195MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 25294ff2-5a06-45e6-933e-08dd459dcd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?khjG5tShcaiOP5LgIoU8KtJSgfS7w7NXFIp1H/CYl3JAqQtEQ2JXSX0A0H3u?=
 =?us-ascii?Q?ThX4bbEr5vzwbgX74HCLl75v8rtXcRk4cK2NPSqnetiNIz5uWj+D7kgTUoON?=
 =?us-ascii?Q?foPWKqoN9SFcpo2Ngn6Hrahyfpfd/uGcq0PoTj0DOToDomZoxUQ9VS5L1RCm?=
 =?us-ascii?Q?Obc+YeqYJDT5JH86dVh+sBp58d2R8X6PeAfuY3rDpatKNG+gdnQxkdUc5iU4?=
 =?us-ascii?Q?cYw0hoG/3rqopITAcRwYxhhhB9OMe0vXXBgqCLQY8SXwoNDqHAuY2QkI9/xs?=
 =?us-ascii?Q?zPhu0Y36jL2G8BQtWi9MOPvdbMdgEut0M745/z98KuNuarATXPtvLNl5rMA8?=
 =?us-ascii?Q?+uS51dAC84IjlrlVcwMFvGsHlVMWoAg8xmUZ7DcO/VZlPJQVqB04plWdX6pE?=
 =?us-ascii?Q?hvTEEUs8+qENTVYRJa+P4giLXwjDlICCiOSjBMpt6X8j6gIOawDoas4Q5r3F?=
 =?us-ascii?Q?X4hM7AH4QM/t//qTXEw/GbG58lLsfWZMxrm+D5MtoDsuTmTZUa9r6+nKrwAr?=
 =?us-ascii?Q?48LfEMy69pju94V2BowTcXJeSn7+LgDrrc1OmzpTv6v0ra6aYB6np+CZdkcK?=
 =?us-ascii?Q?2bs2HpwpA5RDtZ5b7t4vdNQCk5C/NxXylCrJ+NyhO3nbbyjsUmiy3HXiIAB9?=
 =?us-ascii?Q?ep9p7TIDrRw7F1DYABFEQJqQQRK+y78+++UlmgJ3o7SvrPSXeaEASSmzImwK?=
 =?us-ascii?Q?9hdTc1InWKWpB4Kkw5c379qNW+yYAoqPGQJxeSqRnlh0Wn3yQp3x6WSSKyea?=
 =?us-ascii?Q?sQBhJZANgqpqQTV9hMYUlBTS4xADUrqnta3FpDPQeTbUttaq+1JZ7aeeeSJ+?=
 =?us-ascii?Q?YOF14566+1UxbFjwMexybG4QU7oplKz8idhuzh8/XmYR2rQgkFIqDy+q4K65?=
 =?us-ascii?Q?EpS9HKLxZuGtKE7uMO/e/xrPHVrbc2njLs+jA8K8fjqAb8BTvJyitZh/No9A?=
 =?us-ascii?Q?ahclajzncsQ+hGMBxeudICuQbAr+Z1ED4wl2XZLDe1dUTPUOfRCqSZumKui+?=
 =?us-ascii?Q?0qFxDThpZbxk7usdLWeTsITz4r378XlfL+2v2rscfM9hNkw2cAcCcs/vE4P8?=
 =?us-ascii?Q?p9jbcKEHxV/BQd+7KmuFCLrXs8nzmJh7JR9juClXGAJnDByerzXwdR84E6gc?=
 =?us-ascii?Q?kGv7gfrqyI50nXPH8/xHZ7woy4tV2bs90+zds6SNh83Db9CudDemY3qeVms5?=
 =?us-ascii?Q?yDP8//0rxHh4bCGVXCSjXrIzyKOOzhJshEsrqR6jHgp4w6bqdW7R3nmy8wSf?=
 =?us-ascii?Q?4ad8RS4vA6MUhMWKmzCjJ2pE1fRJh0+l6nk7jAMqbe2fClyN44cP6MI0nKsM?=
 =?us-ascii?Q?R7SiVLD2vFE7PkJwByhf++NCoNnhXpDFT0RlxPDh6P87Ht+y8GLGrWP9kS4a?=
 =?us-ascii?Q?UjcfxoRN1vV5SnArVQyucO7p2DUFMQjvF+7XDklY0asn00b6e+/PFPYFxJqM?=
 =?us-ascii?Q?u+T4C//cJ/2ra2i5Y5LM+VxuXNQB4U4ETuB3p5catnm9SxbS4/N9gMxKe8pf?=
 =?us-ascii?Q?kfaGw2I3v2WoVKI=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 04:30:21.5987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25294ff2-5a06-45e6-933e-08dd459dcd83
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2096
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

Add bootph-all properties to I2C0 nodes to ensure the bus and EEPROM
are accessible across all stages. This enables reading the SoM
configuration at any point during the boot process.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Daniel Schultz <d.schultz@phytec.de>
---
v2: Add Tested-by from Daniel
---
 arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
index 8f3c3a185ae..c68a48678a2 100644
--- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
@@ -72,6 +72,14 @@
 	bootph-all;
 };
 
+&main_i2c0 {
+	bootph-all;
+};
+
+&main_i2c0_pins_default {
+	bootph-all;
+};
+
 &main_mmc1_pins_default {
 	bootph-all;
 };
-- 
2.34.1

