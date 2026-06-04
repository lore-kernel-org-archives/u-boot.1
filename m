Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9456ACD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFD084879;
	Thu,  4 Jun 2026 17:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dT677+yJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4050884908; Thu,  4 Jun 2026 17:50:51 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3058284874
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrbVUXc0fRCEqdZOIvwUsIhU67/l4SoXguCRM1eu2Qehf+q+bYD1An/Qs98BsOjk5ZzAJ/vr8/lL1v24m0nwVYx+r4oTtRWAcXt17vLo3/NPH5ZFk0kDpVueBMjDLhFDaq9T0SZQls4B1Fke0hCkM23b54Ea+ItRk+noDEG7OvikDZnPqqqppor/8JQbAkKD2uJQfyvDRG/yuiy/R6n0ECy7iyHW6Pjryl1EgmQpMj2Cgsn4jVdh70JJ2MlSO6khpiYpkASrl2xwz2arBCKD/LuOO9WL00Ct2o+nEn1o2CQ3ki3poZ30MtG7kMvj1DQ5t4FaXKlRZMLVqn8PmNhCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9t4J3+hzdlETl634+lbWLM0VA66muQd3pA59y+q2M0=;
 b=mbuOUCuOBtCc8nXvFU6J5jnwU7+Y0t95YH+O1+KPlDN3NM4JEG+vBknYyvndjzgMFNvLRXn5MVho1ZhdTlUPH4+85uWLbvkbrwtCfSywSDhkrQR8RPeSI7LihNZxrcdUDTeyGNABLr3OT6qf+fqxhV1r6dfWarQI/4UdnbPf63Mg6/+92ijNX0ri90FCxiIUFmk2J6rl9neQXkBL9zBzI4DveMazahXUNeMBzyZNSSOCjA3yA7F6GEMaHpIhyJqVufLv9J02OZQydVJ+s4oEsEqLh4SC9G2az8EPBCR1iIaaSSHgZ41hny8We8iYxvVUe4CxkUt4Ry6sCCAq6m0Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9t4J3+hzdlETl634+lbWLM0VA66muQd3pA59y+q2M0=;
 b=dT677+yJjYt1utuIF7GaMVCJLx5OOr1SDuPDXaziEaAPs2J91zvU21ngADTW7J3/aBGtCEcW+7hvXsoREdScjRW33ye07oB/+JS0TdJVoM0tf28DdwpP+/yyICOeg4sdMpmPJ+2vfFx0m6v+mEzT6DZEDFS2wVzoMCS6d0t3JAo=
Received: from BN9PR03CA0549.namprd03.prod.outlook.com (2603:10b6:408:138::14)
 by IA3PR10MB8467.namprd10.prod.outlook.com (2603:10b6:208:582::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Thu, 4 Jun 2026
 15:50:44 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::89) by BN9PR03CA0549.outlook.office365.com
 (2603:10b6:408:138::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 15:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 15:50:43 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:43 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 10:50:42 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654FogOt017019;
 Thu, 4 Jun 2026 10:50:42 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv10 2/4] test_ut: add a ut_ubman fixture to clean up tests
