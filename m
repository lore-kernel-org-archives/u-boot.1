Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B0FC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 09:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB32B82D88;
	Wed, 23 Jul 2025 11:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLdcaKKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFB882E34; Wed, 23 Jul 2025 11:07:06 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E5D82D21
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 11:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1p99ZjnoYdB7U6l4cndZG/5/uba97egmz0Px9Go33zKBLKXvSrTPvSZcYxxTHiha8WZdzRdH8mrMkcZ+VMeidoJjty5GXwpMmK7GtJ+HJt49c4iKPGj0Nl8tzhKACKM94Rt6wjC+KJ1JQGWkEes/v69/ikfYSELVDWVTji3xCF6CavPhfQ+OZHWlbKeY6LDohB3ko81j8313TlRSxD9IQ7iHBDYxFe6XxNOQ4TotHNDVYSADY3/5z+gNMXsN3/46eEz1qQAUL7aQQd/N7zECa4DhmcX08GbZOC2zh4rsCl34iN3Y6ApEGKSAW/rHjlun6OpzF70gZtpUx4yFne4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmPG7ff3gzYZGHcfUy7UPm3J1BJTCx6RNUdTSlqQBnM=;
 b=c8NW7iixS3S6ptyP+FPJoJ+sw5qLeyDfiHAxESK5NFu2vvYeC56HzKo05SaW8/7AzykkTm6q0ocfBG3APLx5+HlpaAmKMpB0wUTFKvnHUy8EkXe1BgQ9bRYPSingfnfxLWi4zCFBYR407LYCB8RbBFmZwdErN4epY3/S9K9pGssLloEZ9bhsDXJ7qWeCXnDZ5WIl5ffsANVmEhbqwtI/k91G8f/udyjNjBnKMo3lA7zBZD0GvQGjXGoEpyTO7MhZ+jgcKdRpTw3NMiNxPxv2HeRPrby7XHonCo+J4RVAkTKQ0eg64ZUCDcKOK1mDsnF1NfgJbzxDsIGYzlxuTp3xFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmPG7ff3gzYZGHcfUy7UPm3J1BJTCx6RNUdTSlqQBnM=;
 b=jLdcaKKqaFnAj9WuGi+Wc6TaVJExIU9Jcw8QxBsIoPcuHGICzppYZ3GkLXyOaePGi/wQgar4tGKUQMRdap1MTJirxhQpZgDzheDpznI2s3txUpmr/lDhpVWS/jbTpshhq+HNS2Cxxz653VoCwzBYxBM98kgJHSHuQAKylHIHlP8=
Received: from CH0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:610:77::34)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 09:06:59 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:610:77:cafe::eb) by CH0PR04CA0059.outlook.office365.com
 (2603:10b6:610:77::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 09:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 09:06:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 04:06:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 04:06:54 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Jul 2025 04:06:54 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] serial: uartlite: Use private data instead of platform
