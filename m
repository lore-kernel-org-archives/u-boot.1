Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007B4C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA2082F8E;
	Fri, 11 Jul 2025 17:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mtc6rXyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E1E82063; Fri, 11 Jul 2025 17:16:06 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9690782063
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73a4c557d47so1050422a34.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752246963; x=1752851763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jh/71PGtkMz3ZurGTTiSpPvpFNY+tcD8bIHoBaAEwMU=;
 b=mtc6rXytdwKtY5B/VilLwNDkaA4pUeb1n2URomQ1BTYirMYAYrWXLUB1rWb4mjDKx3
 3/D6Keka//4KJvKOFMnhPtIui3xbRa5YzZFp4TY8aQ7wQHDXXszta6L5FqN0jcOvECk1
 js3OaYD06Qsriy0yclZhx98OD+lxEeZg4p4Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752246963; x=1752851763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jh/71PGtkMz3ZurGTTiSpPvpFNY+tcD8bIHoBaAEwMU=;
 b=ffce+qtCIcw24MYNPmoohbRJmEVOVEmTm8XhXpsZvwNTe2Rhq9jjUcZPXjilN7lJeD
 iliwPqcm/6tgiYX/6UZItkjE2FPrYpaIYr+7FGBvBAMFcZ0Z6OeOdpqYQ92rRFkEzS6L
 QmK+uDLAGdImn2a0NfEztHZnfkVgM2+9XqUfbFH/ACmfHqOoO6X5wGnta6yEoo9exFCa
 WvF7HTGhcKJOj2rNpiVdw1dRrFKUoFcH2rlTryecw/jz4B8W/DRfF24s049FyJcaUfSG
 y/3Y4RD9Wfz593VqQUROMblPeeti3Ohaj2CwRHPrIBd9bBlGPkiM/j6MjmmyDit2lRvd
 em+g==
X-Gm-Message-State: AOJu0YwWwKhxp5zZw31sWrWXXl450wZKmF29U6gyCAp2Ss+i1hERO/NI
 VWOtRo/Imrj7Qi39SbrWQUO+2DE21XBB3+5U2yMo+MJJHqfi5577Ev7HUc9BRP7G7DXDDZuIk3O
 QA574e8o=
X-Gm-Gg: ASbGncuoQb7ljFWb2GVrwa/0jV7vvY7iXWlgOgG2FTYjMdSdNwM78vwELr0yhnmRKov
 rBTQExFsDn4eEG+3koVGki5MOMGsaXH7StHSJJ71CU8AtaINzN48SRMEcPGWulpHBp6kUuyzBAj
 q7O9VbQ2X9pCBrU1f4Ly4HXEA8194iLE3o4Qoo0AhWzy8j+zLFx2BA2hV/LxbHFxuu2Hzqt/hAA
 ZjExNuSRtRgBtbrTpfevP0bXl2rDNzuEv4K1X79BL/PGpzNg69pBiYaPAO7w63V6/2OhQl9At0a
 1aLQSFUoymQWsiWXSs8SOfNcvAUzNCX/UlzunL4xVUElJoWcPj0P7cdOZZ7lZX8vhcD2u2z5qdo
 dGlXZlgbIokbBQx46k8Q6dp/HZElwYIUfpj2s6nefKQ/rgaNhfAIzpG9KS5s=
X-Google-Smtp-Source: AGHT+IFg5YXBnm3XW4PGs6+Mthf9PqABSUowjXQNJYkV/SvhxanwxbN59lKHmmNl0z4Tnb1Uug/tDw==
X-Received: by 2002:a05:6830:498f:b0:73b:2480:7eb9 with SMTP id
 46e09a7af769-73cf9f36655mr2991207a34.24.1752246963086; 
 Fri, 11 Jul 2025 08:16:03 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12a5413sm587014a34.52.2025.07.11.08.16.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:16:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mtd: nvmxip: Make use of LBAF for printing lbaint_t
Date: Fri, 11 Jul 2025 09:16:01 -0600
Message-ID: <20250711151601.2224226-1-trini@konsulko.com>
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

When printing the contents of an lbaint_t variable we need to use LBAF
to print it in order to get the correct format type depending on 32 or
64bit-ness.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mtd/nvmxip/nvmxip.c      | 4 ++--
 drivers/mtd/nvmxip/nvmxip_qspi.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nvmxip/nvmxip.c b/drivers/mtd/nvmxip/nvmxip.c
index 594500f0c654..3d8597aca76f 100644
--- a/drivers/mtd/nvmxip/nvmxip.c
+++ b/drivers/mtd/nvmxip/nvmxip.c
@@ -41,7 +41,7 @@ static ulong nvmxip_blk_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcn
 	if (!buffer)
 		return -EINVAL;
 
-	log_debug("[%s]: reading from blknr: %lu , blkcnt: %lu\n", dev->name, blknr, blkcnt);
+	log_debug("[%s]: reading from blknr: " LBAF " , blkcnt: " LBAF "\n", dev->name, blknr, blkcnt);
 
 	virt_blkaddr = map_sysmem(blkaddr, 0);
 
@@ -86,7 +86,7 @@ static int nvmxip_blk_probe(struct udevice *dev)
 	desc->blksz = BIT(plat->lba_shift);
 	desc->bdev = dev;
 
-	log_debug("[%s]: block storage layout\n    lbas: %lu , log2blksz: %d, blksz: %lu\n",
+	log_debug("[%s]: block storage layout\n    lbas: " LBAF " , log2blksz: %d, blksz: %lu\n",
 		  dev->name, desc->lba, desc->log2blksz, desc->blksz);
 
 	return 0;
diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
index f14a822b5d5e..1a109bee557a 100644
--- a/drivers/mtd/nvmxip/nvmxip_qspi.c
+++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
@@ -49,7 +49,7 @@ static int nvmxip_qspi_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	log_debug("[%s]: XIP device base addr: 0x%p , lba_shift: %d , lbas: %lu\n",
+	log_debug("[%s]: XIP device base addr: 0x%p , lba_shift: %d , lbas: " LBAF "\n",
 		  dev->name, (void *)(uintptr_t)plat->phys_base, plat->lba_shift, plat->lba);
 
 	return 0;
-- 
2.43.0

