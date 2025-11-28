Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A649CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 06:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE377842FE;
	Fri, 28 Nov 2025 07:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DMdXl3CV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DBD0842FE; Fri, 28 Nov 2025 07:44:10 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B6A83B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 07:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQWmVhL9DHO6pFtqD71iuTWcQeah8Ug1GYkfQr2EsGF0TZeM6VWJeZJiU1k/Sl7WQSEd8MXXotO57DaOzahssjt7fAGcxBugzPj96jFroMPWq2AEXJ+3D0oUCGMO1SOx5+wVZw5o45/qbC5wn4DeWBTNO0jNo6uxpgTMl0LKi5Xs4WN33ziyL+PyCJn4bp3mErvBFKoPGdvTPWMeUUENG2TxAGBr6iSvtK9JZwAzSSHpfQ0MeE6geW2UhzkBQUtlh2RzPh5QaESY5RL7E/2mCYi9LdOdBDaR9kqC+F4VtroLt0q0pZFPN/whh3HUmT5ZTRMK+l3sY+e1LabexdbvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwUKyjHdgkKVj1TGuAUY86MYknAf+l409sNdNCBbU0I=;
 b=bnAcHW2KmikL0+6ptrHqkMFZvMFaIaeso6ICQ2Vay6LUuYBdi37Pn0GFCiG+3hnp0hsDbVy+uGugcvYujbjiIA7ZHbGoqa4DXnREMImoeNSem+P5cSSOaJO7hbiaX6NzqPAU4dfGjkU5G4QuZG83rXhpNDMEeCc2fUNJqnAVXzgWFLn8r6HNi+f5mB98vpX+4nw8XxqB63UxbRvRFNQTYRquIRNQc9nnEEKvCzknivC2G3kUHgkeCTDhmXWgqVofh2Crc3dtNx4tvXaaOnUpc5FPS3TR1XgT54LvuLPA9EpIQ2540DAWv9XHF3o6XVrvbF1Nxe3mDzDwD6bp4QUpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwUKyjHdgkKVj1TGuAUY86MYknAf+l409sNdNCBbU0I=;
 b=DMdXl3CVfTOvkyUyyYSgIjPJjpzKLnS+i4aoxjal1Bj+IxR0RLMcSvzgWM9o/BZ0lBungmoT+pp+89UdW6Kh/ymRhDEaCIzgwfnSN56UsP1lRP17CRGeh6a0YlPD9qs4y1yrHVF4Z50bvc++4LhhGxi96E2V0H5iuvWfWzauKtQ=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by SJ0PR10MB4783.namprd10.prod.outlook.com (2603:10b6:a03:2d9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 06:44:02 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::c6) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Fri,
 28 Nov 2025 06:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Fri, 28 Nov 2025 06:44:00 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 00:43:56 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 00:43:56 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 00:43:56 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AS6hrRS4092368;
 Fri, 28 Nov 2025 00:43:54 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/2] Fix boot for TI AM571x HS EVM board
