Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DB4CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA72D848DC;
	Tue, 26 May 2026 16:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="X8Q3v1IV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4058B848DC; Tue, 26 May 2026 16:48:04 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2BC78484F
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c7980c060cfso4392461a12.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779806880; x=1780411680;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/UUNPA4Lj3C1uj4yeRsph5IZJ+DDIVT1o96C1DPFxP0=;
 b=X8Q3v1IVa3+94jaGL8B/Xu12+qYU2hQ1OdzAa52MWCvoxHoJEyZY/gsKrwnSPr2sg4
 KTZPHf85dBjxdXykJmT+LWmZqy4CeQeblCmxVemh8FzXY8prOw9ned2pZGVaSCJxSYlq
 iPveJbjOE5BXi0bweeWvn2e3P7JY1y2ZIGQh8II079+aGOEzbXQPffkdbU5tFuGq6JFC
 el4On4NJ8spUO9hXWwT2d57bG4bqm6uRULuV5VytX6WYRI/RuMPfvpvJfzSYFv63NHzB
 n4z+qOp+Bv1kuTrHA5qIWb1h7xvVzFqMVOvmepm5KcyMN7JjAAPz7FIcULnsK6J6W4xS
 u2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806880; x=1780411680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/UUNPA4Lj3C1uj4yeRsph5IZJ+DDIVT1o96C1DPFxP0=;
 b=OkH/vGTK7572E9+AhSpwkRdpCI2nm0X0gnVQwGDZaezNZ/nGyG8ycsO14GEe4MjKvx
 XDxwoK0Nfo8NA5/fab+CcsDC18nRx9NPeVuEhUpqW+w5MwNeqL9nJhX1eFkIzFxd02B/
 /H8ziBjRgP3iIuyUv5bnynPdPrK3CKX8bpujCAmUK/pZ+P/0ngiTL6PeQw86cBhx5c12
 G6ITMx6b4WnOruzVH9Nl+cWOgAfqk+aXkqJbcxa7wqHduwucy4QcWzdWhl3Hy50GFID9
 hGrELz/RjrKWfi25X13puwaf1L+0WroCUQrkAC/9kQ7PcXbdqc6VZ1JEl+z+QmsulqJ2
 cQvw==
X-Gm-Message-State: AOJu0YwubYNvMzSPrvDDsvLSnt4xWZ8c1FMsQSekB1kSN0R5X2Khyv/G
 WrV8hU8ZoqyniYJxTpS1j61AFE0F6KOyGxzB7qwMOK52gwkaY3TNCE2s3oilCjCQ9mU=
X-Gm-Gg: Acq92OE2SP345O/RSyCos85vB1932PVmfK4qrgY0T8CARGasp1WXQAE0cp81FIEOf4X
 +pS56Yov9oezVZh3//HeTFQgq73U1fcm6hg72qUO0U+PAl+R6QUs7/N2Ie9Uj7cMV+mwLYNrBvl
 sY9wJ7xADYGnG+j1nc0Y9wLID/1gVYK6n3KXDhuUPxXNjYhrXBn6ALTpp9Veaib29MgQxa39NHu
 +Li99BPsvdpeMyMbYPegsUtPKwG4IZdL3y73+XFKOSl8OZPq1XpMdVjmOWFv0gsbGb7OZLL63Sa
 1NhdRq/XSTCqrSFZogpyvaCY+07fNnDOtceBUX24oFHgXZLwsuUmP+wiKElxfT2m8xUUWwhx/cx
 FjmG3jQSSUFPnwbpjcCw+jTeXoz3RV4eCGUI4kqAAEV/46dpD2/HKvBJLwsyqw2PTGZuoPQhGhw
 mYCV4T+/LbnNYhSIWNZ9iAOGq0mBgRq6WP+5uCkKFqc2U+F0wGN+wb0A==
X-Received: by 2002:a17:902:ceca:b0:2b4:604c:ec6f with SMTP id
 d9443c01a7336-2beb069853bmr208151755ad.32.1779806880248; 
 Tue, 26 May 2026 07:48:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f4343sm169559915ad.36.2026.05.26.07.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:47:59 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 26 May 2026 22:45:48 -0400
Subject: [PATCH v2 8/8] dt-bindings: reset: drop spacemit-k1-reset.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-k1-clk-reset-upstream-dts-v2-8-af815e362b0c@riscstar.com>
References: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
In-Reply-To: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
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
 Vincent Legoll <legoll@online.fr>, Guodong Xu <docularxu@outlook.com>, 
 Guodong Xu <guodong@riscstar.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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
v2: No change.
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

