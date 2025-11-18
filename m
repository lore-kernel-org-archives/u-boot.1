Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C4BCED624
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 12:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B218383B99;
	Tue, 18 Nov 2025 13:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QQ04BRiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A50983C5E; Tue, 18 Nov 2025 13:20:59 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D27CF83A8F
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM6ElNQfSEJMwkq68wq/mQ9+0IjdC2ozhwEldk9iTpjavDRmECwHddWm+dsFuuIoj+f5UaooNis/9FHY3w9j8Ek5dyrzX2Ya6MhSXlWiZfXDj7Ld2UnSpvh9S12c2BHefwCp/dj0ezAZnBBzMAuczzvANgNg14cwzr9VCjesuhcbOPH+W8io2L21JO2UW7t7TARFoNhgcmFZJg5v41mijWEvy11h78LHFBJzrPYoNPptEtKCYTfImAzhWJ3j0p9JXHXs6Xc4hxdWYqC3+ChoYvsbBKk0g3t2GwVd4s1n9XMbZts4Qun3w3KygYksJy7MnmC8W3l6owpjXdTlXTXGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0rLIDfQVoanczo1oPXUWQpUIW4sU4HmeEhssN8v6eU=;
 b=RIZpM4NJeNb12ZFAfexSHCfvI8u186Ct1lhmcRpwAOMnDcsMcg0XhD7+UzePsZAkT/gUq2L/2vWIvd1ZVx/otl9LqG2ixavXmC7CNBWeOgIWAvJYUT7c3YvtiRRhBGRWiDA6tVwS58K7hCvm97rFjQ56HwhYouLoqq1RxyMSdV80RyMTqkCceq4WBTdFxB5QqlSCtU1Mi4JaYeVTHN8cQKk+/jlM7cIHjdmRm9RTnsGJMjJtKpQWDQBWVyGp2jU6j3btgHIdHo5RF5shYN1X4RRQpFHgRaJXrmXUZbYSaEsTJdJZd4X5xs4ByQgg9jT8OZCWTrd1xrkAZktwlv11TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0rLIDfQVoanczo1oPXUWQpUIW4sU4HmeEhssN8v6eU=;
 b=QQ04BRiQhG0DE8+aZSIF0kpXMUZuc2BTj3mtTw5oXH+gkCB1kDEmRxhyvDwuJNFqk4ZJxjjweAT46p1EXCOLaZWV+wallf5kX98GH9AEfMo4A15nKj8/hZSMABUXc+MvRz9rK5SS9uaVgasrDQNm0aYu+0gLQBmknxZlvdLLQhs=
Received: from SJ0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:a03:333::31)
 by PH3PPFAA02B7A0B.namprd10.prod.outlook.com (2603:10b6:518:1::7bc)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 12:20:50 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::8) by SJ0PR03CA0116.outlook.office365.com
 (2603:10b6:a03:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 12:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 12:20:48 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:20:42 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:20:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:20:41 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AICKb8F084287;
 Tue, 18 Nov 2025 06:20:38 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <jh80.chung@samsung.com>, <peng.fan@nxp.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>, <t-kristo@ti.com>,
 <h-salunke@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] power: domain: ti: fix ti_pd_get() to return after
 verifying transition
