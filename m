Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DA1D1171A
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 17:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3905283EF1;
	Tue,  2 Dec 2025 18:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="P2AhHUyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76F683EF1; Tue,  2 Dec 2025 18:29:20 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE3B83EE8
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 18:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2720DC15D7B;
 Tue,  2 Dec 2025 17:28:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 610F6606D6;
 Tue,  2 Dec 2025 17:29:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EAB3011919DDB; Tue,  2 Dec 2025 18:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764696556; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=79cXBei7RZcKX+oE9e7ZctfK6ibTODsCpuLkstPMmWk=;
 b=P2AhHUyIAAmq+Zz1dgCLOXJk2JOgz2oS4op1Rq12oiAkgQ+eiia/j+DnQ9WeZ0JbSDoc5D
 +UUuAxdtkMFWHKGvmm9wN1Lr6k4SVloiMSN0PwQyE0y3XNCTeNRn2EBbtxByLI/hKb0szP
 fqFnVRg8GeSYC+6/1TrztOQoJM3a72MmCESTdr/LSB2cXcyI/FrFhVW9BaZid67elj84Na
 h0HgaDOARCDnV+V7f2YM6HVxXbYkgvh8IwD3NuC1aQmfsYmt6gfY2LZ9nUQ1t6J7B+y0Dt
 o75DbXAP6ceMheK1CXmVDaW6y5L7CFuC/wSAo3OrZoiJCSp85gZYbpQzFTr+8Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 02 Dec 2025 18:28:31 +0100
Subject: [PATCH 6/6] tools: mkfwumdata: Remove dependency on fwu_mdata.h header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-feature_fwumdata-v1-6-d55154de4103@bootlin.com>
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
In-Reply-To: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

The dependency on fwu_mdata.h creates unnecessary configuration
requirements. To generate metadata V1, CONFIG_FWU_MDATA_V1 must be
enabled, which in turn requires enabling FWU_MULTI_BANK_UPDATE,
EFI_CAPSULE_ON_DISK, PARTITION_TYPE_GUID, and other unrelated configs.
This is not suitable for a simple standalone tool.

Additionally, even with the "-v 1" option to generate V1 metadata, the
tool will still include the firmware store description if
CONFIG_FWU_MDATA_V1 is not enabled. This structure should only be
present in metadata V2.

Replace the fwu_mdata.h dependency with the new fwumdata header to make
the tool compatible with both V1 and V2 without requiring any defconfig
changes. This also uses the access helper functions from the header to
eliminate code duplication.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 tools/fwumdata_src/mkfwumdata.c | 95 +++++++----------------------------------
 1 file changed, 16 insertions(+), 79 deletions(-)

diff --git a/tools/fwumdata_src/mkfwumdata.c b/tools/fwumdata_src/mkfwumdata.c
index 8b25539fd57..35f281d8aeb 100644
--- a/tools/fwumdata_src/mkfwumdata.c
+++ b/tools/fwumdata_src/mkfwumdata.c
@@ -17,26 +17,7 @@
 #include <u-boot/crc.h>
 #include <uuid/uuid.h>
 
-typedef uint8_t u8;
-typedef int16_t s16;
-typedef uint16_t u16;
-typedef uint32_t u32;
-typedef uint64_t u64;
-
-#undef CONFIG_FWU_NUM_BANKS
-#undef CONFIG_FWU_NUM_IMAGES_PER_BANK
-
-/* This will dynamically allocate the fwu_mdata */
-#define CONFIG_FWU_NUM_BANKS		0
-#define CONFIG_FWU_NUM_IMAGES_PER_BANK	0
-
-/* version 2 supports maximum of 4 banks */
-#define MAX_BANKS_V2			4
-
-#define BANK_INVALID			(u8)0xFF
-#define BANK_ACCEPTED			(u8)0xFC
-
-#include <fwu_mdata.h>
+#include "fwumdata.h"
 
 static const char *opts_short = "b:i:a:p:v:V:gh";
 
@@ -116,6 +97,7 @@ static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks,
 			 sizeof(struct fwu_image_bank_info) * banks) * images;
 	} else {
 		mobj->size = sizeof(struct fwu_mdata) +
+			sizeof(struct fwu_mdata_ext) +
 			sizeof(struct fwu_fw_store_desc) +
 			(sizeof(struct fwu_image_entry) +
 			 sizeof(struct fwu_image_bank_info) * banks) * images;
@@ -146,50 +128,6 @@ alloc_err:
 	return NULL;
 }
 
