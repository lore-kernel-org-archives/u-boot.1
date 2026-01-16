Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589BCC982C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 22:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E91D5839B1;
	Fri, 16 Jan 2026 23:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="arztVWP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4AC839D5; Fri, 16 Jan 2026 23:13:22 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66368367F
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 23:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64b7d213fd6so435247a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768601600; x=1769206400; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zMxSHBc3tsNLNzJxRW6TuIvr4ljhRianOsUR4asfdLE=;
 b=arztVWP9U2TP4Y4iDjGbB4JeaclQq6P33UCmF8LjiHiXabIKBo64V1KNgX0bW7H3rI
 iX6RohoMJmkcinE3nz5OCtbVfyM+idc5f8m0XmoYcR5O5745uvaDJQCWWkdhCnf6iQrk
 kMV9xxr2WNjnnzvIn7Y3rEklxtePM039o5taVit93HVbGlm8DV5Eb7JHRPh0j5Xki7B2
 dnLkt+N0sTS+NB0EfoTaNxJPs4u2br0fBOxfDnuUG22H4ncNMN8Ah8EtXkVIZXl7Mnsl
 RclKKyMRk1vS/bcNzKnqo9lAgt3F7rZgG0r0iJwriSQl1Yi2WtVyl58zOXAUySrhG7Fw
 aUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768601600; x=1769206400;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zMxSHBc3tsNLNzJxRW6TuIvr4ljhRianOsUR4asfdLE=;
 b=sgLmPBTcS8W/m2SfkP5zI8ETXVRFASSME2oMuZOEllxfMiB1Vd1xQRPU8ox7nUx1B2
 c+uGU1DGMgt9lBUdCwWiEQE4ASFd9p4aC5Mw8NBbC5HQnIIoUPCZItEx93/SZB6xLywu
 EVNeIgbpvOmc3qclyU1fH+GZvXI6GpoWeYExBkhGfaProY8o7wktp5gfuInhv60S4a/H
 87Fh/QTTa+kiC+anNyy3AF9wVyTPbVay7zaLZa+17AAgKu3yI0ykrvM2ww27U3pKheJ/
 vn8QvGs4qNGHR9ISxYhWGFEzrKV6wcNZgAqDGxT9PCBtcGontI13MVMYkTesCPeZBBdd
 xdgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFn5W8Qxl4j7IlDixRxsRo90koKSX33lQB3FPURDivCmn9zCUnVYPYcygywmEV2AwLMyToAbg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4Hx77JJAZvCusDT/MbCdb8lLY5dsWduIZs6WWv9XgStv64L0u
 dcvt742Zn2Btgv0RZFO+yzc0jl8GDq+0a8GH1qAch9EDpuv6PhaMhaM8
X-Gm-Gg: AY/fxX5fDdbq7QR0ChqeP8HQ6JxS9kSSOMu66ymA9qHVwnF84737mItNn/S6xqo5LJG
 XKObFB2DY3WChsEGhK4gV66YZ1DDV5/N3f3nVe1f+t1hxRa365TmsbXcmcwhr/UvNaYrGBEbKgE
 TbUld6uvejokwQiTYHTG2Wm3v4btk4j4VclQqlG5orUa/jbNAK+dp9y3kLPNj5EdbS4XOXnuVQR
 i8hXx6ShnGmaTmbZcVUq7r8aW4xDRO6RIekz4C02fWuufUVY0Jy7ovPamG707pvnNzx0Q42Ehj5
 HJzhpNfFbniXzdKN9Di6e2wwqFiqD8MYSmiK/btJeibFDePjkpethKj01J2wNRDJqmyZZOCEn8K
 janRBGt4CszDmo4X+iI1q2UW8pUjVDoxXHgouSXIFyB1j2iOhdsb0XiGi4R5ISJWvdBWxysmwS8
 jl16KJG/rKqbY31arMzRrZgBDcY8CHinONAuibeA3Re1RsEK9iKS9taCTFqw0v
X-Received: by 2002:a05:6402:5216:b0:64b:3b7c:7920 with SMTP id
 4fb4d7f45d1cf-65452cd36d2mr1795738a12.8.1768601599981; 
 Fri, 16 Jan 2026 14:13:19 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5d6sm3459748a12.22.2026.01.16.14.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:13:19 -0800 (PST)
Message-ID: <83bd57fb-42cf-4dfd-aa6b-b90155ab84c4@gmail.com>
Date: Fri, 16 Jan 2026 23:13:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 6/6] rockchip: imply OF_UPSTREAM for rk3288 boards
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
Content-Language: en-US
In-Reply-To: <a6eba53c-a2db-44fc-9785-d817dbb4ef11@gmail.com>
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

Imply OF_UPSTREAM for rk3288 boards.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/mach-rockchip/Kconfig      | 1 +
 configs/chromebit_mickey_defconfig  | 1 -
 configs/chromebook_jerry_defconfig  | 1 -
 configs/chromebook_minnie_defconfig | 1 -
 configs/chromebook_speedy_defconfig | 1 -
 configs/evb-rk3288-rk808_defconfig  | 1 -
 configs/firefly-rk3288_defconfig    | 1 -
 configs/miqi-rk3288_defconfig       | 1 -
 configs/phycore-rk3288_defconfig    | 1 -
 configs/popmetal-rk3288_defconfig   | 1 -
 configs/rock-pi-n8-rk3288_defconfig | 1 -
 configs/rock2_defconfig             | 1 -
 configs/tinker-rk3288_defconfig     | 1 -
 configs/tinker-s-rk3288_defconfig   | 1 -
 configs/vyasa-rk3288_defconfig      | 1 -
 15 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 92bb4aa62f11..5eac0cb7d94e 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -132,6 +132,7 @@ config ROCKCHIP_RK3288
 	select SPL
 	select SUPPORT_TPL
 	select FDT_64BIT
+	imply OF_UPSTREAM
 	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 1ae596b4f4f6..60ceae8f1531 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -56,7 +56,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index 5151af8838e4..5e89311affe3 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -56,7 +56,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 3ab1e90746f5..6e0158fd4a9e 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -57,7 +57,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index 796d29604242..86f1399c0e3c 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -57,7 +57,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/evb-rk3288-rk808_defconfig b/configs/evb-rk3288-rk808_defconfig
index 8e140d6e41cd..2112e475ad31 100644
--- a/configs/evb-rk3288-rk808_defconfig
+++ b/configs/evb-rk3288-rk808_defconfig
@@ -52,7 +52,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index d7b01e67db9b..54e3c41f3ccf 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -42,7 +42,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index a4d24c11fe81..4cbd4b97172a 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -41,7 +41,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index 461fa5d432a8..a374f90982e0 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -48,7 +48,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index 4489c0393501..52d38f4108c3 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index ae2f9e9bb17f..242aa89bcce0 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -45,7 +45,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index dd296efaf1ad..025b55e2171b 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index afbb394228f7..2e701a5ff722 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -42,7 +42,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 876086573d31..816903c8430e 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -42,7 +42,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index 8ac1c9620c65..1d7e22653608 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -53,7 +53,6 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_UPSTREAM=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
--
2.39.5

