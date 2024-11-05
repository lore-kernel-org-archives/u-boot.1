Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AA2D36113
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 19:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F248900E;
	Tue,  5 Nov 2024 20:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="M1UBW+/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DE9891AB; Tue,  5 Nov 2024 20:31:39 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC40888D8D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 20:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-177.46.114.pool.telefonica.de
 [46.114.104.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DF9123F09F; 
 Tue,  5 Nov 2024 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730835097;
 bh=DVevpThstcypXlSbpAzXbhujEpEEHQf2zivscrshwDI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=M1UBW+/MFE3947cTTQKHyV+yMNM/l8VCGcD+rqNhna0SRvRqv07Lq647r9uA+4o6g
 2VGaf9IVYjtG0LufdVEVY/LgTnb97GXBBY1Xh99zi+ln5EWE373e9932b7T8tZT41i
 wIbgkYXZwdiCqfEjAVjDbnrJkdPcRAVPaXu9zf64wea9G89E8a/emFrKDNnpt7pwwa
 I5QCOQy/X65mRcmvJlQAdLe1Q77tuSHdgTE9BVfFT9PetGOvT0Ivb5bJTI5ZEU4ew6
 RHS3Pze4G0jK0T4RLGpwYDuO2Sx3VOVlz5rxEJpaIR0lKmKLlZQd7SOcp2+GUYCmto
 BCM/F+Rzpx8RA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] board: qemu-arm: select CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR
Date: Tue,  5 Nov 2024 20:31:29 +0100
Message-ID: <20241105193129.28582-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

qemu_arm64_defconfig with CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=n leads to a
build error:

    arch/arm/lib/crt0_64.S:85:
    Error: constant expression expected at operand 2 --
    `ldr x0,=((CFG_SYS_INIT_RAM_ADDR+CFG_SYS_INIT_RAM_SIZE-480))'

We do not define CFG_SYS_INIT_RAM_ADDR and CFG_SYS_INIT_RAM_SIZE for QEMU.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index e21c135e86f..80ab9d8e1c3 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -5,6 +5,7 @@ config TEXT_BASE
 
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
+	select HAS_CUSTOM_SYS_INIT_SP_ADDR
 	select QFW if ACPI
 	select QFW_MMIO if CMD_QFW
 	imply VIRTIO_MMIO
-- 
2.45.2

