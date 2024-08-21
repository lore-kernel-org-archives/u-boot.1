Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9788C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 21:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA1387E9D;
	Wed, 21 Aug 2024 23:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724274119;
	bh=6aqv4DNnLwjAk81USOPwBdAOrhvd1J3TDUtckv3fvYQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BJmtnJtGEFQ+d9ohQ5jeyrkA4O5dY5mxHo7EXVXad+oNQhZNEz/WRUMYpeqgL2pPV
	 DpII3VMAc6Lh/wX0qbxfVpwbZXhDmrVJ0P34LKeaJ4MdQ7y3yzPArP/fQSixmDG2Bw
	 x5lGAUvXh2SW7yzU4X+TjO9YpoyVpwFSrz/anC7Q45HqUF4D/AbeSYK8z4aU0FbCjV
	 gAFgvvMskYlyrMSqZcI7NjEJx0fDF4qSJpT1ZhnXsXPCdOS+UG1O51hZv0BZS23aFc
	 GTjhElb9Xd/OAVJtt8d8b8pl6+MRurhJDqkqLeBT0tYWL4eWz5VBkrE/Yep67poXHI
	 qTvvtuQZvkOMQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2E2CE87BF4;
 Wed, 21 Aug 2024 23:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724274119;
 bh=6aqv4DNnLwjAk81USOPwBdAOrhvd1J3TDUtckv3fvYQ=;
 h=From:To:Cc:Subject:Date:From;
 b=xOFGN7y2lpoLUYYzBtlig2NbzOB2McifrIywLrIJJcGheCGiKrgII67Fo+Aoa+tp1
 kenX3FjPuOhEVdbLfyKVZ/oAD8snIsz5KssoF+9qfikey90uPpoERo73zqKmvLGJJF
 N/12E9xIsrvZXxr6xagvZZrM4nKIn6HGGCRTNclL8gLcEguIleD5Kv5jhs/i87ujO5
 YoGyq845lldcZPqxQhcFDoxH04r2YG/sheicNouvUSzMarVzfz0HID6OwrDpZfZ54R
 388OYs9zLAUjgm3naxcWnH1GY4maL1eyb5KhsqcDrIb1oyjLd1ufVA/DwLOQS4mYI3
 PQBYfOJLEzdQw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: imx: Use USB SDPS as fallback option on Data Modul
 i.MX8M Plus eDM SBC
Date: Wed, 21 Aug 2024 23:01:16 +0200
Message-ID: <20240821210144.268622-1-marex@denx.de>
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

The Data Modul i.MX8M Plus eDM SBC does have USB gadget capable port
accessible via USB A-A cable plugged into the bottom USB 3.0 port.
Use USB SDPS as the fallback boot device, so USB SDPS loading can
be performed using e.g. uuu tool.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/data_modul/imx8mp_edm_sbc/spl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/data_modul/imx8mp_edm_sbc/spl.c b/board/data_modul/imx8mp_edm_sbc/spl.c
index c0b50e3e3da..ce9da9451c4 100644
--- a/board/data_modul/imx8mp_edm_sbc/spl.c
+++ b/board/data_modul/imx8mp_edm_sbc/spl.c
@@ -104,7 +104,10 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 	if (boot_dev_spl == MMC3_BOOT)		/* eMMC */
 		return BOOT_DEVICE_MMC2;
 
-	return BOOT_DEVICE_MMC1;		/* SD */
+	if (boot_dev_spl == SD2_BOOT)		/* SD */
+		return BOOT_DEVICE_MMC1;
+
+	return BOOT_DEVICE_BOOTROM;		/* USB SDPS */
 }
 
 void board_boot_order(u32 *spl_boot_list)
-- 
2.43.0

