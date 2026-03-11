Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEBEFD0651
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924D884132;
	Wed, 11 Mar 2026 15:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="mWe1oLkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109E184013; Wed, 11 Mar 2026 14:31:43 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6A484013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 14:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so5777388f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773235900; x=1773840700; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q+XhumOtefTxpMhfaBd1SgLoi8BcgToQqmVei1LfLWY=;
 b=mWe1oLktSBP6y60urLEbtZreMVtVxTGkbGRndXImI+N4f5syea1GP1foCmLE6rbLBA
 oV65R8QYq89BZZaCUDMCjwPq3AWQ1ezQuIWdMrY1sR6ZRZGDhmV93F9rZv8udAhxrH2a
 32qXwFhqUmNvLnwXfoIP4Yx9tQ8dSSuaVdGQyOHDQGWzcMzgxKFEdrA8+g//TqA3HV8b
 G4I4iauyjmKfp2cklg3eT4BQ8jdh0jKhlTv7Y4gcQ0eSvPug5ibaYEX7u05NG0yZtlde
 r9mR9Wc9sVNXBFbe+LDqwtSmPu8aD44ltYNJ39uiRY0T6aqbHFp0KtbeMyxYV51BnNjl
 FaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235900; x=1773840700;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q+XhumOtefTxpMhfaBd1SgLoi8BcgToQqmVei1LfLWY=;
 b=a1ydtOCLlcoZ25gwijc2pAkRZQ8i/5kf3bwQpCiLeFC4aOby3SAWO1JnyFc2Zeam1M
 hKpC/4Ix15BJK/Rwy13A15YSMfdnbp8loYRymBI8/G4zCyR1cacCJ1Xi0tzOg7rw53SH
 Kh6RdsZwWFnmkIj+T9Yf9qH9ROTHNvBzNE6eQnDV+RibpHNoA9GCLuKKBXdUQXDAhxr5
 l0x2r91am3r4a+o1Mc7uUin2rPRble+zcqJoRjX84ExuJvXQBRYMmPtZ4zHZirs1G/zF
 pTXnJMyRkPdcyWA+0KOR2zRh6cUO24QL3YJYSybhBAhlHay/FKP5ePYo/OKIrdhTtLp8
 q7zA==
X-Gm-Message-State: AOJu0Yz7Sc6+3eTYgNL36WiKShGqh49Vnt2iuI3V2ixCzEClDf6AdocX
 wtLHItBlNLHDsHeA2MrmBnFScyGwHqJEbMLLZFqQqW57eAWTKbDd0PSgsd5TIMIK8rc=
X-Gm-Gg: ATEYQzw0pOMeyeEOOcOt0CIK/r11c2+ocaV7LNU/jz5XNXOJrDHIwJQV9p83MIhVRiQ
 eV2zWxg5LnlQpluy1ZLOHnxxQnyfxQ7da6F7i2YJ302y5Nb4oEnpXNbGm2DBFWo/EyZ9YBuJ0zx
 oac5kl8VoKvAV2rtJnx14onoy61JvKQmAy2t9vriDXgox8LcPyDNwKYL+AcI5TQLI5hTBW3E3ct
 AuAEhYcEy78mZH+AzEaOMSSAmBAH8GurnU7ZzyS7PeRVi+DpQMT1DFl65jbOiQNi6GBt5CBjQcd
 BUAGDeAJIId4X+78eZHI8AcLvxqld5FJHw6pFiUtDNStuhFtG4uq9NQ2v3cpwHB4/PsiFYHk7aK
 gfPTl1eOVhFyKXsPN3mK+P+myWbisn343ebhGz9EFpu4gyzmJYsiSovVMIldog4g9q/RNby9Rcc
 w9sTDgHi7XtPOt9Pt8W6puj7YhTUvkxrq1gO6A1Z/6WtzjMpNBZag2dBBvp5aAKW/j1Ps/4GBmR
 2xVzg==
X-Received: by 2002:a05:6000:2301:b0:439:be67:a02f with SMTP id
 ffacd0b85a97d-439f842c0a0mr4905087f8f.37.1773235900349; 
 Wed, 11 Mar 2026 06:31:40 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a9e25sm5903038f8f.15.2026.03.11.06.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 06:31:40 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 17:31:01 +0400
Subject: [PATCH v6 6/6] rockchip: rk3576-nanopi-m5: Enable UFS support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-rk3576-ufs-v6-6-c7c353739242@flipper.net>
References: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
In-Reply-To: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=alchark@flipper.net;
 h=from:subject:message-id; bh=MYI7C+v+Y8HLbevdhZgA5EMU7yIMGDbC5lBKKTl6hfk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRuzFugqM4Qufil6LnTa1Y5Xr0Vl3t2b+T28p+/8pbnP
 k/qKn6/pGMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTUMdYxYuDiFICpnrCOkWGKbElqcmHplSsCb0qjqmbLfInf5VFdueoGN/9vMe/laecZ/rvdOD+
 Tu9Jnzrld+n+sLrLpJvS/NRC589rErmlPm4blZh4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

NanoPi M5 supports UFS modules to be inserted into its eMMC/UFS slot,
using the on-chip UFS controller inside the RK3576 SoC.

Enable respective drivers in its default config to be able to load
kernels from UFS.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/nanopi-m5-rk3576_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
index 28427390a62b..558131bf81c5 100644
--- a/configs/nanopi-m5-rk3576_defconfig
+++ b/configs/nanopi-m5-rk3576_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
 CONFIG_SF_DEFAULT_SPEED=50000000
 CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-m5"
@@ -19,8 +20,10 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-nanopi-m5.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_UFS_SUPPORT=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_ADC=y
@@ -30,6 +33,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MISC=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -63,6 +67,7 @@ CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_RK8XX=y
+CONFIG_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -75,4 +80,6 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_UFS=y
+CONFIG_UFS_ROCKCHIP=y
 CONFIG_ERRNO_STR=y

-- 
2.52.0

