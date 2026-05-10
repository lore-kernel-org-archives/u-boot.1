Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C1CCD3447
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 00:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4982484AC9;
	Sun, 10 May 2026 02:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="a+gCmmcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2012184ACF; Sun, 10 May 2026 02:07:48 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BCC84AC9
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 02:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c7b9f54d3deso2061994a12.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778371664; x=1778976464;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v8EG+wATTgZ1GgTkhKsXlRDxaNp+Fmbl2i5Ii64jWdo=;
 b=a+gCmmcg0CcwEbozjnEGw6o6L8sqeKbNeqE6Luf+oyrpgQ5KY80kuJBb1AxIlp+iY1
 3DZuG+4ms7rGCpUWbtZLbH+OYVOOnUjQI8ENTNrUufvP/tA/zVj8kAj/PHlvUMPpnoUh
 yJicfJ9XryQfg24dYenUZm4IHlJU7uShZiP9ChRytpzf0MROO/eklIMzNUIek3QGnbaX
 GfsP/TYqoN12N28VfjiKjjdGh8ssKNEiu6wFEBjoRNC3Pmkpvo0+vzmsBOAH04xCSxIX
 HZh4JVSJP66e/99RERVAO2fohMX8h9eabJMK7Hdb9VJlEM/ByT83jYtMXlrxf7u695wl
 Y8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778371664; x=1778976464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v8EG+wATTgZ1GgTkhKsXlRDxaNp+Fmbl2i5Ii64jWdo=;
 b=Yxgi27i+cYxaHX4Up/5CLsg6EfgYG8a8n7gnlF8cvQR0JiaqITCV0llltUJxHOpw3a
 lPLoIwbfQeL8Al4IcGzwIEigiOVpBEATI6eCOMP6c+yTzVGf3UqTdufaMjzUYE8rF2of
 o148MjabQkOSH+e6W3nIS0E5tJvFkntQYNdevCrAmS5+wSZ8MYD1NoWFigSR89WIzcHW
 viv4uSFIpS99SNt0XcQxgnl0ujX8WhbpiPVClW/YLI7ruWUezFyKrKvtqXAhRG6sZoEU
 kvSk+lXqIRvJJIiKxWvQmcBZkEW5v1/bBl9piQ7TP4SRxQL5s16+nAMnVlit4xxMs93N
 gVCQ==
X-Gm-Message-State: AOJu0YyfM1nwm7VC6PrX6du4AbObqO/ZCMlYnOV6KF1Tuc4AJvHWI7mX
 CxrpKRn80Y49n9xx1KPRulZv9p1eFWv56//XeuHD/iEytZHHDNGkphPL2rlOAgRcMRw=
X-Gm-Gg: Acq92OGMFKmovTut9/dK2mM+G2hGQwmn0CFTivebRZgNEmXOupLIE3osmx5zEYfPMzx
 mP05Cp4Z5gDiuIH1sl99hyMw3MwFd3SWTEqHqZ4VoYj0nxhCk79RskLk4ryO0CEq9EgOpr/RYvP
 fJjAA0ksyClEfB50zOv3VHsH6U410y31gPezQD/FTA4GC25uA89heMSswBTRBsSy2mLJGuqJbYt
 LJ7HxNn8XpLZVXyDQWvJy1jsXXow1ObeVvLt0hKl0bECVZluCqb+eY/NCMkzM/dyWZpi7xpHPRe
 2tPqopZ7LHHpdafVwOPB7vvGl0ApcaCFgBGy/TykYZQ/kE00ifMOxVEZPeItlQQoO07oXvEUxg+
 StBHQZi9D4iz6KO92j2niaeVRVW9QAav2bSngfl52YSONlSsEWuWgX50DDX2Nz6YkjLZrqbLSmP
 9LurSRp8/cBjIYqO2WLB/lq4ljB7IogNEnMkmohdGoLcju+4BE3dlteg==
X-Received: by 2002:a17:902:8bcb:b0:2b4:656b:aeb0 with SMTP id
 d9443c01a7336-2ba7a1fd499mr151266695ad.35.1778371664396; 
 Sat, 09 May 2026 17:07:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d3fee3sm57010625ad.18.2026.05.09.17.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 17:07:44 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 10 May 2026 08:06:30 -0400
Subject: [PATCH 8/8] dt-bindings: reset: drop spacemit-k1-reset.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-b4-k1-clk-reset-upstream-dts-v1-8-db0b0503ee44@riscstar.com>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
In-Reply-To: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

After the K1 build switched to dts/upstream/, all reset IDs come from
the kernel's per-syscon namespace in
<dt-bindings/clock/spacemit,k1-syscon.h>. Remove the legacy U-Boot-only
reset binding header.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 include/dt-bindings/reset/spacemit-k1-reset.h | 118 --------------------------
 1 file changed, 118 deletions(-)

