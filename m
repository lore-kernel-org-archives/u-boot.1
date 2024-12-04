Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075C1E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 07:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 635AC8910E;
	Wed,  4 Dec 2024 08:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QlNU6XWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8460288875; Wed,  4 Dec 2024 08:25:39 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC258950F
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 08:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKOtysMoJAIzHLNEXdw6M0f0ih2cbvVLasr4JCnDEBpUe1kXAzklyrb0N2SbsNKeY+0zdt+m2hje9J6LshJR6S/dUk3EJQw6kx/D7nxil3moPwSmppEwbb1BzKx+/r5w0yIwKcFbBFAFVvfKe+JneZDL161Kh45lVJTEmKUxDLxcsvqamwpp0aUu3OFlwpzB10jngXbecwqLQTEeoTQNS/qfWMtAupIinmOgRr1Js4Z05LMu3opDlJvpYMvbNF8q4rBwAitoUsWj8HySEDE12H/u95rZgVBQ6UUyeU7iZBCPnlLsLvYYAuTgGj06IkeLBLqxSygMEYJBB2dKd1tYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmSsb845To7VvN2YW0j4ep2/Ig1amV3XOLopWPWqSJ0=;
 b=euTjsDKcnknBepV/gY/GYmwNVe6Q5YXeuPFTKMVOjkj6emvW1hSzPjHE0Od/962TMrE5pOdZbdzp7r8zlBlBg9C9A2xm/ULgHmYhB42nm0/0XjC1BCP89nvyqvzOrJbluGOIeGl4pjKQFErYfphRyuK90p9sDFjyIyxug0FXVXWf9WQnAXkxsJREKRWItknW4TsgGMeeS27NzFRag2+MRxUC+1qxVM+yF2o0GycRBwISv98tL+x4O5OV+F/jd8vIf2ScX6hKss9vkYVXD0oV6zl4GLWVpLxBTI/eLP394bVQT8HymHx3bQB7xMXHm2mIPAkDw1C0TNg6cClOqm1uNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmSsb845To7VvN2YW0j4ep2/Ig1amV3XOLopWPWqSJ0=;
 b=QlNU6XWBN7502780ZPlKrll69BIu31KC5bqu+ydGd0cDXUA9pIeUWJs8G2DADmlrW8+QRaZhRcMl2knlsabrEz2vM9luD3qQ9b+W+KeFTQKVB7lPRP3XP/Yl9TJ1h0boNIyTsSd4ie+ZKseG6y4TJFwhXp8Dgtlvf0BfC25UsNw=
Received: from BL1PR13CA0315.namprd13.prod.outlook.com (2603:10b6:208:2c1::20)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 07:25:31 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::eb) by BL1PR13CA0315.outlook.office365.com
 (2603:10b6:208:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Wed, 4
 Dec 2024 07:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Wed, 4 Dec 2024 07:25:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 01:25:29 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Dec 2024 01:25:27 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <patrice.chotard@foss.st.com>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3] usb: onboard-hub: Update the bind function based on
 peer-hub property
