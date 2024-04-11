Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5FEC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4457C8824A;
	Fri, 12 Apr 2024 00:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="21e8evKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6076C8823C; Fri, 12 Apr 2024 00:37:53 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B436881B2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dcc80d6004bso332766276.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875068; x=1713479868;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jOhTNeiPAIhyg6vTb/No1Ra6lSgdjo92WJ/ddVuxLM=;
 b=21e8evKFxHewSN5ZF7d/o2mdIP8q4HdBR0pn84Q8Wnpy2L1DllOD3V18QPi1xrzvF1
 kmvvxSbldtyGFC4/rRheK/5BlnC88KlpZRCrrBGf0aU0OlZ6KYs4RG678awYJ2rQnnIO
 LmA42LXFeVxdudyunLqRXiMZC/iLpeoUnOta0jKoFodD65fkSpZ8Qu5r6f8vErpJbM61
 GRL9vsOW/65xEhrks2krG27lfSuFPrR6gmJiqQIjM3o7Wzdp/LkX2JWE+hs76UTKtGMU
 nhpXRnWAumsWWWDbDsEQJryZzkC6ZBIWK0fbCZv/EC4QHcFblp3hA89ZVjMRZo+4D3A8
 9yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875068; x=1713479868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jOhTNeiPAIhyg6vTb/No1Ra6lSgdjo92WJ/ddVuxLM=;
 b=Qo+hE7Hf5Eo1YMPRd3Ttg0dCUa0vh7q7LiZYvXK/v7fnhVI9HFAD77IWHb71Yodzdv
 2C5r1N0aaVE1Q0WvmHZ9zVPaOH7SvhD2olRxqgDS8zuZTmPwfl0yemN57fb9nyr7wYK4
 K41sXwfPxzP2UjpVFHVV8ziIQdx/Yo6tH9w5zLnRwipFzy2NUQ5dIS+PWwf2i4cW6iUJ
 Y4C8D1DBCIoCdiXqhprNYzGYD9N+Qw7+xEfKRVABrHUc345BfRsZv4eD9sm+J60GGlgg
 xWLKv2AfD+FUDG4jbRuhmTzZ27pESe7YiQ0UnCAA0nKv29HvqlSJ/Q9deOrPVopVmhPC
 UK9w==
X-Gm-Message-State: AOJu0YyEWN4iPU2+bsMHoQkp8F5rFrVC0CjCiVJ9NLjoOUZNrw0YoSKc
 NH42wJee0eQqyQQpoYV5XnJ9lCXqKucHswnJbHeCmTJ2uWdELgS5fqQ4MPJJFkH1D/7S25Gz/Wo
 lsg==
X-Google-Smtp-Source: AGHT+IGk12XWaXlKqZPu0cW8uZPSVDp7tBMeqM1BKt4KY3fvYQyqm4dGuBKaOSQh0vgtrdpvKJcoWw==
X-Received: by 2002:a25:664c:0:b0:dcf:6122:ccec with SMTP id
 z12-20020a25664c000000b00dcf6122ccecmr910943ybm.36.1712875067463; 
 Thu, 11 Apr 2024 15:37:47 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:46 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Apurva Nandan <a-nandan@ti.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Johan Jonker <jbx6244@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 11/11] spi: cadence-quadspi: Implement high speed calibration
Date: Thu, 11 Apr 2024 18:36:55 -0400
Message-ID: <20240411223709.573-12-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411223709.573-1-greg.malysa@timesys.com>
References: <20240411223709.573-1-greg.malysa@timesys.com>
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

From: Ian Roberts <ian.roberts@timesys.com>

Implement the spi-mem calibration hook for high speed flash operation for
use on the SC59x SOCs. The Cadence controller IP has support for the DQS
signal and a PHY mode that facilitates speeds greater than 50MHz.

At high speeds, the IO lines must be calibrated for signal propagation
delay. This calibration is intended to be executed in the final IO
configuration mode. That is, if 8-lane DDR IO operation is the use case,
calibration must occur while that mode is enabled. For example, there
might be excess noise on a single IO lane while operating in 8-lane mode
that then limits the speed of the entire bus. SPI bus drivers are not
involved in the control of the SPI flash chip operating mode, and
performing the switch is done by the SPI-nor subsystem. To add to this
complexity, different IO modes use different command sets, and different
flash chips may also modify this command set further. Thus, we must lean
on the spi-nor subsystem through the spi-mem calibration function for the
most portable implementation of calibration.

The original calibration code in this driver only calibrates the Read
Delay Capture value, over a single lane, over only 3 bytes in the readid
command. This produces unreliable calibrations in single IO mode and is
unusable in DDR or multi-IO modes.
The prior calibration implementation is replaced in favor of the new
approach when CONFIG_SPI_FLASH_HS_CALIB is defined. The old
implementation is still available when not defined. However, the previous
implementation has been tweaked to take advantage of code reuse and to
fix an invalid SPI chip select read from the dm_spi_ops set_speed
callback. It would always return the same invalid CS number, never
triggering a recalibration if the chip changes. However, this driver was
not implemented with support for multiple chips on the bus in mind
anyway. For example:
* of_to_plat only scans the first subnode for flash-specific
  configuration, and thus only a single copy of this info is declared in
  the plat and priv structs.
* Defining cdns,read-delay overrides any automatic recalibration that
  would normally occur from a chip select change to this single value.
A few additional comments, checks, and renames have been made to make
this more clear. The new calibration implementation explicitly disallows
changing the chip after calibration until it is properly implemented in
the driver. The legacy implementation will still allow the chip to change
but now correctly trigger a recalibration after the chip select changes.
The issue with cdns,read-delay and multi-IO modes is only fixed in the
new implementation.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 doc/device-tree-bindings/spi/spi-cadence.txt |   9 +
 drivers/spi/cadence_qspi.c                   | 392 +++++++++++++------
 drivers/spi/cadence_qspi.h                   |  77 ++--
 drivers/spi/cadence_qspi_apb.c               | 327 ++++++++++++++--
 4 files changed, 641 insertions(+), 164 deletions(-)

