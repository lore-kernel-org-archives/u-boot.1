Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2DFC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF3C82A4D;
	Sat, 10 May 2025 15:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FggZ1erk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 832618295C; Sat, 10 May 2025 15:44:00 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E7782B97
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad243b49ef1so25712366b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884637; x=1747489437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sEIV3pc/3kgMkt4HtCjpor2NMO8iEUeULduRqYupkE=;
 b=FggZ1erkDuJseiq3cQg1O2wQAEAR9hei2VThX98FBVCrLXMqS9RaijHRFGU43BNelY
 kIHMJYI42xw9lqqpcFrHumTHHfHMl06UQ0RVq4zOoZQub2bnFjI4C4dtrXw7hcj+sZfy
 eVz/aJZ4VuY+wH5RlbXCn+oAABQWUKmciESlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884637; x=1747489437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sEIV3pc/3kgMkt4HtCjpor2NMO8iEUeULduRqYupkE=;
 b=egvEMfFoCI/ol1dIXSRxdC+YpsKmHCOlP7g439nbuFrNuQ/HkqalzX/omxiFyggw0H
 HWeQI4RMCQHh5s/WpA5f8D9EsHIDs1aFcYm0dhTfqKrnhfFC8ij1rb4ioTwDcnZ0Kw96
 oPYWX5n6CH9cMa1uuaseLIVUU/6fQiiZoHqc12GZbbZ7reXw2ozAj1iMpjP5U164yAYG
 BEUqh1fP2L5lu1bZu5dRKI9Slj2a64dbk1OYWEwubAPxoT6YifpyF/ggTjMr3uqtwP6Y
 TNdbblXf4DgJ/a9ShdTj3vR3spmPtSliA/va7g1G/g4NMqDZf4/5TerGcXDr0JUCJLzz
 rRkw==
X-Gm-Message-State: AOJu0YzHqFpe2ajUW8/kh7sDRkCzSjXnm1eqgBewQ9a4obQUgtntNK9Q
 GLrqEEZTTDDKsrNzY/ISQTcCrTe/THSsTdIlauetrg5kc82baI/iowKQa0nKV1xJ6qHdPTinghC
 2ovDV039ugg==
X-Gm-Gg: ASbGncsyslo/cqso97CQ8ak32AF/QQ/hfPmua41XrkhqmcpvB5R3C7/G+cly1tmWI2y
 pmU/col22Jf46ycIiQEiXf4HZJp2aOiPeq9xfJcN9MlsRrS9FX5F1FTZJvOvQ32ZdPoMw1l1+iP
 f63+5Iqfw1oDC1XMPAZ3bv0tDCkFyhE3XdE3A0/nJmWpJNbYmV43CbpANdNCmjMqFEJBQifkBD+
 kwDmU8ECHzWO1jPW5k9ts2AnrR57mY603suI7oeKlrXIcTpfGv4vPCjNAS7zPG/ZdhXbAPY+dAE
 JjESBipKOg19osTFYIEXNcBqYfTyeDhgLnkXDBpJk5xlzXW31Errr++OE14aSrkxs3bV
X-Google-Smtp-Source: AGHT+IEhA80B8SVOHeDut925Itr7Ex7HiPOaZzjvFAGYSVKtjSU98ND7XXXSVnRzRmZKO1foEoJAig==
X-Received: by 2002:a17:907:3f97:b0:ad2:2b35:8fa5 with SMTP id
 a640c23a62f3a-ad22b359412mr484946766b.28.1746884637178; 
 Sat, 10 May 2025 06:43:57 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 12/22] passage: arm: Add the arch-specific standard passage
 impl
Date: Sat, 10 May 2025 15:42:10 +0200
Message-ID: <20250510154214.v4.12.Ie42090adf599e2b0ceb782298be5278b493f6beb@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

(no changes since v3)

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

