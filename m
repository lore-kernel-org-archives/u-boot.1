Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19630EA3F27
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE95483D2E;
	Wed, 11 Feb 2026 16:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CZkAMetI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A134A83D5D; Wed, 11 Feb 2026 16:56:52 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DEB483B30
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuagSQW8XqXztFCEWeK6ZfYKBsGBYc7KFbExMyiSeI5X0YuRrxU//FrfP9FRqyxOoZDUKfG2EckXp79qdB4ShYsz/6pW3tVzZ8jNvFG1WFy5FmHidOvIcTglgjS9692y284I+RsJ4uw2D2u43UGjBKnucpzHmVvHGHN107fc2hovZykdQeqBx+zcS6c5Y3Dit9CqVb189/qJvZZxU3SyUPXm4S8A1D6rNJlaHqorTwB7R6IJAIG6n2oYZjPGzuE442Fn2c1HI7J+m/s+pilyFOFbCKlo3AsqSgoYhiBdJ1hqcFkF3Cr7PS53AwMyvPqYc+Z6/lm1LB4u1ixsuXdVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RzYdGZXu0DIsSquOuZFztYaDdmfZAqbMIV70pLwblE=;
 b=sC+AJ7uLzTz5PgIvg998ibWHnSzIn6Hqys9aCK58+/8XBrfBwN6p9fqhjDbSn96p6A54bWTm1mJKpGeeSZ5dcFuTlV14XJQtcvX5Y0fujk5ZBCmX/Wimgyf1bpJ9oXmFdiNMvVptBB8rm+KZ/vzQbrHoWYBu+sz7hbxX+FbLxNFwX6UVH7UvIW7FX9cy+7+QsabRfle7CH4+y21xu6NKnNP20XCpawiOgnhjQZYHBR9wWqEW8ZPIGa2azeno2ye6gSBvvRQ1iIxiaa7G3+zPidsnFxfsstJeOZT7FS1On298Dv/KVDWOV0V6JYYg+9NaRjcqXEdAvlLfv/bEtRcfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RzYdGZXu0DIsSquOuZFztYaDdmfZAqbMIV70pLwblE=;
 b=CZkAMetIraGsKFJN4DyxSkZXQAnB8lqYxiVlH3r3Q4dFGEuIUTNR690ei/j2+FLDes4S2Ov/wzOjLpPxK/5rH+2fXr8SvAXsBcaMfj6v7fKIoqaBzYjTBAVNdr9mfoTj3fmiDBJVi25PlAs94OlZQ3F4Uj22sLncX0ZoO6H8Kx0=
Received: from SN7PR04CA0207.namprd04.prod.outlook.com (2603:10b6:806:126::32)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Wed, 11 Feb
 2026 15:56:43 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::c4) by SN7PR04CA0207.outlook.office365.com
 (2603:10b6:806:126::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 15:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 15:56:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 09:56:42 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 07:56:41 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 09:56:41 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Pranav
 Tilak <pranav.vinaytilak@amd.com>, Shantur Rathore <i@shantur.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v8 2/4] efi_var: Unify read/write access helper function
