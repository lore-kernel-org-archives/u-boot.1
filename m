Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83102C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F86140600;
	Fri, 25 Sep 2026 13:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6rEaPWbxUzen; Fri, 25 Sep 2026 13:42:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7786F4062F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343756;
	b=D/OHnMRIlL358fNzEnfNlnnDz3EgN+Dh+R7BppXMFT7YloPHwgovIB7EpIa9qgs0Rvyh
	 Y4yUvsaRcYEhYBH0pOia6tjKGtzudwaoRCb8zPa8yd9uhOByMV+rc9PKSPaqbqAZBR4aL
	 oUeUbgSDrzdw61aORRq6VoL2gKCAyzd23oqHUfgQf4hCP94qsyO+g+JAuKbtckryq7/3L
	 5HgrhnjhUoRLU5NaXRH6egZLmvW7O1lV+wFQbqUF+M3aIbbwXLe8c3uFJBUKapaVGL6Up
	 nQGzxUopKg2oAFxgkcfnnz7I0cyVq3BO9D+/qdJ+uHZ/9ukBjK54+eZr6rE7nx4QwNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=q/2Ut7soPQR9Ie2M5+ScdduwgphNL0NvagG4eggyB/4=;
	b=LyUOrPxj/5VQyYJzAGTCOFOz0l0fyYz/ufLpmpBMCSakbbGXqftZ+5gLN/Kr8YD2aWrh
	 8ol+VPFA5/sf3ucyr6VspcgtP7dFw5c6iTY3BGT3GKoNdFs4YajiJEQACx1kzkFl00Q/4
	 cJcC+DIGrXuF5CZbhzAtErHXT3dQYbyiw+ZV/S4FE6o02wqB3a5X4fMe63vjUP6NVd2lg
	 rXuqqd6/tZYSvSbFkV8Wn19eUexa5QHW+TUJo2prgrVuCakOu5lyQuKKKx4YlO/FD11KD
	 GeM9wIrv//5E3QmSAd441OkXl5EBf+qeGd/px0cQAjQC6Zb65yEr1zPIFKKfRI//n3A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343756;
	bh=q/2Ut7soPQR9Ie2M5+ScdduwgphNL0NvagG4eggyB/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c3/zBIjXxeb0l8HS+giEuueYwROxh6nEhisSF8lyeRNAmeHHHZsEkiEDZ6UOCH+ec
	 28LJKZ4Rm+LYzhyBbpzI0i8oDQVPh2FePSISo+tZiXRarKsyavXN94+9jrsFtIK7co
	 oIQpMdz9KfEBU8K6czua+KHR+zAi0EfTDXrLYqA6xStIgkH//r7RnIX7FsqCFazXAH
	 SeCcA4p8yIC9GqTssB8EpUHbHnv1N0TA5UNyM1Hu30QZKxXVAb9gAJQFscGJ3byQsQ
	 qJqwD77aBhlNoYGjAZo/G2UDDw2XQ20kBsf1PozDvY38oK7UpK57aeZCatlVgHXxIe
	 ojLmkjIDaI7Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7786F4062F;
	Fri, 25 Sep 2026 13:42:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 892CF35A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6ED4740180
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id maNpCwhmegd4 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:42:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4DB7940042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343753;
 b=G2dYiX/8YTn4sEvL5RVPw0rEN/9BYjwP5pYYDCzqKmywhGnMecC+BImSObWch2PoQtof
 c5XkD/ituO6MS+U4kbMF/iZwvG88UId7lYt5TopzWd9mIsALDTuxWfLUGu7Zi7VFuVOrP
 FyDrDLHkzuzqegsxDq6/pwq2VVBrLzleIfAgdZGKQSD2cGKyGf3bym//7fjv+SfW+nC6I
 nHeVXnfrNuwSIvjR6GiW2Mkrm/tOh2LL10mNX5kYX0iokbuV3CzAcfRoo/4wKpdjV+S78
 0vWCQ4H4DR9Z+e9fmw6IVVw3zEmNpfDBFD3TilA+YrGNe7qhG29byG3INM2Vr+wG6Bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=q/2Ut7soPQR9Ie2M5+ScdduwgphNL0NvagG4eggyB/4=;
 b=aof1JMyy52HIESTkjAQUPrAIWbnb7u1jmfJ1eyL9xfp/a084I8grJd8mZyIro2hzX/IM
 6G5cLzPomTDTDlsZMGfnXmbCC+uAfxrdzHlwSxPmm3TjbEzq3P9MUTyy0WTHoUn04sE3K
 cEJ5uX2EQWPuDz7vcOtA9mmJUH4vZtldMQPcezwSZnjA/wzxKAoNEF7BAps6ev8qkgp9O
 oOn5YO2FMJc4lpJ6kp63awPCQr9xzQTu0uiuyd4IKiqrcQAlE2bc6syPvrYt0tZukumoC
 hAOAGaqbuQSNnJvHMEE8ah0beEXPlFcQ+5dhs5IAG0gh2FuvupNC8/kKPYCHkr8eVtA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="H1n/1mPz"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=H1n/1mPz
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DB7940042
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:32 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso5290835e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343751; x=1790948551;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/2Ut7soPQR9Ie2M5+ScdduwgphNL0NvagG4eggyB/4=;
 b=H1n/1mPzbOl01kkK/x5cLEkszKgACYKE0Xizg56c705iIAOGxXmuZo3FeNZS3//0pq
 Qh1Bs9nJS0rOMhOSp8lzRQENnkN3gj1ufa7blqV7Gs1gO36mbaN3LhrV1/PzWq1Dw3Rc
 BHnCoj3ddVt1hSgUkoxf7myyyfaapgct4WpW2+x3/JwrDbOCFF08nmgrNsMO2neUoDeV
 VDJlFk0CeNg4+G0VhINz22yAkCv7Wa9/CTQVaVIrX9cvPzeSvPml3MQ5tohXz/jqicRO
 epOInUdKHbff+lQ5Dykr6LkSA3PpzYDHKwpNUobaDG3oEraTWbFKooswzmJ+4JUEsYFq
 4vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343751; x=1790948551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q/2Ut7soPQR9Ie2M5+ScdduwgphNL0NvagG4eggyB/4=;
 b=dez4gYlwy8LFeoYtiyVIaFwECRi7rmnpIuS72Rm4NcOOh4cECUtIX5v+366/H00Yrs
 N11CmYXmK5nLAi+EMbjkn9xNd5pvLsLL28TH9Q3uLkwysZaBCreBluPg/YCRxXQ1qNXQ
 jnmOMG068keI4K0spzA/lVVX/1lx6Yu5vIbwbbp5AZaWIUtxhGMiNHGbLY6iKjEBbto0
 YUndkZ023oaOEMv2Sf5CeOMgKpTy4XFQUduojREfXCYz//MCJg7YeaWDQSHGIyXRUQHg
 6umV4MTf8qajmn7E986hkDHFOGUw/zRZSp+OkH9OhYZbfmZGAgG+GShKTzAE3saZflsd
 XVDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYsiuVhTiULwTuTjp1wqOJSCu32oXlxOimLGrp4OLPdl+ARmrDbBRLz0ZTL0bs/8SQKT8uXMU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++meTWMWujiIEHusEdW3BoEUVMrwW0Y534dbmL0kx6S0tneZFvJY
 Z2vSgVjkwvHbZnLx2hw4lAYQ2p/fFeG1g1P1IbvV6U2kZJD39vx1IviOjTg8SUOLOnW1SPqOyi0
 oITPY7HI=
