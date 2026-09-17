Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4449AC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 15:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C27460B14;
	Thu, 17 Sep 2026 15:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLm_bFNozQ4H; Thu, 17 Sep 2026 15:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8DB1860A41
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789657629;
	b=j5wXPdxZ8pwmU02O17OkePSlSEOH8tF8Cro+C/IOqxqH4Swd7g33PqxEdbSTKdN23RBw
	 d3eS/GhetnShMk2v5P5U8nrFbJRvKhvgPwaC5kPIiV79V35qex5FgOnuu9NRss39LPfpj
	 a+eJ4dTV0vGcdpwuwfdxHOOCeKLCfal8ikHL3dG029tDNKW0hXZCE+8kA7LAp19d5b9j9
	 fvoLR3YO8yORAFhz4zLuYGm+SRSR+MEfUzZBkU0rQyzNINm07C7j3dObKoBLcb5m5f0gO
	 ca4RbM8AV5jjTAw/zmFFDzZuJeZvQXPriaPV5RBeeVDu+IYadLKDnLxvB4GjXDlf8tQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789657629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XlN/0Z2BR9vC9Ckxven11xiUei0hlE6mf7WdTBdpLMM=;
	b=QuYMnz+h67Pmzpp2b6VYWhy4UORfB/Zh7Vl5zlk+Bb9sXh4pKmGIkQIl6xqkNiNUAKa+
	 /KmQVABg+dpluhX4rdXNJkYLQMqCLYNTnh2kTeoJZ+j5k1epG20YgPLUryZbf1qDxu618
	 4BjZSe3PI6vwoFUoQWh8tbqnLanG+Wz7KIgLpf3NrOzMBgUPnlL8I0jk9bA5JuWfmXvEG
	 fJ9mBCp0dbdWBTCIB0JJk62oL3LIsOlr4FnSaw05e7C0aBTXk5P2hA+qdvB4BiI+H2BYT
	 lV3oCKYbDeH84w6Hy3w3uOjmDUeKbnzaq/D5kPJ0KDLRlcRd4rGr41eX5tAQ8HFSx1w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789657629;
	bh=XlN/0Z2BR9vC9Ckxven11xiUei0hlE6mf7WdTBdpLMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0bQwZsW5Hk+5FCx+vlg6qrGlSPHKrcvNyaElQRgL/76ZA76jdh1gDVmPVCLGpuO4i
	 46j2ZyOO1XhN5BhTqW/rXxMsSvQ5gsUOvJEyz8Htn+8J/dvt+bAnjq/q00HtjbP7qx
	 KU0uSNGNdkejw7bBkwBO9ykCWXWJpCy16I0ZJuobPFQ4DPoHpBss+FZ2UJdkrNYH12
	 fla7jK2rf8cHoYmPPGVv4H/B6OaVKP6KOucjDsFHgmJnFHckJI4k7OSpQkNBLDOGDz
	 c2ISFIBPjmq9qGn52CjPhkZJ0xj1lkioaAELBpRJ4Ml2GA1AWtf8WhF/m+Y/xOh0M+
	 N2JBhiVFrCxxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DB1860A41;
	Thu, 17 Sep 2026 15:07:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C5B337A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 727054051F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BOve8QVa0ZkK for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 71492404F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::27"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653887;
 b=J23FqCWjhT8FnCnIok1zDrsYEN8mBHt2Gnp1u2WEOXgcfpYQleLdiPju2k0L0FCoxrzi
 bsFUtBd96DqKuo6xY0prrjWnZpFoUC3gVZ6E5ss9n5DBizVKnKfPkBKOt06Q8iIeUwsdV
 1yxx8b6KhZ86SgQEJccYcgGk4PafEF6UqCVs23wDqPXDcCpY1MduZooagakjObONhUTeB
 /pOs2S4fIM7AexDGdeJF4gv5gmaTdlujJdsbIP4FrH1nVo7Xpe4AM81v9+2agnvdZwaHx
 57ADCtEBJk87DFVu5BEIIXcCEO+GzEy5wwMyV2s3ZTY5VecIqBVMukLglStEV6mxLyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653887;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=XlN/0Z2BR9vC9Ckxven11xiUei0hlE6mf7WdTBdpLMM=;
 b=WgaDwBj+Pj9pvVea9Gtf0mPphimXeisH43D09b0SJiJQ2YRKF1ktTQoUuFRrRQokNEyA
 Uu5jEE70O9HXGFGgP1xZHjjNRvg4HGGnMlQ/QBLztcb0RA1EaSQ9r1EGDisI38AsDek2y
 pvHeab9XMaL68HPwwxTK1qRFU486OdSsYLgUGwmm4+XkRrnYMEJcVribiPYLPJ9TySCa7
 Mk/PfqIDZC9dbyX+nB4VoQW8K7ykyOc1POSEtqEnOmjquogEjiID7aqVwS6XBPMLlASDm
 no18YoCqzvYb2eI+AZWhn3gkAXYe5eH72kw5lvCms/b8p8aaRHIv1ul7capgCvPBzjw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bMzFyWYW; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::27; helo=mail-wr2-x27.google.com;
 envelope-from=fractalclone@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bMzFyWYW
Received: from mail-wr2-x27.google.com (mail-wr2-x27.google.com
 [IPv6:2a00:1450:4864:30::27])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71492404F4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:46 +0000 (UTC)
