Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9E3CD4F5B
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 02:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1377184874;
	Wed, 20 May 2026 04:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="baW5GtTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BABA848B9; Wed, 20 May 2026 04:52:12 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B22984868
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 04:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSruOLhRrzlK617BOiTaqA8wAlq1gi1G3hig9Ml3d4YxZzsfAkxuOaGuVFhdnGs1jQ9qIGfKCvi81Sk8alRen8xIe1DzIce/MrDAFrErAKjE9gFP4MieKJkDPjNyniwYKfcqLLVM8vpkWvXv0/iey6toUJWNBnQGg4atIid8wQQTgzso9K4uAKXhBUlDc+R3McsPnLADefUhDDEOEsZW/A2xvq9b/wxrQwhKWCjwVH0i8W9+nt6duaZBlbwR+24xLZp9TSndhrPBEEr2u6kQGCoInwLzxmSG5PvxX4PF3D94W2aRVAUK9qM9TLiv0E9dFDtRrn1IXMHDYAPyFOVkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQajXqN3dD1XoSiDWC6al05FZvPSRVqZlS197Rtqmzg=;
 b=Db4ceVFBaoRhCdJx3i/fVtyW3ZsUy6bpT17MesQf47hObp58BKA2MP5pe/0Wptg5pXBYVRpTafkG2umtaKmy9P27NrOwvoCBRtwItJ12SREnZYx5XZr+cyKxmTyj70qh8S1O8Q2QcMCT3vblV5b2lpnkw+HyMTGHuADBtRnana57XfE9MDOO/DMImFZMDPoQc6yJV+0CJgZ0gOH2ZAUDPl6t1plfSmWLn6AZwDuZ+46+ny/rRgWOcsWEg1Q2QGzAgwWa1Un7uBOTiVbKyYL4DggMiTNonMk8hdFzmlBJ+psaeWPBkPNiAGCF2s7BI2BwUWJgNShHXO0czly8MzktFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQajXqN3dD1XoSiDWC6al05FZvPSRVqZlS197Rtqmzg=;
 b=baW5GtTezWLBxGBxw+ktOSiNHpwSuUYUSP32oYj/1Mw3neDfzI3q+gZ/19/OaSngTqYJmSqmXwSFBNHvnja0Ggj91uwUSO7j6v9GeVKFZ8PUDiUAXWEsynD1Auv6JFhz9fs7k9GOJtuhnCtIr8tNvOcHJKmdb5llgeuvW9iNsLE=
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:52:07 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::c5) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 02:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 02:52:04 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 21:52:04 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 21:52:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 21:52:04 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K2q2Nh1099876;
 Tue, 19 May 2026 21:52:03 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH master v3 0/2] Fix speculative access to firewalled regions
 on AM62 SoCs
Date: Wed, 20 May 2026 08:21:48 +0530
Message-ID: <20260520-am62_firewall_exception_fix-v3-0-9ca3dc40aea4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OywrCMBBFf0WyNtJM27S68j9ESh6jjfRFEmul9
 N9NI4grcXkPd86dmTi0Bh05bGZicTTO9F0I6XZDVC26K1KjQyaQAE9yBlS0HKqLsfgQTVPhpHD
 w4SagiUIi0jRXShR8T4JhsBhwtJ9IK5xHS85v7u7yhsqv6rVZG+d7+4xvjCz2/1ocGWU0k1BkB
 SulFurozU71bZwZ4VtU/hYBTajUHEvGUUGqP6JlWV6qMc5hJgEAAA==
