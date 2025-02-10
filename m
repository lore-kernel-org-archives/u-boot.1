Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67502C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EAF880821;
	Mon, 10 Feb 2025 21:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PpxFybpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E1BC8043C; Mon, 10 Feb 2025 21:29:52 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F1280780
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51AKTjQZ193218
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 14:29:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739219385;
 bh=6PxTMRiS51BZO0HzIFilvsg6WvrA/VkSTBpUhddrhrM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PpxFybpy4beWSmf9N4Lhku1bbbwf/1VUOPjIOenTNJtBc/qf7+Uw2Uk6FqH2FSS80
 Yc3Xmpd2jXjfQLT8wg3+VVKzXOB6HnR0ZP5noMK4aR7Bk7UwomilP5eA/5/r+ylArK
 6/2QJrl6Z92g2RXPEqRWFd5QVViPwxE2etScMlto=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51AKTjwO074967
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 14:29:45 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 14:29:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 14:29:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AKTiDH022402;
 Mon, 10 Feb 2025 14:29:44 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Judith
 Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 07/10] spl: Enable SPL remoteproc by default for K3 ARCH
Date: Mon, 10 Feb 2025 14:29:41 -0600
Message-ID: <20250210202944.1071931-8-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250210202944.1071931-1-jm@ti.com>
References: <20250210202944.1071931-1-jm@ti.com>
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

If building for v7R and K3 architecture, enable SPL
remoteproc so that it does not have to be defined in each
board defconfig file.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v4:
- Add patch
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4e56d9909c8..85225db16fe 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1279,6 +1279,7 @@ config SPL_RAM_DEVICE
 
 config SPL_REMOTEPROC
 	bool "Support REMOTEPROCS"
+	default y if (CPU_V7R && ARCH_K3)
 	help
 	  Enable support for REMOTEPROCs in SPL. This permits to load
 	  a remote processor firmware in SPL.
-- 
2.48.0

