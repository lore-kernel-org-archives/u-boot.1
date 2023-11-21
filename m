Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DCCC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 668948762E;
	Tue, 21 Nov 2023 16:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="u8edPeLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5218987626; Tue, 21 Nov 2023 16:28:13 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728AC87605
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1BFF7423D3; 
 Tue, 21 Nov 2023 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700580488;
 bh=BoUxcj5Mel7eFP8oRbKr/XvpGijl4xgBWZ2W1wivNsk=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=u8edPeLYYaPYKYs3PJ1UjQ2A1qV7tYimZapaVggxoko/TNhxuMfldilTKbvHcMaZs
 ohztFZTOTddSFIy3YynLOrPPlHHeUOiL/921KPSeQjBuIq0Beqcu9Y3uXAEPgo/jIf
 Y0xJ4Aa10wHYOHvHw66mcAoh+FvQBiwxDfICEoYz5r9TKFiIKAr7eK90wAy+Zaprip
 oAAAefrbrOfbveQ/SZTX/QYBWYFzSwjLSugVgz6uoUf7gM1Wey9FeO7tzBi6eoUFLv
 HgGxkLYp8D8VpU3VAcxzEcHxPLzy/vzrONvahgT5WFc0lvQmB+qXzhK5WUpCFmiHIN
 7LUmgG9bnTIoQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 7/7] configs: qemu: add config fragment for ACPI
Date: Tue, 21 Nov 2023 16:27:40 +0100
Message-Id: <20231121152740.24783-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
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
---
v2:
	new patch
---
 MAINTAINERS                         |  1 +
 board/emulation/configs/acpi.config |  3 +++
 doc/board/emulation/acpi.rst        | 23 +++++++++++++++++++++++
 doc/board/emulation/index.rst       |  1 +
 4 files changed, 28 insertions(+)
 create mode 100644 board/emulation/configs/acpi.config
 create mode 100644 doc/board/emulation/acpi.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1cb2dc4d..9f443674cb 100644
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

