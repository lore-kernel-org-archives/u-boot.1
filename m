Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27982CCF2CF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22EA983956;
	Mon, 19 Jan 2026 10:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="g40AyEua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B02E8313B; Mon, 19 Jan 2026 06:55:36 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31EB68004F
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 06:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.ho@sifive.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so26966005ad.3
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 21:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768802131; x=1769406931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UADizjFHqqVzKW1O1b3KS/Yb58Db0TIAcGojPYVrZ1Q=;
 b=g40AyEuaGTCSTaH3pmgdLWunodUps/Ez0qzcNJyhx+RoXQxz+ZcKPOrhZyBfKCAaJF
 Nkj8jwWhqAbI00r36q3X9CKih42PDFSSEJMt7zVJRGTRpAMXEgE/NNG1VlfmeUvWWL69
 GcYwdkPMfE/2yBLrd8QwvfIXtLMGkypDxuLR8Ve50rS0sknRy34Uh4enftoGvj5yxjDL
 onyAJF5bkpmfkx4X4T2cO7HibRrvvpf9SVmspuJurnjVT3b8+Xju/siugpbDDUJSykyd
 oJH+buZIHP2H9qe93glyj8OrCZ39/LdIkU9Rd7yApDwebn3NHsGgVjuuVfRphwi1ZtjY
 4oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768802131; x=1769406931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UADizjFHqqVzKW1O1b3KS/Yb58Db0TIAcGojPYVrZ1Q=;
 b=nNBYs7El/sjbn2N3/FB7WEOSiOUEZdKqmvzEzHZrUiombhYgw+ctfz5CcqUWOZvifu
 WBiBODbvQ93Kwvjz6KJjYwg/9N0LvYSPDE42iJpLz3rbv++Jt3RZfPRgCNTS59PUKYDu
 TYIFXJU8s314GCqd7cwhkLOEN4595h46458SKqDigogZQxISO9U2Ki6py860C90neVOm
 QbhnkoPLYYFzmjEXUNPBvsPzoc0OF3BgVaehMIk7WaE2CSqhKw2npahYanqcAcxSigpA
 0RiCmEmv8G7l0WocTqn4afo646UIsMNyGJL6Mr5NDxOrPmBHVzg8t75OPIsXCgVFNY2o
 GTKg==
X-Gm-Message-State: AOJu0Yyr5sx8CGGiVJQQaAtnMb+khrKAWsAvtIr/Y074kleBMwnxIo1r
 RFbic8myFk9CHCfT6ENmb5FRb4+YeLeVnZg4sG5UgRfjuSDNKSZNod6CevLPagM0e8e2wS2d49c
 IGC2QR3B6bYD0MN3ae1/qp3I02p/s35NiBe+iliimKj1b+QKyNL9X0i/6/xecEmjegfzG03mATP
 tPWi/I8QKdm2U0ZtpNIJ7bNfqtfktZBK/Wyz+8pg==
X-Gm-Gg: AZuq6aJ02aXR+8OnqTSqk0mRf+s9fvn2JfffF4ULGCXAJ0UhDSYM7Q1TX6a2oN8AcCy
 NqOdViV9powZdFUSH3zl36oYdnQqCeswaW1mGylALp6fLTfIAlEiYHwbTzK43qYra/F2m6GN0JV
 5sPcCTqgdBhGPjQkOApkV4dKvlUhxbpO0LLsdipuAq1xCA3MiCAend8wBDS/T0CsXb+H7mkf1b0
 Pp+xSmTVTFCz1vgB/dfPBCVE70mqDpmg8DlIHFAnqM7RFSDa8o6Ys1cwVGBQNyeouKZM3FcyIlQ
 YSjXnmGzmR5lQgiXvqbJtjhzqpESRN4Wa/UGaK1Lm+lNcpWftSmEVEA+v4oEPXGPyhfKfMr4o3l
 CtS1CCO7DnNjq+WMxtn9BJhorXZFSH0Mr0dfUDyw7jhxvuOk9Ao7T89nND9FOhk7lyyi+BBSWY5
 Yllr0E+a6teNGzsGddDTLHrZ/NySPW1+WCXw==
X-Received: by 2002:a17:902:ce8b:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-2a7175c30damr89916415ad.35.1768802131237; 
 Sun, 18 Jan 2026 21:55:31 -0800 (PST)
Received: from hsinchu01.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb7fsm82589695ad.64.2026.01.18.21.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 21:55:30 -0800 (PST)
From: Jimmy Ho <jimmy.ho@sifive.com>
To: u-boot@lists.denx.de
Cc: greentime.hu@sifive.com, nick.hu@sifive.com, Jimmy Ho <jimmy.ho@sifive.com>
Subject: [PATCH] driver: cache: Remove SiFive PL2 driver
Date: Mon, 19 Jan 2026 13:55:23 +0800
Message-ID: <20260119055523.13460-1-jimmy.ho@sifive.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 10:12:16 +0100
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

From: Nick Hu <nick.hu@sifive.com>

Under single core boot platform, the secondary cores won't enter the
u-boot spl. Therefore we move the pl2 driver from u-boot to the Opensbi.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
---
 arch/riscv/lib/sifive_cache.c | 3 ---
 drivers/cache/Kconfig         | 6 ------
 drivers/cache/Makefile        | 1 -
 3 files changed, 10 deletions(-)

diff --git a/arch/riscv/lib/sifive_cache.c b/arch/riscv/lib/sifive_cache.c
index d74544b93d8..9a0519af494 100644
--- a/arch/riscv/lib/sifive_cache.c
+++ b/arch/riscv/lib/sifive_cache.c
@@ -41,8 +41,5 @@ static inline void probe_cache_device(struct driver *driver, struct udevice *dev
 
 void enable_caches(void)
 {
-	struct udevice *dev = NULL;
-
-	probe_cache_device(DM_DRIVER_GET(sifive_pl2), dev);
 }
 #endif /* !CONFIG_XPL_BUILD */
diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 4f358657444..28446c479dc 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -45,11 +45,5 @@ config SIFIVE_CCACHE
 	  This driver is for SiFive Composable L2/L3 cache. It enables cache
 	  ways of composable cache.
 
-config SIFIVE_PL2
-	bool "SiFive private L2 cache"
-	select CACHE
-	help
-	  This driver is for SiFive Private L2 cache. It configures registers
-	  to enable the clock gating feature.
 
 endmenu
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 2f683866b87..05ad7d8a33e 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -5,4 +5,3 @@ obj-$(CONFIG_L2X0_CACHE) += cache-l2x0.o
 obj-$(CONFIG_NCORE_CACHE) += cache-ncore.o
 obj-$(CONFIG_ANDES_L2_CACHE) += cache-andes-l2.o
 obj-$(CONFIG_SIFIVE_CCACHE) += cache-sifive-ccache.o
-obj-$(CONFIG_SIFIVE_PL2) += cache-sifive-pl2.o
-- 
2.43.7

