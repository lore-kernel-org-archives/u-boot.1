Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2B5CD8CA7
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B865B8405A;
	Tue,  9 Jun 2026 09:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sQctvpUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8117184841; Tue,  9 Jun 2026 09:48:45 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348AB839A8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdxxG12S7Lx1/a4913INrwUunpHWkCahG9Fd69lNH42iGG8Gt7hh7o0/f9nIs9latvXezkOq1vMZpTFVLYUzlCXI/SWj9MZ3nmttej0mj43Qs6a1aIpJU2XB4/kfrBuU0ZfOcLRvSGFhoEASG6If/XfJfET/2n5QgWEVxlQDdpGVy2PgM3/JmWMkfJd7R5PetatGt+XJTkMZPFwYdKRyyqQVElWHjdVcMmgxQB2djtPT5hLWZIQjnEBuEPhNfR5uAxFm6L/2egojA2N0H6kngMwBYQgc3kl7bfF5BF+eEo38kbSHMpSFAfAIBQZ5TQLk8EJpwtihDJxrVlZZP1fFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOJJb/8kmC39uBkW/KA+R1lQbPUQDX0q7cChr60Cy7M=;
 b=Ule3bkI+x7iiQ9qUoSaSKwyaWqneuSvNoxF6PAUo6yViPmJyPxAAmgrPXnV//oklohp6k9S+VZ1UKQLbhoCARp91yx3fUfCTuVCVHhTKdWsEeNdaR68fTGdcoMW/rk3Uvevrlcdhnx9u9h3gKrUK15F/dfdY6Y8qLlfb94GxSke00Hcv1vwolsLWZlrwCv7XUQyiMV33kFPTBN5gjiIp4cBEeHr4t+iT6beR6BSJwEthpXpzEh9VjVnqeo09F1ZLXO7/d29rAqLNQ9wHgOm6vQFeSUz5pIHZTaXG5W95vYqLWksODdyeUDA/e7OYruAL98Rg3iX25zNMV64a2iuntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOJJb/8kmC39uBkW/KA+R1lQbPUQDX0q7cChr60Cy7M=;
 b=sQctvpUJ6+zkug2f+IkIu+LIS4MtwIkQiwyyQibvhI8lRvfcZYcXb/t9vKi4de2ihX+0y6shZz77pqMJ6px+IEOu1sP7h2grIHneRUH2aAmgMYf56kTO6lU1cddquuNiVItVko/yU5n1zH7cQTkXbQYJpcv/K1ca4ogwgv/JSCY=
