Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49816C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 06:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC8482BA4;
	Wed, 16 Apr 2025 08:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aebMGIhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991A682BDC; Wed, 16 Apr 2025 08:44:36 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6F182BA2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 08:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-010.46.114.pool.telefonica.de
 [46.114.106.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 64A753F2BD; 
 Wed, 16 Apr 2025 06:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744785873;
 bh=tcaPKrwgaXVCHkikc2Qbqv+E8akuukBWWjK4JKLrpc8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=aebMGIhPefSIdjLnZ78vVKaFwxplGgyCoWu7eax/LLBUOym7ZGHSIBgTsWukYCTMW
 ui1oE7hJ7NNcGdPw00hdjFdYsp3PkfAU7uUEdCO+YTPk15tDhMhZOH6omjO+qccFR/
 d6LBlvO/A+U1Q396/pqDGYdfrxjTqqME/mVBE3WPIfi9DtWjPY4PQCHnb2DgprdjRp
 aiLnuhriHpPMb2ROiDO0KBcskjczpybyNLwgvHrYbqMNnXunh0TPAaYOkG0aPYivqi
 iWla5TmHI8m5wNRwEI/v48c3Y4ru7yo5bn74dVtkZ2Z1ooB2cRwz4YFIv7hWOua45b
 JDtEK+RYw7Xfw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: dt_qemu: correct dumpdtb description
Date: Wed, 16 Apr 2025 08:44:29 +0200
Message-ID: <20250416064429.30435-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Use only a single -machine parameter.

Describe that the same invocation of qemu-system-<arch> has to be
used for dumping the device-tree as will be used when executing U-Boot.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/devicetree/dt_qemu.rst | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/doc/develop/devicetree/dt_qemu.rst b/doc/develop/devicetree/dt_qemu.rst
index 8ba2b225590..b452e2a997a 100644
--- a/doc/develop/devicetree/dt_qemu.rst
+++ b/doc/develop/devicetree/dt_qemu.rst
@@ -16,15 +16,22 @@ Obtaining the QEMU devicetree
 Where QEMU generates its own devicetree to pass to U-Boot you can use
 `-dtb u-boot.dtb` to force QEMU to use U-Boot's in-tree version.
 
-To obtain the devicetree that qemu generates, add `-machine dumpdtb=qemu.dtb`,
-e.g.::
-
-    qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
-
-    qemu-system-aarch64 -machine virt -machine dumpdtb=qemu.dtb
-
-    qemu-system-riscv64 -machine virt -machine dumpdtb=qemu.dtb
-
+To obtain the devicetree that QEMU generates, add `dumpdtb=qemu.dtb` to the
+`-machine` argument, e.g.
+
+.. code-block:: bash
+
+    qemu-system-aarch64 \
+      -machine virt,gic-version=3,dumpdtb=qemu.dtb \
+      -cpu cortex-a57 \
+      -smp 4 \
+      -memory 8G \
+      -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+      -tpmdev emulator,id=tpm0,chardev=chrtpm \
+      -device tpm-tis-device,tpmdev=tpm0
+
+Except for the dumpdtb=qemu.dtb sub-parameter use the same qemu-system-<arch>
+invocation that you would use to start U-Boot to to get a complete device-tree.
 
 Merging in U-Boot nodes/properties
 ----------------------------------
-- 
2.48.1

