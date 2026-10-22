Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E0606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hYR9GqdX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7OgbRmt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F3F4409D1;
	Thu, 22 Oct 2026 13:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrVpFbR6PVCP; Thu, 22 Oct 2026 13:30:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 311E8409BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675857;
	b=NdEC6GaIjyOtBj/bZFjW/UJtXV8tBm3deG19JhTpmarsFpRhX3zqNPZlSLjVQGkp/UE1
	 Q5Xkf6gMa+ApmsdN6YmtgNEtH7sj4EFVr08k8iQ9oCEsH3PwuwS2lgwkxtXMMOCx7LrdI
	 UdxYqZX6euCRpumdTYa7Y9QppC76csyTdpMnQDGdncyH729YIJQpynXaSD+fiVKJDn1ZC
	 ozHCAbM7Sfx/iv4xv8X+VpJvUNjgrAD3c5axlORgPdft9QMjyGBKjUw3F1XbpkOkKXpXJ
	 IPuwYxgtbp3SeYqjE7ULlU9keLArgvYrCbcFZ2etjGBGV3jKeYY1USwcjTmDDHgCG6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FQVMrOi1QGd4Wl1WRfHX+aj3xq47h/UIW0Smmto5J3c=;
	b=JicbKextavwadYaPD9FgIDjzd7IXfbubchgBBC795+lpPwqiLto6h1hC4NesO82vdQ35
	 vEFPlc2xnrEe/m1Lb/NElfm/LyAwYZZYZAEh1UzAooABEV22XfgXCOzce47B1mKoNzpSR
	 31UhuFKRdbb3W7NtuB81pQejsFn2kntZbRQ4c37kXZmz4xcV0ibiffvdzIuzt99d+qUIo
	 WXXrHveDROwvdQS4nveUP0A8VlvO4+HRJRI1H4c7iFl9xR9diov3gYPrvLUHrmKU/uVH1
	 BXORXv0SoGWBtj6gkYTsIMFQGGaMk0dsf8Ij/ikxr9+H8cYkmj5S0ScTr1fGUtj0/kQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675857;
	bh=FQVMrOi1QGd4Wl1WRfHX+aj3xq47h/UIW0Smmto5J3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hYR9GqdXsGQoaKHALHZhPJ7ypFPjcYdSe31XMS3KlH9udggE5ibTsfLvvvfSYkuqT
	 I2xqmOgihZUqFkfnrDG61EZqBB26z0EBQabL8CnLYpbYRfHKAnAO0GZKgQksF40MAA
	 9YsRTbsvnXWUc7/itZ6ON3wlLSvJkuSKBm+HKfgE0Shuo4O2TjVxWc1Gg+cslA12iG
	 upYacEISgsD18aaE5ss/TWwtUiIA9fZjcscjo0qOtgvmi/J8C2aclOmlgHbW0If+je
	 oOC5Ar0QsrfQKk/qU714HWvOd/Vx5yIQVyvwOg5zt98aqAzRWGvPbruhabTnc4Fcfz
	 gipLFS+7JUCkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 311E8409BC;
	Thu, 22 Oct 2026 13:30:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF6A73C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3BF1608BD
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVXBJ4fpnmys for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8CA46090A
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675852;
 b=kPhBjHKLBDeVJmfaH/EusInBJqNWZz+ZyBoFtAT2fARORL55PTRM/50IKtlO7YX8XE8s
 qAjlOA87cRrjnM9YyGYywbqRQDjxZeQgQ1474lwYDoBSp4SuzbP+dxfUWC7Uxpj9oLjcP
 ZFcLA0xMxHOBoOVJlpxjyQrZfq8KnXrT2VohdCgp3luXaRziF6Vw1gEA9VGrh66Fj3IEa
 TeAHZzIw8CwPdxOr09i8DMCNrduHddhO7cV61RnaD0vUMThNeiB2On34/kG+mYcUyFPNB
 /u+SA1EP4BCCIwerapUCJmyyk0NIDILWHq8pG+ffKmIsSjUV1ALAqNxuIMZsb9y5icA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675852;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=FQVMrOi1QGd4Wl1WRfHX+aj3xq47h/UIW0Smmto5J3c=;
 b=oT1Ou/zZtHBx9+Cox73JwP7eiT1w3t24eebSnmuyXOqeYOwzZRDxZmzMei7kxwODgLLK
 Sl9UnjDZ5X5KmYwfrc2XP3yeIClLcY1QahFb6R6wY/9GqmFKkDay8BmE31mcYbDKSEFP2
 6Kkl7hZ/9EYrb/Pwu4CaVSEtv7BDEyvz/bAao4MkKttgKyMBXhxqpFW9B7KtgsYjeV5GA
 0mWDjhKRJQ1WSzJxKvpEB/iJUVSBCfN6SeI/i7p1bvW9wwRH7iDVa3wFPJU4lguKuZPRs
 kFaHHIP9lODv2lkWfTU1psncdhlWmTjw1vAdQLbwDA/OEMGoaRmEE2z+P7rv5yhX2iQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=V7OgbRmt; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=V7OgbRmt
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8CA46090A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 943B443274;
 Thu, 22 Oct 2026 13:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0506E1F000C1;
 Thu, 22 Oct 2026 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675851;
 bh=FQVMrOi1QGd4Wl1WRfHX+aj3xq47h/UIW0Smmto5J3c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=V7OgbRmtXCPKa/1IU+fH4MW4HLkdOlm9aLiSWcg6wr+Yb9+grFfylqcnlirH5dofp
 Vk8mf1hmdz+FeadTYGxjadLinr8DpT5UY8apy49Rd5mhflzqpwUeCvMt/HAsBNXwix
 siTPr4hTInQLB/1ZizYdSRkBCdsSzlcP5fucK6jIhf5VY2yTP7oteqBSW42qJ380sy
 SxGZiNVuRBd824fWm+vvu2ZDQgEk0/PY48QLYJ3/ywVY5cRY3w6PHKeacjPeASKQsT
 rnKAgQlvTzjlhIT1f/guNUK2E106qIoJXXybY/RKE5z5S7zRkeR527lv5rK69F5rDi
 X740Z6zmY0fKg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:34 +0200
