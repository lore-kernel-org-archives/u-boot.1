Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05A5C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 09:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90AD1805D7;
	Tue, 11 Feb 2025 10:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JsxtSxTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C00280B9C; Tue, 11 Feb 2025 10:50:04 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F7C80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 10:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51B9ndx5215451
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 03:49:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739267379;
 bh=EjED/vy8A7SaW2Iv5UmwlwBoJ21VpLlXMrXaLkqyL+c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JsxtSxTMxJhLA48DmhtYpfOQUOk0K1RFZKLtASSBi2GH5ph6JLNqTa7jTcxEJPdKf
 EVoDDtsmReOMNjgpbnB+EebnvpJWvqbW1wHoopU91LdL8VCkXRJLoJe4GXNVqhjvYf
 Pj5KeDh8GZ6LzbYlL//Bqm0yB5UVRwv9E0vS3+lk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51B9nd2G031133
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2025 03:49:39 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 03:49:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 03:49:39 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51B9nVVe106439;
 Tue, 11 Feb 2025 03:49:37 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <mkorpershoek@baylibre.com>, <ddrokosov@salutedevices.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
 <a-dutta@ti.com>
Subject: [RESEND PATCH 2/3] configs: omap5: Enable custom mmc boot to
 distroboot for AM57x
Date: Tue, 11 Feb 2025 15:19:30 +0530
Message-ID: <20250211094931.20817-3-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211094931.20817-1-a-dutta@ti.com>
References: <20250211094931.20817-1-a-dutta@ti.com>
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

From: Sinthu Raja <sinthu.raja@ti.com>

TI AM57x boards use a custom (though family common to TI boards) mechanism
for booting Linux. Add support to enable custom MMC boot as a default
option along with the distroboot approach.

Also, add supporting mmc boot environment variables which shall be used for
custom MMC boot

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 include/configs/ti_omap5_common.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index d315a52f36f..ef97711e644 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -240,16 +240,31 @@
 			"echo WARNING: Could not determine device tree to use; fi; \0"
 
 #define BOOT_TARGET_DEVICES(func) \
+	func(TI_MMC, ti_mmc, na) \
 	func(MMC, mmc, 0) \
 	func(MMC, mmc, 1) \
 	func(PXE, pxe, na) \
 	func(DHCP, dhcp, na)
 
+#define BOOTENV_DEV_TI_MMC(devtypeu, devtypel, instance)	\
+	"bootcmd_ti_mmc= run get_name_kern; run mmcboot\0"
+
+#define BOOTENV_DEV_NAME_TI_MMC(devtyeu, devtypel, instance)            \
+	"ti_mmc "
+
 #include <config_distro_bootcmd.h>
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	DEFAULT_LINUX_BOOT_ENV \
 	DEFAULT_MMC_TI_ARGS \
+	"bootpart=0:2\0" \
+	"bootdir=/boot\0" \
+	"get_name_kern=" \
+	"if test $boot_fit -eq 1; then " \
+		"setenv bootfile fitImage; " \
+	"else " \
+		"setenv bootfile zImage; " \
+	"fi\0" \
 	DEFAULT_FIT_TI_ARGS \
 	"get_fit_config=setenv name_fit_config ${fdtfile}\0" \
 	DEFAULT_COMMON_BOOT_TI_ARGS \
-- 
2.34.1

