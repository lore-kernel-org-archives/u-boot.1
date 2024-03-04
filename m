Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193A2C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 07:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E1887F6A;
	Mon,  4 Mar 2024 08:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W+hUP7Tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A30587F6F; Mon,  4 Mar 2024 08:04:24 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B167A87F7B
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 08:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412ddef6f83so6532155e9.3
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 23:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709535859; x=1710140659; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cMLiw8Y/6GzxPB9g7QrJUaIu1BYr29Ydu2mmTzhcyS0=;
 b=W+hUP7TfFuvY9GZ7y8tKWP2C9tTjYyoTxjoDlfo+A2NZblvEDnGqPIB/QpDlSIBc+b
 Skeqsz9D5jBCiqWc1XI0I12hJz+WlD+w2yxq5XMsLIiMW75XVlxcwBOz1WSoKFVeorUl
 2HNCplX86ag/dE+BE4gH/EcMT52U9XZteviyp6It41UDhd7vEVFqVWSXtLM/p88/Hfcx
 3iJTEO4nja68Z5YOcO5dwYYoqp34m+FIvJxiAzd+cjAGd6KZqhUcK5EZS0jTkHA+Chay
 8mHLHR5Tj91/GNy0AZZ84slgsImiHxVlxU6jiCditIcZ64KrfVdN7GddrJHpySLTOJ6L
 DOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709535859; x=1710140659;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMLiw8Y/6GzxPB9g7QrJUaIu1BYr29Ydu2mmTzhcyS0=;
 b=EXNwYgGlzRgjr0KItmTY923AalAUZkuYomdlzwSetT2Yova23PDhxRB1r4tHwY1MUM
 jjgd/LqeZSmL98MeBq45RJGmf/6qPCDePN6ygpR6FdjrQYYv5EwMRqdciFUEjtIHde5j
 QtCoMU0RHmShKCp7taPLGAhxlSwTmY7phYT+yCFdo1bHUFBN7YVvtbfNECcpBzzmVTtP
 6Iat/KSetCCdYKOe2tJiJCjbHcgJv03DOqfOMxnTVmkyNzphCEBtNsOKB6CIXImrLSCT
 xbt6DsW8oauULEDxRMRJtDx45+gSO+pdajOivJPkSd7rwUWxjBlX4qU1AyBldl87BXD8
 QkNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyWdTYw0gngBnIZL//gurA7W+PG408M1d44OvkLYQFCpadL6rYrL2VGJf53XOzt/yyVeO4io4XsaN/B68njYTtvDLomg==
X-Gm-Message-State: AOJu0YxmyR2rYAt33mCT9cXLmOdvHuh9nYrHpfK04vpvhY3HvdU2skQr
 HZ+6bHDsKcQGqYM0hbNU0j9u8Ll3Zvs4ZheJKbW9i+lcJZACtaD4tGZjCxJMzzc=
X-Google-Smtp-Source: AGHT+IEZhQKNeB/8t+kNFxpyUjjxZ+TdJoQfrK6pfEKuDjauBCJSPV2Hc5kuV9Rnj3ZyFjhwc+bJLg==
X-Received: by 2002:a05:600c:3544:b0:412:9eec:92c9 with SMTP id
 i4-20020a05600c354400b004129eec92c9mr7043453wmq.18.1709535858630; 
 Sun, 03 Mar 2024 23:04:18 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 w13-20020a05600c474d00b00412c1d51a0dsm12205326wmo.45.2024.03.03.23.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:04:18 -0800 (PST)
Date: Mon, 4 Mar 2024 10:04:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Gendin <agendin@matrox.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Samuel Holland <samuel@sholland.org>,
 Shengyu Qu <wiagn233@outlook.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/2] Kconfig: move CONFIG_32/64BIT to arch/Kconfig
Message-ID: <b57b0fd3-dfb9-48c4-af0e-076222c85df7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb3255b-5ed7-443b-8a02-6e998126d417@moroto.mountain>
X-Mailer: git-send-email haha only kidding
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

These configs are used in multiple places so put them in a shared
Kconfig file.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: split the patch into two patches

 arch/Kconfig       | 6 ++++++
 arch/mips/Kconfig  | 6 ------
 arch/riscv/Kconfig | 6 ------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b6fb9e927337..70f3b85b449a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -20,6 +20,12 @@ config SYS_CACHE_SHIFT_6
 config SYS_CACHE_SHIFT_7
 	bool
 
+config 32BIT
+	bool
+
+config 64BIT
+	bool
+
 config SYS_CACHELINE_SIZE
 	int
 	default 128 if SYS_CACHE_SHIFT_7
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f0704d97f79b..eb7f3ad23762 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -473,12 +473,6 @@ config MIPS_TUNE_74KC
 config MIPS_TUNE_OCTEON3
 	bool
 
-config 32BIT
-	bool
-
-config 64BIT
-	bool
-
 config SWAP_IO_SPACE
 	bool
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ac52c5e6dafa..6c26f91f1669 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -288,12 +288,6 @@ endmenu
 config RISCV_ISA_A
 	def_bool y
 
-config 32BIT
-	bool
-
-config 64BIT
-	bool
-
 config DMA_ADDR_T_64BIT
 	bool
 	default y if 64BIT
-- 
2.43.0

