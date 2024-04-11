Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7CFC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE4AA8821B;
	Fri, 12 Apr 2024 00:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="TfIZVsrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33F68758B; Fri, 12 Apr 2024 00:37:46 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4B8881ED
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-61428e80f0cso2391057b3.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875061; x=1713479861;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VC5QgJvEMwSHV+2NgM4n/T0M53mzLRV8tgNTWTyL2+8=;
 b=TfIZVsrsL7dZbt7wPmmz55LUhoP3zU3nuhqJSJF2/nz+Dx70Q2yE8DXzRl45TAR4Oo
 Zg1sD4W5mWUKjqgBbLL3Pkm+Yz75J05s/dPpaj4RBHwCbtZMI4rbR0NKpEVJDh8idnP1
 5Mcv3VBBELN7BUS+IlQPajm1y/RU+JBtAKUzzG4fAvCIJ/9T8qmVN1MosUXwlM/iNBU5
 MhowHM1K/E6MrYJx938zPhM9CIP1Oc9cH0K5W7U7WtN6OlwY3DFauqM5dSBIz7c06rL2
 bvJylgzjydHg2hvRtncBMjxtn1584nd417uGvpOkOyGRWT8eY58UV8SHhVIk7IM/zHtt
 cCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875061; x=1713479861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VC5QgJvEMwSHV+2NgM4n/T0M53mzLRV8tgNTWTyL2+8=;
 b=kQQPuW0bXM/efuODx1KKu3nw1BRDwmjNGrwFPiLYFooxo7lTwuoduxfNz+vjldesqa
 CfDRXBOpKJBqlVWNsBrzpr9/mtpAmQEM4YHJZ97CmizInXSMWH/yfIuIXTWxg9zO2kvI
 lr+ZXURNATilvZuO0A4cftZR42I/LLfl0PxH+fmKUzc8nT3TN4sNY8x4CSQfzCGjiny7
 SUNHSJl1YEsSyOGDQuaABHpv/RwIMZ0pMEceW5RHLF0Pm76KqZNShho2pnFgLz5JVTb0
 QhEDcLZyP//1/LJva341gzHC5WmchOcyimZicgmrFaHHeLQbaH4RUQn8yq7/jfHo7nbo
 gG1g==
X-Gm-Message-State: AOJu0Ywg9Cedy04Qlbe2NV4Lwzrwx0Ltf+b4kGJyFmpZIM7jH6LWcMfc
 pIWx748lwxmEV71FGvIE4wn4E6pnREm7oC31voF/XYX7zpnE901R7sW6YQdEiM9ibphXmOcyFst
 jxA==
X-Google-Smtp-Source: AGHT+IEgdPMNYg5eJGI94hu/ft6hWgHOjnI3HBLdwCR1v6MR0LocLrgnkfEkhsL6JAjHGpLAuEU3JQ==
X-Received: by 2002:a25:e081:0:b0:db9:9134:bb28 with SMTP id
 x123-20020a25e081000000b00db99134bb28mr1018117ybg.4.1712875060031; 
 Thu, 11 Apr 2024 15:37:40 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:39 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Dhruva Gole <d-gole@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marex@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH 01/11] mtd: spi-nor: Add calibration hook for high speed SPI
Date: Thu, 11 Apr 2024 18:36:45 -0400
Message-ID: <20240411223709.573-2-greg.malysa@timesys.com>
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

High speed SPI flash chip operation, such as speeds greater than 50MHz,
require a calibration of the data lines to determine the correct signal
propagation delay. This calibration delay will vary based on flash chip,
operating frequency, board trace length, and board temperature to a
smaller extent.

To my knowledge, JEDEC doesn't have a well defined standard for how
calibration should be implemented by flash chip manufacturers. The few
flash chip datasheets I have viewed from chips that do support such high
speed operation implement very different methods for assisting in
calibration, such as:
 * No provision for calibration.
 * Independent "data learning" commands.
 * Scratch data registers.
 * Predefined bit patterns inserted before read data contents
   (preamble).

Thus, the simplest and most portable solution to calibrate appears to be
to simply read and compare a known data pattern from the flash array.

