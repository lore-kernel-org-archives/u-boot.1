Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59241CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 07:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EDD830A0;
	Wed, 10 Sep 2025 09:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SKqTFlSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD8E831A4; Wed, 10 Sep 2025 09:26:56 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6547D82B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 09:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxhxKeUw2ts7wcqANhakJSu2UiksCVsZL9Yp2B6yx4l2Pd74Y0sUJAgqF09/mZRLMcgjSHSqNNspCno7+b94XvBLXRWEff17zz+nCVGt90hj8PuhnJdDMCsd662ss9rzcvxEXckQ36+N72e6ZozlTXvVT91w8TGF+J2ZZDUBvvH2C0TIrlu6jUBEJQuxidz1+c3sxrwMNxfqZUvK65JOCz9EFMCbdZpEqiI2jhJ2wx96UM6brNercFGEVxObzyXIrgwjysuOlBuuv3pTSD5TcPqD67jICXCIB3dI3C25WA3AghnDwslCFUroKlwG+otCjrknC6TTFkiRmsQ7EqjQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxJm/vG4Qo3Jhc5AtGA/YtuFZ791GS4ccrKSJRkPgFY=;
 b=OQcfVvSxUiuzRUagzaRSxInWmbS66cmxjRrboKsAExVZbdQgxcn74AdlUG9pa71c7hY9v6cNRQPlGP7cZ9PZWWKdtGjYf3rDbEpQx4cScUl6dV73aoxbrde+Vs4AiUSlb4u8ihUhk5JNsA8QwpvwAn0UVMolBcvIeqJhPsv9EHI8sg2QWMFhkWjy66Q2mPF8qZfGnlzTrvnBBMbm/Y45kSqs9xPXBNeeXJpZduEI9w+oyvyOf73KAc+9e+2n86qgvUY2rhy1HG902e1VywAJRi0NZkhp2UnRfzg9IWsMjTCoFa7C+iygBEvv6/qhZWSlWCeNIHdVQ1UeQNy8hAI0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxJm/vG4Qo3Jhc5AtGA/YtuFZ791GS4ccrKSJRkPgFY=;
 b=SKqTFlSYtLlcWt964ihxtHX1AEOPDB1/a0wsIs3o0VgFJHOkHEDZyMKSK7QF0Q224+COgWgR6aHhK4iZ92y2wpJubwq68hoXuJhPLiithBXg9Xya+e9+b/0Fyy8tPl0hdy1deYZmISttZvg6ucuvDS2699KWvnMPnVa/mmEIgWc=
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 07:26:47 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::19) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 07:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Wed, 10 Sep 2025 07:26:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 10 Sep
 2025 00:26:46 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 02:26:44 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 00:26:43 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Marek Vasut <marex@denx.de>,
 "Tom Rini" <trini@konsulko.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] env: spi: Fix gd->env_valid for the first write
