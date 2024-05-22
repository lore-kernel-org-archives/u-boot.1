Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF69C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 13:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB4287FC7;
	Wed, 22 May 2024 15:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0qa/q5av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C06E882DA; Wed, 22 May 2024 15:15:30 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F1387FBC
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 15:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsUsD4n0/v1s6/3q5yImQhL/CdtTDHvYUJdVtHE2cSAfun83YTzbPbPlFem7wR1KDH5Fx/RJZpajonXV5J1rZieiVGwTheYjMyFAh+U/uq6WYYRYjmsZaz4lpUyc199NRitwbI+3/mVKMWctGMVGv8rV3/xzIA+QmkiP09x3naLEy/mPxnxBAvT+HEXc+3oFwplFHxB7GRjms5WEoub35y7Q476FrXFPsNDsz1J4vsKFUV4ZK+fdkxPrIEB9yRt8s3aL0buwpXPxVexoNnl57Fw1Z4PNM4ROWJ5x9qxQH0/27C9H+ombzBQL7iTywcmTbuRSah47K2fSstHtYMh8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UPdacQQYvuFa/Gujypv3fjUYAo+WwL5MAp0sNkmS1A=;
 b=dwyCh8xm6yemQ6hvYAzAXKKReDqYSOxEyRVXrEVAdYu0eU7KrfFitloCDSemM9amQ/uau34kmDAOOOO5PL0bZGrQkY1yMfqQGanbdvqz/0eTOAdvKB/0K517lSqEBXGLg03SG4lFgkzFuWvPAqurEGQEgs49x2JClmRQNrGaSu8GLWlT6LJe7iNcw5ffdr+c4IBaN75XXiI1EcM+/I6IVRhioekIUbx1VnK/E5iJp+FJFRbCCVNQsHrptihpmbXK8TJpA4juipEq40hfkL2LtyOTTwGapA70TRJ0jxmEStE9Ar80OM7X3LFYzpgt1jAP7+3hFBadgfXRTWhCcEEjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UPdacQQYvuFa/Gujypv3fjUYAo+WwL5MAp0sNkmS1A=;
 b=0qa/q5avpg5Nf7sUwrBvZlsdyf1MRjml4aa7zbIqU2nLPOtwfZ66mVo5aTzlzQTL4rfChbB0PCfXk7rd78bqdMBUWYM9D4w7LvH6QrNPbi6QL+02FZIByksbb/VrQl4GjksnWQbkH9x1uu6SyvDGeHlHUwbvehzG+u9dy0eODP0=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 13:15:23 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::ae) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Wed, 22 May 2024 13:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 13:15:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 08:15:21 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 22 May 2024 08:15:19 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <swarren@nvidia.com>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: Add support to enable check for bad pattern
Date: Wed, 22 May 2024 18:45:13 +0530
Message-ID: <60e9180b7eba8f97410a320d9ac69101479991d3.1716383488.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eca80ec-a399-4eec-ad48-08dc7a613cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QDK5SDvDhL9qayp7Nq3LD7eYxdcd+D+oSjPbArauZHyvbGFnNkQCaqJU+jtp?=
 =?us-ascii?Q?ExRgNsH3qsF3rwG5zKh8mg6LJ4sOfr4t464qaGRIrp0fgweMHWSdiKn0FxU5?=
 =?us-ascii?Q?rj7NCzrJfQ+IzH1DtZsOk7TRbeosrxO5ws36aTwT5Yw5dBUMB8fWVYyeuris?=
 =?us-ascii?Q?QkhkNgRYKXbVYBP2jM+DhsnJh5hJp4xm/fcS18F2Uc/Lm3N3zA5dpdd2E4TW?=
 =?us-ascii?Q?X0EAx0mrXwaMuDWlyVmcPzYhVBaryWplaxbvPBqNEFD/VEPq6vLck+59wkJj?=
 =?us-ascii?Q?SwLQtz1pEDSjG2v1OVTIoVQJv+bhdLJ9sGWLVg/aQKWCmySUOc5qSlmj6rXl?=
 =?us-ascii?Q?sXS2d2Rhf2ZX/ZX5MWHcYTyORWJ881NIFSSn50Xj2PM1ouexEn6iGWgyPFjG?=
 =?us-ascii?Q?W39qIBHhSwGk0HH4D5irqO6qFWSNwa/4cANV62uyK4h1z7Ll+oWAjdayWeMk?=
 =?us-ascii?Q?LhdSQMfBQtmB/EPjTeL3cMY8fJLtIm69GiVL7GDiVSniyjEyC+c/2k9oqU7J?=
 =?us-ascii?Q?HkoKgDEVPXf9U6B6lXO1MfAJ3tdgoTmrwFix0A/pp+94fz19/VtgdN3W346k?=
 =?us-ascii?Q?cCjUGsKQypqrlREt9iUmoD6Os22YcFHq+4q1P0MyJRG70mF6CvvNARdIygjT?=
 =?us-ascii?Q?WDb8Z1UVAKNhaRV3RW0PuZf760J7QPpe1hkHA7KvSk9kRjeq7rpr+0zQ1fzG?=
 =?us-ascii?Q?xHZ2vAFKkf2aeUUvLm5o8Tn2TocP7MCIorjDgu3ix7hWYJHT9EIoWVs3E3wR?=
 =?us-ascii?Q?id9h0XZjPFjsH2PF+j6PfJj30ROnHG+ciYHteV7bOO69dfk/B9/CBUAqcyFd?=
 =?us-ascii?Q?go1lF7s6apoy1oWPAytgRkyouFSKLV61cLLiJHb/bEM4cBUSftjTklBRrqmD?=
 =?us-ascii?Q?HKGHXAuSgNq9ys8qTeFFW4iN/O3aEzfpXjXV8o5JRUoGQRtrQ5baPD9mMAoU?=
 =?us-ascii?Q?wxSNBq60Sd1xwy7Bt9Or+WRgs9wWiVnUNTYtPAT0TrqcZenV96thLiD/eEM6?=
 =?us-ascii?Q?Ls+yBIXAQsq9wajVIDDcwkDwuSoZpikCoSRfNByXjM5j0sSWB6+Mbc/e0TTH?=
 =?us-ascii?Q?L5dSoTtwY+4KwR67k3gL4z7t+xHRMigAd33UQfGYqkfahgZKdwfriX0hdEoE?=
 =?us-ascii?Q?96e4na9rTNKZ/dnXvvGobXpY4F/dQmhhfqybxtAoaBMWsh8Im4uBGPGQ7MZa?=
 =?us-ascii?Q?+4jsqocnwrvRdpW7iAhYEqruFhTS76lgID4dGLzFWS+HfyvPRhivwlHnUgIr?=
 =?us-ascii?Q?SbGejMLIx+eCLlf3HdsG+8Jo11IggWf+NsO/hcrBy5/MMCCa50Xvlp46gtkb?=
 =?us-ascii?Q?YPrpdVf4twB6bK7oq43nt8lGDYkSvg5WXsXI+4mBbjeR1rV4xF8XugP5JXRb?=
 =?us-ascii?Q?i+UgIlTq7BfJ05be7egSRIETL8sC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:15:22.7972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eca80ec-a399-4eec-ad48-08dc7a613cbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932
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

