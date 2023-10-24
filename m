Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13715C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 06:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A24A870F8;
	Tue, 24 Oct 2023 08:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="L5D24yDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54487870FF; Tue, 24 Oct 2023 08:31:06 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F152870F1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 08:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 85D153F6E0; 
 Tue, 24 Oct 2023 06:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698129062;
 bh=XEZRri4NZfqYI9V9NUynxRAe17blfcX7HeT1hX0VL40=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=L5D24yDZqTu0hWdvIyLtjVHrDQMMTy5eiWSjgWGE1cdfGR+RmnfzLZE+Ci5Qebmqs
 lhDpv/C5MGQef2G1GffVo1sL6/Mcr18dyYGaPSK46UtcRqlaqyTNAYLSiIHuh+ivzn
 y8HwN9cHATsjsdnQNChxP1vtfMlUKX2pE5cT+M9+t51VJmEp8P0WuNZfON2sUHK3N/
 JrVTIZ3YphEKxfo3/5JNXp+sKwW8khJ+sYVrl55TuNcSJ7eTvjMfAIP0c33j0wp+Xy
 1Wc1TaH3yvOKFJpx2I0dx5cu5qP0yx8VDHyguPmHnoomnIry6zQphWtEcvtUDjheRn
 wfHRyOy8PISLA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/1] sandbox: eliminate unused functions from binaries
Date: Tue, 24 Oct 2023 08:30:47 +0200
Message-Id: <20231024063047.20874-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

The sandbox should closely mimic other architectures.

Place each function or data in a separate section and let the linker
eliminate unused ones. This will reduce the binary size.

In the linker script mark that u_boot_sandbox_getopt are to be kept.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	avoid duplicate -Wl,--gc-sections
	only use KEEP for unreferenced symbols
v2:
	mark _u_boot_sandbox_getopt sections as KEEP()
---
 arch/sandbox/config.mk      | 4 ++--
 arch/sandbox/cpu/u-boot.lds | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index 2d184c5f65..1d50991f8d 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -2,7 +2,7 @@
 # Copyright (c) 2011 The Chromium OS Authors.
 
 PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
-PLATFORM_CPPFLAGS += -fPIC
+PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
 PLATFORM_LIBS += -lrt
 SDL_CONFIG ?= sdl2-config
 
@@ -30,7 +30,7 @@ cmd_u-boot__ = $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
 		$(u-boot-main) \
 		$(u-boot-keep-syms-lto) \
 	-Wl,--no-whole-archive \
-	$(PLATFORM_LIBS) -Wl,-Map -Wl,u-boot.map
+	$(PLATFORM_LIBS) -Wl,-Map -Wl,u-boot.map -Wl,--gc-sections
 
 cmd_u-boot-spl = (cd $(obj) && $(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
 	$(KBUILD_LDFLAGS:%=-Wl,%) \
diff --git a/arch/sandbox/cpu/u-boot.lds b/arch/sandbox/cpu/u-boot.lds
index ba8dee50c7..52f13af374 100644
--- a/arch/sandbox/cpu/u-boot.lds
+++ b/arch/sandbox/cpu/u-boot.lds
@@ -15,7 +15,7 @@ SECTIONS
 
 	_u_boot_sandbox_getopt : {
 		*(_u_boot_sandbox_getopt_start)
-		*(_u_boot_sandbox_getopt)
+		KEEP(*(_u_boot_sandbox_getopt))
 		*(_u_boot_sandbox_getopt_end)
 	}
 
-- 
2.40.1

