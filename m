Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584BAE8305D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0D284008;
	Tue,  3 Feb 2026 08:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AI4EEzGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A65BB84016; Tue,  3 Feb 2026 08:58:18 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DBC683FF9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVn6PZ8Sy0jSA9lVBHIArZmxoVXofzZVSkh7YUUwk5vc8IVbyX7rlFGe//5xrYEMDE2WQJy6exj7LudXZuB2skdrGVQBB1l8JBjQ5da4w1BvXWOstZUrP8q+DEh30UsrRj3Tw2oS6Z8ZL6+s9eQrx/rZ0tISFyCg4ftRUApJdokjtVVi8POBPpMz82kzRQNbnhS5a8aYFuom0pCI+4Ol9mE/GQnSKE94TRglZKoP7kcJeOh9h08RSqx5jZvECBnFB4NyMDms/zTfruQl3ZdHq0V/BB1AodEG2sOm7kbcZw8AEdT+b2bibP0ZWhYO0GFMB0Kph6MgFDORScpwp7k+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUNIJjqFu0yKwr5CPm6UYhUOvn3C89ct+NPY5UuQWyo=;
 b=dLr6ozKRDW/11Rpz1TsWPrDPhOTdctKtdMh9e6DnH8u/YCUynk61BXWNeosqduBkf69Sc4VZDRCTigCJiFhu4qy+7WJdg0d5E9j88FUldRzzf5mJ6noJgHt9Jb/pGNHSRCpgCDf2qRNg5iQLDR1yx0g1gAW8b50IA+17r6Wb+p60qT42dp/BrvODTG50dc93s9i2CWP3B0RPgWDt2ld9tzGlkz0y/ikY/8XPqw7PloDbup+7f6dM+/wQXFbmt65e0gfEyKlwPdGvs1evuGASatmLaK5jj0mvFnXEwbJjBWwN9Nik1iUI7WOLoT2pKPbfIRVyZQm24YKWWzfarVqkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUNIJjqFu0yKwr5CPm6UYhUOvn3C89ct+NPY5UuQWyo=;
 b=AI4EEzGwtUUGZA0uFtG5SCOPmKqqSMw7WOJdRG5hwULC/CUS+s7TN66cxu0m9SydVga3SIRI9aGPdF1p9m6qxluzWwPsz/4tNX4zmYivHf2dWho1s3V1bkf7iXQiVFjl0zk/JWJKxgWUK65oLylLOwfR0tiHIMcxYDTNCIb/Y3Q=
Received: from DS7P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::19) by
 SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 07:58:12 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::1b) by DS7P220CA0027.outlook.office365.com
 (2603:10b6:8:223::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 07:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:58:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:58:10 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 01:58:10 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v6 2/3] efi_var: Unify read/write access helper function
