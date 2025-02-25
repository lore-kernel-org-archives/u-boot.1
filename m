Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF8EC021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 14:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BB180EC0;
	Tue, 25 Feb 2025 15:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ry5B1niM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7D780F88; Tue, 25 Feb 2025 15:25:50 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1B080805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 15:25:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51PEPj3M1255441
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 08:25:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740493545;
 bh=+GH7Sst9UQun5THCdpMoDGkfhLO0UT+Q780kuYZ7YRA=;
 h=From:To:CC:Subject:Date;
 b=ry5B1niMceeg5T8Bc7CXFYUX2lRVYNO3WsxO1ogqZtRqPGSdM45GKk1Qa3N9joEN4
 L9b+1055VElgUjkqpv5qUrV7qQw9gUkB8kCayK5a+oVsfNdFgqyTSzTEkFiVCk6R6d
 70NysrV8FD39PIuPJl48abwxrQSrQc5XOxX0gNW4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51PEPj8B015962
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Feb 2025 08:25:45 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Feb 2025 08:25:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Feb 2025 08:25:44 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51PEPiW7021651;
 Tue, 25 Feb 2025 08:25:44 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <seanga2@gmail.com>
Subject: [PATCH v2] spl: return header size to spl_load in os boot
Date: Tue, 25 Feb 2025 19:55:20 +0530
Message-ID: <20250225142522.9069-1-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

During linux build process the header size is computed including the BSS
whereas it's removed when creating the uncompressed image. Therefore the
size of the uncompressed image on filesystem will be smaller than the
size specified in the header.

This causes issues when loading the kernel image from the SPL (as in
falcon boot) with spl_load since it compares the read file size from the
FS to the header size form the image. Which leads to the following check
in `include/spl_load.h` failing to -EIO when loading kernel image:

  return read < spl_image->size ? -EIO : 0;

Therefore we should return the header size back to spl_load instead of
the file size in falcon boot when loading kernel image.

Bug report:
https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.com/

Fixes: 775074165d97 ("spl: Add generic spl_load function")
Reported-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_ext.c | 4 ++++
 common/spl/spl_fat.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index c5478820a9b..6d8d6544092 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -17,6 +17,10 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 	ret = ext4fs_read(buf, file_offset, size, &actlen);
 	if (ret)
 		return ret;
+
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
+		return size;
+
 	return actlen;
 }
 
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index fce451b7664..ddf85e2cece 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -55,6 +55,9 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
+		return size;
+
 	return actread;
 }
 
-- 
2.43.0