X-Gm-Gg: AYBFou296sZ17EWeS432WyaVuPQMqeWBz3Ics6jZFscGwWA6YY/0kboIo8ay9nxvsDW
 N9meTs+PI4aHEubH5ILaxekeLsRywNngogh/E2yeuSrmbqf+xbGevfpWj8JqF1TpjQ+GxXqJczj
 MLvoMf150RtJjota2UFr/4JrU49iyWB2nLpeIZrjTuHgyh+t9bdRjUusVfPv2fsbKACmJQrMWPX
 zqMtEhs4g9MpC+qynsv3JJTmge4/tbMrZdTHIzj9ADxCqXVDqfi1IsqkyH9rjLv4MeWxJeJ/f3t
 1sTVif2AquqnSniW7H2xQr4QU3UzN+w6QVVWT/b4vE2rQZSfaSy9Sf9byc+XpApJ/KVrSeAC0Eh
 gibi7rAjIkidSbb04pTQ/p7P2xJfneg9R/Dw+aiHIornOFzYFAOsK2w48sE41pE/X1msha8jJfe
 hR+qBm7AZ5e1BYGQ8xLVkU+9OrmFyUfwgxQCuZGRKwVgm/KW9IkIpSaCqmP1sd
X-Received: by 2002:a05:600c:c16d:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-49fe66d6c90mr100600895e9.15.1790343750695; 
 Fri, 25 Sep 2026 06:42:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:42:30 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:24 +0200
