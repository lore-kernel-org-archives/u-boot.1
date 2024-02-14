Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89553C48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 11:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630BE87E07;
	Wed, 14 Feb 2024 12:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kTKAamh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1A7387E02; Wed, 14 Feb 2024 12:52:47 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1351387C6D
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crXY6tX+AIvpe2MNc3IQc6+Dqv4gbD67PI9ZYug9LcmHRsagQfw/U+rMkRghA/nXmf4rYkxkR/lmEsP/lcpHW5TseqTQPO15kNCnGoQb+DKEhtwrH7XtAuWiwA0vQxMyu9oq2t4nEgpJf3dEoY2bOs6aq/LejWHVv20+k2my0Ul0qDDocy3hM8D9/jnc0QwW8YtLWbHIKWSp9M2q3fmv+VePHuy73RkLUqhgUMOauybUgCnRYiLEg9pbkXF1cJLYCophX45GjNYOy4hbPm+0j9ZDQNwlq9kzrczlrAA10tCNUGnLHpHsHcb2Rlll/H3lA094P2eg5MFVJMgsz7wE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5y1DLsNRrrsCgn4uOqt7YDap5HWqXOrVPPhEUYZIDqg=;
 b=OVTizWPHX9GNA0Sx0dBm1bymDtWCkA0DmmjcP7hx1llQpdrEEvAztmZ55J9ZapBuxZaRFgUd2pcXaUEMwU3Gi69lY+RYY5oE34gKvt3v6kSaGdA1dIjeZZjiOkhTDK7FWmGl02d3bgGlIYQey2RbzOmkqRXqZ+roshILnw6UiFWj9XwWg6SPb4DCAC2064HLC/7Kun+vVCXkKNuGb6rp0zbREr2MDI/aVhcmhUwtWhWc/qSx8V0fXsSe0PEFG0ZtDyWaz9VOTFG3lsBESDKmEpHJ+wT4FvTmPsglDkxNs3i7wJ/ObKvFpSS3oL4GwQTLZeSWdIDE+ZfA3xe+JO+7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y1DLsNRrrsCgn4uOqt7YDap5HWqXOrVPPhEUYZIDqg=;
 b=kTKAamh0u4/x5qBx8whEqNQLc7TV9CQRSHukNwV9/KyZR5LY4sXt6zWK2NZNTIC9r+Xz1vxcOCKx8GNO/GIY5qoXuIbA2pqoBbtw0nllhb2hZ481+ESf1MDkOhj0nwBTfVC/bCMQ9v3K17YvXoXpYSN6S2jvw1DgIWVgbAO2KhA=
Received: from BN9PR03CA0577.namprd03.prod.outlook.com (2603:10b6:408:10d::12)
 by DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 11:52:37 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::f7) by BN9PR03CA0577.outlook.office365.com
 (2603:10b6:408:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 11:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 11:52:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 05:52:35 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>, Masahisa
 Kojima <masahisa.kojima@linaro.org>, Padmarao Begari
 <padmarao.begari@microchip.com>, Rick Chen <rick@andestech.com>, Shiji Yang
 <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/5] riscv: mbv: Enhance MB-V support with also enabling SPL
Date: Wed, 14 Feb 2024 12:52:28 +0100
Message-ID: <cover.1707911544.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=wEnzMtus1Lsu+p8ennozAPqVPKRfRZA7WraM9FbdTg0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQzK6tuJqXoSnM86pCK4T7E5Ptv5b7q3c9eTC9Jd5jeN
 qV/682yjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRBleGuQJLd53r3vRs+9JL
 Re/XyKhlFe0Jc2KYK/PEziMsMPJFhatZftuJj5t5nGMZAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e3355f-4691-4d64-6505-08dc2d53707f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKlyvEib/6DSK95MBcpgN/EdncmdHS9elllp4oF/k2GXhBfVmkREriAp9mWs1Qz16xKBw8W7tzBmYlUPEV6+T6tDkOyKYWMg28n6rmtNUod7B4Js7HoUNEK+P74Pi+9zWanF4iWq6+XYMc+104TQO7Gq4PXqE4FHnBc2AxbHyUGRJL3tpvLXBuTvVPp7yX21GZCnwBEwPNx7NbWiUYXgB4iS/vfs8rwms8CdtznewdbfQLSFE+5WZoaZmQ9ddYay7R/7vNRIT02rlhqDNovOz586dK0/8Detto3GsGsVlAXqMvgxL1o9/Rc1zgDb7WDi6PnxDpSYJuLfAEWtm5TztubSpLjC6ywH4BkwWmt3lG4QUJTf/qBmLguLw4CnZIEgL2h/5we+taBRhoKdbWaj37YijVtM7xjTGU5r+tFlqCxSK+CJRec5/r5HV5QTxdzUerhPg/22KcQHofMUZbtpCbpvwZn4VgRCDrJ6RAuDoX6wq7wwVaEF55oInr5a9/ka041yFgmIqm4taSrTH2e0BH0oavSFXugaR4FxPkN1YTM5jSKpoSZVRdGKmZSYyP3ClCvCyasQA1FNghTOkSJ0G6dRTe5qsbFKeau2SW5Km/s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(40470700004)(36840700001)(2906002)(4326008)(4744005)(8936002)(44832011)(8676002)(5660300002)(110136005)(336012)(426003)(83380400001)(2616005)(26005)(82740400003)(16526019)(36756003)(86362001)(70586007)(356005)(81166007)(54906003)(316002)(70206006)(6666004)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:52:37.2231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e3355f-4691-4d64-6505-08dc2d53707f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202
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

enhance MB-V support with SPL configuration to support OpenSBI.
All of that changes are out of generic Risc-V support that's why happy to
take it via my tree. Please let me know if you want this to take via riscv
subtree.

Thanks,
Michal


Michal Simek (5):
  riscv: mbv: Align addresses with default DT
  riscv: mbv: Enable REMAKE_ELF by default
  riscv: mbv: Switch to OF_SEPARATE with fixed address
  riscv: mbv: Moving little_endian variable to data section
  riscv: mbv: Enable SPL and binman

 arch/riscv/dts/xilinx-mbv32.dts      |  3 +++
 board/xilinx/Kconfig                 |  1 +
 board/xilinx/common/board.c          |  8 ++++++++
 board/xilinx/mbv/Kconfig             | 14 ++++++++++++--
 board/xilinx/mbv/board.c             | 10 ++++++++++
 configs/xilinx_mbv32_defconfig       | 23 ++++++++++++++++++-----
 configs/xilinx_mbv32_smode_defconfig | 25 ++++++++++++++++++++-----
 drivers/serial/serial_xuartlite.c    |  2 +-
 8 files changed, 73 insertions(+), 13 deletions(-)

-- 
2.36.1

