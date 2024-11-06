Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B399ED29FA5
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 00:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23867891CD;
	Thu,  7 Nov 2024 01:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="GR5RLdVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094F58902D; Wed,  6 Nov 2024 22:04:05 +0100 (CET)
Received: from mail-il1-x161.google.com (mail-il1-x161.google.com
 [IPv6:2607:f8b0:4864:20::161])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B36588E63
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 22:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-il1-x161.google.com with SMTP id
 e9e14a558f8ab-3a4cd2780d8so206475ab.2
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1730927041; x=1731531841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nGlbOcIe1frWmbrVb2JUCSa4EP02nl8KCRdE8eAlVn0=;
 b=GR5RLdVM9NyU/Ano5Gfb3TYmYE0nZGRcfq7Z/erXJ/Cv/7/Inz06iV81LEKasXnp+7
 0/s2BrqCx2WPcWgGbyuCsqg3lOcNxqWUUGhVmDtNihqgYH2OHUSglSZXjvazI3lziRNo
 YAzjhczx0knztrWAvAK0WUO8trlNGpCySoFA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730927041; x=1731531841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGlbOcIe1frWmbrVb2JUCSa4EP02nl8KCRdE8eAlVn0=;
 b=v5+K48UG8tXRdj7yP5ZfdNIC8kgFaqkAOBGysBO7pj3jhLebQ/J7nCJEMwpPqiJBsz
 shEOH0zsgvEtUidK32si3addGp4l4ARvmzKS0cIRnAwPeYbpe5ZQaB07qERhPii4PT5u
 7Pv1zA5l9r7Lj4uY7mEa/QcIgiQSqJpZimy4foDdEQAIPkeTKXwIuaRDVtpZHr5V0cGd
 lb1eSCreKD33ku9thdttUgqIRsuM/ZFu+ycuRvWKEMzoeZp6AxVfUVrNGN12M62msKDU
 Kxb6xQCm9EZ5ls/dK6nDDyfxfxa/FnzJ4mtA6Tvso10CVYUkOu1w2kB/SuLHfiEq8NgA
 H8Eg==
X-Gm-Message-State: AOJu0YyhHD+x3GmJeDMdMgm130V4wEQd+eJ1xqCvaQBxGyP5iasKb9Bs
 1E3iVU2qHzgVt8D+h863h12dFXSyhC8uBM4V23YePCXjOBeyMFN4ep2GdbRu0aGLfL2f9ad6YlK
 V9W7QlIWDkru4ReoBXLuZTGtAHgkOhX9KJjOzyIFg07Lcf1a2brgTsqhWRxqdPua2g5/2upkSjy
 B9Zy6Jhj1Ija43SaPSniXuojWwX9FBF2mfrT4HwMCxeRGOLOYXT+BPGwcFGlQcGn5sHkCq
X-Google-Smtp-Source: AGHT+IE7VCH5ahJ4b9m5f8FWYALlyl+B/qzDIMxfiwMOn0ImzI9H+i32x6mzDbvgzkb+kPx6ssGtRaqg59LV
X-Received: by 2002:a05:6e02:152b:b0:3a6:b6b4:1d4c with SMTP id
 e9e14a558f8ab-3a6e842ebc8mr3040755ab.2.1730927041119; 
 Wed, 06 Nov 2024 13:04:01 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-3a6a9a29b37sm8165005ab.71.2024.11.06.13.03.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2024 13:04:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>,
 David Regan <dregan@mail.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/4] mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
Date: Wed,  6 Nov 2024 13:03:47 -0800
Message-Id: <20241106210348.218507-4-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241106210348.218507-1-dregan@broadcom.com>
References: <20241106210348.218507-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Nov 2024 01:52:42 +0100
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

The BCMBCA broadband SoC integrates the NAND controller differently than
STB, iProc and other SoCs.  It has different endianness for NAND cache
data.

Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
and performance improvement using the optimized memcpy function on NAND
cache memory.

This is a port of the upstream Linux patch to U-Boot.

https://lore.kernel.org/linux-mtd/20240223034758.13753-12-william.zhang@broadcom.com/

Signed-off-by: david regan <dregan@broadcom.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 17 ++---------------
 drivers/mtd/nand/raw/brcmnand/brcmnand.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 749553c9df90..6eb2fa65cc1e 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1640,7 +1640,6 @@ static void brcmnand_cmdfunc(struct mtd_info *mtd, unsigned command,
 			native_cmd == CMD_PARAMETER_CHANGE_COL) {
 		/* Copy flash cache word-wise */
 		u32 *flash_cache = (u32 *)ctrl->flash_cache;
-		int i;
 
 		brcmnand_soc_data_bus_prepare(ctrl->soc, true);
 
@@ -1648,20 +1647,8 @@ static void brcmnand_cmdfunc(struct mtd_info *mtd, unsigned command,
 		 * Must cache the FLASH_CACHE now, since changes in
 		 * SECTOR_SIZE_1K may invalidate it
 		 */
-		for (i = 0; i < FC_WORDS; i++) {
-			u32 fc;
-
-			fc = brcmnand_read_fc(ctrl, i);
-
-			/*
-			 * Flash cache is big endian for parameter pages, at
-			 * least on STB SoCs
-			 */
-			if (ctrl->parameter_page_big_endian)
-				flash_cache[i] = be32_to_cpu(fc);
-			else
-				flash_cache[i] = le32_to_cpu(fc);
-		}
+		brcmnand_soc_data_bus_read(ctrl->soc, ctrl->nand_fc, flash_cache,
+					   FC_WORDS);
 
 		brcmnand_soc_data_bus_unprepare(ctrl->soc, true);
 
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index 3a1d60471361..72f18c3a86f7 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -30,6 +30,24 @@ static inline void brcmnand_soc_data_bus_unprepare(struct brcmnand_soc *soc,
 		soc->prepare_data_bus(soc, false, is_param);
 }
 
+static inline void brcmnand_soc_data_bus_read(struct brcmnand_soc *soc,
+					      void __iomem *flash_cache, u32 *buffer,
+					      int fc_words)
+{
+	int i;
+
+	if (soc->read_data_bus)
+		soc->read_data_bus(soc, flash_cache, buffer, fc_words);
+	else {
+		/*
+		 * Flash cache is big endian for parameter pages, at
+		 * least on STB SoCs
+		 */
+		for (i = 0; i < fc_words; i++, buffer++)
+			*buffer = be32_to_cpu(__raw_readl(flash_cache + i * 4));
+	}
+}
+
 static inline u32 brcmnand_readl(void __iomem *addr)
 {
 	/*
-- 
2.37.3

