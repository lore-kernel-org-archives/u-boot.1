Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92714C8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8618582E8C;
	Mon, 30 Jun 2025 14:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFTz3EZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E3680B9B; Mon, 30 Jun 2025 14:21:40 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AEA880B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 14:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXobOY8qvlaoDRwhGCxOG6+XmpG59evMp5ivDY29qFK3iaUPly7/oWOPHFgCzvYFlupW7mrBsMAcJvZpLSVHBG63zq3VkIHYKIPvLkVvQedrTpgVtg1a0pV3HaPFrrSI5UaOv5D9yVmBxkP/IBYqV5xfB0ufZjcNgGtkS09vjTsCMR6jM0cE45v4gbZ0XoibzJE7j/otmFkPHw9QC9vAEEQHH/UJ/YhTW/0oZy9KABsgNJoSajlI3+hp/9MPCnQmNWWVXhgzbb0NysRA99TuqqMhTfVNd1tFY0iCHhv0n/e0H7dL6UqzOHYBWZq2LeIIM9GHqmzUw2yGzrgnduNL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Htih7Rp3Gq8xWzGUaeNzbZnV9GLKJgTKYwN3Y9LONEw=;
 b=gjbe4z3Wqrt+c0B+pCtM3UJsDVQ65gspsi6KNoav/1Rowdu1t7S13syysq73RFQahBCTNfW83OT6IvnrpFekKUhf4yY23AQKRjpKJgPres6JxD/8Pw6YLy8O9ZLNkMjW7ccRqZdPdpSAcuNShbDt4eWj+Gkf7Zxu51E+NLmihF72pxRcloX6NIdZXjTC4Od+psFSfOl1kQWgpYR2HPatUVXPqi+UckTmlkVafStBfcjdqX84gxbKvviOBYwRSDTEVBYo6hO/uuAQ0peGD2/NLV3IXvhbqp+HGV2v4iKy4pYL3nhZt+r/ONHbLgiAuh4jlHhEWT4BlD4TnJtuGzIdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htih7Rp3Gq8xWzGUaeNzbZnV9GLKJgTKYwN3Y9LONEw=;
 b=wFTz3EZTJ8fW4OYrtd0dWZvhFpPJrBV4MjE3D+X/7EMlqrjVzB+kdZqiWAt3MTaHOMEcvJ9/Xdz0JzzsOIq6qLVd/AaEAS5INDDdKxXPwCrC9Iqdm6eYC9l7rljeiZ5O54Nsw2Y6FH6qE35upzY5YWw7IECR9jR9112jiwaSpE0=
