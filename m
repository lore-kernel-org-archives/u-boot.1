Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D07C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF1087BF2;
	Sat, 16 Dec 2023 04:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I4BspoD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D5E787C0F; Sat, 16 Dec 2023 04:15:18 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9159C87A9B
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35d3846fac9so5208665ab.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696512; x=1703301312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8KAVv0+Ya16D5v6TByRqRhZhZ4pLWAZ4I7NDEURh7s=;
 b=I4BspoD0vuZoGY94VS+gync4313EOw1gcPYAUC1feaM8pSz6T9gjd4M11u/iBUYSlY
 zMpWum791UtIZcBXpM9gmixsvXCmbNJXI8lleA5PfLmqlE2XHGjIDjeHieh7//2woa+A
 olnuJ1GoN99ZXAbXh9sKz8isV3Uv9u03sxT9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696512; x=1703301312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8KAVv0+Ya16D5v6TByRqRhZhZ4pLWAZ4I7NDEURh7s=;
 b=HoRaY+2pJQdMnN3FAQBOMhZU7xwleA42QTSDqM+vcAmsxLMH+U6JcEWNavF/iFdSQV
 SMgIFn1U3S9ujiIYpzSdZzG8mqyVRTURxNm/89SOXrvJqPd6/74UCnDusZI0aX41oi+s
 7A6LU8wUlBgPskv5lkwS4bIsDsuWWstTa8IsoIY3Fq9nLmpL2ogYTMc6DlTYl3hQvhJD
 DSWXs6ATF00q7d5EOm1LxsUrCghuiDagFfq3g3nVpY+VyX5FnIKxeQSl4O5muSFO7KMI
 VfIMd+IObNm9BqiCe8maTPNp/hJxEqT5QRcNCZBXcFjrfBar0uW8ie8w6gUQe2GnML6S
 K3sw==
X-Gm-Message-State: AOJu0YwZia9vljpljvURGPIMcT9GD+SoxSe/y6JEiFNdcgj78TLTTklA
 /HHL0Di+6gjGAbVvNU6vuiewYUBkoKc3q47gQYQAjw==
X-Google-Smtp-Source: AGHT+IHi/0pJhjWusd47HtnQzDGfRRH0qbX1flSe1t8iRNsSCj/PM+fYtHCl4wm6Lt6sDWHDZgZMgA==
X-Received: by 2002:a92:ced2:0:b0:35d:6528:f120 with SMTP id
 z18-20020a92ced2000000b0035d6528f120mr11971576ilq.62.1702696512161; 
 Fri, 15 Dec 2023 19:15:12 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chanho Park <chanho61.park@samsung.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Nikita Shubin <n.shubin@yadro.com>, Rick Chen <rick@andestech.com>
Subject: [PATCH v3 05/22] riscv: Add a reset_cpu() function
Date: Fri, 15 Dec 2023 20:14:09 -0700
Message-ID: <20231215201413.v3.5.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>
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

