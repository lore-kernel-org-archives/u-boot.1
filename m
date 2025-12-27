Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC1E92716
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 22:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B9783D3D;
	Sat, 27 Dec 2025 23:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rjvw30Xn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071E583D0D; Sat, 27 Dec 2025 23:38:43 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA01383D13
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 23:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3ec46e3c65bso6199803fac.0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766875119; x=1767479919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ewa+4VErWuAQrNhDznFRZMvS5+pHHDRm2czAJSMAXbU=;
 b=rjvw30XnxHX85TJyp58q/iNBNLUM+HrzfNRpxMTdJz1WBzQWx3KqD0dVuwhH6eUBY7
 0JMi5hPhKjTjBbKndWLt9FT1mJ03HuTx1UMXCMjXlLgFsWjS0uiuQqt4o2S3CsXLzaid
 pHQ0ZLzqum8E/+3vVASaUNNeHoqj5irYivrMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766875119; x=1767479919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ewa+4VErWuAQrNhDznFRZMvS5+pHHDRm2czAJSMAXbU=;
 b=GOzMK+XAH/JDt1C6cOaGlDQtIpKCz0cDsDG2wUxMX4rOLH7ihxpmEFkj2DG3I/webR
 9llXfHhi0c5gkZwfBpBoNHpMGfnyffk5aZr8QA36h3vp9VX1cT4VNNYN7WjXoxcHw0S/
 zNF3GfFmwMZobBvWx69zVy3vhgXkZvBcaXwiQatPc95MSmKzlJ3V3sKlVp0Bg1OygFbo
 YGQwdQTAuqs/yzfyRIsCd+fWvDQyRB5PcI00yKPQnQ0VBTREqDYndZAxeJK2j0KPA1ya
 HUzm1bEcbcMJoTsXHp/C9SnQwlhvG669tSjDMP8ayMH0M0Qm8aKWyJHnvDaCl2bUeZs9
 vdKQ==
X-Gm-Message-State: AOJu0YxHZUemxDM4a+MVlwl04IMl1gCDEWSLhZUYQc57jf/1PtSWFrhj
 KRwY/Zpvd1q/n4BYtsPPzvsdnm90Jg5qoztHWbENG4J1/48kbfvTHrgjGflSKutO0UbAF8gU0ng
 /TjSj5dE=
X-Gm-Gg: AY/fxX5xTate/cyZzrstmJTS9A6dHGoDHosIm+W55nwCbVkqfS02nhS0OJm4afFDLjK
 N/eoxftbOUH5SVpwrl4mtSwgq29SsCKxs14Ns6/v0FAaiciSvB1AaNDj3reqEUuTwWPLV7UHch8
 1HZu1q/ff8G5RgGTHOiWkFIslYDgNDn/1txewH3QsG8fCra9CseV4wRSzGv2J3XsTBWfGtSWF82
 6hwMckDjQJHUu+/e4x1DbbAootSfuyLWLRNe6Cvr2j/VnEWcXJVT4EQnaVGa5zOd76BH1cyE/mW
 bzBKvRE7oDAvSMH6GPyuSQCpIUCb4xrnVzx7MOzg9C0uJMMxBnFTs1WgJDdWM6EaukXoqRuO2gw
 WuDE7T2wz4Q0XsdLvU1BSbjRc976yuL2GFvvUi6kOaGy3YMBal/0oT9g5zL/+YB+KZCIsh8xb3B
 Y6PW1KAlWKaDBv8TRJRL4I8bE7d5s80yTO7pYOQWgfZwhz2VSufYZt
X-Google-Smtp-Source: AGHT+IEgL+TeAkbx+Ljs0QnnibH5mAwf7MV9An2Pt8waIDncR1aebwrN+AoPUEKWY7uHk64aXeu3Uw==
X-Received: by 2002:a05:6871:6a9:b0:2d5:ba2d:80df with SMTP id
 586e51a60fabf-3fda560d663mr12324073fac.8.1766875119549; 
 Sat, 27 Dec 2025 14:38:39 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab5d61bsm16708517fac.12.2025.12.27.14.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 14:38:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 1/2] x86: Increase SYS_MALLOC_F_LEN to 0x1000
Date: Sat, 27 Dec 2025 16:37:10 -0600
Message-ID: <20251227223833.3019311-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251227223833.3019311-1-trini@konsulko.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251227223833.3019311-1-trini@konsulko.com>
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

A few x86 platforms use a SYS_MALLOC_F_LEN value of 0x1000 or higher.
With the impending move to having DEVRES enabled by default, we will
need a little more room here. Raise the default value.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Pickup Bin's tag
---
 Kconfig                    | 4 ++--
 arch/x86/Kconfig           | 3 ---
 configs/qemu-x86_defconfig | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/Kconfig b/Kconfig
index c435fb431826..ce25ea24a60f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -299,8 +299,8 @@ config SYS_MALLOC_F_LEN
 			 ROCKCHIP_RV1108
 	default 0x600 if ARCH_ZYNQMP_R5 || ARCH_ZYNQMP
 	default 0x800 if ARCH_ZYNQ || ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
-			 ROCKCHIP_RK322X || X86
-	default 0x1000 if ARCH_MESON || ARCH_BMIPS || ARCH_MTMIPS
+			 ROCKCHIP_RK322X
+	default 0x1000 if ARCH_MESON || ARCH_BMIPS || ARCH_MTMIPS || X86
 	default 0x1800 if ARCH_TEGRA
 	default 0x4000 if SANDBOX || RISCV || ARCH_APPLE || ROCKCHIP_RK3368 || \
 			  ROCKCHIP_RK3399
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5aa134b6bcbe..48b033e7e27c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -133,9 +133,6 @@ source "arch/x86/cpu/tangier/Kconfig"
 config AHCI
 	default y
 
-config SYS_MALLOC_F_LEN
-	default 0x800
-
 config RAMBASE
 	hex
 	default 0x100000
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index a3210bc4a5ce..6bea902c947a 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -1,6 +1,5 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0xFFF00000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_BLOBLIST_SIZE_RELOC=0x40000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
-- 
2.43.0

