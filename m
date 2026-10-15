Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CF1CC6B3A
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 676E160A88;
	Thu, 15 Oct 2026 13:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BVF8LOcbN0ys; Thu, 15 Oct 2026 13:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 988F3608D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072530;
	b=bGXeFBT663evn47zgVXBdB06/N5Ab+IXuWQhkwubr8MtMq5MpBZK7yoXIt/K6TgS8TvL
	 SwVZfBVKE/ZBr7+MEHLAS5rkViBZmvzkmmI882rIAjJLaXDI4Lh66u5J4iDAZWqe7RWvE
	 a5G41H8nXEVwOzqy4q4qJ8QKwnj0DDMrqNxO3EVpqmedUeVTvIJpO1XX3SSqYGkedxz8H
	 t8pjDUznBbUE4EelqT0DygxsjNOFWM7vNbftODUcjuLMcTvtVNzf92v65wRmV76kwuJ0C
	 39WfYDhV174joQexkOGSf9U50GNioBZIgGCl0cJMa/i2FUdzfdk8n2o/YWUedstbodw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EZgMMu1nu6X8nzg5ECMqZDozh5jF5nOayjHwKsiFKvk=;
	b=h1A7O36nMYX3kA7vGYe6QkP4gDqblyzoa/bp8/urxi47RrBvKqV8iHd3JfjNgfnoH3DY
	 f1h4kqdgDXz/nHe4ID9BA1ciaFHSbdshOO6q6VhXiWP6s+jg+8huD+NEAigvQ16wkWJbG
	 cEvtqpjcCjdHrFIiyip00HtVdw0kCI3YZELkfSckrWv2ZGiFFGuVHQlklZPcPdku3eIva
	 NVdZHfEwXxqXUZo1wIy6R9oOnuyGv7KKEvzO65hQcXHp6FiSk19/CJkPEOCk2P/JyUsdv
	 +dGKz3A/weq1atNo04XlalYEHBpKjjnCbYGHh73xAP2s+60sJVW76PC4HeJizsY0JAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072530;
	bh=EZgMMu1nu6X8nzg5ECMqZDozh5jF5nOayjHwKsiFKvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ge58ju54NbkvlH34hY3NY1/PoqAdoWTuHMD4OrLuaA1vdUL2A7d3YWlEh0tKkawQD
	 /7W8MHqUGX7kPM5n7o2hny4o3lHSjmvC7EV/UYOql//EgoYa0oEd2OjEvfgjMvhIle
	 MmYflymZkv3dT6kVGbFl4orJdMtj08VG1CF6H61LaYt1Bojg8H5TD8JnSjIWbuLsPy
	 hLzXPC8FRAZGpCzqXFfZYqgv+k3yh0odhN7ym0IqMVB9xkCWMlscELC5FcZ4HEAFaW
	 g9kDPb1Jt1C71+gbm7tcIsLHQz2TCQAK9kV9P9SvqsWD/mpMXK+VEO9CJ+SucBl5gZ
	 hX9UzK+3IpquA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 988F3608D6;
	Thu, 15 Oct 2026 13:55:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 986FE235
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 876858122B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbjmqndstZ-t for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE44381212
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072526;
 b=TzbQagTfwrLXHjjQbRx/driFbkr38CADVtUot86PT2TBKJq+8QjzXNH3epOV/gtKwwFo
 RAWwqnx2uHHMKbUmgOu/MGOeQMtxomv7TS/o5DwzYgV+oGXFczGzMkM+y+Rcl0iYwJ1ZV
 UozzN+oFVfbMek2Fr3sNH2mBXodPVt9nxDL+IyvuNh8rxpRq6MgfPpdHr8Gji1Chc1u7R
 tzFk1SBqMpF9/RBMWkfZ7JiIEA0lJqWSa8CCr+6IdpFoGhxrVvW+mUaNHZ5KP96oMpkFu
 /bh8hrHRLiytc85NtV+vtnqgsxpDczoXDrz074uGmJ9fAEgVA/JT1AhK22huE/wK3ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072526;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=EZgMMu1nu6X8nzg5ECMqZDozh5jF5nOayjHwKsiFKvk=;
 b=jX+eGWjo/nLxzWTyvts307T684rMsLXJnnUAHYykUmno1+KFNEm8iv7Wi2zZo9/0eA/X
 VWuMgdIQ2rv8fwl/XnMR9Xv2OEEJa+uwyJGaV3QOGIWCFkN4PESmUJEUnZiRGmO0GoRRR
 4GS1BJtFiQgdjsms0h7bTR08uClEz1eyLXEzvWqzU14SnZAPMp7xMAmZC7WzKrRoSujqX
 CqVE3imezUpY5UtbGOiuwxuaRYqq/9ZQ9p3x7OQdBMOnVCGr2va3E3+OBC3bMUw669+OO
 uJeeQsjACoj038ZOj2JA/sBny97k9lSDz0sIoL4D9DIva67QuPvh4lK4OuwPd9b/THA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=chHruWP5; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=chHruWP5
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE44381212
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2150643CE8;
 Thu, 15 Oct 2026 13:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8901B1F000C5;
 Thu, 15 Oct 2026 13:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072526;
 bh=EZgMMu1nu6X8nzg5ECMqZDozh5jF5nOayjHwKsiFKvk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=chHruWP591LDTDqcgimdhSpjqzYuS6ctFTQNhiyg0lRz1Nxm1z5mLw0JsliSjcZyC
 tuii99gE1Gqaf4dwrFlqcXC6cV1q3DhRXNDMGkXBn2PTW/2Nf8vsxLYNw7XglNlUD4
 zWuo4yheAMPH6jIlW9i+eVMw8veBtv1c3QBAssp5/vu8BgZ4j9P8EC8W2FRskFxCka
 hWS7LtnDtaiPJpNZsqvxisEXrvUag5fMshrBCy8+d5BMmnlTH9UG8qWbohSr7kmkWR
 9fQ5RPW53wMCCZiiOgoty1x4/OUnVSgYiKBIukXYsaCfE4XZFpt+GJVsSlDefrJDiC
 FtIvJjUgb/Gog==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:55 +0200
