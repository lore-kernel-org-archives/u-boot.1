Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C3BE8385B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 07:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C34C283981;
	Tue, 17 Feb 2026 08:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nqrxFZvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9D983AA9; Tue, 17 Feb 2026 08:47:03 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F24828063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 08:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 356CB3F7BD; 
 Tue, 17 Feb 2026 07:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1771314419;
 bh=n2qod83LE+e5HyqdikoXTLYHWPeDUp143hPc7dnWr0w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nqrxFZvU+uP/lCr5jl3IqE896fzeJhGcYsJkTfkNtDJ4K8Sxfkix2viG+PSGeHULc
 kUqBs35dvp//TTyJv/vHACGNBDQVxkFV7ydaUPgqEY6ZvWtSHlKTvJjN9+rirE/50r
 z4DxeO3eAbt8OiXGIqtJPqnlMoNmZ+UwyMAgRgj0eSaEVysNsiUQK3inRDaJtNefj6
 8tA7GKrj+ttdQ8jvsynJyR1Cx/X8Oc/wN9gCIdGjBRSACsZbCUPVv0VAbNGUjpLOjk
 LGxqA+rjIcpmaHMefYO0a7+8gvQyxYzACDKAkxW67wvrdFBgBAJvLa3cfBtvya3YE3
 RPr74GM0XJyuZdcHH4g7nKYqUcpy2Lv6z9YCjClG01oOspohhLS3sfhpByWeSNsiJ3
 twnb73cQjbQmlLf0EdJFifwWCBelelMc/YViVRwxKLuRPZy6ZU4IoRoQRkt8Kw091w
 wBdA8THpWF85xJB+qxHM1ixksw/xDx65KeDjUM/HmFJ7XfXu9oBs7gbZMtu6nQWe5+
 hVNaBhjjGMDvUn4be8B9oaqtsRdpB4pyi9Bfw92ruAD68o0IpxafvTeshKD5VOW/lz
 4QSHboEU+41pektt5hqZ6SMQJnpDtZauUGfjR9hV3hjMdIhi1Bs8XLidBMK2gNOXS5
 PwKD+GEaoAkUHh2CkXQ2qb5U=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: require at least 128 KiB of stack space
Date: Tue, 17 Feb 2026 08:46:55 +0100
Message-ID: <20260217074655.34137-1-heinrich.schuchardt@canonical.com>
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

The UEFI specification requires at least 128 KiB stack space. Consider this
value as a prerequisite for CONFIG_EFI_LOADER.

Mention the requirement in the CONFIG_STACK_SPACE description and decribe
that the UEFI sub-system uses CONFIG_STACK_SPACE when defining the memory
map.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Kconfig                | 8 +++++---
 lib/efi_loader/Kconfig | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index ce25ea24a60..99b3cd62526 100644
--- a/Kconfig
+++ b/Kconfig
@@ -615,9 +615,11 @@ config STACK_SIZE
 	default 0x4000 if ARCH_STM32
 	default 0x1000000
 	help
-	  Define Max stack size that can be used by U-Boot. This value is used
-	  by the UEFI sub-system. On some boards initrd_high is calculated as
-	  base stack pointer minus this stack size.
+	  Define Max stack size that can be used by U-Boot. The UEFI sub-system
+	  considers this value when setting up the memory map. The UEFI
+	  specification requires 128 KiB or more of available stack space. On
+	  some boards initrd_high is calculated as base stack pointer minus this
+	  stack size.
 
 config SYS_MEM_TOP_HIDE
 	hex "Exclude some memory from U-Boot / OS information"
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d06..450ffa61c0a 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -15,6 +15,8 @@ config EFI_LOADER
 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
 	depends on !EFI_APP
+	# The EFI specification requires 128 KiB or more of stack space
+	depends on STACK_SIZE >= 0x20000
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
 	select EFI
 	select CHARSET
-- 
2.51.0

