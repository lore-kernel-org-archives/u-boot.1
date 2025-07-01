Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E988EC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9666A82F6A;
	Tue,  1 Jul 2025 20:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="juwt77pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFD382F83; Tue,  1 Jul 2025 20:42:42 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BC882F49
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40a55314d06so2063865b6e.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395359; x=1752000159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=N6GtTMlMrSbNAEu3LTJUio+Oc5tqqITHE2IBYYx0rtI=;
 b=juwt77pjbsgsDOV1d84H5n6aRU4d9dKVydyxtg7D6G4i1TKVQfKVINhbyWVQe+QTiN
 AP99zh2dWV8e1KM0WwifDFgGirKQRLKHASSUSzUVHpRbC+6uAY4Uf/jZBZ9Uy5GXhO27
 uBjy9HW0qFOZqdEp6pDHlB0foD6PiY4arI9D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395359; x=1752000159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N6GtTMlMrSbNAEu3LTJUio+Oc5tqqITHE2IBYYx0rtI=;
 b=gAQcXRJ052bBauhygaMaNvhDkx5TGvBdmBUJXbXJcrrIFFTn6MkLxvbawYmOSR40W4
 oZ2yAE/ibrOPZZYGuWdzc9wTYn3+buwKt9bqb82UrjcmOLhOxL29SveCNwNHpwdZ1s3X
 wUM8bzKC8oMQZzD1IZgB3D1AMWZTsRuaVQ/DoZ+ujxFYxQUcbFsELuNiAzRwDK2RybZy
 7w7YyWuUl0bo1ZFgc03d7FJfDsN/V/Lz0jgHluFf6F68APiV4nUD0tg0DETW2Sdie9Ch
 yRhdM/ay0exzVWf2COAGDqecjlDMdD9jibn5vKQyMjr96NsPlscLO1qXaD2pJ8s9a16K
 zMqQ==
X-Gm-Message-State: AOJu0Yzcn4imfX+ReapEmqubTORZaxY7o2q4zwlcoQAyvJjauTizUIa9
 C3l0IiqILmjiqOqGqhvtnrZTmunLKiTA4a6lovWpZ9VQmuyRmSbEd1PYohVzXrUpu8+D9j0t0lN
 4StLdXH4=
X-Gm-Gg: ASbGncu/gwZrHCCIx+ywHzF3ozRyiOjplXP5kzb7BIUVgyh9SjBOz3OPij4UwUfboVu
 OpZ6B4ItcgTE2LEMV/FQVOyQUFNrH8c6y7zz7l7zwU+KGnLxI738axoETDSMFFPeRKsvWf9qX+M
 9nDqjYDaF/kmIFVPRQHLxJ4dKklr2CsVGJxnM6U6SzNpQeVkHqnQlOq72aWEQuS4zgfzwIvYUSV
 NCiz/kIzoGeb8cJAMrgYZkKYTrM6zBg6xrR2GSSvsh2tiyjtcYEP3Dlq6JaQPx8LS6skw1CyX+n
 OqdBv6yOIuH4fDOqnbV7+rfV8RAfaiyZnPG+vK4emizz7btBRXRXjTVLfWE2cyl9Q7sCXp7ZQSy
 gvhIwI2BduY7kmq5h6p+ruPAcFA==
X-Google-Smtp-Source: AGHT+IHniatlgeFz/T/ORK7Eq9pax5rYYItT9rC5mY+4Mfgm0l6AQzKxqaAkoMYOOpD+OcuZXlNzaw==
X-Received: by 2002:a05:6808:1902:b0:401:ea7b:e535 with SMTP id
 5614622812f47-40b33e13d94mr15381079b6e.22.1751395358726; 
 Tue, 01 Jul 2025 11:42:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b324054a2sm2242424b6e.31.2025.07.01.11.42.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:42:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd: Remove "universe" command.
Date: Tue,  1 Jul 2025 12:42:37 -0600
Message-ID: <20250701184237.3191452-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

We have had no platforms that make use of this since 2015, so drop it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig    |   7 -
 cmd/Makefile   |   1 -
 cmd/universe.c | 361 -------------------------------------------------
 3 files changed, 369 deletions(-)
 delete mode 100644 cmd/universe.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4eb0140c10a1..135e03461708 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1700,13 +1700,6 @@ config CMD_UFS
 	  "This provides commands to initialise and configure universal flash
 	   subsystem devices"
 
