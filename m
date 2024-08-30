Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC75CA0EC5
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E5C887F3;
	Fri, 30 Aug 2024 12:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KeZ4zWPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76361887F3; Fri, 30 Aug 2024 12:17:39 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962D1886E5
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428e3129851so14619685e9.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013057; x=1725617857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CS033gC+8rAkxjatyTKS0TJpFCbJLKYLXA1JkaTUCxU=;
 b=KeZ4zWPbbIQp0rGOQ1iUM7s6L2xKXGfoP1i15ySRjJ2No7Ez8EpwPJlRjPnzsUb8Xd
 BCUhCab57pfyGsP+JrjaDdyjlP7C4d9nmGBu29XqwRPItE/W9ZLoPd6HxmTUN+WLzm98
 +SL/wHOxGOd5GgwOXDrNIT12wt3aVNMQVoklkYzR0zPRAHf90FNrWKpaA84Z1AIfZhsF
 m09+4fuoRNTmh+sTrzqU/GELEYUgpu3mwcIZH+yKs6Ch5QcypE30BAKdjhYj6qhzS1s5
 qkJe7nJaxAkL5bm22FIkuC0Ex6EGI+gxCDKahs+rlQw0QEKE+ZPiUYMSbokWNRXVE4sy
 LKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013057; x=1725617857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CS033gC+8rAkxjatyTKS0TJpFCbJLKYLXA1JkaTUCxU=;
 b=gN7s5TxvxpG8M/AGObKd/OrRwx4+paFRJjHyknXS9dwx+FPirvPwm/JkNFrqhHX5kZ
 YNJr8j4TaZAkLlzl1uTZmAW3W7UGg+J/fXDoHbmn4rSy8rCwGBFCuJj+gzxtlI+l/2Dm
 upWZfoPMSunGFIYcipzh/cHEvq56arBclpcdQb4g1Wr6Uy0D41Ro+5CisIVuXy2jDVpl
 52+jqevTIvoH0WWKX8U8K/otueuFrqNyaNVjgIGK119o/w0OjJ1bUz3CxRwaIE73gmWp
 v8CbiCZ0D600EfXkQXvt32seGhHLLt3aTlQfTe9qrWauBr13JePS8OeR35RjOrckj5ej
 JdCg==
X-Gm-Message-State: AOJu0Yy4mdSOEA7pRFea5jTU/uaqJohinwfyEXI9PDHBvjR3ivx3QC0B
 6JhCdl4iECEX7TRF57GY08XP32bu6Hm8RW9ngGY5mScbtwzCQjQq7VSI5JNvNAE3HqMi5FIMJjv
 /kQToos8c
X-Google-Smtp-Source: AGHT+IH3U9nLqc6W2sVyYq4LIOKBoMqx4vuKQq3SJrwwdtlmf+zVTPVQjyaWM2Br9rMtj2uIuujqfQ==
X-Received: by 2002:a05:600c:1389:b0:428:ea8e:b48a with SMTP id
 5b1f17b1804b1-42bb01ae3b1mr46224355e9.8.1725013056751; 
 Fri, 30 Aug 2024 03:17:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:36 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Subject: [PATCH v2 12/16] test/py: net_boot: fix comment
Date: Fri, 30 Aug 2024 12:16:55 +0200
Message-Id: <1231b0ba40f8ecf807078de04597c22a29c9e312.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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

If env__pxe_boot_test_skip is not present, it defaults to True not
False. Therefore fix the comment.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_net_boot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index 63309fe82e..d7d7435692 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -75,7 +75,7 @@ env__net_pxe_bootable_file = {
     'check_pattern': 'ERROR',
 }
 
-# False or omitted if a PXE boot test should be tested.
+# False if a PXE boot test should be tested.
 # If PXE boot testing is not possible or desired, set this variable to True.
 # For example: If pxe configuration file is not proper to boot
 env__pxe_boot_test_skip = False
-- 
2.40.1