Subject: [PATCH 1/4] configs: khadas-vim3: drop non-A/B Android defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-update_vim-v1-1-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
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

Android support for VIM3 and VIM3L is maintained with the A/B layout
used by the AOSP builds. Remove the unused non-A/B defconfigs and
their MAINTAINERS entries.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/amlogic/vim3/MAINTAINERS         |   2 -
 configs/khadas-vim3_android_defconfig  | 122 ---------------------------------
 configs/khadas-vim3l_android_defconfig | 122 ---------------------------------
 3 files changed, 246 deletions(-)

diff --git a/board/amlogic/vim3/MAINTAINERS b/board/amlogic/vim3/MAINTAINERS
index c5f8d9cc5ce..a9b977646c5 100644
--- a/board/amlogic/vim3/MAINTAINERS
+++ b/board/amlogic/vim3/MAINTAINERS
@@ -4,10 +4,8 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/vim3/
 F:	configs/khadas-vim3_defconfig
-F:	configs/khadas-vim3_android_defconfig
 F:	configs/khadas-vim3_android_ab_defconfig
 F:	configs/khadas-vim3l_defconfig
-F:	configs/khadas-vim3l_android_defconfig
 F:	configs/khadas-vim3l_android_ab_defconfig
 F:	doc/board/amlogic/khadas-vim3.rst
 F:	doc/board/amlogic/khadas-vim3l.rst
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
deleted file mode 100644
index 1d518581605..00000000000
--- a/configs/khadas-vim3_android_defconfig
+++ /dev/null
@@ -1,122 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SYS_BOARD="vim3"
-CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
-CONFIG_ARCH_MESON=y
-CONFIG_TEXT_BASE=0x01000000
-CONFIG_SYS_MALLOC_LEN=0x08000000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0x0
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-a311d-khadas-vim3"
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_DM_RESET=y
-CONFIG_MESON_G12A=y
-CONFIG_SYS_LOAD_ADDR=0x1000000
-CONFIG_DEBUG_UART_BASE=0xff803000
-CONFIG_DEBUG_UART_CLOCK=24000000
-CONFIG_IDENT_STRING=" khadas-vim3"
-CONFIG_PCI=y
-CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTMETH_ANDROID=y
-# CONFIG_BOOTMETH_EXTLINUX is not set
-# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
-# CONFIG_BOOTMETH_EFILOADER is not set
-# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
-# CONFIG_BOOTMETH_VBE is not set
-CONFIG_OF_BOARD_SETUP=y
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_MISC_INIT_R=y
-CONFIG_AVB_VERIFY=y
-CONFIG_SYS_MAXARGS=32
-# CONFIG_CMD_BDI is not set
-CONFIG_CMD_ADTIMG=y
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-# CONFIG_CMD_LOADS is not set
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_SF_TEST=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_AVB=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_ADC=y
-CONFIG_SARADC_MESON=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_ADC=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x6000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=2
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_MESON=y
-CONFIG_MMC_MESON_GX=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_DM_MDIO=y
-CONFIG_DM_MDIO_MUX=y
-CONFIG_ETH_DESIGNWARE_MESON8B=y
-CONFIG_MDIO_MUX_MESON_G12A=y
-CONFIG_PHY_REALTEK=y
-CONFIG_NVME_PCI=y
-CONFIG_PCIE_DW_MESON=y
-CONFIG_MESON_G12A_USB_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_MESON_G12A=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_EE_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
-CONFIG_MESON_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_MESON_SPIFC=y
-CONFIG_SYSINFO=y
-CONFIG_SYSINFO_SMBIOS=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_MESON_G12A=y
-CONFIG_USB_KEYBOARD=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
-CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
-CONFIG_USB_GADGET_DWC2_OTG=y
-CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
-CONFIG_VIDEO=y
-# CONFIG_VIDEO_BPP8 is not set
-# CONFIG_VIDEO_BPP16 is not set
-CONFIG_SYS_WHITE_ON_BLACK=y
-CONFIG_VIDEO_MESON=y
-CONFIG_VIDEO_DT_SIMPLEFB=y
-CONFIG_SPLASH_SCREEN=y
-CONFIG_SPLASH_SCREEN_ALIGN=y
-CONFIG_VIDEO_BMP_RLE8=y
-CONFIG_BMP_16BPP=y
-CONFIG_BMP_24BPP=y
-CONFIG_BMP_32BPP=y
-CONFIG_LIBAVB=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
deleted file mode 100644
index 37a1d86a233..00000000000
--- a/configs/khadas-vim3l_android_defconfig
+++ /dev/null
@@ -1,122 +0,0 @@
-CONFIG_ARM=y
-CONFIG_SYS_BOARD="vim3"
-CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
-CONFIG_ARCH_MESON=y
-CONFIG_TEXT_BASE=0x01000000
-CONFIG_SYS_MALLOC_LEN=0x08000000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0x0
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-khadas-vim3l"
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_DM_RESET=y
-CONFIG_MESON_G12A=y
-CONFIG_SYS_LOAD_ADDR=0x1000000
-CONFIG_DEBUG_UART_BASE=0xff803000
-CONFIG_DEBUG_UART_CLOCK=24000000
-CONFIG_IDENT_STRING=" khadas-vim3l"
-CONFIG_PCI=y
-CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTMETH_ANDROID=y
-# CONFIG_BOOTMETH_EXTLINUX is not set
-# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
-# CONFIG_BOOTMETH_EFILOADER is not set
-# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
-# CONFIG_BOOTMETH_VBE is not set
-CONFIG_OF_BOARD_SETUP=y
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_MISC_INIT_R=y
-CONFIG_AVB_VERIFY=y
-CONFIG_SYS_MAXARGS=32
-# CONFIG_CMD_BDI is not set
-CONFIG_CMD_ADTIMG=y
-# CONFIG_CMD_IMI is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-# CONFIG_CMD_LOADS is not set
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_SF_TEST=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_AVB=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=2
-CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
-CONFIG_ADC=y
-CONFIG_SARADC_MESON=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_ADC=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x6000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=2
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_MESON=y
-CONFIG_MMC_MESON_GX=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_DM_MDIO=y
-CONFIG_DM_MDIO_MUX=y
-CONFIG_ETH_DESIGNWARE_MESON8B=y
-CONFIG_MDIO_MUX_MESON_G12A=y
-CONFIG_PHY_REALTEK=y
-CONFIG_NVME_PCI=y
-CONFIG_PCIE_DW_MESON=y
-CONFIG_MESON_G12A_USB_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_MESON_G12A=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_EE_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_SKIP_INIT=y
-CONFIG_MESON_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_MESON_SPIFC=y
-CONFIG_SYSINFO=y
-CONFIG_SYSINFO_SMBIOS=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
-CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
-CONFIG_USB_DWC3_MESON_G12A=y
-CONFIG_USB_KEYBOARD=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
-CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
-CONFIG_USB_GADGET_DWC2_OTG=y
-CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
-CONFIG_VIDEO=y
-# CONFIG_VIDEO_BPP8 is not set
-# CONFIG_VIDEO_BPP16 is not set
-CONFIG_SYS_WHITE_ON_BLACK=y
-CONFIG_VIDEO_MESON=y
-CONFIG_VIDEO_DT_SIMPLEFB=y
-CONFIG_SPLASH_SCREEN=y
-CONFIG_SPLASH_SCREEN_ALIGN=y
-CONFIG_VIDEO_BMP_RLE8=y
-CONFIG_BMP_16BPP=y
-CONFIG_BMP_24BPP=y
-CONFIG_BMP_32BPP=y
-CONFIG_LIBAVB=y

-- 
2.34.1

