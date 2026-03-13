Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8D0105F784
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 09:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC97841D5;
	Fri, 13 Mar 2026 10:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aGiK4n8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345568420D; Fri, 13 Mar 2026 10:41:58 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B895383FA4
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 10:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT59xb+lgIz9zsSCpfA6DyUqleUrjKFkZK31QWOGY8GgVUnGvYCWrr8i6XN4MZrv6zU3Lzyk20aqiS4Xf4V7CR4ThBdFQfXJrn7UqWJ5NfvbBWGAc/4vdqTWgApEP7ltoSr9SSvzJH5ZwCZGGoyHTkqV76Sa5eIIe03aS3VZZaPnfdqQtTnpFJq8KBD1Zu8qrVM1UTjv86GGKcza4tYnJKE8ckdWIy5O5cfZxaZ2C4Lx6YLgsBlmJQQXlRDvzoFT9j+MYq/GSC2pbl3vrn2dUQ+e9XBoBSdxdxqDBUyLpgraNBSb1Aud/urGqvGGpCQ8wVX2E+bJYsqR6mSGO868qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCsurLuv4Tr84CTYVxz0wOzuHHMcwql5f9XMLxEIJtU=;
 b=w8U6lHTHWd/KLKBS3sQp5VjToEBa+5jxNflBljKKnl6PlzehhYXrbTWQX5Y+VngC9Kg5boC1I5rUZgOUjE8GKFcuFvA4GQiNilBPOMCNFRSK57y10dzUMOl6chFCnY5ZKYf0TDkm2Gn1GyBpSg7QJyaAs6AYLqLd9zH94F/e9C+CiQzdBn54P791+8VdtgzjyEh5gbQZQC9kCAcQ6wgiI2FSFi/HXto4vkRUEwnwxq0M6cYoVBT8Ut+/4WMwo+kM/5pLO8IRT9tMa2NBK/F5qWgRu5rr2ZSLq+efKVqm7h8dspplFNU4O8+CVdUU4aekbi+lm9iXDYjezd6x/ySNIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCsurLuv4Tr84CTYVxz0wOzuHHMcwql5f9XMLxEIJtU=;
 b=aGiK4n8hx/A1gpMqEnEUB4qZ74uGDoiVWZQjkMQKoxRMV+HDq4+xTCbz2D46A7+VI+koGt5VPNSqGWO4HUzLS9dL2Zj9NaIuxFNua/Y9OOCeEEBo4SkkZh8Dm2MLIqX+/Qi1VRCh0zBl5+VIGVLJC03y1JcqMT7DHbc51Q9S34o=
