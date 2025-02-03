Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E1FC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8798801DE;
	Mon,  3 Feb 2025 18:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CWaIKVOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB00C80243; Mon,  3 Feb 2025 18:43:57 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4425380815
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f314ff6ffdso2672592b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604632; x=1739209432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZIngGNQXnLJPAlkKzCr7zC2DyMZZhmVWOpa6TFX6FM=;
 b=CWaIKVOE7JDb3bZnim67C8rHlSPUzDzETT/YdHBpG7rsCHsdlMNn3jOX65pvjWQqX9
 YJTq22QK8Yj8ksXLvfNBbb159HxgoNNn+TyeA7sYni5pZB4G8h0vc4LCHHmZS9f222eR
 ZY6Pf6t6O0XgNX8jzIfg0yujpA30+QnW/0OJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604632; x=1739209432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZIngGNQXnLJPAlkKzCr7zC2DyMZZhmVWOpa6TFX6FM=;
 b=XAWbJtwvaglHpp6fUQUE1yFhEZe6UUt2EF7d0q2PbC5oU03s76SlQrXAbJD4RslLam
 pKO4tuX8V49c9r6qgFgffMdPBCkoITz0YkJwuHRfVWXFNqhywDSMDzFpVtkJbmKj6r1O
 KnHzeByqHFN6K9fgLG+zZtg0KyTfkTtoo8OwD25020vma1oWyDP0glmUDfulb8Xa2IfA
 tDMgR7kO9bfzNjkxPXtKV1giF3uTGZE0laeCyA2trHsYiEv0sQeM3Dzz1t8GLK3FP0UZ
 IB0rrA9m8WrmNjAhDNdSmWBBAOsdgkl+SFQDpnIY6ug9jpN8GIYJKybvb7kmXEQeB45m
 THkw==
X-Gm-Message-State: AOJu0YwYesoAttWSDRUG6hfSL2Dq07jlDOzBJ+j/2ggsQpKNcSGDbu/k
 ngSMtW7AT6ZETMDcB2PksdIOzfO9k2itETrgb2nu+8Y0ZScNjGXE1qU+pX9jSOg0fx8VP67ECsg
 =
X-Gm-Gg: ASbGncsxK3izozGi4qy5gpx9EOvV8HS2JA4jgs/G8T4oNH4hcrBki/NZnMD3gmdQZQG
 4B7uRgT3ScuFidLdRC8wrQwVDtgLh9+XXcs9WJIdVOErGP3Necdycl8scMmqsCCTPrB3Fl2mKQs
 INZZad2+iU4JyBdc9boVHZ+nRR7CCN3sI5YrSS5NF7OUn6/oRqJabL9JMvYWiKHjw5Z/Zzwi5mz
 Igjw61T3LBHz41A81XXze/zE8XJlTpQVvyDZfGbAo3UwWWh54U20VsA/cQCTyM5/skV02fi4FON
 oZJeJkS01seldq5n07j6Bd9w89TgU3PNLR5eiR8nQG6wWyWFzDTi
X-Google-Smtp-Source: AGHT+IHKyMwNHckQkhWYFpDj21/HjqQuhqurBY6GRb2/VGGtm7UrkbOF7k/9zPSYoo/Ujpb/0TRr9A==
X-Received: by 2002:a05:6808:320e:b0:3eb:549b:2c14 with SMTP id
 5614622812f47-3f3239fda8amr18822194b6e.2.1738604632180; 
 Mon, 03 Feb 2025 09:43:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Janne Grunau <j@jannau.net>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/32] efi: arm: Don't do the EL2 switch when running under EFI
Date: Mon,  3 Feb 2025 10:42:09 -0700
Message-ID: <20250203174245.1331464-17-sjg@chromium.org>
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

The previous bootloader has likely done this already, so avoid trying to
do it again. This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/bootm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 974cbfe8400..688c2f3f29b 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -16,6 +16,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <init.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <dm/root.h>
@@ -186,8 +187,10 @@ __weak void setup_board_tags(struct tag **in_params) {}
 #ifdef CONFIG_ARM64
 static void do_nonsec_virt_switch(void)
 {
-	smp_kick_all_cpus();
-	dcache_disable();	/* flush cache before swtiching to EL2 */
+	if (ll_boot_init()) {
+		smp_kick_all_cpus();
+		dcache_disable();	/* flush cache before swtiching to EL2 */
+	}
 }
 #endif
 
-- 
2.43.0

