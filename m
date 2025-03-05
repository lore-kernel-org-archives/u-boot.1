Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E5DC282D3
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 04:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40C5B80BAA;
	Wed,  5 Mar 2025 05:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RAc4ADef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1561E811CE; Wed,  5 Mar 2025 05:58:54 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C377D807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+aygEareX9b+HTA88rrIFmF6qgLiYXNj0oASxZAb0/w+vwW3IBhUNYazjmZbatoaEiV0npFYJv0Ok1btPlXPZLRMUlhaJRg6TxBlY4AotyqAB7rUpWW7rngVoU8C8XI11QUcQ/Q8f4NauozMYc9L1A8XHEgYlE9SeuU5RspyJ+beUqyVPgsrGkgwUgWxxWtFahvLPkl81GOS0lpQwKOA+BPTEccXkL0sq9lfU/dtjgA81fO2fd3Avs0Wz2KfToKcG6B4mMNixjfaJE+3fmJblQVMybKoBwOaNLDHmp97aP1HMbFEYEocSjv9lWutdy9yqFY8dvTUyrz81VaMU3FKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8cchXKKtMeB+jo5g/wVu4fZfhi1GqGqxq4Fd/Fvtzs=;
 b=XfXwMqaNqRdhiCukpf0ZEXHOzP7N5aoiMWrcMsMnFSjiyVqgjSXpRXBdUqAL0xPCeGcPOGBIYf1gcn9tjVZAFNF1mngIawaY0645DSPlVG23NnU0LWIN+ptxBllV90d9kBFP0DIOSiu4Nf8xc6dMRv50IKEBByFKlnu0JC9TPQmRbkVXh/vqOi3QKPZfpceVwRbWpdNLcoJoaJSNezFLieaNAocnXzWTvA+u9/DnWIn4EC8PU8t0NS2s4hpqrA78TvehvAtHkpt/PAFxFsusoX5cOcf2EyK9pn+n+XlGReZzDWiKBl/yZZXX/4bNKv5CpvwOjmnepTi/OWJe7zOnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8cchXKKtMeB+jo5g/wVu4fZfhi1GqGqxq4Fd/Fvtzs=;
 b=RAc4ADefXkGY5+BAROBxNE/wLUl4FaGqEoGpNLpr812Yie2EBcKWA3kfv7isUZOTIfwqAASagHtNysuKzfLVB4HTeWU1KXtAqqvWvckSfQltwAgwFQmntNz6pvCZrMon7buu2RFKZLj3Dc09MNiU7PaKJPbEuL55AUG//eaCx9BliOjEv89Jz6UlptFuLeL9RYJOW0GAfiieMkZ/EEcs1Vk0zLSWvtfShAVjmrX+9DHJp4dYPcSyoXfUd3xhezQMdKistoobgYFuiTkIyRpC+9KgmhwvMfnBS7JX9b9j63Qo0k8quADI4ibSjhgVi/Z/hhLJtyugU3ieIsUUUo5Yiw==
Received: from CWLP265CA0278.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::26)
 by PR3P195MB0831.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 04:58:49 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::3e) by CWLP265CA0278.outlook.office365.com
 (2603:10a6:401:5c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 04:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:49 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 02/13] include: configs: phycore-am62ax: Define capsule FW
 names
