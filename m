Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F48CD98C0
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 22:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EF986C53;
	Wed, 11 Oct 2023 00:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QgIN3RnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8DE86B33; Wed, 11 Oct 2023 00:24:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BBFD86C53
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 00:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f707=FZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1696976638; bh=ILVoIlNL+amwQ8YKvqefZwI5918Thx0kvvhJPIDoTUQ=;
 b=QgIN3RnXf/VOraHWAtoI5gWrZxsMqrOSCGRbDtrtwvFPXPpFyZApVe+DLziKoNjZWhSe3nlIs
 qWwJDJhnrKJu44MMpILq8s9vm87KAB6+WZ3mfDF9NstP8tgkYyoRm0GM+QP4a47TG16H4V8TLds
 UrQvvNl7WlJEZI5FTsYU5KAy+Q7sMRt5wyjsrLNm0O6NXJMVuG4v3NGX6/xbRdAjdZmwP5Ofiz6
 eb+s5YLVNBddKFV6U4BTs4mX6zQWuB+8UjdTLe4tUh69GR1WIkEapFvPSkrL1lEBOQW63oAqoHj
 Ai248PVvZYG9DO2hU0ZSXfRO6Q3oP8jokjb9vPgD2iZQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Marek Vasut <marex@denx.de>, Jonas Karlman
 <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH 2/4] rockchip: rk3588-rock-5b: Enable support for PCIe SATA
 cards
Date: Tue, 10 Oct 2023 22:23:36 +0000
Message-ID: <20231010222344.3436526-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010222344.3436526-1-jonas@kwiboo.se>
References: <20231010222344.3436526-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6525cefddfb1822b4d6ef306
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

Enable support for PCIe SATA cards and the on-board SATA controller.

This also revert use of CONFIG_PCI_INIT_R in order to speed up boot from
eMMC or SD-cards. Standard boot will initialize pci after faster boot
media have been enumerated.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Cc: Christopher Obbard <chris.obbard@collabora.com>
---
 configs/rock5b-rk3588_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 447913faccc4..ec22e70033a0 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -26,6 +26,7 @@ CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
@@ -35,7 +36,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -63,6 +63,8 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
 CONFIG_SPL_CLK=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
@@ -89,6 +91,8 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
-- 
2.42.0

