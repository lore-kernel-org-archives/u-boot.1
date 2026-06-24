Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D1ACDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 05:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9F78460E;
	Wed, 24 Jun 2026 07:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VvD+sCAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E41384671; Wed, 24 Jun 2026 07:48:29 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36A6380287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 07:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-031-178.176.6.pool.telefonica.de
 [176.6.31.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1127F3F6AD; 
 Wed, 24 Jun 2026 05:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782280106;
 bh=t6sjRCZGL/LnhOW0TMrpqCTa+pKvO4jy+nFmB7cWL8g=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=VvD+sCAaq5xkIx81D1Wjb3aNh+9oJUSK1LQzpLP/vsGj7dmmn9bf8b/FmJtRpK4E2
 V+tbLKOkiDqDTnNaG326/LcLW18+fw93i7e/EWCZ4GZiFrZwHy9c7GWvzw0+8/Biu4
 yzUeAWbnO0KbBiTgbtCK4P/bqVFfWei1pjt9wIgTvWSadF8HR3aqDfvPr9zt3qR3BM
 tZa2vRYnXWVlZkZs4kvWXz3D+F7xp5VhdUj29lFl+tMxKnCyxNwXPkVQOMv9yK4zVw
 emx0h0qNNW4cpBD/X8Ap9mFzZhNLznFxsWX5IZ2Dvgl99gvLMQ05KVq1XyswOdz94G
 dzhHzHeKDS2/oAi+acToGgnHZtl1TEi7H7uwEwF/QgxoOOjryJE56ezW3tp158uyJL
 NlBA2ErOXtrxWrrt3lP3qWA/V5oE0nngQ21cVnPJ9XE6JSpXroq0tGP56T4YBh6Ik7
 JRduhDtRmMHqeRbZJLFYGP+K0Fr2txhtYfXwVcV0y6YMsqaYD3/XohwTU7Sun5LbC8
 VC5dbx45pR4zKgbv6OBQj5kPKTcaUalz4OTu08yZaYVlsv19PJwvHnESHhhnMTpv9D
 BONXwa90pzoo9z0rsqDak/SLL1bZp5/0RrMdS8SC8Vb3hs1/5Agveywh21iGcBd/7Q
 xhbAjHJRn1FkMzk7mXgJM7TA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jon Mason <jon.mason@arm.com>
Subject: [PATCH 1/1] efi_loader: fix building with
 CONFIG_EFI_VARIABLES_PRESEED=y
Date: Wed, 24 Jun 2026 07:48:19 +0200
Message-ID: <20260624054819.493294-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

Since commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
out-of-tree builds with CONFIG_EFI_VARIABLES_PRESEED=y fail with errors
like:

    ../lib/efi_loader/efi_var_seed.S:14: Error: file not found:
    ubootefi.var

For out-of-tree build we cannot use CONFIG_EFI_VAR_SEED_FILE in the
.incbin statement of file efi_var_seed.S.

* We have to prepend $(srctree) if the path is relative.
* We must not prepend $(srctree) if the path is absolute.

Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
Reported-by: Jon Mason <jon.mason@arm.com>
Closes: https://lore.kernel.org/u-boot/CAPoiz9zg4OXgHo5J3WtJHKOEuWOdCDrugWfAt6Z+d71j=+q8oA@mail.gmail.com/T/#mffaca10a9e812d03eceafad59999a02e57258b9a
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Makefile       | 7 +++++--
 lib/efi_loader/efi_var_seed.S | 4 +---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index d73ad43951b..567db518a8f 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -74,8 +74,11 @@ obj-$(CONFIG_EFI_SIGNATURE_SUPPORT) += efi_signature.o
 obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
 obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_debug_support.o
 
-EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
-$(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
+TMP_VAR_SEED := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
+EFI_VAR_SEED_FILE := $(if $(filter /% ,$(TMP_VAR_SEED)) \
+  ,$(TMP_VAR_SEED),$(srctree)/$(TMP_VAR_SEED))
+AFLAGS_efi_var_seed.o := -DEFI_VAR_SEED_FILE=\"$(EFI_VAR_SEED_FILE)\"
+$(obj)/efi_var_seed.o: $(EFI_VAR_SEED_FILE)
 
 ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
 capsule_crt_path=($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
diff --git a/lib/efi_loader/efi_var_seed.S b/lib/efi_loader/efi_var_seed.S
index e0a40cf46c8..008a505d19e 100644
--- a/lib/efi_loader/efi_var_seed.S
+++ b/lib/efi_loader/efi_var_seed.S
@@ -5,13 +5,11 @@
  * Copyright (c) 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <config.h>
-
 .section .rodata.efi_seed.init,"a"
 .balign 16
 .global __efi_var_file_begin
 __efi_var_file_begin:
-.incbin CONFIG_EFI_VAR_SEED_FILE
+.incbin EFI_VAR_SEED_FILE
 .global __efi_var_file_end
 __efi_var_file_end:
 .balign 16
-- 
2.53.0

