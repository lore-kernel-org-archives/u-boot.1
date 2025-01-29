Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90B4C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC7181FAB;
	Wed, 29 Jan 2025 23:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="itJ3Z0+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249FD81EEF; Wed, 29 Jan 2025 23:37:06 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F8F80C83
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e4db=UW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1738190222; bh=rg8KenFfh653m71UBkTMbTY2ML1aT3VJ51ChxlWbx7E=;
 b=itJ3Z0+1SwIfAxbKsWXUtzq9ZiD6sHrHNuhDG4IhL5OHxDG7bk8FzNc3DfXETjKemZRcKGzXA
 Wf09khii0/GMy8M5rLDlP0i8l47i4aQtd6jglyELKdu2ZhEnZAMnesi1ZegbUzkXSdqyPJ5p3Az
 iqrMHMB/IvOIWff7K6TmWqppd8sXje1q3KZr1ScOQOGUplo6lB551Wp5ecc2cadoNwKRjv3NRep
 4wvWjPsKhleS9ya3oWD0Rwt9K27MHk2FyUgWJ/KrUqlqgWTu4W2muBgCrW779qAfsow8t3Z6kgn
 UIC6CRZpEtAGA9a2CLPDYTtBlyk1MbaHshyAl48+yUeQ==
X-Forward-Email-ID: 679aad8a3590a80aa97f8e38
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/6] rockchip: mkimage: Add option to change image offset
 alignment
Date: Wed, 29 Jan 2025 22:36:30 +0000
Message-ID: <20250129223641.1888833-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129223641.1888833-1-jonas@kwiboo.se>
References: <20250129223641.1888833-1-jonas@kwiboo.se>
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

The vendor boot_merger tool support a ALIGN parameter that is used to
define offset alignment of the embedded images.

Vendor use this for RK3576 to change offset alignment from the common
2 KiB to 4 KiB, presumably it may have something to do with UFS.
Testing with eMMC has shown that using a 512-byte alignment also work.

Add support for overriding offset alignment in case this is needed for
e.g. RK3576 in the future.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 tools/rkcommon.c | 75 +++++++++++++++++++++++++++++++-----------------
 tools/rkcommon.h |  2 --
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 324820717663..542aca931693 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -124,6 +124,7 @@ struct spl_info {
 	const uint32_t spl_size;
 	const bool spl_rc4;
 	const uint32_t header_ver;
+	const uint32_t align;
 };
 
 static struct spl_info spl_infos[] = {
@@ -181,14 +182,19 @@ static struct spl_info *rkcommon_get_spl_info(char *imagename)
 	return NULL;
 }
 
