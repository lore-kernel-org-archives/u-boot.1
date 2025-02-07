Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B84C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C98FB801DE;
	Fri,  7 Feb 2025 07:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jDUi57En";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEDF580786; Fri,  7 Feb 2025 07:44:04 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9585E801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7ba0xMpd5TT5m0KA+ByLb3HSlZtJKEwlqBEaMAcR0CtB86YJWFNNrDcUrUMrRcSei7YeZQhZl28ULVDcJORe1wKjGdcH1b8agTuvCN7/eIf1nLwMkfWEh1MO6V92taOZaxnvRz5si8qU1VXr8i3CqAMiW5/661uwudDH/R78mb9V9qHC3MvwE/mfeqr3xRsjhkp7AfjG5HxUvNOY0ktm5X3DxgRXIl5G6PMG160jiRsG/UX2qZna41GFKLYKQqbw5CUnb0DGdtvgjTSJOTppUhXrtmUoNedkeSPR7WytISLnm8C54mN8TKZ3cRI73LWqzW8wN/5ctTpruZWJZLUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrG85J1mRXQ6Sm8dNatnWMtL/pmk8+3MkRYK5bjsCfY=;
 b=o2yZ3+4i8gVWH9AqcK5cvd5tehZuyD45fdzrQCoIbQEkCGi8bwbtvxTBQqw22QNRvfelVZB3R9RqY43SFTMOY1WrGJ+oPJ464gUObtzSc4sW+aW5kA8IhsDuFA7RfpygKzENAZvCwmgIOrNrbCqpq59h06YAvTv/DANxQcGdpw0u+vPsZ6H+qftcKStt4nA7fUFYvd8jXIQ5ljrM5HUiLy6ITyx6Wbzo5TJBk2CB9A0PMIEIvD4Xsh5TUHcCeWSfLPA6kmW16N3AkctNcgRGD6sKoartiydwbmWVaL2d+6zcYgBNU1A0c9JrzXn8l6XUsB45vL4VHQ0abnO8Wqf0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrG85J1mRXQ6Sm8dNatnWMtL/pmk8+3MkRYK5bjsCfY=;
 b=jDUi57EnuN2IYtpCxQ7SpqIY+AwdvHCwIKD7g5/EKwX7/u+wgYQPOX/c72xDr5A1aGqHHHL11D3KwNbto77fRWzp6DC1Td/k9MidhLxrsO+gP1wfipgxKtSSFwyczmPcNclwfacwpANwh72gMqNmEE8NqvjLST7i3iL7vADo4QA=
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 06:43:57 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:33b::4) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Fri, 7
 Feb 2025 06:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:43:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 00:43:53 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Srinivas Goud
 <srinivas.goud@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, "Tom
 Rini" <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Enable mkfwumdata tool for a/b update for Kria
