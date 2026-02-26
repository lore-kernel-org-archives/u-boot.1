Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD7EF5544F
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 05:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9815A83E76;
	Thu, 26 Feb 2026 06:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j1D8ulOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B482C83EA6; Thu, 26 Feb 2026 06:48:27 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D8183E63
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuV+KtNFub2KWpYmAuix6pK8w4cY7pobbfRCyTiFy2EXgI4uU77io56tMB5D6IWcmsglk7n8vBhAMB+YVPfVt2UpKTEakz9vb+WcKgg8161sHjsiPDiYpzH6NwAf//Ceu0LLxYdLPtsybcgeWjk71cTHkm1y1DTMxpFfSlmoaKA9rWnss3WUw4O7ykKTWG/k1hUn5rGQ2nP7ncO/8E4q+XoYA2hY8y+w9grGidMipuQGgsiDDnIlGUgxKgI1oBiXP/gDv2TsKP6Ijlg7YWsv64fxdXw5idWhZQ3sFFlyqG7RHibB9Mbwdq+72LEIZVZw9klFrAut9ClfYO65lDqMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRQc9BiK0DrDHZaxuDS27OdozBlgbXHVqp9mcgO7Z7g=;
 b=VyVtOfX7JbewTnUfqdg9eu4vJt2pkRBmumcDUQG4GP/43mBfvh/UAbLrGoNGWKRiwoUG1sqM8MnZkRlo1cmD/MpQR2MBntBf731fsfWdZsqG4cjDzkQSPvnlp2wRBhXKYuMbdaUf9LPDRDB1J5oFEh4EJp5rvgB8wZ18ip3jlIAyFw5g36DJ9dOV/hv5iYo6XiM42pMXGDWTb3gWQZ8Zv6iL5zDC4dF7YZr8trH703gpXy/95H+AaaY6RUhtNfp71/q2OwMhLwvL3aIJaQ2cq4QQQNakjiv5yPMHv0ZIPKAcVPZvbgRk75ht+3J2PCpbZD4D2yLS3qOPN+stlMzX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRQc9BiK0DrDHZaxuDS27OdozBlgbXHVqp9mcgO7Z7g=;
 b=j1D8ulOubiPtujsNUYtu9YzUQH8+0toLHy1B0h15PX3g/Kx9GO38fszOXE3u+4ehdErBXujAaCO+qbTWU2gnyWEwGVukd6E+FVWPfbbCS1CN/i3xgxM/6CrlJdrphBU9ZyTdGU01X1zsi4FbAtt9fNCMvUV1jadSTrKDtSAZC60=
