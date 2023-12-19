Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FCAC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8547E875B5;
	Tue, 19 Dec 2023 13:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AGFjWb6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C2387630; Tue, 19 Dec 2023 13:25:10 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 317AB876A4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2BB26420F4; 
 Tue, 19 Dec 2023 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702988697;
 bh=K4xEA5ljzXFQWhWGTdEZwSgS9m7h3rNSt9dewgMSyUI=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=AGFjWb6C8nhgjwdny044TZAPSOjQOkyFfDPMt66nfVWX7+rDweUQaDpj/QNn+HgXI
 6ArVeGCscZGz7ZP8pJX0DMtpkMBNoVLgo+YRQbV7UYj38BAoSu0KaTQhjmOuGpw/NX
 6vkOKbKnJLFerRijMjGQ1edrDMZIuFDcvLGW31PaBXBIMpsfDPrfHTH+/TTiTnnx7o
 p3xfQ4w/xxrK3GfShxWzzI4EdEnKamWXxGseGnvco8TOH9flH86qlZTvfzJkUbLfOH
 QdXMTqs1k4pKOiF+xKxX/j8mRnDh53goPQl4/PcIduVZY8MGlwGKKnLb5kYm71Q3MG
 XD5oW4HOQveaA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 8/9] configs: qemu: add config fragment for ACPI
Date: Tue, 19 Dec 2023 13:24:38 +0100
Message-Id: <20231219122439.31983-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
References: <20231219122439.31983-1-heinrich.schuchardt@canonical.com>
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

Provide a configuration fragment to enable ACPI on QEMU.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v3:
	no change
v2:
	no change
---
 MAINTAINERS                         |  1 +
 board/emulation/configs/acpi.config |  3 +++
 doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
 doc/board/emulation/index.rst       |  1 +
 4 files changed, 28 insertions(+)
 create mode 100644 board/emulation/configs/acpi.config
 create mode 100644 doc/board/emulation/acpi.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 25f2bb80de..bf437b253b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -53,6 +53,7 @@ Maintainers List (try to look for most precise areas first)
 ACPI:
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
+F:	board/emulation/configs/acpi.config
 F:	cmd/acpi.c
 F:	lib/acpi/
 
diff --git a/board/emulation/configs/acpi.config b/board/emulation/configs/acpi.config
new file mode 100644
index 0000000000..b7ed811e33
--- /dev/null
+++ b/board/emulation/configs/acpi.config
@@ -0,0 +1,3 @@
+CONFIG_CMD_QFW=y
+CONFIG_ACPI=y
+CONFIG_GENERATE_ACPI_TABLE=y
diff --git a/doc/board/emulation/acpi.rst b/doc/board/emulation/acpi.rst
new file mode 100644
index 0000000000..e1208ca51e
--- /dev/null
+++ b/doc/board/emulation/acpi.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+ACPI on QEMU
+============
+
+QEMU can provide ACPI tables on ARM, RISC-V, and x86.
+
+The following settings are needed::
+
+    CONFIG_CMD_QFW=y
+    CONFIG_ACPI=y
+    CONFIG_GENERATE_ACPI_TABLE=y
+
+On x86 these settings are already included in the defconfig files. ARM and
+RISC-V default to use device-trees.
+
+Instead of updating the configuration manually you can add the configuration
+fragment `acpi.config` to the make command for initializing the configuration.
+E.g.
+
+.. code-block:: bash
+
+    make qemu-riscv64_smode_defconfig acpi.config
diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index 932c65adeb..d3d6b8f3d8 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -6,6 +6,7 @@ Emulation
 .. toctree::
    :maxdepth: 1
 
+   acpi
    blkdev
    ../../usage/semihosting
    qemu-arm
-- 
2.40.1

