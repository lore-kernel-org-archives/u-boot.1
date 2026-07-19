Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA0CC44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D683884A95;
	Sun, 19 Jul 2026 20:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ZCUU9zci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3030484A29; Sun, 19 Jul 2026 20:04:19 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1EF84A29
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=asrinivasan@tenstorrent.com
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66771ded50aso12527915d50.1
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784484256; x=1785089056; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q1863o5MRbOiFPb3YeEbDfuT0d0yXTYOl0w68kFZKY8=;
 b=ZCUU9zcigWyzK/3pePaX496j+pGfN1qGipOua+gFVCNYXk0HbJ0t9fMU1//0WcIkvW
 /M9d0eI41UTgSe6vkUEfqhBpM1dJ537Y7LVya/oSpGnRjtl3lq8WZZKK/TM1sA6WNo68
 3At3YetoO9OnMMHYHBFzwhd/cTB8ySl8P40PeO1g4LH3JeOfNRMmNmLiJs3w0qIaJrVH
 qTDwvUSoC3tp/zui2+dEu8TQ8vpcWSWzAeSzuf8TpwqsMqDEvvQ0bAoDOrzO3qp9NC4G
 97pop1pxCBMGJbNF6udWikWC1HNGb8VmH8urep7D9GxGApM4UnR4NfCtFzGp9HUZ7hcA
 ZwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484256; x=1785089056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q1863o5MRbOiFPb3YeEbDfuT0d0yXTYOl0w68kFZKY8=;
 b=dC9NVXgdMKnSAB731Yhs4aakS8+3Nxds/FoQpXsxSjWbpBMGkKE6XYZwwk89rGsdPh
 Avx27b7uedgiwAeB79IQcsipCcYMQJnsUdsuxg6HEsVxLCLg7d5XPK45dA31i0wHYM2+
 IhgYrGDjH+Ji7DlKZ+G4S4qSKb6IsQ5xL/qyJebV+Fxo80tY4Rq1wdng276UnboT6LVn
 X6MdXj3q45YrXUE13ykEAV7UYRugwIJyqFi+G9AmcnEHyya1F3pL+D2Hnc9Z2tS67dEy
 t9rXki9jvo+XmQcahBGGAc9cw3RTH9utsAY2RqTIWHXArjsXo2iJPSzoyaYnFHoA/wcj
 dyZQ==
X-Gm-Message-State: AOJu0YyEh0CyIsXtcTY1M2ve9sOfxiqTee0fuGQ3Z81Gl79oS1r7kSZL
 PUQyZHw2EUSnnCXpCu2luY5aZioQSfQ0iAB5yqO3Z3jRwj2dpeHDpN2AnvRGHqKVARM=
X-Gm-Gg: AfdE7clOsUnAaCA0sy6LUqb2bwS7jMwhbIgk4WdJBRDS0KpjuhWq/Aj3ToPMTPGhtFF
 A8Rt/DRG0I3UWP7zKJmQ9SjqxG6Vu5Pb9a5lUr9QJj0gGzuzgYlc61nvr3+heaKYE5I15+e5XQO
 9CZWkyssg1Lmz+NAld2JjnzubUx4hcGJ3J5At8MUFMkbGnVCE//6gliBTTVheBp2IfgwtpNLJGw
 fRI3BPObax94ktiUP3gXRi0EBJw3+L9+DQKmq4ooAsIFJJb1thcxE4eyOEv/jPYNt1EqPNX2Fpn
 FimAP6UHLOdkiRfVUyIjxYXSI0cucSE3f+R7pCuDzxClO9gFp5dTa/CI2QvxFR/VlD9amuZmoBE
 lVKKiPJhXjNvxFr8eQcIesMtIwNyD1Y6ZsE06vFWI22I+Rqf1nYyEcYJngrPHh21WEgO2QzMqQr
 8MujxihpEH0mlns9w/V621NYp1IU7dUOavB1ZZMDBL+nb+eYD93cVe73rsaErTjxvx
X-Received: by 2002:a53:e44c:0:b0:664:bd5c:6e72 with SMTP id
 956f58d0204a3-6683bb06c5fmr2479884d50.34.1784484255675; 
 Sun, 19 Jul 2026 11:04:15 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:423:c42:416:fc31])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6683b513a3esm4879882d50.2.2026.07.19.11.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:04:15 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 19 Jul 2026 13:03:38 -0500
