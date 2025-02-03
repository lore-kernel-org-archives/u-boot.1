Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A20C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D332807F1;
	Mon,  3 Feb 2025 18:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E83hHUAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FDF80834; Mon,  3 Feb 2025 18:44:06 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD82A800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eb87127854so957640b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604642; x=1739209442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2oNlp50j4X2Rv+V3i1mKRhlmYpWCGXEf0dLRCvRG/g=;
 b=E83hHUAB83gmLf5XNhFISCwNelx79EEf8Odwfr5gesZBjKFl44wZaCgK1DJMusytbV
 ZBi0HXwBgLRQdeaZJJdmnNxV7dq2I8o2uKyRj5ggyPyzT20G5yHvGJbSHPVGzoXokSbe
 p4CJfHh1IoihFBz4RtmziFJ8X6l2WD/QtGS1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604642; x=1739209442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2oNlp50j4X2Rv+V3i1mKRhlmYpWCGXEf0dLRCvRG/g=;
 b=rR3KCI79mN8ugb3/9lUHy4pepm3TORSZmGdSTKSdBfAal3tqCnKA0Px7k58LzqBBrG
 124nCNvNsG07UPzHnROcy49XUx+l6n4inFrxs0P1FizOZYpyKHeiOaKQ5wS9vkYV58I9
 5LnfOHh7yjwjdE5+BbC7pKScpNL33xJuxXKt5KdoBjZwYvpArTD2HoHtCf0zaiK7RAHw
 aDb8ZXvYXjjXzlY5j0h3uZ6eTu2Rf5hPCbTq0xssdlwB9pt+90p0kM1H8kTLTI7hajCz
 8np/9iuWZ89ZBC8pMo5dXYqjtgRkGgtSNnXgDrsZ+Y265hSAjHs+J2StfKcBMl7lFyQG
 uGuw==
X-Gm-Message-State: AOJu0YyYrs8T1KJ2ZvCOaUV4KmOm/maoW5Gyk+K+8EDEI968A3ES1RMh
 Tf7bgflj3Kz01PHazmaatxQ/ORd9nx1kP/1FEGoG593Vu7jXRbeENhmef+p5LxcOEr2dJ7hZU3w
 =
X-Gm-Gg: ASbGncvDbhqxSrhIoq1efZqDbUlOfdcZB+SMRo1JUi7KxO1vCIzIbxG4e+tbsuTywlw
 yJJikzKMiC6I3lIjSkV11NxU+6UTY07vxgR4J0Qpt4BsoGv1e06DwA4z6TUz3gPaHJkCmWzAwHB
 ybaeQ7q1lpi0g+6x3YmXPFKHALqg/0XKhlQ2kDrEqXA5MFAeQjBnHXUQZATfF17i0isBPL40MaC
 NI+5io7uJ4PCJFfX/mz6IdsFKimratBFLmcPD2pKDsPZnQ8kCDIKC2+BOp/MmXeiLi1afik2ufI
 QmVqk2SmsjIhwtbmlc9r2HOabpkfrRD6XXTslbsT7ELS3Z39xuda
X-Google-Smtp-Source: AGHT+IEID8Gqc3/bT5fOGr642hPsldiJsn5APl5ynQk5QBzjl9eSikKkik3RFlQjn4xbuXnBkWLnRA==
X-Received: by 2002:a05:6808:3a18:b0:3e7:59ed:d7f8 with SMTP id
 5614622812f47-3f323a14832mr18280320b6e.2.1738604642597; 
 Mon, 03 Feb 2025 09:44:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/32] efi: arm: Implement access to global_data for EFI
Date: Mon,  3 Feb 2025 10:42:12 -0700
Message-ID: <20250203174245.1331464-20-sjg@chromium.org>
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

The EFI app likes to use a simple variable for global data. Implement
this for ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/include/asm/global_data.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 6e4471662a3..8d51111f095 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -115,7 +115,13 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
-#if defined(__clang__) || defined(LTO_ENABLE)
+#ifdef CONFIG_EFI_APP
+
+#define DECLARE_GLOBAL_DATA_PTR   extern struct global_data *global_data_ptr
+
+#define gd global_data_ptr
+
+#elif defined(__clang__) || defined(LTO_ENABLE)
 
 #define DECLARE_GLOBAL_DATA_PTR
 #define gd	get_gd()
@@ -144,7 +150,11 @@ static inline gd_t *get_gd(void)
 
 static inline void set_gd(volatile gd_t *gd_ptr)
 {
-#ifdef CONFIG_ARM64
+#ifdef CONFIG_EFI_APP
+	extern struct global_data *global_data_ptr;
+
+	global_data_ptr = (void *)gd_ptr;
+#elif defined CONFIG_ARM64
 	__asm__ volatile("ldr x18, %0\n" : : "m"(gd_ptr));
 #elif __ARM_ARCH >= 7
 	__asm__ volatile("ldr r9, %0\n" : : "m"(gd_ptr));
-- 
2.43.0

