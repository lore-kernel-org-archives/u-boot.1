Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1771C55838
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93F4A80C9A;
	Tue,  4 Aug 2026 11:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDdCibP0cavG; Tue,  4 Aug 2026 11:34:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7318B80CA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785843246;
	bh=kMYeKaBngw1Ak4I8ivGc5zye+0K/5/MvpJK14fxFkZQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pwWHdcfGtqNq1SKVUODNdyTw/Tep1hm+ZsBjZQbUcqVWcpIi7UFWEBCtSYimMXVRW
	 kzsa2UIcLbQSG73PfLET3+KTB8gClEdgsP4k2a4zFvZ3Fgf3PvRz/LEebO6Z5smmZG
	 YuTWHmtY76BTQJ/qCw8QMVrPV2MoWs4gzBMBnmZYbkEEM9KymSopktEDH1IsyOBRSb
	 j0pJz5L6oLnHQkO6tNvZzUUYBBuH8taiSCs32na6Oxgx9xwXWtbFxMq2Eqzn/qTuMo
	 HwxDM//dGAV6ZhyTqVK/m+HrTMallLXy4IZ8Hm/Rqa/wXQxWrJMeHpfSpuq/wJLz2q
	 3iWtnBb6XrkKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7318B80CA2;
	Tue,  4 Aug 2026 11:34:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23938296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04603406EC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QrMEoh4Dz-67 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 10:43:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=ukleinek@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C9FCA406EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9FCA406EA
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9FCA406EA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 10:43:42 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so3339120f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 03:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785840220; x=1786445020;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kMYeKaBngw1Ak4I8ivGc5zye+0K/5/MvpJK14fxFkZQ=;
 b=RwqgX9eHru/dSICiTFwY07vaihzIR9i8hWr7QPC7lgds1Cp+CJJodIB5BX8AEMnNun
 vy4rzKxmXmJemxrrnqpneZZS77uod164RWm2Ks0qx0O8IzK18NoVkGJZhLFy6WM6JZWe
 0qhaesi+eJYxWnwK3Ryhdf6o55ZQI+r3K1VXpCiVxUZPvVAkHto9ol7iglRw/yKEq0/s
 JrgCDZfuX3/YlFZl7gYQYIzytf6XG0FfI6vm45npKpCJ+/3BWvlvbViQqXx08fGjDfFK
 g/5wJpXBnjo7xmQsRRhg3TOx9Rfp3LfCNSxTDv/G41IBhe71uP76CsEd3Ui5KMJZJT8X
 Cl0w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6ohxB7NCiFqU99esGWpKjDJ1hAkIogJf+GSGG8xXTO2TsayCnDiIR9kwDtVIXbbu8rZd1q10=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yye2yGwpmSjPXxY/Dkr2eDQN8MGhpGVPbtdkXxAZdHv0gXxqkkE
 um0QdYHFYAxXzwNjtpPjv1Cb4WVSsJFfXTJrjxrdskMpkOOkZDLRpMo4nQNOku3SKDs=
X-Gm-Gg: AR+sD113aKW421heXwyMGrCW9Sg6dQ7AVlcoix04MJTuN2SoWcDwJtWf3eq41iXFDo5
 9nMvqdOaa6sLCnTtI3YxlnNV7Qp+NagnPoGpjke2BSyymqSYlIMWVeVYUfPF3bsxJWYCE4qNFST
 hThqQZmokBF83taq6QfkEw7WIuOUcs5M2u2NCVKZalSkBZw7mQxZfqoJEn2rLsu70iCCl6RI5JL
 Xch7wy0dh21H2ttQGWzjvQIKeWVh/40z2rDuq7khVOWMTTnKFDC3TopCZrS8I6KEqcIDugZCd8z
 D86GNOFDBQ8kzfsK4Z1MBrM8C/yVgZ35VlRpcwgWa75HT0cocAsV8IEbglKKrLzZytbgYd7QwAi
 E7C909S3XtD6tulBZijjkrIGJ0k3zT7qfk/5VpZ3dAxyf6hE/bng4EmvQQFuyUYBBpeYomWQ6n+
 TRHFBZbCjALGURyhklRRnfmWYbVALky9rjBuWlR7whTScCY0l+1lVM5Fu2PdMGi5xc7UjbUEgcG
 TzEqcBt5SPe9uwPxp1ZuPJookSIGdLbrL4gSmTk01+qw5YBdJ5U
X-Received: by 2002:a05:6000:615:b0:47f:6efd:8421 with SMTP id
 ffacd0b85a97d-47fd72a8ae6mr31304559f8f.13.1785840220230; 
 Tue, 04 Aug 2026 03:43:40 -0700 (PDT)
Received: from localhost
 (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de.
 [2003:f6:5f01:7104:96a7:6592:f113:63a3])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47fd45a1abfsm41531358f8f.37.2026.08.04.03.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 03:43:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>
