Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90703C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C0D80C72;
	Sat,  8 Feb 2025 18:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QOBxjHUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B9780D28; Sat,  8 Feb 2025 18:12:54 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DAC980C5A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-854e5dd5cf7so89509339f.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034771; x=1739639571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dk3qoiCuEHl22ragnV17lf8EVgSSbsvCgqFXgEIf2M=;
 b=QOBxjHUXWnkEo7Ppy81EM9b9nSdeGsIfOruz5Y9lc6GHqnFGasMO9hQMgdeZDpcse8
 dNx3n38fYZJjsaxtfSeZLA+JZyLLqngFB4cKntZJbJatseinsRj7n/UkK+OVuTIrjM4Q
 lDtUgD4IDSgdglvaZnBUD1WEN4Rw2mGNhAmyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034771; x=1739639571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dk3qoiCuEHl22ragnV17lf8EVgSSbsvCgqFXgEIf2M=;
 b=oWVllYe52F8uACbAUyQfLyvtD3V3zOSqA1jgDlZmaJxzHAe9O+mFTCFTPj9oTZ4FTO
 pFwKrIj9AmwE9iKX8fe7q4U4XqL7R8/PYki4YHA+qVJDcvYrsoTNKYSaXQboWQyqsC8u
 ZglLDoKmT0X/ADvkDUWINQ4k7+phrPj3VSgMyfPbsetgWyYrD1Cb2idhrNEbpwA8a7yO
 RNjBLDvf8yHGVS9I1u0EL4gXYogZC3evxYLQMpuIixM+M76jnb9IwrB67t02lx7+Jfqo
 OMr9jKHBOuCZOgwgSmSf/ksgS7HQA6LkvhYUs+QqSg0IzDUcxFV0toV55NPkcFWUTZL/
 CMrA==
X-Gm-Message-State: AOJu0YwWhK0/yPWi0+XtJLQt62P1gajuWshoJTR4VNR+n4/YwQqLaOn9
 E9WmGN94Zajx2fSrRXXHrAlsyQcrNp/tzHi2Pa09qFcvSyrEBkQXOgq/i/uvCRzdoM5o6v4s4pU
 =
X-Gm-Gg: ASbGncuSQ6UNjjRTuNLYNtxlAIVUML7iulm9nohI8V5WwOoF3dtkzyUDRSVDDm47bjd
 8AYkbffQLpysG/GsHz/Mf3hDSniGSOsxBqtVhnLA/A8Gvv8Nyb3FeNdS6ugE56DoB5ARgxOLxU2
 yUYGlDdmsd2u4mzU+OWCag6cAQJEAFuQpeRtzf068lkxKJN4RvvGJ03QXC/+wOzJelkHv8rDETO
 RFMTUcrBWZA0lBxoknKGBwUQFD9rTga1hpadYq3Vs/xjkbNyJpeeZCojvQoEiQ+P48eQXwA95W8
 3W4sgugXWe6E8ZcLuReFKSccfg6Az36RizHGZrqsTeQDTlJBBsTp
X-Google-Smtp-Source: AGHT+IGujb8Y7xFk/NgqvlO68Ug7ePKaNEYb80JTx4tS7QEiVuwtWXGVeqnE0er3ydSuVpT9y5WIzg==
X-Received: by 2002:a05:6602:b8f:b0:843:ec8d:be00 with SMTP id
 ca18e2360f4ac-854fd90833emr715835839f.13.1739034770742; 
 Sat, 08 Feb 2025 09:12:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/29] efi: arm: Drop exception code when running as an EFI
 app
Date: Sat,  8 Feb 2025 10:11:39 -0700
Message-ID: <20250208171154.1305761-20-sjg@chromium.org>
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

This code cannot be used since EFI is in charge of managing exceptions.
Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/cpu/armv8/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 2e71ff2dc97..7bd6cf21b19 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -13,7 +13,7 @@ ifndef CONFIG_$(XPL_)SYS_DCACHE_OFF
 obj-y	+= cache_v8.o
 obj-y	+= cache.o
 endif
-ifdef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_XPL_BUILD)$(CONFIG_EFI_APP),)
 obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o
 else
 obj-y	+= exceptions.o
-- 
2.43.0

