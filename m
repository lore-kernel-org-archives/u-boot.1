Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EC3CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 04:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE1A83A57;
	Tue,  2 Sep 2025 06:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C63QFzZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FFDF83A5A; Tue,  2 Sep 2025 06:58:34 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D6D83443
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 06:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5824wU2r2506898;
 Mon, 1 Sep 2025 23:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756789110;
 bh=K+04NbGDu/Yh+mgqf7oAtH1Ly46WKRVv+wPqq5kMcp0=;
 h=From:To:CC:Subject:Date;
 b=C63QFzZ2QA93na+UDE2/LrrjQo1wBm71fhhObOKsEqrKsKVAwh2dK05RsbfQUMCg9
 8S1iG/cHStLF/IoT/q4jRjMhVwh4mQIwGUBvG78wVhSQWH0BwTHpgaWyALjvrvM1t3
 E3Is+IN2NBu8wDOW0GavnIPMpxKmA/ccplEsj7as=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5824wU212026144
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 1 Sep 2025 23:58:30 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 23:58:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 23:58:30 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5824wTlW3507629;
 Mon, 1 Sep 2025 23:58:29 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1] board: ti: common: Kconfig: add CMD_MEMINFO
Date: Tue, 2 Sep 2025 10:27:07 +0530
Message-ID: <20250902045708.1328550-1-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
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

Add CMD_MEMINFO and CMD_MEMINFO_MAP to list of configs implied by
TI_COMMON_CMD_OPTIONS. This allows users to easily view the memory
configuration and the memory maps at runtime.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/common/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index 2de4212d9b8..f481812247c 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -40,6 +40,8 @@ config TI_COMMON_CMD_OPTIONS
 	imply CMD_GPIO
 	imply CMD_GPT
 	imply CMD_I2C
+	imply CMD_MEMINFO
+	imply CMD_MEMINFO_MAP
 	imply CMD_MII
 	imply CMD_MMC
 	imply CMD_MMC_REG
-- 
2.50.1

