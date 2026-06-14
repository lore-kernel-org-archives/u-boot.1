Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01705CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 14:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B100884877;
	Sun, 14 Jun 2026 16:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i11asvd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 943C384704; Sun, 14 Jun 2026 15:44:19 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F03583EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 15:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8419ab3a297so1033017b3a.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781444655; x=1782049455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kxmppgxjv+9gY7xZk7zpjMgAGf/4fk6diWtb8BPJGXU=;
 b=i11asvd3FQ4pj0dulCyF4VGn2WhTm/p15apqu0ENQVoYN6OTbp1h1N4hLPM+5nYQEe
 aaYI+63m5A04Zlj5rG/NfXttJSJPlzBx3sPYqj+1AGpNK+jgzYeEGaiE1uBYFnXwd/8P
 FhpausGG3x40AAQwN0L4+/27ciGU3z5cGMVM640l0muujqoa/Ek3bTyE3lPNSJ1Z3Fas
 DoXjZGNjZ3fTLGmrPchNbX18ZqM3ZBIBMWn5zk3Rh6SRANYbUgRUIhJd4nYH1hL1UbGq
 HUYhVJLfdxcrKvB+8cMjF5IuV4CdCoCJU8saTig0+NKpW1Sl1aKf927OfvdQeNABRYro
 xOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781444655; x=1782049455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kxmppgxjv+9gY7xZk7zpjMgAGf/4fk6diWtb8BPJGXU=;
 b=bnOCnjDhAw/nFXTyh69yOS+2UBskBVIZIqAhOtO1/4O9VZ1CW661sQZNADtuNoDcT5
 2l/VSmgEEpdMXbwqxH8bXNvQTgwWvgLHVQqtxLATyWeFfgTMoAuiK+8YYm1+J6rOgnUE
 tj6a4SSX/tw4GhAf8EqmzEavkPuik/CZwsw80ixBuzE1favhxjXpPp0W5+5lFx61Qy0n
 3/Bg3onRa5/ZXtGbsC27gbP5q3AEvhOf7rgCcgtcvPFotg6I8FgWnvHHXj45oM2UpoWJ
 5gCOA42GHYl5o2/nNSt7vYbghrdNrpYLj5tr/J/3MDU0vs6RBB8AMbm8tPITy7HnZE+1
 cMBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/niuxMPbUrSwrEmwYt71Z3PHz9kUaMVeghr6g4IE+IKrtyRWDxhJ1aTsec3e7wYtWTe+SMFtk=@lists.denx.de
X-Gm-Message-State: AOJu0YwTdQRu19oD7jYp8R/fsbtg2T1OV7QWa4r3CB8nYzahR0KXabuP
 bmyThNZiyiMijXLUzhB8p4vUqaHo7ImiCLmfbKf5XIkbThE6U6ud+Otb
X-Gm-Gg: Acq92OEIRzql+J31jz3VuMs0ABvFhn1TaEMUVd4WPmMcUGFdTBpiYBJ8J5Ej8wjzzND
 pFbULjfOPfdnQD/LI8yAgQ/ofG/6kO240xKw3hwLvHmeWMR5goXXpjiA5yelIF1yZ/ZUP5yd2uu
 u83CRCiTZNWdB43DjmgEJlZNpyKm7jabGZApi7g9dEMMEVJk/WDa/71qkzpGtv6yuvQS7eUiqMV
 Csr/0pLD7p9pPIPSQfC5rurY6Lv4K7+PYpu0isn7x5RSBUpbddwSwBDZcjCpm4sBG+Uwto6bjUW
 A4Sel8o0FzV51duox11TbiuycL+pBBtGsTNBUDL8xGc+rdTpuhobRsb9swvKiWcDgv8rbCI9QIH
 HTpbp3N84RmrhyW1xbJsDUH18ap19J7bdRwNyW65ZJoESLU7tKjf2WxYFXxvcgHmdh8osZbGyZF
 FehaU0RMd7NzYy4XvApPY9cGs=
X-Received: by 2002:a05:6a00:450f:b0:835:3949:3c1f with SMTP id
 d2e1a72fcca58-8434cf0e0d0mr10821357b3a.24.1781444655342; 
 Sun, 14 Jun 2026 06:44:15 -0700 (PDT)
Received: from Sun ([117.89.72.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm7421359b3a.5.2026.06.14.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 06:44:14 -0700 (PDT)
From: Ssunk <ssunkkan@gmail.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Date: Sun, 14 Jun 2026 21:44:06 +0800
Message-ID: <20260614134406.542-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jun 2026 16:04:46 +0200
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

Add support for dosilicon ds25q4bb (256M-bit) SPI NOR flash.

Datasheet:
https://drive.google.com/file/d/17UFJa5_3imH0YmWlRGTQYhO2JBXf4Klk/view

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..b370e782627 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -87,6 +87,8 @@ const struct flash_info spi_nor_ids[] = {
 		    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("ds25q4dn", 0xe5301b, 0, 64 * 1024, 2048,
 		    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("ds25q4bb", 0xe53019, 0, 64 * 1024, 512,
+		    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */
-- 
2.43.0