During SPI flash probe, calibration is initialized after the SFDP read,
but before read command selection. At this stage, higher speeds, more
advanced read commands, and additional IO lanes, and dual data rate
options have not yet been enabled. Communication is most reliable at
this stage to read out a pattern to then check against later. The most
basic and widely supported read commands are then used to read out the
data pattern. The default is to read 2 flash pages worth of data at the
first address in flash. Commonly, this is where a bootloader might be
located on the chip. While a bootloader is not an ideal pattern, two
pages worth of data hopefully contains enough entropy to calibrate
successfully. This can be further customized with two new flash chip
device tree parameters:

 * 'calibration-offset' The flash chip address offset where the pattern
   data is located.
 * 'calibration-length' The length of pattern data.

The calibration step is then called at the end of the chip probe, right
after all advanced IO modes have been enabled, such as multiple IO lanes
and SDR/DDR modes.

Another solution to the high speed calibration issue is to perform the
calibration offline and then to simply apply the calibration at boot.
This skips a potentially lengthy calibration process. However, this
change set also serves as an ideal hook for controller drivers to also
simply apply any pre-calibrated values. Early commands in the probe
process, such as RDID, RDSFDP, and RDAY may have slower operating
frequencies. As, for example, the JEDEC spec only requires that RDSFDP
and RDAY to support at least up to 50MHz frequency. Thus it is ideal to
probe the chip at lower frequencies with more reliable IO modes, such as
a low frequency with one lane at a single data rate.

This patch implements:
 * SPI-mem API function for drivers to implement to perform calibration.
 * Read pattern data through reliable methods.
 * Call SPI-mem API calibration function with a read check function that
   uses probed read commands and all enabled fast IO modes.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>

---


---
 doc/device-tree-bindings/spi/spi-bus.txt |   4 +
 drivers/mtd/spi/Kconfig                  |  12 ++
 drivers/mtd/spi/spi-nor-core.c           | 168 +++++++++++++++++++++++
 drivers/spi/spi-mem.c                    |  24 ++++
 include/linux/mtd/spi-nor.h              |   7 +
 include/spi-mem.h                        |  19 +++
 6 files changed, 234 insertions(+)

diff --git a/doc/device-tree-bindings/spi/spi-bus.txt b/doc/device-tree-bindings/spi/spi-bus.txt
index e57897ac0c..654d388cac 100644
--- a/doc/device-tree-bindings/spi/spi-bus.txt
+++ b/doc/device-tree-bindings/spi/spi-bus.txt
@@ -61,6 +61,10 @@ contain the following properties.
                       used for MISO. Defaults to 1 if not present.
 - spi-half-duplex  - (optional) Indicates that the SPI bus should wait for
 		      a header byte before reading data from the slave.
+- calibration-offset - (optional) Check pattern offset location for high-
+		        speed calibration.
+- calibration-length - (optional) Check pattern length for high-speed
+		        calibration.
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in SPI system transferred in 2 wires(DUAL) or 4 wires(QUAD).
diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index d068b7860e..ed0335d9ba 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -127,6 +127,18 @@ config SPI_FLASH_SOFT_RESET_ON_BOOT
 	 that are not supposed to be handed to U-Boot in Octal DTR mode, even
 	 if they _do_ support the Soft Reset sequence.
 
