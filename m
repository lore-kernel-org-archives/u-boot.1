Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083B7CAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 14:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C53382AE1;
	Mon, 15 Sep 2025 16:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="ccE1KyAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E7B83071; Mon, 15 Sep 2025 16:41:34 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B62F280B9B
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 16:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mark.Jonas@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFGgTrqMGMQjPhleHoFmHi0rcJ14pTREgEeU097WqZV2vpzt9WKx4Z7hwvewYsrtfcWPmD6SnQgyKVPWRfKJ3jnatKbHW7reUek2ijX1+PsDKDi/Q9p9X6VMADue7GLAhaE6HbLtBXwgou8+MlW0rGBrNqYwc/rp+3iAg0DjfH6Y5/fMIl4vTsdsbiM0ODtnmCYvkg/hgN3SWpawlRZI8Npgai4GoV2Sf1lrmLkEP5GnanfRfGZ/ACZnNlSrStTCJt3aPhRid3ASRIo5dN5kmK/Jq0xf4GVd1Ml4RqUm3dpNyUf+x+zBTt6KHd/3ZSI4Atv1ebC1WDvQvXoXCIVPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqPQFLlgBbYTUz4EZYExhvXFmGCCj6DIb6gtbw1qG64=;
 b=Cx1ayNYFD9y2e7qEmbposlkq/kqRDe3ql6mU7H/MkUX7QCMRocUKrvEYgKGiRECXyGS6vRjbLM2yyZVNnMNRyAu8NT+guxyqQhcyP8ffk5KYWPDXVW4Yh76h30UIgMcI4BuIzkGka5sLVF7OwiWJR164mb8JVqBjuevmcT7C5pMuWZnJ7jSX9mb1yFxD0/oDP7fBAaiMwpmBtaaiZ7uyDZfetMA3Fqx429TKYEm9GBolB2j/7g0krSqGR+dUES3Hm4LAAj592vlG07y3F0PBE/X29YHiicCZ0itf+NaF3UhJYqaFoP9q+Kgg++QsjgatdDROAs8K8PkMdCLf2yjfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqPQFLlgBbYTUz4EZYExhvXFmGCCj6DIb6gtbw1qG64=;
 b=ccE1KyAWN76+BMwMl5zrsO92rZlB9J5dsvLamWBATkRGryuHHeU5uA8ZoDibBXLJ/Sr4h3A6FMxEaJokTudxOtUfQg0JjlkzVLlhjaCuuz1qYD++qcjqjqKpnI58oSkhhfCRoDiLpbXer7u8sf/4YxCGdSSnC27begIkShszvV1zITJVbxg5bNOjW86xX2/tqPUkdKRipCFoLUbV+Ci2AOVEl57qvGHp60PZE1iC1zmnTPiDY6DeJaAQLZ7h4XGoMI75cH6ayy07Jw4Cw51nZk3EZ0BH9aAI14jox1qQldw+taBxHmHaQcqw1pOdc89WRM90aTFj//DGavPNzt0LIA==
Received: from DU2PR04CA0034.eurprd04.prod.outlook.com (2603:10a6:10:234::9)
 by AM7PR10MB3349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 14:41:30 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::92) by DU2PR04CA0034.outlook.office365.com
 (2603:10a6:10:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 14:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 14:41:28 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Mon, 15 Sep
 2025 16:41:15 +0200
Received: from GRB-C-0009M.ot.de.bosch.com (10.142.214.88) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 15 Sep 2025 16:41:14 +0200
From: <mark.jonas@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Joe
 Hershberger" <joe.hershberger@ni.com>, Ricardo Simoes
 <ricardo.simoes@pt.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH] doc: environment: clarify env precedence
