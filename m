Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F68FC83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 16:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCFA80E9A;
	Thu,  3 Jul 2025 18:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fReyruLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D06F82063; Thu,  3 Jul 2025 18:05:35 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A2A38091A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 18:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453066fad06so139245e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751558733; x=1752163533; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=It07awQAiMcR0mRToSbXMzBT7EF/Sf5jCxDUnuMtv14=;
 b=fReyruLi5CkQeDDfXmFdKKtNlHFpSfKFmBt114shc4oeTyuj3xbHOKWzBC/wdQSM58
 XorLvdAlKstbVq4BfLczaHMlKc7kmH7X3hdxEa55sgpJj2m3ieAg9o4rP9ZG9b9JQzW5
 AIxav2tXgSrBXVzktoYk0jYzbjO6YwrhN0JC0/FIrjXUy2po7NJLqKx7MGJVl88SDVpq
 GGuu3YM1XdB5VSPM6JQ8At3rErq0tINAJ2Fk5Is85OEClIxiu3+/p62GYxaJ/qVsxWrm
 OkaSFCJYrWajozrU8/zNhF0e0GkWRHzQAVEGzwThEsWv2vkjDZg6KuXrRNjKl95a52xc
 JhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751558733; x=1752163533;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=It07awQAiMcR0mRToSbXMzBT7EF/Sf5jCxDUnuMtv14=;
 b=jrIsijNgUALxfe+FO20AXxVSpwuh5bjzjyVlvpVcwJXGCwpiy0lPeCo4sPw8o7pwmE
 nyDlUjsGhs/4U8QnCAbnAkmoY8hFKuNRjHBI30XkMjsJYmCXjUPZd1ylsvzECFnZUJR9
 uojXvtgUkgErnUTdwrkmLJDNqr6uMbejfPuPN1ZHxqyUlRt0/ZOwrMvZmdtp2UDsaRyV
 TSRDY5z5nkvvve6w3yEf2+SzPDRFLBz1le/v8di1nhkmSezXUqHRR5Fpd/ZA1M2d+CRw
 fyJoYsuX9QHdA8U3DoUj/fDGXkwAAQ/3EjDPM0N0Cf6Fd+mPW7ewp9bWLiaO6PUY36ki
 ZH4g==
X-Gm-Message-State: AOJu0YyaIdoN9MGVOUatBLMzinC6I4t0pV1/v4Qch4VKX0/IOezcPPrW
 IICaKM8hRZ0IZhOddZM+dwmYJXLyPkfwZO6VleyqP5gHJGBPoSa4oieBGJ6FCo2Uk+3qOShcFAw
 LiZPE
X-Gm-Gg: ASbGnct08wdaLAcOwfm2eMTUDOxdLbBA5biOQiABJ1KjwZX9GdsgBQNdImUgFBdNFZv
 3Jz9wegBXhJjPqF9OBKDL6lpYde8AKRurdaTE/At3nYlHSGl1MvS0ztxf4/55+4D5LLNk/QSu4j
 2gn9LEUkpUZP3tLZ2QQnfeReNufoDUPxhzA9asZlxFJVGqshW6Wj2u9zL8bnTEd/ypuJV7oqrzT
 lNfQjapIppV5cjTok7omQjGl/E2EhYBuZWMXBOPmOWXTg8WtoQOb1Nci7Whi3FMwL/nHbOmbQn/
 Wp3DPpratAzen/j8HqAO8FAEEYZ9AGd1dZAQACgbLSsBh8c05b0uNi6vwo+xnmrWDUig3xEzZKx
 7tquDHIvaFDFS
X-Google-Smtp-Source: AGHT+IHcsiUHhrGdRafMV6yczvnQm4NH6xI8YXSwTy4F55ovE4kCVW56G7QOd/RDLdgMgwGFdLNRtA==
X-Received: by 2002:a05:600c:4449:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-454ab3bc45bmr31977465e9.32.1751558732570; 
 Thu, 03 Jul 2025 09:05:32 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:b5c8:44f:55cc:3182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030ba54sm165075f8f.8.2025.07.03.09.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:05:31 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 03 Jul 2025 17:05:31 +0100
Subject: [PATCH] ofnode: NULL check bootscr_flash_size before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-ofnode_fix-v1-1-c739233efb58@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEqqZmgC/x2N0QqDMBAEf0XuuYEYbav9lSISda33YCJ3RQTx3
 40+DrPD7qQQhtIn20mwsnIMCfJHRv3kww+Gh8TkrHvaty1MHEMc0I68GVeVeNkcZeFqSkHnFaY
 TH/rpSmavf8glFkHa3y/f5jhOKi1woHUAAAA=
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Move the NULL check of bootscr_flash_size to before the first time it is
dereferenced to avoid any possible segment violations.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/core/ofnode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 26e014d5c53..1c285a867b3 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1960,6 +1960,12 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
 	int ret;
 	ofnode uboot;
 
+	if (!bootscr_flash_size) {
+		dm_warn("bootscr-flash-size is zero. Ignoring properties!\n");
+		*bootscr_flash_offset = 0;
+		return -EINVAL;
+	}
+
 	*bootscr_flash_offset = 0;
 	*bootscr_flash_size = 0;
 
@@ -1979,12 +1985,6 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
 	if (ret)
 		return -EINVAL;
 
-	if (!bootscr_flash_size) {
-		dm_warn("bootscr-flash-size is zero. Ignoring properties!\n");
-		*bootscr_flash_offset = 0;
-		return -EINVAL;
-	}
-
 	return 0;
 }
 

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250703-ofnode_fix-284e601e4329

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

