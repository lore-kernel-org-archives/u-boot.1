Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21356C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD03806FE;
	Wed, 15 Jan 2025 11:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HLWD/YqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58FF8070D; Wed, 15 Jan 2025 11:35:34 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA06806F4
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WScP17T7BNaMB56Vx+8nhfGeW7JpzwQqRwYLo2wjwlszF4qJk7UOcnTvkBiSqA/1TTp7K2HvxFllASOkYiRLew2hOTJV9Vd6XyToYrMRDtW+PBfewQYRL5YFSKpZvO2ZKnI2fIMgXV7wfHWWjjyBC0qdq+I89F8DsmXUXLthbwuOL0JnCPY6itCKcrbxqc/KShb30WyvgKAzJI7J1qArp7BCo+QAHSmIBdw5DksjHhYTPWPuLhvwBmJiI1AGEDH/h3yiReJ8FNAdSsHIBolbV/d/AZdB4XJOWuPHCKQJ4TkkcBlV6jKCWO9pxJ2hf6cj71+cTX6cNVYhuK7XOL+YNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoWTNqWsK1XZSYEauPbUUqkuOwEpQsP95uS43+bOEkk=;
 b=WjYB8ooGpXy441DnuKyz6251M/o+8T3Grcn31Z7pLbhT07ZwNdv3D2ec+lWhPiA7X1ruZdhKQqTA1cVhs2bTJVN4eY33oo+fL0eY1qDJjZNyXZLHBCJ27maeQxzRg4NkzhkRmKdxDz/cC4xOGblnzRsVfQIbOCgeJXeoZp6y8N1FdLeSD3XVCmXcEemjZ4lzm6l8WpeiKEEFXDIqKRc684Atoebg7uYScelLFueAawucur8qOj41wjHMbNCyFVWvP+03hMW+nRXDVZdrCfYBAVHehojwQqQed153fP/JGJi3nMQrHaPBcgnDZg85kbrSza2xcIy0lxomrnFZhKBm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoWTNqWsK1XZSYEauPbUUqkuOwEpQsP95uS43+bOEkk=;
 b=HLWD/YqToS4jT6bK6WuPZPFvozuX18/bIb7dRWGeXddBjleofVFnGubLtoaAY523nBG96setDms2QsZ7na+l+taas1hgdDB5Q2/QVz3CqWNMGgJf18LtVBg4Ur79sz2CH2kk9YAojLJ52Oae+SQftXdKBKprVuhJOxacl3u4O5zmWHCnd01AzqVwb5XdVoDMlPvSPo2Sp8RqzC/zoih23kd3o4qiMKk0/W9vm8mY5jcQlfgg51gjwg9MnR+PWByC1imy8hZOa8TEqP60ofiqbHR4hVTxx+dYMV0Lm25n39Pj+u9XWJ6LBjymZqgv9J3Lyz8j3leMxlh/3ts5o8MZgg==
Received: from DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) by PAVP195MB2184.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:322::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 15 Jan
 2025 10:35:29 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::ed) by DUZPR01CA0054.outlook.office365.com
 (2603:10a6:10:469::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 10:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 10:35:29 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 11:35:28 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 11:35:26 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH v2 2/2] board: phytec: common: k3: Expose product infos to
 Linux
