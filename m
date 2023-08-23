Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21557C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7070486512;
	Wed, 23 Aug 2023 23:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BQolksg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16554864EB; Wed, 23 Aug 2023 23:11:19 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0989864F8
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7909307ecd1so206511839f.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825074; x=1693429874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40ytgRDa4WsLH5OXB8yIwmzPGAkuTzC4jIWmjhR7OT4=;
 b=BQolksg2JVttMOmn1rOfxJ872MXbaLjiQmeeaYjcX7NGKzzf3sliBCQsea+WJf2cx/
 JEJyrrzhWJk5VmWIEdLtLgOy+E05t1/YD5JH2emzYJyoseN5T/4zCF286qE0z9ceQnI/
 5lMQ6F2zQmQ5Z8kCCgjBT9Y/NuQDj0SoVQpmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825074; x=1693429874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40ytgRDa4WsLH5OXB8yIwmzPGAkuTzC4jIWmjhR7OT4=;
 b=jZ8t88hyOpBmy+wkwMkWQPEkMY6IyQelnhsb+PQSr1XEr0/BVvy5c9te26KnJY4pQZ
 PDD1GBye8zPLJBQSBGe9x0iZwLMNrldnGJGl+oiqVYGujeQxo9x7Rz6JwdT8lp0TR6ZL
 UQJyF2jN3VMBYsMS6UGdB5KTHNkxzpk4JFODPPRRUeo2qus1TLg8zcIe1cOeY76e72cx
 NN6RRyZEBjk5zjnKvN8VsOYKraMMrXvByLrJvi67IdQkC9a1rfQmKGJDBLprw+YkbT7y
 54UD9NxeNjD0qpKmDUsDBet6IG3Jh0xo5fg7Ijxa5KP1DjbxUKZyaERF4xQJINqXz9Ih
 2vcA==
X-Gm-Message-State: AOJu0Yzu/hFiVUXSD+ixevvF/kAE/Dob8wWc+LlGmLU08bGwOROpYR4C
 GN1Qsn2gsXtTTLXfu2cvasDsLxngKwJf9yy1E3w=
X-Google-Smtp-Source: AGHT+IG3B+nl2mpcBwux8yldqDLq18Il4JPr8rwM4vDdRizhNxn5D0x9Sx0b8nawgLN73m0xMU5DSQ==
X-Received: by 2002:a6b:6e05:0:b0:786:cd9c:cf9e with SMTP id
 d5-20020a6b6e05000000b00786cd9ccf9emr3888556ioh.2.1692825074405; 
 Wed, 23 Aug 2023 14:11:14 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 08/20] x86: coreboot: Drop USB init on startup
Date: Wed, 23 Aug 2023 15:10:25 -0600
Message-ID: <20230823211059.1235147-9-sjg@chromium.org>
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

This is very annoying as it is quite slow on many machines. Also, U-Boot
has an existing 'preboot' mechanism to enable this feature if desired.

Drop this code so that it is possible to choose whether to init USB or
not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/coreboot/coreboot.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index c2ceaa9a56c..567f1ab116c 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -86,10 +86,6 @@ static int last_stage_init(void)
 	if (IS_ENABLED(CONFIG_SPL_BUILD))
 		return 0;
 
-	/* start usb so that usb keyboard can be used as input device */
-	if (IS_ENABLED(CONFIG_USB_KEYBOARD))
-		usb_init();
-
 	board_final_init();
 
 	return 0;
-- 
2.42.0.rc1.204.g551eb34607-goog

