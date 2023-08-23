Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51EEC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45092864F3;
	Wed, 23 Aug 2023 23:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FYjqX59i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFECC864F2; Wed, 23 Aug 2023 23:11:14 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5344864E1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79264ca4b34so23657939f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825071; x=1693429871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4aIZPdmD8FnWlSQa+HAN+bDEF5lfsohzHamkcCokDI=;
 b=FYjqX59iUWqC2kAYsDGzEG14jYWZGV6c4iKFEIODzMPRuB7q23Iuh8cbYNf3TF0NBh
 0Shx2T7zJrmmnh80ONaMp8n8WHWN2cqIZuI+eplU+5YlS1eRrJLyMhHCpY1MKAmVZgaV
 HEwhd9KC6ooj6L0n+rux5JzFFewDIcHr1LBGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825071; x=1693429871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4aIZPdmD8FnWlSQa+HAN+bDEF5lfsohzHamkcCokDI=;
 b=f9nzj+kEKyjNy3E1sOe6Jm4zsWRI2pF4LZ+cC9NACU5TU60B0LBKLVamwhEFK58ung
 NIiDuYIhthgieZInH6qLRNaCXpMRb84mcQmOjDMMFEdIv2G98KGw3qxTrCvMx6fY8044
 E5WoUx5x2pwmlwMJKQrpDon9oojrpARENDM8U5YkOnE0JdKvYygARrLkmSQ1GlF/ix+J
 YbUH0zEi+b1zi+PaiG+P49KCXNp3UwFTQVqS2u+qC9tKuT6tTn5NTSJD0QD8B4ckBW7X
 3Z4Z8U8GZ7pT7lfeU8IHJML9Khh53o/VRWialJynQL7ULPHW50YC5i+c/RdKvWe3+XLO
 x+0Q==
X-Gm-Message-State: AOJu0YzxzaU/+rVBs5YbnZ8+Yp+Re/E6TUnwCn98FmmwPYfpLvfzld4r
 KQdfDaMWyF3RErAhxj1WZWugfRTkgCJGZjiX22w=
X-Google-Smtp-Source: AGHT+IGfG3LqUzfnoNIvTTwzMsEzSNamkW935n0ldCmVWnI7bGQ7Ugx29uIYnrbzfX/Ca+K4xCdOkg==
X-Received: by 2002:a6b:620d:0:b0:783:4bc6:636e with SMTP id
 f13-20020a6b620d000000b007834bc6636emr3744736iog.21.1692825071244; 
 Wed, 23 Aug 2023 14:11:11 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 04/20] x86: Set the CPU vendor in SPL
Date: Wed, 23 Aug 2023 15:10:21 -0600
Message-ID: <20230823211059.1235147-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
---

(no changes since v1)

 arch/x86/cpu/x86_64/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index d1c3873dd6a..2647bff891f 100644
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
2.42.0.rc1.204.g551eb34607-goog

