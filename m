Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (unknown [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AD1CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 22:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C216388995;
	Wed, 25 Sep 2024 00:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727215761;
	bh=w3ownSHkCWxmq/vI06FfFpZ0827yjzd/Z7VnXH9/u5U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fkqLP3Q/X5iQY2uTQDRgHAK5fOKwb7qXW0zZYcFeKf/uyNyZ0emVGkKU2EF5Tlk5G
	 Imp9Dtosh0opXKD9/vX8M/4wW/x640wCWEzZMwoyzjbTlOflcZub7Q5gW9zRwTz05u
	 /dFwJOe4hfcg8ekiGoNwWabEIaXU2ZlLa0+W540T7YLKYRahLA7NW083B6j75bNagd
	 LH7sULzjFF7orQJjD4h86WaqSISmZhNBlMeAFMOJsFqVu5NI6POExoY8TWuB++hP+q
	 p7OTGHfQwJNwnSPktkcjKRzfY7BidmwML59UVJjHkEWL6lQoI3ymvaHJuHULEwHLMW
	 3z6modwGp/i/w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4BC4188580;
 Wed, 25 Sep 2024 00:09:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727215760;
 bh=w3ownSHkCWxmq/vI06FfFpZ0827yjzd/Z7VnXH9/u5U=;
 h=From:To:Cc:Subject:Date:From;
 b=zFVQnD5eAI6lktViWQ+S3Tua+qO5LvVM4vowGGuQGchjbE0+EfKLuOhNNKahRBmkH
 dlsIvUbFkThO7HAPl24AfGhEuLPQEg+8pDIe2TLG+cG6wOnQCKZBFLyMc7wTkp1xS+
 k0W6PYhdDQjQY/uJF52tm3A3JBeFtbF3/eUBWAe9b9+GRNsJXEvOt8TChQvGuKftsb
 fRHAgnosbgF07xPwKvvmuZ0eRJb9sehcEajchiBWroC3IADAbYsiS0IDQLNMyLtbQx
 +V8lcU+RsyZbr/ItRL1wRVVluDc313h+BG6Eln4qE9K9DNmPO1nevjoWZxbX/X6Qsg
 2hvW2r12G8xMw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] arm: imx: Enable always-on regulators using board specific
 workaround on DHCOM SoM
Date: Wed, 25 Sep 2024 00:08:23 +0200
Message-ID: <20240924220905.514122-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

U-Boot is currently unable to automatically enable regulators which
contain DT property regulator-always-on or regulator-boot-on. There
is an ongoing work to add this functionality to regulator core code,
but until the proper solution lands, add this awful workaround code
to force these regulators on. This is specifically needed to assure
the VIO regulator used to supply ethernet magnetics is enabled.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: This is for 2024.10 as a bad temporary workaround
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 board/dhelectronics/dh_imx6/dh_imx6.c             | 3 +++
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/board/dhelectronics/dh_imx6/dh_imx6.c b/board/dhelectronics/dh_imx6/dh_imx6.c
index c8dd30dfeaf..ada44e01424 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6.c
@@ -30,6 +30,7 @@
 #include <fuse.h>
 #include <i2c_eeprom.h>
 #include <mmc.h>
+#include <power/regulator.h>
 #include <usb.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
@@ -127,6 +128,8 @@ int board_init(void)
 
 	setup_fec_clock();
 
+	regulators_enable_boot_on(_DEBUG);
+
 	return 0;
 }
 
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index c635735d89c..a389ab3c2d9 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <net.h>
 #include <miiphy.h>
+#include <power/regulator.h>
 
 #include "lpddr4_timing.h"
 #include "../common/dh_common.h"
@@ -111,6 +112,8 @@ int dh_setup_mac_address(void)
 
 int board_init(void)
 {
+	regulators_enable_boot_on(_DEBUG);
+
 	return 0;
 }
 
-- 
2.45.2

