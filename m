Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF38C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C7188213;
	Fri, 12 Apr 2024 00:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="TNjEqUqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FEEF88229; Fri, 12 Apr 2024 00:37:49 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA9F881FE
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dcbc6a6808fso308473276.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875065; x=1713479865;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaUFGnTC45loDw+ajgYymT2Xbb7DoytNPTC5wR165Zs=;
 b=TNjEqUqyoZUcXiIrmH0h/R9TwBsByMRMm7GYC+67PXJDz5H4wxaRliFQEf+0UV9Jsc
 lKHZWb+EEaIbv3hRO1UkdTmgbB9TON1whr2yu1TAV5AWYEFMBAwWw9hpaA0zsOOHDHle
 IMR4xWpFzA5XpVpRjKQMlR715YGaDcbvvX28WPUNlvGxxZ9LVccaIaWT+fnzd7LUCOQY
 K6K7ROaqozgzPqKdMescgxj2cQY+5pzY/1Qb3gTizLBr31RwPvbcVHVlW1ouT14bgK/T
 2OuFMEDAnPU+0BfQyoIwPrZ+SFuG/PMRyDJigJFaFK1kD51TV0hm/uvaw8k727Wjtl9M
 6QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875065; x=1713479865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaUFGnTC45loDw+ajgYymT2Xbb7DoytNPTC5wR165Zs=;
 b=I31EPPPggCOpo20mCoOCAaCFB1b5ZCE8k8pf96uZkwMhXK1oI6XRygzSXr2CG32DlN
 0PLMrPMmYneHcy6OgZuv3zzT2PvkLnBdSZOYhIElYgN9M4Lz++JrcHp/3XxqhnLOjEzy
 6voSJERfEFo0fQlRQPa+yvOYVlIhq375RR+gMkjevNxqDwxZ+pT1HIT0syQ3p4k4Ok7g
 RxQFCZoO0UvqxDM2Tjdf/L9xGgn1YvkvE9jvTAE0UmJeET4gjSShyPfoY5+OKamHpbdJ
 Kk5LIYwdtElW4nkt+q01ZH5SEvic1LUuKL2HUJRK+mv/DP+OkSPjqV+yUiAedE1Q/+vp
 qFpg==
X-Gm-Message-State: AOJu0YwuWdx0oasxJKgLeJMWkNM5IHN66/W9VeuxLQqZVB30/0DnGq35
 5yneOW4cP+IIu6sYJAAJOo6a2Iyb/ZlwE896oencTPnTDFEfOlwG4Gf5ZyEWoT3+JK1fbmS9BUp
 xBg==
X-Google-Smtp-Source: AGHT+IG+1M8DLkz2MMBlk0+RYG0bPrk5TQLObIDo+PVZ3rjEBizty/4Qe2Ny2S38qMppWpvx8FoExw==
X-Received: by 2002:a05:6902:2409:b0:dcf:56c5:4298 with SMTP id
 dr9-20020a056902240900b00dcf56c54298mr1091188ybb.12.1712875065378; 
 Thu, 11 Apr 2024 15:37:45 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:45 -0700 (PDT)
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
Subject: [PATCH 09/11] spi: cadence-quadspi: Add support for memory DMA
 channel transfers
Date: Thu, 11 Apr 2024 18:36:53 -0400
Message-ID: <20240411223709.573-10-greg.malysa@timesys.com>
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

On the SC59x platform, the Cadence SPI IP block can use memory DMA
channels to execute transactions. Existing Cadence DMA support attempts
appears to be SOC specific and not generic. Thus, framework to use the
DMA subsystem was added. On the SC59x, DMA to the Cadence SPI block is
connected via memory DMA instead of peripheral DMA. In addition, some
of the memory DMA channels are recommended over others for better
transaction performance. This initial implementation simply uses the
recommended memory channel indicated from the device tree. Peripheral
DMA support can be added later for platforms that need it.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 drivers/spi/cadence_qspi.c     | 47 ++++++++++++++++
 drivers/spi/cadence_qspi.h     | 31 +++++++++--
 drivers/spi/cadence_qspi_apb.c | 99 ++++++++++++++++++++++++++++++----
 3 files changed, 164 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index a2644d9e11..a5e921cae7 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -7,6 +7,8 @@
 #include <common.h>
 #include <clk.h>
 #include <log.h>