Date: Wed, 23 Jul 2025 11:06:46 +0200
Message-ID: <8d32af596f80a2220d9f5d7fb98476e6d2b5f303.1753261604.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2879; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4eB9+KjlmlkspQVPkSet5irZSAbSVNE75qttW3EfacI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0LFM/qjFzaQPXl5trVr289cO52eRF0Iky2emNby9wH
 t/Vuz65saOUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAm0i3JyDC5JpCt1eUZEzM/
 08cDhmGXRf3erljh8fK+9vpNct8WLr3AyNDi/sSpcvMs1WseFSfC092sytd/M5645OC7zVzp1hK
 nLvIBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8156b4ac-4735-4709-5bbd-08ddc9c847e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cOtQQhUr65fl0SiFdv4NN1Nvfq8Y8WJjjmtYKWt32fty5qgtfys2UHWIh08B?=
 =?us-ascii?Q?7apa1R61LKD2RafuPEwvAQhs78y6fQ/gxrylYiSyVKuAVluzZ9zWaDPNAvVe?=
 =?us-ascii?Q?4NsOAqswj2Tbrir69bEhOZeIcUeFCwaputGCcU2k0KHnVGv6Qgl1EBSzXJF1?=
 =?us-ascii?Q?sLWOr5Gtp1ZpnaV2yRPpH4UcBveA9oUTwHALMER5fH1MHuW3ro/OA65HnCLR?=
 =?us-ascii?Q?BlFGXIaOy9hC3btEz4Sj1YpsadyQV5ebCr4LAB0zcSE2YunOSTBQTIQL6TDG?=
 =?us-ascii?Q?yp3vUUVolbZZKhpCSllRY1E6MUEJjlW7VHJhIycdz1tAyns235hUrnn6r+G0?=
 =?us-ascii?Q?XD5NwntX9fEr6WulnwnfRH2DWUxLJJ+sjJejcJOGaPo3BUHLk6lzRwyb4POY?=
 =?us-ascii?Q?gVo1Et6Od3Dl/iMgQ8+9lJ+aVILvkxzNdP7g6GNaW+lHYsEV6yCitTkPp2ba?=
 =?us-ascii?Q?MtYFL3k06pitKXAXWpQnfD+0Vp0Wm2WFbc4Ldpj7VhhgNz1ZCdmYVZgi27jm?=
 =?us-ascii?Q?7VtKbRsa92A9FJhQwIAb94y2VN1c3mbFVeExTsIl7jmr2ZZFAuoaafZMD8zc?=
 =?us-ascii?Q?IXfrM1BawUDcPTo5JE1Od3STAPATMuZyuOzW6ymMd7Ax+ntGsQw8DSs0GbUw?=
 =?us-ascii?Q?vqPdUPNwnx2w/In0O+sfYzTcR9aXIuuTdIqWjrOd460Df8F9UczkhAOOw+JZ?=
 =?us-ascii?Q?LuSaYbC4EiXBCNp7a+hfH7tqaJjq6e3TjQb0HZRmrf+rioGnAFM5ABa+3jRW?=
 =?us-ascii?Q?B1FQPRPBX8/g7pUYJC1qWbYfAFUdwHdu/Y6X7LgF/85eqR5mJv2KL7zZ5v8Q?=
 =?us-ascii?Q?8eQ9hThEwJkl09IPwd3lutfryGbilqu/mVyxU5DryG3pFl6l1Cxb03U4wkq/?=
 =?us-ascii?Q?kHmwMNQpWQeCdHXMbD0OxyCojMY+pGAmK+h6Du2CgHi0TUDipKPpBbpOiVcg?=
 =?us-ascii?Q?RktbDlCJqMXOmku3Tqg1zb44aWKcPKvAw+r3gJeXSYqEeUkkEcazyU2oYPN/?=
 =?us-ascii?Q?XSuww3wEo+xH1PcKkl+nbEb6I4oXvy4DldIDOZQCGtf5NvOMnw3aoUPkxIaK?=
 =?us-ascii?Q?zE8cxV9YWEg2HSJJZuPn3ePSxK+qF/EsBeYmhtOo9uZOsUywEm3o6X/m8ZF8?=
 =?us-ascii?Q?K68zsLt3GYfpid3nyxcIY2nXVrbdQoYrhQKXDv5xU61jyvXwelsgqDDwP5w1?=
 =?us-ascii?Q?4n6GzQ66KYNWfh5nfK7Yp61DeZUjnUl+NDkMfdnV7CyNHbOinGd0mzZhEhjO?=
 =?us-ascii?Q?qpS3Df+SDSAh88t/XYkO+HusFkpBBqsLECPLZktAcTNKHokXSXc63A7nnu4H?=
 =?us-ascii?Q?IlGRkqUZeYq/awBtZwAKoIhwH4CgbHOCPh3Uk2ixNIrMKYp2heUTEcDKsTdl?=
 =?us-ascii?Q?R8F417KhKbP9aqNDvJUJGy2Bw0hh0mlEb5Cfr1Aj8dGuD4E2F3NIrudYEozD?=
 =?us-ascii?Q?Ztbve/XpWuUk8+uK0bOzPZO74KBODCJQJuKL5XHlcbnM5UB2lTyX4wcd/BQA?=
 =?us-ascii?Q?QORUT6D0PEzQiuDKa3qzZ7ATE4AMz8MCAcbX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 09:06:59.2719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8156b4ac-4735-4709-5bbd-08ddc9c847e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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

