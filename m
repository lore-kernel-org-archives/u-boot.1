Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9DBC02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B738A80FBC;
	Sat, 15 Feb 2025 04:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jq9zZYro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DC780FD4; Sat, 15 Feb 2025 04:24:14 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DEC80B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d284b9734fso1737405ab.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589849; x=1740194649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtSEeuMiupA/PWWHjaSAkrW4hxdrLSxNODrAc4mv4So=;
 b=Jq9zZYroeBBt5w0ZaZLC4yRqVoQb0/skBx0aMFdFHsZda98xaIGzSoEPOYwDzjDr6q
 4/XC0q5u6gFBxTfdZQJRjS4qzFkFvi4ha055yocqLVme3kqTI1qb/KdQPI056I2XPT4/
 C41d/kPzu/oP+FV3LMQXch7F9GhkHORpx/cfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589849; x=1740194649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtSEeuMiupA/PWWHjaSAkrW4hxdrLSxNODrAc4mv4So=;
 b=KE2oqiNc0coo23DHKS5symJzLt93iCYXR41LHCydWOt7uHBSUQq6tYQF9HYytZlZXE
 aji5sENSwX1Q9QxPcc9juKRzvSVLNkccaD9AYjGJVUAggFkRzwkbVQL4cAtCQRzcIw16
 Bcegkw+TrzlLK9xMCKj2RT+alNETRDgSunaz1XNuEURaqe8twKDfUSzrXGsAHu1yAQNk
 TyAay4bw9KapqLmz0YigWLroxSYu3W0Kf/+0gU7gsEQkq6xYAF0G6rHlnw6aDTE9GC5j
 lfGbuKZVhfFjjqxFr5OFESo3KoaRUerFe3uZ7ZhxH83NAFeadkeA/TF669OSJEBO4ssf
 KAag==
X-Gm-Message-State: AOJu0YzXMj8sDNmV58HHPu89+DUZTMQvIJDpB2UCMq50Hb8zShtqZHyO
 2gQHbGNAcE2rEc9QWtmYgHTM0rDD4oncztKmzOlMUag7+bgVY14rnLSpEMS3qDdpreeQc4LxiIo
 =
X-Gm-Gg: ASbGncthKkdXUaaRbkSU+VkT+06UsZnAN5PRO9M4cQVAoBZDEa6Hwby7GRNd9+6k8Bi
 NwYpQcV79l5A9OKVVSgD+FD/hWU2Ca8gEy0IBbAD4DDfT1dttZqZDXg+/1lF6tBlh61HYhos9y3
 XQnokV5BAfrLlh7n4PHZLTyvf0FVkoau+OxaTiF59N+h0XZVa6KJxcznQ0srfGOqsRNvuzr5+R5
 LQp8TBIbWmoI3iiQWjKnrjNyvD2NI38Tp677Q4vUUID1PXnjWNTmdVHDMsvwxuylTepeThcCOS6
 /QpUJMbqM9cdlYLIzhnwRRknHxjv0vH/o/U8kLgxCIRE9drhGOoD
X-Google-Smtp-Source: AGHT+IHn0/wwwLadKJycFGsYm/k0c/Elf3t75TNiCBC2nAnbQhFkQrsXm+CJCZ4imPJvmiBw2RVUog==
X-Received: by 2002:a05:6e02:1b09:b0:3cf:fb97:c313 with SMTP id
 e9e14a558f8ab-3d2809cf122mr17395705ab.18.1739589849066; 
 Fri, 14 Feb 2025 19:24:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v4 22/29] efi: arm: Drop startup code from the app
Date: Fri, 14 Feb 2025 20:22:43 -0700
Message-ID: <20250215032254.4121030-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

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

