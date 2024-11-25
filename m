Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E911D58D78
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 18:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1A889A5E;
	Mon, 25 Nov 2024 19:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="m5Z+Qo0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBFC89A5E; Mon, 25 Nov 2024 19:17:07 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:da0a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7C489A5E
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 19:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4DFCkfB0xQ9TP5tFODUGVC43MhFgB6GB9BrZjaF3nBThdip1wOmVxISQOL4YePL4OrBUV19fBdKhEjiE054Xl9GRjSU1Rf/4DjT05mBbNNUPFo/V1Sp2/XU1cr96z3dSSrryf4QzIpd2q+IgeH9It0QNsUIcX6/nofjHileiMu63TG9rB5p3w8ULVYhpsFGSl543GQv+a/M14GbAiyPs3WaCby7I1oNzxd3qBuJ71Ft/7CUw121XWWGkt/xBqGBPq3wgC9qhFU2KZuoSY5TTRZO6kZ9SUEnZVWdXFixCWW/1garYPWO3RoYaYypcifd64w33b3ONwdXDPy73kpO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJ2V+YcUOa1FtkDvPomweoakyWiivRrX/sqgwAQXp+A=;
 b=smZAr4rMLGzKb8jfibzYjPTJwOIenQ5cqlZIvwQt+yoHk9yJtpBO2z/UecAf5fAu2B4jB+TzYI+KFGd2T/VD704uG5jK69ThYv8mptOY1+jM3Zh254EccVWNukexWbhv63sydeTm6scr0fAxb6aQaBKFjj+R6uLxFId461UNcmXmeA+baqe5+IlkDOOgqbtJbCcAfXyvUCFwSm2NkB54QrQJO5qgTqTNRaoxyzqMSwuipngjoITgL+Huu/upJyDVJyCnDoFzCdYr4sk9M32Bam24DerD6/0e1a7zE3ziApI577V6l/GNt3MOT/VoNIzt+m2CghKYwNd3TQtHWZvkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ2V+YcUOa1FtkDvPomweoakyWiivRrX/sqgwAQXp+A=;
 b=m5Z+Qo0vFpmL84OVkjma4lnVAiIKSSUFbXvnEcZL+vtHmY6Dm59qE7ZzA9Rnpuv2PxMJ1h86Wi5SvGjpG0xIDZ8OonjeEGLSDTGJrP2RPA8sAPlaQPRtZ6VUJKvv+V6rtf8YkzlCRo1U57FeHQvq7v3kJ44n9JrVAEc2MgrMM/+dXl+Th3J53G+S/FscprIkcZa9RPA5qRDNijU7WARXOHJi9J8k+t8I2ivg8v/3HGUdCcGdA1Tgg7MaRVP1auMv6AhnQQVwNR3w+p+/Kz3UF/ZT2ctOkyt4c06ltId86zU/h3hhyKsQHnF/KWUIs7kg8unr7ZofLDuPTbtNt8Ak6A==
Received: from PA7P264CA0383.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:399::19)
 by MR1P264MB2643.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 18:17:01 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399:cafe::2) by PA7P264CA0383.outlook.office365.com
 (2603:10a6:102:399::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 18:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 18:17:01 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 35D492027B;
 Mon, 25 Nov 2024 19:17:01 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/2] tools: u_boot_pylib: Allow to append input directories to
 indir
