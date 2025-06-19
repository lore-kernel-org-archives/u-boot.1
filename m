Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4F7C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 11:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA5F82CCE;
	Thu, 19 Jun 2025 13:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ceyLm6z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAFD82CD5; Thu, 19 Jun 2025 13:45:15 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D376B82CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 13:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55JBjBEB573053;
 Thu, 19 Jun 2025 06:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750333511;
 bh=NTpsqjGlE2km1d/F2xqWqq2PZy4rCNkaof2bnqAtymI=;
 h=From:Date:Subject:To:CC;
 b=ceyLm6z+OVewgUQqFyR36V2pQrfF635LWVtY+lpNj+GrYL9KVZ2OK8Oh3e4MzEzXX
 a1m/bbUydf1s8fL+jJuiONg1wF2TEwMNX51kq+blre2b228N9MV/2ZZppEeLXSmWWY
 EqWjDo4kE8580p97QMl7wto0lRyXzs0CGS6+S5iI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55JBjBhj3672337
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 19 Jun 2025 06:45:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 19
 Jun 2025 06:45:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 19 Jun 2025 06:45:10 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55JBjAfm1056596;
 Thu, 19 Jun 2025 06:45:10 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 19 Jun 2025 06:45:05 -0500
Subject: [PATCH -next] test/py/test_mmc: wrap multi-argument printf-style
 strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250619-mmc-test-fixes-v1-1-1eff87dd69db@ti.com>
X-B4-Tracking: v=1; b=H4sIAED4U2gC/x3LSwqAMAxF0a1IxgZqof62Ig6KPjUDqzRFBHHvF
 oeHy31IEQVKffFQxCUqR8ioyoKmzYcVLHM2WWOdqauO933iBE28yA1l1xjTNn62cKA8nRF/yM9
 AHHAnGt/3A5mlGVpnAAAA
X-Change-ID: 20250619-mmc-test-fixes-570087ad2e5e
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7853; i=bb@ti.com;
 h=from:subject:message-id; bh=8dkEG1Rc2yf8BAyNOmXXSZnTSYeyG59ZPnUmZ3rLEj8=;
 b=owNCWmg5MUFZJlNZ+nlU+wAAcH///nfd2/m3/duv7u8znP+b/a4v4H++nlJPb63O6Ttay+ewA
 RtWCHpA0AAA9QZPUBoAPUMjQDQAAANAB6jT1AAAAaNHqHqAZpNPUPU2o8U20odAaAyDTTQYmQMg
 NPUBgIYgZDQA0Bk0GgANqYJk0wT1GE0NNA0MmE00PQZQeoeUehDQA0xDJkaaPQg00aGgZNDTEGm
 gDRpiDQaBoANGQ0YjJpiaNGJkBoCDXBog5Mzn7IgoQ5ACVmWK8UoEA90bKqFnBw0bPzYFa7Mx+a
 jkGOtrh2PQjTGiuC+krFEBdbB4CoiIjg93h9uKxOStXvUd7zfKvwfkKF8rbicZDr4AT16Gmh4KD
 mZKDku3+wxgRJoTTmoz5o5J5l0pEjL3ypVRv6GeAgFU7mr91jVQ2cCSpIgkmi9rqe7EQp2hQQW4
 oBixaJCt/S9apvEcuHp8ukIyoixgGDab6i3tj+Z7Qc4uNiA2XBBB45r3slECxhbFpN7dUqaOJ8Y
 RvUq8QMchDwUNSLEwFyUwTKhfyukvtQUKEVWq0c713jEPhsaxdhs1qpPYNpZETvwWfEWvHMfhO1
 nWazc3+Xb+pdhMkycwJDqWEwpwHpEJ5S3YeV8XU9H6cbQ4sGA4FR+gXJB8kAvJmnJYMEnSSJUnd
 B/+LuSKcKEh9PKp9g==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Newer versions of python will emit a TypeError about not enough
arguments for a format string:

    FAILED ub/test/py/tests/test_mmc.py::test_mmc_dev - TypeError: not enough arguments for format string
    FAILED ub/test/py/tests/test_mmc.py::test_mmcinfo - TypeError: not enough arguments for format string
    FAILED ub/test/py/tests/test_mmc.py::test_mmc_info - TypeError: not enough arguments for format string
    FAILED ub/test/py/tests/test_mmc.py::test_mmc_rescan - TypeError: not enough arguments for format string
    FAILED ub/test/py/tests/test_mmc.py::test_mmc_part - TypeError: not enough arguments for format string

Add parentheses around all multi argument format strings so all
arguments will be passed to the format string

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 test/py/tests/test_mmc.py | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/test/py/tests/test_mmc.py b/test/py/tests/test_mmc.py
index e751a3bd36a8e212d19a6587c33c34043a3dd4a2..1f738ef3dcb4c9c82ee982eac058520b215f3766 100644
--- a/test/py/tests/test_mmc.py
+++ b/test/py/tests/test_mmc.py
@@ -99,7 +99,7 @@ def test_mmc_dev(ubman):
         devices[x]['detected'] = 'yes'
 
         for y in mmc_modes:
