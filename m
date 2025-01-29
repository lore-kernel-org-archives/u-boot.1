Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31202C02190
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2C680C6E;
	Wed, 29 Jan 2025 23:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zedhn/ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6363581FE8; Wed, 29 Jan 2025 23:37:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29C580C8F
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e4db=UW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1738190223; bh=IbZgzhvdCKnk/9rY0pUCtbeLNrOCl/oHm0ICMv9QfBE=;
 b=zedhn/hohy9kHDeTz2D4T6ZgXxWM5bjE6LcKKtHWomhlAmeqnZPM8tFAFwwpAWZIsZozOA7qa
 DC203l6epagBxotHn2/BZZH657eyCF6JfdZFK2x4dRLFqZZOOE0kY5FMsX37cUJxCW4l1vGefgv
 Mi8p5gvkMMvs9ngSuZUJFItuJvLn00GOyIZCKf7GYsq0SCi4YZE6Qk0ONYzPGx8rQgohQUsjurS
 0klu2GcfkbO0FatDjhaRAK5Vwk2OCEe35T6Z4lmBV3WfODjD1VjsIhIeLbZ6WYnHe94lDfZrx00
 ZK7JIwMnFBpahigo0o07YLcZIcd7hMf6NH/kCXTg/N/A==
X-Forward-Email-ID: 679aad8d3590a80aa97f8e47
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH 5/6] rockchip: mkimage: Add support for up to 4 input files
Date: Wed, 29 Jan 2025 22:36:31 +0000
Message-ID: <20250129223641.1888833-6-jonas@kwiboo.se>
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

The v2 image format can support up to 4 embedded images that can be
loaded by the BootROM using the back-to-bootrom method.

Currently two input files can be passed in using the datafile parameter,
separated by a colon (":").

