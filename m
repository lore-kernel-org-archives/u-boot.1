Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDBBFF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEDD8460E;
	Tue, 28 Apr 2026 10:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hr0pJuSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C32845E2; Tue, 28 Apr 2026 10:46:42 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B57183693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dye6WP2PEsklAb7XsI7jP0w1AV64/iLhX/TO+7zsdnxqqlDVcEKHBzpN8NwzxRJTVAnU0uWPg3OUTiCfknvixo6ESXnUSIqEebx1xGuN8qQf+eS3WBTSAk/TUs2921QrcCOvH3OykYZ6dgUdHZCA7URoKbKOXv3ffmh5lWDwxqm4Y1rwMVfpQL4FFlEDpefDj9DMW3tBQIfLzLSbpPx5ylctMbaGzlRGcQxfGHl83bZpt7TEp3nnuKBd/ok3WL+KjcCkz4D/cFIFADZfghl117g0ossl7KjM/nJIUGXVDV5fyW1tdUywK27BPQQeeE1pQLS/RzOA6KqYHbt23IS5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ynUW0JrGvAlVsrkCTjrUMXdE3SYx7sRhcafvhB8A1M=;
 b=pqA/U5gll2zCITEaxem8vDMg7lAFo2YrEy+Yf+1n6jdy5JICjxHgDC7F1Ix6aaKMvhJRhIDU688PTk3vQkZYxe0cq//cYCHQFi+E3t0B5OW2GzctrZeTQ8XM1/KyqoTWLlWAV3OqMf+XAKOVmDU6BKxglcK55W/9oc0xHVaN4WBiYw00TYXYnnODTiJPKPI2mOlMnH+i8qxd/9KGkYmp7+oqaD0OQwzizGZ9fP22Vj7HVAwSqc3b/6LKuxQT20WE7JMsursX8d+9o2gZ7p/v7UKMxakGreCrpum/a6BpEx8x+bOxUJ8UyEzsb3OuQXBZHW0qG2QXCQZkvpsn6Q6SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ynUW0JrGvAlVsrkCTjrUMXdE3SYx7sRhcafvhB8A1M=;
 b=Hr0pJuSwVnnMT8FHk/7vJB/Wl1hCIiR/oyYuM+AGG9PO+9jQXTkfOTf3t/BzHe/ZklpxfyZLJOULQMxOX19b0T2SCMUXsMh80j/UWLFkpstBm9r8nzpx07iW78rLJJWN6P/RKg5TgpuQt5NX/GbQI26NSbIFHnOPfdVPxCEnqKg=
Received: from SJ0PR13CA0080.namprd13.prod.outlook.com (2603:10b6:a03:2c4::25)
 by CH5PR10MB997719.namprd10.prod.outlook.com (2603:10b6:610:2f0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:46:37 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::6a) by SJ0PR13CA0080.outlook.office365.com
 (2603:10b6:a03:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:46:36 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:46:35 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:46:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:46:34 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8kSTM615433;
 Tue, 28 Apr 2026 03:46:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 04/11] arm: mach-k3: Add config option for packaging
 HSM firmware
From: Neha Malcom Francis <n-francis@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <trini@konsulko.com>, <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>,
 <hnagalla@ti.com>, <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260425033742.1519298-5-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-5-b-padhi@ti.com>
Date: Tue, 28 Apr 2026 14:16:15 +0530
Message-ID: <177736597529.3159199.11987625630678065093.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777365988; l=471;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=e3Pg5i5GqZ4C5DIAPxLOuHpY2dX8Ltwsf3MfLBGpWt4=;
 b=+CnJw6Uc3b0xsUb2LKyxTV8EMPfMKZn9H48lkIXTP6PlDY0SqY8XatZeOeOyhS6/q/SCQ5GsL
 ntu3ADf1LglAo7p4WysqpnZDmCTmNwkfb86lU5N9N6PDqhda2wee+Ce
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CH5PR10MB997719:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3e4906-4456-4911-1b29-08dea502a878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: C2DGiS+JDyT9v1ZgWIUWTWluJ6AFqPdw+jqBmxEPo5Erwgzoy0R31sxLpgHfMV8EmuGzuVx2Ga/O6O1Cto2bHy5nS+3TVgGHHj2XQC/4IrNHp67Bf9hQGR5x5AoZX7dQlQ0NXyX3oV40bS9PEVKj5mfUm5qerbL8Wzq4dyXR7CRXRgSL2rUSuFba4sABCTlGLBM8pdCh7Nef1BhYvIko7aOAGytdXmsaJu+Dd0MqgMJbhjsWRA7PKW5QOqK2D1BXgmSA7muCWXZNnkM2BBG645/6omKsjHlUBqbPBmz2j2vpJkwW6HhEiHyBIV4LmLkDd9jAyrGDtBLUh+URofYXYeTLR2zkzn0g51B8o/whNM9xcS6qv6NDyGx365rtUf3T4uJLXNFNicm6Mwkp/A82VD2iqvgiEbsti0PpUxKBYYhzj0ky24iNJE3gOP1CGgXXhSYgkwkWQoC6+YU4oT2hb9hTB19x0RRfy35LKGw0AaBxlWGvAjilKS8Hg+zK2NEA/oLzmjPTIJDnl0kkpmKeFReIB+jtdKsmvyuGEblRQ8Kk7N9JNhHfNoFKEY5FlcKaEF8/wH30YAcZmKr+OvLhci/cI6YpQ7dF23kci4eQK7R6ZajDFYMCFpYEi9k32/9BWP2tvz0yRfarJlh6iyr/XjQhYQvrQ6iHNtjfCFiNMf/elY2yT4p4Md/IXPcrA0w9al5Uz8h6RrfleDDuiXPnpEj07Z4WIs3XuQ+5P2aoF9UKasuhFwAN8rtlrLAgAEpC/GbQSKrTRy/Ln/ZVpDpcKA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WiXWlvz5ML6+XSs2F3a/qdI0IZG2ArJQnem2GXzZXoIs3xLnKPSKdLNU+hUuRFfRFKBk3AhkKQN10DDEMI3MXzMnlNPji5Q7e32+EbjMmN6wGaF5RvWRD3E5l88YTrnUJc6Wb1nmA94E/I2Z9K4nbvWmar0FYRP8raqQNBTpIxe5gOdo/KN8tkR7ak+j2hM1Bp/qVDzypt2v3sSCOBpiMuIf2iWNS9p1atGYnf/XOw2Hbs5riKvosI14asn5eg12NYvDfR6zzBPIz7jnT52hWPym2D5z0z2H1uNbTbXAoa1UvgOPTrPc8tuH5qB8kpKx7kp74eSGLw/4MpqpjaV4DuMwXR5lATt+mpLHnw2L7LliaFy6jij7LgZOgtlyRSM2dbomaKHKOMx9CRozZyfHMkhssbT1xzfmJu0a7Ig1Ql2CFhTUG6QayAiQ4pnOet4g
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:46:36.6746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3e4906-4456-4911-1b29-08dea502a878
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997719
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

On Sat, 25 Apr 2026 09:07:35 +0530, Beleswar Padhi <b-padhi@ti.com> wrote:
> Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
> M4F core in the Wakeup Voltage Domain which could be used to run secure
> services like Authentication. Add a config option which indicates that
> the SoC has a HSM core and the firmware for the core is available.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
