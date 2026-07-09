Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC14C44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 09:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DE184AD3;
	Thu,  9 Jul 2026 11:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hh04Trk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B65384AD7; Thu,  9 Jul 2026 11:16:20 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2158584A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 11:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgNMu3JRe/iG1Wjd4sa6d8VoANyausuBEcDMy4cQ2lYfG6d8o6nDg1u742xzYf5isRJ/701//3V0EfuFU9zCeV/m5S6SQKjBCicdofkhhswKtDlrWI2CVbnfln86pel5++d8xP9ILnSHgVTBjPKYmkXoPHmG8ocNZCQK3p8FvqUIw9BtnM+JgPPJ3S/niJuJFzUkx0la9PWc2AdcRzprIZSFyN+wQSlSwOrEgv9lN0imzRiYuS1N/QWGDhrz6cWprCBySXfIBhI5I1W5Y8plwvoIYnVzlvgAHoUFZfVkyIq4td9rbHGEdo6CLBGyom0vGphxl8TULDunKS1eQYE2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5465bHJJyP1IoLwdRu/0RjLw+Ry79ZAtGjl3uF0qwU=;
 b=ciV/3oQUHQHpWDJd54pt/HZOYzM3v873L0C/ETzdjyTLtN/6AbX8eYkmwjNNY8Mevi2sEPJATwVyi7WT8RDTSdKTjaHGdAxcPDNE63/hhNtQyzFE7wftNYIdPiLityuC/a7eVrczhKh7C7Zsc9P0YJzO28J9AHmXr0Q5fypJWIxejLQ+adEOzrRgtr/nqXQOZrYU9/LlXOkWQt3ScQGeE7380RbLNVWl0Fny3fvFxST7VurqE2VYu4AlX6Mv1qBtSEZmv+4vAK5SMzh/rR0GuhCpfQhj/9m5QnBmuPVsB8NBJET4fjY/HfFQrdfcrx9x0xoucTtzuVc+7TeTH5+Y2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5465bHJJyP1IoLwdRu/0RjLw+Ry79ZAtGjl3uF0qwU=;
 b=Hh04Trk7lWp1AjuH5MPHjXlGi+uPxdSnrFMuP1bDlGeZqrEE8Dw5dw5kDznHxEFJUu/AflMTf7+ttTXkYdL9YOhWW0q/ZDtEreiORZZ4P/iLI1aCuSeDFGJjo0bRjX8EwVE0ORx+iDJlcj4llbySbMBlIyD7zY01+tO9jWnCZC8=
Received: from MN2PR11CA0017.namprd11.prod.outlook.com (2603:10b6:208:23b::22)
 by DSVPR12MB999124.namprd12.prod.outlook.com (2603:10b6:8:38b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:16:13 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:23b::4) by MN2PR11CA0017.outlook.office365.com
 (2603:10b6:208:23b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 09:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 09:16:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:16:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:16:11 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 04:16:10 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Dinesh <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 1/4] i3c: dw: make resets optional in probe
Date: Thu, 9 Jul 2026 14:42:52 +0530
Message-ID: <20260709091357.1860417-2-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|DSVPR12MB999124:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e794345-3f0d-4138-4cdd-08dedd9ab904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pC9fYhB0o7F4hgu+yypBJFFq9oSDJkdOo/1W8HvtMgWb6Cf5ElicoGNueba8GY6sUSUgioqyEySxc+ue5CYvX438S4Uu7vNchLPQeZ3gmIdU4vLjcLz+UyQrQuZRwlpRDdqSA/aHeD3xsqpxudgF1Imncst2s1zuTjLTelKcgp9RPErHh4xmSkYAQg5fkNjKPm2w09XvlvJPnGYH6VGwuxkmcbF39Z/FuhHS53ifPyGr1aQLtXmgdMaziN9sVDtiqRe3wJ3EEjTA6BS+uNdlbi3GriOO0+LKC/miuW35acO4qJsBR7ucOy4xEWxGhkfCkIQEx6k+tRsjO9HZmiFnrET1cpaLjWmnYeuIffCzoKf/Pc25YHQPL+hofLs5TOCc6gj3V4yebtpjdAYhbBn4QGRzgD6bngf7im0Z5FdsVOBTyCx6CDPlWBhZqrPKH4nUHMsPPgFDbAn4i+jX8/TiZdzkUlh7B8G40kTsucZCA0ZeLn8RTpKbCcp41w0+zUrZkdD96zwn0KdiXDS+LaOLl3yc5uS9/Eek/95nLBQv/oxgmW7Aw6vNU29Z7zioIDj6Ga5CYdDbR3iwWWBtgxnNedfdI/d1zP96LvBYOyl4+bK8zv5Bxn/S+KxU89dGnzXLb1+hIRPEuoFec5QoUwRrf3IuoLzHTbY00aWO8lMsANPCaUr0c98+1hGhkFk5wUiVovts7UQmVNYyTIyoiO1Zdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GozOZKV6dwbm8BFR/4bA5IjI+6zlli+DepMzcqxGUE/sb+trEy3cxUGnJSQJlJhJjDaxas9P5XAPE7EfCcYRy0Goube1LEPx0jsI+2WIoNFbcgoMgO77jtU6WGeC8GpwbtlhrWachyo+Z15spZ8TNWl5IRxIVBweeNRGN8N0P28TeYxq114f+gL3gm9bPPGfTRCnwONwVyAqITmR+X6uV0MQuYXIyo81sCCLIyawC/kgvs694gGD9SIG0IOC5FIVezB0G0ffOWi8NZQmlHVz1KlU+I9J2Mx2te4D0LHaS4tddgXSA7iOc4/vaZkz8JxD+dZT4G/tVzP3h6QHZPF2qnzBA9GEm0z1rq5W7VOcmxFp5mUAd3EgW6DVzSLT0gyI2hfYZfy5M28LJXVB6vb4u5iHOJDguR5DOlRC8j8JQU64DAnckA44L8uDby9All78
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:16:13.1590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e794345-3f0d-4138-4cdd-08dedd9ab904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999124
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

Treat -ENOENT and -ENOTSUPP from reset_get_bulk() as non-fatal to
support platforms where no resets are defined in the DTS. The resets
property is not yet documented in the DT binding.

Fixes: 1009c96f1590 ("drivers: i3c: Add driver for MIPI DWI3C")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 0c4af7e528a..c6ce54a1d3b 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -972,7 +972,7 @@ static int dw_i3c_probe(struct udevice *dev)
 	}
 
 	ret = reset_get_bulk(dev, &master->resets);
-	if (ret) {
+	if (ret && ret != -ENOTSUPP && ret != -ENOENT) {
 		dev_err(dev, "Can't get reset: %d\n", ret);
 		return ret;
 	}
-- 
2.34.1

