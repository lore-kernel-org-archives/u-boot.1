Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EA8CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3C58039B;
	Sun, 31 May 2026 23:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cf2HdAJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7BA84671; Sun, 31 May 2026 23:01:37 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8164280077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68cebf2657cso214597a12.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261295; x=1780866095; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uN50UupezHOxKl+v7G8WnnFIs9IiVB8sciGREM+2VHQ=;
 b=cf2HdAJpQDxqyXwx1oKddFuYjPkGE4qFTAIUF291OGojXoaokaeNMkyCZBDNJKBgCu
 7QsU9Zk+j6L490QwAFGlRxciLEVrMN2HyCTjnUB+1TUdXwxvSs3Immlrt7AaXrHKWEiT
 Y2iqVeGaO8RqyNYBqYfTwOkPSMCWyB5pcJ2mu2SW55lrw7XOl96QamuMAVRmeQoXLzWo
 FUiUK8KxGAwDvrZ+Zzm+xpPiU9JGhMG/rfIk2BKni3sjyUrJBsDHHDbqt6Mpu7DvSPYx
 lPHMBD7FqKFDA9OUfDj87M+g7sltgtK6QdE0sbh+bK7vVr7N+IaoCgmmWx17TITT2saH
 LOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261295; x=1780866095;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uN50UupezHOxKl+v7G8WnnFIs9IiVB8sciGREM+2VHQ=;
 b=lJG+SCCSH8rKdIJMjW9u6J6j/ceSEqb0IaTvAOj4VCB8i8FVZpMS+A2vGw4Etfg7s0
 TefLT6YtSs9tKmP3HF6vrZLLzMlhDmPXIC2crgZKSbzHrHf+CLY2mXwAUilcn9IESExo
 NmshfcrGLofPY2Ddzhs/fRMYgewdW7slbyDye+VE7OBYR4jw2o1fjMDQtVOtt8UzO0l9
 nficQ0UuFQRrQdcEHzi2XyDO0BxIIwPNS5VyQ9DZCv7UJBqvae8qDFRV6EFH3jBaPh4r
 5XthMmSn8zSwnYkPZaGkVkHWTpgkc9D5lm6VoNZ3Jvi0t3JHc9YTDQQjMqwJ6L5M+XMr
 k2Qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GMkleN1Of2AMwY5P/5B2Yd4U3X4nRZqjjcbNl9Zdka2kQiFnBxqJgOVUcL/KoH9pL/ObgTxM=@lists.denx.de
X-Gm-Message-State: AOJu0YyWfefRMawc4RTjsUFrKWsttMPFmU2CPLs5fsqV5/aXUIHfrnhW
 FNy8qDn3KcvCOAue+jQ0OW6yhl53LyvZF+kKknvpRYaAFbLw7mFjHdp5
X-Gm-Gg: Acq92OFpfXXe4AxxaKctt+KvRzg/nqGxu0CIgiHRLmeLUh5pg1r1OaKtegUikAK0Mdh
 zE/gd61p4Chgka0SYWtFI2ZobSRFl3wtrAHPbwn03k6/r0CtydBYO7o0VYdImXipu6BueYr5Ohp
 nly1VIethmWAJ+oYvHtSnrT+SaMAwQUU78/qk4VmZeAd8SWRZp0SI9do6XKmVyTPqJGApwTorDj
 +ts2V39zFunIYx9UGvVLwVlkAbQAIRbf+KQ1dLJ1JwYkkljWHsAKAjMRYgigUfwqx9jjaUx8mWx
 lTfxcde10FJEUTQPB+m38RKRlVW0ZvoaYNWAYNXUICXcJyL+NOHHxLqWWa247T74PMtfWKmlcwj
 WSSy7wbrrUI2fcf5MIPCyAQmux2OnTYc78daTmjmIDlZtJkrIHndLjWzeszNk6fQQG2qsvKZRYR
 bGfBpB31KgSocRWozaFpDXpQwpzl5V0/MwA3OAjIdEhrzdVXvLFwcpnQ3AouK5uN6FpMd/GbOB
X-Received: by 2002:a05:6402:2112:b0:680:ddba:c435 with SMTP id
 4fb4d7f45d1cf-68c8ac28ca9mr1767070a12.8.1780261294828; 
 Sun, 31 May 2026 14:01:34 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-be9d5cd8043sm262788466b.33.2026.05.31.14.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:01:33 -0700 (PDT)
Message-ID: <69037016-773a-41c1-8143-9ffb25dae5cf@gmail.com>
Date: Sun, 31 May 2026 23:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 01/12] rockchip: configs: compile rk3066 SPL with
 SPL_OF_REAL
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
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

