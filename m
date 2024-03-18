Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFF5C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 13:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80E787BF1;
	Mon, 18 Mar 2024 14:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="F1KEWhgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0DDF87DA7; Mon, 18 Mar 2024 14:43:07 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E58CB8752B
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 14:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710769385; x=1742305385;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lljkyHLPdyGeiAqKf8J1fPg3yfJZgxxZ28tDYWrczKc=;
 b=F1KEWhgmuEDbr8Frzxa6MUDX7Cf+xrZT7CYUiCWKGKafQ8tEaQQkbuxS
 tFCOfXoJntdTYviP4o/achG067hHBsErmQEOiedpCXgpF6LgVBKTCHW6l
 AAFrm5jbnRopqZWKCoxV/iFpgdjy56Ye2HYfai6qRZ9yCtFfKaohiarnr
 /h/eMJ+XQnWq+kfgtqpyQvfWWx9sQ2i4GF4fkz7ZKQWQ2gfTo0RJbt3tB
 43MyP9ArFy2K2rwW6ErLKFlttGAw4dz5Vh1LQuRNg63QnUOROMjybWgG7
 lPOU2Q1vVugqzXLT3m/6FUzd5w1K780hn08jtZPbWFiIeo0bZI9UxGt8F Q==;
X-CSE-ConnectionGUID: 7ltU+JBzT2ygi8tqEp4BLA==
X-CSE-MsgGUID: PfRImXxQSICb8tYaxLr1Fw==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; d="scan'208";a="17759370"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Mar 2024 06:43:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 06:42:23 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 06:42:21 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <seanga2@gmail.com>,
 <u-boot@lists.denx.de>, <dario.binacchi@amarulasolutions.com>,
 <michael@amarulasolutions.com>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2] cmd: nand: Add support to print the manufacturer,
 model and size
Date: Mon, 18 Mar 2024 15:42:19 +0200
Message-ID: <20240318134219.20040-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add support to nand info for printing the manufacturer,model and size.
The manufacturer and model are printed only for ONFI flashes.

U-Boot> nand info

Device 0: nand0, sector size 256 KiB
  Manufacturer  MACRONIX
  Model         MX30LF4G28AD
  Device size        512 MiB
  Page size         4096 b
  OOB size           256 b
  Erase size      262144 b
  ecc strength         8 bits
  ecc step size      512 b
  subpagesize       4096 b
  options       0x00004200
  bbt options   0x00028000

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

Changes in v2:
--------------
* use #ifdef directive for ONFI flashes.
* use unsigned int for chipsize.
---
 cmd/nand.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/cmd/nand.c b/cmd/nand.c
index fe834c4ac5..5773246d64 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -418,6 +418,11 @@ static void nand_print_and_set_info(int idx)
 		printf("%dx ", chip->numchips);
 	printf("%s, sector size %u KiB\n",
 	       mtd->name, mtd->erasesize >> 10);
+#ifdef CONFIG_SYS_NAND_ONFI_DETECTION
+	printf("  Manufacturer  %s \n", chip->onfi_params.manufacturer);
+	printf("  Model         %s \n", chip->onfi_params.model);
+#endif
+	printf("  Device size   %8u MiB\n", (unsigned int)(chip->chipsize >> 20));
 	printf("  Page size     %8d b\n", mtd->writesize);
 	printf("  OOB size      %8d b\n", mtd->oobsize);
 	printf("  Erase size    %8d b\n", mtd->erasesize);
-- 
2.44.0

