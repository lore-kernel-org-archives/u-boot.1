Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A556FD10F5F
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC1B84239;
	Wed, 26 Nov 2025 16:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CiFpUxRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947E183BF1; Wed, 26 Nov 2025 16:24:21 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A6B84239
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVfK6Ng+qb5q/2iL3V4pdbEdlz9CL0YgOw1QilxiKrSe2ZyvBiJfkiBEDF3zpFinBVb3f5cAbgFIAJNkHhZAPDo0NMcNYzofPOTfitBhGKz23oYpiWWwW8YKZE9nwiA7XPAXjtME8P9Eqe6d/7y13WPYe8Jtit2wmrgF6/Tiwl+SnQJFTyp5izW8IISZLFA0H9TKOtVvMGjVidsxoAl+8OFyTKDO4P/FDd6Vwk/u9qS8nMEhSYItsK8tVL6agc2JVRN7M0oEoPSG62jJzU8cNSauahaaxmKNMhsT1q0Bbta09ESi+4k6z5wNQWkYqEovEDepaMLsZoZsBfJ961hkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V257D4ADP5mpQRrm4NANAkX5sphw4DoVFlQMOojIwEo=;
 b=YQPIB8gQhUpe8rPFdNcODJVMzpgH/sStWZR5QoM4j/d1HNngyUR+COxs9os8FpmomU1kRywu/iLlNgt4SU8jGUhkQotECy97tNqUN+fsyUIWmPwymy0takCpt1VAd4iOrnHdEXYwyTB2fVUpqqGxEC0w6aotutTy+2b76jZst//T4/IBWmhP/DOtsurxn0fgmpi9MezWFrkfpkPnB1Y8BcgMcNiDDiid8r0nZBL/NOB1HmrvHolwurZUFKSEMgMGgPL2Wg99jU0hxAjv8YqJGJ6lWCKdrpmzwI9wcUZ9NDY2KafXMagoQhrO1hJ4EvVH4+6nGmohMAiyQc3dPNZubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V257D4ADP5mpQRrm4NANAkX5sphw4DoVFlQMOojIwEo=;
 b=CiFpUxRu1e9UyQHtpKODzrTtK8DXhIDqNaMkBnXyFGDgdgRWOM+mGiv9VOXeAq/nm+XzkxT3jSn8qBaU4Rwu6Ib8vWGaI6hNP6KfSh/ORNI3DIkXBJ4YELSJdzlyrBaf3w7vVBjChalVSXvhN7QxxlM/j2/1BqrqUnmOhbEOy08=
Received: from PH8PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:2d0::18)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 15:24:13 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b5) by PH8PR02CA0007.outlook.office365.com
 (2603:10b6:510:2d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Wed,
 26 Nov 2025 15:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 15:24:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 09:24:06 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 07:24:06 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Padmarao Begari <padmarao.begari@amd.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] arm64: versal2: Update the text base and dtb address
