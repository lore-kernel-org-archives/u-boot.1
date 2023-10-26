Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44249C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1896087639;
	Thu, 26 Oct 2023 20:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L4ZCyA26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F309887638; Thu, 26 Oct 2023 20:31:43 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD016875B8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d24ccc6f2so19650186d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345100; x=1698949900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vZxpAqJkH6XG2FNv/HXBn2EsaJozOnbZh07nvxPye9A=;
 b=L4ZCyA26x6uvfdQVacPSX1Vf9yqQ9FmNh4WJofWyJgACGJUtRPcDnPMg/lh62sNyn4
 52BXcokYPaz7xrNMMGncw4qfT8vK9tCycdEIJhyIVqBCdX1b9JVLlZF+6GdyFfle9Lhs
 /kF4g5o6B+XyeHu4m+YnfALaZzoe9AcPdQeBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345100; x=1698949900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZxpAqJkH6XG2FNv/HXBn2EsaJozOnbZh07nvxPye9A=;
 b=ERWm7P+2TLM9pF4JNWDfzFiXvFZI1/1uAEokzqPKG3i5y44d9zlcnAPACLhJaSJMBa
 AVKNqiPmUavfj2SqKkYlvMgU/C+R4I62dpjwoB06b/yor2lKrP5dt4STsYNoO9oi8mTV
 +qdIPhc5Z/D4dtY73VWUOI4LwZaTytNZeLy2XXiKmvhhACs1RqPCdgcihlPWGeHSuRst
 LS8zN5fRZGnkTsFb2oloKOMjCCZgd4FNkz3HMhQg9c86HB2emEzh+lxWj3EG9eQb7Es4
 4ffclPczt8yT4EwKuP4pT9r1CG4nXo2tV+WCtJDRIxyiVSu9TGcNNhYfEE6O3LQN+030
 rOyA==
X-Gm-Message-State: AOJu0YzNfVJgDkx40jp/5SiqR75B5HF+QAHl+FGKrqIoJr/RuICdzKEQ
 nzSjgVOCynMRISdQ7Dpjr22Bs7FKjxncNjXCBN5UpA==
X-Google-Smtp-Source: AGHT+IFxKP0A8xcRRbpI3iZLnfXyitgZKb7IZiL2Vhh7ONTJyecqeMMsPzL8m0pdnvYH22YqjVEk/w==
X-Received: by 2002:ad4:58cf:0:b0:66d:1302:e278 with SMTP id
 dh15-20020ad458cf000000b0066d1302e278mr3609608qvb.19.1698345100213; 
 Thu, 26 Oct 2023 11:31:40 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [v5 01/30] sandbox: eliminate unused functions from binaries
Date: Thu, 26 Oct 2023 14:31:09 -0400
Message-Id: <20231026183138.636948-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

The sandbox should closely mimic other architectures.

Place each function or data in a separate section and let the linker
eliminate unused ones. This will reduce the binary size.

In the linker script mark that u_boot_sandbox_getopt are to be kept.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v5:
- This is Heinrich's v3 just brought to this series to enable the
  overall series goal to work
---
 arch/sandbox/config.mk      | 4 ++--
 arch/sandbox/cpu/u-boot.lds | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index 2d184c5f652a..1d50991f8d24 100644
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
index ba8dee50c7bd..52f13af3742f 100644
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
2.34.1

