Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27483C9EC88
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D6D683AAE;
	Mon, 12 Jan 2026 14:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hOvpDA2M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC6183D52; Mon, 12 Jan 2026 10:38:29 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B0083CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH8jzGEsRCt6x2h6WXvVQTv4mmUHgwgL0I4jtycnulg+29Z4ZwWjZOnBU8B7Q3V4XtWM6OOhxNyIU7EFHr/0ooSpRzwiGItsjBMYXgdMng8fFHtlcMIFVcv6cJy+VEADtmqPmSVr8fDVlEb+UdINpfMa4wZ/XU5suyrl7ReaowRKallViFiDgJWNMUT9JW9T8V6bltHwv5DRRJAjBPwpIf6j6kyN3kCdtFk0+HQeQeZZPtc7yIila/pwL5ekkLHry8NTurXOzCi2kqDoS5OI27rg0yz1hGy5vvIgN/r2kkaTj70Ap2/DTsRfcXpwYc+wHT9BgHH/at0hh3FKzZtapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIJEhV/SO6C2IVseJhdy7QWuvzqZnHxfiKIoGeKrZuA=;
 b=YJ+ePI1l6GC73AvRCwNeX7GnZTh0slAZLANQj5zzvjDx/fUpOlh58hKaeWY4rNbZyizDy2SyGp/MGvSqUoGvoymlu5zBb2EFLdi/iIzU7ybsio73ugvc3qwQTbLlJiZmkUm7vhl6PRgwQoSgA5UqH6k6vme5TIJMsGXfMEUcQE0hJX29XOrJZyZ/rshS420wpjBzEg3fFmt6I5Yg0kYzA7sAq5HXhj11MuGB3umk2iz1SzD3b2Y255XP28nmQz0K7bjI1lU46Jb3MnlaqHmI5H1iar2MdD4amwfjm6/RES7yJe6X1f5bvX1KlpjlA0ZcPC7x/Gq8DnNQzZICgry1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIJEhV/SO6C2IVseJhdy7QWuvzqZnHxfiKIoGeKrZuA=;
 b=hOvpDA2MjDagr/b27irZEJtKeoVBP5uqT2/VyD3a68OsJKu7lKdIoWSyJ5DmVdeclHKwny8Z17UPO2byDaT4mXhpTBxSllJ+mmVECnDhqsfMHPHxPI02boM0O49WJwnVKRZke36DBcMKayerpiz0i8liRTC2L7a3aYX5y0/mhOw=
Received: from SA1P222CA0144.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::22)
 by DS0PR10MB6823.namprd10.prod.outlook.com (2603:10b6:8:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:38:23 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::bc) by SA1P222CA0144.outlook.office365.com
 (2603:10b6:806:3c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 09:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:38:21 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:20 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 03:38:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 03:38:20 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C9cHnM278554;
 Mon, 12 Jan 2026 03:38:19 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH 1/5] arm: dts: k3-binman: Use configs for ATF/OPTEE addresses
