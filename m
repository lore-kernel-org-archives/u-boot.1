Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26C4D37E40
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49804830CA;
	Wed, 14 Jan 2026 16:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2+E1DCpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E523A83655; Wed, 14 Jan 2026 16:16:02 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEFBF8063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i26OWhjZGCTU9pQ04I25MQcpmpR8IPmFwHIJHQsuSxmiBUqjsxi6lq/QNTSxtE7ADlpryU88eXYPwp1dpWfOEitDwHsi4cMoW79IAZ6i0KThvVZyYtuKyEG16Xo6jzPZz3/zvfW70wdEHwQq7cTFdLbR8HDSWaYpXhDzAYm6QB20Y4QSN8tdbkZPngt7ttjrNvRxK22C4VNh18FqriBe9psm9llTy8o5C7sasyqq0qWyDi7K7Gg3d5/F+l/1PR3vJElM3ticghADeYy7E+OeCaOFdT/VAW0Rf46x7+Ga6cCtJ/wjKuAdmcDGaZ8NPppW2ipYzDi+2vGZY6OTiP6HSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHkEHQsf52nFgWkD8N3YFTdK8ZHnyaFM/Imv5utFwoM=;
 b=pqfA8ZeC91k78DGHy6P47kd2x1oeSNz74VQjmAVHSw20sfevsJ5H5MXfA5+iVSHluZnNndZULaFWyMzKcRYpTcxGYOTUm7PSxgk/hi5v2P9pxhUE53fSNbZV1evXKvHFlYlopSZGAOsLCy0tnfIqw1WrDxOH4vBfh+FHPteKq57RbMTORj7YKdnA8enhIgypFP4+FhBq19IV6F7iQt0NWTt5kEnlqsAAg2qItWkDX4E/pzsIXfjETmarTAcLQHTD2vm+fbX7/YRLonnHJ1vbkCdqV/p3wM3dhgnYhilBlKvewGdhedFbUpbuNL5EWAEsiwcZf08devvHaGn1m1uPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHkEHQsf52nFgWkD8N3YFTdK8ZHnyaFM/Imv5utFwoM=;
 b=2+E1DCpETCL8QwDDZf0qFxfryulQqaRHAIjsNdaSQNH1uDDt5X2ujIfIUwLa9rR7M3oT/6qdJHtaid6xjmirSVwOl6V6liylMUFpvM8W7hVXaVpsLLPYbk02/DIIj4dqkE19RVlXdQexBdFivruIOWdda0XcaoB8bnB0E8G9V+g=
Received: from CH0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:610:75::27)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 15:15:56 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::2a) by CH0PR04CA0112.outlook.office365.com
 (2603:10b6:610:75::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 15:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 15:15:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 09:15:49 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 09:15:49 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Shantur Rathore <i@shantur.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v4 2/3] efi_var: Unify read/write access helper function
