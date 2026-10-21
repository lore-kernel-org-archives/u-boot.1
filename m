Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008F606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FGujQsJh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 273E5811A1;
	Wed, 21 Oct 2026 14:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GIlE1cwt6keO; Wed, 21 Oct 2026 14:10:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15D8B81192
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591808;
	b=WuIM42pFwBdLYlIlZ/bPz1y9hXGsyMqv44LQqWJE5w1EZ2V/qdCdHUHRUk3q/FyUT5uQ
	 lgpONpCRZ8abpTwjEEKZDYN51UZ9qEE5K51d2rH2NmLd4HGG8QCjwI2pzlMfogHDStqBr
	 HfPwGt2vOaVsk/M3SJEITvf2VHcBqBT3iQb4cGCbatQbQ5gOc3LgUCssYJarNPar0XrN3
	 JHMAx5z6ZIVvtwI7e22SUdQ++s5APyUAOV9QqQh63t69FXmK1wefKh/QNtxFfxQRzsIdq
	 XhdPnAc4pgMpeKzDD5mOQsbgNjIJWy44mPeb2RACPavxpGFbt1ggu6On/asDrpvExnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=seAkeELG2hBEm4arbgofJkjUK/O6T/2AL/RBX7s0HWI=;
	b=IIL+RLESq4P9nhp/jBw8KDrqJNxf+XOMP4n5Jv3kH1felWB5CXr35mO4PpXVPlg5ECNZ
	 IQFb082y1riN49PaKtl+PgTN+Lg0A4+QS7AzgilU1r67QmTF87gkRa9a9VXV4c9ydMOgr
	 INKwoZox4oX3hWrvooJl5hz/SZ+Hb/8nSmojo8dvnAaz7c/7SEdEpvGCQEkD4Wij2v/uJ
	 cWQScnw7Xseaju8Wj7ysRpSrk8EhBD230pzASaGHk4dtQkwwDNH+8IRhAFkdjJ/5sfcI0
	 ogu9jjmG8H1GZm6UBlYjtOKLJAfCAMiMDFz9VyuhzIZvJUf/uXS5ZKjLcVg9prD3+bg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591808;
	bh=seAkeELG2hBEm4arbgofJkjUK/O6T/2AL/RBX7s0HWI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGujQsJhH56ve4AK5dARQ1W2GlTR7kORsHT26Uwq09cm6cg8I/IKBtGzWnjSjjK8K
	 WuIQ9zdrGNtKq1moUf6MhHfIHypwSeYvoiiekxUpIPlbo7Qaw/eCCZuzJygtAQVhbc
	 LmZ450GyeLKPERALmVo5BXN2fJZ6FGM+PixC2uI42Tq9zcPLrGfHOG96Ip0fcddLBI
	 4S6VHffr18qQcRlJkiADNQeNcDAnODhrYuvS+vGWkExsOBp2G16UltMgtivm5l0eiB
	 +Xe+dA358BcZncO6Pr1Xydr5yo7/pPGAtmWf1Hpw9x+OXwmeoL0IVOyV4OTFLk3gzv
	 zCsDabse6iuEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15D8B81192;
	Wed, 21 Oct 2026 14:10:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1D3C1E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7E39408AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FVCvqECTIVJe for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AA2ED4087B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591805;
 b=YJl14Pjap5cy8c1mfV+OsSqJnJWHUtppzfY4fEfzdC7pC9fzrR8Gvc7GYDkCoRFgE7W3
 1BqyYD9njW5Hxe3V1pBKIs2k74G8ta032p3wjzuKMaVycD/B/ufb3TRssj/zzWQV61Ndb
 3mkhwMlg6hyG8QeDguQQnRuextNAe0tgdRjadpN0eiqoHSE6Rdk5aiuk8K5VUEi9/eIZ9
 Xb1MdOeOcVd9sbTAyDgpIw4Kjh679c4y9O6fVPvj1u0LFIZ8fJMoezEG5BGdknHKcfkSc
 gq1xXyCuXotMJzldMt0DP5+aR3S7tPvW7PF40u+3NH11kCJvLFbAL5874RINH5ri8DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591805;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=seAkeELG2hBEm4arbgofJkjUK/O6T/2AL/RBX7s0HWI=;
 b=fr7no6aGYxaYW10aOpRfEERbP4/eDeT5fHgglLLCX8Y0hMl6jWIIcNBfGsz0UOX7CJ9w
 OE/1KTHL/ac1CNp2jXjksfyyNRQxUpOF6xh5bm0kdWX6KAPS9C5UlTiBl5zRbLRvr06+e
 K3PtzN5CEvUOpXsdwu9kB9Ap6kkPhRR8dM9N4DeNFiQ8Xi4LKv1JsH+WPfRD7JcSXVbJv
 En1E1lcTAEPf9/QK59Mvm3toZLWw6k6U6M6+MRAdeylgBP91ZEAjor6I6/r3eksXOvQcl
 Mf4YrBqmwIoEjULi2MHv5pchlF1REZ6h+RdcpQ9QRfgfjTRhDLocdXuK70/YVnG3q9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA2ED4087B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:10:05 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWxs-0000000028O-1l5w;
 Wed, 21 Oct 2026 14:10:02 +0000
