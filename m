Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4B4CEFC42
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 19:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 376BE88EE2;
	Tue,  8 Oct 2024 21:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sMw2S5Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F4D88F0A; Tue,  8 Oct 2024 21:27:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791E58852B
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 21:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ecb7=RF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1728415647;
 bh=YZOsBcFOKv+nRGg+G9Xh5GPJWcGLVtJoEe4Y8ToJDjk=;
 b=sMw2S5RxYuPgxo+pYXO4on7HLoUwO/IX3rT8Zo3t6Zk6cEUKgCvwyOIk45mLmy23XTj+jfkVJ
 d7UcC+jBmcaYrhufH82MwIkFRHkgwwzzMVJoLgHm4tdtQ+eChSL3fAZ8Hj8gV0eGjoE4vgKh8xt
 htQWmyMRdiMHPqp4ZW+6/MNlh/OTrRpK0UVN7nboD6liXUfCfIfvUuVLPezbJx+w8RdRyTZq5++
 TnHe+fVMQkM4qc3PbOdG0fghnI5Y8yqUG4p9mUErMLupdNFy1ZDqj2nvOPKdnNTov3W/NZqR4Z9
 TqcsHgNR+uGA3JDWBvsJZXgGdoxgiCK9jllMiwGpGKZg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: Migrate to use USB_DWC3_GENERIC on RK3328
Date: Tue,  8 Oct 2024 19:27:16 +0000
Message-ID: <20241008192719.2192430-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6705879d94f108ef872130e3
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

After the full convertion of usb gadget interrupt handling to
usb_gadget_generic_ops, it is now possible to use DM_USB_GADGET,
DWC2_OTG and DWC3_GENERIC together without causing a build error.

Change to use USB_DWC3_GENERIC instead of USB_XHCI_DWC3 to complte the
migration initiated in commit 1bc4e8eb1d7f ("rockchip: Migrate to use
DM_USB_GADGET on RK3328"). No functional change is intended.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This has been tested on a Orange Pi R1 Plus LTS and a NanoPi R2S Plus.
---
 configs/evb-rk3328_defconfig                  | 3 +--
 configs/nanopi-r2c-plus-rk3328_defconfig      | 3 +--
 configs/nanopi-r2c-rk3328_defconfig           | 3 +--
 configs/nanopi-r2s-rk3328_defconfig           | 3 +--
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 +--
 configs/orangepi-r1-plus-rk3328_defconfig     | 3 +--
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index bfb85223437d..b3790c4d4ae2 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -88,13 +88,12 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index f311a0a80ba7..19fab59eff01 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index 533dc1029f73..65ffdd34d4d1 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 2591a9cc8ab2..751da1c446d8 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 14cdbd813c81..7786a3514b4d 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -104,13 +104,12 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index 7fe58e7a1467..e2b9ce705ecb 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -104,13 +104,12 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
-# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
-- 
2.46.2