Cc: Tom Rini <trini@konsulko.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, Ozan Durgut <ozndrgt@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>, linux@analog.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] arm: sc5xx: Enable BOOTSTD_DEFAULTS
Date: Tue,  4 Aug 2026 12:43:31 +0200
Message-ID: <20260804104332.2585195-1-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Aug 2026 11:34:05 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785840220; x=1786445020;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kMYeKaBngw1Ak4I8ivGc5zye+0K/5/MvpJK14fxFkZQ=;
 b=NWKG+WwX/2JVfXKPpsiSp13L/XOXFAzWR4KeeocEucSqydeLMBYG8//G3A+PMB+vN+
 C/QFCA/V73EZkGyl1a9u8e17hNOTks0mGJaDYvt+NN5uYwJGwDpQPGUSEtUWWWkIUhpy
 E3UiwUxrXNLtXheYJQvbgsXUiLWVR6IkOSlJgJWd3n4radjZZXJLuJaBNxkz/JIoCvoA
 2pXcE0HIIvnHSyVa/L+b48c/i1Olilzp83uAWvLd9YaO97j+09XoGKqmR4OtcgUCLIrV
 6bCJxsWHNEYLUFBc9Kjm7FSY1NswKKL2homQswFhrO9C/r6Cw2ObzCt7e2JV6yrFqu10
 zZEA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NWKG+WwX
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This setting implies various config knobs that are "commonly needed to
support a good selection of booting methods." Among them is
CONFIG_SUPPORT_RAW_INITRD which is convenient for booting a Debian
installer. Enable it for the (non-SPL) sc5xx defconfigs.

The removed lines are only about settings that are (transitively)
selected by CONFIG_BOOTSTD_DEFAULTS and thus are not needed any more to
be listed explicitly. CONFIG_ISO_PARTITION is now listed explicitly
because it defaults to y in the presence of BOOT_DEFAULTS (which is
selected by BOOTSTD_DEFAULTS).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 configs/sc573-ezkit_defconfig | 11 ++---------
 configs/sc584-ezkit_defconfig | 11 ++---------
 configs/sc589-ezkit_defconfig | 11 ++---------
 configs/sc589-mini_defconfig  | 11 ++---------
 4 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index fc4ce13cc709..086009a23e15 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -18,13 +18,12 @@ CONFIG_CGU0_CLKOUTSEL=7
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ramboot"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
-CONFIG_CMD_BOOTZ=y
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
@@ -39,16 +38,11 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_DHCP=y
 CONFIG_CMD_DNS=y
-CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
-CONFIG_CMD_PING=y
 CONFIG_CMD_WGET=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
+# CONFIG_ISO_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
@@ -87,6 +81,5 @@ CONFIG_USB=y
 CONFIG_USB_MUSB_HOST=y
 CONFIG_USB_MUSB_SC5XX=y
 CONFIG_USB_MUSB_PIO_ONLY=y
-CONFIG_USB_STORAGE=y
 CONFIG_FAT_WRITE=y
 # CONFIG_REGEX is not set
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index a8c6b9f1224b..161c9ecda038 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -23,14 +23,13 @@ CONFIG_CGU0_CLKOUTSEL=7
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ramboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
-CONFIG_CMD_BOOTZ=y
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
@@ -44,16 +43,11 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_DHCP=y
 CONFIG_CMD_DNS=y
-CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
-CONFIG_CMD_PING=y
 CONFIG_CMD_WGET=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
+# CONFIG_ISO_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
@@ -91,7 +85,6 @@ CONFIG_USB=y
 CONFIG_USB_MUSB_HOST=y
 CONFIG_USB_MUSB_SC5XX=y
 CONFIG_USB_MUSB_PIO_ONLY=y
-CONFIG_USB_STORAGE=y
 CONFIG_FAT_WRITE=y
 # CONFIG_REGEX is not set
 # CONFIG_SPL_CRC8 is not set
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 9cd204e40abb..5b56a0bef9be 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -26,14 +26,13 @@ CONFIG_CGU0_CLKOUTSEL=7
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ramboot"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
-CONFIG_CMD_BOOTZ=y
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
@@ -48,16 +47,11 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_DHCP=y
 CONFIG_CMD_DNS=y
-CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
-CONFIG_CMD_PING=y
 CONFIG_CMD_WGET=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
+# CONFIG_ISO_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
@@ -97,7 +91,6 @@ CONFIG_USB=y
 CONFIG_USB_MUSB_HOST=y
 CONFIG_USB_MUSB_SC5XX=y
 CONFIG_USB_MUSB_PIO_ONLY=y
-CONFIG_USB_STORAGE=y
 CONFIG_FAT_WRITE=y
 # CONFIG_REGEX is not set
 # CONFIG_SPL_CRC8 is not set
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 0908ab1708b3..6c6dc805e606 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -24,13 +24,12 @@ CONFIG_ADI_USE_DMC1=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ramboot"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
-CONFIG_CMD_BOOTZ=y
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
 # CONFIG_BOOTM_VXWORKS is not set
@@ -45,16 +44,11 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
-CONFIG_CMD_DHCP=y
 CONFIG_CMD_DNS=y
-CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
-CONFIG_CMD_PING=y
 CONFIG_CMD_WGET=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
+# CONFIG_ISO_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
@@ -94,6 +88,5 @@ CONFIG_USB=y
 CONFIG_USB_MUSB_HOST=y
 CONFIG_USB_MUSB_SC5XX=y
 CONFIG_USB_MUSB_PIO_ONLY=y
-CONFIG_USB_STORAGE=y
 CONFIG_FAT_WRITE=y
 # CONFIG_REGEX is not set

base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.55.0.11.g153666a7d9bb

