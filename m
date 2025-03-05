Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F737C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379EE81607;
	Wed,  5 Mar 2025 05:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qUjKAmZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BB0812C8; Wed,  5 Mar 2025 05:59:00 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A66812BC
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shoUjk676CkLIPWcLl8mOpBf6YmsRXIbnCKvZiUIKsOc0n8HqQoU0MtKzeI1nF3aX8CG60DKvnQBOk/8cshysXdAThmqcWQExCs+l5VsARgqmTTuw1MV0Iw/Sye/Btt3d3bs6bIMrfkWrENL652UhSIEuwzvzAW5GhrfzunZlNdDBKcut3zhaPox6ds//c3EL2FS6OrcSL9aNQDk5wZlas26nRTcQuGpUgTemk3WZOrhVxcoq/vB30XUb0z/+RQmiimrcMQ3ciG/fQjdDq/IdTkylT2YnzwHKI4I1AlCCVQoqfkKlkjFif3jdrHyYxgZmU8Og7tCpmg5U8E92fmUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTivU7IicKpj5YqpOJU0D2jVSCvF+KP1fyC1yP8zyM4=;
 b=i+pdB4sz86nFXUGj+1xMfTQXrQB9UVFVpEeJEyLhqAg1RVAO5jkub3kh1wCBWfooxV7BVMmaqbCoc2GrYDJbKNQv1nBMIO9uKo/AWukRuxlI+6IJXDCyhoYzrGbo5x8ZeVVL5b74rWj0u+2LVOtbEHiek9eMZ8wfgWPqfx535UBpeWs2iSyV8X4s9VEtYQ8AXqf859b0LtSZzwgLxnoAX6mnDA/a7FaxBMphykZmXNBSHSCmqVBdYg9kaMltG89TdjWq9lczuB6frH1eFsWuYtt9TQSHeIa8PIqQdwe8JrjCKKCFt/ohAJ3nfXQFsEV/rUSBoU0bofiC1GyiEqNtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTivU7IicKpj5YqpOJU0D2jVSCvF+KP1fyC1yP8zyM4=;
 b=qUjKAmZ9ajH1LHQ6to0jkApmTIX+/bh5gZFjLQR8Qhv6nAQVBgbQbwIjQjolyhe3vRs7L0VAbzs2PO9xKSx+ZammFGYc+39gXt6BsbvH6XTJHVkQTupuneeUdD4NN1+5PWvZau6YguVWL3cafTx+1ufNHsPc+5+E8YYvMF2Jmudw1yjzjk4105kIfY3x7qlWA7l63YAmz0tWipxnS6fPmikHB846ly1Wc9QIGvK5rGDh1K+wN8/TynshOnPDQikG6JLatIEzyfr3TYlFTz4wt2Yi/vRsUjN2gMue3mjauiu1FtYg5c7O8Kp2tWnDf+NXLWSLE7mOnFFqfuYO9qRWxw==
Received: from CWLP265CA0273.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::21)
 by AM0P195MB0674.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 04:58:53 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::4d) by CWLP265CA0273.outlook.office365.com
 (2603:10a6:401:5c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 04:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:53 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 10/13] board: phytec: common: k3: Make
 configure_capsule_updates() static
