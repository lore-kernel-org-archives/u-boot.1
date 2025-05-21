Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADC2C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C704D82FB9;
	Thu, 22 May 2025 01:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uVAHxfR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF7682FB8; Thu, 22 May 2025 01:01:32 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FCF82F84
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6021e3daeabso3914062eaf.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868487; x=1748473287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O/a1beNZJqccoB8CN6g7ghU28NfrR0yuWzGk83w723g=;
 b=uVAHxfR5uEb+cDj2JZn/j1VnT4jxxYD+zCMN5CtmZ0WKLiZ2eTF1MYrIUegRaIZ5QE
 WhZ4oV54NQyq+i7s405/n+D6rRtIbFRAlP7LMgcYC6Q/tdKwElasBP/J7ngXa1ztBDyT
 JFx5+WJxa5vfgqHaJYcSdB1xsxWE4t3iB/Z/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868487; x=1748473287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/a1beNZJqccoB8CN6g7ghU28NfrR0yuWzGk83w723g=;
 b=PbQ43feQaq4DNb1uXEMYKz4FdwllHu5XlXxmENIabBhzV9Y/OSME5gZ+m2aEGzkdh9
 D5TnPGv03uy7DlyqU3hiMbgXmIzX/bYWAOHoBp8/bpOgQ0tua1EkBkuAwm0HnMmi1enh
 zLPzX3jCAXOWpvD7VX8bin4xcCc0/ZOKUrNsiqELiRlQv6XOExKCPlmTgHijDjtkJOa+
 z5yy8wZYJk5kFFlhNMIb4we/4NGiYk5zNvjmtPhQ/4AQGG5wkZzJL6KX66IKhUOdzgJT
 cuqP90LoswzU+X3rPiqu5r+CrGVWwcmnhTJ4z0GxyZWTOydmeXHCUB+2agkzeaOfOVde
 j1tQ==
X-Gm-Message-State: AOJu0Yyll4ejLGbuAm6BazaYNInifVot8mx1BrVIB3jfhYKWzRl/PPkg
 nokSNAQyhWkcS3rU80s3ULcSBSOkmozagbfrOcWE6p69G2YQQ2X2E+9Mhe6ThP+MJwxYG/nNI2i
 PW6l4L20=
X-Gm-Gg: ASbGncuc7XwHFAussWVbdyLMk8nWSVT7O5zJ6+zRDyR/2Jz7iMNW0TvIKIU+Gj1ktat
 yZ6Oo+4pO31OQjWEiHjhfbjI5eRPEEw0ZQeiTRvC4+poMg/0w+xGHQHVxZw9duFJNb6t7Mo/GfM
 5ZKHo5OupwPq/vmn2N4OwY+p+U/XLV2t1TbeG0wu4PYshf5UQQZlXnEb4HmkYeZKjrzjxRHn5nO
 yJZ2zeoVXeuZDbCDBMqMg+sLEZjSPx6BpA5JpRrEtuEKxXxzxRPChF/1s7pQL1Pf+pZisf7f69V
 jt3seD5xZIif8miVJp+UYo30yaiKRTVoqGIQmh5t7GyMADcspCz7jVQguJlV1pzAUG1sF3C8UuC
 gpkzM8L55q4EgjIY=
X-Google-Smtp-Source: AGHT+IFJIrSLaNBPHyCDlGLXVqq9fJNTjyUccmTopzIyEScCZ1SkvB/83po+KiJmAPr4sbFZimZ7oA==
X-Received: by 2002:a05:6820:290c:b0:60a:9c7:e8e6 with SMTP id
 006d021491bc7-60a09c7eab4mr8712955eaf.4.1747868487634; 
 Wed, 21 May 2025 16:01:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 03/17] include/bios_emul.h: Audit include list
Date: Wed, 21 May 2025 16:51:08 -0600
Message-ID: <20250521230119.2084088-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <pc.h> but does directly need
<linux/types.h>. Furthermore, arch/x86/lib/bios.c was getting <pci.h>
via <bios_emul.h> so add it there.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/x86/lib/bios.c | 1 +
 include/bios_emul.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index de4578666fbd..77a8117d1580 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -12,6 +12,7 @@
 #include <bios_emul.h>
 #include <irq_func.h>
 #include <log.h>
+#include <pci.h>
 #include <vesa.h>
 #include <linux/linkage.h>
 #include <asm/cache.h>
diff --git a/include/bios_emul.h b/include/bios_emul.h
index a7e6d73972ce..47a45296cc31 100644
--- a/include/bios_emul.h
+++ b/include/bios_emul.h
@@ -8,7 +8,7 @@
 
 /* Include the register header directly here */
 #include "../drivers/bios_emulator/include/x86emu/regs.h"
-#include <pci.h>
+#include <linux/types.h>
 
 /****************************************************************************
 REMARKS:
-- 
2.43.0

