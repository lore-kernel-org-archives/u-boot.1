Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87499CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 360D740900;
	Thu, 15 Oct 2026 13:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E9fu3VxDzxwE; Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B3B3408FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072527;
	b=NR0SMyp8YMKk8sMSXLcEziZayV5M1f2iCmWA0GeofI9skpkkoqjZBFFF6BplPAgt4Bfv
	 FvXFf/IhBWUMxKwC5pmJGKm9o+1SAvvLCSu5QPoT+iWa+y8eNyIoI1YSodGJo2p1mkt0U
	 UPYIWi8wyiLOCdld3fv34505Yw6hVogUztReeozk+X1maooqM/wB2/rwXgRjOsD4Q4G/i
	 pz4aaqqsySlBHoU9+qSZJxu9/rTzVlRyQ0L0K3hhYXKnU+A/yu836XQLTREKWpk/SqvSf
	 m9nt3sLZDY29pUr9MiFIM3kpTKXKJ1eUAIuvj3gCOSAcNKH3HlaVC7Nen7rXDKjDWgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o43dcc016kgJhpah+In+QxYVan0VlOIesNW8hhk8hX0=;
	b=RtjVpuJKcLAzGgTlx3g32CV0tyxuQ2Nsp4mqjjs5eykktuXtbcx0gaXAacbPEoQLUqmL
	 oMgolXXq/M7ibnKvMNQ/F85k+V3KCUSHrG4+6e7ksXK0Pa9I8GQE14dNvmdZy18WkT7Jt
	 QrUuxqvKxVC9gWSE4RwNRHm8E52/Ny0RYshV6SqDJZqcbC6ETsdTEld0c2uF0j/7XZN+b
	 uf3DB22rh052y4/fxKXPxBzJX0zu+7Vh5dDr9/oFdTGvmW7uVZ18LzfrMd16/eyYvZNLv
	 cA8vH+mmS//NDwBDhYp7NRW6l3DNa11ML+/ZEgF+TnFVeBKhnvkcRxM1uHAQpNmzoeA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072527;
	bh=o43dcc016kgJhpah+In+QxYVan0VlOIesNW8hhk8hX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wk6KkXGzw7u9pBzE5hPnCaW3v+5C3TySJOw7d81NoIzcuOdkH4NDM1O0wXI/LzJ1e
	 m1S15WmlUU5DS3Cit6gNovoS3DdFxSIU11/9XFByK2WFFEGl7wpA5hKQGv2mbuJpjU
	 Df0p45XCIP4RieSsly234nnia5OH6nXVI/kuD2EPirnOQ3ckyJmFGDB/g2JlH5hpgi
	 TAKtZsN3ckrUOQ7hvAyWyCXDB4kO3uVN6zTjZV+pS9QbqjZ7qmK6TlYWm22NiWtxBy
	 WSsMtobPXGdKMXXZqhuyb0JEEfBRKpLxXlTcsLWimFxzDCskYOR7CghHCyd/yirwVC
	 Th7b3JN3oM6kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B3B3408FB;
	Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E3702AC
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 448BF81212
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBo0Ce2__TOZ for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54BF580E47
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072520;
 b=pFnAeaJ9YFexNBclupU166iCKxLGcWJuxwkgtEilajQtku9y37E14mm+CUmP/aEOxdsW
 gFel9Tcu9PlOD6WAqcaMt5I63Odhy9HwZDz8ApTUu4bIJuiS8os//No97EvOvXYqkGy1p
 SodO+KMiQtf/vWeWHYgMOnB2vZhUC8AseQ/8XhUzSyOo9uLiZRVzRApCZztYIOghACR8M
 DRvraHrYCqPCMjwdsKRXFrVeynKV7hsCshOvH3eGyaHNzUTnhQEGM6cbZHPHNa1/qWmuW
 HFYSufucr5KwbqZxjEKe+xk67KMRNf9fLiluMWQ+qW0/xo8FFAJEjHhOYn3SMMu3kXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072520;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=o43dcc016kgJhpah+In+QxYVan0VlOIesNW8hhk8hX0=;
 b=Qdervsg3PLfcoOM5WBush05NCNrSex89fT82uQTHwHXGzWtGRdv+9wGsKwQ7Q1M26aHe
 UUZOWaGnoZz/Cug64Y5DxP4+qyE077jgpN+u5LhP0IzsSuCIieIrAV7HPFJXDqBHFZBpv
 UD7TvlgvHb95Z1VZnqxT8TjXUhxCFjjFTQ9RV7sNhmYi7o4RMbXknfJ2gyklZyGunC40F
 U3aKkIE0RHwdf/O3J7n0YSQgDUGOLCId+nchCHlYFRyNUyNpFFn+6L0x2fpyGZeWyFkl8
 fOz9//4bYHs72B+PquWrcsNXmIYQjtsBQnbKcVClVPWNgO2dWVR4M9T0r9b5VJEVuog==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=deUt1bSN; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=deUt1bSN
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54BF580E47
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B9D940062;
 Thu, 15 Oct 2026 13:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5041F000C4;
 Thu, 15 Oct 2026 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072519;
 bh=o43dcc016kgJhpah+In+QxYVan0VlOIesNW8hhk8hX0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=deUt1bSNrV51dazO0SrBxwHlwYKjnZfZDwIwGJhIrfoUpqpVyZ018qAiWT7qZjtF2
 ybZb/e6kRIGTVuHjvACQDL+WdrgOBD7nW6n/I9UfZaddYv0BjOX6pMYHEpvC131KWU
 KAZKCcnltQAA0gfN2N2z+xX4oyM3ot6PC0xukUvLzF5ct3yMF7ZueO+GlogXviE0xN
 vdjFb5M6uc4RSHNRC7d0A+EZXoyRu65E8+z/j5xjwRl4JUe4Ght2rjaDZY9VmGTwSF
 3oyjwUmB7S6p98DNNWKK/e3I/GrLHsh4DvoE95SlS4A+MZydBKDZqtXLD4PAHZE8N+
 kYfixr32pqqkw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:52 +0200