Date: Wed, 11 Feb 2026 16:56:21 +0100
Message-ID: <327a701110864b92e5ce9c68197ea3428ac20b61.1770825377.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770825377.git.michal.simek@amd.com>
References: <cover.1770825377.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3899; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=oFMcFeZwyzH/h4t5EYSFHEjH0gDwtiA2b/oy+GnMIX8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT2LFv3Uali6eQ9TucrGg0nvFVyCHOJmRhf//W/TNzi3
 doVb2wYO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiog0M/71+snKtbWA2mSzj
 FfzH9dMVs51SJXvvW/rsf7JEmeGR20RGhv2ns1KFHKsvPdNUrrjHcOrFxtruNbvKfTwXBaoz3dW
 9wg4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 504a5079-af83-4c3b-368b-08de698626da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qxR+2F8HyA6PAkY5DBOOMrF97ZzfJjyIzwrA1O/lDvA8hGaqxC3JG+Icd2AY?=
 =?us-ascii?Q?McVbUNKczIcd/F3NbymAdsfQPGWRtghKMoLuKZ/MQ+M0EUromYScJiv9PERF?=
 =?us-ascii?Q?ixCmy/GfcRULNewoiMR2RatSrTuQA9OT+kkTqmzLU+EaVD27AN1Rhw+nfufn?=
 =?us-ascii?Q?bPNS9pP9xBpF4VYgOgapN16Z8q0tiU1TFrHlllbNw/bPrg+z5b8VaIzTC2Kp?=
 =?us-ascii?Q?HXima5quFedR//T76FLdNT/sHz53835cIudt0dzV5URneb0tCS+TWXE0rpSy?=
 =?us-ascii?Q?8El6cviFkP16to5mwqGKT2yqx44xoXp7Eg51p9M6rZEIsDp+Ds1k+o4SImKc?=
 =?us-ascii?Q?yul1nUVOnIKUyFr2kjB/Mzwy4k3SrIAiF2xjn8PLduccojMBjIOmAWfAnlFg?=
 =?us-ascii?Q?eklvKBARVT0qQFhqzHjl/Z+eQ42QGdTYlKJg6X/wNduAJOh8Gcawi6nyjJdu?=
 =?us-ascii?Q?03KFNGtoiOFpV9aSREWJHcTlmWhRgdEZnlQ0OniJ55F92OcZrSAzuNVfGSQt?=
 =?us-ascii?Q?ccn+j/hDM1OhOcWMd+74cg65v8c0ZD68XJDegZOS8cactV9OiD2xcR1Iq4NB?=
 =?us-ascii?Q?lulpqt8OVy9+a1jNPvF3vJaQ0bzNSz/m82Jdrz9f4tBer38XxlORBDaWGyzc?=
 =?us-ascii?Q?HkxWhXVKinVxsjclVu1fL62BIe0xETWfo997iEflfTMUdDtdj/E1ARmdaYn6?=
 =?us-ascii?Q?9lIjS8CjXoAcYsG06a0yeIWWs8hYsHgj+Bl2smOFP9gfuh2HrCjA3Gxpfqf9?=
 =?us-ascii?Q?bF+cvdeNZoWYyaYQj/zgaFwxnpD658wxStccT2OrP6b6PqiF1ecTAolqOltQ?=
 =?us-ascii?Q?8VVAkgO9iZbJe4jfXDagSo5BCS5tvVrJkkO4kUrxhilsIiG7fGAffVVI/DVM?=
 =?us-ascii?Q?5kB2fy+JtK3iaf0fL5iGkMvPjvy/ihYp9HQDWFLncR2m1MkHbhRVgI5TCN5c?=
 =?us-ascii?Q?JXNNrCsBgA04JHUFE6nHykMkEY9cjDe3Mj0IUUeUNvgPT8WcvAbmhrlvDbGz?=
 =?us-ascii?Q?VM1eVUg40ILlVj4fzNbe3Y4Ca4cCs9aeOiLx2a1HQCaFo7OHJCrYM1n41rWw?=
 =?us-ascii?Q?Z5aJAleH1uC1WGRBDV3a25HU9Po0IiMHBlwqcoqu8yBVRBjs6DDZeDb3NKJG?=
 =?us-ascii?Q?bHrKA4h9OxX7J7yFbWdqv45DFuJtpkIs/a9gSBVasSdZXOwWUs/so6+pXgBz?=
 =?us-ascii?Q?VNpWL4MX4ean5c/Jw6Bhq+fuy6HG5jFV4vgZzNDk4s13qLKCdDkgZYlWQBDx?=
 =?us-ascii?Q?qZhr3goDYyghWky4b/njPY9no3cmMR3rxQEgZADJPvU6NHtQvvY0Wd8okUJB?=
 =?us-ascii?Q?15Dh74FZ7d7dS11YCxcNSySbbUsoUxmM+pb8n3jeXvylhqU4nPIDnICeRPzA?=
 =?us-ascii?Q?5n92sK34KgRpisie3Sl3B0ZXbsF4+9EHklzrvWdsCO5NcD1g1JAwCXSnfouU?=
 =?us-ascii?Q?8CpaNFNyb8tK4nRtXKz+JzKLKhcTav0Xfi2Os1Bh/THLL4EAAE5KSH7ksTWg?=
 =?us-ascii?Q?xS/zv+I6JoFXj1GLe3SN0aXo3EZxFqGRM0F/F0umYxzx8cXvJ/V8LEjZoV2j?=
 =?us-ascii?Q?dzz2VsRZb0sM8VwlqyUGY/xxlOqqHpxJieafzt8v6JunDx9vw3JlP7qFNgvk?=
 =?us-ascii?Q?7syJbOmQhMaycyFg9a2TVRxiXCLI2n5g8qYUJNg3u6jf4CPHqsz5bHmxkT55?=
 =?us-ascii?Q?HZiepQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nEHqwhbBmZqUTH3SNeUoOD+2//lFjcc79BUwQLqvkMRK1/4itDS4sVxHKL99+KHBOV9UyPmL/scyfhNCctlgSWUG30YVMwm2BxcZkzfhqMoGWMBlORloN9YzsNwcAxK7z7TZiOWvYDJQRfy0sOqjSb+ZVJZYU99Zmt+IIoP2Pjt9LOubxE+xG8IE0lPmLvmkV2144N+lOiTbRMG6VtQ1dsJwvfLy6a2ZYQwGuYJLrbbjod1aa+Gg4ONsw9N3TMML7uEN02XyHcnhkchwPaw0FABw5o7jJacSaoF6prmCNLqVv3M+AtrIn/PjfecXffPBCAKGaZyf0S7+s0CYV+gsunwQ5j8OYHPvz5bCQhE+ep4VU0kXjLzP18UAH4hQ6dknsF8RQxa9h/VpAaBEHSyEHCj1hSvWgSmz7R1G7ZqVBDjRnc7HQij2dn3HF5JoXH+g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:56:43.0950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504a5079-af83-4c3b-368b-08de698626da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765
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

