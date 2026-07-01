Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193F6C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7668984C10;
	Wed,  1 Jul 2026 19:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ff6uOrNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609D984AE9; Wed,  1 Jul 2026 19:58:19 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C4C3843B6
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c9a20f70263so443841a12.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782928695; x=1783533495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ewv8BbgaJM+t6gW1+XsEtgnyEocUyJSwTvoVRt+UHKk=;
 b=Ff6uOrNLrYvDrgOMYqJaEJrO4uw0OHf8JeZdHv/w30JOT/zch+bIyjRQzLsQrvKMEx
 LDWnkLJBX1An5YO3mo4owH+wc0L8piYQgHIRnOQNNvgvvfK6w5w/wpbtMFONu93QeAP7
 kRXnAl41VoZjwO2O8sX5gLIKaX1UZ0/+MPgwNbUbYi/PsFILo1NXH6Hz36BiaC7TUtMJ
 3ZPfAPn/+s5VoS9Qe0cjauwUJia479TmImZkGuH+LPtetP7P8ucoW7hklVNNAH+hHA80
 XQ7XnCi3Aowj2JmJ+rdfRzeWQTTCYtnLe9a61XK06TKGEFhgcRcAZt3Uwa2rvjX9CV1u
 6OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928695; x=1783533495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ewv8BbgaJM+t6gW1+XsEtgnyEocUyJSwTvoVRt+UHKk=;
 b=LdocEwg3ZhKGPpQjgpcZnaIEhPDqF+OWRHMEw9V30q8wsUcRdBsIDAe2ntBemXcZ6M
 Po9IIdOXWn/eTj+Ha90/rubIKMd5a7cVO7Vg7KWK35aUg1jdnH7lEsAucx+SH2iaD+uF
 A3VTGp5OTEe6XiHxq9+qdf1jIqT2PWWYrswXx36ZUOoojh4s0EBlJFMAs7VoSr3/TT5z
 FbQmFmHZYE/OHWowdD3ksFntdNNWcbjdQyYarfo6ONJdvkV2HluBGCCxIRDayMbyp9pV
 ShBMZbCfp9rU/HPZry6sZkPKQW7mP64/MnBZqZx/bWBjnWf/L2K8T22NkfvFaRuLk82U
 o3Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mlOYfxY2dSByEF6IHHz21v+f+dyu99iqnTq+nvTTcYlr1dPJrthZmiurMGoEudp8A39G42fk=@lists.denx.de
X-Gm-Message-State: AOJu0YyqtIaRqX+VGlUOGmshEF8Ow3cLaRkdj0+Fl1xiZbczAwcp4eJF
 xMkcflg4zUA/qlhvEWltWaAKtmyZpnVJTJHc7LuZuO9hZkEkk8+L8YhSqyGZ3g==
X-Gm-Gg: AfdE7cmBJqWULUvUf+K2/l0JSuS3cOU78MlEKYtBHvYuK8yQIhXck8OwgrKhVkUyWoU
 m6Hu/ZsEJLF0Nrekd5Z00VJRPfuofRvlk399+NKazgItTb7JZYG2YfkE583vXH3dwDq4SP6Pc5s
 s7c7CDkR5M9EehqH/fjq4EReusqOpL3wE29Dc8uxY/wWlh3ckcYk8ac7X1GlInZhYNrw/Rm0LOd
 jpTbJ2qx3lNDrEITOBNA35SpmqzNhQkjyJjhuhf6ganTRGE2TQs76ab9AAL0LJUE2rRVNwAWqYY
 hcyS+zg+5to7SKiyzAf0+fhaOaF/KJyihOX4xIPwgpxSguQnEGuG4knt40ScjMGMwTVsN99213m
 7trYETElDcuzjasYRfbzma1zm+94JTSoPGD1BgoDUPflsnknHT/fMjoE/Y7ThB3YEvsdv4880Wc
 weH9Qp1fwbg1Us+IUR7ishhu0/MdhZC70W7rm4RIL7eUgRshK0xkD0xDYIQgk=
X-Received: by 2002:a05:6a21:6e84:b0:3bf:aa54:4cbc with SMTP id
 adf61e73a8af0-3bfd2871224mr6579985637.26.1782928695463; 
 Wed, 01 Jul 2026 10:58:15 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:5116:3bae:12e8:a7c9:dab9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm63078eec.27.2026.07.01.10.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:58:14 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 1/5] roc-pc-rk3399: Enable redundant SPI flash environment
Date: Wed,  1 Jul 2026 14:57:56 -0300
Message-ID: <20260701175800.40141-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Enable redundant environment storage in the SPI NOR flash by enabling
CONFIG_ENV_REDUNDANT and defining CONFIG_ENV_OFFSET_REDUND.

Move the primary environment to 0x3f0000 and place the redundant copy
at 0x3f8000, matching the existing SPI NOR layout.

Having two copies of the environment improves robustness against
power loss or interrupted writes and is useful for software update
frameworks such as SWUpdate that modify the U-Boot environment during
system updates.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Use CONFIG_ENV_OFFSET=0x3F0000 and CONFIG_ENV_OFFSET_REDUND=0x3F8000.

 configs/roc-pc-rk3399_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 1df5cb03adbb..c7cbe8ec34b3 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -7,6 +7,6 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x8000
-CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_ENV_OFFSET=0x3F0000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc"
 CONFIG_DM_RESET=y
@@ -17,6 +17,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x3F8000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
@@ -39,6 +40,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-- 
2.43.0
