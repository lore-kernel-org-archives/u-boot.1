Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC03D7877E
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 20:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E1AA836CE;
	Fri, 19 Dec 2025 21:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H2U3I+pD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8872A83642; Fri, 19 Dec 2025 21:21:32 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16E98334F
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 21:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c7613db390so1282947a34.2
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766175689; x=1766780489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7x1tzAK3S1evb0Xj8oQbw0O1KIirP1yj5POxr8y7Ok=;
 b=H2U3I+pD+fk65fjd9cN6HuKPHRwC0Z0yw7ic77tltXV46qyLbLS3wUxgw61FGNPiTH
 EPbyZ9o2ddYqNgxOq8N7F4cX2RoRQo4JgBHb2ZwYl/Ryxr6CrRvDzVaB348/Yp5sNhC8
 m+2xetzdYOmHoavKdmCBy28YtkF6kGB+0feWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766175689; x=1766780489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7x1tzAK3S1evb0Xj8oQbw0O1KIirP1yj5POxr8y7Ok=;
 b=TmJAE2trwO+oaN/UoIMNypN9xkAEXCuTqh3+pZLZK6DE7jTFk+COn/h9AXaMgOgFee
 9vrolFmJgq9rh5DlIneNpVpdkZWvHBfxZKymFnxGXyPyKzGvqD3Ftvko+8QVj1y+nn2L
 5UGHB9BcRRlXsfpsFYp/iCXCvi+mtSNEze2NyELeB9mMpLKzcAbWvCUBfveJV3vRQ6/T
 Zxq/DpujfGfKj0SOc73HizqrRGzQovM3PjOLzLVdslRgXxCUz4orKI7qGL3zj6RRwAgL
 JoNpdTHclgI/Fr3WxbYM6wxBogF5XYCUJ3+vnJa4SAR0oGnsgHyRPLGSshRBjOBwcx06
 nZzQ==
X-Gm-Message-State: AOJu0Yzi/Ks8zFfTObbr0cZSmQK7lmL7iXn68pJLLceeVLGVM53SFu9Y
 +OUgD3zAj/5DtfN6lKjprRPZvhX2Ac8SEGDehNgUhwbZGTTx92GY256M8xX1rGe2oH8rLY79k0T
 ikPn9ngc=
X-Gm-Gg: AY/fxX7f2FKApIyHlo36GQNd4RkaBTkNicZmtvz2WBoBdvg2Hwc3Ss6QZqTyy/F3DVw
 fX4wUTY1oenl4T9OPtIZAmImbcBsb3gdGUK5yVUEeTc3IBgtuwWqN7LR9isWkj2NSadA4svNGr0
 3FkiwX0a77peBNqlmbQfbkeMeKehBi+nxWMhmKZJHHVKBl5bnN+AexYHkAnJNfULNmJm7wsXrXq
 7o8C2LUneIpuozWAlHA8HOX3ZWvI8tKEqLjKJ8RcamPwExkNsW+Ze2RmjpUigx7qZlruhHWZQZ/
 It3xU5bdYg4rBU3lYMGx2h/mH0F8EFONNzTvuqEDbBLxKzgZdEzxJlfo2us3EjBDIOLMhYTGFMP
 8K62r60vTGgvNBTXobl+nakt8BkkZ7lWqQAj2na/g5x0/4d17eXw7LLYHOQCV8KbjSAqEs/WPtl
 ff/vnqvy3RTLTgFRiD0C2bBdoVxQohVeRmQPilEObeBe6Ozr4Bp7QH
X-Google-Smtp-Source: AGHT+IHobZCZjSBDJE1/RQXx6B3KRPCjgUmLdELrWR4HOzdBYX9ZUtxcOo0LlK5GN3HB0UPKvYr2IQ==
X-Received: by 2002:a05:6830:410b:b0:7c7:526:b1fd with SMTP id
 46e09a7af769-7cc668ba26bmr2908540a34.11.1766175688753; 
 Fri, 19 Dec 2025 12:21:28 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673c32esm2359189a34.9.2025.12.19.12.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 12:21:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 2/3] x86: Increase SYS_MALLOC_F_LEN to 0x1000
Date: Fri, 19 Dec 2025 14:13:42 -0600
Message-ID: <20251219202121.4180810-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219202121.4180810-1-trini@konsulko.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
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

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 Kconfig                    | 4 ++--
 arch/x86/Kconfig           | 3 ---
 configs/qemu-x86_defconfig | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/Kconfig b/Kconfig
index 1d6003426855..aef7aa2c841d 100644
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

