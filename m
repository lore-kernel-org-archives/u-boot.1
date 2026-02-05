Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D568DECD9AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B63583AA4;
	Thu,  5 Feb 2026 23:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l6zzgFUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 742D283AA7; Thu,  5 Feb 2026 23:16:52 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4597A83693
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 23:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-662fe3ff6f6so793066eaf.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770329809; x=1770934609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnX5SRj6ON0AcGdj2tDIRU8C5HSbDoCMjA7qoSFyKFs=;
 b=l6zzgFUOE0sMj4v6CgdpuuYaR52EWy/90fPt0yS/V53ynVx8x0nFc4frlHApsE0k06
 NMZ7gPVXNTGYdvMWu7rL5B7eiO1pulTpupdJQE/8+jJdshLN8ILtWwQzCq6BrJfYnFXl
 KzOnQWIveGtvH5GkU7fg/P2KqloFHzKPRUVHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770329809; x=1770934609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnX5SRj6ON0AcGdj2tDIRU8C5HSbDoCMjA7qoSFyKFs=;
 b=K8DU2FxTINfn+T2WISEkzBN5r6qqFhJSw1is6FBGICX++fzzZ/7ghpcfsCnd83yY3+
 R0gZ5oPdc+fz4cwudPor+dzWY2BdeqPkP0Cj5j5yaStzMp9CjqVHoDr0NNG15ye7wzCf
 S8h/lqaRh/9xNOjHvWSbB7xaD1IOTTwMCZWU9rwxmmx43RLvGfWAioas2Nda9381ZQGL
 aDkXIdLPIsEVwaXcRjV70Usdz0gsXkj4J+IaRcJdsaMbzrnMe+mc5bMgAdHTFhyesRQ2
 wwu4zvIWAdtw1RMmB35jGKY/tkllyujbGGiADssjY9g0wlYCCsL8RYHAPviXKLNNka6i
 iXwA==
X-Gm-Message-State: AOJu0YyGue5JDhYH3dZA2GDbl5HAjy1LKIA1E3LSNswfk2sH78zy66WG
 YAvDqX1JsUZLnLwtgRVkxhBDJOKT8sDX0YzWPc7BgWGD5/YzDUeHyNZrkci6+pgdpBa41scpY9k
 ono07lWU=
X-Gm-Gg: AZuq6aJJCQ/EluBRVNyt7oLKwczPf6SYr8eBP0prO0eurUs4U4Qq+5hT3KTBY1B25sO
 BTwcEaUmlGPQfEVR7W/P+il9MvVK+JJgG0xQUH3UIXjqKnb2/NnFqfESZRvP/gNq5cDboxStbGy
 pgImJNQHwcWgg+J+g9cA2qCrpPfQpzJreU0ERSaADa9a5K4QOq+qsctErpUo+h0YUmUi5RP2lyG
 OZkMF3tq/bIe7/Y3t/12XRqvDZiFAdDBlhZrwVKja9V/VtweTqOxQWWSuH2K2g/mXIH3LXhAEgm
 g9uuINvkMJUVXvafETqYctRguE+uzwghFknGEsqkrOb74DEivisCSlj0qHcacko0e0cCduoDPoH
 aBphzVguq4XPRgLO9ueko42omwSw/HTeM4Jj0KtNPysrdG8Hle1JJTA/01kW3ctBrmJYeX7GqAR
 pLC9g6busWX0OvkOyHKETGBR2+NIC+MhUP8Hu/41CYtaG6Z8Qh32cXdCl8s8ccJo288MAIUsZmA
 N+Y2gw3JHI9Xu2xkmnR2wHZepfzInkIYAytGcEGiw==
X-Received: by 2002:a05:6820:3096:b0:663:96:a8e4 with SMTP id
 006d021491bc7-66d0a667d96mr442720eaf.26.1770329809044; 
 Thu, 05 Feb 2026 14:16:49 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d35e5c0desm214873eaf.0.2026.02.05.14.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 14:16:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>
Subject: [PATCH] socfpga: Remove incorrect CONFIG_SPL_LDSCRIPT settings
Date: Thu,  5 Feb 2026 16:16:45 -0600
Message-ID: <20260205221645.3749285-1-trini@konsulko.com>
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

These platforms set CONFIG_SPL_LDSCRIPT to a file that doesn't exist,
and in turn were using the default of arch/arm/cpu/armv8/u-boot-spl.lds
instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Lim Siew Chin <elly.siew.chin.lim@intel.com>
Cc: Chin-Liang See <chin.liang.see@intel.com>
Cc: Dinh Nguyen <dinh.nguyen@intel.com>
---
 configs/socfpga_agilex7m_defconfig      | 1 -
 configs/socfpga_n5x_atf_defconfig       | 1 -
 configs/socfpga_n5x_vab_defconfig       | 1 -
 configs/socfpga_stratix10_atf_defconfig | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/socfpga_agilex7m_defconfig b/configs/socfpga_agilex7m_defconfig
index 0a8c58234b95..d3ecca436efd 100644
--- a/configs/socfpga_agilex7m_defconfig
+++ b/configs/socfpga_agilex7m_defconfig
@@ -1,7 +1,6 @@
 #include <configs/socfpga_agilex_defconfig>
 
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 # CONFIG_TARGET_SOCFPGA_AGILEX_SOCDK is not set
 # CONFIG_IDENT_STRING is not set
 CONFIG_SPL_BSS_START_ADDR=0x1ff00000
diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
index 1ef20ba97a84..bb8f1eb7264e 100644
--- a/configs/socfpga_n5x_atf_defconfig
+++ b/configs/socfpga_n5x_atf_defconfig
@@ -4,7 +4,6 @@ CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
index a4798e2f953d..78fe42e107c7 100644
--- a/configs/socfpga_n5x_vab_defconfig
+++ b/configs/socfpga_n5x_vab_defconfig
@@ -4,7 +4,6 @@ CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
index 63ea467baefe..206343885d96 100644
--- a/configs/socfpga_stratix10_atf_defconfig
+++ b/configs/socfpga_stratix10_atf_defconfig
@@ -4,7 +4,6 @@ CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
-- 
2.43.0

