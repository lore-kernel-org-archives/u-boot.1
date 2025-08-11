Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BC2C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73BA48329C;
	Mon, 11 Aug 2025 15:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="FXv6DX5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FBA8346A; Mon, 11 Aug 2025 15:12:39 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6480883381
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F1655C975F; Mon, 11 Aug 2025 15:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1754917957; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=01Sw8SxLfrFOXs3HN4ipAAUMV/FaBNA7VD/qv1Sp+3o=;
 b=FXv6DX5iMupl3NMrrIC9glq2n5vw6r9M7UCzvAQ8QUi3GRBDHRQp9WZ0dcU0hd7Wx4stxH
 aBTCb/qAtn6ZtXAnMStkyhXVDJrGbtec3uW2k5qCgwAiKQjajYXE9BSC9YRdIytiktGwGQ
 5oqoG9lU/8aaGeUw8w8Y7fehv+oSFjtQeGTppwoYMbULoTYzVC1hvI7JK9VvigENAzwg5S
 N0OXmTk4bmLrzVjsfIgTh2aOv+5iUrb8p0lOGaSFEM9ZsqKB+LNxcE1DmCWV2PR/LmAgS8
 grlRhrBC/w8AM0x4ILTTUsLTk8w1hsHPCVLZgxOtFaIc8mnxeauaORQ7sYbfKw==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Joy Zou <joy.zou@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 4/6] pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
Date: Mon, 11 Aug 2025 15:12:00 +0200
Message-ID: <20250811131213.211124-5-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811131213.211124-1-frieder@fris.de>
References: <20250811131213.211124-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

There are two ways to set the output voltage of the LD05
regulator. First by writing to the voltage selection registers
and second by toggling the SD_VSEL signal.

Usually board designers connect SD_VSEL to the VSELECT signal
controlled by the USDHC controller, but in some cases the
signal is hardwired to a fixed low level (therefore selecting
3.3V as initial value for allowing to boot from the SD card).

In these cases, the voltage is only determined by the value
of the LDO5CTRL_L register. Introduce a property
nxp,sd-vsel-fixed-low to let the driver know that SD_VSEL
is low and there is no GPIO to actually get that
information from dynamically.

This is equivalent to the following change in Linux:

c8c1ab2c5cb7 ("regulator: pca9450: Handle hardware with fixed SD_VSEL for LDO5")

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/power/regulator/pca9450.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/regulator/pca9450.c b/drivers/power/regulator/pca9450.c
index 9d8d142b464..3bb0c71dde7 100644
--- a/drivers/power/regulator/pca9450.c
+++ b/drivers/power/regulator/pca9450.c
@@ -56,6 +56,7 @@ struct pca9450_plat {
 	struct pca9450_vrange	*ranges;
 	unsigned int		numranges;
 	struct gpio_desc	*sd_vsel_gpio;
+	bool			sd_vsel_fixed_low;
 };
 
 #define PCA_RANGE(_min, _vstep, _sel_low, _sel_hi) \
@@ -229,7 +230,8 @@ static int pca9450_set_enable(struct udevice *dev, bool enable)
 static u8 pca9450_get_vsel_reg(struct pca9450_plat *plat)
 {
 	if (!strcmp(plat->name, "LDO5") &&
-	    (plat->sd_vsel_gpio && !dm_gpio_get_value(plat->sd_vsel_gpio)) {
+	    ((plat->sd_vsel_gpio && !dm_gpio_get_value(plat->sd_vsel_gpio)) ||
+	     plat->sd_vsel_fixed_low)) {
 		return PCA9450_LDO5CTRL_L;
 	}
 
@@ -360,6 +362,8 @@ static int pca9450_regulator_probe(struct udevice *dev)
 						return ret;
 				}
 			}
+
+			plat->sd_vsel_fixed_low = dev_read_bool(dev, "nxp,sd-vsel-fixed-low");
 		}
 
 		return 0;
-- 
2.50.1

