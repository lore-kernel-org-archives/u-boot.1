Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F79C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CED987BE7;
	Wed, 24 Jan 2024 08:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gEvyQAg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 989B687BE7; Wed, 24 Jan 2024 08:26:43 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D268887613
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O7Qc6c054982
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 01:26:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706081198;
 bh=2BOrv03jvY0jQfhDNcvubHfbiKN3DvYOGQgUU9Jd5B0=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=gEvyQAg9w0neyT0+MT2HoU3TcOSdgB5T8L0IgnxmOsUI/zanfoPRr+U50IewInA/3
 hroVu8FoQu5BgTOZHeSxgzzfgILH7HYldSTakKrg4yT+IQxWtqy1Md0AeM9gcSzuQu
 Ic8w+pS5AMqqnnTPLphcg6PDEiuyV4SYIIpKWvpE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O7QcAG010973
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 01:26:38 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 01:26:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 01:26:38 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O7QTGj015268;
 Wed, 24 Jan 2024 01:26:35 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 24 Jan 2024 12:56:26 +0530
Subject: [PATCH 2/2] doc: k3: update documentation for uEnv.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240124-b4-upstream-save_uenv-v1-2-4a4dfbd3eca9@ti.com>
References: <20240124-b4-upstream-save_uenv-v1-0-4a4dfbd3eca9@ti.com>
In-Reply-To: <20240124-b4-upstream-save_uenv-v1-0-4a4dfbd3eca9@ti.com>
To: Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706081189; l=2085;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=+aE3O9XdnIXHzdNG7VxLIyD/UoJelk4O5uQRxE53wUA=;
 b=FOZtn6G+keK5m5REldMCBjc/W3Sn41EIhpzmb7yGbCV7gUjd1Inx6IFOdgmmFZnP2s5FZidY3
 wX1Ydkbf+tYCdmFcwREpMLkq5xeLV7/xVgyYtQytpNB6eqYHvnyS8Eu
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Add the information for the save_uenv command and refactor the
documentation to remove the eMMC information that was wrong.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 doc/board/ti/k3.rst | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 7dfe39c5fa57..e95779e32566 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -594,20 +594,21 @@ Refer (:ref:`U-boot ARMV8 build <k3_rst_include_start_build_steps_uboot>`)
 Saving environment
 ------------------
 
-SAVEENV is disabled by default and for the new flow uses Uenv.txt as the default
-way for saving the environments. This has been done as Uenv.txt is more granular
-then the saveenv command and can be used across various bootmodes too.
+CONFIG_CMD_SAVEENV is disabled by default and for the new flow uses
+uEnv.txt as the default way for saving the environments. This has been done
+as uEnv.txt is more granular then the saveenv command and can be used
+across various bootmodes too.
 
-**Writing to MMC/EMMC**
+**Writing to MMC**
 
 .. prompt:: bash =>
 
-  env export -t $loadaddr <list of variables>
-  fatwrite mmc ${mmcdev} ${loadaddr} ${bootenvfile} ${filesize}
+  setenv save_to_env <variables to be saved in uEnv.txt>
+  run save_uenv
 
-**Reading from MMC/EMMC**
+**Reading from MMC**
 
-By default run envboot will read it from the MMC/EMMC partition ( based on
+By default run envboot will read it from the MMC partition ( based on
 mmcdev) and set the environments.
 
 If manually needs to be done then the environment can be read from the
@@ -615,8 +616,11 @@ filesystem and then imported
 
 .. prompt:: bash =>
 
-  fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
-  env import -t ${loadaddr} ${filesize}
+  run envboot
+
+To read from eMMC, the save_uenv and envboot commands would need to be
+changed to pickup the bootenvfile from eMMC. Mainly the write and read
+commands would change to eMMC.
 
 .. _k3_rst_refer_openocd:
 

-- 
2.43.0