+#include <asm-generic/io.h>
+#include <dma.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <malloc.h>
@@ -194,6 +196,42 @@ static int cadence_spi_set_speed(struct udevice *bus, uint hz)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(DMA_CHANNELS)
+static int cadence_spi_probe_dma(struct udevice *bus)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	struct dma_dev_priv *dma_uc;
+	int hasdma;
+	int ret;
+
+	hasdma = (ofnode_read_u32(dev_ofnode(bus), "dmas", NULL) == 0) &&
+		 (ofnode_read_u32(dev_ofnode(bus), "dma-names", NULL) == 0);
+	if (!hasdma)
+		return 0;
+
+	ret = dma_get_by_name(bus, "dst", &priv->dstdma);
+	if (ret != 0)
+		return 0;
+
+	dma_uc = dev_get_uclass_priv(priv->dstdma.dev);
+
+	if (dma_uc->supported == DMA_SUPPORTS_MEM_TO_MEM) {
+		/* We were given a specific DMA channel that only
+		 * supports mem-to-mem transactions.
+		 */
+		priv->hasdma = hasdma;
+		priv->ops.direct_read_copy = cadence_qspi_apb_read_copy_mdma;
+		priv->ops.direct_write_copy = cadence_qspi_apb_write_copy_mdma;
+		return 0;
+	}
+
+	/* Todo: Implement device DMA channel modes when needed
+	 * (DMA_SUPPORTS_MEM_TO_DEV, DMA_SUPPORTS_DEV_TO_MEM).
+	 */
+	return -ENOSYS;
+}
+#endif
+
 static int cadence_spi_probe(struct udevice *bus)
 {
 	struct cadence_spi_plat *plat = dev_get_plat(bus);
@@ -219,6 +257,9 @@ static int cadence_spi_probe(struct udevice *bus)
 	priv->tchsh_ns		= plat->tchsh_ns;
 	priv->tslch_ns		= plat->tslch_ns;
 
+	priv->ops.direct_read_copy = cadence_qspi_apb_direct_read_copy;
+	priv->ops.direct_write_copy = cadence_qspi_apb_direct_write_copy;
+
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
 		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
 				  ZYNQMP_PM_CAPABILITY_ACCESS, ZYNQMP_PM_MAX_QOS,
@@ -252,6 +293,12 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
 
+	if (CONFIG_IS_ENABLED(DMA_CHANNELS)) {
+		ret = cadence_spi_probe_dma(bus);
+		if (ret)
+			return ret;
+	}
+
 	/* Versal and Versal-NET use spi calibration to set read delay */
 	if (CONFIG_IS_ENABLED(ARCH_VERSAL) ||
 	    CONFIG_IS_ENABLED(ARCH_VERSAL_NET))
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 5704f5a3f6..9c15d3c6df 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -223,7 +223,16 @@ struct cadence_spi_plat {
 	u32		tchsh_ns;
 	u32		tslch_ns;
 
-	bool            is_dma;
+	bool		is_dma;
+};
+
+struct cadence_spi_priv;
+
+struct cadence_drv_ops {
+	int (*direct_read_copy)(struct cadence_spi_priv *priv,
+				void *dst, u64 src, size_t len);
+	int (*direct_write_copy)(struct cadence_spi_priv *priv,
+				 const void *src, u64 dst, size_t len);
 };
 
 struct cadence_spi_priv {
@@ -234,11 +243,17 @@ struct cadence_spi_priv {
 	unsigned int	fifo_depth;
 	unsigned int	fifo_width;
 	unsigned int	trigger_address;
-	fdt_addr_t      ahbsize;
+	fdt_addr_t	ahbsize;
 	size_t		cmd_len;
 	u8		cmd_buf[32];
 	size_t		data_len;
 
+	bool		hasdma;
+#if CONFIG_IS_ENABLED(DMA_CHANNELS)
+	struct dma	dstdma;
+#endif
+	struct cadence_drv_ops ops;
+
 	int		qspi_is_init;
 	unsigned int	qspi_calibrated_hz;
 	unsigned int	qspi_calibrated_cs;
@@ -253,8 +268,8 @@ struct cadence_spi_priv {
 	u32		tsd2d_ns;
 	u32		tchsh_ns;
 	u32		tslch_ns;
-	u8              edge_mode;
-	u8              dll_mode;
+	u8		edge_mode;
+	u8		dll_mode;
 	bool		extra_dummy;
 	bool		ddr_init;
 	bool		is_decoded_cs;
@@ -312,4 +327,12 @@ int cadence_qspi_versal_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
 
+int cadence_qspi_apb_read_copy_mdma(struct cadence_spi_priv *priv,
+				    void *dst, u64 src, size_t len);
+int cadence_qspi_apb_write_copy_mdma(struct cadence_spi_priv *priv,
+				     const void *src, u64 dst, size_t len);
+int cadence_qspi_apb_direct_read_copy(struct cadence_spi_priv *priv,
+				      void *dst, u64 src, size_t len);
+int cadence_qspi_apb_direct_write_copy(struct cadence_spi_priv *priv,
+				       const void *src, u64 dst, size_t len);
 #endif /* __CADENCE_QSPI_H__ */
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 340889c271..90b9c558b2 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -29,9 +29,11 @@
 #include <log.h>
 #include <asm/io.h>
 #include <dma.h>
+#include <dma-uclass.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/dma-mapping.h>
 #include <wait_bit.h>
 #include <spi.h>
 #include <spi-mem.h>
@@ -781,17 +783,15 @@ int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
 	u64 from = op->addr.val;
 	void *buf = op->data.buf.in;
 	size_t len = op->data.nbytes;
+	int retval = 0;
 
 	cadence_qspi_apb_enable_linear_mode(true);
 
 	if (op->addr.nbytes && priv->use_dac_mode && (from + len < priv->ahbsize)) {
-		if (len < 256 ||
-		    dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
-			memcpy_fromio(buf, priv->ahbbase + from, len);
-		}
+		retval = priv->ops.direct_read_copy(priv, buf, from, len);
 		if (!cadence_qspi_wait_idle(priv->regbase))
-			return -EIO;
-		return 0;
+			retval = -EIO;
+		return retval;
 	}
 
 	return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
@@ -968,13 +968,14 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
 	u32 to = op->addr.val;
 	const void *buf = op->data.buf.out;
 	size_t len = op->data.nbytes;
+	int retval = 0;
 
 	cadence_qspi_apb_enable_linear_mode(true);
 	if (op->addr.nbytes && priv->use_dac_mode && (to + len < priv->ahbsize)) {
-		memcpy_toio(priv->ahbbase + to, buf, len);
+		retval = priv->ops.direct_write_copy(priv, buf, to, len);
 		if (!cadence_qspi_wait_idle(priv->regbase))
-			return -EIO;
-		return 0;
+			retval = -EIO;
+		return retval;
 	}
 
 	return cadence_qspi_apb_indirect_write_execute(priv, len, buf);
@@ -999,3 +1000,83 @@ void cadence_qspi_apb_enter_xip(void *reg_base, char xip_dummy)
 	reg |= (1 << CQSPI_REG_RD_INSTR_MODE_EN_LSB);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 }
+
+#if CONFIG_IS_ENABLED(DMA_CHANNELS)
+static int cadence_qspi_apb_copy_mdma(struct udevice *dmadev,
+				      void *dst, void *src, size_t len)
+{
+	struct dma_ops *ops = (struct dma_ops *)dmadev->driver->ops;
+
+	/* Some transfers might not be aligned to cache boundaries. Align them
+	 * for the cache operation while preserving the original transfer
+	 * address.
+	 */
+	uintptr_t algn_dst_l = ((uintptr_t)dst / ARCH_DMA_MINALIGN) *
+				ARCH_DMA_MINALIGN;
+	uintptr_t algn_dst_h = ALIGN((uintptr_t)dst + len, ARCH_DMA_MINALIGN);
+	uintptr_t algn_src_l = ((uintptr_t)src / ARCH_DMA_MINALIGN) *
+				ARCH_DMA_MINALIGN;
+	uintptr_t algn_src_h = ALIGN((uintptr_t)src + len, ARCH_DMA_MINALIGN);
+	uintptr_t algn_len = max(algn_dst_h - algn_dst_l,
+				 algn_src_h - algn_src_l);
+
+	dma_addr_t dst_map = dma_map_single((void *)algn_dst_l, algn_len,
+					    DMA_FROM_DEVICE);
+	dma_addr_t src_map = dma_map_single((void *)algn_src_l, algn_len,
+					    DMA_TO_DEVICE);
+
+	uintptr_t dma_dst = dst_map + ((uintptr_t)dst - algn_dst_l);
+	uintptr_t dma_src = src_map + ((uintptr_t)src - algn_src_l);
+
+	int ret = ops->transfer(dmadev, DMA_MEM_TO_MEM, dma_dst, dma_src, len);
+
+	dma_unmap_single(dst_map,  algn_len, DMA_FROM_DEVICE);
+	dma_unmap_single(src_map, algn_len, DMA_TO_DEVICE);
+
+	return ret;
+}
+
+int cadence_qspi_apb_read_copy_mdma(struct cadence_spi_priv *priv,
+				    void *dst, u64 src, size_t len)
+{
+	return cadence_qspi_apb_copy_mdma(priv->dstdma.dev, dst,
+					  priv->ahbbase + src, len);
+}
+
+int cadence_qspi_apb_write_copy_mdma(struct cadence_spi_priv *priv,
+				     const void *src, u64 dst, size_t len)
+{
+	return cadence_qspi_apb_copy_mdma(priv->dstdma.dev,
+					  priv->ahbbase + dst,
+					  (void *)src, len);
+}
+#else
+int cadence_qspi_apb_read_copy_mdma(struct cadence_spi_priv *priv,
+				    void *dst, u64 src, size_t len)
+{
+	return -ENOSYS;
+}
+
+int cadence_qspi_apb_write_copy_mdma(struct cadence_spi_priv *priv,
+				     const void *src, u64 dst, size_t len)
+{
+	return -ENOSYS;
+}
+#endif
+
+int cadence_qspi_apb_direct_read_copy(struct cadence_spi_priv *priv,
+				      void *dst, u64 src, size_t len)
+{
+	if (len < 256 ||
+	    dma_memcpy(dst, priv->ahbbase + src, len) < 0) {
+		memcpy_fromio(dst, priv->ahbbase + src, len);
+	}
+	return 0;
+}
+
+int cadence_qspi_apb_direct_write_copy(struct cadence_spi_priv *priv,
+				       const void *src, u64 dst, size_t len)
+{
+	memcpy_toio(priv->ahbbase + dst, src, len);
+	return 0;
+}
-- 
2.43.2

