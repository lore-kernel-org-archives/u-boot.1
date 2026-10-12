Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76661CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CCB3605F5;
	Mon, 12 Oct 2026 09:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5OokqqDalomO; Mon, 12 Oct 2026 09:35:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C974605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791797701;
	b=kVyNx7YtFZq8StC2aY+waaVUDGyyKCWAdV2mjofemM72ilCwR0FUJnfToocrbhbE8KHS
	 jL7tqg/mz3WgIqRpMoAUa5ZOYPJ0e8HLsw/vYSxAkd4cpYFelcu7DLKCke6f5zfxDkej4
	 Ks9Um+Na+Rdl/YBrO/Ci+8NC8NcSF2PnjBPYLNDycIis61alCQyDFTeFb71gNxzYPoeL7
	 VqtUiFxOnvRyuSv8e6Dy74/ZWouGe2C1KBNnfHTsxyebl5kfd5d9rpzKhOUQwt4/XWucE
	 B7cyOsg6o3C4dTA4f9ZjmUBKs9ZBMZ/xSfRPhFfBsnCi6blKnbob4933w18jvn6lLjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791797701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=eT6hfjo/bLLdF/eI+c2I3SyKZsow6klzGtI4sj5/tGc=;
	b=WqahPQrnqxoQamz+rAtg/RpFDQIraOqpc2JNz9SZ9oNfdLenPKWT17HIBDgXSdmc8ApV
	 KEP83ceygTmoVSFy60O89Ztllr9QhFXkS0/72WBwFtnMW0OBlorardYPJ+SycJnQoUGIW
	 FCiJPd7xe9/6tiW+upn8h3bxQQ4LZsF6DdrbJEucOmAzfRi5T5Ctqyc1QC+O+duWWufPi
	 ey7na8SSeXJPsILDmJJkyHSsPFZb5bo6OSoCBt5a4AuigcLYSq1Qlr3k21pdwvvEf3ELB
	 II+nYDbowrHPgKZyx+nvBzJmMPEUHPNy+kEO7igrYwcigUL/xzNj3NLnWV6wyfs46eQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U7bHD+tT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791797701;
	bh=eT6hfjo/bLLdF/eI+c2I3SyKZsow6klzGtI4sj5/tGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KUS1zWkSSZrXMniqx2BcRUfmWi9N5dM+rGVrwDvbdmMDo44mbXB0AiULHYbl39fTm
	 cAtbSbDH7eR6mLon05lDihtzDTwlmmLMwPMCl2l+vNPEv8shfSFsslTvjN49VUbCT5
	 2K6qL0DY7AJTTLJmuTNd7EeEvd8B24EaFRCoU+c3Upo8nodH82+GpLcHFSvOiFCyIe
	 g/izxmZM8p9v9DlYOICDgf5aZXq4QLAHnxxmTkkmehwSpqrK0mujC78nKsQ/ecn7M7
	 jlXdHeOp/NuHVv1wEBX9p2nNryK6pUoQyHe3lIVF7+Cpd0lEEtqttQIbTNcShV41FW
	 81q+3fPBVKa8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C974605EE;
	Mon, 12 Oct 2026 09:35:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4E62D5E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CAC5B60626
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toceDo6vq_sG for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 06:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1694C605F5
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791788146;
 b=YPHlNbJpW7DkrSJeoBUpPQh+BHJYGr0LxTjEfzJzmsnUxyyFqLnh18+ieaEM+CYuUwBv
 FzOb/Td7H4wa+IjcUO8dkcuJvreblyCcbUm6GsX+FU1XIOqA7T75hbYZYzfjgSJulP1bK
 UfsesgFNt2h79VjI+7fyzX7/MF8/cB1ZXeTUqafHXnbifI2rwbCcXEcndk6I2pYvEnIc4
 fdH8x86U/3FZ27V+wJ0hARrNPXsPLiMTftxieZh7oii0tR2ghbRXnkL00AC8j3gF94VKT
 BpvaZdscOmebR5QbXrd7OmzE284fABTJDOhrL2PBevPnk4Wq64ohAwA8QJQiY/MIWvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791788146;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=eT6hfjo/bLLdF/eI+c2I3SyKZsow6klzGtI4sj5/tGc=;
 b=cPnhdiQLN40N49igAEX05DjnZm/65uWnqJmny7Eq/xaeq0SSts+qHYK0glMFP5Zu+/on
 xC1iKqa9tMtKEMm9RMc0c/jl0DH0GXEW6L2wCg3+hqhhO89TAptqucLgZc6FapFHHXBiz
 QJbx4zcin0dmp4xFR3snKNR7QTJijExjJTdPPgkDS6zrM+qydns7Fa0lsuDnccFJW1EMw
 pkov48vWiRyvv9XAD057xWlxy9+3i+BUF93/mH6VUGo/i7fspOcVExmR9Uod3bJ3+TU5o
 67P14gkgjitIqE9DLY4zsvmt4NuvFWJiTTCe2iydm2w5Erv5cEmUNEQ7bWTcOEhoQsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U7bHD+tT; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U7bHD+tT
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1694C605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C2E54434B2;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3ECCC2BCF4;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791788144;
 bh=uzyQ6EYqhA8h3JC7wwSyFsUv0ZlFl4cV7K3x+aZIOeE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=U7bHD+tTqeFXUgBTQeKA8YbSi15n2tLTypiAEnquV61yoaE+VCcIGs3srtksBWYm6
 87nN5D+G0/PF9bP/zCY75kpUARYvrvG4FXV7+Lt/ZzjZs5GubdShukBccQWcSLjf5J
 OyuclLF5UXO2RCfkbYhjwqjoAtIJkpiIdJKKX37SaEbj2FNL4Kz0vZdgLcvhaTCFzZ
 I3sJsIiUMfIJt5t8L4xe+K+jQrRZJn/7HhsecbDbD26YdyWebooYtoxAJYBErijrPx
 yy6/F0jN2o8zbDsoMgwcU7oXAC3BqhvRX74S/fE9sK9tCQ7nAnohScRVPYOxBOStNs
 5OXf4HtZAqoPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 85D67CA9ED8;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Mon, 12 Oct 2026 14:55:43 +0800