efi_var_to/from_file() suggest method where variables are placed. But there
is no reason for it and generic name can be used to wire also different
locations for variables.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC

---

(no changes since v7)

Changes in v7:
- sed -i 's/efi_var_from/efi_var_from_storage/g'

Changes in v6:
- sed -i 's/efi_var_read/efi_var_from/g'
- sed -i 's/efi_var_write/efi_var_to_storage/g'

Changes in v4:
- New patch based on review comments from v3

 include/efi_variable.h        | 13 ++++---------
 lib/efi_loader/efi_var_file.c |  8 ++++----
 lib/efi_loader/efi_variable.c |  4 ++--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index ee68fa4a885f..fc1184e5ca1a 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -137,13 +137,11 @@ struct efi_var_file {
 };
 
 /**
- * efi_var_to_file() - save non-volatile variables as file
- *
- * File ubootefi.var is created on the EFI system partion.
+ * efi_var_to_storage() - save non-volatile variables
  *
  * Return:	status code
  */
-efi_status_t efi_var_to_file(void);
+efi_status_t efi_var_to_storage(void);
 
 /**
  * efi_var_collect() - collect variables in buffer
@@ -178,17 +176,14 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
 
 /**
- * efi_var_from_file() - read variables from file
- *
- * File ubootefi.var is read from the EFI system partitions and the variables
- * stored in the file are created.
+ * efi_var_from_storage() - read variables
  *
  * In case the file does not exist yet or a variable cannot be set EFI_SUCCESS
  * is returned.
  *
  * Return:	status code
  */
-efi_status_t efi_var_from_file(void);
+efi_status_t efi_var_from_storage(void);
 
 /**
  * efi_var_mem_init() - set-up variable list
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 4061a463b580..9cda38f319ee 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -43,13 +43,13 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
 }
 
 /**
- * efi_var_to_file() - save non-volatile variables as file
+ * efi_var_to_storage() - save non-volatile variables as file
  *
  * File ubootefi.var is created on the EFI system partion.
  *
  * Return:	status code
  */
-efi_status_t efi_var_to_file(void)
+efi_status_t efi_var_to_storage(void)
 {
 	efi_status_t ret;
 	struct efi_var_file *buf;
@@ -85,7 +85,7 @@ out:
 }
 
 /**
- * efi_var_from_file() - read variables from file
+ * efi_var_from_storage() - read variables from file
  *
  * File ubootefi.var is read from the EFI system partitions and the variables
  * stored in the file are created.
@@ -98,7 +98,7 @@ out:
  *
  * Return:	status code
  */
-efi_status_t efi_var_from_file(void)
+efi_status_t efi_var_from_storage(void)
 {
 	struct efi_var_file *buf;
 	loff_t len;
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 6e45134c61bf..8512bc20f11e 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -404,7 +404,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
 			return EFI_SUCCESS;
 
-		efi_var_to_file();
+		efi_var_to_storage();
 	}
 
 	return EFI_SUCCESS;
@@ -599,7 +599,7 @@ efi_status_t efi_init_variables(void)
 		return ret;
 
 	if (!IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE)) {
-		ret = efi_var_from_file();
+		ret = efi_var_from_storage();
 		if (ret != EFI_SUCCESS)
 			return ret;
 	}
-- 
2.43.0