Date: Tue, 3 Feb 2026 08:57:54 +0100
Message-ID: <620c169fb271be3ca6de3e8aea498fba7aa36d99.1770105470.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770105470.git.michal.simek@amd.com>
References: <cover.1770105470.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=kqc+D8VsNtOWf+zUd5LAz6KbJpJtkqZA4WdY1CUe0Bc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2rmr+8t0o4s60ovXhYRWzyxYeeXlvRYvZtmvPFki12
 HEd2Od5t6OUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAm4s7O8Ifnyccbi/5LSt3i
 T33vKRfd+DdbufGwywdGzf6Y9xt7TR0YGf55Tjm+49+H789qmNrK9iT/1f25+OPELW4y0+4XKx+
 QXMAHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: ad836241-226c-47a0-c2fa-08de62f9fa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BdtODMPlyn5aZKdmnGiuiM75VFxsM2Y9wMLKTww+3oqX+JWXm6aRm5HIkujU?=
 =?us-ascii?Q?o3ZbC8vnrcnSq/mvXCrWUF5u4yUVaTwKvOsPuHczf4anGgXLFV7PEhzbHj0T?=
 =?us-ascii?Q?d35jfU48ZHUsLDpcQIPvP1Gi8C5MhxG47SsMiiqEIXovVo0WSOW7T5c7qnzS?=
 =?us-ascii?Q?7sWqU2X4JnpjGnYbnX8aptJM1tCbS3tswa77VbFhKAyxGCqfwFQWMiNRQxC9?=
 =?us-ascii?Q?ADwZhzQVbzx1tiukAfWm4BjlM5qyqAzr8xGMyMm1oKVRBpo12YGuMiL52OxJ?=
 =?us-ascii?Q?fojQqnInMGfFZm5LDjR1seDAnB5uOkymYHW59r0sLv6AO5FktAb1q54vUyQH?=
 =?us-ascii?Q?5N5cNycPlRvZL4pkR19L72gndrig1DEln9npxHXjm838MtQCt3wOxQdvHrkn?=
 =?us-ascii?Q?NPXp3TCmRBv6CdXO1RXdXAnOpmxPbbT5QnKYMZxQEl7MS6pv2Cjbg8zw0Gs2?=
 =?us-ascii?Q?NlyDGC5DlYFzycbMIUCTz4g3mbhc5Ki2natUFPA8an12nsmrIMzrBBPIO6ay?=
 =?us-ascii?Q?ytHnfNOMuIMG5G8YL9XDO/0tXRzgeIYuAjnTIaG2rnDG2x1pKJq50TjZpVMG?=
 =?us-ascii?Q?f4qAGBoV0FhG2sXc2jN4WgXqY57HL5vicbN6edqMw3mAT+yeUkhjLF74ePb2?=
 =?us-ascii?Q?s6cHKUzLIyGOnUBnz0SX5Sh4wtpgG2+Pwd1/vD98mS/YETl9FPJuE8DrVyuW?=
 =?us-ascii?Q?11oe2GwrmlA5UTM1hCOU/sZcHsBdnYIfIVDIgRib9itPuYm/RzxS3iZghonM?=
 =?us-ascii?Q?K208xk2/2kUkBE8UF1/oFV1yX8e6r177nKw9MUtvUuAum/Y2rTTSl10G1tlf?=
 =?us-ascii?Q?bBESvoPP5+YVCIRpAVm58BhvgE4vugQWHHFmd6D9wo308jtE774Nao6iiArk?=
 =?us-ascii?Q?sbSdZ2cegopQYWtBnrtqcrsCb8aprx++7Je0mdkX0Fpx24yL3wHpk6JMcPNS?=
 =?us-ascii?Q?az/52bpOnWh+sxAmRgTkpDWKUFVve3568EZ7ZGdJFr76j5ocvmKaL1Y6tgIC?=
 =?us-ascii?Q?z9K+/GfOZMc88BefpNKgKymqMdBRRTAQ5xEkBmxqMCjCUHSkICc8PDHW+umY?=
 =?us-ascii?Q?7vChHWjork6X9XQDeKbErjPUvENW8VRJKChB0VLM+VUf+RfcNcsAxVkYcWCp?=
 =?us-ascii?Q?0oDqSjf7rrwxC1Mx0D7Zk6CznCdmP5Nj2QRJKUtEcKdqSkG4X9RJirKwO7k0?=
 =?us-ascii?Q?2Dp9Ps0LEqpgO03vTzOCIvKe/4q5+zeUI72Tt3YRg+kK5poT9LWBp6ZH3HOn?=
 =?us-ascii?Q?2PkmjdQGbdFeWwKQr3S5rzDzMEy01PuQ9mfLUTe6TtLoKO3+lyNREAz1jXEh?=
 =?us-ascii?Q?/UsYH9Y+cgwDVK+vK5NzyNfrY2OT0lDnF/9jb6w07jn0qNNEdkvEzWAntoL6?=
 =?us-ascii?Q?knXcbSNz3uBKqdt1tFe4v+BVL6sezVSqVuYDdNrObybNBxjoDpzbHwDWVtAH?=
 =?us-ascii?Q?/E/i2rsMSznNRRZ7x5cSB/vmWJ8EkyeBhXlVXONuZkywdHd3by4v2d2wfSve?=
 =?us-ascii?Q?YT1rO5L1Oejw5el7Xjc7rMnU5AbQEHRyfO55qWOit10qPIaJXdxNKm0cMiF1?=
 =?us-ascii?Q?1Lyc8OfEmrlTXDtYmX4haqAOgH7/27frGg1/T6EtfGwFfRcxjJboyKWy2+10?=
 =?us-ascii?Q?qUs2tSXWMxMzduPcHV0MlMkqWElwgsfOJLKJsIAH7J/7nJQObZ4YT5daaeY3?=
 =?us-ascii?Q?GI/zpA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uq5+wWAkmRVyk2JiOh9qzavs2v68mxYu01fB9Ldiw5ChOLeyycln0rzz072o94F6DQceIQdOEzPchOCpxUcxoVKbRT0scUtwNLy/h5CAZdQ4JAqoi6qd8TCI8b8lWC/r9F6Z/wO3qwDtr5P8bFcMwFn1q6RrZZMx8DeDolhVxYOzJzHNtvEjZovo80XcExVsDcpQgO+PibbfyW+F/tBBdKYMZUy8mQaq7FSDLGucCjOrrzEpyGyC+TXa21iP9IL2Zl0A1h5SbzCYBCMJrYh97V5MtQ+AQaUSI4o9zBI0wQKssdgLFrvKLVljo55E1lJxEEGQs4l5iGFqyNF+8kPTlJ25z6oGAfQ9C1M4ePVeeSR6t23V/s+WBEq06w8+/pfFdQNndikfpFCeWq7n2vBR+K4QpS7J++ibHovrNL/B9mzYTSb3hqADO+4FLoLD6Jlw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:58:11.9873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad836241-226c-47a0-c2fa-08de62f9fa67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
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
---

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
index ee68fa4a885f..2b06505b8654 100644
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
+ * efi_var_from() - read variables
  *
  * In case the file does not exist yet or a variable cannot be set EFI_SUCCESS
  * is returned.
  *
  * Return:	status code
  */
-efi_status_t efi_var_from_file(void);
+efi_status_t efi_var_from(void);
 
 /**
  * efi_var_mem_init() - set-up variable list
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index d32edaac277d..d012d6a18b02 100644
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
+ * efi_var_from() - read variables from file
  *
  * File ubootefi.var is read from the EFI system partitions and the variables
  * stored in the file are created.
@@ -98,7 +98,7 @@ out:
  *
  * Return:	status code
  */
-efi_status_t efi_var_from_file(void)
+efi_status_t efi_var_from(void)
 {
 	struct efi_var_file *buf;
 	loff_t len;
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 6e45134c61bf..42f3ba901556 100644
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
+		ret = efi_var_from();
 		if (ret != EFI_SUCCESS)
 			return ret;
 	}
-- 
2.43.0

