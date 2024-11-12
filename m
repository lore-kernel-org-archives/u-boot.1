Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3296CD41D6F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B6A8942C;
	Tue, 12 Nov 2024 09:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U3NzEXqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D52F89431; Tue, 12 Nov 2024 09:58:13 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E873C891B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwVjlbInsTM+/69N0MyZs2yPZEmVT/pIVDYFNVIqwZxDIUZkdM28Wy4z+8a1ok5/Jn4asbxOnlhFFHYepBVjnHjWd7OH7HIkoCq5eesoA7brHjJL1NltKmi2VOFGiXX2i7EyT/sxC/hJxqdYYCPb9tC6giqPC4JqCLbXMccrC/qKsEqblkay7Z9JnbifVMrS1PcziI+5apGUauQaJu45OYP6reoLjqFyxsUVrc9NMsyYJAacVD52fLZNYnplnAai8ZvV3W8K6IQ7fr4xdsSGsGZzrRJ0MhxkP4LJg1/0ITJjF1xjjbK1NyLEqx0a69UGY8mKV8Upn1q+E/z/hGG7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kr88tPGmcdQuWpjsENhdCtlotX2I4wrfluKFKe+1Mo=;
 b=y5m4N+txxCWVcV7Azn4O5XxLCB2tttv+XPs1nOf1aAJk5SPLM3yLytvof55GRXNiDknphtZ9TDzrZhNjWUKzNYHRhdW+wl6hOG6FK/WJZQARJw7NOt6kWNIxJoJDwY3aCMX65lXTBBdBje2oc6NDg5bLFRsA7vPXgGgfxUEmprDCNAVHt7AS5vlZ2KBiJapokiDUIwwAAtqNiyTJ11N+6XRPJoZmC5+PhlIhQNrqN0/voo6NjIG6kT8ZDcZBOOxwFmTvQ0vBDjIoOHqIZHz7rJjd+53OpStkcr0meRdFmXA1N4XOMguMc1TdhJtPu9oCbZMiF2wSQo+VSTiZd6Qymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kr88tPGmcdQuWpjsENhdCtlotX2I4wrfluKFKe+1Mo=;
 b=U3NzEXqge1X+Utt8z1bWX2KPF9sYAsnHvbSVlVGtHV2+x/7f/7g0LyCbC8qA2/fQylGzT2N3B/k38RHVTh/dbSEahL/54Yy2qmqVmmYehbj+315PtijVZFmPcupfO/fWtzKdN5YDMYvY9PnosC9VEBshfNcrHcreK/qiUBIGjvI=
