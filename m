Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFC1C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 22:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E76E80BAA;
	Tue,  4 Mar 2025 23:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N74DNGoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3160A809D0; Tue,  4 Mar 2025 23:06:47 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0315F800C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 23:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524M6WNI3699623
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Mar 2025 16:06:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741125992;
 bh=hO7VghqeqgSwa/EgFynyeEAw/gW+No0tFGK07qAGSbo=;
 h=From:To:CC:Subject:Date;
 b=N74DNGoq0MiaYmmbsnRlB+Kif9kFHM3g60ORoV7sVpUVVoKJDUTWESUCGvS9g0tsU
 hLH+nOk6qfNprrh1ua/tfiO9PBr+mWQdxyKpJVGhcdhZXn7FRjyZDEjCJfH5Z3FIDB
 pWvHSjFBTYVmwlpsn7jBlwsOtFpzuiQnkZGVO0Gs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 524M6Weh027351
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Mar 2025 16:06:32 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 16:06:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 16:06:31 -0600
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.72.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524M6SwC064367;
 Tue, 4 Mar 2025 16:06:28 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <hs@denx.de>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <marcel.ziswiler@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
Subject: [PATCH RFC/RFT 0/3] omap24xx_i2c: Enable Repeated Start functionality
Date: Wed, 5 Mar 2025 03:34:08 +0530
Message-ID: <20250304220546.866602-1-a-limaye@ti.com>
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

Test logs (On AM68-SK with additional debug prints):
https://gist.github.com/aniket-l/8c64c5bc81246751a02836a96510df14

Requesting reviews/testing on specifically the CONFIG_I2C_REPEATED_START
addition:
- Is the Kconfig needed or should we simply always default to not
  sending Stop bit? Drivers can use i2c_msg.flags to request Stop bit
  for each msg, same as in the Linux Kernel i2c-omap driver[0].
- If yes, Should we re-use CONFIG_I2C_REPEATED_START from the legacy
  implementation of the driver or define a new config
- Default enable it for K3 devices?

[0]: https://github.com/torvalds/linux/blob/v6.14-rc5/drivers/i2c/busses/i2c-omap.c#L699

Aniket Limaye (3):
  i2c: omap24xx_i2c: Use new function __omap24_i2c_xfer_msg()
  i2c: omap24xx_i2c: support CONFIG_I2C_REPEATED_START in DM_I2C xfer
  drivers: i2c: Kconfig: Add config for I2C_REPEATED_START

 drivers/i2c/Kconfig        |   9 +++
 drivers/i2c/omap24xx_i2c.c | 149 ++++++++++++++++++++++++++++++++-----
 2 files changed, 140 insertions(+), 18 deletions(-)

-- 
2.48.1