Date: Wed, 26 Nov 2025 16:23:45 +0100
Message-ID: <6c6eeab25c8bc8739127fb40e1a941920d04fc77.1764170621.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
References: <edfb7e7a6e800484d3ac3bf45a4f83adfcdd1754.1764170621.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Fhx+AEPbOU50ftF3s8qnlS2NMYjvSsB74tM1eRhjGbU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqS7d3RwT+bJbeb2LSuvD1FOGde5uZjXb+i+ls+3Xxm
 1OM9PNXHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRR0EM/0PyPgl2pPg5vzwQ
 YnH3750E2ekvlnLVrFrPGad7k2fd2h5Ghg8xgkGvjr7O7cppuVwk7zGrecm81M/8Cl+srtVaFps
 0cwAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ec2e91-ed8f-4aea-e35b-08de2cffda77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0AkpE96WeMc1NcH/9sYZSkkR0wPZlcQxUpikeoRXXiSfysboSRzKXTsAv/uJ?=
 =?us-ascii?Q?CS1v8xttT8ezpXZoniQ64F2anBTbaS4frmF6Qgi2p6eZuB/bzjZvq+R918t/?=
 =?us-ascii?Q?u5r3BYLs03CJ+0XNJt1UZ0YXZ8OHtIviP3DwCqZj3mRMxbrg6S2GtMaGairZ?=
 =?us-ascii?Q?hR53okjPaj/8t0xuA3n8ma2vI+zZVl2KkjnB5oJmaPHeuiM0WgNDU9VJw0Y0?=
 =?us-ascii?Q?RE9ElmaJUe7ZBn+mSiXCcLZ4tgUAfZDzNZeS63wbvewPRj/+EJpYqQAkG/+5?=
 =?us-ascii?Q?QX09Xj/R9fwVypAEyJvVVpZnHMZWj0aRuQl0fnnQENV2E+C3N9FsRyP0xdoP?=
 =?us-ascii?Q?ZAKS7iRY4HmlTO3Noq/USLP2ijyRhnWIGTwU9QtMpArmu3HADairnbyXS6wG?=
 =?us-ascii?Q?TspEArD56P2ZQePtCyQqAcWdiQUPTm/17UTcPdIA1co7ZWVQ0mDB2lg8qLlI?=
 =?us-ascii?Q?7BTUg3jkcE8WvrgeANwvdyzclDy5QRITN+eYu5BYPmt4XklH8ja1JdEykTq/?=
 =?us-ascii?Q?UWHas3DHgWDKXNiqB902dMD7c6gjF037W9DkSNPVGtcMnjl9F5G18E16oTo7?=
 =?us-ascii?Q?bXYBwEfrE/fKdBL9FS5q+oXeP6b/YlMri5uVatJSwQ2J6qPiCkwgcUVIy0g1?=
 =?us-ascii?Q?7N1oSlpgYL2X7KjZ9OQNwbELVnjRL3ugF/sdqDPg3AnD/qPMM8ABb7dCyDDH?=
 =?us-ascii?Q?Ipr9pRYEexQhLXD0ZpQBzPWnpoHfdhJweTph//cjLZLl3cVms70P0Ap79Hzs?=
 =?us-ascii?Q?fDCy3UNEgvC5jesMJH5OGgPs3Vs06AHf4M1p6RyuJAzEX4nErCvOMVHYz3FB?=
 =?us-ascii?Q?NqMgW7WWoBI0g+ZcTrtIEsiPVCEDosLHbelHFYUVuInjRR5n6moBWSQ8fy+2?=
 =?us-ascii?Q?Ex7nRwqcZNXioa+QTHO75K/xIOGNoS5gS13kdLnZ1v/hSK0zCjHac5T7A6gf?=
 =?us-ascii?Q?vrLZ+mhVlj/g3COlkFNX/LJHpaD9A8vER8rKB0F/XXOfSlWZ/hmoAPwxSokJ?=
 =?us-ascii?Q?qouFoQcOZqGCGbGrc38LL5N6X6NlS9tLWAUxHhanVva+gTABmV4J5ERqHdM1?=
 =?us-ascii?Q?kwWjTNitph/MI0sKjEu5xsFn4JB8mGW4xcD5o4YbFMG6GHejA3e0YUJi4fTs?=
 =?us-ascii?Q?wGdceN6viYBwWkKoNLG9pVEEPxg4erSg9ME1a9o3kkv1N2419Llc5CbkLWg9?=
 =?us-ascii?Q?ynQbUkT8edx3Q+VcMDllG8vzElD6hKpJHk6m2esp/Ygenig8UOO/Y8uW7ihc?=
 =?us-ascii?Q?z0yN/3Bh10C8EzTuyT3es3HSrENFE4qlGXWvNRKAztFdNDq33KZ2cqsJoW5N?=
 =?us-ascii?Q?n/051Qif/bnEX4Rh6R63Y9wSeXzuY6/K3OTeL/XGDNBgs1QxZp+4Q1yJ9EID?=
 =?us-ascii?Q?UFoj4BG7K+OqII/yTJ6/gaVH7KpZzYaz5LunGGA9RX2x0F5MgTrI47H8HW2v?=
 =?us-ascii?Q?YUfZPgzEyHcnzGf1CU9TO6t1FBiwKUUjPS4yE5Lu4dE2vgjyTwet0RB5VZP5?=
 =?us-ascii?Q?AW99YWG1+BUuNxP5HvXZIXnbYHrlFMrifrUCV9WkjZlJ5Xkk+iHVu10twmMe?=
 =?us-ascii?Q?N28uFsCbSUMt4vQh7lQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:24:12.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ec2e91-ed8f-4aea-e35b-08de2cffda77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Update the TEXT_BASE and DTB address as per the new memory map.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index c3893fa833ac..ce633dfc61ac 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -11,6 +11,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_BOOTM_LEN=0x6400000
 CONFIG_SYS_LOAD_ADDR=0x8000000
+CONFIG_XILINX_OF_BOARD_DTB_ADDR=0x1000000
 CONFIG_CMD_FRU=y
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
-- 
2.43.0

base-commit: ba53d57c179f3390b32bc6094f3ffb5f4cde931e
branch: debian-sent3
