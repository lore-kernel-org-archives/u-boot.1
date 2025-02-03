Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF70C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6FF808A2;
	Mon,  3 Feb 2025 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C7d+OGXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02820800B3; Mon,  3 Feb 2025 18:44:19 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC4780834
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eba559611aso1344803b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604655; x=1739209455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uabx0UBFq0B8emdgtaaonm1g+MkfP2m3DMalN30lGsY=;
 b=C7d+OGXoXGVp1bBaDecuQdfTWjpvlPHvgvhxu3nqxJpuTu1wocg6I8sfuU/XiaBi0q
 KZOF4isvh9KI+338nVdskWrDmdiJuiwmKkpDJmjs0HMOh9PTCgcQRfzjKxinLqgEX+rO
 FSicdL5RurfnIwwnmc0bsb66LN0KJ+QdqIgrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604655; x=1739209455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uabx0UBFq0B8emdgtaaonm1g+MkfP2m3DMalN30lGsY=;
 b=jQmwHVkk8J984UgwlPK7Pj9HNr+C++pWvxEQH3GRRTe1PAtEuoGD9Lml/IwPEiL0RW
 B3pT3VNpeuSA4buYt9eUzeYgkKU0ZoTNuaBe1pZJqIp7Za0oaOwL/wGuxB1DcmjlqAN7
 JdufYGnYnsbHb6TjLeFiMTOEsHYufICF/fXdLKzYKOTV3aJ1P+ajBxn2tRgKYQzaJo9J
 TGrf7GttJREBJuH8iIXAHvhjzInf6cpvRUalNEV3ozio9BESbizy7B8gvg8XqAn94sUm
 aLrAUnAKGSyvic8x49SPtjJvq50b1naEV1jscTSDFd5FibgTmpYOk8ALYM6u63RlLmuO
 pYOA==
X-Gm-Message-State: AOJu0YwzKSPWz/GgHFWs8ooa923EgPu4qv+hIzfeWtu4BvpOF51Jf3Lu
 zigY67mf1V2fMGRfdv5CCmvy22/2AR5NUxiBZs4K3o1/h0drOqtuke/0VtMYObzXUnCxkXyaQvM
 =
X-Gm-Gg: ASbGncsBD+orLfph1IbmKhnrCMfq8rGTokA8pw3XKvQyTS2PESfpx45IWxu2ZtuSnNe
 JNIROm1ozvrHo5wfIe1k4a5EM7cpTYYnmBRZe3mdbUq1jeAamz3bqIQZTvEgCDViVbifsoyD54+
 VN9sqh8Qn1LRLxVayszGthXTjhRkIANhi5uFLTLOoHAisyUGH5A8YqIb9qGYJ91vPRXuEXXSshb
 74UvXgxzfNjmUvjZ9ggzRDxZNMFIJUyS008hUJr+Emnj58eF94g9oTtP2nGwNZY0LQJxX+/DCX/
 mYy7xXc2TxilajQidqU9eAuUVuERf+ED9ytR04CAsNzv+clBlHkq
X-Google-Smtp-Source: AGHT+IFJl7e6lpLq+kaq0fosmV4C13b009Z0XojMm11hQmNPqY8cjXCaB3O5UJkN700409GfOInpWQ==
X-Received: by 2002:a05:6808:13c8:b0:3eb:6326:78e3 with SMTP id
 5614622812f47-3f323bb208fmr13496983b6e.38.1738604654968; 
 Mon, 03 Feb 2025 09:44:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/32] efi: arm: Disable --gc-sections for the app
Date: Mon,  3 Feb 2025 10:42:16 -0700
Message-ID: <20250203174245.1331464-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

This option cannot be used with a shared library, since it results in
everything being removed. Disable it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/config.mk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index e0045e22271..20f4d41f2c3 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -14,8 +14,10 @@ CFLAGS_NON_EFI := -fno-pic $(FIXED_REG) -ffunction-sections -fdata-sections \
 CFLAGS_EFI := -fpic -fshort-wchar
 
 ifneq ($(LTO_ENABLE)$(CONFIG_USE_PRIVATE_LIBGCC),yy)
+ifndef CONFIG_EFI_APP
 LDFLAGS_FINAL += --gc-sections
 endif
+endif
 
 ifneq ($(LTO_ENABLE),y)
 PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
-- 
2.43.0

