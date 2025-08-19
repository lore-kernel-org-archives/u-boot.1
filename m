Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58493CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 15:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 390D582E67;
	Tue, 19 Aug 2025 17:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AO0Qv8PD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A1882E67; Tue, 19 Aug 2025 17:40:37 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049278211F
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 17:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-435de764e08so3315977b6e.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755618034; x=1756222834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wzk84OBxW0YbU/J4rIDhc4rEfjSwjbXzzgRnqBcKxCg=;
 b=AO0Qv8PDVwfE8mZTM2A5zaT91fllxaPVjuMCw0dX8bkohbnZ9H3CaNipB5wwGL05u3
 cSXkE/QYRjm/HJyzxyH8OCqpY9PWyLolUvNQo0y9F/32m3shU61BfIbsWF1oQwep2W0q
 I6tHIsGSc98izDuSPx6QuSQ4sPBQU/ERCFgLT6Mgekip/+pxFn2pxlAoicwm8xzXQZCV
 jqrRQiXckICAPxB6K1vCyHjRvwRqBVuVuAqhsO7fr77QP07+HDteqiX7g21QCfs5LgZD
 vD8nbqjWwInJ0/CMfGtt7/lZ8NAWk+5+k1pxPe33YqjIuaBMLeTaMAx+PWxPzo4uiTV+
 N/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755618034; x=1756222834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wzk84OBxW0YbU/J4rIDhc4rEfjSwjbXzzgRnqBcKxCg=;
 b=KgS3j5ASzU/X6Iu2fR/FFiit6LyNGqLBBSG+KWdObz/E9r+9zwxiSqo5bknC4Eqc8d
 sXDDd4Zhk0D1LwdxJGpp3gHI9DNFRTUClwISNRHoesGp2CY6RvRHkZNOlJaAKl7RoPfx
 mc4LF9WxT5kD5R7ywzuRxYbLax+I8PGZLVZs3W6+Io2oUQdeMFjHc6Y4Vf5QdIrIgbxx
 N3FTRUdIsP5kF3FHSIVNtSOxMoZIbOq5ops5oEfLiHk5VcHFjoXQZ9EJMLywZnFiC5wO
 cz77TqkVbo/ClxUI3022/AgSMjiNcD0x3pYLZbw24r5fwL66EciXfllocATPebUU63Kv
 qeTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX+I0B84nMQNu9dFQ9wV4Z5OO473VNw3xx4GhPYSrwWFi+LjqdbyjgJsnsaLGScFZ6PwAYRAU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3l2RrVA6xmFedw/zOkP+Q41MEXMPBP7KfQeKWOKaugh9Z+2qc
 PxYCZvnx0IcxhBJFMROTAjZJV5zLDZ0IcdR8eJurw4f//FvDHebRLjjD
X-Gm-Gg: ASbGnctv+Vd3Aj6hqwu09pW6Q7Whkzcqe2H+PVxN8LxNweTQqquy2jhmiWaxOn+jfAk
 ACvsqcKN4pkEslp41NiK7JGqU9/xyyqn3XXfhmVXbGjiy6w/xrghaxYjC4uI2/n/f5F6+El0ihw
 r5CwZ6CFYHXoegFTqYJaEdBVjm1eUWiMamcFBZEJ1vjtAdsnLhnp65j0qO6R0gcxaXNE+JQ289Q
 ozg0+9+BLOsBBOEHWqu750fSR4vQAOTkiUOpToxM7geFhNhxpvmOKHmZXSlcG94M4o9H5ay4Igf
 8AtdCVzUQ9VSFVjaa+em30vwplhHARTbkl9wTvTG0qZgU6TwYgN5tgr71+4LFa9ZoRbdBGH2UI5
 uTxVTkiaa06YCYi658DEPAs7P7uCPbOiJC9UdM63TYiFNlw==
X-Google-Smtp-Source: AGHT+IGmKPPYvh0zXrrGgVfRKl9N75B2jQcqLsrmeKcfZTcwN45m+Dfh+0p0xm3/wCuCwCSBXXCsdQ==
X-Received: by 2002:a05:6808:1920:b0:435:7126:fc7f with SMTP id
 5614622812f47-436da1e9cc0mr1462754b6e.18.1755618033635; 
 Tue, 19 Aug 2025 08:40:33 -0700 (PDT)
Received: from cypher.home.roving-it.com.com ([4.31.143.193])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-435ed2054fcsm2323107b6e.31.2025.08.19.08.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:40:32 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>,
 u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 2/2] p3450: fix Jetson Nano SPI flash
Date: Tue, 19 Aug 2025 16:40:14 +0100
Message-ID: <20250819154025.604784-2-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819154025.604784-1-pbrobinson@gmail.com>
References: <20250819154025.604784-1-pbrobinson@gmail.com>
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

The Nano's SPI flash stopped working in U-Boot, as the
prior stage loaded U-Boot, the only thing it was used
for was save/loading env vars so update the DT so it
can now initialise it. It also drops enabling the old
TEGRA114_SPI driver, as the flash hangs off the faster
TEGRA210_QSPI interface, nothing on the Nano uses the
old interface by default so it's surplus.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/dts/tegra210-p3450-0000.dts | 9 ++++++++-
 arch/arm/dts/tegra210.dtsi           | 6 +++---
 configs/p3450-0000_defconfig         | 1 -
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/tegra210-p3450-0000.dts b/arch/arm/dts/tegra210-p3450-0000.dts
index 9ef744ac8b0..ddeeb232de2 100644
--- a/arch/arm/dts/tegra210-p3450-0000.dts
+++ b/arch/arm/dts/tegra210-p3450-0000.dts
@@ -124,7 +124,14 @@
 
 	spi@70410000 {
 		status = "okay";
-		spi-max-frequency = <80000000>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <104000000>;
+			spi-tx-bus-width = <2>;
+			spi-rx-bus-width = <2>;
+		};
 	};
 
 	usb@7d000000 {
diff --git a/arch/arm/dts/tegra210.dtsi b/arch/arm/dts/tegra210.dtsi
index 28ecd2b467a..6dd8fe26c38 100644
--- a/arch/arm/dts/tegra210.dtsi
+++ b/arch/arm/dts/tegra210.dtsi
@@ -762,10 +762,10 @@
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car TEGRA210_CLK_QSPI>;
-		clock-names = "qspi";
+		clocks = <&tegra_car TEGRA210_CLK_QSPI>,
+			<&tegra_car TEGRA210_CLK_QSPI_PM>;
+		clock-names = "qspi", "qspi_out";
 		resets = <&tegra_car 211>;
-		reset-names = "qspi";
 		dmas = <&apbdma 5>, <&apbdma 5>;
 		dma-names = "rx", "tx";
 		status = "disabled";
diff --git a/configs/p3450-0000_defconfig b/configs/p3450-0000_defconfig
index 518ed6b37a2..3b4b863100f 100644
--- a/configs/p3450-0000_defconfig
+++ b/configs/p3450-0000_defconfig
@@ -61,7 +61,6 @@ CONFIG_RTL8169=y
 CONFIG_NVME_PCI=y
 CONFIG_PCI_TEGRA=y
 CONFIG_SYS_NS16550=y
-CONFIG_TEGRA114_SPI=y
 CONFIG_TEGRA210_QSPI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.50.1

