Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAF2C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A7A82CFA;
	Tue,  1 Jul 2025 20:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t09TKjUU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C5D82F4E; Tue,  1 Jul 2025 20:42:40 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C291A8003E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4080548891fso2108029b6e.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395356; x=1752000156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTtVvXcA/v3US1PUIfkfnCk7GHC99au8RIG7WhF3hLU=;
 b=t09TKjUUtt8fjdgqdchUS08VuyzemZemMpp4JoSQvgkj8urf3ZhmrS5r4yfdB4N6pj
 gjJAVRCBCS8VAFRPq9WYWgpW7aIEJ3hYRBONCZWHqiVC4Pde/51FhLSxPgzsJVpHT7Ed
 AipM/8R8uFCiCPueXoW3fxUpygwqyY7u8Ji5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395356; x=1752000156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTtVvXcA/v3US1PUIfkfnCk7GHC99au8RIG7WhF3hLU=;
 b=ZTWx8QXDvUgMtBt+V8JGS3Is2GlJAoWxz6Q/ziv+JTG1/hl1RmG4kOMhLXa7RMQxP0
 3nbnVRXGsEvZGDvXco/xndLFFApb/vF4yTdtEn5WIaobtAjmu3VL0LU6gcw3PhUoR5qB
 ekNW1C0ybGSiLGeZK0mieYwt9iqhLOwkCYAYBx3aZH4FUBd6PY75JJ/EOobK5VrU7aNH
 Touzu4qYe1ZW4KDxR9uK4Tnzz5SanNqK4aw6Pap/uAavDt8Sixm8ZYpKllIGpV4MP8jA
 2hIjf7/mmFRUQcJ0a2JzSpivo7XCi4Ee0X/B0h0Q12ITuXy6RTUcgUPo8flGH9LGDisu
 lgyg==
X-Gm-Message-State: AOJu0YxUv+Bfh3RqYCkEYBebwLMrATn4cJJCMcn5fv9W/FNn5uFWeBAY
 mSzpbZGkN2pw2T3I90KD+Y7fMmiwUioLZugppVH1epNeHO0aymdN69yImBUUiAMvasrxVgcBshe
 i++esc4Y=
X-Gm-Gg: ASbGncsBBqtt8dWw25fUMsBFOQs6T2fF/plU+7Eew3y4U1b5e47zzdc2pdlGpVZFRvk
 YN0rzae6+LSBt8ttxPtu3epm8RCoUvYHaTtDNc5RvR+M9Z3VV1gme6DVjVFBNKaod0PfHHw9TRA
 WpglfVVtjHuJPdCUyaIcyjxfihKm1xpwJX+KebdQybzdrQucJOKSQa+i5tt7dgRQwL+Wi4b2rTG
 itkhKMF06pTt80z4ZQj+JDs5eMLhgSG9bStxXBz7oH59gyN/SWC2I1GbrXpP2saG4+NUsCu2Agr
 LBCXc22eFOuEBk5nLdc+BP3xq+alkvnay5nB+NhznZZJchqj2tRXzidAfBFbUEo+InHGyYasfyf
 YIPbea5a8JxZvwwXY8KoNJCHq6w==
X-Google-Smtp-Source: AGHT+IG/kccsBT/H65ciN/esIbCQIixA/mlZnrmd7Nn2CgIxjp8yKUDPRpigMRBIVtE3+dWYDKLOAw==
X-Received: by 2002:a05:6808:2202:b0:406:7054:f7b5 with SMTP id
 5614622812f47-40b33e4ce15mr12830539b6e.36.1751395356245; 
 Tue, 01 Jul 2025 11:42:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243deeesm2223266b6e.48.2025.07.01.11.42.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:42:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd: Remove "tsi148" command
Date: Tue,  1 Jul 2025 12:42:34 -0600
Message-ID: <20250701184234.3191423-1-trini@konsulko.com>
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

We have had no platforms that make use of this since 2021, so drop it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig      |   7 -
 cmd/Makefile     |   1 -
 cmd/tsi148.c     | 472 -----------------------------------------------
 include/tsi148.h | 201 --------------------
 4 files changed, 681 deletions(-)
 delete mode 100644 cmd/tsi148.c
 delete mode 100644 include/tsi148.h

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 135e03461708..19f47c893439 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1686,13 +1686,6 @@ config CMD_TEMPERATURE
 	help
 	  Provides a way to list thermal sensors and to get their readings.
 
