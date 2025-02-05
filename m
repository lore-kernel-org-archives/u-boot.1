Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C569DC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDE280812;
	Wed,  5 Feb 2025 09:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fHBNDVXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AFE8081E; Wed,  5 Feb 2025 09:02:36 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FEFB80207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPTCh1MJlL6sEyP4MAUp24SJsrvLZi3FjgjHeugTPM1Ai1IsCka7LHAquQCXcCjptvyXSYLAltw6jChMaP3N2S+EdDIRhkM5zCutlsGgf8UMkQJUsBXqRWjd4mJn58/ErYFOwA5Bep2RHvkiPDwLssZRVEZG+yzGm/A500Y08lzNldMyNnDBzXr6TEjv50cYO1Wh/sbJ9SW0rH6xeSbRnsiAhNO8dOKeLonfVXC3tPK1Cj3kH5qmT6V2YeanBCv/oyV5KmBe9yCKfmm93aVtOlIUZ40UuBkFwp7sCG84zQKvKJi7lEqMJG1b4LWqQF+w/VQkvFolyt7J6nykewFuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJpHlIniUqLE7E1mHzZLgWW0QD55V5ybzprIRBB6rfs=;
 b=tWolT6D/61aCxYQ5WJdjK5TEMuYmJPxPdSE8U9P5hNmJ4Ww9Nfr0D4Ga09Z0PZ6XXPWsxy3SB3xlA62io3I/4yhK6H/MF/P+FCQPOgQU2D2azqFgYfLRCmwObH024s9irLB1ko3tNhMCdFM8lvG0DdYWXxsZuDz7Wj9NMLyo5/to0mWj6EuYZauoa6OifenwFmo2RqsvyCBW0T2x8z5FucZJzk8MZs9wRQB54ax+ZlPQxmy6PLFOhpYPqqKHi53wjKIonr+4d9kjRMZ68ZiC+DV6CgazJmEHPo+j6bStvx9YwZfzc46u/KlOyw9fHKZT7T3vMQbKqdwLTy7y6qUWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJpHlIniUqLE7E1mHzZLgWW0QD55V5ybzprIRBB6rfs=;
 b=fHBNDVXgyFSs+aef1W8GzzwzlI2dYlZ1YMvDCwIQ1rzDNOOGeqcHLIZmpLCkWYZsp+H1ens7XoCBVGWvPR2mQMQwTyKpWOQE0WhiQ9vdgii7EmaF6E2OTSyXGbjKcVaVQnn123bA0QI2qmfYSd9bC1373EBkZoL4EIUdOpnslEleSZjv6kO897knGuOiCe35Kqp6O2Ad5hlFw8u6rZMdSj8gXGzArxBhmpye2mf4fEVhZc7wQtEY2Hd7GgSF4TIn1umrCi3GvulsD3OpDfLAhuVF4WfPuWcTG8YaO++AcNpJGByc3CWDe76cwNKg5YYfx42KQQbV4Htcx/RuoDsHPw==
Received: from AM0PR07CA0003.eurprd07.prod.outlook.com (2603:10a6:208:ac::16)
 by VI1P195MB0672.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:156::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 08:02:30 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:208:ac:cafe::4c) by AM0PR07CA0003.outlook.office365.com
 (2603:10a6:208:ac::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.5 via Frontend Transport; Wed, 5
 Feb 2025 08:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:30 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:29 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:26 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 07/10] include: env: phytec: k3_mmc: Use
 PHYTEC_K3_EMBED_RAUC_ENV to enable RAUC
