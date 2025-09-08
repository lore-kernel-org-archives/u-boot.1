Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6E3CAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 13:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FB5809A5;
	Mon,  8 Sep 2025 15:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gcw5s7oR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xjihtIxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271C282AE9; Mon,  8 Sep 2025 15:48:49 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3167809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 15:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cL7b24t0Jz9sc0;
 Mon,  8 Sep 2025 15:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757339326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+tiIfaShm7sejd5IFVhJPI7ohyt6g1kqR9Jqyke+mX8=;
 b=gcw5s7oRFyDW2MgrEZkfzUOfPCmEom5BUKfeFOskW+cVIlHujaA9LQQneaUTCkEG+wXrxR
 GXEsHG/oyawFB7OIgstg/ZGBpmYAF3JeY2W53E/rcOcKzBXOqrep3kT1BtTZ95zvs+Fk0A
 lyWHXKTr13JB8bI4IBm0W1aW17eSZFd+RZOiCP59rUpUHcNXkurPMkjvvx/pCrXAKtiBK2
 NRrkky2hYSF1OFhDOU5+jMrdhf8VRP3ywXOv4+0HbOkoFSMlcqbD+uaIXazQ25OrIFP2jt
 B7YmrC/jKyni+zF9uIs7PUz5kiFs5l1deq8vPVHnYX/JeQX3tl4RtV24obDLag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757339324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+tiIfaShm7sejd5IFVhJPI7ohyt6g1kqR9Jqyke+mX8=;
 b=xjihtIxXTB+imLzVwqfcboZRT9MedeBgl8AV+LusBZ6U7H8w9iV4oefzVk3kxKZcyVsHIJ
 2pjacrTLFwe/pkGA8wWNK/f0z38UhWbSeBJ/hGkAZqT5fuJjnkKgxoFGLfLXfZIJTqNpzG
 bUtyZm3umZnwqFfWdURMLn79tkHkHClc5RiwNuM9VM25vhCp+UI8pFKiajpJ+tvphHgPVt
 wjrZSEhCCuX4TVRf1dSxsR4hu8sBiBUyPIU8pwolpDmFKPZ/bo/iaMVEJouxfBZXF5+NOy
 qCID8hPRh0HEebLOXCcAIYCZC2XQz34fYJv42ekm0m5XTH7d4LtHcleqF8juSA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] boot: Increase kernel size limit to 128 MiB on ARM64/PPC/RV
Date: Mon,  8 Sep 2025 15:48:16 +0200
Message-ID: <20250908134833.38297-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: s75uxto9u5ed3mbmbi5i7w4g5w9u8my9
X-MBO-RS-ID: 46b8893bfb31551ed3c
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

The ARM64 kernel Image size with LOCKDEP enabled is now around 80 MiB, which
makes it unbootable due to "Image too large: increase CONFIG_SYS_BOOTM_LEN".
Increase the image size limit to 128 MiB to future proof the limit.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Martin Schwan <m.schwan@phytec.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2993cd7f9ba..e4c46d50dca 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1056,7 +1056,7 @@ config SYS_BOOTM_LEN
 	hex "Maximum size of a decompresed OS image"
 	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
 		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
-	default 0x4000000 if PPC || ARM64 || RISCV
+	default 0x8000000 if PPC || ARM64 || RISCV
 	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
 	default 0x800000
 	help
-- 
2.51.0