Date: Wed, 21 Oct 2026 15:09:59 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 09/11] boot: fit: share the external-data offset calculation
Message-ID: <8ccc9c3794b6314bb4b450eb8291c3cdaf5e36a9.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fit_image_load_storage() repeats the data-position / data-offset /
totalsize-alignment sequence that fit_image_get_data() performs, and
writes the result through an int pointer where the getters expect a u32.
The copy also omits the range check on the sum, so an offset that the
embedded path rejects is accepted here.

Extract fit_image_get_ext_data_offset() and call it from both. The
storage path gains the range check and both agree on one expression for
the alignment. The signed comparison of the offset and size is
meaningless once both are u32, so it is dropped in favour of the shared
range check the helper provides.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 - Rename the helper to fit_image_get_ext_data_offset() to match the
   sibling fit_image_get_*() getters.
 - fit_image_get_data() folds the embedded case into an early return
   on -ENOENT, dropping the external_data local.
 - Note in the message that the signed-value guard in the storage
   path is dead once data_off and data_sz are u32.

 boot/image-fit.c | 166 ++++++++++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 75 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 6ab6c6c7da9..0367331c25d 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1056,6 +1056,47 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 	return 0;
 }
 
+/**
+ * fit_image_get_ext_data_offset - locate a sub-image's external data
+ * @fit: pointer to the FIT format image header
+ * @noffset: component image node offset
+ * @offsetp: holds the data offset from the start of the FIT, on success
+ *
+ * returns:
+ *     0, if the sub-image has external data
+ *     -ENOENT, if its data is embedded in the FIT
+ *     -EINVAL, if the recorded offset is out of range
+ */
+static int fit_image_get_ext_data_offset(const void *fit, int noffset, u32 *offsetp)
+{
+	size_t fdt_total_size_aligned;
+	u32 offset;
+
+	if (!fit_image_get_data_position(fit, noffset, &offset)) {
+		*offsetp = offset;
+
+		return 0;
+	}
+
+	if (fit_image_get_data_offset(fit, noffset, &offset))
+		return -ENOENT;
+
+	/*
+	 * data-offset counts from the end of the FDT, so that is the base for
+	 * every image; the sum has to stay within a u32.
+	 */
+	fdt_total_size_aligned = ALIGN(fdt_totalsize(fit), 4);
+	if (fdt_total_size_aligned > UINT32_MAX - offset) {
+		printf("Invalid external data offset: %u\n", offset);
+
+		return -EINVAL;
+	}
+
+	*offsetp = offset + fdt_total_size_aligned;
+
+	return 0;
+}
+
 /**
  * fit_image_get_data - get data and its size including
  *				 both embedded and external data
@@ -1075,82 +1116,63 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 int fit_image_get_data(const void *fit, int noffset, const void **data,
 		       size_t *size)
 {
-	bool external_data = false;
 	int ret;
-	size_t fdt_total_size_aligned;
 	u32 offset;
 	u32 len;
 	uintptr_t max_offset;
 
-	if (!fit_image_get_data_position(fit, noffset, &offset)) {
-		external_data = true;
-	} else if (!fit_image_get_data_offset(fit, noffset, &offset)) {
-		/*
-		 * For FIT with external data, figure out where
-		 * the external images start. This is the base
-		 * for the data-offset properties in each image.
-		 */
-		fdt_total_size_aligned = ((fdt_totalsize(fit) + 3) & ~3);
-		/* The resulting offset cannot exceed UINT32_MAX */
-		if (fdt_total_size_aligned > UINT32_MAX - offset) {
-			printf("Invalid external data offset: %u\n", offset);
-			return -EINVAL;
-		}
-		offset += fdt_total_size_aligned;
-
-		external_data = true;
-	}
+	ret = fit_image_get_ext_data_offset(fit, noffset, &offset);
+	if (ret == -ENOENT)
+		return fit_image_get_emb_data(fit, noffset, data, size);
+	if (ret)
+		return ret;
 
