Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E690C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 15:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9864A807C4;
	Fri, 21 Feb 2025 16:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XMZbayl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7866F80F56; Fri, 21 Feb 2025 16:18:02 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C04F0806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 16:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51LFHvA1333663
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2025 09:17:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740151077;
 bh=pnlfFebFRM0VSzoUfgctsNSWsTPKK+/N1xd3hT9fYEE=;
 h=From:To:CC:Subject:Date;
 b=XMZbayl8Rfi+BeglLzzVobN6TvYQFPVzC6C2cfahj5eQxM1Pvg5yHCpG2ZEJC3Rkb
 4AIJK/OF8KhVsHEnh5bI9NDtM5ORABdsFTkk16JnOq38qS7PgFJ4fwj1tKkv06n9dP
 1kN+AsxGF380F1Y89TbZ2rtyvIwC5cn7qdXDciQI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51LFHvBH028864
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Feb 2025 09:17:57 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Feb 2025 09:17:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Feb 2025 09:17:57 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51LFHuiB125993;
 Fri, 21 Feb 2025 09:17:56 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <seanga2@gmail.com>
Subject: [PATCH] spl: return kernel image header size in os boot
Date: Fri, 21 Feb 2025 20:47:51 +0530
Message-ID: <20250221151752.2618666-1-anshuld@ti.com>
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

During kernel build process the header size is computed including the
BSS whereas it's removed when creating the uncompressed image. Therefore
the size of the uncompressed image on filesystem will be smaller than
the size specifiedin the header.

Therefore it makes sense to return the header size back instead of the
file size in falcon boot.

More info:
https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.com/

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

