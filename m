Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB551FD7F9C
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 11:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F22183D1A;
	Fri, 27 Feb 2026 12:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tmvn5Vp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7731283F00; Fri, 27 Feb 2026 12:57:54 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49EB783AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 12:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beRDJ4asIxvQGeD7Tbgpj1PgfCwKuXfAl47Ot92tR4+Hxvq5YzEG9CUpFAcSGDSdk/JUuk4tCTuczWuSBHXYx9IbYox7UsxVYYPCWwooPk/tECi7wSLM7mcgeo4CPiJsEJzFf96Pcla1T8BRNrbQYs1JcLW/mGVpJzzJQXXtVnbQFJNCsc0BV+dr+uXQPYkOWHg/nrgQUyZ7IxvmU95u0VrjWYn5+p2d8dIYRJFpeT2cU9+QwOIemdfPsacQmpez1bOykd3/w9eUxV7XMji21nzET6E6F0wEgAXDUd8OTcpa9rnrF8FoCWhKYSBJPAuBTxc5lfQohlrBzmbX+3YUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0B88vsUzKHLNXiJEYKzZ9g+rSq/aLOu4GkLzj/a3ko=;
 b=TjVJhJZrSTY/AOSukS72IaSJf5y06c0cfQ7GJBVkFwh5vThad0aSrl/LlslSXdPPORrZYDcQ3JdxxaLlG1dFkznuZeS8OB7O/ofq29c5LH2RM0cx5X8bkJcvZFBsvJGTX0W2eaIMQ/1ThldhcUKUhxzTkCO7qqx8hnRWhc4Z7tv2w20Xoc8m0/RoH2n+efNIy3BEGP+Ufr0xaxvCt9uUIcujxy2W5l17kKR0/d4Z5A0XHri5xvFOAk1ok83D1E5MUxWMzypwhcWQBH2qoX8TI957tjcQx56ym5kMNakcmrqUNZf9N+lTbRMSbbpMUgHXyrAojPOZuDFSma+NF3i9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0B88vsUzKHLNXiJEYKzZ9g+rSq/aLOu4GkLzj/a3ko=;
 b=tmvn5Vp0pRJ8KNZ5k8gFWjb+JVAYH5mxOe+/Ng39e2YDJzXAO+vSA9O7VmqnSLlKS9yxvfxYVedC1STvwuG3Pmi03dQ1PjkYpDAP7a0WO+Od5IId8Hhmcs34YXim1RRw4hYyYADyYxgN5ZM8HjHsJJ1eWMgJCbOghTbgVJ6to00=
Received: from LV3P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::12)
 by SJ2PR10MB7670.namprd10.prod.outlook.com (2603:10b6:a03:53b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 11:57:48 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::ae) by LV3P220CA0011.outlook.office365.com
 (2603:10b6:408:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 11:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 11:57:48 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:47 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 05:57:47 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RBvApd3689228;
 Fri, 27 Feb 2026 05:57:42 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <anshuld@ti.com>,
 <d-gole@ti.com>, <n-francis@ti.com>, <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, 
 <afd@ti.com>, <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <a-dutta@ti.com>, <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 6/6] configs: j722s_evm_a53_defconfig: enable 64-bit
 addressing for PCIe
Date: Fri, 27 Feb 2026 17:28:34 +0530
Message-ID: <20260227115841.333073-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260227115841.333073-1-s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|SJ2PR10MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc7c734-71b9-4bac-e609-08de75f76d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|34020700016|82310400026|376014|921020; 
X-Microsoft-Antispam-Message-Info: nSHgt9+PIcNmeLie6K63gYZ3WTjUDKwcJwUtDVAzZUzTZ6i2IFg6IDE9CDIeGeQOGW8o+xYaZbd7juwLn2UbvPHEa2h2/dv7KeTnS/JNEgP3HXJDE97qwQyjRk1wyFUI7bZ5551l4KOYYy5Fka0X2AobBesdPQ5F65aGUNUSFfCNgA7x+stlI+ODDYuAEfPlxrrqDPUqws/RTMeB/mlmNBo16WCX4x0dD9/qMMUlOfjb64hG/9PWJBaBcd/lT0Wxq7ADTXqCIkb5tBesi9AKEDArY3szqHE2kfAusr7wkibrcLfbi6JmCB5gWR41yFf/IPXwA/k8LuHYvCd4CGFb5lkZOs0fLy06VNn8UOjcz1/dREEDuZ0HdKLOIu3+MKeKREbBzWmBn13sxj3NAHbJLwHwK8o2h67bnz0Hn2lRxk4s8fQ84u2YP/A4HVxqS2uLo/TvBiGEQNQMHqHVt9URmt37NXyku39ER+zwIT/XS06C93OKXR696FDz69aaKAjX1lvL7/DNsoNgyHv7R7QSUJx6aVtL0MC6FOwR1hQYEpI1gtJAChtTn6NIHTTVzfEDtDxdYSqClZ1AWv5wUUen2zIyOO5rxSBcKgG4zXKF9iqWLD29Q2K2i6FyyL/SEd4reNncCkvlxXXpZDAKy29HLhZ+TUXlg0rrO56qdgRbHzR9HfbArtoRoowqik39Dsfbz+R4oyJia9Mv1dc6LZwNtuSuUj1VDvqNJhL6sn1rzs/4+tg1kPilx9XTUCVYYZmEKswHzluJWaYWUJLv3nSQiJ3r4LU3vLweg4O1CjuAYW9Bmo2u90BrfSoy48wX+DCc41OLgqkuzhkTfYsre6vjaoRzBGJn2hniO3QanTMMofI=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(34020700016)(82310400026)(376014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rw1/qMDS958VOu9RjRPMgz8lyH/qzYV4DQZXq61cluKDub07rIb4bnU5CecLHDOwfVqY7jRw99NfYqUYMoK5B3Ly8vxjjIM3rpYg1j0/8jXolA9OSSiuqXsJjoOIHkyW/81Se+7JY4nLeXgEVNIAXdIfF4bNINs8ho1Z+7y48LvY8Wkprys7SZxUp3KiYDJC0I++WT6IwKUdr0drk1xNwcd5aTYbRXrAgl40qRY3DBPfMWZyKZosVAkkqVsgJmxj52MFYSjOGTcSQVm2G8jn62D0KIwNDDoIJgzOF97IbKFEEAACwi1c8qx7iBmx29tEXywdViKe755lkIIyMz9Kkd0Vy29TIEDj2mHI6VAoT53WQ8BXjqVNkTZI8sHKkaLlNQIrq0TP6+Rtz8jHxAJREqS7VcCPpMj66OCmeLnso5vRkPL1NNlp8Y6HP5ra72qp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:57:48.0039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc7c734-71b9-4bac-e609-08de75f76d1c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7670
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

The PCIe0 instance of PCIe on the J722S SoC uses the 4 GB Address Window
starting from 0x6_0000_0000 to map System Addresses to PCIe Bus Addresses.
Hence, enable CONFIG_SYS_PCI_64BIT.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j722s_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index e84670c75ed..dc4b6b93803 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_SYS_PCI_64BIT=y
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_BOOTSTD_FULL=y
-- 
2.51.1