-config CMD_UNIVERSE
-	bool "universe - Command to set up the Turndra Universe controller"
-	depends on DM_PCI_COMPAT
-	help
-	  This allows setting up the VMEbus provided by this controller.
-	  See the command help for full details.
-
 config CMD_USB
 	bool "usb"
 	depends on USB_HOST
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8c..691de88c2965 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -193,7 +193,6 @@ obj-$(CONFIG_CMD_CROS_EC) += cros_ec.o
 obj-$(CONFIG_CMD_TSI148) += tsi148.o
 obj-$(CONFIG_CMD_UBI) += ubi.o
 obj-$(CONFIG_CMD_UBIFS) += ubifs.o
-obj-$(CONFIG_CMD_UNIVERSE) += universe.o
 obj-$(CONFIG_CMD_UNLZ4) += unlz4.o
 obj-$(CONFIG_CMD_UNZIP) += unzip.o
 obj-$(CONFIG_CMD_UPL) += upl.o
diff --git a/cmd/universe.c b/cmd/universe.c
deleted file mode 100644
index 1445d5301f2e..000000000000
--- a/cmd/universe.c
+++ /dev/null
@@ -1,361 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2003 Stefan Roese, stefan.roese@esd-electronics.com
- */
-
-#include <command.h>
-#include <malloc.h>
-#include <vsprintf.h>
-#include <asm/io.h>
-#include <pci.h>
-
-#include <universe.h>
-
-#define PCI_VENDOR PCI_VENDOR_ID_TUNDRA
-#define PCI_DEVICE PCI_DEVICE_ID_TUNDRA_CA91C042
-
-typedef struct _UNI_DEV UNI_DEV;
-
-struct _UNI_DEV {
-	int            bus;
-	pci_dev_t      busdevfn;
-	UNIVERSE       *uregs;
-	unsigned int   pci_bs;
-};
-
-static UNI_DEV   *dev;
-
-int universe_init(void)
-{
-	int j, result;
-	pci_dev_t busdevfn;
-	unsigned int val;
-
-	busdevfn = pci_find_device(PCI_VENDOR, PCI_DEVICE, 0);
-	if (busdevfn == -1) {
-		puts("No Tundra Universe found!\n");
-		return -1;
-	}
-
-	/* Lets turn Latency off */
-	pci_write_config_dword(busdevfn, 0x0c, 0);
-
-	dev = malloc(sizeof(*dev));
-	if (NULL == dev) {
-		puts("UNIVERSE: No memory!\n");
-		result = -1;
-		goto break_20;
-	}
-
-	memset(dev, 0, sizeof(*dev));
-	dev->busdevfn = busdevfn;
-
-	pci_read_config_dword(busdevfn, PCI_BASE_ADDRESS_1, &val);
-	if (val & 1) {
-		pci_read_config_dword(busdevfn, PCI_BASE_ADDRESS_0, &val);
-	}
-	val &= ~0xf;
-	dev->uregs = (UNIVERSE *)val;
-
-	debug ("UNIVERSE-Base    : %p\n", dev->uregs);
-
-	/* check mapping  */
-	debug (" Read via mapping, PCI_ID = %08X\n", readl(&dev->uregs->pci_id));
-	if (((PCI_DEVICE <<16) | PCI_VENDOR) !=  readl(&dev->uregs->pci_id)) {
-		printf ("UNIVERSE: Cannot read PCI-ID via Mapping: %08x\n",
-			readl(&dev->uregs->pci_id));
-		result = -1;
-		goto break_30;
-	}
-
-	debug ("PCI_BS = %08X\n", readl(&dev->uregs->pci_bs));
-
-	dev->pci_bs = readl(&dev->uregs->pci_bs);
-
-	/* turn off windows */
-	for (j=0; j <4; j ++) {
-		writel(0x00800000, &dev->uregs->lsi[j].ctl);
-		writel(0x00800000, &dev->uregs->vsi[j].ctl);
-	}
-
-	/*
-	 * Write to Misc Register
-	 * Set VME Bus Time-out
-	 *   Arbitration Mode
-	 *   DTACK Enable
-	 */
-	writel(0x15040000 | (readl(&dev->uregs->misc_ctl) & 0x00020000), &dev->uregs->misc_ctl);
-
-	if (readl(&dev->uregs->misc_ctl) & 0x00020000) {
-		debug ("System Controller!\n"); /* test-only */
-	} else {
-		debug ("Not System Controller!\n"); /* test-only */
-	}
-
-	/*
-	 * Lets turn off interrupts
-	 */
-	writel(0x00000000,&dev->uregs->lint_en);   /* Disable interrupts in the Universe first */
-	writel(0x0000FFFF,&dev->uregs->lint_stat); /* Clear Any Pending Interrupts */
-	eieio();
-	writel(0x0000, &dev->uregs->lint_map0);  /* Map all ints to 0 */
-	writel(0x0000, &dev->uregs->lint_map1);  /* Map all ints to 0 */
-	eieio();
-
-	return 0;
-
- break_30:
-	free(dev);
- break_20:
-	return result;
-}
-
-/*
- * Create pci slave window (access: pci -> vme)
- */
-int universe_pci_slave_window(unsigned int pciAddr, unsigned int vmeAddr, int size, int vam, int pms, int vdw)
-{
-	int result, i;
-	unsigned int ctl = 0;
-
-	if (NULL == dev) {
-		result = -1;
-		goto exit_10;
-	}
-
-	for (i = 0; i < 4; i++) {
-		if (0x00800000 == readl(&dev->uregs->lsi[i].ctl))
-			break;
-	}
-
-	if (i == 4) {
-		printf ("universe: No Image available\n");
-		result = -1;
-		goto exit_10;
-	}
-
-	debug ("universe: Using image %d\n", i);
-
-	writel(pciAddr , &dev->uregs->lsi[i].bs);
-	writel((pciAddr + size), &dev->uregs->lsi[i].bd);
-	writel((vmeAddr - pciAddr), &dev->uregs->lsi[i].to);
-
-	switch (vam & VME_AM_Axx) {
-	case VME_AM_A16:
-		ctl = 0x00000000;
-		break;
-	case VME_AM_A24:
-		ctl = 0x00010000;
-		break;
-	case VME_AM_A32:
-		ctl = 0x00020000;
-		break;
-	}
-
-	switch (vam & VME_AM_Mxx) {
-	case VME_AM_DATA:
-		ctl |= 0x00000000;
-		break;
-	case VME_AM_PROG:
-		ctl |= 0x00008000;
-		break;
-	}
-
-	if (vam & VME_AM_SUP) {
-		ctl |= 0x00001000;
-
-	}
-
-	switch (vdw & VME_FLAG_Dxx) {
-	case VME_FLAG_D8:
-		ctl |= 0x00000000;
-		break;
-	case VME_FLAG_D16:
-		ctl |= 0x00400000;
-		break;
-	case VME_FLAG_D32:
-		ctl |= 0x00800000;
-		break;
-	}
-
-	switch (pms & PCI_MS_Mxx) {
-	case PCI_MS_MEM:
-		ctl |= 0x00000000;
-		break;
-	case PCI_MS_IO:
-		ctl |= 0x00000001;
-		break;
-	case PCI_MS_CONFIG:
-		ctl |= 0x00000002;
-		break;
-	}
-
-	ctl |= 0x80000000;    /* enable */
-
-	writel(ctl, &dev->uregs->lsi[i].ctl);
-
-	debug ("universe: window-addr=%p\n", &dev->uregs->lsi[i].ctl);
-	debug ("universe: pci slave window[%d] ctl=%08x\n", i, readl(&dev->uregs->lsi[i].ctl));
-	debug ("universe: pci slave window[%d] bs=%08x\n", i, readl(&dev->uregs->lsi[i].bs));
-	debug ("universe: pci slave window[%d] bd=%08x\n", i, readl(&dev->uregs->lsi[i].bd));
-	debug ("universe: pci slave window[%d] to=%08x\n", i, readl(&dev->uregs->lsi[i].to));
-
-	return 0;
-
- exit_10:
-	return -result;
-}
-
-/*
- * Create vme slave window (access: vme -> pci)
- */
-int universe_vme_slave_window(unsigned int vmeAddr, unsigned int pciAddr, int size, int vam, int pms)
-{
-	int result, i;
-	unsigned int ctl = 0;
-
-	if (NULL == dev) {
-		result = -1;
-		goto exit_10;
-	}
-
-	for (i = 0; i < 4; i++) {
-		if (0x00800000 == readl(&dev->uregs->vsi[i].ctl))
-			break;
-	}
-
-	if (i == 4) {
-		printf ("universe: No Image available\n");
-		result = -1;
-		goto exit_10;
-	}
-
-	debug ("universe: Using image %d\n", i);
-
-	writel(vmeAddr , &dev->uregs->vsi[i].bs);
-	writel((vmeAddr + size), &dev->uregs->vsi[i].bd);
-	writel((pciAddr - vmeAddr), &dev->uregs->vsi[i].to);
-
-	switch (vam & VME_AM_Axx) {
-	case VME_AM_A16:
-		ctl = 0x00000000;
-		break;
-	case VME_AM_A24:
-		ctl = 0x00010000;
-		break;
-	case VME_AM_A32:
-		ctl = 0x00020000;
-		break;
-	}
-
-	switch (vam & VME_AM_Mxx) {
-	case VME_AM_DATA:
-		ctl |= 0x00000000;
-		break;
-	case VME_AM_PROG:
-		ctl |= 0x00800000;
-		break;
-	}
-
-	if (vam & VME_AM_SUP) {
-		ctl |= 0x00100000;
-
-	}
-
-	switch (pms & PCI_MS_Mxx) {
-	case PCI_MS_MEM:
-		ctl |= 0x00000000;
-		break;
-	case PCI_MS_IO:
-		ctl |= 0x00000001;
-		break;
-	case PCI_MS_CONFIG:
-		ctl |= 0x00000002;
-		break;
-	}
-
-	ctl |= 0x80f00000;    /* enable */
-
-	writel(ctl, &dev->uregs->vsi[i].ctl);
-
-	debug ("universe: window-addr=%p\n", &dev->uregs->vsi[i].ctl);
-	debug ("universe: vme slave window[%d] ctl=%08x\n", i, readl(&dev->uregs->vsi[i].ctl));
-	debug ("universe: vme slave window[%d] bs=%08x\n", i, readl(&dev->uregs->vsi[i].bs));
-	debug ("universe: vme slave window[%d] bd=%08x\n", i, readl(&dev->uregs->vsi[i].bd));
-	debug ("universe: vme slave window[%d] to=%08x\n", i, readl(&dev->uregs->vsi[i].to));
-
-	return 0;
-
- exit_10:
-	return -result;
-}
-
-/*
- * Tundra Universe configuration
- */
-int do_universe(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	ulong addr1 = 0, addr2 = 0, size = 0, vam = 0, pms = 0, vdw = 0;
-	char cmd = 'x';
-
-	/* get parameter */
-	if (argc > 1)
-		cmd = argv[1][0];
-	if (argc > 2)
-		addr1 = hextoul(argv[2], NULL);
-	if (argc > 3)
-		addr2 = hextoul(argv[3], NULL);
-	if (argc > 4)
-		size = hextoul(argv[4], NULL);
-	if (argc > 5)
-		vam = hextoul(argv[5], NULL);
-	if (argc > 6)
-		pms = hextoul(argv[6], NULL);
-	if (argc > 7)
-		vdw = hextoul(argv[7], NULL);
-
-	switch (cmd) {
-	case 'i':		/* init */
-		universe_init();
-		break;
-	case 'v':		/* vme */
-		printf("Configuring Universe VME Slave Window (VME->PCI):\n");
-		printf("  vme=%08lx pci=%08lx size=%08lx vam=%02lx pms=%02lx\n",
-		       addr1, addr2, size, vam, pms);
-		universe_vme_slave_window(addr1, addr2, size, vam, pms);
-		break;
-	case 'p':		/* pci */
-		printf("Configuring Universe PCI Slave Window (PCI->VME):\n");
-		printf("  pci=%08lx vme=%08lx size=%08lx vam=%02lx pms=%02lx vdw=%02lx\n",
-		       addr1, addr2, size, vam, pms, vdw);
-		universe_pci_slave_window(addr1, addr2, size, vam, pms, vdw);
-		break;
-	default:
-		printf("Universe command %s not supported!\n", argv[1]);
-	}
-
-	return 0;
-}
-
-U_BOOT_CMD(
-	universe,	8,	1,	do_universe,
-	"initialize and configure Turndra Universe",
-	"init\n"
-	"    - initialize universe\n"
-	"universe vme [vme_addr] [pci_addr] [size] [vam] [pms]\n"
-	"    - create vme slave window (access: vme->pci)\n"
-	"universe pci [pci_addr] [vme_addr] [size] [vam] [pms] [vdw]\n"
-	"    - create pci slave window (access: pci->vme)\n"
-	"    [vam] = VMEbus Address-Modifier:  01 -> A16 Address Space\n"
-	"                                      02 -> A24 Address Space\n"
-	"                                      03 -> A32 Address Space\n"
-	"                                      04 -> Supervisor AM Code\n"
-	"                                      10 -> Data AM Code\n"
-	"                                      20 -> Program AM Code\n"
-	"    [pms] = PCI Memory Space:         01 -> Memory Space\n"
-	"                                      02 -> I/O Space\n"
-	"                                      03 -> Configuration Space\n"
-	"    [vdw] = VMEbus Maximum Datawidth: 01 -> D8 Data Width\n"
-	"                                      02 -> D16 Data Width\n"
-	"                                      03 -> D32 Data Width"
-);
-- 
2.43.0

