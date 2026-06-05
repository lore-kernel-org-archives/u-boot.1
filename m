Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AA9CD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 19:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA67B849E0;
	Fri,  5 Jun 2026 21:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Efbo0sFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1028849E0; Fri,  5 Jun 2026 21:38:38 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E505849D9
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 21:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbMu/Ar0RN3u7wFucOedaoop0TUPmIFmTsOyy3IvTcv9RuCYI9GI57zTZReUuG5AcsG6oTpbrqxUb4pv4jplHRkQ1v/r+3W/IfRQLwN4gnCnNbOieRjFN7ILjDTkdmds0Q8VyE2xYMlXoBxkKimY1nH1iQxuOvaWmqjLFY7MYvEzOWfUmQLG+F8PoPb800WH9EixfobXoWhrxGFOUnyZU8STkbkCH93HcST2p4qzi2h0aoAFtIkP/IzEU9KvmUmBuU4NiBknXrdA1TT6NDzA5eYVVcatKDv3aqCu6I0adCfr+ghBUPcw7X6/+Y6RxP+sflgcUrE+0eDE0uAw4uFWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC7aJdqSGef/tApoET9dltZkSI8ljdm3c1Uijhw19LA=;
 b=GHHSThsqH/zMWVdQnJ/GP0X6rUQreYQxZyFnoS31flWtJJFbS9o29XLJ6BVy236NU5pIovvnkhxsxN2EJVKz06Qhyc1yIhBLYb2NnyW4YaXvg7Mg+Wxclulm02PRDcWdqWGOf20PpVghDcXzjOnyp7AhD9utPmXbfy5b0DxH4O9tbkKcAqrU4gd33rAaSe5IOww0uKLy8WgQJ3Smq8Ru/6MTfFsd4eWTBPkPzJPaObAl9gUlYeDLHLjBKoRK5EPSMYBA9rAgdHoOJ3bNqJggS/BBDB9Kdz531GBNEIAXRGUjqsHLsWtjltKoVL5oN2+/3GXhCtcMII0+n92/es/50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC7aJdqSGef/tApoET9dltZkSI8ljdm3c1Uijhw19LA=;
 b=Efbo0sFkOj3EgZrYLuOcYwGdANi2dmyyEWDpj2efqIFk/QRZT7xqQC1RtgzCC6iC0eO9t1OekdUioZHtKqEA7KQbR4sRlInyRZ1M7KyO9h18xrUFeFTTb84UwbiyGm2Z2i64lap4tVFr7fkOZcr53Wp7Bj9tfDod2kv/9zhkCOA=
Received: from BLAPR03CA0131.namprd03.prod.outlook.com (2603:10b6:208:32e::16)
 by IA1PR10MB6855.namprd10.prod.outlook.com (2603:10b6:208:424::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 19:38:31 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::b) by BLAPR03CA0131.outlook.office365.com
 (2603:10b6:208:32e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 19:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 19:38:31 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 14:38:29 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 14:38:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 5 Jun 2026 14:38:29 -0500
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 655JcT392005785;
 Fri, 5 Jun 2026 14:38:29 -0500
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>
CC: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 2/2] arm: dts: k3-am642-evm/sk: enable MAIN UART1 for SYSFW
 logs