-static int rkcommon_get_aligned_size(struct image_tool_params *params,
-				     const char *fname)
+static bool rkcommon_is_header_v2(struct image_tool_params *params)
 {
-	int size;
+	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
 
-	size = imagetool_get_filesize(params, fname);
-	if (size < 0)
-		return -1;
+	return (info->header_ver == RK_HEADER_V2);
+}
+
+static int rkcommon_get_aligned_size(struct image_tool_params *params, int size)
+{
+	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
+
+	if (info->align)
+		return ROUND(size, info->align * RK_BLK_SIZE);
 
 	/*
 	 * Pad to a 2KB alignment, as required for init/boot size by the ROM
@@ -197,6 +203,27 @@ static int rkcommon_get_aligned_size(struct image_tool_params *params,
 	return ROUND(size, RK_SIZE_ALIGN);
 }
 
+static int rkcommon_get_header_size(struct image_tool_params *params)
+{
+	int header_size = rkcommon_is_header_v2(params) ?
+			  sizeof(struct header0_info_v2) :
+			  sizeof(struct header0_info);
+
+	return rkcommon_get_aligned_size(params, header_size);
+}
+
+static int rkcommon_get_aligned_filesize(struct image_tool_params *params,
+					 const char *fname)
+{
+	int size;
+
+	size = imagetool_get_filesize(params, fname);
+	if (size < 0)
+		return -1;
+
+	return rkcommon_get_aligned_size(params, size);
+}
+
 int rkcommon_check_params(struct image_tool_params *params)
 {
 	int i, size;
@@ -219,14 +246,14 @@ int rkcommon_check_params(struct image_tool_params *params)
 		spl_params.boot_file += 1;
 	}
 
-	size = rkcommon_get_aligned_size(params, spl_params.init_file);
+	size = rkcommon_get_aligned_filesize(params, spl_params.init_file);
 	if (size < 0)
 		return EXIT_FAILURE;
 	spl_params.init_size = size;
 
 	/* Boot file is optional, and only for back-to-bootrom functionality. */
 	if (spl_params.boot_file) {
-		size = rkcommon_get_aligned_size(params, spl_params.boot_file);
+		size = rkcommon_get_aligned_filesize(params, spl_params.boot_file);
 		if (size < 0)
 			return EXIT_FAILURE;
 		spl_params.boot_size = size;
@@ -283,13 +310,6 @@ bool rkcommon_need_rc4_spl(struct image_tool_params *params)
 	return info->spl_rc4;
 }
 
-bool rkcommon_is_header_v2(struct image_tool_params *params)
-{
-	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
-
-	return (info->header_ver == RK_HEADER_V2);
-}
-
 static void do_sha256_hash(uint8_t *buf, uint32_t size, uint8_t *out)
 {
 	sha256_context ctx;
@@ -302,12 +322,13 @@ static void do_sha256_hash(uint8_t *buf, uint32_t size, uint8_t *out)
 static void rkcommon_set_header0(void *buf, struct image_tool_params *params)
 {
 	struct header0_info *hdr = buf;
-	uint32_t init_boot_size;
+	uint32_t init_boot_size, init_offset;
 
-	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
+	init_offset = rkcommon_get_header_size(params) / RK_BLK_SIZE;
+	memset(buf, '\0', init_offset * RK_BLK_SIZE);
 	hdr->magic = cpu_to_le32(RK_MAGIC);
 	hdr->disable_rc4 = cpu_to_le32(!rkcommon_need_rc4_spl(params));
-	hdr->init_offset = cpu_to_le16(RK_INIT_OFFSET);
+	hdr->init_offset = cpu_to_le16(init_offset);
 	hdr->init_size   = cpu_to_le16(spl_params.init_size / RK_BLK_SIZE);
 
 	/*
@@ -335,10 +356,10 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 	uint8_t *image_ptr = NULL;
 	int i;
 
-	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
+	sector_offset = rkcommon_get_header_size(params) / RK_BLK_SIZE;
+	memset(buf, '\0', sector_offset * RK_BLK_SIZE);
 	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
 	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
-	sector_offset = 4;
 	image_size_array[0] = spl_params.init_size;
 	image_size_array[1] = spl_params.boot_size;
 
@@ -364,11 +385,12 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 void rkcommon_set_header(void *buf,  struct stat *sbuf,  int ifd,
 			 struct image_tool_params *params)
 {
-	struct header1_info *hdr = buf + RK_SPL_HDR_START;
-
 	if (rkcommon_is_header_v2(params)) {
 		rkcommon_set_header0_v2(buf, params);
 	} else {
+		int header_size = rkcommon_get_header_size(params);
+		struct header1_info *hdr = buf + header_size;
+
 		rkcommon_set_header0(buf, params);
 
 		/* Set up the SPL name (i.e. copy spl_hdr over) */
@@ -376,12 +398,12 @@ void rkcommon_set_header(void *buf,  struct stat *sbuf,  int ifd,
 			memcpy(&hdr->magic, rkcommon_get_spl_hdr(params), RK_SPL_HDR_SIZE);
 
 		if (rkcommon_need_rc4_spl(params))
-			rkcommon_rc4_encode_spl(buf, RK_SPL_HDR_START,
+			rkcommon_rc4_encode_spl(buf, header_size,
 						spl_params.init_size);
 
 		if (spl_params.boot_file) {
 			if (rkcommon_need_rc4_spl(params))
-				rkcommon_rc4_encode_spl(buf + RK_SPL_HDR_START,
+				rkcommon_rc4_encode_spl(buf + header_size,
 							spl_params.init_size,
 							spl_params.boot_size);
 		}
@@ -606,7 +628,7 @@ int rkcommon_vrec_header(struct image_tool_params *params,
 	 * 4 bytes of these images can safely be overwritten using the
 	 * boot magic.
 	 */
-	tparams->header_size = RK_SPL_HDR_START;
+	tparams->header_size = rkcommon_get_header_size(params);
 
 	/* Allocate, clear and install the header */
 	tparams->hdr = malloc(tparams->header_size);
@@ -624,7 +646,8 @@ int rkcommon_vrec_header(struct image_tool_params *params,
 	params->orig_file_size = tparams->header_size +
 		spl_params.init_size + spl_params.boot_size;
 
-	params->file_size = ROUND(params->orig_file_size, RK_SIZE_ALIGN);
+	params->file_size = rkcommon_get_aligned_size(params,
+						      params->orig_file_size);
 
 	/* Ignoring pad len, since we are using our own copy_image() */
 	return 0;
diff --git a/tools/rkcommon.h b/tools/rkcommon.h
index 5d2770a80f1c..c887a659a953 100644
--- a/tools/rkcommon.h
+++ b/tools/rkcommon.h
@@ -10,9 +10,7 @@
 enum {
 	RK_BLK_SIZE		= 512,
 	RK_SIZE_ALIGN		= 2048,
-	RK_INIT_OFFSET		= 4,
 	RK_MAX_BOOT_SIZE	= 512 << 10,
-	RK_SPL_HDR_START	= RK_INIT_OFFSET * RK_BLK_SIZE,
 	RK_SPL_HDR_SIZE		= 4,
 };
 
-- 
2.48.1

