Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B4FC02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2C280D1C;
	Sun,  9 Feb 2025 03:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hpO+cDxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B5280834; Sun,  9 Feb 2025 03:02:50 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A37F0808E6
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-851c4f1fb18so87091839f.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066563; x=1739671363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtSEeuMiupA/PWWHjaSAkrW4hxdrLSxNODrAc4mv4So=;
 b=hpO+cDxaM7786rtVuCEHVBS9nsvDacnOSqQk8YabTpuIE3NUbBUbx83SyRjyizTou5
 +IPB+xetszahvEAcaM2tT70GF+2uAF0MrL4+3nQu9FdlbS7RTmAq0JHNVrMkeyYFot8R
 19DhGRFxgtj4H2Wvxj4RG5gGMhR3Dua+E/kCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066563; x=1739671363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtSEeuMiupA/PWWHjaSAkrW4hxdrLSxNODrAc4mv4So=;
 b=qKVxiUeX/q/M3F7AHvhl0AK8Y75gusJOIlg7ichS4VD9WKtjYoCxuTnHBe2ecsEHbu
 wRYPB3ggj3KWzMtQdn2qKp7IZQ1pX4jWhE4suKFVKtvdnZW2vze0ZuOQxaeoUzw/PHUa
 IMHXK/bFtEWhCpktMIhOrm5HVCPW/6+yA1WXonaDVVq39AOUUvG08sd64mEgrHVicQ7f
 3o/8Jb/4GmUD8PnwHXMcVLOMnz2LXMp4dm3F0pRY8eOwPzSyf0n/PsdrGtyzaVEXVVmk
 awKzR4daidrQFEp81fUyicZDEcxMHC1ZNfVR48gD0EeGFEtJwapX1p8wNeQyrDeyYJFX
 VJkg==
X-Gm-Message-State: AOJu0YybMhmQIcFYWkqmG72g+cPL4ETd7YwilheY6f2HDbapdxpVCSAj
 O1XOICqq7Glwq8BQRJ5lRUvvNtoewlPUQjC/F44a5lr7tqGEJy3kx7joc3pQi2Iwp+SUaldglHQ
 =
X-Gm-Gg: ASbGnctN/qDNxp9C6CF6BBlzqY7nK1t9JwlTSIdE7XVorJR7V8J9t+t+9rpxCKqYS+U
 HE8SgjFQkhs8etpFGKJQhwOsifjMjpknPrnLYsvx9Isv7tzuhYW1rSQMR0mI8wbx2ddNDqXUdZD
 ud5x1+CG5eCiTkV6VpjZDdygvA/tkoNPYIQJ3oIHmsWqKBsW8ehs9cLUzVH5dHLuKh16lykDEcM
 O3xN7OyKnhPnaJ8CqyQFZAJMNUnkss8mm4HNl1PcgGWgUFlLJLCAJ7iZhIIIHG0lVKug3aEkjdV
 ckNAeC7GGvbdI+VZeV91Ums9DgVFf+d+5S1mD2t7IjhsyXZ+7fr7
X-Google-Smtp-Source: AGHT+IFK0EBEdXOk0rJQkWcIKtQN8fuw5H1cdgKzzvi80NZ8lZzA4lovWywGOooVvwTm2azYW9CVSg==
X-Received: by 2002:a05:6602:29ac:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-854fd7a0b65mr857679139f.0.1739066563029; 
 Sat, 08 Feb 2025 18:02:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v3 22/29] efi: arm: Drop startup code from the app
Date: Sat,  8 Feb 2025 19:01:21 -0700
Message-ID: <20250209020136.4108987-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

The EFI app uses different startup and relocation code and the existing
code uses symbols not present in the app. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 arch/arm/cpu/armv8/Makefile | 2 ++
 arch/arm/lib/Makefile       | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 7bd6cf21b19..a8f5de58cc4 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -3,7 +3,9 @@
 # (C) Copyright 2000-2003
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+ifndef CONFIG_EFI_APP
 extra-y	:= start.o
+endif
 
 obj-y	+= cpu.o
 ifndef CONFIG_$(PHASE_)TIMER
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 9500ba6fddc..a41566c816d 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -24,11 +24,13 @@ endif  # ARM64
 endif  # CONFIG_EFI_APP
 
 ifndef CONFIG_XPL_BUILD
+ifndef CONFIG_EFI_APP
 ifdef CONFIG_ARM64
 obj-y	+= relocate_64.o
 else
 obj-y	+= relocate.o
-endif
+endif  # ARM64
+endif  # EFI_APP
 
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
-- 
2.43.0

