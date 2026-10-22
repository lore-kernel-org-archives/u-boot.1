Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714DA606A330
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T8neIMTm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQ4rtm9+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 406D660A45;
	Thu, 22 Oct 2026 13:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1as3NWJ4vQEZ; Thu, 22 Oct 2026 13:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A9F9608DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675855;
	b=P+X75Ue8HD18drySc6jR1Ar0gyHiwrMpN2uGhuHnV2IyziFXd7Q647tMGPtlj0c80mKv
	 wM+HdR+KbeNn1QEBV1DCJCBICarRz+TyuQIyabHhfsONN4W4WjaRNKPLZC6TOH+iCsBE7
	 yMHJRbuoxSVgcN/Q9N2t6O6azVbavNvTi9iL7KGungpdLmcDlb5zo8hF3b3JNGajUsk8v
	 8w6pEO3ShQ2wUDDUr7BwGlEYIYGuQNjMcXXzQcuvlJqZ0a4vpouw/rg2pcMcIIH2MR3Vr
	 qHqJeFMpgj7HlLhSmvDP3d7pnjUJQw6U+vjNpBABj7T0MuJ/SNLlj4j+ostD+/RVXrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ex+EJmCBFG1jxei+5bA3PBtK+SxX7TzuiyRy2eYJ4C4=;
	b=FX/NMXNCIicU37X9yi6vmtW8a2phEge/mDmHhkHPJQ2LGUDfi/XcsjR5/8MWYwMmSTii
	 SrLDH6YYO1B2pfRMFwqgcbtrl5aOwGHx5HIgzaoZQw/PGyEb/tfDPNVw1oqxsBjU+BLe1
	 w+SsbD3mvVLLEd6ocyjNWrk675r6cerKAtabf8Mcwuz0vuUBr9mLkjBKzYBN//iU2Q3R+
	 GHme/r+LQHc6vObCtKOW0r8Y1fPrgL+XC+oT0QLZCByr2ibJfmSfNw+eSBaFb/xnMyk1m
	 AvaQ87UBDv4yLsl2pr6pWTUuGeHAaDhAJkR9m1ZNG2ADW33rZeez9Uxozj0SPYBaVxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675855;
	bh=ex+EJmCBFG1jxei+5bA3PBtK+SxX7TzuiyRy2eYJ4C4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T8neIMTm0+vqcVoql+miVfCcmn16LBnhXlkcKu/glExtf1MGztsXH3ytsup9oNfsF
	 ZlsZH1oltzrq7lLN6WAuzJYHz0JRQ9djwcg7ctKsLWv3r0B6dsZs/XvKF+RgdBIHAZ
	 n5ijlSDF1oAuoV66UiJee8nF8Gm3DlaXEIMRHQ+skIBAYHnKhNMKMryKE2rsvqJk66
	 JsuS6HcPBmr3mFy+/VAmd6vyvV/vyYBgtIqG0wqjLh/P6aCnqrU/WC3Rlk+xyHeqFC
	 2LmbGjzNKGYOigDi1Y5heqeX2mIIv6lkhKxfK9EcQYCzLWPN6+HnGY8nInneUN7hg0
	 2q7MAFPwwHksQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A9F9608DB;
	Thu, 22 Oct 2026 13:30:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BEC53C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3986640932
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Et0bHEh27JL7 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AB69940649
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675850;
 b=USIWdcCiByLyH6qy19T+E1e3IAh4DIlepBxD1vraMsGCOWwT+iOly6JXgOsY7yh29BwK
 hvk41ynEHsZ9j26Fo/xpdb6mc3U33rUC8koEHJ/zKCdg9TlaaYlQYgRP8aLgtQ1Z23izd
 HrJFzMICg3OOPVrZLcTn/q7a7ESR9ofr4zfC9ZHQInokQ2FFxBrikeXyt0dh6KtxTq9gg
 AzBC2qDtIe/5ok2pmop6YI1v1U7/Kw5xKsp7LOvHYOHVlJBCokwIvZSM+bYa2hm6d8A9Q
 LG3Eqw9mPFT7KN+7b4njD8XDTCK28mc3ugzoD2xP1T9Qg98EZKs1Dx0zxN/GtoDL/uQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675850;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ex+EJmCBFG1jxei+5bA3PBtK+SxX7TzuiyRy2eYJ4C4=;
 b=CkcufVOUoQj4abpan4G+c0BM6/TkvCI4h91zFCW3I0gTDVW6We60k4LP39JDzLjrDtiJ
 tfShdkysJoYfWOvXM2m/DAvQSxPS52KQ5NV6Ekf2CqAdt/lUusAAocE4XWmGIUvOfR2dO
 UbluK1+aC4PPniDmLUgLE079K5xHYEWr9TIwQ1V92oTpNW1JSeNxFVWnqpk+oxRWPrWNK
 sZhaRxRvZEak0ghcLc6YIYOz1G0kqRWdPWIJREaXuWNIfZRlyPU9q0Zz4I2Jr5QHbeF+g
 74rzDtpMJy6jbIWScyZ0VRQr4ne9k2sgYl/5jFpJjhsx1SpRbaJgQ2LCeUPDaMyV0xw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hQ4rtm9+; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=hQ4rtm9+
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB69940649
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F44E60261;
 Thu, 22 Oct 2026 13:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CFB1F000C1;
 Thu, 22 Oct 2026 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675849;
 bh=ex+EJmCBFG1jxei+5bA3PBtK+SxX7TzuiyRy2eYJ4C4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hQ4rtm9+XekYifm6ilXM//4eJ3KsPDYTFBvVDvtGCqHVOZkr6mjvP18ch2ZhkRHc9
 eH1sW1L7081Yp2QU5dzlxVLsaLbIs9cPfmtoYTs6+WLIf26W5AhjI8y55ocDTV2bWr
 Wz3Qw/DD6xhUOylFnBX0guRzM5WzquKBKzgnX0RKro0WzY8000iI/M+GXzErdpGSZF
 mRHV05mnxphFfbu8NKbSitI04+0gaXhGgpz02MXrVyn65BfP4/KalWCz3+bYLR/WUC
 EgdL3ZB+xV4tXQL+rw7xKUCv6sfJZwv9Np9w/s6at93/ntx7iy5iIqhbs8BEy5FjJW
 tPmvaHB0e5jGg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:33 +0200
Subject: [PATCH v3 04/10] test/py: android: Use for loop to create the
 images / update disks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-4-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3947;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=oenpuL1JZh+Ar/a0zyZJ8Wj8U56QpptVI7uHlN+mP7U=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/86ucja5GtVKobVWVussA7HV2RrOOwFQVvT
 ukDyEM7Yb+JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/AAKCRAZDR20Zk4Z
 NUDtB/0afllPxaGPW0/HTdlcHw5KrxOv3wo9dElF4XpXSILeRrM8eG+pcicCblLTBxy6o5RXkvU
 L3+rfhJ10aDjHbKH2x+aFUTtMIG5jjf0uzQG7OeHXoeLEgVpZM9Zc4f10qAt/iaYBRzB8InKUdA
 Erkt02bREGX0+REsgntuu/Z0GMeZehc3tV9lB/EWSn0CVDSKWrTuwx1+vpxu4ltbTAAd/tpPWpZ
 cfNu3ga2r/vXpXvc1z+G7bLKgQoLIAKIIsSyIlM192V9+L094/qekSUBFaa4LKvniRZMOhWaUmg
 HH71sxWts3VZDq83HfpUs+4qDgOkBxy22k3Rhun2FwrqIDmM
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

