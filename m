Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA419CEDD97
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C93983C5E;
	Tue, 18 Nov 2025 15:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SLISz8Z5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CDF83DEC; Tue, 18 Nov 2025 15:30:39 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0959483B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZFQN/uCre7+08og9rgbPZILa0q4vD6u7DpFZT0RFwD8OjNgNQMlvQC69EZuBbtek6fFmZvqpWtLorSG+V0D0wBPzoQ75IRZR8wAaekb1Swj06sbL1qwLyNXoyX8wI2qoacmSXHGwk353qskbN5NtxJ1t4l+YcZEyVJZ7WFS6qVl6Xex0g7WkdkFCvXv9aDzQ6ezxklDtVjuQWXJuWByHykNnscgY5pHmmf7THVGp1KgJunmfIrsYBSvOPds+M0KqBRabZVFCIrLYJmwbyLm6vPJX34zhkuarwGjMAvfd+YnfypDXJXKUU649r4XmYjD3MGSRxD9QsaUEiEAVyyE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGduV1RKMMiBBDg80dUOKgvjArFIDdb68WEbYA1UN7w=;
 b=JG3BFqKp++ara5FisODXrNxtfW/HPA/TgHSXFyOQc6g7d/HxowDJjENz357x0VOFAP7AHl67IZQGkOqYQdoJOFhJhgGnwcZMUUpar6nEaBzNSrF9/e93y/8Fk2TrxEZD1rPtP7UyGIy9RZtR3M00mHTS6o9ZRG2u1t49dBvKyVBWlHAi8Fvj2gwyBEccJp8dasqSbqibLnRwE3VE5ezHz3HupagR9clMN6tZegsY4rJHRrKPyS1R9If0s2JyhxAgGDK0BydA2ycodtHITaYebwtnJA59pHm1b1bUmOwPtYK47dpDtVMyZMu1+SNl/luIlg3Q4JvTp68bongY7s9OFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGduV1RKMMiBBDg80dUOKgvjArFIDdb68WEbYA1UN7w=;
 b=SLISz8Z5TQIHlne1hwML2P5e6dL2fC7fGneLiDUZ8NSiljxPTmUuS7EkVsllfHIQsR+iWXLB2lrvQfnGqDtwbRBZZ1YsXscmevfYE0emGCpRAPlvdvwt9Iz2kzeSksWEFOysKsGsA4juZlAq97x6DwqE7AO1Fj69WYC/PUIZFLU2gzV4QeorR+PfKRdHf0cF+DHsNVWS0IhWNVo33BqgOloR4i5PRSUY7U8LiwbhGrIyg9S+H7ftCB23qBpqnTyccbgyrPnSBd0rDlzuDK/FUjphyJTbvY3tM5JhFH/7Wp1cTTCO6MtUfi/VUO923dpC9pu+IP0Zzbx9U3vU7m0UPg==