+config SPI_FLASH_HS_CALIB
+	bool "Support for high-speed SPI flash calibration"
+	default n
+	help
+	 Modern flash chips and controllers that operate at speeds higher than
+	 50MHz require delays in the signal lines to be calibrated. This
+	 feature adds a spi-mem API hook to allow controller drivers to
+	 perform the calibration during chip probe.
+	 Select N here if SPI flash chips or controllers on your platform
+	 operate roughly around or less than 50MHz, or if the controller driver
+	 doesn't implement the calibration hook.
+
 config SPI_FLASH_BAR
 	bool "SPI flash Bank/Extended address register support"
 	help
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f86003ca8c..f164c3cf73 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3230,6 +3230,152 @@ static int spi_nor_select_erase(struct spi_nor *nor,
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+/**
+ * Very basic check to make sure every bit changes in the reference pattern
+ * and that there aren't too many duplicate bytes in a row, such as all FF's
+ * or all zeros.
+ * Returns boolean.
+ */
+static int spi_nor_spimem_validate_calib_data(u8 *buff, size_t len)
+{
+	size_t i;
+	u8 prev;
+	u8 changed_bits = 0;
+	size_t changing = 0;
+
+	if (!buff || !len)
+		return 0;
+
+	prev = *buff;
+	for (i = 1; i < len; ++i) {
+		u8 changed = prev ^ buff[i];
+
+		changed_bits |= changed;
+		if (changed)
+			++changing;
+		prev = buff[i];
+	}
+	return (changing > (len / 2)) && (changed_bits == 0xff);
+}
+
+/** Returns 0 on success, negative error code on error.
+ */
+static int spi_nor_spimem_calib_read_chk(struct spi_slave *slave)
+{
+	struct spi_nor *nor = dev_get_uclass_priv(slave->dev);
+
+	ssize_t readval = nor->read(nor, nor->calib_off,
+				    nor->calib_size,
+				    nor->calib_buff);
+	if (readval != nor->calib_size) {
+		if (readval >= 0)
+			return -EIO;
+		return readval;
+	}
+	return (memcmp(nor->calib_ref_buff,
+		       nor->calib_buff, nor->calib_size) != 0);
+}
+
+static int spi_nor_spimem_calib(struct spi_nor *nor)
+{
+	int retval = 0;
+
+	if (!nor->calib_buff || !nor->calib_ref_buff)
+		return retval;
+
+	retval = spi_mem_calibrate(nor->spi, spi_nor_spimem_calib_read_chk);
+
+	devm_kfree(nor->dev, nor->calib_buff);
+	nor->calib_buff = NULL;
+	devm_kfree(nor->dev, nor->calib_ref_buff);
+	nor->calib_ref_buff = NULL;
+
+	return retval;
+}
+
+static
+int spi_nor_spimem_calib_init(struct spi_nor *nor,
+			      const struct spi_nor_flash_parameter *params,
+			      u32 shared_caps_mask)
+{
+	int err;
+	ssize_t readval;
+	ofnode np = dev_ofnode(nor->spi->dev);
+	u8 old_addr_width = nor->addr_width;
+
+	if (!spi_mem_has_calibrate(nor->spi))
+		return 0;
+
+	/* Select a supported 1x read command to obtain calibration
+	 * reference data.
+	 */
+	shared_caps_mask &= (SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST);
+	err = spi_nor_select_read(nor, params, shared_caps_mask);
+	if (err) {
+		dev_warn(nor->dev,
+			 "Skipping SPI-nor calibration: Can't select 1x read settings supported by both the controller and memory.\n");
+		return 0;
+	}
+
+	/* Default to read the first 2 pages of the flash. Usually, this
+	 * would contain a bootloader image. While this isn't an ideal
+	 * calibration pattern, it's hopefully good enough to get something
+	 * working most of the time.
+	 */
+	ofnode_read_u32(np, "calibration-offset", &nor->calib_off);
+	ofnode_read_u32(np, "calibration-length", &nor->calib_size);
+	if (!nor->calib_size)
+		nor->calib_size = 2 * nor->page_size;
+
+	if (nor->addr_width == 4 ||
+	    ((nor->calib_off + nor->calib_size) > SZ_16M)) {
+		/* Only support a >16MB calibration address if the flash chip
+		 * supports 4 byte commands. Otherwise, it would require
+		 * enabling 4 byte mode. This isn't handled until later, in
+		 * spi_nor_init()
+		 */
+		if (!(nor->flags & SPI_NOR_4B_OPCODES)) {
+			dev_warn(nor->dev,
+				 "Skipping SPI-nor calibration: calibration currently only supports 3 byte addressing.\n");
+			return 0;
+		}
+		nor->read_opcode = spi_nor_convert_3to4_read(nor->read_opcode);
+		nor->addr_width = 4;
+	} else {
+		nor->addr_width = 3;
+	}
+
+	nor->calib_ref_buff = devm_kmalloc(nor->dev, nor->calib_size,
+					   GFP_KERNEL);
+	nor->calib_buff = devm_kmalloc(nor->dev, nor->calib_size, GFP_KERNEL);
+	if (!nor->calib_ref_buff || !nor->calib_buff)
+		return -ENOMEM;
+
+	readval = nor->read(nor, nor->calib_off,
+			    nor->calib_size, nor->calib_ref_buff);
+	if (readval < 0)
+		return readval;
+	else if (nor->calib_size != readval)
+		return -EIO;
+
+	if (!spi_nor_spimem_validate_calib_data(nor->calib_ref_buff,
+						nor->calib_size)) {
+		devm_kfree(nor->dev, nor->calib_ref_buff);
+		devm_kfree(nor->dev, nor->calib_buff);
+		nor->calib_ref_buff = NULL;
+		nor->calib_buff = NULL;
+		dev_warn(nor->dev,
+			 "Skipping SPI-nor calibration: Calibration data has poor entropy.\n");
+	}
+
+	/* Restore settings. */
+	nor->addr_width = old_addr_width;
+
+	return 0;
+}
+#endif
+
 static int spi_nor_default_setup(struct spi_nor *nor,
 				 const struct flash_info *info,
 				 const struct spi_nor_flash_parameter *params)
@@ -3240,6 +3386,12 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 
 	spi_nor_adjust_hwcaps(nor, params, &shared_mask);
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+	err = spi_nor_spimem_calib_init(nor, params, shared_mask);
+	if (err)
+		return err;
+#endif
+
 	/* Select the (Fast) Read command. */
 	err = spi_nor_select_read(nor, params, shared_mask);
 	if (err) {
@@ -3892,6 +4044,14 @@ static int spi_nor_init(struct spi_nor *nor)
 		set_4byte(nor, nor->info, 1);
 	}
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+	err = spi_nor_spimem_calib(nor);
+	if (err) {
+		dev_err(nor->dev, "SPI calibration failed\n");
+		return err;
+	}
+#endif
+
 	return 0;
 }
 
