Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F34C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 19:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F25F881F4D;
	Fri, 14 Mar 2025 20:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WSh5IA61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9971681F4E; Fri, 14 Mar 2025 20:00:18 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC2C80F9A
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 20:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948021a45so542935e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741978816; x=1742583616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ICQqNFwxmp1QbkWF70VVLWMfzJY6GtsrlBNQE76TDks=;
 b=WSh5IA61grOH+Nfbxh7QW9z+m0yebFJs9OXsuC4Q7gq6WhDzTS445RFmEGhkkW4SIn
 ESwFpRTTphQ+ZPG6ue3IasWaYksak+S0GUJztsVzeVSU5FXDgLMRpuyGxmjQ5eI3t/37
 qhTf7S/zOo/AcGcZwTIzQays0JRBFKkd1WtCa1t/HU1S97mZD601x1DfhZ8o32ShY4G+
 7KejZP+EeJsSKGTQ37iSkCDFBp3CBdyMviD43C28xg1oM8MSRURWEMsivt6f0E9s/6ir
 xSTCe5oEUEp0yog51GWj7mvBTHwCqsjtyrJ6nZO1/dGxPPDyM1RFZiLrG/8osDGCpVgm
 P7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741978816; x=1742583616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ICQqNFwxmp1QbkWF70VVLWMfzJY6GtsrlBNQE76TDks=;
 b=V91dD4TQo12U6QExckp+m8F6zswM5AOs4OfjbMoUXHfrU85Zdmm81ylT1z4eVyk/ob
 fjAeE9uAB9/3IsTNTOaluHUGQWNroFhvMRtEZHz8ODrlRpO+MtwN8VlNK5u2j5Bk7oYN
 VFFCjPo8f9dlrXdLjJNq60I/ldSO/1RK8o5AsgDzG32sMIJMsjBwdqSW1+ha7CEbaKUw
 RiQr4rgveBDE4zeJr2SH9QPF46Z+lrgs9D3lkT2d+lM+sfR/+2xiqdH0uXj7oV5mLPZI
 Ng046sRmHwB8PGKsIRLu3Y4sl2b1S60EyIW1s8j13oFHiqqJWN3jbqY6FW946ew99Q5O
 AUoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/EV4yd4XhTVgwnA2GYnbMEk8ty78RVhJ4HeM/ivF7hqqv3z5fahIvboKlWqbxyIOegosPhtU=@lists.denx.de
X-Gm-Message-State: AOJu0YyOa1UvrbBRp7jBv84/YngKUGW6SA9fVlnCAyGTw1Z46ehHEibD
 ju+18vZdSdRmeu5hDldXnQlLBwOiI81lUV7KPqkS6/46Al116ZoE
X-Gm-Gg: ASbGncszO8+LBbZhS6z5FLjirExIBFSBY1BligjQV4xCU8ydwHNE/T0KKvusE1iw++k
 AKaGuQMSZuoTg/4zGD4wj5WsUptwjaDC2qOLr3hxZL/6QEoNhistkTn3ibNWC96/LxOjT2D/zJa
 E5T7fbbZy9YM6a2nS2Ndk2690It7fIRLwiMM8b98vNQXico+vLbVpM9g7TVbbqiwTTQX3v68lo2
 QBSn5MeSPxUJUIZNAN/1OK2n1wevE/xt0OVfjpsjKHh8+4HZnF/uHuGRzBKwdYnFt9nQW9a0Nhg
 SmLEMkTJitPkvg0Fxi7Af6ernRZNeSx0SnMmXf5OiWEtfWQ3jAvmExHm9TM0e0KLv0SRPOiRuYq
 ASUkWkUa+cMNh9w==
X-Google-Smtp-Source: AGHT+IH5dxhzm1zqVycl4WKxOtfo2uBjdM/4tdUgQWPAV4jCXc33yVzeM2pIazPSQRuUSCTHt8Vg1Q==
X-Received: by 2002:a05:600c:3399:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-43d2230311bmr33490605e9.0.1741978815584; 
 Fri, 14 Mar 2025 12:00:15 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm25547965e9.17.2025.03.14.12.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 12:00:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/6] airoha: Add initial support AN7581
Date: Fri, 14 Mar 2025 19:59:20 +0100
Message-ID: <20250314185941.27834-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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

This little series adds initial support for Airoha AN7581 SoC.

With the help of some backport patch, this use OF_UPSTREAM
directly.

Posting this to have the targer and the very basic driver.

Ethernet, SNAND and eMMC support is already ready downstream
and will be posted shortly after this gets approved.

Having the first driver ready permits to separately push
dedicate series for SNAND, eMMC and Ethrnet as they all depends
on basic support of clock and reset and nothing else.

Changes v2:
- Use OF_UPSTREAM directly
- Backport some patch for OF_UPSTREAM
- Make use of u-boot.dtsi files
- Fix defconfig
- Use pattern for MAINTAINERS file
- Correctly handle SYS_BOARD/SYS_CONFIG_NAME
- Drop config for header file

Christian Marangi (6):
  airoha: Add initial support for Airoha AN7581 SoC
  clk: airoha: Add support for Airoha AN7581 SoC clock
  reset: airoha: Add driver for controlling reset line of AN7581
  arm64: dts: airoha: en7581: Add Clock Controller node
  dt-bindings: clock: drop NUM_CLOCKS define for EN7581
  dt-bindings: clock: add ID for eMMC for EN7581

 arch/arm/Kconfig                              |   9 +
 arch/arm/Makefile                             |   1 +
 arch/arm/dts/an7581-u-boot.dtsi               |  18 +
 arch/arm/dts/en7581-evb-u-boot.dtsi           |  11 +
 arch/arm/mach-airoha/Kconfig                  |  32 ++
 arch/arm/mach-airoha/Makefile                 |   5 +
 arch/arm/mach-airoha/an7581/Makefile          |   3 +
 arch/arm/mach-airoha/an7581/init.c            |  47 ++
 arch/arm/mach-airoha/cpu.c                    |  20 +
 board/airoha/an7581/MAINTAINERS               |   5 +
 board/airoha/an7581/Makefile                  |   3 +
 board/airoha/an7581/an7581_rfb.c              |  16 +
 configs/an7581_evb_defconfig                  |  78 +++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/airoha/Makefile                   |   3 +
 drivers/clk/airoha/clk-airoha.c               | 454 ++++++++++++++++++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-airoha.c                  | 173 +++++++
 .../include/dt-bindings/clock/en7523-clk.h    |   2 +-
 dts/upstream/src/arm64/airoha/en7581.dtsi     |   8 +
 include/configs/an7581.h                      |  19 +
 22 files changed, 915 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/an7581-u-boot.dtsi
 create mode 100644 arch/arm/dts/en7581-evb-u-boot.dtsi
 create mode 100644 arch/arm/mach-airoha/Kconfig
 create mode 100644 arch/arm/mach-airoha/Makefile
 create mode 100644 arch/arm/mach-airoha/an7581/Makefile
 create mode 100644 arch/arm/mach-airoha/an7581/init.c
 create mode 100644 arch/arm/mach-airoha/cpu.c
 create mode 100644 board/airoha/an7581/MAINTAINERS
 create mode 100644 board/airoha/an7581/Makefile
 create mode 100644 board/airoha/an7581/an7581_rfb.c
 create mode 100644 configs/an7581_evb_defconfig
 create mode 100644 drivers/clk/airoha/Makefile
 create mode 100644 drivers/clk/airoha/clk-airoha.c
 create mode 100644 drivers/reset/reset-airoha.c
 create mode 100644 include/configs/an7581.h

-- 
2.48.1

