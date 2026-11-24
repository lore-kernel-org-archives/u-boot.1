Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC2606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mhEpOOon;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=pZav3FUs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55A55407F5;
	Tue, 24 Nov 2026 13:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JfWgVGGWfvYW; Tue, 24 Nov 2026 13:22:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8109A407EE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526579;
	b=FoELdf14FjHFzeQkSudRMF/fcg4cVjojuKszskfE/r+/V8uOmy18m/M1rIWJw2aI9TFx
	 GjeyMu3owHIP+GUzew/9wpJg56Ajtu845J0Fck5DZUrTsDoOJA7UBK0Z8Lc0qZiAgPGIZ
	 +SBNRt25oHugZ/e9c8uCiBvmtfdbOTTYB3JRox86Mtm79mi8IYfxN6p6kAisgmeyuoppV
	 ZDSPeDI9pqIDw8cFVw1OiZ5nwlAlkeRAgocG1XVNEGLMtR4uBDlkc9qN0wkxz6njNHXuO
	 nN3vnQZaLIdJQrSS4Nqwh331P3GtArzArpTPcBhj+Yo0MzxemPiYtkvZwYMIljrOZaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-OQ-MSGID:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cob4G3wbDSB0o3BTE2dkQU2KA/zzzvnHcpPKqWf8L/0=;
	b=S9rJc1mHdDicZMYLnRBPL/uKCGVIqwYDEFNLT0J7S9DRO7LouDPsdUw8pnRKnEwihvM/
	 He0TnGaVwu1K0roIGKnUL2knts0zl9AQF1N1Gw5YU1YZmqsN2NXhVLgeUsunRSB0tzocV
	 2uyvRo6b/RPUiy6bIy6wJswr7jhUHB5ViWpBAYETiImEfNVCp+HAD8gruhveKghLBR1+o
	 qBmxaSan01mirmfiKiUuGI0ibuaDoV/aDSFsvY/iXMIGKb0W0YrTaAHlCsevq/nINVFQh
	 N/i9bXne7fhHw5G7FZljByRPGvuygYC2dxANKpNF7dcNHxcsymsdzsUPgejdVcreiew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526579;
	bh=cob4G3wbDSB0o3BTE2dkQU2KA/zzzvnHcpPKqWf8L/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mhEpOOon/j0w8G08p5FJSgREoDkeHstEn3wA86QY30scXBZlIWe+X/BZoUCnaWLPq
	 9LQkwQco5rK3t3cEUQU5H6qN2JFbaghiq/O+ReWHJJ9+OgQq/xPtDgn4rjlS+Jaa+0
	 RpfrgJHcXpM+taVwAetTmMo6tQagfWwrhhdE9WqD7YNLJFOu/Qm2Eq1bCLe6/kxvRo
	 Ei38W42XBBU0xjEZmBRRG2oxFdKtS4g9fr/1zo0y/TLeqYOabeBQU/rlTOe3Ap82gt
	 P+CE7FmNc5bZVkNSmDGC4aiZmldG02plwFO32atyPqF+e/53+/xyb4aoAW73vriZma
	 eGn7ifnNNGbAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8109A407EE;
	Tue, 24 Nov 2026 13:22:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 53C6F27C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 321D2400C8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVdGp_xnBK1Z for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 07:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4A33B40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=203.205.221.235
