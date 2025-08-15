Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E24CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 16:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC75683AA1;
	Fri, 15 Aug 2025 18:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZFuKaXbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2AA083AAD; Fri, 15 Aug 2025 18:03:01 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF7F83A9A
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 18:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnaRDJRPuBaFwIR8asND1TQSxcjWqZJCDfgICgaboRidOQHxLXAtl2M6C03d54uTc8SDJ7/mFe2jpDfqYVgEBwUJHum43DcLvVKbnEEwQDhrNLRdVWVOKBPFhEw+yhx7eG9HqEIg+g9/TzKm77KB2eH6Gyput7Yyjr4p0NOB/fX6HBnPHHsiBJn+zkOj5Rd7T12cXqk/BzrlJ2POBk30mcXz6RzNBzi9zfsg1yb/TGLJAcaVuF6cpeGBOkNWUwsjIBqMK7T7yk5r9k/cJ7oE28gnRC9lKhDUPt9AIGti3KsGB9KAZKZFKrD2iF243QAjOnf65R3tvU9coo80cTuJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8BFf0Atia3MzfeLraodDPa3eITeIbOStlBL5jFoCCI=;
 b=qdeVTC5uOLFdnx8nXXQQwiK6jUHHpbPyXMq3apnL8bsDwsPBio6PYAPsH8zLJcUSmgWqZjYToENdSAarzWoTgg05V/eAyiEqdMTiZvZfZWBQSgzQR8swDgkX+G7TTd4kYGOFB8mE5iFFyUiNkpop5/cydkijbxmvqbNHEOt9wrFF7XBwYdWWWjUDz8RJ5Xs7qA/BMJJBjxC3ckc7cpJH64zIi7GutMabRD78qRjK7EiPdRXX39nQ4fdiW+zKCWDgtabYmrKYAgySv5hl4GloRkdW6vUrK8IyWxgm/uyaqF2HhyeUHZvgj5cJoOJSQDx1Gqv4uABzT7KuTIfVlGPApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8BFf0Atia3MzfeLraodDPa3eITeIbOStlBL5jFoCCI=;
 b=ZFuKaXbxLRmItFTZLzBuypZF5nCNYVN7y7/54z6EaGi2IfoMvUvA3DSsi8hIjBXtTzsw9i0yor3WaTKh7hdWTfDsUMaNeiLqNvk2LWGjluBcaGCbZTL0o/8pxXfoOB7waC/J7i0aKzsrK+y77ivA5okngjlnerGOamNy0FXx8TgG6BtJ5ZYt19SSNQ6fa0IOvZ8JRDPIG5QxHFuycgYbbLwBZVVnxGPx3vly88Luumry7RROsOSfOjpPibp2Je2AsCgz+eIm6300ln24Eu8ODgew7E9PupBv7VSbocb3r+P4whWpywIUt2tVyZZhiRCnfIT/kZjf6hq7S4sx/9+C5Q==
