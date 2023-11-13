Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022C1C05021
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 11:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A56E8708B;
	Mon, 13 Nov 2023 12:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="2SxOUXq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2653287091; Mon, 13 Nov 2023 12:24:21 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3660F86DCE
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 12:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so33752485e9.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 03:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699874657; x=1700479457;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/+J7dDoC5WXMA4VaUKrjq5q9AOGW8vgNNvmsM998PY=;
 b=2SxOUXq94CmjLlWU8gTpPgYv/kezNit4CxDNLhq+TAPc4zzIa6Ppf5eq5OYFzIf5UJ
 JAx8Mr2EiRKHwX/IKrYNDGT8xLJVfyxU2JbDWsqPn5iL+O0YNebAHeGDiLeH3PpHhl5A
 MFHBoNCzemdVkfIQRO7e2NuAMHJvLanyTAZuu2AR34wtMe0cxsCF/OCrGN9JN8XV99a3
 yHgAQDkppqQfatULED5kBaoagPzUWJ88cJui79FB5oaRlk/3V1J2t6V2fRCIzrZnVtUl
 UREB1Q3drJ5gkIOo9yuJG7slfYzQhDKgmEab4nYsNh7WvlpwyraAA17FOXImVwM5RX/f
 X2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699874657; x=1700479457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/+J7dDoC5WXMA4VaUKrjq5q9AOGW8vgNNvmsM998PY=;
 b=bfL3U4343H9rh5p+BdXUMhfXcvgU1h6GenK+s3WOokHt9+51YT3kXSX12kgri4CFVZ
 LcirMFFYc9YtQPPW2SluxfE/HVG5xzt7HR2TvjqCKcyQjG6r94rfXAUJLuhQM3pOWzaH
 J64DYVgEZMhsI+S+hFN8cb2rWeSMIAWuDh59ybNnvMVIc+AK1m908j06u2TWlnISUoEk
 HsBY/BNDFJxWrTLga8CLdOT9BJYA5c2KSOFoN279O4IP3lLIaKT07MbobHohWd3qnyG8
 Afa+6/VFfNCNyfbmqboikWG2KDTbYaIQJFEsakdsbzQBVrKEaBmT9t58R17sVk0kIgEP
 1+QQ==
X-Gm-Message-State: AOJu0Yx3/rfUGw7P6xe45Url3PwThtYoBPvGWgk6++8M/MvfNfG8iJPc
 3Yl98BlNVd1tP+3HyXIs2EKR8/HRMYDJm5x40HEfghay
X-Google-Smtp-Source: AGHT+IGUsgRkSS40txUVAGoihjyjDpDBMe3Tz0EvpFIW+Qz75Jp598bR8/+YNV1kubANhmEENCY7WA==
X-Received: by 2002:a05:600c:458a:b0:40a:4607:5f68 with SMTP id
 r10-20020a05600c458a00b0040a46075f68mr4915744wmo.22.1699874657390; 
 Mon, 13 Nov 2023 03:24:17 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 d14-20020a05600c34ce00b00406443c8b4fsm13532581wmq.19.2023.11.13.03.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 03:24:17 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jagan@amarulasolutions.com, akash@openedev.com,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
Date: Mon, 13 Nov 2023 11:23:09 +0000
Message-Id: <20231113112309.730323-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
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

Add smbios information for Pine64 RockPro64 board and enable in
config

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 Changes 
 v4: Change PINE64 to Pine64
 v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig

 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 ++++++++++++++++++++++
 configs/rockpro64-rk3399_defconfig        |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
index 732727d9b0..089732524a 100644
--- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
@@ -9,6 +9,28 @@
 	chosen {
 		u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
 	};
+
+        smbios {
+                compatible = "u-boot,sysinfo-smbios";
+                smbios {
+                        system {
+                                manufacturer = "Pine64";
+                                product = "RockPro64";
+                        };
+
+                        baseboard {
+                                manufacturer = "Pine64";
+                                product = "RockPro64";
+                        };
+
+                        chassis {
+                                manufacturer = "Pine64";
+                                product = "RockPro64";
+                        };
+                };
+        };
+
+
 };
 
 &sdhci {
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 4cd6b76665..affb6137e0 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -90,6 +90,8 @@ CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.40.1