Date: Wed, 5 Mar 2025 05:58:35 +0100
Message-ID: <20250305045838.3614661-11-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM0P195MB0674:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a8a330-0dd1-4117-4e59-08dd5ba26d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kz7OT3E+PqmptjZKrJZXDor2tH41qL26hDDraDnzP/Ho8EpXev4bvWRs1CqU?=
 =?us-ascii?Q?jcq19qIAo965uDhiI0t+gMuBtfit9V/Q4JAOtRYrd4BrPTnJF0RFLlL2M5FD?=
 =?us-ascii?Q?51QQ47Pw6Pu1WRUI7Re0S8sqbbGzIl9QlJHOCjHKDSgs7fdejTNbPiV9Bsej?=
 =?us-ascii?Q?F9WyhAq1EZIgJ4b9bRjwr1egfoqrhmbw4DLacb4yLEBfhTSvySEgXKhctQ+C?=
 =?us-ascii?Q?ptsEw0IFWn5UYHApCPKTEuOIXDdfGKxK3141KxWCNZuUsdRUtBLDAFKlZ03i?=
 =?us-ascii?Q?9taamuPJllvcCaVs/guUysVlaEV4u5lyhuYoghkV1wVnmRsQgfSvg8VOqhDe?=
 =?us-ascii?Q?HjuMX6KzFuY45/8a8X5iV3eMclMl3sGyBCut++MfCCdWUCo/smfvAkJQWy1/?=
 =?us-ascii?Q?b8pIjetx9cYRVqttMB2M/Lk07yPIrmmJiPNm+dz5N2VyHyX3gvjrDW37j8aa?=
 =?us-ascii?Q?NUyDo2gLmzxa5mu12RkVhfmat65zkkvkROhpBIPVNLXoz16kPiD04TXYWa/H?=
 =?us-ascii?Q?MDJpQKOdKHcwqLa0xwqsMgcWOZSKHNewAn9LdkgcGLw7zPhBXNJBp1vVgQ/C?=
 =?us-ascii?Q?RMSyG3vXIknqorP6Db0z8lYGg6C2PItEG6YKwKiZpKtwSARpfu/3VHXY7/hP?=
 =?us-ascii?Q?4GArSXWzgKmYDjoNFfL5SFhfyxVuLh2qbhhZ2n5p8b2NWEvZjORcDmQQ+G1k?=
 =?us-ascii?Q?HVnDKMoPUQCsdQ0BXrZKb929p0uA2QkBm3ldNZWmxf9NHsZNU8h3zrCM2CAC?=
 =?us-ascii?Q?yQ9+rEcILIDYnUB0LAfZA5XG2EFYSguNU0RTPSM3GG4nePN0KEJ18escbrfG?=
 =?us-ascii?Q?uwu7OM4ux5Y4B3wQSBhsmOmbDfeSX08WIt6CDaPomA45t/KxNwXNwwZR70QU?=
 =?us-ascii?Q?CEY6CBkL4Np4JM0JacOtXefmxIHFaNU4DkFrZxxGz8IHwQ5Rtq5wrDrJZaTP?=
 =?us-ascii?Q?fYtSM0+0pIl6d0tYx/MdBHw2pxZY92MV6wQ7sm22rODHGjd875RGIN7Okg1p?=
 =?us-ascii?Q?UTro4To536lXb47Pw46CDWLALKyYCRJd/jRogdNrKJeH1kWNnK3i9gLnoQFZ?=
 =?us-ascii?Q?D6Vztyi4wC6sxhMiAT6rZUQx8aHtMdMGhQoRRPWldIWI7Dhi40TC1gkqIN3q?=
 =?us-ascii?Q?7TM/nthNC94hrIwKhUGMV+L6tyAm7V83votm6ttwg5sihsxvFQ/E0zjUZbyw?=
 =?us-ascii?Q?Ky1cFLJOpGFZqbXBk7FstN6IsSfOHlVvCeiQO5c/IOw32tcFa/gaM4Xt6D7R?=
 =?us-ascii?Q?x8GpPH2VXOSxJx18dNSpeKUPF/tqdgrb4ry4K9DCkRN6BRQ1q7XSFhEVCyya?=
 =?us-ascii?Q?NhJz+xw1WLnQ1xWuedAS6m6mAxjP3EfnfMChGZ2LFLPeNDhkfjIDNigCg/LB?=
 =?us-ascii?Q?eZi5N1UCvY8/pV8mFWiETeNDKO1AetIhsQWioEnAyEAHfO99njbFNUwm+P65?=
 =?us-ascii?Q?C9F3HxjDtPpfyjGqboaW6kE48ooObShiEP0dKfc3y4nlFkOfnxyU/sgfzH0u?=
 =?us-ascii?Q?ATFJ2Mwk9ScWL04=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:53.4850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a8a330-0dd1-4117-4e59-08dd5ba26d6f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0674
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

This function is only used in the board.c file. Make it static.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/k3/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 9d833456810..7d2146d5727 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -48,7 +48,7 @@ struct efi_capsule_update_info update_info = {
  * Note: Currently, eMMC hardware partitions are not differentiated; Updates
  * are always applied to the first boot partition.
  */
-void configure_capsule_updates(void)
+static void configure_capsule_updates(void)
 {
 	static char dfu_string[128] = { 0 };
 	const char *dfu_raw = "tiboot3.bin raw 0x0 0x400 mmcpart 1;"
-- 
2.34.1

