Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EB2CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E1B84922;
	Mon,  1 Jun 2026 14:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kkZKiCMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB37784881; Mon,  1 Jun 2026 10:12:57 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898F084867
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B593601E6;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B7A7C2BCC6;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780301572;
 bh=fRn9Y587h0G3CGAuo4mNVg/A3/FQhrXacSW4OiBxHhs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=kkZKiCMZn63CnSX3VtBO/vAUxsO47tqFERW6HFRpBMkoRs0EOTwgKpdjC47InLJjG
 vveZcBImmah6xaydnEbYPSnB86i4oUx/x1/VDNnDGuR4pSRJJNsVYMcx7cpVYrka71
 8bdaMUEl1bCpeAojEriWzV9vmq6NBBBH5FW4a3XXG80ngBuVqBABEOINwvQefCYcAy
 mBR4qVqwqnxvOv0jq6/pFp//4grtmbwJxxD47khCIR7K59sfBv/p+SagMBo5D7rQpl
 gtaBDD0GGJrnbAgUBpcxXPplnl9OmtzPonHxi9Z7Hn0yegblV01MfdSl8Z8uQCLjKA
 MUzFkk1ZsMNNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 41488CD5BD1;
 Mon,  1 Jun 2026 08:12:52 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 01 Jun 2026 18:12:48 +1000
Subject: [PATCH RESEND 07/16] configs: introduce qcom_armv7_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-qcom-armv7-v1-7-05a08d87e476@samcday.com>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780301569; l=2157;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=mxwycB2A5GwzFMwdIjogaHy0a126Zo0vOB3W8d6mYkk=;
 b=qDOyuYXOpZ83YNvm+F7hI6hnRKxfhNmdB5Ft2rCdY7+Ku76rndA8oKv2cqupHY7enJkajZxoM
 UQ8A7RGPIoqBvWwXNWsE7CVfrIczk+CqFd7CAE6g64A1/Jogz7g8DgE
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

This new config aims to be analogous to qcom_defconfig, but for armv7
devices. It can compose with qcom-phone.config.

Signed-off-by: Sam Day <me@samcday.com>
---
 configs/qcom_armv7_defconfig | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/configs/qcom_armv7_defconfig b/configs/qcom_armv7_defconfig
new file mode 100644
index 00000000000..7d64ee68ecd
--- /dev/null
+++ b/configs/qcom_armv7_defconfig
@@ -0,0 +1,59 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_ICACHE_OFF=y
+CONFIG_SYS_DCACHE_OFF=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x80208000
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x88FE0000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/qcom-msm8960-cdp"
+CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_ARCH_SNAPDRAGON_ARM32=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTDELAY=1
+CONFIG_SYS_CBSIZE=512
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+# CONFIG_CMD_BIND is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_BMP=y
+CONFIG_CMD_LOG=y
+CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
+CONFIG_CLK=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x0
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_MSM_GPIO=y
+CONFIG_DM_KEYBOARD=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_PINCTRL=y
+CONFIG_MSM_SERIAL=y
+CONFIG_SYSRESET_QCOM_PSHOLD=y
+CONFIG_TIMER=y
+CONFIG_QCOM_KPSS_TIMER=y
+CONFIG_USB=y
+# CONFIG_DM_USB_GADGET is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MSM=y
+CONFIG_USB_GADGET=y
+CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_NO_FB_CLEAR=y
+CONFIG_VIDEO_SIMPLE=y

-- 
2.54.0


