Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE98FD461F
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 05:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BB483E83;
	Thu, 26 Feb 2026 06:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oqzVhsit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DB983642; Thu, 26 Feb 2026 06:48:28 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B1983E7F
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QN3ZGOIlQfxmD4WoI+bAoZpDK4kYrhk03czAY9u6Iq8oLxS/VTpHpbQz/G9zOEvnlUZBXSi74uCArTS9Ym26ZYiKfSu3YeVnwrVab0ZQb04ginjTi0vYoVRjRXfkZxgbF6lktCAarkNThzGGTLq8IU4gKaTA2/tm7JLGDjDu6lc4S1x0GF+F6IutpuZwkECqKlyfQid8ccZBesjnsuER7bkzIPvVZAN03VgWQNRqGNUq+Gx/Oxs29UVdgEW7UOHWsS1qIsf/v5mDsscj7Tuc2cAzftGwgQNhyXzM/1gYWD6UOeR5hOo6kInwysxtTPBpvl0ECn4JJBBT8JGcTJ0Bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUNy9Sp4jKcxZqnR6/G8woAom8thsW+hI/oFjGdKx48=;
 b=l7/UYc70u49I4Fh+Uv/7TcGaQoiNxhBPzjZYw8Qld/YMCo2DTyXEgKZUr/Rsd7OlWLpcYIEcfiSzysXl2rN/7vDu61m0U4Y3iB+rpbWQt1cPhIEORN14o3jRUrgAI7FVtnBckJi/dQdq2P8ZNV8mBFAd4N2OM+3WUKdlUPDs2Zrccn+gpzLPgSH9mjhWp9d74hVzHfe42DzOH+L9myQm8J9lYsf7QVKqjV9vxbvmPKx/caUQXmur91yqfeVQ41POCIrEwlSaM/wCLtDpY80wcoU0R2zdZhOczuT9LpzWdSpGeKptciIF1U8IJvcft9XES/VdDOq5YmyZJZj9iy2ZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUNy9Sp4jKcxZqnR6/G8woAom8thsW+hI/oFjGdKx48=;
 b=oqzVhsiteyDzfIunspzUzT6WZgS/XSo8BmV7MTBNj+KiC4tpUELFydCNVO6TNcTzVK+yPUYeHBZ/YoVcDrtlgablSWa/XiShpixwIb1h12fxCWIS0xsqtgDAzz/VLf5d3TeUHL8WJLYqxP18Y4F7VjrXNYumBqTopjlUir9k7jg=
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by LV8PR10MB7824.namprd10.prod.outlook.com (2603:10b6:408:1e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 05:48:22 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::3f) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 05:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 05:48:22 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:19 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 23:48:19 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61Q5mHDM1311046;
 Wed, 25 Feb 2026 23:48:18 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 26 Feb 2026 11:18:13 +0530
