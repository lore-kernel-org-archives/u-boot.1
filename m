Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C91FC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 21:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7810877F4;
	Mon,  4 Dec 2023 22:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D+JDhDZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB7286BD6; Mon,  4 Dec 2023 22:56:55 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3888759E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 22:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tanmay.shah@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMG/mA2tE4CnXG0itgp4ORvctjMrbbT4YS30LJvEFJSk8xk1Le5gPiGXT5ODwSd1eHfiqqVqeLyW+CEFqIaUdATbOw9NTrz6FdBDZHE+t7SwBY68qI6ewZbLPnQy0Pg87aS2FlXfkoJQoZyTsZ4RGAQxoVk8EbimvqgwczyWdnIIpLrGkIeTWiEIB8NeGI/FqcldxhOPoqu51qVfahy/zpCZTrze8IkgejZHGIrGzkQ4a+wjZfqYTDjJm90raPejt+Hc51J6y7/m9+O5ojYq5mzr+UCYZG8oKWBKsYKU2D2qzLKjrOD8d/PSlF/bX83kKUw5ITlmSfw7XCVQoqGVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq0aLYtTxl05p0y+zWF31yIry25P2tK6LaUyXBplb3w=;
 b=d/aIuiw0ytkHpJ6+qbVPNVXTNpcJqLvb3kO5gFT+2G95HTJzXDlbpdWkPoTXaDvWOApibL5ykbxJGlf9fPrGZxq9TGgeomllOWwRBjExUCW1CSge8jhMlpzpD06VmqCViWlnsAbyJNfQeo5fvk6GX8VTbxilXnyvl1hTq2GDFaFWxZs5yOUQzqrGfyPJtzw4num1LXvtuRhhBPJ1MHvDmAT0+W6V+Hzsn+pZmopmR+xtGoxTEks3fSeebAX7Sakk8fiZ0gps/rq302PN7STlZHPhmR9SaEQYEpGHDJTnu/hE/HyL6SonSDSQd0M2Lwct8Ax8XLLx/9JBWHYTNnQJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq0aLYtTxl05p0y+zWF31yIry25P2tK6LaUyXBplb3w=;
 b=D+JDhDZQo5eCXa8CpoOawMA+u2+sYrck+xzXv500GQzbVGCrhd/AUbU17ixNUOmDdynsrCFqUMh53ZYoMcY+AA3us4WAs/LxLcYM01CA+NnitsccLoUEIlLLNI5cmNNci75UmOM5ChrffFOC/WzH/QbLNQUa7PUEMP6HpEeWys8=
Received: from SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:56:49 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::7c) by SN7PR04CA0109.outlook.office365.com
 (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 21:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:56:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:56:48 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Mon, 4 Dec 2023 15:56:48 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 0/4] mailbox: zynqmp: support multiple child nodes
Date: Mon, 4 Dec 2023 13:56:16 -0800
Message-ID: <20231204215620.63334-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: eb65baee-a07f-4af3-5acc-08dbf513ea85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgm/KRlaSFCx46VvD8eg3OHHBa27wO0CiXeG+HrfeSEyqkokRvEwNyLv9uSOs6OSnBgVjc87WxWS4oYUG+/m0sbuguoqcHzEiCT9JlCOMd6kq8xqinDD8N/3JTkhJgtgIpzA4ztx+1HWmZDq2NutKoNPQ9wFJVqgJm6fH+ntlI8uyRVX4Rno0Yri1kSeVH59Hxyk0U3d/Sa1scNoQMM9JsBMHM795+MKmQIW1r/dQRxHpW4X1RK8JtOZQ62yXsFSEg0GiOlfNu9Z6q3LYIXENAxwii94gxBSLCy5BCfq9kJQ91E5z8BuBBys4QAurQfSKxpWzv4CO9LMa+a65mjbrdf3ATDggIUq2JKIVqo2GtbgrFM/aeJkK3lMqZs7QiU4lfqnRIUfnO6k3nVgn+f/XZrk6HVRc7rSuCyGoWru5/MXxlnyG+f4E5T2XuBoMkHlSrHbiClfO7K8gRVS1poHvveTDlowSEeZ79x5SfJgORxiDOkEW7Xafn6DsDA6WujeDK2Im7NCHPD6UumuCtKkFntY/ngUMXkceEJ+oW3RYAYJ2aVzNf2IB63maP8YyDgp7ALd9sUoTxc8V4P4frsW+YAAPty+0KR/6i4+qu8rvBFgskoiIAmUN3EhSRE/96FxiIZ4m/a2f7il0sw0PV4WSNcCbQM+f+MdsYmVUtNwd64FuGr2w5d4wRokYBBNjyshSzXkMAcswsfiVbHrHRZ/37hkLKvtcbRL5tylxDfcfSRsAIaPGbkhhX3wnNHzeo3jadgUfhhOKQR9/DlXl7oRew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(70586007)(6916009)(70206006)(54906003)(316002)(40460700003)(2906002)(15650500001)(5660300002)(86362001)(36756003)(41300700001)(4326008)(8936002)(8676002)(81166007)(356005)(82740400003)(44832011)(40480700001)(36860700001)(6666004)(426003)(336012)(83380400001)(47076005)(26005)(1076003)(2616005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:56:49.0223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb65baee-a07f-4af3-5acc-08dbf513ea85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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

Current zynqmp_ipi driver is hardcoded to work with only PMU
mailbox node.

This patch series adds new driver "zynqmp_ipi_dest" to support
multiple child node of current "zynqmp-ipi-mailbox" node. It
also adds support of SMC calls to TF-A to configure IPI
register address space.

New driver uses compatible property recently introduced for each
child mailbox node. However it is important to maintain backward
compatibility for old dts. Previous driver now binds each child
node to "zynqmp_ipi_dest" driver which is needed to maintain
backward compatibility.

Tanmay Shah (4):
  mailbox: zynqmp: support smc calls to TF-A
  mailbox: add el3 support only for zynqmp platform
  mailbox: zynqmp: support mulitple mboxes via device-tree
  dts: zynqmp: add missing destination mailbox compatible

 arch/arm/dts/zynqmp.dtsi           |   1 +
 drivers/firmware/firmware-zynqmp.c |  22 ++++
 drivers/mailbox/zynqmp-ipi.c       | 159 ++++++++++++++++++++++++++---
 3 files changed, 169 insertions(+), 13 deletions(-)

base-commit: 5c4e9d0c74a8c2f8d0f4e0ab9cf44959298c2bad
-- 
2.25.1