Subject: [PATCH 02/10] test/py: android: Move android image creation to a
 dedicated file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-2-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10662;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=KWd3WBwF7uASW7ehZQI8480DoOk78ChFMsYvYtYsiJ4=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ9aF23ZHn8T7SehZftLQ210aUV55+ULnzoZdkyOMdhYwr
 N3SmvKmk9GYhYGRi0FWTJFF76XT8m3yWfuChdcywAxiZQKZwsDFKQATYV7I/ldgpe/+Mz2xlXm7
 iqJfsne4TPVQeHf2Z55v+4/0BjsRCe+gKP/LBmZHeO9e2Pm2YFpguNY0nvdGG8u+WzKwh7Z+6pg
 l4W22mz33XbPzyrOKdvWeBw/9z9xn3Ha2iHvGojxWXs9Px7jWtu9Jzj/7fs7iQP+zW90fv2f0Fz
 yYs3uqt5HGmtAza5yvqR8LZTQ/x6CzgNWjvDXk9IsvZy9NKpRZ//BTWdG5JfG9HYEXE8R8L6m/M
 WmSSZCsNGzYuNMzuM2zS0/2+DuN9gfZ1mlS79O8eg23PtZ5ecF0qW3Uh7D98SlBq0LVvFVa36Vf
 YrY/7mBmEZDy8I20WtvWddrXnAomVDZ6+rrwZDMxynEDAA==
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The image creation code in test_ut is huge and difficult to follow.
The android part contain code duplications when making mmc7.img/mmc8.img.

To prepare some code refactoring, move the Android specific bits into a
dedicated file under test_android/.

No functional change.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 135 ++++++++++++++++++++++++++++
 test/py/tests/test_ut.py                    | 129 +-------------------------
 2 files changed, 136 insertions(+), 128 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
