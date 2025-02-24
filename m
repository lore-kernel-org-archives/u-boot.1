Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876DDC021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDBA880F16;
	Mon, 24 Feb 2025 06:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MjAMiH/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C2D180FB1; Mon, 24 Feb 2025 06:56:08 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C76C280017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so88852205ad.2
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376561; x=1740981361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwPegcMLYF4WC46AvkGeVjBP0wX2a1n5AAa7QS4U0GM=;
 b=MjAMiH/8kSjCGP3X8o9f9B/0iLcswIbjMnMnZQHXuwghOM8eTwMyMBYU9S8F4kSwuc
 zdW4p07zMlMNsqBwzz1DoEElxSDmS9rxa3BahjgTCa8FKh+T3IKHQap0EQGxirPa0S0H
 pua6pJB3euNGnqr6NidOXeOvurZmXyHeVrNNgVnv9Fgx88xSlANOeJLYopZxe1pcg8UR
 pcUQLlqkylIG22hzpPwa87RxnrSUflsowypt84PyGKoQ2mo34wUPava16ECwYZn2uefB
 8uTB4dr6jQLkWhSsS2CK+DARfoTaSxir+OMmOoUXQ2l3EagYGG802MBt85Lk+W27p4+3
 fEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376561; x=1740981361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwPegcMLYF4WC46AvkGeVjBP0wX2a1n5AAa7QS4U0GM=;
 b=R+tOyOJ6WgDireNjosUoSmsxuirsoPXq/U15SYEneF00N8+TaL8rOMQ4V8flSkVcvd
 oiJtk2eZGKgiE1k7MIozGnqmPoEptKjvOW4dTv0gFDNo3IPCxXkOScWKZgNeTZZ0M3jp
 lwOH/Xu3520N+tbnNBIj6bWEvoxY+8YUW1OxlkcAQxgbqSf7JWec+VHI7LFhgo4cf69F
 MUchegt++LSKWc8rhGS7zctGFVOxr+Rn4BCPDC1s6kqyaD6N5Qx++p/n5lB9QMtWjgcx
 U5iRP3pSqt4XM4B4q2L/Gjxq6xjmzsEGtvEaL2UHnoU7LbCwXd5P2dec7I9PIVBanuuq
 hDFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnVmoi4/T2AYAC3h3AitGkMn6HDCuVlugKdeU+onPYKi0KiKI0cgofVbz5g/88SXxd1e5J960=@lists.denx.de
X-Gm-Message-State: AOJu0YzCVki9M4k47Aiqsx9jkTmUgv4HmraWr9u/ymetv8OiUWYkSuXI
 Y/pAE/W+lKcmPUkHJxmd29vhMEHaT4FOWd86OmX7CcKXT+756Dw6
X-Gm-Gg: ASbGncv5VxqM2jFwXrbBUcL2aZIrCPbm4hTYZd1MxBHDz+THGUDP8orzcioWJsD3/kk
 agZlTfV+rV7497nz64BemeXyGJCDngFDeAAEWRsLrWdHrQN/ybHo6pH4m+kUOUvC1aqlF/n2QgM
 oT/Jdded55pj4TLbnOKKnk8KR5nne95mKKv/UiKXDeYdYWgT2G8zTnp4gCKWb16qIDTWPGlCYjV
 CnUcnqMMx7z3UA/nByCxuFEgd4dp8I0vNdAaTApbMEHauE+DVgYrj/MjkD34gqISr91e/HpbS9w
 dT63P1eJfHneXJtwa9eOCdpKTcVZPUZ4HojAyQ==
X-Google-Smtp-Source: AGHT+IHZWEN2BXVqA8zEcDZ+y7/s6vDCUcnJn233FRqTp0H2UOxfdEmIEJJ9Qojkli5etOqDiUUPOQ==
X-Received: by 2002:a05:6a00:18a2:b0:730:9204:f0c3 with SMTP id
 d2e1a72fcca58-73426daad19mr17384361b3a.23.1740376561281; 
 Sun, 23 Feb 2025 21:56:01 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:00 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 04/17] arm: Add aligned-memory aliases to eabi_compat
Date: Sun, 23 Feb 2025 21:55:11 -0800
Message-ID: <20250224055524.1334929-5-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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
2.45.2

