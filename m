Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535D5CD6E60
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944288467E;
	Thu,  4 Jun 2026 01:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F3p8TMWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98ABE8467E; Thu,  4 Jun 2026 01:49:12 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E5283EF9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68bd9bf02aeso14388a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530550; x=1781135350; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uN50UupezHOxKl+v7G8WnnFIs9IiVB8sciGREM+2VHQ=;
 b=F3p8TMWtZRwQAUX/nUxEmIF7dK1hZlmrQjXmWkjmioj8Ua6SP+olfXYnQpM6cxQqXG
 ysFVCAsOT8yzjaa6ft1c3GqaopaG0smsQy2C+glSOJ8e2Nc+Z+kCd8tCyRoOjWrD3Wu7
 zqFaPHrxbvVTqy6+iZ9Vt7CtuAzIIRKL09BejP+qHtIRRh1IREjXuyaeF9mG1mTXKlo2
 jP5HdOaLim4JRE2q+lD2RL4XY18ciCgKnVRZ0zbCROqG2msGuWjqdh2uCVoEYr2M6ApV
 ZZuwMphpX6dek0TA/QyjWFBTT5ioDKxHaIg+mMg/M+uKyn1l5oPsFX9RfAVlYbSBXfRr
 Mtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530550; x=1781135350;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uN50UupezHOxKl+v7G8WnnFIs9IiVB8sciGREM+2VHQ=;
 b=kFXEvB6xg7NnQzbgz/193WJj66YHx2M2k3rMsjftCNetzspcWE8FS3B/dvkdFGPuAS
 vGYY+akNWnWKFozUiCOtAdTxqgB3W7j9Nxc2xT0nP38nP35hKZtmGsgP1Kkc7ApQCz9x
 BTMI7/hIOddCkzdVBzz8dGpwro1Rn2+4npZzmMPwkWk3qvGZFkPCf5VZiFWGTvBfLjtM
 zS1PDl+m+PI6qfy6nN/KW/vl1IHhP9jQ7kdsOGc34b3LP730151463O5HKhZZ0nRO0yC
 BHU43tKVfVgyVDHvnlBRhKFXuP7U+q0WGixf2bcyBBPsg9cpgoG6oemTA2zUKdZhD7q+
 YwYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UOhKLQwiUtLNffxZLKuSFaycls+hBjcMa2pQ+URs2ZCGobIwv4D0hiKGoYsftdM4gSqJLwSs=@lists.denx.de
X-Gm-Message-State: AOJu0YxlXtNQDSI+tAS2AGirp4LtAGhCwR0hWCm3bh/alJv2SZf4/pZV
 O1R35zmcncXD6cc2Nx2ZnrXlYB4e2hK1k7MQq0rKSKTUHOA/QiaAaEGr
X-Gm-Gg: Acq92OES7eW6B7Qzr1/0LE9VSQVWsHb47UYcOKH5JHSLIPbq1tT+w5F7ynxuY/nrVgm
 Hhy/LyGDJYFJKvHkJ/0JJ02ZP7TY3uYOAQAEeJikms0fhgun3+NrTY1bA8dHLtZSpdF0/w6ofSy
 g2qnR5tCKEXbz9cy04YYZ6BJa9ZJE/3f8+pvPLkvOApg1UGHv2dDBCr6sH2j4eR1KqJKjbDNy8/
 qwJjkLxmUGE3pDWcb37Nvjlct2lZT4LIQ118aYlvB+doJyvijCiIzSoLwdLlFnCt5Vcwai671P7
 6rr6t/TGFG8NhKvuWQ40XCaN4ZxcUqldcVq4mT0d+ZS4oGSYyiRnFvez5bGY5MZqsPi9cONanZt
 RrMtdgpyuqPovs5YN6lZU8x+zYk+x5iJexBGgO7TZWfe0P0lnfLyc+XPO/dIuvs1Sa1iD38jxTw
 jXxbNFxht0ak4+buu7EJvpLVlQaE8SNcpydocavxJ7V0LWogcJc02isWt/pFYG6alOZX+pGRgi
X-Received: by 2002:a05:6402:3886:b0:68c:76fb:7e8f with SMTP id
 4fb4d7f45d1cf-68f39814926mr76642a12.0.1780530549978; 
 Wed, 03 Jun 2026 16:49:09 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e6585177bsm1721087a12.19.2026.06.03.16.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:49:08 -0700 (PDT)
Message-ID: <4f7f08c6-cabe-4a7b-8658-5082fff7f417@gmail.com>
Date: Thu, 4 Jun 2026 01:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 01/10] rockchip: configs: compile rk3066 SPL with
 SPL_OF_REAL
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
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
 configs/mk808_defconfig | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index b983128e1def..31b18c529134 100644
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
@@ -65,14 +63,10 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_TPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_OF_DTB_PROPS_REMOVE=y
-CONFIG_SPL_OF_PLATDATA=y
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_TPL_DM=y
-CONFIG_REGMAP=y
-CONFIG_SPL_REGMAP=y
-CONFIG_TPL_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
 CONFIG_TPL_SYSCON=y
--
2.39.5

