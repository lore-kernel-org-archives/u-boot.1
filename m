Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD50C0032E
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 23:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 203318779E;
	Mon, 23 Oct 2023 01:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jqH8hc/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D3F877D7; Mon, 23 Oct 2023 01:37:32 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E108778A
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 01:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C9DDE3F1FB; 
 Sun, 22 Oct 2023 23:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698017849;
 bh=3IHHyYbQ2PDDZWndeyOObtt3edKpvioujSTTwOl4ePQ=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=jqH8hc/Qhs/JbxZ/BnC9dUKw31mYMQduM6ZvfQTmNN6RzZPE3U9hzU9rPx5ZV+SU0
 HoyDcXxjxULzS3cQl6aTsHRhYjgSf5NjCrU2lPTKi85Vw95R35r8bZg4pdmArm4/Bj
 n/EjhCrrAt7Uh2EZ1s+pIE1ZJ38jKHAtfmR7CXotv5bSuL7ZofvV7Q3HjoE799L5Qe
 +dYq64XAut/gRWj2Fgcu3zxSUsy7qCVSCHr7C3Y8SHLpag+CXZgMQwtPICA7rPzb7a
 WmJCGotAAEewSDKQ2kjyJATdFGsWZKPhl9D7o7RKmZBig+SKw8MnUBTDIxsRzHrQPb
 pyGT8d2D0+EjA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] sandbox: eliminate unused functions from binaries
Date: Mon, 23 Oct 2023 01:37:27 +0200
Message-Id: <20231022233727.84947-1-heinrich.schuchardt@canonical.com>
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
v2:
	mark _u_boot_sandbox_getopt secitons a KEEP()
---
 arch/sandbox/config.mk      | 4 +++-
 arch/sandbox/cpu/u-boot.lds | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index 2d184c5f65..c02f0229c2 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -2,7 +2,7 @@
 # Copyright (c) 2011 The Chromium OS Authors.
 
 PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
-PLATFORM_CPPFLAGS += -fPIC
+PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
 PLATFORM_LIBS += -lrt
 SDL_CONFIG ?= sdl2-config
 
@@ -26,6 +26,7 @@ cmd_u-boot__ = $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
 	$(KBUILD_LDFLAGS:%=-Wl,%) \
 	$(SANITIZERS) \
 	$(LTO_FINAL_LDFLAGS) \
+	-Wl,--gc-section \
 	-Wl,--whole-archive \
 		$(u-boot-main) \
 		$(u-boot-keep-syms-lto) \
@@ -37,6 +38,7 @@ cmd_u-boot-spl = (cd $(obj) && $(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
 	$(SANITIZERS) \
 	$(LTO_FINAL_LDFLAGS) \
 	$(patsubst $(obj)/%,%,$(u-boot-spl-init)) \
+	-Wl,--gc-section \
 	-Wl,--whole-archive \
 		$(patsubst $(obj)/%,%,$(u-boot-spl-main)) \
 		$(patsubst $(obj)/%,%,$(u-boot-spl-platdata)) \
diff --git a/arch/sandbox/cpu/u-boot.lds b/arch/sandbox/cpu/u-boot.lds
index ba8dee50c7..d896c6f0ec 100644
--- a/arch/sandbox/cpu/u-boot.lds
+++ b/arch/sandbox/cpu/u-boot.lds
@@ -14,9 +14,9 @@ SECTIONS
 	}
 
 	_u_boot_sandbox_getopt : {
-		*(_u_boot_sandbox_getopt_start)
-		*(_u_boot_sandbox_getopt)
-		*(_u_boot_sandbox_getopt_end)
+		KEEP(*(_u_boot_sandbox_getopt_start))
+		KEEP(*(_u_boot_sandbox_getopt))
+		KEEP(*(_u_boot_sandbox_getopt_end))
 	}
 
 	efi_runtime_start : {
-- 
2.40.1