Received: from BL1PR13CA0432.namprd13.prod.outlook.com (2603:10b6:208:2c3::17)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 08:58:00 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::2d) by BL1PR13CA0432.outlook.office365.com
 (2603:10b6:208:2c3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14 via Frontend
 Transport; Tue, 12 Nov 2024 08:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:58:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:57:58 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:57:57 -0600
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: mmc: Add support for different mmc modes
Date: Tue, 12 Nov 2024 14:27:56 +0530
Message-ID: <885b2f4019dd9a4d76a6ed9b8393bd99bf813392.1731401816.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dda19c-b4d2-4ce9-1e76-08dd02f81c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?79JQ8vIgyHaJN416eszZByupxWNnX0GVZuR9ricKU4yboMc0kXCioJX3uOiv?=
 =?us-ascii?Q?jPFmUN/NS/lhIvB0ssqkXI/hd5uk7v9nP8mhCft34uOUVg4jm5pGncm18wq6?=
 =?us-ascii?Q?s/UPrT9WiNuf8Cm0EIowG8C/83+9mvvLnauAmG0TiMvR3bEfJxYNnd5hAlk7?=
 =?us-ascii?Q?IBBLvB0fuaFwwdxwR5zUNY3109a8nd3HEMrTE/nMyioFsK8gyPyaccnoGq3d?=
 =?us-ascii?Q?xi7A4U8C3YKeZZ00JnEHh64JXri72T8VukqZXy4/o5cE9gzL4AD+hhk6A2lA?=
 =?us-ascii?Q?L9LCQ7XAXHcnlPdKtLXJsRAsg14X1Y874jBKXrY8zOPbVm0SNiDEfcKo1t0E?=
 =?us-ascii?Q?Pib9acuAEPTmlZQbM9/zWv6wInDjK81Ntt/xYKFNXNtrSooNfLvHpPKrsVaE?=
 =?us-ascii?Q?aZEHD0+DprnsmiCxjxWpHLZZUNflab7cAU0gWzOgheUYAiroZimylOPUQk08?=
 =?us-ascii?Q?+eV0pdzQs5seQPp8mmdkRWZ7LoSLwwDa9hTTP2cGI1TQ/mI94LqwFwe/KS21?=
 =?us-ascii?Q?Pla8XJfcMRCkAwcurD+9k2V6HSANwtmqpF8pC3ujXLPHRtC2mqfyZzdp/X28?=
 =?us-ascii?Q?JJkeZydutPD8Pcz5YtyxSdcLDGdI0RAb32n8Hb/knmc/QKl2Kiu6nyutzZ1Q?=
 =?us-ascii?Q?2F+SOUtlndnhL38A5FYfdwsphGO9yO3WaS53EFRneKxchYqHRceAhyOPVZCq?=
 =?us-ascii?Q?tB0sINUipNzFigG2YLCvaW9YqNj39WapUg9PtIM1fWPfUwG2tIkgrPD7JqsL?=
 =?us-ascii?Q?Wx/9WuGdudUWEnPEEJNfdxY5iYWWkMXceHwS/aBJ1Wr4Edoi/9yUCAmo4COF?=
 =?us-ascii?Q?7/LGrb0T9VPaDyeP53lco0IBZtIFRd+WUEQ5ISBwk+rERGByNemLmFsSM2ZU?=
 =?us-ascii?Q?jjJRdgUKNdbugnauWuO5/297tA+gaDdofn40H9ua4KJdyHIC7iHEYvbKGBsJ?=
 =?us-ascii?Q?wJw54knIHcold2MDXVQ1LQGToZP1JH31Q3bt7H14aYnuADlvaKqEs86PZ/0L?=
 =?us-ascii?Q?DrB6PtJy8GJh6gnmUCT+4sig2r84ZW+AVJmPPefrvx1Jnf/Yni9ZY3z0PAvy?=
 =?us-ascii?Q?wE6YiyruNhTXyRaAF8aTkLMiRqzYTjGO/hfG4tVnBdMgxVZM7cO6ZOk6OYwg?=
 =?us-ascii?Q?0I33yC6mnXnBJMEreUZ81Zkgo/cC6ALWFxGLeFcJvgkZNEY2/NJ8KNyy9i9t?=
 =?us-ascii?Q?ZE9QwGShkS9aeT8kLaEeYdK+aHKPYQ5MrlwdaIsRT37wZpqIYICHfRZGyssA?=
 =?us-ascii?Q?5Q8EMZxNi4lTJtGr3bpw9JreVSE/iShazufEAHY8iSqy2jKl2e3TM4vDjTne?=
 =?us-ascii?Q?I3QQdXTSDTGHwGKaYHuCOMg4j8UgVJMRbTCNDq/NO4Gx4A8qpGg5MW1h2xOo?=
 =?us-ascii?Q?WjD+tsPdhl7q3WxIvcJMxSmRuRp7oSehsSuDF066r4wxGKVu5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:58:00.2865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dda19c-b4d2-4ce9-1e76-08dd02f81c20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

Currently, MMC test runs on default mmc modes, adding a provision to
support multiple mmc modes through user defined parameters.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_mmc.py | 608 +++++++++++++++++++++-----------------
 1 file changed, 335 insertions(+), 273 deletions(-)

diff --git a/test/py/tests/test_mmc.py b/test/py/tests/test_mmc.py
index 1193f4a95737..462404338844 100644
--- a/test/py/tests/test_mmc.py
+++ b/test/py/tests/test_mmc.py
@@ -18,16 +18,55 @@ For example:
 # Setup env__mmc_device_test_skip to not skipping the test. By default, its
 # value is set to True. Set it to False to run all tests for MMC device.
 env__mmc_device_test_skip = False
+
+# Setup env__mmc_device to set the supported mmc modes to be tested
+env__mmc_device {
+    'mmc_modes': ['MMC_LEGACY', 'SD_HS'],
+}
+
 """
 
 mmc_set_up = False
 controllers = 0
 devices = {}
+mmc_modes_name = []
+mmc_modes = []
+
+def setup_mmc_modes(cons):
+    global mmc_modes, mmc_modes_name
+    f = cons.config.env.get('env__mmc_device', None)
+    if f:
+        mmc_modes_name = f.get('mmc_modes', None)
+
+    # Set mmc mode to default mode (legacy), if speed mode config isn't enabled
+    if cons.config.buildconfig.get('config_mmc_speed_mode_set', 'n') != 'y':
+        mmc_modes = [0]
+        return
+
+    if mmc_modes_name:
+        mmc_help = cons.run_command('mmc -help')
+        m = re.search(r"\[MMC_LEGACY(.*\n.+])", mmc_help)
+        modes = [
+            x.strip()
+            for x in m.group()
+            .replace('\n', '')
+            .replace('[', '')
+            .replace(']', '')
+            .split(',')
+        ]
+
+        for mode in mmc_modes_name:
+            mmc_modes += [modes.index(mode)]
+    else:
+        # Set mmc mode to default mode (legacy), if it is not defined in env
+        mmc_modes = [0]
 
 def setup_mmc(u_boot_console):
     if u_boot_console.config.env.get('env__mmc_device_test_skip', True):
         pytest.skip('MMC device test is not enabled')
 
+    setup_mmc_modes(u_boot_console)
+
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_mmc_list(u_boot_console):
     setup_mmc(u_boot_console)
@@ -58,21 +97,22 @@ def test_mmc_dev(u_boot_console):
     fail = 0
     for x in range(0, controllers):
         devices[x]['detected'] = 'yes'
-        output = u_boot_console.run_command('mmc dev %d' % x)
 
-        # Some sort of switch here
-        if 'Card did not respond to voltage select' in output:
-            fail = 1
-            devices[x]['detected'] = 'no'
+        for y in mmc_modes:
+            output = u_boot_console.run_command('mmc dev %d 0 %d' % x, y)
 
-        if 'no mmc device at slot' in output:
-            devices[x]['detected'] = 'no'
+            if 'Card did not respond to voltage select' in output:
+                fail = 1
+                devices[x]['detected'] = 'no'
 
-        if 'MMC: no card present' in output:
-            devices[x]['detected'] = 'no'
+            if 'no mmc device at slot' in output:
+                devices[x]['detected'] = 'no'
 
-    if fail:
-        pytest.fail('Card not present')
+            if 'MMC: no card present' in output:
+                devices[x]['detected'] = 'no'
+
+        if fail:
+            pytest.fail('Card not present')
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_mmcinfo(u_boot_console):
@@ -81,19 +121,22 @@ def test_mmcinfo(u_boot_console):
 
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
-            output = u_boot_console.run_command('mmcinfo')
-            if 'busy timeout' in output:
-                pytest.skip('No SD/MMC/eMMC device present')
+            for y in mmc_modes:
+                u_boot_console.run_command('mmc dev %d 0 %d' % x, y)
+                output = u_boot_console.run_command('mmcinfo')
+                if 'busy timeout' in output:
+                    pytest.skip('No SD/MMC/eMMC device present')
 
-            obj = re.search(r'Capacity: (\d+|\d+[\.]?\d)', output)
-            try:
-                capacity = float(obj.groups()[0])
-                print(capacity)
-                devices[x]['capacity'] = capacity
-                print('Capacity of dev %d is: %g GiB' % (x, capacity))
-            except ValueError:
-                pytest.fail('MMC capacity not recognized')
+                assert mmc_modes_name[mmc_modes.index(y)] in output
+
+                obj = re.search(r'Capacity: (\d+|\d+[\.]?\d)', output)
+                try:
+                    capacity = float(obj.groups()[0])
+                    print(capacity)
+                    devices[x]['capacity'] = capacity
+                    print('Capacity of dev %d is: %g GiB' % (x, capacity))
+                except ValueError:
+                    pytest.fail('MMC capacity not recognized')
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_mmc_info(u_boot_console):
@@ -102,19 +145,21 @@ def test_mmc_info(u_boot_console):
 
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
+            for y in mmc_modes:
+                u_boot_console.run_command('mmc dev %d 0 %d' % x, y)
 
-            output = u_boot_console.run_command('mmc info')
+                output = u_boot_console.run_command('mmc info')
+                assert mmc_modes_name[mmc_modes.index(y)] in output
 
-            obj = re.search(r'Capacity: (\d+|\d+[\.]?\d)', output)
-            try:
-                capacity = float(obj.groups()[0])
-                print(capacity)
-                if devices[x]['capacity'] != capacity:
-                    pytest.fail("MMC capacity doesn't match mmcinfo")
+                obj = re.search(r'Capacity: (\d+|\d+[\.]?\d)', output)
+                try:
+                    capacity = float(obj.groups()[0])
+                    print(capacity)
+                    if devices[x]['capacity'] != capacity:
+                        pytest.fail("MMC capacity doesn't match mmcinfo")
 
-            except ValueError:
-                pytest.fail('MMC capacity not recognized')
+                except ValueError:
+                    pytest.fail('MMC capacity not recognized')
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_mmc_rescan(u_boot_console):
@@ -126,12 +171,13 @@ def test_mmc_rescan(u_boot_console):
 
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
-            output = u_boot_console.run_command('mmc rescan')
-            if output:
-                pytest.fail('mmc rescan has something to check')
-            output = u_boot_console.run_command('echo $?')
-            assert output.endswith('0')
+            for y in mmc_modes:
+                u_boot_console.run_command('mmc dev %d 0 %d' % x, y)
+                output = u_boot_console.run_command('mmc rescan')
+                if output:
+                    pytest.fail('mmc rescan has something to check')
+                output = u_boot_console.run_command('echo $?')
+                assert output.endswith('0')
 
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_mmc_part(u_boot_console):
@@ -192,7 +238,6 @@ def test_mmc_fatls_fatinfo(u_boot_console):
     fs = 'fat'
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -200,20 +245,22 @@ def test_mmc_fatls_fatinfo(u_boot_console):
                 continue
 
             for part in partitions:
-                output = u_boot_console.run_command(
-                        'fatls mmc %d:%s' % (x, part))
-                if 'Unrecognized filesystem type' in output:
-                    partitions.remove(part)
-                    pytest.fail('Unrecognized filesystem')
-
-                if not re.search(r'\d file\(s\), \d dir\(s\)', output):
-                    pytest.fail('%s read failed on device %d' % (fs.upper, x))
-                output = u_boot_console.run_command(
-                        'fatinfo mmc %d:%s' % (x, part))
-                string = 'Filesystem: %s' % fs.upper
-                if re.search(string, output):
-                    pytest.fail('%s FS failed on device %d' % (fs.upper(), x))
-                part_detect = 1
+                for y in mmc_modes:
+                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    output = u_boot_console.run_command(
+                            'fatls mmc %d:%s' % (x, part))
+                    if 'Unrecognized filesystem type' in output:
+                        partitions.remove(part)
+                        pytest.fail('Unrecognized filesystem')
+
+                    if not re.search(r'\d file\(s\), \d dir\(s\)', output):
+                        pytest.fail('%s read failed on device %d' % (fs.upper, x))
+                    output = u_boot_console.run_command(
+                            'fatinfo mmc %d:%s' % (x, part))
+                    string = 'Filesystem: %s' % fs.upper
+                    if re.search(string, output):
+                        pytest.fail('%s FS failed on device %d' % (fs.upper(), x))
+                    part_detect = 1
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
@@ -233,7 +280,6 @@ def test_mmc_fatload_fatwrite(u_boot_console):
     fs = 'fat'
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -241,49 +287,51 @@ def test_mmc_fatload_fatwrite(u_boot_console):
                 continue
 
             for part in partitions:
-                part_detect = 1
-                addr = u_boot_utils.find_ram_base(u_boot_console)
-                devices[x]['addr_%d' % part] = addr
-                size = random.randint(4, 1 * 1024 * 1024)
-                devices[x]['size_%d' % part] = size
-                # count CRC32
-                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
-                m = re.search('==> (.+?)', output)
-                if not m:
-                    pytest.fail('CRC32 failed')
-                expected_crc32 = m.group(1)
-                devices[x]['expected_crc32_%d' % part] = expected_crc32
-                # do write
-                file = '%s_%d' % ('uboot_test', size)
-                devices[x]['file_%d' % part] = file
-                output = u_boot_console.run_command(
-                    '%swrite mmc %d:%s %x %s %x' % (fs, x, part, addr, file, size)
-                )
-                assert 'Unable to write' not in output
-                assert 'Error' not in output
-                assert 'overflow' not in output
-                expected_text = '%d bytes written' % size
-                assert expected_text in output
-
-                alignment = int(
-                    u_boot_console.config.buildconfig.get(
-                        'config_sys_cacheline_size', 128
+                for y in mmc_modes:
+                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    part_detect = 1
+                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    devices[x]['addr_%d' % part] = addr
+                    size = random.randint(4, 1 * 1024 * 1024)
+                    devices[x]['size_%d' % part] = size
+                    # count CRC32
+                    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                    m = re.search('==> (.+?)', output)
+                    if not m:
+                        pytest.fail('CRC32 failed')
+                    expected_crc32 = m.group(1)
+                    devices[x]['expected_crc32_%d' % part] = expected_crc32
+                    # do write
+                    file = '%s_%d' % ('uboot_test', size)
+                    devices[x]['file_%d' % part] = file
+                    output = u_boot_console.run_command(
+                        '%swrite mmc %d:%s %x %s %x' % (fs, x, part, addr, file, size)
                     )
-                )
-                offset = random.randrange(alignment, 1024, alignment)
-                output = u_boot_console.run_command(
-                    '%sload mmc %d:%s %x %s' % (fs, x, part, addr + offset, file)
-                )
-                assert 'Invalid FAT entry' not in output
-                assert 'Unable to read file' not in output
-                assert 'Misaligned buffer address' not in output
-                expected_text = '%d bytes read' % size
-                assert expected_text in output
-
-                output = u_boot_console.run_command(
-                    'crc32 %x $filesize' % (addr + offset)
-                )
-                assert expected_crc32 in output
+                    assert 'Unable to write' not in output
+                    assert 'Error' not in output
+                    assert 'overflow' not in output
+                    expected_text = '%d bytes written' % size
+                    assert expected_text in output
+
+                    alignment = int(
+                        u_boot_console.config.buildconfig.get(
+                            'config_sys_cacheline_size', 128
+                        )
+                    )
+                    offset = random.randrange(alignment, 1024, alignment)
+                    output = u_boot_console.run_command(
+                        '%sload mmc %d:%s %x %s' % (fs, x, part, addr + offset, file)
+                    )
+                    assert 'Invalid FAT entry' not in output
+                    assert 'Unable to read file' not in output
+                    assert 'Misaligned buffer address' not in output
+                    expected_text = '%d bytes read' % size
+                    assert expected_text in output
+
+                    output = u_boot_console.run_command(
+                        'crc32 %x $filesize' % (addr + offset)
+                    )
+                    assert expected_crc32 in output
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
@@ -307,13 +355,16 @@ def test_mmc_ext4ls(u_boot_console):
                 print('No %s table on this device' % fs.upper())
                 continue
 
-            u_boot_console.run_command('mmc dev %d' % x)
             for part in partitions:
-                output = u_boot_console.run_command('%sls mmc %d:%s' % (fs, x, part))
-                if 'Unrecognized filesystem type' in output:
-                    partitions.remove(part)
-                    pytest.fail('Unrecognized filesystem')
-                part_detect = 1
+                for y in mmc_modes:
+                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    output = u_boot_console.run_command(
+                        '%sls mmc %d:%s' % (fs, x, part)
+                    )
+                    if 'Unrecognized filesystem type' in output:
+                        partitions.remove(part)
+                        pytest.fail('Unrecognized filesystem')
+                    part_detect = 1
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
@@ -333,7 +384,6 @@ def test_mmc_ext4load_ext4write(u_boot_console):
     fs = 'ext4'
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -341,42 +391,44 @@ def test_mmc_ext4load_ext4write(u_boot_console):
                 continue
 
             for part in partitions:
-                part_detect = 1
-                addr = u_boot_utils.find_ram_base(u_boot_console)
-                devices[x]['addr_%d' % part] = addr
-                size = random.randint(4, 1 * 1024 * 1024)
-                devices[x]['size_%d' % part] = size
-                # count CRC32
-                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
-                m = re.search('==> (.+?)', output)
-                if not m:
-                    pytest.fail('CRC32 failed')
-                expected_crc32 = m.group(1)
-                devices[x]['expected_crc32_%d' % part] = expected_crc32
-                # do write
-
-                file = '%s_%d' % ('uboot_test', size)
-                devices[x]['file_%d' % part] = file
-                output = u_boot_console.run_command(
-                    '%swrite mmc %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
-                )
-                assert 'Unable to write' not in output
-                assert 'Error' not in output
-                assert 'overflow' not in output
-                expected_text = '%d bytes written' % size
-                assert expected_text in output
-
-                offset = random.randrange(128, 1024, 128)
-                output = u_boot_console.run_command(
-                    '%sload mmc %d:%s %x /%s' % (fs, x, part, addr + offset, file)
-                )
-                expected_text = '%d bytes read' % size
-                assert expected_text in output
-
-                output = u_boot_console.run_command(
-                    'crc32 %x $filesize' % (addr + offset)
-                )
-                assert expected_crc32 in output
+                for y in mmc_modes:
+                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    part_detect = 1
+                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    devices[x]['addr_%d' % part] = addr
+                    size = random.randint(4, 1 * 1024 * 1024)
+                    devices[x]['size_%d' % part] = size
+                    # count CRC32
+                    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+                    m = re.search('==> (.+?)', output)
+                    if not m:
+                        pytest.fail('CRC32 failed')
+                    expected_crc32 = m.group(1)
+                    devices[x]['expected_crc32_%d' % part] = expected_crc32
+
+                    # do write
+                    file = '%s_%d' % ('uboot_test', size)
+                    devices[x]['file_%d' % part] = file
+                    output = u_boot_console.run_command(
+                        '%swrite mmc %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
+                    )
+                    assert 'Unable to write' not in output
+                    assert 'Error' not in output
+                    assert 'overflow' not in output
+                    expected_text = '%d bytes written' % size
+                    assert expected_text in output
+
+                    offset = random.randrange(128, 1024, 128)
+                    output = u_boot_console.run_command(
+                        '%sload mmc %d:%s %x /%s' % (fs, x, part, addr + offset, file)
+                    )
+                    expected_text = '%d bytes read' % size
+                    assert expected_text in output
+
+                    output = u_boot_console.run_command(
+                        'crc32 %x $filesize' % (addr + offset)
+                    )
+                    assert expected_crc32 in output
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
@@ -394,7 +446,6 @@ def test_mmc_ext2ls(u_boot_console):
     fs = 'ext2'
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -402,12 +453,16 @@ def test_mmc_ext2ls(u_boot_console):
                 continue
 
             for part in partitions:
-                part_detect = 1
-                output = u_boot_console.run_command('%sls mmc %d:%s' % (fs, x, part))
-                if 'Unrecognized filesystem type' in output:
-                    partitions.remove(part)
-                    pytest.fail('Unrecognized filesystem')
-                part_detect = 1
+                for y in mmc_modes:
+                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    part_detect = 1
+                    output = u_boot_console.run_command(
+                        '%sls mmc %d:%s' % (fs, x, part)
+                    )
+                    if 'Unrecognized filesystem type' in output:
+                        partitions.remove(part)
+                        pytest.fail('Unrecognized filesystem')
+                    part_detect = 1
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
@@ -428,7 +483,6 @@ def test_mmc_ext2load(u_boot_console):
     fs = 'ext2'
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -436,23 +490,25 @@ def test_mmc_ext2load(u_boot_console):
                 continue
 
             for part in partitions:
-                part_detect = 1
-                addr = devices[x]['addr_%d' % part]
-                size = devices[x]['size_%d' % part]
-                expected_crc32 = devices[x]['expected_crc32_%d' % part]
-                file = devices[x]['file_%d' % part]
-
-                offset = random.randrange(128, 1024, 128)
-                output = u_boot_console.run_command(
-                    '%sload mmc %d:%s %x /%s' % (fs, x, part, addr + offset, file)
-                )
-                expected_text = '%d bytes read' % size
-                assert expected_text in output
-
-                output = u_boot_console.run_command(
-                    'crc32 %x $filesize' % (addr + offset)
-                )
-                assert expected_crc32 in output
+                for y in mmc_modes:
+                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    part_detect = 1
+                    addr = devices[x]['addr_%d' % part]
+                    size = devices[x]['size_%d' % part]
+                    expected_crc32 = devices[x]['expected_crc32_%d' % part]
+                    file = devices[x]['file_%d' % part]
+
+                    offset = random.randrange(128, 1024, 128)
+                    output = u_boot_console.run_command(
+                        '%sload mmc %d:%s %x /%s' % (fs, x, part, addr + offset, file)
+                    )
+                    expected_text = '%d bytes read' % size
+                    assert expected_text in output
+
+                    output = u_boot_console.run_command(
+                        'crc32 %x $filesize' % (addr + offset)
+                    )
+                    assert expected_crc32 in output
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
@@ -469,7 +525,6 @@ def test_mmc_ls(u_boot_console):
     part_detect = 0
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             for fs in ['fat', 'ext4', 'ext2']:
                 try:
                     partitions = devices[x][fs]
@@ -478,12 +533,14 @@ def test_mmc_ls(u_boot_console):
                     continue
 
                 for part in partitions:
-                    part_detect = 1
-                    output = u_boot_console.run_command('ls mmc %d:%s' % (x, part))
-                    if re.search(r'No \w+ table on this device', output):
-                        pytest.fail(
-                            '%s: Partition table not found %d' % (fs.upper(), x)
-                        )
+                    for y in mmc_modes:
+                        u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                        part_detect = 1
+                        output = u_boot_console.run_command('ls mmc %d:%s' % (x, part))
+                        if re.search(r'No \w+ table on this device', output):
+                            pytest.fail(
+                                '%s: Partition table not found %d' % (fs.upper(), x)
+                            )
 
     if not part_detect:
         pytest.skip('No partition detected')
@@ -500,7 +557,6 @@ def test_mmc_load(u_boot_console):
     part_detect = 0
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             for fs in ['fat', 'ext4', 'ext2']:
                 try:
                     partitions = devices[x][fs]
@@ -509,23 +565,25 @@ def test_mmc_load(u_boot_console):
                     continue
 
                 for part in partitions:
-                    part_detect = 1
-                    addr = devices[x]['addr_%d' % part]
-                    size = devices[x]['size_%d' % part]
-                    expected_crc32 = devices[x]['expected_crc32_%d' % part]
-                    file = devices[x]['file_%d' % part]
-
-                    offset = random.randrange(128, 1024, 128)
-                    output = u_boot_console.run_command(
-                        'load mmc %d:%s %x /%s' % (x, part, addr + offset, file)
-                    )
-                    expected_text = '%d bytes read' % size
-                    assert expected_text in output
+                    for y in mmc_modes:
+                        u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                        part_detect = 1
+                        addr = devices[x]['addr_%d' % part]
+                        size = devices[x]['size_%d' % part]
+                        expected_crc32 = devices[x]['expected_crc32_%d' % part]
+                        file = devices[x]['file_%d' % part]
+
+                        offset = random.randrange(128, 1024, 128)
+                        output = u_boot_console.run_command(
+                            'load mmc %d:%s %x /%s' % (x, part, addr + offset, file)
+                        )
+                        expected_text = '%d bytes read' % size
+                        assert expected_text in output
 
-                    output = u_boot_console.run_command(
-                        'crc32 %x $filesize' % (addr + offset)
-                    )
-                    assert expected_crc32 in output
+                        output = u_boot_console.run_command(
+                            'crc32 %x $filesize' % (addr + offset)
+                        )
+                        assert expected_crc32 in output
 
     if not part_detect:
         pytest.skip('No partition detected')
@@ -542,7 +600,6 @@ def test_mmc_save(u_boot_console):
     part_detect = 0
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             for fs in ['fat', 'ext4', 'ext2']:
                 try:
                     partitions = devices[x][fs]
@@ -551,18 +608,20 @@ def test_mmc_save(u_boot_console):
                     continue
 
                 for part in partitions:
-                    part_detect = 1
-                    addr = devices[x]['addr_%d' % part]
-                    size = 0
-                    file = devices[x]['file_%d' % part]
-
-                    offset = random.randrange(128, 1024, 128)
-                    output = u_boot_console.run_command(
-                        'save mmc %d:%s %x /%s %d'
-                        % (x, part, addr + offset, file, size)
-                    )
-                    expected_text = '%d bytes written' % size
-                    assert expected_text in output
+                    for y in mmc_modes:
+                        u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                        part_detect = 1
+                        addr = devices[x]['addr_%d' % part]
+                        size = 0
+                        file = devices[x]['file_%d' % part]
+
+                        offset = random.randrange(128, 1024, 128)
+                        output = u_boot_console.run_command(
+                            'save mmc %d:%s %x /%s %d'
+                            % (x, part, addr + offset, file, size)
+                        )
+                        expected_text = '%d bytes written' % size
+                        assert expected_text in output
 
     if not part_detect:
         pytest.skip('No partition detected')
@@ -589,7 +648,6 @@ def test_mmc_fat_read_write_files(u_boot_console):
 
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
-            u_boot_console.run_command('mmc dev %d' % x)
             try:
                 partitions = devices[x][fs]
             except:
@@ -597,82 +655,86 @@ def test_mmc_fat_read_write_files(u_boot_console):
                 continue
 
             for part in partitions:
-                part_detect = 1
-                addr = u_boot_utils.find_ram_base(u_boot_console)
-                count_f = 0
-                addr_l = []
-                size_l = []
-                file_l = []
-                crc32_l = []
-                offset_l = []
-                addr_l.append(addr)
-
-                while count_f < num_files:
-                    size_l.append(random.randint(4, 1 * 1024 * 1024))
-
-                    # CRC32 count
-                    output = u_boot_console.run_command(
-                        'crc32 %x %x' % (addr_l[count_f], size_l[count_f])
-                    )
-                    m = re.search('==> (.+?)', output)
-                    if not m:
-                        pytest.fail('CRC32 failed')
-                    crc32_l.append(m.group(1))
-
-                    # Write operation
-                    file_l.append('%s_%d_%d' % ('uboot_test', count_f, size_l[count_f]))
-                    output = u_boot_console.run_command(
-                        '%swrite mmc %d:%s %x %s %x'
-                        % (
-                            fs,
-                            x,
-                            part,
-                            addr_l[count_f],
-                            file_l[count_f],
-                            size_l[count_f],
+                for y in mmc_modes:
+                    u_boot_console.run_command('mmc dev %d %d %d' % x, part, y)
+                    part_detect = 1
+                    addr = u_boot_utils.find_ram_base(u_boot_console)
+                    count_f = 0
+                    addr_l = []
+                    size_l = []
+                    file_l = []
+                    crc32_l = []
+                    offset_l = []
+                    addr_l.append(addr)
+
+                    while count_f < num_files:
+                        size_l.append(random.randint(4, 1 * 1024 * 1024))
+
+                        # CRC32 count
+                        output = u_boot_console.run_command(
+                            'crc32 %x %x' % (addr_l[count_f], size_l[count_f])
                         )
-                    )
-                    assert 'Unable to write' not in output
-                    assert 'Error' not in output
-                    assert 'overflow' not in output
-                    expected_text = '%d bytes written' % size_l[count_f]
-                    assert expected_text in output
-
-                    addr_l.append(addr_l[count_f] + size_l[count_f] + 1048576)
-                    count_f += 1
-
-                count_f = 0
-                while count_f < num_files:
-                    alignment = int(
-                        u_boot_console.config.buildconfig.get(
-                            'config_sys_cacheline_size', 128
+                        m = re.search('==> (.+?)', output)
+                        if not m:
+                            pytest.fail('CRC32 failed')
+                        crc32_l.append(m.group(1))
+
+                        # Write operation
+                        file_l.append(
+                            '%s_%d_%d' % ('uboot_test', count_f, size_l[count_f])
                         )
-                    )
-                    offset_l.append(random.randrange(alignment, 1024, alignment))
+                        output = u_boot_console.run_command(
+                            '%swrite mmc %d:%s %x %s %x'
+                            % (
+                                fs,
+                                x,
+                                part,
+                                addr_l[count_f],
+                                file_l[count_f],
+                                size_l[count_f],
+                            )
+                        )
+                        assert 'Unable to write' not in output
+                        assert 'Error' not in output
+                        assert 'overflow' not in output
+                        expected_text = '%d bytes written' % size_l[count_f]
+                        assert expected_text in output
+
+                        addr_l.append(addr_l[count_f] + size_l[count_f] + 1048576)
+                        count_f += 1
+
+                    count_f = 0
+                    while count_f < num_files:
+                        alignment = int(
+                            u_boot_console.config.buildconfig.get(
+                                'config_sys_cacheline_size', 128
+                            )
+                        )
+                        offset_l.append(random.randrange(alignment, 1024, alignment))
 
-                    # Read operation
-                    output = u_boot_console.run_command(
-                        '%sload mmc %d:%s %x %s'
-                        % (
-                            fs,
-                            x,
-                            part,
-                            addr_l[count_f] + offset_l[count_f],
-                            file_l[count_f],
+                        # Read operation
+                        output = u_boot_console.run_command(
+                            '%sload mmc %d:%s %x %s'
+                            % (
+                                fs,
+                                x,
+                                part,
+                                addr_l[count_f] + offset_l[count_f],
+                                file_l[count_f],
+                            )
                         )
-                    )
-                    assert 'Invalid FAT entry' not in output
-                    assert 'Unable to read file' not in output
-                    assert 'Misaligned buffer address' not in output
-                    expected_text = '%d bytes read' % size_l[count_f]
-                    assert expected_text in output
+                        assert 'Invalid FAT entry' not in output
+                        assert 'Unable to read file' not in output
+                        assert 'Misaligned buffer address' not in output
+                        expected_text = '%d bytes read' % size_l[count_f]
+                        assert expected_text in output
 
-                    output = u_boot_console.run_command(
-                        'crc32 %x $filesize' % (addr_l[count_f] + offset_l[count_f])
-                    )
-                    assert crc32_l[count_f] in output
+                        output = u_boot_console.run_command(
+                            'crc32 %x $filesize' % (addr_l[count_f] + offset_l[count_f])
+                        )
+                        assert crc32_l[count_f] in output
 
-                    count_f += 1
+                        count_f += 1
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
-- 
2.25.1

