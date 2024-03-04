Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF49C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 18:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD95875FA;
	Mon,  4 Mar 2024 19:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709576762;
	bh=+0T+wJXL8FKfJJ0NSFTyDoBkQVpdNcYCKNfG6Czkoxc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FCIVOuAMVKmRVg3en8KTOFmvyx1e2Kipdfcq9TalIeefLKtnLNNM8GssvVerz1MHh
	 G/49d2YqL9+yfhcN0OZfyIq1ZEaSQdzjGczr7jw9JwvjDD7M3h2ysahFWedSTMBeZQ
	 581IpBYcPyATRGY8o0ZDvN+Cj/GKOf8hYaMu8m4TcPA5WUubgc5/YE4h9vi52NFqxM
	 v2KZo9sJm4VoIHUgbt0oFDdSCXjdhkV8kUo7xZzAW/71rrZTGbEb00jUKbYX8wl/4c
	 SqUpqA7DaktICY41Z3DukfFID0EozFH9rk5Mjyh5Y/zzL3L5KSJrEYkZv2RjYqk3x6
	 +BkF7cVOWeLBw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E04818758B;
 Mon,  4 Mar 2024 19:26:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709576762;
 bh=+0T+wJXL8FKfJJ0NSFTyDoBkQVpdNcYCKNfG6Czkoxc=;
 h=From:To:Cc:Subject:Date:From;
 b=vrugHAv0i/SEP+qmgN8+rWfakz0S6ySVhJSjqJuB1LKFTaS5NnLR1yePTf5ngswMX
 /Q89sX7781xN2oq5hU0X+CZNoqzTB8kCS14afPy40FfBd9wNcwkRsZSCljItzw0OnE
 mcH5wiwJ9wu+Hd63cORRf9ZHjphA5DKqBbP+lYkIycFCs6EVazWSO/xPbSYgMWSJOo
 m1lEaMH6dFlqw0eipymRaDdVPuCiIkodLY67edeoLbzaH64GnfWESMUnkN/f6euQpX
 eBL8f4rSuvDxu0W8dGNBrQJPFFZKzYl1UbW/ePA1n4/VJZDrl/P1QJ2ffWyrk0CDm+
 CePRlZVwBrkng==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] arm: stm32: Enable OHCI HCD support on STM32MP15xx DHSOM
Date: Mon,  4 Mar 2024 19:25:43 +0100
Message-ID: <20240304182553.106321-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

The OHCI HCD is mandatory for USB 1.1 FS/LS device support, enable it.
This used to be enabled implicitly before, now that implicit dependency
disappeared and this got disabled. Enable it manually.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/stm32mp15_dhcom_basic_defconfig | 2 ++
 configs/stm32mp15_dhcor_basic_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index 1d241529be7..0bfd3b76d6a 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -164,6 +164,8 @@ CONFIG_DM_USB_GADGET=y
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index 6e0c4a8cf9f..1c1fbc5c7db 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -164,6 +164,8 @@ CONFIG_DM_USB_GADGET=y
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
-- 
2.43.0

