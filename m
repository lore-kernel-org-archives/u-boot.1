Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D41C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 09:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548D38847C;
	Thu,  9 May 2024 11:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pChCmvbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F7888470; Thu,  9 May 2024 11:53:37 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB39C88480
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4499rVdA067200;
 Thu, 9 May 2024 04:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715248411;
 bh=m8jh6F1eoOGG1rxD88QKo1/PLbAL4lSPzYAyaHgzzAE=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=pChCmvbV5STZisXmUDmGg9adZLuh/+Ipn2qg9EqKMjRgr8TqtWbGxgAkFQ1B/bgrL
 BbH+dEDwK/fq5yjU6NQfl06lFmbsFh2PghTW5DwxHGtpkEjqYmyUIIj9ZJxJ5Q5umZ
 UQZsCgILtMvwJz/LV6506lSjN+fnwMqc8XAelAlk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4499rVc9004460
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 04:53:31 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 04:53:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 04:53:31 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4499rKt3075143;
 Thu, 9 May 2024 04:53:28 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 9 May 2024 15:23:16 +0530
Subject: [PATCH v2 2/6] configs: j721s2_evm_a72_defconfig: Switch to
 bootstd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240509-b4-upstream-j721s2-of-upstream-v2-2-149563cd4901@ti.com>
References: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
In-Reply-To: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715248400; l=1549;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=f2/qa0bsyybOyAvTmDnqWekzN0BWA10EdH6uCfnnyhQ=;
 b=B8dE/DDO7vtpOyNWB360txm1zTOXkn5CKYzkzjSseXGkDLtqWX7Pv14If79x46LlhCfLWFcQo
 m6pQER0gZTgAAupjNQIHmVxsn1j3A8aY0AM47fj5OFNxzrN4PU+5S4A
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

From: Neha Malcom Francis <n-francis@ti.com>

Switch to using bootstd. Note that with this change, we will stop using
distro_bootcmd and instead depend entirely on bootflow method of
starting the system up.

Also config_distro_bootcmd.h header file that is no longer needed in
j721s2_evm.h.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 configs/j721s2_evm_a72_defconfig | 5 +++--
 include/configs/j721s2_evm.h     | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 19cd44b068c0..8b02d07a9f09 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -33,9 +33,10 @@ CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_LOGLEVEL=7
 CONFIG_SPL_MAX_SIZE=0xc0000
 CONFIG_SPL_BOARD_INIT=y
diff --git a/include/configs/j721s2_evm.h b/include/configs/j721s2_evm.h
index 846cfa7531cc..6186ec32b1d8 100644
--- a/include/configs/j721s2_evm.h
+++ b/include/configs/j721s2_evm.h
@@ -10,7 +10,6 @@
 #define __CONFIG_J721S2_EVM_H
 
 #include <linux/sizes.h>
-#include <config_distro_bootcmd.h>
 
 /* SPL Loader Configuration */
 #if defined(CONFIG_TARGET_J721S2_A72_EVM)

-- 
2.43.2

