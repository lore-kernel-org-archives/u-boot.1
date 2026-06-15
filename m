Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB49FCD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F88B8484C;
	Mon, 15 Jun 2026 23:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rqhOv8fZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC5084869; Mon, 15 Jun 2026 23:07:02 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7F2846B0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bec423a2d26so38277466b.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557620; x=1782162420; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fw8uU1RykNTY2mUwlmpnKIQgHE+kztjTYjQSBwLg6zc=;
 b=rqhOv8fZr2bDr3myY146tT6aA2BymMfL3QoYAAdtKNdHPTObyNkB/mvbc7xGPDgBbX
 dXKC+j97r+cVACd5funkaQbmt94oNCIUJm30eyT78eZ37x/rYvJMcGs8Ij76b8euPFJQ
 BnnuG9g28SwvGjRuQ7I+LOs2eVS3tym08d8Vx2E4uy6UE0Li3DTHc4RyYwu2D6nO6v2R
 EGI0XQkrX2+x3I1mzSw5cJvwVHw8MxvczkLW61c42KY/fKglJPXHoMbj4dhAxqUWinLg
 po2XaConPefaZ6hxR5J2wu4z890M1Kt2VopCb2TwQequL3nEn5IIcgy7ibswySXQDmyE
 LMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557620; x=1782162420;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fw8uU1RykNTY2mUwlmpnKIQgHE+kztjTYjQSBwLg6zc=;
 b=tJSckN5clG1r8pJNfo72qqFqWYd/YcBFgqwmXFo0bk3G9AuUo2KPKF7iM9O834HwYn
 xrJABKw7B2KiajUxQqqDmE76SOstRT08auPuyYhBegoJYQmDsDewpwTxF6VKAsGBuLd1
 EYVo6fTbPoI7oKRRZc3q4L+Fa+OQ+J/sue+N/EanR5OJbldDOO9fi6xGfvOWkpII3dFF
 lnEy4hKNuLTTjGhRkKes8TqAQy/Rv2PnYkB1dcuZZrN9CMf883gXBlwLb4+hRwCj4kcQ
 vJ+OSE2r6ajoWdDs9PjpBZFQR15Ka7ccs3uQE2SGcmJJvp6XJhpZazj9yUYfiAtPiT5W
 k+tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7EuuOUR1SdO0ZFrwjYiLBhB+rAuyG33FEYbKK8Hthr80atRkATc/tPs0Gv8XMteRCOMP05bg=@lists.denx.de
X-Gm-Message-State: AOJu0YwgpS5/xmDtJs9Bj5Ts3flz3hVlWKBPfDCUaEfYdlTNiaLTyhKF
 Jr178NMpYxmvFfgPsGZQLJ1tmaAjQAYlGNBXxlP8y9PrkgaDyXEI/59W
X-Gm-Gg: Acq92OGg+fgV/NeujYJB8HYq29lqwrfAYJb4bdN22wZa4UCoqzvCqIseAup2ZcU+Z3T
 gHrqQJJhttafxu/LO5M5kHBQl1qHRU84mPx8NgaAC1bp6qzYjIkFmWozcIziv39OBPZlQEu8qn6
 Rxema2jLjDBTxfU3CN8O+1eelAqswo4Z0gQ+Jb6qCudbBrXPB2775ePYhBUW1Lyg6whpCZf8Blt
 PX8aGj+h2z9Objv3U4OkcpUQL+F2LqHz6GWn2s3i8S1Rpv3TTQ0doT1yR8GGfOzXqJ2qv8y3Y/l
 1OfBvtJPiQD4V92nyf1rbuoMS5+dMLofJWXSSE80YfjibC7kHLbCHM0EXlSbZHOXa11I2TzebXF
 GkP6aFEYAHWpuT7eXI8zk/vAYTxvW+12inMRkVm87UqPA/t/BKy4nnP2yQxQ1dc3R8o8J9+N+p+
 a4ceAzZHBcTffqCmozp/umU8kwNDB3e8cAYDqbYtSvBAj+UEcvXmTs5nCLMi+xUMB5lHuDxu+h
X-Received: by 2002:a17:907:3f18:b0:bec:ebd7:90d5 with SMTP id
 a640c23a62f3a-bfe27e0909amr322583266b.1.1781557619518; 
 Mon, 15 Jun 2026 14:06:59 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb7b6dbd7sm517970866b.29.2026.06.15.14.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:06:57 -0700 (PDT)
Message-ID: <53da4adc-c397-47e2-b65a-fd5325826d7e@gmail.com>
Date: Mon, 15 Jun 2026 23:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 01/10] rockchip: configs: compile rk3066 SPL with
 SPL_OF_REAL
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Unlike later Rockchip models the rk3066 SOC has no build-in support
for SD/MMC cards in the boot phase. The current workaround in SPL
probes the rockchip_dwmmc driver with OF_PLATDATA. For a simple board
as MK808 with MMC that just works fine, but for more complex boot options
not all required drivers come with OF_PLATDATA support, so compile
rk3066 SPL with SPL_OF_REAL. Update mk808_defconfig.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V5:
rebase
---
 configs/mk808_defconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index ea257495db73..31b18c529134 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -16,16 +16,17 @@ CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3066a-mk808"
 CONFIG_DM_RESET=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_ROCKCHIP_RK3066=y
 # CONFIG_ROCKCHIP_STIMER is not set
 CONFIG_TPL_TEXT_BASE=0x10080c00
 CONFIG_TPL_STACK=0x1008FFFF
+CONFIG_TPL_SYS_MALLOC_F_LEN=0x0800
 CONFIG_TARGET_MK808=y
 CONFIG_SPL_STACK_R_ADDR=0x70000000
-CONFIG_SPL_STACK=0x1008ffff
 CONFIG_SPL_TEXT_BASE=0x60000000
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x300000
 CONFIG_SYS_LOAD_ADDR=0x70800800
 CONFIG_DEBUG_UART_BASE=0x20064000
 CONFIG_DEBUG_UART_CLOCK=24000000
@@ -43,9 +44,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x32000
 CONFIG_SPL_NO_BSS_LIMIT=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
 CONFIG_TPL_HAVE_INIT_STACK=y
@@ -65,7 +63,6 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_OF_DTB_PROPS_REMOVE=y
-CONFIG_SPL_OF_PLATDATA=y
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
--
2.39.5

