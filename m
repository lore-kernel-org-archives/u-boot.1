Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA83C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896D987D38;
	Wed,  1 Nov 2023 17:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ahE1Et3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CA587D25; Wed,  1 Nov 2023 17:28:40 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D661F87762
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-672096e0e89so79606d6.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856111; x=1699460911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mDqNAbRNjpbbIzA9KST6zw3j2FWInzP3k5sk/toY5E0=;
 b=ahE1Et3FtalSujsUyB4oeckzU6kt/tIVQLGLNmG0VRAoasMxNrOhEDm17Q+mCPfkTz
 mMxLv/zTz6NhIvlk4UkgCAaEnHiu+tCs0zwhDMMKrkgzEHUR4PXXHpvHZTRk5bsF3czY
 Ft9Yh6kZm9kYnwemDYxgp9v+uC13BW5a5Z7tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856111; x=1699460911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDqNAbRNjpbbIzA9KST6zw3j2FWInzP3k5sk/toY5E0=;
 b=kHdElfVlbUccxROj4KiR4b+9j1uwRYBT1A0JLT7+bkpGwX8ztUPdWFKAnqvBSwa8Ux
 0AJ1ItLw1GWmCFjJCKHRHDyjL17wIKTchEi2EhuLXVStwbgwuDH1KtOw0QsfYQamA/W4
 9YSICD+baBXXZaMR/VCJc3LpSaQUiWQGibDQsb/r9/dknJp8/5dVMn2/vl9C9uoE5MMj
 WjZ81yAAT95/m5IIEqGgzhSy/WL0pI0wsAhHBfYkzSsNZ6/nGWdLGKjgLXDHA9ALwTC8
 +LPJNgi9CNhPTdjrCw7QjnsScQBLX92rfIW7lMaDyOsK8loox5IO28WE8B3H5+pw3RhW
 I69Q==
X-Gm-Message-State: AOJu0Yz3uvdNOjDPwEZjiev4eIaj4+RTN9RjdE4dS1TPs8ZK7pum1wuo
 DnHKNZCkCs9Lztn2vcmBK+J16EHGjb1yoGn+I11GuA==
X-Google-Smtp-Source: AGHT+IER0FV7gAR5rbwZ17k0EJ3x5D6P7ZSo3Zi6F0hlhOndS2t64qWbGSfpJxuoKoL9ATCZR4VJ+w==
X-Received: by 2002:a05:6214:2482:b0:66d:59a3:f9e with SMTP id
 gi2-20020a056214248200b0066d59a30f9emr19896261qvb.63.1698856111487; 
 Wed, 01 Nov 2023 09:28:31 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 06/20] spi: Add <errno.h> to spi-mem-nodm.c
Date: Wed,  1 Nov 2023 12:28:10 -0400
Message-Id: <20231101162824.3755579-6-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

This file uses errno return values in functions, so include <errno.h>
here rather than rely on indirect inclusion.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/spi/spi-mem-nodm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mem-nodm.c b/drivers/spi/spi-mem-nodm.c
index 77ddb19a9f32..f9cadcc026dc 100644
--- a/drivers/spi/spi-mem-nodm.c
+++ b/drivers/spi/spi-mem-nodm.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
  */
 
+#include <errno.h>
 #include <log.h>
 #include <malloc.h>
 #include <spi.h>
-- 
2.34.1

