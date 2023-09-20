Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2503CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 964BD86C4A;
	Wed, 20 Sep 2023 05:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V4fv9itU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0503886C0B; Wed, 20 Sep 2023 05:00:39 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F9686BF7
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-350fbd09d8bso162245ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178835; x=1695783635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JCuA9a2jpIg7eaMjmv/zjLecEprZUNdKg6NU9VQOXE=;
 b=V4fv9itUiQgPVa/wT7+/RioNnmyi9IsOg7t9pSO0B4FyhyvOFgWxidGyCsxEFoiAys
 zK/QIwsIq8g6OlykgBZ1mEv4lxE8tIPGrZw9JokWC8WPPcpftXT9KEDILtRbpiDX9nH+
 FAS2M/HsJGE6dT4knn2DV3atAYo9qRExappGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178835; x=1695783635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JCuA9a2jpIg7eaMjmv/zjLecEprZUNdKg6NU9VQOXE=;
 b=j8QZ17d1a7f1fy8lj0YfdjXvllLUnSIj6EChwXbJZF/+yxVZGD5Eirn7yDu2Z0ytYN
 ni6vxNeZeLrKDLscE1bjZfYGxLNRmdRRFBikdBK03oHxONFW1Ku3VLz4SfHri6A57s1J
 nyUc9fI4xaBfUM/XizIVoOCXgJ/OgGel4Fdw/lKkT3NlOPAqY9JCQF0WYdnHF7f5R+9J
 Zu7ssRRezG6jVBhYb1YIcTHZIAOQSyFkNLqhnmv35w+hJV188kDw4berr8l14iX0trF3
 kLt8iKeFo+gBsngFw7wngzfKKRKEGebhWivN4LfOFarkNqr6tar/N8GQ9JXChZzwE1rq
 3OPA==
X-Gm-Message-State: AOJu0YyAzRH0tH2dKCzuC9mD5o6bCmyn8O9vJfz1Nbryz7wNT7tYVsvY
 Axwg6Br6o8WHw064De5SS+REhcbiroOzYFy1Lqk=
X-Google-Smtp-Source: AGHT+IHt5fZuVfJkKqmvwCNzMh+Ws8EF1IxCs2GMlkI16KezP2nx3IjV/7aIsji2l5k5o3Y+d6hP8A==
X-Received: by 2002:a05:6e02:1522:b0:34f:e5cc:43fc with SMTP id
 i2-20020a056e02152200b0034fe5cc43fcmr1999905ilu.17.1695178835518; 
 Tue, 19 Sep 2023 20:00:35 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 04/20] x86: Set the CPU vendor in SPL
Date: Tue, 19 Sep 2023 21:00:05 -0600
Message-ID: <20230920030027.1385833-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

We don't read this information in 64-bit mode, since we don't have the
macros for doing it. Set it to Intel by default. This allows the TSC timer
to work correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 arch/x86/cpu/x86_64/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index d1c3873dd6a7..2647bff891f8 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -8,8 +8,11 @@
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <init.h>
+#include <asm/cpu.h>
 #include <asm/global_data.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 int cpu_has_64bit(void)
 {
 	return true;
@@ -38,6 +41,10 @@ int x86_mp_init(void)
 
 int x86_cpu_reinit_f(void)
 {
+	/* set the vendor to Intel so that native_calibrate_tsc() works */
+	gd->arch.x86_vendor = X86_VENDOR_INTEL;
+	gd->arch.has_mtrr = true;
+
 	return 0;
 }
 
-- 
2.42.0.459.ge4e396fd5e-goog

