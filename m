Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CA0C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642C582977;
	Thu,  8 May 2025 23:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="gQr/Z9Cj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8BE828C2; Thu,  8 May 2025 23:24:23 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C85E82AA8
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739459; x=1746998659;
 bh=E7FRRVUC7UOz3l2fzdBzBhJ1TwgzocrRTHZZFEnbGc0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=gQr/Z9CjE6sGl03Vz32N+7CoKtFXDJDU51O+iN4okVr16qeAyGtLwpwXgcOu+gSIC
 +XU0XjNNeRMebu4JJVNsJzMahiGM5cEzltVJz/xyw2cxNnIMqeKG74dwAN8yOglBxb
 MYMZk5LgEvOiVNHGBPoi/wog5qWTf4OlGz37j9QzYfgDLrbeSrapnQnALh1/oIhA/b
 0AreDsY2oPcYsJLu2wYlzy1X2HDGE3vXgv0GqkXEDthLNfFzd92HzH0ME5w5CtuKr7
 s8Di1obOM2hjwiAya/UJdVQmE1kfwmzIpNuiYonV5TlNqNLxWuZgioc6IuYYF5YogH
 Rm0/Pahtj3LCw==
Date: Thu, 08 May 2025 21:24:15 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 06/10] configs: add STM32H747 discovery board
Message-ID: <20250508212058.640483-7-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 2a3383c466eafc7320a34fc0358452f7a016cd50
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add initial support for the STM32H747 discovery board. The
configuration is copied and modified from the STM32H743 discovery
board.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 configs/stm32h747-disco_defconfig | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 configs/stm32h747-disco_defconfig

diff --git a/configs/stm32h747-disco_defconfig b/configs/stm32h747-disco_de=
fconfig
new file mode 100644
index 00000000000..8a0c72450d1
--- /dev/null
+++ b/configs/stm32h747-disco_defconfig
@@ -0,0 +1,35 @@
+CONFIG_ARM=3Dy
+CONFIG_ARCH_STM32=3Dy
+CONFIG_TEXT_BASE=3D0x08000000
+CONFIG_SYS_MALLOC_LEN=3D0x100000
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x24040000
+CONFIG_ENV_SIZE=3D0x2000
+CONFIG_DEFAULT_DEVICE_TREE=3D"st/stm32h747i-disco"
+CONFIG_OF_LIBFDT_OVERLAY=3Dy
+CONFIG_SYS_LOAD_ADDR=3D0xd0400000
+CONFIG_STM32H7=3Dy
+CONFIG_TARGET_STM32H747_DISCO=3Dy
+CONFIG_DISTRO_DEFAULTS=3Dy
+CONFIG_BOOTDELAY=3D3
+CONFIG_AUTOBOOT_KEYED=3Dy
+CONFIG_AUTOBOOT_PROMPT=3D"Hit SPACE in %d seconds to stop autoboot.\n"
+CONFIG_AUTOBOOT_STOP_STR=3D" "
+CONFIG_DEFAULT_FDT_FILE=3D"stm32h747i-disco"
+CONFIG_SYS_CBSIZE=3D256
+CONFIG_SYS_PBSIZE=3D282
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SYS_PROMPT=3D"U-Boot > "
+CONFIG_CMD_GPT=3Dy
+CONFIG_CMD_MMC=3Dy
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=3Dy
+CONFIG_CMD_TIMER=3Dy
+CONFIG_CMD_EXT4_WRITE=3Dy
+# CONFIG_ISO_PARTITION is not set
+CONFIG_OF_CONTROL=3Dy
+CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_NO_NET=3Dy
+CONFIG_STM32_SDMMC2=3Dy
+# CONFIG_PINCTRL_FULL is not set
--=20
2.39.5


