Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F155DC19F4F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 13:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62BB881BF;
	Fri, 26 Apr 2024 15:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PDAJG85k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF833881F4; Fri, 26 Apr 2024 15:38:36 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE12881BF
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 15:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMgY3uhc/0p3YEv1/p+8na4fUHohlrsuC60G5LDNT/1Vh1gOzHammEhzE/IPSY7ZE9dhu8cAMonOnkClE8UlPRLw7LekAFnR0mKGNpqExcOdul2wT1BQuaQCVKjYNN66R25ex1IduEfnKJUFF0r73VNN740r+a6qifBhnb/yUuoKUv7UlcfVqGvrXWza8+nQeCvFpL67NV1SjQZ4p17PvQq2tw7SNp5uCgpXuHSiMUSWLj6lOOzq/Oghplj5D3KIzzzVyRBJI79zD39uHkSubl/7PwBZ5LfllAhgJE3cdjPD2gOdDEAD7G9c3xJUcTwNg0lf8eQKcq9Djbtp0Rx3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61n5YqOPfwgAzze3uNX7s60EpBB3B9V8w2pYtZn+3Tg=;
 b=G8MYcSLSK+tUts7daH1rkfnYA2rBMX+epB8pDRLVP5IKeohBS522+9dfd0hl+T65RDswoD6b0dtlaKhW/Oye16mE4SdwuvKu7sYHeUP6HF3jDmL+Aec1U+BACGj2GaxCA1tfBxjWUABCjm95opchLMKVjHJg/1v9Cr9GnwSqR5VGKmA7vDqSGfCt0G5PB52RxAPxkRdcAxNP2hZvYV1Y2d5V91exAy+MN3jz3MgP5TWdesAY6jBghP7Lx+ZDQQxN+0uS/TXQi4wy4B8x7nF3UnBqQRNKoY5KZrRDlgKheUN44HlckjQys8vMds3WmFjZEPX/EskSn8aB/ZimYpq0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61n5YqOPfwgAzze3uNX7s60EpBB3B9V8w2pYtZn+3Tg=;
 b=PDAJG85khdnlHcnG5uz5B42Hs9+kCxkT0WIwle72yyM1F2ovlrBUhLDmFQ1Gwvw+yBPP3y+gytJr4E46x7FpjgV2ZZI6sU2o8iL+OY3d0CKpgrMJJre/lXz/bSs2fbFe6cQVOKdTaZnVQlWOaUts8pUCXjFu/aD6OwxYHhy53DU=
Received: from PH2PEPF0000384F.namprd17.prod.outlook.com (2603:10b6:518:1::71)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 13:38:26 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2a01:111:f403:c801::1) by PH2PEPF0000384F.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Fri, 26 Apr 2024 13:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 13:38:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:38:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Martyn Welch
 <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/3] xilinx: Enable SMBIOS command