Date: Fri, 28 Nov 2025 12:13:51 +0530
Message-ID: <20251128064353.1295063-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SJ0PR10MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: f95f6c28-1452-42f6-a96a-08de2e498393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/FHZqCRFAIyLhi7mz+BPtQlBM+izW93/4QlopQXxTHW8zcGkFyF3SDU5NKF3?=
 =?us-ascii?Q?wUYjiz4F1C3zUEuaRMRfpOLIN8tuK1agaiGGaQsGfFcf9dRvUK5euzYKO/ba?=
 =?us-ascii?Q?LyK8psHh396igUMdbuXoUNMI6itDs/zHjNePoVJim+ZseuO69wEo1JCk/uFM?=
 =?us-ascii?Q?dBZtUzSk4JilH1DoeqU9tXCuIz3hhjUUCP7hFDjs1gIwFw0V0KTIUieeanyJ?=
 =?us-ascii?Q?lW5R5P+581+qNfFJarR9LK43YemmJ082OOaN7ukqBfpPZ/+Y9RINiYYCUzaS?=
 =?us-ascii?Q?DLBeOGz1AgF4NMV2u8lyABSNiPF5uHGqG0qwXnc9Agb4mhrM5VvRnUYbWtIa?=
 =?us-ascii?Q?Cgl5r7Mx/EbqSO0+KpGI3Q2oe+nhdfdNmz7mEfVCvAeb4PniTrA6o3PrY9LI?=
 =?us-ascii?Q?v/G5pr688ebAWeDEG6hVHk3bd7sJfNRvU9RkYCLRkFeXEee9QojJX8nPBiVf?=
 =?us-ascii?Q?1jkjTBqYSn4sXPbZki2UoJiPpa0OkjpeQ9oHfBggioxnEFiqmQW6juwJaXaI?=
 =?us-ascii?Q?ap6umF1MvGA7fjI2WQCnBGPbacKgFAGZPQZd38JwlxJjptJ1rT6+7YuFiB5f?=
 =?us-ascii?Q?/BHk8fLhYNnBWupHBQvjhAP3nb3IiBUdQWYtJTFo2bEBR+ji5QVNW0+NlNwj?=
 =?us-ascii?Q?I4l3/tVZ9qlGV8mgtTqBjYaZaKxDqDZa9kHR9K7ZngQYnz8antL9fyprdPQ1?=
 =?us-ascii?Q?Kw0gz4/kfx+Q5Fq3HlKVTDob/HLhvm4TQWBfokpAvxmIwK7JOKmQ+gnT0jcm?=
 =?us-ascii?Q?I7x3rYw1Vc5xVEGUX+vXMJiMWoVNcWemHtT1+GPqIi7cQOvM8W8Kx4b8Oujj?=
 =?us-ascii?Q?U1xRXMhYoJh5rjZPK8dyV9YPqacyW0bJNHTUY3lID2DkxozYQ22FYK9XLIez?=
 =?us-ascii?Q?L1E9qnXTyaEGjo70EadG6spANPHNCQObl7XXiQsW2tNQTWRAoJQMnZXcbX46?=
 =?us-ascii?Q?rIfxqWeyY7ysL1q36TLqIFmqRoWE9tpebQ3GOWOB/ld9AOwCbV/bvrnd85p6?=
 =?us-ascii?Q?OIzpaK0cZxEqWicsCdGrvt01hRqD+5SnYSa9WWjNyJBeiZh+4oHR2WM0bLut?=
 =?us-ascii?Q?fq0SocLaLl6oEt7woODMlxL+PnanL29ncw47U3V1zY+AIkG1n+iTC+qAKe3N?=
 =?us-ascii?Q?uM6UjIdFFALcUPzGFRq+rWqBH7zkrGeXhp2bZcq29LdJkSlVJtJbJazkOY/A?=
 =?us-ascii?Q?Fj/bbpiIiLk8JqMffKTZntm3dHRXDeypRA1lW1g+HVe19uiFBMEdfmf2GqAL?=
 =?us-ascii?Q?wP2AElsaMOJr7jeNPq3eoLKGxuAH8ngUk4iffgfChIrnjPs4TZ9rFRvoA+N+?=
 =?us-ascii?Q?y1s5eM8f8cNQ/59cR4Ar0/8WGORhuGi/bCbVzBvArcmL4e7UPDIYdcsepdDZ?=
 =?us-ascii?Q?+dOCCtvoUAIG5QF8RMqVJfeaNTrujQcQuqVGvRB+J8Avd/FekAag6b8NPspt?=
 =?us-ascii?Q?Emb+h0sFxj0KnDK8r2v2UQGDY4IjTR7zpOojGUuQ0afU8lKCwPVNsky5dMge?=
 =?us-ascii?Q?6JnqkVRV7mdKj2tU6gd/755/2ldLatYXRc0d?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 06:44:00.7027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95f6c28-1452-42f6-a96a-08de2e498393
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
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

The AM571x SoC has 1 GB DDR space. As part of normal re-location process
U-Boot copies itself to the top of DDR bank. However, on HS devices, the
top 0x2500000 is used by PPA and is firewalled. This results in an
exception and the boot fails.

Fix this by reserving the top 0x2600000 memory (aligned to 2MB as per
page size for ARM32) in defconfig and devicetree.

Test logs:
https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66

Beleswar Padhi (2):
  configs: am571x_hs_evm_defconfig: Reserve EMIF memory used by PPA
  arm: dts: am571x-idk: Reserve EMIF memory used by PPA

 arch/arm/dts/am571x-idk.dts     | 12 ++++++++++++
 configs/am571x_hs_evm_defconfig |  3 +++
 2 files changed, 15 insertions(+)
 create mode 100644 configs/am571x_hs_evm_defconfig

-- 
2.34.1