Date: Wed, 14 Jan 2026 16:15:34 +0100
Message-ID: <ebfe0557d1a2d78b8a2264b431fb2b84dc3c03d0.1768403729.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768403729.git.michal.simek@amd.com>
References: <cover.1768403729.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3531; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=R7B7KHuvTU8FDhYbLdcr6Kbv1ArRCYd7gfB2XzcVz2Q=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSmbxaTDN+5YJF+lEma8rkugXApg2k36habnbB9sPPT+
 W8Wv+QzO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAi98MZ/qctn3bQffGCR1mO
 Sg7Sr70CMjhuBnZJWUxabC+5WOH81fcM/2zmNpwLLevRsGn4LezfblUvp7b9leWVXduqdlz8fNH
 fggUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bebd1b5-1690-4ccf-1a30-08de537fd115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H55BdrFqp6/l8lTv8ZzJDCweOyLlUkz79R91B12dJJTwubjbutlLbL6D7PDX?=
 =?us-ascii?Q?C0q7DL/UFioYRo7QRTxrflA9vDfRhdVB30M9j3MbLk2dpK2CRF9grsfjcLmC?=
 =?us-ascii?Q?ao8/AzRtllR7zGtpop5iutaiVE7FYZcjkW1ZOPKYqm7bv0hrjdki7m8XcJ8w?=
 =?us-ascii?Q?XBmSW0zJiR+Ct7ZAitBukw/iU+odwpnHngIzzxZpC5JG/uyOuJK6ZQKgRydN?=
 =?us-ascii?Q?rmxwvkBh76bNPZf5bc2WJ5d2AAfzSkP6uTBvTpgMc0hpj8efHdXmx3dkXv0l?=
 =?us-ascii?Q?QhAAOk6EKSl8gdnbOgALY/U+bHJAhO1SuJDfGJyxp9lLxx0apHB2APnXVVjP?=
 =?us-ascii?Q?lq8ipZK+0aowVJdGfO5Yljk5fFqi9/5lMP7e4rrQB0nxQNNuYzbyOmYd5+AK?=
 =?us-ascii?Q?82ASw/8l4SuEScxGMy7lBJt4X57ySTYKJu1IOabpw+IEsbxPEsx+wWf2nuO4?=
 =?us-ascii?Q?uXtXbBRRny8ntJu9BdyzXNrlONBejYMhDGOtnrtpyyMEoivjFAYRXG3gXuNK?=
 =?us-ascii?Q?gtZX+IZcrFsIBGMV24EtgeqGzGG5XpO/hz8uLRi+vFG3514ol6enCCvSqHmB?=
 =?us-ascii?Q?P04qvBnHLMOPPXxAow4d5a+iCreIXB9RU+i5Q/GxkCePaz2D2M/WfaXuo1Tg?=
 =?us-ascii?Q?+PVRLFJy+t6T9kkxKNgWNqSwGelv+83BQeXOnPDZ94uL7yIOzlDJJd0Mdnoz?=
 =?us-ascii?Q?H1n16+nCf/FykqeGzMwUAHrpNrrbSP6KLc1C6Ssd1Zuc/uWcbmlOHrQrYqIB?=
 =?us-ascii?Q?9I/tkfstAD4srxKTJmaVvITXHl1jaX/LQDzW+hzS2zrfmlPgYf2Q/bWEgDrR?=
 =?us-ascii?Q?Tg0pdb59H37qW2DFRldVq1GdMqf5oifOJxv003T5OIsSMmPsgJoJIwhtfQci?=
 =?us-ascii?Q?NtWBwM+izCUJO1NEYfuUJaWYSDxLqwAJ09cHr9LtdtnATD6sSrFUfTrlvMVN?=
 =?us-ascii?Q?Qpnj57U4pcHv6yhj+zF7m9IZlAT1lcJThQQrMyhM/K3Zy+zPVj46MSxSSONe?=
 =?us-ascii?Q?Fu0sFCtcycJM3SW8OwTdWPs2lO/L1MioRv3RzirfOk7E8oE0k0YQqbh9WKkh?=
 =?us-ascii?Q?JwROAppnyv/g88u9ikwvX0xuWXHak8GzumC9/cU6rsDfI6R36aEEO/vM574Q?=
 =?us-ascii?Q?9W7JaDmqNAnwwd3JK1xszHFVYOBtOxLJ9D5pdIyGL7nR3tkXQu8KkclthD7s?=
 =?us-ascii?Q?m2dtFjh5LAA63V2BoCoNfvYWhhCo6A4t3xqKF58WtWJTgpPXnY5j590nxSar?=
 =?us-ascii?Q?O2VVG09/zj8Gr++FWAPhxpkqwIXGSlUwaF2Hm6lFiEkaVwnNdRhOIxSdZvVI?=
 =?us-ascii?Q?t2TX0B9+UNujvsyTcSbxW09lf6PFg5w9DfjS59mo5JG0I7vGsqugWsLgHpjA?=
 =?us-ascii?Q?6GpCJxKy3WzQTB1ZALKFq520yWMOF8l0fiAwBgCS/Soq9fEnquBBzEOz6/0i?=
 =?us-ascii?Q?MKo1N6lus/a87+rdv662J7zldSpj5Am4gQOl5XDGEdKrLZkR1v3BgaMsaOHk?=
 =?us-ascii?Q?j0hFaxfQEC5x1Dgt4+96uWqzAUabJx//ufOTsmt/ovHZMNLJ/Dk/QUnBzTEn?=
 =?us-ascii?Q?jW6vYBUO5V7Fj9RW8j5D5tXBHU21BgBv6v2I4B9ugfnF6fdqzcpjfhmzTYUj?=
 =?us-ascii?Q?QCv4PLX3/Gx//jd5/noMbUkYmjoORNdorBcUs7eRbiP0wJkxgBEDTwDTuJwS?=
 =?us-ascii?Q?G14YQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:15:56.6361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bebd1b5-1690-4ccf-1a30-08de537fd115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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
