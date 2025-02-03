Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A433C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8219B809A5;
	Mon,  3 Feb 2025 18:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDEDyLn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D2A809A5; Mon,  3 Feb 2025 18:44:20 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9675680840
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eb9bbcc936so2825132b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604657; x=1739209457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kzn9ZZRApG/l2gZKb8QQDSh9po+jXuE6F7me3ODKFpA=;
 b=VDEDyLn+TAIFhZReR2o4KuLcxrG4eoxwj+T2T412dxl7YCRbYtEQepxKh7/LRsNzXw
 0R2Y324desMDMvfRyd7McP48dgBUsectSS3QyJAmYZbl1dj//iwy9FvSFOW/GVF3p2TA
 QdcTYvcCdYRs6EqX5BKxiGwEEIJ8xKgK+yD6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604657; x=1739209457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kzn9ZZRApG/l2gZKb8QQDSh9po+jXuE6F7me3ODKFpA=;
 b=O8P9g4xRb35Ovtu2YeWRvC1FJFnHS3xXkYVFPS1fcJXBA2ZjjVmfvO5l0BLLHu48e3
 6wOieNALnwAGwq8QGN+fiOBG4ARQaA2IWWVlrKABMQJtvST1xsPxTpLEaQ0xAuRFJ20D
 S4ph1BJKBQcelDQI0Qoel4oX/dtNZ6RXOTa5emYaFvZhfdaIiPln+fsO+5efoqDzNJeV
 0fhfLwOR2PHaJFWEU+cc5RKYpmDYgz+5J4KZmXwf154phDZdVpWZ5nosSJMqYMXc/cLg
 OyKF73Ln2PkmGbLpUkdZWqMtHBsk7ko+SLD20Zhg+2dsN0oV16GPsHCxZ0/EUNs3AuDF
 W/rA==
X-Gm-Message-State: AOJu0YxGns2yHH0av6TSE56QlOyv9tnpcj7eKQuZCB5cpPz1/5QNLXjG
 yiC9udA6umzWkD6vI0ZMmWNhorz/ziHXUvgXRkBHsCsYub0bjE1G7xPFGNVBBwB1idAsczHT09Q
 =
X-Gm-Gg: ASbGnctgN2jn1CRk/fhu0o6O6Ey7DmU0pE1KfTJTQQJDB+ZuBD291ZrNXKdeoWYv76c
 Et8gxDhKQdWp0FgZDU7YhFtyrS/7pqv8kr5OAK1EPktDTsfUJUif42ZUry/Gh/p1W4sOR90ePpH
 +pZUSpnnPf7dogyj4yrVjQs4FmPHzxBviG1bVENoq67oX3DfsphF6QJ05YLE0P6aHwpFNhbr7Ng
 2QURXrqQL/lc76h50+pp6kZZByZ7MEhmeidIel9jhThZ/dsgVsHzZSpt6pk6mp8bYb5V3KymV2g
 Bq1VqubVVJlG9ARhZ0JBjzGDsbYGq8dwpoib276m5BofbuMGx5Jt
X-Google-Smtp-Source: AGHT+IHVkeNW5X4/Kj2wE3Lf+QiJqkDcgICdf8oNkEa8AE+cwqi5sGY40Q0RcZefsyaID8nA9wovQQ==
X-Received: by 2002:a05:6808:2e46:b0:3f1:ccc5:26cc with SMTP id
 5614622812f47-3f323a0fd82mr15063056b6e.6.1738604656865; 
 Mon, 03 Feb 2025 09:44:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 24/32] efi: arm: Drop startup code from the app
Date: Mon,  3 Feb 2025 10:42:17 -0700
Message-ID: <20250203174245.1331464-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

The EFI app uses different startup and relocation code and the existing
code uses symbols not present in the app. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/Makefile | 2 ++
 arch/arm/lib/Makefile       | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 7bd6cf21b19..a8f5de58cc4 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -3,7 +3,9 @@
 # (C) Copyright 2000-2003
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+ifndef CONFIG_EFI_APP
 extra-y	:= start.o
+endif
 
 obj-y	+= cpu.o
 ifndef CONFIG_$(PHASE_)TIMER
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 9500ba6fddc..a41566c816d 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -24,11 +24,13 @@ endif  # ARM64
 endif  # CONFIG_EFI_APP
 
 ifndef CONFIG_XPL_BUILD
+ifndef CONFIG_EFI_APP
 ifdef CONFIG_ARM64
 obj-y	+= relocate_64.o
 else
 obj-y	+= relocate.o
-endif
+endif  # ARM64
+endif  # EFI_APP
 
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
-- 
2.43.0

