Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28064C5AC80
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42CAB6089D;
	Fri,  7 Aug 2026 01:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFZdul-sXP15; Fri,  7 Aug 2026 01:50:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E47960889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067435;
	bh=kgVUAFbtGurXRTdOXlK23tLkOKjodzhg7VgD5LPcoNE=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XD12fs/+3BkrKarWyiDIzZZip7Qjm4VfgnnsBKTXSrkDfaBQ4CZApidg/M7rtJF+I
	 jyCzzopdrW0L40FZEOwdlHtQiuYBuhzAoCDc5VDNkouBP/G1oaGrmOgv9hIqxdBMdn
	 lKvWRoDhWqd+22Tsv1yKh/0P/P2Fe6o1gP9tkfUssJ4jvrZ7QpywzR+/Wu3z9NkGJT
	 jixmrkqzywFV8k0lIprJjLMnjfosu08qtEmowUzLwtgOo8erUkMF067ytSdlAhdE68
	 XBPViltLr/AIILKi96voMTWUqxQ+TmQi4DftnHTDYoRl0ei3jdHwpjSlt+frGpo+zz
	 Aqq5YuPQJTSbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E47960889;
	Fri,  7 Aug 2026 01:50:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30D002B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1703740874
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id olTbSDEUjptK for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:29:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B506640812
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B506640812
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B506640812
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:29:42 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-51c928bf172so17409591cf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786051781; x=1786656581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kgVUAFbtGurXRTdOXlK23tLkOKjodzhg7VgD5LPcoNE=;
 b=ecr6cRdvKeJH7piVsDYt0Abp61tVG+nsfKURT+7H/z9CkbbPKw/ihMaGqCeJhsEf7e
 N31lRKKL7aVQW7EC8YlvbhnyC66ha7yp9N8i89aomT1EUWCiI4E9NQfiSVnW80uOO8aX
 cfiTspfbOG9ocrqUkq1erwQ862gieEafGTErt10dplJhKRRh3WMNSIr5r2mv2xaGUDmw
 Khw6AAofYISnJ9T+t/6n6s4zTJAwcSPrI8GDXsxiaiZnxqstfc+Gl+egjC7htS2FEQmu
 ViP4UAE/6vPGQIk9oG5Czp/2TmU5HkuQv1oPybpNLWhXTKW2yCCrjkrs4sDrpO9AKyA2
 5Oxw==
X-Gm-Message-State: AOJu0YzBaqFfAVH8WK6W48Cjic5KXDWKn/eqsvsAQL7v9ZLV8FHGN3hx
 1kwnkgybqyVGfs1BpkMGifPTqah7F6imZGfAVcNSmjGQL/aaUyDs3pPZOnqPtiOTch0=
X-Gm-Gg: AR+sD13tn9fV1utnU/pLM4uYNG4PH/2HIJhNijOr95Y0AmTLKKVWeKJ8vvEvd+6x+6L
 HpboI/C911+qTe5EVPjS8j57vfZcElY7NdpPKDniNi+3heppy8Y9U0oZJIBqJR7zun17/PU6euJ
 3t6JcNPvzZS8XST4DWjv3SNRWNHn8TTgM+Satf3me4hrSeh/I1L7ji6tyedlrq8sjMIgtqDv2Oa
 QPnwsQdadw17VZ6n8/z46kPeXTGjgzH5ZznvWpBx9HZnhiuXy2XteyaPKC0oZns9SL80hL5mkoE
 4xJhNR7NcPM9zq49jk23h+gxvgCmPMQP9VGD8ljyrZVFwgWMRkyOUDgNU19IY5XNSk9NvLQfCG5
 Z7/8whg+nVlyBtmC7bW4fMw3fbhvVkjb4D83Xwvr1d4nybCaGdIyvMmgYeWl8WDPX88UjktZHn2
 VRH3/MlVFoIHsAX4YsOF37DME3/pDPpq6GoRT4/mLPEgvORp6J1V+PFIbUcMvOsyX2ggc5nuA2u
 PKiLV5Y1dp2HqauJXXF3CNe7AI=
X-Received: by 2002:a05:622a:4812:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-52ce5fbdf93mr203692751cf.14.1786051781143; 
 Thu, 06 Aug 2026 14:29:41 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c207b4fffcdsm2071466b.46.2026.08.06.14.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:29:39 -0700 (PDT)