plat data should be used only in probe or of_to_plat to fill it information
from DT. Then in probe platform data should be stored in private structure
which should be used by the other driver functions.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/serial/serial_xuartlite.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/serial_xuartlite.c b/drivers/serial/serial_xuartlite.c
index eb234108746d..00155aba5eb2 100644
--- a/drivers/serial/serial_xuartlite.c
+++ b/drivers/serial/serial_xuartlite.c
@@ -35,6 +35,10 @@ struct uartlite_plat {
 	struct uartlite *regs;
 };
 
+struct uartlite_priv {
+	struct uartlite *regs;
+};
+
 static u32 uart_in32(void __iomem *addr)
 {
 	if (little_endian)
@@ -53,8 +57,8 @@ static void uart_out32(void __iomem *addr, u32 val)
 
 static int uartlite_serial_putc(struct udevice *dev, const char ch)
 {
-	struct uartlite_plat *plat = dev_get_plat(dev);
-	struct uartlite *regs = plat->regs;
+	struct uartlite_priv *priv = dev_get_priv(dev);
+	struct uartlite *regs = priv->regs;
 
 	if (uart_in32(&regs->status) & SR_TX_FIFO_FULL)
 		return -EAGAIN;
@@ -66,8 +70,8 @@ static int uartlite_serial_putc(struct udevice *dev, const char ch)
 
 static int uartlite_serial_getc(struct udevice *dev)
 {
-	struct uartlite_plat *plat = dev_get_plat(dev);
-	struct uartlite *regs = plat->regs;
+	struct uartlite_priv *priv = dev_get_priv(dev);
+	struct uartlite *regs = priv->regs;
 
 	if (!(uart_in32(&regs->status) & SR_RX_FIFO_VALID_DATA))
 		return -EAGAIN;
@@ -77,8 +81,8 @@ static int uartlite_serial_getc(struct udevice *dev)
 
 static int uartlite_serial_pending(struct udevice *dev, bool input)
 {
-	struct uartlite_plat *plat = dev_get_plat(dev);
-	struct uartlite *regs = plat->regs;
+	struct uartlite_priv *priv = dev_get_priv(dev);
+	struct uartlite *regs = priv->regs;
 
 	if (input)
 		return uart_in32(&regs->status) & SR_RX_FIFO_VALID_DATA;
@@ -89,9 +93,12 @@ static int uartlite_serial_pending(struct udevice *dev, bool input)
 static int uartlite_serial_probe(struct udevice *dev)
 {
 	struct uartlite_plat *plat = dev_get_plat(dev);
+	struct uartlite_priv *priv = dev_get_priv(dev);
 	struct uartlite *regs = plat->regs;
 	int ret;
 
+	priv->regs = regs;
+
 	uart_out32(&regs->control, 0);
 	uart_out32(&regs->control, ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
 	ret = uart_in32(&regs->status);
@@ -131,6 +138,7 @@ U_BOOT_DRIVER(serial_uartlite) = {
 	.id	= UCLASS_SERIAL,
 	.of_match = uartlite_serial_ids,
 	.of_to_plat = uartlite_serial_of_to_plat,
+	.priv_auto	= sizeof(struct uartlite_priv),
 	.plat_auto	= sizeof(struct uartlite_plat),
 	.probe = uartlite_serial_probe,
 	.ops	= &uartlite_serial_ops,
-- 
2.43.0

base-commit: 877984a9b68bac862cca6f2d8885947a48e6fd50
