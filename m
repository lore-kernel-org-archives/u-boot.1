Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156BECA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 12:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28D4183AB5;
	Tue,  2 Sep 2025 14:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="A80TB4ST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B760A83AC5; Tue,  2 Sep 2025 12:08:14 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E0883A91
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 12:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=333b0acd5=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1756807692; x=1788343692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1ZAt8DRCUn+08e078ex+HIUDSnf60Xo2NGLHtDTRVbk=;
 b=A80TB4STMLlNe/gpLhBndG6vmg5n2E1DMcyesI0LZLaYOMCioFM9H+SY
 9QiozFJYhSzJO6NHJpK7v1nPNbYG7xRi5B5zbrn+kPn+b6lRj+o5ka7WU
 9pC+tE1U4yZwjt1qw6jkn2YPYDaZLvvZVzqJ6cfgpx8DUsS4PUV88qJKf
 yJ2TMfrRZw6pUR23SmNxkh3VHnyXqt5uy5F4w29WfN/snq8QdRLje2V+f
 mfr+rMMrHSkIA6uQG5V8PATSSQ08lTdHANa+8YDrskRF8Z13LA6wTYvkC
 ulGhDyKplvHqxmh+/cPs4/D5qr06VCYXZEFfxQz4pQnCQPI8gy4avWMI7 A==;
X-CSE-ConnectionGUID: JT66SDXQQWy8/gAC9Q5PjA==
X-CSE-MsgGUID: 8qZnKBokSVepmDt2tiXu8w==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="46493824"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2025 03:08:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 03:07:40 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 03:07:38 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH 5/6] misc: mpfs_syscontroller: add functions to read device
 tree overlays
Date: Tue, 2 Sep 2025 11:11:02 +0100
Message-ID: <20250902101105.3218793-6-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
References: <20250902101105.3218793-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 02 Sep 2025 14:59:00 +0200
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

Include functions to use the system controller to read the device tree
overlays which supports auto update functionality.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 drivers/misc/mpfs_syscontroller.c | 200 ++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
index 41e80815ab5..f608d5518b0 100644
--- a/drivers/misc/mpfs_syscontroller.c
+++ b/drivers/misc/mpfs_syscontroller.c
@@ -22,7 +22,27 @@
 #include <misc.h>
 #include <mpfs-mailbox.h>
 
+#define SYS_SPI_CMD						0x50
+#define SYS_SPI_MAILBOX_DATA_LEN		17
+#define SYS_SPI_MAILBOX_SRC_OFFSET		8
+#define SYS_SPI_MAILBOX_LENGTH_OFFSET	12
+#define SYS_SPI_MAILBOX_FREQ_OFFSET		16
+#define SYS_SPI_MAILBOX_FREQ			3
+#define SPI_FLASH_ADDR					0x400
+
 /* Descriptor table */
+#define START_OFFSET					4
+#define END_OFFSET						8
+#define SIZE_OFFSET						12
+#define DESC_NEXT						12
+#define DESC_RESERVED_SIZE				0
+#define DESC_SIZE						16
+
+#define DESIGN_MAGIC_0					0x4d /* 'M' */
+#define DESIGN_MAGIC_1					0x43 /* 'C'*/
+#define DESIGN_MAGIC_2					0x48 /* 'H'*/
+#define DESIGN_MAGIC_3					0x50 /* 'P'*/
+
 #define CMD_OPCODE						0x0u
 #define CMD_DATA_SIZE					0U
 #define CMD_DATA						NULL
@@ -109,6 +129,186 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *devi
 }
 EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
 