Date: Wed, 4 Dec 2024 12:55:20 +0530
Message-ID: <20241204072520.213949-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2732aa75-7f40-4b8f-efcd-08dd1434d5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9TixkHoytN0uu/RXpn1Jkf20/NpjtrreYLSQlo8bslRV99+BUCNjgbeFarQp?=
 =?us-ascii?Q?NHrEY4EKmcs26fISlg2ImQkAAnHYpRks21lM6Hl42mTD7owtlpVIiNxWP3GM?=
 =?us-ascii?Q?VUCHxbCamGyyqawOAixRoId0Rm2M3gmjlyEGBi1S6JThjZRZweN0FkudE93b?=
 =?us-ascii?Q?mlIVoj+hwf18tRr1Wbmc1y8KYD8V9xZVtN5O0cZ5RVF/DUb2uFESrK3jjUox?=
 =?us-ascii?Q?SImTkKgX46HN9DARxwUbPbPGNgmogfG7kEh29nOCPNdLjHbW+ivcwy9B+wMr?=
 =?us-ascii?Q?84M5EwHxSxaxtUYgDvFnCE2USzHw5ZJq7ESlkjx9P8aHytmKslYXghaa0nJC?=
 =?us-ascii?Q?ITgzitod7thoSfRXjb6bpbOWzioGzFWEmYYddUaHx3yoCQe+xIXP15SQ+Ei4?=
 =?us-ascii?Q?mB/d/wTFXYYsI7YF9z2/ogzXTF3TWNps3e4w1/byA8O84OuVN+j4pJ8KnDCy?=
 =?us-ascii?Q?ilNfjP6TvarW48oK40xnw5uN8RO672GnpxX461M6w8JXzeO3Aj9ZMwm6HC3E?=
 =?us-ascii?Q?vnq2TnTlo+vOeA1pUDilDIqoP4RN6/Avc/6gAaxXsgM4ehfhOOQqZ7iEOTRv?=
 =?us-ascii?Q?PEPQp2f3PDabjRjGWRZnd2DUW6QcCvMfxFUtcH/LHxeZZnD6wluWhwNhPX8J?=
 =?us-ascii?Q?6iK2S/o/hLdsRyd7BLeP+aw/KSvpxTST0DvEgJuZeneODaVi15FuCHU+2oum?=
 =?us-ascii?Q?Akq1Stg5EqAqx8O6F9FrmhLEl5WOcglgbvdJX63V8TgAEZyDV0azTHOiKm09?=
 =?us-ascii?Q?2ZYHD7SZl6xb+a1JdD1g/diqEHQkvE6TvZNnEZIQDXUVh/wTpj+hJj+M2YSy?=
 =?us-ascii?Q?wKv1QGBBmbPTfPIU0d/INdGbWfAzjnmqNToH50rwP+Ho+nIgNKRxq4YsbAtd?=
 =?us-ascii?Q?1oZp2wzB1ycFlgGZ1hkpnrBbmbxxJunbf9woylVdROP+ffYdgj4MXXIexujd?=
 =?us-ascii?Q?av4M3RB+WBB3szX6M8ohkQuorFtZHE+F+UyaVWWImaCdCq/UlG0t2+P7V/Qd?=
 =?us-ascii?Q?o9JQmKCZQpn8gwRsgRaSHm5USMzrJsQjfR75Pi8ij4Spdjp0uCGiyLbv3f2u?=
 =?us-ascii?Q?lakXOwgDFTxAo4yTH/4u5ceoGaivELJt8rk8yP7SGLCblq9c9YV5oiHNl0Kp?=
 =?us-ascii?Q?TyQVt3lIs4cBwClUXs1ONGyVWM9Kn4fmSRxFDR5dPl3V9lETEy7wNcfPq5RF?=
 =?us-ascii?Q?NMdG7mVsmJ7isHjDupZdT7GmOXVrLIdHFukwRkbWH01JKqm7MI+Gp0/Fz7md?=
 =?us-ascii?Q?WQFnY/uAuvN/o6PZTlQCwYd6Rb0Gf6OmfFUY68m2Ae6ai/m4d279XPedVw56?=
 =?us-ascii?Q?Svb3HfRzaa46vKU4KWOIXE3LDwR4s1jLOJJWUijdn9LLSnkeAyYMyzscf/k6?=
 =?us-ascii?Q?EnpVbN0cDIFQsVWXKduHUExTsFbgKIEx4c1A7LOJkgUfTrQqyywOxbPzp8u9?=
 =?us-ascii?Q?aRQzaMK5J/Vq99Xz5J6rmJ163u9qd6eE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 07:25:31.1523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2732aa75-7f40-4b8f-efcd-08dd1434d5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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

As the "peer-hub" property is optional, don't error out just
skip the bind function.

Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Removed the peer_hub variable and used the return value.
Changes in v3:
- Removed the else condition.
---
 common/usb_onboard_hub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6f28036e09..7fe62b043e 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -183,7 +183,12 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 	int ret, off;
 
 	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
-	if (ret)  {
+	if (ret == -ENOENT) {
+		dev_dbg(dev, "peer-hub property not present\n");
+		return 0;
+	}
+
+	if (ret) {
 		dev_err(dev, "peer-hub not specified\n");
 		return ret;
 	}
-- 
2.34.1