Subject: [PATCH NOT-FOR-UPSTREAM 7/8] bios_emulator: Support IO port reads
 for Aspeed VGA cards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-aspeed_vbios_fixes-v1-7-c94026f28250@oss.tenstorrent.com>
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sun, 19 Jul 2026 20:36:10 +0200
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

The Aspeed VGA PCI device exposes an MMIO region in BAR2 that is mirrors
the same registers exposed by I/O ports. All the reads/writes done by
the VBIOS to I/O ports can be forwarded to this region. This allows
the probe to complete and we get video output in u-boot.

This is probably not the right way to do this, and I'm open to feedback
on how this should be done.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/atibios.c         | 30 ++++++++++++++++++++++++++++++
 drivers/bios_emulator/besys.c           | 12 ++++++++++++
 drivers/bios_emulator/include/biosemu.h |  5 +++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
index ebeeb178b7f..2102a9ba0a1 100644
--- a/drivers/bios_emulator/atibios.c
+++ b/drivers/bios_emulator/atibios.c
@@ -47,6 +47,8 @@
 ****************************************************************************/
 #include <compiler.h>
 #include <bios_emul.h>
+#include <dm/device.h>
+#include <pci.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
@@ -483,6 +485,34 @@ int biosemu_setup(struct udevice *pcidev, BE_VGAInfo **vga_infop)
 	}
 	memset(VGAInfo, 0, sizeof(*VGAInfo));
 	BE_init(0, 65536, VGAInfo, 0);
+
+	/*
+	 * ASPEED VGA devices expose a relocatable I/O BAR (BAR2, 128 bytes)
+	 * that maps the legacy VGA ports 0x380-0x3ff. Use it to forward VGA
+	 * port I/O to the real card on platforms without x86-style I/O
+	 * port access.
+	 */
+	if (device_is_on_pci_bus(pcidev)) {
+		u16 vendor;
+		u32 bar;
+
+		dm_pci_read_config16(pcidev, PCI_VENDOR_ID, &vendor);
+		if (vendor == 0x1a03) {
+			dm_pci_read_config32(pcidev, PCI_BASE_ADDRESS_2, &bar);
+			if ((bar & PCI_BASE_ADDRESS_SPACE) ==
+			    PCI_BASE_ADDRESS_SPACE_IO &&
+			    (bar & PCI_BASE_ADDRESS_IO_MASK)) {
+				_BE_env.vga_mmio = \
+					dm_pci_io_to_virt( \
+								pcidev,
+								bar & PCI_BASE_ADDRESS_IO_MASK,
+								0x80,
+								MAP_NOCACHE);
+				printf("videoboot: VGA I/O via IO BAR2 %p\n",
+				       _BE_env.vga_mmio);
+			}
+		}
+	}
 	*vga_infop = VGAInfo;
 
 	return 0;
diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 7365e86a9e7..15bb3d75ad8 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -268,6 +268,12 @@ static u8 VGA_inpb (const int port)
 {
 	u8 val = 0xff;
 
+	/* Forward to the real card via its memory-mapped VGA port window */
+	if (_BE_env.vga_mmio) {
+		val = readb(_BE_env.vga_mmio + (port - 0x380));
+		return val;
+	}
+
 	debug_io("vga_inb.%04X -> ", (u16) port);
 	switch (port) {
 	/*
@@ -358,6 +364,12 @@ to use.
 ****************************************************************************/
 static void VGA_outpb (int port, u8 val)
 {
+	/* Forward to the real card via its memory-mapped VGA port window */
+	if (_BE_env.vga_mmio) {
+		writeb(val, _BE_env.vga_mmio + (port - 0x380));
+		return;
+	}
+
 	switch (port) {
 	/*
 	 * 3B4 and 3B5 are mirrors of 3D4 and 3D5 that are used in
diff --git a/drivers/bios_emulator/include/biosemu.h b/drivers/bios_emulator/include/biosemu.h
index 124d79d80e1..51ffef39f8a 100644
--- a/drivers/bios_emulator/include/biosemu.h
+++ b/drivers/bios_emulator/include/biosemu.h
@@ -88,6 +88,11 @@ typedef struct {
 	ulong biosmem_base;
 	ulong biosmem_limit;
 	ulong busmem_base;
+	/*
+	 * Memory-mapped window to VGA I/O ports 0x380-0x3ff (e.g. ASPEED
+	 * I/O BAR2 mapped via the PCI host I/O window); NULL if unused
+	 */
+	void *vga_mmio;
 
 	u32 timer0;
 	int timer0Latched;

-- 
2.43.0