Subject: [PATCH 2/4] misc: k3_fuse: Check readback on fuse prog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-k3_fuse_fixes-v1-2-86c81c298bc5@ti.com>
References: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
In-Reply-To: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
To: Harsha Vardhan V M <h-vm@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772084893; l=860;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ZGv4keaPXVUFHkODp1lYWF+6noiR1m6GTihbLRx2Mx8=;
 b=4im8ra/BGxsHVuOalLlQs9sdr/gz+sHIhbZjHhavAvZz8xTP4OvofwCuu7zwP4QJ1MCeff9tx
 Q+ZVBdrGMIzBbkYhd09vnr2PEjW0RG8sjK5KbELGCSpotvIjv/8oADT
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|LV8PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eff147f-11bc-4261-ebcd-08de74faa6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: hJABNXEXSoyBAb2aNI8YIcdN+V2LU+qWqsuwv6wH7tyCkgkJiv8r4sFw67eZA+iNzwbpGTUulhs1KLcUHzOnoG7Bp9jV/kqaQVNkyq6dHSUn6MAYi0XhVYttkegwKGWpOf7nnboWRptrtxIuE/PANLi1CtmB6Pv/rQwoVhg28yoJaSjoK6Z1QeE/7HU0sjmISKFEtaaNOz4vtKUt7To23100VtasRTEZb30GcuJNas5o2eTZFdX+B8wbJyciL6QiOxtCKF0VOwPQkWjxKSaGU6APrUMBroDuhf/Oec8ijAtosK6eUNvc5Bq9W/VZIY+PDRarilRhF6uLLR6WKTYjSJFzoUPiEDf2Y6GJbc9s31NU0rWQKC/X7q9humZ708nky/gGStCDsqTahaQTGCey/HNaQR6LiuEehO5A1rmKGyfkZ+COPngn72FmKHqvXiXNNhXjcMIm6iTT+iupvhbJxiiYZ2jDEaPhXMN2D+iamqMyNSQQ4zn0Ena2mvon3BBgTC8cv1W8Q68Ko10cRQ6gc5kwXVdro+WtJuG8HBmUkkF99FSt3YlrRQLX/NVY621dkruOjgozsRZSMYWYuhW7yvEUYyo2R//eF2USnM0VsCOC3PA51BQRn5udUi+S5bhM+yQKYfbWhKFqLx1rJeHXv1QOeucTlTfN66/TcTyeQ1DgZF8PyVoB99QYDhONeulIxuVLG/+rN4i/u/jeYnsdGPNCB1ITCSaHsQnHT0ShcNn2tgefB4ZZHjiWTsNnb4JB/eXsRDnR96lvOnAsmcfue9kbQrWc6pCQnH1ow58+8rKJ1gLjr9iK34ii0/c0Js3H6X+9FsWJxYRy0wu3LMmfag==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: szOULbzxS+Wc2ok+nBkvP+rH9cKy1TbjGG3q0RonB0AarEr/rPSDFME1vFxTWksNpR65muRAd68MRvFjdex2PhBSplkeKe4+Slgek3nv9qi+m7Lkdtsjy7w2F/sPRSkCxXDxsWYibhAO09m+98KSItDIq8mfhXVm1L7ZLo0te+LNLWANngF8Vd2/REnokaiChGYFpt3QjefFte2UqNQRkkPGPyxx3xQd88vrZOPCiqjtAmwddL1FlBDdDZ0qIYLATnr4CefscPkDfIplKSQw29VzihYk6m0x2sM6VbEjx2u8QdUWSn7yOd9OlxFXyZvUOXx+Or1ijPsRDQfyUAyLxk0p8Tj9DUDSXjz4F0iE1Q20+jw9cMCd0DPZGrb+P5FhpKZBdoonoEmCuLEEXICCiWnWQflotH9h+7ZO65f1ZxT5JdD/vCuZpCdqJfvcqPhl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 05:48:22.0361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eff147f-11bc-4261-ebcd-08de74faa6c3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7824
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

Error out if readback value doesn't match the programmed value.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 drivers/misc/k3_fuse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/k3_fuse.c b/drivers/misc/k3_fuse.c
index cefdedaf411..882fd431659 100644
--- a/drivers/misc/k3_fuse.c
+++ b/drivers/misc/k3_fuse.c
@@ -52,8 +52,15 @@ int fuse_prog(u32 bank, u32 word, u32 val)
 	arm_smccc_smc(K3_SIP_OTP_WRITE, word,
 		      val, mask, 0, 0, 0, 0, &res);
 
-	if (res.a0 != 0)
+	if (res.a0 != 0) {
 		printf("SMC call failed: Error code %ld\n", res.a0);
+		return res.a0;
+	}
+
+	if (res.a1 != val) {
+		printf("Readback failed, written 0x%x readback 0x%lx\n", val, res.a1);
+		return -EINVAL;
+	}
 
 	return res.a0;
 }

-- 
2.52.0