Received: from DB9PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::13) by PRAP195MB1409.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:29b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 16:02:57 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::f7) by DB9PR01CA0008.outlook.office365.com
 (2603:10a6:10:1d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 16:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 16:02:56 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 18:02:56 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 18:02:54 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <kishon@ti.com>, <alexander.sverdlin@siemens.com>,
 <s-vadapalli@ti.com>, <c-vankar@ti.com>, <bb@ti.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Date: Fri, 15 Aug 2025 09:02:40 -0700
Message-ID: <20250815160240.3575140-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|PRAP195MB1409:EE_
X-MS-Office365-Filtering-Correlation-Id: 675d796b-3526-440b-efe3-08dddc153359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h20eh3tStSf79baQGyhskjIqXu7GKoa7i8G7G71xV86qOwCvRGGYmjDShIT5?=
 =?us-ascii?Q?0PXTJ7E6cSS7YtDBz8+dB3E2p0ENL93BjHXPLTC1TzHMMxlhynRzJR1u1aAg?=
 =?us-ascii?Q?45AQTfx9D9e7ELMpHwAYqfdSYSKKEDgOP6WBv8rmPIw0e6+ziH7n9yD1GzXI?=
 =?us-ascii?Q?WM/ljHfiKTzkDOO98cRBV+jO9JXx2rQYmWBALjZpD+1QnQHlF2qi7cZXlV01?=
 =?us-ascii?Q?8tiWzrCoxRINfEWH7fHDLicAWlnDAe1LQTtfH81ue4gI4WTmQTgoLigc5Djt?=
 =?us-ascii?Q?Rfe7b1FA4/qDt5ngFZaJLYFpaCwxaBirz8KD6cwBez5r5HVn6ogo9mpANiir?=
 =?us-ascii?Q?6N/PNbnNkU+vrlTHXsKFVS/BBxOfkddDaNEmh8cV1y/WQaU2BdFQt/+lsWQz?=
 =?us-ascii?Q?Hp9MoU3NSVIi/JcANHjGaDEBoUOrH1SFBqixnwKoCC1EjHnI0gb2OdJP5us5?=
 =?us-ascii?Q?umGCXw/V4NMlxFQBNOU5KZe+vCkaOpOIYmuT1fOXbIWD/FbwxYhkV/tqTUz3?=
 =?us-ascii?Q?ND5Q86/y1uRAiW8/m3M3QoVpSLEluVnEiwWpeKw4tzEpCul97eKPoqVutiz/?=
 =?us-ascii?Q?19nNXenKbthHIYvrJGE1uKvR1TP1fxpdCnPxIaDQrcWovcwYCxnZp/kduB9L?=
 =?us-ascii?Q?KywxwfGXh50ygieZjRs/LPFeWZ5Ti098lI8FxVZ90iQcJ7cQNxP7p0CjFd7F?=
 =?us-ascii?Q?j9b4SilBJvW2xPxTBpWeTZRowyGRaWh1K1DMDa5HxZJ1r8WWyLILg4EZJWRl?=
 =?us-ascii?Q?peMAedjtz15UY99jLV0Av8XzWZqEclBYvo6XGv7zY1KuVJgrVMxo45HmQStp?=
 =?us-ascii?Q?IfEMQVr9CmPS+cD9gttp6Cof+UFbwfvJfy++YMWGlrOZ8+KXJl0VwofTnBUH?=
 =?us-ascii?Q?cNIauiiumaJyQGKW2TjMSjz0yY7aVNHqleIDCruAaGcGQVnJeknt1Bocblaj?=
 =?us-ascii?Q?PT9bK1mE7033wannjvbrY2W6A4rh+yWK/9REhmmcI8JgBrhuB6zSAjLgy1sW?=
 =?us-ascii?Q?yOerM4j0ZQBWCVTB79bhy4lg9/uGb6Sy1qAo/6Zh3m89orGWCyDumvRNU5z6?=
 =?us-ascii?Q?HIXITxIb+Vdbn0iguKgsQu5qZCMJdTlhxLLgV09R7a23Lfgglgn2xblfKV18?=
 =?us-ascii?Q?7NlM2c+tGVBoUSZ9Be8EuZguixhL/h9+Pye9usZCGr+vRWd0Jl/r9ljBG16r?=
 =?us-ascii?Q?QxXKhJ3aIq5oPZBifWicTBhG4ZcB7pIrtfflOjnbv55wqfpD9wIE8Ck8eoUn?=
 =?us-ascii?Q?2scsCGyxYC6icm1mMi8NX2OirVDraOhXe5RMenhvkJeNNFWqony0S85UuVfC?=
 =?us-ascii?Q?bno/W+UDJ3LpCOnX/8hU78GxpHN5y21m7G5MXi9IZ9R7HPmOhWFdViqs1+jF?=
 =?us-ascii?Q?PN+ZeUJQ+gcf7WJlv3cu9FKduKVjeSedRSndaob/sxA9O1RAlEdj2b+cHV5z?=
 =?us-ascii?Q?mSxMH6Dvx2SuUK3vLGgQ5hcAI7KS9GMekH/E88rZRNevRvox3U7hcRkJ6hOQ?=
 =?us-ascii?Q?xwQJqXCRz+yBoqZ+nv7Hj8cytV59y2BMw5Vs?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:02:56.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 675d796b-3526-440b-efe3-08dddc153359
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1409
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

The watchdog requires to have the MCU ESM error source enabled to
trigger a system reboot. When booting HS-SE (security enforced)
devices, the MMR registers are locked again and all write commands
are simply ignored.

Unlock the MMR registers again to successfully enable the MCU ESM
source.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/mach-k3/am62x/am625_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index a422919fab1..498bbe45b38 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -84,6 +84,9 @@ static void ctrl_mmr_unlock(void)
 
 static __maybe_unused void enable_mcu_esm_reset(void)
 {
+	/* CTRLMMR_MCU_RST registers are locked again on HS-SE devices */
+	mmr_unlock(MCU_CTRL_MMR0_BASE, 6);
+
 	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
 	u32 stat = readl(CTRLMMR_MCU_RST_CTRL);
 
-- 
2.25.1

