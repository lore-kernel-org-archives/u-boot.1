Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4583DD2502E
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 16:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0FD83B85;
	Sun, 11 Jan 2026 17:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zf1wlWbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA00A83CEA; Sun, 11 Jan 2026 17:31:57 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B438A83B85
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 17:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b5eb14e88so1146494a12.2
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768149115; x=1768753915; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zMxSHBc3tsNLNzJxRW6TuIvr4ljhRianOsUR4asfdLE=;
 b=Zf1wlWbWjS+wj3CTM4/UoqQGD7d9CMgMmyiCLsEudEC9u/K9A782n4VgHXoy8odtkN
 jE3XFPkoe/AtgEVDRS/8pxPVFh8hlL/0LJJdklT1XHSbSgMsu+foE6rB9hCfnAJrUALs
 KUMidjGtpl3AVMVCPjDa8srtUCkGtkbKVu+9hHZ/DdOrUDBdPS+16t717GgU4BZMM4fh
 pcYw96J64tx7UOjCpZUvax1IgL0oKizuy6CdhLeVRIy3C5DPHQAlJu+nC/aQek18KjQS
 ukuLdQJLOVU/Cd1K18I6+RNLGEMECiGfHrd4mHVyLArhGVOOyFzPbpnpU2ByoALwrUcu
 g3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768149115; x=1768753915;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zMxSHBc3tsNLNzJxRW6TuIvr4ljhRianOsUR4asfdLE=;
 b=AgaZnrpm4JnsQOhucGgmQ9Tkn9cDdXCNtJC9UKuzmrDCQf6O2sjPBUr2SoMTGrdBVa
 qfCh2udCks+KWjAXO0XZ1ClFSgkQqfZzR5oHgRNOQ6WRILMV0rHTcoKoqDktFSkFUIGF
 nh2kVQwnnT0Eh1GZ/gg1yCdaYcJKJnCVzUZtfajSuC/VELqL9CDx0ebXEG05DazNSzEN
 57JuQw8vV5dMnOETc8+pvIP4gxYgExITVhplNRqbHMKTVdc+MpbNVh1W0mTHDAqenk2k
 fy+VYNrp8cT48vtoeT3tFg7tzjiLL9NvC6ZJU+EiGLfyjDVQ+3GChOYcVcugWGQVj+pQ
 qzgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXILBpBajid0qAga4jB2f9wH8tV5Fs8PGQRs/0w8lldbcyZoSbtTvdYqBEntlrpvcbg9aBz4Mg=@lists.denx.de
X-Gm-Message-State: AOJu0YzXFAH8FvAn1d/BauacNZGfPzUJXo2nhOIftBARsiV2vtwYmGq9
 tj5+YvURSFvyNlDy+4NmZ7tk7ci1GQKMzEk1j5KrahKd4oWgmGtx5sjAQ9wSBw==
X-Gm-Gg: AY/fxX6qMUmcr/ShBECgsXY9z+C7QDFnNDweknsW5nQvlKu0dpIZC+a5ftzTPrcKM3T
 i5sbElTQrY1QlNz1AKf2Rrn6NpHM+gUOLDTdu0zcbWCg1QKv/1C2kfcP5khRA5BCTphvKQWeIpj
 2PExQcOeXMmVSAWQWLpJU02gl6PCL+l/RVZvk9gHz+wvMBBibdF05Fyh6c/uoJIWCiUH3OhCT8q
 Gi0iBSn0BkizHaWSUkKgExIOhsU83thCQo0qZd15miCUzh6ow60hQNPYnjqti6WdBF4Lg151e/t
 Zl1S3gnjpHEvClO65vm1Pl70sdtZSjCO4cpEjVba/s6lpCmmYuWghqrLqVpDAmNCOYiktx2LDSp
 eEXiuaKE8SlNSml9OY3PKJxZpjZ/HaGQGfxEXORRkyGIyJy+70K5v/mHKCG1t1xucxCtyxN5YKi
 dz2F7c2oNKOhfSr+z0FwYV7IoyhgbiBl9OxyzO9Hrq4HFPjv9+WQ==
X-Google-Smtp-Source: AGHT+IHPF9JIv/zgnRfvIxO6+JDyT6N9BUry/Px8zrmtY43xyJUK5YNahXu1TND8/AuIIejObmBB4Q==
X-Received: by 2002:a05:6402:51d2:b0:64b:4e7a:bbc8 with SMTP id
 4fb4d7f45d1cf-65097ec3077mr8044992a12.5.1768149115083; 
 Sun, 11 Jan 2026 08:31:55 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8717a10ae1sm109409866b.32.2026.01.11.08.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 08:31:54 -0800 (PST)
Message-ID: <7bfdca4d-356d-4488-a67b-d358205db632@gmail.com>
Date: Sun, 11 Jan 2026 17:31:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 6/6] rockchip: imply OF_UPSTREAM for rk3288 boards
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Content-Language: en-US
In-Reply-To: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
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

