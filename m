Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2B0E8305C
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3658783FFA;
	Tue,  3 Feb 2026 08:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBHsxI3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FED83FFA; Tue,  3 Feb 2026 08:58:37 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A8083FF9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=parcp3uSkhJCGYg2dBvWT6Pfup9gZ1mbNmcaD0WECRVPGCKs4Bm3Rj7nHR3agqoJD3k+HkeqdVQfxYIrprfTH/FITa0qAl2WBNOuF3L/GuRoiKL1husoFZUzr+WU8rnns/4zSDLkJJ6ApDHJAzbNK2B2GYXeWNpPpbtM6JiSc2gvovEPzEFgg4eq6he473CxKIXTTbL55DpmuxFuqX8xaIww2bRO7rwP+++ZOzD7dsU+wGtRJPd3IOX9obhavfW7r23M57C/gwrWjfMpZVXFgJFlxbjAHHssjOulcFFNWCGBIaoFcUtuRPj9LXeT66LQR71Dvt1BKpASzTvNErDNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPXlb/MGV9xcbwztEgPXiVCib7/ggsN5QuNOHka6M/Q=;
 b=c7I2qaC2IPzJNoHpbeKHlnSh4kT/Zt7V17NBHmcEBOjw/XZYKkPNWxPQ+tuD8y0OkCvnZwjh3zzwuw25Llpoe7RQNzRhYqPrzJH7s/wyi+C9iBR4HF3eqgXvyWno6NRxw9nqqzCXedxPWw1DzJDFQf8QT1FVNaaM5fxvvGByYy+4Gb8qsvVp0WvWkAz3nic6nf+mgVxyqaQ3tncjDoldG3FvJqgyVCLoGGXfAukUULdPKntz2Puq9lAdUyd4QqBxOnEqTK0imxFMMqB2pgQZPdIsZ8Ws4vKZmM3n5T5YZfNbnImQoD381f6owgnrBvDjX1CmvqB2AYLoxtbjKBpa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPXlb/MGV9xcbwztEgPXiVCib7/ggsN5QuNOHka6M/Q=;
 b=zBHsxI3C6YpS8oylorfOEqrCBG2OB50wBjDB6mrYrB9CvVlZMm3NiiyDSNgxTiYZ+JteOIeInTW891fObbSSDAGO5Qi966gHYvocJmlUlrgN/RM6Uih+3+buIv0ZXwzOC/FRVYatnFDL04zCs6JBK1nl5OlMYB6aBFRE06bxEHQ=
Received: from DM6PR02CA0142.namprd02.prod.outlook.com (2603:10b6:5:332::9) by
 PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 07:58:09 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::26) by DM6PR02CA0142.outlook.office365.com
 (2603:10b6:5:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 07:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:58:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:58:07 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 01:58:06 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Shantur Rathore <i@shantur.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v6 1/3] efi_var_file: refactor to move buffer functions
