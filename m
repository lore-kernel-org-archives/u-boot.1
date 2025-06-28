Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59742C7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 22:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B5B82F30;
	Sun, 29 Jun 2025 00:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nIwkw4CY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4820582F00; Sun, 29 Jun 2025 00:44:11 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E03582EA2
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 00:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-611a7c617a7so108204eaf.1
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751150638; x=1751755438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NY1soArAlKKSbPfASHabgrq8Mj3Eb4ScTfiohek4WAo=;
 b=nIwkw4CYSAOIkabXdTNb4zTmAyQZiHQLPbS8mrbb1HgOnQbgt/CxfEnNRJxuiapyCN
 0JqMPLII1dYZYs7cmWW4r39TB8nXXtVdaRAbZRr8ute/uAzQtQbaoEPqdyw+ljlwB/rj
 RifPL0tez17ufzOqi3pEKYGFrBxHGWS/a0LmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751150638; x=1751755438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NY1soArAlKKSbPfASHabgrq8Mj3Eb4ScTfiohek4WAo=;
 b=gBqF3eNTyha3qaiTyCR8ux5tMOUwQG0plyW8wWNJRxyZ+JlZWWDSIuZW4a/koidViJ
 oCxyDOG155yW/rzYxisTCERU2KBuvHy1snrctvEAiuS47DStjJc4XB8C0GBOUPSNjppv
 wJa24cwBKcafXpYaYxOxvdh1r1YeKGB/Ffwy4GzmPqS7Z1Vvilu+5Dk8UWDb1affzFrk
 x+UKzcznOffm7lZmCNU/zctF/Z+KcJ3b2GiDYY+DS7ZZYTQPaJd3zsaQadFZbM5MW6df
 K9rWHziJ6TjmTt1z8Gn/wyMxDu2cL/Oq8bgrrwGfkSPacZTTS6e47SESz2+xjVrjU7cr
 K2WA==
X-Gm-Message-State: AOJu0YzmlovUGD3c8y15B1yMem/H/wdwE0Hhx6C18NRDcr0bfnIKSU0+
 1/2ZRpCviyrkWwCk6dAWfGfLep3YJpo4a4eUL3y3OjxMENvOj6UIeJ3BaH/uE5Yr/72bIX6ISCu
 v+EBbxvE=
X-Gm-Gg: ASbGncsTdtDURdZTg73pKolX4do5AlQU0xNwpvZR07CttTWdt0Zcg+HCVWogmIDILE3
 W9AU8dcBpYe1MYJpmANvTF7KSPxVB3FvpvgZgsovfsMnQ+tUofm319z8OJ/tGHqnQFiJdLRXKfL
 DfqIbNKuH8sFD3xQLl3kxfGtOowi+FgR9akLyTa+q3o67zk7fMMvjfUXcgq8BrCFLKQ6hx7haVs
 62Sf8al0zQzYOGZkEyIm90jQlKdJV+g/xyMVX5CYdDfgZM8xFuShVbmFQZbVQQhIzZ4YZ+KQyhF
 NIJAqAnGrIf6fQYSe9F9O5Q/bnaK8ebPtpq2lJDrSjlMhkCATwn2qRC8g7nq/RFSVJNQujL3Ebo
 4UHEhwBWaZYj4w8WnLeVhwUhYsA==
X-Google-Smtp-Source: AGHT+IFgQO6wEhiWC6I0zZEyZLBFRwMyt8CFkg3C+iRu5RdAmbeICW2MlC4hmgt3qcEKNYVbYabkPg==
X-Received: by 2002:a05:6808:2202:b0:40a:52cf:8870 with SMTP id
 5614622812f47-40b33e37bfcmr7689560b6e.26.1751150638139; 
 Sat, 28 Jun 2025 15:43:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243e4besm1013148b6e.50.2025.06.28.15.43.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 15:43:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/5] include/sata.h: Audit include list
Date: Sat, 28 Jun 2025 16:43:50 -0600
Message-ID: <20250628224352.85694-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250628224352.85694-1-trini@konsulko.com>
References: <20250628224352.85694-1-trini@konsulko.com>
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

This file does not need <part.h> so remove it. This file does however
need <stdbool.h> so add that in.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/sata.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sata.h b/include/sata.h
index 8414e77e42ba..868e89464f03 100644
--- a/include/sata.h
+++ b/include/sata.h
@@ -1,6 +1,7 @@
 #ifndef __SATA_H__
 #define __SATA_H__
-#include <part.h>
+
+#include <stdbool.h>
 
 int sata_probe(int devnum);
 int sata_remove(int devnum);
-- 
2.43.0

