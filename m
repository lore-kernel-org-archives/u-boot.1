Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E120AC369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC0D88B9F;
	Wed, 25 Sep 2024 14:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sk0/CcyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D11888CD9; Wed, 25 Sep 2024 14:57:59 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE5E88AA7
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so102381821fa.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269073; x=1727873873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lmz3ZBfNtAIv2vHaWtxuz5yci45e/SlWzBgUGnIw558=;
 b=Sk0/CcyGyMt9s0U52geRNPLitbFYhUupzJhOCMk502vIv/X2n9cGSpbaKAbqUFds+i
 tuz+FWq0WBfGOBpiu7iwWQxZiZwC3FS8MEnXqYXukES8d/RQyIWbfYM7zl1Lgis8SImd
 I5x8LFIbiGyGeUUVbnc5/JHg1RKoQ3fCoiuFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269073; x=1727873873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lmz3ZBfNtAIv2vHaWtxuz5yci45e/SlWzBgUGnIw558=;
 b=wW39QuTH83iHnr8phFxBwHztadvNCv1anP6rwonLmZoVMaJaPRt4Yo1s5J3t6S5VSY
 JLetTNej0Qo5p+X0+Vl5KxA+jnpXqI5IsgApPGcUxL4bOq85En+xEMWkzTrAL3AOeHEF
 dyvVMsRZ4bRynmDoN+CFDF8dKC9Ly6/hwvmQj9/txIo5vALU8YkxY7WDoKa1PkL2MKp4
 oQS7QaDje95PQcj0323KzvvuF7ShcEHE3xclSeVYJ7v86lunUX8S7S+mYU7NRx4SHKO6
 fhVBwFItZgnMc8j+ye7ZmQ/u2V6KF6tiWalf1OhX01RWhSSD5WZHEAS/+aDGlUSENtuX
 9SFw==
X-Gm-Message-State: AOJu0YyUdmH+Wk5UbmavJq1ds5CfrsxZPaGZ/d2D84EZx3gH0Va2kAl9
 ClrLWzNFMDc6uO7EwqAQxvc8oF8ItDdGoGsUwaQra81wvuEB+JHY7cRs+dxE14oHuqfwWNXN5ka
 Pgg==
X-Google-Smtp-Source: AGHT+IEgpioX4dx+HHFMV8i5PejLel4UV/Trs9K7JY1SGPqny18Cu7mi3nizmb3BmMFxiUTM/mCltA==
X-Received: by 2002:a05:651c:2105:b0:2ef:226e:e150 with SMTP id
 38308e7fff4ca-2f91604cb0dmr22525521fa.32.1727269073280; 
 Wed, 25 Sep 2024 05:57:53 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:57:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 04/19] spl: Provide a way to mark code needed for relocation
Date: Wed, 25 Sep 2024 14:55:30 +0200
Message-ID: <20240925125622.197915-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Add a linker symbol which can be used to mark relocation code, so it can
be collected by the linker and copied into a suitable place and executed
when needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/sections.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index b6bca53db10..3fd5c772a1a 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -67,6 +67,9 @@ extern char __text_start[];
 /* This marks the text region which must be relocated */
 extern char __image_copy_start[], __image_copy_end[];
 
+/* This marks the rcode region used for SPL relocation */
+extern char _rcode_start[], _rcode_end[];
+
 extern char __bss_end[];
 extern char __rel_dyn_start[], __rel_dyn_end[];
 extern char _image_binary_end[];
@@ -77,4 +80,17 @@ extern char _image_binary_end[];
  */
 extern void _start(void);
 
+#ifndef USE_HOSTCC
+#if CONFIG_IS_ENABLED(RELOC_LOADER)
+#define __rcode __section(".text.rcode")
+#define __rdata __section(".text.rdata")
+#else
+#define __rcode
+#define __rdata
+#endif
+#else
+#define __rcode
+#define __rdata
+#endif
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
-- 
2.43.0

