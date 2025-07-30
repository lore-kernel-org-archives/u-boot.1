Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDCAC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC6E832AD;
	Thu, 31 Jul 2025 01:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pSs7zL9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B7A832BC; Thu, 31 Jul 2025 01:54:04 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6517C8313F
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753919639; bh=q+/tpHgjLQZaWSU2+qE5K/9QSnpuVNBnVbnslSGOx0Q=;
 b=pSs7zL9U7JOpm3cRpCg7YspvwPYQ2P6AXUrSDr2PwY3ym1SBG1Tzn17NGV3ZgvSy1nS81EwZd
 9n1twC8rZLUMYxSlz6pqe6gOlQLq2T5eBRNiQftObipIuH92gE8c9gaIKQWkiT6qEvrGRSqXXri
 c/kG2NqnCOR/GwOAraJdaQ25b8MF4E50CTRsUa+/XmW2vuJuKPF8GOawM5er50dW1nE/Ju/0GnJ
 6C+jF0KZk+sl2to1JD5DBI89oGskBS22DxArnOh59zZTNUTRDT+aBHv9UryM/Jo+Aw6AspIYVnk
 KUvV0/goWjPenWMVGi/psVm9SS06FfSSs/CLHGqIpq4Q==
X-Forward-Email-ID: 688ab07f1851584377f621b1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
Subject: [PATCH 8/8] rockchip: rk3528-radxa-e20c: Enable USB gadget Kconfig
 options
Date: Wed, 30 Jul 2025 23:52:49 +0000
Message-ID: <20250730235301.1774089-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730235301.1774089-1-jonas@kwiboo.se>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
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

Radxa E20C has a USB OTG Type-C port for Debug and Data.

Add required Kconfig options to use USB gadget features once pending
USB nodes finally lands in dts/upstream by a future sync.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
USB nodes for RK3528 has not yet landed in linux-rockchip maintainer
tree, however USB features have been verified working in U-Boot using
current pending DT patches.
---
 configs/radxa-e20c-rk3528_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
index f5e097f3edf8..0941d1b9be81 100644
--- a/configs/radxa-e20c-rk3528_defconfig
+++ b/configs/radxa-e20c-rk3528_defconfig
@@ -20,6 +20,8 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MISC=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
@@ -28,6 +30,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_BUTTON_GPIO=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
@@ -43,6 +46,7 @@ CONFIG_DM_MDIO=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_PWM_ROCKCHIP=y
@@ -50,6 +54,12 @@ CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
-- 
2.50.1

