Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCE7C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2EA780EB0;
	Sat,  8 Feb 2025 18:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QISmrQ2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246BE80821; Sat,  8 Feb 2025 18:12:59 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B9B80D1C
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-854a68f5afcso69468639f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034775; x=1739639575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXFoBZBeCJNvaf4dKKmyayw+c/DD7UvupwhobcQHYh8=;
 b=QISmrQ2vcJM90YiIthMorXD/SxV4yftT9+oPClKsHUQJlMlJQSz4lcsQG4/mrNILq6
 SdDJgZM9orwyAUzr07MNrMwWytmebwJBeP8luipqZkL9qB50NXTsIExK9mYO4S+d3IpI
 JXdvS66A+45XgqGnxxIJVWCf7zRS4b6Wpx+r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034775; x=1739639575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXFoBZBeCJNvaf4dKKmyayw+c/DD7UvupwhobcQHYh8=;
 b=IcaI2Cyu75IXZogZz6Ts+8PmCxiJGGQzi0sbZMuhwgStJ3JOu/5w8x9dVKnZ2e2yiL
 1qdwcu9qRPow9uTxUMSNhNr+b5zF/tNIQ5W7yU5pVwJRTd+yHk7/LFB5Mwp8IoHNiimW
 6Je/BMpXP/jILzopmvZqNPuDagWQ2tnSB8jBEI/Dsfznh/fHnba05XHVy+Yw6XOjmUhM
 upxLpch3db4K0GebehX9hv74msduOYQvBbhisO4XfZSwNb+YXyuCTcMNIGhzarDp4x+j
 zJtAXLKfQSPrlfdn3eVgrkOftRrPyWD6WoX7/3HhTUsT7NKxqQKkELrqries0kgqtCsW
 dF0A==
X-Gm-Message-State: AOJu0YyAn4WmJPzNHmvMH39pwv5Q8rCv7Xt7oS/RE2HsI13cYB1B61HW
 qb/jLgZaIbTg5OoImCQPUjvHiwHGWzvsiMmywcvJumvySQDZ+7o+5uxd3UEzTBMWO1uOOvHYOp0
 =
X-Gm-Gg: ASbGncuJ93/DTfcbmNaUj0UTT9A1cgtpsZCOCBw2RsHTk+pb7arWHKIkNbEeitUqVN/
 6KV8biQtGqibUUGU+rLHt33mCz749kY2fVNd1x8Ea8uH8IAN6yxJM9HfbkuG+BObL6d8IFM4eag
 atoqVJsm6VzbBnp8sWSSZf4165+BFhZ6L+VDRXCGeNbgAlpfCVqoPrVsuNqxiPhzFVN+mbxR2LM
 J+mrjSTdLVkRLYZ2vrs7JLLoLcJ3JkIBdsy0G6sr34nWFZnAEUSkeufoi4ZQAR8e0vf/JrCpeXU
 88YtoDa3/q90cCa/gbE1LNWDJtI5t9Y8Cwqx0pvdrcow8ZPMAbY7
X-Google-Smtp-Source: AGHT+IGE+/3HX1Fk57A8uQKZkUGMi3qn9HVycohXOL78pMRtsezXoKv0JnEpOuqG9wnZscLTfv8qWg==
X-Received: by 2002:a05:6e02:12c1:b0:3cf:b9b8:5052 with SMTP id
 e9e14a558f8ab-3d13dcd8ffamr61309355ab.3.1739034774818; 
 Sat, 08 Feb 2025 09:12:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>
Subject: [PATCH v2 21/29] efi: arm: Disable --gc-sections for the app
Date: Sat,  8 Feb 2025 10:11:41 -0700
Message-ID: <20250208171154.1305761-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

