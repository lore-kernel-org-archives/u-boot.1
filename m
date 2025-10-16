Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5603CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 13:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3726C836A3;
	Thu, 16 Oct 2025 15:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LXqcvK5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A66B836AC; Thu, 16 Oct 2025 15:27:52 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5AA8367F
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 15:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4710683a644so7440955e9.0
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760621270; x=1761226070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nD9MvvkBAqAzjYBYoS4qd/0bHMtuiR0JDjCot8lL+ng=;
 b=LXqcvK5XegQuGEGNpCUFBatp6esJeTljCpG2NXTfQjugMZVNRrxz/oo6rqBXMf1aG4
 gdKNrznaGTzgfUI8XfKZWpPYn9FmdqioTMH/sqHyZ0WAgn7AELYaK46KKZh4dvM8dVvB
 W6uJsCeYsETxt3ahPleSb05DBHaqa5+75oS1yyG99O3hYSTs34m6zMcVS+IsylzJ0LCT
 fCTje9Kc0bl1SkmEmxK05t0QgUjpH7J4lU7SEJZhGZ4ppvFF9TNN7KJUwCHKOnksxw2B
 XwKE/9o02FqL88me8oGLfnaePJ7569SBh0ln5pTepkew/4QB/GovmObNrJ2MFZpt0OUf
 inMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760621270; x=1761226070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nD9MvvkBAqAzjYBYoS4qd/0bHMtuiR0JDjCot8lL+ng=;
 b=swdptt4EBjhe8Ra9IXAsj47zBT4JE3jOncDTehIPh1sveLqyEupFN6gcRyZnNwE+dO
 8NrZm1HQwOz0vmbGXa3/WUtVK9YrI0/rikbpmtzILWH6Ep3mtG0SFoNmJamFVlFErS6g
 YtjI3ju9e8Aa36iePC6J3pMuOV5WbAT6lbeBBc4kC0jmqYbqJCe3ku1PawotPUF0/2fG
 MdTcYqJCQpDTY3k7b034z4/OwYagM1R+G/GPLyTXx+Ngf6uwnXOXdNN0tpc/UyHlEyzr
 dgi0k5gRwUb3e+W1z7SRPxw4jffAhHAnWxAlXF5WVPTeL7rHTmtFPlEv1+i51eAMQlo6
 aJDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJrPmFikPOJa9Wh92LNlcahuKP0MslWXFF9u9pbaS5bRkV5FpEYAiVYIgxJqRmIbTezil/iVs=@lists.denx.de
X-Gm-Message-State: AOJu0YxtRd/DThvG//ROAQYtqGX0mt5Dmqh9cpdwDczLnbMV8UT8Fyfm
 Pvpyko9b0Ngdg1YPqs0vdQ0dAfGQZ5tCPeaiEIqp/N2JDOLXwdJrKEf6UOHJvb//4g0=
X-Gm-Gg: ASbGncukW85lZ5q6oKA+kR2MoCGQTs5MHIHY5ArV5KIU7ZMmkBwL3MHDZET7OWMwrJG
 Z9eCkQ08xvw3Say8FCLPoARplZFxyr+Bu4GnIo8qG6dp1rNFOy5TsbvEeULq1f83X1OOO1YPAtL
 fmG0W5QMpvE6hUcL9XXlCLh74r1w5GYzqRbwWHjzxLrphMtCGzljSZEVT/aJ+AqHezE0m+I8toK
 Cuz0ZFYumLDJxuJRbV4S4UioczRBng7AEp+HT9k+HJM3WA0pnsmmk58AP90nPcscQz0YTc+1o2q
 s6IWqCpz7TQcWgPIS8nzFV8Sf+EPiCoFGX6KAQmpNoEbvnOiAwPBRnzTI4XN9D6s1A1yfb3Mrpv
 FtJdefyjw6JUO3YB43zSjvILqXD4JXdnDP7/f5IAcGmWjWGFvnXJBRMN9iGUKzaT/p9kCpt6aqn
 iKpO7W7lYqEdJ3TsJxochnMLioLOBpwashNNDCgiAfk2v4W9uv6vOkukL6PTQrI0k=
X-Google-Smtp-Source: AGHT+IHfXU3ZaT5XNJuMs2Fay2dCXD5TYYwem+qLZetK+yiKRkVfzHS08Iq+TyUdQuCN3YeUpBH+cA==
X-Received: by 2002:a05:600d:62eb:b0:471:6d1:9895 with SMTP id
 5b1f17b1804b1-47109b58f90mr17486995e9.14.1760621269924; 
 Thu, 16 Oct 2025 06:27:49 -0700 (PDT)
Received: from hades.. ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c91sm24963155e9.11.2025.10.16.06.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 06:27:49 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: raymond.mao@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xu Zhang <423756212@qq.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] arm: armv8: Make save_boot_params simpler
Date: Thu, 16 Oct 2025 16:27:43 +0300
Message-ID: <20251016132745.237295-1-ilias.apalodimas@linaro.org>
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

The idiom used in save_boot_params is common for armv7.
In armv8 is much easier to do the same thing with adr/adrp.

So let's simplify the code a bit.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/start.S | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 829a620faeb6..40c342e97e9b 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -387,23 +387,18 @@ ENDPROC(c_runtime_cpu_setup)
 WEAK(save_boot_params)
 #if (IS_ENABLED(CONFIG_BLOBLIST))
 	/* Calculate the PC-relative address of saved_args */
-	adr	x9, saved_args_offset
-	ldr	w10, saved_args_offset
-	add	x9, x9, w10, sxtw
-
-	stp	x0, x1, [x9]
-	stp	x2, x3, [x9, #16]
+	adrp	x9, saved_args
+	add	x9, x9, :lo12:saved_args
+	stp 	x0, x1, [x9]
+	stp 	x2, x3, [x9, #16]
 #endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)

 #if (IS_ENABLED(CONFIG_BLOBLIST))
-saved_args_offset:
-	.long	saved_args - .	/* offset from current code to save_args */
-
-	.section .data
-	.align 2
-	.global saved_args
+.section .data
+.align 2
+.global saved_args
 saved_args:
 	.rept 4
 	.dword 0
--
2.43.0

