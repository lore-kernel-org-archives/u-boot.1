Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99099C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 07:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA6F810DC;
	Tue,  4 Mar 2025 08:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="so4VY+lu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2C0810DC; Tue,  4 Mar 2025 08:03:36 +0100 (CET)
Received: from mail.per1cycle.org (unknown [IPv6:2a01:4f8:c013:8d4e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56ECD80FD8
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 08:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0F99E3F9EB; Tue,  4 Mar 2025 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1741071813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mmSouhWV2Mf4MG2KpyePuKyln+Z42A+yS50PrjwLZU=;
 b=so4VY+luuU+T51zXTy557/oRgUEQrwGCHXRpBxJTSLA9cTBiGlYpE9YocUAS3J2WjQ+VUa
 J37LsJmKT4OQfTsXQJKmxh/CGF5qDoQaJlp6ISZ8fUfHb7kJp+q5CHE6h9T2AnsuEdMuaR
 ShHxk2VPXOX0/zve+a+kOZ0jeepKx8HcrhFwfeylUpX/DQEdKau8anxCcwypwo0KoJNF7f
 hWG6G7yVYx83Sw/TRhGJa6acaSaMNyzC0iQX8IFvTeNUCKCKHlzn6+qY8KtVh/vfBIS8WQ
 XQIVoFakB4gKZYaw429i4YN88Wlxu4H/U0SxBg7zNJ/LxumReq20pCsNXYUJSw==
From: Huan Zhou <me@per1cycle.org>
Date: Tue, 04 Mar 2025 15:03:27 +0800
Subject: [PATCH 1/4] riscv: dt-binding: k1: Add reset driver binding
 definition.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-reset-k1-v1-1-dc9510ff1113@per1cycle.org>
References: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
In-Reply-To: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741071809; l=3811;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=qdHGEH77hfGfloyj6MeIHkd2tR+D3xtCtMesRqeUIGM=;
 b=KGbOaJOuaF0Gf0597u+TaFzoIb8UiVlYKzMOHOD2hnd3ttFaKLCS3DGPIsMlF/fZBhb3o0LUc
 hSh3gs4stDgBVgQkzr/SHGLIodhsY/yzZ7hddI6CNqNN3nkbU9gvtDR
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

Add dt-binding for reset driver.
---
 include/dt-bindings/reset/spacemit-k1-reset.h | 118 ++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/include/dt-bindings/reset/spacemit-k1-reset.h b/include/dt-bindings/reset/spacemit-k1-reset.h
new file mode 100644
index 0000000000000000000000000000000000000000..3835b3264a6b4cb3affa0d04690e158f2e385ea2
--- /dev/null
+++ b/include/dt-bindings/reset/spacemit-k1-reset.h
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Spacemit Inc.
+ * Copyright (C) 2025 Huan Zhou <pericycle.cc@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_RESET_SAPCEMIT_K1_H__
+#define __DT_BINDINGS_RESET_SAPCEMIT_K1_H__
+/* APBC */
+#define RESET_UART1   1
+#define RESET_UART2   2
+#define RESET_GPIO    3
+#define RESET_PWM0    4
+#define RESET_PWM1    5
+#define RESET_PWM2    6
+#define RESET_PWM3    7
+#define RESET_PWM4    8
+#define RESET_PWM5    9
+#define RESET_PWM6    10
+#define RESET_PWM7    11
+#define RESET_PWM8    12
+#define RESET_PWM9    13
+#define RESET_PWM10   14
+#define RESET_PWM11   15
+#define RESET_PWM12   16
+#define RESET_PWM13   17
+#define RESET_PWM14   18
+#define RESET_PWM15   19
+#define RESET_PWM16   20
+#define RESET_PWM17   21
+#define RESET_PWM18   22
+#define RESET_PWM19   23
+#define RESET_SSP3    24
+#define RESET_UART3   25
+#define RESET_RTC     26
+#define RESET_TWSI0   27 
+#define RESET_TIMERS1 28
+#define RESET_AIB     29
+#define RESET_TIMERS2 30
+#define RESET_ONEWIRE 31
+#define RESET_SSPA0   32
+#define RESET_SSPA1   33
+#define RESET_DRO     34
+#define RESET_IR      35
+#define RESET_TWSI1   36
+#define RESET_TSEN    37
+#define RESET_TWSI2   38
+#define RESET_TWSI4   39
+#define RESET_TWSI5   40
+#define RESET_TWSI6   41
+#define RESET_TWSI7   42
+#define RESET_TWSI8   43
+#define RESET_IPC_AP2AUD  44
+#define RESET_UART4   45
+#define RESET_UART5   46
+#define RESET_UART6   47
+#define RESET_UART7   48
+#define RESET_UART8   49
+#define RESET_UART9   50
+#define RESET_CAN0    51
+
+/* MPMU */
+#define RESET_WDT     52
+
+/* APMU */
+#define	RESET_JPG        53
+#define	RESET_CSI        54
+#define	RESET_CCIC2_PHY  55
+#define	RESET_CCIC3_PHY  56
+#define	RESET_ISP        57
+#define	RESET_ISP_AHB    58
+#define	RESET_ISP_CI     59
+#define	RESET_ISP_CPP    60
+#define	RESET_LCD        61
+#define	RESET_DSI_ESC    62
+#define	RESET_V2D        63
+#define	RESET_MIPI       64
+#define	RESET_LCD_SPI    65
+#define	RESET_LCD_SPI_BUS  66
+#define	RESET_LCD_SPI_HBUS 67
+#define	RESET_LCD_MCLK     68
+#define	RESET_CCIC_4X      69
+#define	RESET_CCIC1_PHY    70
+#define	RESET_SDH_AXI      71
+#define	RESET_SDH0         72
+#define	RESET_SDH1         73
+#define	RESET_USB_AXI      74
+#define	RESET_USBP1_AXI    75
+#define	RESET_USB3_0       76
+#define	RESET_QSPI         77
+#define	RESET_QSPI_BUS     78
+#define RESET_DMA          79
+#define	RESET_AES          80
+#define	RESET_VPU          81
+#define	RESET_GPU          82
+#define	RESET_SDH2         83
+#define	RESET_MC           84
+#define	RESET_EM_AXI       85
+#define	RESET_EM           86
+#define	RESET_AUDIO_SYS    87
+#define	RESET_HDMI         88
+#define	RESET_PCIE0        89
+#define	RESET_PCIE1        90
+#define	RESET_PCIE2        91
+#define	RESET_EMAC0        92
+#define	RESET_EMAC1        93
+
+/* APBC2 */
+#define	RESET_SEC_UART1    94
+#define	RESET_SEC_SSP2     95
+#define	RESET_SEC_TWSI3    96
+#define	RESET_SEC_RTC      97
+#define	RESET_SEC_TIMERS0  98
+#define	RESET_SEC_KPC      99
+#define	RESET_SEC_GPIO     100
+#define	RESET_NUMBER       101
+
+#endif /* __DT_BINDINGS_RESET_SAPCEMIT_K1_H__ */
\ No newline at end of file

-- 
2.39.5