+static u16 mpfs_syscontroller_service_spi_copy(struct mpfs_sys_serv *sys_serv_priv, u64 dst_addr, u32 src_addr, u32 length)
+{
+	int ret;
+	u32 mailbox_format[SYS_SPI_MAILBOX_DATA_LEN];
+
+	*(u64 *)mailbox_format = dst_addr;
+	mailbox_format[SYS_SPI_MAILBOX_SRC_OFFSET/4] = src_addr;
+	mailbox_format[SYS_SPI_MAILBOX_LENGTH_OFFSET/4] = length;
+	mailbox_format[SYS_SPI_MAILBOX_FREQ_OFFSET/4] = SYS_SPI_MAILBOX_FREQ;
+
+	struct mpfs_mss_response response = {
+		.resp_status = 0U,
+		.resp_msg = mailbox_format,
+		.resp_size = RESP_BYTES};
+	struct mpfs_mss_msg msg = {
+		.cmd_opcode = SYS_SPI_CMD,
+		.cmd_data_size = SYS_SPI_MAILBOX_DATA_LEN,
+		.response = &response,
+		.cmd_data = (u8 *)mailbox_format,
+		.mbox_offset = MBOX_OFFSET,
+		.resp_offset = RESP_OFFSET};
+
+	ret = mpfs_syscontroller_run_service(sys_serv_priv->sys_controller, &msg);
+	if (ret) {
+		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort. Failure: %u\n", ret, msg.response->resp_status);
+	}
+
+	return ret;
+}
+
+static u16 mpfs_syscontroller_get_dtbo_desc_header(struct mpfs_sys_serv *sys_serv_priv, u8 *desc_data, u32 desc_addr)
+{
+	u32 length, no_of_descs;
+	int ret = -ENOENT;
+
+	/* Get first four bytes to calculate length */
+	ret = mpfs_syscontroller_service_spi_copy(sys_serv_priv, (u64)desc_data, desc_addr, BYTES_4);
+	if (!ret) {
+		no_of_descs = *((u32 *)desc_data);
+		if (no_of_descs) {
+			length = DESC_SIZE + ((no_of_descs - 1) * DESC_SIZE);
+			ret = mpfs_syscontroller_service_spi_copy(sys_serv_priv, (u64)desc_data, desc_addr,
+						      length);
+		}
+	}
+
+	return ret;
+}
+
+static u8 *mpfs_syscontroller_get_dtbo(struct mpfs_sys_serv *sys_serv_priv, u32 start_addr, u32 size)
+{
+	int ret;
+	u8 *dtbo;
+
+	/* Intentionally never freed, even on success so that u-boot "userspace" can access it. */
+	dtbo = (u8 *)malloc(size);
+
+	ret = mpfs_syscontroller_service_spi_copy(sys_serv_priv, (u64)dtbo, start_addr, size);
+	if (ret) {
+		free(dtbo);
+		dtbo = NULL;
+	}
+
+	return dtbo;
+}
+
+static void mpfs_syscontroller_parse_desc_header(struct mpfs_sys_serv *sys_serv_priv, u8 *desc_header, u8 *no_of_dtbo, u32 *dtbos_size)
+{
+	u32 dtbo_desc_start_addr;
+	u32 dtbo_desc_size;
+	u32 no_of_descs;
+	u16 i;
+	u8 dtbo_name[16];
+	u8 dtbo_addr[20];
+	u8 *desc;
+	u8 *dtbo;
+
+	no_of_descs = *((u32 *)desc_header);
+
+	for (i = 0; i < no_of_descs; i++) {
+		desc = &desc_header[START_OFFSET + (DESC_NEXT * i)];
+		/*
+		 * The dtbo info structure contains addresses that are relative
+		 * to the start of structure, so the offset of the structure in
+		 * flash must be added to get the actual start address.
+		 */
+		dtbo_desc_start_addr = *((u32 *)desc) + SPI_FLASH_ADDR;
+
+		desc = &desc_header[SIZE_OFFSET + (DESC_NEXT * i)];
+		dtbo_desc_size = *((u32 *)desc);
+
+		dtbo = mpfs_syscontroller_get_dtbo(sys_serv_priv, dtbo_desc_start_addr, dtbo_desc_size);
+		if (dtbo) {
+			sprintf(dtbo_name, "dtbo_image%d", *no_of_dtbo);
+			sprintf(dtbo_addr, "0x%llx", (u64)dtbo);
+			env_set(dtbo_name, dtbo_addr);
+			++*no_of_dtbo;
+			*dtbos_size += dtbo_desc_size;
+		}
+	}
+}
+
+void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv)
+{
+	u32 desc_length;
+	u32 dtbo_desc_addr;
+	u32 dtbo_addr[5];
+	u16 i, hart, no_of_harts;
+	u8 design_info_desc[256];
+	u8 dtbo_desc_data[256];
+	u8 no_of_dtbos[8];
+	u8 dtbo_size[8];
+	u8 *desc;
+	u8 no_of_dtbo = 0;
+	u32 dtbos_size = 0;
+	int ret;
+
+	/* Read first 10 bytes to verify the descriptor is found or not */
+	ret = mpfs_syscontroller_service_spi_copy(sys_serv_priv, (u64)design_info_desc, SPI_FLASH_ADDR, 10);
+	if (ret) {
+		sprintf(no_of_dtbos, "%d", no_of_dtbo);
+		env_set("no_of_overlays", no_of_dtbos);
+		sprintf(dtbo_size, "%d", dtbos_size);
+		env_set("dtbo_size", dtbo_size);
+		return;
+	}
+
+	if (design_info_desc[0] != DESIGN_MAGIC_0 ||
+	    design_info_desc[1] != DESIGN_MAGIC_1 ||
+	    design_info_desc[2] != DESIGN_MAGIC_2 ||
+	    design_info_desc[3] != DESIGN_MAGIC_3) {
+		dev_dbg(sys_serv_priv->dev, "magic not found in desc structure.\n");
+		sprintf(no_of_dtbos, "%d", no_of_dtbo);
+		env_set("no_of_overlays", no_of_dtbos);
+		sprintf(dtbo_size, "%d", dtbos_size);
+		env_set("dtbo_size", dtbo_size);
+		return;
+	}
+	desc_length = *((u32 *)&design_info_desc[4]);
+	/* Read Design descriptor */
+	ret = mpfs_syscontroller_service_spi_copy(sys_serv_priv, (u64)design_info_desc,
+						SPI_FLASH_ADDR, desc_length);
+	if (ret)
+		return;
+
+	no_of_harts = *((u16 *)&design_info_desc[10]);
+
+	for (hart = 0; hart < no_of_harts; hart++) {
+		/* Start address of DTBO descriptor */
+		desc = &design_info_desc[(0x4 * hart) + 0xc];
+
+		dtbo_desc_addr = *((u32 *)desc);
+		dtbo_addr[hart] = dtbo_desc_addr;
+
+		if (!dtbo_addr[hart])
+			continue;
+
+		for (i = 0; i < hart; i++) {
+			if (dtbo_addr[hart] == dtbo_addr[i])
+				continue;
+		}
+
+		if (hart && hart == i)
+			continue;
+
+		dtbo_desc_addr += SPI_FLASH_ADDR;
+		ret = mpfs_syscontroller_get_dtbo_desc_header(sys_serv_priv, dtbo_desc_data,
+							dtbo_desc_addr);
+		if (ret)
+			continue;
+		else
+			mpfs_syscontroller_parse_desc_header(sys_serv_priv, dtbo_desc_data, &no_of_dtbo, &dtbos_size);
+	}
+	sprintf(no_of_dtbos, "%d", no_of_dtbo);
+	env_set("no_of_overlays", no_of_dtbos);
+	sprintf(dtbo_size, "%d", dtbos_size);
+	env_set("dtbo_size", dtbo_size);
+}
+EXPORT_SYMBOL(mpfs_syscontroller_process_dtbo);
+
 static int mpfs_syscontroller_probe(struct udevice *dev)
 {
 	struct mpfs_syscontroller_priv *sys_controller = dev_get_priv(dev);
-- 
2.43.0

