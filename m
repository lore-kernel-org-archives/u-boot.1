Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D2606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R2GuO/76
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAF288110C;
	Sat, 31 Oct 2026 11:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgRsqVcKpr2w; Sat, 31 Oct 2026 11:12:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EDC6B81173
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445132;
	b=YUJ+WDJV87Y2v3Jh5rg92VoFeXaRnyK6DvWuzc/Syq/7gHM5PvKMEnSXFcx/vPrfSuCg
	 ScTYs2CK0VbFsgQSAkU3rUh9OP50mKi0qLYYyiKhNA2flsuEmB58RgxRatP7J+z2l5OJh
	 RZb5kxqshPYxzkox9Eap8OXn9oWIWKhKxvdMs76U1etYaaU4oz1D/YJ/XceisVN8IHi/m
	 aTvmBgsA3lwz8nK2fuTU/7cDjQVnBGoSuViCBsQShKRymdyxIuo02kaGN2DRHMs99sItc
	 qIbrVcsaT6mE/XYjSEspUnXsHr9P6vJvrn8pznE503mKXJxvPUoFD2wRbzJFn9ukqMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Liup6pfGP2Zv6ztYfNbGVtJ60eB6+2y6+Hfj22h9FKc=;
	b=YJzIw9RkAPQLd1dhhFzxLhC5CgAQ+hueq3JAuPC3MvLyAE3uOkxSAE7ahZs4LkyA2WUl
	 TWD0AFUKHuzC2LS7Uud1botAevqZ2ZwOp3Ow+ff0h5HU5lF/m4TPZwjnUd+2aBKK23IBE
	 AOXGyASI/ySqKI/AOz9bWEZHd+EVmifs96VWtX4ipOBIPG0n+7BZ95LCiLS8hwIj8pRJI
	 ZC4uix1zDz4uR9TajKmDErbDKZEUAD7YdBesQVb31ZKm9aW8Yk/82sbtiFIWGtbw+3aU6
	 Y93w5hygvV4aU0asuQKYu8RYECkrzsr5sXNCXqV+SV7xl9C+3yQLPYXQ6iTsloJEMHw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445132;
	bh=Liup6pfGP2Zv6ztYfNbGVtJ60eB6+2y6+Hfj22h9FKc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R2GuO/762oL0BWWqTuvZVlR+ssoVwSBfq40vFhU9DYdKZe2bgE3Ewo9iUu9ZAj+FN
	 5wj5BdjKHgcpViattxB7VcSuaKTn9UGDEJm6N10rUbrQy2fKIbWeAcc7bjb+2O4TX2
	 KV/xUqqSnqCuhWRPLDNaxkaARcYGORILFKjbk/+SGv3ijYJUUg8Rkd6sP5xUiU3Go3
	 76fsRvNGZxGLcA+ZgtqpVf8ySVaMXPwvJt3D8mltF0rbNWMrwn1EDDumsfavAJz66e
	 jrmPYobrN8d/9fA0yoii1GRn0of9V+W98BMDJhUpibsvVV8cZlXP7ZvX3tacJxnJEE
	 6O9O9pA3I8rXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDC6B81173;
	Sat, 31 Oct 2026 11:12:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04091473
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0177881173
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UUKRJfNfJ16t for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:12:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 273278110C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445128;
 b=PDINWiOGPv8ldL/yo8g3kd6annNUxM3vbY6PYRCbXIZwyX6ZlMkT8eKXIlUfc/9YLPgP
 B+MtJHRQNIvAURJ1Y2OONoYPRtpeCtQmWlIM5JCbfrl0zcM9SdrrHOlW3fRqOxlApwlZY
 YRk1qwY8qy3rdEJDT+F6Loplw9D1EmOH4yQz1LXlCZhRyRkRc4E5YkNrKGqf/h3oblSpe
 CfNEPkg3rRNebHpFwKoXbqQfeSWyg0xE0aamfUgF8HzDeKjvP9vWWNtJ5/7tKiXXVqMh1
 bfTmXe6LVno6ZaQm8fD0C3zOrdc5tcK8xvoo4J3yJ9yc9JfPmwhqSI03UbS3NVLGmjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445128;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=Liup6pfGP2Zv6ztYfNbGVtJ60eB6+2y6+Hfj22h9FKc=;
 b=gFSDI+Bpv/pJpeafCyQR3DpvjqPd/LKxz5flVb7nXDEkDjhFWZRddiBbsEDlS2mk4sl+
 OkGEMnRGssmmodqp+WI6MI3G7VtoZ/0SYHtGN4NCU3EIGT5+/nf9Atr57lYEeTPG3tjCy
 290kkMpbYgWQ4TAzJsAvWqQZINkznEgfDjv1hYW4RcTWxgSFwyxkzZhBBeDjYCbo2IRMf
 mtEdGT4DtdDuCD9do0kVL8SYl/XuyhTNvZFcArA4Wvh0k+vZxVKlrY66/ScaXMETOmHn8
 Pgh/CaDWuSIjRDtvXDxOQlxUIFfFbUsrd/HgN3TAMJBS80i4n2pL85Clfk4D3MYBNFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 273278110C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:12:08 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6x9-000000003RG-0Kv3;
 Sat, 31 Oct 2026 11:12:04 +0000
Date: Sat, 31 Oct 2026 11:12:02 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 09/11] boot: fit: share the external-data offset calculation
Message-ID: <00255326a5f621e50543045223eda653627bac01.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v2.
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
