Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D6606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eC+mp31A;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=If5h7dwH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC8A081141;
	Tue, 20 Oct 2026 09:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsaJG-u7AZvQ; Tue, 20 Oct 2026 09:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3FE98114C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488388;
	b=VOiUeIIjGAw1k2ZZjaryxmlmYiH1808PTCrL1fvq1ciZtmIYrkQ9pTULLIpIk/IhhbYz
	 Lpp8OA9c1fb+1Dki8BJePu9is+HJc2ZfJev88XqUGL25hnQspuGSZ92jJZXL3dKQ0qbhy
	 n3+fR5DzOGfmJnfrDQEnE9JgvgYgFXuKdiuAUPY1vwsFvfpIVl5j5TNy+Q6AIAGJmPYhh
	 0Vlh5ch+q4q0syQRB6QPkm5df2DG38aYpZDF2v+1buJrw06Tw8QgS/tiZH83diYc8NeGJ
	 7f3iXWRH2tQ0nKF2WEo6876a5X0G3ZSzUbUwz93UEGzx1qVHTxwkoy7APaw7vF00abA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=py61AxbK2agDJIaS89/SD2aqMMSXst5QgqQGKhNQBuY=;
	b=qwZf3VFRBtBkWRQqaHIB9ogei0a+Va5sMo0J5q5d05fSX38Hr2aDU16mwVAVHZKa1g2g
	 dZQsmBF9MaT9QXof7yi11p9MK+LG93lxSWawFW5f0P24M4ySxO6Z7HHvYta2z4m65G5tQ
	 WL362RhmV4W+YXkY44+e23V1KAfcn9i7pkXPxRjPQwsUKNnAQhMNcFfep2kTIUReKw4xL
	 M+lgj8XswEu/XHfzgEvoQICNmnHp46MqAuO+m3gPBWJWIVV7dA1JG250UNUb4YizmAI1/
	 507EVIETSSmrng0sfL25+vBW5B4TrSWrZoBQeUpM9lvLsAcZp2biNmWbZA6A6vhrfpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488387;
	bh=py61AxbK2agDJIaS89/SD2aqMMSXst5QgqQGKhNQBuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eC+mp31AR86GFQ0a/AfGbewPUZeLuApTCyHI/rI85CSzqPoT1DQbpaiVHrySBXECi
	 wSLwY0uzOrvG0X3mc2Q+fMKJNxBONbboD4hDY4WVnJ77FoOx/adZfjULDCU7WdqOWf
	 d1kqXSA9jW2EaNckzGm9cz6DvFQRN5wVkcfPfGe0aFw7KSQTeFCRP8X+815ahDDsp/
	 nL9QkYAFKh0mvv1wV5+rHRmaiWKodzuEsHr/p5h6SU+SXdglbK2evCxIoj8urV8AFo
	 CP9qIRI9tnlPj9CY8Q7H85zrMuN+aIbfEL973duWMiVtDhbcv0ZbYWADuHoFbl8ksv
	 WRye6/ZrZJ7yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3FE98114C;
	Tue, 20 Oct 2026 09:26:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB896769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6E244094A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8P-6vsc5YNaU for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44F94408EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488382;
 b=n5Ci9hRzsYezclGmi8vf5LwL1bi6oxPGxR/ra48DJk3Ltc9KlMdsRsf1Hv4b1a7V6zHD
 X0xRJCA47H9iyQhihBIgidLxieXNu4mBWpFXEcWJ0fZxLWPSP1tZBD9yMtgiGz2Gbfb6f
 KXz9l0cSbnX4Tqqr9NqxJW3Zz0gppfL/RQp8DVt/sImhZopLfEezTnZSUW6J6RiiuIcJl
 X+lZGeNFwA6Rq5KjvpcJsNQ/1IXZwU3iyMBWIiaHXHo6vjFqNGWuVobK5TANQC5OqxSD/
 LwOLW4eHgC4Vfqhx2wYs6BFGRt1+bNw6iqmoq+Y4eyd3oc8UGs5uHNKYKwQ3+Bdpiqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488382;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=py61AxbK2agDJIaS89/SD2aqMMSXst5QgqQGKhNQBuY=;
 b=jkVJKd4P+kKwckrsSBAGDxk4aO9Bnt/MjTkj2KCPzZEepFn7AuDFBl9IwGuwsJw1bluP
 Ah5rNwN6qdpaTUkTf37R0F67MhkESZcl6nIRMxPgKkPC9d9yoSKREOHzjRQ+N2n6+de79
 ZnIe1JUGsrxhqI/Es5tEy86ZKqd2JeO4nEPN9qG6uy0aeM3JGjdbwM7p19WEcee/nLotl
 6R1ue2gHbbZDXOOr31hZf7Uc7Fn4EGMRvmlnSCUhGL1ViNsr1fLURZQWJ19ePaOgd/Kxb
 na8IpLhwuozSNV8SdRM1GqRCUf4258pUenunMR2aKMMm89te7R8zcm7VsFEE9ybLLDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=If5h7dwH; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=If5h7dwH
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44F94408EB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF2BD431D5;
 Tue, 20 Oct 2026 09:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9101F000C4;
 Tue, 20 Oct 2026 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488381;
 bh=py61AxbK2agDJIaS89/SD2aqMMSXst5QgqQGKhNQBuY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=If5h7dwHUOHZXIO8pyVWHkEvEDuc8SoONhxPyMv5k4fk7SmfWrO7jWzlGpKdxUYKU
 o11MKPwINd6P9Q3s2abmXgp+2CISisTd8/EtJSsGevxcSzXR11fXCY50/5gncrB4Pm
 D9XhDoxmXYaRTQeEtvzNVsq3B7Elm3XB/9TVhDlAOi6sFXyzPOyhufpnC+AvwvtJhD
 YkCyulXob928/JUjMnDsPZP297cMMjszb/hogzp78Mn7ONZnUR/QrQFI4y7Saiv8NG
 cXEwqcOfMcalAiY+ODDlElBwEjUpfKT7qpg2KJ/18NLFr+teXOMcH6+zuUgzc3VKHE
 Gd6nuByXXk7tQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:54 +0200
Subject: [PATCH v2 05/10] test/py: android: Add create_gpt_image() for
 image creation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-5-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5177;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=6viGMJ/nK/r3R/133d1w/GxqcM4oOOPE6X7ZDZN03dk=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOvdsxoPQQ2UJpI7f5PFwDkYnOaeDCkVAGtW
 v8Q/DuxCKCJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrwAKCRAZDR20Zk4Z
 NQfmCACS8VHW90YJ96oTaDayGf4PQb2DRZuJwycVYlwIZlHq/Ob9nwdgohGxgQYJ4feo2HvX33j
 d9+0CYpHoMaGVh7rb6jxHbo4rnDX2VC8HP+kDiLb1e5cwk/XFQWzDWStQTwPX5WpaSzQsgo/8l/
 ofNaWrAMV9QAekSRsYi9+s9oKJQXeb6Scjk5I9dyGt1BWjJItbp0Gi7upYVpH76Y3l5UyuEKa+a
 ID5vdT7GDgehnFPVD3AAzMpT2LhHiFvFva2NKBGmj5feCIQofsAGYOSR2NNLgwSnwqXn3sP3njJ
 nHSwK2m0QYuT5d3OG/B+n3p8uBd5836XO8x92TyGvRqUwi9C
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

There is quite some code duplication between the image creation for
mmc7.img and mmc8.img. If we want to add more images, this will be even
more duplication.

Add a common function, create_gpt_image() which removes all the code
duplication.

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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

