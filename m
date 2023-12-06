Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E871C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC9687884;
	Wed,  6 Dec 2023 10:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eX6uW16r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13F587884; Wed,  6 Dec 2023 10:33:40 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C9E86F64
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGQpy1eLB12iOoqPmGIIT62FhGaA0mz9ajrXHFPPTgD6vzlQ2LbtqTW83t/YLULfzEe2GcBqMgndKfz8PDB1fgLcVdPxbOjp+0lxKLaMnZKfbM81Hx3x4nBPdznarwzMd+IvIp/Sv9h4InbnI6intE3a50k6EKIhq4n61FOhVb49LvE5U315jm2Z/wHjgXeFgDfK6FC4+9JUOt0SQShEw/zcghnAkyj2XqKBJT5XXgxJreC94u/y64ujNm8LaKOF4Y5U2qpSzNI5DBj2ny5cqwdTQZToLtunJZJ/MRU0ofQJwuo0HAhBUsYkIScMdtCvD+dXoIivJkXlh78yMu7kBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg1Sur1rkRIAz4YlIZHiJx0/GGwSVH8HPtBDANkDUZM=;
 b=TZR3cndoXl+HJPmZITLYwmJYaKXJIqTPuBuc2fE7C9TM/QPh8apLPctmSngpmsczqBJkpGbUO62Cd+xp+obTTD9MPrOw9V2hcwBULIBxClxKvMCfNBsNB7YrkPfPiPiMats/OaefUtPg1AbQxt3unhi7rHAuV8MW4wVMJXlChxF9IgZ8vAMHqRTkY0XCtYATixB0YUxjofnvoDw4QP1PjnMgZMNMCzl7TIHbhe3k/a2M/8nnmOgQ/+Pa4DdLg+Hj9FSH/uA8BLGqisdFJuRCEwPWkLfdvySU8FzdpwkTXayA7robFZOs6MnLapnFiCA5a5RU05vdBj4PDIMvvEFC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg1Sur1rkRIAz4YlIZHiJx0/GGwSVH8HPtBDANkDUZM=;
 b=eX6uW16rmdtqaWwNCeHOVAL1tUvdp+l9SWyXbSX1wND2p78yqlXoFJhmN8aIipQqA6Is1Yf+C5Jd5PLffa0UDy9TWM8zIHh/ELrUqZ1Nblg4eDUOHLu8/rctoYvwrE/IbycwCTClpjSuONTJxop8i/VcN+Sjd4+qnj537VaJpMw=
Received: from CH0PR03CA0410.namprd03.prod.outlook.com (2603:10b6:610:11b::22)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:33:35 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::3a) by CH0PR03CA0410.outlook.office365.com
 (2603:10b6:610:11b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:33 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:31 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>
Subject: [PATCH v2 22/30] spi: cadence_qspi: Add spi mem dtr support ops
Date: Wed, 6 Dec 2023 15:01:33 +0530
Message-ID: <0be5d24a4068ef3bb1d8df92d78886f4e0879362.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: d87683ca-f6bd-409b-94bf-08dbf63e6b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUyw8woNYeQp0h6mR/goPqg6wABW6sSo4VAb1KLi+z6SgpQgI4ztLtVsy6x+8pkWHmsLZZCnWRE1F1t51BePRW5vg9yzHe37GrMHy2fnOivCTCib5ihVW9dHUQCOmCok2XjkseCosLbFhYg6UTIryITs8yM+nLmv0VPVXYFDF/sLXHUO/fG/b2+1/oHnEpN4pxyb9Pvo6/Eu6ciUz8AaEYheUXM6By58vyXPTPwK/dumL+mFOsR9yiStWr6cjW3Vp0AUg7Otv9my/q7ylsrcqIjAql55RmMwbw0SnSJRukx21DJo+E3F6mWOxq3SkN3ZSfrFmOupSxnEGa/cKrqTGmMUc3vYOJyjmvoa4JcW0Jl3mUqEakZuizrOAn0O5lmn5lSiTmDsMFb9CBO4QaGabmC7T+q99MexkjJ9QdZZCB4RmtbiXXpJZJVsiQ/Ht4TACkLj2sydy7o+b8STq4TIajAc+sJAF7tPl2T1MS+3rKycEqtt+bVOISicyM201UdL5DiIB4mMkQ+Zcz4+AX/Q1CdWWvQ0uJJVSdN0xFH5fgooc4912pm/is5EgGa/Nip5UwS+F9Bpp1prOIumUjLV0iC4tVffWXSs87jzIuvmcr3W44F13GvJpyoDNuBdSGSQmoZXXwbWnab3DI22YJrNgs/KEZZ5BOvcLigDnvpkYbon8rih3MCAoVbR2dqJnbqfi6GDJCRgdCoZO9bx8r/XCs77ae9tkTgNMNOsOFPPVBYFaaVOh622v5AKIanQdgMh2VhB1mMk5ifOt7oi4bdaiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(426003)(26005)(336012)(36756003)(40460700003)(41300700001)(86362001)(4326008)(8936002)(2906002)(8676002)(5660300002)(6916009)(54906003)(70206006)(316002)(70586007)(2616005)(478600001)(81166007)(36860700001)(356005)(40480700001)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:34.7560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87683ca-f6bd-409b-94bf-08dbf63e6b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

In DDR mode, current default spi_mem_dtr_supports_op() function does
not allow mixed DTR operation functionality. So implement cadence
specific cadence_spi_mem_dtr_supports_op() function to verifying only
the command buswidth and command opcode bytes which satisfies the DTR
protocol.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 710c4a532d..282028c845 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -718,6 +718,21 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	return err;
 }
 
+static bool cadence_spi_mem_dtr_supports_op(struct spi_slave *slave,
+					    const struct spi_mem_op *op)
+{
+	/*
+	 * In DTR mode, except op->cmd all other parameters like address,
+	 * dummy and data could be 0.
+	 * So lets only check if the cmd buswidth and number of opcode bytes
+	 * are true for DTR to support.
+	 */
+	if (op->cmd.buswidth == 8 && op->cmd.nbytes % 2)
+		return false;
+
+	return true;
+}
+
 static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 					const struct spi_mem_op *op)
 {
@@ -740,7 +755,7 @@ static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
 		return false;
 
 	if (all_true)
-		return spi_mem_dtr_supports_op(slave, op);
+		return cadence_spi_mem_dtr_supports_op(slave, op);
 	else
 		return spi_mem_default_supports_op(slave, op);
 }
-- 
2.27.0

