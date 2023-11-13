Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3FCC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 10:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F1F86D4C;
	Mon, 13 Nov 2023 11:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="bSYD/3Kh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C4686D82; Mon, 13 Nov 2023 11:02:43 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC59E86B2E
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 11:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5094cb3a036so5813162e87.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 02:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699869761; x=1700474561;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvS1qYpZLAax1NPjqKb36L/9NCp4Jb7UMjvNqI78XMU=;
 b=bSYD/3Kh9FMAgZ3Eh9NPJRAQf3sgt6FpwJ0SEoem221iw+roK4jhGoJfBwCQDEciWu
 cJbEAN4J4EPE7eo90NP8oQSvuCRg7jsXhoMIWooQ8IcyZqQC6MbnYbJoFGF+IRuLzQIm
 ZSNXpCU+HaHWpxE43KIgWfvkbSwTB/Rm6GhXqd3dNENKvjPo1Ej/8vNLa+G6xfFXG+Ys
 EPY8TwlKSzVdccLhBtI1lib4xHRWEy8LnHcVk9/M/0h4twcahpyymcj12Aqr74T6HPvp
 vSpILptoqQZ5ulWJImZB1kCtLrnk4AsvZTWXiiGXbTQG/666DkbxNxL8m7AsFRp5UGXV
 dF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699869761; x=1700474561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvS1qYpZLAax1NPjqKb36L/9NCp4Jb7UMjvNqI78XMU=;
 b=Cuy0zGSs3RjHW5Ghccxm4XcplCVHDibVu49tViUhAmcPitqIeCOOCRNUwjbVRjyZi2
 9om0rP+oEY1ByZKGVibGog0vFA0cDMOslrhIMlIXzr2mjGkHFasEbMyvkhZPqoK3HhaZ
 vb+VD7jnDYJY7jv1vQTuKFu3RNE77WpT5OblEl6lbq9y76TjgtJQNBjTMR1HweTKrX0N
 HIZJx1LvlJXvVUpNGfS/+JqK3wHwRhXPhx+La00Q7zv5j5eyDHrMwokejyR6Gvyt975r
 Ww2vLr803eFfTaCA099F43R8mbrVTKrYEE7c5kUKG4K1LAJnDODYi0W5+cMc1yAojfZn
 2RxQ==
X-Gm-Message-State: AOJu0YyqG4CdBIVRLxyx8mfWsasYqBTpe8WSa7xtHajW5fsqfCJvNbd1
 N9tVr5Sq9XQC6x0WdIZuwA3XNNSJ/nScc3/iH7Si678z
X-Google-Smtp-Source: AGHT+IGSNaz9CzmOmS/lfalLL6JEZrYI81WjZ6U1Z4HjKQ8Z95a84crmd2G6Lz5vN3e0Tkggv9nHEg==
X-Received: by 2002:a05:6512:23a9:b0:507:9e6c:e165 with SMTP id
 c41-20020a05651223a900b005079e6ce165mr5104403lfv.50.1699869760677; 
 Mon, 13 Nov 2023 02:02:40 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 j21-20020a05600c1c1500b003fee567235bsm9955613wms.1.2023.11.13.02.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 02:02:40 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, agan@amarulasolutions.com, akash@openedev.com,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v3] arm: dts: rockpro64: Add RockPro64 smbios
Date: Mon, 13 Nov 2023 10:01:28 +0000
Message-Id: <20231113100128.710860-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231110235806.525529-1-i@shantur.com>
References: <20231110235806.525529-1-i@shantur.com>
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
 Changes v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig

 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 ++++++++++++++++++++++
 configs/rockpro64-rk3399_defconfig        |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
index 732727d9b0..a4453e76f6 100644
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
+                                manufacturer = "PINE64";
+                                product = "RockPro64";
+                        };
+
+                        baseboard {
+                                manufacturer = "PINE64";
+                                product = "RockPro64";
+                        };
+
+                        chassis {
+                                manufacturer = "PINE64";
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

