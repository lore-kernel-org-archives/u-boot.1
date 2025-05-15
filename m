Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00DDC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7253B806D8;
	Fri, 16 May 2025 01:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rZ3O0V4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F3B182A25; Fri, 16 May 2025 01:42:05 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFBE81DD6
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so615791a34.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352521; x=1747957321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAg6P3lC8mMwjfmgE2N0nwW4l73iQyAOMTc2Xk4yKc8=;
 b=rZ3O0V4K1K4i+3sP7J2CdI5hY4BhtWCLWT55JOgrN0kX6GbXdC4Zb403Lxg/ety4TF
 ZMQmzp15gHvvJdM59ewMkkpZsEjqCC6nemqx/ISjMwRRVj2HLCnj/a2W5A2Em2qHIU7j
 qnNNbnbgbpiZe+dxGaspx6eZWxM4yz2cdrqUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352521; x=1747957321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAg6P3lC8mMwjfmgE2N0nwW4l73iQyAOMTc2Xk4yKc8=;
 b=jG6H2HiItLWxL7+dycIn+7YI4WMhl1eIRacXuHCFueBR58uOi5l+TDsh5hWWMYio32
 pZ1hqrcxjE5M+uikJ5V36m+6HvWDDUb8Z4LIYniXPqorpZSjmd9A75nAMxkCJSYq04ux
 pOIdOjKG6BkLhg2AsahzgxD3gGnnCccDTqPs9Pn79h2TOnNgY0/adwS8ZKacQwymwgkq
 khGbUMd7IVbpIORrO4K0P9yW/RMKOfsPafEv/J8pgLzWXb7oupo0RD+3e0NxAWgV3mjC
 o9a5EIcGA37HfFpBSgNPPlm9XaElv7TxMjsnw9w8JXx17Sfa/6aILzE47p8CGErCmwrJ
 Ng2w==
X-Gm-Message-State: AOJu0YzLUFbMgSCVrFspFf3hYpv7DX7phd2cztwudbqVkNZ611Y3Gt5E
 tqG5c07xHMehqQ2Ddzpgomlyu0w64nhlH8yvXXwgWYmM1AXXBfTXUe7rDa8Z3HEeBYRMrsmheDD
 EgS1TMZ8=
X-Gm-Gg: ASbGncsr2gL49wlR+7CDRKe6OYvbLzS6On4izMTyh2Z3xEjakPjJ1YxYhMnT+CR2iGw
 xiz9TJuqBrZrrWjBoTWBPbQHD8edoATZbG16GznItNI53zqrQum4B6zT70ku7P/C3fCWUqocubP
 PoB1ByP4xw2SVMMgdUdOMIQ9pO4Hz8xuJGSAu6CC41pEbF7g7KuGaXwwJ2/nbOg9+GowKeFTubi
 4DzV5khrHAT+USy5LBNWHSdbcNLjJSFL7LVX6TQxTZ+SiV5/jBOMIkf3PKx2CRbQFeJf+VA/WK3
 WdYmG9bf7m/71wzeucNNwf8NdN7N275hZOUxhqp8YqJPVKwhmx5Cj6CAdbKHhQI8mqvp9F6V09Z
 BPIj8WQ4MxveqJWo=
X-Google-Smtp-Source: AGHT+IFyTPppSq+gj9Pwp9PwVuDdJywMNIRzUQBP5+wUkvuu5p0Xm7g1Qm/uERusm+p6pmQB/NHUbA==
X-Received: by 2002:a05:6830:61c4:b0:72b:a020:a2c0 with SMTP id
 46e09a7af769-734f99582ddmr403202a34.17.1747352521207; 
 Thu, 15 May 2025 16:42:01 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 02/22] congatec: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:31 -0600
Message-ID: <20250515234154.1859366-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- Keep config.h, update commit message - trini
---
 board/congatec/cgtqmx8/cgtqmx8.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cgtqmx8.c
index 054e4e10867a..03be02a2884f 100644
--- a/board/congatec/cgtqmx8/cgtqmx8.c
+++ b/board/congatec/cgtqmx8/cgtqmx8.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2019 Oliver Graute <oliver.graute@kococonnector.com>
  */
 #include <config.h>
+#include <env.h>
 #include <errno.h>
 #include <linux/libfdt.h>
 #include <fsl_esdhc.h>
-- 
2.43.0

