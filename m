Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E67C35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727A68191C;
	Sat, 15 Mar 2025 23:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QdUc5IYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5279D814B6; Sat, 15 Mar 2025 23:18:26 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D9780C93
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso56293555ad.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077102; x=1742681902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHQwcys8M3sXw36eYNtzH5jaWNtK01MX4yQg00HHfBo=;
 b=QdUc5IYQNcWskm13s9w5XhCZiKtZmVXGEz9WCjsrYPVXiHWkhqSpObkzWJbVbnjdvY
 A+wINaCUT4bI6SxOnzrE/p10Suu5xC49oYuCdIOjdH0022f0WLtOoxa6te+QU8XZNfAS
 zrIxApnAJYFjljmldJeMF7xhZwilhVCy4eaEJWvT//M7H59F2WAJrFskTk0ZOT3AfLyn
 tUvbItTzGlH1EjjgxFrIERqNT6sXy9LGBsvhse62XbXaEgWEMhrJ2kp1oKwTYUv9aoXd
 9Am8GcCcnEIaPIZmNwuMoYrzSslaSC9svLmk4AMNf2e3v8MaWeL86jWYj2TVVgrHR0A5
 I/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077102; x=1742681902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHQwcys8M3sXw36eYNtzH5jaWNtK01MX4yQg00HHfBo=;
 b=Hoi4NKuxLhddsbW1lredHehqgDgE8NTFm/NmZmj3msNVLZuhh9b4JE6GIHROcFi/5H
 G8j3/vUfCqRzc1cvHBUc2Bam6V8CQW1hC/F5e5L0MF4Hr4tkT73B5pMWhanRRmbDezgp
 Q6g8C//yzUyl1zdpYMUdZMuDKTpaGp3928cUEdl28TuRP1Z8UbQt18Aw5MTWcZEdfono
 m49lL7zKXimAPSKunZn9BINdNhLC9A27rsNGw/WIK8XJrE0VU5yDNK8mjvxFUxLR4hj7
 efXygn3a3MLb3KKxwZuWaFIxHlX7FyD5u0ATUTNhE2LJLxo5uoKYrZuvwMEa3F+38ok7
 sdqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIUp1u0D58EI24ObEW/5+fiPq3Eko8dZQUqXvoGVGgJxf3OuP6DwuGYlC5y+UaW7H1q2y+coU=@lists.denx.de
X-Gm-Message-State: AOJu0YzdcTEEL11czHvhk8brPT9ztFTw8dKr5i5tg+py42HhcPO0CFNP
 VLfPFQoily0TVcc5Ydjgc01QjtWrBjaMb+wHFQJkIdyahwIyqGxx
X-Gm-Gg: ASbGncu/EUFxgN0kcco3Vm3qTf+KZk6jrLsPmyg6ZJSJMUpWrUsASfiYbUZA+VsECLX
 xkG6VM0foGyfyufi3mNyAynTu9Aw+XE98ELVQO+IXOetjicrF7T2JyxGDqi/srQl6+FC0l+UcbI
 l88tRQwvT6SQJpbgwdDAcr221NcfvtKXFCImj3HdsR4MCYiVTHhB/QHWGffq4kV/nUibOiUhEu8
 HP5jpZbJL/FeG13znUqKI3oLpjyJ68m9e/LWywAC914WQxqI/85KoDl8k0hO4xfDBQ+wZ/vESsV
 Zx7bFyZDCyX3YvHOM5+7PGuRZyaVtl55YCbAc9mGopurVJhZhCa5ykA=
X-Google-Smtp-Source: AGHT+IFX/0B7Vhj+b/scKHRzwnVjCkVs2bOc59L9wqwTh+l+EizNQCpHCqzOrs5Jqowh712UGtZPpQ==
X-Received: by 2002:a05:6a00:4f92:b0:736:532b:7c10 with SMTP id
 d2e1a72fcca58-737223fccabmr9033302b3a.21.1742077102634; 
 Sat, 15 Mar 2025 15:18:22 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:22 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 04/15] arm: Add aligned-memory aliases to eabi_compat
Date: Sat, 15 Mar 2025 15:18:02 -0700
Message-ID: <20250315221813.1265193-5-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

These are sometimes used by LLVM's code-generator, when it can guarantee that
the memory buffer being passed is aligned on a (4- or 8-byte) boundary. They
can safely be aliased to the unaligned versions.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/eabi_compat.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/lib/eabi_compat.c b/arch/arm/lib/eabi_compat.c
index e4190c049a3..e6cafcc5f2b 100644
--- a/arch/arm/lib/eabi_compat.c
+++ b/arch/arm/lib/eabi_compat.c
@@ -33,12 +33,24 @@ void __aeabi_memcpy(void *dest, const void *src, size_t n)
 	(void) memcpy(dest, src, n);
 }
 
+void __aeabi_memcpy4(void *dest, const void *src, size_t n) __alias(__aeabi_memcpy);
+
+void __aeabi_memcpy8(void *dest, const void *src, size_t n) __alias(__aeabi_memcpy);
+
 void __aeabi_memset(void *dest, size_t n, int c)
 {
 	(void) memset(dest, c, n);
 }
 
+void __aeabi_memset4(void *dest, size_t n, int c) __alias(__aeabi_memset);
+
+void __aeabi_memset8(void *dest, size_t n, int c) __alias(__aeabi_memset);
+
 void __aeabi_memclr(void *dest, size_t n)
 {
 	(void) memset(dest, 0, n);
 }
+
+void __aeabi_memclr4(void *dest, size_t n) __alias(__aeabi_memclr);
+
+void __aeabi_memclr8(void *dest, size_t n) __alias(__aeabi_memclr);
-- 
2.48.1

