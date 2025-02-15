Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA04C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60BB580F9C;
	Sat, 15 Feb 2025 04:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m3XRE49p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C54280ECC; Sat, 15 Feb 2025 04:24:11 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C2980F9C
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ce87d31480so8313065ab.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589847; x=1740194647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXFoBZBeCJNvaf4dKKmyayw+c/DD7UvupwhobcQHYh8=;
 b=m3XRE49pFGmYsTerqb0zMiazU4ZKXp9um6kYO5vkvVxaC8FJEZsUVqEI18wROkyvdH
 ddk9H1527kT04oRaF+eeKGF+xGHtqf9gysjR3a5DM7/zqA3ZuxdrZtEsqGtb9y3jIalW
 gtp81GycdoZ8nE44S/sBfGj7ZbcLLegaiRTw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589847; x=1740194647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXFoBZBeCJNvaf4dKKmyayw+c/DD7UvupwhobcQHYh8=;
 b=vTrhY7CxttjN01dsJM+cX1hY1p5KXge2z/4aTejsrxKRdnE/WzBJ6zH8H03ePI3QSM
 oTPEWf9nfLxrJwxrlrw+ezjA7YRaHpFx4VBINZ9f0Ir9SEmWzJqLsn+0aiCTv5hzYExu
 D46LpBHcOKoLDcMg8mBHVlHp39rkMd2XiGd/uEQb6r6XqZHayMXkwvdL1MM6TQ/UHzi2
 zw/VxQ6QyjpV1ZOd7281Wg/dLEwNf8FapCyRdMt+yVu8W7WMFMwrfTF9qXq850n83LKJ
 7K9OFKxmYggfgEtUKs1kBZz4WWbmjpHga+cqTqUMiaX8Q05DGyuQm28kRjuzKb63XUuC
 Dt2g==
X-Gm-Message-State: AOJu0YxFB6is9thtghFGegn/OtT1eB7JYiQbA1MCnNHxc30KjrWp5+p2
 1ZkRafrxbG7kHpS4j8ap+7xH4Lhu2cD5/RGAZIdxZQpK/3KvjO6j/RnFSFsZqAthINNP2h8AiGU
 =
X-Gm-Gg: ASbGncttyV/OfRsPvxV5jLW9JTfW3LZdur0tJQTIm334xp8D/rMAo7kMnPi7ZraYDtj
 NIPnhhgjiM7DLT1utas9Za917tu5WM7MoA71Xue0pmS9ccAvVXhN7XCWgaXiarqN9ENX11F7kyi
 TutFUCNoquLf7L1r2Adz1DyOekJIqOcM1Y4p+mNYqolyM4JoPKo0u9PuIs0wszxLFnaDh16nPUt
 Es6wsw/XOF+iW+RLydDrJsam7+Z7bKcShHRP61NNzCTt3ZyZQVUhwH0hDskNsfWPnsZVpxSNr5y
 xDKfCBWpXfP0mjZhO1mxJjtuWICDBOiWQV4h/svTHw+e752i4wnW
X-Google-Smtp-Source: AGHT+IH8jq5ujwzSM6/fovbgcdzw/WPwH678113OROZipidBW8LVraqQeOr5kw1ftdimyKKiMTEAZw==
X-Received: by 2002:a05:6e02:1a8b:b0:3d0:2331:f809 with SMTP id
 e9e14a558f8ab-3d280763e4dmr13451235ab.2.1739589846083; 
 Fri, 14 Feb 2025 19:24:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH v4 21/29] efi: arm: Disable --gc-sections for the app
Date: Fri, 14 Feb 2025 20:22:42 -0700
Message-ID: <20250215032254.4121030-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

