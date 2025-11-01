Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8C6CCFA03
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 15:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37647838EC;
	Sat,  1 Nov 2025 16:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sl898Q+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 694B483A3B; Sat,  1 Nov 2025 10:40:07 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1920883A2B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 10:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47710acf715so14585615e9.1
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761990004; x=1762594804; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H2YRCLGTngXYqQBSxEGQ6V3FYxWjiHS8j29vE0bDMj8=;
 b=Sl898Q+9YZIns97AMsz1bUo0MBrtCgveVEzYChAgBz8f3dvGspdRjpl8ZadvUhp16G
 3d+4WhD3iV9nXf6A+UM1Td+9sV0o2UrM1JlQG41hqplhLbkssJoBgmqrIh5N5gVZrEnp
 823gvpu8tno8VLdq6pdHqgv8oQ9VSheN09t5UfY2NLNdiFyO5tDk1y4slkm67qAzyHC/
 JY06mlqj9ChFnGKekk/uC+UmacDuxInqUIdfoTqYLd7mpmM5E/TG8SPriswWuxo7tD/H
 5wrPHkm2//EI1xX5qw7ipPY0aUFSy3u07z8v2NeRWUaMuZhrePWpAvMtSxfCzRM1RLuH
 ThXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761990004; x=1762594804;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2YRCLGTngXYqQBSxEGQ6V3FYxWjiHS8j29vE0bDMj8=;
 b=ojuKn9dGhMwPATFzO1/qybdqBMYnXBPpKHU5t4D8vYMKaHggaEIPk8IkRYgpSFiRnK
 oNryBSamrKF9j9nudxLhGRcMk7tw6BoDjKJYeZsxNmxHtIxjGsqxEwTsm9BuVg7hwcV8
 KLCJKVgKEylOeVF6tmg86eV3y+D9FkQo99qLXo1RJidvW/xgMUImB5xJ2ikrrSXoPSU/
 Qpr6oTH6ZTR+SO4oxwaCKla6sBT7m+YhnqENFprZtl3BlbB7JD4S35fIVGPwTnrrB+pa
 Y0CL3oq/zgHFmXDN24T/c4EvArWJezOa1HAN2JHoA+kHMuY6aMjSRA5Yb0NZHUPf7y6Q
 A4zw==
X-Gm-Message-State: AOJu0Yy8TlDFr+o2VKEZbZ3UBqfqmc58tCisb5cUGHDVjiX9MrI8TTMF
 CBEQZBJn51iBvNEIc2k5//vXXqv5DC+pIo38WsY94qDjR27u38gjFTRB
X-Gm-Gg: ASbGncvEGrzcOxi4kVFmX9Nh+QgBiuPNgo6iKq/IkvZIPuXnN/8Ob4QaM6Cxo9qaUms
 0cGw1StQQq2f/kdO0huCOWCotMWWlj5kz0CCGQg4FhAkb5OThyCMxMeWYl9SjgkTgW8fqCmz/4x
 cIdb0mGeU33Tth0a4bb9canri9SPO2xP/2XN3YpOcwTOHCGkoFw9mw9/IaX2jmRbEPvOUCIbrAb
 3/mnwYpMJen3SxESOvh11eyNfow8eWzKuf5dERCplOaRUeaqQNGeb7EnCUCYPK9za93HmYGIbvP
 uYGXKqYHtC3Con8z3mxQKpbOLiN53wn3Abjtk5RXPh1bhPoLbfJqWMNA/0Ba9RYtwhRPNdjquEe
 +WZFRNTMZXAZ9aC42py9XmygoudqJIstgVhpT0ZxIFzAEam+rEmkMybUbZg4AHyI8UeEdojY4K1
 Z/15ylRXZZPnMFUjSnNS5MRpp1
X-Google-Smtp-Source: AGHT+IE1znAMFajOtZpzUZTAQ+UTRCY937xIz1Iwtp6SKJhvHGiAxQZXRmrKRukEMDxRd+D+8yUtWg==
X-Received: by 2002:a05:600c:4ece:b0:46f:b42e:e367 with SMTP id
 5b1f17b1804b1-477308cc556mr62886815e9.41.1761990004133; 
 Sat, 01 Nov 2025 02:40:04 -0700 (PDT)
Received: from [127.0.0.1] (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c110037asm8697791f8f.3.2025.11.01.02.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 02:40:03 -0700 (PDT)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Date: Sat, 01 Nov 2025 10:39:58 +0100
Subject: [PATCH 1/2] arch: arm: build: only set -mgeneral-regs-only for AArch64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-clang-fixes-v1-1-a8398475226e@gmail.com>
References: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
In-Reply-To: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sat, 01 Nov 2025 16:15:06 +0100
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

This option is not available for 32-bit ARM targets and causes an error
when building with Clang:

clang: error: unsupported option '-mgeneral-regs-only' for
target 'arm-none-eabi'

This fixes the following patch (also seems to only concern AArch64):

Link: https://lists.denx.de/pipermail/u-boot/2021-August/458067.html

Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
---
 arch/arm/config.mk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index 6e725ba1081..ba7dd99672a 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -23,9 +23,12 @@ endif
 
 PLATFORM_RELFLAGS += -fno-common $(FIXED_REG)
 PLATFORM_RELFLAGS += $(call cc-option, -msoft-float) \
-		     $(call cc-option,-mgeneral-regs-only) \
       $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,))
 
+ifeq ($(CONFIG_ARM64),y)
+PLATFORM_RELFLAGS += $(call cc-option,-mgeneral-regs-only)
+endif
+
 # LLVM support
 LLVM_RELFLAGS		:= $(call cc-option,-mllvm,) \
 			$(call cc-option,-mno-movt,)

-- 
2.51.1

