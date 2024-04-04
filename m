Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8072CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 06:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018F188279;
	Thu,  4 Apr 2024 08:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nt0vM8DJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C9B8827A; Thu,  4 Apr 2024 08:37:44 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3811387C2D
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 08:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e030624d1so904298a12.2
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 23:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712212661; x=1712817461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tq1Z25wnNY6uLOtH9Yd9BJZfR+Nn7OwI4j/AkSOvG4c=;
 b=Nt0vM8DJKqm+p+KuPu/zUgJ+z9TqeHcpL2+VjUpUatSub01MNjc5d1jdTNAYXojrux
 /baoAG99ILS9g6mFIuKe2U3krG15iuWWVw6A8utY8ttrgte42Za+RB5R1yPSCUgWLR6/
 qpN/IDTdu8O59BsOjpxR47r4EcdZaOoOsjV/ktGRXsSDk9JI/93S39AmoWMBlAKVs+oJ
 iXNeqjdwj5pt+tCBPEi+TtqpgzjACNNMu0FCm+LRRInN1LBpvWfN3xea8S6P6cI2Czsu
 EXoT5cxA/IrJOE+AOOnOvb1EmHNWMQII/O+UsVi9IWK8nDjGxO0wBQ3vNiUU07TaHfAE
 z9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712212661; x=1712817461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tq1Z25wnNY6uLOtH9Yd9BJZfR+Nn7OwI4j/AkSOvG4c=;
 b=H4Bh1SzVKyQwgySt4PC2g+RAYYljQPrXnUTF/R4/NAKBWWuRikOEuvp6XfvEiiwATD
 idn1SWahCPq/iB9O4I6El1YH6bhOTgJPR2pPDUA+U4oVHhcvlfegu9q8nRSv6UyaLpP2
 lDHFW71PyY0G/KtkEEXDsPsOnJrrcGxekuP6PbMtkvg7elYM8Ir1SdryP5iPmLpuxa4J
 iF/x4URIRiGLdyA0TTVNP5x9IZmD8kLQ/k/n1rP/PYCV2OiVcWtrGqYutY17p7ZEbT0L
 +zppfaBgzoLYlqDGt9octQ7onx/L/wsh7gkVBoenLjoQhnzfllzchQXXCXmiDDTQJvBN
 WOFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoR8Z9FTUUhApQFSK1hTWPM7U3FLdKiKGKNviXgi5lo+GOjI6z8Xima/tGXY4S8208GgNOT+NVCL2kKmibDJsBXrSUXw==
X-Gm-Message-State: AOJu0YzDaJLqHD9H8Y6GgAed8wNjH2PRiJjB9arwMGgInqfa54oKySp2
 o7y/b5uR4SHkhJD1v54uFjUOX8LdF3uKBGqEGJdKqNKgAqLDlBRwVAtB7fS50P8=
X-Google-Smtp-Source: AGHT+IEX6gCshMYXEplA3bVAv8DabnMXTDGwrqmUbgbD/Cj6RKNt03Pm19jceG/+Q7BUxMKjzqWxSg==
X-Received: by 2002:a17:906:5603:b0:a4e:8024:87f6 with SMTP id
 f3-20020a170906560300b00a4e802487f6mr1088208ejq.66.1712212661702; 
 Wed, 03 Apr 2024 23:37:41 -0700 (PDT)
Received: from localhost.localdomain (ppp089210071137.access.hol.gr.
 [89.210.71.137]) by smtp.gmail.com with ESMTPSA id
 lw7-20020a170906bcc700b00a4df01f4232sm8622356ejb.189.2024.04.03.23.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 23:37:41 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>, Simon Glass <sjg@chromium.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: access __efi_runtime_rel_start/stop without &
Date: Thu,  4 Apr 2024 09:37:37 +0300
Message-ID: <20240404063738.470494-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

A symbol defined in a linker script (e.g. __efi_runtime_rel_start = .;)
is only a symbol, not a variable and should not be dereferenced.
The common practice is either define it as
extern uint32_t __efi_runtime_rel_start or
extern char __efi_runtime_rel_start[] and access it as
&__efi_runtime_rel_start or __efi_runtime_rel_start respectively.

So let's access it properly since we define it as an array

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 9185f1894c47..fdf2fbd9ba3d 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -669,14 +669,14 @@ static __efi_runtime void efi_relocate_runtime_table(ulong offset)
 void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map)
 {
 #ifdef IS_RELA
-	struct elf_rela *rel = (void*)&__efi_runtime_rel_start;
+	struct elf_rela *rel = (void *)__efi_runtime_rel_start;
 #else
-	struct elf_rel *rel = (void*)&__efi_runtime_rel_start;
+	struct elf_rel *rel = (void *)__efi_runtime_rel_start;
 	static ulong lastoff = CONFIG_TEXT_BASE;
 #endif
 
 	debug("%s: Relocating to offset=%lx\n", __func__, offset);
-	for (; (ulong)rel < (ulong)&__efi_runtime_rel_stop; rel++) {
+	for (; (ulong)rel < (ulong)__efi_runtime_rel_stop; rel++) {
 		ulong base = CONFIG_TEXT_BASE;
 		ulong *p;
 		ulong newaddr;
-- 
2.43.0