Date: Tue, 3 Feb 2026 08:57:53 +0100
Message-ID: <1f50d76c2370b9b032e73c35c05246cc70255b28.1770105470.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770105470.git.michal.simek@amd.com>
References: <cover.1770105470.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7760; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=EXFizwp1lokcFaR1YlhPZo8DXxYPf67b3fnnHJle93w=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2rmpaxRHVwa6s0LW7IoijJFrWelmK+aGfZgu/1tUIX
 rnTs9S/o4SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACbCn8TI0PJ7N+/DH6WRLaGV
 ynu2m89gfHY7+nByN8PJpPtP4mX3iDJ8d9YRnXKIdfbf3H2z5Dx2y9/vfyTyf/KPy+2LHXtnXkj
 lBgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 12259130-8853-4dad-a3a7-08de62f9f8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U/qdOjNs5fq6oTtHXTqcljztdYf8FGwT0jPd7sRCa+N80BI/cTqIuXq0UjAL?=
 =?us-ascii?Q?eToV8ZxVjkY+thaujRfakjyEbFda4ZLoBgAw/zegLz5O7ZezaO1/nTd/eX+l?=
 =?us-ascii?Q?7krXKCzgjAJQUpRWJ+zTwSIlfLKwaJ/KGVNlUoNmoj/pzRNhm2onducbeWW2?=
 =?us-ascii?Q?fAPDgGMW9qbleZpVZxnG0aLyCjDbunVbo2iGzrqsrYtbwS68VaStlk2+D7GI?=
 =?us-ascii?Q?eTyEJCvmI4c2rJGEx2NzNGZMsHILgiNYS3+vt7kHb0hb9qOR2Izho+rvQapn?=
 =?us-ascii?Q?uxSLoWvPLLseFBgL9hv6HupCWTLW75dNRQqT7pPXh6ZI+AQiyPvF9WbctDfn?=
 =?us-ascii?Q?UDE2oie7iz2efYmIJ9uniGFLNSdalyhPnYcbOVQWJuL90aDJGmgagJS79gs+?=
 =?us-ascii?Q?z+1pHQlk5jk6AvMa1CTnzIEJCYZeAWIjFcFrayLsEFpEYVh5OfRjk4uxPjHH?=
 =?us-ascii?Q?iXI/ugYQwGcxeWa3ay3Y4jWyB/jMUX9rver9sjO+GuQqe8PKAtpjKCxgMiaf?=
 =?us-ascii?Q?fjgqoRAqznvuGr3ZWxRyMgv1LaPkVYA0mM96+yTUqKJCgohN7sWI1+S90YZm?=
 =?us-ascii?Q?V1p4uksqhT3JMmIeLMGnm05PndgzcC/uBhk8VffMaiqL0Y9Qa7gYs9gaVhlJ?=
 =?us-ascii?Q?kxQMgY/9TW+HRDhboFEbVcNIdFxpxKLGBF9nPgX0xjRcJetfyz5fI1VKJmOd?=
 =?us-ascii?Q?/nShPUPyWdsYzms/mreLTypYpmfkk9Zj84KvUzLoaeqTVgE7HzQZg6AVpf5Y?=
 =?us-ascii?Q?5UUyks9sDXiMyl7ttFY/ClMWJdDy/dZTB/sdkA+PTaVKX0lRYocwJbXYf/81?=
 =?us-ascii?Q?zXQV0By1VFzGgARuxwDKDH1G8VIsTQwCqL6MV6oefFhuncei4rGFNcP/kjXk?=
 =?us-ascii?Q?AE0fX7D/ZXFgv2g23mY7fKF2wvMVJkbI3YTJNIJG1cBCLb4WHm7sWi5vpuhg?=
 =?us-ascii?Q?CAXMoDqGHduZYyfFCpvpKsIRXoeFOPzpM0UZLtjf3fj+VABvJ9VSYqszSzwA?=
 =?us-ascii?Q?9XLh5jDf2SFaIwRhTai0R/KL3FHYJNfoTHsiapySIIZf700+h0X5+YaKccwF?=
 =?us-ascii?Q?9IqN9DGauQ2Ab6fExPUoBkov9aBRx3LpTyKOy7YTJNo1egsXm2UbELlkYK//?=
 =?us-ascii?Q?d4p5dVOwXPNn/c95fxUI3P9RDvFfGuGwKq85PcG5eTMCyVr2d4AGn9ZmDIg5?=
 =?us-ascii?Q?/gysyBmBSS7weTkZeu9cHdximQFTTdRRS2pABstEmlCKGYabocOpcUkQGwzT?=
 =?us-ascii?Q?tZKRxV6Am9TuJQ15SQEnL5xDHb/zpAakvGtN9J0poddukgLdI/zSbKLbvNUH?=
 =?us-ascii?Q?E+kFbU0kjMOVT48oQ2fDUhkXlBYk73FiN/43Y45M4JHDuHDEO/bvANTAjm6j?=
 =?us-ascii?Q?QqPKS6JU4eOIEgpVlJO3R/UP5O0xsqzpkBcPy7Y2Cw9AmSehJZU4kDZ7zlO0?=
 =?us-ascii?Q?WDRudjU0Vm4df0dE3B8SSJv30OzPNOEToENI/qePvnYSyI+t48g0Gk4pVVHd?=
 =?us-ascii?Q?gnl4sN0t5IVGsrq1cIW9If90U+RTD/yEzhkFtYzufGtUlOdvdRkNByLkV0O0?=
 =?us-ascii?Q?KimL+pGqcQ5AJ66kDy+OdGNu7HD5SUGujrT0svzzR8jlCgMJ6Kep6sHd9sGi?=
 =?us-ascii?Q?ofpCZTbpKK6M4Uhw6ZSTUJVp/knsqQpTbFgTX+aB/ypGJ5Ey4u50EHsJIyrs?=
 =?us-ascii?Q?YaT91A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RsB6iY329xEBVPyKJ8mx9XPLeHbC0WMpaW5XHZnIlPHrxqd/cDcDQ7B7WSzgLbhpt8uleD8VNnmULWTU8we7EQOJRQ1wxLvyf7/mSi14Ezd0zrICwpPqb43PPkPs1+LGfJwtAFBBjUoANJ5UVbP+hHLigURXJg1YajmFHooddlYOlTX3nbrWkE1QX/RsV2oDhnjQ16/zTHpGHtmpWApkHq/nszyq+Gbr3OfS5p/+loOnT55aTD9Rz5/jjachweXiuj3uKQfbkOWh9xaiYLOAY0Ole1m40C+SlKqxEG+G7gsaywVgw5IY0RCzjZqi/9miXAG6kIsDdOiuqhaqzN+zKV1NIUJjeeEpjvEAx6EOdi6ihfK1w/zp5VrR/hCP0x3/B8EUJssKDtAEsczhO0L01Njj9YBOfCtTw2BlGYmOhfvH9gbjy3qlU+Z0hJLUsc7D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:58:09.4149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12259130-8853-4dad-a3a7-08de62f9f8da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
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

