Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0AFC04FF6
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 07:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C53C87F64;
	Sat, 13 Apr 2024 09:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iVyxrIhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 746D08801F; Sat, 13 Apr 2024 09:26:06 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4488687E62
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 09:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7d6230233f9so60827239f.2
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712993158; x=1713597958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uHitjs9I6Ovwb1hH2+VS+RBfbChLH/Ni4ahAKQR36gA=;
 b=iVyxrIhvSfl1hug+ysWX4xzgjMWqGVr8hsNs6ZASTmaRDjYp+AXALNYKMKTan2OFKF
 Ru+xnxZFq1KpSpscPMmai4x/Cqqu6tAB9xnIJiUHcaPFFfjFDpfoCL7xTllbOb+C+WYe
 1MwljO8AfyPwO3S6+biOf2B0EkC639a4A0FjWInVFOd5ph7Oj4kyPJlrJyJv7irSRtgF
 T1vyhxr0fDTJ/lg+w+kVokqSFdTnADn9CUETaEl91RdCgWwg+GaUzTvU2DA4N6HoWlp+
 wZnUOtjjGFi0ila+51g/2F1u6YWz9NfzAIaN5tlvjcF7hciBqW33dekDpwdefvH+kJfu
 KcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712993158; x=1713597958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uHitjs9I6Ovwb1hH2+VS+RBfbChLH/Ni4ahAKQR36gA=;
 b=DMO9vGdZ8HQ+Nayx1/EOGdGehoHtfUTqYtvaxBtyqlqjOi+wJe1WJq3YjbdeVOHFJ5
 8Jz86QqlTOMWXGRV3mDs6TgmbO84y9DlLLsYGSsrp7Xiy9fP5FGi65h/utht4q/hn1MP
 IbUjgarZ5y/dwiKPxKrNFkPYm+xSrZaghkGX96o2ePAl5+N7ll6zvsmq3WASloFg5YuU
 fbXVz+HlOyGPm9okKwhAHL6X7D+PUQXJJK2EKsF3zvGNOpqdXhR16d9DU16SfdQwctD/
 d09RiWYXkGJDZQ0rQ6FLLLp6Mkmo7o0BF0skKEGVDcs68u3n9ODo9rId+6ys4UNBLyaC
 GEwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV21zb20lWKkMdnLQ7x1BpS4cEd2TCmgpZRJC/1ACoB/em40c+vH3zHrxnvPEgm3jcAekSBRFWugqwKcARxJ5fd5M/iVA==
X-Gm-Message-State: AOJu0Yyn2v+VDwVVgdTpPQ/ur1O/DPbo7xFoUdyXw3HBKgaW4KGuAf3j
 a9J75U41I9nkIrNHPXO5gWNZG13mhOyzymsjeEHY+BuRRl5cPhx4
X-Google-Smtp-Source: AGHT+IH/NTNujajgFMfP6kg+DIY4KAjw1FUsGk1F8ZuZpVVk/3FHFhu4Yb/HGTvvL0ECETCAwZeEcg==
X-Received: by 2002:a05:6602:3d6:b0:7d5:f3d4:201c with SMTP id
 g22-20020a05660203d600b007d5f3d4201cmr5331395iov.21.1712993157877; 
 Sat, 13 Apr 2024 00:25:57 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:e858:7d5f:e2dd:57ff])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a5e8808000000b007d5e0b3396esm1499066ioj.55.2024.04.13.00.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Apr 2024 00:25:57 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Joshua Riek <jjriek@verizon.net>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>, Florian Klink <flokli@flokli.de>
Subject: [PATCH] configs: turing-rk1: disable SPI flash by default
Date: Sat, 13 Apr 2024 01:25:36 -0600
Message-ID: <20240413072536.582731-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.43.2
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

While the Turing RK1 board has a pad on the PCB for SPI flash, it is
not populated at the factory: supporting SPI flash boot is a user
modification, not an out-of-the-box feature. The defconfig for this
board should therefore not be enabling the SPI flash image nor SPI
support in the SPL, as it causes confusion among downstream users as to
whether the SPI image needs to be distributed.

Fixes: 153ac950a599 ("board: rockchip: Add the Turing RK1 SoM")
Suggested-by: Florian Klink <flokli@flokli.de>
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Acked-by: Joshua Riek <jjriek@verizon.net>
---
 configs/turing-rk1-rk3588_defconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 07f7b84852..28c3e50ed4 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -8,13 +8,10 @@ CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
 CONFIG_ROCKCHIP_RK3588=y
-CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_TURINGRK1_RK3588=y
 CONFIG_DEBUG_UART_BASE=0xFEBC0000
 CONFIG_DEBUG_UART_CLOCK=24000000
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
@@ -31,8 +28,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -109,7 +104,6 @@ CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_PRODUCT_NUM=0x350b
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

