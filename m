Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B86606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IAzWSqfT;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQcgjjsB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18643405F6;
	Sun,  8 Nov 2026 14:58:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id prYgPG0CBTBx; Sun,  8 Nov 2026 14:58:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 32C68405ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794149911;
	b=OCLgFpI+F5dihAOWL6fX8nngXZtxt79wqDXEAsfzSo1hKP9WNGfZNe+n46gs+gqcLVtA
	 dIgJnmUiZADIin9VjgWaNJu3M2E0y4vLwND7FeEZ1DUBeR7U7A/w/bMmx2ORZ4DEufOXE
	 nihEu8Pg0mEdoLjwgaXorO+Sxl8EfS+4nJVOifcfsLxNqrOyJlh5RIo9U1oMvl9uXnKAh
	 /EPo9h/IFdcuz7ZvuwdGPeXPYpfJJKxloWMPSEUERE7c0uQ37DAQxVDsJZUJ2Y+4u1tYl
	 lrfAOqEdhlb6xgPC6tYUVOi2Cj/L4k5RK9qXwIBlfwCX28Qr04BQV6oJcUx/i8j4vlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794149911;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CTDnOaibLqnwl3OtMhUnYq1iWg2nMUYtOJi/ZN/soy0=;
	b=JRA6ZdDOA5gH1PS32AGrk3D89D07kGghW5wrWu5vUJVjmf1AS+clHUJJgfCTwB9ufJTT
	 U/EfmwMy8PdM6AtHgPuD38+ntkJ16WZCT03FFOZUmqZy4TEe8AfhlSl6x5NzqnT5iwUhq
	 XlSEzvmNFtinrl2Ds4gW/29JzYxjxmZQoDUGeqAdFxm0NF6JOJ4dO8GZiteLQXnfjnQvP
	 pJw++nzebujrkg/RMw69CCscUsT+a4yMh6XjC3wGCNrLFuiTDJCUj6txz3DpJlP3vr+Gr
	 tl6NCXDNgCHW6dJdSuegJdWsamaydw6Q741OFMsrc1os5eptRXi0yntgsBsFKD/V1CQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794149911;
	bh=CTDnOaibLqnwl3OtMhUnYq1iWg2nMUYtOJi/ZN/soy0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IAzWSqfTKqr49sjB30ry8ONHE/1Kf3/nXtVZRM+lnYcTWaCVtsTzwrkKtpbtdOnrL
	 S9R4K9aLMy/1l3jKbg6w1jZT9N5BT7nUDE8MOrfkzz9kFWbpsfcViVA1icVFsNK+Vu
	 XiDOkomxiczXzzaJVHcC80qsb7BmTy6J0fYj8jMeK5ybEq4LLKt8uea6nIAvRNS5AU
	 WyTDWQs3zv7z+o0dpIn/OQELpwVCQSe/+oZrnALk9k9vBOhX/V13nySpyzQh6MfuSx
	 U7Ye22kxw5F01zfDabfF+OVDOsGDQc0pMbQDl4AbBjptiEC5RJKLqQJYL8/wM/i+te
	 ilZHgX5ybz4Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32C68405ED;
	Sun,  8 Nov 2026 14:58:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 158C42AC
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 14:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0720A80AA6
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 14:22:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YSkTgGz1AF13 for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 14:22:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CFEA80DDB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=iudalov08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mQcgjjsB
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CFEA80DDB
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 14:22:12 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so83551f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 06:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794147730; x=1794752530;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CTDnOaibLqnwl3OtMhUnYq1iWg2nMUYtOJi/ZN/soy0=;
 b=mQcgjjsBBzgmYOY230qnKZPJCZtq2LzbP/XNPcUh5Xru2RTBTl+wN8xqWDj/yqVQ2x
 vBrj7aWRmlfEbqV1H3IfDT9NhUlolyU+tQcjcCX+bOG1cRBq6/oY7sAL7uyKNMZ5yarn
 JDfAUPpvnNrUcchDm7FyxwxGgJMbjCrnjpE+wAeGHQqtXU3sOHDxv8oEPnCVLc9111Q3
 lpolOCtf0FfRSw3Ep16wZFAF+f+sx+ETmq3DlkLQDxWDfHTabq4HUjdprVD2fgUjthfR
 wPWZ3aG65P58vDPAZ9Bo5vphl9joaoWIxYeqxUgJqw0sGisd2TkStbyt9C97xR5pVWTZ
 VuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794147730; x=1794752530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CTDnOaibLqnwl3OtMhUnYq1iWg2nMUYtOJi/ZN/soy0=;
 b=mqzZkxYunP+ZzyVZPscFNI6FJdBxYMDpx2L0BAo/50DFhp7g0/2BMGmrbwD2vcWeRh
 it1ixOYuQruX9TX1PbleFvDLs07Wjri3IS2zJynpKehieXsvkkRD/AqmNaodO66uGvta
 xZKzQYZJj9+Hjl7OQ7sM9KV8pkjn+JyuFjohsMF8WStVwZkbuISOeSidV4b28MWKRk8j
 qmms0BB6ptrbn7EUacOlTTTCeogQiKII3gx6bRL38r+R91Jpon6c4XBy46OwN6NClsAm
 366EEJulpNU7tpz3aBpRFgR6J/YPx3ZwGsSRjjGvMiIGXPErv7Zs2bV8euZcgUIgJVl8
 Mkfw==