Date: Fri, 26 Apr 2024 15:38:11 +0200
Message-ID: <8fc5eb2301e6d1f1851bbf5d175ad5770d7ece6f.1714138688.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714138688.git.michal.simek@amd.com>
References: <cover.1714138688.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=oDYZnWfz63Y/Rt7+di+9wYcJxqszQMI8vGYVkaS5m2U=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjTtdR6zuqZ9PSMWkpKxe8PSJ18XJOm3pPFLSt47VXVuc
 3dyb/3tjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRmM0M8wxbt7ybv+uhkKIJ
 Q/tbYZdjEc3xpQxzJfvSXv19mm6r5Xy965fkLWkBmedvAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdb6064-d571-495e-391e-08dc65f62654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jyT62qYuvFuqSP8hwCPmPWLIKeAxkCkUo+xRE/r7v2btFgSsVE/rnQPBEGWT?=
 =?us-ascii?Q?nGpWhCF8XtIMbshJl/d0sR/wkRQG3j8ORsLKBIcoAzU8rroiGgwADOq5qM8Y?=
 =?us-ascii?Q?w7W7vWK3nBNAXkmeInVNqPm5ewd+GhA+ee65ixAoBo8l+ZzHtKq7+QZOCn2l?=
 =?us-ascii?Q?zQOD/C5bsLIEJA3ozYJTT/oa3JCgn3whkVMpwP+e+CnJqVW4OITPudVb83De?=
 =?us-ascii?Q?JSVewJmPjSG/1+tteXOs0YoZeLTpQwQLrEtssY84AYFRrvHjyK5q0WmdquuW?=
 =?us-ascii?Q?ouhyssESyWUtgUh0SxlB5zW29mZro1iEPlsuVYEpQzXacWx30iggybJqKoWS?=
 =?us-ascii?Q?Hx7io3T5v+Dv+ouwrep2joIUyI+taIHGtFz8rFbvFRs49Ce5AJG/EbszMk/X?=
 =?us-ascii?Q?qqaqhYWFDnrYGXqgZTpWiph78KqToAXxuyZn/MdM6sapztHTCO21i6c1RC7Y?=
 =?us-ascii?Q?QccAoFVN99kN1xYM/9ji6rkcLOz1/tWxJHy18h6uXjQO9SyeanjN+s1FuWE/?=
 =?us-ascii?Q?hY1cyfCHWp4sIecc3JHYsUO6a2miCONTNjm7td5Xz7Ddl7CFfnbkUunAzPfY?=
 =?us-ascii?Q?F+Yq/uIZzU6+54z4BCZF2swap5KSo6mAhyQKV/kOcjCQ/mEppfkOq+nJLJ9J?=
 =?us-ascii?Q?3E87F1+ZrceO56LG1nGvnEz74zU81PvjKaEEa/w5bQ/0iX0mio1/cRWCe9P1?=
 =?us-ascii?Q?Hvh8iPTD6avUHy52eZSx+Rn2doEhEjJ2NpUlCu9YlDSI3py+mUIzesWMNqjB?=
 =?us-ascii?Q?Mr9xiJOYfaH0Axu+EnHiDomp2sLG8cC1kvHJUDJQXnzqOtN7vqCQ8bl5tuvL?=
 =?us-ascii?Q?YkimJoFnVYJktAmA1Ti2qACmjoeAnPYKx0byxIahDbtXFcVRkTkqCnOIiR1i?=
 =?us-ascii?Q?cLZWcLQi+2I+hJDLV9fgdKUoy6U2xiK3Peyjf8BhVRCyUN8B8wUKVPNwJ/WD?=
 =?us-ascii?Q?WZ3Cxuq/mA21y4VwtGEA5xEnZpvuEWqb5UT+zvcKd+1P8Cn/lJlTGw74yYPp?=
 =?us-ascii?Q?e0HjnsUnZw+A8qBLWu2dzR8BVbP0+URdOueouHctqbrKUuIOg19o+R5o1ER3?=
 =?us-ascii?Q?B2vIG8xxApjeIwGbGa3MSTmxAa6OIEsGIVCsUcvXS0obOjOT2qPuJHiPFQl4?=
 =?us-ascii?Q?aqGfNbmBjHi5znTGLxDBQ+hoDX0VppaK10AlusXrpKySCEcUlkxdMYAtNtku?=
 =?us-ascii?Q?5OyO3egYE+MOQgDxnFL1gKHc0xyAYStMcH4yo4DGGBJ3kDHmNzH+m9nvHviw?=
 =?us-ascii?Q?nBWJWsYvunGRILUXRyRhsL6w+kVAEsmNWCvLjsgKiMSan2UuTYRZwuAcUES3?=
 =?us-ascii?Q?Xi6nd2o+NOmjvQq1YtNU4zBcsYxhMj3MtozcR95+ATIUOboWWrwtP2cg0Ei2?=
 =?us-ascii?Q?+syJsDk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:38:25.7931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdb6064-d571-495e-391e-08dc65f62654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
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

It is good to be aware what information is shared via smbios interface
that's why enable it by default.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynqmp_kria_defconfig     | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index d9e2e050ceb6..3c7e37d7c81d 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -26,6 +26,7 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
 CONFIG_SYS_PROMPT="Versal NET> "
+CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 95a671db363e..b7c3a4f96416 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -28,6 +28,7 @@ CONFIG_SYS_PBSIZE=2073
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
 CONFIG_SYS_PROMPT="Versal> "
+CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 7af8b27be931..41798ace6bc9 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -54,6 +54,7 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 296adf066b10..772209dd6b1e 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -52,6 +52,7 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_THOR_DOWNLOAD=y
 CONFIG_THOR_RESET_OFF=y
-- 
2.44.0