diff --git a/doc/device-tree-bindings/spi/spi-cadence.txt b/doc/device-tree-bindings/spi/spi-cadence.txt
index 9bd7ef8bed..4ee0b628e3 100644
--- a/doc/device-tree-bindings/spi/spi-cadence.txt
+++ b/doc/device-tree-bindings/spi/spi-cadence.txt
@@ -31,3 +31,12 @@ connected flash properties
 			  n_ss_out low and first bit transfer
 - cdns,max-read-delay	: Max safe value to use for the read capture delay
 			  during auto calibration.
+- cdns,spi-calib-frequency : Max safe SPI clock frequency to use before bus
+			     calibration is performed.
+- cdns,dqs		: Enable use of the DQS signal with the flash chip.
+- cdns,phy		: Enable use of the high-speed PHY feature with the
+			  flash chip. Generally required for speeds higher
+			  than 50MHz.
+- cdns,read-delay	: Optional pre-calibrated Read Delay Capture value.
+- cdns,phyrxdly		: Optional pre-calibrated PHY RX Delay value.
+- cdns,phytxdly		: Optional pre-calibrated PHY TX Delay value.
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 3778a469d4..1db3167a5b 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -8,6 +8,7 @@
 #include <clk.h>
 #include <log.h>
 #include <asm-generic/io.h>
+#include <asm/io.h>
 #include <dma.h>
 #include <dm.h>
 #include <fdtdec.h>
@@ -30,6 +31,20 @@
 #define CQSPI_READ			2
 #define CQSPI_WRITE			3
 
+static bool is_calibrated(struct cadence_spi_priv *priv,
+			  struct spi_slave *slave)
+{
+	return (priv->qspi_calibrated_hz == priv->req_hz) &&
+	       (priv->qspi_calibrated_cs == spi_chip_select(slave->dev));
+}
+
+static void set_calibrated(struct cadence_spi_priv *priv,
+			   struct spi_slave *slave)
+{
+	priv->qspi_calibrated_hz = priv->req_hz;
+	priv->qspi_calibrated_cs = spi_chip_select(slave->dev);
+}
+
 __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				     const struct spi_mem_op *op)
 {
@@ -49,86 +64,92 @@ __weak ofnode cadence_qspi_get_subnode(struct udevice *dev)
 static int cadence_spi_write_speed(struct udevice *bus, uint hz)
 {
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	struct cadence_spi_plat *plat = dev_get_plat(bus);
 
 	cadence_qspi_apb_config_baudrate_div(priv->regbase,
 					     priv->ref_clk_hz, hz);
 
 	/* Reconfigure delay timing if speed is changed. */
 	cadence_qspi_apb_delay(priv->regbase, priv->ref_clk_hz, hz,
-			       priv->tshsl_ns, priv->tsd2d_ns,
-			       priv->tchsh_ns, priv->tslch_ns);
-
-	return 0;
+			       plat->tshsl_ns, plat->tsd2d_ns,
+			       plat->tchsh_ns, plat->tslch_ns);
 }
 
-static int cadence_spi_read_id(struct cadence_spi_priv *priv, u8 len,
-			       u8 *idcode)
+void cadence_spi_update_speed(struct udevice *bus, bool calibrated)
 {
-	int err;
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	struct cadence_spi_plat *plat = dev_get_plat(bus);
+	void *regb = priv->regbase;
+	uint hz = priv->req_hz;
+	u32 rdc = 0;
 
-	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x9F, 1),
-					  SPI_MEM_OP_NO_ADDR,
-					  SPI_MEM_OP_NO_DUMMY,
-					  SPI_MEM_OP_DATA_IN(len, idcode, 1));
+	if (!calibrated)
+		hz = plat->calib_hz;
 
-	err = cadence_qspi_apb_command_read_setup(priv, &op);
-	if (!err)
-		err = cadence_qspi_apb_command_read(priv, &op);
+	/* Disable QSPI */
+	cadence_qspi_apb_controller_disable(regb);
+
+	if (calibrated) {
+		rdc = priv->read_delay;
+		if (plat->phy_support && plat->use_phy) {
+			cadence_qspi_apb_enable_phy(regb, true);
+			if (plat->slow_phy_tx)
+				hz /= 4;
+		}
+	} else if (plat->phy_support) {
+		cadence_qspi_apb_enable_phy(regb, false);
+	}
 
-	return err;
+	cadence_spi_write_speed(bus, hz);
+	cadence_qspi_apb_readdata_capture(priv, 1, rdc);
+
+	if (plat->phy_support)
+		cadence_qspi_apb_set_phy_cfg(regb,
+					     priv->phyrxdly, priv->phytxdly);
+
+	/* Enable QSPI */
+	cadence_qspi_apb_controller_enable(regb);
 }
 
