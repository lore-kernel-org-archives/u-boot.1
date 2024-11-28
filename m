Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1760D70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A9089D40;
	Thu, 28 Nov 2024 20:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SZLN65pm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B9389D3D; Thu, 28 Nov 2024 20:13:14 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E545D89D35
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea3cc9a5ddso631386b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821190; x=1733425990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jFqJ04svZU3Mqsoc7avJCl9+HK/BQIxvwvXv8OILnk=;
 b=SZLN65pmQVI0DCEfEMVO7GpQ+Xnkk8J50IozeT8J58mxKUvXVzlF0iVwCQFklBM+0r
 n+tDK7zg2akMVFSs1kMU50izJo03m9d9UClHNaptepWfgTTVWoSeRUB0FqNf2dE4PPIF
 q8lEgaqC5wuIo+kNeA19Muv0DZOLBTlFJqV/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821190; x=1733425990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jFqJ04svZU3Mqsoc7avJCl9+HK/BQIxvwvXv8OILnk=;
 b=VyMxPllzkLKTF7148J0eTWkSWNU51XR2DtD6wgHDXcK9z1NN9CAp9aBBSRW7rvQHOw
 du3ek5AGLWDzt7sJxPotW2UcKr5nNJduQLLns9o5IF3o0fSrUhUUBodJmwLmj2jEMBmw
 mmiImcyEcXyz7BUNnsSaUTioOVemyyMsrI0G2/+nyedx8bIUWI03r5q718K1UrL76Q0M
 X3wE0TDDnVrIiI6ZbKyqC20tGPkkfGba9fAzy/pZrg15tVJ/huCeQfjvnnNrisezmLAK
 0iVu1fZeFRQKas8kpLBluk0UyUGIwJo0RcoOg+PN/n08OkTSlzk194r6vXxc2UXgN+ov
 OcEQ==
X-Gm-Message-State: AOJu0YzarKa5f+a5BfIGCm6oZqeINmQr1b6y9hm3HnwusrJbWLBTHjvS
 KnNH+RaQb2dfyNZSDL61b08fwyOFfHyGKfqDT4nnG4WwAkoS1Yn6TmCDxMh2wup3sJxlRZGH5I4
 =
X-Gm-Gg: ASbGncuqCXhwD2wJnVaMOowTHSH02ibktW/KQBtpiSKC44L3NG0o9LzSORdWDdSTzLU
 BPFi6jBf1QkxKU+HatIbQyavAg14I3zQ15lonpovtmEzBOuTBxPFLIif4MgigB3JVS+A8/jDQ32
 k7p0HkubZ37eowKx5dkJOR+NKzDX1eUHY1dNobpjxidDyTLnyYPuyxHoynewMdSqGuFeL6VDFdu
 8sVJJ3t+Ods59LaDr/Hl3RwyBGalt/AlJ8u5iuOUP9kKA==
X-Google-Smtp-Source: AGHT+IHvAxkAX4+1IkqGrT9dLUcWtoiTMppSNNPbGSKhTJiz75gpiVCBW79NsF/0udFaEvusTHQ0xw==
X-Received: by 2002:a05:6830:3898:b0:71d:5209:5cec with SMTP id
 46e09a7af769-71d65c7e4b8mr8535914a34.3.1732821190167; 
 Thu, 28 Nov 2024 11:13:10 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 08/28] doc: efi: Add the EFI-loader API documentation
Date: Thu, 28 Nov 2024 12:12:24 -0700
Message-Id: <20241128191244.900006-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

Bring in the documentation from the efi_loader.h header file, so we can
see the API defined there.

Fix efi_alloc() to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v3:
- Put the header-file in its own section

Changes in v2:
- Add new patch to add the EFI-loader API documentation

 doc/api/efi.rst      | 6 ++++++
 include/efi_loader.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/api/efi.rst b/doc/api/efi.rst
index 43d6f936fb0..49814bcf5ea 100644
--- a/doc/api/efi.rst
+++ b/doc/api/efi.rst
@@ -54,6 +54,12 @@ drivers, handles, loaded images, and the memory map).
 .. kernel-doc:: cmd/efidebug.c
    :internal:
 
+Overall API
+-----------
+
+.. kernel-doc:: include/efi_loader.h
+   :internal:
+
 Initialization of the UEFI sub-system
 -------------------------------------
 
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 00a1259c006..3f75f2efcb6 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -764,7 +764,7 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
  *
  * Allocate memory from pool and zero it out.
  *
- * @size:	number of bytes to allocate
+ * @len:	number of bytes to allocate
  * Return:	pointer to allocated memory or NULL
  */
 void *efi_alloc(size_t len);
-- 
2.34.1

