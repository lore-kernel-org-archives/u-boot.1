Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD3C4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E1DC87D5B;
	Wed,  1 Nov 2023 17:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UdyaZ55u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A2487D5C; Wed,  1 Nov 2023 17:28:51 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 581DC87D0A
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d24ccc6f2so9362456d6.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856121; x=1699460921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X3NdQqlOEFjU06s1YEO43FgC/DjqQ+d5Epr/j/nr5mk=;
 b=UdyaZ55uPlo/XOXHtc8g6BMftIbOizaG2z9218YyHW3FnsX1DNFqeHTmlHIiAj6AWw
 fI6TomWGH3oRaWkRQFNLdUfBhJCRET606psqocfowdJLOK77YVBpJR1go9PVsjx4h2AN
 4nmppH5oT9XOei9BFyIvUbgI1h8yWXmYY315s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856121; x=1699460921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3NdQqlOEFjU06s1YEO43FgC/DjqQ+d5Epr/j/nr5mk=;
 b=DIDC7o5onbVyAEmm8U0GaZ/5Rnin/b2IJ7uwDh6oHdsf3ZLYCaM16gxpZsxTQW+vXc
 4lHVUGGNIqQq/mJLJakh8H/9Qra5U+pZ6gLEZ/hjs0++JZpYFubggUQzOv6wsvF7pYHU
 b+Cy09C7lUNZkPPzsti0h6ZVn8YTuPCsYzX7u7sh8/KxnGfAjmkw7IxJTUt4STV5KNGX
 5cE52zr35smgF0rxVk6GAdKGWuJRORDbEt15B1EXuWUUXme6WQ9K4JIdLQYsOAtIVV0L
 V4MExW9cSiOTdJPdJLeIFOU9IrDIhZLhibwud+LNvrScDA2v4DRuqp2KS1kSiEi7Cm4V
 rTqA==
X-Gm-Message-State: AOJu0YzIkGdTUXvHn1RBWfd5mqSGMODv6iDIo3KgQpLwJhTpnxZ03ZVT
 IQDG7l8l7i71BxNXdi4m1sgWwrfCpKCoCc8bdqxgAg==
X-Google-Smtp-Source: AGHT+IHOXOpEGgZK8P8pjlcQ5/LrI1oNUMhOGkw+jtrXUNohzmbyn689JDpPmE4BH7dtNg01LYW/nQ==
X-Received: by 2002:a05:6214:48f:b0:66d:9b75:750b with SMTP id
 pt15-20020a056214048f00b0066d9b75750bmr9544572qvb.8.1698856120699; 
 Wed, 01 Nov 2023 09:28:40 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 18/20] sandbox: Drop <common.h>
Date: Wed,  1 Nov 2023 12:28:22 -0400
Message-Id: <20231101162824.3755579-18-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

None of these headers need <common.h> to be included, drop it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/clk.h          | 1 -
 arch/sandbox/include/asm/mbox.h         | 2 --
 arch/sandbox/include/asm/power-domain.h | 2 --
 arch/sandbox/include/asm/reset.h        | 2 --
 4 files changed, 7 deletions(-)

diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
index df7156fe3174..2b7dbca8f755 100644
--- a/arch/sandbox/include/asm/clk.h
+++ b/arch/sandbox/include/asm/clk.h
@@ -6,7 +6,6 @@
 #ifndef __SANDBOX_CLK_H
 #define __SANDBOX_CLK_H
 
-#include <common.h>
 #include <clk.h>
 #include <dt-structs.h>
 #include <linux/clk-provider.h>
diff --git a/arch/sandbox/include/asm/mbox.h b/arch/sandbox/include/asm/mbox.h
index 70f36d7afef6..499e9a67f6ac 100644
--- a/arch/sandbox/include/asm/mbox.h
+++ b/arch/sandbox/include/asm/mbox.h
@@ -6,8 +6,6 @@
 #ifndef __SANDBOX_MBOX_H
 #define __SANDBOX_MBOX_H
 
-#include <common.h>
-
 #define SANDBOX_MBOX_PING_XOR 0x12345678
 
 struct udevice;
diff --git a/arch/sandbox/include/asm/power-domain.h b/arch/sandbox/include/asm/power-domain.h
index 1845bc8d3baf..4d5e861dbce2 100644
--- a/arch/sandbox/include/asm/power-domain.h
+++ b/arch/sandbox/include/asm/power-domain.h
@@ -6,8 +6,6 @@
 #ifndef __SANDBOX_POWER_DOMAIN_H
 #define __SANDBOX_POWER_DOMAIN_H
 
-#include <common.h>
-
 struct udevice;
 
 int sandbox_power_domain_query(struct udevice *dev, unsigned long id);
diff --git a/arch/sandbox/include/asm/reset.h b/arch/sandbox/include/asm/reset.h
index 40d3e61c110a..f0709b41c09f 100644
--- a/arch/sandbox/include/asm/reset.h
+++ b/arch/sandbox/include/asm/reset.h
@@ -6,8 +6,6 @@
 #ifndef __SANDBOX_RESET_H
 #define __SANDBOX_RESET_H
 
-#include <common.h>
-
 struct udevice;
 
 int sandbox_reset_query(struct udevice *dev, unsigned long id);
-- 
2.34.1

