Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE03C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 899BA80BA8;
	Sun,  9 Feb 2025 03:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pbz9TK9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F8980836; Sun,  9 Feb 2025 03:02:45 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7E2807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-852050432a8so101818839f.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066560; x=1739671360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXFoBZBeCJNvaf4dKKmyayw+c/DD7UvupwhobcQHYh8=;
 b=Pbz9TK9avIBrfj8U6MCQWBY9pJzbx98JsKoUQg4VUNeS1I2Rb2I7fDvgNKW3tvZXek
 wbBa5vJUL73wG477ZDj4lR3HdGFUKqqxNKY9oGh8TtQnVvbk66cTpDN64Piv9gKjILI4
 QTxCHOzxPx5HnDt61oWoXx5umD2g/ApL3R7Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066560; x=1739671360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXFoBZBeCJNvaf4dKKmyayw+c/DD7UvupwhobcQHYh8=;
 b=EuKS0kmuTER4ngTfvW6kMtCF0YdDqiM5A+FNZGksWkVyUQxSaTM6coiLYkzma1JExA
 XoO0KSDoNS89NmljJ8pVR9dkNdaUp945pzHNFdZwKCB3oODBQq8t5Hw2Hn8JvXORJY/z
 /FZ+Tn0ohM+kfshfytiH2rPLqTiZBCr/OuqaMFK7ZgoZBufmrG46csU6sfCmWXmgo1xT
 ZyMAgW9iNXfA84o2RUHMEBWkyPCYO3Ko1jpL405VlxrWXnqZOjzy1yqVCOKMQY/F6App
 38Nz72pN9jya+rCFZVLzCpMB6nVzO6BCw27oWU4x2zK/FHLyYkFa7p1Re5SrVZAAcwgQ
 xdjw==
X-Gm-Message-State: AOJu0YxSc8ec9FSi18Lv2Nhd6m2SIcVPFNuxbl+40MrqPDrtKEkMzljZ
 RC33RUg0344PXB+acIM0XfeTdAVbDN8ejYL6Evy/Z36ode0nlrC5X4Zam7bREGB13xOG9ITt7BU
 =
X-Gm-Gg: ASbGnctAZ9kTMIRWbREnns8qvC1dlD8RyoGxtIX4VQq14hdaXjKX/kz35KUsJBo0czT
 KU+Hedokt0TlkG4TPck4SZHgXJXPqaKuBMNsrGjoeECa/ohGddJGU2IQxsNo2KZ4r/VuPA7Tv5S
 aKrf1qVFQXsXC0AivqAPx7WMizFwJPZTCV3oZ+GYX5cXUxLBgK1UmhiQN270yKCDL5rUHyGIF4O
 m2CJ1jB5ef9CB1bFooLVs2R3rEGeVqVjqeRP6C/5Vz8qfTYs4+IuEOHh+e9Qfdy53U/IVveSLMQ
 Tgh+I5p+41OM1d5OknZG04fnVs6ZDquJbarOLxoI3ZPqWNKIWgCF
X-Google-Smtp-Source: AGHT+IEImo9ngWWMJZskFECCeT9mj2hRGl+dZjPu4qTQtFSST7u0ZoLhHnpfhG2wH7j7CHoTCPWI2w==
X-Received: by 2002:a05:6602:ce:b0:835:39a8:e201 with SMTP id
 ca18e2360f4ac-854f386ec03mr911900839f.0.1739066560249; 
 Sat, 08 Feb 2025 18:02:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH v3 21/29] efi: arm: Disable --gc-sections for the app
Date: Sat,  8 Feb 2025 19:01:20 -0700
Message-ID: <20250209020136.4108987-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

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

