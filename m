Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECA6D6B6D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0248926A;
	Wed, 30 Oct 2024 22:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="KeYsDf9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CDC389228; Wed, 30 Oct 2024 20:38:31 +0100 (CET)
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF2589246
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 20:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1730317109;
 bh=KnXBCYewnGtUjvFUAn4i2dmU+SVxvUYUhR9NQ8fyLB8=;
 h=Date:From:To:Subject:Message-ID:Content-Type:From;
 b=KeYsDf9gpp97RGR8bru95cYt2Dqza0tnD+WmpDaxC1q/w8dahd4txXYgnI6KIgf1s
 Cuxh9c0Xg2i7QJAfa8CPK8HBRwnpKwB7X/U6cDfup47JHPEVS7ChymNNIgI/ppaSoB
 UyOUCez9uxDvXY73+103a5gA8qNNmbm6tefQOF0A=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr4.vodafonemail.de (Postfix) with ESMTPS id 4Xdy912JlXz21Pt
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 19:38:29 +0000 (UTC)
Received: from qrv-systems.net (ip-095-222-025-162.um34.pools.vodafone-ip.de
 [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4Xdy8w74qkz9rwG
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 19:38:21 +0000 (UTC)
Date: Wed, 30 Oct 2024 20:38:20 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Subject: [PATCH] bios_emulator: fix first argument of
 pci_{read,write}_config_* function calls
Message-ID: <ZyKLLBASJfMDk0QX@qrv-systems.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 2161
X-purgate-ID: 155817::1730317105-D8FF8466-02B208FC/0/0
X-Mailman-Approved-At: Wed, 30 Oct 2024 22:00:12 +0100
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

When compiling for riscv64, a bunch of warning is produced for the file
drivers/bios_emulator/besys.c. This patch fixes a portion of those warnings,
caused by incorrect first argument to pci_{read,write}_config_* functions.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/besys.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 2fd794f76c..c6c5b7ed44 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -49,6 +49,7 @@
 
 #define __io
 #include <asm/io.h>
+#include <pci.h>
 #include "biosemui.h"
 
 /*------------------------- Global Variables ------------------------------*/
@@ -434,32 +435,27 @@ static u32 BE_accessReg(int regOffset, u32 value, int func)
 	if ((function == _BE_env.vgaInfo.function) &&
 	    (device == _BE_env.vgaInfo.device) &&
 	    (bus == _BE_env.vgaInfo.bus)) {
+                pci_dev_t bdf = PCI_BDF(bus, device, function);
 		switch (func) {
 		case REG_READ_BYTE:
-			pci_read_config_byte(_BE_env.vgaInfo.pcidev, regOffset,
-					     &val8);
+			pci_read_config_byte(bdf, regOffset, &val8);
 			return val8;
 		case REG_READ_WORD:
-			pci_read_config_word(_BE_env.vgaInfo.pcidev, regOffset,
-					     &val16);
+			pci_read_config_word(bdf, regOffset, &val16);
 			return val16;
 		case REG_READ_DWORD:
-			pci_read_config_dword(_BE_env.vgaInfo.pcidev, regOffset,
-					      &val32);
+			pci_read_config_dword(bdf, regOffset, &val32);
 			return val32;
 		case REG_WRITE_BYTE:
-			pci_write_config_byte(_BE_env.vgaInfo.pcidev, regOffset,
-					      value);
+			pci_write_config_byte(bdf, regOffset, value);
 
 			return 0;
 		case REG_WRITE_WORD:
-			pci_write_config_word(_BE_env.vgaInfo.pcidev, regOffset,
-					      value);
+			pci_write_config_word(bdf, regOffset, value);
 
 			return 0;
 		case REG_WRITE_DWORD:
-			pci_write_config_dword(_BE_env.vgaInfo.pcidev,
-					       regOffset, value);
+			pci_write_config_dword(bdf, regOffset, value);
 
 			return 0;
 		}
-- 
2.39.5

