Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DC3C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7503982C15;
	Thu, 15 May 2025 17:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="2+M0hEE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EAD482C13; Thu, 15 May 2025 17:58:22 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A7782BC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad243cdbe98so184563366b.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747324696; x=1747929496;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=utkffFrvbQ7mU7V/LwrxwzHbkZuG0TKCFcBC3slGrxA=;
 b=2+M0hEE8mfwOrsFEZsZMIVqKycN3pEAy6AZ6kbk78Uin/zavEjZ2vqEHAQeUfbqmpe
 wZtfxT7EB1XoxKD1bfZxdu1CcCvQ/b6rBQQyBKNJXRAAKjDSzBd/Y01MJpsifgStKzTh
 Cbc4BIwGsnM4hCTsW30ytawrge4pc0/qLpgwigZnrwyAic43RpuqzkbvAvtmlBjZ3Qi1
 dlzCOz2Eb9zih/lRXNhw2nHBguPHVVxw9zsqo6nG8qxfjamE2LZXtPcsDuX7JgASgCZT
 RPPip72DTkQbwHbHW+XgnqwlhZUN3URKuLHSOBFLGpNQ+eV7TQO6N96z9gjLFDqEFAbw
 EJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747324696; x=1747929496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utkffFrvbQ7mU7V/LwrxwzHbkZuG0TKCFcBC3slGrxA=;
 b=bxYg9vRevquDjy1KPH46xTC5LPQkR3LRXapQLzm5XIiWFh+IyRuAs7Vm24DwBz9RZc
 YZNe9GP30TY4SEZh88bYXW7cO5vkRYhtfM8Hu0AcuuWjZG//YhG/n3T7YvTeYljWJz/V
 xkQrLRAbDp/TIv01FbNLhmRAGV60R3vsDVapo0K0seGffzFGEd+3aGdLeUOdeQQXLfI7
 HTXMTBzgUvnCsRJR/fAmYj5ecpZ170KFOHJ/gkBnXratFdhzzOOw0n4cReChCzgwBH79
 tfa4QhzgTgz10qqGeg5s10F5eU57eUdodyKHVuXwDG/8jBCpgnw5OKvit8u9KSNUvIuj
 srtw==
X-Gm-Message-State: AOJu0Yz4ZiXjpEdtycxoPFrUcof35GZ0DPH4qejB0MSbKIvnDcok0amX
 8nsR4kxsbXRgxPlRRg2NKJ47XAwWZ1RacbZOZJbgHAYVV2fzFwuPXoB/DA0YNcpzBzw=
X-Gm-Gg: ASbGncvz+IlDBCKiwZpzHOnL34jtwgX97hkD1OmiQ4UVMTYxY57GrRFlL+2KBbn/JjA
 TL6rTezdIOf7whV9wU8zqVwG+Mt+CCMYa/6u0H/0onbRys08nWXGpyimEKOjxhhfRwFLZkzFb6z
 2Ai378LDm8uVag1IcXd0ICPZmaftBliOOI7obXi49bIASrTPFVzAlJxUk6lWyfjgh/7leXj1foz
 lLLPZ/IY+iVxeLrZ/IvAcm9L3O+zk7ITeFm+oX87vkMmY81aoqls3w4PgLD24+/maoB00D5SQvI
 YR4/RUYf0GFscGt8yv8GMkMbh8KOhC3uKgGwMqvxVmm7LBL8DYsPd2btnWdJX0w5
X-Google-Smtp-Source: AGHT+IGFt8irkF6xRVsinU+sU95L88Gl/7kFQH3AhsR0At861hLvFwgHmXubTlWilKT8aLpg1U0bBw==
X-Received: by 2002:a17:907:3e0a:b0:ad5:20ba:210e with SMTP id
 a640c23a62f3a-ad52d4ca85fmr22440066b.26.1747324696217; 
 Thu, 15 May 2025 08:58:16 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d271916sm8698266b.69.2025.05.15.08.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 08:58:15 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Thu, 15 May 2025 17:55:48 +0200
Subject: [PATCH v4 5/5] rockchip: px30: Fix hard dependency to
 DEBUG_UART_BOARD_INIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-silent_console-v4-5-dec6c8391f01@thaumatec.com>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
In-Reply-To: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Because DEBUG_UART_BOARD_INIT depends on DEBUG_UART, hard dependency
to DEBUG_UART_BOARD_INIT in ROCKCHIP_PX30 can cause warnings if
DEBUG_UART is disabled.
The DEBUG_UART_BOARD_INIT is already implied by ARCH_ROCKCHIP entry.
Remove hard dependency from ROCKCHIP_PX30, so that it will be
consistent with other rockchip boards.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/mach-rockchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index dac160d33ae3..d3ed870b169c 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -13,7 +13,6 @@ config ROCKCHIP_PX30
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
 	imply TPL_SERIAL
-	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply SPL_ROCKCHIP_COMMON_BOARD

-- 
2.43.0

