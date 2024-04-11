Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D12DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86778823C;
	Fri, 12 Apr 2024 00:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="0DKiZUWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D18881ED; Fri, 12 Apr 2024 00:37:49 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424B38758B
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-ddda842c399so323542276.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875066; x=1713479866;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Daz87Jsd3MES1tYDBM2LSyxiFUcw/7q9uHvplAxcodY=;
 b=0DKiZUWSeRnoZJOGjfBCgOjan5X+nOUPQOXjEXHm52jp3Bmh4t4+70DVuGUZ/CzFSN
 hD2mIcPo2sovkYB7q01hf+ysVuK/CjkMYk/cPfVhh+NVvpwzignxKooxR3QZyfxfJaGN
 67gRCtOBWgn471k7tX6CKStZ7WYaM2PSnQJ4NajzzixzKP6GItTnJKumvWDJ5VNpvX23
 83uGgfTU47DuLjZ+oCf1X9p22uI75hzsIaK4/z11RN+Mwk4XONGCnxuOhihHTl6qzTx/
 VJxIXFr+oLdmOjT6Ef+Ofw/OcI47lpv0Ls7zYC1QueCLvPMzogVTJKlTtHApL/ANy1BB
 yE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875066; x=1713479866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Daz87Jsd3MES1tYDBM2LSyxiFUcw/7q9uHvplAxcodY=;
 b=WkeM2ep77mtR45yv7BunHHa7LZODHEQYlxx39X7+KtpJD1AkAHLeNPJa0FaEgtiygp
 GN80TNiT4noKjspWkANwdUydWQXFaYsSJrDD2dTY8UDr8L7JHqhmcE/s/Qfv3OC5UAFq
 UUsVbDVzuwI/3pJ/GIq6yICUWa/C5JRCVZabCzmVlehUyj7nBKb+CrLz5AWl738PJ6os
 yHzrxdDoVngyd/Pwkecq+M3F+zBWcHRHm4Jl2uQooI5D1HG78nwwU4N0JeHbi71eXDq4
 gyEpM/IDHYYD78t2TQ2Id0PjOfKKmCCRtxFe8kZfvIu4FiXS5UaxL2j+AM4j6fnP2URo
 FGuQ==
X-Gm-Message-State: AOJu0YxScVcyfu497krxB7SrZR3Lau4w/r1c8+Vnz7KeLt+3YpjzKV6W
 5Blqu937ILfE+DM1Oiz+PuHlymD1GVnygRVxXzp3EWdOOovYzQhyMBlE+5maV99MbTDQgkREDbL
 vnQ==
X-Google-Smtp-Source: AGHT+IHodI7c3/oCP5vXFrwVBiSDx945Tj7yByl1aRYQHV+CO/ZdpDTBH9NJ6C/dyGhgXPapdCJGMw==
X-Received: by 2002:a05:6902:e13:b0:dc7:4367:2527 with SMTP id
 df19-20020a0569020e1300b00dc743672527mr1114712ybb.49.1712875066010; 
 Thu, 11 Apr 2024 15:37:46 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:45 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Apurva Nandan <a-nandan@ti.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Johan Jonker <jbx6244@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 10/11] spi: cadence-quadspi: Add DT control of max Read Delay
 Capture value
Date: Thu, 11 Apr 2024 18:36:54 -0400
Message-ID: <20240411223709.573-11-greg.malysa@timesys.com>
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

On some SOCs (eg sc59x), attempting to use too high of a Read
Delay Capture value can cause the controller DMA to lock up. Thus,
add a device tree configuration property to allow controlling
the max Read Delay Capture value.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 doc/device-tree-bindings/spi/spi-cadence.txt | 2 ++
 drivers/spi/cadence_qspi.c                   | 9 ++++++++-
 drivers/spi/cadence_qspi.h                   | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/doc/device-tree-bindings/spi/spi-cadence.txt b/doc/device-tree-bindings/spi/spi-cadence.txt
index 69e02c1c4b..9bd7ef8bed 100644
--- a/doc/device-tree-bindings/spi/spi-cadence.txt
+++ b/doc/device-tree-bindings/spi/spi-cadence.txt
@@ -29,3 +29,5 @@ connected flash properties
 			  select (n_ss_out).
 - cdns,tslch-ns		: Delay in master reference clocks between setting
 			  n_ss_out low and first bit transfer
+- cdns,max-read-delay	: Max safe value to use for the read capture delay
+			  during auto calibration.
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index a5e921cae7..3778a469d4 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -104,7 +104,7 @@ static int spi_calibration(struct udevice *bus, uint hz)
 
 	/* use back the intended clock and find low range */
 	cadence_spi_write_speed(bus, hz);
-	for (i = 0; i < CQSPI_READ_CAPTURE_MAX_DELAY; i++) {
+	for (i = 0; i < priv->max_read_delay; i++) {
 		/* Disable QSPI */
 		cadence_qspi_apb_controller_disable(base);
 
@@ -246,6 +246,7 @@ static int cadence_spi_probe(struct udevice *bus)
 	priv->fifo_depth	= plat->fifo_depth;
 	priv->fifo_width	= plat->fifo_width;
 	priv->trigger_address	= plat->trigger_address;
+	priv->max_read_delay	= plat->max_read_delay;
 	priv->read_delay	= plat->read_delay;
 	priv->ahbsize		= plat->ahbsize;
 	priv->max_hz		= plat->max_hz;
@@ -456,6 +457,10 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 
 	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
 
+	plat->max_read_delay = dev_read_u32_default(bus,
+						    "cdns,max-read-delay",
+						    CQSPI_READ_CAPTURE_MAX_DELAY);
+
 	/* All other parameters are embedded in the child node */
 	subnode = cadence_qspi_get_subnode(bus);
 	if (!ofnode_valid(subnode)) {
@@ -484,6 +489,8 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	 */
 	plat->read_delay = ofnode_read_s32_default(subnode, "cdns,read-delay",
 						   -1);
+	if (plat->read_delay > plat->max_read_delay)
+		plat->read_delay = plat->max_read_delay;
 
 	debug("%s: regbase=%p ahbbase=%p max-frequency=%d page-size=%d\n",
 	      __func__, plat->regbase, plat->ahbbase, plat->max_hz,
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 9c15d3c6df..d7a02f0870 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -214,6 +214,7 @@ struct cadence_spi_plat {
 	fdt_addr_t	ahbsize;
 	bool		use_dac_mode;
 	int		read_delay;
+	int		max_read_delay;
 
 	/* Flash parameters */
 	u32		page_size;
@@ -260,6 +261,7 @@ struct cadence_spi_priv {
 	unsigned int	previous_hz;
 	u32		wr_delay;
 	int		read_delay;
+	int		max_read_delay;
 
 	struct reset_ctl_bulk *resets;
 	u32		page_size;
-- 
2.43.2

