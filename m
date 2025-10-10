Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E401CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 13:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA2084248;
	Fri, 10 Oct 2025 15:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UZTkVDk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A5B8410C; Fri, 10 Oct 2025 15:18:40 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB5283F91
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ADIaHE694407;
 Fri, 10 Oct 2025 08:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760102316;
 bh=YyuZOpt6Ftylz3zv9UUWc/wnqHAg00/w9qYjEdVxWXE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UZTkVDk5PVH1M8je7buq61x/UwuRnuNnOudaKdlFI+s115D8fVViOOotszelfA939
 d+RctPWNZbRquUj28Z9Aew3oBWp9ScO66rFxsXmqVtJTTfzzxTwMYFXwHV1pzT3nZD
 wXkZet85sU9CuIz/6/JSkbnFlvsA/Fx5v63/NtMA=
Received: from DFLE200.ent.ti.com (dfle200.ent.ti.com [10.64.6.58])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ADIa7b816271
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 Oct 2025 08:18:36 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 08:18:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 08:18:36 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ADIY6p1692610;
 Fri, 10 Oct 2025 08:18:35 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v1 2/5] board: ti: common: Kconfig: add CMD_SPL
Date: Fri, 10 Oct 2025 18:48:24 +0530
Message-ID: <20251010131829.3737258-3-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010131829.3737258-1-anshuld@ti.com>
References: <20251010131829.3737258-1-anshuld@ti.com>
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

Add CMD_CACHE to list of configs implied by TI_COMMON_CMD_OPTIONS. This
allows the use of 'spl export'[1] command for preparing a device-tree
for falcon boot.

[1]: https://docs.u-boot.org/en/v2025.10/develop/falcon.html#using-spl-command

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 board/ti/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index f481812247c..fa8260e3fa4 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -53,6 +53,7 @@ config TI_COMMON_CMD_OPTIONS
 	imply CMD_REGULATOR if DM_REGULATOR
 	imply CMD_SF if SPI_FLASH
 	imply CMD_SPI
+	imply CMD_SPL
 	imply CMD_TIME
 	imply CMD_USB if USB
 
-- 
2.51.0