Date: Thu, 06 Aug 2026 22:29:19 +0100
Subject: [PATCH v2 1/4] image-fit: Use unsigned types for external data
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-fit-ext-data-hardening-v2-1-b181cac15c29@binarly.io>
References: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
In-Reply-To: <20260806-b4-fit-ext-data-hardening-v2-0-b181cac15c29@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786051774; l=7865;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=gJHW4T7IXWzsBMCPUSDQTmzFkLKj2pMaRqaequFYdv0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBlUD30axecgWYdLKFlVVKMzeMOAmZRfyxV2KG9I0TDBOTmQ3OdTMBZFIUTBPBOcZl/IcrW7lC1
 wcei/gpDklAU=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1786051781; x=1786656581;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kgVUAFbtGurXRTdOXlK23tLkOKjodzhg7VgD5LPcoNE=;
 b=JvBNAGzlBiMus2DKmq4gIeHhjFbpmOQyiMQF24TR5wi2kJxQ3orNuhjeB31CWEmIeE
 VgnvBoc4H/jM/yY9WyuVQ3Om97uwxZ+ka/KsX6OD2ruVkKHGmXupQG/pi5H87azZxIC6
 h10EXue83SdJp+vFIzOENrjkXsEEz0Z7kDayM07YU5bV3mtoZe50O+VuD+GzO6OGGlQm
 HW5WBd8tz46p+Xu7Ls62f6kn3hNK++SEfZBfKeqkLX/6tXn/nr7q3EcX8TlDbgYXg6Pz
 h/80scy1LZD07VjAdwIfmPLtAW+9XymM/+b7CmWW5NudTJ6uCZQBhDUBNpMYCewXiIFq
 JvZQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=JvBNAGzl
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Anton Ivanov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anton Ivanov <anton@binarly.io>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The data-offset, data-position and data-size FIT properties are
stored as 32-bit unsigned values (fdt32_t), but the accessors
fit_image_get_data_offset(), fit_image_get_data_position() and
fit_image_get_data_size() return them through a signed int.

Switch the accessors and their callers to u32. This removes the
special-processing of "negative" values in fit_image_get_data().

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
 boot/image-fit.c               | 29 ++++++++++-------------------
 common/spl/spl_fit.c           |  4 ++--
 common/splash_source.c         |  2 +-
 drivers/fpga/socfpga_arria10.c |  3 ++-
 include/image.h                |  6 +++---
 test/py/tests/test_vboot.py    | 10 +++++-----
 6 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..26e9323da06 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -963,7 +963,7 @@ int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
  *     0, on success
  *     -ENOENT if the property could not be found
  */
