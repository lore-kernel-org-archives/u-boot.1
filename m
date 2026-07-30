Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56002C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3305340B7B;
	Thu, 30 Jul 2026 15:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JrdhaErIWH_h; Thu, 30 Jul 2026 15:31:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB2EB40B52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785425481;
	bh=T1JBtVwcPrEx95pbIiYGUU1vj8Pu8xBrpSeO6N5excw=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Uf04dpe6fM1vIN+WKi2uJgE4zguU/IJNa3z/UanfBOI5RlT3CvXpsFZDPlVHjOLFh
	 mJSin+WI8J6+1Y6I6KsMuOBpINmz1+EJhWITqAOlUU/hCQon3X3UT9He4LzUOARfcr
	 qlySTZ7osqfHVUEcPvabT5rsj69Z9FsnY7oDP7kh6GWqo1pEpyezazS9ZrYup7QYWp
	 ujGfmFp6mC7FhiatJuymUCxqlJFIvn+AH5NVcZGgilPxeJtpyQiCOfkzmtuWduW9ba
	 2Pt0kp/fCTtRVObjDerMiQHYUHSH/22rVNZOI/rIY6v6f45s46U0rEeQYXtxk9MJhG
	 AG7hJX5H5TNDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB2EB40B52;
	Thu, 30 Jul 2026 15:31:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C592352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D85580FB5
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3PxPq15oiohv for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:04:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com;
 envelope-from=anton@binarly.io; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 06EBF80F8E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06EBF80F8E
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06EBF80F8E
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:04:12 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-7564b7a9490so595472137.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785423851; x=1786028651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T1JBtVwcPrEx95pbIiYGUU1vj8Pu8xBrpSeO6N5excw=;
 b=ijOyPpXpqhUx42j6456ObA87CvtwXGORX2tJsmVwrnxS0EsqU5ft3xZ4JprptM9gSh
 EOvmnbrO3Z+Xxl7hQEbkTEkgd6ugBwRe+p8ElvhJ9kwQhljqw/83c7V3y4NdiHYBA+b7
 Yio2zAZgsmDN6JP79U5z3/rpsEQe3Zo/d2Gho8hLqdCMQJSEqbuHSEmemhT/hTLlJ++d
 mGZ2kT6ovXLxo/hf0NMuuzLq6kw4+Ti1z/eonsKsfib9Y2oywnc1smM0oG1z0hPD+3Cy
 5Gcu6CGXRXkFD+sObdbNj0k6i720a3aLEcdf4tlA7pxAv6GoKYnsXBlSS5y0GGdlUZAD
 BRpA==
X-Gm-Message-State: AOJu0YzpqEhiYuvODj1NU26AJCJgeDgriGzhBWRRAvm2fKPoHnu5kHs+
 9Q5FDU3lN5HB9D2PRJA4S5f1KYxcLAZe3F1fH4E5XioqzmjyeJnvgXqT4wZiskd0O3A=
X-Gm-Gg: AR+sD139l62aYGtaFLXpK9OvcdnLGqgRlDJnhENIxKAOoTiuR35uk79+URnEnXKYtpJ
 a+YCSTDtXu0w7sydUItIamCOU0q6c1BlM/Moge3KiG2k1LccTZkWuJwMgJHXi6Ewh2353PYXhXa
 5hgBe4EqqSaWdcU2mDOWnjMxL3vZJTOmbQzExj63QCrVqygqm6a2SmzPSvCJ1mvnd2jlWvaaUYi
 Ysdt2s25cf5jml5nHdLxVsoryMto0cP75PApQASJh2qRJeEbFF5hj3SiENYgiAPzHG/vfvdTbhR
 mVeEsJftVgINf+aHjNhHEbnxB5SPsZrjUMFwL8HBjQUuRGKZd1/qdKgcryU4lXB3kQbaPsvEE6D
 7vG/o/Vm+MxjgBdUL9ZhY/v4jPPBgpqE7RLrmVlUctEPiTHwtoiXjC113/qrHSH4HEancLTovHc
 ZTRGTA8stAhEhdoEPft4bKVWFKP1b9Ceatefk5arVNSnSS9ShwyehhD1cvNj36Qy/UlOXcVq9CI
 5idRRqBnDZ7VxYD
X-Received: by 2002:a67:f584:0:b0:738:8b5c:a41a with SMTP id
 ada2fe7eead31-7582b0ed85bmr241161137.18.1785423851372; 
 Thu, 30 Jul 2026 08:04:11 -0700 (PDT)
Received: from Ivanovs-MacBook-Pro.local ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8bbc755sm78846966b.54.2026.07.30.08.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:04:10 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:03:41 +0100
Subject: [PATCH 1/4] image-fit: Use unsigned types for external data properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-fit-ext-data-hardening-v1-1-4a6b91e37b51@binarly.io>
References: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
In-Reply-To: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, 
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1785423847; l=7634;
 i=anton@binarly.io; s=default; h=from:subject:message-id;
 bh=77A21kSXz6ni3/rEmgizHiTVHRGGBfHAL+Z25yVURV0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgLlci93RPwSlisH3PzSX3+CiC/xruz
 nbNSGHIKfmW2YQAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDffFr9X3EWrfYRkwweFXNRAZJqxVHuLR6Y0kSpsmqwGClb/8aM5BplTFIlcwQuI2hf/wgBcgUV
 GvSAHndK9iwU=
X-Developer-Key: i=anton@binarly.io; a=openssh;
 fpr=SHA256:OWnvXkgcqeWMXacIaCJR2oikuTmVTaSodreIHEJTWEc
X-Mailman-Approved-At: Thu, 30 Jul 2026 15:31:18 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1785423851; x=1786028651;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T1JBtVwcPrEx95pbIiYGUU1vj8Pu8xBrpSeO6N5excw=;
 b=Nee2MX/NzOjabgdn/rAmoIlyMP0xhPzSbW+D2pjBbYOpF0+an3dwtT6H0AyG+N+HEV
 vq6TVLxDe3eWeAPEk/YtinNKHgiLX7eSLnfoa13Lse6aquMCXdrrx1iRI+GHKTzlKbyb
 NqzzO7BnVyPy7bPodklhELwf5vve3YMcA4Pic2/+NeRJHDa/Qt4HdtDz069Yw5v+dzAs
 6Xq9tJYYrANiPaSA2cBKUqzQdZiBb0TeSuI0mQ4htdueTMslGe2Ug7gGwMcl8wd5iukb
 gcu80TJYBBaEv3gYHo+XRR2SjRA0/KoZpWvhGF37uWl4VsVv28l3j2upkX6pVv2Fvgxt
 cqKg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=binarly.io
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=binarly.io header.i=@binarly.io header.a=rsa-sha256
 header.s=google header.b=Nee2MX/N
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
 test/py/tests/test_vboot.py    |  6 +-----
 6 files changed, 19 insertions(+), 31 deletions(-)

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
index 4b6707caf70..e1c6b7c9ec3 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -700,12 +700,8 @@ def test_vboot_ext_data_bounds(ubman):
         fd.write(500 * b'\0')
 
     testcases = [
-        ('negative data-position',
-         {'data-position': 0xffffffff}, 'Invalid external data position'),
-        ('negative data-offset',
+        ('invalid data-offset',
          {'data-offset': 0xffffffff}, 'Invalid external data offset'),
-        ('negative data-size',
-         {'data-size': 0xffffffff}, 'Invalid external data size'),
         ('off-bounds data-position',
          {'data-position': 0x7fffffff}, 'FIT external data is out of bounds'),
         ('off-bounds data-offset',

-- 
2.51.0

