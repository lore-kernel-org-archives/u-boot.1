Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ECDFCE066
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37F483EA6;
	Thu, 26 Feb 2026 13:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cVknAGgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF4D383E8E; Thu, 26 Feb 2026 13:25:20 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F050C83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNXk4Ne0+gECV7fHazyQ4sHLLD5Jc7NBob61bE6YIUPXKMuJXsLjHRdn/ceHOFt3LZ1igh7qxAQKC4/yNaSOQiaVqAYGVIZhbpAAi8AX39Db2dSZEUnlGgWly/95ZBaNEK8k1qlonbmjzX3KWQyutWd0Rw8ugjwCpodK6bmMyrVD2f6HL9z+cpdO/SFZVZq/gOyuaL6EZWCAo4CxUUScCoFvzGnWwl/c5OsONiLgUcNPJ9X6O5aJP/gRrUAyH8ET68odIuOkcSLF8DFF/FWohGep6bWeI4oxeHdXCRcSEXFwsFQwPSQEq6gZJ6vr8jn6PFVofKTq+oIg1BlymAnHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEW7PtoAN7HJf9xlbwNf/Vts0454hJU0/SZxRL3TYEc=;
 b=Sp4DOzarrzJOvWzE8hJihlbDj3XXN8TDO+vE2VcMaDYGikj5xbIe7TWWuI3v6s6l7gY3ebXHopEAh5Ttm17H6HEPX6d0DVyWhjJ8VIDP9o9Pp4/OwB7VNyRQBiNFlqKUe991ZUHf//rbIbxlHcsSnGhBzj+EvnRUlPQkCmdRn7FM9bdY8B7BBH5qbYSIquR5hzmWV0yBgTltSaGjBBvX3lVk69oiy4z+pGpg7XPrxGurBPkAk1m1CQWclO/cEy40Ph608KXf4V22UdlBeZ57qstVsBr8rENG1nirg//DMsg6jQZGIzf2g0K1+vKMe/w0hS+LDOxs+W/JYpDTaONeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEW7PtoAN7HJf9xlbwNf/Vts0454hJU0/SZxRL3TYEc=;
 b=cVknAGgX6M9W9P6E8P2mMVKkslvZ5ycyYUnrTmeOvwF0UpaadLn9r+4O2xZPkivrELQUyFRXYroewueIYMTeGfTUorvQXc/gbMc9bDPNOQ4knimdS+zK1p1YIlfiQCELqTHWJ2HVpkKU7jMr8FRWIArmRX8sYYSWZ3YRnfZ0zGE=
Received: from SJ0PR13CA0151.namprd13.prod.outlook.com (2603:10b6:a03:2c7::6)
 by BL3PR10MB6139.namprd10.prod.outlook.com (2603:10b6:208:3ba::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 12:25:14 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::86) by SJ0PR13CA0151.outlook.office365.com
 (2603:10b6:a03:2c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 12:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 12:25:13 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:25:12 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:25:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 06:25:11 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QCP8Rc2348372;
 Thu, 26 Feb 2026 06:25:09 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>, <n-francis@ti.com>
Subject: [RESEND PATCH v2 0/2] k3_*: Add config fragments for inline ECC and
 BIST
Date: Thu, 26 Feb 2026 17:55:06 +0530
Message-ID: <20260226122508.2269682-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|BL3PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b542f0e-8b50-4687-4f08-08de7532176f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: oTqD0nNNZT4wTt9zF296iZOPME1YeewxvH39H2FzZPhYhOoAj/3A/RXN5E762yaSBBwmZNV5VE+QQfIPqpb4XLBFFeRtbJbT/D30bnv+FkIKHh7aBkGe0oUfRlS99miMi33ncKJXKwShLWo5cjfcBrpginitsWbnh5OKJWKtiuxjj4ZAQXI5TAwX52esGXkWxqvV6unFHqABJpkLQy3MkcxGtwmJiowmttGq3lm5Df6kkXi197JR0ZB2CJvI+gKK3Y8u7EOUXuPPbb71MY8sEF+ugwnCm37WRA6LqjL5wjr2Q1an3/P55ppXUXPkvupyw2Va90RZO60lZPaA6PkCJcLa+m15sctiaHDmfyXCeRA9Tn6zIR95HKpT3eTtORDilwHUYHcl6BNIGdzDfoBcIuS3gLXrFUf0ebBlhGVbZorGFscwzlyowGhAL5ND1CzGxMfYutdIgE0z4EdM1jehBFSWoVhk62EHzkTXAoBfxSIbDKGUjpK9iTn4DLEhFRn/A+sgZWkP+VF9qdwR48xvxRsxT5Y0L4ika1kO7mhRkkZ9UPf3AObk2w9c1BhuLSBEdL1nd5HHvzCH7pZfx3MMU+LLTlNOMx9d87M2tE4GepxQWyxv5eceS9AxbJX4CTbhIP6imX2FFjgInHXmxXP4BqQbZW3zwObwYJyN3l7Xtp2rLY9T48k/J4MDnbGTYjWNGhEexclhOOU2ZitOxrC7eKBLweQPcEAn6rf9llxCPvL3clvTe3YsldEAQKpGFphFyBLVzcKH6Uak3nKtnJMu0Ldo9/WkbjTTWTc/atSRUE0=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ctCo6wGCWmeKBNHuMpF2B77ebxMD0jfOlCAEhZmH/eHBglQ3JDTkhFxvVFLQB9OBycVt5sGAJVLrvTxfF7a6y3STL1+Rh2kBGvEtYeSouyZDqrrJspBTbok1m8ilY2y5EIidsFi57jEb3Dj1tkG2H+xAKKdVmbz0us0W6TYv2tL30V8351CmTMmfTJaQTBsxmTrqc2sQin10ASfyuMYeow9BwRA5AfevFmiNV6zv/OE6iP0IoUkAKV6P61fbqBt7dVC469pX5E3HEiqbGUpaJMooUwvPIkjk4uuPobAZrsQS82uVDfO9RrGhiEDooOmA4eQRPM6nZX3ggzQvyBXCvfc6tj+5V/oG0iCwDS1+eZ2M9pC3wFoyDteysNNqabNNJUUEukJxkmEy3cdGid6gznPgtoyj1Aae6LOJuyypBBW0YrO6Crcj7TCiUVf+tLF7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:25:13.3854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b542f0e-8b50-4687-4f08-08de7532176f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6139
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

Typically we do not enable these configs by default but would still like to
have the option to start building them in our default build flow for
testing. Also there is the added advantage of users being able to see what
is needed in case they choose to enable these features.

Changes since v1:
https://lore.kernel.org/u-boot/20260220091532.3584771-1-n-francis@ti.com/
- move fragments to board/ti/common (Tom)
- add doc patch (Tom)

Neha Malcom Francis (2):
  configs: k3_*: Add config fragments for enabling inline ECC and/or
    BIST
  doc: board: ti: Add support for config fragment builds

 board/ti/common/k3_bist.config       |  1 +
 board/ti/common/k3_inline_ecc.config |  1 +
 doc/board/ti/k3.rst                  | 66 ++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 board/ti/common/k3_bist.config
 create mode 100644 board/ti/common/k3_inline_ecc.config

-- 
2.34.1

