Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCC7C04FF9
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BB988179;
	Mon, 15 Apr 2024 09:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="UAyOa9hH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A9DB8644E; Mon, 15 Apr 2024 09:58:12 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E235988195
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA6C4148D010; Mon, 15 Apr 2024 09:58:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1713167884; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=xOW6YJKE/C0QVri1k1MnvGS0QjMQ3rx7U7L4yE3CSLU=;
 b=UAyOa9hH58SIdDQypbWGjNIsSCFjSG27PDS/hF6mpzVtuMTct1qSSmjpTzcaz07PYdEwYt
 KLaMLemfq4vtvKhSb75Lj9ekRrYHyqTbAi4wJe9WvG6gL6s5hsbTnxSW1EPzJLmlTwiOIJ
 FQHn1jvtHkXf0XIf0FhU7nc0+obKEmqfimakoyVQQ4EAW+o+Ekl/e47PW57JWbZTqEplMd
 eD1zluYEZc5ip9j13RCFqg0pWCTM0FFVu+xOA2EL1rIW558jlSGrTtnqgI2wwmS4dRHth2
 rgoo6yuwrmEuDECyK26Xhs6snySUvKq/PZ9RFmVRUh7BIGsT2oDtbY5Krbsodg==
From: Alexander Dahl <ada@thorsis.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
Date: Mon, 15 Apr 2024 09:57:55 +0200
Message-Id: <20240415075755.780653-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415074547.779264-1-ada@thorsis.com>
References: <20240415074547.779264-1-ada@thorsis.com>
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

From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
like we have to wait tREA after rising RE# before sampling the data.
Thus pulse time must be at least tREA.

Without this fix we got PMECC errors when reading, after switching to
ONFI timing mode 3 on SAM9X60 SoC with S34ML02G1 raw NAND flash chip.

The approach to set timings used before worked on sam9g20 and sama5d2
with the same flash (S34ML02G1), probably because those have a slower
mck clock rate and thus the resolution of the timings setup is not as
tight as with sam9x60.

The approach to fix the issue was carried over from at91bootstrap, and
has been successfully tested in at91bootstrap, U-Boot and Linux.

Link: https://github.com/linux4sam/at91bootstrap/issues/174
Cc: Li Bin <bin.li@microchip.com>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v3:
    - initial patch version (not present in v1 and v2)

 drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index bbafc88e44c..00ffeadd113 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1133,7 +1133,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 					  const struct nand_data_interface *conf,
 					  struct atmel_smc_cs_conf *smcconf)
 {
-	u32 ncycles, totalcycles, timeps, mckperiodps;
+	u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
 	struct atmel_nand_controller *nc;
 	int ret;
 
@@ -1259,11 +1259,16 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 			 ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
 
 	/*
-	 * Read pulse timing directly matches tRP:
+	 * Read pulse timing would directly match tRP,
+	 * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
+	 * do not work properly in timing mode 3.
+	 * The workaround is to extend the SMC NRD pulse to meet tREA
+	 * timing.
 	 *
-	 * NRD_PULSE = tRP
+	 * NRD_PULSE = max(tRP, tREA)
 	 */
-	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
+	pulse = max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_max);
+	ncycles = DIV_ROUND_UP(pulse, mckperiodps);
 	totalcycles += ncycles;
 	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
 					  ncycles);
-- 
2.39.2