Extend the datafile parameter parsing to support up to 4 input files
separated by a colon (":") for use with the v2 image format.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 tools/rkcommon.c | 93 +++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 542aca931693..4ff48e81a636 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -148,17 +148,15 @@ static struct spl_info spl_infos[] = {
 /**
  * struct spl_params - spl params parsed in check_params()
  *
- * @init_file:		Init data file path
- * @init_size:		Aligned size of init data in bytes
- * @boot_file:		Boot data file path
- * @boot_size:		Aligned size of boot data in bytes
+ * @file:	image file path
+ * @size:	aligned size of image in bytes
  */
 
 struct spl_params {
-	char *init_file;
-	uint32_t init_size;
-	char *boot_file;
-	uint32_t boot_size;
+	struct {
+		char *file;
+		uint32_t size;
+	} images[4];
 };
 
 static struct spl_params spl_params = { 0 };
@@ -238,31 +236,32 @@ int rkcommon_check_params(struct image_tool_params *params)
 	if (!rkcommon_get_spl_info(params->imagename))
 		goto err_spl_info;
 
-	spl_params.init_file = params->datafile;
+	spl_params.images[0].file = params->datafile;
+	for (i = 1; i < ARRAY_SIZE(spl_params.images); i++) {
+		spl_params.images[i].file =
+				strchr(spl_params.images[i - 1].file, ':');
+		if (!spl_params.images[i].file)
+			break;
 
-	spl_params.boot_file = strchr(spl_params.init_file, ':');
-	if (spl_params.boot_file) {
-		*spl_params.boot_file = '\0';
-		spl_params.boot_file += 1;
+		*spl_params.images[i].file = '\0';
+		spl_params.images[i].file += 1;
 	}
 
-	size = rkcommon_get_aligned_filesize(params, spl_params.init_file);
-	if (size < 0)
-		return EXIT_FAILURE;
-	spl_params.init_size = size;
+	for (i = 0; i < ARRAY_SIZE(spl_params.images); i++) {
+		if (!spl_params.images[i].file)
+			break;
 
-	/* Boot file is optional, and only for back-to-bootrom functionality. */
-	if (spl_params.boot_file) {
-		size = rkcommon_get_aligned_filesize(params, spl_params.boot_file);
+		size = rkcommon_get_aligned_filesize(params,
+						     spl_params.images[i].file);
 		if (size < 0)
 			return EXIT_FAILURE;
-		spl_params.boot_size = size;
+		spl_params.images[i].size = size;
 	}
 
-	if (spl_params.init_size > rkcommon_get_spl_size(params)) {
+	if (spl_params.images[0].size > rkcommon_get_spl_size(params)) {
 		fprintf(stderr,
 			"Error: SPL image is too large (size %#x than %#x)\n",
-			spl_params.init_size, rkcommon_get_spl_size(params));
+			spl_params.images[0].size, rkcommon_get_spl_size(params));
 		return EXIT_FAILURE;
 	}
 
@@ -329,7 +328,7 @@ static void rkcommon_set_header0(void *buf, struct image_tool_params *params)
 	hdr->magic = cpu_to_le32(RK_MAGIC);
 	hdr->disable_rc4 = cpu_to_le32(!rkcommon_need_rc4_spl(params));
 	hdr->init_offset = cpu_to_le16(init_offset);
-	hdr->init_size   = cpu_to_le16(spl_params.init_size / RK_BLK_SIZE);
+	hdr->init_size = cpu_to_le16(spl_params.images[0].size / RK_BLK_SIZE);
 
 	/*
 	 * init_boot_size needs to be set, as it is read by the BootROM
@@ -339,10 +338,11 @@ static void rkcommon_set_header0(void *buf, struct image_tool_params *params)
 	 * see https://lists.denx.de/pipermail/u-boot/2017-May/293267.html
 	 * for a more detailed explanation by Andy Yan
 	 */
-	if (spl_params.boot_file)
-		init_boot_size = spl_params.init_size + spl_params.boot_size;
+	if (spl_params.images[1].file)
+		init_boot_size = spl_params.images[0].size +
+				 spl_params.images[1].size;
 	else
-		init_boot_size = spl_params.init_size + RK_MAX_BOOT_SIZE;
+		init_boot_size = spl_params.images[0].size + RK_MAX_BOOT_SIZE;
 	hdr->init_boot_size = cpu_to_le16(init_boot_size / RK_BLK_SIZE);
 
 	rc4_encode(buf, RK_BLK_SIZE, rc4_key);
@@ -352,7 +352,6 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 {
 	struct header0_info_v2 *hdr = buf;
 	uint32_t sector_offset, image_sector_count;
-	uint32_t image_size_array[2];
 	uint8_t *image_ptr = NULL;
 	int i;
 
@@ -360,19 +359,17 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 	memset(buf, '\0', sector_offset * RK_BLK_SIZE);
 	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
 	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
-	image_size_array[0] = spl_params.init_size;
-	image_size_array[1] = spl_params.boot_size;
 
-	for (i = 0; i < 2; i++) {
-		if (!image_size_array[i])
+	for (i = 0; i < ARRAY_SIZE(spl_params.images); i++) {
+		if (!spl_params.images[i].size)
 			break;
-		image_sector_count = image_size_array[i] / RK_BLK_SIZE;
+		image_sector_count = spl_params.images[i].size / RK_BLK_SIZE;
 		hdr->images[i].offset = cpu_to_le16(sector_offset);
 		hdr->images[i].size = cpu_to_le16(image_sector_count);
 		hdr->images[i].address = 0xFFFFFFFF;
 		hdr->images[i].counter = cpu_to_le32(i + 1);
 		image_ptr = buf + sector_offset * RK_BLK_SIZE;
-		do_sha256_hash(image_ptr, image_size_array[i],
+		do_sha256_hash(image_ptr, spl_params.images[i].size,
 			       hdr->images[i].hash);
 		sector_offset = sector_offset + image_sector_count;
 	}
@@ -399,13 +396,13 @@ void rkcommon_set_header(void *buf,  struct stat *sbuf,  int ifd,
 
 		if (rkcommon_need_rc4_spl(params))
 			rkcommon_rc4_encode_spl(buf, header_size,
-						spl_params.init_size);
+						spl_params.images[0].size);
 
-		if (spl_params.boot_file) {
+		if (spl_params.images[1].file) {
 			if (rkcommon_need_rc4_spl(params))
 				rkcommon_rc4_encode_spl(buf + header_size,
-							spl_params.init_size,
-							spl_params.boot_size);
+							spl_params.images[0].size,
+							spl_params.images[1].size);
 		}
 	}
 }
@@ -643,8 +640,9 @@ int rkcommon_vrec_header(struct image_tool_params *params,
 	 * We need to store the original file-size (i.e. before padding), as
 	 * imagetool does not set this during its adjustment of file_size.
 	 */
-	params->orig_file_size = tparams->header_size +
-		spl_params.init_size + spl_params.boot_size;
+	params->orig_file_size = tparams->header_size;
+	for (int i = 0; i < ARRAY_SIZE(spl_params.images); i++)
+		params->orig_file_size += spl_params.images[i].size;
 
 	params->file_size = rkcommon_get_aligned_size(params,
 						      params->orig_file_size);
@@ -731,16 +729,13 @@ err_close:
 
 int rockchip_copy_image(int ifd, struct image_tool_params *params)
 {
-	int ret;
-
-	ret = copy_file(params, ifd, spl_params.init_file,
-			spl_params.init_size);
-	if (ret)
-		return ret;
+	int i, ret;
 
-	if (spl_params.boot_file) {
-		ret = copy_file(params, ifd, spl_params.boot_file,
-				spl_params.boot_size);
+	for (i = 0; i < ARRAY_SIZE(spl_params.images); i++) {
+		if (!spl_params.images[i].size)
+			break;
+		ret = copy_file(params, ifd, spl_params.images[i].file,
+				spl_params.images[i].size);
 		if (ret)
 			return ret;
 	}
-- 
2.48.1

