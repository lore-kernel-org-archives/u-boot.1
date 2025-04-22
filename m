Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B6BC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77976819D2;
	Tue, 22 Apr 2025 12:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k8Bvu9ps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6937E81B4B; Tue, 22 Apr 2025 12:20:51 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BEE80FEC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAKeop1191621
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 05:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745317240;
 bh=o9Ts5FoVQ//9Ek9TXUPbXaMaynffafmWbMvAZZ/Lubo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=k8Bvu9psbAWNwat1du2FRQ4rHNeaTKzBD8yyGoMVYVJfagHH2JliPuM43cQfhHbYc
 kP3NnOfFkIxmB3XPgNljZxjLxbKZczWC9VqsadR37LyiiQlen5C1UngeUEs1Ug3I9G
 BbWdw9Yfaqcz1V+c7/4aCklnGY/rYi7aPxd6y2WA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAKeHP067770
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 05:20:40 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 05:20:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 05:20:39 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.72.128])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MAKWRu105794;
 Tue, 22 Apr 2025 05:20:36 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <hs@denx.de>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <w.egorov@phytec.de>, <j-keerthy@ti.com>,
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v3 1/4] i2c: omap24xx_i2c: Remove unused
 CONFIG_I2C_REPEATED_START
Date: Tue, 22 Apr 2025 15:49:49 +0530
Message-ID: <20250422101957.1949448-2-a-limaye@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422101957.1949448-1-a-limaye@ti.com>
References: <20250422101957.1949448-1-a-limaye@ti.com>
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

Remove unused piece of code under CONFIG_I2C_REPEATED_START which does
not have any Kconfig entry at all.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 drivers/i2c/omap24xx_i2c.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
index ebe472e20cd..1fd5f5cc224 100644
--- a/drivers/i2c/omap24xx_i2c.c
+++ b/drivers/i2c/omap24xx_i2c.c
@@ -538,9 +538,7 @@ pr_exit:
 /*
  * i2c_read: Function now uses a single I2C read transaction with bulk transfer
  *           of the requested number of bytes (note that the 'i2c md' command
- *           limits this to 16 bytes anyway). If CONFIG_I2C_REPEATED_START is
- *           defined in the board config header, this transaction shall be with
- *           Repeated Start (Sr) between the address and data phases; otherwise
+ *           limits this to 16 bytes anyway).
  *           Stop-Start (P-S) shall be used (some I2C chips do require a P-S).
  *           The address (reg offset) may be 0, 1 or 2 bytes long.
  *           Function now reads correctly from chips that return more than one
@@ -608,16 +606,10 @@ static int __omap24_i2c_read(void __iomem *i2c_base, int ip_rev, int waitdelay,
 
 	if (alen) {
 		/* Must write reg offset first */
-#ifdef CONFIG_I2C_REPEATED_START
-		/* No stop bit, use Repeated Start (Sr) */
-		omap_i2c_write_reg(i2c_base, ip_rev, I2C_CON_EN | I2C_CON_MST |
-				   I2C_CON_STT | I2C_CON_TRX, OMAP_I2C_CON_REG);
-#else
 		/* Stop - Start (P-S) */
 		omap_i2c_write_reg(i2c_base, ip_rev, I2C_CON_EN | I2C_CON_MST |
 				   I2C_CON_STT | I2C_CON_STP | I2C_CON_TRX,
 				   OMAP_I2C_CON_REG);
-#endif
 		/* Send register offset */
 		while (1) {
 			status = wait_for_event(i2c_base, ip_rev, waitdelay);
-- 
2.49.0