@@ -4057,6 +4217,14 @@ int spi_nor_scan(struct spi_nor *nor)
 	spi_nor_soft_reset(nor);
 #endif /* CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT */
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+	if (spi_mem_has_calibrate(nor->spi)) {
+		ret = spi_mem_calibrate(nor->spi, NULL);
+		if (ret)
+			return ret;
+	}
+#endif
+
 	info = spi_nor_read_id(nor);
 	if (IS_ERR_OR_NULL(info))
 		return -ENOENT;
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index b7eca58359..03ede22216 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -763,6 +763,30 @@ ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 }
 EXPORT_SYMBOL_GPL(spi_mem_dirmap_write);
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+int spi_mem_has_calibrate(struct spi_slave *slave)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+
+	return (ops->mem_ops && ops->mem_ops->calibrate);
+}
+EXPORT_SYMBOL_GPL(spi_mem_has_calibrate);
+
+int spi_mem_calibrate(struct spi_slave *slave,
+		      int (*calib_chk_fn)(struct spi_slave *))
+{
+	struct udevice *bus = slave->dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+
+	if (spi_mem_has_calibrate(slave))
+		return ops->mem_ops->calibrate(slave, calib_chk_fn);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(spi_mem_calibrate);
+#endif
+
 #ifndef __UBOOT__
 static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
 {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1dbf3eadb..2eddb52392 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -593,6 +593,13 @@ struct spi_nor {
 	u32 size;
 	u32 sector_size;
 	u32 erase_size;
+
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+	u8	*calib_ref_buff;
+	u8	*calib_buff;
+	u32	calib_size;
+	u32	calib_off;
+#endif
 };
 
 #ifndef __UBOOT__
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 3c8e95b6f5..3db0f7e11c 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -243,6 +243,15 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		  the currently mapped area), and the caller of
  *		  spi_mem_dirmap_write() is responsible for calling it again in
  *		  this case.
+ * @calibrate: instruct driver to perform or clear high speed calibration for
+ *	       the memory device. The provided function should be used by the
+ *	       driver to check if a calibration configuration is valid. May be
+ *	       called multiple times as needed. Do note that calling the check
+ *	       function may call back into the other ops in this interface.
+ *	       A null calib_chk_fn should clear any existing calibration.
+ *	       calib_chk_fn is expected to return 0 on success, negative error
+ *	       codes, and a positive value on failure.
+ *	       The same return value expectation for the calibrate function.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -266,6 +275,10 @@ struct spi_controller_mem_ops {
 			       u64 offs, size_t len, void *buf);
 	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
 				u64 offs, size_t len, const void *buf);
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+	int (*calibrate)(struct spi_slave *slave,
+			 int (*calib_chk_fn)(struct spi_slave *));
+#endif
 };
 
 #ifndef __UBOOT__
@@ -341,6 +354,12 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 			     u64 offs, size_t len, const void *buf);
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_HS_CALIB)
+int spi_mem_has_calibrate(struct spi_slave *slave);
+int spi_mem_calibrate(struct spi_slave *slave,
+		      int (*calib_chk_fn)(struct spi_slave *));
+#endif
+
 #ifndef __UBOOT__
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
-- 
2.43.2

