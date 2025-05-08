Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D622C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642D282B31;
	Thu,  8 May 2025 17:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IIw/gPfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CBB82AFD; Thu,  8 May 2025 17:16:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB73C829A1
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaGwC3NWw72b9UDqGi7+A7+MeDddDr0ESjgWalZYvSRdzvvmLt+IDEiTbpH4fyNvAfekn1UBt9cmXbn+5/49IBuyg26yGOVjje7fonfE8u78DvCU11mnyJ9esjcDQ7uUaUIl4lftrwlbKb7KYD9ppGhjgXps2Jjin5gEq8Oz+IGoh0eGMmW/RpAqezeMg2/bNpIzkoc6SWkzvN2bbMkkf6HIBzbWvQ8ZTJHU1HLXuQCDnM04qXyYUbpnDHLuOyoM6fQGW6gZPU+Buqa+cLD8UfNiaN0jJl5Y2t48k0KCVDgvMfUm0m3rK4WUkKO/t9NDZB10ufMDrCi0X7aDk/hF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TfcahiP/djPoCyXGqPoOVhY4bhHMemSeFrugZaOXM0=;
 b=tFx6uSeesux1A6AavE9ZB84Cs1Li7VqHxPamuOmQGiumMHxqyTv6EicCpQttmzzqq7YiAmQAU79Xdvf7MS983V3kMTYtVXY2VsrRcmC1yQql4BbTMkqOg23qQ6CLs6upTX1FS3p3TgF5ydDQBfgVyH5MZU1KLhfy8BT/hZM3aLNKiiPjCCKvRw3SGC4UGpVU6XwWYS0RO2u8YaeyEvAS9d6NgNPSFXlAw2FHtDLs1vnQAdFpeTjrCUFU6xrBegPNrsniaggLbpHa/DRXeAzmotb8lfzjvWVvewp2GoZXLvmZh3gjqag1E3K3BmzjXjNS4x7/OjT0w+ekSStpXa80pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TfcahiP/djPoCyXGqPoOVhY4bhHMemSeFrugZaOXM0=;
 b=IIw/gPfOqGOYFeIb4phf0haj5MrsYU9G+/sS9fhcsLcHggMxeN3Krxt79RCD/21tENYDbR6GVqlrRGJ3k2Ocee4j6+N2JOf7uqkLbjyYyK0kNkUP5pUDT5r5VgPlDaZOY8dq4eTUAGjs/72Ii947kKx6y1sjrBxWm1BkOyf6iTuIrvN4MXCvX28tn3ej6Bk1GTQud0inwqiA2W1Z1mAs1hh+nrKHoxVobHAIRmOsTGorHKl6uVbt9BSI2y6uwlH+NdDawlpCTr3K3Qs4vYFjpHDKwHZiRNibdMX3+YioioCaEIuLP74623NKe4yN3/FNBzRVaLkUSu0l9g32QyMx0w==
Received: from DB9PR06CA0014.eurprd06.prod.outlook.com (2603:10a6:10:1db::19)
 by DBAP195MB0827.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 15:15:57 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::8e) by DB9PR06CA0014.outlook.office365.com
 (2603:10a6:10:1db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Thu,
 8 May 2025 15:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 15:15:57 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:56 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH v2 2/7] board: phytec: phycore_am64x: Update environment for
 fitboot
