Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C333CE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319F586E1B;
	Tue, 26 Sep 2023 16:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GwDqAzoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC1F86E1B; Tue, 26 Sep 2023 16:15:48 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD86186DCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso309330139f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737737; x=1696342537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMtGbc0CJJahoofKH9jg0i4a2VTKfeOkNxUjZLG3ZCk=;
 b=GwDqAzoA3HbAuKgF3xHiasYxFqVSKmVDICXgZZIYGvqISNsJgkhsLwq5smi4lNl3qR
 lWfIGZDlUPxMyDxfl62NfPnCEAX6NUG8QMquuPBqRhI6aF9sQDCpFmbJk2/KRxUDVt4X
 lX+ann5Lom2m3ur0OQBSSflGgs1rjvlD8HTwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737737; x=1696342537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMtGbc0CJJahoofKH9jg0i4a2VTKfeOkNxUjZLG3ZCk=;
 b=UPmOErdzYHme8da17WVyMP4mFmsdmu0PuOfryLLqKNODdd3rp1veKsuhZ6XKFrVFL3
 00A6RzI3uxzJk2bynCEY1664gUvKQNfLrQ1Fsv7U5XMMj4XxGKyRcAwHkUJnmnIwpOMM
 urpDdjiBbM1SpCHmfbexOOiETV5HO07Xk3D7wMeC0B2cV7/f/d9g6xz6KTwFkqO/SPJx
 LzMfU++HP+KtwM9CPwLNuBbvQIZzfGeA+ltofW2fLiRnc2nM/hXsUo/Ss0YPMlYw16KV
 10UgTOf+lVceUrRbZpkmV0lTOrUXakxYmAazvANcRNhHC6+BXZHUumb19j5DkGQSbLl9
 +04w==
X-Gm-Message-State: AOJu0YyCWcyMoZFw7A3k2t3ZjEXwGMFLsDxNorlvBMLlrJI5pn0PV2JL
 Fyhtw048qbP5JVIg8LmIhvem1wsoYcRnVjjJqZw=
X-Google-Smtp-Source: AGHT+IGejuTNL2/CElmqVP9p23KQpXME90wQj3ZZtVlXTW7HMX+gndb0jo5ilsldAbA4PP7N60fUdw==
X-Received: by 2002:a6b:7c46:0:b0:792:72b8:b90 with SMTP id
 b6-20020a6b7c46000000b0079272b80b90mr10276646ioq.16.1695737737534; 
 Tue, 26 Sep 2023 07:15:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 14/44] Tidy up uses of CONFIG_SYS_MALLOC_F_LEN
Date: Tue, 26 Sep 2023 08:14:28 -0600
Message-ID: <20230926141514.2101787-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

Use CONFIG_SYS_MALLOC_F instead to of CONFIG_SYS_MALLOC_F_LEN to
determine whether pre-relocation malloc() is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to tidy up uses of CONFIG_SYS_MALLOC_F_LEN

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index efbaf434df48..23abb70136d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1287,7 +1287,7 @@ binary_size_check: u-boot-nodtb.bin FORCE
 	fi
 
 ifeq ($(CONFIG_INIT_SP_RELATIVE)$(CONFIG_OF_SEPARATE),yy)
-ifneq ($(CONFIG_SYS_MALLOC_F_LEN),)
+ifneq ($(CONFIG_SYS_MALLOC_F),)
 subtract_sys_malloc_f_len = space=$$(($${space} - $(CONFIG_SYS_MALLOC_F_LEN)))
 else
 subtract_sys_malloc_f_len = true
-- 
2.42.0.515.g380fc7ccd1-goog

