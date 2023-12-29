Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78813C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8E587BCD;
	Fri, 29 Dec 2023 18:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LQVkPEf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE2F87BD2; Fri, 29 Dec 2023 18:47:12 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDFC487BAE
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1ex088946;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=KuI4O4TVFjrh1iPjYjzeZoiqd6HovMk3Ok/je4woG24=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LQVkPEf3KZNkQFUOv2UIcZTIeHq7kkFLRJQ+oO0Jp9QJ+KhPJ0dyIXtKYt4zYSefy
 f27mBymaubQU7SdiPcplClNvCjl3DQ7rlHLkRzRruZJSyocxn/Tj8rn0uvtMrkr/pD
 bt/XJ5jKALxX5sDmmClzjGXF+/wm6ZVZOtbIX2KE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl161063424
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:00 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl0Cs005041;
 Fri, 29 Dec 2023 11:47:00 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 02/26] configs: am65x_evm_a53: disable CONSOLE_MUX
Date: Fri, 29 Dec 2023 11:46:59 -0600
Message-ID: <20231229174656.634065-30-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=bb@ti.com;
 h=from:subject; bh=9xttIhV83tylaFeFhKqAPAEn1VVM/FM9BpFiJKzp6Jw=;
 b=owNCWmg5MUFZJlNZadPeDQAAYP///v992vvzuOW+49vjenFm+Xb79m/o+2f/e+2bt95p+/+wA
 Rms0dqaDIZGJoMnqBpiGgA0NA0NNDJ6gDQHqGgAyAAyAaBo0Awmho000NG0gGymIZA0AaAGRoAD
 QaGmEMRhNDQAMgD01DTBBiZNGhoMgyA0AMQ0GTCZM1NBkh6g9QaPUAYhoNqA0yPUZGRoaD1AADQ
 AANA9RkZBkAxNBkNA9QaA0GTTag0aAg7D7UNXrABgX7NDEVnO9KAaCcRM3TFYcMDds1HWUSZg11
 7yFqqVgNVDQoEKOePNhyCa/t1S5AzNEVJS5UB6Vx1jh22uw/QlPqXozk4yEj0GoM0QbWcyXfXdC
 zSTaSb/Ml+jqfFBcLeprWAMwgZQ5RRuw0dHtUCPNblNpPWpxWht0CbwPWMG+juh1wmr1sELzmyw
 yLB0ZowwgvMWVSKvER1jkHcXeZ3hIYFw5tGLmdH/DZPMYZ4TTnck2DRu4GQ9g/VOOxAebOTtXIq
 a8OfZABMpdcIwrFnftm3VS9xAd+aFj2ibwsMvE+ZgJO3EWEbjDO+n+64FneL7bP7CBhEcDacbo3
 w7AJRMuAHmPysEJerRwEWAXfmf4BmGqvsgZf2iOLz3pq9S+JTHCTQNPnCnzBf9brw6EOFBDYIJh
 4HbL9+LePr0XckU4UJBp094NA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

We do not have a need to share a single console with the evaluation
board and disabling this option reduces the complexity of configuring
the consoles. Disable CONSOLE_MUX

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 configs/am65x_evm_a53_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index f4369865bf665..4d95e3bd29630 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -36,7 +36,6 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run init_${boot}; run boot_rprocs; if test ${boot_fit} -eq 1; then run get_fit_${boot}; run get_overlaystring; run run_fit; else; run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern; fi;"
 CONFIG_LOGLEVEL=7
-CONFIG_CONSOLE_MUX=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
-- 
2.43.0