new file mode 100644
index 000000000000..3bea311586bf
--- /dev/null
+++ b/test/py/tests/test_android/android_image.py
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: GPL-2.0
+"""Helpers to create Android disk images for sandbox testing."""
+
+import collections
+import os
+
+import utils
+from test_android import test_abootimg
+
+def setup_android_image(ubman):
+    """Create a 20MB disk image with Android partitions"""
+    Partition = collections.namedtuple('part', 'start,size,name')
+    parts = {}
+    disk_data = None
+
+    def set_part_data(partnum, data):
+        """Set the contents of a disk partition
+
+        This updates disk_data by putting data in the right place
+
+        Args:
+            partnum (int): Partition number to set
+            data (bytes): Data for that partition
+        """
+        nonlocal disk_data
+
+        start = parts[partnum].start * sect_size
+        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
+
+    mmc_dev = 7
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
+        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
+    ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        utils.run_and_log(
+            ubman,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
+        ptr += size
+
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
+    boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
+    with open(boot_img, 'rb') as inf:
+        set_part_data(2, inf.read())
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
+    vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
+    with open(vendor_boot_img, 'rb') as inf:
+        set_part_data(4, inf.read())
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    print(f'wrote to {fname}')
+
+    mmc_dev = 8
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+    ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        utils.run_and_log(
+            ubman,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
+        ptr += size
+
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
+    boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
+    with open(boot_img, 'rb') as inf:
+        set_part_data(2, inf.read())
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    print(f'wrote to {fname}')
+
+    return fname
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 2a5acc18c612..c1b5bc056023 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -19,7 +19,7 @@ import utils
 # pylint: disable=E0611
 from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
-from test_android import test_abootimg
+from test_android.android_image import setup_android_image
 
 def mkdir_cond(dirname):
     """Create a directory if it doesn't already exist
@@ -506,133 +506,6 @@ def setup_cros_image(ubman):
 
     return fname
 
-def setup_android_image(ubman):
-    """Create a 20MB disk image with Android partitions"""
-    Partition = collections.namedtuple('part', 'start,size,name')
-    parts = {}
-    disk_data = None
-
-    def set_part_data(partnum, data):
-        """Set the contents of a disk partition
-
-        This updates disk_data by putting data in the right place
-
-        Args:
-            partnum (int): Partition number to set
-            data (bytes): Data for that partition
-        """
-        nonlocal disk_data
-
-        start = parts[partnum].start * sect_size
-        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
-
-    mmc_dev = 7
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
-    utils.run_and_log(ubman, f'cgpt create {fname}')
-
-    ptr = 40
-
-    # Number of sectors in 1MB
-    sect_size = 512
-    sect_1mb = (1 << 20) // sect_size
-
-    required_parts = [
-        {'num': 1, 'label':'misc', 'size': '1M'},
-        {'num': 2, 'label':'boot_a', 'size': '4M'},
-        {'num': 3, 'label':'boot_b', 'size': '4M'},
-        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
-        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
-    ]
-
-    for part in required_parts:
-        size_str = part['size']
-        if 'M' in size_str:
-            size = int(size_str[:-1]) * sect_1mb
-        else:
-            size = int(size_str)
-        utils.run_and_log(
-            ubman,
-            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
-        ptr += size
-
-    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
-
-    # Create a dict (indexed by partition number) containing the above info
-    for line in out.splitlines():
-        start, size, num, name = line.split(maxsplit=3)
-        parts[int(num)] = Partition(int(start), int(size), name)
-
-    with open(fname, 'rb') as inf:
-        disk_data = inf.read()
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
-    boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
-    with open(boot_img, 'rb') as inf:
-        set_part_data(2, inf.read())
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
-    vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
-    with open(vendor_boot_img, 'rb') as inf:
-        set_part_data(4, inf.read())
-
-    with open(fname, 'wb') as outf:
-        outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    mmc_dev = 8
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
-    utils.run_and_log(ubman, f'cgpt create {fname}')
-
-    ptr = 40
-
-    # Number of sectors in 1MB
-    sect_size = 512
-    sect_1mb = (1 << 20) // sect_size
-
-    required_parts = [
-        {'num': 1, 'label':'misc', 'size': '1M'},
-        {'num': 2, 'label':'boot_a', 'size': '4M'},
-        {'num': 3, 'label':'boot_b', 'size': '4M'},
-    ]
-
-    for part in required_parts:
-        size_str = part['size']
-        if 'M' in size_str:
-            size = int(size_str[:-1]) * sect_1mb
-        else:
-            size = int(size_str)
-        utils.run_and_log(
-            ubman,
-            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
-        ptr += size
-
-    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
-
-    # Create a dict (indexed by partition number) containing the above info
-    for line in out.splitlines():
-        start, size, num, name = line.split(maxsplit=3)
-        parts[int(num)] = Partition(int(start), int(size), name)
-
-    with open(fname, 'rb') as inf:
-        disk_data = inf.read()
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
-    boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
-    with open(boot_img, 'rb') as inf:
-        set_part_data(2, inf.read())
-
-    with open(fname, 'wb') as outf:
-        outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    return fname
-
 def setup_cedit_file(ubman):
     """Set up a .dtb file for use with testing expo and configuration editor"""
     infname = os.path.join(ubman.config.source_dir,

-- 
2.56.0

