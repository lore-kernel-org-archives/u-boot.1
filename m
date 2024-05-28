Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF692C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66351884C8;
	Tue, 28 May 2024 15:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w0Rgj/Ga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F489884D5; Tue, 28 May 2024 15:13:18 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E64888349
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SDDBfu061715;
 Tue, 28 May 2024 08:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716901991;
 bh=FjsS6Lqa+LiXhv1k2pTdFPbwUOrof13BmxaAoVIgMSU=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=w0Rgj/GaICjMuLfzV/cWWHPvNuinrre+yZkyH1cQO0gVfeBOJZ6HCQhOVF1LDSIpv
 gVyYRgXHNcwFT+HWbolkQy1Rrbnu+RPwyJTmyN2eJkZPRVh2bd7QLVTA2HxSWgmY9b
 HPPcXhjpWCdKPbk6MqTHFxgHIb+rzneMnaVjQ9s0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SDDBYF117940
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 08:13:11 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 08:13:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 08:13:10 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SDD25d099882;
 Tue, 28 May 2024 08:13:07 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 28 May 2024 18:42:55 +0530
Subject: [PATCH v2 1/4] mtd: spi-nor-core: Do not start or end writes at
 odd address in DTR mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-b4-upstream-j721s2-ospi-support-v2-1-b2e372ebcdd7@ti.com>
References: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Pratyush Yadav <p.yadav@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716901982; l=2516;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=9yJbeJJh1BRRq3TrIe4BKBlxZYXEQL3vpgJQbGr0ri4=;
 b=qteamt4A1AAHNxM7J+KaoNRX4t+hjuuNdi5W//DyDbuAzM73y9PHzzexeyFzNGz2GJaLVkG7Z
 oVf/elUNhSgDTuYX5eEH1tU0fUWoRQIvZJwxQyFQzdIQ203MsPhlefe
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

From: Pratyush Yadav <p.yadav@ti.com>

On DTR capable flashes like Micron Xcella the writes cannot start or end
at an odd address in DTR mode. Extra 0xff bytes need to be prepended or
appended respectively to make sure both the start and end addresses are
even.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Tested-by: Jonathan Humphreys <j-humphreys@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/mtd/spi/spi-nor-core.c | 59 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 982dd251150d..aea611fef523 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1804,11 +1804,62 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret < 0)
 			return ret;
 #endif
+
 		write_enable(nor);
-		ret = nor->write(nor, addr, page_remain, buf + i);
-		if (ret < 0)
-			goto write_err;
-		written = ret;
+
+		/*
+		 * On DTR capable flashes like Micron Xcella the writes cannot
+		 * start or end at an odd address in DTR mode. So we need to
+		 * append or prepend extra 0xff bytes to make sure the start
+		 * address and end address are even.
+		 */
+		if (spi_nor_protocol_is_dtr(nor->write_proto) &&
+		    ((addr | page_remain) & 1)) {
+			u_char *tmp;
+			size_t extra_bytes = 0;
+
+			tmp = kmalloc(nor->page_size, 0);
+			if (!tmp) {
+				ret = -ENOMEM;
+				goto write_err;
+			}
+
+			/* Prepend a 0xff byte if the start address is odd. */
+			if (addr & 1) {
+				tmp[0] = 0xff;
+				memcpy(tmp + 1, buf + i, page_remain);
+				addr--;
+				page_remain++;
+				extra_bytes++;
+			} else {
+				memcpy(tmp, buf + i, page_remain);
+			}
+
+			/* Append a 0xff byte if the end address is odd. */
+			if ((addr + page_remain) & 1) {
+				tmp[page_remain + extra_bytes] = 0xff;
+				extra_bytes++;
+				page_remain++;
+			}
+
+			ret = nor->write(nor, addr, page_remain, tmp);
+
+			kfree(tmp);
+
+			if (ret < 0)
+				goto write_err;
+
+			/*
+			 * We write extra bytes but they are not part of the
+			 * original write.
+			 */
+			written = ret - extra_bytes;
+		} else {
+			ret = nor->write(nor, addr, page_remain, buf + i);
+			if (ret < 0)
+				goto write_err;
+			written = ret;
+		}
 
 		ret = spi_nor_wait_till_ready(nor);
 		if (ret)

-- 
2.43.2

