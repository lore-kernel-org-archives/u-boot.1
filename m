Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4D8C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8899687AEF;
	Thu, 14 Dec 2023 17:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D9TDIv26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2C987AD9; Thu, 14 Dec 2023 17:51:51 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D2F887AC7
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35d72bc5cf2so33406565ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572707; x=1703177507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MFYzdl7migOcYkscCUsKl8HZSRhA+83+HGVb/J/wYU=;
 b=D9TDIv26GePUciR9zVrhq7mEW0NDGdzDfkBom2hzIfgzY2LdUq0mEo/w5PHB4nkdx5
 JFbG/q8r3eRyffKkwK5mT8QWSYBQCEhmG7OLcwJgn7GTHI1VZsfdyLppjRRk7ZpR0NfI
 JNaVlivFy7ZIL4MWaagkQRL78yG0y3PQzFsiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572707; x=1703177507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MFYzdl7migOcYkscCUsKl8HZSRhA+83+HGVb/J/wYU=;
 b=i+jrBhcBTfhtIfdVO2IGYj1iwdu70IrX2VPeDUS9InqSEI2KsryZ4/c8h+oIXGPA2c
 q4ArvFfVgRS0eqEmMlXaNxgwGuTCTkhhoaP5ofBDDIDxPVbzZkjGCjsOmLDusyPGy2kK
 Mgie9wbALIGKW155/mjrUeSOnp1hJFwC6ybvlzkJeRYjGc+uktkp4WXS/CsWtGJAz72w
 kEUX9ZvosfDN3SE1kg53eohPKnWH5/UAtRE1YixLxG/GVLEGGRltZa9n7SYVOjCyXuZ3
 Dd2BzFJZgv2z+TTyUj8hkH0yTT/2QoEIX909u5R/IY0YFEgUNgfY+FEORTaKL9BnyhVt
 T1Mw==
X-Gm-Message-State: AOJu0YyHl2urCooNW5ktatdQdIpB0Cr12kqelnuEM8W2Aarqi77EUbjF
 EzOnZw0ZJ1/ZCZCbkfKhiHgfwwwObNtkm41bJSFmYQ==
X-Google-Smtp-Source: AGHT+IHe/kx+p38IObEjwxoOPvQ6x8fKFV3hvfE2FJoKKdaVz8mXP0dF2PJ45RtgJ6UTodqqxZO+HA==
X-Received: by 2002:a05:6e02:ca2:b0:35d:5995:1d79 with SMTP id
 2-20020a056e020ca200b0035d59951d79mr11820626ilg.62.1702572707303; 
 Thu, 14 Dec 2023 08:51:47 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Nikita Shubin <n.shubin@yadro.com>, Rick Chen <rick@andestech.com>
Subject: [PATCH v2 05/21] riscv: Add a reset_cpu() function
Date: Thu, 14 Dec 2023 09:50:14 -0700
Message-ID: <20231214094939.v2.5.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

The current do_reset() is called from a command context. Add a function
which can be used from anywhere, as is done on ARM. Adjust do_reset()
to call it.

Note that reset_cpu() is normally provided by SYSRESET so make this
declaration conditional on that being disabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/riscv/cpu/cpu.c   | 13 +++++++++++++
 arch/riscv/lib/reset.c |  7 ++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index ebd39cb41a60..8445c5823e17 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -3,10 +3,13 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#include <command.h>
 #include <cpu.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <event.h>
+#include <hang.h>
 #include <init.h>
 #include <log.h>
 #include <asm/encoding.h>
@@ -162,3 +165,13 @@ int arch_early_init_r(void)
 __weak void harts_early_init(void)
 {
 }
+
+#if !CONFIG_IS_ENABLED(SYSRESET)
+void reset_cpu(void)
+{
+	printf("resetting ...\n");
+
+	printf("reset not supported yet\n");
+	hang();
+}
+#endif
diff --git a/arch/riscv/lib/reset.c b/arch/riscv/lib/reset.c
index 712e1bdb8e1d..c4153c9e6e02 100644
--- a/arch/riscv/lib/reset.c
+++ b/arch/riscv/lib/reset.c
@@ -4,14 +4,11 @@
  */
 
 #include <command.h>
-#include <hang.h>
+#include <cpu_func.h>
 
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	printf("resetting ...\n");
-
-	printf("reset not supported yet\n");
-	hang();
+	reset_cpu();
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog

