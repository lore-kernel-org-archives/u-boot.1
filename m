Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE78F0182E
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 12:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D4BF839A8;
	Fri,  6 Mar 2026 13:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvDI5S78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69AE83F00; Fri,  6 Mar 2026 13:48:26 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3ED836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 13:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5SXBEmd/leVeSaMb/iIqKxWTkIFyyHyf7PJP8U+uraUr2hXzrfQgvsI00Mnv6wwvbSSkQhSo0mcslpmQh22k2XMra/xmwCKm0eyUGodrzBIv+QdqWkn2XrarE7GSaunss/DFw/7G/WL0j+qLprtkGwHmpl3Nd0kN3QeJpg/16JEyf13v5g+HKts/o5CxFSa+NvlzTmLolPG5LDKrhcTCxlGOOqv/6GqY/UlLY1il7FsapuXXPNX6cz0GN8QfHgc8vns7ayLapnqoxMz9W7wAJqp+PqJ70GzwJjVWrOZBC9X678k0K30qIJTpaNYhqk0LQqsl4v+OdOyIivYTxnZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwscZ/YqXH1ubYwdhwFSx5BZJaBcn8BVbe7UoQ0sL4w=;
 b=GW+q/eTGAPqiAPRRmoDJZ/ltH+JOGyBI5kunowPwATm+T7srffY2Fc7meWcb8PJy2hZPUiAat38nN30w4v6twKTDD/+GCL3VvmaAQECHIzFKOYE1KKBE1/AntAsJd2L2Z/FWTxReniSxn6nii/NS/pT9BD/SJrn8D1RSWyPp5MBijFVjiXKTZDrB6Ui/nhZkzgMCYmUNYUBiqNxJEmORSZfcdEKyDpeIOhNUt6UknOOZiS6mluB8tYsC/M8oyJiF0/5c9OuvWL39of9wqvTYRidcdXO53T86FuuhZpNcqUSulYfkfiDsBreMbWcecGxU2sWnsPczaSuNO2GkO9/fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwscZ/YqXH1ubYwdhwFSx5BZJaBcn8BVbe7UoQ0sL4w=;
 b=ZvDI5S786j5E8HuV6MGBiYGkBQ+8xOeSJEkOuv4FK7UjR5T3eJGiw0DB9Z1No0ogVo3jdGnYM5f47ug3Y8Hd0AaBb87VlvZWr7G4srplpZaYNT4TNYN1c2TjrnxHA3RPRWXZfN8nDD1Oo0UslbYPlbAemhvWAvb4t7LLUGvRLjc=
