Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16A3CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2071083957;
	Sun, 31 Aug 2025 18:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="visLPKi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31616839DE; Sun, 31 Aug 2025 18:51:33 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31AC83929
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659089; bh=28KWmwikGGjJaU3XyGTCUbFsKSYzMDXlnEmLw3ZQnhA=;
 b=visLPKi7fyL/FzIttz1eje1h+jIpzyhozz1mA92EIsNfjDHq3Ncci7agbpFvkpce+wZ8lDY3V
 UqAN/ONVI0yIHN72aZckWp38hfRxrEZL+BfGHhA3F5zex+u0FD2rkdIxhpnE9RxDziOn4qZzgPs
 I4SalKVHFiLWqMz0oIf7UWX2fTeIFUEQhzRaLHsNAJNQlH88TjUtpH8kYvKok+VPtID122Cye6M
 k+UtVDppQ1Jhny3Bi7H+EBK2MqhdyY9CKRJ5KwPavJ3oRCRT8PLwQvnU03hxhXvJXRIg5QuMU7+
 uA4OZJrQUsdVn7r09wOB0cLpWLtSDMFZnV7iIHJbdntw==
X-Forward-Email-ID: 68b47d8b7f68b507ca9c3b80
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 16/18] rockchip: odroid-go2: Enable more commands
Date: Sun, 31 Aug 2025 16:49:33 +0000
Message-ID: <20250831165001.2749711-17-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable the default commands and some more useful commands that can be
useful to determin the state of the board from U-Boot CLI.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 configs/odroid-go2_defconfig | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 70d74c65a2f3..512ffefc70f6 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -42,22 +42,21 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_BANNER_PRINT is not set
-# CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_ELF is not set
-# CONFIG_CMD_IMI is not set
-# CONFIG_CMD_XIMG is not set
-# CONFIG_CMD_LZMADEC is not set
-# CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT=y
-# CONFIG_CMD_LOADB is not set
-# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_ITEST is not set
-# CONFIG_CMD_SLEEP is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
-- 
2.51.0

