Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD676C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412B782CB0;
	Tue, 20 May 2025 07:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GLijJlpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89BE282CBC; Tue, 20 May 2025 07:22:33 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD4982BD9
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a36abf5df9so1484694f8f.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718551; x=1748323351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k//ry/DIVpP0692vd34TO35qgb1KNGlSmkUjvdkuKck=;
 b=GLijJlpjGx76AShCC9Wwle/NaToTgzkdD9hIjmPagjI1iuCOXzR2LgiSF4QssSz9w0
 53fAenZxSXcU4pIKVwEn59l6nc4zAH3Ea+P3+J31qWiSq2SAT2MCzfiECY/dpaMJE64A
 Rsd7m4zQopE/B7T9FtJ/TFVuTf+THoLpGNpTcrn3Wski14wLldl3ZeOXcvHVsIubb63R
 MEIVRObdpMzBrSiBJYmpTimfEJoLhUN4Qys6mDWogzSgwb3INwsVDTsFJs2YzkGMo/s2
 lKU53uQmaCZyP8fFiGbmSr7AxFTeWv/OkIkdAwZSd+6VR+dVSaoDLOhq8Cc1u1lqmMmJ
 JwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718551; x=1748323351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k//ry/DIVpP0692vd34TO35qgb1KNGlSmkUjvdkuKck=;
 b=Exow0dbsJ3fhAUdwrHss0DrZYx790UtPL06a0JNtznyO/uC18Dw+LSh3SV3jIsDwUO
 WfkYMBvK7743iEFw1svYW6COgJOP65o5xnX5AyjoK3gvD/yEChI77n00B9XJmWyYjgQA
 nEJMGWKGoqCjXfERNtmL81PHvamiVova5xkr55Hc9nskDIipGV2waCu2jXpxDFCKl52C
 xp5qI/t3Q82IGsVYMa4Z/gDL+pW22HbicBeW2V8OdfwKpfAhBbNn8ANutYtbQv9QotoI
 mBrahsr6iAxp0fy1nnffbHisOCU6oxtldMZ+x3aRvrNig5X5X4tIWsSb5alTaRDYBorC
 EOfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSWKFnMwk69RES/N8DYKdfDg1iTRw0iujL0XXlKCO+awPVqU+AOrtuwh294x84oM62P3ZD1AQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyAzuV95snylWKeMlqqSbJXKtwyaic4v6DlJvlk17w079FSPuvn
 LWqPnFkriSTdK8ifC7eXbsnmTyaa7hh4S+7c584jpzJE4qbUZNrP1Dlc8fDjvP2rx+Y=
X-Gm-Gg: ASbGncscUahnCUsiynDd5n8a233+vNS/cYpeZ7/SHVt0wq70mKkmRTGf77dRG4UCSl3
 gYxYT+a3DSBwepuc2lx//nBDoRnO4NuLB9j5AeTYx0hEtompNd+/XfMzTIuMwWQ1qvzeMaDgB3U
 D3OmktKV38Njfh9UfPBKiaYsTDFaQ9SGiNPIysgwBEY2Rk84TXl0XnQjY9wqLK+mPkABK9a+DWZ
 elJpX8eFRXyHPp0u2K+oCOhOMUY/lVG1WmyILDhRpFm5daCCQiLgVZzrVPgig/lL30+f8yKoggH
 +P9uXbhlYnxVH5V4fwb9Hv1zp3B+NA9Ivw4a60E6+m6VBy6nUIq6mshJxh2R+hn8bWDLp5X4E2M
 =
X-Google-Smtp-Source: AGHT+IE9GzROE1E3KJaK9guMpHoL2uFncFszIXGI9SXzFvbwOM3N6LtEccI3hZ+YMCVihdW8w1oO/Q==
X-Received: by 2002:a05:6000:1867:b0:3a3:70ab:b274 with SMTP id
 ffacd0b85a97d-3a370abb2cemr4764406f8f.12.1747718551048; 
 Mon, 19 May 2025 22:22:31 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:30 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 13/24] kbuild: refactor modversions build rules
Date: Tue, 20 May 2025 08:21:24 +0300
Message-ID: <20250520052153.307194-14-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit ee3e46b7efd2 ("kbuild: refactor modversions build rules")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index b2bf5a2c0001..639091e7b29c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -171,34 +171,30 @@ $(obj)/%.symtypes : $(src)/%.c FORCE
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
 
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-
-ifndef CONFIG_MODVERSIONS
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
-else
+ifdef CONFIG_MODVERSIONS
 # When module versioning is enabled the following steps are executed:
-# o compile a .tmp_<file>.o from <file>.c
-# o if .tmp_<file>.o doesn't contain a __ksymtab version, i.e. does
-#   not export symbols, we just rename .tmp_<file>.o to <file>.o and
-#   are done.
+# o compile a <file>.o from <file>.c
+# o if <file>.o doesn't contain a __ksymtab version, i.e. does
+#   not export symbols, it's done
 # o otherwise, we calculate symbol versions using the good old
 #   genksyms on the preprocessed source and postprocess them in a way
 #   that they are usable as a linker script
-# o generate <file>.o from .tmp_<file>.o using the linker to
+# o generate .tmp_<file>.o from <file>.o using the linker to
 #   replace the unresolved symbols __crc_exported_symbol with
 #   the actual value of the checksum generated by genksyms
 
-cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
+# o remove .tmp_<file>.o to <file>.o
 cmd_modversions =								\
-	if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then		\
+	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
 		$(call cmd_gensymtypes,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
-		$(LD) $(KBUILD_LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
-		rm -f $(@D)/.tmp_$(@F) $(@D)/.tmp_$(@F:.o=.ver);		\
-	else									\
 		mv -f $(@D)/.tmp_$(@F) $@;					\
+		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
 	fi;
 endif
 
-- 
2.49.0