X-Gm-Message-State: APuU4Z+HzFfVglDqkf5q3NvFM3y54k5ooPMrvcrk/TOEE5Kl8zr3Ykqw
 Uwx/+vqxZlhP0C7DX0nDVDfjGLGISzgnHUB2xieY9GRC5/4dDEtF5sXPCSwpBYgS
X-Gm-Gg: AYBFou2qFyxDWsJp4/i9llZpQc1ATIIeP3Gwzzut6mTA9Y5Gv7DaNPHNH4hxBiDoS7T
 hA63WzQsvfa5pfqc1c/mdpwux7odQWGSqyon6cY42S+YiS9pfQAvi0bZ23Bp4WJdj+ihzGZsW9v
 7oURyusHHexkAGhuuoAs9Oohj1h8Bh9UuMWqLEQCcKDXJc3zpI5X5oE9yr6cUSIu2HvdYiaTg8Y
 CqEQTq2uEbvMZu7U4VKyiD7a6MXEk2g5Dyn20cqRhRkiWQaZZKh4KduLSXMZtA4m+fq1QzSUM+z
 N506Nd1dfJgpgkENd39fpmYO8fx8ALH6DwXajcmGvLVNzRhyRry8dryNz0EaDSPEUjCooa86Ga6
 AVW+sAwZxwrV0rr7H1B+jl/n++FYPSNeTF1LF3+h/J78JMWW0AVpBeeX1mBbRkgz8WJo2Hg42aD
 SeIjpzz4pBedLJka/sqreoyPzBNdX1j/2D1tlF3TRelUI+8lJ6oTTqOaf7FdX4pNQRpjgEFHphM
 4isy2BR7zgbA4IvDPJ59Hghw9XfIgw7tNcbpAaSJcdRLjvnJSTD7RAyQGm3rkPUOlIsdfXW0X8W
 RukZyAlAJrI0JSm7MqHzqbNBGEYUZ6zZKXzUGx42BQ==
X-Received: by 2002:a05:6000:3ce:b0:48e:e98:8b6a with SMTP id
 ffacd0b85a97d-495877b999amr3067270f8f.4.1794147730379; 
 Sun, 08 Nov 2026 06:22:10 -0800 (PST)
Received: from localhost.localdomain ([195.178.19.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597186eb9sm4123208f8f.35.2026.11.08.06.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 06:22:10 -0800 (PST)
From: Ivan Udalov <iudalov08@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Ivan Udalov <iudalov08@gmail.com>
Subject: [PATCH] board: rockchip: Add 100ASK DshanPi A1
Date: Sun,  8 Nov 2026 16:21:49 +0200
Message-ID: <20261108142149.230620-1-iudalov08@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 08 Nov 2026 14:58:29 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

100ASK DshanPi A1 with Rockchip RK3576 SoC (4x Cortex-A72,
4x Cortex-A53, Mali-G52 MC3 GPU, 6 TOPS NPU).

Features tested on a DshanPi A1:
- SD-card boot
- PCIe
- USB HOST

Signed-off-by: Ivan Udalov <iudalov08@gmail.com>
---
 arch/arm/mach-rockchip/rk3576/MAINTAINERS |  5 ++
 configs/dshanpi-a1-rk3576_defconfig       | 75 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 3 files changed, 81 insertions(+)
 create mode 100644 configs/dshanpi-a1-rk3576_defconfig

diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index baae63fc7b0..6eb00f0de6a 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -33,3 +33,8 @@ M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	arch/arm/dts/rk3576-armsom-sige5*
 F:	configs/sige5-rk3576_defconfig
+
+100ASK-DSHANPI-A1-RK3576
+M:	Ivan Udalov <iudalov08@gmail.com>
+S:	Maintained
+F:	configs/dshanpi-a1-rk3576_defconfig
diff --git a/configs/dshanpi-a1-rk3576_defconfig b/configs/dshanpi-a1-rk3576_defconfig
new file mode 100644
index 00000000000..a3ff2e58dfc
--- /dev/null
+++ b/configs/dshanpi-a1-rk3576_defconfig
@@ -0,0 +1,75 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-100ask-dshanpi-a1"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-100ask-dshanpi-a1.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_UFS_SUPPORT=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_UFS=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_UFS=y
+CONFIG_UFS_ROCKCHIP=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1f4e58c8be2..9dc67f0b4d8 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -144,6 +144,7 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 3B (rock-3b-rk3568)
 
 * rk3576
+     - 100ASK DshanPi A1 (dshanpi-a1-rk3576)
      - ArmSoM Sige5 (sige5-rk3576)
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
      - FriendlyElec NanoPi M5 (nanopi-m5-rk3576)
-- 
2.56.0

