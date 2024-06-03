Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BC0C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A88888245;
	Mon,  3 Jun 2024 15:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oBvamhxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89E6A88282; Mon,  3 Jun 2024 15:09:16 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31309881C3
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgSU/ulqJEuF76dZDiV8dKrElTXn5TegqfXzdVXZDG/xWdu9rqvWGEUirI3xWPJ7pd3Reag/wA20Ve2mu61ywNWw2soLWrny+3CqXaOBbzK830H9FhDwDeUoB0XwHC6xoQCdssUEMpIGhNcBoj/r4MXW7yVuYFnmMuv9by3zVF+v29nwJezuHWyetNecCVye88NzRqrcY/3XQP7LnP4b3p33upUoqDafzo9TXxB5DENUUlgsg9zymqCDxL3lmYnujJ4ZFzK5Nl/wLpRIpEni9K5YX3TdgGeNa8KrAP4EfBfybtmgj+2GLpTFqq5Sf38a8GY8+5YKRBzCHU3y9czRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuBn4pdPMwIlNV3vMHbhEf9e/6YT4zpWpcoJJ1Q9dWk=;
 b=LmacuBf6NBnneZ+WLAap/r8atUOGywO/1LBNKD7C8KSDKOGRwNlaZCZSxFUd3ktIs63MNx5sD/rbvlQZ13sLSwylpWfsrXbPBeOk/SbwZZV6bc7CpPABekOcSyUv7OkgNM0v8sQ60yp0F8zZl0kC8C0Neg0hARVZ3KVT7rXX2w32curi5bJWFIYXw3HU2Ab7PbvZlHppGP0KuYwK68P1gUl7T4ZKyItnSSfWETo/SNSbqNXY5T6FYn05W2IJvu+0iZI8qhIEntVYs1Az5xhqC8XffwZyysxh5RgWGVnOvrdx77z86uvMFGh4Vbob/jlKW9sONDnJoE/aqlqbTQaZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuBn4pdPMwIlNV3vMHbhEf9e/6YT4zpWpcoJJ1Q9dWk=;
 b=oBvamhxBqF8GsDajL0KChOYBqM5b5EYFVGbp3R7CAvnQk2M4dKEDDuAVVoavJLhJ4+J1C/EhwTKs70v+szJaawNicWRNKaCpv9eJMl0F2zaCFpzjFvZd5G96icdZPT4U0HCoDpSQHJ74pCxAxjotndtH0U4kaWYFMP05QsqxvzE=
