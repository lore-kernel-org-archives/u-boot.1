Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAC4D10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA2089140;
	Mon, 28 Oct 2024 13:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TagEkK6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9728B890F8; Mon, 28 Oct 2024 13:48:36 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E8D889140
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a0cee600aso553362666b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119713; x=1730724513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAz3x/71XCjq6jhdiRVq8EiJsLdFnMU3Bf5vQQSeKiA=;
 b=TagEkK6Xq1bjvCoaFtdOmCba1XB6Ew0Pv+DkfviITpaR2Ahh/te8gfY0cClhUz1G0V
 VJfDpNXi3b+itdmQs5iNN4zkhI2hTO5qV7qY1BKOOHxBhaHqoYa0fwKBfWl/u+gAg2hC
 H/Taa+aB5IFQcOE/toOg/+0FcRUDCgOUmTc2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119713; x=1730724513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAz3x/71XCjq6jhdiRVq8EiJsLdFnMU3Bf5vQQSeKiA=;
 b=ZaRlbtfHUM97my/qcCIEF3bvIXZkmeFqm2Vprx/36tlkSznPdtKZI1s7WzgT2Lglua
 Xd16wzG0E9bLdOZ4A8XZrXgfd/zvOHAMY5ykRrCbi7NzYMVRWwCE7SWfyCpJYFTy93b3
 3faSTAl+HpNXqjsbaXnV7bhtPCEQq69sjA3ikWJauhatNMCdLSJ3SHl3HbGLi/Quuvot
 z7urd7roH7wJCs+4oQ961G3zNBtGwgWoaeGufVYt4KFYAWUl4KUwJGazWIykII/bJLbF
 +kyogVYneGXf2nmkTofOSSXF/+rdh/kUClblJlyKldXHuSQnBuZVSzBF6rD7vTDq7cpz
 Zt4w==
X-Gm-Message-State: AOJu0Yyw2DjPwySVUpbVwXgNtCUDsdYJhHefkIVcHYLQJkHlbWq3eAbw
 BHCQSLzKz5poq2hO4/BUe9mlbv0Ywe+C9LhmQONgVNzQhmbeRh8bJIBRBDbFTLbgaWgNcOujWr9
 W7A==
X-Google-Smtp-Source: AGHT+IGExkeyfQ5ywTTpTt80xeq8pWEKEyXlTrElBmznKd98PqytQJ/cgC14dr4IYwE9EAHkjtQEww==
X-Received: by 2002:a17:907:7f16:b0:a99:dde6:9f42 with SMTP id
 a640c23a62f3a-a9de619ed20mr586161866b.47.1730119713305; 
 Mon, 28 Oct 2024 05:48:33 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/15] sandbox: Add a way to show the sandbox memory-mapping
Date: Mon, 28 Oct 2024 13:47:57 +0100
Message-ID: <20241028124815.47262-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

This is mostly hidden in the background, but it is sometimes useful to
look at it. Add a function to allow this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/cpu/cpu.c         | 13 +++++++++++++
 arch/sandbox/include/asm/cpu.h |  3 +++
 cmd/sb.c                       | 11 +++++++++++
 doc/usage/cmd/sb.rst           | 25 +++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 06f8c13fab9..d1c4dcf0764 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -253,6 +253,19 @@ phys_addr_t map_to_sysmem(const void *ptr)
 	return mentry->tag;
 }
 
+void sandbox_map_list(void)
+{
+	struct sandbox_mapmem_entry *mentry;
+	struct sandbox_state *state = state_get_current();
+
+	printf("Sandbox memory-mapping\n");
+	printf("%8s  %16s  %6s\n", "Addr", "Mapping", "Refcnt");
+	list_for_each_entry(mentry, &state->mapmem_head, sibling_node) {
+		printf("%8lx  %p  %6d\n", mentry->tag, mentry->ptr,
+		       mentry->refcnt);
+	}
+}
+
 unsigned long sandbox_read(const void *addr, enum sandboxio_size_t size)
 {
 	struct sandbox_state *state = state_get_current();
diff --git a/arch/sandbox/include/asm/cpu.h b/arch/sandbox/include/asm/cpu.h
index c97ac7ba95b..682bb3376d1 100644
--- a/arch/sandbox/include/asm/cpu.h
+++ b/arch/sandbox/include/asm/cpu.h
@@ -8,4 +8,7 @@
 
 void cpu_sandbox_set_current(const char *name);
 
+/* show the mapping of sandbox addresses to pointers */
+void sandbox_map_list(void);
+
 #endif /* __SANDBOX_CPU_H */
diff --git a/cmd/sb.c b/cmd/sb.c
index 9dbb53275b3..9245052492e 100644
--- a/cmd/sb.c
+++ b/cmd/sb.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <dm.h>
 #include <spl.h>
+#include <asm/cpu.h>
 #include <asm/global_data.h>
 #include <asm/state.h>
 
@@ -29,6 +30,14 @@ static int do_sb_handoff(struct cmd_tbl *cmdtp, int flag, int argc,
 #endif
 }
 
+static int do_sb_map(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	sandbox_map_list();
+
+	return 0;
+}
+
 static int do_sb_state(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
@@ -42,8 +51,10 @@ static int do_sb_state(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_LONGHELP(sb,
 	"handoff     - Show handoff data received from SPL\n"
+	"sb map         - Show mapped memory\n"
 	"sb state       - Show sandbox state");
 
 U_BOOT_CMD_WITH_SUBCMDS(sb, "Sandbox status commands", sb_help_text,
 	U_BOOT_SUBCMD_MKENT(handoff, 1, 1, do_sb_handoff),
+	U_BOOT_SUBCMD_MKENT(map, 1, 1, do_sb_map),
 	U_BOOT_SUBCMD_MKENT(state, 1, 1, do_sb_state));
diff --git a/doc/usage/cmd/sb.rst b/doc/usage/cmd/sb.rst
index 6f54f9d9eb7..37431aff7c8 100644
--- a/doc/usage/cmd/sb.rst
+++ b/doc/usage/cmd/sb.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     sb handoff
+    sb map
     sb state
 
 Description
@@ -26,6 +27,24 @@ sb handoff
 This shows information about any handoff information received from SPL. If
 U-Boot is started from an SPL build, it shows a valid magic number.
 
+sb map
+~~~~~~
+
+This shows any mappings between sandbox's emulated RAM and the underlying host
+address-space.
+
+Fields shown are:
+
+Addr
+    Address in emulated RAM
+
+Mapping
+    Equivalent address in the host address-space. While sandbox requests address
+    ``0x10000000`` from the OS, this is not always available.
+
+Refcnt
+    Shows the number of references to this mapping.
+
 sb state
 ~~~~~~~~
 
@@ -42,6 +61,12 @@ as ``sandbox_spl``::
     => sb handoff
     SPL handoff magic 14f93c7b
 
+This shows output from the *sb map* subcommand, with a single mapping::
+
+    Sandbox memory-mapping
+        Addr           Mapping  Refcnt
+    ff000000  000056185b46d6d0       2
+
 This shows output from the *sb state* subcommand::
 
     => sb state
-- 
2.43.0