Date: Wed, 5 Feb 2025 00:01:43 -0800
Message-ID: <20250205080146.1944928-8-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|VI1P195MB0672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecd73ad-045d-4b0b-1613-08dd45bb7045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sFTeNQpW4BRm0Z2PjWSmDa40qOyNUXYauwVIsoQfOebUxI7U7BCyjxnfUUC6?=
 =?us-ascii?Q?5ZpnQvMJslobsJbGRFEAkGDt+PLrOJBtbn27maje+razEebjizXRqhUCyqcw?=
 =?us-ascii?Q?q8Mij88H8eiXKUrHQWZA0A7njAfPc/zSJC4c6ENxsc1Ln+Yhtcpo/2GAY+gA?=
 =?us-ascii?Q?PUBr9aogOlRHboyWpQU+aA8OW4ijb8J6QaiRnEb2pnmyUtN7NnGnIJEZjHCT?=
 =?us-ascii?Q?0f+Do/C9aTaI+vJqGykzM7mEzpzz/y1ritwUHqCSnLe3gQR0JjW4dkAEs2UC?=
 =?us-ascii?Q?dzv4RbHZTGAVJgNq6N6hVac/kZ1JPHFjUkBsukv4RZKJx99xXxBTFyvGWSma?=
 =?us-ascii?Q?UFoJhKzAa6/kldROk91msYtTht4ame+QYuE1G/Ult+xEMkoGVXDWRkrNvQ8l?=
 =?us-ascii?Q?IDZ44cwITc3Qrj8Vem82o/8JlpSUfoXx9oHDYTq/QEhlfi0RGRIl/w2qdiUU?=
 =?us-ascii?Q?IIIUnEvftpBRgohfW9emtiT2toEie8wjtRc5C7I1MsLIllu8E0biNvO6GE4c?=
 =?us-ascii?Q?8sYhPFvY1goAw5MNaahJ5HGaDliXDx1Yn5Q0F9SUJ6LKR4JCGRhDbhoB1FPT?=
 =?us-ascii?Q?k3DeP1ZnHTsFeoNvQLvpOyvvtYCnt/vt1GUisar+mzzpyAIjqTaKVruv8TFi?=
 =?us-ascii?Q?2qnyDZlcMVdU04qSvYSHl6V8kwiurBRy3WQY1l4bh3YFfORRsRHBHHFJu3xy?=
 =?us-ascii?Q?PzSY/n6md272o/PjPHhe6QbN1ohfIybtW/IMPAA6lg3yNf8zaqsFynt4UWkq?=
 =?us-ascii?Q?I69JrU5FzG0jrw4SQgPgOaIAmdpPLzTNvrhFJWRe/q/PX8oxi7oa4Sl4CzVd?=
 =?us-ascii?Q?OW17zK2P4VtBkBo8heRJPlD+3IoGpOKL2+mgsjQkdP7QKEyBQiNberVdQGkj?=
 =?us-ascii?Q?xHMhAb/wq8a/o3pkzdRiWmwP7vFNMuvE3NoJXpGeN02aFtDsKwaCCTvqhfIR?=
 =?us-ascii?Q?ulr2XdMeFGyKifrgrcBEijHPZBjR26+eL2NMpMyL6rF7vN9XZxaJzMZIRsSn?=
 =?us-ascii?Q?pngwkthgxJ9LLarNtTei2flB+8gBuY1hH8iyBab2tLpqP+MBoqpOjpTrv17t?=
 =?us-ascii?Q?x98Ps322aluoasCSmzJiPLZDUGq9zKRv+svdAhKpW5fAtdWGE4dXDJ390KZI?=
 =?us-ascii?Q?sJrTzqS93QGAEqug5aljG6QHWr4JUUsSuKpGREHAQmEvmq2ohwqo2IXdqaZ5?=
 =?us-ascii?Q?0ZcmsWxIejixduX/9orcZZd27jGI4/0nrA5M12ip2N0y3ol1y6LSSLocJ7hu?=
 =?us-ascii?Q?Lb5/Rs2hF/XDPWgDWYUqJ3D8w5DRpwSeLXmtJ94F1ordozxXcwP5FopTVLAP?=
 =?us-ascii?Q?Mp9B/3OgpESJGP/vZ9zG6nTtb0fviS/fYWpbtQ/zLHLIH9riENFbqUW5L+zK?=
 =?us-ascii?Q?FlX+AZeAXARpcOLJ6izqtFc7pJ9KGdELjjz6TKlfweW3mna6IQhu4y3KkVaQ?=
 =?us-ascii?Q?GACPUfp8u8u03+4L0SxCvj5/W89SN/TamlBZHeso7TdXl5/luo5ZFoW60NBx?=
 =?us-ascii?Q?iW7zR8GRf76kiEQ=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:30.0942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecd73ad-045d-4b0b-1613-08dd45bb7045
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0672
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

There's no need to include RAUC logic if it isn't required.
Use CONFIG_PHYTEC_K3_EMBED_RAUC_ENV to conditionally include RAUC.
Additionally, include the test for raucboot only when this
configuration is enabled.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_mmc.env | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index ad8d3a8b764..c4354fbb884 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -7,13 +7,19 @@
 /* Logic for TI K3 based SoCs to boot from a MMC device. */
 
 #include <env/phytec/overlays.env>
+#ifdef CONFIG_PHYTEC_K3_EMBED_RAUC_ENV
 #include <env/phytec/rauc.env>
+doraucboot=1
+#endif
 
 mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
 	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcloadimage=load mmc ${mmcdev}:${mmcpart} ${kernel_addr_r} Image
 mmcloadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
-mmcboot=if test ${doraucboot} = 1; then run raucinit; fi;
+mmcboot=
+#ifdef CONFIG_PHYTEC_K3_EMBED_RAUC_ENV
+	if test -n ${doraucboot}; then run raucinit; fi;
+#endif
 	run mmcargs;
 	mmc dev ${mmcdev};
 	mmc rescan;
-- 
2.25.1