Date: Tue, 18 Nov 2025 17:50:52 +0530
Message-ID: <20251118122055.1972591-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH3PPFAA02B7A0B:EE_
X-MS-Office365-Filtering-Correlation-Id: c82c80f1-97f0-498b-fd49-08de269ce86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1tqlpf5bSi+GcaWoi+ex8Fz2KTw4P8MNdPm0CMgM9pdTkItOvBP/7m+wliHq?=
 =?us-ascii?Q?Du8tlhslO5o2ZCtDCCGBd9SgfuOh1nC5cvUEmPWLHdPAqQqA0zMNx/uEYRdP?=
 =?us-ascii?Q?uEJY0FC91cca+nuaUtPCO2oK8A8yt1S7+urLvSScM2oCk+2VnGpNBYID640Z?=
 =?us-ascii?Q?e3mvT16HYeF+l6A+tJKjfCQLMe8y1be4La6FMif4/nc4XibWYOsgRw5vhTNG?=
 =?us-ascii?Q?jaVXVQiNdIX/LhBmw6XfV0WVissQ+PTUYTDkjofVq1svFVHklLizLCP5ylzI?=
 =?us-ascii?Q?oyLk75fospvJI0mAJh9Jv9iESD0ZjIWuQWa2yI3oF236ZBs5fm5zdU0z3pSY?=
 =?us-ascii?Q?NoAcVaLUML6njKXcvRnNrLrG+sZVGiIDdzBtWfGeKZ+iOZ8IXIAeJrjKOAaX?=
 =?us-ascii?Q?8FEl9D2s2wRz9Fh2pe+f1g5qx3YpIFOnPNhiymXIEKxJaUelSbe4xIQLD7Gg?=
 =?us-ascii?Q?6d141OLbD4URtvSuuxxhi5L/pNnyGGBsocugwFaCVguQx/BK8jwqLRHmVfK/?=
 =?us-ascii?Q?ypwqivacF+aN7A3vUHFfYQVoOe4KFk2VbYCfgSGe7wI+csuEOooZZPrL+nIQ?=
 =?us-ascii?Q?E5OvvgHzKPzducvtgQKuD0ynp2PmV/jb0BsmITN42TY+quIo7bNoGfqKiNIc?=
 =?us-ascii?Q?DpiJxvJk517lUtxgZYlxpmVwCBh1j3OPI7TmqYg855gZsuXsK/0a3+ElR6Qv?=
 =?us-ascii?Q?B1v9JVFTcMXBR0gTRRHeK8XkRFfNPcVxUNlknLFcqNfmjNJBTplZ2E9ppVvv?=
 =?us-ascii?Q?2sB0Rd+reqAdWOFlbSnvOEkgdihlH08rqQrM9RrdG7Y9XirllOi7a1Cje8ui?=
 =?us-ascii?Q?jDuERNdWntL+UuRzCYNMblwN1v0bFKyenCM6GeTMaeV68huUevWLkv0c1VX0?=
 =?us-ascii?Q?tY3sEnXYXO/YcZS1LqVUdL59b6z9rvf5biCAnjzSNAJ3ASv1e71SCUj3wfZV?=
 =?us-ascii?Q?y1taZhU/ijXGGzETlkLSviz7Z9A9uGYufm3uUoJLEF+/cqoT+3yYh5tDhwTH?=
 =?us-ascii?Q?e2XMyoljhESxRKMqxHoy7DivRkoCUyoinFMtAVHl5rOUFN+D/cdX78Im2U7y?=
 =?us-ascii?Q?l5LXTR9M99Fd5KmdLJpNi/iOzpNbtjYTulcg/T41Qa2l/9nNJEc5s7+qSFef?=
 =?us-ascii?Q?0wXkdrJoJ5Pr2IZPjGKb6uOyv4THA3et7k/6TeHDHJCRIA4sWCs2UIOkeNB/?=
 =?us-ascii?Q?S7jCCP9FzeSAzbHM2fBLy/NJ1n+RLbNNc8gGZqF3EAQ0cKpKf8vJjOXIj+ua?=
 =?us-ascii?Q?duofk31+azlczLVCA78yIydJkZtr6Hbuv83iUGRF5Ty8y+KK5WXm8Wcx7jSm?=
 =?us-ascii?Q?X53aY9NhiYvFXTIdEvdSe+OAUpeLuADB7wdmCNifyCOBlzNIoXlzEuUlTROk?=
 =?us-ascii?Q?hObPeQbT6TG7dHVBCYXDWVXqZiOklcC8JDEv73P7H8LKrAayBKmsqLXKdIHm?=
 =?us-ascii?Q?W4hucgRiGxHFR18oerJytoYCBXNYTE6rdfpqz56FSjou8ast+WDqfHz+9VKR?=
 =?us-ascii?Q?WvDgkzAj+HyIWrk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 12:20:48.8617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82c80f1-97f0-498b-fd49-08de269ce86b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAA02B7A0B
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

The helper function "ti_pd_get()" is responsible for powering on a
domain if it is powered off. In the current implementation, if a power
domain is determined to be powered off - no prior users and the PDCTL
register indicates that the user desired state is OFF, then powering on
the domain constitutes setting 'PDCTL_STATE_ON' field of the PDCTL
register.

While the current implementation indeed requests the power domain to be
transition to the ON state, the helper function "ti_pd_get()" doesn't
verify that the power domain has 'transitioned' to the ON state before
returning to its caller. As a result, it is possible that the device(s)
belonging to the power domain may be accessed before it is truly powered
on, leading to a bus abort.

Fix this by waiting for the power domain to transition to the ON state
by using "ti_pd_wait()" before returning from "ti_pd_get()".

Fixes: 144464bd2c67 ("power: domain: Introduce driver for raw TI K3 PDs")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
91861e5a30d Merge tag 'u-boot-stm32-20251117' of https://source.denx.de/u-boot/custodians/u-boot-stm
of the master branch of U-Boot.

v2 of this patch is at:
https://lore.kernel.org/r/20251114150243.96429-1-s-vadapalli@ti.com/
Changes since v2:
- Rebased patch on latest master.
- Fixed the parameter passed to ti_pd_wait().

Patch has been tested for PCIe Boot on J784S4 SoC and the 1 millisecond
delay is no longer required in the pcie_cdns_ti_ep.c driver with this
patch.

Regards,
Siddharth.

 drivers/power/domain/ti-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index c3519307340..a554e659392 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -227,7 +227,7 @@ static int ti_pd_get(struct ti_pd *pd)
 
 	pd_write(pdctl, pd, PSC_PDCTL);
 
-	return 0;
+	return ti_pd_wait(pd);
 }
 
 static int ti_pd_put(struct ti_pd *pd)
-- 
2.51.1

