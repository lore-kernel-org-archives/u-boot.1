Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EDAFD2D97
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C90784010;
	Tue, 10 Mar 2026 14:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RtX3RCwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03EF84035; Tue, 10 Mar 2026 14:50:30 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB7283FEE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 14:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rA+LsvVN3pdpQ6M3joXENBcrotaQky5LswTcuVJOhhwC2lHIL4ZlLfkLKYsb+c6XUauCGOZhzmihK86tmhgXC0xSPWi1EhJwz2yeiHlXdCjTapcKI1ZWuA1q9S7hLHnribtnbAmuFgNsuNcW8O5N8QrrkErAd139bU+XvvXHYtE4TK+yCWl6rNqOlqe5XQYNhneWkSrZgZrCo3+nnSZzPidDZHbZIqZKBjq9ABQ8wF0v96furAD2XYLJSyjlVSK9/MSv5nx9reiOoV0E9swNzhi9NoagI6hHVElwTrv4Zhar5UfOYbDBV4RJyItb2WRqLLd1pwejqgh50wetZw4zVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEe2HDY188smgJQLi+c+XH8At26R1NKU/6ajDz2Qr4M=;
 b=tjOwyXeIJyUADxE/qL3FGl+2B1Uek+ELNeU520zNf+J/L1jejTf1aACsvputFzd+4BxU6KVmG5L9NRsswnrIzmU83GIyu5QKDJU4hzrjAAQowjjDSubwUeN0r/GG5/gcBlZZ0HnIU6PaIshidKWskix5E3SWq0pNz6eoHYQliyLpbm2NBVXdQStn4NsFLUHhH9W2VxypN+EA0AifThQwmk9J9AJYU1wSjuEvvyCw3GJ0ZmbuuJBW64EXQTGVu193Uv5XMfO1QZW7RXKf9pP/fwJag/RZb9QltNloGJSoLWAZtDosAcl3X/yzQxbiKt33YLgBpHpafcHXJqSb5tBFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEe2HDY188smgJQLi+c+XH8At26R1NKU/6ajDz2Qr4M=;
 b=RtX3RCwzjyFYUwfxNRr+1V9B2+qbOIAvIH7v844PqbzWsoZZrWzkncSZl177B0iCvJsHVJc2g8ovbVbV50zzBND/oJsTq3uVwT6tlh/8FLD++eOU8x2n0teTb0bFlI71xDfyap3RlrosqYA4ebWS72STf57tvcgWNH9EzJnY0NU=
Received: from BYAPR08CA0031.namprd08.prod.outlook.com (2603:10b6:a03:100::44)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 13:50:24 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::69) by BYAPR08CA0031.outlook.office365.com
 (2603:10b6:a03:100::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 13:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 13:50:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 08:50:12 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 08:50:11 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
Date: Tue, 10 Mar 2026 14:50:05 +0100
Message-ID: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=cYy2tWjOX/rD6pUrHemWprlleYMhcybauNSahzqoskk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRuUOxr4r7cwKdWG3X6zK/NkrKrVYydb1o/FHl6pmV9Q
 8m8NlvHjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjI30+MDL8+KIi8nyB7YJZU
 0tXmkzkH986Y/ZHx4AaP3z+Uv+/68fY9w/+0a+575+9+UbLtzecEV93cLvZjZslHVL/c9Vfktn9
 8TpMJAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: d26de929-4b49-4d7c-5e8d-08de7eabfa3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: b9oOmrsrPoYMjEo3Sf+nn3xQ+pFRmmM7Rb/+0FDo6LVb44zRk3hR+ZaDxp6RXRKgwySw0JZBJyJB+6UBsjApBcp3hOwq8l7YYHgjZTsBBDG0XwiVWgX4TlcY3PxxVKVTbJlXpB17W4dPQWYKBxCtvBi7SI8kiUOnehxgEkLGHLdmSatnGl0ghDX23fqvSvDvRojVVqlumUMdFror736jqhddwoBJtoWQNgTljY4cmQD3MtKCgJk+xwk0kACPrMxoAC6hzechGc9Rc6gyYkIL3ekrOAe6vHZG8WyNhbcPcWU1fvPoLJuTGqC1XYouWyu/IQ1mqeTR78EaT3ZAFJn7wV558uZU7IwKJixpBt/o0O0Ycex0m+DtrobGE1M92spmmcfEayzCeZsmVFUuLLm0tzy6MKQE4i6M34rBTo3muFBg2pHsXrnkczmpiNhFi0rZiyyaudjkR3eMSmlDdg8JTpNoOvAiPISQGsJ8YKj7En2WI9bph7Csi8lqTv+Af5ZQKgXqKTvPtEF5I2heLfzZc3+NuvZ40Rp9TnWtYh+460YlXPDq6mvgMN6RHiUy+cc9/7egkK8c2KaHPqPLMdXvE35QolnS3aofHNiguEeJd8zgzU3vDSzmguhVIDu1ilNoP13C4VIe5Ghx68h+meIf8lImJWORmRyi1D8fjsjm9fRhhK8snDKn5Oc0NWy0sOtE/lJCaYxjVAq2fTUR72KYqcpTM0i/F//Gb8Nj/AUlogxZtlXksGp2SJBW+tKA6dIuiY+oVnNxEGOcoYI75S77tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MZ3OfdjjbIrZmi1kYcNCXRFv2t5PtDXAwowxaoNtEqeUe1MyogGhqxc1Wd6K/iJDRzvXLLoeC5mxOD717Zlf5lqOnHFIXruEzdnGhGGqC9AHlFgDbWSUygbox4Af5FuBJKpsJCrtvA266TZd4z+AeCI7FaaatM+youUFaoy/3vtVZo9s3zBWs/Z71Mc2phhfmtmUH17AjJCehJvLHk+cU/zapz+igVg+Pu/ZDKKOBkMUHCajS6HHqVy8lzaK95MVbjlpuWgm0egJVDbW9jwV8wVA3sfC8yjZdTQnK94h0XxX0hPVX85S4BXDjkUKg18CaDwcVwZlNFlOtm94X5osgyz3mYrlc92qYTaWWbYIVMo2iYr67XmqmsV4Td04gDY1UPeEK5UiRvhN/1sVfnZRbgqaBGhY/Kp8LGcsQGfBt/QbotSZRXaPD+lD3q6Pay7l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 13:50:23.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26de929-4b49-4d7c-5e8d-08de7eabfa3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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

Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
introduced efi_console_set_ansi() to suppress ANSI escape sequences
during unit tests. Extend this mechanism to be runtime-configurable via
the 'no_ansi' U-Boot environment variable.

When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
at the start of efi_setup_console_size(). This prevents
query_console_serial() from sending ANSI escape sequences to the
terminal, using default 25x80 dimensions instead. This is useful for
platforms where the serial console cannot handle ANSI queries.

The variable is read using env_get_yesno() which accepts standard
boolean values (yes/y/1/true/t).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/efi_loader/efi_console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 068d1a0a7b74..737c2331b56c 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -365,6 +365,9 @@ void efi_setup_console_size(void)
 	int rows = 25, cols = 80;
 	int ret = -ENODEV;
 
+	if (env_get_yesno("no_ansi") == 1)
+		efi_console_set_ansi(false);
+
 	if (IS_ENABLED(CONFIG_VIDEO))
 		ret = query_vidconsole(&rows, &cols);
 	if (ret) {
-- 
2.43.0

base-commit: f74b8c2aeaf8d14565abff8f6a59625c543169ee
branch: debian-sent3
