Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D50CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 22:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7880C87047;
	Thu, 19 Oct 2023 00:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uSV4/A7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6757D86F9A; Thu, 19 Oct 2023 00:31:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A27FD86E7E
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 00:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bda0=GB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1697668274; bh=IixNTx3PCaZyj4EQI2lhppInHjbSNkZdBaGNO0WQMPE=;
 b=uSV4/A7VKYIJ3kkuV1u1coEkJ4v87B5axYJAm3sAZjGoV4hRJIl30zrzQS3NCXjZt+QLSIKJu
 sSj44pR5F+GiN8e90jN8YS819lTSax/E+HWPGyz0OitLqcoUnLfhR1+ojwFObRHSr2Aj7sJL2LV
 wLAo/Q1BML+Tm4+7flfJLE45Nbn97FHl7Eg2QgPwaiicVrnz6K53Cjesy1ChdomE9RKrHG8KZq+
 vXdFkmMVe9f362QFzj1OESHBFut2BblPfaPjJEs1RhsTDNqqJOjP86eUI/VLFS70R6myhcHrFZn
 eNwdFEvbo3jPw7xTXK7han3nNpKOfuCox99wmlGKEtIA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Andy Yan <andy.yan@rock-chips.com>, Nick Xie
 <nick@khadas.com>, Jagan Teki <jagan@amarulasolutions.com>, Deepak Das
 <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>, Xiaobo
 Tian <peterwillcn@gmail.com>, Tianling Shen <cnsztl@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Levin Du <djw@t-chip.com.cn>, Suniel
 Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>, Akash Gajjar
 <akash@openedev.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] configs: rockchip: Use dwc3-generic driver on RK3328 and
 RK3399
Date: Wed, 18 Oct 2023 22:30:51 +0000
Message-ID: <20231018223058.2081052-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018223058.2081052-1-jonas@kwiboo.se>
References: <20231018223058.2081052-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65305cb153b629052bafed79
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

Change to use the dwc3-generic driver on all RK3328 and RK3399 boards.

MISC, USB_DWC3 and USB_DWC3_GENERIC are enabled on boards that enabled
USB_XHCI_DWC3. Also enable DM_USB_GADGET for any board that enable
USB_DWC3_GADGET.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/chromebook_bob_defconfig              | 2 +-
 configs/chromebook_kevin_defconfig            | 2 +-
 configs/eaidk-610-rk3399_defconfig            | 4 +++-
 configs/evb-rk3399_defconfig                  | 1 -
 configs/firefly-rk3399_defconfig              | 1 -
 configs/khadas-edge-captain-rk3399_defconfig  | 4 +++-
 configs/khadas-edge-rk3399_defconfig          | 4 +++-
 configs/khadas-edge-v-rk3399_defconfig        | 4 +++-
 configs/leez-rk3399_defconfig                 | 4 +++-
 configs/nanopc-t4-rk3399_defconfig            | 4 +++-
 configs/nanopi-m4-2gb-rk3399_defconfig        | 4 +++-
 configs/nanopi-m4-rk3399_defconfig            | 4 +++-
 configs/nanopi-m4b-rk3399_defconfig           | 4 +++-
 configs/nanopi-neo4-rk3399_defconfig          | 4 +++-
 configs/nanopi-r4s-rk3399_defconfig           | 3 ++-
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 ++-
 configs/orangepi-r1-plus-rk3328_defconfig     | 3 ++-
 configs/orangepi-rk3399_defconfig             | 4 +++-
 configs/pinebook-pro-rk3399_defconfig         | 1 -
 configs/pinephone-pro-rk3399_defconfig        | 1 -
 configs/puma-rk3399_defconfig                 | 1 -
 configs/roc-pc-mezzanine-rk3399_defconfig     | 2 +-
 configs/roc-pc-rk3399_defconfig               | 2 +-
 configs/rock-4c-plus-rk3399_defconfig         | 2 +-
 configs/rock-4se-rk3399_defconfig             | 2 +-
 configs/rock-pi-4-rk3399_defconfig            | 2 +-
 configs/rock-pi-4c-rk3399_defconfig           | 2 +-
 configs/rock-pi-n10-rk3399pro_defconfig       | 2 +-
 configs/rock960-rk3399_defconfig              | 3 ++-
 configs/rockpro64-rk3399_defconfig            | 1 -
 drivers/usb/host/Kconfig                      | 1 -
 31 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 1807e838223a..b5a5ae737e52 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -98,12 +98,12 @@ CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 638beee2c6d3..20913d2cf0fe 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -99,12 +99,12 @@ CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 77edbdbf9597..22ad98b95ad3 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -56,8 +57,9 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index 5740ffc38f6c..d6140527b752 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -66,7 +66,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index b4660a051dfd..b7c8e95b7b89 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -66,7 +66,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index ed06fe7846e6..8b6935d86730 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -43,6 +43,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -61,11 +62,12 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index 9df945e6c0fe..070f0ea48c40 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -42,6 +42,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -60,11 +61,12 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index e216c0e86f7f..5344ecd1f20f 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -43,6 +43,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -61,11 +62,12 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index fa936609e9b1..76dd91911c7c 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -39,6 +39,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index 82e86ca07026..a722891fdd75 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -43,6 +43,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -59,11 +60,12 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index dd715517d5a1..e3bdbccccbec 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index 3da93db06da3..e51e51c8cf5c 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index 701dde15f3e2..ca57c7f81a51 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index 3f9d0340c81e..02e7f4e2ecb7 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index 4f4363cb0f90..cacaab14d21f 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -63,9 +63,10 @@ CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 0ea45df33338..d3d9417509e9 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -71,6 +71,7 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
