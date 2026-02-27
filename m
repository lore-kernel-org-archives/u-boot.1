Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8939EFD9E3C
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 05:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870C883AA9;
	Fri, 27 Feb 2026 06:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ntlEwWDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8DD83BB1; Fri, 27 Feb 2026 06:58:32 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440A783642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 06:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktsMkf766sMVejS7Ci3CXPZ4VbSwXqxFIWiV/2KWkUKrATF6l9LK6uBe1MR7UwzM9hhjHZp39yZzX0NduvntsYxSH/zFPFv5H5ciXpgbrooYEZfxF6mLiEsVJ8DtDAtFWSYrzkOdjoQAHyPB1YI10+TJw66h8mkjUlObO5ZtNBamhDSHw86QDuPF8LQ+hzPYPIV4gVcOv0yMJ4j7qdkUQOk6UI0OIRhEz1aAdHS2ZFHWOtNuDquw4f32WU50aHmKnr8mC7Yu91QzTIPp2Gys8AI8qbK/ngqmmDRl3UJtOtj2yP+JplPpcnv6ve27bQVh0Z4SOivvjoE//y6LBfWpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCtKT14RRC7SMBQ2jU/Zp2gVf2VjuxGccR9ImGKiw7s=;
 b=vkT6qLTTqupun4OaxZKceQihekoFY+k++vIGOd2Ij3rnaqDyQxkagz1b/2W/RNobbVe7tFVOYZ3qrkk7ONXa0/aMwQKOMqEyfPPGnF5XwTdRK014QEJJg7PhBGzt3x8i9EoOrSnhHbVvQw75O4EbHyfel1eDM4BU6AX0KMf7Pkf9U+a7o07trgFvVEaWK6dtxbOnNU4s4MGZdciSxWzQQqm0sGvE8duKiAQCoD0PSkwjMdkID6RAQhDHVRBk6ngtQqyLA5hDCys8O5cZPoHMAiJhtXHGUG4GslDfl0sG7OIRv1gt/nIXAhM25wpOUq2f01AMSrASmfNjlUUGqVHtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCtKT14RRC7SMBQ2jU/Zp2gVf2VjuxGccR9ImGKiw7s=;
 b=ntlEwWDEkOo3xkwggFkVTFremK0YDG58wHOMVxGgUj01qBzcinCgg9VeM3bLdhgHurqclT3lM+Iurj8rwZ0LgbZPPfCxnGXo9NcTegOM5KxqHSZKzY6ejIjBG91bqYXiXVXwDCp08VnVZOPx2+ijaW/bMt6cya6qs9Mus/NSeGg=