Date: Mon, 15 Sep 2025 16:40:33 +0200
Message-ID: <20250915144033.8572-1-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.214.88]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|AM7PR10MB3349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c222649-e128-40e6-9938-08ddf465f422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5pkxuB2Q/uoXMsN07R1Zwv2QyGT1dWDKoSCXcoJ/24HVrNF3EWPhXt8dpFzr?=
 =?us-ascii?Q?+omGddWHrLz83hvx9hpOzrAwQhiOSJVPtruubC3rkwVv/6xI8cK7htFdEE0+?=
 =?us-ascii?Q?LsmSmeuU/7HuZLjn8wIwC/dmNwBq3tpw9A8O4/6Q7NzmKXGRLPRv6mt0LG84?=
 =?us-ascii?Q?H4wtwB/AcqUNXtXA/6Dr/roDDNlvZOM6gcFtjdSbieYo1VSCqoS5oPvAaOhb?=
 =?us-ascii?Q?7Rp+H0fLS7TpP4J9TlBbPsRtNCWBEZ19/T4i7+DZ+fA9Ues785IJh1mXmmFp?=
 =?us-ascii?Q?wU7EVTHPa14zt2KrX/ee/hIRHuYnoKTbgT+x9OH5eieSIKhydkjqXxpdQCyp?=
 =?us-ascii?Q?44QmSxk0Qy0ynywhdGNtakuHzneAO768LLSU9Vp8MXOuDWgxa5GfDrWhzsvP?=
 =?us-ascii?Q?iQ2/JZuCcwQ+r0Kx4CUPR9KV73ZldazCowg9cl+9oA0sNEZ2M6q1T+LR8Ghv?=
 =?us-ascii?Q?DHG4ljg5liy4IetOuvJ8IdEoG1WWmiaGdCucqcBfnXZQIhBMgqUCxmQX3/sa?=
 =?us-ascii?Q?vUbZgFPsZFk2hlXgWBJBfCBjJQmRG1XQ1hF9+k2sZ8KhQiHjR4XNkbNr79zs?=
 =?us-ascii?Q?qY+Hm2bmWmyt5LA+8YMkxpYzczQo46pBrSXl5froBKGVpqHeH89D3g0hJ3zn?=
 =?us-ascii?Q?u21rvgqYmAY1AoKrcF8p0lYvE12GGr8kqSS2ZVQm5T17g6bOhABd3RBLjEyL?=
 =?us-ascii?Q?13G27QYraRLDU3Y3O2pZR/yfDPId1nDkI0aGR5qtxtQI9a/dGitgzUmYZYCP?=
 =?us-ascii?Q?Y7FRVwpV4jrVGJsvbDUNYAtR1vv/f0Ww7dVnJj22rUYdKudVTX2nli5qG0ME?=
 =?us-ascii?Q?zLPXrClduCDL4CWhTN60WxiWUo7XgCbR2yKQT4/5YM7uKC3/qFp+zO2MQOQe?=
 =?us-ascii?Q?RZltS0sqBqW5cpzmQG8YC2yHrZ5I3aAQXjSqhQTl3N3LdwlzL8E3+BwQrRHY?=
 =?us-ascii?Q?m6EJh1y176BDcllSaHQx2ZGutcb1cVpzeSFvnKqO/biRL8s/Umr2W8pO4klQ?=
 =?us-ascii?Q?SnL9Qm7drHU8iw02YxKnHV5dMSnDp4LDJc6HtEJa3JBer+/TyryIa6Wbjm8G?=
 =?us-ascii?Q?eDLRocqrNR1aPmmBepOfr2uUjZRXPXINdJvRqd6elM3No39Tfvff4kr5Uk5Y?=
 =?us-ascii?Q?gEhLgFAF7jWgmp8Rvy1ucOrSbmNAMMRMjlyW7SAfsRFWkovHbAYkHnttTGNy?=
 =?us-ascii?Q?TszpCGAI8lzbrd+C6cwheEDqXEZO0JldoK8uKgzCm/Z1wCB+2UFkIUMQrV7p?=
 =?us-ascii?Q?7UDkdYCEyyywV4DmrMuy5UABDjR2W9ao4RUsP1LcG/6Flsf/9wxAZ2LG2LDW?=
 =?us-ascii?Q?y4NTF0Shv6vDcqwJneZBTStS2UQ+5tp2LCV2uhk0b65GP8Kbo5qW3bdUlEzk?=
 =?us-ascii?Q?u5rC5bNrLC6LxZuKA+YnbqUkvKig9flV61CGWEVydj7DgmF1fqIJUaEjS6oZ?=
 =?us-ascii?Q?E5+woXEaeOJlx7C8hZrpK90w8o7ZVq2m1s4MCVtKZIXQjt5L8RTLH4Xnwcxy?=
 =?us-ascii?Q?mTqeQPAWaHvNOUmG5b55haDSpXg2Yt2+dwDa?=
X-Forefront-Antispam-Report: CIP:139.15.153.205; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:41:28.0187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c222649-e128-40e6-9938-08ddf465f422
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.205];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3349
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

From: Ricardo Simoes <ricardo.simoes@pt.bosch.com>

Since commit 5cf6a06a it is possible to have both text-based and
old-style C environment files. But so far the environment documentation
has not reflected this change. This commit fixes that.

Signed-off-by: Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 doc/usage/environment.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 77197d79380..3764f65c221 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -99,9 +99,6 @@ For this particular issue you can use ``DEFAULT_DEVICE_TREE`` instead::
 
 There is no general way to remove quotes.
 
-If CONFIG_ENV_SOURCE_FILE is empty and the default filename is not present, then
-the old-style C environment is used instead. See below.
-
 Old-style C environment
 -----------------------
 
@@ -114,6 +111,9 @@ Board maintainers are encouraged to migrate to the text-based environment as it
 is easier to maintain. The distro-board script still requires the old-style
 environments, so use :doc:`/develop/bootstd/index` instead.
 
+If both the text-based environment file and the old-style C environment are
+defined, the variables from the old-style C environment will override those set
+in the text-based environment file.
 
 List of environment variables
 -----------------------------
-- 
2.34.1

