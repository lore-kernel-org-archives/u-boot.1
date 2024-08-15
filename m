Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED41C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC5F88AE8;
	Thu, 15 Aug 2024 22:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jqt0QjG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2FB88AD7; Thu, 15 Aug 2024 22:24:43 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2077688A95
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d20c4be31so2878195ab.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753469; x=1724358269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnoJRYiA0jpgdtUTiaY1SSzDLCyCKyPzj2aCRxRQE1s=;
 b=jqt0QjG7FrmJfgFtQvBFusogYhZFf3ztrHg8ze6BYYeCeHqHQ47XrLxWj1Bt5xFf7D
 OkZygmJjd/7CGg8xdpbKOK8BAoonONybj4NUC81jRxOLJ8mFkf6NA9c5bIbueuqKnBNL
 J4k7SOuV7ooLQLgEHKCisn//5nzD4LTmc8xsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753469; x=1724358269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnoJRYiA0jpgdtUTiaY1SSzDLCyCKyPzj2aCRxRQE1s=;
 b=MZibZ9UfZ68jZ7Qoaix7TKygdKPVXYWZaTMyK8ExZjmOjgxGcSgLOZ4Tdj95apO2nV
 6KlcA+8uQW9kbH1VzUN/2KWE3zayKEbyaJp3UD3bKNyK3liOoKXBETE0q9Jeaz1Unm6C
 2HUMJTYSt7vAk+J/cTUnyO6c6rtqpY8jFvth05b4mO1um++8RVRLId5B8+/Hf/sG+cE1
 jJ6RjE+RMKK2qH/xj6wQKGQoTpM8vfKABNrSMdLWI/U/kt+2pcERb84PCFwaGeLn9/7E
 4CBvgodLIbilHPZ5f1qqQViQAMKZxXLRxZPSI4rheobKeELGdNZvRDciQg84C44SFfsH
 4rJA==
X-Gm-Message-State: AOJu0YwZ3rDIfhFuWOKfDAGLmn63nZ7DhnmFzy7a13aG2MNTxRXdiwcx
 JLb+UDdbQpiFUSnIpQQhiMgTUWapeeZUWST0UQSMneF0nm4zwlaDKjCw5GekK8a1ckSDggIle5V
 yCA==
X-Google-Smtp-Source: AGHT+IGbhBsupyyTeH0h/PGtW9TJH+/EJspM+Dcg+RrGaUC5qDgDHQDmZ8kVA8dd5wuhK+qAITOu0A==
X-Received: by 2002:a05:6e02:1c4c:b0:39d:20e2:1eea with SMTP id
 e9e14a558f8ab-39d26cee6acmr10080605ab.10.1723753469374; 
 Thu, 15 Aug 2024 13:24:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 02/14] efi_loader: Put back copyright message
Date: Thu, 15 Aug 2024 14:24:12 -0600
Message-Id: <20240815202424.766778-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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

This was lost in a later commit, so add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: dd860b90ff4 ("efi_loader: print boot device and file path in")
---

(no changes since v1)

 lib/efi_loader/helloworld.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index bd72822c0b7..586177de0c8 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -2,6 +2,9 @@
 /*
  * Hello world EFI application
  *
+ * Copyright (c) 2016 Google, Inc
+ * Written by Simon Glass <sjg@chromium.org>
+ *
  * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  *
  * This test program is used to test the invocation of an EFI application.
-- 
2.34.1