Received: from DM5PR07CA0061.namprd07.prod.outlook.com (2603:10b6:4:ad::26) by
 PH0PR10MB997643.namprd10.prod.outlook.com (2603:10b6:510:384::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 05:58:27 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::8c) by DM5PR07CA0061.outlook.office365.com
 (2603:10b6:4:ad::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 05:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 05:58:26 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 23:58:26 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 23:58:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 23:58:26 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61R5wN8r3685739;
 Thu, 26 Feb 2026 23:58:24 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <marex@denx.de>, <trini@konsulko.com>, <minda.chen@starfivetech.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and
 probe parent
Date: Fri, 27 Feb 2026 11:29:49 +0530
Message-ID: <20260227055954.3916518-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH0PR10MB997643:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd13cad-be95-4c74-5124-08de75c53992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|34020700016|1800799024; 
X-Microsoft-Antispam-Message-Info: 5UI2/5g8JoNUJ3STdDLR6rcymT/3FfAjytaGJGigAQSuApMdgpTNhhayoIn2AgLR2im+v70kd4Q/QTYSCs2Vq5VCFJlYdYj+1XlGQaZ1APKhnOVKCwRlI8Wj2dM2b1WFErFOIW5XfHEK8haSIbyPdyv0jQPxH32QajFYljL1oRTBSQC+ZmgQY9CyraPTNFkc58Goy/osoDlkwY4bdyHDm4Zg1i6yCH61bQwbNZeZW+APYLGvqN+JYavK2YgJbX2uST93wJP+Xs8Mk1/8ZZFZcn/KPMvIH+9NbHIe5BgRTo5fH1Mg/i4jtTTKKswAyvHAhKGZYipcVT0XZvkhdo1I1A68jRwNONCiitRL2t8rjiM5XZK+cqJ/i0l+vie65QgPXaEKa4wmSVa8PcvBUeBFE0ZBS+XFJpiwqX154rGJft+95j4z0eRR98/3hJhY3wbfknNTLWOVMps3ZjkanSk3vSF0gbxyvjwp4ttgh5AOVBgpSyDn7SWkaP7ItAiQRRX+Rof4m4umtjBZsKV3aVDqHQv+JD8STpIf17ojfHPZ2Ilr9va7E4PBni26BVIG4MB19oLE6USgBCMX+vYkI+9+9rn18n/qTSlUaIFtJGqp5QBX/YsJubQPc7AqS4XsJPh0dbwVRzXex5JInEaJiW0WH2o7sB4POrJwqNbB8uukYPO/2QZIXehJR47oSk0q2TqvlYWSZvuZKr+mfpMeUIFiLDjmQC4pR46xrXh5HZJUuz8oZfVPR1nlkZ3rQbqMzYfUL+UKjtc3R8+NItFl29pFQ7LSJkL6V9KL/uqXmueZvoA=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(34020700016)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TYKnixFYt01DDMY/QNk9Gn3hf0m3wRRNzJn3DnimDG2v0VS2vgxG7BgljBccwjn3Dx8bartyk+wi4tlfu3zYGwUGLM0zffpYJrOxqPpWsPrSn9Jbw23iO4nMHGiu3FVvAthVb2wiQ4gx7CMtMmX3qW2HwzTz3H9IXBj9Foahb/xI6nB47OBF2uIIkR/NKwGxL+fGK7Ea1Q/8iFSI1IawikiH41YWGrox0nVl4ZseM7en+COV3smTT0H9Z7GeMNXXYEutF7uOwCZK5sEOBrozsfmlsSsKlgKM1JeI4TIU8yZZDXK6K9TItKY275M+pFrLG3831c9L8oGmYws9fxjkrEZQIN0NjXVPS2RdErObIXHEqAV3sZY0OXmFPAuB4yAdNS4I1hCVpiv+IiuGz+tSkWvnzFV1W2CoE7e31RO7IQB/zMhUUww2mXndimcKRAnH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 05:58:26.7282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd13cad-be95-4c74-5124-08de75c53992
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997643
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

While commit bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role
for dr_mode OTG") enhances the driver, it causes boot failure for non-USB
boot mode when the 'dr_mode' is 'otg'. The reason for it is that the
cdns3_get_otg_mode() function reads the USB Controller registers to
determine the appropriate role. If the boot mode happens to be USB, then
the USB Controller will be powered ON and the registers are accessible.
For non-USB boot modes, the USB Controller is not necessarily powered ON
as a result of which the register accesses cause boot failure.

Another issue is that the error code from cdns3_get_otg_mode() is returned
as-is by cdns3_bind(). The cdns3_bind() function already has a comment
near the 'fail' label stating that an error code should __not__ be returned
as it will cause the board to hang.

Fix the aforementioned issues in the following manner:
1. Probe the parent device before calling cdns3_get_otg_mode() to ensure
   that the USB Controller is powered ON and its registers are accessible.
2. If cdns3_get_otg_mode() returns an error code, instead of returning
   the error code, jump to the 'fail' label and return '0'.

Fixes: bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role for dr_mode OTG")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
7995bf8dea2 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-samsung
of the master branch of U-Boot.

This patch is critical since it fixes non-USB boot modes on J784S4-EVM.
The commit being Fixed introduced boot failure for non-USB boot modes due
to the register accesses being performed by cdns3_get_otg_mode() without
ensuring that the USB Controller is powered ON.

Test Logs with the patch on J784S4 EVM for:
1. SD Boot Mode (non-USB Boot Mode):
https://gist.github.com/Siddharth-Vadapalli-at-TI/d3fbf2a7ddfa9bee1d65c09254ca3ef3
2. USB DFU Boot Mode (USB Boot Mode):
https://gist.github.com/Siddharth-Vadapalli-at-TI/bb7487efeb37b72039a9cb7d7aa563e0

Regards,
Siddharth.

 drivers/usb/cdns3/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 10bc4cabed4..a775567b3bc 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -461,9 +461,18 @@ int cdns3_bind(struct udevice *parent)
 
 	/* Use VBUS Valid to determine role */
 	if (dr_mode == USB_DR_MODE_OTG) {
+		/*
+		 * Since we perform register accesses in cdns3_get_otg_mode(),
+		 * we need to ensure that the parent has been probed and that
+		 * the USB Controller is powered ON.
+		 */
+		ret = device_probe(parent);
+		if (ret)
+			goto fail;
+
 		ret = cdns3_get_otg_mode(parent, &dr_mode);
 		if (ret < 0)
-			return ret;
+			goto fail;
 	}
 
 	switch (dr_mode) {
-- 
2.51.1