Date: Wed, 10 Sep 2025 09:26:30 +0200
Message-ID: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2875; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=GGeEUxhHKVfKYFUNwHU39PJHy8XEe6lSVp3CFLQ6gMw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQc1FDXiOZa+3rxxmJT3zOuLhZsrLZC0hdKDH7cnXXxn
 fZuFjWdjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjI6v0Mv9lZ65WTE689OmNx
 YdOspPU6MnPKE/LDlwQ9qZab1PqkL4GR4d5uoZqlNy/LOB3TUN4x0y7zaOzbBcsPt8+8q3Vyi8I
 1JVYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: aeff2a44-bc29-444c-0992-08ddf03b6688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G77bxJNvhulnmPeX4/yhBTllDdooY8UMLO1ZwvJ677efEa07snr3DfQ+/EQf?=
 =?us-ascii?Q?zQyz4nIlz7e4lDVlMPFxdyDobW8LxFuV75XQUREdWva2vQDscfKkyCtTVXF9?=
 =?us-ascii?Q?DlNWP9XX/Zf5EgftQB91Dm+uqsefgjTd0eAY5VACa7cQ/o42jx8i3+KS9f+K?=
 =?us-ascii?Q?PJs8ZoE7U5U+UDbZDVXl6LLT71OkX+MAB80Y6kO/nlOdF0okyr9SmhD6rTEm?=
 =?us-ascii?Q?cJNtwIZelyUXGxkM8HDenqKbrjObtlA2ROZPvQYjyeO7ZacGvcyF63VKmQlB?=
 =?us-ascii?Q?1eKHnSh1x1rcoRA6tz6+afcdszLT4ZxZHTlXV1LCG5ezvGjerR2+gv30v+KT?=
 =?us-ascii?Q?NfkIdOdo60a4rKvkbewxHoxFtItqPMeOhE/AHDOyurDkifkzZoU+oj2fp/zs?=
 =?us-ascii?Q?pz5e7WDU9sPBD18RgIe+oCV50wjQKPATPWAE3po0SmIULa83p22vITgg84Bl?=
 =?us-ascii?Q?CtXTyTbEB1nkT45bBkfVXBbHOSBGeGEU+dP3RzyN+BtYGI7OtQ8P22YUwK23?=
 =?us-ascii?Q?cISeNCqclYNHKU43CW9GuIoxcinTClGmjGdQANhxf+wZx0i9+R/DnJmAZbxN?=
 =?us-ascii?Q?XOICPexKDf+/9GeYRjFKxaffthMimzTjPvZpHClCe1dKRaxWF4G2jHq2Z49n?=
 =?us-ascii?Q?eS1X2eVf3dP1PRuMNhCvNUAHjX6B4fIOmnxXRV4pM07mzyN5CbzWspTxHh4F?=
 =?us-ascii?Q?0vYIWjwBGVAO+6Kcfv/AVn5CMCVrG6vctZP9hp6xX3Ote1e16Cb4xs6b6juO?=
 =?us-ascii?Q?Q+dxoa1MnRXnhqeIy2puFxx/gKou9XjtsB1X5jF/P/shyhqPc/Nu/Gcb9NDJ?=
 =?us-ascii?Q?G5x6E0yfa2RThvF+M56FdKw4qOe0v/9/+/zk1iTRIizN4GOmaJ+kJmDjpHBg?=
 =?us-ascii?Q?zjJ3lzXA5QFUBIJCY+EBb5AXgo6YCnPmB+6lbcQ/NIVw52w4XGdjmfQWEUp7?=
 =?us-ascii?Q?mvJ9m9dv0gd0K1dwTQm3LfL7hQ5HTRY9/Up2mZhRi7+xo8tebdrahA7rqmz3?=
 =?us-ascii?Q?zt3IuNwnpcjnaGrg5g4j0IOZ/cIdMs0uQohD820tyUiyMAEQKBnsP+/BLQrH?=
 =?us-ascii?Q?i2MMUzwbyofZzS1Sa9NA+Ly+TZB1pqDtEOHWgu9MOBRDVjnQw1WlQ6UDt77m?=
 =?us-ascii?Q?OjaSHkz0+0N8tkigTdQX7E/szHvP3pYeD3i8SBkg+Zv9s+CiCSXpHlGMX/eO?=
 =?us-ascii?Q?lbOsGZQUnPRJIHonFdMohfxwdAg8hDnlkJ+S9OAz/kiKCQ1rDArYiz+sqMjS?=
 =?us-ascii?Q?aOpB2jaj6wnrYtPEfNn7HPIZx5Xf3kJd9czuR9o+JT/JsPrJYfn6J8yWAxLL?=
 =?us-ascii?Q?bh2733cW4bbkFlbSgEfWXLkWnBqKFJ4XmfAdaWQda2CYCkgSxN3jjqGEUBIy?=
 =?us-ascii?Q?FQIwlUcKrNtldj9M7I0LlixVkXXKz3jMHJtYL+4H0pegglY4ASTqKdEgyaJH?=
 =?us-ascii?Q?GdjqN1lj8ZmZsbU+ZTy4PkqAjbXOK7g+y0BlAB15YqCMX7HE8A8MVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 07:26:46.9063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeff2a44-bc29-444c-0992-08ddf03b6688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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

In case of ENV_INVALID (uninitialized variables) the first env location
should be used for storing variables.
That's why change the logic how env_valid is setup to be aligned with
offset calculation.
This will also fix the print about Valid environment is showing proper
location where variables are saved for the first time.
And also fixes behavior where the first two writes were going to the
first location instead of the first to the first location and second to
second location.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Simplify commit message

Origin commit message with more technical details.

When both location for variables are not valid (or empty) gd->env_valid is
0 (ENV_INVALID) which is setup by
env_sf_load()/env_import_redund()/env_check_redund() calls.

When saveenv is called in case of SPI env_sf_save() is called which
contains logic which describes new/old variable locations.

if (gd->env_valid == ENV_VALID) {
        env_new_offset = CONFIG_ENV_OFFSET_REDUND;
        env_offset = CONFIG_ENV_OFFSET;
} else {
        env_new_offset = CONFIG_ENV_OFFSET;
        env_offset = CONFIG_ENV_OFFSET_REDUND;
}

In case of ENV_INVALID option the first location is used (else part)
and variables are saved with ENV_REDUND_ACTIVE flag.
The second location flag is rewritten to ENV_REDUND_OBSOLETE.

And
gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
but that's not correct because the first location has been written and not
the second one.
That is confirmed by
printf("Valid environment: %d\n", (int)gd->env_valid);
which is showing number 2 (ENV_REDUND).

That's why change the logic how env_valid is setup to be aligned with
offset calculation which also cover the case where initial state is
ENV_INVALID.
Then print about Valid environment is showing proper location where
variables are saved for the first time.
But also it is fixing behavior where the first two writes are going to the
first location instead of the first to the first location and second to
second location. Alternation is happening after it.

v1: https://lore.kernel.org/r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
---
 env/sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/sf.c b/env/sf.c
index 0b70e18b9afa..0e27a020643e 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -148,7 +148,7 @@ static int env_sf_save(void)
 
 	puts("done\n");
 
-	gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
+	gd->env_valid = gd->env_valid == ENV_VALID ? ENV_REDUND : ENV_VALID;
 
 	printf("Valid environment: %d\n", (int)gd->env_valid);
 
-- 
2.43.0

base-commit: 354392a63cf18523a6714d3b486e68dd92ba2ca7
branch: debian-sent3
