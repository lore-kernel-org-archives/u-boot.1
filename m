Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AADC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0138681430;
	Wed, 26 Feb 2025 23:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="epNxJnD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F2481110; Wed, 26 Feb 2025 23:16:35 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F028080F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2232b12cd36so3525645ad.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740608191; x=1741212991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0+I7nSQZa+m8YSUfiPNvFTFETDMeeHmYdlym+clkUM=;
 b=epNxJnD/FSPN7Rd+cgF2wIyvfPBJZwg6U12RSOnE5OyGoQ248mziaULsxq5esM0/j0
 GTLa1n44LLNb32oebKGsvmv6GFY4XQxgL2i7roVhDUki2/+zt1bHIfnlq5u+p1AZ4Vtm
 EcNPorbYt/i8TsfZsXmcvIk2KMnvaCY5gRlV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740608191; x=1741212991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0+I7nSQZa+m8YSUfiPNvFTFETDMeeHmYdlym+clkUM=;
 b=W9lCasMw8U+B49CgxOgMnpuM0VOLVkGU4nDWTnM6tNEnrP4CM6aF9DCsJ1FXNc1Lgt
 K3sAUOQqjeOg3ulXz+hz3mEt0eKl9vWOlx8ckI+PCTP2HJy2gjv7yuwpIiu2Coqj66A6
 RwGpLOiB3sx1WUI0XfK5NatHAsw49J+3dPRyg4H8J9MQ+Pyb4fc0+t9Sm/UgISsabOLd
 3sYsTnO2G7yoaqLo9S0tfqLP5LV1FFFhwmBSkqVwF33lddW/uY9GPQC1yiUcNE1K31Y1
 82kjsuvubRUFqxDuu4EboaMjT/HWnmCakB46O0mdvuuxKhNUQtOuBQ6yXgwief3z1Fgw
 ctHA==
X-Gm-Message-State: AOJu0YxV7LfxcpJJVjYeGpuUmQRV7DmtDslIHxYSZ2gDFLNKwT2YkXkF
 xv6hU1K5jRSM8lbZe18FBb9nPu/uLvTzZP31pVC5gVR+/YU4JztwmY2LGgL6/GSgJoMIyhRb60Y
 =
X-Gm-Gg: ASbGncv/QQ/wGI4eBkd3hkcKzkJAVTo5K78kEuwxHIcJxJ+MFDfAsC44CCBZqXmZbQ3
 yFGYwzj9OhNbsZEwxAhZjcQ06b3S/XGKUs9UN6AgZcDnwLZaNZMRBe7O2n4J+5yX3fAek5Bv7pT
 GO7tCtBgzfz2N1C9gn6iYEpHhPJXmyfFi17jap7doy9sCds0/V5Lj2CNAItlhOPR072jh4kVrsV
 LSNZV6Iyo6gKTQ7LODjHuEarcUCe38wagiXBZjJBQOLO6bqjm4/PHqL/U1jYvN+em+FgSramgRM
 1VrfkrjO657cwCdnEnrnuuqpAKQvN4BdTRO0C95SVyV2beFTMqzdw87+HUD3spa2qQ==
X-Google-Smtp-Source: AGHT+IEsD/bwhXBx+hwzM4lsGCA9dYQTcqqoZqZF29hDfgvG8f0pB9q4Vq3poo8nKEZ1NL3JGA0Nfg==
X-Received: by 2002:a17:903:94c:b0:220:d81a:bebf with SMTP id
 d9443c01a7336-2231fe0f976mr87846765ad.0.1740608191195; 
 Wed, 26 Feb 2025 14:16:31 -0800 (PST)
Received: from localhost (222.246.125.34.bc.googleusercontent.com.
 [34.125.246.222]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-223501fae03sm1349725ad.84.2025.02.26.14.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 14:16:30 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v2 13/15] mach-snapdragon: Support booting as a coreboot
 payload
Date: Wed, 26 Feb 2025 14:15:59 -0800
Message-ID: <20250226221607.1283592-14-swboyd@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250226221607.1283592-1-swboyd@chromium.org>
References: <20250226221607.1283592-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 23:23:35 +0100
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

Coreboot sets up the DRAM, CPU, and devices before booting a payload,
meaning we can parse the coreboot tables at boot for memory info when
running as a payload. Use the memory descriptors from coreboot if the
tables are present so that Snapdragon SoCs can run U-boot as a coreboot
payload.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2ef936aab757..cb3df1c2adec 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/system.h>
+#include <cb_sysinfo.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
@@ -48,6 +49,10 @@ static struct {
 
 int dram_init(void)
 {
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_dram_init();
+#endif
 	/*
 	 * gd->ram_base / ram_size have been setup already
 	 * in qcom_parse_memory().
@@ -81,8 +86,21 @@ static void qcom_configure_bi_dram(void)
 	}
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_board_get_usable_ram_top(total_size);
+#endif
+	return gd->ram_top;
+}
+
 int dram_init_banksize(void)
 {
+#ifdef CONFIG_SYS_COREBOOT
+	if (gd->arch.coreboot_table)
+		return coreboot_dram_init_banksize();
+#endif
 	qcom_configure_bi_dram();
 
 	return 0;
-- 
Sent by a computer, using git, on the internet