@@ -99,7 +100,6 @@ CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
@@ -107,6 +107,7 @@ CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_SPL_TINY_MEMSET=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index e3d7f0b8aeb0..9356e87132e7 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -71,6 +71,7 @@ CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
@@ -99,7 +100,6 @@ CONFIG_SYSRESET=y
 # CONFIG_TPL_SYSRESET is not set
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
@@ -107,6 +107,7 @@ CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
 # CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_SPL_TINY_MEMSET=y
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index ba6d91e877d6..27add8a29b92 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -40,6 +40,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -56,9 +57,10 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index ae3211bbe9c4..de357415fbe4 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -96,7 +96,6 @@ CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 11243bc5c193..d08224fe536b 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -85,7 +85,6 @@ CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index b632fa3dcf34..c2aa02ec74bd 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -97,7 +97,6 @@ CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index 06d97c3e1a2d..f4b2e394cb35 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -80,8 +80,8 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index c53e8622431e..ff4c7b55726e 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -81,8 +81,8 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 3028a86705ca..2e730f029b43 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -73,8 +73,8 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 9abe8bf85354..083fc80e5471 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -75,8 +75,8 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 84e0dcf02827..fedf0dfd7b77 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -76,8 +76,8 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 5c9fb14787d8..9e8664bfa6b4 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -73,8 +73,8 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index 1978fd525b8f..3bae2a1e9c3a 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -67,8 +67,8 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC3=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index fee10c471946..f74864b6eb90 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -50,6 +50,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -70,12 +71,12 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 4cd6b76665bd..44171aac06a6 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -93,7 +93,6 @@ CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 1a883babf4c2..85dcbac3aec5 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -39,7 +39,6 @@ config USB_XHCI_DWC3
 config USB_XHCI_DWC3_OF_SIMPLE
 	bool "DesignWare USB3 DRD Generic OF Simple Glue Layer"
 	depends on DM_USB
-	default y if ARCH_ROCKCHIP
 	default y if DRA7XX
 	help
 	  Support USB2/3 functionality in simple SoC integrations with
-- 
2.42.0

