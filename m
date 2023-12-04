Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F2EC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C30E87825;
	Mon,  4 Dec 2023 01:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cdmlq8Fu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C779877E5; Mon,  4 Dec 2023 01:27:51 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E49877FF
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ce5a0c384fso1432b3a.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649666; x=1702254466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mi99BaMLKb3RVrf2lgh4OjKqw4XaWKLQK2cJ7jxmSw=;
 b=Cdmlq8FuKyvCU2N2MtFvJ0Qk+6iVKWJccdBRNolJwws1hwDt58sOQ9DQcPlzxMIjSX
 t1beAHxjMBWFgblqx/oDxjeYVuVhgYTKAyOTPJM6DTyqcNBH0j87uv3kTu/Iv1y8ikKJ
 Ycr1bsEQbYvnUVHbQ7sFTMjv7gfYCoT6SCwaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649666; x=1702254466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9mi99BaMLKb3RVrf2lgh4OjKqw4XaWKLQK2cJ7jxmSw=;
 b=LwSTOzopHrdKYGNYQqnpGdeUxmpm8vg3b5916c5zDc4UZtmUFLRvamdoaHErv5tBwc
 3q7pMfuiRnYAWH0mg4wbp7CeNAcH/Ddc2FwoBaEKeo4ugct8Ke3CEc9LoCHOxbGR531q
 NlLRz47cCip63piNmSY3rXbbQCRJcxMpMKtdr8CP5MZMovNg9zPUlCxF5dJqU/Ap/U7x
 e7vqgWtmr1SbjxmkhdKdjrFpRZZxi8iNoYrCjS2A1w971+/jIYxD0LiTCaZwW/bWvoYT
 r/7Dg3M0Z4DKmUoUugcEgUJM4Hpu13RoZ+AST/uCXcGS6HLNZv+101g9JGNe3JgjeOcQ
 BHtw==
X-Gm-Message-State: AOJu0Yythk/qoF4X3dst/QvSLmHMBACW2ZT4yepmpclUTMaUO6p+0D+V
 CyMRKu3w0wEIyPGo64H1AbSF2auYEuNTVMAtfyuT0Q==
X-Google-Smtp-Source: AGHT+IH3ai5v5yXMuwDpeSmkCzpbkunFjP+xF97/rw9iKNLl1BBeAxsGKm6MdeXcWk8+b/I6Abu/Sw==
X-Received: by 2002:a05:6a20:c5a9:b0:18f:97c:ba10 with SMTP id
 gn41-20020a056a20c5a900b0018f097cba10mr1156699pzb.106.1701649666353; 
 Sun, 03 Dec 2023 16:27:46 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Chanho Park <chanho61.park@samsung.com>,
 Leo <ycliang@andestech.com>, Nikita Shubin <n.shubin@yadro.com>,
 Rick Chen <rick@andestech.com>
Subject: [PATCH 11/18] riscv: Add a reset_cpu() function
Date: Sun,  3 Dec 2023 17:26:27 -0700
Message-ID: <20231203172622.11.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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
2.43.0.rc2.451.g8631bc7472-goog

