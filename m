Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B204E7FDCF
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E5D840B1;
	Tue,  3 Feb 2026 12:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sTrXTlVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136178405A; Tue,  3 Feb 2026 12:52:00 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9EE840B0
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dab2p/N8X9C7DcMchiIiRf+MrpuLBkLPe41KV2FfpWbZlw4BSR5sBYFLL1ZiiYiaJv6UKPpBbSQoAWGFnFEnb6xDEdz4/xLS8ffHcFHHvm/AC036Y0Iw2rG0Gq7l3GghXvrp83YUDQYUm9o2KWPWBzXagfio+Q38qklLeqkLYa2j8JF4rnAtbDHjhYYixOHzFTZLIjQQ1m4OFs3rDBqiAbnQ7KY0y9CSJFaBQaV1aEB3FNPm2GMdmE1GY+x4fGNsoye6OcQko2SxIbopGfIJCsu2d/mhvFFareOrxF/gpBEdDZJ5QSgGw0qjP1NOod/JQCgppqfetpdN6Y3MMlhb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRt3expefat2HQFDUOrIC8ZsorLQB1GO+TTT60hWaeE=;
 b=hKeQI+oFMY3QVaAA1/kUIYV1vnvOK4q/WESS7CxumaCnWmH0QuANZJtHiun5WICJQWGGCt2ItysSLweDp7EVL8KNbvALnux9kCWaMGCyhQiY872YHfqaZPq+4s3y6EtGlwqwOEhs3DTOeDBsP+2lis4SXe9uIw8jEQSZq+EBMT80/k/CM4lRupN8D39o6SRLaPpB/X//ukluyYgT7rLDMMqt+qWbVIsgeGjDtiFpKzIrzGhX2+06uGVGi/hKAb5jlZyCH9JdlNqYYN0wKYGak43FUnRe+k1rq4H35chvGkFC+I+t5pVSma+ZrQkISVvbjMOysOzqW/kOeI5eBzU/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRt3expefat2HQFDUOrIC8ZsorLQB1GO+TTT60hWaeE=;
 b=sTrXTlVGwab51WDzUC7NbVITVKCntegc8JaFfFPqCxRJ5iOdrg/4V4e4MS8FzDZj3npcGOtvIAVWdQolvJ8ZquvG92StL2s6074OyHlirpQ7Jskn7Ctx0NdT5s4rLbfuIYKl9s7sWctP2W82wLWXjfi1go+/M4sdghZb+/1RZbY=
Received: from BN9PR03CA0426.namprd03.prod.outlook.com (2603:10b6:408:113::11)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:51:51 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::e9) by BN9PR03CA0426.outlook.office365.com
 (2603:10b6:408:113::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Tue, 3
 Feb 2026 11:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 11:51:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 05:51:50 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 05:51:48 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 03:51:48 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v7 2/3] efi_var: Unify read/write access helper function
Date: Tue, 3 Feb 2026 12:51:27 +0100
Message-ID: <f56553cd519b768f8febba0b8d807de3cad14739.1770119483.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770119483.git.michal.simek@amd.com>
References: <cover.1770119483.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3798; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dPn5Nh1crwNwOkpFVLpKRIHv4Ppoyig8trMkUiJGZGc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2PnSdwf3L/iTfk6fPOI4pyKlEJ5xImvGHXf1t4Jo/P
 BGB6lNPd5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEngky/Gb9Pe/Lm7hHLmyd
 +7LtHA+FZcyU/fCYxXva0ou5IruW1oQxMjwQv8pS0ur4voov0swv8Ma2Vzp7GzttEjmzDtxpVN5
 +lxEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ffd62b-56ea-4b11-8a8f-08de631a9e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5atqtb/cmUNvKiQ9DlAVg6ThgQlepkAfkrRLG85AIldzx/GD7EHAJXamy2Jb?=
 =?us-ascii?Q?vhyQKzEtFfTboAbYDQgbRJ2QqU3Le8yfAOXEG15yozso2YWjgTcKB61tfPTo?=
 =?us-ascii?Q?WsJC6wQbHfeuYlCfgxG384td8vvNo4xVrVxbapMK7pxiJzK75nNQxffAmlvK?=
 =?us-ascii?Q?pK7baer4mcvxTgY0wY7LDVNPJJu3K6PIIuJR/UNE1QZdNDcr+Jd9VVpEPU6c?=
 =?us-ascii?Q?R1R4FgCGQJpXqpAsl92aYlCanmwZEf60ELnPi+jPqbFc90uLNAM1AGX0GT3S?=
 =?us-ascii?Q?0M0lyP4vT5p42zjYaRKqnPNzL4+JHNJg5JXOC5Km+rByueFCByjPsHWqqI7q?=
 =?us-ascii?Q?9j33vM3Ndy/E1oKi4RPSD6gVsLTN5kUKTMTgURk6ZCYDFe+u7zXyrKWCIFNZ?=
 =?us-ascii?Q?N4rhEmjQUeoNfTbOw1jXD82pMJeb0SMCb41bgP8EI+hsQvPysw+ZGKh0lxgX?=
 =?us-ascii?Q?GRPu6Xi8igUiEz57OU7tWCRlMjbSzfK9Lzbijxi15RIDUHdKknoA3oqcLPbS?=
 =?us-ascii?Q?nmC7E3waN50kxKL7yl4k0D6nJrdxrGRAcNMXg9JPiTMbCPtU4RnGpf8tdr0I?=
 =?us-ascii?Q?3e3XKG4aX6AWqYu4FUqiRYSpVhX8F7QyK6kOjxvnU5VwUwcnnDqs6A7v92w5?=
 =?us-ascii?Q?w1HwxwirD9vUqIgKwXNLGIPEO7qaqexO41NylLUVd8+WDjslP1K6r1lQZ7sY?=
 =?us-ascii?Q?9puYCQS4l2xZcZ20bpNVci6rtSwziOHHbfScr3wuG+kSbGo5HY8Pfb0TzaQG?=
 =?us-ascii?Q?LvAQ3MqEq3b8+7dlSjmtQUQzCyJpvoJtsNvkIsGK8fdpCXh18WdRdz6VHu4u?=
 =?us-ascii?Q?r7ncsl+DQnAgYv5BEv1Q81gkh68L6kBAacinHsRUpta4btE6nQ26z2NDzL/J?=
 =?us-ascii?Q?RwYXVLeFApDhwNxzVnXH89Y27BDb4DlyumCuMhQxLGZjmgu8K0QaKYv183td?=
 =?us-ascii?Q?nadHpxvmRgooGX5WmUffvSikCVOroKAxk6w9NWfNEk7JURra54sbaBqdrQXn?=
 =?us-ascii?Q?LQAVy7QMlq1UYuiWVQo8bxnRPz8WpIqTxZ46e5pFumybRHwjLtr8bxkLIbMN?=
 =?us-ascii?Q?chqtU3lBvrBj31niW/LFE7T/6Y9/nKW9Y2Q8DwVt4kEGjvKVuYflNoT/JaQ2?=
 =?us-ascii?Q?w/1i5c7LDOMD6DnhatQzoyC6YPalhiSw8aciuFUt37WGxBeMr7LW27SAF7lh?=
 =?us-ascii?Q?eJefoi/W0dtxXG06YJJ67tBNn9aceCcX8hzmCbXBAseYvGypTFUtZWeU71uY?=
 =?us-ascii?Q?GXd8ysG+B4N62LMgr1qP9C0p5zVg6y0olHKyreWDZDhGT0K4lNB8YVSCh8lQ?=
 =?us-ascii?Q?0InR3a4Fr42wwbjJ2uECBeQWAb/E8tOUt2n1Vhj657DpK/ZO0rJFT+ciHO2h?=
 =?us-ascii?Q?OwLIpi2W2sIAVPERPEFmg1MC4n48Q0Ti8dhzR3d9MRlfGqNqfZNbRlQZSzzK?=
 =?us-ascii?Q?FxsE4Xpx0o5xBkrchVM5nVmRiPGy9vcvPwiBXFiFLNEOuCm9Afmtr2gKg/6c?=
 =?us-ascii?Q?3gAmcjPMXvGNBBmafsmSOjlaVMEjHriFmPEgjIbsSx5+JzDO9A+iC3CE/C19?=
 =?us-ascii?Q?3dPWmEg+52891hJG4wXkRk5ze4KCn+ndgtIHMiuAPbtwU9FGmZ0eEQm28AuL?=
 =?us-ascii?Q?C8++7isGSg5PfltG1MyhufGgHkDGBTISdD1ORijqB+S6BjVaMiRc5GMCSPvT?=
 =?us-ascii?Q?NbC4cA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iZBPAkwoATnK6KrPqHcvmGWjdTyp+juJXpZYoYkZg3aFeaUssaLznBHPtWQicT26dSaMQRhmsnneL6b9vXAPBI+tTkbRdCO6o1naVu2kLiDgmwSYume2EFMsRrirbzu6Qwxyib94Hkz18yFViDXw5PQMKbA/Hw0fYXGnUEEKMmac0d+sCupBOgzsJ00CW2b4JvOZ9DWbJQl0eb6ziXZWMZdFN5vMUdDbStwM1GBfKy4JQrPOtAHoO4ryZjBFfSK0YPn6BReo4GNizYFO5//pIIG4tyZyVnClhNJnRO4yVBzBoF0F4XAn94JWtsUHBKFWQ4Q9fRIug2tQ0x6+49w3Lyl9qeErwFZtdAq6FX8QJsqM5/+IovoY3HrOhSLXm2U97QTEi+DHRoIT0oer39oD88qMuaZAhWS5LOJxAayHcPbYFU6mloykWt7hpEvGigIi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:51:50.6409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ffd62b-56ea-4b11-8a8f-08de631a9e26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
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
index d32edaac277d..3b50911215eb 100644
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