From: Shantur Rathore <i@shantur.com>

Currently efi_var_file.c has functions to store/read
EFI variables to/from memory buffer. These functions
can be used with other EFI variable stores so move
them out to efi_var_common.c

Signed-off-by: Shantur Rathore <i@shantur.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v6:
- Return EFI_SUCCESS in efi_set_variable_int() when
  CONFIG_EFI_VARIABLE_NO_STORE is enabled

Changes in v5:
- Invert logic in efi_variable.c and avoid #if

 include/efi_variable.h          |  5 +++
 lib/efi_loader/Makefile         |  2 +-
 lib/efi_loader/efi_var_common.c | 42 ++++++++++++++++++++++++
 lib/efi_loader/efi_var_file.c   | 57 ---------------------------------
 lib/efi_loader/efi_variable.c   | 17 +++++++---
 5 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 4065cf45ecaf..ee68fa4a885f 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -161,6 +161,11 @@ efi_status_t efi_var_to_file(void);
 efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
 					    u32 check_attr_mask);
 
+/* GUID used by Shim to store the MOK database */
+#define SHIM_LOCK_GUID \
+	EFI_GUID(0x605dab50, 0xe046, 0x4300, \
+		 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
+
 /**
  * efi_var_restore() - restore EFI variables from buffer
  *
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index f490081f6542..ca1775eb03be 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -53,7 +53,7 @@ ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
 obj-y += efi_variable_tee.o
 else
 obj-y += efi_variable.o
-obj-y += efi_var_file.o
+obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
 obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
 endif
 obj-y += efi_watchdog.o
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index 4b34a58b4cf7..5ea1688dca3d 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -41,6 +41,7 @@ static const struct efi_auth_var_name_type name_type[] = {
 
 static bool efi_secure_boot;
 static enum efi_secure_mode efi_secure_mode;
+static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
 
 /**
  * efi_efi_get_variable() - retrieve value of a UEFI variable
@@ -488,3 +489,44 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 
 	return EFI_SUCCESS;
 }
+
+efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
+{
+	struct efi_var_entry *var, *last_var;
+	u16 *data;
+	efi_status_t ret;
+
+	if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
+	    buf->crc32 != crc32(0, (u8 *)buf->var,
+				buf->length - sizeof(struct efi_var_file))) {
+		log_err("Invalid EFI variables file\n");
+		return EFI_INVALID_PARAMETER;
+	}
+
+	last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
+	for (var = buf->var; var < last_var;
+	     var = (struct efi_var_entry *)ALIGN((uintptr_t)data + var->length, 8)) {
+		data = var->name + u16_strlen(var->name) + 1;
+
+		/*
+		 * Secure boot related and volatile variables shall only be
+		 * restored from U-Boot's preseed.
+		 */
+		if (!safe &&
+		    (efi_auth_var_get_type(var->name, &var->guid) !=
+		     EFI_AUTH_VAR_NONE ||
+		     !guidcmp(&var->guid, &shim_lock_guid) ||
+		     !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
+			continue;
+		if (!var->length)
+			continue;
+		if (efi_var_mem_find(&var->guid, var->name, NULL))
+			continue;
+		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
+				      var->length, data, 0, NULL,
+				      var->time);
+		if (ret != EFI_SUCCESS)
+			log_err("Failed to set EFI variable %ls\n", var->name);
+	}
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index ba0bf33ffbd1..d32edaac277d 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -14,17 +14,9 @@
 #include <mapmem.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
-#include <u-boot/crc.h>
 
 #define PART_STR_LEN 10
 
-/* GUID used by Shim to store the MOK database */
-#define SHIM_LOCK_GUID \
-	EFI_GUID(0x605dab50, 0xe046, 0x4300, \
-		 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
-
-static const efi_guid_t shim_lock_guid = SHIM_LOCK_GUID;
-
 /**
  * efi_set_blk_dev_to_system_partition() - select EFI system partition
  *
@@ -59,7 +51,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
  */
 efi_status_t efi_var_to_file(void)
 {
-#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	efi_status_t ret;
 	struct efi_var_file *buf;
 	loff_t len;
@@ -91,52 +82,6 @@ error:
 out:
 	free(buf);
 	return ret;
-#else
-	return EFI_SUCCESS;
-#endif
-}
-
-efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
-{
-	struct efi_var_entry *var, *last_var;
-	u16 *data;
-	efi_status_t ret;
-
-	if (buf->reserved || buf->magic != EFI_VAR_FILE_MAGIC ||
-	    buf->crc32 != crc32(0, (u8 *)buf->var,
-				buf->length - sizeof(struct efi_var_file))) {
-		log_err("Invalid EFI variables file\n");
-		return EFI_INVALID_PARAMETER;
-	}
-
-	last_var = (struct efi_var_entry *)((u8 *)buf + buf->length);
-	for (var = buf->var; var < last_var;
-	     var = (struct efi_var_entry *)
-		   ALIGN((uintptr_t)data + var->length, 8)) {
-
-		data = var->name + u16_strlen(var->name) + 1;
-
-		/*
-		 * Secure boot related and volatile variables shall only be
-		 * restored from U-Boot's preseed.
-		 */
-		if (!safe &&
-		    (efi_auth_var_get_type(var->name, &var->guid) !=
-		     EFI_AUTH_VAR_NONE ||
-		     !guidcmp(&var->guid, &shim_lock_guid) ||
-		     !(var->attr & EFI_VARIABLE_NON_VOLATILE)))
-			continue;
-		if (!var->length)
-			continue;
-		if (efi_var_mem_find(&var->guid, var->name, NULL))
-			continue;
-		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
-				      var->length, data, 0, NULL,
-				      var->time);
-		if (ret != EFI_SUCCESS)
-			log_err("Failed to set EFI variable %ls\n", var->name);
-	}
-	return EFI_SUCCESS;
 }
 
 /**
@@ -155,7 +100,6 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
  */
 efi_status_t efi_var_from_file(void)
 {
-#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	struct efi_var_file *buf;
 	loff_t len;
 	efi_status_t ret;
@@ -180,6 +124,5 @@ efi_status_t efi_var_from_file(void)
 		log_err("Invalid EFI variables file\n");
 error:
 	free(buf);
-#endif
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index f3533f4def3a..6e45134c61bf 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -397,11 +397,15 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		ret = EFI_SUCCESS;
 
 	/*
-	 * Write non-volatile EFI variables to file
+	 * Write non-volatile EFI variables
 	 * TODO: check if a value change has occured to avoid superfluous writes
 	 */
-	if (attributes & EFI_VARIABLE_NON_VOLATILE)
+	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
+		if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
+			return EFI_SUCCESS;
+
 		efi_var_to_file();
+	}
 
 	return EFI_SUCCESS;
 }
@@ -594,9 +598,12 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	ret = efi_var_from_file();
-	if (ret != EFI_SUCCESS)
-		return ret;
+	if (!IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE)) {
+		ret = efi_var_from_file();
+		if (ret != EFI_SUCCESS)
+			return ret;
+	}
+
 	if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
 		ret = efi_var_restore((struct efi_var_file *)
 				      __efi_var_file_begin, true);
-- 
2.43.0

