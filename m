Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B714ECA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 048938319C;
	Mon, 25 Aug 2025 15:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="uskz6B1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE2883043; Mon, 25 Aug 2025 15:55:46 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508BE8313B
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5CD3CC994E; Mon, 25 Aug 2025 15:55:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130143; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=I/67E1XuLPDEyOSyzEQ1UkF/HSp5UuBVALSG/aqrM0c=;
 b=uskz6B1o/lU5RlalI1T0FvhGQbY71cjCmD5NYxirbod62vXjpU0Os4VWxddEqylfVULCWT
 0qPMADgv5mXdOtyb/7dtkqdcmyIh5q2UIT3YxuCjEzDuxdIsJOfR6TNpdlanqI3nFVzl35
 ats8TbhWMW7PgKCzjYJPS7mBgI8riTNZH4wXBgMcrfZ3lhgzTAxaEs1iDgjk3e2aNTy3b2
 I541ZSdLimw54sxpepzz3KEImagxJviwtX7JSG7jk7BXKH1EJ9M5pehqLM+nsohBoXLzWe
 EEUgSsruy1L9tLzZngGz9afiP8aiAXfMAl3B6heSN20Al4Fc5RZXtE7oJJPafA==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, Marek Vasut <marex@denx.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 05/11] imx: kontron-sl-mx6ul: Enable fastboot support
Date: Mon, 25 Aug 2025 15:54:29 +0200
Message-ID: <20250825135504.193004-6-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Annette Kobou <annette.kobou@kontron.de>

Enable support for fastboot commands via USB.

Signed-off-by: Annette Kobou <annette.kobou@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 7ecf2bbaa9f..1831f99db46 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_BOOTSTD_FULL=y
@@ -69,6 +70,13 @@ CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="kontron-mx6ul"
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_NAME="mmc1"
 CONFIG_DM_I2C=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
@@ -108,5 +116,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x8f7fffc0
-CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
-- 
2.50.1