X-Greylist: delayed 123 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 24 Nov 2026 07:00:34 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256
 header.s=s201512 header.b=pZav3FUs
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.205.221.235;
 helo=out203-205-221-235.mail.qq.com; envelope-from=fragrantorchid@foxmail.com;
 receiver=<UNKNOWN> 
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com
 [203.205.221.235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A33B40068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1795503630;
 bh=cob4G3wbDSB0o3BTE2dkQU2KA/zzzvnHcpPKqWf8L/0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=pZav3FUsvd7QQHtegvZRG+DhO/++8fF7Rp8H/n9dVYKmdziCdhj+6FcusxItoWsaT
 xu8JwgR+aOBUkoRDZkyglJpDxg2Ur/UdenWLNZpPq5IEpWNaRxiktLWPMXimIMOrvS
 26G8gDto62M42mS9z3EpIhCpA8Kq4LJnucQmepwg=
Received: from [127.0.0.1] ([223.73.111.26])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id E4D2D205; Tue, 24 Nov 2026 14:57:13 +0800
X-QQ-mid: xmsmtpt1795503434toyl86s93
Message-ID: <tencent_1A550397605E9386493CD0A1BE7DF34E0F05@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeRkerblRF595X0vcNG6g7M1mig2mkjVdQDrU8oZ7I9RU0/FDuHh
 awuzMap0BpBVFnTyjKVHizIaEQ3tt6fgPX53leH4jk8BwfdXxnO9FOo4sz8B6+ZosgE+DahX3VUH
 KtATQr+GNeHPQomxXi3tUaPfrt1nTFQIAPDvbLPHBXItntxnG/vjpM49OZGGvKLPJeXQjGQEo7JJ
 6bH0hJtbWwpbWPHoAasrSQE2tle9fE6WU9XS05IDh3HLaPdeH+DY+lV+95ZxojB2PRcHtnqdqIJ1
 o3+lOGIQKvCFOzYVWGFLcC4OVWzqC3pWE6q5kF0JEf+1/nK2TvtDRxKQE9j7iO2JfkhnipgmiTK4
 Ryxfj6/9ED/cARFNqW/QH8wynJHmlZcYunWW6do5ubdYS2jn2ZEeojrHpmspwJh7gnyUxSiGe3+P
 hZQFY2ENptAnxOz0w7OhB3g9As74NPskQltgD+KZ6Ns4dJ3Xz9yzw52fk1T0JpmEvWhi5ITkKSb4
 2rXQIb4TDjESfRR6BG0dX9v8XT7gkkcF8TqzCd0mqAPo3idvZvSrOGP/w/6mn0eG6wL5aVdhxdKc
 Uq/GQ+dHhsZEhFOedxtSJTWg0tTkTGRE8IszIC/ShwYxeXic6UsPdauEBkqTk1Jwd02a0fPmB4WE
 BRkqDN2RLA8GwDUl9mcs64m82vVUlYuU+a0LduZIXuqzdXEi019A1Koc6YL/YAaCyTtwDg1APl7p
 JgDoZ3PWrZQAZowJodnifIlGwBiFXk1sZvwojVHD8UblIMjUO8dbB++nf5ixaBBmVGDa3/nRhNNw
 M8rhflSiTk7CsdpYBC9JPNnwxxjQZ5QYVDQYxfmMryDhhemW4lcGZVTAem0KPa0PJGYt20icQkfE
 A83aIl3lybIm9ujUc4yFCwmtZPeu+3SjMM6OFVveHrMFVHJVWUUJMba1KzMRtkl9+TxLlhqbc84q
 oisFlFiXSV+sEoerVBazOwaoo3Y/0BlJAJypy2HdurriLgXxfr1bNMXn6OofLT/E/VR6Wghi3FJH
 Tm0MzaEFIxT46tOzV+FLgZVDnaLYgM2v9HtHMM0mv9/19yCWa5
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Xuechao Han <fragrantorchid@foxmail.com>
Date: Tue, 24 Nov 2026 14:57:14 +0800
Subject: [PATCH v3 1/2] board: rockchip: Add LCKFB TaishanPi 3M
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20261124-lckfb-tspi-3m-v3-1-2ade6e655544@foxmail.com>
References: <20261124-lckfb-tspi-3m-v3-0-2ade6e655544@foxmail.com>
In-Reply-To: <20261124-lckfb-tspi-3m-v3-0-2ade6e655544@foxmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the LCKFB TaishanPi 3M (RK3576).

Signed-off-by: Xuechao Han <fragrantorchid@foxmail.com>
---
 arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi |  8 ++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS     |  6 +++
 configs/lckfb-tspi-3m-rk3576_defconfig        | 64 +++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 4 files changed, 79 insertions(+)

diff --git a/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi b/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..abbef475d5b6d157a39a616f9bd531761fd1748d
--- /dev/null
+++ b/arch/arm/dts/rk3576-lckfb-tspi-3m-u-boot.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3576-u-boot.dtsi"
+
+&sdmmc0_det_l {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index baae63fc7b08a815b3a898486c021e3480f4b1aa..3c85649ef61d24397a7611765b12206f314b9744 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -4,6 +4,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3576-generic*
 F:	configs/generic-rk3576_defconfig
 
+LCKFB-TSPI-3M-RK3576
+M:	Xuechao Han <fragrantorchid@foxmail.com>
+S:	Maintained
+N:	rk3576-lckfb-tspi-3m
+F:	configs/lckfb-tspi-3m-rk3576_defconfig
+
 NANOPI-M5-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/lckfb-tspi-3m-rk3576_defconfig b/configs/lckfb-tspi-3m-rk3576_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..50dd903561c9c87d965228e00d5fbf6039f2d0e7
--- /dev/null
+++ b/configs/lckfb-tspi-3m-rk3576_defconfig
@@ -0,0 +1,64 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-lckfb-tspi-3m"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_BOOTMETH_EFI_BOOTMGR=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-lckfb-tspi-3m.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
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
+CONFIG_PHY_MAXIO=y
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
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index e22c2d6c575142e382ebf2d723581c09a21ce2ee..832c9043a141d68ff80fc96aa3573126a1449023 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -150,6 +150,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPi M5 (nanopi-m5-rk3576)
      - FriendlyElec NanoPi R76S (nanopi-r76s-rk3576)
      - Generic RK3576 (generic-rk3576)
+     - LCKFB TaishanPi 3M (lckfb-tspi-3m-rk3576)
      - Luckfox Omni3576 (omni3576-rk3576)
      - Radxa ROCK 4D (rock-4d-rk3576)
 

-- 
2.47.3

