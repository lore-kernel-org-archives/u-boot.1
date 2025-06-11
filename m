Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BF7C71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48C382C2F;
	Wed, 11 Jun 2025 22:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QWnqxBTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B6F782B63; Wed, 11 Jun 2025 22:25:05 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3378E82B0F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45024721cbdso1507715e9.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673503; x=1750278303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBd5IqOqmVtWiDMTCWjmlUBBf+6RSNiOck8S+u2pwEs=;
 b=QWnqxBTw+JtH5SF5PdQMZPsLPGqfFOehLLEy1yxi9ZNjus6cQXRYnwugS7D5deihrR
 J6oTEz5H4yWv2XGIHB7Hv/Au0T6gvOxmFQKbfyNghZbCIRL7TSvfCVLr6cv9IObNYU/3
 gpb2vEoWLcm9B5KQh730hA2IpM3g0UQ1oN6/a+WTkw1F72riIBMj4UjWVNkmw+GDmKsr
 sSjwO4wHO3jC4WkeYr8kTMY3judZc2+c9ay0TQhfe8x/0ZrCxLGLYTiE5LRU9yScfYDl
 J7xUh19qzz/XV7+xvPBXQzcxpDAnTIA0/Q5qbYrt9v0WsISyPXdkTEcjefK62ZI75nUi
 WSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673503; x=1750278303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBd5IqOqmVtWiDMTCWjmlUBBf+6RSNiOck8S+u2pwEs=;
 b=V7s/X5Ybb3DkT0/JwNMzhf5Qlzp6BmlhY0WP26NYZ7J4CP+UqiSsHZ7rFMzyuq8N3+
 lJAHlM2PmfS8meH8kh2/W3GJrFRYwMG2XyyEK3CaHHxzPifiaHpnie5MWfTQNvCTSG48
 Ht+A6du6qzsmJNxwiI6OKY9arX/ZUTi5oSNvyhxXIrWBg5XONDeqq6SXnOejrB6lLk/+
 RIfs8TgB0Dv3MvzFHxNBV3Sqs7lt6aIMQxE5rAF9JlwYhloOJZbnb++Pvmhwccsb8slR
 Ifo2AadfPEyVO48l39CL1TKunOcSk5uaBGCqBTX2z9AICYzxYp26tRFPdQqahpkgFEfI
 x2jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdklSGuXbEXHXASetXwSc57orKDn6AJlaydIyujNnNIbKnN0lUr2Fi6syw8ZG/JpoW7e25qrM=@lists.denx.de
X-Gm-Message-State: AOJu0YwS230OUv3qEsHX3Qgyubhz0HTtb9uXGEF3+ahD7BBgmHaXYVcK
 9oGo55vZQmyrKnLw5qlka3Bsxp3lI4H53+zLUfIz0A79ZjGiruon0GG5cX0ZMxQLY7pUWUdmcSm
 zbxPE
X-Gm-Gg: ASbGncvVtBn6DU037nFbGGVQqS/VGSCl3r1eOCXI2+0ssFDit4cdPUJxjvxqWzWOZnh
 iBBlBnA9sbvxWD22DYwMW2FO/fdI6hkPyBFgoNBj00FMnFkuZHwC52D3VY93ykYdCsCy6VfT4OS
 c40DaEzW7TJcHdkYbJ2kjGPJ4P8aFYyUS87YDDyKPau31y4uJ0lpwCgxS/7AO2BrS+RPPmpN8K2
 7vW2rilzp3/+1/GuAHoTyP8N5x7mxU5QBgU1wurufysL0vSYRFNGrnJRoHqlSJqMUbk8EsPkujs
 KA7NpZ+ehbcrIKsod4XmKNJAIbDbbpDv1Ax12fhllBzSlZMyElakygUj2oahbwCi1JK2RTRM5bd
 oEAmTEpKacll0OR5Blcp7E3la/jQcoacPObyCaElH
X-Google-Smtp-Source: AGHT+IEjWccBL3HYo43X1pdxMr6TEwE/t/DQad6lyw8oAkqQQQOQUrR1uHOz/JM5LxoK6Ngim4fk1A==
X-Received: by 2002:a05:600c:384a:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-453248cc53dmr42321385e9.27.1749673502637; 
 Wed, 11 Jun 2025 13:25:02 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:02 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 04/13] kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
Date: Wed, 11 Jun 2025 23:24:31 +0300
Message-ID: <20250611202449.2317279-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit ad15006cc784 ("kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7e1b36e78b93..e648f4920cfb 100644
--- a/Makefile
+++ b/Makefile
@@ -446,7 +446,7 @@ ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
 LDPPFLAGS	+= $(CLANG_TARGET)
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
 CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
-- 
2.49.0

