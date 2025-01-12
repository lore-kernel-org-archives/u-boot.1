Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEDCE77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6636280079;
	Sun, 12 Jan 2025 23:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tHR45cbf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d6ZhfLvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C33800D2; Sun, 12 Jan 2025 23:33:11 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77DA580027
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YWVXN0bclz9sbY;
 Sun, 12 Jan 2025 23:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=z9t4BgCQ0ELtqDaiq8IsYcYkqYICJLlD/srL/phGrfc=;
 b=tHR45cbfGLv3kScV2ua0vVf7nZ+m2RVmmnA5chyuFhaMuEsyKT3tfYuRbtoV7qnkWtXuh/
 wSBk+1RFYbd41uWS8UCugfD51G6/j/w/R5kmds3+k31bE4apmszXv5kZzoR8oJ7FsjJ8yP
 GuDLY6ocWAPrHeQYljDo9AihT/Q5JunwJXIYnFqbSgdYeUx0wjE3OsDXBCF7BK67z3JVYp
 aQdvAkMxIEJQVk/UFibwTZaQiijBqpgoXySg4YpGIVrhnTz7OwTeRExr1WWnjy1YR43UGl
 uho5zoKt1ERvmRN1M7kAkG+OuSN8FKA8EX6+c3WQWzf479KjgnEYdI02Mw8uqQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=z9t4BgCQ0ELtqDaiq8IsYcYkqYICJLlD/srL/phGrfc=;
 b=d6ZhfLvjGs4V9w8yofKw83nT+icFdRkv5QYiwa1lI2Pup56X50Jhm5UNErdZ+235skTiE+
 LFv8M4+VhjGXFQX8UNgJb8JJRBPq03BOGOpTLiCzqtXkWVkMqKCpPuqPnNSJF8qrInj3/h
 BRfwz8zGqUwQGmReiLOu+6yzC+lwj+Kw50zX7vXjubi3P1vTojwNvcG9/6JROUMIK9pOp0
 pTbRg3TE3A2As7gBP0f+pe+MPJKW4+xKmtgIfU1Lh65IPIi2pNuWn/eSwxzjnW5Ve+qY92
 ZBxbVciRezE42BP6sFnKwidqsHs30tOkvQa6Ym/9xX8oNVT3Cjj8gsi/hndHXA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] Makefile: Make sure all linker input objects exist
Date: Sun, 12 Jan 2025 23:32:38 +0100
Message-ID: <20250112223252.179123-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rcwnizkzsbm7rzi5d1jkdbeuts9kx7s6
X-MBO-RS-ID: 4202ba9d89e493ff437
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

In case the build system builds a directory with empty Makefile,
one which does not contain any obj-y entries, the build fails to
link due to missing built-in.o .

This happens because of this part of scripts/Makefile.build
 81 ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
 82 builtin-target := $(obj)/built-in.o
 83 endif
which does not assign builtin-target in case obj-y is empty. The
built-in target is then not built at all, and built-in.o is not
generated by this part of scripts/Makefile.build
 325 ifdef builtin-target
 326 quiet_cmd_link_o_target = AR      $@
 327 # If the list of objects to link is empty, just create an empty built-in.o
 ...
 335 targets += $(builtin-target)
 336 endif # builtin-target
This is the correct behavior.

The final link however expects the built-in.o to exist in every directory
included in the build, even in those where the aforementioned code skipped
generation of built-in.o . Make sure the built-in.o does exist for every
directory used in final link simply by doing touch on every built-in.o used
for the link, which will create empty built-in.o in case any built-in.o is
missing.

A possible alternative fix is the always define the builtin-target
and always generate built-in.o .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bryan Brattlof <bb@ti.com>
Cc: Greg Malysa <greg.malysa@timesys.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ian Roberts <ian.roberts@timesys.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 Makefile               | 5 ++++-
 arch/sandbox/config.mk | 8 ++++++--
 scripts/Makefile.xpl   | 2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0500eb6e0a7..03df04853c8 100644
--- a/Makefile
+++ b/Makefile
@@ -1779,6 +1779,7 @@ endif
 ifeq ($(LTO_ENABLE),y)
 quiet_cmd_u-boot__ ?= LTO     $@
       cmd_u-boot__ ?=								\
+		touch $(u-boot-main) ;						\
 		$(CC) -nostdlib -nostartfiles					\
 		$(LTO_FINAL_LDFLAGS) $(c_flags)					\
 		$(KBUILD_LDFLAGS:%=-Wl,%) $(LDFLAGS_u-boot:%=-Wl,%) -o $@	\
@@ -1792,7 +1793,9 @@ quiet_cmd_u-boot__ ?= LTO     $@
 		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 else
 quiet_cmd_u-boot__ ?= LD      $@
-      cmd_u-boot__ ?= $(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_u-boot) -o $@		\
+      cmd_u-boot__ ?=								\
+		touch $(u-boot-main) ;						\
+		$(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_u-boot) -o $@			\
 		-T u-boot.lds $(u-boot-init)					\
 		--whole-archive							\
 			$(u-boot-main)						\
diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index 405843800e9..dd9b7473fa9 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -22,7 +22,9 @@ SANITIZERS	+= -fsanitize=fuzzer
 endif
 KBUILD_CFLAGS	+= $(SANITIZERS)
 
-cmd_u-boot__ = $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
+cmd_u-boot__ = \
+	touch $(u-boot-main) ; \
+	$(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
 	$(KBUILD_LDFLAGS:%=-Wl,%) \
 	$(SANITIZERS) \
 	$(LTO_FINAL_LDFLAGS) \
@@ -32,7 +34,9 @@ cmd_u-boot__ = $(CC) -o $@ -Wl,-T u-boot.lds $(u-boot-init) \
 	-Wl,--no-whole-archive \
 	$(PLATFORM_LIBS) -Wl,-Map -Wl,u-boot.map -Wl,--gc-sections
 
-cmd_u-boot-spl = (cd $(obj) && $(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
+cmd_u-boot-spl = (cd $(obj) && \
+	touch $(patsubst $(obj)/%,%,$(u-boot-spl-main)) && \
+	$(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
 	$(KBUILD_LDFLAGS:%=-Wl,%) \
 	$(SANITIZERS) \
 	$(LTO_FINAL_LDFLAGS) \
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index dca5f4539d0..abc49fbe6c9 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -510,6 +510,7 @@ quiet_cmd_u-boot-spl ?= LTO     $@
       cmd_u-boot-spl ?= \
 	(									\
 		cd $(obj) &&							\
+		touch $(patsubst $(obj)/%,%,$(u-boot-spl-main)) &&		\
 		$(CC) -nostdlib -nostartfiles $(LTO_FINAL_LDFLAGS) $(c_flags)	\
 		$(KBUILD_LDFLAGS:%=-Wl,%) $(LDFLAGS_$(@F):%=-Wl,%)		\
 		$(patsubst $(obj)/%,%,$(u-boot-spl-init))			\
@@ -526,6 +527,7 @@ quiet_cmd_u-boot-spl ?= LD      $@
       cmd_u-boot-spl ?= \
 	(								\
 		cd $(obj) &&						\
+		touch $(patsubst $(obj)/%,%,$(u-boot-spl-main)) &&	\
 		$(LD) $(KBUILD_LDFLAGS) $(LDFLAGS_$(@F))		\
 		$(patsubst $(obj)/%,%,$(u-boot-spl-init))		\
 		--whole-archive						\
-- 
2.45.2

