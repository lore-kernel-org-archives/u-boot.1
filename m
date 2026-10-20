Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED163606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yU12lNB/;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ari9jXTZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C67868110C;
	Tue, 20 Oct 2026 09:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SmX8pgzxeJ7y; Tue, 20 Oct 2026 09:26:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C33B81111
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488385;
	b=fky7nZ/iQfuG1x5YOCPj+WYJtoL3ZGIN8pRg3gVzax35psbexkUGOuJwT3pVnkkxb9RM
	 y+yay4Gqzsv8kKdcMUmoTJgYjx/RtayVREnDPXC1EwcJb1ZS2mY3Hv37ezYsCRidkyvOB
	 GhUqXvda6yjB9gqi2qXMguBxBdIZ6/WwntibueOjEaOu+xSI7fx527hn1IcDmKyyfBTMI
	 yAHt4+l24zA7TAe5UeMzK0rIe7ZdFFO3bJePalQs1kgKyH/C6J9moMxYnxE+s2qaVaohg
	 WR41b8KGmPJfzjckFhY2MNjgXV+Hp2Bg+Uhk38KDy6FBe34Ms1KRt8rIoNBnhnvbgAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TrgT7CtWX77uEA5cHRZgvMKa7hIDrnBQYNn9IO1Msn0=;
	b=GBWRKttfOVsL65y4xOu+H8VbqQ/Eh1XGSxuvXsbfX+LFwkMOXdLQ2Z0nos/EBYwsLkn7
	 /Up87uoJqoE6IteSxmYnMD+Zu30bDigkABigZDCIWXsIxfxesV5pTr6iIOYBFHX449NNq
	 kA1viqiD/JG7pVnR7T76J1b7WNneaqmcsuTY3lbIPlbyWgxdJPe9eWGw8mdXRDCkbEpy5
	 1/r82LHFmyX7kJW/wrVQkwYOU3W1Pc1lGEy1CNvn6wizrEoxGHFuyH4RQKxWmcyZiJEeP
	 26xVHaVA3o4CkzAzHeW2MxLP/zhMCDICSEIS9FYzevF/gYvPQ7GMmf4n5hwzwW1/X3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488385;
	bh=TrgT7CtWX77uEA5cHRZgvMKa7hIDrnBQYNn9IO1Msn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yU12lNB/4uAz9pELXmOfZX8bk0enLiefSTH85qn5Kd9pYSCVskDwHLxQdL/sENj3X
	 1GRhZAdeqOOfLNvG5Gv4vMA5XDm80vrYCNntvesfY/n79uqjBS+I9V5ARHkweHM/3l
	 FASNFNXOU9ILMHy4Z5WwWJ/T6UqjBkp5tt/6fozdoh8O+lyP0IDklPuj4ZF5ivuZOS
	 QBXuJVffy1qi2e7Ksdi9pHcn4mPh4gmggzelY2GttR1tBsXNBRnoE6qWk6v03bIACZ
	 Ft/5YqP3xbAj8CV4dfy0ylrw609t2RT8oBQyQHrJJ1cb5LGq6MDJ4IdgJvffyGrVpe
	 irFgknOdliQfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C33B81111;
	Tue, 20 Oct 2026 09:26:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDC4F765
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFCDC6083C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jxl0JYDFk3sF for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF65F60830
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488380;
 b=tJ8KabSLyzhSinNIO1iYBcCk7TX+0xpMcLEhzitDuoiwhm8xu6rvr6qJIjfHLCLadpfH
 aDNLdZeLKa2oCyYEU9xLaBe2hXBkJkDYdzucoMkty5vx+v/GTFTvRTw+0b+Ta52wTIap/
 C5nWy60dqyI6gudH3XxFBqKWq+yh85LWptrcWjrWAeagbNobtkmPqGll4MNnLfydnvcNs
 ibqpMeL4dMCl2Sof8scoZ7ha8IMzaDRoPrzCMr/v3QS4Fin6gBaCPtCH1vpieauLaKdiY
 m06t39+aLkDqmk0OMwlpjaJuuIGLRx1oEHHnH1p/Zh4UwEWVYZht5r3pkfF8o5Ap+MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488380;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=TrgT7CtWX77uEA5cHRZgvMKa7hIDrnBQYNn9IO1Msn0=;
 b=dO0nD+rWWQB2dI75bry9wZkjqbTNQ3PpR22LD8o7VtNOkvLd4Qwt2g3hmw40gcPP26i7
 OE0wUWXOPKSlJ4IBHtuce0eadcG7sc/ls6m/loO6lmaQitvANrsTV/w6wNxWrRtUOdRrZ
 pYPQrX7zuocfDwRqnDxUiLGrYe6K4sm7tg9R5W2GThBIlRYe1NB1Uj3No845htUzzg8be
 pFS1SXcYV1NxCcVzBzhbpSeYrdvvc1T46EF776IkPiNljhVypkinU9akX8gO9QbeTnWYW
 wC8fU5V4w9Uykp880xgvQOZOsZzwCTZr5TJZCEw9TvhqhG7ByCyoxbL6aQ1aDmciPsw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ari9jXTZ; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Ari9jXTZ
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF65F60830
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3D8943AC2;
 Tue, 20 Oct 2026 09:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA11F000C5;
 Tue, 20 Oct 2026 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488379;
 bh=TrgT7CtWX77uEA5cHRZgvMKa7hIDrnBQYNn9IO1Msn0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ari9jXTZN7Cva9q5IvPnw9gaje8OAC0eRETczrOngIPJRLPT1hNKLK3Sld5Y8ZDIA
 tgjeGL1w+sJGOnmyzGKqpZhZcxeK5y5UkTxBE/G0Ee6CLMagwJNL+xrirSjN1bVvfB
 sY+yD4FLQm8TC3oWj1k+p1eNFz66vmeJubTIjRSld1/lgm6ZaMF5moHd+RQnZDykfL
 x1w2dhzzWcWA8YuGhHucWGvufzAOw+8xT3CQjSEEZK2K6nBZ8penlHOtxUimefHlVk
 0/GP2ZRT9U+3PXbAQeXZzUYTW4eErliucADi4WvPoitv6YwVP3REgY2egYiP5ffLC9
 xRm255yU9QFJQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:53 +0200
