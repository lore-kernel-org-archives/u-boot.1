Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD7B109C046
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7377E8406D;
	Wed, 25 Mar 2026 17:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fLF2dvxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A2784082; Wed, 25 Mar 2026 17:55:54 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F4283F14
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-46805c4ae5dso4023b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457750; x=1775062550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TCMothyrrc4+m6VCEww4SjWQn5vb6XWEl2OBrcWSjI=;
 b=fLF2dvxlO/xYrB75/T9KBMfqwpY/ijit9AxVQvAlUXFLSAXPxsmrsjxP0AelnkH3kD
 r4JtMDbFJlvb1QDO0YjMTbySMwAVsC5uP0CvysauVBPt/4jEDdSXmCeZEuRkSSDRmAIZ
 qtojAxdiznFAwL5/mTKumlfihSVcXwmB9VhXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457750; x=1775062550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4TCMothyrrc4+m6VCEww4SjWQn5vb6XWEl2OBrcWSjI=;
 b=G6Tf+tvsQvzxjCmwc/LrnsTBsglU5s43BKy0/nA30/PwlyHZ59AqZ7UFiXyUuDUjat
 r64jFev8myNFyJteVNr25BBiOhXDLELVfJlC+bBk5H9437P6t0Ma/bN/5iDMBMNME4XN
 iXlpUT29sHfmZTOHIwB9jn0947gM71/aq2pVsnz7CRMEeBtP2WeYiq/PtWYdCaOyl8Mt
 +JROVaY/8saRPzBdD3M2+gniVmnA6ElLjijuq5KdUbzGUCH5eyZ++rEKUzlXz/Fl970h
 bwgierzwdjaIV2yuouulno6K+sQk1TX7NGhKq5PL9csxRN4hhoX9wsbpz/0ymHSZXmNL
 d+Ug==
X-Gm-Message-State: AOJu0YynE7tNDFY9duZ45eaa18Ho3aUQbQA7lsURmLcLo6QKbfHeadU9
 nhazax1CY2BrYLYjbnHjpQHM7a14DNnQJiWSgowlmbr3+BEaSWUzGGxdDrH0xB+IdzpDWXqKbL4
 R2a5r/w==
X-Gm-Gg: ATEYQzzpHeGSYJnyS3IaCz2mSCteinDaiNEojzP7zPWTUyckV3MeULP+Ke+tNc1zBCt
 v+tYmKocPo+cFtBeIctl5Z+ec2VFPimsVLDGUR58D5js8at6DxolvuriBNt0gtwrlq46dLUmNgO
 nhcIi9aMm72Qfb1jxrRxASuPD7wW5eW6a3ygABPHQ+sR7vp0fZ5ZR10uMpJCksDosfipDMYOMDY
 Bgag6p1nrTCpv9/7VY1T9vADYrYHTKiVdkHFubITJtakrQZNWRud/JkL36q01I3X77rdcp7NxU9
 jLIoAolG9qGENA/pqs430K7evBv6x+NaUjm1+wPXxFKvIU/XPW//m4S3b7hKaIgKIv1ZJ6hGj/c
 Yarn6wQlmXEfvWVjUg3wv0bZjc2vfKz/b/NrAw09+YQ4rKfuHcDkDp+1OJuCZUVfC+/RYACDHEJ
 XaTWcUW5bdBIwxASXLNKEHKo9Rl6QE
X-Received: by 2002:a05:6808:8955:b0:466:fcbb:1673 with SMTP id
 5614622812f47-46a5c5d63c8mr2037568b6e.17.1774457750564; 
 Wed, 25 Mar 2026 09:55:50 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/13] boot: Move decomp_image() into handle_load_op()
Date: Wed, 25 Mar 2026 10:54:19 -0600
Message-ID: <20260325165431.1027591-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
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

Decompress is really part of loading, so simplify the code slightly by
moving decompression out of the top-level fit_image_load() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index a59226d42c5..7efd0f30dc5 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2390,7 +2390,8 @@ static int decomp_image(const void *fit, int noffset, const char *prop_name,
  * handle_load_op() - Handle the load operation
  *
  * Process the load_op and figure out where the image should be loaded, now
- * that it has been located
+ * that it has been located. Decompress and move as necessary to get the image
+ * into the right place - see decomp_image()
  *
  * @fit: FIT to check
  * @noffset: Node offset of the image being loaded
@@ -2402,21 +2403,21 @@ static int decomp_image(const void *fit, int noffset, const char *prop_name,
  * @load_op: Load operation to process
  * @bootstage_id: ID of starting bootstage to use for progress updates
  * @datap: Returns buf
- * @loadp: Returns the address to which the data should be loaded
- * @load_endp: Returns the end address of the data-loading location
+ * @loadp: Returns the address where the data was loaded
+ * @sizep: On entry, the size of the image in bytes. Updated if decompressed
  * Return: 0 if OK, -ve on error
  */
 static int handle_load_op(const void *fit, int noffset, const char *prop_name,
-			  void *buf, ulong size,
-			  enum image_type_t image_type,
+			  void *buf, ulong size, enum image_type_t image_type,
 			  enum fit_load_op load_op, int bootstage_id,
-			  ulong *datap, ulong *loadp, ulong *load_endp)
+			  ulong *datap, ulong *loadp, ulong *sizep)
 {
-	ulong data, load;
+	ulong data, load, load_end;
+	int ret;
 
 	data = map_to_sysmem(buf);
 	load = data;
-	*load_endp = 0;
+	load_end = 0;
 	if (load_op == FIT_LOAD_IGNORED) {
 		log_debug("load_op: not loading\n");
 		/* Don't load */
@@ -2437,9 +2438,9 @@ static int handle_load_op(const void *fit, int noffset, const char *prop_name,
 		image_start = map_to_sysmem(fit);
 		image_end = image_start + fit_get_size(fit);
 
-		*load_endp = load + size;
+		load_end = load + size;
 		if (image_type != IH_TYPE_KERNEL &&
-		    load < image_end && *load_endp > image_start) {
+		    load < image_end && load_end > image_start) {
 			printf("Error: %s overwritten\n", prop_name);
 			return -EXDEV;
 		}
@@ -2449,6 +2450,13 @@ static int handle_load_op(const void *fit, int noffset, const char *prop_name,
 	} else {
 		load = data;	/* No load address specified */
 	}
+
+	ret = decomp_image(fit, noffset, prop_name, buf, image_type,
+			   load_op, bootstage_id, data, &load, sizep,
+			   load_end);
+	if (ret)
+		return ret;
+
 	*datap = data;
 	*loadp = load;
 
@@ -2467,7 +2475,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const char *fit_base_uname_config;
 	const void *fit;
 	void *buf;
-	ulong load, load_end, data, len;
+	ulong load, data, len;
 	uint8_t os_arch;
 	const char *prop_name;
 	int ret;
@@ -2497,13 +2505,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		return ret;
 
 	ret = handle_load_op(fit, noffset, prop_name, buf, len, image_type,
-			     load_op, bootstage_id, &data, &load, &load_end);
-	if (ret)
-		return ret;
-
-	ret = decomp_image(fit, noffset, prop_name, buf, image_type,
-			   load_op, bootstage_id, data, &load, &len,
-			   load_end);
+			     load_op, bootstage_id, &data, &load, &len);
 	if (ret)
 		return ret;
 
-- 
2.43.0