Date: Mon, 12 Jan 2026 15:06:39 +0530
Message-ID: <20260112093643.885903-2-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112093643.885903-1-s-joshi@ti.com>
References: <20260112093643.885903-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS0PR10MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: ff98cd66-5c2b-4b85-3814-08de51be5324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XDH9k1Lyd+kd54oB7jiKU/6NfN+EwBvu9tF42m/9sK6a93b7Hs0eBcIvs6wb?=
 =?us-ascii?Q?rpHQBMa8pHI3N7+A0VA/UYl2IEf887GKBLofOYKfFuw+evhJKrRUOrqu3P/c?=
 =?us-ascii?Q?oQjY5mc5iIvTL6veUXu9XF49lTs7FG6mcB+9GIWaXdUvjYk6bdREvSu6UTmA?=
 =?us-ascii?Q?7MKPRv9Bhhx2NY7MG7Kddl/QVWTqQBIA3Vq2Gz+CiKZllvNyq+vaF25Pe0C5?=
 =?us-ascii?Q?URHjcgAWK4/V1ROIbD32Zt0+NJbEniKMbdm33dIuIh2RiR6QV6nGsonbSewE?=
 =?us-ascii?Q?KWaeuk2cBxGUsLqxdLmfW5ZrF+q1gyeV1gOMwqXYeA5pDN4Ihf2kMW4TgEBr?=
 =?us-ascii?Q?3laAEFnDiJc0iT72yfcyev6AfPJumONwN6bWg50OjPaokTfkHIV6wSrs/u8p?=
 =?us-ascii?Q?YtiE01CIN49syHH9uvUnFaiWZR6jWEpUF0bR3z0seXIAoWJl7U8BHoNcLjis?=
 =?us-ascii?Q?z7FTz8yla2QoYInIcaMsu9xizZekLvBLl7Hbkow9LBGrEekLNwrTffCMUIsO?=
 =?us-ascii?Q?Gfmx5gIN+sD6qZS9IgFPfHjOpCTeRD3DWVApRK9I136uiUBSw0No/Way7g6T?=
 =?us-ascii?Q?LElF/LUZVrzn0LvvoFNX4dNNz7sbyBrNSBSxUyIsdlLlVaSYbYHtNEgiQvSf?=
 =?us-ascii?Q?wOtYo1y1Rjfm+CenigvRUZpT7K6ksyjZDeB0BmVGO8+MX1I73fQTgCOOHwXx?=
 =?us-ascii?Q?0d7HhKMRGpYnZtDC1HjtYoh4ZIrnvQdODxCVyzAInOg5LOCMBjmDbhBZHCpQ?=
 =?us-ascii?Q?hPEtNp0BuzZ1lsEriAjKObKEi9podsmMju9LOD0xhOWvujIGacNF8KTkFoRl?=
 =?us-ascii?Q?cGCANPBCdvuOUpYjcasgRlhbQJk1bzRQ4pGG4qegJEMM+YeX4jYid8+rnQLk?=
 =?us-ascii?Q?vSxX9mneXq4vPgUXfMv69w/UK6hd8EZHvCNqDBg7WshNaZCxCZz3t1oItKhT?=
 =?us-ascii?Q?AnCKTHCt98Eok6FjCTiyol8SKKUV5/bPEBWUsHYXb7po8at/dA+AKoY8EeAu?=
 =?us-ascii?Q?KMyF24Ltj4aNzSpOq+yVF5EZZxsrH9l7mhn+lc/2th+sF0g2ikex7HA2uaSt?=
 =?us-ascii?Q?IO8VjQZPCawzMgjBW+OBTm8cs9GeDmxpkYlT6Emlb8dnuGGTTs0m4fwI+sx2?=
 =?us-ascii?Q?VLl2M7JoKOV/PB9RI5l2OVjJwakSPrd06fQ9IJTipQDvWhcFAyXonuTB6ErI?=
 =?us-ascii?Q?j9+KvoM6RvUtQ9YX9hcpA0Fe8OhiiszlOrEMgLi2zF7Zi4tY/ljx8oz0DV0n?=
 =?us-ascii?Q?Yeho8AlEgPmf2DUWap/QNGhJOH+isPqAz0q7Ti2bRFs9ttng3Eu6S7KtuLsU?=
 =?us-ascii?Q?iMlfCnaqrlZleFewJQqRQdWqPSFgkutxW+FjjWut1G/muHCOBvHYZEHfzD1L?=
 =?us-ascii?Q?16M7/iB3CgGkOfZHdRZiAbMy6NnFZwK4RbQ0xU0pT0CgC6q4B7oL5Ie+t2XI?=
 =?us-ascii?Q?mW3AcXI/0Kx9G5lR7aYOzpbIGh1ezHZjd+llwSgegVnj0WGtOSu6xCozzw2a?=
 =?us-ascii?Q?5E95v71EjAWd7nvE0ZYKL0gnmzDAbo61NG/hLHjBLek3zkv9m0PSuELKy7RE?=
 =?us-ascii?Q?9bj16zotcdZMliPV4j4=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:38:21.2913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff98cd66-5c2b-4b85-3814-08de51be5324
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6823
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

Instead of hard-coding ATF and OPTEE addresses in firewall configuration
templates, use K3_*_LOAD_ADDR. Doing so ensures that if someone moves
ATF/OPTEE regions, the change gets picked up by binman without
explicitly having to modify dts files.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-binman.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 761b1730464..0fd93f9536a 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -476,8 +476,8 @@
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
 						FWPERM_SECURE_USER_RWCD)>;
-		start_address = <0x0 0x70000000>;
-		end_address = <0x0 0x7001ffff>;
+		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
+		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
 	};
 	firewall_armv8_optee_fg: template-8 {
 		control = <(FWCTRL_EN | FWCTRL_LOCK |
@@ -485,8 +485,8 @@
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
 						FWPERM_SECURE_USER_RWCD)>;
-		start_address = <0x0 0x9e800000>;
-		end_address = <0x0 0x9fffffff>;
+		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
+		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
 	};
 
 	ti_falcon_template: template-9 {
-- 
2.34.1

