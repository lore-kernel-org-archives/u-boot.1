Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E7DCC6B3D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30DE040917;
	Thu, 15 Oct 2026 13:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ni1IGJ4W9F13; Thu, 15 Oct 2026 13:55:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4727D40910
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072532;
	b=La5nQPj5jFD5cagrHk5lCoc+O04P6Q9PAvKo/iGJgOWwFXJMFjLhnEKQEJ09Cj2dZ655
	 P/6ZicmS9BoFU+bOmRiGKF+0D+nSA4uDLOPU5nQkQYuCNlN3coODq5Skyhf+qdDqoMvP/
	 J30CSA+Em148AmcKFvWpwZ5XxzIAIOw1bR6YMOhejIKCPPu3gYOfWVB/t1ngELfaw5VnZ
	 8DJuhUJaBAP49bmefX58OoH0e8iOnNlmA/HGqc3UUuRGNTRigdPwE/QO7GCRtAP7uwskX
	 VG5L9594Sh4VJ7ZmRYwd7R30vz7EkpS0mG6r+6yL3gdYC6C2a7r9OFmppkDvnHmf0kA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SKqnE6yvb30CCxHZZuDYtZy9HcwHnW/jEr9yMDv/elM=;
	b=KVNFi/iLhJzpHnxcehcUtk26TT64lCAE99E+6RoM7r4m6TYqMKGHV8HX0kjfcMXixpjs
	 3ZFifFa6I3J9MrWxE5JGc+vCz73DhYkp23BkRUowS7Og+jjMCeWh2KMTdqF2QbttZ2ztC
	 5Y41/3a/xFBmbg1XiqxJmormPlCTqAL0Vr1Z3VUcuayxut/XvT/BipU0jQvvMd2Tp3HZr
	 VgqfXkBTfcJUKaE2OsdsKG4WIGiZG01ZFVN4PKPLZjHi6BZYGmUsU71arwY/Vu+85IMO5
	 1NMqjSHJsf71rc4b2Qk76jeNR3T2v9AyjEkLUSYFwdcx+4hba1vBPp0SXX7hnLbWQLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072532;
	bh=SKqnE6yvb30CCxHZZuDYtZy9HcwHnW/jEr9yMDv/elM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kPeW1Y0T/Wy5uQNqWKBueCS+mDk9+PRsOC/lh4gtcg9UJLJzzOXB9YBHF+3X7Jomt
	 dWqPW/unLqo6ZGeiM6JZSQ0AwzmFDui0fTAROURyRaM6iQI1Q/HiAyE3BY5CLs1Lmw
	 cOGXPTIuTIaWpFe3LhOhD2gaMI3W74LUYkaMcp9oWRBY/ZnPoHmaxQUFZKwV5AooT1
	 iHBoIHe3PGA/JVWF3tTD8XMfzD/nG1r1/V66apPhcrNf/MOyJXgKjTsEGOiSuMCdpI
	 5sxpr121xGOlcsVYTVPf0amjEhTWebjeVsWHbtzaGoXCkD51zpWTl2kMXJ+eBGprWZ
	 r8b89JC7R4guQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4727D40910;
	Thu, 15 Oct 2026 13:55:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E35542E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4FB560A85
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7VescDTKOsxJ for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2034D608D6
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072526;
 b=BfWrGLIAo8NmXKmzpk3+qIHy28g7mBADSakWkuvXxKtHpwS8DhwJxX0zYMYAdOVQZ4++
 O7Qa0DAAbnk5P5na6sql2u9o2ZlKRYMYeIImKMKlshZXlPWk6ISZB13Q3b2NEHo+CIWT8
 jwP4/x6fXOItPXlsrHeKVmrTh08lmD02Y7qOq8nTxWvGcpaBKF3H92yV01v8APUcjmRAS
 OZWuOvHUhgLZGjAs0URJALN7P/HPAaFyZ5cuwg9VHum/GMZFDf7RDHLfy7ZybvEG1yo/t
 tWzF6R/vxGj+z0ecATDoZuhR/v+AhOrHkmbOGqLPdm0OhRXUuwgvtB7vxmeC1nwHnxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072526;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=SKqnE6yvb30CCxHZZuDYtZy9HcwHnW/jEr9yMDv/elM=;
 b=kOEFvP4wbG69pJjORkO/TdHaCyiEFpmR/a34FnB/SVm27XQ9zfUY6YWaRFCYl16a6001
 UwCBdTEpX7FMb3cUKOwcpy4nTHVo94jXdBhttA9Rc+ozDtYrvfHvONhUcVrdyhA3usNsI
 fGNY9ukmpB3cC9NFGt/9qsmcXwNhGxn1Qc+HMXpvSAEmfUnUZUHkQDTfpMn+++XhnFWF2
 YHut9awdCEYhm0b71I3IwhqGn0UkA42TRq7dM3e0PKvBLIokWpdzaeNvxhXJzpgKwkf9m
 0g9lUkfsdpx66DzUr/cjRtcwoDzdBDy5z9nSmJm3nZq+/RlxFyV2c/xUwYwoLb+vcAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="lD4WUDU/"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lD4WUDU/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2034D608D6
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07BFA601EF;
 Thu, 15 Oct 2026 13:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B6A1F000C4;
 Thu, 15 Oct 2026 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072523;
 bh=SKqnE6yvb30CCxHZZuDYtZy9HcwHnW/jEr9yMDv/elM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lD4WUDU/6USw0Xpb3+7II/v8FyyRymSU57CH3DRLZq4QcrvamUsmc2RZAM7hkF8Pl
 0Px5msKHA24RS0LLbULRC1WvXT6XdXvt4p9cprESuuLiZxB4tYxzh1fytuV3nmS2J9
 L46ypKOM6aJQ1c17apUYcdcEX71nbqL0YiLowjtC8eppuiNZMU87irQHFmYKoqC+Q3
 xqdN9miocdykMhCOLdQwzZPj+V3S8vau5AS6/dFKi5FSNsnbDf1Gb22Dr2tef/P5Hn
 D5xcwAzysKJLvkx0u+MFqtNbKGCO7u03Hs8QvtiFGnuJS9mTOc1+kLcsO+BV9fBGMO
 wmGSyXxIdLJ5Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:54 +0200
