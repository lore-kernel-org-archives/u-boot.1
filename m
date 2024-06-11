Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8477C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803A588743;
	Tue, 11 Jun 2024 23:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="DPTwicG1";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbT6/d6/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCFD8839F; Tue, 11 Jun 2024 23:01:04 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605F988706
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.west.internal (Postfix) with ESMTP id AD1EB1C0018C;
 Tue, 11 Jun 2024 17:00:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 11 Jun 2024 17:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1718139658; x=
 1718226058; bh=/pLt6Qjz+E7bFvYpn+mZpAuRl0/0KBhDfJPoE3G7aXQ=; b=D
 PTwicG1OvKsKVwXNY1du6Zhr2q+mgbmMbSIEuBPR2QzwEWDioJIrVqL7Egqdn1jy
 g4HXXVBDzV5SxdWfFjQXP8PTaq5hTqKmDnnXJVCPvMQNMXldayU+mO15+5QLj2q9
 OMv3C3xEbZmH2tdG4AD1v7sdCpdU0l0BytLYkqKR/1tMumLSd8zFVtp88pofv0oI
 h5iOHqsLdMGKAjQXPphizXzZHlE7E8RP7sx+sWxGFwPywBrsyalFasHvOMV0F0Z9
 tmhZkMLMMNZ64+utshnfutv20h4Q7RFMHJ8q1bmf10s3R5vjmsWmffCa4hoxiGrN
 GOfEtx+EPmuPHuX27O3sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139658; x=
 1718226058; bh=/pLt6Qjz+E7bFvYpn+mZpAuRl0/0KBhDfJPoE3G7aXQ=; b=q
 bT6/d6/1kXgnfxDPzDy6YLGRQxCa8+osUD0RR3OAJ4Zu0irUX7kwFkrVg3ccKGD0
 Kobwkm314WPvcTL9DFnylzwgFOohi/NqkWczIQbrArg//NZIzIhYax4J4mr1HQMn
 J3we+J+fitTryCskF+idOyqwOugV1Jo/EqE4dxq01vIdd+y3LgiKJiqtuRPsHLCy
 +t+FrNLa3Ec8VqUSIrh0SNg8GqVHXj3HhnITe3CVAUjURSuAyeNS7fPOwYzL95iS
 KDYenmXakmVwcalxcdMWSdWiwvagQSjOUHHqwWlkWh/3y9o7s/kGYKaGZBGZvdqP
 VZ695SbKUX+8qRRsbCw9A==
X-ME-Sender: <xms:CrtoZhAsdrapZ0OW6PFuoK59pnI5JMstAYuvyqiUL_ffiNW9_Eu0VA>
 <xme:CrtoZvg-naIdJKv4xmKggoEOl_KcUIAHJVXmpbRUZ7ReYFvkSXwpnnoWli3a4kZuk
 2aOS4eRJGAtMauDjH4>
X-ME-Received: <xmr:CrtoZsn3hpcd6C0Giu73QGKlQqmpifC5cOR8InTpYNgmOh591VQcx1pH-B8V4IsBnDvBX_lNKls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvue
 dvvdegkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:CrtoZryCRceS4RkwjOckQeIxvpQ2LW6dc8HzJG4kwtxjLi-EkY6eZA>
 <xmx:CrtoZmRWoRWr6sJpDyq6hNKjXps6VhB70bUzn-XlBJfRZazjz65Bwg>
 <xmx:CrtoZuY8ZgbxZ7yK2-1roiR0-enrUpCQNB3KJv0WoRqRjtDTH1mjjw>
 <xmx:CrtoZnQj5J6TBeBhS5HumezFeCzg8Voxgtv--zKwHwiZMKbQbagxvA>
 <xmx:CrtoZkcZ5988uvPTWeVoDR8K0kJIpKRdicDEKcLwXnsBC_WBiSahMnud>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:00:57 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [u-boot-test-hooks PATCH 2/4] qemu-arm64be: New board
Date: Tue, 11 Jun 2024 22:00:23 +0100
Message-ID: <20240611210025.798978-3-jiaxun.yang@flygoat.com>
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
 bin/travis-ci/conf.qemu_arm64be_na              | 13 +++++++++++++
 py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py | 10 ++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu_arm64be_na
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py

diff --git a/bin/travis-ci/conf.qemu_arm64be_na b/bin/travis-ci/conf.qemu_arm64be_na
new file mode 100644
index 000000000000..3929636932e6
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm64be_na
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2024 Jiaxun Yang
+#
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py b/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
new file mode 100644
index 000000000000..5746b37dbcf5
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot.bin', 0x40400000)
+env__efi_fit_tftp_file = {
+    'addr' : 0x40400000,
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
-- 
2.43.0

