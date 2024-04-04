Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6A1CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 06:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5914488249;
	Thu,  4 Apr 2024 08:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mtxopZCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E0B288251; Thu,  4 Apr 2024 08:35:45 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E57F87C2D
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 08:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a47385a4379so334039866b.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712212543; x=1712817343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rI7+huMMf554nNUWoRAF56i0M5LoXr1nnc/rX5fps6o=;
 b=mtxopZCyWFvL7jGTCsiHzOy5EqlYd1uz2xZroxlHR5k2RZNae2VDIqUS88fpZhv5vK
 mtUxaFUDryIRgWcDgCGwtDuDBhLGct8LlbUQiU5PW+0i8u0cI+bGMJ2l4VGIxClHQYK1
 hnl18s6lS+Bdtbu31c1I6tA++YW5M6Wqh4SORQel1FRecoRcI35FDh7dPdIWoBh2j73O
 U5sB56GGPtMvoiI/T2Qg9QBKS3xHUoVTSBUpyGJ/nJdqmCiqRRR8erTjJoRLk2U7/It9
 ofwm6AA+9rLIVv5AjrYQIMApaCxT83xOgUYZ8ez/EelHbiqqKnXdlRREiH9fsCD340e3
 A5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712212543; x=1712817343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rI7+huMMf554nNUWoRAF56i0M5LoXr1nnc/rX5fps6o=;
 b=aKSpG24XiFHbga4iFNhjPwIZ0lm6b5hgTTdx/eRZo11AbQaUkO1NG4NdKSbZHL12ld
 4+jsmd03MKGssyabfth4lHqKfAsoGWzAu95Yw384K3rt29fFRyzjK7xgkFzS5lNLCBvp
 BxGAC9h9uePYbHS/QinMevyn0NPsFnUkeE+xhiQWlSObjTi6GxI3PkklZSSD1zLpr+hA
 JF4tzjOn3Z6d5CqqS91ovWriE9NLZdqdqKunX4dWHIj1E4oEj2ObxqHGx6pr/q6pD2TK
 SOpjTMix/nAX0zZsnD8hRX81OavUCpCVMh6Csjr4ITDbVRXU1wr1XgDjyzChgaBLObYy
 BzZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvdUx1p37HGXbWFOtBgLAyy8K/ESz92/y94U30KzR8w4Y/C42gFFplNyUncHo3ZexKr0bQUdMla7WdBYQavm5qfxFaYw==
X-Gm-Message-State: AOJu0YzCg5ZgHqA/Y/aLxFOHBGm7Xy8O0BPh0Zso0JuZevSxGdgPX5Eu
 1tyxMBtB6HGidMkibNuOIC71OpByKRcE2KvdHuX7FwRtkGBUHphz2Z7/KScTJ2o=
X-Google-Smtp-Source: AGHT+IGKpHiEGDb5awMDnqY8+lJWx6tocv7NFRYuZT0e5DF0geI4AAAVJLYw31AH165hQ/Od1/vSsQ==
X-Received: by 2002:a17:906:6a1e:b0:a4f:b398:2f47 with SMTP id
 qw30-20020a1709066a1e00b00a4fb3982f47mr3633114ejc.25.1712212543048; 
 Wed, 03 Apr 2024 23:35:43 -0700 (PDT)
Received: from localhost.localdomain (ppp089210071137.access.hol.gr.
 [89.210.71.137]) by smtp.gmail.com with ESMTPSA id
 du14-20020a17090772ce00b00a518c69c4e3sm212987ejc.23.2024.04.03.23.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 23:35:42 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: access __efi_runtime_start/stop without &
Date: Thu,  4 Apr 2024 09:35:35 +0300
Message-ID: <20240404063535.469995-1-ilias.apalodimas@linaro.org>
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

A symbol defined in a linker script (e.g. __efi_runtime_start = .;) is
only a symbol, not a variable and should not be dereferenced.
The common practice is either define it as
extern uint32_t __efi_runtime_start or
extern char __efi_runtime_start[] and access it as
&__efi_runtime_start or __efi_runtime_start respectively.

So let's access it properly since we define it as an array

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index edfad2d95a1d..98f104390c8d 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -933,8 +933,8 @@ static void add_u_boot_and_runtime(void)
 	 * Add Runtime Services. We mark surrounding boottime code as runtime as
 	 * well to fulfill the runtime alignment constraints but avoid padding.
 	 */
-	runtime_start = (ulong)&__efi_runtime_start & ~runtime_mask;
-	runtime_end = (ulong)&__efi_runtime_stop;
+	runtime_start = (ulong)__efi_runtime_start & ~runtime_mask;
+	runtime_end = (ulong)__efi_runtime_stop;
 	runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
 	runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
 	efi_add_memory_map_pg(runtime_start, runtime_pages,
-- 
2.43.0