-static struct fwu_image_entry *
-fwu_get_image(struct fwu_mdata_object *mobj, size_t idx)
-{
-	size_t offset;
-
-	if (mobj->version == 1) {
-		offset = sizeof(struct fwu_mdata) +
-			(sizeof(struct fwu_image_entry) +
-			 sizeof(struct fwu_image_bank_info) * mobj->banks) *
-			idx;
-	} else {
-		offset = sizeof(struct fwu_mdata) +
-			sizeof(struct fwu_fw_store_desc) +
-			(sizeof(struct fwu_image_entry) +
-			 sizeof(struct fwu_image_bank_info) * mobj->banks) *
-			idx;
-	}
-
-	return (struct fwu_image_entry *)((char *)mobj->mdata + offset);
-}
-
-static struct fwu_image_bank_info *
-fwu_get_bank(struct fwu_mdata_object *mobj, size_t img_idx, size_t bnk_idx)
-{
-	size_t offset;
-
-	if (mobj->version == 1) {
-		offset = sizeof(struct fwu_mdata) +
-			(sizeof(struct fwu_image_entry) +
-			 sizeof(struct fwu_image_bank_info) * mobj->banks) *
-			img_idx + sizeof(struct fwu_image_entry) +
-			sizeof(struct fwu_image_bank_info) * bnk_idx;
-	} else {
-		offset = sizeof(struct fwu_mdata) +
-			sizeof(struct fwu_fw_store_desc) +
-			(sizeof(struct fwu_image_entry) +
-			 sizeof(struct fwu_image_bank_info) * mobj->banks) *
-			img_idx + sizeof(struct fwu_image_entry) +
-			sizeof(struct fwu_image_bank_info) * bnk_idx;
-	}
-
-	return (struct fwu_image_bank_info *)((char *)mobj->mdata + offset);
-}
-
 /**
  * convert_uuid_to_guid() - convert UUID to GUID
  * @buf:	UUID binary
@@ -239,11 +177,13 @@ static int
 fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 			  size_t idx, char *uuids)
 {
-	struct fwu_image_entry *image = fwu_get_image(mobj, idx);
 	struct fwu_image_bank_info *bank;
+	struct fwu_image_entry *image;
 	char *p = uuids, *uuid;
 	int i;
 
+	image = fwu_get_image_entry(mobj->mdata, mobj->version,
+				    mobj->banks, idx);
 	if (!image)
 		return -ENOENT;
 
@@ -266,7 +206,8 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 
 	/* Fill bank image-UUID */
 	for (i = 0; i < mobj->banks; i++) {
-		bank = fwu_get_bank(mobj, idx, i);
+		bank = fwu_get_bank_info(mobj->mdata, mobj->version,
+					 mobj->banks, idx, i);
 		if (!bank)
 			return -ENOENT;
 		bank->accepted = 1;
@@ -281,25 +222,21 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 	return 0;
 }
 
-#if defined(CONFIG_FWU_MDATA_V1)
-static void fwu_fill_version_specific_mdata(struct fwu_mdata_object *mobj)
-{
-}
-#else
 static void fwu_fill_version_specific_mdata(struct fwu_mdata_object *mobj)
 {
 	int i;
 	struct fwu_fw_store_desc *fw_desc;
-	struct fwu_mdata *mdata = mobj->mdata;
+	struct fwu_mdata_ext *mdata_ext;
 
-	mdata->metadata_size = mobj->size;
-	mdata->desc_offset = sizeof(struct fwu_mdata);
+	mdata_ext = fwu_get_fw_mdata_ext(mobj->mdata);
+	mdata_ext->metadata_size = mobj->size;
+	mdata_ext->desc_offset = sizeof(struct fwu_mdata);
 
 	for (i = 0; i < MAX_BANKS_V2; i++)
-		mdata->bank_state[i] = i < mobj->banks ?
-			BANK_ACCEPTED : BANK_INVALID;
+		mdata_ext->bank_state[i] = i < mobj->banks ?
+			FWU_BANK_ACCEPTED : FWU_BANK_INVALID;
 
-	fw_desc = (struct fwu_fw_store_desc *)((u8 *)mdata + sizeof(*mdata));
+	fw_desc = fwu_get_fw_desc(mobj->mdata);
 	fw_desc->num_banks = mobj->banks;
 	fw_desc->num_images = mobj->images;
 	fw_desc->img_entry_size = sizeof(struct fwu_image_entry) +
@@ -307,7 +244,6 @@ static void fwu_fill_version_specific_mdata(struct fwu_mdata_object *mobj)
 	fw_desc->bank_info_entry_size =
 		sizeof(struct fwu_image_bank_info);
 }
-#endif /* CONFIG_FWU_MDATA_V1 */
 
 /* Caller must ensure that @uuids[] has @mobj->images entries. */
 static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
@@ -320,7 +256,8 @@ static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
 	mdata->active_index = active_bank;
 	mdata->previous_active_index = previous_bank;
 
-	fwu_fill_version_specific_mdata(mobj);
+	if (mdata->version == 2)
+		fwu_fill_version_specific_mdata(mobj);
 
 	for (i = 0; i < mobj->images; i++) {
 		ret = fwu_parse_fill_image_uuid(mobj, i, uuids[i]);

-- 
2.43.0

