Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130B1D6911A
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8322D89D25;
	Thu, 28 Nov 2024 16:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l46818C/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDDD089894; Thu, 28 Nov 2024 16:48:02 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 329F589D65
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea5a7a5e48so472735b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808877; x=1733413677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvZfHboekwGKZaTf2sYSOgInL9b19oQYgvVUO9winh4=;
 b=l46818C/Wy+Ep4apG7Cio2HuTfY9CDEbft9zbhSQwTu1OQHU3zbBlhaniBYsFjYc7j
 ueJ3J/abYjGzOtfag4K3reyJaSWoaAiJVsmItQ9SlG+9wQtanrlvqggXWd0Oj0HhtoRQ
 vJq2964vhMJaio3sMO2E9ASpTDjOP6k+eikXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808877; x=1733413677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BvZfHboekwGKZaTf2sYSOgInL9b19oQYgvVUO9winh4=;
 b=XZEvW7OpUmg+8/7s1lblAsXjWdIn1QWqhi7uIMLWkSRGKYOXPVY5Ofwh22SCpxEZuR
 oQvUzX12S8AOshPcfLCZJu3O4zPQAsQ9AB/k+oHkYmyuuZDbLEWRH+9Nf1YGZOHRP1Fl
 oAXhwhB3oVwxHBBDxn7efHvAcabyFGLERk7ZiQu4Ym2rAh1iBEm1OiWublKxYZldNaUX
 0dHhuYVqQW+2T5EkXnizI3qRKgJhSIV7U6JC8YcVGBo1WktaOwjm7pEQXRYdDJRbs9zm
 S5k7PBz1RzAZSq0LER/+T2uNA3xa9GcRzg9W4G2QxNXFVnh3ZKGfx3qvbF2oox4hSGYn
 Rehw==
X-Gm-Message-State: AOJu0YwMzuln63zsUZQEAhgBgdGTY/Q4ODAC3kYrR2IqHU740oL87aN0
 IEgpmCyDVaNDrH2ee7//+H7kS7DKgb/Rg9K+tya/RkPCzDDjPlrybwpMk7p4T/qXHlGyvLLGBVw
 =
X-Gm-Gg: ASbGncuJWrJuWR0g/+XHAPUGcPfL38MU9mS3ui+MOBkXz8iIK9tQTR9D4uFJ6m00cu+
 Dpu2tRKADi8bnRsp+j9amP6fppouiEg/0Y2ti8ZYjpeqNL6ue1G7Ra1ZzVCrGOVVUOsEKhaRT+l
 GCtlawCgELoxIYZiMQWuHuPGU+bugbA/bJkp0xnyGS5s4yQjttJzM8SHwI3QODed2BSmyIIst9+
 LL3fIhNOOIzEiee8GsbqVyoHDQPOpcfErma4Pn5oLIz6A==
X-Google-Smtp-Source: AGHT+IFIs4v8Qd+vaMolpvXCRmY2Pj5GshPn/yBXUwZaBVbPD5XooG0sVOsJIfPwCOiE2o3/F0rZxg==
X-Received: by 2002:a05:6808:1997:b0:3e6:22da:843b with SMTP id
 5614622812f47-3ea6dd4676cmr9456615b6e.28.1732808877711; 
 Thu, 28 Nov 2024 07:47:57 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 08/28] doc: efi: Add the EFI-loader API documentation
Date: Thu, 28 Nov 2024 08:47:07 -0700
Message-Id: <20241128154727.771871-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch to add the EFI-loader API documentation

 doc/api/efi.rst      | 3 +++
 include/efi_loader.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/api/efi.rst b/doc/api/efi.rst
index 43d6f936fb0..57da7f615a6 100644
--- a/doc/api/efi.rst
+++ b/doc/api/efi.rst
@@ -75,6 +75,9 @@ Image relocation
 Memory services
 ~~~~~~~~~~~~~~~
 
+.. kernel-doc:: include/efi_loader.h
+   :internal:
+
 .. kernel-doc:: lib/efi_loader/efi_memory.c
    :internal:
 
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

