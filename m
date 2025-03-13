Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274B7C28B2E
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 11:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C718169D;
	Thu, 13 Mar 2025 12:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hakwF0er";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D9380F9C; Thu, 13 Mar 2025 12:55:30 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D95148169D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52DBtOfI1323681
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 06:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741866924;
 bh=PSuWg3Dye9wazoITfmIbCU+Wkt2LwBgvIAWiFCUqXWg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hakwF0erhbZCVQxm1oYL9eXdCn1FINZHsAN4Qq+Q+Mmlg2Mx5wNXLV7e2AnoXnyJf
 mEkFy4YHZADWUnc5kYg1S2LjyNZkgswi56IUHTC6Rz5fQHVjuiluP4ZHbe190rIDp4
 6HI7frBPTJrSqrCuLI4XXQwN/z+A4IIn0+4ewBTY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52DBtOgX097102
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Mar 2025 06:55:24 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Mar 2025 06:55:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Mar 2025 06:55:24 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.128])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52DBtNHn097530;
 Thu, 13 Mar 2025 06:55:24 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>
Subject: [RFC PATCH 4/4] docs: fuse: Add fuse writebuff cmd docs
Date: Thu, 13 Mar 2025 17:25:17 +0530
Message-ID: <20250313115517.1181829-5-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313115517.1181829-1-h-vm@ti.com>
References: <20250313115517.1181829-1-h-vm@ti.com>
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

Add fuse writebuff sub-system command documentation

Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
---
 doc/README.fuse | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/README.fuse b/doc/README.fuse
index 1bc91c44a6a..b150f39cc16 100644
--- a/doc/README.fuse
+++ b/doc/README.fuse
@@ -61,7 +61,21 @@ Functions / commands:
       fuses have already been programmed or are locked (if the SoC allows to
       override a locked fuse).
 
+   int fuse_writebuff(ulong addr);
+   fuse writebuff [-y] <addr>
+      Program fuse data using a structured buffer in memory starting at 'addr'.
+      This operation directly affects the fusebox and is irreversible.
+
+      The structure of the buffer should contain all necessary details for
+      programming fuses, such as the values to be written to the fuse, optional
+      metadata for validation or programming constraints and any configuration
+      data required for the operation. Define CONFIG_CMD_FUSE_WRITEBUFF to
+      enable the fuse writebuff command.
+
 Configuration:
 
    CONFIG_CMD_FUSE
       Define this to enable the fuse commands.
+
+   CONFIG_CMD_FUSE_WRITEBUFF
+      Define this to enable the fuse writebuff command.
-- 
2.34.1

