Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77F6C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 11:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEDF8059D;
	Thu,  1 May 2025 13:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h2POuW0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2898081A; Thu,  1 May 2025 13:12:44 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 819688056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 13:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d81768268dso7597735ab.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746097960; x=1746702760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f/COofnDcyHhxuS0+E7GVfKqTFjHVDJR5T61jmlNRYI=;
 b=h2POuW0p5mUCJ7+xRzpJyXimT0BN19HP/VOG5zaAUoAn4a+BfTy3SsuqaFeovhP8aT
 4g1tQbAEFx6PezXm1iH2XdB8Vcpfwyj0/MsXkvp3VhYhcQD7kplZEkvt4Ch28VOde1ie
 1EqrWBLcvURYpjY5UtSaifX56nYKQfanoQIMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746097960; x=1746702760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f/COofnDcyHhxuS0+E7GVfKqTFjHVDJR5T61jmlNRYI=;
 b=eYGSFuD/T0YbogAwQwjFhO6XzNKZtENvMC2eqj1syB+ovX3v4xEqXNvdpiIUc+uWZd
 qU5FEr7kQCS3EdrXRiqMD9EUNdpJ7YmMjtkVa9L4JtOZLq/3/QL1qwlLFVbwanGHin2y
 8IQsBa+Kc21gHguScIwsTQ+HU/qtfZd0r7Izkd1XXtXleyWFgBfbOCC3e8Upazgg7iAr
 Pjeuh6QGUw0KflOlzf0X/1SUls/EwuySQOEA7/Ya6jFyrmCGnKnEKFvoPgk8m7uExLaY
 9Yz6dVkfl6JH05NpqqNVAOMIBqTJQdJS2LtUMapG+9omaBND1pD67617SbPo6TLnd5mb
 BPOA==
X-Gm-Message-State: AOJu0YzJiX3xJCnKLnZZnUqHWpEp6KvQ6k9FCEy7QETScPI+leyyQjgS
 McrRRxSOciyneN0XZSgEWeUtAyK3wAe2oMteVmjf96YkyJax0W7CDX2dkE5fdWaq7BxfWYjBpW0
 =
X-Gm-Gg: ASbGncuwY8oqUz2qdTq6VKjdZv3bz91z60l1AoJwAIxO0N8NhLT0vH8oPlCshyAmdDv
 LEqIIbNf/D46IYPtZ6m/+wzJuX2KznnK77o6xys1FEYXUqPL++jH7XRD4kuwz7y49bfXJVXsC3j
 3OZ8UdqOjEvYLB3dI68D06JytJefZppYGsBaGTPfbb1GpNYERnY1Fxu+V2lCU9vEw7nfxX3cYaM
 jotJG6e+ALRloGVDTgYg6+cqAFli05GrMlmluywG+nZPqx/3BK10+t7jxrLUPL5Hv1Bz3uEEJj0
 IH4/+dyc41ffVxqe1eJ17J5B/BWCo8HGeZYrNzKbjqsVatQuQq6NOUolYDe0g34aZXUhlq10at7
 ThA==
X-Google-Smtp-Source: AGHT+IG5z7lTAnh7Mtp/9RylTV9EgrSS4lI/pS5i1DLMo+1j2g0zPan3ustucl+zs8CYAaLr7WkDqA==
X-Received: by 2002:a05:6e02:18c8:b0:3d4:244b:db20 with SMTP id
 e9e14a558f8ab-3d967fffd51mr72663405ab.16.1746097960279; 
 Thu, 01 May 2025 04:12:40 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975ec7df4sm845175ab.32.2025.05.01.04.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 04:12:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH v2] sandbox: Enable PHYS_64BIT for 64-bit builds
Date: Thu,  1 May 2025 05:12:32 -0600
Message-ID: <20250501111235.707593-1-sjg@chromium.org>
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

Sandbox is special in that we use the bitness of the host. This should
extend to PHYS_64BIT as well, so enable this option when building on a
64-bit host.

Update the conditions in io.h so that 64-bit access is available.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Stand-alone patch

 Kconfig                       | 1 +
 arch/sandbox/include/asm/io.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 589fed689c8..de9d9ad5653 100644
--- a/Kconfig
+++ b/Kconfig
@@ -448,6 +448,7 @@ endif # EXPERT
 config PHYS_64BIT
 	bool "64bit physical address support"
 	select FDT_64BIT
+	default y if HOST_64BIT
 	help
 	  Say Y here to support 64bit physical memory address.
 	  This can be used not only for 64bit SoCs, but also for
diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 3d09170063f..3c3545a2747 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -39,13 +39,13 @@ void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 #define readb(addr) sandbox_read((const void *)addr, SB_SIZE_8)
 #define readw(addr) sandbox_read((const void *)addr, SB_SIZE_16)
 #define readl(addr) sandbox_read((const void *)addr, SB_SIZE_32)
-#ifdef CONFIG_SANDBOX64
+#ifdef CONFIG_HOST_64BIT
 #define readq(addr) sandbox_read((const void *)addr, SB_SIZE_64)
 #endif
 #define writeb(v, addr) sandbox_write((void *)addr, v, SB_SIZE_8)
 #define writew(v, addr) sandbox_write((void *)addr, v, SB_SIZE_16)
 #define writel(v, addr) sandbox_write((void *)addr, v, SB_SIZE_32)
-#ifdef CONFIG_SANDBOX64
+#ifdef CONFIG_HOST_64BIT
 #define writeq(v, addr) sandbox_write((void *)addr, v, SB_SIZE_64)
 #endif
 
-- 
2.43.0

base-commit: b5d6220dd2f4612912989f3c2b5a710f2248cb36
branch: schb2