Date: Fri, 5 Jun 2026 14:38:29 -0500
Message-ID: <20260605193829.395161-3-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605193829.395161-1-vishalm@ti.com>
References: <20260605193829.395161-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|IA1PR10MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: d10c7d46-9aef-472b-ac35-08dec33a063e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: Qmfooz1wY8NR6dk1Ak0O3jDgdT9KbJh4sRevMQVlyG5O3mHLwWoCtRTYXSCR7Q+dAiX2D+Fn7B9BuEDYxJkUfjqy/GPtE5FcpxoPDFjS+Ni+28tRt0URmJn7G/FZgCgwTRuV+orM0XKoWnu2EcmVZYgAgsgWg5vSBdBemqUr8sJHvPsV8d4WiGrCh2BDCQ60u28RNYjR6/jZUs45Z+4kizsuQf2OcIPeS8MNaBdLPPSk4R2FhiWqfn4eKl+JKhWrGBZfiIT7PDD1lV5yqGxc/zTM+z2czcKp5I+Ev5uu1CCkiByeZC/UPWZ2DDCZDQbtF/muaGvUDIORVKCO2alu0XzXw5Lxnn5siE04q2ZlkhHaGTpKJ9w5+QEfMjUBW3NPcb6IKiqAlZu30vEILoky1Xp930ISN7Vv9erV+d1tzWJMYW0b+xUR6jar6V5MQzsxGjLQ+qhjuJ8mm1w/nFajmqGaFcQdIFmDpBEYWygAGYIJjwsQ4rmtWVjHNCtA0WGEumn7z0d7XAYLacjqLIF0ehmdB6v+Oax0cGEXBV/FFYxF8mD8vt5VNPDFmcffmDwlDoBtem/hwnA9kx/OBXlNVVFOZuGKtwa7z43/axB55dR7ovttoUbUCfXnhNk1HzDZqjqBUKB0AJ/kA2XaojPR5hlJ67+4B2vU/MhQ1UPbNQ1GzOKNGWVfvPA8laOm+f2k9pC5/dCyK5L9UQadWkeLVrAqhy3Yb69uI000VHNRCsQ=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: if9EkUGgEu3XTVqgu/AHPiVslzLb/8x9O2xBQcKFgLdUEwGk7SEY2zxZBW3jtRLVEjcDQYeIBflEMTJ7OvBVLFhs2wUABpH5Tl1QC2jb4fuahOa7G4LXiFaq5+sWq7nQGhjV0Sj8e6vv9DcE1RfdEQrBz9xR9k0DCxJZ2BHsu6sG2CPnlW3KVnbxh5XpkTmZRZbTHxP6cinkTcGJrWaYzIQ+LnlTTs2PsSTsNAAPfs5ldEeENisBwPyism6sIuM4AKqPjrpZrRfqK43eg3o3dqxxRQoc/SEdw5GTzEGv/cyo7IbT16NX/OnN6FUG+Gex99ohlnMZ+IAsIAIBd/oPKzKdj9ax56x8vMKE71I1pzsax0wxdYvZQTFrz6SYMWfqLq+iiD7VtN/LAec8X1Gp8ylZWMuUMEwj7IAEU3BLvx+gVK5Slbf8ARXasv26mbGx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:38:31.2311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10c7d46-9aef-472b-ac35-08dec33a063e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6855
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

Enable MAIN UART1 in the R5 SPL device tree to collect system SYSFW
debug traces during early boot.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 arch/arm/dts/k3-am642-r5-evm.dts | 10 ++++++++++
 arch/arm/dts/k3-am642-r5-sk.dts  | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index e3d363a8e39..d1fe7efd006 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -23,3 +23,13 @@
 	clocks = <&clk_200mhz>;
 	clock-names = "clk_xin";
 };
+
+&main_uart1_pins_default {
+	bootph-pre-ram;
+};
+
+/* Main UART1 is used for TIFS firmware logs */
+&main_uart1 {
+	bootph-pre-ram;
+	status="okay";
+};
diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
index 27f3e87fb90..19435cd1f5c 100644
--- a/arch/arm/dts/k3-am642-r5-sk.dts
+++ b/arch/arm/dts/k3-am642-r5-sk.dts
@@ -18,3 +18,13 @@
 &serdes_wiz0 {
 	status = "okay";
 };
+
+&main_uart1_pins_default {
+	bootph-pre-ram;
+};
+
+/* Main UART1 is used for TIFS firmware logs */
+&main_uart1 {
+	bootph-pre-ram;
+	status="okay";
+};
-- 
2.34.1