-int fit_image_get_data_offset(const void *fit, int noffset, int *data_offset)
+int fit_image_get_data_offset(const void *fit, int noffset, u32 *data_offset)
 {
 	const fdt32_t *val;
 
@@ -988,7 +988,7 @@ int fit_image_get_data_offset(const void *fit, int noffset, int *data_offset)
  *     -ENOENT if the property could not be found
  */
 int fit_image_get_data_position(const void *fit, int noffset,
-				int *data_position)
+				u32 *data_position)
 {
 	const fdt32_t *val;
 
@@ -1012,7 +1012,7 @@ int fit_image_get_data_position(const void *fit, int noffset,
  *     0, on success
  *     -ENOENT if the property could not be found
  */
-int fit_image_get_data_size(const void *fit, int noffset, int *data_size)
+int fit_image_get_data_size(const void *fit, int noffset, u32 *data_size)
 {
 	const fdt32_t *val;
 
@@ -1070,18 +1070,13 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 		       size_t *size)
 {
 	bool external_data = false;
-	int offset;
-	int len;
 	int ret;
 	size_t fdt_total_size_aligned;
+	u32 offset;
+	u32 len;
 	uintptr_t max_offset;
 
 	if (!fit_image_get_data_position(fit, noffset, &offset)) {
-		if (offset < 0) {
-			printf("Invalid external data position: %d\n", offset);
-			return -EINVAL;
-		}
-
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, noffset, &offset)) {
 		/*
@@ -1090,9 +1085,9 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 		 * for the data-offset properties in each image.
 		 */
 		fdt_total_size_aligned = ((fdt_totalsize(fit) + 3) & ~3);
-		/* The resulting offset cannot exceed INT_MAX */
-		if (offset < 0 || fdt_total_size_aligned > INT_MAX - offset) {
-			printf("Invalid external data offset: %d\n", offset);
+		/* The resulting offset cannot exceed UINT32_MAX */
+		if (fdt_total_size_aligned > UINT32_MAX - offset) {
+			printf("Invalid external data offset: %u\n", offset);
 			return -EINVAL;
 		}
 		offset += fdt_total_size_aligned;
@@ -1106,16 +1101,12 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 		max_offset = UINTPTR_MAX - (uintptr_t)fit;
 		/* Check that external data offset is within the addressable range */
 		if (offset > max_offset) {
-			printf("Invalid external data offset: %d\n", offset);
+			printf("Invalid external data offset: %u\n", offset);
 			return -EINVAL;
 		}
 
 		ret = fit_image_get_data_size(fit, noffset, &len);
 		if (!ret) {
-			if (len < 0) {
-				printf("Invalid external data size: %d\n", len);
-				return -EINVAL;
-			}
 			/*
 			 * For non-signed FIT images, we can only check that
 			 * (offset + len) doesn't exceed the addressable range.
@@ -1135,7 +1126,7 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 			    len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset
 #endif
 			) {
-				printf("FIT external data is out of bounds (offset=%d, size=%d)\n",
+				printf("FIT external data is out of bounds (offset=%u, size=%u)\n",
 				       offset, len);
 				return -EINVAL;
 			}
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 18bff7b8d4a..9b16f91cc6f 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -216,9 +216,9 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			   const struct spl_fit_info *ctx, int node,
 			   struct spl_image_info *image_info, ulong max_size)
 {
-	int offset;
+	u32 offset;
+	u32 len;
 	size_t length;
-	int len;
 	ulong size;
 	ulong load_addr;
 	void *load_ptr;
diff --git a/common/splash_source.c b/common/splash_source.c
index e02f9be05e4..a5ed7431b8e 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -351,7 +351,7 @@ static int splash_load_fit(struct splash_location *location, ulong bmp_load_addr
 	const void *internal_splash_data;
 	size_t internal_splash_size;
 	int external_splash_addr;
-	int external_splash_size;
+	u32 external_splash_size;
 	bool is_splash_external = false;
 	struct legacy_img_hdr *img_header;
 	const u32 *fit_header;
diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
index e9822b2bb0e..e397b37adf0 100644
--- a/drivers/fpga/socfpga_arria10.c
+++ b/drivers/fpga/socfpga_arria10.c
@@ -547,7 +547,8 @@ static int first_loading_rbf_to_buffer(struct udevice *dev,
 	u32 *loadable = buffer_p;
 	size_t buffer_size = *buffer_bsize;
 	size_t fit_size;
-	int ret, i, count, confs_noffset, images_noffset, rbf_offset, rbf_size;
+	int ret, i, count, confs_noffset, images_noffset;
+	u32 rbf_offset, rbf_size;
 	const char *fpga_node_name = NULL;
 	const char *uname = NULL;
 
diff --git a/include/image.h b/include/image.h
index 4149ebbcce9..d082dac5035 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1263,10 +1263,10 @@ int fit_image_get_load(const void *fit, int noffset, ulong *load);
 int fit_image_get_entry(const void *fit, int noffset, ulong *entry);
 int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
 			   size_t *size);
-int fit_image_get_data_offset(const void *fit, int noffset, int *data_offset);
+int fit_image_get_data_offset(const void *fit, int noffset, u32 *data_offset);
 int fit_image_get_data_position(const void *fit, int noffset,
-				int *data_position);
-int fit_image_get_data_size(const void *fit, int noffset, int *data_size);
+				u32 *data_position);
+int fit_image_get_data_size(const void *fit, int noffset, u32 *data_size);
 int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size);
 int fit_image_get_data(const void *fit, int noffset, const void **data,
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 4b6707caf70..fd91b3f10a2 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -700,12 +700,12 @@ def test_vboot_ext_data_bounds(ubman):
         fd.write(500 * b'\0')
 
     testcases = [
-        ('negative data-position',
-         {'data-position': 0xffffffff}, 'Invalid external data position'),
-        ('negative data-offset',
+        ('invalid data-position',
+         {'data-position': 0xffffffff}, 'FIT external data is out of bounds'),
+        ('invalid data-offset',
          {'data-offset': 0xffffffff}, 'Invalid external data offset'),
-        ('negative data-size',
-         {'data-size': 0xffffffff}, 'Invalid external data size'),
+        ('invalid data-size',
+         {'data-size': 0xffffffff}, 'FIT external data is out of bounds'),
         ('off-bounds data-position',
          {'data-position': 0x7fffffff}, 'FIT external data is out of bounds'),
         ('off-bounds data-offset',

-- 
2.55.0

