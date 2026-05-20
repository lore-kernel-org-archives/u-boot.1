Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C681CD4F5B
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 00:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FEE6848AA;
	Wed, 20 May 2026 02:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O2uB2Til";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAE548488F; Wed, 20 May 2026 02:12:43 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2750084894
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-48270f099d5so3551520b6e.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779235959; x=1779840759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Q5CDQjvrPBAp5N2gCtSbM6By58NwfT26xnMIaRGqEI=;
 b=O2uB2TileFQbsjvdap+VJV8f2hVj9J7cr5tcank6NQaSBsK9lT06FVrNQOQ4XhriuI
 c1zahMzW5XNBDHqUM//mcomhJvZl1lYsMPEzu+VtgOAwE27IIlFbYr/j11zkznK0iJuC
 4ot3Dty9xbFV8pkzhBswnjnO3NX2PyYnxouWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779235959; x=1779840759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Q5CDQjvrPBAp5N2gCtSbM6By58NwfT26xnMIaRGqEI=;
 b=kSSi1VFFVMNv/j+IyaltWmKw4oF7dxTIeZ/MM9XD02HPCao53IUKOrjz3NTpHsfzwk
 7GD7TQHD9ddJQvtLc/ypzOifJ0/If3Qv5OvIKA9lgIzXSwNUGSg6GY2n8gfEZMQXIOEF
 PtkzfanbsOAwFMHQkLe40otO0NVevfP0s1Mgv7cMzUGIcxMLhYuz29PIq1382OdljtvF
 TprhCtcdaAkuEXEu35sDEnRjERB1mo+UWedTjgrd03nydiKrVi6rDdIGGy8ZfMoyH6jo
 9B3+W6gHoeq8hpVL24OK9/i+dH1xDa8XUrsbsAf4KMKM4TLMZ2e7UKQz5FdMhlIqpAes
 yn3g==
X-Gm-Message-State: AOJu0YwvijRNIwUXQs7GHThM2I59RfVbRmbRd9vdlb9/PneQzaH1lRqK
 DL+nBjKbGYzfBvk3tBSC2mEDYmOJpQxbXHiz6V7DXZdRuefzRTXa5FmFdD5fT6FAZLtmdDui2K9
 3p6/2C/aUisC2
X-Gm-Gg: Acq92OHxWQTx35sDQFlSWQQqNiPrAILj7bxVUVscO9W5VmCsH/fOy5vSOBlFePv8u+J
 IlOBJ3TtDjGEm0IrmtTLHzbhB6dlIGYmJiUGro0flEdA4CJIawWOBSqhK1Hp1JCBc7bTDD1FwIX
 BeUbEVuApqZo7DKyemgnfZHNevPZM6naODkuiceukyf7HkXdRDrSmJSPzWG9WxWLSF2tGqdjLZp
 4xcXQvevSgFqIUIBVDe4RjV/+3YXFkHOw9KLnQSVt2DgFyAihgmuS95ipZHbRlnuUGc4Mj3E8jf
 Dg6g7YgndpKvew/5Ae5sYzeqIDY79EO6g6hqAcGCs1o5es4ZsLc99rHzmaQmu1cHWu3D08H8Dk1
 5mFYwIzTrbY13pLqG/8mKLlq30SrtOPyoGw4b+5WCZLKvs/xRy378wpq4ZwoxG+7YrteQr9bXrp
 f1Y6Zw6AG6cBty0j+jVeMiyg9TWMBkxBVxJh2cm0+ZqEelbrqd41am93PYUSURFVNw7F4Uom0ql
 D49SfEobTLTeuP4ntUOqo+yzPGJ4ygqzf0jmyhz+SM3CpThKmtUgg4bCxb2PzRNIU45Mn+cHf7g
 yGWHpvLh2Q==
X-Received: by 2002:a05:6808:22a5:b0:479:da60:7dd4 with SMTP id
 5614622812f47-482e5725ba8mr13870656b6e.30.1779235958832; 
 Tue, 19 May 2026 17:12:38 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a94fce014sm8859863fac.7.2026.05.19.17.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 17:12:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] sandbox: Drop special link order treatment of start.o and
 sdl.o
Date: Tue, 19 May 2026 18:09:52 -0600
Message-ID: <20260520001234.1555120-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520001234.1555120-1-trini@konsulko.com>
References: <20260520001234.1555120-1-trini@konsulko.com>
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

On hardware architectures, we need to treat start.o (generated from
start.S) very special due to the constraints of being a program running
on hardware in an unknown state. These objects are treated a little
different than the rest by the linker and linker scripts on various
architectures.

Sandbox is different, and doesn't need to do that. In fact, it can lead
to hard to diagnose problems because of just how subtly different the
treatment is. For example, the comment about LTO in include/event.h
introduced with commit 87a5d1b5d012 ("event: Add basic support for
events") was only a sandbox issue because of the event in start.c and
in turn linking start.o isn't treated the same way as an archive with
all its sections considered.

Correct all of this by removing the "head-" lines for cpu.o and sdl.o
from arch/sandbox/Makefile (and unused cmd_cc_sdl.o lines) and change
arch/sandbox/cpu/Makefile to treating them both with "obj-" and not
"extra-".

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/Makefile     | 9 ---------
 arch/sandbox/cpu/Makefile | 5 ++---
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/sandbox/Makefile b/arch/sandbox/Makefile
index 5bbf9f1f96bb..0360d2bd8861 100644
--- a/arch/sandbox/Makefile
+++ b/arch/sandbox/Makefile
@@ -1,13 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-head-y := arch/sandbox/cpu/start.o
-head-$(CONFIG_SANDBOX_SDL) += arch/sandbox/cpu/sdl.o
 libs-y += arch/sandbox/cpu/
 libs-y += arch/sandbox/lib/
-
-# sdl.c fails to compile with -fshort-wchar using musl.
-cmd_cc_sdl.o = $(CC) $(filter-out -nostdinc -fshort-wchar, \
-	$(patsubst -I%,-idirafter%,$(c_flags))) -fno-lto -c -o $@ $<
-
-$(obj)/sdl.o: $(src)/sdl.c FORCE
-	$(call if_changed_dep,cc_sdl.o)
diff --git a/arch/sandbox/cpu/Makefile b/arch/sandbox/cpu/Makefile
index ee3c04c49e14..eb6bf6302e23 100644
--- a/arch/sandbox/cpu/Makefile
+++ b/arch/sandbox/cpu/Makefile
@@ -5,9 +5,8 @@
 # (C) Copyright 2000-2003
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-y	:= cache.o cpu.o state.o initjmp.o os.o
-extra-y	:= start.o
-extra-$(CONFIG_SANDBOX_SDL)    += sdl.o
+obj-y	:= start.o cache.o cpu.o state.o initjmp.o os.o
+obj-$(CONFIG_SANDBOX_SDL)    += sdl.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-$(CONFIG_ETH_SANDBOX_RAW)	+= eth-raw-os.o
 
-- 
2.43.0