Date: Wed, 5 Mar 2025 05:58:27 +0100
Message-ID: <20250305045838.3614661-3-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PR3P195MB0831:EE_
X-MS-Office365-Filtering-Correlation-Id: f36cb2b1-1ae3-4ab0-e0cb-08dd5ba26ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZXsxed+wsgJ/k/l5ZXTv3kKP/P6mjZpv5PCmESHrIN4DIKqLosgUFvSFqK1l?=
 =?us-ascii?Q?8NNgBfD94LnecRMIkPn0fkeQZr3tJCKpB6ddfGkTaq6GhJULJgfPVKi/qEH2?=
 =?us-ascii?Q?PHDYYyaGulv94a6TKHv6Zl6yovIv5emLaL6jK2Y2X94GtMQKQ5hHvFJ/JkFt?=
 =?us-ascii?Q?++kOKRBZVDcKKKBxmgbQXXiAqWAlt88WD7Pyvg1Jlrw4Jn7L8fHb7LAqedCD?=
 =?us-ascii?Q?wgqV+vzXj/IkahVDP84jPIwbIHsfVAYb1ziVl+bDx7O1gxMMOy6HwJgE3giT?=
 =?us-ascii?Q?lNrHlP9PPs+cUBMgWA+XHRMrl8bt0yU7U4p/d+/fRk8nLbL7p+qGcxLorVTK?=
 =?us-ascii?Q?YnEn4Y3oIw/Y0vpE/SK30XJKyf8WpjCeyj+Lbqh+eeCyEjxzStrF+zVDuKt1?=
 =?us-ascii?Q?6DnnOzuJZdgf61e8dxXOl5zmQzMlB9QpwDzQywGpXR/DfiiZY87tKtIhspQ+?=
 =?us-ascii?Q?uFqzrlDOVepPe0a9GrmC4ZV7FhMsmdp+Vc4wiLUHGjqa6OLvbqKj8AhdYI6L?=
 =?us-ascii?Q?kwhIvCS7JcGW/mnff5dGpgtGSgH8cZnCiLmxmeD2JjuPheXAVuig8mFqz2Gc?=
 =?us-ascii?Q?FPaRc2PqTnLlYbRVlbWq88VJLKJhxTIGXbjDiaL2Bj8PxZCOPWjqeccGYPNi?=
 =?us-ascii?Q?ShC28lP2igLj2cz5TuEhmpI18HKTcdW5HkC+dO5DTdz20C+0Hh0jp9NuDUqP?=
 =?us-ascii?Q?GTncMbyj8WsX0rPZ1f7A+T0LH7Zu97VhF/3UUjR4U2ZD0wgVzaDz5v/wC1WD?=
 =?us-ascii?Q?x3Vkmb0pFzW/F/4g3BgNuhb87WC2FQ8UayLDJO2nQXZ9VrKZbmEKp3ai2e3D?=
 =?us-ascii?Q?vVr9Obgss5PqkoPuADJ50zCFz1X6TJLqDZa0x6Qu1SIBDdD2T9yF0dVPVB2Y?=
 =?us-ascii?Q?5oNwplzWMjWs4/mt189zxZaBUyteexVu9BA+z7uHr/59kfvPSxJrPIDwKbLw?=
 =?us-ascii?Q?bTvyjZlxV53nfnePD819fEnDnTGGHwKFc+veHFgVwR/jtssn1OwgHZJ+nqHm?=
 =?us-ascii?Q?hjgNH4aA4sof2r4Ecyap4jFQMLvnMSZcaN6GYRNw5rIf5uADDAuylo81R86K?=
 =?us-ascii?Q?cTNYXrXtymMTNpyiuZuFa6j7/prDvzV7CEljgV+zJFz4hHcOgfhaZ7IP40iR?=
 =?us-ascii?Q?JoWnijums5Y0poGrQsUukS3XxkVrav/4alduPcaEffkFbTkja7b7bkcjwdNL?=
 =?us-ascii?Q?Mze/d6qxQrQ89qFYRjWfm2PAdNZToJQf+kXNY4n2PvNHZStJSIyTvw+bgTnN?=
 =?us-ascii?Q?/EiDQoEtVQvGxyHDgIF1Gks5sZpODIqmmBQ5V3Wdip+MOWxGlJdhTb8n+iAN?=
 =?us-ascii?Q?niCxR9DhEAO/CF0yyAgbCO1JwCHCM5raByXnByC2/m3le1kHSL53JvKoLi6q?=
 =?us-ascii?Q?pDDdM83sz5qo7XcrBKw8cdccCqOkWJywt+MwX27yekOVmMLNHuUwpYKP0SFH?=
 =?us-ascii?Q?2IVnwlvG/ls2Act4Km2YPI1uof7dJp9BkX4taMB0OJ0kk6vLZE9GQEQh5wfa?=
 =?us-ascii?Q?rtww5FLzip9h8wE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:49.1724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36cb2b1-1ae3-4ab0-e0cb-08dd5ba26ada
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0831
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

Define firmware names for phycore-am62ax capsules.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 include/configs/phycore_am62ax.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/configs/phycore_am62ax.h b/include/configs/phycore_am62ax.h
index 661ba8f73ca..4f612d2c2ce 100644
--- a/include/configs/phycore_am62ax.h
+++ b/include/configs/phycore_am62ax.h
@@ -12,4 +12,8 @@
 /* DDR Configuration */
 #define CFG_SYS_SDRAM_BASE		0x80000000
 
+#define PHYCORE_AM6XX_FW_NAME_TIBOOT3	u"PHYCORE_AM62AX_TIBOOT3"
+#define PHYCORE_AM6XX_FW_NAME_SPL	u"PHYCORE_AM62AX_SPL"
+#define PHYCORE_AM6XX_FW_NAME_UBOOT	u"PHYCORE_AM62AX_UBOOT"
+
 #endif /* __PHYCORE_AM62AX_H */
-- 
2.34.1