Received: from BL1P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::13)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:48:36 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:5b5:cafe::1e) by BL1P221CA0043.outlook.office365.com
 (2603:10b6:208:5b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:48:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:48:33 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:48:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>, Rohit Visavalia
 <rohit.visavalia@amd.com>, Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini
 <trini@konsulko.com>, Trapti Damodar Balgi <traptidamodar.balgi@amd.com>
Subject: [PATCH 0/9] arm64: zynqmp: DT updates
Date: Tue, 9 Jun 2026 09:48:14 +0200
Message-ID: <cover.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3290; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=cLX4Y+/uMOQjudWZp6+MB4MGPpRpS754t3frQs3jEN0=;
 b=kA0DAAgWqwf+8E71EfUByyZiAGonxUKhLKjZ0nXr5c3fe/rq4ZDoIZrfU148OsUSgbqbDDZ1w
 4h1BAAWCAAdFiEElwIsQKz21qUWp1lvqwf+8E71EfUFAmonxUIACgkQqwf+8E71EfX9RQD/YIWM
 aqWBtr9XIdUdlOekHpdrxzOQagnvGcn0QSzuIk4BANt45K4IEBMqdZh6jSyNu669izd+kYL3+II
 pNBjb64wL
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: c19ce162-7615-480d-8b6f-08dec5fb82cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: /pil9/Jvxa6xMjkVve1rKGs+v2grl2wElQEwuMsyRKkmocwj3hIovqKuR7Ae4YGmB9Djhp/GFXwGSMK+Pd72BYze/XwEYI14gszWgWTRlGc8g9kwi81SOb6hw7w2H+v5bDGZm23XiwmB2c8Fl8iZGd7HeWcC+CEQAvQIdZL/M1CN5P6ivQCgIJA2TObDBGxawQ6HcQ59Q1GbdtiafkXYXo2vGjJwA/oqz1GNhVm83U4OmpiqiK8Igr3Mj38f/JaB+bZsS2T6UB5skoejVPtS8GxtFxGpoXL4mg2HW37krQ7ghvFPZ3gha2hLrvIfgpt5eGZBAJD/d2LoWFZqLNYlfd8F9VrBWe4xpm7CLwJJ4Q/TSmugEF6JqipT03P5fdtbKh94rtqyV13YOov2s+ES4HQbyRMtZ9KRA1eRLgNTzHnB/XZ1paCvfvrJcfg2R3S1wRRgMUv1BAX9uDjVfKfggf+q3Q+7oepTOQS5sRGaqU9khUELiSqLE87ZzTKzYdBIEje8eOYoVznxPCHJpOIz5X/dsbTWWRPGDZeM/DXXPVmXPN2Ywa/gyVzOiJ41LARHgUu5zpC2OX18bmIKfW555AZE12Z7xusnL2q2OWQFkp1ibIGvyWXf8oE/2mGiTxxwIQw4BT0M/gZDTQ119Ddx9CK011JfWh6t0Sqo/x+j6qQs8j2c5crK2NHJgS/iKJ5beT19P5wUVeELMj8dU2ssUiGGFlD8i2+P7/+kqLi+lns=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mfBm3BfX+EKJOZAHixl1D8KJoQ7JHn3cujcqSK6hN7fmMedOoyvpOHsrylCso6YUWHgZSqEfHSfnwJN9s4VUHc8FwTyaqdpnZtWuPYxITKqhzESvC6uCqzpHaKK1RJGZWzHjLFiLwj9FX0oXSvja2lpoYlzlScxs+OBe0IAHMrgmZ0dKcik5k2SmBK29Xm9jQ3v5NetJyE1t9v/L8F8E/nHQGBP3JrruXHKmX0nbqq9j1Sq4RFbu5bQFREZfswCK0ySR6vO1Bh3aIilyujNG/R4stQbQ4LPzhyjujlEQSgem2mhfmqqPbJ0Ee0PS235wlKm2Omy/Fl+K/aIn9wyrRweh1nwxfCDUlvp9HR3JXVEw+UbCJ8VWNfIwA9+cONuFMjERXrdMkCD0+poFOUtvSZew6Sl92Nznyx2YJwcxgSNNgGTB8xp6SOLluykll3Ey
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:48:35.4887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19ce162-7615-480d-8b6f-08dec5fb82cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
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

Hi,

sending multiple patches to update DTs for ZynqMP targets to reflect
the latest findings and updates.

Thanks,
Michal


Michal Simek (5):
  arm64: zynqmp: Drop incorrect #phy-cells from ethernet-phy nodes
  arm64: zynqmp: Use fixed-partitions for MTD
  arm64: zynqmp: Add CMA reserved-memory for runtime FPGA loading
  arm64: zynqmp: dts: Fix file descriptions to match actual filenames
  arm64: zynqmp: Sync compatible string format

Rob Herring (Arm) (1):
  arm64: dts: xilinx: Drop "label" property on dlg,slg7xl45106

Shaikh Mohammed Suhan (1):
  arm64: zynqmp: add USB hub supply regulators

Trapti Damodar Balgi (2):
  arm64: zynqmp-dlc21-revA: Update GPIO line names mapping
  arm64: zynqmp-dlc21-revA: add mac nvmem cell for gem0

 arch/arm/dts/zynqmp-dlc21-revA.dts            |  17 +-
 arch/arm/dts/zynqmp-sc-revB.dts               | 171 +++++++++---------
 arch/arm/dts/zynqmp-sc-revC.dts               |   1 -
 arch/arm/dts/zynqmp-sc-vek280-revA.dtso       |   5 +-
 arch/arm/dts/zynqmp-sc-vek280-revB.dtso       |   5 +-
 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso       |   5 +-
 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso       |   5 +-
 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso       |   5 +-
 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso       |   7 +-
 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso        |  22 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso        |  25 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso        |  25 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso        |  21 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso        |  23 ++-
 arch/arm/dts/zynqmp-sm-k24-revA.dts           |   7 +-
 arch/arm/dts/zynqmp-sm-k26-revA.dts           |  11 +-
 .../zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts  |  38 ++--
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts    |  14 +-
 arch/arm/dts/zynqmp-vpk120-revA.dts           |  14 +-
 arch/arm/dts/zynqmp-zc1232-revA.dts           |  55 ++++--
 arch/arm/dts/zynqmp-zc1254-revA.dts           |  53 ++++--
 arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts      |  55 ++++--
 arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts      | 153 +++++++++-------
 arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts      | 124 +++++++------
 arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts      |  53 ++++--
 arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts      |  15 ++
 arch/arm/dts/zynqmp-zcu100-revC.dts           |  17 +-
 arch/arm/dts/zynqmp-zcu102-revA.dts           |  56 ++++--
 arch/arm/dts/zynqmp-zcu102-revB.dts           |   1 -
 arch/arm/dts/zynqmp-zcu104-revA.dts           |  56 ++++--
 arch/arm/dts/zynqmp-zcu104-revC.dts           |  56 ++++--
 arch/arm/dts/zynqmp-zcu106-revA.dts           |  56 ++++--
 arch/arm/dts/zynqmp-zcu111-revA.dts           |  56 ++++--
 arch/arm/dts/zynqmp-zcu1275-revA.dts          |  53 ++++--
 arch/arm/dts/zynqmp-zcu1275-revB.dts          |  53 ++++--
 arch/arm/dts/zynqmp-zcu1285-revA.dts          |  15 ++
 arch/arm/dts/zynqmp-zcu208-revA.dts           |  16 +-
 arch/arm/dts/zynqmp-zcu216-revA.dts           |  16 +-
 arch/arm/dts/zynqmp-zcu670-revA.dts           |  18 +-
 arch/arm/dts/zynqmp-zcu670-revB.dts           |  18 +-
 40 files changed, 948 insertions(+), 468 deletions(-)

-- 
2.43.0

base-commit: e91911169bc737ee4a79963a1cba8db2aab7c1c0
branch: debian-sent3