Received: from PH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:510:5::22)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Mon, 3 Jun
 2024 13:09:09 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::7c) by PH0PR07CA0017.outlook.office365.com
 (2603:10b6:510:5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Mon, 3 Jun 2024 13:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 13:09:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 08:09:07 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Shubhangi Shrikrushna
 Mahalle" <shubhangi.shrikrushna-mahalle@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Setup multiboot register to 0
Date: Mon, 3 Jun 2024 15:09:01 +0200
Message-ID: <edaf714a778bdd7447533a77b3455e4fd623f9da.1717420131.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BPC2B2XL8SS7RNS/gCR8OAy3fzQjlcXJ50P9eU5jWcI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTYAymPNFLi1v0Nan76NdPqmfLTfJXp4c0/ChncF/TcU
 PpccrekI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzEoIxhnsKuVbx2sQmBVTfm
 v7p6f/LHr5c5rzDMd/t7vCXJwOjvvuMRX4sr1jAy2sv2AAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b03eb9-d728-407b-80dd-08dc83ce5ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dYExaYWwfpCZM8lKIzKJDQvVYsRg76OkkAIYYZAotnYwJjyH9VvxXEl3+8au?=
 =?us-ascii?Q?kQFCePcl5z+/r3NB66l4uc6ve/VOLgDVm1ioWBHuykomt3TsVX8AEbGyYaht?=
 =?us-ascii?Q?lczgZp347MAqkl/X0klErFM2kkuAFBB1U3pIfqY8vz3kHUWkN+DTLaf9+Tvs?=
 =?us-ascii?Q?vqZ6QGHSl7CjHwefgRgoER88sgoVD+oEHRMqtJJRSIxyEzl/R1yFatZ55sMx?=
 =?us-ascii?Q?l19XXGpZsKd8UdK+CFuVIy5eYc3GQ5lCbfk1moqUJ/hF0x/fHsWHbpL2B/WI?=
 =?us-ascii?Q?tY6trNdMxbcd+8LQI22e65T9G32/uhAjioNHIBbuybmgA7kR6+VinIXoaSYz?=
 =?us-ascii?Q?UTDna5uZ2fierNkkG25fVCq9Ev7zQQQDd7KlkcA+6a1bjKXG01ytQdVonSaf?=
 =?us-ascii?Q?5CnLxCXNMHCH3u+OZTkzKpphM6yBzfLMDxJgwiFNyH/Dkslmbxi0g1ZymvkB?=
 =?us-ascii?Q?CYB8xSubleViq3BqAM8k+S4Y2+GukFopUp40owp9rTYRDUF7MZeN98Eh6Tgg?=
 =?us-ascii?Q?EUc4M+7ViN5cBk8FBEMyBfHe+7nRVjdTUgkxhoJM1tr2E2smtVbhSO6zKrEl?=
 =?us-ascii?Q?GR//hrC3fyo6USTTkJZhGXToOquiFRowVQZOxZ/jiNXH4Z/PNE7azZlmHSjj?=
 =?us-ascii?Q?OX8oPiLji9YVKttBtGaGn982awzV0/PnqWDkFtb8WIcNluAgsa2w5PYid53l?=
 =?us-ascii?Q?oamOktbUrgo2qL1qPKfAJPbSI02opziGn171Rc5bcKlKH4M9zbVs3q+q0prm?=
 =?us-ascii?Q?ZG/6/fsIrAu2SWJYqXIHy2OpQJry9WgFVbyLbt2aULppyNMQeYZZ9b57E6gZ?=
 =?us-ascii?Q?/V1351qEYLbZ7VtSOlf8BcSzPwTvWjcqL3On/Pb0UE82zUtokdgLPJXu4+G9?=
 =?us-ascii?Q?U9knXS1Oj1/OSx/xisQvS2Yet6jSQkvVZiOJ3D9MHiAua43zi/pTQPduBfo+?=
 =?us-ascii?Q?Hr8+UNIIOxovvhPwPMlf0hIrbvVpzcvNE/yhTGDqaEjKqlWVd7XfA3q3uA23?=
 =?us-ascii?Q?0m2ZW00iOixuHBQPCUpJYSI4KETpVJDoZIxEh2iZco2T9Nfq0Ixl66s64bZB?=
 =?us-ascii?Q?zNzhJHvKRVkEvIsV3i58pWI1TFEnd90F92gnnYEnDHtip7cO8jCxwL0UTT33?=
 =?us-ascii?Q?UM+HBLdbKCV6SfSGd5gyp8HWDiEPxJeIg3BHHDAsZ+4WTCGocdJ/rRAbH5ID?=
 =?us-ascii?Q?/EbSbSYKQ5t43mC0Nm4s9XSeHB3pMi7/PUmlk41ZpU4TeYrGddxBqAUc31bf?=
 =?us-ascii?Q?5nJJ3+HKnY+lZnppYelFwhzYaRllG06j3s/L+282COgtBVO6YGHn47hTgVFy?=
 =?us-ascii?Q?J0EUcxikMvWHmc1G1lwJCDW83fw2o0DlmtOSgW+elQf25oW06vP7cmrDQ8UH?=
 =?us-ascii?Q?TtAkvDY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:09:09.0125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b03eb9-d728-407b-80dd-08dc83ce5ae2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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

On Kria when board starts from Image A or Image B partition multiboot
register is already setup to that location. When reset command is called
board is issuing soft reset which start SW at already used location (offset
of multiboot * 32k).
But board should continue to run from multiboot offset 0 (start of QSPI)
and call early bootloader every reboot that's why clear multiboot register
to 0 by default to go that route all the time.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 846eceb0118d..69e333c53887 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -65,6 +65,7 @@ kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw nod
 tpm_setup=tpm autostart;
 
 board_setup=\
+zynqmp mmio_write 0xFFCA0010 0xfff 0; \
 if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
 if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
 if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;\
-- 
2.40.1