Received: from MN2PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:d4::32)
 by IA4PR10MB8398.namprd10.prod.outlook.com (2603:10b6:208:56d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 09:41:51 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::b4) by MN2PR04CA0019.outlook.office365.com
 (2603:10b6:208:d4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Fri,
 13 Mar 2026 09:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 09:41:51 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 04:41:50 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 04:41:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 04:41:49 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62D9fm8P4006793;
 Fri, 13 Mar 2026 04:41:49 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 13 Mar 2026 15:11:44 +0530
Subject: [PATCH] doc: board: ti: fix incorrect labels for boot switches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260313-boot_mode_switch_doc_fix-v1-1-1ce5d1eb04d7@ti.com>
X-B4-Tracking: v=1; b=H4sIANfbs2kC/x2MQQqAIBAAvxJ7TjC1Dn0lQkq33ENuaFQQ/T3pO
 AMzD2RMhBn66oGEJ2XiWKCpK3BhiisK8oVBSdVJ3WgxMx92Y482X3S4YD07u9At3Kxla7SZjEI
 o+Z6w6H89jO/7ASg4p3JqAAAA
X-Change-ID: 20260313-boot_mode_switch_doc_fix-cb305434a42e
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Neha
 Malcom Francis" <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Nishanth
 Menon" <nm@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773394908; l=3017;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=UMoe5ns0yJQ04IsHY55HYzGU18D98yjvT2Dz8LXnhc4=;
 b=XkURWmtwDjramSbfQMDwXT7B2JL4zSk8CdKUEjyMjnYGvZdl8BgO6ZohYwid5ujN0gc9HcZN5
 mMBCFxPYTZ9BZQkOKRXmcterbG07aAsw1YQqE4zaE0MnwXOym+kh9RC
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|IA4PR10MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a0a9aa-6d8f-4a66-3afa-08de80e4c146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ebhfRDpRdTWfEAmJsFZTL8jLGZcqaneYB4eZD5zHohAOqE06JzIL/Sfb8hYAOC+XrNETVJBAkB3k78pEyu7/TPWvb/4nlOVzKqG5pybRgSc5EOsS44I9gtUHQb3wuijQe8+xNjtFB0PiOhhQXbQaxiUn2XPpfw17S7YVuZJl+ed8fEmH9BJtof0nOjipKLrcJZvRKL2KZXlXi7N7LXHbYh0NdajRHREHzqCWg+iHYh4HbW4mqfWmxfO/jCjWiy0nmi0f2rKmVhOeUinRbEkZxm5dWJA7Ho+hBV/Imiqdr39b6XvPuKEv9ggbvMLIrHh/dk7d9X3r1Tu2IZW3oFzLyXVKI6iSHFWyi6MZfR/Kr1FVItqD40uow1evGB8JG2IN39DeSh5Ak72D+pYyPX0QTS0l9WKpIjJj6eVtxv7IoZWYzAgj5A1z2XBp6en6f+oQOQTrjYEhKzC9CifNr9UXSQeOsUN46eaF77/qobdJj1zGd555Ak53N5moesuCRyTUsTzJwgxHSPZ0fUwc8YeXMYq9oUNyUskoBKRPD8Y+Ndy8mmOK7ejd0+jx+jXXFfi6IqlIg3YwKMEZbntK5o8K0ZDSMTvwSW1NOBkJiHOG4z1C66XqLI+/eDsWDSENuSndcbIvKTCRmZRtoYYHFuhpzTuA8+YLZo05L+Y/ZxiOIFsX16kbUBmVwiihl42j4SjUL2TbVkLk4/DyNlRnBpwda5nJSTx0OXlPU+iBDpTyFsI=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UExKn2Sj0Xcp+CCuMlveRMD+EhqKHOB5SGcrsAXDQX+iDJYbeNF53LoLc/oOpVLBf6ehwWnOr4L1I1rU/gYorAo3eyFl/x8gMobuQbns8hxlkj3ndwnzrZA23qbpVgG5CM2/zzqRgRFklGXlzuZg7+XwLuS1kCWvVu3GZzxpyFFJDAZHEotcH/BwwtKTS0V+ngycYPCtE92hMZZtMw0p9Q2lYwexXSCfEi6LCmlQH0yJYBxm2csU+7GJK+fJO7N+z0HisyzLHydSNLTzzXh91vTdQXSu31h4xUD5yZ7x2VnVmLFU6poXqfHhSDiSGoqo4sMwyQVwtSLC7+ZD2ZzKlccmsB0H7ISlQUNy+1kQWW37pdngQVGoi/CVHp7Yk3wy6qJU8p5m9CytBiXbYE071INWDvRkRbcV/fVSF+3EHpqqc4cEN7JEX75XIsIj3lWI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:41:51.5443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a0a9aa-6d8f-4a66-3afa-08de80e4c146
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8398
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

The labels for the boot mode switches were incorreclty documented for
some TI boards, this patch fixes them as per the official user guides
linked below:

  AM62x     https://www.ti.com/lit/ug/spruj40e/spruj40e.pdf
  AM62dx    https://www.ti.com/lit/ug/sprujg2/sprujg2.pdf
  AM62ax    https://www.ti.com/lit/ug/spruj66b/spruj66b.pdf
  AM62px    https://www.ti.com/lit/ug/spruj40e/spruj40e.pdf
  AM6254atl https://www.ti.com/lit/ug/spruja1a/spruja1a.pdf

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/board/ti/am6254atl_sk.rst | 2 +-
 doc/board/ti/am62ax_sk.rst    | 2 +-
 doc/board/ti/am62dx_evm.rst   | 2 +-
 doc/board/ti/am62px_sk.rst    | 4 ++--
 doc/board/ti/am62x_sk.rst     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
index 7776ffb14cb..18a3520b39c 100644
--- a/doc/board/ti/am6254atl_sk.rst
+++ b/doc/board/ti/am6254atl_sk.rst
@@ -236,7 +236,7 @@ https://www.ti.com/lit/pdf/spruiv7 under the `Boot Mode Pins` section.
 
    * - Switch Label
      - SW2: 12345678
-     - SW3: 12345678
+     - SW1: 12345678
 
    * - SD
      - 01000000
diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 8eeb90a271b..6f3432f7895 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -162,8 +162,8 @@ https://www.ti.com/lit/pdf/spruj16 under the `Boot Mode Pins` section.
    :header-rows: 1
 
    * - Switch Label
-     - SW2: 12345678
      - SW3: 12345678
+     - SW2: 12345678
 
    * - SD
      - 01000000
diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
index 2d66241ce68..0d12e3ec147 100644
--- a/doc/board/ti/am62dx_evm.rst
+++ b/doc/board/ti/am62dx_evm.rst
@@ -173,8 +173,8 @@ https://www.ti.com/lit/pdf/sprujd4 under the `Boot Mode Pins` section.
    :header-rows: 1
 
    * - Switch Label
+     - SW1: 12345678
      - SW2: 12345678
-     - SW3: 12345678
 
    * - SD
      - 01000000
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index da70cd58095..c97042d09f1 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -265,8 +265,8 @@ https://www.ti.com/lit/pdf/spruj83 under the `Boot Mode Pins` section.
    :header-rows: 1
 
    * - Switch Label
-     - SW2: 12345678
-     - SW3: 12345678
+     - SW5: 12345678
+     - SW4: 12345678
 
    * - SD
      - 01000000
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index b50fff87506..cf49508d10e 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -283,7 +283,7 @@ https://www.ti.com/lit/pdf/spruiv7 under the `Boot Mode Pins` section.
 
    * - Switch Label
      - SW2: 12345678
-     - SW3: 12345678
+     - SW1: 12345678
 
    * - SD
      - 01000000

---
base-commit: 9f1059bc735ec2a8d78c1f3e4fcab1fa3f428317
change-id: 20260313-boot_mode_switch_doc_fix-cb305434a42e

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

