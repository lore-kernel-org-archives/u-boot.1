Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86873E74AE0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDFEE841D5;
	Wed, 24 Dec 2025 09:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oXOwOdAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D6E841D6; Wed, 24 Dec 2025 09:03:21 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E54841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B9BBF3F295; 
 Wed, 24 Dec 2025 08:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766563398;
 bh=BvXCUjQm1a7520OK+KCLbykT3mxLy9mDNCn0aehjE5c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=oXOwOdArPg/TcOTumyOV/geexTC+J43bCYEpCDOwvRqZvHHjGyw9vjbNvkyc8tJ8a
 LSlGqm2Tk4mj0AsB84Y9PIvAux8pGocyAOKORUF6PdhzczKW9Y3CxZZAZpbUB6L34p
 fcK/YIZixz5TBad9vVf3R29faYw2DYLUspQDXyQNINvWn/+3x2D7IHmyCshBSaJMpL
 oXdlMCZ7ftIk/Oo6JNPYZBPtBhqtSsuhXWn+Z2E8x18ZKCpTCL3yT3od5MrO+Tujm8
 UREjcetnmQwkUoLaCM4aBH5pXWiNyFmQFrNtCq1jEDnrha00igQUthJXcC4LNZSMjt
 kOtIoOtoaazJBAvLszVUi39DQ6sr8nllVIm0U6RG+1TPQTAtOuDFBgwfYpJzbHI39v
 zOSWE30bWeIJ9XV0yvChoMluao4lot3wbcEXc01WFagyfJQhMgQekIEEfMnvNioLcL
 nPOuScb2ozS6IU1Slw1DBluhbuHcV+5hjENjZ623b04YswYTYA8rnlriDlGW3hxlN6
 PcNndR6Z/hIvEq0udhYX1rULVXuQ+dJBzxNjq+LCsrnbyve7r2hhO+JgRWivQdsRet
 EpFsMSHg8R+9WvUOESg9sT7DzBxp9U8ktxUoYGlJCSVci1qgUXnVj7d0LAoeh+yock
 lHOxqY6g+b8pHzwqm5z1JhC8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Stephen Warren <swarren@nvidia.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [U-Boot testhooks][PATCH v2 1/1] py/travis-ci: add
 u_boot_boardenv_qemu_riscv64_smode_(acpi_)na.py
Date: Wed, 24 Dec 2025 09:03:14 +0100
Message-ID: <20251224080314.17188-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Add missing boardenv files for

* qemu-riscv64_smode_defconfig
* qemu-riscv64_smode_acpi_defconfig

to enable network testing.

As the environment can be the same as in u_boot_boardenv_qemu_riscv64_na.py
use symbolic links.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	use symbolic links
---
 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py | 1 +
 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py      | 1 +
 2 files changed, 2 insertions(+)
 create mode 120000 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py
 create mode 120000 py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py

diff --git a/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py b/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py
new file mode 120000
index 0000000..7745909
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_acpi_na.py
@@ -0,0 +1 @@
+u_boot_boardenv_qemu_riscv64_na.py
\ No newline at end of file
diff --git a/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py b/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py
new file mode 120000
index 0000000..7745909
--- /dev/null
+++ b/py/travis-ci/u_boot_boardenv_qemu_riscv64_smode_na.py
@@ -0,0 +1 @@
+u_boot_boardenv_qemu_riscv64_na.py
\ No newline at end of file
-- 
2.51.0

