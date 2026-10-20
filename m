Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861A606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dfVFTg9D;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWA0+JyK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 399F1810D9;
	Tue, 20 Oct 2026 09:26:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBAPPjQUSIAw; Tue, 20 Oct 2026 09:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 909B2810DA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488378;
	b=Uy+9hGiv75MfHs0RarKX3ZmFveVvbuVYrkENFAVbEGhhqmTv1p6pojWfquax4ZQjXqQX
	 iQ+i/FzIwWAk66gt4zIqZsn0aV67vbo836sZvnO/bAnGcmTKDPhtDknnbiqmssfqVspoG
	 OYpgSl+6jU0U58a57gKRQG59yaWRhcXXzbhSHGB92nEL1BCT3cqJVR3OGzSDYi2fJMjuu
	 uFXeufkPcLwq8VuQSHoEByj/11YS+h9QjjUGd9m5d+f6/m34sn00FbEIaMhIlF8TXnj+9
	 fen/rAYRZm0fFdgx8pNx9pJdfuSU+glWUTSYNgkvUtGvwi84Rfrv6aCKnkKKBKO2gqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488378;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LFuyrPA7WbeO3l3+UcKpScaJahjZakIM1EWYA3nJS7I=;
	b=W1LazXG1iD+BZ6YMcclYqB5AhzhNBOx2cXVNFzNOv5CoUpTLNsv39HpCguQhAw3pIi3W
	 Uk/kxCbTwVfmT9Jv3ZjTYb+pFUun5Zi0q7MhLKyI17stZqpjqb9dW0k6kTii1YZCr9Yih
	 BYnxXbAbx6gmHjPrwx8yIG/0RKZDhe/cVaXU9QquTqVyYojVCWVySfT/48V27UC5IKXs7
	 5GEOK1TMtzGRZ23xas2m5EQoeN0VWx7YM2Y7zEwr3eFK0DOhWQyybAPgZokugIve5GbNJ
	 KTW+qw/xqbr1ztI2rhrAzUilMYM8vQnWYNsyN1aSfp5kQoXhRZ1IJxVKyktZ76laLOQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488378;
	bh=LFuyrPA7WbeO3l3+UcKpScaJahjZakIM1EWYA3nJS7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dfVFTg9DilJo8jHnCJ3BYMLHvajNqymzuEaCHC6S3xVbrPowDmb3Q7vDZC/Aol5oe
	 bmORjOPztvRKi5DmtOy04BPaSKVR+VI0DcJpmt9HtRL3pVk8EH7ZKLwcc3s62aaefS
	 4EyHiUtDOTJsCkupGxIyGuiYv2Vmv7cfPHG9t26sMKYS5HEV8znrquyr5eth7AXJdS
	 wup98Y21DmSsk2ccpLIGdN8hBXkeRllLBV76hp7ik2fr8TV3+eXFNsZdZDe4Hvdx8k
	 k0F4FFeXZGAyD9z/hDsr9UBQeI1GQ/A5e3/TxIKTP0ePwzUwI7crzjm88+TGpbrLXZ
	 VaKTryknJWy5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 909B2810DA;
	Tue, 20 Oct 2026 09:26:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDECF3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB45640328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EImlnW0V7reZ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A56584016F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488375;
 b=DuiskiMNVKiwD8zRJxJRL3nRBly8RLkQhmclaagtUdHMJWwhOoMwjmUlXPUPrFhihlsF
 QTcPCNYf7BiONl2X6lEOTP97YEw8Z1Fr5ea7+a7yfGK/fhUOpc3R5R5wI+C1burcIFd5W
 2n7YV1YmvAZvd5KyVMNkwkArTsLhjaXAzNbA+2GZSLYSoPStAaPxQ9YeBOuLA0N/wYGB/
 AIjvAvN12shBxR5Uf0cqW1CPgBx3fYJkZKOHddcEf0tXL7ULXPtqADagArMnwIEmCnG2L
 dOokRauDsNFwz4iuY71m5XbaxRq5xhnIWSnMWl9U5g3dtF8FOZdP9pEXyo4/oyeTgGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488375;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=LFuyrPA7WbeO3l3+UcKpScaJahjZakIM1EWYA3nJS7I=;
 b=ezRjteQqvJ/rSuURGA8InT5vbEx3pxFG0X0oG+LitLXf3w3z+HZhYCleYTov5HJSJtsr
 iMQIQX26HzWHxekhEjwILTljNQNSnUAOIqjbTZiAs8tbkL5VkIXe605gpvIEi4/izhiMD
 LQbo1WiBLiQF6a0+GcvF7ci2YN3E9ppka7Ee3v7GnHL/WfGIKmNEwbDXCfXqbZY9inT7w
 y2quu8voQmsCWJBSwFSqlD1VuB66HPOOqGlZjKzAscVdr8xKVDco9A7ajsAJ2qseEwLVJ
 H9trIa74v6z94gdSMww7iC9QKXrAdosUgMxu0PLDQS6+BDUuXL232YTCRTw4wp+sumA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XWA0+JyK; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XWA0+JyK
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A56584016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CB60431D5;
 Tue, 20 Oct 2026 09:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1031F000C4;
 Tue, 20 Oct 2026 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488374;
 bh=LFuyrPA7WbeO3l3+UcKpScaJahjZakIM1EWYA3nJS7I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XWA0+JyKdq7ImNwH9GUO1PLwVtUFrWKZhB3lmYKJQKX3qhUm9r+USrjAG7Rd7VpNI
 mhLxO3QiuAkRymES8tvGcxDyAM7NoNNQZSqYWvkSUKOEvhTAIhB39nHPZ8LpaXMguv
 tYdUYkkf23UrPX87qTj1NaOtxLC2iHzdHTtAFcHekGisBjdkQykJifXtvhu7RdVBFK
 MhAe9S2mZz2onBsHwuO6ejIPH26uwK0i/28LXuFHlhrN6h2YvceRM+ya5O9Xk7vivq
 edQTOhDNZWPg1G6dL60qglzEJa8G58VzT/BnGnqg90Q1LyyMShNAQ8gy2C+pJWV/oy
 mpNvqeKCYnaUQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:51 +0200
Subject: [PATCH v2 02/10] test/py: android: Move android image creation to
 a dedicated file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-2-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10890;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=HvFQeVUVYuELA1hGLxOQXeCG6jP9XI+swJulnk4Ryvk=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOuCv7rq2mIs/1fjfTvdZ0UfrNpFGOKF6nyK
 kRV5alioMuJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrgAKCRAZDR20Zk4Z
 NVVYCACTNCaYBv9d65WCVL6MoMK+ilvbaikhduIzS9nR+ozWgvL3KSYzxBMcRvIYEiJlKl5b6Lz
 wEnWD2LlMRz2C2jgUhY49UQOts1Eywdn/9ET9lJeRzLwyoEhVxiCLfK+vKPNYWz3LmKMoH28Ilx
 sdFY5xY2ZZMQ900bIYlGZrEXml7iZ9LwmCcJVb3s//U1rdoLqOWZAQx/Vwi67sk4yfmdjwYzJj7
 LCKy64ju9Tcd2gNGyRnlxipRmOKc8ixerg+itQCZ6bTxPZ6aeEyNE12uqWAaUAXpGlIIenYUSt9
 mToqWT4rcesouH9Ymi0nDMjkdErMl39GCL6twiwxp5zDt/gL
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The image creation code in test_ut is huge and difficult to follow.
The android part contain code duplications when making mmc7.img/mmc8.img.

To prepare some code refactoring, move the Android specific bits into a
dedicated file under test_android/.

No functional change.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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

