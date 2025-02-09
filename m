Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58755C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4BA80A55;
	Sun,  9 Feb 2025 03:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fh5YHaHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEDB380834; Sun,  9 Feb 2025 03:02:32 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 716B580BAD
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d14f752bcaso6711025ab.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066544; x=1739671344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22DTu4dGLVb3YFvFaQrr6xvHm/rcyuyLS42GLIaK0NU=;
 b=Fh5YHaHA72I/iPzpnnLAr9mp616GIx/IjlAjizXugZGlwwNB/1XgbDpB1D+n5g+w84
 5NKlD55HPVpIuZLrwVVa5/KTxreykpPVmcHiQaypNDlkQfU1pXnrwcdRUWqQoPZYrbQ4
 eSQghKcXEgxC8qqwYzY2lNCi56UmK7qkRjR8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066544; x=1739671344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22DTu4dGLVb3YFvFaQrr6xvHm/rcyuyLS42GLIaK0NU=;
 b=k8IPGMkUbILET+m7kRDCrbI5fOpLlu+okpDLOqb7xs+xECwZaTQK6vG9sPFTOckagJ
 9vsOkdd4TU41PAIpjTj/IcOQuAOqRW055eGTS0kx56I2G5wwI8HNwtOQ7G7WJLSWsO+n
 jgvNfDV0U9ZNnHsrUBOf06qMwPxFWcrdUcRW93KNmWw3JdKTYXB9rkZadio3OEW3BQD7
 rvfy1kjP+g+wQfxiXa9k5qQ+iqIy1dooPdMA10KdxbRmy0O2lRcbF4duRdQfNjqeSYHV
 CrnOj5G7WPm55/69KMnHAuw0h4Yh27aCagupwt1Z8JDY41/E5n1vWvsOMz49W67zSy4u
 xBQg==
X-Gm-Message-State: AOJu0YwvgkXFsocQEph80xnUyfQwQve8vui64prPI7liNOcTDIuyjK7x
 UrSTZ8QupjMeZM1kIpOWzqg7D4vQ6F/OSn7QWOXlBgusaFeuPIg7D3W7qcYOEbGk/OU5SHcWe6g
 =
X-Gm-Gg: ASbGncv+wdzVMNfgD5rYcbTT2lQpOYND+CQlWjkEX++l4aAd5/s0zoaW4auH1st4bb9
 yOdB0quaW9Jdno44LGGh/Q0mIIQuVNihryvPQflPev4wg9kt3NddSFRA0i4bsq7Tln3y2Rw1pN/
 ohplILv5nh6zdZn4ukpKFJ92nozO5l//sVFEObmj07pkw2O8jlXqHWec1dsWY4C4t1IXcHzWjqa
 pIIJxjo2bdSzNShsPdIwkMPfhqOb8b5aTVdnLZ1wjumGieHrG5VteqLp+K5nvzvYLW9jzCEOr6Z
 12c7IzbCcEmN0hlmXXmqm27cEEtHZolIL3XwLljWxU3xKmLR5qCH
X-Google-Smtp-Source: AGHT+IG0Cgt8BRw+637CTt9gz2vneMKVn9WgmY11gRMY6rjDgnOmonzUAXqLu/fADGIrGKlHlIDFXA==
X-Received: by 2002:a05:6e02:3421:b0:3cf:bb3e:884c with SMTP id
 e9e14a558f8ab-3d13df2bf5amr78313775ab.16.1739066544289; 
 Sat, 08 Feb 2025 18:02:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 15/29] efi: arm: Avoid allocating page tables when running
 under EFI
Date: Sat,  8 Feb 2025 19:01:14 -0700
Message-ID: <20250209020136.4108987-16-sjg@chromium.org>
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

The previous bootloader has already set up the page tables, so don't try
to do it again.

This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 516754caeaf..bdd0f202bf9 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -6,6 +6,7 @@
 
 #include <config.h>
 #include <cpu_func.h>
+#include <init.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/cache.h>
@@ -138,6 +139,8 @@ int arch_reserve_mmu(void)
 
 __weak int arm_reserve_mmu(void)
 {
+	if (!ll_boot_init())
+		return 0;
 #if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 	/* reserve TLB table */
 	gd->arch.tlb_size = PGTABLE_SIZE;
-- 
2.43.0

