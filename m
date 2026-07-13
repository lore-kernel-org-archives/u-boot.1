Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E806C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D894D84AC2;
	Mon, 13 Jul 2026 12:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="hCjd4Lqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D8284AA6; Mon, 13 Jul 2026 12:03:03 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9166D84AA6
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47640541585so1360960f8f.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783936980; x=1784541780; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wqe19UjFoVa0jdI+1vW/U/fsREi0t0jDwPmVGiFx7D4=;
 b=hCjd4Lqz48bzfBwl+9GcsirmpPNZNs+NfTxhp8jctH5stnoSNCqOVljiujeHlAxIPr
 0f1YAXb+wzyhPQNtQjUkD+zOgxYqdPHTQcalWOmz72cxti0snzjy1iYY+YLOAooIlu2s
 9xh/RoFhJtAUnK8N90olj2sO1hsldHP6c0AShrvSVShcrEqlSmLtTktMuSguDX7kIl3y
 ErH4GkyELpTvwjJpndwgPW+iyfYUAE+wuh4arizwvmaK3PzMuJ4M8HoyJHElQtNEZwuM
 UyqXnjdBgp8iC27oLEYnNkNC/Lsvwit+kXLBMWJ3RB0V/9ISyXad6y/qnTSszXDAbOJ7
 2tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936980; x=1784541780;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wqe19UjFoVa0jdI+1vW/U/fsREi0t0jDwPmVGiFx7D4=;
 b=g8oeO4zerq3iY5vfvltPgr7sKobmz6nm+oMrpVwpr8Ig2ZqPaj0g59uKnP730Zbs3I
 7zo6scULfqHaMxh0q0dag5ooKKpUwWBDyS0I0hSI7IXvxVAI0CAXufwonZ1+ruaMWaxM
 wJXRrl/dU+9yETO9JBsMBFZ0hYkVWsZsb/bHEC/CzwRAOgHzOuh5QHu2B5+5XDnzByaW
 dzAL4I6eQZK/Grv6dQbkiHUh5eLd22p8nNUQYY4xXj5b5Jesl419ikyjmDtjt84YtY8O
 S79r+9EyVLsDfWd9eJ4N2GM0LwsxrslfmQ3ZSCuQmpJqMQUl+2WR7wdbmc7CWlrW6AfU
 FCaQ==
X-Gm-Message-State: AOJu0YzYabSOYyipcAP4SgJzkNXHWZM1bZ+SVt1OPOk49Ysn8t2aAoWp
 EKhWrXWid3emdoBKRUiY7DCEdOuN8hurvH5TSN/JnDOmru1XRTCYYbpvaTP3sNPjpK/kpXNXcF9
 gJn0X
X-Gm-Gg: AfdE7clL7y8JVEa/ajdnjLIcfSt69u+wqbQXTyWL7Gw/XmE1BXiVzBKHiAjD24skwZa
 fk2jDUzlTrsQfATmOgC5TWFIvWInbNX+Yx0nsZJnjG+Poj3vdyjtfjaONPjCaIQGn3mv03uB4Lq
 tz7PoYtMZnOVTIhQlfkEHGtkMq0nNEoBC+ny+1oXY9f8zBbmWWLzI13ygIpZbMQ7EBMO5Ku5Bio
 9oLQIpSBy/Ho+xVGROQmO0WvmzIoetDARTSu21FOT4MP6iHh7OZUEZLsNBxpyfkEvnx/EmBmkyU
 9GVN9IOA+PVBWlHDdTRmVCedbNaKrHD990pLHjUSj7rKUuqsOGhLAldTqXjycXTqrrfznm0gs6l
 jbppprx4q+7G6bni5ocN5povSA8c9wnHbHf2o/y5Ow2F8sp2FBhswaXYLKgc6WXBVXt8/dGCAko
 x0Z2ZXiQLbEdcluzwrjMfrCDL0u69MITj2ixl0YxWcbcxmXZCokrALg9PmSIdF76VG
X-Received: by 2002:a05:6000:1acf:b0:472:c426:2ce9 with SMTP id
 ffacd0b85a97d-47f2dcac21amr9765825f8f.12.1783936979911; 
 Mon, 13 Jul 2026 03:02:59 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29135772f8f.18.2026.07.13.03.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:02:59 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 14:02:46 +0400
Subject: [PATCH 5/7] rockchip: mkimage: Add support for up to 4 input files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3576-boost-v1-5-9d23aa08f674@flipper.net>
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7384; i=alchark@flipper.net;
 h=from:subject:message-id; bh=qZyxAjJR0OP6yz1I5AP++3bJoLdnqVivLlWwSS836OM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFbD9+7cH9oklaD65Pt6kvvbbsaVtlt9o2idPzHuWeU
 6jcb9hzuWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpFtrH8D9Wckarzf0VV2tvP04zCCk/tHNG3ky/Zo4+2+iLQdO/7dBk+KdS8oX
 PWr36Rvflza84ltWKMoVfWt668lEK7wFenU6LXA4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Jonas Karlman <jonas@kwiboo.se>

The v2 image format can support up to 4 embedded images that can be
loaded by the BootROM using the back-to-bootrom method.

Currently two input files can be passed in using the datafile parameter,
separated by a colon (":").

Extend the datafile parameter parsing to support up to 4 input files
separated by a colon (":") for use with the v2 image format.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/rkcommon.c | 93 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index b413cd3f7e49..a52d1f36d772 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -167,17 +167,15 @@ static struct spl_info spl_infos[] = {
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
@@ -257,31 +255,32 @@ int rkcommon_check_params(struct image_tool_params *params)
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
 
@@ -348,7 +347,7 @@ static void rkcommon_set_header0(void *buf, struct image_tool_params *params)
 	hdr->magic = cpu_to_le32(RK_MAGIC);
 	hdr->disable_rc4 = cpu_to_le32(!rkcommon_need_rc4_spl(params));
 	hdr->init_offset = cpu_to_le16(init_offset);
-	hdr->init_size   = cpu_to_le16(spl_params.init_size / RK_BLK_SIZE);
+	hdr->init_size = cpu_to_le16(spl_params.images[0].size / RK_BLK_SIZE);
 
 	/*
 	 * init_boot_size needs to be set, as it is read by the BootROM
@@ -358,10 +357,11 @@ static void rkcommon_set_header0(void *buf, struct image_tool_params *params)
 	 * see https://patch.msgid.link/CANbgqAQ5p-fE4T-Ye9UAMs-nRGU8AP_yxDf+5SbZbP8bxLa0dg@mail.gmail.com/
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
@@ -371,7 +371,6 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
 {
 	struct header0_info_v2 *hdr = buf;
 	uint32_t sector_offset, image_sector_count;
-	uint32_t image_size_array[2];
 	uint8_t *image_ptr = NULL;
 	int i;
 
@@ -379,19 +378,17 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
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
@@ -418,13 +415,13 @@ void rkcommon_set_header(void *buf,  struct stat *sbuf,  int ifd,
 
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
@@ -662,8 +659,9 @@ int rkcommon_vrec_header(struct image_tool_params *params,
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
@@ -750,16 +748,13 @@ err_close:
 
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
2.53.0

