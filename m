Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A81C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA665870D0;
	Sun, 19 Nov 2023 15:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dtrMLy7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16036871A5; Sun, 19 Nov 2023 15:47:16 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D1758701F
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7ac7b2b1e99so134623939f.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405227; x=1701010027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jO9vO/y//t9p/lR9UbSe7e1D0J7jrHCjZIXvbX7Tfi4=;
 b=dtrMLy7Zc/CZxkmHTV760YB9ZUgckOOTn0n6lGerBZeOZ7rBu5InVOOG0mWd3Po8M+
 TJElcVhCq5AtcT6H7+ob8ILfF8afKBwVRbGQRuZ8iiN+PBvOuPaI/PfGrxIGJoX456bg
 kNbOGE1ReRVNsgEuK+uyFOv6Z0mgDYEAnn2R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405227; x=1701010027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jO9vO/y//t9p/lR9UbSe7e1D0J7jrHCjZIXvbX7Tfi4=;
 b=KBBczxuXhPyLUihdaCpMS5ja8SqtO+YUCnof43oK4NQ8z8qdoJFze7s8rWJxFoLiVE
 ZR7sUCPaRgq6PfrNyecAatkkT8/J4jgOBsOYPbapUgyLkjAjMBxUXylT3pXAcOz6GzyS
 XjR4auh02yDRcS/gtk4oSHdl2XlKusB7+K176T007JbSZfZ3xt7a6v7iVwWIVqU0ng0c
 LH490Ou+tYPfAUBCM+W8iLCwhnvb9EwKN1dzs5H01OJA7OG0KtTtmfHioo6P0rTzQnSx
 u9uAobCIUn2O1WIQef0GlYdTUEAB+7QyEhLnzrn+Bw1BZplL4bTYE+yC93ST7U8a84VR
 RXmw==
X-Gm-Message-State: AOJu0YyN/95syXg14MJbc+gz4puXFB0wBjNUHYiRy7DAXUMujZmYjXW2
 Lq4gWToISkoW1J/wQcymDRPExUdvYhxrb7hn9o20rg==
X-Google-Smtp-Source: AGHT+IG3x3NResgWYNIlsibl7WHeoltCrVWvMLGR+kHnni+gD0ZtfOQZ6V1tINVi0bu2ST/llt0Utg==
X-Received: by 2002:a5d:8246:0:b0:787:1472:3181 with SMTP id
 n6-20020a5d8246000000b0078714723181mr5968788ioo.3.1700405226944; 
 Sun, 19 Nov 2023 06:47:06 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a023946000000b0043194542229sm1450695jae.52.2023.11.19.06.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:47:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Nikhil M Jain <n-jain1@ti.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH 1/5] cyclic: Disable in SPL builds
Date: Sun, 19 Nov 2023 07:46:39 -0700
Message-ID: <20231119144700.631322-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144700.631322-1-sjg@chromium.org>
References: <20231119144700.631322-1-sjg@chromium.org>
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

The cyclic subsystem is currently enabled in all build phases or none.
So far it doesn't have any purpose within SPL builds, so adjust the
rules to prevent it being built in that case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Makefile  | 2 +-
 include/cyclic.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/common/Makefile b/common/Makefile
index 1495436d5d45..27443863bf9b 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -77,7 +77,7 @@ obj-$(CONFIG_CROS_EC) += cros_ec.o
 obj-y += dlmalloc.o
 obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) += malloc_simple.o
 
-obj-$(CONFIG_CYCLIC) += cyclic.o
+obj-$(CONFIG_$(SPL_TPL_)CYCLIC) += cyclic.o
 obj-$(CONFIG_$(SPL_TPL_)EVENT) += event.o
 
 obj-$(CONFIG_$(SPL_TPL_)HASH) += hash.o
diff --git a/include/cyclic.h b/include/cyclic.h
index 44ad3cb6b803..d3b368dd90df 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -11,6 +11,7 @@
 #ifndef __cyclic_h
 #define __cyclic_h
 
+#include <linux/kconfig.h>
 #include <linux/list.h>
 #include <asm/types.h>
 
@@ -44,7 +45,8 @@ struct cyclic_info {
 /** Function type for cyclic functions */
 typedef void (*cyclic_func_t)(void *ctx);
 
-#if defined(CONFIG_CYCLIC)
+#if CONFIG_IS_ENABLED(CYCLIC)
+
 /**
  * cyclic_register - Register a new cyclic function
  *
@@ -122,6 +124,6 @@ static inline int cyclic_unregister_all(void)
 {
 	return 0;
 }
-#endif
+#endif /* CYCLIC */
 
 #endif
-- 
2.43.0.rc0.421.g78406f8d94-goog