Subject: [PATCH 05/10] test/py: android: Add create_gpt_image() for image
 creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-5-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5006;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=eekhmGl9r2aTES2Ow4q00Uhxq6Vr3uGxmR8zA0X99YE=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ9aF2/ai++bYV153X5W7T1R4jZagyaa35t3pbdy2bDziU
 zYkV/N2MhqzMDByMciKKbLovXRavk0+a1+w8FoGmEGsTCBTGLg4BWAiCzjZ/4qd2FXR+qh+md+9
 Rd967DfsmZ6xcf3fJWd3xVq1KW+0f9adOSWV622t8R9Oxkm9x+uLuhP+nuN4b7z1is6Sq3yvO1g
 neallaXT8PblqQv9fxwKGU8qdujk72szimfOd4utvv3lzQqx/3zGWa45Hz6jsDvAycLfq3i2nnP
 VhdZLxZ92yyZ5sZx5Zd10ryFu3muu/0sofL+6viQjYJmG1tsnLrM36wUnvyg/r1nh1hDPG5nJ1S
 vpODvt/4NPiXy4FPY4TRQRMnMUOrErzd2DYfISjOLX4RLpkpKqrhUt6dzcX52FHy2c6tR+ur1xk
 ckggdOLpOql+DtHNkrLBVvNnrImcznp+zXoj6W7V738KAA==
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

There is quite some code duplication between the image creation for
mmc7.img and mmc8.img. If we want to add more images, this will be even
more duplication.

Add a common function, create_gpt_image() which removes all the code
duplication.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 78 +++++++----------------------
 1 file changed, 19 insertions(+), 59 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index 14dfd26fffd8..b5fede8ebf0b 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -7,13 +7,12 @@ import os
 import utils
 from test_android import test_abootimg
 
-def setup_android_image(ubman):
+Partition = collections.namedtuple('part', 'start,size,name')
+
+def create_gpt_image(ubman, mmc_dev, required_parts, images):
     """Create a 20MB disk image with Android partitions"""
-    Partition = collections.namedtuple('part', 'start,size,name')
     parts = {}
     disk_data = None
-
-    mmc_dev = 7
     fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
     utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
     utils.run_and_log(ubman, f'cgpt create {fname}')
@@ -24,14 +23,6 @@ def setup_android_image(ubman):
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
@@ -54,10 +45,6 @@ def setup_android_image(ubman):
     with open(fname, 'rb') as inf:
         disk_data = inf.read()
 
-    images = [
-        (2, 'bootv4.img', test_abootimg.boot_img_hex),
-        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
-    ]
     for partnum, img_name, hex_data in images:
         test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
         img_path = os.path.join(ubman.config.result_dir, img_name)
@@ -69,55 +56,28 @@ def setup_android_image(ubman):
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