Date: Thu, 8 May 2025 17:15:43 +0200
Message-ID: <20250508151548.162122-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508151548.162122-1-w.egorov@phytec.de>
References: <20250508151548.162122-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|DBAP195MB0827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3611f896-2189-40d8-dff5-08dd8e433c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zhqKXyq7eFH94ub8HL5RJ3C27IcDzjbQi17CTfotqhz8VBcGGgl57l1GlNEL?=
 =?us-ascii?Q?jhPf45lh6hUAUKxbe5XH0cS1El25q4DcA6aTxjh7eLsmcvB9Q8ToVxzjbqmr?=
 =?us-ascii?Q?VAlC5TBnZqwuRHpcXLGD0s6v7oIkxAWSE3AnHL9tF4YDaT+dpRgm/HirN97y?=
 =?us-ascii?Q?YOx0q9XiKQ7DsxUiwO5+DM9FqVnr0xly6Gyt2skAe4VDJreYEDUZSaZ4G6Dn?=
 =?us-ascii?Q?5upg+zZZfKngUFsRX4BJWBE13YCka/BhLvcHmQitrNFQdv92VoS1c1H/uwls?=
 =?us-ascii?Q?cJZ4YGKU3qnz6iBQp2aGqpRDBomjPwr6EkxhTBfdA7R2rfLwRphVbnNB57Fg?=
 =?us-ascii?Q?nfdW6vZLd82BZD3QNQLCRHiObUUQe++aLwiHP1qac7onjLrczHTuQ61ngxy9?=
 =?us-ascii?Q?PNQgDW17DBMvzBDEq7TA3A5TYwpPaMb9psMSVRuc8fNMHeMzwUSo2q5hf86A?=
 =?us-ascii?Q?n8r3ki1KBdWL/uDHSzYaVcMYbXGk++NHze0Bs6aYwqVs0gEqxw2QzOz6jaF9?=
 =?us-ascii?Q?tKCOKxQ2QYv4M9MklHISr7dufGggfFr9KJ25DagHnksx2FrRvuKzB08aHYTo?=
 =?us-ascii?Q?y9zI0tSysxvl++e3d8w5uOQg0uSConP/Woocbq800ITDEto6tSal25rMOxSq?=
 =?us-ascii?Q?gHs8xTrPTLRevOo5ZZhqmQQcFAXzi7F+hkC7+Rz2hnBVdbUK/j7+Mvl/tNBh?=
 =?us-ascii?Q?4BzEkypJ//Cje1J6TT7/dZlBI6y0X5KOH3yVxbzSy2Pe7cRFqV1bJJMBuFiB?=
 =?us-ascii?Q?1bIE1duD9zSEEXLMPO+s8g9wBjZJUiUrelJCxJx7eGKfRnLvLs3tPrrKynXf?=
 =?us-ascii?Q?Rp3jRuVqH/s6coSlCReiFJqqYXiBs03fY7PLKp3Bv7Y9yf0/6MBL34+RIQ3v?=
 =?us-ascii?Q?AqNgocko2mUx4EOO9/oZANppjuaB+YqoSYVKL40wxD+FR86n9itdHn6+xZg4?=
 =?us-ascii?Q?H2VrlHdnF1UJlAxQk5KLKUGHMQtxhJ0uVzj608gSGeA/3EMDiQgsL8dX3SS3?=
 =?us-ascii?Q?pjeZ6Ccwb/LMZAtll6rssSM5Ymjq/twLqY0pIy5Q+lT0ei2refnpMRfbzNIO?=
 =?us-ascii?Q?9tJyi88hqx+oHc9/puOccUvWFT5KtwpVrAo8F/28U7Stq8CH4oiy+t1uAm+c?=
 =?us-ascii?Q?Eb5K4y0YMMR9Lb272pWvXvu9iM8ipyscWrOHSHwVyfni6NFz9XdQQcPS+SB7?=
 =?us-ascii?Q?rByhf9wHwys9DBExtS28aP/slUswbrOzPlxYRh0X/ANiDOpj3n0JqHEnb7eD?=
 =?us-ascii?Q?qc7dBoQuXiHO8umCnEJJuZmdtzvmX2Uv+Be6RY7Fp8WzDD44BgGv4yJNAonD?=
 =?us-ascii?Q?Iqc60KgXZkpW+X5e/JZroWDfrtlDEu3Ook1CkS1T82ScAY4K7JttdNjGIzHq?=
 =?us-ascii?Q?6pjaXVSWU03nU/Gl4XUKcB8l36z3rgAqPQdI9cRo3OxEPVtZqPDZdATCamIo?=
 =?us-ascii?Q?X5TASzvuj3dGKbdKR4H5k5p9TlRUdaBCTUgTUj6uLm8BPbT0tDLWxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:15:57.8886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3611f896-2189-40d8-dff5-08dd8e433c26
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0827
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add fit_addr_r to the environment to allow us to boot from a FIT image.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lists.denx.de/pipermail/u-boot/2025-April/588142.html
v2: No changes
---
 board/phytec/phycore_am64x/phycore_am64x.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index d69dfe75674..d04a3be6864 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -9,6 +9,7 @@ fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
+fit_addr_r=0x90000000
 
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 mmcdev=1
-- 
2.34.1

