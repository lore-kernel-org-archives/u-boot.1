Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F43C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 03:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DCA9835C6;
	Thu, 29 May 2025 05:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OrLDmp49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A6F835C6; Thu, 29 May 2025 05:31:06 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE28C83487
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 05:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-742af848148so247678b3a.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748489462; x=1749094262; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p78nNtuINXQerzmA1c7lovihjD6piWS8OQxUp7+bZjw=;
 b=OrLDmp49S2lGBQSQ9XyS1GMlKuvPCyaSJTIJ+etMNp0oYcYRQlIuLf65ZcIB1/AOu6
 SCt+P76+Fte+EWJyFrNQlbx3DyaHDRkrFQyKDUBilJ3VCNia05sxK8WCCE6yRl/GNRPR
 iCQej1k66fg/ghZm4TR3La9fBtISdKEHwmtd9Od4B56/Utt9TdH1JBUsSPG+1x8uOEfR
 wf7NZmSyRmsIyVt+COYqDdgv1I9b1aop35GdL6Zi0YgFEbVaGi1NnSr7mhGXmUPnAoib
 2mXKJQLpAqTC+ek5wwmtJUl+hxMfayyHkauH+YnxOiWu2dssqQQj6G19Y0lTlODUVfGy
 rOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748489462; x=1749094262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p78nNtuINXQerzmA1c7lovihjD6piWS8OQxUp7+bZjw=;
 b=jMxvLPLeaywc65LtOjNrLibu/jIzeQr9bya45JHrb+odeGZsgmlYDbMso0JXBUtIja
 jHCgp3KQmGKuEvGRq6QrqpHGz+0Jce+6djA8sYJWuSD+uOl5LWtwGJVSSZ+In2E+Kl5N
 Cp5YPSXp25Xe3otBtnzSpG3n/jez1TU8z0m9epz5d3L5hkR6jdsWi0L8DlMa3/yOAetj
 9I3bJD0UwbzxNhcxq5wi6Fko3B64aXRaBzb8+FHbyZt0fIGuWC+G8VPFS8XXL4i6LQSz
 YLaofeyISISiGD8l0ji1FoUokm8FSWqtqi4Ih8v57+mjpvmnwJ8RbEFD2uCD37vV9wF1
 k46Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTsSBB7yG1nGwQzB54wErc6Gdwlo9Q9b3fvyRCi2yccBgSOs1kFMv22Qy5uG7sTR54oFz49MY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj5iHT3QyuTTjXe0oBL5iQOryxGh/9b1gD58wgoaKvM/x4CzlP
 EXhJaWK5/f2/rkON1pOw6z31qq9FGVpLY1ZAV08tqEnkvn9yNCcztvciAGTmWXquX9s=
X-Gm-Gg: ASbGncuZFO8wn9kaUoYiecRBTDAc0KnXE7RNJYlDHuDXeP5T0shGStqmsHMGBB0Dyp4
 Eee722c5p1o8YmTkzaqFIOvNkXD61If3fLjhGaf0CGuh6iXjbI2I2tZOPR+5S2CGHreOPQWZccx
 OXnDqxuLhRkL823+rTjRPHDrgAxkKe7IgqRVz/GwTcA28fSoDjbxyTsAolnk1/zGJ2Qg3FSnX+u
 I1VMxxkHlLMLo6+5+oh5XHPvXUiBKQtv0CObeKzOgLZltzH4EWOLDKwKVGJXD9EVgA6ECyLI2sL
 faXh2u2m9TFxo8ggcPt7IF74tlBGLvTmEtA4xtLwv3tduz5JSWGhrSX5Ej3F/e62smZLo6Ih
X-Google-Smtp-Source: AGHT+IFqJ7M2P3ACC7XH72SP9G050UDhlIur1Eurzb5jviLVZiCu4vtvP+J/yt4jbwX02w3O8QKovA==
X-Received: by 2002:a05:6a21:8cc6:b0:1f5:8220:7452 with SMTP id
 adf61e73a8af0-2188c28d3ccmr29464523637.24.1748489462358; 
 Wed, 28 May 2025 20:31:02 -0700 (PDT)
Received: from localhost.localdomain ([223.228.139.23])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b2d9872cca0sm1847252a12.15.2025.05.28.20.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 20:31:02 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: trini@konsulko.com
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
	u-boot@lists.denx.de
Subject: [PATCH] Revert "booti/bootm: riscv: Verify image arch type"
Date: Thu, 29 May 2025 03:30:49 +0000
Message-ID: <20250529033052.399573-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
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

This reverts commit 37b0b22d8b7bbed6aa95b6daed06dcbf4a66f211 as
discussed in [1].

[1] https://lists.denx.de/pipermail/u-boot/2025-May/590841.html

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/lib/bootm.c | 4 ----
 cmd/booti.c            | 7 ++-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index c98c5e76633..9544907ab1e 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -90,10 +90,6 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	announce_and_cleanup(fake);
 
 	if (!fake) {
-		if (images->os.arch != IH_ARCH_DEFAULT) {
-			printf("Image arch not compatible with host arch.\n");
-			hang();
-		}
 		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
 #ifdef CONFIG_SMP
 			ret = smp_call_function(images->ep,
diff --git a/cmd/booti.c b/cmd/booti.c
index ced2c1047ab..1a57fe91397 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -130,11 +130,8 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bootm_disable_interrupts();
 
 	images.os.os = IH_OS_LINUX;
-	if (IS_ENABLED(CONFIG_RISCV))
-		if (IS_ENABLED(CONFIG_64BIT))
-			images.os.arch = IH_ARCH_RISCV64;
-		else
-			images.os.arch = IH_ARCH_RISCV;
+	if (IS_ENABLED(CONFIG_RISCV_SMODE))
+		images.os.arch = IH_ARCH_RISCV;
 	else if (IS_ENABLED(CONFIG_ARM64))
 		images.os.arch = IH_ARCH_ARM64;
 
-- 
2.43.0