Subject: [PATCH 04/10] test/py: android: Use for loop to create the images
 / update disks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-4-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3674;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=05LBZv2nsKui1P0vcz85dg3vuTAjTglT+BUjVKjDB2g=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0Ns/wf8zPCne5eulc7oeg3g3uxRFFscybijmc
 YJBPXBMNgWJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbPwAKCRAZDR20Zk4Z
 NfB/CADueMLSur6Qkt+4kcEYTnaN8mQHm75UnixomA4LyF1l6SELFhNbZGFs0C7tS+YO/ZDfwz+
 WoszW/84kH2cxzHGqaBFba6++7Yz5ds1rsznrYYLq3kBn/DZYwVVjzLO2Rnw5neLCZEzmMSuwXK
 9B7OSEkTKmQvivGT8HaxNf39oBku9Q26CPdfL445N3rCvf/ImlI6l13OpWETs45ptWrhLFBxaE0
 UJ76MMKa8BU2Xh0ddJxnlDOJ0LwrgniqBMCDrYlQsUGH/RfgZmsSuiDvmBYTSjtzAnMeI4P/9UG
 6YbZZBonYKAwZZ2UXFNsMg7zass/LhM0W3UKedmsZWwOSxRm
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

setup_android_image() creates 2 mmcX.img files:

* mmc7.img: For boot image v4 support
* mmc8.img: For boot image v2 support

There is quite some code that's common for both images. Currently,
most code is duplicated.

To prepare a cleaner refactoring, move the image descriptions into an
array and create each partition using a loop.

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

