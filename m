Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D299BC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B668801F;
	Sat, 13 Apr 2024 20:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="t/s1RTn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B5387CF1; Sat, 13 Apr 2024 20:16:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4121C88262
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032154; bh=tcQ5GGwIO4RSEJ93smVGEE9fGA1ValdlXWnE7OLpmRQ=;
 b=t/s1RTn/aANZaYWYZdq9FR9mIcYJaka4x4ENmx/LkN5mYiYbgN5Y9baCG6rbWmwWopLsHiARz
 o0vPp1/hid6lZiTf1pAjBecIxYOt3Q/N+rKc9NlHGFX2HbiUloev4J+L5qiUFM1x0YT2GRCW/3O
 9gNPSBvLPu09Qk6cTYMPkyVesnfQExPexXYyj0a37H5KrkL0tAfpJjKKNQzkBP4965uEpzUJ+yj
 iaJQb3mnBK2bqvHCh855sli69aqzpWnN1z8rmRnK6KtvSTtz5aXnsW6vH2l0NBs/qL3swhAEX2X
 4y0NUcmJFiI1XMubuYg0TGEgifz8Un+scSXgMvXgOvug==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 22/23] rockchip: rk35xx-generic: Disable unused features
Date: Sat, 13 Apr 2024 18:13:56 +0000
Message-ID: <20240413181425.1384357-23-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 661acbd96fbb975d49a65571
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

The generic RK35xx board targets are intended to be used as a bare
minimum target that can be used to e.g. boot boards that mostly follow
reference hw design before a board spefic target has been added or
flashing and recovery purposes.

Disable BOOTMETH_VBE, NET and ADC as these features are not intended to
ever be used by these minimal generic board targets.

Enable SYSRESET_PSCI to let TF-A handle sysreset from U-Boot proper.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split patch and skip enable of SUPPORT_EMMC_BOOT option
---
 configs/generic-rk3568_defconfig | 5 +++++
 configs/generic-rk3588_defconfig | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 26114f9cb2a5..76c15ca27cc5 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -18,6 +18,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+# CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -38,9 +39,12 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+# CONFIG_ADC is not set
 CONFIG_SPL_CLK=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
@@ -68,6 +72,7 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
 CONFIG_USB=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index e96df619b59d..897456111215 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -15,6 +15,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+# CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
@@ -34,9 +35,12 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+# CONFIG_ADC is not set
 CONFIG_SPL_CLK=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
@@ -55,6 +59,7 @@ CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
 CONFIG_USB=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
-- 
2.43.2