Received: by mail-wr2-x27.google.com with SMTP id
 ffacd0b85a97d-4843796e373so529064f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789653885; x=1790258685;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XlN/0Z2BR9vC9Ckxven11xiUei0hlE6mf7WdTBdpLMM=;
 b=bMzFyWYWEDE50OmLz20S70CukOUeTbqAYzBVoD5781qHTUn+1dYCX4TKGMkCf4P0S9
 wHukcdo3pcaRbJ+tvmP+KrBYsZoUVMd44tXA+iMm/mwdWQ+xyRNQX8kNkHrINdF7NGVI
 /ljb5gk2EL3PZYsrDWbkCzRuB1P1gNMilKi39cyVnZ/K8H4WvGxWrj6xS+iMPgQB8OO+
 hx7txXA7dh86///zzAWTOiNm66T+OHbYdRnuM8TjEQXZvRNGQxs0SwEdBsktjD9ruVbB
 l4WaA5aVoFvSJ1LS+m5Zdnu+hZWP0ZRrN7JMXyaH8252/g1D5kpLAmpJnKYum+CczbDY
 6gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653885; x=1790258685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XlN/0Z2BR9vC9Ckxven11xiUei0hlE6mf7WdTBdpLMM=;
 b=PzciOipmYqR2OaSfkPQba+7U/Rne1Z5qPAwvlE+u+xxXYtsP4XLqfTf4mYvYuV448J
 e8EsNptQ+oPyqT/q7WK9S8DaIqjS65dv5n7aTTewIoJnXNWRiUBMwz1B/NhpnO3L9R/+
 uSqRMWiWJD3TIktga0v2+BVR/ianMsXDNApP8ViQrS+7YpiLVyLFhoFyW4A0vKSlEvQj
 y17j6FLzxG5HQoMPvb1T/9jBRRx1/kPpcBPuH+bO7GGsEXGmYtSCWpWtRX6KoPBlPVm4
 Dx7vVVqffJtBmHqy7m7Ve/hPMpKopDykAGp6E9Zik4hspU9diR/M0jClU7HnUElcMrjd
 Gtsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrzBJiZQf2bRNTQMcJ0KmLM8uerlm15MCk62+Pigizdgk/UNXx60YkzKH+oWSHnSVmgh8eNnI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kLGv+m3RwdzguI+dmKirDnSs6//LYNIJWxZJqnd0f8ZzWEZpFa
 nkwTBK7WsbRDpjZS7WEoAcALKEBkB3cLGBkzNi3Yneg8TIqjI5mxtVix
X-Gm-Gg: AYBFou1Lt12h0LSN51F5dVX7IKgn5EDseZFXqrq97De2hEdUn2SH9mjfrz0hvoOnI3i
 Lgj0+SIkcjlCLXCfMgh7GgaBkZzRFdFvxri3gtB/Tb/XLrNMnmpDXRBS8HissJPPMGEiI1AOZTO
 tZyDgb24iiLMwJZwCpIneMxAAmmFYQmQBo6aku/EVGVxEjGMUpBuZfFhqXAxk0P4rD8R5lVwYnC
 X6TSoqxazEhVJqUFi4+F9/2qlL9aSLkuh7Fwmrms0l9dFWzq5UV89fpqDtDsooaokwn22T76Cda
 +OafhA72ebhJnqg7kAMarIjCo5rAjipd6C8YEnqN3YDxjOPk9rMLqex6M0XNCOLE4p+2Q0lrlul
 UuFIlauYx/4/2rpqxQdipOOh01tTtQvGxMrNW5nBnRm7iNgvirgvmsTbHQJ0/KZbDpvXTKMLCbE
 BNhpsaR6SxLi162jrJ58A8RWdmJFju6k1xT/NcvTRo1xPOQUL73Oxe7cgKuXpYBIVE8F5GGzRz0
 ejhjYw=
X-Received: by 2002:a05:6000:4209:b0:487:a15:dbee with SMTP id
 ffacd0b85a97d-4870cf406cemr8865880f8f.21.1789653884909; 
 Thu, 17 Sep 2026 07:04:44 -0700 (PDT)
Received: from [192.168.1.138] ([139.47.34.204])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf34440sm15600634f8f.25.2026.09.17.07.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:04:44 -0700 (PDT)
From: Jean-Paul Etienne <fractalclone@gmail.com>
Date: Thu, 17 Sep 2026 16:04:32 +0200
Subject: [PATCH 1/2] configs: add config for rock-pi-4b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rock-pi-4b-fix-v1-1-1b3b52c38ed2@gmail.com>
References: <20260917-rock-pi-4b-fix-v1-0-1b3b52c38ed2@gmail.com>
In-Reply-To: <20260917-rock-pi-4b-fix-v1-0-1b3b52c38ed2@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Jean-Paul Etienne <fractalclone@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 17 Sep 2026 15:07:06 +0000
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

Device tree for rock-pi-4b is already available
but no defconfig

Signed-off-by: Jean-Paul Etienne <fractalclone@gmail.com>
---
 configs/rock-pi-4b-rk3399_defconfig | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/configs/rock-pi-4b-rk3399_defconfig b/configs/rock-pi-4b-rk3399_defconfig
new file mode 100644
index 00000000000..83247b98bcd
--- /dev/null
+++ b/configs/rock-pi-4b-rk3399_defconfig
@@ -0,0 +1,103 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=10000000
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-pi-4b"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_TARGET_ROCKPI4_RK3399=y
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_DEBUG_UART_BASE=0xFF1A0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4b.dtb"
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_TIME=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_DFU_MMC=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM_ROCKCHIP_LPDDR4=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_ERRNO_STR=y

-- 
2.55.0