Date: Thu, 4 Jun 2026 10:50:36 -0500
Message-ID: <20260604155038.3182-3-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604155038.3182-1-rs@ti.com>
References: <20260604155038.3182-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|IA3PR10MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b029664-e35e-4642-9a90-08dec2510940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|6133799003|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8bhom6OEQ637rQv4qg/GtyheSQnuEzBUzHEtFsvGRfsaVMZXhzCmXrASiIv7xfxtzrN9N7vXCBxVO5Y6kbtrR7vG8+mYazzyqs7wHPg0+1tZmTQ1P9tOYVp178oImY4Z0+zYHqJ8X5uOVZ5vGfUs5MI8sloMW5bDFRyIkZjGOaZ6zyXepwwjwijRb679bOHQVJVf5U1nQI/N3iGejPmHXE99o+8u/8OlqpZizJx8hL+NpQKwnh4hJHrCq0NOyUezwZrBq6lXAiYCcVyvLgF2DiydnRqleRNYvqvDTQasgsWa3IySVG1UK3DpupGL/7GbfYbMIhJtqiRc3g36G+1wSsyH9pp56txxEcnoH1Bwedj5V3g9k1u7WHJwf/riPVgPK6N0hGL4hQ9NEMxnkTptA8SJ/LQy1pfGv7n+ECI22LLTkkSMc8BoZkY8SiFkIDMygoOp3BE3d7v39pWT9GfcgBlMlBPzYG71l9AZVdGILZk6Y7WjpoNIqWKYzqbItphKz1Y0+B7R7ivoJFkqziX5JmgUlYb6WPKV/2GNqhvlCoGQBulrymW0MhdlNYN9IuvWglLyJF41zuZYMUjki0akJaAuW945jCK0zIiBKi2MPf2mEr3SpVYS9YwaANkTMTJVyYSbNJshVxkjnofqK5kSUEVtEQoqfquiUa/csoKzYXZRt+ZUOzNO26Q8ilkXB2RK/I9Yeb6e/iOfqqQc2YL2+qUNSss2Zy9NUz5EldXcsFGsjHa+6wLqIdfSFkEqZqgH0LSa4qrlJFzl7f4o5yPv6w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cOMPy0HRnZ3dVJzDfiv6gzuWq7xr2k7YKoyJVmgGVal7o7E5HZx6P/s7ps7IpIlHfW7Rbj5FJ6WFQK6xWifiTG5nJCRe8EfmIphwslpe8fJpr4OloJU3N6gUoxbqkAtu2rKZaIMf7RvatFX2M3mNuhwhQ5eFJcutNCW+lbvV/YY3kBrg0VJ5c6tgjAkydf2ZRLnOCqrETrvnPABTIM/DTCRmMLA9nif4aTCqYL9Fed4NsUvliCpu1vpLTV3GBv9pQs4SVsT7BE8CM4eM95QKIhqU0tx/9Noglvp5nbfhWG9/k86IB9RAaDdokbU+V91+U1pS5TodMuM/gQmJhrDgFjYMTZGQArffnpeoflkrnj2qW1tTmei+EZju7IQ+lLLn1DdBYB8PiCnmhXX7I6xiPi4e8JTl4a0R0tbpGNENShIXiMGxOj3X57jQsVlBZMPb
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:50:43.5422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b029664-e35e-4642-9a90-08dec2510940
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8467
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

From: Randolph Sapp <rs@ti.com>

Add a ut_ubman fixture to clean up after certain problematic tests
without negatively affecting the current assert based testing.

Currently this catches "bootstd bootflow_cmd_boot" and "bootstd
bootflow_scan_boot" ut_subtests, as these will change the sandbox state
a little too much to be recoverable from.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
v10:
	- Init
---
 test/py/tests/test_ut.py | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index dce5a37dd35..fa50c8008a5 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -631,7 +631,23 @@ def test_ut_dm_init_bootstd(ubman):
     ubman.restart_uboot()
 
 
-def test_ut(ubman, ut_subtest):
+@pytest.fixture(name="ut_ubman")
+def ut_ubman_fixture(ubman, ut_subtest):
+    """Fixture to restart the sandbox after known problematic tests.
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        ut_subtest (str): test to be executed via command ut, e.g 'foo bar' to
+            execute command 'ut foo bar'
+    """
+
+    yield ubman
+
+    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_scan_boot"):
+        ubman.restart_uboot()
+
+
+def test_ut(ut_ubman, ut_subtest):
     """Execute a "ut" subtest.
 
     The subtests are collected in function generate_ut_subtest() from linker
@@ -644,18 +660,18 @@ def test_ut(ubman, ut_subtest):
     implemented in C function foo_test_bar().
 
     Args:
-        ubman (ConsoleBase): U-Boot console
+        ut_ubman (ConsoleBase): U-Boot console
         ut_subtest (str): test to be executed via command ut, e.g 'foo bar' to
             execute command 'ut foo bar'
     """
 
     if ut_subtest == 'hush hush_test_simple_dollar':
         # ut hush hush_test_simple_dollar prints "Unknown command" on purpose.
-        with ubman.disable_check('unknown_command'):
-            output = ubman.run_command('ut ' + ut_subtest)
+        with ut_ubman.disable_check('unknown_command'):
+            output = ut_ubman.run_command('ut ' + ut_subtest)
         assert 'Unknown command \'quux\' - try \'help\'' in output
     else:
-        output = ubman.run_command('ut ' + ut_subtest)
+        output = ut_ubman.run_command('ut ' + ut_subtest)
     assert output.endswith('failures: 0')
     lastline = output.splitlines()[-1]
     if "skipped: 0," not in lastline:
-- 
2.54.0