-            output = ubman.run_command('mmc dev %d 0 %d' % x, y)
+            output = ubman.run_command('mmc dev %d 0 %d' % (x, y))
 
             if 'Card did not respond to voltage select' in output:
                 fail = 1
@@ -122,7 +122,7 @@ def test_mmcinfo(ubman):
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             for y in mmc_modes:
-                ubman.run_command('mmc dev %d 0 %d' % x, y)
+                ubman.run_command('mmc dev %d 0 %d' % (x, y))
                 output = ubman.run_command('mmcinfo')
                 if 'busy timeout' in output:
                     pytest.skip('No SD/MMC/eMMC device present')
@@ -146,7 +146,7 @@ def test_mmc_info(ubman):
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             for y in mmc_modes:
-                ubman.run_command('mmc dev %d 0 %d' % x, y)
+                ubman.run_command('mmc dev %d 0 %d' % (x, y))
 
                 output = ubman.run_command('mmc info')
                 assert mmc_modes_name[mmc_modes.index(y)] in output
@@ -172,7 +172,7 @@ def test_mmc_rescan(ubman):
     for x in range(0, controllers):
         if devices[x]['detected'] == 'yes':
             for y in mmc_modes:
-                ubman.run_command('mmc dev %d 0 %d' % x, y)
+                ubman.run_command('mmc dev %d 0 %d' % (x, y))
                 output = ubman.run_command('mmc rescan')
                 if output:
                     pytest.fail('mmc rescan has something to check')
@@ -210,7 +210,7 @@ def test_mmc_part(ubman):
                     elif part_type == '83':
                         print('ext(2/4) detected')
                         output = ubman.run_command(
-                            'fstype mmc %d:%d' % x, part_id
+                            'fstype mmc %d:%d' % (x, part_id)
                         )
                         if 'ext2' in output:
                             part_ext2.append(part_id)
@@ -246,7 +246,7 @@ def test_mmc_fatls_fatinfo(ubman):
 
             for part in partitions:
                 for y in mmc_modes:
-                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                     output = ubman.run_command(
                             'fatls mmc %d:%s' % (x, part))
                     if 'Unrecognized filesystem type' in output:
@@ -288,7 +288,7 @@ def test_mmc_fatload_fatwrite(ubman):
 
             for part in partitions:
                 for y in mmc_modes:
-                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                     part_detect = 1
                     addr = utils.find_ram_base(ubman)
                     devices[x]['addr_%d' % part] = addr
@@ -357,7 +357,7 @@ def test_mmc_ext4ls(ubman):
 
             for part in partitions:
                 for y in mmc_modes:
-                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                     output = ubman.run_command(
                         '%sls mmc %d:%s' % (fs, x, part)
                     )
@@ -392,7 +392,7 @@ def test_mmc_ext4load_ext4write(ubman):
 
             for part in partitions:
                 for y in mmc_modes:
-                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                     part_detect = 1
                     addr = utils.find_ram_base(ubman)
                     devices[x]['addr_%d' % part] = addr
@@ -454,7 +454,7 @@ def test_mmc_ext2ls(ubman):
 
             for part in partitions:
                 for y in mmc_modes:
-                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                     part_detect = 1
                     output = ubman.run_command(
                         '%sls mmc %d:%s' % (fs, x, part)
@@ -491,7 +491,7 @@ def test_mmc_ext2load(ubman):
 
             for part in partitions:
                 for y in mmc_modes:
-                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                     part_detect = 1
                     addr = devices[x]['addr_%d' % part]
                     size = devices[x]['size_%d' % part]
@@ -534,7 +534,7 @@ def test_mmc_ls(ubman):
 
                 for part in partitions:
                     for y in mmc_modes:
-                        ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                        ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                         part_detect = 1
                         output = ubman.run_command('ls mmc %d:%s' % (x, part))
                         if re.search(r'No \w+ table on this device', output):
@@ -566,7 +566,7 @@ def test_mmc_load(ubman):
 
                 for part in partitions:
                     for y in mmc_modes:
-                        ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                        ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                         part_detect = 1
                         addr = devices[x]['addr_%d' % part]
                         size = devices[x]['size_%d' % part]
@@ -609,7 +609,7 @@ def test_mmc_save(ubman):
 
                 for part in partitions:
                     for y in mmc_modes:
-                        ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                        ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                         part_detect = 1
                         addr = devices[x]['addr_%d' % part]
                         size = 0
@@ -656,7 +656,7 @@ def test_mmc_fat_read_write_files(ubman):
 
             for part in partitions:
                 for y in mmc_modes:
-                    ubman.run_command('mmc dev %d %d %d' % x, part, y)
+                    ubman.run_command('mmc dev %d %d %d' % (x, part, y))
                     part_detect = 1
                     addr = utils.find_ram_base(ubman)
                     count_f = 0

---
base-commit: ce2a7fcbd565d55b1d3fdc0e68edd50a21eca7d4
change-id: 20250619-mmc-test-fixes-570087ad2e5e

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