Subject: [PATCH v3 05/10] test/py: android: Add create_gpt_image() for
 image creation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-5-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6023;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=jxdF/yf/8LMrwEi2H45wQVWpWQRt1oCiG+nKn1t9ctM=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/87UuWZ1r/bRBlZKnBpvU9rvqul/TSms6w/
 O/hjEE48XCJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/AAKCRAZDR20Zk4Z
 NRNxCACmRMX8ULwmz0poHL2g3LW8rD97wxTu8DMvavQXGqmxhUjYPoskuwUJALlk1/vMleRzrN2
 WMqbKZlvdvhuJcXwWT/Maqp3G7C9qGFeoA4TjWTXiFKr5VwjG2QQOHuTT1ZtPx+M4cit6LY0TS6
 7tOzQrojjuAvUAHOFidj5cnp+7bgjKTivarTmNEMY0dMYsuw/pODQNdEMf8VcZQo6frcbx1riNh
 lCc1fEt+zrqaXSeyj0E7DtFHzmLnsBMmHRgVpUOtJr8+nh2p/if6/RKugD8/Un/FGZvSdD5TC/N
 /MpWmJW4z1mqAF/NIxy4+0jmKrv7/5BDQx02QfQp//eLbsFw
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is quite some code duplication between the image creation for
mmc7.img and mmc8.img. If we want to add more images, this will be even
more duplication.

Add a common function, create_gpt_image() which removes all the code
duplication.

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 93 ++++++++++-------------------
 1 file changed, 33 insertions(+), 60 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index 14dfd26fffd8..53b5ebc1de19 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -7,13 +7,24 @@ import os
 import utils
 from test_android import test_abootimg
 
-def setup_android_image(ubman):
-    """Create a 20MB disk image with Android partitions"""
+def create_gpt_image(ubman, mmc_dev, required_parts, images):
+    """Create a 20MB GPT disk image and write it to mmc{mmc_dev}.img
+
+    Args:
+        ubman: U-Boot console fixture
+        mmc_dev (int): MMC device number, used to name the output image
+            file mmc{mmc_dev}.img in the source directory
+        required_parts (list of dict): Partitions to create, each with
+            'num' (int) partition number, 'label' (str) partition name,
+            and 'size' (str) either a sector count or 'NM' for N
+            megabytes (e.g. '4M')
+        images (list of tuple): Data to write into partitions, each a
+            (partnum, filename, hex_data) tuple where partnum (int) is
+            the target partition, filename (str) the image file name,
+            and hex_data (str) the image content as hex
+    """
     Partition = collections.namedtuple('part', 'start,size,name')
     parts = {}
-    disk_data = None
-
-    mmc_dev = 7
     fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
     utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
     utils.run_and_log(ubman, f'cgpt create {fname}')
@@ -24,14 +35,6 @@ def setup_android_image(ubman):
     sect_size = 512
     sect_1mb = (1 << 20) // sect_size
 
-    required_parts = [
-        {'num': 1, 'label':'misc', 'size': '1M'},
-        {'num': 2, 'label':'boot_a', 'size': '4M'},
-        {'num': 3, 'label':'boot_b', 'size': '4M'},
-        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
-        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
-    ]
-
     for part in required_parts:
         size_str = part['size']
         if 'M' in size_str:
@@ -54,10 +57,6 @@ def setup_android_image(ubman):
     with open(fname, 'rb') as inf:
         disk_data = inf.read()
 
-    images = [
-        (2, 'bootv4.img', test_abootimg.boot_img_hex),
-        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
-    ]
     for partnum, img_name, hex_data in images:
         test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
         img_path = os.path.join(ubman.config.result_dir, img_name)
@@ -69,55 +68,29 @@ def setup_android_image(ubman):
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
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
+def setup_android_image(ubman):
+    """Create a 20MB disk image with Android partitions"""
+    mmc_dev = 7
     required_parts = [
         {'num': 1, 'label':'misc', 'size': '1M'},
         {'num': 2, 'label':'boot_a', 'size': '4M'},
         {'num': 3, 'label':'boot_b', 'size': '4M'},
+        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
+        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
     ]
+    images = [
+        (2, 'bootv4.img', test_abootimg.boot_img_hex),
+        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
+    ]
+    create_gpt_image(ubman, mmc_dev, required_parts, images)
 
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
+    mmc_dev = 8
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+    ]
     images = [
         (2, 'boot.img', test_abootimg.img_hex),
     ]
-    for partnum, img_name, hex_data in images:
-        test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
-        img_path = os.path.join(ubman.config.result_dir, img_name)
-        with open(img_path, 'rb') as inf:
-            data = inf.read()
-        start = parts[partnum].start * sect_size
-        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
-
-    with open(fname, 'wb') as outf:
-        outf.write(disk_data)
+    create_gpt_image(ubman, mmc_dev, required_parts, images)

-- 
2.56.0

