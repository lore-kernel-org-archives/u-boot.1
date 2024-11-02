Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0B1E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4724A89066;
	Sat,  2 Nov 2024 20:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AFEvCqDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 884B68860B; Sat,  2 Nov 2024 20:38:06 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6DD89321
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbd57cc35bso34805496d6.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576279; x=1731181079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiOlTMOrfQbBLlFivQWQ4iqSk+5zaEcjMJtTqpka/TI=;
 b=AFEvCqDVlErMomCrNuqYD+nmE/sdi63aQOMwHkbV31XDM5i798+f6tdlZpN4KL1wRw
 T8mnTXvx5XaVZGUxUGdJaSoIvxe+41MWpo2+T2+ZzmQQ5V6qmJ4xNYrRe9jN3uY6W6Mw
 nPuLQbjeH/PJkQgaAA7ly9vwRB3LZdCGmgiNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576279; x=1731181079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiOlTMOrfQbBLlFivQWQ4iqSk+5zaEcjMJtTqpka/TI=;
 b=GVoQpHKj7WIoomT9Y7gDOCJdOHQKl5yxLjPmezl8WXD2KNdJmUy8Xk7qFJxxpyzZ9+
 J2ID1V8MIqIj3A1+ane0dY8namvegZ7LgHuUqX/rQ8tQWiYWRCpe531tb7NLm/YBzW2/
 kcRUzMc3oGKtYXyz0ck3PwbJfUq5HmJ9yv579HtGV+h+gC+6cQeLEXuIlC5ZNZxsgIJY
 WQbHlp8BDZJRCav4S+wIWXRl/bwJO5FuHA4tnN9kN/jJmgvXGf3Fx00tLGNbLNMQXR+d
 5PWYWbWnpevJcjUkpYHqhJVJf/6Vjlb8hZRW5m5RBUwpS9BdtInzl85fTwBlRDkcJQmX
 c6rA==
X-Gm-Message-State: AOJu0Yysk/O0glcjFN8GHeqx66OIZ7BEU2HXCSjweZ0nzW4oBhDL2hnP
 uJTwoK2CeBM+N1L+0QrPEdwngn+OUixUbupBWLVdAFfUCgPK/Cb6Bl83KxRoGpaYYEVS4jD8IV/
 gssFm
X-Google-Smtp-Source: AGHT+IEhc/cObEPEU3qPsDChbUgnuZS1u394UizIUtWoTxec9Q9cV1Tnu8B3osTugT+hzIY+Pz24fQ==
X-Received: by 2002:a05:6214:481:b0:6c3:6477:16e7 with SMTP id
 6a1803df08f44-6d35b90df1dmr138656396d6.11.1730576278767; 
 Sat, 02 Nov 2024 12:37:58 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/20] test: Move time_ut test into lib
Date: Sat,  2 Nov 2024 13:37:01 -0600
Message-ID: <20241102193715.432529-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the lib/
directory, to match its implementation. Rename it to drop the
unnecessary _ut suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Makefile                  | 1 -
 test/lib/Makefile              | 1 +
 test/{time_ut.c => lib/time.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{time_ut.c => lib/time.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index 0b1affcf445..47a07d653a9 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,7 +14,6 @@ endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
-obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
 ifeq ($(CONFIG_XPL_BUILD),)
diff --git a/test/lib/Makefile b/test/lib/Makefile
index c36c8b0917d..217c3baf881 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_AES) += test_aes.o
 obj-$(CONFIG_GETOPT) += getopt.o
 obj-$(CONFIG_CRC8) += test_crc8.o
 obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
+obj-$(CONFIG_UT_TIME) += time.o
 obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode.o
 obj-$(CONFIG_LIB_UUID) += uuid.o
 else
diff --git a/test/time_ut.c b/test/lib/time.c
similarity index 100%
rename from test/time_ut.c
rename to test/lib/time.c
-- 
2.43.0

