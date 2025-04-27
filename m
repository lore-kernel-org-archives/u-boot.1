Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15869C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 23:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F1F80FDA;
	Mon, 28 Apr 2025 01:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RNhq4DEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D67981E0F; Mon, 28 Apr 2025 01:08:11 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C2C180F9C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 01:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4769aef457bso62259121cf.2
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 16:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745795288; x=1746400088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AZ/Jc7jJZvBtQZ98yg68lYULxcHKBizzPUn7CCl9+h0=;
 b=RNhq4DEL43Si+xtakfdB/RI5/24p2hy5UGSNaHEwxAvmg8EJvkSzXKFqqBtqpLOxA3
 iy66vVrKgrV2/M6dB1YRVWT4CA5soYaOe3xMTOtO7XagHPO4ywwZqFLJWGhw0/1IUQ9v
 cjUDG063norWSpgh5dgFxsh4RnYeb+Tw3RR4HdH8nTaQ2vHQ2R/iU6CcDfQdkGithRSM
 z+HdKWYVJjD62mSo9ZyuHykZhfLVvJdPHXmdTMnZ4+iT9/HQ/m5i5kw8bWK3ElWxa9zP
 a9bAmbG8gsurtmi+Px31v8fCbi5wzN2jEPXrQpd+m2180ILGd4qLu6uNBbpT19gy8RWG
 fZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745795288; x=1746400088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZ/Jc7jJZvBtQZ98yg68lYULxcHKBizzPUn7CCl9+h0=;
 b=R8JBF9/FZIDaaz3bTePR2Fh8+CNC4cttmMqHffN/6KfNXkZ1orBJUvrZ8QKhZGR5pr
 QCSHyRj4bNbLb3v/BTl//ToIehEeS4C2M3IsZkcYskOiE6Wel8lGUwUOIO44AOJSw4GL
 bRhcXeUEDH8XTEFqg6B2fkWiDbfKaSLdoiyXVONcZ7J48QGBY3By2sTkbZC+qCYbzuK3
 EYR30ZMWCpzeL8uMtkAHKlIw+F2bXH8z/LWjlrW+8Zc9F6EwcDg0CioAmpZRjg2BYPOX
 W64VBhdSKBZjeOomvvBby7w/w6vM7713+Eu8Yx35Vq5LE8WFQkpFconDqkOKO114sPzt
 fGnA==
X-Gm-Message-State: AOJu0YzWdXCPb2gJ+PdsigmR9CBo+u13cYvQ9kZBYKW4UbxjDfTcImii
 4xy+cDIyP9M4+KXzrKXBeY/UwlXFohCatg7sKxw+Y07AxiDqRfx02H2UMg==
X-Gm-Gg: ASbGncs/Lm3RI2fkSuqCtpk2OVCGNqSEFmOW7HYPwSfs7SSCJVDpl6YRo1ZC3YsZ/rw
 9csz7zubOE0mJhI/ugCIBBnhzMpmPkfYKnFEaO5hXOZGBo/gAhs4Q8yW/lyKhCTAcsP31mebG2l
 8Yjm09zLBEiJoPkZWw3QrxUlWxTDoVJ6eAi41MzykzmSvU5dlhiBO/yjBWHIoOIlYmYXzBXMRox
 rEoqHXVU7UaNF1xopZwZn7Bv9h9P+BAAfRtsgI40ErHuToxrEK8Zf8GZ6w8ereV3THF4wmG8jjN
 cOiuXWAysC8s7MUs6d5UKQ4FmEb50XQv+zjg8xjeN2sWiE0LAhpSaepSxb4bgA==
X-Google-Smtp-Source: AGHT+IHVV55mSpJVmCRnksOrwKMGLYP38dxmc7/4QBGOLZVpqpcLfXagx50OfCFEYLUV8g/UE60YJg==
X-Received: by 2002:a05:622a:11d6:b0:476:9f3e:1806 with SMTP id
 d75a77b69052e-4801e7ed9bamr179413921cf.46.1745795287725; 
 Sun, 27 Apr 2025 16:08:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47e9f7a8326sm57158731cf.37.2025.04.27.16.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 16:08:07 -0700 (PDT)
From: Ben Wolsieffer <benwolsieffer@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ben Wolsieffer <benwolsieffer@gmail.com>, ZHANG Yuntian <yt@radxa.com>
Subject: [PATCH] Add HOST_ARCH detection for armv5tel and armv6l
Date: Sun, 27 Apr 2025 19:07:25 -0400
Message-ID: <20250427230725.46236-1-benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Since 7506c15, HOST_ARCH is now used by the EFI loader even when
CONFIG_SANDBOX is disabled. When cross-compiling, the Makefile defines
HOST_ARCH based on the cross-compiler prefix, but this definition fails
to cover some common compiler prefixes. When cross-compiling U-Boot in
nixpkgs, we use CROSS_COMPILE=armv6l-unknown-linux-gnueabihf-, which
results in HOST_ARCH being undefined and causes a build failure.

Fix this by adding armv6l to the match for ARM. Also add armv5tel,
as this is another possible ARM compiler prefix.

Signed-off-by: ZHANG Yuntian <yt@radxa.com>
Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 73939748e54..a6535c71576 100644
--- a/Makefile
+++ b/Makefile
@@ -30,7 +30,7 @@ else ifneq (,$(findstring $(MK_ARCH), "i386" "i486" "i586" "i686"))
   export HOST_ARCH=$(HOST_ARCH_X86)
 else ifneq (,$(findstring $(MK_ARCH), "aarch64" "armv8l"))
   export HOST_ARCH=$(HOST_ARCH_AARCH64)
-else ifneq (,$(findstring $(MK_ARCH), "arm" "armv7" "armv7a" "armv7l"))
+else ifneq (,$(findstring $(MK_ARCH), "arm" "armv5tel" "armv6l" "armv7" "armv7a" "armv7l"))
   export HOST_ARCH=$(HOST_ARCH_ARM)
 else ifeq ("riscv32", $(MK_ARCH))
   export HOST_ARCH=$(HOST_ARCH_RISCV32)
-- 
2.49.0