Received: from DB8PR06CA0052.eurprd06.prod.outlook.com (2603:10a6:10:120::26)
 by AM7PPF3B35A546A.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::74b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:30:34 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::d8) by DB8PR06CA0052.outlook.office365.com
 (2603:10a6:10:120::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 14:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:30:34 +0000
Received: from llp-anderweit.phytec.de (172.25.32.82) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 18 Nov
 2025 15:30:33 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <m.schwan@phytec.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <upstream@lists.phytec.de>
Subject: [PATCH 1/2] bootstd: rauc: Don't check root part filesystem
Date: Tue, 18 Nov 2025 15:30:20 +0100
Message-ID: <20251118143021.1757423-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.82]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AM7PPF3B35A546A:EE_
X-MS-Office365-Filtering-Correlation-Id: aa91b904-807e-4189-6f5f-08de26af08df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZHbkS3zX6s9WRwJslZVRvbk0MjPSNPKUQ0jicK658kkGmPb4Kamea6366ChG?=
 =?us-ascii?Q?YKlH9O39IgdJ4Lto3eTI5346KvMPKlDEPuTRGPHsnIiur8Htpfve744OAZkY?=
 =?us-ascii?Q?ShzKqYxhKUEgb9uVGgFTO9uIKH9KOwy/pS9ej6Ly495smDPYMAXv+MALOUk+?=
 =?us-ascii?Q?88Fmz5+m0VTHyzLWdiU5rncTsKBqQZrk0k5wO1YCEoA/kvoCWiByo5JtNdEA?=
 =?us-ascii?Q?YsaRstumxC+1chMqSbStq/VjGWw1kb7LZtk4+kPiU1uhuLClzdXSEK0HIg2E?=
 =?us-ascii?Q?55P0nP9/7nzsocCoMmQVLMk9dGW3J30HImvGPqRunf7OHofa2cbiXomvErm0?=
 =?us-ascii?Q?iBmCqEewXYqcg7En+IgHnCBX+x0+c8suvh5mCyIjqZRYEphM8r1JLTqvFfPI?=
 =?us-ascii?Q?lKU0WffRiHdIRHLBdYWyA03U80mNlWvju37GQy9iAQ+11j5OxSPyOBrA7ik8?=
 =?us-ascii?Q?DAUwde20uUHytxYbCg5zWirP+Al186IO+PV3KSJ5a8Wg8rl4A1AynDLiA0WC?=
 =?us-ascii?Q?StCrQIig6vpcnB8ka60nlRzRiq2ERIxl8NLILl2AmidcXs4fZcXOQcerGhwN?=
 =?us-ascii?Q?/rP6OpZWToqVvOgLe2bdpyQy7WK4ewiYBsznEnuAA60Fxf5cDtPLba+EwFMu?=
 =?us-ascii?Q?F4QrbxNLvhxkWM1x2eAWPEFLYk29Yb+ajCBOX6LyyInRb+D/vAEAUA+lvKex?=
 =?us-ascii?Q?oK6Zh/C6UIO8c+5Xi38em4FLxvjAcZlLJUXbnCplUsxKzvvdBkmHYsPT97En?=
 =?us-ascii?Q?DJEbSxDESlVPs7jvDG6YVfW4ghRtrXMrNzRHa6vkEliy7RG78CfNDK6t9vr+?=
 =?us-ascii?Q?hjFqd0oegptDAcRJBte2HObvX/t46cJXv/XqmZ4W/5Jr9vWQVyQ7Yl8B8bDk?=
 =?us-ascii?Q?NY/6F7MCCn0MPeC9dj5vyYlTIC+npuZrrptyJ9DsZLKPPMrTQJWj86ENg1iv?=
 =?us-ascii?Q?s9DumY7/69AZUGV8gtUHeBIAirSBdTFe5FrK9yzfmhq/duqarGtDLOdoKz8y?=
 =?us-ascii?Q?l/BijHER4quE2Ky+3zNqmasJU6OLKg5vnfQcQj9HgCgrcdP1eJhuoDKcr0en?=
 =?us-ascii?Q?ZpVE2DaQofxPZQfOGtrAB348d6325fIEmZ2dW06B17gztSWhTPlsCYKmABDB?=
 =?us-ascii?Q?ofngkP3Xl2wF2YwRHBoeg7tkpEYYawsA/T+pGNT6AXRMiR8g6h/PNS47MmE1?=
 =?us-ascii?Q?vnshUJUWZ5stzffbouzZqGbJaD51hoxR/qy8qis6XXrfUaxt/Obx3EONDCee?=
 =?us-ascii?Q?Qj9RiveXJm6M/+WLd06zq1NmoCc/fE5TP41VO8BX7zYhJEcXBsdJ+84zIu2i?=
 =?us-ascii?Q?o82PlpU2FUKQU3kxFpMWRUNVauyZ+H1+R4X0XNkBqO9H9hy9wNuW8cZGy0Ut?=
 =?us-ascii?Q?xwYgcA7WP6iHGTY2PHu/b9ZnlUKNp2sRr6SvrOwt6VKrxeh7kIFT4V3q7X5C?=
 =?us-ascii?Q?wA5XNMfzklQeBfEj9hZA0gYbM/xRF8MGPYWyUyMG+LSQGT6XbLRIWaD6zQeF?=
 =?us-ascii?Q?msWtx/pNTmI/e7CAZnAm+zyzgGy6N/55mWfFbB1R62YdnHCORU2itCOFJZPw?=
 =?us-ascii?Q?EKRvaaPa//YIl/dcNeQ=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:30:34.2459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa91b904-807e-4189-6f5f-08de26af08df
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF3B35A546A
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

Only check if the root partition exists when scanning for the slots
partitions and not if the filesystem can be accessed. It is not needed
to access the filesystem of the root partition as it might not be
supported by u-boot or be encrypted.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
Tested-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index f5d5a971e871..1096daedb5a8 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -17,6 +17,7 @@
 #include <fs.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <part.h>
 #include <string.h>
 #include <linux/stringify.h>
 #include <asm/cache.h>
@@ -121,10 +122,9 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 			if (ret)
 				return log_msg_ret("part", ret);
 			fs_close();
-			ret = fs_set_blk_dev_with_part(desc, slot->root_part);
+			ret = part_get_info(desc, slot->root_part, NULL);
 			if (ret)
 				return log_msg_ret("part", ret);
-			fs_close();
 		}
 	}
 	str_free_list(boot_order_list);
-- 
2.43.0

