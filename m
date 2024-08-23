Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA12BC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269B5889B4;
	Fri, 23 Aug 2024 15:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yx8CXJAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F71E88965; Fri, 23 Aug 2024 15:49:13 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A895588722
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428243f928cso16093315e9.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420951; x=1725025751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOTQNZd1OFEvNEscEUawarENuiq+pq1NNlw8zoOJclY=;
 b=yx8CXJAIb3C4gGVxKqMrP0RS2ux5YhZ9vMzIe19d6z1UuexJBLhoC4JqTCTLoWnjtP
 9AGaQ2XyikYsFF5qiSHOgTRPhK54d2ZSHvErUjvWZade5Vpc1RJkKBgdi+Nh4okrNCIq
 5w5Qb+1JSMOqk3e3mD9VzDczzL5KtyKv8HYZJvyRHZ9wNtwW81Oy5INGaIndJio34tAQ
 5QJ3fH4YpyVxSE5wEa6NPIkJVkBESELQd4Nw28sByMOwYW2rpKS3gMRAtuyOn0Yd6sCE
 l2orBFLYQhmuGpgVxn06TZvECDjKIPoWOABlVizGQQnHmjKPEBCobUMDj23ysgGAl5Ta
 k7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420951; x=1725025751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOTQNZd1OFEvNEscEUawarENuiq+pq1NNlw8zoOJclY=;
 b=H1qIV7yTgowO+rkAfrgDqLFaGod+PbDtVzv+zCmY66EJkToUnLB1zUxlj1iniTOrwL
 OGroqGjq5gpylcQejrocV42F3p76lYZTXu7tNkA2dTrvf9v4qeRcW+eXzb87CCUPGq1T
 r+sRge/l5tcUqU4DivVEs5m46L3daSLacknks+Zv5u+twzcycYPmeUDiDo75rX+l2bPQ
 cqFcmE36UyzY5hiXbF1mre8jaWvA9rzE5K6pVqgpiejgaMT7o1m/UdM3vGRdLm8FuHAT
 stiItH4FIwHzzPfTky5iMNc3F+0pZblil8uYMF2NGOZPb15qTKf+Ne0oCgBV5sn7vHMh
 cb/Q==
X-Gm-Message-State: AOJu0YxpuBsQil27CKj0ox2YWlscQvOc0lK+klEFLbDsMuRbwvbu7og5
 3AFHLhwRTzaIfLxO9FcPZlaVMN9Zhm75Dhf3JhJdwWmTEEv2rqhC3ZgwE47LadYWCEMAMc+EI9G
 r0E4xgg==
X-Google-Smtp-Source: AGHT+IE7oj62Q7KKciiInKKie0rdAkBb6GWQdmXpPVk+QVTmaXjyxa5XTAcpjpqZ8QZxjPsecarJ9Q==
X-Received: by 2002:a5d:424a:0:b0:371:93aa:361c with SMTP id
 ffacd0b85a97d-373118878f6mr1569906f8f.7.1724420950918; 
 Fri, 23 Aug 2024 06:49:10 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:10 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
Subject: [PATCH v9 01/37] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
Date: Fri, 23 Aug 2024 15:48:05 +0200
Message-Id: <6ece1bd7ecd90c5396247237cbf26ada63643ca7.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
detected and the sandbox build fail. It typically happens when using
ccache. For example:

 $ make sandbox_defconfig
 $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
        CC="ccache x86_64-linux-gnu-gcc"
 [...]
 In file included from boot/bootmeth_efi.c:16:
 include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
    33 | #error Unsupported UEFI architecture
       |  ^~~~~

A similar error occurs when the build is done via buildman and
~/.buildman contains:

  [toolchain-wrapper]
  wrapper = ccache

Fix the issue by considering only the last word in $(CROSS_COMPILE).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f90e48f58a5..dc7bdd79420 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
   MK_ARCH="${shell uname -m}"
 else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
+  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
 endif
 unexport HOST_ARCH
 ifeq ("x86_64", $(MK_ARCH))
-- 
2.40.1

