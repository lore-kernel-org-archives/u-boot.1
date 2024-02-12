Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EADC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8384A87EF6;
	Mon, 12 Feb 2024 08:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4353C87EFB; Mon, 12 Feb 2024 08:48:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4A00687EF4
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5652ADA7;
 Sun, 11 Feb 2024 23:49:04 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 894473F762;
 Sun, 11 Feb 2024 23:48:19 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 13/21] efi_firmware: fwu: get the number of FWU banks at
 runtime
Date: Mon, 12 Feb 2024 13:17:04 +0530
Message-Id: <20240212074712.3657076-14-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With the migration of the FWU metadata to version 2, the number of
banks are now obtained at runtime, instead of the config symbols. Make
use of the API to get the number of banks in the versioning
functions.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1: None

 lib/efi_loader/efi_firmware.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index c742e23268..26d2916ee1 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -207,7 +207,8 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 	u16 varname[13]; /* u"FmpStateXXXX" */
 	efi_status_t ret;
 	efi_uintn_t size, expected_size;
-	uint num_banks = 1;
+	u8 num_banks = 1;
+	u16 __maybe_unused num_images;
 	uint active_index = 0;
 	struct fmp_state *var_state;
 
@@ -229,7 +230,9 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 		if (ret)
 			return;
 
-		num_banks = CONFIG_FWU_NUM_BANKS;
+		ret = fwu_get_banks_images(&num_banks, &num_images);
+		if (ret)
+			return;
 	}
 
 	size = num_banks * sizeof(*var_state);
@@ -379,7 +382,8 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 {
 	u16 varname[13]; /* u"FmpStateXXXX" */
 	efi_status_t ret;
-	uint num_banks = 1;
+	u8 num_banks = 1;
+	u16 __maybe_unused num_images;
 	uint update_bank = 0;
 	efi_uintn_t size;
 	efi_guid_t *image_type_id;
@@ -398,7 +402,9 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
 		if (ret)
 			return EFI_INVALID_PARAMETER;
 
-		num_banks = CONFIG_FWU_NUM_BANKS;
+		ret = fwu_get_banks_images(&num_banks, &num_images);
+		if (ret)
+			return EFI_INVALID_PARAMETER;
 	}
 
 	size = num_banks * sizeof(*var_state);
-- 
2.34.1

