Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C9C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 11:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45AD878FF;
	Sat,  3 Feb 2024 12:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="C6MKt63Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338E88791E; Sat,  3 Feb 2024 12:31:25 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by phobos.denx.de (Postfix) with ESMTP id 24077878D0
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 12:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=g+ijE
 l1dSgmerpkuo5w36TAOkOmZfq3VItiJAWHhuss=; b=C6MKt63Qjgq11Wullmgd3
 4gxscdIZ/rwX9AxFIgmo4o5r7ZTFr2dL2rGRNaPKiMoVWU8bVLEokb1OnWLsy5J6
 XUCzZNpTZWVUgtAOBTZC+bf/AlrBbQ/Y7BHeN38oI5kqtyzEgm5SHeA6alPH2/f4
 DDkmHLa70s443CRaHGQg0I=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3fwH8I75lOgcgAg--.4168S2; 
 Sat, 03 Feb 2024 19:31:13 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: jonas@kwiboo.se, u-boot@lists.denx.de, Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] rockchip: rk3588-evb: Enable USB support
Date: Sat,  3 Feb 2024 19:31:07 +0800
Message-Id: <20240203113107.1945139-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3fwH8I75lOgcgAg--.4168S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyrXw4xAw17XF4fZw4fXwb_yoW8Gryrpr
 n7Jw4rGF4kJryfJaya9FWvgrZ8tFsrJrWj9rW3Ar15Ar18Jw43Cr1qvr17GrZFqFWxXr4F
 qas7K3WayF4UA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhBMiUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gJ5XmWXv3a2VQAAsv
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

From: Andy Yan <andy.yan@rock-chips.com>

Enable USB releated config to support
boot from usb.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---
 configs/evb-rk3588_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 0b7b4f2f627..8a6aa91cb29 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -40,6 +40,7 @@ CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
@@ -61,6 +62,9 @@ CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
@@ -68,4 +72,12 @@ CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_ERRNO_STR=y
-- 
2.34.1