Received: from BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35)
 by DS4PPF17DE2E3E9.namprd10.prod.outlook.com (2603:10b6:f:fc00::d0c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 05:48:23 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::34) by BL1PR13CA0180.outlook.office365.com
 (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 05:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 05:48:21 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:21 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 23:48:20 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61Q5mJTh1805728;
 Wed, 25 Feb 2026 23:48:20 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 26 Feb 2026 11:18:14 +0530
Subject: [PATCH 3/4] misc: k3_fuse: Enable fuse Sense support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-k3_fuse_fixes-v1-3-86c81c298bc5@ti.com>
References: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
In-Reply-To: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
To: Harsha Vardhan V M <h-vm@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772084893; l=644;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=jY4uFYxpVbw9jR3/CHnPrNTHbhenF+5zoKakFD/qol0=;
 b=IbBQEHEWehe1ZAqFSHqtUCCNbhA0H6nA/7lv6sfsJlOLkwuNI3uJhOdwQLnxoTURTitITTekz
 xrlF4S0z5Q4CFbUgJ73L5tlyZLk1E6doDCreFIxm/WwUrPc+mq16fIN
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS4PPF17DE2E3E9:EE_
X-MS-Office365-Filtering-Correlation-Id: 327dc6b4-216c-48a9-e32b-08de74faa67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: ICUg9D++WS7/nh7jIBUd7Idu6I9YA/0C5ErpcgXsqnwdD0GPXkbu+t4fl0TF/HTEGHoWaUuMDbPp4nv5qbgMUQ/zJMgwCCmDNTWx4JtO6yaO4LVdyhu8eZOn8QvGqXWWgActYzaFTkZZmSVUgtcYCxCvKWnNw0UbuDLCntp6mdvrqIriHp8H0qghmvtHGmN4D4OD5a9HESxtaY3egxTwK9O7o+KGjSZTyx779N0fCAggOR52rSjdPbjasXPvkqDB5wXlV5pBqeme1RV+ka2ypQ652E5ha7eBASXh8FS8d3H4X6ZNHYy78We1l8BVcPMt9vBYKL0qjrG8voxrwD3VI83e9CPskUp7jYH7bJpIO5EvDM62mFhlprVgwyzy4BLx7uAfBtLNVfyxKFGJCAJcgQfcBUPdrbSEV2XDmRycZs5Aa+sVEP01uHSsKNWqATANxyEH9WghWffXFPREE4fMAbSXTBWWg4uTj1yJgbag4YN79GOu5a25BqhFZ1P7HhdV9wLtNqV19xvCQg0TG5oTEMWGmu6QWQRk/BdYez5DcsRyf4gYmXz3r/t3zBEosbBhSR0c1gIMavPoQ6Bj4ozF5QCKrxMYgsgQyfe8zVi5+Pu4fMljtDOn0V02y8NfJwzjOGUmIEAD+xiTfqtq+h75fPJ4sD1cH/3In0GuSGshrlnhz/IShwqoI/0SPh6ghMBU236/0ps4vyerVUAzRdgTn5EvlDi/21a8WxQaTvZXR4CBWU2GfPV1ZL7gNdbVKnzrGijBXOM8GPpwaD4QH3AAUYpByPVus22GTLlq0enDhYIXZfYBBWRFXN0S2fkwL3nkLsfhoB0zapWq1SM4CI9WoQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TAux8FgfUHG24uMkqwAiT6cjAKoKHpNdHwVm09qWJiUQs6DHq3J34akJY/JG+JzPGcm1HsZcZQFH4o/JV2c4wo3lIByLtgqUFUheQHuDwAoGNMteHmx2kCb/5qBzgUNlbTIMZwzqKPktLnAcG7FQz40zeNc04FFR/Cxr9bup0yW8VHANgPJN/b1gOQlGt4Mat4oTkTUR1n8qxGAhRRrsch5LupdriXeLVFp9USOoAEvNMVVviB3K/4gv4vsH+0QRXyksecYhGEFneLvnoyYME6jdorqmqOXk47Ese8tFkhwoSiw/H6M7nhmypdAQ87GDzuzdXD7PMybBh5Mpapx2DFn3z0HS9tMSLUu76/gW1M8hBvF5sBqcOA5wawOYrGFJiihCC/ldPeXiX2yHs/bYsU9JOlIBXavpevGcvZA1gtfcG8yGFORKWKGk0FsZaZ9H
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 05:48:21.5753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327dc6b4-216c-48a9-e32b-08de74faa67a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF17DE2E3E9
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

From: Vignesh Raghavendra <vigneshr@ti.com>

fuse sense is essentially read, map it to fuse read.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 drivers/misc/k3_fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/k3_fuse.c b/drivers/misc/k3_fuse.c
index 882fd431659..d738f75f272 100644
--- a/drivers/misc/k3_fuse.c
+++ b/drivers/misc/k3_fuse.c
@@ -35,7 +35,7 @@ int fuse_read(u32 bank, u32 word, u32 *val)
 
 int fuse_sense(u32 bank, u32 word, u32 *val)
 {
-	return -EPERM;
+	return fuse_read(bank, word, val);
 }
 
 int fuse_prog(u32 bank, u32 word, u32 val)

-- 
2.52.0

