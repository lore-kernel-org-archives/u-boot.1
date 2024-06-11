Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC96C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71858874E;
	Tue, 11 Jun 2024 23:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Lzxacozs";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="oexdUTo2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485A18839F; Tue, 11 Jun 2024 23:01:04 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326F688714
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.west.internal (Postfix) with ESMTP id 7C8CA1C0016E;
 Tue, 11 Jun 2024 17:01:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 11 Jun 2024 17:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1718139660; x=
 1718226060; bh=kRaHkmS5Il0gzjTDerANdYfM6UjZATXidPdQ3QUu1b0=; b=L
 zxacozsUByu/TRIKCt3ioOIK14UoN/KzWTgo1ochtDMXxOwJobC3geqKmPgTsm29
 cZfzXNj1d6Pm6XtusWR4PpX70mXjAvHdD7hyE1CvVmT+jf3Er6hzjxacsG9iUQLH
 0kiVE5tpTQFHlMkP8ZXmd0JLnzQ8SZ3Qe83BeIoni1TprScmjGTl2FuUNKAMJ9Fo
 PjnXDmgBXNIJ7ophc4bRKnO9ijo6QCssdzXRxVMdGXtnlIekggNIdJGmhlp5X9zb
 fzyicS/9IUy0yZH29xpOZG1bue2bBgHTbMj36Q2eVW998mRRDveXvF9hoRmmvVnh
 3Kh3EGl/Ot0p2889CLTyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139660; x=
 1718226060; bh=kRaHkmS5Il0gzjTDerANdYfM6UjZATXidPdQ3QUu1b0=; b=o
 exdUTo2jM/FYyu3KfBFM8jsbSrIXASKCtHO+VivTI9+YKPmy+kwTIyZiBEx1cT/k
 dIa+p0wLJoA/9MhprDIjNKDMv6MOki8uDmYauPiSGZxW2mR6uJVLnXGlCEXhpU9e
 8pZRd8guiTs5SLoidnfzFM2pKs3JadNIFeh6UKmGMJeKd+CQ6G1Yc3LcSzGRcv7x
 MUhmgeQaBByh+wQjtRrP+UwlnRogpDnFKS6AG6E4moP59CRKY/8sz57QfLiYn/HU
 F9eNO/nt2qfli4TVXlpnbWISzz8HNcT85+i+0dJgzIVDZkoVpGD2ghYnHUZbIVF9
 L13nIc0LxiASsdgDWVCHA==
X-ME-Sender: <xms:C7toZkayx8hI94p4zn90Jp_naYFhxDfnuhZbicusiW24Ees46DLUqQ>
 <xme:C7toZvbnrzsX-SQNQN8W9lU3DqKqHePM4vE7UpUP2GjIhw2mOWYShB3fCP4B6MpoE
 RRuCNXnyZs34ppRPKU>
X-ME-Received: <xmr:C7toZu8fdZZ_OucPiw6jDvoAGId3vT2208FQMgXijMPqJJN1y6UIZkyMEpNn03XT1W9e9BNOINk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvue
 dvvdegkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:C7toZuq-xkFZwl6lq6VQx79KFyHnHIZCd9X4R7MGnitRbwvsANsuCQ>
 <xmx:C7toZvpJIbnJ7imuEET2-I_Zv3oNeEQ9sTDoZ3gk3y_Zh9SB7RjrxQ>
 <xmx:C7toZsS3ATu2H6tjttWR74sjMDX9D9s2CXS2wKGKgS8XT0hG1zUPEg>
 <xmx:C7toZvrnIn5KIoE67aDvsYWuVWMUY5PlYTOwgh4hRF5RKVDj5SZv6w>
 <xmx:DLtoZuXRV91PFNl3G1csb7JjuOgwZiP5OQx1boo40NNZAfUaddAOoXbB>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:00:59 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [u-boot-test-hooks PATCH 3/4] qemu-xtensa-dc233c: New board
Date: Tue, 11 Jun 2024 22:00:24 +0100
Message-ID: <20240611210025.798978-4-jiaxun.yang@flygoat.com>
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
 bin/travis-ci/conf.qemu-xtensa-dc233c_na             | 12 ++++++++++++
 .../u_boot_boardenv_qemu_xtensa_dc233c_na.py         |  6 ++++++
 2 files changed, 18 insertions(+)
 create mode 100644 bin/travis-ci/conf.qemu-xtensa-dc233c_na
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py

diff --git a/bin/travis-ci/conf.qemu-xtensa-dc233c_na b/bin/travis-ci/conf.qemu-xtensa-dc233c_na
new file mode 100644
index 000000000000..fc3b5880e5c1
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-xtensa-dc233c_na
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2024 Jiaxun Yang
+#
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-xtensa"
+qemu_extra_args="-cpu dc233c -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-pci,netdev=net0 -device virtio-rng-pci -semihosting"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot.elf"
+reset_impl=none
+flash_impl=none
diff --git a/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py b/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
new file mode 100644
index 000000000000..8fdb24b284c7
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
@@ -0,0 +1,6 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
-- 
2.43.0