-/* Calibration sequence to determine the read data capture delay register */
-static int spi_calibration(struct udevice *bus, uint hz)
+/* Calibration sequence to determine the read data capture delay register
+ * Returns 0 on success, negative error code.
+ */
+static int spi_non_phy_calibrate(struct spi_slave *slave,
+				 int (*test_read_fn)(struct spi_slave *))
 {
+	struct udevice *bus = slave->dev->parent;
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	struct cadence_spi_plat *plat = dev_get_plat(bus);
 	void *base = priv->regbase;
-	unsigned int idcode = 0, temp = 0;
 	int err = 0, i, range_lo = -1, range_hi = -1;
 
-	/* start with slowest clock (1 MHz) */
-	cadence_spi_write_speed(bus, 1000000);
-
-	/* configure the read data capture delay register to 0 */
-	cadence_qspi_apb_readdata_capture(base, 1, 0);
-
-	/* Enable QSPI */
-	cadence_qspi_apb_controller_enable(base);
-
-	/* read the ID which will be our golden value */
-	err = cadence_spi_read_id(priv, 3, (u8 *)&idcode);
-	if (err) {
-		puts("SF: Calibration failed (read)\n");
-		return err;
-	}
-
 	/* use back the intended clock and find low range */
-	cadence_spi_write_speed(bus, hz);
-	for (i = 0; i < priv->max_read_delay; i++) {
+	cadence_spi_update_speed(bus, true);
+
+	for (i = 0; i < plat->max_read_delay; i++) {
 		/* Disable QSPI */
 		cadence_qspi_apb_controller_disable(base);
 
 		/* reconfigure the read data capture delay register */
-		cadence_qspi_apb_readdata_capture(base, 1, i);
+		cadence_qspi_apb_readdata_capture(priv, 1, i);
 
 		/* Enable back QSPI */
 		cadence_qspi_apb_controller_enable(base);
 
-		/* issue a RDID to get the ID value */
-		err = cadence_spi_read_id(priv, 3, (u8 *)&temp);
-		if (err) {
+		err = test_read_fn(slave);
+		if (err < 0) {
 			puts("SF: Calibration failed (read)\n");
-			return err;
+			goto err;
 		}
 
 		/* search for range lo */
-		if (range_lo == -1 && temp == idcode) {
+		if (range_lo == -1 && err == 0) {
 			range_lo = i;
 			continue;
 		}
 
 		/* search for range hi */
-		if (range_lo != -1 && temp != idcode) {
+		if (range_lo != -1 && err) {
 			range_hi = i - 1;
 			break;
 		}
@@ -137,59 +158,169 @@ static int spi_calibration(struct udevice *bus, uint hz)
 
 	if (range_lo == -1) {
 		puts("SF: Calibration failed (low range)\n");
-		return err;
+		err = -EIO;
+		goto err;
 	}
 
 	/* Disable QSPI for subsequent initialization */
 	cadence_qspi_apb_controller_disable(base);
 
-	/* configure the final value for read data capture delay register */
-	cadence_qspi_apb_readdata_capture(base, 1, (range_hi + range_lo) / 2);
-	debug("SF: Read data capture delay calibrated to %i (%i - %i)\n",
-	      (range_hi + range_lo) / 2, range_lo, range_hi);
+	priv->read_delay = (range_hi + range_lo) / 2;
 
-	/* just to ensure we do once only when speed or chip select change */
-	priv->qspi_calibrated_hz = hz;
-	priv->qspi_calibrated_cs = spi_chip_select(bus);
+	/* configure the final value for read data capture delay register */
+	cadence_qspi_apb_readdata_capture(priv, 1, priv->read_delay);
+	debug("SF: Calibration: read-delay=%u (%i - %i)\n",
+	      priv->read_delay, range_lo, range_hi);
 
 	return 0;
+
+err:
+	cadence_spi_update_speed(bus, false);
+	return err;
 }
 
-static int cadence_spi_set_speed(struct udevice *bus, uint hz)
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+static void clr_calibrated(struct cadence_spi_priv *priv,
+			   struct spi_slave *slave)
 {
+	priv->qspi_calibrated_hz = 0;
+}
+
+/* Returns 0 on success, negative error code.
+ */
+int cadence_spi_calibrate(struct spi_slave *slave,
+			  int (*test_read_fn)(struct spi_slave *))
+{
+	struct udevice *bus = slave->dev->parent;
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
-	int err;
+	struct cadence_spi_plat *plat = dev_get_plat(bus);
+	int err = 0;
 
-	if (!hz || hz > priv->max_hz)
-		hz = priv->max_hz;
-	/* Disable QSPI */
-	cadence_qspi_apb_controller_disable(priv->regbase);
+	if (!test_read_fn) {
+		if (priv->qspi_calibrated_hz &&
+		    priv->qspi_calibrated_cs != spi_chip_select(slave->dev)) {
+			debug("%s: multiple chips on the bus not yet implemented\n",
+			      __func__);
+			return -ENOSYS;
+		}
+		clr_calibrated(priv, slave);
+		cadence_spi_update_speed(bus, false);
+		return 0;
+	}
 
-	/*
-	 * If the device tree already provides a read delay value, use that
-	 * instead of calibrating.
+	/* todo: Allow recalibrations. This could be useful in the event
+	 * of a communication CRC failure. A recalibration could improve
+	 * signal quality. This however, requires implementing communication
+	 * CRC features in spi-nor.
 	 */
-	if (priv->read_delay >= 0) {
-		cadence_spi_write_speed(bus, hz);
-		cadence_qspi_apb_readdata_capture(priv->regbase, 1,
-						  priv->read_delay);
-	} else if (priv->previous_hz != hz ||
-		   priv->qspi_calibrated_hz != hz ||
-		   priv->qspi_calibrated_cs != spi_chip_select(bus)) {
-		/*
-		 * Calibration required for different current SCLK speed,
-		 * requested SCLK speed or chip select
-		 */
-		err = spi_calibration(bus, hz);
-		if (err)
-			return err;
+	if (is_calibrated(priv, slave))
+		return 0;
 
-		/* prevent calibration run when same as previous request */
-		priv->previous_hz = hz;
+	if (plat->calib_cfg) {
+		set_calibrated(priv, slave);
+		cadence_spi_update_speed(bus, true);
+		return 0;
 	}
 
-	/* Enable QSPI */
-	cadence_qspi_apb_controller_enable(priv->regbase);
+	if (plat->use_phy)
+		err = cadence_qspi_apb_phy_calibrate(slave, test_read_fn);
+	else
+		err = spi_non_phy_calibrate(slave, test_read_fn);
+	if (err)
+		return err;
+
+	set_calibrated(priv, slave);
+
+	return 0;
+}
+#else
+/* NOTE: This will not work as expected if spi-nor has put the chip into a
+ * multi-io or DDR mode. Use CONFIG_SPI_FLASH_HS_CALIB.
+ * Calibrating from only 3 bytes is also not enough to get a reliable
+ * calibration range.
+ */
+static int cadence_spi_read_id(struct cadence_spi_priv *priv, u8 len,
+			       u8 *idcode)
+{
+	int err;
+
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x9F, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(len, idcode, 1));
+
+	err = cadence_qspi_apb_command_read_setup(priv, &op);
+	if (!err)
+		err = cadence_qspi_apb_command_read(priv, &op);
+	return err;
+}
+
+/* Returns 0 on success, negative error code.
+ */
+static int cadence_spi_legacy_non_phy_calib_chk(struct spi_slave *slave)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	u32 temp = 0;
+
+	int err = cadence_spi_read_id(priv, 3, (u8 *)&temp);
+
+	if (err)
+		return err;
+
+	return temp != priv->chipid;
+}
+
+/* Calibration sequence to determine the read data capture delay register
+ * Returns 0 on success, negative error code.
+ */
+static int legacy_spi_calibration(struct spi_slave *slave)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	struct cadence_spi_plat *plat = dev_get_plat(bus);
+	int err = 0;
+
+	if (is_calibrated(priv, slave)) {
+		return 0;
+	} else if (plat->calib_cfg) {
+		set_calibrated(priv, slave);
+		cadence_spi_update_speed(bus, true);
+		return 0;
+	}
+
+	cadence_spi_update_speed(bus, false);
+
+	/* read the ID which will be our golden value */
+	err = cadence_spi_read_id(priv, 3, (u8 *)&priv->chipid);
+	if (err) {
+		puts("SF: Calibration failed (read)\n");
+		return err;
+	}
+
+	err = spi_non_phy_calibrate(slave, cadence_spi_legacy_non_phy_calib_chk);
+	if (err)
+		return err;
+
+	set_calibrated(priv, slave);
+
+	return 0;
+}
+#endif
+
+static int cadence_spi_set_speed(struct udevice *bus, uint hz)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	/*
+	 * In the high speed calib case, clibration clearing will then apply
+	 * the max non-calibrated speed.
+	 * When calibration occurs later, it will then apply the full requested
+	 * speed.
+	 *
+	 * In the legacy calibration case, exec_op calls check if the new
+	 * speed needs to be applied.
+	 */
+	priv->req_hz = hz;
 
 	debug("%s: speed=%d\n", __func__, hz);
 
@@ -239,6 +370,7 @@ static int cadence_spi_probe(struct udevice *bus)
 	struct clk clk;
 	int ret;
 
+	priv->plat		= plat;
 	priv->regbase		= plat->regbase;
 	priv->ahbbase		= plat->ahbbase;
 	priv->is_dma		= plat->is_dma;
@@ -246,17 +378,10 @@ static int cadence_spi_probe(struct udevice *bus)
 	priv->fifo_depth	= plat->fifo_depth;
 	priv->fifo_width	= plat->fifo_width;
 	priv->trigger_address	= plat->trigger_address;
-	priv->max_read_delay	= plat->max_read_delay;
-	priv->read_delay	= plat->read_delay;
 	priv->ahbsize		= plat->ahbsize;
-	priv->max_hz		= plat->max_hz;
-
-	priv->page_size		= plat->page_size;
-	priv->block_size	= plat->block_size;
-	priv->tshsl_ns		= plat->tshsl_ns;
-	priv->tsd2d_ns		= plat->tsd2d_ns;
-	priv->tchsh_ns		= plat->tchsh_ns;
-	priv->tslch_ns		= plat->tslch_ns;
+	priv->read_delay	= plat->read_delay;
+	priv->phyrxdly		= plat->phyrxdly;
+	priv->phytxdly		= plat->phytxdly;
 
 	priv->ops.direct_read_copy = cadence_qspi_apb_direct_read_copy;
 	priv->ops.direct_write_copy = cadence_qspi_apb_direct_write_copy;
@@ -354,6 +479,33 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	cadence_qspi_apb_chipselect(base, spi_chip_select(spi->dev),
 				    priv->is_decoded_cs);
 
+	/* todo: Due to there only being 1 declaration of per-flash parameters,
+	 * this driver only ever correctly supported 1 chip on the bus.
+	 * Per-flash data must be moved into a data structure that can lookup
+	 * by chip select.
+	 */
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+	if (priv->qspi_calibrated_hz &&
+	    priv->qspi_calibrated_cs != spi_chip_select(spi->dev)) {
+		debug("%s: multiple chips on the bus not yet implemented\n",
+		      __func__);
+		return -ENOSYS;
+	} else if (is_calibrated(priv, spi) &&
+		   priv->qspi_calibrated_hz != priv->req_hz) {
+		debug("%s: speed change after calibration not yet supported\n",
+		      __func__);
+		return -ENOSYS;
+	}
+#else
+	/* Regardless of the above, attempt a recalib anyway. */
+	if (!is_calibrated(priv, spi) ||
+	    priv->qspi_calibrated_hz != priv->req_hz) {
+		err = legacy_spi_calibration(spi);
+		if (err)
+			return err;
+	}
+#endif
+
 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
 		/*
 		 * Performing reads in DAC mode forces to read minimum 4 bytes
@@ -441,6 +593,7 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 {
 	struct cadence_spi_plat *plat = dev_get_plat(bus);
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	struct cadence_spi_plat *chip = plat;
 	ofnode subnode;
 
 	plat->regbase = devfdt_get_addr_index_ptr(bus, 0);
@@ -457,6 +610,12 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 
 	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
 
+	if (CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB))
+		plat->phy_support = bus->driver_data & CQSPI_HW_SUPPORTS_PHY;
+
+	plat->slow_phy_tx = plat->phy_support && (bus->driver_data
+		& CQSPI_QUIRK_SLOW_PHY_TX_DMA);
+
 	plat->max_read_delay = dev_read_u32_default(bus,
 						    "cdns,max-read-delay",
 						    CQSPI_READ_CAPTURE_MAX_DELAY);
@@ -464,37 +623,41 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	/* All other parameters are embedded in the child node */
 	subnode = cadence_qspi_get_subnode(bus);
 	if (!ofnode_valid(subnode)) {
-		printf("Error: subnode with SPI flash config missing!\n");
+		debug("Error: subnode with SPI flash config missing!\n");
 		return -ENODEV;
 	}
 
-	/* Use 500 KHz as a suitable default */
-	plat->max_hz = ofnode_read_u32_default(subnode, "spi-max-frequency",
-					       500000);
-
 	/* Read other parameters from DT */
-	plat->page_size = ofnode_read_u32_default(subnode, "page-size", 256);
-	plat->block_size = ofnode_read_u32_default(subnode, "block-size", 16);
-	plat->tshsl_ns = ofnode_read_u32_default(subnode, "cdns,tshsl-ns",
+	chip->page_size = ofnode_read_u32_default(subnode, "page-size", 256);
+	chip->block_size = ofnode_read_u32_default(subnode, "block-size", 16);
+	chip->tshsl_ns = ofnode_read_u32_default(subnode, "cdns,tshsl-ns",
 						 200);
-	plat->tsd2d_ns = ofnode_read_u32_default(subnode, "cdns,tsd2d-ns",
+	chip->tsd2d_ns = ofnode_read_u32_default(subnode, "cdns,tsd2d-ns",
 						 255);
-	plat->tchsh_ns = ofnode_read_u32_default(subnode, "cdns,tchsh-ns", 20);
-	plat->tslch_ns = ofnode_read_u32_default(subnode, "cdns,tslch-ns", 20);
-	/*
-	 * Read delay should be an unsigned value but we use a signed integer
-	 * so that negative values can indicate that the device tree did not
-	 * specify any signed values and we need to perform the calibration
-	 * sequence to find it out.
-	 */
-	plat->read_delay = ofnode_read_s32_default(subnode, "cdns,read-delay",
-						   -1);
-	if (plat->read_delay > plat->max_read_delay)
-		plat->read_delay = plat->max_read_delay;
+	chip->tchsh_ns = ofnode_read_u32_default(subnode, "cdns,tchsh-ns", 20);
+	chip->tslch_ns = ofnode_read_u32_default(subnode, "cdns,tslch-ns", 20);
+
+	chip->calib_hz = ofnode_read_u32_default(subnode,
+						 "cdns,spi-calib-frequency",
+						 1000000);
+
+	chip->use_dqs = ofnode_read_bool(subnode, "cdns,dqs");
+	chip->use_phy = ofnode_read_bool(subnode, "cdns,phy") && plat->phy_support;
+
+	if (!ofnode_read_u32(subnode, "cdns,read-delay", &chip->read_delay))
+		chip->calib_cfg |= true;
+	if (chip->read_delay > plat->max_read_delay)
+		chip->read_delay = plat->max_read_delay;
+
+	if (!ofnode_read_u32(subnode, "cdns,phyrxdly", &chip->phyrxdly) ||
+	    !ofnode_read_u32(subnode, "cdns,phytxdly", &chip->phytxdly)) {
+		chip->calib_cfg |= true;
+		if (!chip->use_phy)
+			debug("PHY delays configured but PHY mode is not enabled!\n");
+	}
 
-	debug("%s: regbase=%p ahbbase=%p max-frequency=%d page-size=%d\n",
-	      __func__, plat->regbase, plat->ahbbase, plat->max_hz,
-	      plat->page_size);
+	debug("%s: regbase=%p ahbbase=%p page-size=%d\n",
+	      __func__, plat->regbase, plat->ahbbase, plat->page_size);
 
 	return 0;
 }
@@ -502,6 +665,9 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 static const struct spi_controller_mem_ops cadence_spi_mem_ops = {
 	.exec_op = cadence_spi_mem_exec_op,
 	.supports_op = cadence_spi_mem_supports_op,
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+	.calibrate = cadence_spi_calibrate,
+#endif
 };
 
 static const struct dm_spi_ops cadence_spi_ops = {
@@ -517,6 +683,8 @@ static const struct dm_spi_ops cadence_spi_ops = {
 static const struct udevice_id cadence_spi_ids[] = {
 	{ .compatible = "cdns,qspi-nor" },
 	{ .compatible = "ti,am654-ospi" },
+	{ .compatible = "adi,sc59x-ospi", .data =
+		CQSPI_HW_SUPPORTS_PHY | CQSPI_QUIRK_SLOW_PHY_TX_DMA },
 	{ }
 };
 
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index d7a02f0870..d38dee63d4 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -11,11 +11,17 @@
 #include <linux/mtd/spi-nor.h>
 #include <spi-mem.h>
 
+/* HWcaps */
+#define CQSPI_HW_SUPPORTS_PHY		BIT(0)
+/* Quirks */
+#define CQSPI_QUIRK_SLOW_PHY_TX_DMA	BIT(16)
+
 #define CQSPI_IS_ADDR(cmd_len)		(cmd_len > 1 ? 1 : 0)
 
 #define CQSPI_NO_DECODER_MAX_CS		4
 #define CQSPI_DECODER_MAX_CS		16
 #define CQSPI_READ_CAPTURE_MAX_DELAY	16
+#define CQSPI_PHY_DLL_MAX_DELAY 0x7f
 
 #define CQSPI_REG_POLL_US                       1 /* 1us */
 #define CQSPI_REG_RETRY                         10000
@@ -53,6 +59,7 @@
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB         10
 #define CQSPI_REG_CONFIG_BAUD_LSB               19
 #define CQSPI_REG_CONFIG_DTR_PROTO		BIT(24)
+#define CQSPI_REG_CONFIG_PIPELINE_PHY_EN_MASK   BIT(25)
 #define CQSPI_REG_CONFIG_DUAL_OPCODE		BIT(30)
 #define CQSPI_REG_CONFIG_IDLE_LSB               31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK        0xF
@@ -89,9 +96,12 @@
 
 #define CQSPI_REG_RD_DATA_CAPTURE               0x10
 #define CQSPI_REG_RD_DATA_CAPTURE_BYPASS        BIT(0)
+#define CQSPI_REG_RD_DATA_CAPTURE_SAMPLE_EDGE   BIT(5)
 #define CQSPI_REG_READCAPTURE_DQS_ENABLE        BIT(8)
 #define CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB     1
 #define CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK    0xF
+#define CQSPI_REG_RD_DATA_CAPTURE_DDR_DELAY_LSB 16
+#define CQSPI_REG_RD_DATA_CAPTURE_DDR_DELAY_MASK 0xF
 
 #define CQSPI_REG_SIZE                          0x14
 #define CQSPI_REG_SIZE_ADDRESS_LSB              0
@@ -169,6 +179,12 @@
 
 #define CQSPI_REG_PHY_CONFIG                    0xB4
 #define CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK     0x40000000
+#define CQSPI_REG_PHY_CONFIG_RXDLY_MSK		0x7Fu
+#define CQSPI_REG_PHY_CONFIG_TXDLY_MSK		0x7Fu
+#define CQSPI_REG_PHY_CONFIG_RXDLY_LSB		0
+#define CQSPI_REG_PHY_CONFIG_TXDLY_LSB		16
+#define CQSPI_REG_PHY_CONFIG_RXBYP		BIT(29)
+#define CQSPI_REG_PHY_CONFIG_RESYNC		BIT(31)
 
 #define CQSPI_DMA_DST_ADDR_REG                  0x1800
 #define CQSPI_DMA_DST_SIZE_REG                  0x1804
@@ -204,7 +220,6 @@
 	CQSPI_REG_SDRAMLEVEL_WR_LSB) & CQSPI_REG_SDRAMLEVEL_WR_MASK)
 
 struct cadence_spi_plat {
-	unsigned int	max_hz;
 	void		*regbase;
 	void		*ahbbase;
 	bool		is_decoded_cs;
@@ -213,10 +228,15 @@ struct cadence_spi_plat {
 	u32		trigger_address;
 	fdt_addr_t	ahbsize;
 	bool		use_dac_mode;
-	int		read_delay;
-	int		max_read_delay;
+	bool		phy_support;
+	bool		slow_phy_tx;
+	u32		max_read_delay;
+
+	bool		is_dma;
+
+	/* Per-flash parameters */
+	unsigned int	calib_hz;
 
-	/* Flash parameters */
 	u32		page_size;
 	u32		block_size;
 	u32		tshsl_ns;
@@ -224,7 +244,13 @@ struct cadence_spi_plat {
 	u32		tchsh_ns;
 	u32		tslch_ns;
 
-	bool		is_dma;
+	bool		calib_cfg;
+	u32		read_delay;
+	bool		use_dqs;
+	bool		use_phy;
+	u32		phyrxdly;
+	u32		phytxdly;
+	/* End per-flash parameters */
 };
 
 struct cadence_spi_priv;
@@ -237,8 +263,10 @@ struct cadence_drv_ops {
 };
 
 struct cadence_spi_priv {
+	uint		req_hz;
+	struct cadence_spi_plat *plat;
+
 	unsigned int	ref_clk_hz;
-	unsigned int	max_hz;
 	void		*regbase;
 	void		*ahbbase;
 	unsigned int	fifo_depth;
@@ -256,24 +284,22 @@ struct cadence_spi_priv {
 	struct cadence_drv_ops ops;
 
 	int		qspi_is_init;
-	unsigned int	qspi_calibrated_hz;
 	unsigned int	qspi_calibrated_cs;
-	unsigned int	previous_hz;
 	u32		wr_delay;
-	int		read_delay;
-	int		max_read_delay;
 
 	struct reset_ctl_bulk *resets;
-	u32		page_size;
-	u32		block_size;
-	u32		tshsl_ns;
-	u32		tsd2d_ns;
-	u32		tchsh_ns;
-	u32		tslch_ns;
-	u8		edge_mode;
-	u8		dll_mode;
-	bool		extra_dummy;
-	bool		ddr_init;
+
+	/* Flash parameters */
+	unsigned int	qspi_calibrated_hz;
+	u32		read_delay;
+
+#if !CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+	unsigned int	chipid;
+#endif
+	u32		phyrxdly;
+	u32		phytxdly;
+	/* End Flash parameters */
+
 	bool		is_decoded_cs;
 	bool		use_dac_mode;
 	bool		is_dma;
@@ -289,7 +315,10 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv);
 void cadence_qspi_apb_controller_enable(void *reg_base_addr);
 void cadence_qspi_apb_controller_disable(void *reg_base_addr);
 void cadence_qspi_apb_dac_mode_enable(void *reg_base);
-
+void cadence_qspi_apb_enable_phy(void *reg_base, bool enbl);
+void cadence_qspi_apb_set_phy_cfg(void *reg_base,
+				  u32 rxdly, u32 txdly);
+void cadence_spi_update_speed(struct udevice *bus, bool calibrated);
 int cadence_qspi_apb_command_read_setup(struct cadence_spi_priv *priv,
 					const struct spi_mem_op *op);
 int cadence_qspi_apb_command_read(struct cadence_spi_priv *priv,
@@ -318,8 +347,8 @@ void cadence_qspi_apb_delay(void *reg_base,
 	unsigned int tshsl_ns, unsigned int tsd2d_ns,
 	unsigned int tchsh_ns, unsigned int tslch_ns);
 void cadence_qspi_apb_enter_xip(void *reg_base, char xip_dummy);
-void cadence_qspi_apb_readdata_capture(void *reg_base,
-	unsigned int bypass, unsigned int delay);
+void cadence_qspi_apb_readdata_capture(const struct cadence_spi_priv *priv,
+				       unsigned int bypass, unsigned int delay);
 unsigned int cm_get_qspi_controller_clk_hz(void);
 int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 			      const struct spi_mem_op *op);
@@ -328,6 +357,8 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_versal_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
+int cadence_qspi_apb_phy_calibrate(struct spi_slave *slave,
+				   int (*test_read_fn)(struct spi_slave *));
 
 int cadence_qspi_apb_read_copy_mdma(struct cadence_spi_priv *priv,
 				    void *dst, u64 src, size_t len);
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 90b9c558b2..fde66cc13f 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -70,6 +70,284 @@ void cadence_qspi_apb_dac_mode_enable(void *reg_base)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
+void cadence_qspi_apb_enable_phy(void *reg_base, bool enbl)
+{
+	u32 reg;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	if (enbl)
+		reg |= CQSPI_REG_CONFIG_PHY_ENABLE_MASK
+			| CQSPI_REG_CONFIG_PIPELINE_PHY_EN_MASK;
+	else
+		reg &= ~(CQSPI_REG_CONFIG_PHY_ENABLE_MASK
+			| CQSPI_REG_CONFIG_PIPELINE_PHY_EN_MASK);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+}
+
+void cadence_qspi_apb_set_phy_cfg(void *reg_base,
+				  u32 rxdly, u32 txdly)
+{
+	u32 reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~(CQSPI_REG_PHY_CONFIG_RESYNC
+		| (CQSPI_REG_PHY_CONFIG_RXDLY_MSK
+			<< CQSPI_REG_PHY_CONFIG_RXDLY_LSB)
+		| (CQSPI_REG_PHY_CONFIG_TXDLY_MSK
+			<< CQSPI_REG_PHY_CONFIG_TXDLY_LSB));
+	reg |= ((rxdly & CQSPI_REG_PHY_CONFIG_RXDLY_MSK)
+			<< CQSPI_REG_PHY_CONFIG_RXDLY_LSB)
+		| ((txdly & CQSPI_REG_PHY_CONFIG_TXDLY_MSK)
+			<< CQSPI_REG_PHY_CONFIG_TXDLY_LSB)
+		| CQSPI_REG_PHY_CONFIG_RXBYP;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg |= CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+}
+
+void cadence_qspi_apb_readdata_capture(const struct cadence_spi_priv *priv,
+				       unsigned int bypass, unsigned int delay)
+{
+	void *reg_base = priv->regbase;
+	unsigned int reg;
+
+	cadence_qspi_apb_controller_disable(reg_base);
+	reg = readl(reg_base + CQSPI_REG_RD_DATA_CAPTURE);
+
+	if (bypass)
+		reg |= CQSPI_REG_RD_DATA_CAPTURE_BYPASS;
+	else
+		reg &= ~CQSPI_REG_RD_DATA_CAPTURE_BYPASS;
+
+	reg &= ~(CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK
+		<< CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK)
+		<< CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB;
+
+	if (priv->plat->phy_support) {
+		if (priv->plat->use_dqs)
+			reg |= CQSPI_REG_READCAPTURE_DQS_ENABLE;
+		else
+			reg &= ~CQSPI_REG_READCAPTURE_DQS_ENABLE;
+	}
+
+	writel(reg, reg_base + CQSPI_REG_RD_DATA_CAPTURE);
+
+	cadence_qspi_apb_controller_enable(reg_base);
+}
+
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+/**
+ * This algorithm was implemented based on the Analog Devices application note
+ * EE-437: "OSPI PHY Configuration and Training".
+ *
+ * Algorithm breif:
+ * * Set Read Delay Capture, TX DLL delay, and RX DLL delay to 0.
+ * * Iterate over RDC, TXdly and RXdly until the first valid configuration is
+ *   found.
+ * * Keep this RDC value. Scan all TXdly values for the range of valid values
+ *   and pick the middle value.
+ * * If data strobe signal (DQS) is used, use the first valid RXdly value, +1.
+ * * If DQS is not used, scan all RXdly for the range of valid values and pick
+ *   the middle value.
+ * * Configurations are considered valid if they pass for at least 2
+ *   consecutive iterations.
+ *
+ * The caller is responsible for providing the function to test
+ * if a configuration is valid.
+ *
+ * Returns 0 on success, negative error code.
+ */
+int cadence_qspi_apb_phy_calibrate(struct spi_slave *slave,
+				   int (*test_read_fn)(struct spi_slave *))
+{
+	struct udevice *bus = slave->dev->parent;
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	struct cadence_spi_plat *plat = dev_get_plat(bus);
+	void * const reg_base = priv->regbase;
+	int err = 0;
+	const bool dqs = plat->use_dqs;
+	int fast = 1;
+
+	int rdcd;
+	int txvalid_count;
+	int rxvalid_count;
+
+	int first_txdly_valid;
+	int last_txdly_valid;
+	int first_rxdly_valid;
+	int last_rxdly_valid;
+
+	int txdly;
+	int rxdly;
+
+	int txdly_step;
+	int rxdly_step;
+	int txpass_limit;
+	int rxpass_limit;
+
+	if (priv->req_hz != priv->ref_clk_hz) {
+		debug("%s: phy mode must operate at ref_clk speed.", __func__);
+		err = -EINVAL;
+		goto out;
+	}
+
+	cadence_spi_update_speed(bus, true);
+
+try_again_slow:
+	if (fast) {
+		txdly_step = 4;
+		rxdly_step = 4;
+		txpass_limit = 16;
+		rxpass_limit = 16;
+	} else {
+		txdly_step = 1;
+		rxdly_step = 1;
+		txpass_limit = 128;
+		rxpass_limit = 128;
+	}
+
+	first_txdly_valid = -1;
+	last_txdly_valid = -1;
+
+	for (rdcd = 0; rdcd < plat->max_read_delay; ++rdcd) {
+		cadence_qspi_apb_readdata_capture(priv, 1, rdcd);
+
+		txvalid_count = 0;
+		for (txdly = 0; txdly < CQSPI_PHY_DLL_MAX_DELAY;
+				txdly += txdly_step) {
+			rxvalid_count = 0;
+			for (rxdly = 0; rxdly < CQSPI_PHY_DLL_MAX_DELAY;
+					rxdly += rxdly_step) {
+				cadence_qspi_apb_set_phy_cfg(reg_base,
+							     rxdly, txdly);
+				err = test_read_fn(slave);
+				if (err < 0) {
+					goto out;
+				} else if (!err) {
+					++rxvalid_count;
+
+					if (rxvalid_count == 2)
+						++txvalid_count;
+
+					/* Check for enough passing cfgs
+					 * With DQS, only 2 need to pass.
+					 */
+					if (dqs && rxvalid_count >= 2)
+						break;
+					else if (!dqs && (rxvalid_count >=
+							  rxpass_limit))
+						break;
+				} else if (rxvalid_count == 1) {
+					//must be consecutive to be valid
+					rxvalid_count = 0;
+				} else if (rxvalid_count >= 2) {
+					break; //end of valid range
+				}
+			}
+
+			if (rxvalid_count >= 2) {
+				if (first_txdly_valid < 0)
+					first_txdly_valid = txdly;
+				last_txdly_valid = txdly;
+			}
+
+			if (txvalid_count >= txpass_limit)
+				break;
+			else if (txvalid_count && !rxvalid_count)
+				break;
+		}
+		if (first_txdly_valid >= 0)
+			break;
+	}
+
+	if (first_txdly_valid < 0 || last_txdly_valid < 0) {
+		if (fast) {
+			fast = 0;
+			goto try_again_slow;
+		} else {
+			goto out;
+		}
+	}
+
+	txdly = (first_txdly_valid + last_txdly_valid) / 2;
+
+	rxvalid_count = 0;
+	first_rxdly_valid = -1;
+	last_rxdly_valid = -1;
+	for (rxdly = 0; rxdly < CQSPI_PHY_DLL_MAX_DELAY;
+			rxdly += rxdly_step) {
+		cadence_qspi_apb_set_phy_cfg(reg_base, rxdly, txdly);
+		err = test_read_fn(slave);
+		if (err < 0) {
+			goto out;
+		} else if (!err) {
+			++rxvalid_count;
+
+			if (first_rxdly_valid < 0)
+				first_rxdly_valid = rxdly;
+			last_rxdly_valid = rxdly;
+
+			//check if we have enough passing configurations
+			if (dqs && rxvalid_count >= 2)
+				break;
+			else if (!dqs && (rxvalid_count >= rxpass_limit))
+				break;
+		} else if (rxvalid_count == 1) {
+			//must be consecutive to be valid
+			rxvalid_count = 0;
+			first_rxdly_valid = -1;
+			last_rxdly_valid = -1;
+		} else if (rxvalid_count >= 2) {
+			break; //end of valid range
+		}
+	}
+
+	if (first_rxdly_valid < 0 || last_rxdly_valid < 0) {
+		if (fast) {
+			fast = 0;
+			goto try_again_slow;
+		} else {
+			goto out;
+		}
+	}
+
+	if (dqs)
+		rxdly = first_rxdly_valid + 1;
+	else
+		rxdly = (first_rxdly_valid + last_rxdly_valid) / 2;
+
+	cadence_qspi_apb_set_phy_cfg(reg_base, rxdly, txdly);
+	err = test_read_fn(slave);
+	if (err < 0) {
+		goto out;
+	} else if (err) {
+		if (fast) {
+			fast = 0;
+			goto try_again_slow;
+		} else {
+			goto out;
+		}
+	}
+
+	priv->phyrxdly = rxdly;
+	priv->phytxdly = txdly;
+	priv->read_delay = rdcd;
+
+	debug("%s: read-delay=%u phyrxdly=%u phytxdly=%u\n",
+	      __func__, rdcd, rxdly, txdly);
+
+	return 0;
+
+out:
+	cadence_spi_update_speed(bus, false);
+	return err;
+}
+#endif
+
 static unsigned int cadence_qspi_calc_dummy(const struct spi_mem_op *op,
 					    bool dtr)
 {
@@ -166,30 +444,6 @@ static unsigned int cadence_qspi_wait_idle(void *reg_base)
 	return 0;
 }
 
-void cadence_qspi_apb_readdata_capture(void *reg_base,
-				unsigned int bypass, unsigned int delay)
-{
-	unsigned int reg;
-	cadence_qspi_apb_controller_disable(reg_base);
-
-	reg = readl(reg_base + CQSPI_REG_RD_DATA_CAPTURE);
-
-	if (bypass)
-		reg |= CQSPI_REG_RD_DATA_CAPTURE_BYPASS;
-	else
-		reg &= ~CQSPI_REG_RD_DATA_CAPTURE_BYPASS;
-
-	reg &= ~(CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK
-		<< CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB);
-
-	reg |= (delay & CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK)
-		<< CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB;
-
-	writel(reg, reg_base + CQSPI_REG_RD_DATA_CAPTURE);
-
-	cadence_qspi_apb_controller_enable(reg_base);
-}
-
 void cadence_qspi_apb_config_baudrate_div(void *reg_base,
 	unsigned int ref_clk_hz, unsigned int sclk_hz)
 {
@@ -211,8 +465,13 @@ void cadence_qspi_apb_config_baudrate_div(void *reg_base,
 	if (div > CQSPI_REG_CONFIG_BAUD_MASK)
 		div = CQSPI_REG_CONFIG_BAUD_MASK;
 
-	debug("%s: ref_clk %dHz sclk %dHz Div 0x%x, actual %dHz\n", __func__,
-	      ref_clk_hz, sclk_hz, div, ref_clk_hz / (2 * (div + 1)));
+	debug("%s: ref_clk %dHz sclk %dHz Div 0x%x, %s %dHz\n", __func__,
+	      ref_clk_hz, sclk_hz, div,
+	      (readl(reg_base + CQSPI_REG_CONFIG) &
+	       CQSPI_REG_CONFIG_PHY_ENABLE_MASK) ? "PHY" : "actual",
+	      (readl(reg_base + CQSPI_REG_CONFIG) &
+	       CQSPI_REG_CONFIG_PHY_ENABLE_MASK) ?
+	       ref_clk_hz : ref_clk_hz / (2 * (div + 1)));
 
 	reg |= (div << CQSPI_REG_CONFIG_BAUD_LSB);
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
@@ -324,8 +583,8 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 	/* Clear the previous value */
 	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
 	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
-	reg |= (priv->page_size << CQSPI_REG_SIZE_PAGE_LSB);
-	reg |= (priv->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
+	reg |= (priv->plat->page_size << CQSPI_REG_SIZE_PAGE_LSB);
+	reg |= (priv->plat->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
 	writel(reg, priv->regbase + CQSPI_REG_SIZE);
 
 	/* Configure the remap address register, no remap */
@@ -877,7 +1136,7 @@ static int
 cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 					unsigned int n_tx, const u8 *txbuf)
 {
-	unsigned int page_size = priv->page_size;
+	unsigned int page_size = priv->plat->page_size;
 	unsigned int remaining = n_tx;
 	const u8 *bb_txbuf = txbuf;
 	void *bounce_buf = NULL;
@@ -968,13 +1227,23 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
 	u32 to = op->addr.val;
 	const void *buf = op->data.buf.out;
 	size_t len = op->data.nbytes;
+	u32 cfg;
 	int retval = 0;
 
 	cadence_qspi_apb_enable_linear_mode(true);
 	if (op->addr.nbytes && priv->use_dac_mode && (to + len < priv->ahbsize)) {
+		cfg = readl(priv->regbase + CQSPI_REG_CONFIG);
+		if (priv->plat->slow_phy_tx && (cfg & CQSPI_REG_CONFIG_PHY_ENABLE_MASK))
+			writel(cfg & ~(CQSPI_REG_CONFIG_PHY_ENABLE_MASK),
+			       priv->regbase + CQSPI_REG_CONFIG);
+
 		retval = priv->ops.direct_write_copy(priv, buf, to, len);
+
 		if (!cadence_qspi_wait_idle(priv->regbase))
 			retval = -EIO;
+
+		writel(cfg, priv->regbase + CQSPI_REG_CONFIG);
+
 		return retval;
 	}
 
-- 
2.43.2

