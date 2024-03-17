Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6CEC54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 14:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5350387E2E;
	Sun, 17 Mar 2024 15:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L09pWTuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524BC86F67; Sun, 17 Mar 2024 15:54:53 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C86876BA
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 15:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0080560AEC;
 Sun, 17 Mar 2024 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9182BC433F1;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710687289;
 bh=W/VbIpCvZRDplOLXLtFGQiPxIAPwMPHxXMcJ4WlLWFA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=L09pWTuOPVkz8TuQAxOw9yD+e2hRCEWDMEg/pjeYNBGtdpr9ilBG4SruMRUJeGZYT
 pWft/DL7M6k0CQd9BL0VpJ9YkTav+HQL5JDaUNEarrRKxEesvGhP/XVmtumwx7oKO8
 zw3uP8NtmMmD3+FPqINSmd8nB9l4AkSyWDpal5NEjCbAxmslSNRMLmC5zy1CBnTwET
 Wgzs3lEhrkFRF6zuWF76/BqiVRi91OAxmnVsmmk1e1YfmNWSB5vXzE9789DsOLKsKp
 zH7oWAkWxAOGZOX8JR74D6911DcBP5i3sKPHeyLdclVL7R7fBN2jEprPGQUZ7epyl0
 c13xDDIH+VPeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 84C18C54E72;
 Sun, 17 Mar 2024 14:54:49 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sun, 17 Mar 2024 15:54:50 +0100
Subject: [PATCH 4/4] arm: apple: Switch to standard boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-apple_config-v1-4-1b862bc140a9@jannau.net>
References: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
In-Reply-To: <20240317-apple_config-v1-0-1b862bc140a9@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=j@jannau.net;
 h=from:subject:message-id; bh=crjeE1IUF+rCa9w41oK3inDEucGXM4uquwiVSADZxhc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtTvLBZ8rklbnTjUW/wP/JPO5/6z+ma4TOHMM09ffwjY+
 1Ws5v/njlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABN5LsjwT/PXdOdjFjrccdYl
 T64oHb/76I7xg8jeJt4TVq2bllz+ycXI0MiuumGxecDBWxwSVufSmC/n3w6q0VJfJ37S5mmDQKo
 6EwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Use standard boot instead of the distro boot scripts.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm/Kconfig        |  2 +-
 include/configs/apple.h | 20 ++------------------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01d6556c42..ad89abde41 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1034,7 +1034,7 @@ config ARCH_APPLE
 	select USB
 	imply CMD_DM
 	imply CMD_GPT
-	imply DISTRO_DEFAULTS
+	imply BOOTSTD_DEFAULTS
 	imply OF_HAS_PRIOR_STAGE
 
 config ARCH_OWL
diff --git a/include/configs/apple.h b/include/configs/apple.h
index a70440b3ad..1e08b11448 100644
--- a/include/configs/apple.h
+++ b/include/configs/apple.h
@@ -9,26 +9,10 @@
 	"stdout=vidconsole,serial\0" \
 	"stderr=vidconsole,serial\0"
 
-#if IS_ENABLED(CONFIG_CMD_NVME)
-	#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
-#else
-	#define BOOT_TARGET_NVME(func)
-#endif
-
-#if IS_ENABLED(CONFIG_CMD_USB)
-	#define BOOT_TARGET_USB(func) func(USB, usb, 0)
-#else
-	#define BOOT_TARGET_USB(func)
-#endif
-
-#define BOOT_TARGET_DEVICES(func) \
-	BOOT_TARGET_NVME(func) \
-	BOOT_TARGET_USB(func)
-
-#include <config_distro_bootcmd.h>
+#define BOOT_TARGETS	"nvme usb"
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	ENV_DEVICE_SETTINGS \
-	BOOTENV
+	"boot_targets=" BOOT_TARGETS "\0"
 
 #endif

-- 
2.44.0

