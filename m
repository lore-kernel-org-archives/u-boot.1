Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83BDC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB91807E1;
	Mon,  3 Feb 2025 18:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MJj8Sho0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABAAE801DE; Mon,  3 Feb 2025 18:43:58 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95836800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ee1be3d496so2386739b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604635; x=1739209435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GRk/ut8Hi8wLduIcL+22rvhTEJ6Mt8M1Ji4HQtwFbA=;
 b=MJj8Sho0khxwBWWHZaNzCcMZWVBqDqTpl5CKCZn+8eVJCjyc74WSSVsIIqr1+wNmk3
 fkXDbryoi0yI5D0RJs+imwlBvafVmKgnc75n+s2/6ylKaTOcYbnc6U0ZAeKTzUTUDjv5
 0PGZn1TV/ciowYPhE1JV+8p3xrMWf5cvUErJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604635; x=1739209435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/GRk/ut8Hi8wLduIcL+22rvhTEJ6Mt8M1Ji4HQtwFbA=;
 b=bIEGi0YdV5VoC6rEB0ZJurUSWYzkDc+1BL2KqYd/O+7vPn6g5GQMsFnXZzoJ/Y4JAB
 or+HX4bq1XnuwQ39WW/fzPOwGhm/v9yqxZIeonosmqH87CofevHKMYg2xBMfCFiDfNr9
 J1UbdfBcMxUrkkxL+48LoXGFwb0bEgLLWsdeRLQQVD9VsgDkoy7VZuSv/lBUaLE+OrVY
 9aJUc93NwF0XI1tONaBySji0XzetHJS4/CXHnVcYm8jciYVjstkVzB49VCzIQFD1DjdR
 hY6bP9yqsRrmfHhddLk67cnHi0PocJDg9bZUDv1PQVQ4mQsCfjCrBewW/YlQmpWEvb5R
 yVyg==
X-Gm-Message-State: AOJu0YxeDnpa/ZhBcgEt3Q5T6JdY7MaNFH6GZ+dxHgjOfgrGqEIm9ogO
 nvR8n35WDKpq/WytaU+4dhNQBAAe2NjG5Ybrnyf2O3EVzyC09dn+VDRewNychMEn+yPSVlMq1ls
 =
X-Gm-Gg: ASbGncutMXrnWuGCL37Whe9n+6YXipozaBpT1IZ/sybfZmltagXqqJcWBzewo73CTYG
 1a3vgx46svojMIviCqCLp523GNRgFpxfxkXp/iCFwM6skELP14/lXMzXeUiZ930cCThWEzsccLS
 smI3hPVGw7nWc6YAp7NsjlCKHWssyqIjla4T0NMZioDEkbhmJTg9f1fgtWNA/5l9MSMUxNDl32/
 C6Ph03RpseE1SBTIym4GC9NGbvtyWgy35d6yYOLMAY5X3eWBSbov6kxM35/US5424TMJZOl8RE1
 4rXYQ4waaEuEGaZIw5ALHcvONkOkIssY6gl7Cl6u2qt4BpUezSDi
X-Google-Smtp-Source: AGHT+IHQ8sG7iHzonpGGvn8NdKXtad6roI9gtrMj9eQFbYCjzshHBjW9Wg+skAGjsmZtPV159lre8g==
X-Received: by 2002:a05:6808:2212:b0:3eb:4292:e6c9 with SMTP id
 5614622812f47-3f36dd0fffdmr132450b6e.2.1738604634866; 
 Mon, 03 Feb 2025 09:43:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/32] efi: arm: Avoid allocating page tables when running
 under EFI
Date: Mon,  3 Feb 2025 10:42:10 -0700
Message-ID: <20250203174245.1331464-18-sjg@chromium.org>
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

The previous bootloader has already set up the page tables, so don't try
to do it again.

This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

