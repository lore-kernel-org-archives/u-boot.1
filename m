Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14596C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6BC87DD0;
	Tue, 30 Jan 2024 14:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F+Gy0xg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A160F87DB1; Tue, 30 Jan 2024 14:06:40 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F43487DBE
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6MIp077534;
 Tue, 30 Jan 2024 07:06:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706619982;
 bh=xzWYklAx+LicqYgI4yDye5+ESOOtZsP00gLlASULIlM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=F+Gy0xg8l28tGUfA2Io0Zi22NW1YVrieiulto9xa4zWqYrTC7OkweKgPIdfifTQi3
 d+O6aObqU1T0NSm4kiL5badNOnGbEjiwuVNlGfKwAh3ZqeS5sUV9F7HNQ0Zfwnc+nF
 p9oxvOSBpWEcUbUm6BYkGcDcPTvTVN0jv6QIsUi0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UD6MQ7026365
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 07:06:22 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 07:06:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 07:06:21 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6LxW121220;
 Tue, 30 Jan 2024 07:06:21 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 11/11] include: env: ti: Drop default_findfdt
Date: Tue, 30 Jan 2024 07:06:15 -0600
Message-ID: <20240130130615.670783-12-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130130615.670783-1-nm@ti.com>
References: <20240130130615.670783-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
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

We shouldn't need finfdt anymore. Drop the env script.

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V3:
- none other than picking up reviews.

V2: https://lore.kernel.org/r/20240109191506.3820908-11-nm@ti.com

 include/env/ti/default_findfdt.env | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 include/env/ti/default_findfdt.env

diff --git a/include/env/ti/default_findfdt.env b/include/env/ti/default_findfdt.env
deleted file mode 100644
index a2b51dd923bb..000000000000
--- a/include/env/ti/default_findfdt.env
+++ /dev/null
@@ -1,12 +0,0 @@
-default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
-default_device_tree_arch=ti
-#ifdef CONFIG_ARM64
-findfdt=
-	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
-	setenv fdtfile ${name_fdt}
-#else
-default_device_tree_subarch=omap
-findfdt=
-	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
-	setenv fdtfile ${name_fdt}
-#endif
-- 
2.43.0

