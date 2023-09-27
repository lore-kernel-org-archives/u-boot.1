Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2583E810B1
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 09:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726BB86D4F;
	Wed, 27 Sep 2023 11:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2WlRgm+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640B386D4F; Wed, 27 Sep 2023 11:53:46 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25B6086D4D
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 11:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or0coaxWPPiGdCUy85Cje4XRjTUHLC0zjaNn1h5wThchG4ZLIunFsvoZVP+I18ixXbDtGTxlhgFSt091mlULE2dCJCNzZTpsfptbDOoZ7ZTgeJXFkJlg8nf+uyn+Wu1AqwYG05T12eiW6LfifVnciwxzf/dwCOL0r6FQdZXCU0H7Lur0HglA7jw4ha35qkRLTBHDB2G6IvGD+z2i6L2CbkYdq+HfyA2YH9JzoF5Z5QJrTqdCXpRZp3tE8yUp3kQysHu09JV412bDDtwZOn9mHK5B5DUFaTVHSqLRyurL4juzmf842uXleC8nFNFg8uXrum6pXJwEAgq52cjZOGO1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgDOnTuwsdfq/n3Nt7KWD2SXnSoHbrG6UWRYdmEzQ5k=;
 b=fDUJX0FY+TUnRCTp17iio6AMLNtSQOKVt0EI+ewfKaQcyiTP/o5FfwPmEZXjNo1oalNuhE2nQlNf/l3gq9ycAb04JKXUxYefJkMXtaLXyPtA7tLHqqBTkX0mmuMcqWBVLvUt76HB6IjgtDajKDIY6+Sqo67d5e5v5Mk6bGzSXpzfUa7unqpwROJPtIy6H9z2J3tfQDqKigdHDnmSXwpBIgnQxOQ1tiLInpbVTK3c90CUfUygVvK3eqEaU5YvWrRHBrIvRy5OZ2B9vGL5QMYQgrkYScd5JZFhJhHH47oYkl3vLpf/jMbkAdfmThYA/KiZuY7vasq+iJqyxCospOGhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgDOnTuwsdfq/n3Nt7KWD2SXnSoHbrG6UWRYdmEzQ5k=;
 b=2WlRgm+CmqFZ1zBrI/jnasgnt+mCzCMRh0aaRwWiDJxvY9lrgbB8U+v9FgA6qnSWcySfCYdDl7Q7Y1xGdDAPQdU8QhoMziOTdhB6BI75tzhw8rQvEH8CGZPHjZHcK0iJt/IdLu4qJyRQpZ8LbX3S1KPY7hNZv/7aoJJgvOfSyb4=
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 09:53:40 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::63) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.20 via Frontend
 Transport; Wed, 27 Sep 2023 09:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:53:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 04:53:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 00/11] xilinx: add missing boards/SC descriptions
Date: Wed, 27 Sep 2023 11:53:26 +0200
Message-ID: <cover.1695808407.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4072; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=LlYwopmwAOShXuZi15pUHOg9k6VfeZAURgVy1i0I0u0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTh3zM4jeZ68Z26t6Lu7snyT27dPFdOH/3GNzNrV+SCf
 651n5gMO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBENp1gmO8jNIF74z7+Q3OZ
 8q//90sTXMSbP5VhngWzWiOvMpOA8Qcvv0l9NscdbafbAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: e26141f2-e2f1-47fa-6c73-08dbbf3fa09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4csy4OgzspnsJZ1YP4nPsYaSCD9j5SivbuaNIe0vxd9yh5Kxp/oScmEGaZLGB3xZatF2mw47QBfbKfaf60+ScImeAJmebMY+hNQE9vLr/A+TFxPZssQKocki+StoxifeSMD+aFWeKa8+IRAm59SYY0kUBOJYBewJ+eqJnDyxHAAhkOYRrysl1B73fJUp2IujL5Om3sxqaplZqtoTqI658LHGOHbnIotG31eNKKazStgpjQixMiEgfk8KqMJeRf5RbXXk6fUWJJVy3ZeMaO76xhJR9V8jUYgal/tLS0f9Av/IScxIJw6s8/T/PTIfkPJ4det/C0/oi6e6YieqMDxfttkhcxrFzo0pkhI7VPL9P0EdWlnueubPCtHUe+uSe/WDG4R5J/hnmvxh+RZsF1mA9QyPUoyGPamS6Oim5JEQH1m2Z/1sBZ0ZZ8AHCOUFd1O4fR1UUgDQCuS0Sdz3hm8/BAYq7zct8VddAyyzeSxN/TxbUOUQQfE7gMRYtVl0NNh9eIOVHgfMR3LKUA72RfPNMRs3Xi/5D5C6+rOBx5FGfHpfVIwSouIVJdAXnDB1IlarQxYPGcqFDToYBGdRPHfK3OTkrtOGN5EkOAd31/jLkNm6941i3tl2j3ob9vFxJpNBzRr+34XHFMeOHWIf50eMep2tQuU1C6k4UDwaNBphMKsP373dCNYc3+RQG7RY1RbLWx22MICxK9wqOyrshT+eOcF82/vXQgWICk2KlPVHvPF8scHkswaYkM8KkB9FvVnGxYkW1yc9UqShLYdkC2xU5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(336012)(478600001)(6666004)(19627235002)(426003)(83380400001)(26005)(16526019)(2616005)(41300700001)(44832011)(316002)(70206006)(70586007)(110136005)(8936002)(8676002)(5660300002)(36756003)(86362001)(81166007)(36860700001)(47076005)(356005)(82740400003)(2906002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:53:40.1170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e26141f2-e2f1-47fa-6c73-08dbbf3fa09e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
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

