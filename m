Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45488C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B88C88722;
	Tue, 11 Jun 2024 23:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="XoMbBR8P";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TC4LfUus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0638988706; Tue, 11 Jun 2024 23:01:06 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC77488738
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 445B61C00067;
 Tue, 11 Jun 2024 17:01:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 11 Jun 2024 17:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1718139661; x=
 1718226061; bh=grSCFhXDszSlUvT3BiWDqsbWB6VeFAYkZyKzPHEvsK0=; b=X
 oMbBR8PJ32a09MGqatTI23XSP1DedtRkFK6AfM9KfRiDMgk8m8K5FnL8TRbkIiLe
 lakMawRnUdKTHZwRXIBceYott6tnk5Q32L2iLSzplVmEzoVMhrJ8oPNvAZs0aHKr
 zpkolOUxa6+jICl/TC7O9RIcvlP9PMs9Sq6CdFOM8mhyXX3gqyrfH3fu9ks76kYT
 vwfvOqXSHoqO48AorJJvSZG+0OBcyX45vmD5QNaaJvNJ/mDXwtsx7NqCafWwQQMI
 dqehjlHPA3zKHSDWRYqdrC9/jKg5QzT7w1puYksjGSlVGkxL0dOux9D7G2vgqBVQ
 1C1G4+CaObHiAoPtZ9tGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139661; x=
 1718226061; bh=grSCFhXDszSlUvT3BiWDqsbWB6VeFAYkZyKzPHEvsK0=; b=T
 C4LfUuscZXh0gYR1K1c1MqV1PON/43K5Kf50v/IduiOietqvIumh25QDjchdC/Dt
 UhY/JOiBeGeyllJKeoPUQbwQJ8cqgCE2mOIfJxW0P0lJwUedUdFMifPmljrffMI2
 EgTwCQjEtYknKS5suHFNYVVMRjPPsFGxs3GKX8IQc6ZqR9yEk+1ZV3/xzBt5Ev3H
 EaWM89IhfXgwD/c2c9uPICNAwhCUBIP067ItUo6pUm9Ne1Ciwv8xXKW4M5Af6dXz
 ddfH2jVMxFFtSGavM7djWB3/I0lswvNAXaT0U7sgVcJJD9C8bn678Z9KqdJvJSJH
 cUpRVIG2hYXpglUi5ZbDg==
X-ME-Sender: <xms:DbtoZlqsZ8nnVxSjtOPY0Yg3vvlcEonBHN99TDUOuOW6aWzl4Us1Pw>
 <xme:DbtoZnpa6xxspycJnyoR5WGQnvbiZKiPCX_3j3TdiZxlJqjEIGovvDXjkW1HEkhxm
 yMzDHwJWziZPa-4Baw>
X-ME-Received: <xmr:DbtoZiN6V-9C1JJJT_vVZWy7GOTYfl1I0RKYnTDrn1-Mgm27rNcOtD5HvqXJnVtmCRlYZhqfcIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvue
 dvvdegkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhi
 iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:DbtoZg7fIbeZKx2Dd32ABbbS9t9KKYxRd3vmd4ZhG0Y_0YymyXoaLA>
 <xmx:DbtoZk5R_mgqF2rGQvqOEYNxRiBCMSa73L6v6DcMZpfuXqJEnDCdIg>
 <xmx:DbtoZohOI0of06iKF5hwiax8AnNW6jkMvqoozPqUOXRPBmbDrqHu6A>
 <xmx:DbtoZm4xlBGaNNe_2KzKVec_L39HqoPIgWd_9EWhTlDnSguZGFWa4w>
 <xmx:DbtoZin9ozMe2HfqHXtV7X-458NA_hz6SdRsCAMZ3t_qHNbk8HGVVhi0>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:01:00 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [u-boot-test-hooks PATCH 4/4] qemu-loongarch64: New board
Date: Tue, 11 Jun 2024 22:00:25 +0100
Message-ID: <20240611210025.798978-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 bin/travis-ci/conf.qemu-loongarch64_na              | 12 ++++++++++++
 py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py | 11 +++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu-loongarch64_na
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py

diff --git a/bin/travis-ci/conf.qemu-loongarch64_na b/bin/travis-ci/conf.qemu-loongarch64_na
new file mode 100644
index 000000000000..e8860bb40326
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-loongarch64_na
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2024 Jiaxun Yang
+#
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-loongarch64"
+qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-pci,netdev=net0 -device virtio-rng-pci"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py b/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
new file mode 100644
index 000000000000..8a9f747f0457
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
@@ -0,0 +1,11 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_loongarch64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
-- 
2.43.0

