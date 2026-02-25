Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E27FD3762
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3DD483F7D;
	Wed, 25 Feb 2026 14:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oK6r9fL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3A283F8E; Wed, 25 Feb 2026 14:25:50 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2BB83F7D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUyvBnA77NczM84sdg9adsZ1VWZYyIkKgyDH60k74ktH1MEerWyUcXG7icz5A57SWFQfOVXAcBrUJ8ec0A9ry9z9fHCrR+3bUdWHG8E3d2r2N9vkOM7AS1D45xofwhyXNV3Lt4GsHulUfl+0dT9jFe6SUguwIVmXco1Iu/9PHfRTze7e/yCjSy/gu+lVjKMukB3CJHFUAjgUOue51nPBTOtzsANPShrUTMFc8QI9CF+ZtQ3Pnc9jqu+UtOAdspzhI5PDbMSYhmuk+G9tMd2KHQ7Q08gfFjY9aN8QGa714aBMedg2BU3X2Xb9lOrDdSqrrK99F/UQRJ0InNGYrRdCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsuepanftanbiws3z8sxMfA0AxXDJ4w0P2yfAlfgYz0=;
 b=rTWier9/2eNz/OHWb+lZcR9r9w8M559iynClG/0pQWt0gm+ZFr2rtoXvl6E0R/U/IDf5stvuiK+iCpFnVPVGmjMrCtY8K3G8wPXY0hR2JR+VnisOobTTqOnwazqHgbYE7VXOkfkaDNxy/Bpi1nHwJzlCL/ZNf6YDG6/Y8qbDi/H48wAE4HYLlc559qbbNYxjccYLHjAC7nf6GeNF+4arjOnMwggnIrXoLM90Z+ActhAx8jtHeCKHhGj6bI5/QEFqzY/weIvDWjka2E3raZ/lyO9I4MEWzJlr88giJAMENljRm+4BBqQ6oJHQZvUwfLrPxCHfv5f6vOjeLvUvUcesHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsuepanftanbiws3z8sxMfA0AxXDJ4w0P2yfAlfgYz0=;
 b=oK6r9fL0sZg8VUWs78Q2ik5v3ffXE/l1fxlvRkybZ0qLgcZSUegYk+kNKKHjCK8IawZjB6dfyyZ7NItx5/Aqy2Di5LSsyoZA1pydnDfOM3QUUUoVeMjuXdCcVKGgw/6Skr1tfO4VQ6hwqmvr+DmqrP4EfxMqzWJzxQX33CNtSMc=
Received: from MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19)
 by PH7PR10MB5700.namprd10.prod.outlook.com (2603:10b6:510:125::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:24:57 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::8a) by MN2PR15CA0006.outlook.office365.com
 (2603:10b6:208:1b4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 13:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:24:55 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:49 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:24:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:24:49 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGt011150;
 Wed, 25 Feb 2026 07:24:46 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 5/9] board: beagle: beagleplay: rm-cfg: Update rm-cfg to
 reflect new resource reservation
Date: Wed, 25 Feb 2026 18:54:21 +0530
Message-ID: <20260225132425.3096103-6-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH7PR10MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: ac42eac4-a4be-40ad-ef1b-08de74714405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|34070700014; 
X-Microsoft-Antispam-Message-Info: OXLBoMlNUJUAes2ccUeHHzfbNIi9IHpzm2Q0aVOPZlNnCoVrPq9f1P7gehERJSAX6yKEgHY8aXo35lF2QoT1cjXtll6ZN9MlTmbSSGy3tqCjGArOnStI7tAfkppk0MRasXCFAQ2J1Lp7Dm0E9SQhwqjmglz2h+xn0gQfSSDZa+RYFlh4Klu75zM6fxxlI5U09ffJd50uRAfyzIylWpHXNepY4mHX4XeAW3sMoj2mp4nsvSS44LSZ00IPGQu+ygDD28utO7fUplJTOcDRIxf4Maa+GPppcUV3hODgqJWIW/cdG1jB3gnJJVVFWHc2qSDzpqyPn9ql2qF2IOaI6MFWw7PloNU3FU8VlWHZEHG0SrjV1rQ72sYDy6vSR9jEGPucQiwFx4Ag1qq4n6isKbRKTlcOzrbzYaKy/QAmwKTJ25JIMq9HDDxweN4vLZYNkMkgktVpROMYczpjGPbLk2hlJTj/u2WPgpdOzaNCkbFwmU5GvWeCqrAKWWIuN1MWd4DFsjERpnOJbdVVdIZLZV2o7IY7Mf761b6+4WmSjJOh78xZWXPbCnmb99m3c+VesqBbZVOXMmls1fexORWSfGiQCYYo0Vl03dja95/x21a7/5NWaypqiGN+n6CD9HTCJgfBzJKKe5vSkhbZrOralFvqalgll8Fm2lTaxvWcH61iTHBC8xKnHg/+lc9qn4nPAeSVh9pEXgvsL5zLfB+opPUOEhTEgFBpwyHDDXRiUJfRjC5ATYdLRXCSX1xI+m1DyAV3frKH+i0iZphmzHXmULm5SK4OzNoiBFc1hnFBAdDS+o2+f62iiljUe6VBc2egJCrI6vNH3JFiInORmn/ypx8EZA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(34070700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eeM3JS+yuiecDudv+usUW0ghMJMQYmUoOQZQUBDbaJEdpJiU7nn+c9XmeGEw1qyT08U2kkQjVbmkPAUiyC+lgfOIfFHyUzVLHGfzA4KuUR8Thik/tgv1csYHfv3RkcIEElr44iz52RZ+UzI8BRJutMBFtQcdUu+NOBsPtJhj/XvwX5gvaVkHYY3P4miWV5OycBItQTeYNuYlzwv/kCiTqkQTigwCtBlMDGfSmXxGONGGWkmQ8aM1xNTNM+r3wydEaOivWbFfc04AebW6WvlZep111RyHeAY8oXocRZX6SnX+v18I4f4CMOW4Bg8EDMTBLtgNf8g7zTJIZSGn9G86J9XARgiwERAe59XkFolsQWGNnuPcOnU4Q8+DpEP3Oja6kv7j6xTkz+2cfkjwPp89SZB+1bLlwiBSywKJNWJ1T70rVL0d3DmHailQuRmtZxV7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:24:55.3438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac42eac4-a4be-40ad-ef1b-08de74714405
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5700
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:33:08 +0100
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

With the latest v11.02.09 TIFS firmware, an additional
virtual interrupt and event is reserved for MCU cores
to DM usage on am62x devices.

Update the rm-cfg to reflect this new reservation.

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 board/beagle/beagleplay/rm-cfg.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/beagle/beagleplay/rm-cfg.yaml b/board/beagle/beagleplay/rm-cfg.yaml
index e4221f82f92..aa999c2ef67 100644
--- a/board/beagle/beagleplay/rm-cfg.yaml
+++ b/board/beagle/beagleplay/rm-cfg.yaml
@@ -513,7 +513,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 168
-            num_resource: 8
+            num_resource: 7
             type: 1802
             host_id: 30
             reserved: 0
@@ -543,7 +543,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 627
+            num_resource: 626
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.34.1

