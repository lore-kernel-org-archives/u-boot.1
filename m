Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B35C369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CF8830EA;
	Thu, 17 Apr 2025 20:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VwZ1X1BM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0A683145; Thu, 17 Apr 2025 20:17:11 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0414F830E3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d8092656a9so6734085ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913825; x=1745518625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ojAtL+oXZug1AwSrGbCAqCxR6XgH98HaqwlM3SJUj4=;
 b=VwZ1X1BMoN7NiDuAXz2AmlCZpkRdFhQYrhBB4/Uoa1NHuodO0HobYm+pM0KIL7xlHf
 trqMHYcdn9n5AEh9/JU69wgU1zNYNlAjYXypoC05KpToXLsgb6Bh/04ULBTuTON3X1bL
 Fp+7AvO+LkbcY05Q/1s4yL6ZxGJxxeYV/xNUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913825; x=1745518625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ojAtL+oXZug1AwSrGbCAqCxR6XgH98HaqwlM3SJUj4=;
 b=ZwjlS5CJdLjrYKeCVNgZIbBcJl6KHtNsK+/RKD7fWXYvWK9HiaFwssSuvvEPHMknrg
 wdoUuUoKji9OeN3+CF/go9jODZkj9xORosrkMheb8ibKvLpYOdCCdr+vryAIp0H1JBXw
 yRMzYvLPYXtOsCaf6nY/fmnODyrMbg0HC1TjzEXLoYjy7hzV195BOVBo3zWD6q6vXd4w
 WBDRRj/8j/GAsecLehb7zo/pEXot+fmylDc+DCgyCl7xiyOTFTzxZNyGDp72nweAU/OH
 dytp1/B5YNC3JIfr9bzJdfVtPqnrDw1jxm2xN7XyesPhucEnPkFB/JBTl6Ji5EiMVh/9
 f1gw==
X-Gm-Message-State: AOJu0YxhEnjEx4+PcjBqSx6ltqEjJqcFU8YqtuiDZOZyALQbrIo+TjPv
 /AGLuWcPB0n+1A/qWYAd9PM85oxiaMQJAkgXX4qV6rS3OxFbK10Yf4LR0qhUgI0GXL9ydo1brH0
 =
X-Gm-Gg: ASbGncsOT+KVZ9tJDWnwsSDdMZkBi3fN12j5qvrQ8WiZDbr6NSpwMk3Y2rh5G3bUN+/
 tE/v0xNP3o2ngsitGF9e1CnHCGjbBg8Osq+rjuLxRmc5r6wFevwB7zJHA5aEU67oBaV31tC/7Gc
 L6sJsLCIZqQtlPw/RegTrlM48GjiVwFQImw2mfNb43qmoNnwVYyEZ13Ntf4Za/q7B7SSJLk5xeY
 amovjMnLBQCFfSUTiotMAF0K1DlW0ltHFIFpFrxnotRQA1jr3bQNXcTz3To/XYmjpwZmgQa9zYi
 tk2QzcVsiI6PT04eUIVhM98A6NCYqyjY5vyqm9KiHf0qPYhKZqioMvkd2TaopnmwyA1yfOBInn7
 URw==
X-Google-Smtp-Source: AGHT+IG/aGAaDvq1eMdnPsMR93ToQ8L7vF0egacHvyCTVkta1MgXSIM4BVDg+ZsWX4sJMWIjs74+mQ==
X-Received: by 2002:a05:6e02:d0e:b0:3d6:cb49:1e5f with SMTP id
 e9e14a558f8ab-3d821cffb34mr9843905ab.2.1744913825161; 
 Thu, 17 Apr 2025 11:17:05 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 13/22] passage: arm: Add the arch-specific standard passage
 impl
Date: Thu, 17 Apr 2025 12:15:55 -0600
Message-ID: <20250417121601.v3.13.Ie42090adf599e2b0ceb782298be5278b493f6beb@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

Add implementations for 32- and 64-bit ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Update registers to match the Firmware Handoff protocol

Changes in v2:
- Add new patch with the arm-specific standard passage implementation

 arch/arm/cpu/armv7/cpu.c | 18 ++++++++++++++++++
 arch/arm/cpu/armv8/cpu.c | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/cpu/armv7/cpu.c b/arch/arm/cpu/armv7/cpu.c
index 8082f369ed6..f1b07c414de 100644
--- a/arch/arm/cpu/armv7/cpu.c
+++ b/arch/arm/cpu/armv7/cpu.c
@@ -17,6 +17,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
+#include <passage.h>
 #include <asm/system.h>
 #include <asm/cache.h>
 #include <asm/armv7.h>
@@ -87,3 +88,20 @@ void allow_unaligned(void)
 {
 	v7_arch_cp15_allow_unaligned();
 }
+
+void __noreturn arch_passage_entry(ulong entry_addr, ulong bloblist, ulong fdt)
+{
+	typedef void __noreturn (*passage_entry_t)(ulong zero1, ulong mach,
+						   ulong fdt, ulong bloblist);
+	passage_entry_t entry = (passage_entry_t)entry_addr;
+
+	/*
+	 * Register   Contents
+	 * r0         0
+	 * r1         010fb10b (indicates standard passage v1)
+	 * r2         Address of devicetree
+	 * r3         Address of bloblist
+	 * lr         Return address
+	 */
+	entry(0, passage_mach_version(), fdt, bloblist);
+}
diff --git a/arch/arm/cpu/armv8/cpu.c b/arch/arm/cpu/armv8/cpu.c
index 82ecf02f4b0..275aa2501f1 100644
--- a/arch/arm/cpu/armv8/cpu.c
+++ b/arch/arm/cpu/armv8/cpu.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
+#include <passage.h>
 #include <asm/cache.h>
 #include <asm/system.h>
 #include <asm/secure.h>
@@ -99,3 +100,21 @@ void allow_unaligned(void)
 {
 	set_sctlr(get_sctlr() & ~CR_A);
 }
+
+void __noreturn arch_passage_entry(ulong entry_addr, ulong bloblist, ulong fdt)
+{
+	typedef void __noreturn (*passage_entry_t)(ulong fdt, ulong abi,
+						   ulong zero1, ulong bloblist,
+						   ulong zero2);
+	passage_entry_t entry = (passage_entry_t)entry_addr;
+
+	/*
+	 * Register   Contents
+	 * x0         Address of devicetree
+	 * x1         00000001_4a0fb10b (indicates standard passage v1)
+	 * x2         0
+	 * x3         Address of bloblist
+	 * x30        Return address
+	 */
+	entry(fdt, passage_mach_version(), 0, bloblist, 0);
+}
-- 
2.43.0