Date: Fri, 7 Feb 2025 07:43:50 +0100
Message-ID: <641e7759275cfe673ffcee2000a6c34224f0c5d5.1738910629.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=567; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=eWz9vF5paxa9RGgHC6SBmSSWzIpgyHAt04YzHR8usxo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSlq5c/zVv20Ct5ec2X7Q9u2cS5NUXNfKNo1rT8rnD1X
 63ICXIdHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiiscZ5jvpHdl5s+pA7dUY
 j2dlevfmTnNUO8Uw31k73UIvRf8ExzWOs2EtV7T5UydyAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd7ff42-e984-4da1-07a5-08dd4742cbf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SqEMWllaq2ee+IjaclILKGVdUMdH180Z6pIBPrL4GPhnMvCYQyoJnWl7woS8?=
 =?us-ascii?Q?K9tXT7GdnmbyEe7Y4c1JKpuksSjHYAZSsoil4JS0V3j8cHmg27LbZg8toEpd?=
 =?us-ascii?Q?Xq909OHrwgRiFRCsLDnLJg13OnEuwGRGJQTrxQw3e/NKbcbCvApjRkrJ5CPv?=
 =?us-ascii?Q?5DfD2aSn68IAcuH6Ta1netGP+ns4hT7V5ph0NkVAecbucDOcv/8xzuY8BHX9?=
 =?us-ascii?Q?+oIGhs2uQIMVjo7HcgfEfW39vzqS/Vs07KEChb7fRi5SCCxY+tJ2a2sksEXG?=
 =?us-ascii?Q?fsVjs5NPNEBI6DT2w6FgW7PUA0myuqR7tj+pD0lFIz2USjqAWmhXKmyGdn37?=
 =?us-ascii?Q?JENpbofGs/p36LPghyN9mK1UPFO0nt+UAxJKoXml84oGN2H4GQybAoMdsnEN?=
 =?us-ascii?Q?azwmllAJWRfI9ozMMRGY0gAGcK1eyKEKUl2pa+IiiOkrn3kZn4N4RMTOfSaH?=
 =?us-ascii?Q?WMYb5pUSaRsS2Jfh/qYnxEpSLlhTDJLnjax3tra/XwafdC4QdLlDi2t6odRo?=
 =?us-ascii?Q?SvwaF9yj69PVaR7i5MjbGWlHBZMxrrsCOSHhvVQ+xWxb/0Obkl2JDo8WnRxB?=
 =?us-ascii?Q?WyhxrxOqVppf3GRJ8yFt6apyG7wswpnVPL3jiZtpZ4IgFf/FH1gMdS7V1Q8h?=
 =?us-ascii?Q?tLlOFas7sXY4hcCHf8TfMakXxRYINzQSHmqRWV/NADdzC8O6/7nLp5e+zFrZ?=
 =?us-ascii?Q?j4zqQDv4XkFlq8y6RT067pQtGnmYKQMlaDe0A5abZYOBEuy8HQxw+aUJPovi?=
 =?us-ascii?Q?J5b+lj1HkdlocGiekdcThdQTSTuHgEkkUHYs5KEvaEhVjgBaWYkd4vw72xDZ?=
 =?us-ascii?Q?mZZpl0xJyxxEZzsK9yd1hip5PT3wHia+M9mlqeeiRzY0pNCZgiS7ez/ox7pl?=
 =?us-ascii?Q?tKsjEh1qEmjbxP3/Mcpn/FsskOUQxH6+VbyV+AWBLIOPRobkloieCmIALXeB?=
 =?us-ascii?Q?dobQcg6lySwkr7EAr6QrW51rGMZf/cLy6gejPUH3WiLAcxWBM38rsq7q0Du0?=
 =?us-ascii?Q?a15Oe4Uu1sM/D9S5xOIRR28V118iiydllJfDK2DFWBhl+uEeBxx6ROb7FF4d?=
 =?us-ascii?Q?X6BmbTpnJ1sMxVbaNFB6evSRASYg/eoUhG9DTDp8N4KfIv79ZvHT0zIr+1Ox?=
 =?us-ascii?Q?6yGuC9WlqVZCSupp1DvV8yiszd1uZopdTrVkvS6jG8sRKSNWYrpjvFw26+Mv?=
 =?us-ascii?Q?OPCl+zmF6bL2+Ec2OSZmIhs5+o/9YHL/2grbGjmEiFbLuqfXheUNO/OoD4iu?=
 =?us-ascii?Q?A3LQF1V4tITgxy20hECktd5sSmDG682Vhgz9yxPjrmTdTTv0Jsth5ynVQe26?=
 =?us-ascii?Q?8005cQlHAderZuJ/TUO3yBYADi+0wr3BnKn1Fsz5//q4TCf1jiek0Ja8/+1J?=
 =?us-ascii?Q?R+xMCG/4TFjZXvUZcZyf9M5mp56RMrbbswyannhwDBVWaLPLV1knLzcPQe5Y?=
 =?us-ascii?Q?zNedddPnMICJN6sdsUBqkIO7b9aP7PRs0v8JFdJhV5RgZsM4if8UFHHMSibD?=
 =?us-ascii?Q?kbDnZ0Ht/f+o58Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:43:56.9966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd7ff42-e984-4da1-07a5-08dd4742cbf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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

Build mkfwumdata tool by default for building ab mdata structure.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_zynqmp_kria_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index ad46c091c4a6..1e8ec90ff533 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -224,3 +224,4 @@ CONFIG_PANIC_HANG=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_SPL_GZIP=y
+CONFIG_TOOLS_MKFWUMDATA=y
-- 
2.43.0