Subject: [PATCH v2 04/10] test/py: android: Use for loop to create the
 images / update disks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-4-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3902;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=mL5Aqe1u24K4SJfiXIJuuozo1cKYCbIK7hSDLWaLCKo=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOvCEjcfgV2ekMjHHJ39XI1Yv8g7C9IrClUC
 qKd6vVlsi6JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczrwAKCRAZDR20Zk4Z
 NZWaB/9RVi6eXJutwkW1aHNb83s+ET7l5P+9/zETan86hCKMc1fK1X+TC1HjqTHTWBiako7luJW
 pAUQZpciCr3i1zJjnITQua6PY+9ntBGEdQJ8A3w9gHWER1oPrJAu8OftrG+bj1EB6+NjSe89O8G
 iPc5Vl2v817nmvmxMQnPIvdE2lBrnjQd/qmgNq8h9SBmKMUbcbyD1gOxreSNMLzIGOcJ4agW1ea
 72mUIZtTFsqTf3Xqta+++uQ7ot6eQLKE9dg2wCNs0wSz2x/mMTwT3bHs99kixpC9iVTGAMSSAQe
 HN3e8qWet2xhBDzelpjEY6LBXk3jQ+8HWRu+EBqPogKcRo3y
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

setup_android_image() creates 2 mmcX.img files:

* mmc7.img: For boot image v4 support
* mmc8.img: For boot image v2 support

There is quite some code that's common for both images. Currently,
most code is duplicated.

To prepare a cleaner refactoring, move the image descriptions into an
array and create each partition using a loop.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 48 +++++++++++++----------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index 8b536754656e..14dfd26fffd8 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -13,20 +13,6 @@ def setup_android_image(ubman):
     parts = {}
     disk_data = None
 
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
     mmc_dev = 7
     fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
     utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
@@ -68,15 +54,17 @@ def setup_android_image(ubman):
     with open(fname, 'rb') as inf:
         disk_data = inf.read()
 
-    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
-    boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
-    with open(boot_img, 'rb') as inf:
-        set_part_data(2, inf.read())
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
-    vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
-    with open(vendor_boot_img, 'rb') as inf:
-        set_part_data(4, inf.read())
+    images = [
+        (2, 'bootv4.img', test_abootimg.boot_img_hex),
+        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
+    ]
+    for partnum, img_name, hex_data in images:
+        test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
+        img_path = os.path.join(ubman.config.result_dir, img_name)
+        with open(img_path, 'rb') as inf:
+            data = inf.read()
+        start = parts[partnum].start * sect_size
+        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
@@ -120,10 +108,16 @@ def setup_android_image(ubman):
     with open(fname, 'rb') as inf:
         disk_data = inf.read()
 
-    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
-    boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
-    with open(boot_img, 'rb') as inf:
-        set_part_data(2, inf.read())
+    images = [
+        (2, 'boot.img', test_abootimg.img_hex),
+    ]
+    for partnum, img_name, hex_data in images:
+        test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
+        img_path = os.path.join(ubman.config.result_dir, img_name)
+        with open(img_path, 'rb') as inf:
+            data = inf.read()
+        start = parts[partnum].start * sect_size
+        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)

-- 
2.56.0

