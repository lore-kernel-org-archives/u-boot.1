Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7DEC8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1987183189;
	Tue, 26 Aug 2025 00:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="li4zLIfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9979383145; Tue, 26 Aug 2025 00:34:34 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F59E830A0
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b4d892175so23674865e9.2
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161272; x=1756766072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sH1XUxqC5vOJCaFTbGgKL+mKULrbNv67pjJ8vpIlcko=;
 b=li4zLIfIfVIMrK3gdcIFstlcwmilabHLoEcwhiXdi1fo9EADM/3oZAespyVWHjBWv4
 d0ImqCkCWd/nHFVY8/xc4NQMO094Lr2El4MgNQmsXcmJZHQ56iEcsDjCNIixpqbbpQKG
 e/1pUV0xhIPuK2erzEtPswTNzxTriBAQ/9yruHGhtdkXnL3hRq3vLb8vY7QLu+uBQfSe
 7t0agq5zVbDKSBd9thKD+8xmAq6taUfIOcDQSOWBYCkg3tEf30p+RBpliAQoqzwARTYh
 8RIjt5A9z7BEFUDAWxsjFXovaS5KSq6Kc6Ct7Kqa5jI/qxOx/D1+smB4LQ3lw8fSaKaO
 FNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161272; x=1756766072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sH1XUxqC5vOJCaFTbGgKL+mKULrbNv67pjJ8vpIlcko=;
 b=T1ASrpTXhnNGC2G6X0GTI3I/o0SWs6h8CuAZ0wkWvTjtBNeXymdJEchD/oUIaMb+kE
 bs+aqXW2e22r/nCL7xDVENfw5NpKKwiy6IHjgff9+2GyKlP+7J/5J3gjVhUS9uZMUIOI
 +Qng59zG4wJT3qA7SNw1UfBMN7zxrXUHB/6iBfT0uU42/Na+KEkjFxIguyad0YRNcYYP
 ezWb/kJUZWYH6gHtoszonEXezya5OGtpbrtt3dmxkTaoWEZpzO0DP3vCAr4Eh6NfNW6r
 vaNr1VQfDyWmG/6yPqgsX/LswsGU5Ah8dd6+Az4b81AdDztfnU/HYez8nMyUVOqvK1DP
 7Aug==
X-Gm-Message-State: AOJu0YwVoBNMmsP1QtlOW4HBxqLlcgbx1cZULWSMNYLpRRHJPqOJbw96
 jiMqs/A/GUGIoN2yBqJLAhQRNPfVAwELePMnML5zZgctARWzjIPO2lmBppuUxcFGuvw=
X-Gm-Gg: ASbGncsHjn3Lja1ESTBUPKxGS8s4V0bv/TGX/ZiKG4IrpZbF5cCueWvsvv8lOrLhrQM
 zALNU2vgrLpo6Xe/rJbWyq5lBr/bbYRUfGKw6hEw1euG8r/qMOEmwJsFjMLTYd3wD4K8MH4rfFd
 vBKrg4sEq+lJammLlcwORf0yZWWCWfmeg3I0sKzKLbmTUAXLOIgOhG3himh5Q368DYVQbI77I/f
 paauBKn7GZxUHukncAxkYB458ui82PsTjSY5vjGUt3TvnWuZsCVz9GJMv054S+GtGq/oa+GOnvk
 9BrCdH0Bey+v/qH6kNvKDmdsR808MDAIAizL0jdVMPv22UMS7Amz1An9tTphkTTJmQIPhm1EfXN
 KiXSZjs8QfIzUrM8QzFRiEN7aaDVR
X-Google-Smtp-Source: AGHT+IE5InLLAUzH6/KtPNEHVDjEd89yFAV37ksiiuGMUCbe77fsjyvOBd/8uzt1KGMHFl15R5BOfA==
X-Received: by 2002:a05:600c:46d1:b0:456:8eb:a35c with SMTP id
 5b1f17b1804b1-45b517d9601mr136004775e9.31.1756161271651; 
 Mon, 25 Aug 2025 15:34:31 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:31 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 06/10] doc: Rephrase to be more clear
Date: Mon, 25 Aug 2025 23:32:33 +0100
Message-ID: <20250825223251.674591-7-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
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

It might not be clear what is meant with "to make sure the shell leaves it alone".

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index a6ae9b0a9d1..709fe82f845 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1273,8 +1273,9 @@ Some options have values, in which case you can change them:
 
     buildman -a 'BOOTCOMMAND="echo hello"' CONFIG_SYS_LOAD_ADDR=0x1000
 
-Note that you must put quotes around string options and the whole thing must be
-in single quotes, to make sure the shell leave it alone.
+Note that you must put quotes around string options and the whole argument must
+be in single quotes to ensure that the shell recognizes it as a single
+argument.
 
 If you try to set an option that does not exist, or that cannot be changed for
 some other reason (e.g. it is 'selected' by another option), then buildman
-- 
2.48.1

