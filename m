Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1290C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 07:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CDE82D21;
	Tue, 29 Jul 2025 09:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lkx5/HU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB7882F00; Tue, 29 Jul 2025 09:47:35 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FCB82D06
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4D6883FF42; 
 Tue, 29 Jul 2025 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1753775252;
 bh=UTXf0TdrzDobveNJFeLJ/m90ZPEHAdiffFYrwOS0YVI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lkx5/HU95jGwa6J6gTN+rLvuMA9Gm/BN2nwnIlL3+718BxZOSuHLbazCnnEQ0yWl2
 sSf8CoWm1PLfiMgJLDGoYYE12Myiq2tUSCeJtqEv/Fs7ruuNdTHHIKPHMO3VZ62hLQ
 kZj6t8Ee+DpRsGQSC3VfZyjt2fpmzDHBwKKJvOQ15I9aWPSJBjwTPXiVqPKomtE4Pu
 URFhYrTVvd7fHDjp4GaTiNEByMFWB6yqrlYTtcT/5081iwt+LJ30nsy7NMnQi9BlTw
 sQHYJJ6ix9CDA8QXm81cQkb5zIZWmLQeT1uNstxRtDNPC/Z40GS3stAKI5NTt8EtBM
 cQuvW72n2y6PA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: qemu-riscv: describe running as flash image
Date: Tue, 29 Jul 2025 09:47:26 +0200
Message-ID: <20250729074726.31333-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

Describe how to build U-Boot to be run by QEMU as an emulated flash image.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/emulation/qemu-riscv.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index cf2f893b723..b5948d9affc 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -179,6 +179,32 @@ Provide the U-Boot S-mode ELF image as *-kernel* parameter and do not add a
 
     qemu-system-riscv64 -accel kvm -nographic -machine virt -kernel u-boot
 
+Running as flash binary
+-----------------------
+
+U-Boot can be provided to QEMU as an emulated flash drive.
+This can for instance be used to test capsule updates.
+
+Build qemu-riscv64_smode_defconfig with::
+
+    CONFIG_XIP=y
+    CONFIG_TEXT_BASE=0x20000000
+    CONFIG_CMD_MTD=y
+    CONFIG_FLASH_CFI_MTD=y
+
+Pad u-boot.bin to 32 MiB size:
+
+.. code-block:: bash
+
+    truncate -s 32M u-boot.bin
+
+Invoke QEMU with:
+
+.. code-block:: bash
+
+    qemu-system-riscv64 -M virt -nographic \
+    -drive if=pflash,format=raw,unit=0,file=u-boot.bin,readonly=off
+
 Debug UART
 ----------
 
-- 
2.50.0