Subject: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi R28S
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-nanopi-r28s-v1-2-042d62597829@proton.me>
References: <20261012-nanopi-r28s-v1-0-042d62597829@proton.me>
In-Reply-To: <20261012-nanopi-r28s-v1-0-042d62597829@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4645;
 i=HystericalDragons@proton.me; h=from:subject:message-id;
 bh=h2uOPfV9i4tlc0R4y0H4cVqMfdPL5EaYzrXjaZL/NA0=;
 b=owGbwMvMwCUmepz3XUtTHjvjabUkhqwzLfnr3F7ITe28n8ui9ZV7Y020UM8lxfxXDtLv2lkOt
 C8LPGTYUcrCIMbFICumyCK7qTpSaFX0zCIWqeMwc1iZQIYwcHEKwERCqxgZdvKqFsZdDOoMfZ+5
 stlS5rLn3WOuSmeK3q1e/+G2VKumFcP/mDWrF+o+NedfPaNj5QLuvUxVN6eFZL/8JpZ/6mLy1Ck
 TmQE=
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=1DB27B5912AA5B9972041AC715C70DEE84826E07
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/default
 with auth_id=1004
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailman-Approved-At: Mon, 12 Oct 2026 09:34:57 +0000
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
Reply-To: HystericalDragons@proton.me
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: 安容 <HystericalDragons@proton.me>

The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
based on the Rockchip RK3528 SoC. It shares most of its design with the
NanoPi Zero2.

Specifications:
- SoC: Rockchip RK3528, quad-core Cortex-A53 @ 2.0 GHz
- RAM: 1 GB LPDDR4
- Storage: microSD slot, optional onboard eMMC
- Ethernet: 1x GbE (GMAC1 + Realtek RTL8211F),
            1x GbE (Realtek RTL8111H over PCIe)
- WiFi: AICSemi AIC8800D80 over SDIO
- USB: 1x USB 2.0 Type-C (power input and OTG)
- UART: USB Type-C debug console (onboard WCH CH340E), 1500000 8N1
- Buttons: user (GPIO), MaskROM (SARADC)

Add support for the board based on the NanoPi Zero2, and enable
CONFIG_BUTTON_GPIO for the user button.

Features tested on NanoPi R28S:
- SD-card boot
- Ethernet

Signed-off-by: 安容 <HystericalDragons@proton.me>
---
 arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi |  3 ++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS   |  6 +++
 configs/nanopi-r28s-rk3528_defconfig        | 65 +++++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst             |  1 +
 4 files changed, 75 insertions(+)

diff --git a/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
new file mode 100644
index 00000000000..151f1872fed
--- /dev/null
+++ b/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-nanopi-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index d1810fb0528..78e0bfb2701 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -10,6 +10,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3528-hinlink-h28k*
 F:	configs/hinlink-h28k-rk3528_defconfig
 
+NANOPI-R28S-RK3528
+M:	安容 <HystericalDragons@proton.me>
+S:	Maintained
+F:	arch/arm/dts/rk3528-nanopi-r28s*
+F:	configs/nanopi-r28s-rk3528_defconfig
+
 NANOPI-ZERO2-RK3528
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/nanopi-r28s-rk3528_defconfig b/configs/nanopi-r28s-rk3528_defconfig
new file mode 100644
index 00000000000..f24bf2c65f2
--- /dev/null
+++ b/configs/nanopi-r28s-rk3528_defconfig
@@ -0,0 +1,65 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-nanopi-r28s"
+CONFIG_ROCKCHIP_RK3528=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFF9F0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-nanopi-r28s.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_RNG_SEED=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DM_MDIO=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1f4e58c8be2..faca4fc425a 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -103,6 +103,7 @@ List of mainline supported Rockchip boards:
 
 * rk3528
      - ArmSoM Sige1 (sige1-rk3528)
+     - FriendlyElec NanoPi R28S (nanopi-r28s-rk3528)
      - FriendlyElec NanoPi Zero2 (nanopi-zero2-rk3528)
      - Generic RK3528 (generic-rk3528)
      - HINLINK H28K (hinlink-h28k-rk3528)

-- 
2.56.0


