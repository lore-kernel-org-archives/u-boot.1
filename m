Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FA8C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 12:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7CCC87D1D;
	Mon, 18 Mar 2024 13:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="OrPA3B5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0332A87E69; Mon, 18 Mar 2024 13:27:17 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0D9878E9
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 13:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710764834; x=1742300834;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LG5HXtwkEeCY6oSBkdyuhoKz++cHieuroBIZK8gEDxU=;
 b=OrPA3B5/P7jwT7rV+oXp8h9rQPmgcD0kD8qsuiTII20vLK5YjDgjcTGj
 8+YIvVmnEH2jfA8HQSZ/+Nq8Xr86VO4ey2UdViYujppQTAy1ZPhqXzPM4
 mBdI0OdHBwAi71uVTjr/syETPJELxyQa5XyjgR9zu0IB8oxeeISZkIRUS
 310WvViDEx35gFFmzvFD/+N/C/teCKu9YFBJ1y66N0iRrbKhkmvkzOo1s
 zBXwrHQw1tofjN1au07S2cU68qnF1NAlf+4jMm3FVS5/x1q0N3Ln64DDR
 S5D+PUKRdQq/6pZYds+a1Pzx5OBd76P2oYxemd6/gBLXS5QafnJxQ6FyI Q==;
X-CSE-ConnectionGUID: ZIuZESPzS86zB8/4EY1jpQ==
X-CSE-MsgGUID: HVF4CS2MQ720WA3rmpNXUQ==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; d="scan'208";a="19512093"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Mar 2024 05:27:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 05:27:09 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 05:27:07 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <seanga2@gmail.com>,
 <u-boot@lists.denx.de>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] cmd: nand: Add support to print the manufacturer,
 model and size
Date: Mon, 18 Mar 2024 14:26:47 +0200
Message-ID: <20240318122647.1578-1-mihai.sain@microchip.com>
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
---
 cmd/nand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/nand.c b/cmd/nand.c
index fe834c4ac5..f5cfaab37c 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -418,6 +418,9 @@ static void nand_print_and_set_info(int idx)
 		printf("%dx ", chip->numchips);
 	printf("%s, sector size %u KiB\n",
 	       mtd->name, mtd->erasesize >> 10);
+	printf("  Manufacturer  %s \n", chip->onfi_params.manufacturer);
+	printf("  Model         %s \n", chip->onfi_params.model);
+	printf("  Device size   %8d MiB\n", (int)(chip->chipsize >> 20));
 	printf("  Page size     %8d b\n", mtd->writesize);
 	printf("  OOB size      %8d b\n", mtd->oobsize);
 	printf("  Erase size    %8d b\n", mtd->erasesize);
-- 
2.44.0