-config CMD_TSI148
-	bool "tsi148 - Command to access tsi148 device"
-	depends on DM_PCI_COMPAT
-	help
-	  This provides various sub-commands to initialise and configure the
-	  Turndra tsi148 device. See the command help for full details.
-
 config CMD_UFS
 	bool "ufs - Universal Flash Storage commands"
 	depends on UFS
diff --git a/cmd/Makefile b/cmd/Makefile
index 691de88c2965..5062eb8def49 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -190,7 +190,6 @@ obj-$(CONFIG_CMD_TPM_V1) += tpm-v1.o
 obj-$(CONFIG_CMD_TPM_TEST) += tpm_test.o
 obj-$(CONFIG_CMD_TPM_V2) += tpm-v2.o
 obj-$(CONFIG_CMD_CROS_EC) += cros_ec.o
-obj-$(CONFIG_CMD_TSI148) += tsi148.o
 obj-$(CONFIG_CMD_UBI) += ubi.o
 obj-$(CONFIG_CMD_UBIFS) += ubifs.o
 obj-$(CONFIG_CMD_UNLZ4) += unlz4.o
diff --git a/cmd/tsi148.c b/cmd/tsi148.c
deleted file mode 100644
index 113b4e673304..000000000000
--- a/cmd/tsi148.c
+++ /dev/null
@@ -1,472 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2009 Reinhard Arlt, reinhard.arlt@esd-electronics.com
- *
- * base on universe.h by
- *
- * (C) Copyright 2003 Stefan Roese, stefan.roese@esd-electronics.com
- */
-
-#include <command.h>
-#include <log.h>
-#include <malloc.h>
-#include <vsprintf.h>
-#include <asm/io.h>
-#include <pci.h>
-
-#include <tsi148.h>
-
-#define LPCI_VENDOR PCI_VENDOR_ID_TUNDRA
-#define LPCI_DEVICE PCI_DEVICE_ID_TUNDRA_TSI148
-
-typedef struct _TSI148_DEV TSI148_DEV;
-
-struct _TSI148_DEV {
-	int           bus;
-	pci_dev_t     busdevfn;
-	TSI148       *uregs;
-	unsigned int  pci_bs;
-};
-
-static TSI148_DEV *dev;
-
-/*
- * Most of the TSI148 register are BIGENDIAN
- * This is the reason for the __raw_writel(htonl(x), x) usage!
- */
-
-int tsi148_init(void)
-{
-	int j, result;
-	pci_dev_t busdevfn;
-	unsigned int val;
-
-	busdevfn = pci_find_device(LPCI_VENDOR, LPCI_DEVICE, 0);
-	if (busdevfn == -1) {
-		puts("Tsi148: No Tundra Tsi148 found!\n");
-		return -1;
-	}
-
-	/* Lets turn Latency off */
-	pci_write_config_dword(busdevfn, 0x0c, 0);
-
-	dev = malloc(sizeof(*dev));
-	if (NULL == dev) {
-		puts("Tsi148: No memory!\n");
-		return -1;
-	}
-
-	memset(dev, 0, sizeof(*dev));
-	dev->busdevfn = busdevfn;
-
-	pci_read_config_dword(busdevfn, PCI_BASE_ADDRESS_0, &val);
-	val &= ~0xf;
-	dev->uregs = (TSI148 *)val;
-
-	debug("Tsi148: Base    : %p\n", dev->uregs);
-
-	/* check mapping */
-	debug("Tsi148: Read via mapping, PCI_ID = %08X\n",
-	      readl(&dev->uregs->pci_id));
-	if (((LPCI_DEVICE << 16) | LPCI_VENDOR) != readl(&dev->uregs->pci_id)) {
-		printf("Tsi148: Cannot read PCI-ID via Mapping: %08x\n",
-		       readl(&dev->uregs->pci_id));
-		result = -1;
-		goto break_30;
-	}
-
-	debug("Tsi148: PCI_BS = %08X\n", readl(&dev->uregs->pci_mbarl));
-
-	dev->pci_bs = readl(&dev->uregs->pci_mbarl);
-
-	/* turn off windows */
-	for (j = 0; j < 8; j++) {
-		__raw_writel(htonl(0x00000000), &dev->uregs->outbound[j].otat);
-		__raw_writel(htonl(0x00000000), &dev->uregs->inbound[j].itat);
-	}
-
-	/* Tsi148 VME timeout etc */
-	__raw_writel(htonl(0x00000084), &dev->uregs->vctrl);
-
-#ifdef DEBUG
-	if ((__raw_readl(&dev->uregs->vstat) & 0x00000100) != 0)
-		printf("Tsi148: System Controller!\n");
-	else
-		printf("Tsi148: Not System Controller!\n");
-#endif
-
-	/*
-	 * Lets turn off interrupts
-	 */
-	/* Disable interrupts in Tsi148 first */
-	__raw_writel(htonl(0x00000000), &dev->uregs->inten);
-	/* Disable interrupt out */
-	__raw_writel(htonl(0x00000000), &dev->uregs->inteo);
-	eieio();
-	/* Reset all IRQ's */
-	__raw_writel(htonl(0x03ff3f00), &dev->uregs->intc);
-	/* Map all ints to 0 */
-	__raw_writel(htonl(0x00000000), &dev->uregs->intm1);
-	__raw_writel(htonl(0x00000000), &dev->uregs->intm2);
-	eieio();
-
-	val = __raw_readl(&dev->uregs->vstat);
-	val &= ~(0x00004000);
-	__raw_writel(val, &dev->uregs->vstat);
-	eieio();
-
-	debug("Tsi148: register struct size %08x\n", sizeof(TSI148));
-
-	return 0;
-
- break_30:
-	free(dev);
-	dev = NULL;
-
-	return result;
-}
-
-/*
- * Create pci slave window (access: pci -> vme)
- */
-int tsi148_pci_slave_window(unsigned int pciAddr, unsigned int vmeAddr,
-			    int size, int vam, int vdw)
-{
-	int result, i;
-	unsigned int ctl = 0;
-
-	if (NULL == dev) {
-		result = -1;
-		goto exit_10;
-	}
-
-	for (i = 0; i < 8; i++) {
-		if (0x00000000 == readl(&dev->uregs->outbound[i].otat))
-			break;
-	}
-
-	if (i > 7) {
-		printf("Tsi148: No Image available\n");
-		result = -1;
-		goto exit_10;
-	}
-
-	debug("Tsi148: Using image %d\n", i);
-
-	printf("Tsi148: Pci addr %08x\n", pciAddr);
-
-	__raw_writel(htonl(pciAddr), &dev->uregs->outbound[i].otsal);
-	__raw_writel(0x00000000, &dev->uregs->outbound[i].otsau);
-	__raw_writel(htonl(pciAddr + size), &dev->uregs->outbound[i].oteal);
-	__raw_writel(0x00000000, &dev->uregs->outbound[i].oteau);
-	__raw_writel(htonl(vmeAddr - pciAddr), &dev->uregs->outbound[i].otofl);
-	__raw_writel(0x00000000, &dev->uregs->outbound[i].otofu);
-
-	switch (vam & VME_AM_Axx) {
-	case VME_AM_A16:
-		ctl = 0x00000000;
-		break;
-	case VME_AM_A24:
-		ctl = 0x00000001;
-		break;
-	case VME_AM_A32:
-		ctl = 0x00000002;
-		break;
-	}
-
-	switch (vam & VME_AM_Mxx) {
-	case VME_AM_DATA:
-		ctl |= 0x00000000;
-		break;
-	case VME_AM_PROG:
-		ctl |= 0x00000010;
-		break;
-	}
-
-	if (vam & VME_AM_SUP)
-		ctl |= 0x00000020;
-
-	switch (vdw & VME_FLAG_Dxx) {
-	case VME_FLAG_D16:
-		ctl |= 0x00000000;
-		break;
-	case VME_FLAG_D32:
-		ctl |= 0x00000040;
-		break;
-	}
-
-	ctl |= 0x80040000;	/* enable, no prefetch */
-
-	__raw_writel(htonl(ctl), &dev->uregs->outbound[i].otat);
-
-	debug("Tsi148: window-addr                =%p\n",
-	      &dev->uregs->outbound[i].otsau);
-	debug("Tsi148: pci slave window[%d] attr  =%08x\n",
-	      i, ntohl(__raw_readl(&dev->uregs->outbound[i].otat)));
-	debug("Tsi148: pci slave window[%d] start =%08x\n",
-	      i, ntohl(__raw_readl(&dev->uregs->outbound[i].otsal)));
-	debug("Tsi148: pci slave window[%d] end   =%08x\n",
-	      i, ntohl(__raw_readl(&dev->uregs->outbound[i].oteal)));
-	debug("Tsi148: pci slave window[%d] offset=%08x\n",
-	      i, ntohl(__raw_readl(&dev->uregs->outbound[i].otofl)));
-
-	return 0;
-
- exit_10:
-	return -result;
-}
-
-unsigned int tsi148_eval_vam(int vam)
-{
-	unsigned int ctl = 0;
-
-	switch (vam & VME_AM_Axx) {
-	case VME_AM_A16:
-		ctl = 0x00000000;
-		break;
-	case VME_AM_A24:
-		ctl = 0x00000010;
-		break;
-	case VME_AM_A32:
-		ctl = 0x00000020;
-		break;
-	}
-	switch (vam & VME_AM_Mxx) {
-	case VME_AM_DATA:
-		ctl |= 0x00000001;
-		break;
-	case VME_AM_PROG:
-		ctl |= 0x00000002;
-		break;
-	case (VME_AM_PROG | VME_AM_DATA):
-		ctl |= 0x00000003;
-		break;
-	}
-
-	if (vam & VME_AM_SUP)
-		ctl |= 0x00000008;
-	if (vam & VME_AM_USR)
-		ctl |= 0x00000004;
-
-	return ctl;
-}
-
-/*
- * Create vme slave window (access: vme -> pci)
- */
-int tsi148_vme_slave_window(unsigned int vmeAddr, unsigned int pciAddr,
-			    int size, int vam)
-{
-	int result, i;
-	unsigned int ctl = 0;
-
-	if (NULL == dev) {
-		result = -1;
-		goto exit_10;
-	}
-
-	for (i = 0; i < 8; i++) {
-		if (0x00000000 == readl(&dev->uregs->inbound[i].itat))
-			break;
-	}
-
-	if (i > 7) {
-		printf("Tsi148: No Image available\n");
-		result = -1;
-		goto exit_10;
-	}
-
-	debug("Tsi148: Using image %d\n", i);
-
-	__raw_writel(htonl(vmeAddr), &dev->uregs->inbound[i].itsal);
-	__raw_writel(0x00000000, &dev->uregs->inbound[i].itsau);
-	__raw_writel(htonl(vmeAddr + size), &dev->uregs->inbound[i].iteal);
-	__raw_writel(0x00000000, &dev->uregs->inbound[i].iteau);
-	__raw_writel(htonl(pciAddr - vmeAddr), &dev->uregs->inbound[i].itofl);
-	if (vmeAddr > pciAddr)
-		__raw_writel(0xffffffff, &dev->uregs->inbound[i].itofu);
-	else
-		__raw_writel(0x00000000, &dev->uregs->inbound[i].itofu);
-
-	ctl = tsi148_eval_vam(vam);
-	ctl |= 0x80000000;	/* enable */
-	__raw_writel(htonl(ctl), &dev->uregs->inbound[i].itat);
-
-	debug("Tsi148: window-addr                =%p\n",
-	      &dev->uregs->inbound[i].itsau);
-	debug("Tsi148: vme slave window[%d] attr  =%08x\n",
-	      i, ntohl(__raw_readl(&dev->uregs->inbound[i].itat)));
-	debug("Tsi148: vme slave window[%d] start =%08x\n",
-	      i, ntohl(__raw_readl(&dev->uregs->inbound[i].itsal)));
-	debug("Tsi148: vme slave window[%d] end   =%08x\n",
-	      i, ntohl(__raw_readl(&dev->uregs->inbound[i].iteal)));
-	debug("Tsi148: vme slave window[%d] offset=%08x\n",
-	      i, ntohl(__raw_readl(&dev->uregs->inbound[i].itofl)));
-
-	return 0;
-
- exit_10:
-	return -result;
-}
-
-/*
- * Create vme slave window (access: vme -> gcsr)
- */
-int tsi148_vme_gcsr_window(unsigned int vmeAddr, int vam)
-{
-	int result;
-	unsigned int ctl;
-
-	result = 0;
-
-	if (NULL == dev) {
-		result = 1;
-	} else {
-		__raw_writel(htonl(vmeAddr), &dev->uregs->gbal);
-		__raw_writel(0x00000000, &dev->uregs->gbau);
-
-		ctl = tsi148_eval_vam(vam);
-		ctl |= 0x00000080;	/* enable */
-		__raw_writel(htonl(ctl), &dev->uregs->gcsrat);
-	}
-
-	return result;
-}
-
-/*
- * Create vme slave window (access: vme -> crcsr)
- */
-int tsi148_vme_crcsr_window(unsigned int vmeAddr)
-{
-	int result;
-	unsigned int ctl;
-
-	result = 0;
-
-	if (NULL == dev) {
-		result = 1;
-	} else {
-		__raw_writel(htonl(vmeAddr), &dev->uregs->crol);
-		__raw_writel(0x00000000, &dev->uregs->crou);
-
-		ctl = 0x00000080;	/* enable */
-		__raw_writel(htonl(ctl), &dev->uregs->crat);
-	}
-
-	return result;
-}
-
-/*
- * Create vme slave window (access: vme -> crg)
- */
-int tsi148_vme_crg_window(unsigned int vmeAddr, int vam)
-{
-	int result;
-	unsigned int ctl;
-
-	result = 0;
-
-	if (NULL == dev) {
-		result = 1;
-	} else {
-		__raw_writel(htonl(vmeAddr), &dev->uregs->cbal);
-		__raw_writel(0x00000000, &dev->uregs->cbau);
-
-		ctl = tsi148_eval_vam(vam);
-		ctl |= 0x00000080;	/* enable */
-		__raw_writel(htonl(ctl), &dev->uregs->crgat);
-	}
-
-	return result;
-}
-
-/*
- * Tundra Tsi148 configuration
- */
-int do_tsi148(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	ulong addr1 = 0, addr2 = 0, size = 0, vam = 0, vdw = 0;
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
-		vdw = hextoul(argv[6], NULL);
-
-	switch (cmd) {
-	case 'c':
-		if (strcmp(argv[1], "crg") == 0) {
-			vam = addr2;
-			printf("Tsi148: Configuring VME CRG Window "
-			       "(VME->CRG):\n");
-			printf("  vme=%08lx vam=%02lx\n", addr1, vam);
-			tsi148_vme_crg_window(addr1, vam);
-		} else {
-			printf("Tsi148: Configuring VME CR/CSR Window "
-			       "(VME->CR/CSR):\n");
-			printf("  pci=%08lx\n", addr1);
-			tsi148_vme_crcsr_window(addr1);
-		}
-		break;
-	case 'i':		/* init */
-		tsi148_init();
-		break;
-	case 'g':
-		vam = addr2;
-		printf("Tsi148: Configuring VME GCSR Window (VME->GCSR):\n");
-		printf("  vme=%08lx vam=%02lx\n", addr1, vam);
-		tsi148_vme_gcsr_window(addr1, vam);
-		break;
-	case 'v':		/* vme */
-		printf("Tsi148: Configuring VME Slave Window (VME->PCI):\n");
-		printf("  vme=%08lx pci=%08lx size=%08lx vam=%02lx\n",
-		       addr1, addr2, size, vam);
-		tsi148_vme_slave_window(addr1, addr2, size, vam);
-		break;
-	case 'p':		/* pci */
-		printf("Tsi148: Configuring PCI Slave Window (PCI->VME):\n");
-		printf("  pci=%08lx vme=%08lx size=%08lx vam=%02lx vdw=%02lx\n",
-		       addr1, addr2, size, vam, vdw);
-		tsi148_pci_slave_window(addr1, addr2, size, vam, vdw);
-		break;
-	default:
-		printf("Tsi148: Command %s not supported!\n", argv[1]);
-	}
-
-	return 0;
-}
-
-U_BOOT_CMD(
-	tsi148,	7,	1,	do_tsi148,
-	"initialize and configure Turndra Tsi148\n",
-	"init\n"
-	"    - initialize tsi148\n"
-	"tsi148 vme   [vme_addr] [pci_addr] [size] [vam]\n"
-	"    - create vme slave window (access: vme->pci)\n"
-	"tsi148 pci   [pci_addr] [vme_addr] [size] [vam] [vdw]\n"
-	"    - create pci slave window (access: pci->vme)\n"
-	"tsi148 crg   [vme_addr] [vam]\n"
-	"    - create vme slave window: (access vme->CRG\n"
-	"tsi148 crcsr [pci_addr]\n"
-	"    - create vme slave window: (access vme->CR/CSR\n"
-	"tsi148 gcsr  [vme_addr] [vam]\n"
-	"    - create vme slave window: (access vme->GCSR\n"
-	"    [vam] = VMEbus Address-Modifier:  01 -> A16 Address Space\n"
-	"                                      02 -> A24 Address Space\n"
-	"                                      03 -> A32 Address Space\n"
-	"                                      04 -> Usr        AM Code\n"
-	"                                      08 -> Supervisor AM Code\n"
-	"                                      10 -> Data AM Code\n"
-	"                                      20 -> Program AM Code\n"
-	"    [vdw] = VMEbus Maximum Datawidth: 02 -> D16 Data Width\n"
-	"                                      03 -> D32 Data Width\n"
-);
diff --git a/include/tsi148.h b/include/tsi148.h
deleted file mode 100644
index a9f353b9080f..000000000000
--- a/include/tsi148.h
+++ /dev/null
@@ -1,201 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2009 Reinhard Arlt, reinhard.arlt@esd-electronics.com
- *
- * base on universe.h by
- *
- * (C) Copyright 2003 Stefan Roese, stefan.roese@esd-electronics.com
- */
-
-#ifndef _tsi148_h
-#define _tsi148_h
-
-#ifndef PCI_DEVICE_ID_TUNDRA_TSI148
-#define PCI_DEVICE_ID_TUNDRA_TSI148 0x0148
-#endif
-
-typedef struct _TSI148 TSI148;
-typedef struct _OUTBOUND OUTBOUND;
-typedef struct _INBOUND  INBOUND;
-typedef struct _TDMA_CMD_PACKET TDMA_CMD_PACKET;
-
-struct _OUTBOUND {
-	unsigned int otsau;                   /* 0x000 Outbound start       upper */
-	unsigned int otsal;                   /* 0x004 Outbouud start       lower */
-	unsigned int oteau;                   /* 0x008 Outbound end         upper */
-	unsigned int oteal;                   /* 0x00c Outbound end         lower */
-	unsigned int otofu;                   /* 0x010 Outbound translation upper */
-	unsigned int otofl;                   /* 0x014 Outbound translation lower */
-	unsigned int otbs;                    /* 0x018 Outbound translation 2eSST */
-	unsigned int otat;                    /* 0x01c Outbound translation attr  */
-};
-
-struct _INBOUND {
-	unsigned int itsau;                   /* 0x000 inbound  start       upper */
-	unsigned int itsal;                   /* 0x004 inbouud  start       lower */
-	unsigned int iteau;                   /* 0x008 inbound  end         upper */
-	unsigned int iteal;                   /* 0x00c inbound  end         lower */
-	unsigned int itofu;                   /* 0x010 inbound  translation upper */
-	unsigned int itofl;                   /* 0x014 inbound  translation lower */
-	unsigned int itat;                    /* 0x018 inbound  translation attr  */
-	unsigned int spare;                   /* 0x01c not used                   */
-};
-
-struct _TSI148 {
-	unsigned int pci_id;                  /* 0x000         */
-	unsigned int pci_csr;                 /* 0x004         */
-	unsigned int pci_class;               /* 0x008         */
-	unsigned int pci_misc0;               /* 0x00c         */
-	unsigned int pci_mbarl;               /* 0x010         */
-	unsigned int pci_mbarh;               /* 0x014         */
-	unsigned int spare0[(0x03c-0x018)/4]; /* 0x018         */
-	unsigned int pci_misc1;               /* 0x03c         */
-	unsigned int pci_pcixcap;             /* 0x040         */
-	unsigned int pci_pcixstat;            /* 0x044         */
-	unsigned int spare1[(0x100-0x048)/4]; /* 0x048         */
-	OUTBOUND     outbound[8];             /* 0x100         */
-	unsigned int viack[8];                /* 0x204         */
-	unsigned int rmwau;                   /* 0x220         */
-	unsigned int rmwal;                   /* 0x224         */
-	unsigned int rmwen;                   /* 0x228         */
-	unsigned int rmwc;                    /* 0x22c         */
-	unsigned int rmws;                    /* 0x230         */
-	unsigned int vmctrl;                  /* 0x234         */
-	unsigned int vctrl;                   /* 0x238         */
-	unsigned int vstat;                   /* 0x23c         */
-	unsigned int pcsr;                    /* 0x240         */
-	unsigned int spare2[3];               /* 0x244 - 0x24c */
-	unsigned int vmefl;                   /* 0x250         */
-	unsigned int spare3[3];               /* 0x254 - 0x25c */
-	unsigned int veau;                    /* 0x260         */
-	unsigned int veal;                    /* 0x264         */
-	unsigned int veat;                    /* 0x268         */
-	unsigned int spare4[1];               /* 0x26c         */
-	unsigned int edpau;                   /* 0x270         */
-	unsigned int edpal;                   /* 0x274         */
-	unsigned int edpxa;                   /* 0x278         */
-	unsigned int edpxs;                   /* 0x27c         */
-	unsigned int edpat;                   /* 0x280         */
-	unsigned int spare5[31];              /* 0x284 - 0x2fc */
-	INBOUND      inbound[8];              /* 0x100         */
-	unsigned int gbau;                    /* 0x400         */
-	unsigned int gbal;                    /* 0x404         */
-	unsigned int gcsrat;                  /* 0x408         */
-	unsigned int cbau;                    /* 0x40c         */
-	unsigned int cbal;                    /* 0x410         */
-	unsigned int crgat;                   /* 0x414         */
-	unsigned int crou;                    /* 0x418         */
-	unsigned int crol;                    /* 0x41c         */
-	unsigned int crat;                    /* 0x420         */
-	unsigned int lmbau;                   /* 0x424         */
-	unsigned int lmbal;                   /* 0x428         */
-	unsigned int lmat;                    /* 0x42c         */
-	unsigned int r64bcu;                  /* 0x430         */
-	unsigned int r64bcl;                  /* 0x434         */
-	unsigned int bpgtr;                   /* 0x438         */
-	unsigned int bpctr;                   /* 0x43c         */
-	unsigned int vicr;                    /* 0x440         */
-	unsigned int spare6[1];               /* 0x444         */
-	unsigned int inten;                   /* 0x448         */
-	unsigned int inteo;                   /* 0x44c         */
-	unsigned int ints;                    /* 0x450         */
-	unsigned int intc;                    /* 0x454         */
-	unsigned int intm1;                   /* 0x458         */
-	unsigned int intm2;                   /* 0x45c         */
-	unsigned int spare7[40];              /* 0x460 - 0x4fc */
-	unsigned int dctl0;                   /* 0x500         */
-	unsigned int dsta0;                   /* 0x504         */
-	unsigned int dcsau0;                  /* 0x508         */
-	unsigned int dcsal0;                  /* 0x50c         */
-	unsigned int dcdau0;                  /* 0x510         */
-	unsigned int dcdal0;                  /* 0x514         */
-	unsigned int dclau0;                  /* 0x518         */
-	unsigned int dclal0;                  /* 0x51c         */
-	unsigned int dsau0;                   /* 0x520         */
-	unsigned int dsal0;                   /* 0x524         */
-	unsigned int ddau0;                   /* 0x528         */
-	unsigned int ddal0;                   /* 0x52c         */
-	unsigned int dsat0;                   /* 0x530         */
-	unsigned int ddat0;                   /* 0x534         */
-	unsigned int dnlau0;                  /* 0x538         */
-	unsigned int dnlal0;                  /* 0x53c         */
-	unsigned int dcnt0;                   /* 0x540         */
-	unsigned int ddbs0;                   /* 0x544         */
-	unsigned int r20[14];                 /* 0x548 - 0x57c */
-	unsigned int dctl1;                   /* 0x580         */
-	unsigned int dsta1;                   /* 0x584         */
-	unsigned int dcsau1;                  /* 0x588         */
-	unsigned int dcsal1;                  /* 0x58c         */
-	unsigned int dcdau1;                  /* 0x590         */
-	unsigned int dcdal1;                  /* 0x594         */
-	unsigned int dclau1;                  /* 0x598         */
-	unsigned int dclal1;                  /* 0x59c         */
-	unsigned int dsau1;                   /* 0x5a0         */
-	unsigned int dsal1;                   /* 0x5a4         */
-	unsigned int ddau1;                   /* 0x5a8         */
-	unsigned int ddal1;                   /* 0x5ac         */
-	unsigned int dsat1;                   /* 0x5b0         */
-	unsigned int ddat1;                   /* 0x5b4         */
-	unsigned int dnlau1;                  /* 0x5b8         */
-	unsigned int dnlal1;                  /* 0x5bc         */
-	unsigned int dcnt1;                   /* 0x5c0         */
-	unsigned int ddbs1;                   /* 0x5c4         */
-	unsigned int r21[14];                 /* 0x5c8 - 0x5fc */
-	unsigned int devi_veni_2;             /* 0x600         */
-	unsigned int gctrl_ga_revid;          /* 0x604         */
-	unsigned int semaphore0_1_2_3;        /* 0x608         */
-	unsigned int semaphore4_5_6_7;        /* 0x60c         */
-	unsigned int mbox0;                   /* 0x610         */
-	unsigned int mbox1;                   /* 0x614         */
-	unsigned int mbox2;                   /* 0x618         */
-	unsigned int mbox3;                   /* 0x61c         */
-	unsigned int r22[629];                /* 0x620 - 0xff0 */
-	unsigned int csrbcr;                  /* 0xff4         */
-	unsigned int csrbsr;                  /* 0xff8         */
-	unsigned int cbar;                    /* 0xffc         */
-};
-
-#define IRQ_VOWN	0x0001
-#define IRQ_VIRQ1	0x0002
-#define IRQ_VIRQ2	0x0004
-#define IRQ_VIRQ3	0x0008
-#define IRQ_VIRQ4	0x0010
-#define IRQ_VIRQ5	0x0020
-#define IRQ_VIRQ6	0x0040
-#define IRQ_VIRQ7	0x0080
-#define IRQ_DMA		0x0100
-#define IRQ_LERR	0x0200
-#define IRQ_VERR	0x0400
-#define IRQ_res		0x0800
-#define IRQ_IACK	0x1000
-#define IRQ_SWINT	0x2000
-#define IRQ_SYSFAIL	0x4000
-#define IRQ_ACFAIL	0x8000
-
-struct _TDMA_CMD_PACKET {
-	unsigned int dctl;   /* DMA Control         */
-	unsigned int dtbc;   /* Transfer Byte Count */
-	unsigned int dlv;    /* PCI Address         */
-	unsigned int res1;   /* Reserved            */
-	unsigned int dva;    /* Vme Address         */
-	unsigned int res2;   /* Reserved            */
-	unsigned int dcpp;   /* Pointer to Numed Cmd Packet with rPN */
-	unsigned int res3;   /* Reserved                             */
-};
-
-#define VME_AM_A16		0x01
-#define VME_AM_A24		0x02
-#define VME_AM_A32		0x03
-#define VME_AM_Axx		0x03
-#define VME_AM_USR		0x04
-#define VME_AM_SUP		0x08
-#define VME_AM_DATA		0x10
-#define VME_AM_PROG		0x20
-#define VME_AM_Mxx		(VME_AM_DATA | VME_AM_PROG)
-
-#define VME_FLAG_D8		0x01
-#define VME_FLAG_D16		0x02
-#define VME_FLAG_D32		0x03
-#define VME_FLAG_Dxx		0x03
-
-#endif
-- 
2.43.0

