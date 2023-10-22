Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8E6CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 06:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBEE876D5;
	Sun, 22 Oct 2023 08:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HM6tDpPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5707C876D7; Sun, 22 Oct 2023 08:29:29 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2BB4876D2
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 08:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 634853FB9B; 
 Sun, 22 Oct 2023 06:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697956163;
 bh=8lWF0Zdw2LorNUyfs34184Ey5/gyUNq/HichnAD/PVw=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=HM6tDpPXOVE5rmYyweYIJw2Aki1j/RC9WcZnChvwm4TPJ1rHFq6JxIU571pJL9Eyw
 QS3IGwa8uIPdi8YwPw4rKuLl3gJm2JY8OLKOzdVB/ELdqEvruhUnf0VhHc7qKR65wP
 OkOBO63/2v0jKJiBPkiD4X0aYUZWXp7nxGgrwgkIeI9h++ToPkpQuxdTi7stpcwrmH
 p3sgbsoiwvIiVi7EJGIv/TTohTia5u1zVyv1qsF3sby3JUx4y1US2274zfbup4f4Gl
 QqVhU60vXgEkIKfuKYkJAXKvOr9aRI6O3jQ5PzndVO2U5BsIrg3yd0hhgta5zvZu/1
 0FbYwGdZPptdw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: eliminate unused functions from binaries
Date: Sun, 22 Oct 2023 08:29:29 +0200
Message-Id: <20231022062929.106169-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/config.mk | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
-- 
2.40.1