diff --git a/include/dt-bindings/reset/spacemit-k1-reset.h b/include/dt-bindings/reset/spacemit-k1-reset.h
deleted file mode 100644
index 74db58b27ef..00000000000
--- a/include/dt-bindings/reset/spacemit-k1-reset.h
+++ /dev/null
@@ -1,118 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2022 Spacemit Inc.
- * Copyright (C) 2025 Huan Zhou <pericycle.cc@gmail.com>
- */
-
-#ifndef __DT_BINDINGS_RESET_SAPCEMIT_K1_H__
-#define __DT_BINDINGS_RESET_SAPCEMIT_K1_H__
-/* APBC */
-#define	RESET_UART1   1
-#define	RESET_UART2   2
-#define	RESET_GPIO    3
-#define	RESET_PWM0    4
-#define	RESET_PWM1    5
-#define	RESET_PWM2    6
-#define	RESET_PWM3    7
-#define	RESET_PWM4    8
-#define	RESET_PWM5    9
-#define	RESET_PWM6    10
-#define	RESET_PWM7    11
-#define	RESET_PWM8    12
-#define	RESET_PWM9    13
-#define	RESET_PWM10   14
-#define	RESET_PWM11   15
-#define	RESET_PWM12   16
-#define	RESET_PWM13   17
-#define	RESET_PWM14   18
-#define	RESET_PWM15   19
-#define	RESET_PWM16   20
-#define	RESET_PWM17   21
-#define	RESET_PWM18   22
-#define	RESET_PWM19   23
-#define	RESET_SSP3    24
-#define	RESET_UART3   25
-#define	RESET_RTC     26
-#define	RESET_TWSI0   27
-#define	RESET_TIMERS1 28
-#define	RESET_AIB     29
-#define	RESET_TIMERS2 30
-#define	RESET_ONEWIRE 31
-#define	RESET_SSPA0   32
-#define	RESET_SSPA1   33
-#define	RESET_DRO     34
-#define	RESET_IR      35
-#define	RESET_TWSI1   36
-#define	RESET_TSEN    37
-#define	RESET_TWSI2   38
-#define	RESET_TWSI4   39
-#define	RESET_TWSI5   40
-#define	RESET_TWSI6   41
-#define	RESET_TWSI7   42
-#define	RESET_TWSI8   43
-#define	RESET_IPC_AP2AUD  44
-#define	RESET_UART4   45
-#define	RESET_UART5   46
-#define	RESET_UART6   47
-#define	RESET_UART7   48
-#define	RESET_UART8   49
-#define	RESET_UART9   50
-#define	RESET_CAN0    51
-
-/* MPMU */
-#define	RESET_WDT     52
-
-/* APMU */
-#define	RESET_JPG        53
-#define	RESET_CSI        54
-#define	RESET_CCIC2_PHY  55
-#define	RESET_CCIC3_PHY  56
-#define	RESET_ISP        57
-#define	RESET_ISP_AHB    58
-#define	RESET_ISP_CI     59
-#define	RESET_ISP_CPP    60
-#define	RESET_LCD        61
-#define	RESET_DSI_ESC    62
-#define	RESET_V2D        63
-#define	RESET_MIPI       64
-#define	RESET_LCD_SPI    65
-#define	RESET_LCD_SPI_BUS  66
-#define	RESET_LCD_SPI_HBUS 67
-#define	RESET_LCD_MCLK     68
-#define	RESET_CCIC_4X      69
-#define	RESET_CCIC1_PHY    70
-#define	RESET_SDH_AXI      71
-#define	RESET_SDH0         72
-#define	RESET_SDH1         73
-#define	RESET_USB_AXI      74
-#define	RESET_USBP1_AXI    75
-#define	RESET_USB3_0       76
-#define	RESET_QSPI         77
-#define	RESET_QSPI_BUS     78
-#define	RESET_DMA          79
-#define	RESET_AES          80
-#define	RESET_VPU          81
-#define	RESET_GPU          82
-#define	RESET_SDH2         83
-#define	RESET_MC           84
-#define	RESET_EM_AXI       85
-#define	RESET_EM           86
-#define	RESET_AUDIO_SYS    87
-#define	RESET_HDMI         88
-#define	RESET_PCIE0        89
-#define	RESET_PCIE1        90
-#define	RESET_PCIE2        91
-#define	RESET_EMAC0        92
-#define	RESET_EMAC1        93
-
-/* APBC2 */
-#define	RESET_SEC_UART1    94
-#define	RESET_SEC_SSP2     95
-#define	RESET_SEC_TWSI3    96
-#define	RESET_SEC_RTC      97
-#define	RESET_SEC_TIMERS0  98
-#define	RESET_SEC_KPC      99
-#define	RESET_SEC_GPIO     100
-#define	RESET_NUMBER       101
-
-#endif

-- 
2.43.0

