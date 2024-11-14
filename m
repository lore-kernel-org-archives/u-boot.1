Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC1D65C6A
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C699489607;
	Thu, 14 Nov 2024 11:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vaAtgPDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C8989198; Thu, 14 Nov 2024 11:21:58 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10F38960A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 11:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314b316495so4101735e9.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 02:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731579715; x=1732184515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=okuS3znsVACEGr06HyoLRkX19R/GhjfDvHpaaQQcd28=;
 b=vaAtgPDipwZeMqGLF0z/tdUixfBKi7UZgtbuuu1E5HcP4ZTl5bBBbC1QqX1n1szrDT
 +nXT5tJ06T1BVA+xdWIfB2pKW8c3WZ0CQYDKeCvuBXLKv6PLtcjTrGrmW4mzUpw+8rfX
 CMACQYLlyuWAI15cfp/R1FKS2rY2G7dpC6cqfeQuaWykfRJbgHlUQK6Vjc14fiAk+R/O
 y7ZHUocYwaZdhSTXpmodJIPBr6TsFmWgScmSZOh4rPgVztUPs/tUmz4pYU7Ry+34oIHc
 YXdYwZANc2CVuSSd4kqPedFeXcc6l0pSGsG1QyXibX1lERbWbKmeN1D/YxmGTupkfWP7
 wmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731579715; x=1732184515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okuS3znsVACEGr06HyoLRkX19R/GhjfDvHpaaQQcd28=;
 b=FlnmBN5I+D46vC5pnJ8JjEz7TjMIzzPiEmsd1MCTbkugDxb7UZDl5AO3wQNdZOi8sw
 G2DMKmbzsnIiAvLzLco9xl/ferqUAYWuY6HoY2itIb33dgBBMiJUriWrAOAUYHddgvTj
 jGiju2+3kKLN7Ja2ze9v8nWgpjvloydmTI9WypbZxuMrNco6QhwE0SgEEhon+oGpA8m2
 R31SF5IL4XfMjf1g58MXV5K6+d6C1r1xP1j873AX7Qr2btGVEZlN3MWqHLz3MM6bKHWx
 jwmlRkowHUfwWt4TngXMBOcFbD6Fn7wociPuMNY8r4OxDphz9XHjdl3NKQClA0UWTz6A
 P8ZQ==
X-Gm-Message-State: AOJu0YzNoTbltTc33OGow/cTtWhP3gjNAdwawkYWUJtasUEu2pBxkLAB
 plpiFaFpTYFlWOu4YV8E5TOOmX/Vn5R5Vg74246DB9weQggnvnzF/8TC2zrO+0Hd7qgVPSxJp1V
 JF2U=
X-Google-Smtp-Source: AGHT+IELDt2DbQ0Mc45MFW52u6zGD0UJvEHCtYnm3ngrEnciVu7R+Q0Xt52p7/Yjvfv/M33RldAE4g==
X-Received: by 2002:a05:600c:1c1d:b0:431:5957:27e8 with SMTP id
 5b1f17b1804b1-432d4ad89a3mr46515195e9.28.1731579714902; 
 Thu, 14 Nov 2024 02:21:54 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3895:27b4:20b7:7653])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da24498csm18902695e9.1.2024.11.14.02.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 02:21:54 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
Subject: [PATCH v4] Makefile: detect HOST_ARCH properly when CROSS_COMPILE is
 multi-word
Date: Thu, 14 Nov 2024 11:21:38 +0100
Message-Id: <20241114102138.1977060-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
detected and the build may fail. It typically happens when using
ccache. For example:

 $ make qemu_arm64_defconfig
 $ make CROSS_COMPILE="ccache aarch64-linux-gnu-"
   CC      lib/efi_loader/efi_helper.o
 lib/efi_loader/efi_helper.c:26:15: error: operator '==' has no left operand
    26 | #if HOST_ARCH == HOST_ARCH_X86_64
       |               ^~
 [...]

Fix the issue by considering only the last word in $(CROSS_COMPILE).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Note that this patch was already proposed to fix an issue with the
sandbox build, which was addressed in a different manner [1].
Now the problem crops up again and I bisected it down to commit
7506c1566998 ("sandbox: Report host default-filename in native mode").
In any case there is no reason to have an invalid HOST_ARCH and
this patch does fix it.

[1] https://lore.kernel.org/u-boot/f06b0774-d47c-4414-9974-89d2ebbf1902@linaro.org/

diff --git a/Makefile b/Makefile
index da742ceae76..fbc876c1b83 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
   MK_ARCH="${shell uname -m}"
 else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
+  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
 endif
 unexport HOST_ARCH
 ifeq ("x86_64", $(MK_ARCH))
-- 
2.40.1