Executing a u-boot command may raise an error or extra bad pattern,
beyond the default bad patterns. Providing a way to enable the console
output error check in test.

For example, description for OS boot test:
import re
check_type = 'kernel_boot_error'
check_pattern = re.compile('ERROR -2: can't get kernel image!')
with u_boot_console.enable_check(check_type, check_pattern):
    u_boot_console.run_command('<boot command>')

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/u_boot_console_base.py | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 26b6de07f88f..2f882fb53fc5 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -57,6 +57,32 @@ class ConsoleDisableCheck(object):
         self.console.disable_check_count[self.check_type] -= 1
         self.console.eval_bad_patterns()
 
+class ConsoleEnableCheck(object):
+    """Context manager (for Python's with statement) that temporarily enables
+    the specified console output error check. This is useful when executing a
+    command that might raise an extra bad pattern, beyond the default bad
+    patterns, in order to validate that the extra bad pattern is actually
+    detected. This class is used internally by ConsoleBase::enable_check(); it
+    is not intended for direct usage."""
+
+    def __init__(self, console, check_type, check_pattern):
+        self.console = console
+        self.check_type = check_type
+        self.check_pattern = check_pattern
+
+    def __enter__(self):
+        global bad_pattern_defs
+        self.default_bad_patterns = bad_pattern_defs
+        bad_pattern_defs += ((self.check_type, self.check_pattern),)
+        self.console.disable_check_count = {pat[PAT_ID]: 0 for pat in bad_pattern_defs}
+        self.console.eval_bad_patterns()
+
+    def __exit__(self, extype, value, traceback):
+        global bad_pattern_defs
+        bad_pattern_defs = self.default_bad_patterns
+        self.console.disable_check_count = {pat[PAT_ID]: 0 for pat in bad_pattern_defs}
+        self.console.eval_bad_patterns()
+
 class ConsoleSetupTimeout(object):
     """Context manager (for Python's with statement) that temporarily sets up
     timeout for specific command. This is useful when execution time is greater
@@ -499,6 +525,24 @@ class ConsoleBase(object):
 
         return ConsoleDisableCheck(self, check_type)
 
+    def enable_check(self, check_type, check_pattern):
+        """Temporarily enable an error check of U-Boot's output.
+
+        Create a new context manager (for use with the "with" statement) which
+        temporarily enables a particular console output error check. The
+        arguments form a new element of bad_pattern_defs defined above.
+
+        Args:
+            check_type: The type of error-check or bad pattern to enable.
+            check_pattern: The regexes for text error pattern or bad pattern
+                to be checked.
+
+        Returns:
+            A context manager object.
+        """
+
+        return ConsoleEnableCheck(self, check_type, check_pattern)
+
     def temporary_timeout(self, timeout):
         """Temporarily set up different timeout for commands.
 
-- 
2.25.1