X-Change-ID: 20260512-am62_firewall_exception_fix-20a335cca769
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>,
 "Beleswar Padhi" <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779245522; l=1993;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=TXq8ZOlpRUIfnJ5cQFoewZtQx5I6tNRDY12xf/ydVzs=;
 b=iPGQBlCPYRu70Fr/yhTSK00rbfYB+Rlv2QJ/YWMuS/fhYCsewPjTwEwTTIZRyUz/n10AKtnTM
 pCTCQAd/86ADw3ZnYd47PNgSl/WGUGOKnXaGdBcqLDMD+vjsQgANNVo
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|BY5PR10MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bf3764-7243-4c2e-b1b6-08deb61ac68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2O8DPfw8fUE1JY+6QWe0/xv3QiwB8RNNVhMtPGhSUO6Dr74nTferFk8VIVdqYdVnhv/iHLtQoax/w6DN+6QrEy3KjyDMD4xr3KC8uhiR8e39d2veqsOj05c5/C+nk/khrhmCjd+BR/spCTH6vkHbhO6oqyF4oJ76NUPyd4IB4KqjUZJ+0RWmAgisKjnOHV668PwuUxKK1Tcux5vs8bmOZPxF0283rtV+o0RF2by+7wwKoYrO9nP/UYeqbtfgFt7kT79+fKjoq0n5QN6HXqkCy7L07Ljx1QJ+yqNWOmn13KsGTvfpjvnTH1FYNKhFNex9VRloXepxrT8Uc7uxD+OEGFpRXE8dQ1BUTjFv/WUDjTkSHs/g1w5e0vkkKGiQ+aKTm/gs0yMRAje1ko3kfvEUb8pIPQcj19MEFDkYaD5rFaszmrG5kAcvUQNTxMxYZoh1oQgsRG1X3s1IaOAKl3OBZeuNpHpjtCMNUVCaKYCJGXUQOzJawQwlXnuouQTm3KcRxw39K9Wcd2brvR0zvk14vuwjDBYXoQI0fmJytY/8sI/Qps+8BNOPqkWLzhx20o9D6hkNkhH9cyp2RL+nYx5z/AsUnLyVO6Q+31ql+j12FLJkTCwsab0F1tKFuJJKfj1MgaRX2GzgoFzHbHlXbJlIIGErZvGHYL3I9TURdyka90cPUzDUhOQNEWU5cSv397uO
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XyHoL2vNt9Lz48nkudqxt42sAFLq6GYYzh2Db9YFobIMcdvARGWOPMhMlqxD+YFZb2LKl5G+qGeq2Pc00M0QR8mH9by/Ohttr94Joc2VVdGhzc0PzvCtgaJcpHHpXdOsuGEh+hmdEL2DFsa7sks7XqVYax9SPVevYu2pHIVvGFZzPfBXZLgT1UWcMdn/qiWWTA7PAoCtEtfQvCZkznEJ/mRvYOMD22tUieiY8KxbXjm8RgWu0w3YrfHY/z6/sDIBpntV8cEV1XamQ285y7zd1k2RNF4mr/IKoLCeKN/ZzP9VqfmwF8D1BcL9JYRQq4h3UTfu+pBrZgkWwn/ZBvlaBDr9zZpfiDlrQzi6nqvw764Mk2rrnjwGbv9t4ITj8MJ3iYFJWMwbb4V6HWW8HFKqfu7B96A1puARF5db54MzcnyjbAGQPsFZK/Q5EObli36F
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 02:52:04.8386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bf3764-7243-4c2e-b1b6-08deb61ac68a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
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

Hi all,

This patch series fixes firewall exceptions observed on AM62 family of
devices due to speculative accesses made by the A53 core to secure DDR
regions.

For testing, I had used an AM62p with the following diff to enable
logging from TIFS:

  --- a/board/ti/am62px/board-cfg.yaml
  +++ b/board/ti/am62px/board-cfg.yaml
  @@ -33,5 +33,5 @@ board-cfg:
           subhdr:
               magic: 0x020C
               size: 8
  -        trace_dst_enables: 0x00
  -        trace_src_enables: 0x00
  +        trace_dst_enables: 0xd
  +        trace_src_enables: 0x3f

Without this patch an exception[1] similar to the following is observed
at A53 SPL stage:

  FWL Bit  0x1
  Exception addr  0x45B08000
  FWL Exception  0x1000100
   0x60000
   0x80002880
   0x0
   0x141201
   0x40

[1]: https://software-dl.ti.com/tisci/esd/latest/6_topic_user_guides/firewall_faq.html#how-do-i-debug-firewall-issues

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v3:
- Pick R-by tag form Ilias
- Remove the mmu_enable call added in [1/2] in patch [2/2]
- Link to v2: https://patch.msgid.link/20260518-am62_firewall_exception_fix-v2-0-bd6e816ec23d@ti.com

Changes in v2:
- Added Reported-by from Suhaas
- Modify ARMv8's mmu_setup instead of overriding it only for mach-k3
- Add mmu_enable to give boards more control over MMU configruation
- Link to v1: https://patch.msgid.link/20260512-am62_firewall_exception_fix-v1-1-4b274718bdac@ti.com

---
Anshul Dalal (2):
      arm: armv8: mmu: move mmu enablement out of mmu_setup
      mach-k3: enable mmu after reserved memory is unmapped

 arch/arm/cpu/armv8/cache_v8.c    | 5 ++++-
 arch/arm/include/asm/armv8/mmu.h | 5 +++++
 arch/arm/mach-k3/common.c        | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 13c1e13cc7fb1fa07867f835ccf25913594c71ec
change-id: 20260512-am62_firewall_exception_fix-20a335cca769

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

