Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE6CC001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 04:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4898186BF5;
	Fri, 18 Aug 2023 06:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MZXfr2Kr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9637386AB9; Fri, 18 Aug 2023 06:21:39 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9346786C70
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ashok.reddy.soma@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvQw1omwZwgvnMBDSJaEEI4FIle6nyQQ/GbPc1ZTQVAo8GnCq/FeC9/YHgwtk3sr1YY96g9OgzYc70v0gF2NKOWbcUU68EGJE3hB2Gb5gJDuCjvUILsZAmrzH65t8U5UpJjz4PvXAw7rarVjqo/SyZsWgRPdxICAA6suusdo0ptabwrAZucQar/mjDf6qN4ujaEAiRkyc28XkhrGFzAVvmEtPfwk8eJbLSpqjqyIMOYuMN3FzI0v/iSS2AWnixLG4MMOsBWQRuJIZsqcst762swHgyyzMfvar5Rrsbs4ncnuaR4EX7tBTo1qWgg7mzLOL7vkG6YymPRyDlZXKZoiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4Kn06bH+AukDhYOfXdm/8DtIFkn3kW30azyNRLgJYQ=;
 b=ncdXGk8WAFTJpcgezgWN9TtVFv7JvPQC4PYxJNXbBzjanLtSc5WaFHTzhkToF2lhBZfzeVgRtaHql+WyqlghJS/3a0kDrs8/kpZByZ7EKvIHWAzkcwUmqXYBW55Nfta3wJiTlZK1HvOwk+qqdHc2MW4tnyEYfVAWpth3UljjWhZcdCeiDsBSpMUb2jNUuOtPuZ/GUgq/xB2m9z977xarIFfaC7A6j+phKLdhcmr3GDBQqQzIjNX0pOs8mI1RYmwMt8QreGYr2aeJjhcB49idWxxJg9L88VdZdoY/GUzpeK9+TLeKFEKNcRbHJUkzODYoI+KFvmo23h8x+HWKh4NVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4Kn06bH+AukDhYOfXdm/8DtIFkn3kW30azyNRLgJYQ=;
 b=MZXfr2KrYG3qfwJ6wTY8RN4OY66uzXql/OrcdI/T1/wA7buXXaEI1vKTC9n3x6l54a+8EPjvr0tnI/bSa0FasNYS1a4SHHXw4tnH0hxNvIITts2mnDNKrWP8J94Esnj9S1rA/C3SF5rSbpIiz4oQvnlR/1ONgWFhBdRwMB8F9mM=
Received: from SA0PR11CA0118.namprd11.prod.outlook.com (2603:10b6:806:d1::33)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 04:21:32 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::5c) by SA0PR11CA0118.outlook.office365.com
 (2603:10b6:806:d1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 04:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 04:21:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:21:30 -0500
Received: from xhdashokred41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 23:21:28 -0500
From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <sjg@chromium.org>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
Date: Thu, 17 Aug 2023 22:21:12 -0600
Message-ID: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d411d98-178d-4d41-399f-08db9fa299d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fS6PKpJsj9abP5r3Dphu5D6gFY6cSFwMyDIyeNJqH2m/iKirsTQUIJ22vcj/9wLRQj+cHMyFdET6EHAUeCbEKdv2ImEiq8cdAoRLbQLUnjr47sFzBH/PVsUb3bkPLM9/1R0QUDMeZHzgz8aTzOU2qgAgrdV5HmUYSJ3E1Llf2mtc7hv31nXS4KtXNpg9YuXdT7UlOIzkWBNExE1LFQ9sWSgVu+CnAVELPq54r2dNqiesm5mp+OXzjZo3ZuOffoRdUhjp12ds/UMXEvNa9ARfPVkHXRz3za3Y66cccw5NqCVS1iGSG60jMUY6W6q63rpi9YiMz4Uftgx7yPM+pfF0UIafFS1sV3DhgRQ1Rqh+3vu8kR1ScKGY9UHfyyG+1MRhDZtfVRuzZmgpw5g5XPI795XOpM3uhjvHKHokE8LpgPWn2yH589DJcTEZgXRUuITpii1WO+h6hOzL1EWbbfO1O3/3qVFBJtCX1RDE9LRcS1sXp21aQ29kA0EshSEkVkE+vNK0cV0yN47d0jpMuxPb9MRbnUG2AV9yDdY9VevN8OR/Frliay+3CjggiGMyHhqk4zvsKBTX+w8CHX1xi4y6gr2DkdKxgkZKPQ1y855UcxQChPpQ1kXQ6K5VBMYFYsbqtowG7uK0Xvqtr+xcTODWDoqfxJ/zPe0zAqZrtvnDRWnSjUB/a/zt3mXHnn/GA/zofDUl0B2mYATPYWorEAlMG5T8Z1UGcsMZzUT//XEeBovAqOaQJM7iO71a7vFJsOdZf4qRr6STcyoP0uV5TYmMvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(86362001)(103116003)(36756003)(40460700003)(40480700001)(83380400001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(336012)(1076003)(6666004)(47076005)(36860700001)(426003)(2616005)(478600001)(81166007)(82740400003)(356005)(316002)(6916009)(70206006)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 04:21:31.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d411d98-178d-4d41-399f-08db9fa299d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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

This series adds support for Xilinx qspi parallel and stacked memeories.

In parallel mode, the current implementation assumes that a maximum of
two flashes are connected. The QSPI controller splits the data evenly
between both the flashes so, both the flashes that are connected in
parallel mode should be identical.
During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
nor->flags.

In stacked mode the current implementation assumes that a maximum of two
flashes are connected and both the flashes are of same make but can
differ in sizes. So, except the sizes all other flash parameters of both
the flashes are identical

Spi-nor will pass on the appropriate flash select flag to low level
driver, and it will select pass all the data to that particular flash.

Write operation in parallel mode are performed in page size * 2 chunks as
each write operation results in writing both the flashes. For doubling
the address space each operation is performed at addr/2 flash offset,
where addr is the address specified by the user.

Similarly for read and erase operations it will read from both flashes,
so size and offset are divided by 2 and send to flash.



Ashok Reddy Soma (7):
  dm: core: support reading a single indexed u64 value
  mtd: spi-nor: Add parallel and stacked memories support
  mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
  mtd: spi-nor: Add parallel and stacked memories support in read_bar
    and write_bar
  spi: spi-uclass: Read chipselect and restrict capabilities
  spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
  spi: zynq_qspi: Add parallel memories support in QSPI driver

 drivers/core/of_access.c       |  22 ++
 drivers/core/ofnode.c          |  30 +++
 drivers/mtd/spi/spi-nor-core.c | 385 ++++++++++++++++++++++++++++-----
 drivers/spi/spi-uclass.c       |  21 +-
 drivers/spi/xilinx_spi.c       |   4 +-
 drivers/spi/zynq_qspi.c        | 145 +++++++++++--
 drivers/spi/zynq_spi.c         |   6 +-
 drivers/spi/zynqmp_gqspi.c     | 146 +++++++++++--
 include/dm/of_access.h         |  19 ++
 include/dm/ofnode.h            |  12 +
 include/linux/mtd/spi-nor.h    |  13 ++
 include/spi.h                  |  29 ++-
 12 files changed, 737 insertions(+), 95 deletions(-)

-- 
2.17.1