Received: from BYAPR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:74::25)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 12:48:20 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:74:cafe::5c) by BYAPR05CA0048.outlook.office365.com
 (2603:10b6:a03:74::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.17 via Frontend Transport; Fri,
 6 Mar 2026 12:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 12:48:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 06:48:16 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 06:48:16 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Maheedhar Bollapalli
 <maheedharsai.bollapalli@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: versal2: Fix UFS boot command sequence
Date: Fri, 6 Mar 2026 13:48:07 +0100
Message-ID: <5447ce1d5c4a21b0b62ce76ad642296110364041.1772801284.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=CLQHY+lgdGDVCoVAeLWqUEH9t94yKBGO9i0bVU2e0nU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSuOsuZJ2k8/93HDK2c/70yJRO3LGrTkj+9uSRuisXtu
 bvZvGdN7ShlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJ5AUxMhw891REs8XxiESL
 2/Tthx49qvaZFaDb1D054PtmwZ0lrxcy/Pf593DeLZueib4K55VnK80+nHdj+524I7WFIQUSMpd
 u5PABAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d83b4b-b738-473d-ffaa-08de7b7ea4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: +jRqgDc7Ke0+uQbMcxg/s1hzRjS3H2cWUCJ8yo4iI3J/tQx+4NrBGEGboas8a3OR9k1TPi5FKl1mzenapPZbgi+Z8OacRI47nX7/YSP/mOxS14awA85vnP2/OfNzaizi0fu70nYesrWvDFE66li2GybnOg62wPHrPDX6d+0PtJBygfWHPqHqsjtvh5V8NsjINOiEPQT9YoDPiKALnEKrVq7j0fDDWi8dBJSrK4z8m8E9ZfPylPFRxLQlCwMEU2vdRmIVm6IwKbpe1P0i5IcfkIUmSC6Z68YZ/nBEZ+fce2wZ5j4yhfTMYIFdRdkhNj2SjEW6WwNANmOJHkPOpR8vctC2Bpwoudd2X3y5+3eI5GbPzsjP/UUuxayUYNu5GPOPGGDJwAPBGvM2s9Rr9NRIomizYAsbLpvf5IAIhhqc1K8WpaAnzQ/H/f5b41SZUUCzzDWekeQqYzY3lycM905JLxihmVm5KkMP2hfXxj9tj5xT3j9EF5JoepTaCcc839rvryUaRdLmcCjXO9O9odhAVsLhVFDlErCEw4VDKj0IEeKCJjMSa8+d8Me1FqUp3aTJE9UMpIAxqs0wsZ7iRFrRMUqz7fR2nyR9wrdsqqn271hrPJRHCGG5Sw/tCfyeGfZp5nz6O5jnpWJ34Bp/Nsekz1c2ju2JVD7l3/Ka5DncF0Cyu2B9T2SxQug7U6oNJQxGfFYaNgIBO8nCL2BfL9Wqc4fyp0D+wa0hNpLd4/Jt3aVgH0zAOJn+TCVr4iEJblk3SAHScYfg/rnhLfVc4or+YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3zXyKL+qRmRXHJB7nzVXrR/AMFwOQcmKPeGgdUgwlxfVb2Kujwo6Ptk7/tNXLjpfXDyUhn98PU+e13r2vsXM7lX8KM+dd1pnbM+nfg/skpg6QoRvEQWvUD+llN5/PG1kwnHPRnfECMtBgjrj8/y25rtlDsmLd0LJsHZYa75rXKt0xX5ec4Tybopm67pq+KJHPgdQHWJn95B0LMFARJWOYUUxvKtiA1oMAIjqzZ4dRGVIiwJ6WzzA8fpIcv/UykmilsHuaHW9enIYv6ETHBPgryC+Q1RArxjjLpe6Bwdf+dfKANljupmEU4davDcFr39W1Q2Hoxe/JbwTkNAncmaf1/S1/+8XMAb8QyYRe+TCtXsSx57skTnO7ofdZNG42A9HgcmhHnIGivuvMcqyUWnyJPZz3XlAId+1XntDm9hXWgrdtL6QmgKOrhmRwkXrIyIY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 12:48:19.4186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d83b4b-b738-473d-ffaa-08de7b7ea4d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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

From: Padmarao Begari <padmarao.begari@amd.com>

The BOOTENV_DEV_UFS macro is incomplete - it only initializes UFS
and scans SCSI devices but does not actually boot anything. This
causes the boot sequence to stop after scsi scan without loading
a kernel.

Update BOOTENV_DEV_UFS to set the devnum environment variable to
the UFS instance number, initialize the device using $devnum, and
delegate the boot process to the shared scsi_boot script. Remove
the explicit scsi scan, as it is already handled by scsi_boot.

This matches the pattern used by other boot device macros and
ensures that UFS devices can successfully boot using the distro
boot framework.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/amd_versal2.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index 404af2cd4c65..38d0bfc315b7 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -108,7 +108,8 @@
 #define BOOT_TARGET_DEVICES_UFS(func)	func(UFS, ufs, 0)
 
 #define BOOTENV_DEV_UFS(devtypeu, devtypel, instance) \
-	"bootcmd_" #devtypel "=" #devtypel " init " #instance "; scsi scan;\0"
+	"bootcmd_" #devtypel "=devnum=" #instance "; " \
+	#devtypel " init $devnum; run scsi_boot\0"
 
 #define BOOTENV_DEV_NAME_UFS(devtypeu, devtypel, instance) \
 	"ufs "
-- 
2.43.0

base-commit: f431a25f6a088a4a296d13c2f00290e71a552d24
branch: debian-sent3