I am sending series of zynqmp boards mostly related to system controller.
System controller is small ZynqMP board sitting on Versal/Versal NET board
doing board management. There is a internal spec about connection outside
but pretty much DT description describe all connected IPs.
The only thing what it is not covered in generic SC are i2c buses because
they contain different devices. That's why they are described by DT
overlays.
The first version was created for vpk120-revA, next was generic SC revB and
because of supply chain issue ethernet phy was replaced which ends up in
revC version.

The series also contain some cleanups and also adding new platforms like
KD240.

Thanks,
Michal


Michal Simek (11):
  arm64: zynqmp: Add support for KD240 Kria SOM CC
  arm64: zynqmp: Remove xlnx,fclk nodes
  arm64: zynqmp: Add support for vck190 revB system controller
  arm64: zynqmp: Add x-prc-01/02/03/04/05 revA support from SC
  arm64: zynqmp: Add support for vpk120-revA
  arm64: zynqmp: Create description for generic SC (vpk120-revB)
  arm64: zynqmp: Add support for SC revC
  arm64: zynqmp: Describe i2c structures for SCs
  arm64: zynqmp: Add support for VPXA2785
  arm64: zynqmp: Add support for zcu670-revA
  arm64: zynqmp: Add support for zcu670-revB

 arch/arm/dts/Makefile                         |  20 +
 arch/arm/dts/zynqmp-clk-ccf.dtsi              |  18 -
 arch/arm/dts/zynqmp-e-a2197-00-revB.dts       |  34 +
 .../zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso |  76 ++
 .../zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso |  76 ++
 .../zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso |  80 +++
 .../zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso |  86 +++
 .../zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso |  86 +++
 arch/arm/dts/zynqmp-sc-revB.dts               | 430 +++++++++++
 arch/arm/dts/zynqmp-sc-revC.dts               |  37 +
 arch/arm/dts/zynqmp-sc-vek280-revA.dtso       | 230 ++++++
 arch/arm/dts/zynqmp-sc-vek280-revB.dtso       |  15 +
 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso       | 321 +++++++++
 .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 460 ++++++++++++
 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso       | 326 +++++++++
 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso       | 371 ++++++++++
 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso       | 337 +++++++++
 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso        | 353 +++++++++
 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts    | 438 ++++++++++++
 arch/arm/dts/zynqmp-vpk120-revA.dts           | 574 +++++++++++++++
 arch/arm/dts/zynqmp-zcu670-revA.dts           | 669 +++++++++++++++++
 arch/arm/dts/zynqmp-zcu670-revB.dts           | 672 ++++++++++++++++++
 configs/xilinx_zynqmp_virt_defconfig          |   2 +-
 23 files changed, 5692 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/dts/zynqmp-e-a2197-00-revB.dts
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-revB.dts
 create mode 100644 arch/arm/dts/zynqmp-sc-revC.dts
 create mode 100644 arch/arm/dts/zynqmp-sc-vek280-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vek280-revB.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vhk158-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vpk120-revB.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vpk180-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
 create mode 100644 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
 create mode 100644 arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
 create mode 100644 arch/arm/dts/zynqmp-vpk120-revA.dts
 create mode 100644 arch/arm/dts/zynqmp-zcu670-revA.dts
 create mode 100644 arch/arm/dts/zynqmp-zcu670-revB.dts

-- 
2.36.1

