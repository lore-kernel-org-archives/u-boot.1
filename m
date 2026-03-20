Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1861099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFBF2840AA;
	Fri, 20 Mar 2026 21:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hm2K+cf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B1D83FED; Fri, 20 Mar 2026 21:53:45 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87A5F8409B
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-67bb19ac35aso1449539eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040022; x=1774644822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ilim9B3Vwp38JQC2GZxRVRw4/YC2m2GfdYEubV7T88E=;
 b=hm2K+cf6VSH1H5f2j14NXi+ORZPeoGMhRNugq+bvsr6/X6JDVF/qRZ/MhkU82RitYq
 vV8eXz1u8WYqtp8/4C/0DcjlmcjTpu5+Ai0g1S9RbzgRmCI4CcccKeZkBXvXrBdjtUlr
 Kkj0MW/ll0RD5/DM7WPECGaUDKezRza5r58mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040022; x=1774644822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ilim9B3Vwp38JQC2GZxRVRw4/YC2m2GfdYEubV7T88E=;
 b=K2DDjTQbYtGoeL/z/NEBjIXm2w8/3eNZsVJyTBqweKu7VeFRjJYLOXZsdW6xReVv+Z
 Jnk0cnvadB4cXiyjtOeJAqI44hpzx1CbudXfB7IuJ5ZOBvbgYwF0vQktiqegIIt1eojn
 9vkvoVrQ+wIwkit5Xfv3gr8LIzEO1OiPk5Zc1SB7cLbXSZ+PLa7GlY+ucvZisuZqYqwc
 IQXo/e7uNAL09mmRol2S5/PN7kwFSfsZ1UjMiB+O7m0J6iG9ez2lLwoXoFOeTxNUcI23
 eMXQMAOdpE9jhfFrgVG+5uXfUSUpjY6b5O7cifeNCRgaD4+vnZ1NdmH+g7ekxNgT3l1p
 U8gg==
X-Gm-Message-State: AOJu0YzTw5MF/UTFGh5wNNvk1j4K//NlRRevFDYsOWyTx4KYr6O08Em/
 dyLwEvYvOaguZllrn5jUSFGF5vQtlv06TIR4JHh0J/a3TurvKCOGbNYAghkWauVHQFLS5eN+XM9
 +fINU
X-Gm-Gg: ATEYQzxclmctwrekZ2/VoSm/sdAfB2Guf2quWjA7IZaeTYmsk+T6kBbS+vIdYcSEhcI
 4h8WzbCA5om3j7CCWw1JnOICWALR4zWBYHBaIpm96knMqhUZ5cZyaTNpSPybt5zBoS++F4+uTyJ
 gAGg1S6pYh2V0+ASAHNqSdfiuiuHF1rkQfrYpanifCQeDJC/X6KVVBqmYbmtPsCvtPvWjMALkY3
 gcEHSYnOO/JKhDsj8WS5ETuPr5zHK5mX3UTPPRlvH0Y6U6ewGFMdp4nE1WCoXDIDSD8RghbI4hd
 rjeUZsPPHsdTw+wr6etYduWc+kkdsknTLkaFM/9H/XJ0rG48C6BOT+YsY0RWD9RdouThGYfmYNn
 vvc4DhAV3dqL1CmZjtlykWg4Nv46WnCgal8q/uLpLPCbE/HFr0WkFhNlg785PtjTwtxLmFlbZ20
 rkmRZ+XE2jHlYPX9I+yIQF+u3+ZUhW8hx1Rr4sbn8YxqAHOhn9GaBKowKrJ0szBPziTk1Zratpb
 kyLH5KQ+x3PaaBXcOxwJuCA7HtI+KVrHrbxpU6bbsAj88nNezs=
X-Received: by 2002:a05:6820:f029:b0:67c:1cdd:eff6 with SMTP id
 006d021491bc7-67c22f71b17mr3397928eaf.35.1774040022173; 
 Fri, 20 Mar 2026 13:53:42 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252e0d18sm1870179eaf.7.2026.03.20.13.53.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] lmb: Correct dependency around CMD_BOOT[IMZ]
Date: Fri, 20 Mar 2026 14:53:40 -0600
Message-ID: <20260320205340.3788962-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The calls around lmb functions for these commands are not specific to
SYS_BOOT_RAMDISK_HIGH but rather part of the general loading portion of
the command itself currently. Move this dependency to the right spot.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 1 -
 cmd/Kconfig  | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a56b7aa2f378..2fe3f4fe4d1e 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1164,7 +1164,6 @@ config SYS_BOOT_RAMDISK_HIGH
 	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ
 	depends on !(NIOS2 || SANDBOX || SH || XTENSA)
 	def_bool y
-	select LMB
 	help
 	  Enable initrd_high functionality.  If defined then the initrd_high
 	  feature is enabled and the boot* ramdisk subcommand is enabled.
diff --git a/cmd/Kconfig b/cmd/Kconfig
index f459f6b029c2..4077cdce1069 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -298,6 +298,7 @@ config CMD_BOOTD
 
 config CMD_BOOTM
 	bool "bootm"
+	depends on LMB
 	default y
 	select LIB_BOOTM
 	help
@@ -376,6 +377,7 @@ config BOOTM_ELF
 
 config CMD_BOOTZ
 	bool "bootz"
+	depends on LMB
 	select LIB_BOOTZ
 	select LIB_BOOTM
 	help
@@ -384,6 +386,7 @@ config CMD_BOOTZ
 config CMD_BOOTI
 	bool "booti"
 	depends on ARM64 || RISCV || SANDBOX
+	depends on LMB
 	default y
 	select LIB_BOOTI
 	select LIB_BOOTM
-- 
2.43.0