Received: from SJ0PR13CA0231.namprd13.prod.outlook.com (2603:10b6:a03:2c1::26)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 12:21:27 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::c9) by SJ0PR13CA0231.outlook.office365.com
 (2603:10b6:a03:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.17 via Frontend Transport; Mon,
 30 Jun 2025 12:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 12:21:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 07:21:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 07:21:17 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Jun 2025 07:21:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Peter Robinson <pbrobinson@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ibai
 Erkiaga" <ibai.erkiaga-elorza@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] cmd: Introduce CMD_HELP
Date: Mon, 30 Jun 2025 14:21:07 +0200
Message-ID: <c17f825fb8a74e1d1912a3fd09a9a880c84a8bfd.1751286059.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=G4xMPhSaplEqt13Woj8LdVC6kE0J50bTZf6LYBCPfsA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQkNZoqi2asX+/+wuqS+K0v88q3b7ZLvZVzJX5f707Hv
 r3MxbGlHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRslmMDI/Vzt2v40/j9Hkj
 2K/x695kH4Mrz+tWufVs47q7InqjXz0jw9tdsR8kj8z2MdnD+Kudq+q+x84lP8p431ad5znn8MD
 hGhsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 297074d6-4510-42be-69d0-08ddb7d0a159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fu1A3TPm5mUpdMXZFjH2jecEytmAui9kHDD5ai3ZS79MJtF7Vb/GvjSoOhzE?=
 =?us-ascii?Q?7SmV7k9/bp97CUZSsFXwWB3EjTP0j5Dfwp1QUsEPkkBnocSNuihaOEy2Xhh2?=
 =?us-ascii?Q?QdCM0WkZK4w+lFehSLX5jNFi+lOvvEE2kILg5gmqcnKI7B58oFUnuQf/Vblk?=
 =?us-ascii?Q?S7gF8c29N67N3Y+wx/lBTPOYddnU4xFLkWmTdXDELm57RyHyRjQaiwIkojxH?=
 =?us-ascii?Q?VCsDGXPDVrMfxzVjf+iDoAXz7c2eJMnniyGCvKKpwXJxZrkeMmP7YbVKmG0u?=
 =?us-ascii?Q?oXdnjL48iVRNOCh8oqo2ENbhTcrdcpUPVnnqUWJFm3lR8Kueka3W7GDBh0Rj?=
 =?us-ascii?Q?MXY3buSPApOevJCMGzvQc+AKh5pkR0OCJ9Mw1czhv2RAHP/+t/Iqv7gBZCba?=
 =?us-ascii?Q?dLq6ZzoYUN/ET21KBKf72LbkZsbAaokBGzKlg0Dhn8zhZFg+9W93LmTTcL8a?=
 =?us-ascii?Q?cJGtCuXxY8o0xqBGfkc+CBvPx3givEfEO/s9/OuTVoNf2gLD3/9SkbbNpkAs?=
 =?us-ascii?Q?l6Vhi/i1cT/kCG0ogu33DzsiCijCMh3HRbUo20iBpw45VlN7kmk2kzm0m7sF?=
 =?us-ascii?Q?fcPj73WkyKuut4QONa4+ghLGcsVqSMJLHp3TmCQVgIfOjNmcubuDKgBwLkDV?=
 =?us-ascii?Q?e8GUT9LgEBMlWPbX4SMH92Ga640crqIZqME0VNJH/acQE7CPjS3cJO4xtr7w?=
 =?us-ascii?Q?ImdpyQDZgGEjwB3p0aJBRjz2PHP0giEL36arO1e2I84yygT+wo+Hya3HZapB?=
 =?us-ascii?Q?rPAAv8lJB8kSecQxs2zSKrxmsc++AmtlMn8YXSqkxACBKCdZa1rNi5PmEAUK?=
 =?us-ascii?Q?jHA4wRd5JJQq6Ve7D+zb5OTGuA0gt3Q5DqrS77S4HMqWol1MKTRhRnn5ssLR?=
 =?us-ascii?Q?jUkVrYaZBhhnibLxiGTZ7mxJ0RXkEiWihfwyYOUzuVvm0OErRqH5xrcQ6j6d?=
 =?us-ascii?Q?rTFtf6Veuk+pb6n4LDA6Y3JGRT6/ripCNcnJWycrVEHP/xHn/nr4FRqJrarP?=
 =?us-ascii?Q?U2WvrM79Wzs4S/BYSugPIVi7tAI0g49v67S4zpVUvVxnQawhnB7MwVpF1eWi?=
 =?us-ascii?Q?J2aPoojrnM6kVtTvXzg9FFyxE7UN29Z4NXwY2uLoNrzuqqQHPVNcvQRE2wRN?=
 =?us-ascii?Q?4pRNDL8/huU1YvO8cyF3xmUSV0nClB53lQo9SNjX8wPTDHs561rQX+FYiBnI?=
 =?us-ascii?Q?vz896gvs8nD6wIhmJih0h6+324svt+x+kQDl4fMPC5WCKu+yHoOMc6crhG8d?=
 =?us-ascii?Q?5a77y5KlLNSvvc5g5/8+jf9uo1loXxBneeAe+bVcmxtNHQ61HIq3TsTHUfRm?=
 =?us-ascii?Q?x65+NmQ73DRK8illuifuTvyKuYF12x+bPZkX+XzBcu+pumc5N1bpffjdlUCZ?=
 =?us-ascii?Q?QWDQHx9iR5Hja2KVxBOoTsZruf/++DcfoHUxf14tfLMO/NCdXfr1kZowUbEw?=
 =?us-ascii?Q?lorzxJKyRExxb9IUWl2k7Iux2IAB2ikRM3mICeapDy9PX3hdAOxbXRd0X07f?=
 =?us-ascii?Q?wNqloPVo5IduB6M1gwBgVPIBixtV9koJygjL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:21:24.3897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297074d6-4510-42be-69d0-08ddb7d0a159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158
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

Add option to disable help command in size constrained systems to save some
space. There is also no need to have ifdefs around CMDLINE because all
commands bepends on it.
And also mark cmd_help dependency in test_help.py.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---

Changes in v2:
- Remove CONFIG_CMDLINE ifdefs from code.
- Update test_help.

 cmd/Kconfig                | 6 ++++++
 cmd/Makefile               | 2 +-
 cmd/help.c                 | 6 ------
 test/py/tests/test_help.py | 1 +
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4eb0140c10a1..ee3fbe6a4f2b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -189,6 +189,12 @@ config CMD_FWU_METADATA
 	help
 	  Command to read the metadata and dump it's contents
 
+config CMD_HELP
+	bool "help"
+	default y
+	help
+	  Command to show help information about other commands.
+
 config CMD_HISTORY
 	bool "history"
 	depends on CMDLINE_EDITING
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8c..718eff4ed197 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -7,7 +7,7 @@ ifndef CONFIG_XPL_BUILD
 # core command
 obj-y += boot.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
-obj-y += help.o
+obj-$(CONFIG_CMD_HELP) += help.o
 obj-y += panic.o
 obj-y += version.o
 
diff --git a/cmd/help.c b/cmd/help.c
index 56579e28d31d..1be83ba607d4 100644
--- a/cmd/help.c
+++ b/cmd/help.c
@@ -9,13 +9,9 @@
 static int do_help(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
-#ifdef CONFIG_CMDLINE
 	struct cmd_tbl *start = ll_entry_start(struct cmd_tbl, cmd);
 	const int len = ll_entry_count(struct cmd_tbl, cmd);
 	return _do_help(start, len, cmdtp, flag, argc, argv);
-#else
-	return 0;
-#endif
 }
 
 U_BOOT_CMD(
@@ -27,7 +23,6 @@ U_BOOT_CMD(
 	"	- print detailed usage of 'command'"
 );
 
-#ifdef CONFIG_CMDLINE
 /*
  * This does not use the U_BOOT_CMD macro as ? can't be used in symbol names
  * nor can we rely on the CONFIG_SYS_LONGHELP helper macro
@@ -39,4 +34,3 @@ ll_entry_declare(struct cmd_tbl, question_mark, cmd) = {
 	""
 #endif /* CONFIG_SYS_LONGHELP */
 };
-#endif
diff --git a/test/py/tests/test_help.py b/test/py/tests/test_help.py
index 12cb36b7b985..afb57201ba38 100644
--- a/test/py/tests/test_help.py
+++ b/test/py/tests/test_help.py
@@ -4,6 +4,7 @@
 
 import pytest
 
+@pytest.mark.buildconfigspec('cmd_help')
 def test_help(ubman):
     """Test that the "help" command can be executed."""
 
-- 
2.43.0

base-commit: 40ef75b0796307f718a4b424b5e52e79b36ae2f4
