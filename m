Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8448C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C80F84AB3;
	Mon, 13 Jul 2026 12:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="KlaDWfeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B496A84AA8; Mon, 13 Jul 2026 12:03:00 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF5384A78
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4758b2a9e2aso1717308f8f.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783936978; x=1784541778; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nBHSgSOIPRjt1DHVV/lSaGYfi02gEsYas7QSlgJoH50=;
 b=KlaDWfeTStAYLZPEMr0/b6KCMvtcEyGRddd+OB+SDsi2fNll1tk0NQFRTjmMB04Qkf
 Lm+rY7JF/D44PC7uFrqJ2tJEC5EzsYMWwFI7L2EW4S9r+J/1x5qLeY2lj4ep4aQxfxw+
 T42aCor3xD5awcnnsoBNmldBzy2IMOjVeJnSqBPPAQu95nb/2RkQmKZa0kvqR9NCBVKp
 3vv2y2/BDGIvWZ1xlhhE3PEGB87T79Gfq7eV6E0MSTgHxpbpyB4DSktFvhJxxX13QuXm
 hTBK+f/5zIGSCobuH1uassqm9BgPrF7Vq9nuKxNqlsDO7evSpf4MWk+P4OYwbOwpgbux
 i2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936978; x=1784541778;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nBHSgSOIPRjt1DHVV/lSaGYfi02gEsYas7QSlgJoH50=;
 b=I6VsdRw4AErYlHyrNUZ/V6o98SWA1ujVzDZsZb4PzKvtas2MJDkUIbpncaYHzE5Zci
 jgvqXPEkaspUwXj9wPM5jyCybXbS1AaYqx6iImkv+NK91UhA1vcvIRAyesZRUQrQWwQs
 fHuU1GKXH4gNw021d9OZYadpANyk9mNSX38x9iyTnctxvi6ZB3G3tbTg+vlVVQ7iQ+Db
 QESzpMmtv3AikkcR0Zf97RKXxnNlCUJ08dxg7HGXQ05b1xmY5OZXWOcuij0+xVCV1VqD
 vEiIrhrv+/2unG/ku5r4XS59W47j5UkQLDWuke+dtR2eU6/g8RCwT7ALJAF+uBaq2BrU
 Hp7Q==
X-Gm-Message-State: AOJu0YxTXZ5LJ8U0UFJAIOyav0dQnoZj9lgc/FUeptQufh4UQ2iD2b0h
 Wpf5QCEJO/xU99bitUurTA3aGA2VLgtMuXXt3dy3t6gG1VEf1HCrmL/sSjQrCkSTA24=
X-Gm-Gg: AfdE7clx6c0FsAGSIYZobvOFMcioxMcweci7rI07cXdH+FxN942m6dSvDFGK0PWmlQk
 ReUUEpeU5HV5jivqjkoyFbMvhxgkOjY/d4ku/0Ig7wLJi0etSAAw4JnDDMjG8gWpAE+dqEwB5qB
 Qccl/hW0t6QtGvVFTIvn1tHCpZ0mrEe0NkUzAWh507hG9IFbHRBgZ4syrU9po7d6m7GUBbIRF5k
 bVA9G7hbedyz8ycgRVOhI/Pki3GcOaykOQyRYttZa9/BdriF6SfvpU875NlxU/p0T/Jj15Yug3I
 llPlt5KlkNpCJOFhp7orwyWY3ykjO3PEKicszcEyNocQ4+O+aAGaEhmCy/noLpPb3Ue3WysNZ+1
 pePo/8f1MeZ0LiZov2a5N5VRn9rhaqGCCeAAW+PfkAZHb5xL3f8NwDW8x16NESuzzgkSYH1Rwq1
 q1yKPvwNZqyfRtEgyrYZ6f4hPXkyLA4K/bYBaIGJMRbAiIkqeBaGUwuZ502ro600kU
X-Received: by 2002:a05:6000:24c4:b0:47f:2a3a:1801 with SMTP id
 ffacd0b85a97d-47f2dc7d3f3mr10570717f8f.12.1783936977774; 
 Mon, 13 Jul 2026 03:02:57 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29135772f8f.18.2026.07.13.03.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:02:57 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 14:02:45 +0400
Subject: [PATCH 4/7] rockchip: mkimage: Add option to change image offset
 alignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3576-boost-v1-4-9d23aa08f674@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7277; i=alchark@flipper.net;
 h=from:subject:message-id; bh=rFRbIfuBei+rZ4uYoKgfKkTQKIA86GsU3JJ+PdsTTKE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFbD8u+Pe+jOVv2Tk9b7MnaaSfmrE4c4VksIz0mX2zx
 XmnvREo6pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqvfgY/qdaxVx8G8jV0cAhLs3gukjhro/9tEi3rn/umxNk5TwYWxkZDv1nlzp
 858ulb+nxFzwZ9mc2rn1x2eO4WHn1ynNBLxrncwMA
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

The vendor boot_merger tool support a ALIGN parameter that is used to
define offset alignment of the embedded images.

Vendor use this for RK3576 to change offset alignment from the common
2 KiB to 4 KiB, presumably it may have something to do with UFS.
Testing with eMMC has shown that using a 512-byte alignment also work.

Add support for overriding offset alignment in case this is needed for
e.g. RK3576 in the future.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/rkcommon.c | 75 ++++++++++++++++++++++++++++++++++++--------------------
 tools/rkcommon.h |  2 --
 2 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 992c90791ffc..b413cd3f7e49 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -140,6 +140,7 @@ struct spl_info {
 	const uint32_t spl_size;
 	const bool spl_rc4;
 	const uint32_t header_ver;
+	const uint32_t align;
 };
 
 static struct spl_info spl_infos[] = {
@@ -200,14 +201,19 @@ static struct spl_info *rkcommon_get_spl_info(char *imagename)
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
@@ -216,6 +222,27 @@ static int rkcommon_get_aligned_size(struct image_tool_params *params,
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
@@ -238,14 +265,14 @@ int rkcommon_check_params(struct image_tool_params *params)
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
@@ -302,13 +329,6 @@ bool rkcommon_need_rc4_spl(struct image_tool_params *params)
 	return info->spl_rc4;
 }
 
-static bool rkcommon_is_header_v2(struct image_tool_params *params)
-{
-	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
-
-	return (info->header_ver == RK_HEADER_V2);
-}
-
 static void do_sha256_hash(uint8_t *buf, uint32_t size, uint8_t *out)
 {
 	sha256_context ctx;
@@ -321,12 +341,13 @@ static void do_sha256_hash(uint8_t *buf, uint32_t size, uint8_t *out)
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
@@ -354,10 +375,10 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
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
 
@@ -383,11 +404,12 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
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
@@ -395,12 +417,12 @@ void rkcommon_set_header(void *buf,  struct stat *sbuf,  int ifd,
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
@@ -625,7 +647,7 @@ int rkcommon_vrec_header(struct image_tool_params *params,
 	 * 4 bytes of these images can safely be overwritten using the
 	 * boot magic.
 	 */
-	tparams->header_size = RK_SPL_HDR_START;
+	tparams->header_size = rkcommon_get_header_size(params);
 
 	/* Allocate, clear and install the header */
 	tparams->hdr = malloc(tparams->header_size);
@@ -643,7 +665,8 @@ int rkcommon_vrec_header(struct image_tool_params *params,
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
2.53.0

