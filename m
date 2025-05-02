Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2F2C3ABA5
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 05:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56EE8059D;
	Fri,  2 May 2025 07:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i8VLpke2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4715A8070C; Fri,  2 May 2025 07:05:42 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B626E803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 07:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54255bDt3786811
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 May 2025 00:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746162338;
 bh=sKG9FxMlHK4c4gEFl5Zy6MbAAL96dEA1Kp8BXnDsIBk=;
 h=From:To:CC:Subject:Date;
 b=i8VLpke28+OEWgqOz/3ei2QQjF/HiTBU5wCamDBM5pcCpLyxMKzWzF9LPxWcKWvZ0
 XIOKwR3Hj1iVvHS4o+KaOROL9uAhI4+cfmKEfx+YLkM5PoDb+sgiDFjjK1xmoqYO51
 z4vJ6yjQV7jete6Ech9U3+Drfg+HmVNnv3mDbeiA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54255bRH053269
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 2 May 2025 00:05:37 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 May 2025 00:05:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 May 2025 00:05:37 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54255aCk028170;
 Fri, 2 May 2025 00:05:37 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1] board: ti: common: Kconfig: add CMD_CACHE
Date: Fri, 2 May 2025 10:35:16 +0530
Message-ID: <20250502050517.3724756-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
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

Add CMD_CACHE to list of configs implied by TI_COMMON_CMD_OPTIONS.
This allows the usage of cache commands from U-Boot prompt.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index c03aa3a368f..d578ee44ae8 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -26,6 +26,7 @@ config TI_COMMON_CMD_OPTIONS
 	bool "Enable cmd options on TI platforms"
 	imply CMD_ASKENV
 	imply CMD_BOOTZ
+	imply CMD_CACHE
 	imply CRC32_VERIFY if ARCH_KEYSTONE
 	imply CMD_DFU if USB_GADGET_DOWNLOAD
 	imply CMD_DHCP
-- 
2.49.0

