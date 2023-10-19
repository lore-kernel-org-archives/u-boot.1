Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8535CCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC4828748B;
	Thu, 19 Oct 2023 17:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jAmZBdLj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1EA8743E; Thu, 19 Oct 2023 17:01:32 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B958745D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a877e0f0d8so7552767b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727688; x=1698332488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WiEHq7p8aMvtiykxv8utIa5Q8Rliz9M4cSuuKPx2Mrs=;
 b=jAmZBdLjkyYQxzozGGRm/Ea0HEpWjmKWwfxqCPLhgguQSeN7NqMdLb2Akz1cwbITPH
 0futNZ66TfXg47a82pSRY1xBzouMO9L8JcwNLxnr+j4gySuamQpL7RjwcqwjPZ6uFA/X
 lRILv/6YFCn7n0Yl3XKQ6aodWS4Q9TrS6cMDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727688; x=1698332488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiEHq7p8aMvtiykxv8utIa5Q8Rliz9M4cSuuKPx2Mrs=;
 b=dcjIgu8vq8qix4BEe9bmF5MfH838N2OAUpvy/qJGOWWoIPezXs8/ZPMZp8SRHXDOCb
 so3itDMHiIYiuG3NRCrJixcc2YjlbGBzvCWi2uuhBD4mvsy7TiUyjp0hTbDmGeS9mz43
 FOBUyt/kfmNCG61FMkToeFjLOytXlTK2hlKASsPSWQomXi5YUFTF/Kbqat+C3m/Er9yf
 +IvI5LEUehe6s8jNNy2Yydf34XKcx4dTbGynbv5BmhyhVCQpcrhWLZLLLLkgp4YL/ZF3
 t+VFaKzp5E6Ralk9brytWwsBLkHex1/wOR7s9NtPWmG+MINUCjmx+M8zrtEzOzpvWivx
 +axg==
X-Gm-Message-State: AOJu0YzinntvaKLJU3CbX7ShTWh2yZdDMTP/BkgatQxaFK82Nf/fqi9F
 QF87Ue3knkpyf18QKWZbVLfQqNd5xe5rgLlWCq6CuA==
X-Google-Smtp-Source: AGHT+IHep1iJh66dfw9JgML2sy1SCauYDOvVyMt0Zh4fpWgEL4R77wvok/1rjjtZm6vOzAevBMjWGQ==
X-Received: by 2002:a0d:cb87:0:b0:5a7:be23:296f with SMTP id
 n129-20020a0dcb87000000b005a7be23296fmr1615721ywd.10.1697727688421; 
 Thu, 19 Oct 2023 08:01:28 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 19/24] boot: Make preboot and bootcmd require CMDLINE
Date: Thu, 19 Oct 2023 11:01:00 -0400
Message-Id: <20231019150105.714407-19-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

In order for a predefined "preboot" or "bootcmd" to be executed by the
running system we must have a command line.  Add CMDLINE as a
dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 40a04f43ee3d..fabf6fec2195 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1558,6 +1558,7 @@ config BOOTARGS_SUBST
 
 config USE_BOOTCOMMAND
 	bool "Enable a default value for bootcmd"
+	depends on CMDLINE
 	help
 	  Provide a default value for the bootcmd entry in the environment.  If
 	  autoboot is enabled this is what will be run automatically.  Enable
@@ -1577,6 +1578,7 @@ config BOOTCOMMAND
 
 config USE_PREBOOT
 	bool "Enable preboot"
+	depends on CMDLINE
 	help
 	  When this option is enabled, the existence of the environment
 	  variable "preboot" will be checked immediately before starting the
-- 
2.34.1