Date: Wed, 15 Jan 2025 02:35:02 -0800
Message-ID: <20250115103502.844304-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115103502.844304-1-d.schultz@phytec.de>
References: <20250115103502.844304-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|PAVP195MB2184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff4ac64-e592-4ed6-0fcc-08dd355054fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DNt4m1r09Cef/xFvklU5eacqt7QG/n0zqUULNOnFn1bljOqK7jbvkaTYmEnj?=
 =?us-ascii?Q?GT4afdta/F8LxOzI5leBuN0xqrhtI09yYbJCmNfhvtieARagdIHzty5dP/2W?=
 =?us-ascii?Q?SXyCzA3sWaWc2sK+hflyrjOg2L0lDzehFSuwsLS18XZ6kvXuSivtZWKT6t9k?=
 =?us-ascii?Q?RB9UxkOzPyPcLIwIOpfPQ+clo9NAYCHMtTU9pprSEIj03Yqyuc75Ouk8F1x6?=
 =?us-ascii?Q?Byt4HP0Pf2I1ApubUfc3M+xFDTxyOAws732ZByAart4S7s5NrNy1X2j4Yp/P?=
 =?us-ascii?Q?wEDkp8WMQTgHuNj/LOfUJi6/EC+byPlWfP13jxSt0WXfwz6oA1ccXVj3i/W3?=
 =?us-ascii?Q?vWQrPNHGN10rhcBqL1vY9aBggrkf/FgfHAJuEjsr4ToF8tUITZ4Gkj9RRwyN?=
 =?us-ascii?Q?HOLBYwHAC5U//MjSvKkDgEtIOB7BE44tmr6dpA/38+H3TkoNf4fxuTG1mBY4?=
 =?us-ascii?Q?V4FumQgZ9cjA6GZCZpqi+cdSW0dee6qRp8cej2uLWB8uIafUV3RWzwdXwggw?=
 =?us-ascii?Q?VoSgRf8Md69cPTnP0+F7EZ8D1MGOhGDRi5uIaBv4kWqm2oJ4RFlFX5ZEXaxN?=
 =?us-ascii?Q?DDsoTbCpIfBd1SY6ApHm+w/REmugyfl4aZrpk4pkqdfnJ+DWjmckTWFATIQh?=
 =?us-ascii?Q?XY4yJmd670lFTq8OXA7twD8uBDYEGCCpFuMdheidtAv8LCsWLCEWNc6Zc6Z3?=
 =?us-ascii?Q?MN3B2LpSv9lg6yg4klXPNvYgrZnDnxaLknkGuJMfOuR9fjS2jBgpJs9aIYip?=
 =?us-ascii?Q?tvN0xvyuyZplsbydvVSq7QYtonFfr7wz7ihbLWJolQ8XG9hTEDcKi6OZaEpf?=
 =?us-ascii?Q?Lr46XgxckDWTZG+Zqeta3KI+tUWeNN2xzxEPFMMQo0INFFgLgLOEhjd2Dbzs?=
 =?us-ascii?Q?NYRUco014JoAgz+9s13Cm6d9d16YRN8CViMpcmQQZppVfMnHjeVOTLrxdDzp?=
 =?us-ascii?Q?uk/8mePnSKhEYr8gYngnPgXvkpILMLYKs3BY0alooTRs8ZVhZ6+HZNi+GfQa?=
 =?us-ascii?Q?1CWa0KPwJ/afqrhg7e/m3MoJQKsfSlSulwROWIJY1VaPCkVHyCc/rKu+fnQ0?=
 =?us-ascii?Q?XkJGtdE/t260yLitvr4tgiRVPcR0XRmsVq15im2vIbCShL4agUUZs1lIHz0u?=
 =?us-ascii?Q?m5+h3d0z3iv4zVumSsdwHRqs859p1Ylcu88hZkIdzYbyBTTu2UlID2vPfEWx?=
 =?us-ascii?Q?XAytIidrMp1xegiWT+UdoplyhPL7XwBUjQK9LmdQmhCh/fapYs/vT4BR/FG0?=
 =?us-ascii?Q?+JTB2fE96ADGMGbMllAXqy+pdgIXLIXUKQuymfHmB+c3fqa02ZqkgJvIzLD2?=
 =?us-ascii?Q?R/yoMw9rmD+JkVn+jks0qozlv4P02EB4CMF2KEb3/5ESs5AT/UvwUfeAKViJ?=
 =?us-ascii?Q?2S3ro8bYfWKZrVff+5klP5BB4Xzvp0TEMR3mXnYiftu/W5trOo2r3sy/MRzb?=
 =?us-ascii?Q?qrdI9PmG3XrA3+EK0P0ImJCy3J00LAT9tJGrzVCT25TevVxPqCf4H0bsm5SK?=
 =?us-ascii?Q?LvpFwy12qRW29Qg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:35:29.5248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff4ac64-e592-4ed6-0fcc-08dd355054fb
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2184
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

Call 'phytec_ft_board_fixup' in the common K3 board code
to expose the product name and part number to Linux.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---

Changes in v2:
 * Removed 'return 0' right before leaving with the same return code anyways.
 * Added Wadim's Reviewed-by.

 board/phytec/common/k3/board.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 9ff861cd3f4..3f70dcddf45 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -252,9 +252,21 @@ fixup_error:
 
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	struct phytec_eeprom_data data;
+	int ret;
+
 	fdt_apply_som_overlays(blob);
 	fdt_copy_fixed_partitions(blob);
 
+	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (ret || !data.valid)
+		return 0;
+
+	ret = phytec_ft_board_fixup(&data, blob);
+	if (ret)
+		pr_err("%s: Failed to add PHYTEC information to fdt.\n",
+		       __func__);
+
 	return 0;
 }
 #endif
-- 
2.25.1

