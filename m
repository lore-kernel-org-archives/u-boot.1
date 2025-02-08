Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF172C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F46D8083C;
	Sat,  8 Feb 2025 18:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UYrjDkRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0083580BB1; Sat,  8 Feb 2025 18:12:50 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D71EA80B9E
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so96555339f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034765; x=1739639565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Llts60eBLWa0MZZHaozvsxw1BhkCjeVbwdCOquTaflM=;
 b=UYrjDkRYrxyQBLCJ1z22hx9aocAVWt5Ja0Fb+oy2FRoIftm18nB7ZPmGAByj4k4SNb
 WrPUUM9zOYvH5DMDQpGVveYmnjjF1J2pH/4iCp0PRZGPJ9+XbD1SStH9pDi1MjgDSQ/1
 ijOPKrP5d0VOqFfIEiJ9CW3vkjfiraIqU058A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034765; x=1739639565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Llts60eBLWa0MZZHaozvsxw1BhkCjeVbwdCOquTaflM=;
 b=ajZEV/FieICQc8y1CQ6QCsREEWwN+1j+/aK2QKEKxSheIH/ohShH7tYmlZ1testN1d
 vC9BnRYbQHds6FPVYoXWHcU7tNNiGtdicW93xn6oaja/o8ySfV8JmYNuhGQUlvlA43IU
 8BmsaQvFV8DSFHCMSDlvTiEqN25fSu+291DFPQXzFA5hpu2dnVzHXQQ0z0xxbZdQBzym
 9GYN6/1LZJ/eNq99WykMmvN6Y6P3CRJbJd4sEgYBrzTy+vt7nwLmqWIZkybc7HY2QoJP
 3Er8tBN9RETVXB53mEkFcOLqCAogBtFQvHCTrNUoUSCxbvtyWV1LZ6kDnUguBhXx9NnI
 UPtg==
X-Gm-Message-State: AOJu0YzH7kqZxvdVoqSKQgHGnW49weRnyLCKUsJNmwnj8NlvuNtz2n/g
 dzpWJid8Po62CT9ak8FNQJY/vSl/Wn7FH6uO9HWSWj+n06ilIZEMi/sv2LZIpp/GcwRy9rkHC5U
 =
X-Gm-Gg: ASbGncuneqByA73Z3hxwJfFbjkW1+Rsp5N6Y0gQq8SOavjb+uEh9XVnCC57B5dMhizJ
 EdXpUpXMnWWrJb1HWQguNXMGfkndCm8HkX76ZDhkGGgnsp5sH7cWFEU13q8PAIE3spPR0rxPdUp
 Z6psn5/4mp6ObrEVl1cgMhoRxxFSmjxbuyk6JGDok+D+oChDsk32xCLrf3Kpct2hB+x5NEM6f8p
 LT7hSScmj6R27LN8rheSvA6YfUcWPAZlkPyvPFr4msMhr+uOJKbKPNqtgRTdPvzX0Hey7gjiJin
 UGBStdjryfguY1z5nhxMusP6JtFjnpvTrbfJCBbqM9wfkyICB5S8
X-Google-Smtp-Source: AGHT+IGs6MdbhegYWYUoAkuO8Up1aSvumkzMD+TZugMYwHk63ApY3AQPluatI5ULQagqakbm3CCmog==
X-Received: by 2002:a05:6602:4802:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-854f3a4cadbmr1203808039f.5.1739034765517; 
 Sat, 08 Feb 2025 09:12:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/29] efi: arm: Implement access to global_data for EFI
Date: Sat,  8 Feb 2025 10:11:37 -0700
Message-ID: <20250208171154.1305761-18-sjg@chromium.org>
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

The EFI app likes to use a simple variable for global data. Implement
this for ARM (for use only with 64-bit ARM at present).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Mention '64-bit ARM' here, rather than just 'ARM'

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

