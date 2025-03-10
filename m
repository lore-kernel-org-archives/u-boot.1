Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B6AC28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 10:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AED5812D9;
	Mon, 10 Mar 2025 11:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fMeVbMMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8632C811C1; Mon, 10 Mar 2025 11:37:24 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4DC58003E
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 11:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52AAbA6j858018
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 05:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741603030;
 bh=57vDKUc9DftuB1l4uFdiDatj0tW7ooWkWHGluIWwf3g=;
 h=From:To:CC:Subject:Date;
 b=fMeVbMMrrXHfZ5tGFpHlA+Tcol0/oPIN1iB5I3kxUsRqaHKUkVK7a0mEnQxRyhnXz
 1BUIeUIms5+S5ptk7r2szLUnpPuJ4h2LGZ/M0orheb1C0M+PEFCqq2KHzT+ef7J6XV
 HqNelBm4U1mXI6v+MN2QFMJE4FsJxqf3sb/oX7LI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52AAbAgk125283
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Mar 2025 05:37:10 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 05:37:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Mar 2025 05:37:10 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.72.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52AAb6kI072804;
 Mon, 10 Mar 2025 05:37:07 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <hs@denx.de>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <stefan.agner@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2 0/4] omap24xx_i2c: Enable Repeated Start functionality
Date: Mon, 10 Mar 2025 16:06:43 +0530
Message-ID: <20250310103702.1464782-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This series implements Repeated Start functionality for the DM_I2C xfer
API (omap_i2c_xfer())

First, split out the actual implementation for each individual i2c msg
transfer into a new function __omap24_i2c_xfer_msg() and use this to
implement omap_i2c_xfer().

Then, add support for the Repeated Start condition in omap_i2c_xfer()
through the CONFIG_I2C_REPEATED_START option. 

Also add this config to Kconfig and enable it for ARCH_K3 platforms by
default.

Test logs (On AM68-SK with DEBUG enabled):
https://gist.github.com/aniket-l/e6d78d52c172ebb475552929b71736a9

Boot logs on k3:
https://gist.github.com/aniket-l/110ee4f950ef05027a12bafa96431936

---
v2:
- Add another patch to remove unused CONFIG_I2C_REPEATED_START
- use new CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
- Return right error codes and update debug prints to be driver specific
- patch formatting updates
- Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-1-a-limaye@ti.com/

Aniket Limaye (4):
  i2c: omap24xx_i2c: Remove unused CONFIG_I2C_REPEATED_START
  i2c: omap24xx_i2c: Use new function __omap24_i2c_xfer_msg()
  i2c: omap24xx_i2c: support CONFIG for repeated start in DM_I2C xfer
  drivers: i2c: Kconfig: Add CONFIG_SYS_I2C_OMAP24XX_REPEATED_START

 drivers/i2c/Kconfig        |   9 ++
 drivers/i2c/omap24xx_i2c.c | 165 ++++++++++++++++++++++++++++++-------
 2 files changed, 144 insertions(+), 30 deletions(-)

-- 
2.48.1