Date: Mon, 25 Nov 2024 19:16:53 +0100
Message-ID: <20241125181654.1182646-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
References: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|MR1P264MB2643:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1652363f-030a-405a-7388-08dd0d7d5ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|34020700016|376014|82310400026|12100799063;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E9LGrubly3n78Ac690bvflf3y/8hGV7P2WgAk4ubfj8001xmsGBBlNGDRv9e?=
 =?us-ascii?Q?yI1niY2K/fb+w3/c1OLjY01QrOLLg+kDNtvwW5/nowExdvetW83hIdQHm7sD?=
 =?us-ascii?Q?2y7Jg5lJn4PgLSy/UsAWeQnnZmWScUkvq+UxkIdK9kJxeW4xOphg55jmuo8l?=
 =?us-ascii?Q?tWUVJlKE4h1Xhnbt78gzSa21GKSEmJ8AtL9b0D7j7tRyWeMC6ge0lNwCJFBE?=
 =?us-ascii?Q?4UtL6CsORH2MYDSOOL40UDz8jlWF6kK1WWdG1uTbIsZ9yi0o8TZ35FahsimS?=
 =?us-ascii?Q?LLeyaWcTfr7ji5jHUUz/NdzAh7NoeRoRoDNqWd9wAiPPM9A6BcX1FlLRtX82?=
 =?us-ascii?Q?IjYBwnrtI3xUpNk5NTNJOXfe4BM2Uk6puPXYL8lRKhOLMfoBMjPzhj/UlL2U?=
 =?us-ascii?Q?4PPxYBnuNSVsl+W6JQMYv68a5PJUA8MR0p8swhwspxndgVBhlgGdzosr9euY?=
 =?us-ascii?Q?fYK0ET0DrX2q89PAh8VWbcP/DsAiXr3HPHE00ES9lMA55PrpFMibnpLm9Oqe?=
 =?us-ascii?Q?c+zd+CMG1CEiGLySjqE8xi7PA01TgFHV6hvwlbSly/1pXmgl3HGNDbVRw5Ob?=
 =?us-ascii?Q?Po05Kh3f78OtFl/2BxXLzddsTIVrcyIJZWB4QVOqfW36OtU/nLT4ku0srR30?=
 =?us-ascii?Q?u7lSUyOoiO8R5E4VgOk3wYVsp2fKPfdGRwb6i0KQwScjgNqMA8urszi2SC4t?=
 =?us-ascii?Q?JlWonlDZMvVwUfDxah5p/3xNsy0/6ArtKgXHQjnYuuM3KH8qBm/ik3NMqmPN?=
 =?us-ascii?Q?AOSawckZFacWRhpRHNG95GUZOR7DIJmpZjbF1zON/uXz1e1vuDCZVgy2zh6U?=
 =?us-ascii?Q?97RGvOExfLKFriNmxKkF4L6o1kxC8obn0N12GS13b/Oqyefku7DEP7dvfGFV?=
 =?us-ascii?Q?3vPmID6mURYvQmZofUHsRoszAYdTvi7Shnf1ro1C+O6WZNCG4EgMNpXtx9mZ?=
 =?us-ascii?Q?0hCJdYAtVeK4OvEhf12+iLHAzIzfy/3GNikKAIEv7dDfJsMDsp+U3r6okScE?=
 =?us-ascii?Q?pojG74ZC+5NfK+x1YcmydhLkC5Xn2KnpODkHXVrXDTGsQPRrepdNE5pQDw+G?=
 =?us-ascii?Q?FFEDZa2VKdzeUa4Kpj7iGQJysAPv2yscD8nPmnzG4W+8LsyDwMv2l4OO/NxW?=
 =?us-ascii?Q?MZvLlT82hbTKkhhA8CAhdioy1Tt9Q9Zwzp0ot6UhimvW/c58PBIbZUxDXsY7?=
 =?us-ascii?Q?j77blmi8swXEd4kIAklbOXjufT/6ScTcauP7UXErzSvturltv5eeSOW9LT7T?=
 =?us-ascii?Q?hQFHOsKtPJT9TJ82S6ZEOTpvS8SddHi6TC9INUc4RaOJMbk+bHdBIitbuPu1?=
 =?us-ascii?Q?BHgM4IGDQ3UxTXPtUm4bTWKHCRR7dv5SO0om4n9p/Umf4gRhrfR8JT8ps3jL?=
 =?us-ascii?Q?CTQjw3867yke7BPUHV7IT6/HlXBGVtJgSbRqro1T9n1m849jRX/dqFdj5xIz?=
 =?us-ascii?Q?Z0OWJqCEJldghtbvJ6/fO1x+Ln7cC32P?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(34020700016)(376014)(82310400026)(12100799063);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:17:01.5586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1652363f-030a-405a-7388-08dd0d7d5ba4
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2643
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

append_input_dirs() can be used to append a list of input directories to indir
global list.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/u_boot_pylib/tools.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/u_boot_pylib/tools.py b/tools/u_boot_pylib/tools.py
index 187725b501..0499a75526 100644
--- a/tools/u_boot_pylib/tools.py
+++ b/tools/u_boot_pylib/tools.py
@@ -123,6 +123,22 @@ def set_input_dirs(dirname):
     indir = dirname
     tout.debug("Using input directories %s" % indir)
 
+def append_input_dirs(dirname):
+    """Append a list of input directories to the current list of input
+    directories
+
+    Args:
+        dirname: a list of paths to input directories to use for obtaining
+                files needed by binman to place in the image.
+    """
+    global indir
+
+    for dir in dirname:
+        if dirname not in indir:
+            indir.append(dirname)
+
+    tout.debug("Updated input directories %s" % indir)
+
 def get_input_filename(fname, allow_missing=False):
     """Return a filename for use as input.
 
-- 
2.43.0

