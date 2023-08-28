Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E92C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD0588647F;
	Mon, 28 Aug 2023 23:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1921286482; Mon, 28 Aug 2023 23:50:52 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C75386456
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.int.toradex.com ([84.226.64.168]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MWlJt-1qCufy0xhb-00XuQy; Mon, 28 Aug 2023 23:50:41 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Nishanth Menon <nm@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1] include: configs: verdin-am62: drop unused sdram address
Date: Mon, 28 Aug 2023 23:50:37 +0200
Message-Id: <20230828215037.482278-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kAYLCklHqI/iRfeU9JTSRvdILdiYrPSB9CCliMFMrFe5G8nyE1Z
 FAjGmAwFEMnURaYvJPv/oesiN5NximIOjxQZE8wcGTYCT8nrFcYYrXmTv09PLVlnFbR1GVw
 LInCHfA8pMBIniXk8CT1h9iDH9yDL99o5vdf5iA7ngtNZbQn0gjDyAsCP8IIDIEwdG2rkF4
 OSxCRU1Fj/xkXlzY9oloA==
UI-OutboundReport: notjunk:1;M01:P0:vVkgsbVIw10=;gBMqXNyAnXzWe/xoYY61lqpEPdI
 aECF3SpivobAzippQUK3R3p2MBQK8b4wTrHN7bYIsDUPpsVWFOWrq/nXEGQI+P33Lzs+GiAqx
 zI4GdQH31DnouFWXXcAzET0zIgmyw9k2lFWD6K8EQQyn8N9ZW4bxQfLO+eSYTC/a/DGPHdLoY
 Wiop/IAY4xh7Gcwzh60CF2NuaYYtfHEW5TWrdvWa5GIYtL53zsw3no9eZCaMcIYrkR5vaBX9x
 lMbzRFQCtXPkUw+284CWF/4+pAvgpj4FlFW0NF5fbhS/Eq3oFKs9m33po0A3paNMOfpeGMi3v
 vala64t9iSNCwuOWxQCgGfj92eQrvWW2UBhIj8B8ChIVxycw1dXhn/Cv5aFSQSZ1XfrmnztDN
 cSZQ3ng7mYYTS3sRACHqMBOt637iIMesrgtmrjtW1hkDxhOANv1oZlrj5/aJlpL8SCmFR9bJo
 G6VT7n/WmrQrEpzibXo3yGqEPS6SX6oVIniUGWqOXHZRlblPVPEpo0WkPYirRnwNSnE6nKF0v
 xxbQQrSEJ55dE9/OgmuvN2seZJrR8VVstDmaWPPkJYy5jVIDYqJv5d+3hk6/DKe33dpdDjXJQ
 OHsQQbDq82KYtp46Ib+6ccm69+0GXQlEtcrUlUZjVI/B4UpWG8acmWKXso5VZ5XFUCnxyEbuo
 O+WHBDSAH429ywFEsQRCwr2SuooM2+WqaE5aPNSyJLwbrK6gYxXGG8EQKPXFJte9PU/obp5Gb
 3r+TWk6Zrv4xQP3XSxrAYPGzwKT4y/hExOpg25R3F9ca3tAqT1l0rxRBuv20lCgY+ECxuYBP7
 L0lSvqpOnXwV/1Yj+tXud619aj84nIRAS+SlzaSD7PuVqYS/NB1U4WrJfRBDVco/6y0VqqtNH
 ddRe2dwzNE1TLBg==
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused macro. This was copied straight from the AM62x EVM but while
meant for a second region of DDR this is not even needed for the AM62x
EVM configurations and has meanwhile also been dropped there.

Note that on the Verdin AM62, we do auto-detect the amount of SDRAM.

While at it also update the comment noting that CFG_SYS_SDRAM_SIZE is
the maximum which is only used for such auto-detection.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 include/configs/verdin-am62.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/configs/verdin-am62.h b/include/configs/verdin-am62.h
index 7990ea83102..e1a5f5ad44b 100644
--- a/include/configs/verdin-am62.h
+++ b/include/configs/verdin-am62.h
@@ -13,8 +13,7 @@
 
 /* DDR Configuration */
 #define CFG_SYS_SDRAM_BASE	0x80000000
-#define CFG_SYS_SDRAM_BASE1	0x880000000
-#define CFG_SYS_SDRAM_SIZE	SZ_2G /* Maximum supported size */
+#define CFG_SYS_SDRAM_SIZE	SZ_2G /* Maximum supported size, auto-detection is used */
 
 #define MEM_LAYOUT_ENV_SETTINGS \
 	"fdt_addr_r=0x90200000\0" \
-- 
2.36.1

