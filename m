Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D98ECD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A611686B08;
	Fri, 22 Sep 2023 12:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WW7MLqO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1BF86B81; Fri, 22 Sep 2023 12:37:02 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D43F86B72
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTTXVIbMNQ3LhjtkTY15B2FzQayJlBHK6q0NX/cDp7yzfNrsjFf73eSEyffFlSrd3zVqyaWPNy3HcYnGTy6kJBSN3mXkcdLiNYNyxo40q4yINe1CYOkREW0/iP7ByVZMzxw51ssXJnUkzj3lUpGeeuHlaZ2lUnbZpqreksZ4V+T44Lm3vGbvoqRgGO82+bGma4Y2yesU17yeLgCuMpvGL833KEhJPt5yMobQ0rzxgfzWItDRADqbNTZeMDp9GwNWhIfHsteEwzH5/yyKwJl5SQpAMmZkTbXlT6tF3Ls0m5ZKSTPC/QJ+ig9bLhlydfty54CZYI1fgWqL1gDJzz3/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApPug42Wln9tO7loJqlPLMrfl31jfT4HlKl6hjj8BEA=;
 b=KqpcyqQ6zp9rIewBCjXXqcDYNWjLZviLB5PTxraQutyDnucwOEFVdzohMLxbUUhg8bbpMMCV5KTfWTVWWKhu77AclAHew096G9MFMnMge2aule6IF4Wfyer8HxHBT+JOxVzf19A8dO1dkScQCco9AsDuejN1xD83twZnhcfAJOxBPA2YhNaZ2lsrw1xVT7V3mCVYRYQsnhf8vF/smoNP62ypjCfSmb+vmvPQbV6auUdHlCDo9BCz/qSIrkJ62Xz0En9mCuQ79HOowkSudE0cLyMz8miAh80CxMEWEFbGSTh2yZyTWrB0A5F7IG83VoDaV5j0p5elptEA6tNo/27OuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApPug42Wln9tO7loJqlPLMrfl31jfT4HlKl6hjj8BEA=;
 b=WW7MLqO57RxZID39Jk+acNITl33uUcM+hvjSvyhdqJvTwpSWMdGQBWGM3RM+XShp/B6i06UfcoJZaa6XxtOoiD+Mt8IQxRq5YdMRfQ7bt+o3Z0Yp7YXnOy92tlnfGbt0sZ0mUztfF0NYww5+pYr+srXkxGaluMfdD9y02UnRC6g=
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 10:36:54 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::f) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:36:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:51 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 11/14] arm64: zynqmp: Convert kv260-revA overlay to ASCII text
Date: Fri, 22 Sep 2023 12:35:40 +0200
Message-ID: <e4d52b898b461b86bb82009f37635f351279c753.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ysrWGoAc+1TYp49PXq8uDN1IdCEETHtgX/7MY1D2YiE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3OkV+ny/VD0YWGL4uqb+MEvZ03zo0XPRpMBKF3+9d
 xU7/P92xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIlsucYwv8I4quWB7I63iRM0
 29WP25w/meLezzCHU+noXuV53BIrajv8m/ev5t4nt30mAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|BN9PR12MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: db5d9efb-30b1-4940-f5ac-08dbbb57d6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U25Q8dEdlDC3u7zzElhCck5ZMRqy9rL8jY2EPbGKuG9HhuU1PQdlZULVmDoI3f+16BY2U7hCcDSXBU5THPtH22NaHYgGSNoGwTlFBRaZCbZjdz/potZ3dwa5jx5uYKhlhz6+iNzXHqqEhkqcQ4hKw2HW82wVq1BXpZX/SVYspOZhPs9JY2mF/Z1o4FZS43+YASgHFpBtvLv+nkNBo+yJT9bqBH65lgDcR01HAkXvz6446P8amciYk0TPdn4dbbUrrbO/B3hi0Q8cEqTg+Ksg4ck4I/UgotkibdhnsusNuQSG24lhX2Mn/mTCEEeXFMikF1ysT9MZQmdAnGkkudpJfs/QGkBzWvVp5DCQEBvCdUDX3D+aGWPMAXMmG3cRKVMP1u5D+4aLTuIjsOt12f9PfQNADWia05Hd3WygI2QP2Nub/Mjk0XnUUMUaW2iyPQ/HieQv2DQL96WV8K3oorZYL7aKZnn+xMIaLAeDmIP5eFECvtBVqcOLvhrAbPbk4JwnyWy6n5HBvyplvmIy/Jr2WGYQfMPVjujZoauK6zY71EZfu9UhfzTbnlgYq+vfWbr51ryXMh0uVTZSLHm9jo7Ne8wp82/O1oUG312Dn38g0qhj8A6wDEnT5T/006j6RTws5HS6LM/6as0bBlpR0D5UlK0kKxXZP0y5Wf55KkZpdfBJl+uHYyv0KXYpqWB5e10R1/zW1zNjZFI+6gIEm4R3trcwZebESCpI3KUE7bom6VqN5S/6LP+nc+uoeYqy5wrag24ZWDj2eOnpz0BdFB669JdxopbjyOzttO1IbN/IW/9vyhBLC5nXQFLYO4OKSEec
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(1800799009)(186009)(82310400011)(451199024)(230921699003)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(82740400003)(426003)(336012)(26005)(16526019)(110136005)(70586007)(70206006)(2616005)(86362001)(47076005)(478600001)(36860700001)(81166007)(83380400001)(356005)(36756003)(8936002)(8676002)(44832011)(316002)(5660300002)(40480700001)(41300700001)(4744005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:54.5111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db5d9efb-30b1-4940-f5ac-08dbbb57d6f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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

File was in UTF-8 format but there is no reason for it. Convert it to
ASCII/plain text.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index 72361f6f9e4a..530bc9076d94 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -5,9 +5,9 @@
  * (C) Copyright 2020 - 2021, Xilinx, Inc.
  *
  * SD level shifter:
- * "A" – A01 board un-modified (NXP)
- * "Y" – A01 board modified with legacy interposer (Nexperia)
- * "Z" – A01 board modified with Diode interposer
+ * "A" - A01 board un-modified (NXP)
+ * "Y" - A01 board modified with legacy interposer (Nexperia)
+ * "Z" - A01 board modified with Diode interposer
  *
  * Michal Simek <michal.simek@amd.com>
  */
-- 
2.36.1