-	if (external_data) {
-		debug("External Data\n");
+	debug("External Data\n");
 
-		max_offset = UINTPTR_MAX - (uintptr_t)fit;
-		/* Check that external data offset is within the addressable range */
-		if (offset > max_offset) {
-			printf("Invalid external data offset: %u\n", offset);
-			return -EINVAL;
-		}
+	max_offset = UINTPTR_MAX - (uintptr_t)fit;
+	/* Check that external data offset is within the addressable range */
+	if (offset > max_offset) {
+		printf("Invalid external data offset: %u\n", offset);
+		return -EINVAL;
+	}
 
-		ret = fit_image_get_data_size(fit, noffset, &len);
-		if (!ret) {
-			/*
-			 * For non-signed FIT images, we can only check that
-			 * (offset + len) doesn't exceed the addressable range.
-			 * For signed FITs, we can additionally check that
-			 * (offset + len) doesn't exceed the allowed FIT image
-			 * maximum size.
-			 */
-			if (len > max_offset - offset
-			/*
-			 * #if (not a runtime if) is required: FIT_SIGNATURE_MAX_SIZE
-			 * depends on FIT_SIGNATURE, so CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE)
-			 * is undefined when signing is disabled and referencing it
-			 * here would fail to compile.
-			 */
+	ret = fit_image_get_data_size(fit, noffset, &len);
+	if (!ret) {
+		/*
+		 * For non-signed FIT images, we can only check that
+		 * (offset + len) doesn't exceed the addressable range.
+		 * For signed FITs, we can additionally check that
+		 * (offset + len) doesn't exceed the allowed FIT image
+		 * maximum size.
+		 */
+		if (len > max_offset - offset
+		/*
+		 * #if (not a runtime if) is required: FIT_SIGNATURE_MAX_SIZE
+		 * depends on FIT_SIGNATURE, so CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE)
+		 * is undefined when signing is disabled and referencing it
+		 * here would fail to compile.
+		 */
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
-			    || offset > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) ||
-			    len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset
+		    || offset > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) ||
+		    len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset
 #endif
-			) {
-				printf("FIT external data is out of bounds (offset=%u, size=%u)\n",
-				       offset, len);
-				return -EINVAL;
-			}
-			*data = fit + offset;
+		) {
+			printf("FIT external data is out of bounds (offset=%u, size=%u)\n",
+			       offset, len);
+			return -EINVAL;
+		}
+		*data = fit + offset;
 #if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGEMAP)
-			if (images.imagemap) {
-				void *mapped;
+		if (images.imagemap) {
+			void *mapped;
 
-				mapped = imagemap_lookup(images.imagemap,
-							 offset, len);
-				if (mapped)
-					*data = mapped;
-			}
-#endif
-			*size = len;
+			mapped = imagemap_lookup(images.imagemap,
+						 offset, len);
+			if (mapped)
+				*data = mapped;
 		}
-	} else {
-		ret = fit_image_get_emb_data(fit, noffset, data, size);
+#endif
+		*size = len;
 	}
 
 	return ret;
@@ -2185,12 +2207,12 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 				  int noffset, enum fit_load_op load_op,
 				  ulong *datap, ulong *lenp, bool *early)
 {
-	int data_off = 0, data_sz = 0;
-	bool external = false;
+	u32 data_off = 0, data_sz = 0;
 	ulong img_load;
 	u8 img_comp = IH_COMP_NONE;
 	void *mapped;
 	void *dst;
+	int ret;
 
 	if (CONFIG_IS_ENABLED(FIT_VERITY)) {
 		u8 img_type;
@@ -2207,19 +2229,13 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 		}
 	}
 
-	if (!fit_image_get_data_position(fit, noffset, &data_off)) {
-		external = true;
-	} else if (!fit_image_get_data_offset(fit, noffset, &data_off)) {
-		external = true;
-		data_off += ALIGN(fdt_totalsize(fit), 4);
-	}
+	ret = fit_image_get_ext_data_offset(fit, noffset, &data_off);
+	if (ret)
+		return ret == -ENOENT ? 0 : ret;
 
-	if (!external || fit_image_get_data_size(fit, noffset, &data_sz))
+	if (fit_image_get_data_size(fit, noffset, &data_sz))
 		return 0;
 
-	if (data_off < 0 || data_sz < 0)
-		return -EINVAL;
-
 	fit_image_get_comp(fit, noffset, &img_comp);
 
 	if (img_comp == IH_COMP_NONE && load_op != FIT_LOAD_IGNORED &&
-- 
2.56.0
