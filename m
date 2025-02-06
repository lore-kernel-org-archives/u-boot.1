Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0D6C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 15:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68DDD80B9F;
	Thu,  6 Feb 2025 16:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HY+F0XGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E0D80BAA; Thu,  6 Feb 2025 16:48:20 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4A880B9F
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 16:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 516Flc6j2829761
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Feb 2025 09:47:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738856858;
 bh=+th17CoZqfaan8/lO4oWuRJnuBMzYuUIZYBD4BE0BjY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HY+F0XGQ3Xiq6+subNR4q8mpo7kyo9BP2MIHF5QnXpjxi1BMntn2H5nvj+tBdMmci
 e4WlT75PNTs5LfbiL4FzzopqOtaxVA7f9sRUEM4F0lOUe0Ky/Wuz9a0p1oxOwakAvD
 E3AlV6/Ssp7cDjiNVxenxwowue9E1PGqf4v6A5ek=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516Flc35081989;
 Thu, 6 Feb 2025 09:47:38 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Feb 2025 09:47:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Feb 2025 09:47:37 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516FlboB016666;
 Thu, 6 Feb 2025 09:47:37 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Raymond Mao <raymond.mao@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Adriano Cordova <adrianox@gmail.com>, Michal
 Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Viacheslav Bocharov <adeep@lexina.in>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Tom Rini
 <trini@konsulko.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 1/2] efi_firmware: set EFI capsule dfu_alt_info env
 explicitly
Date: Thu, 6 Feb 2025 09:47:18 -0600
Message-ID: <20250206154719.3032322-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206154719.3032322-1-j-humphreys@ti.com>
References: <20250206154719.3032322-1-j-humphreys@ti.com>
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

The current implementation of EFI capsule update uses set_dfu_alt_info() to
set the dfu_alt_info environment variable with the settings it requires.
However, set_dfu_alt_info() is doing this for all DFU operations, even
those unrelated to capsule update.

Thus other uses of DFU, such as DFU boot which sets its own value for the
dfu_alt_info environment variable, will have that setting overwritten with
the capsule update setting. Similarly, any user defined value for the
dfu_alt_info environment variable would get overwritten when any DFU
operation was performed, including simply performing a "dfu 0 list"
command.

The solution is stop using the set_dfu_alt_info() mechanism to set the
dfu_alt_info environment variable and instead explicitly set it to the
capsule update's setting just before performing the capsule update's DFU
operation, and then restore the environment variable back to its original
value.

This patch implements the explicit setting and restoring of the
dfu_alt_info environment variable as part of the EFI capsule update
operation.

The fix is fully implemented in a subsequent patch that removes the capsule
update dfu_alt_info support in set_dfu_alt_info().

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 lib/efi_loader/efi_firmware.c | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 5a754c9cd03..1a1cf3b55e1 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -649,8 +649,10 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 	efi_status_t (*progress)(efi_uintn_t completion),
 	u16 **abort_reason)
 {
+	int ret;
 	efi_status_t status;
 	struct fmp_state state = { 0 };
+	char *orig_dfu_env;
 
 	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
 		  image_size, vendor_code, progress, abort_reason);
@@ -663,7 +665,22 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 	if (status != EFI_SUCCESS)
 		return EFI_EXIT(status);
 
-	if (fit_update(image))
+	orig_dfu_env = strdup(env_get("dfu_alt_info"));
+	if (env_set("dfu_alt_info", update_info.dfu_string)) {
+		log_err("unable to set env variable \"dfu_alt_info\"!\n");
+		free(orig_dfu_env);
+		return EFI_EXIT(EFI_DEVICE_ERROR);
+	}
+
+	ret = fit_update(image);
+
+	if (env_set("dfu_alt_info", orig_dfu_env)) {
+		log_err("unable to set env variable \"dfu_alt_info\"!\n");
+		ret = 1;
+	}
+	free(orig_dfu_env);
+
+	if (ret)
 		return EFI_EXIT(EFI_DEVICE_ERROR);
 
 	efi_firmware_set_fmp_state_var(&state, image_index);
@@ -717,6 +734,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	u8 dfu_alt_num;
 	efi_status_t status;
 	struct fmp_state state = { 0 };
+	char *orig_dfu_env;
 
 	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
 		  image_size, vendor_code, progress, abort_reason);
@@ -747,8 +765,23 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 		}
 	}
 
-	if (dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
-			     NULL, NULL))
+	orig_dfu_env = strdup(env_get("dfu_alt_info"));
+	if (env_set("dfu_alt_info", update_info.dfu_string)) {
+		log_err("unable to set env variable \"dfu_alt_info\"!\n");
+		free(orig_dfu_env);
+		return EFI_EXIT(EFI_DEVICE_ERROR);
+	}
+
+	ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
+			       NULL, NULL);
+
+	if (env_set("dfu_alt_info", orig_dfu_env)) {
+		log_err("unable to set env variable \"dfu_alt_info\"!\n");
+		ret = 1;
+	}
+	free(orig_dfu_env);
+
+	if (ret)
 		return EFI_EXIT(EFI_DEVICE_ERROR);
 
 	efi_firmware_set_fmp_state_var(&state, image_index);
-- 
2.34.1