---

Changes in v4:
- New patch based on review comments from v3

 include/efi_variable.h        | 13 ++++---------
 lib/efi_loader/efi_var_file.c |  8 ++++----
 lib/efi_loader/efi_variable.c |  4 ++--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index ee68fa4a885f..ae542c597129 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -137,13 +137,11 @@ struct efi_var_file {
 };
 
 /**
- * efi_var_to_file() - save non-volatile variables as file
- *
- * File ubootefi.var is created on the EFI system partion.
+ * efi_var_write() - save non-volatile variables
  *
  * Return:	status code
  */
-efi_status_t efi_var_to_file(void);
+efi_status_t efi_var_write(void);
 
 /**
  * efi_var_collect() - collect variables in buffer
@@ -178,17 +176,14 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
 
 /**
- * efi_var_from_file() - read variables from file
- *
- * File ubootefi.var is read from the EFI system partitions and the variables
- * stored in the file are created.
+ * efi_var_read() - read variables
  *
  * In case the file does not exist yet or a variable cannot be set EFI_SUCCESS
  * is returned.
  *
  * Return:	status code
  */
-efi_status_t efi_var_from_file(void);
+efi_status_t efi_var_read(void);
 
 /**
  * efi_var_mem_init() - set-up variable list
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index d32edaac277d..01ac7cc20e1f 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -43,13 +43,13 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
 }
 
 /**
- * efi_var_to_file() - save non-volatile variables as file
+ * efi_var_write() - save non-volatile variables as file
  *
  * File ubootefi.var is created on the EFI system partion.
  *
  * Return:	status code
  */
-efi_status_t efi_var_to_file(void)
+efi_status_t efi_var_write(void)
 {
 	efi_status_t ret;
 	struct efi_var_file *buf;
@@ -85,7 +85,7 @@ out:
 }
 
 /**
- * efi_var_from_file() - read variables from file
+ * efi_var_read() - read variables from file
  *
  * File ubootefi.var is read from the EFI system partitions and the variables
  * stored in the file are created.
@@ -98,7 +98,7 @@ out:
  *
  * Return:	status code
  */
-efi_status_t efi_var_from_file(void)
+efi_status_t efi_var_read(void)
 {
 	struct efi_var_file *buf;
 	loff_t len;
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 9394ecf6994c..be670a8e7c25 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -402,7 +402,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	 */
 	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
 #if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
-		efi_var_to_file();
+		efi_var_write();
 #else
 		return EFI_NOT_READY;
 #endif
@@ -600,7 +600,7 @@ efi_status_t efi_init_variables(void)
 		return ret;
 
 #if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
-	ret = efi_var_from_file();
+	ret = efi_var_read();
 	if (ret != EFI_SUCCESS)
 		return ret;
 #endif
-- 
2.43.0

