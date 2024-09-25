Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB22C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF76688CEC;
	Wed, 25 Sep 2024 14:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XvfoT8cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170D088363; Wed, 25 Sep 2024 14:58:04 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E58A88BA7
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so788215866b.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269078; x=1727873878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kciSc7vxbnbq5kB8LVX2zOA0PHIUiQnWpfZPga2noA=;
 b=XvfoT8cls5fU8SfhXFgHMnL3K6NXVNYRtPeB/9xDw1c03YZ9AcglpDARzNV3DuKBQs
 Hxyoty5PmmeHm464ZvaPmXtRdOyKGDDrXq543+5nwPqUDypqZqL3iJcDUmBOsIuA9r/5
 5e7djC7tdPNl79yyc2U2A+PbEPUcpBL6LKe+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269078; x=1727873878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kciSc7vxbnbq5kB8LVX2zOA0PHIUiQnWpfZPga2noA=;
 b=rkI/qv54VOU7zwwQDPlHFPKKPrNsIYAvnJpMGRhDDbUbPBNa0KwpKe2q4Z9PAJLMGx
 bLRLIT6g+a8wDgr/IlSLhBAUjZ1zuRIrIKXLu3R1x43J4xYIpyaudlq+UyQJP/DrJ84C
 sxydbXYXiEqNpFzwq8Kf5rDYiLqMIYRzcaMEqYFoVDiZmzTvRf1r7uy8oWgW7eQw+ypc
 h6eran7+zBskpVMQfJAFUFQwCE1/hxyVEUyJxXVLM8VjbySGKTvFVUimI+A5Ufl/1S9Q
 T+2z0NpbJFMK/UtoxQY8mJz47mvIBITIiwq3CohqRhhCUmoksQoJM5yqcBIdn4cyQX5o
 a71w==
X-Gm-Message-State: AOJu0Yx0/X6uAcl9rOjLTM42hIInvVKG2qG7cRBIfu4yiAn7AXJbUMsp
 H8ToMJvBkDuFlv9YJLzwAfyVS+ZY0RPapQ3z89EdxthkjaPSpKl+XFSuHWVYofHX+zQZE7sS5RZ
 50w==
X-Google-Smtp-Source: AGHT+IEH6IfKnJS1UksbqyHkAHu74SZfhzlanriW2yeUmWEFmeyISBqhCOCc38DJhc5lZK+owLkTBw==
X-Received: by 2002:a17:907:1ca1:b0:a8c:78a5:8fc4 with SMTP id
 a640c23a62f3a-a93a036a36bmr204616566b.19.1727269078251; 
 Wed, 25 Sep 2024 05:57:58 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:57:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/19] lib: Mark memcpy() and memmove() as relocation code
Date: Wed, 25 Sep 2024 14:55:33 +0200
Message-ID: <20240925125622.197915-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Mark these functions as needed by relocation. This is used to copy data
while relocating the next-phase image.

Drop the 'safe' versions from SPL as they are not needed. Change the
static array to a local one, to avoid link errors when trying to access
the data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/string.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index feae9519f2f..0e0900de8bf 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -21,6 +21,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <malloc.h>
+#include <asm/sections.h>
 
 /**
  * strncasecmp - Case insensitive, length-limited string comparison
@@ -559,7 +560,7 @@ __used void * memset(void * s,int c,size_t count)
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
-__used void * memcpy(void *dest, const void *src, size_t count)
+__rcode __used void *memcpy(void *dest, const void *src, size_t count)
 {
 	unsigned long *dl = (unsigned long *)dest, *sl = (unsigned long *)src;
 	char *d8, *s8;
@@ -593,7 +594,7 @@ __used void * memcpy(void *dest, const void *src, size_t count)
  *
  * Unlike memcpy(), memmove() copes with overlapping areas.
  */
-__used void * memmove(void * dest,const void *src,size_t count)
+__rcode __used void *memmove(void *dest, const void *src, size_t count)
 {
 	char *tmp, *s;
 
-- 
2.43.0

