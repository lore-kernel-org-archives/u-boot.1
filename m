Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D86C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B72807D9;
	Mon, 20 Jan 2025 22:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YH5YuntS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9213F807EC; Mon, 20 Jan 2025 22:54:09 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE3C807F1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e9b83aaaso422609839f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410044; x=1738014844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7ao0bEf8eDEejBcn1+OJH9PSYtG+AfA/EcNhQXLuIA=;
 b=YH5YuntSpjiNgeK9klqYWr39sWb0hZzxxvLRK+hXDk2rZefxNx3peRs5ItFKB4TCk1
 9K3hVSPhOxmkC16T8QOZduREFg3RoK++K9Xo9lyD3NNIdc1HN2teoMdFjH0dg1+BXxOQ
 +21nPU1gXdeyL31ioHCwI0ckYlz0coVR0IyLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410044; x=1738014844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7ao0bEf8eDEejBcn1+OJH9PSYtG+AfA/EcNhQXLuIA=;
 b=mwCZXdMsGAiDjcOxEGzpmhZeo7RfyJNUvkedagxpj4oObJ3lq9VQMmqjcrhxMH3ANR
 GN9OngLu4gKvVFhz6PzEzATX1qBSEgGsWFZGWj0AdGx7Uj42btHOWoGyoNFr/6UZMbVR
 uooydZylUteF85zpOtCu0eKE2x8ak17rOyrWJuBfFI2+GI6FNAwYg6u/lbmHnen+RkxM
 lzl3U6NtT/rEvGEFsfKF7wu5Z0m3OC8AxJpvvxVj3tPL+eVAXSrg6bZgzeLQlZd3NTiR
 CoL+rZAZ/1oZG00gDlw7p8yEkWs+7p4qWutKq5vcIn3Gr6IL6eE9sljmFutgSp0r2g8R
 9ccw==
X-Gm-Message-State: AOJu0YyR8bDx79dPmqiJuJq9pJsVCduEVOmD+Uzu15UQkooqozngFB0F
 s7fUW4P6dwh2tOlv4AwsOoqu9ySU5Ari4bTvUvTCF5u3SbKKj0ADAPD6FuH/2gG6kIp08kHLrto
 =
X-Gm-Gg: ASbGncvMpXAlZk4L42URYqYeNdmF7KPkHrfUpCpBN8hpA6pOAwZ8JdTVoHKCiF6/72g
 Jz3x9Tudphj6NAQjGXCH5x0+qwYG5kuGWhEFFkS0IpfAX8JNxt3ZLS/U8nhsj5SkjEVLq+CzVEh
 l3RaPjrQSjOUyu6jWCyfsI1QLYKWJK6RdVr7FfHabqwBkpm7tMo8JQFBBLCmJYX2CUtOzxdn0zB
 zX182jKeXUHAHhzxpKy9I/W4SaWMWIUvncon4uyas8YWPuVNBEL1xbrfHWuaBob3J3msjuGoYI6
 u4WnrN4KdijLcGGYclDMsF7Yso9/OlM=
X-Google-Smtp-Source: AGHT+IFSD+pZ7xhON0ugK23tfF7bnZ9kWd6li6kHsW/cclMWurKN0Rbvt1A0ueW52WptYKx3elUIuA==
X-Received: by 2002:a05:6602:751a:b0:843:ec18:82e2 with SMTP id
 ca18e2360f4ac-851b623f79bmr1264790039f.8.1737410044401; 
 Mon, 20 Jan 2025 13:54:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/28] test: Move optee-test rule into test/
Date: Mon, 20 Jan 2025 14:53:09 -0700
Message-ID: <20250120215340.617194-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

The Makefile rules for tests should be within test/Makefile so move the
'optee' rule over.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile      | 1 -
 test/Makefile | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c86e289718b..5d1b3d0f217 100644
--- a/Makefile
+++ b/Makefile
@@ -893,7 +893,6 @@ ifdef CONFIG_POST
 libs-y += post/
 endif
 libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
-libs-$(CONFIG_UT_OPTEE) += test/optee/
 libs-$(CONFIG_UT_FDT_OVERLAY) += test/fdt_overlay/
 
 libs-y += $(if $(wildcard $(srctree)/board/$(BOARDDIR)/Makefile),board/$(BOARDDIR)/)
diff --git a/test/Makefile b/test/Makefile
index 17716ef384a..5ef8c379cb2 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,6 +14,7 @@ endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
+obj-$(CONFIG_UT_OPTEE) += optee/
 obj-y += ut.o
 
 ifeq ($(CONFIG_XPL_BUILD),)
-- 
2.43.0

