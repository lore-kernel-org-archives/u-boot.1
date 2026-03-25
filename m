Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31769109C047
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094BA83F86;
	Wed, 25 Mar 2026 17:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lfShIvsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B53B183FD3; Wed, 25 Mar 2026 17:55:45 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F57B83FA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46701f2077cso924118b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457741; x=1775062541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z881z5jd2wmbjjcTKjYLqOLeDOI/44P3CyjiizKqpSo=;
 b=lfShIvsOH2CC1/V5bT/AXwDAi8tHlORPywd3aGuLQj3StxWNK9lRq4uPDUv3HaYTvb
 mfLhzFv82M6p1DL741j4b7AElhfBKLMSXgL4+1B52zrSogxEVdduYf4ruWV6QZlAh9T3
 slwUuX0eqGdiSU7E4wemNCKkeFXbrSmANq33g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457741; x=1775062541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z881z5jd2wmbjjcTKjYLqOLeDOI/44P3CyjiizKqpSo=;
 b=nlZSYnLAqwlbMiucnf/MPMGR39RHyMP5VOzjI4x3lVrLYcXuxkwRtGlBVCWrGeoobE
 caiX6xV0pdw18DhT7QqhHyX5ry09YTCEGvOK6WUQdVnhyqau3ddBwshbhb25WaW/yXWl
 PcByk6EDx2GdQeNnhfsSp21t0R8q9+SarG3LhE91GwLqx2x7LGknEpW2EkNwPkxrl/lA
 SeDiIYVruB6+q/kay1Gz48Gp5kAYPAUeWXivonOjj358U6lo13o8n2YmyNhjmiUkYWYo
 DCMBRX1XzvtR4kqR2PK1sx/nPMA7UPvCXwuKCQ2t2rdNW1qicQKfwu5qf+cTP7wGiRed
 4O5Q==
X-Gm-Message-State: AOJu0YxRJFcuboZXwukjWukq2JerXxgYNa87OpdBpb/yHFfwRBxX/QnX
 xrdqQSg6HYA5Rasy3cu+sQNKZPILvFyHqSTFLAhI+9C4JtBW7ObXKGYi4KHCoufWlZMeLoOQLvX
 1jlPFAg==
X-Gm-Gg: ATEYQzxz6LUz9XhKuPgnLTjNEihLAsNbm8q278CCNdn1Xa55QYXM28UEBxeUURLS4zK
 0tG25a4pPWKp0DNSkOOT1Ao49MCPC6xvYBabUnCny6IQ/OVaW7I/PTxBSiNeF8PVOlkO47Rnes/
 X+i4FtRv+q5vI8O0RHPJux3PkdPhtuVdqB0jdqxHjob3nKoRrQo1nQ8A0Gvh7rlG43qYZ7JDXpI
 ce2MgAFwXOOD5VHOLq/BQbWGExnrkwjdhic9DIH4GT7279zBe3Ys7kZMG9Dp1EAx9T0d//layfJ
 nh3g5qtxJ1ay1thaQCS0PyX6n0mx1yN8sWGw1aeVtDYlY/akNlSMBc+LmMrfGxlEt2qlxgRh1cW
 BAnWoXbg/DWVTpQvbxWbQ6iPWtewY0mLoETEad6/BS2dmqFkBXqamAhxc6wNc60wj0asq2fJD0s
 xMgulJqmNuM6+Mk/ugJA==
X-Received: by 2002:a05:6808:1787:b0:467:153a:2d9c with SMTP id
 5614622812f47-46a0cde406fmr4489674b6e.15.1774457741389; 
 Wed, 25 Mar 2026 09:55:41 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/13] boot: Move handling of the load_op into a separate
 function
Date: Wed, 25 Mar 2026 10:54:14 -0600
Message-ID: <20260325165431.1027591-6-sjg@chromium.org>
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

Since fit_image_load() is still too long, move the load-operation
handling into a separate function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 107 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 34 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3a6120e9151..c5067b63682 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2232,6 +2232,75 @@ static int check_allowed(const void *fit, int noffset,
 	return 0;
 }
 
+/**
+ * handle_load_op() - Handle the load operation
+ *
+ * Process the load_op and figure out where the image should be loaded, now
+ * that it has been located
+ *
+ * @fit: FIT to check
+ * @noffset: Node offset of the image being loaded
+ * @prop_name: Property name (in the configuration node) indicating the image
+ * that was loaded
+ * @buf: Pointer to image (within the FIT)
+ * @size: Size of the image in bytes
+ * @image_type: Type of the image
+ * @load_op: Load operation to process
+ * @bootstage_id: ID of starting bootstage to use for progress updates
+ * @datap: Returns buf
+ * @loadp: Returns the address to which the data should be loaded
+ * @load_endp: Returns the end address of the data-loading location
+ * Return: 0 if OK, -ve on error
+ */
+static int handle_load_op(const void *fit, int noffset, const char *prop_name,
+			  void *buf, ulong size,
+			  enum image_type_t image_type,
+			  enum fit_load_op load_op, int bootstage_id,
+			  ulong *datap, ulong *loadp, ulong *load_endp)
+{
+	ulong data, load;
+
+	data = map_to_sysmem(buf);
+	load = data;
+	*load_endp = 0;
+	if (load_op == FIT_LOAD_IGNORED) {
+		log_debug("load_op: not loading\n");
+		/* Don't load */
+	} else if (fit_image_get_load(fit, noffset, &load)) {
+		if (load_op == FIT_LOAD_REQUIRED) {
+			printf("Can't get %s subimage load address!\n",
+			       prop_name);
+			bootstage_error(bootstage_id + BOOTSTAGE_SUB_LOAD);
+			return -EBADF;
+		}
+	} else if (load_op != FIT_LOAD_OPTIONAL_NON_ZERO || load) {
+		ulong image_start, image_end;
+
+		/*
+		 * move image data to the load address,
+		 * make sure we don't overwrite initial image
+		 */
+		image_start = map_to_sysmem(fit);
+		image_end = image_start + fit_get_size(fit);
+
+		*load_endp = load + size;
+		if (image_type != IH_TYPE_KERNEL &&
+		    load < image_end && *load_endp > image_start) {
+			printf("Error: %s overwritten\n", prop_name);
+			return -EXDEV;
+		}
+
+		printf("   Loading %s from 0x%08lx to 0x%08lx\n",
+		       prop_name, data, load);
+	} else {
+		load = data;	/* No load address specified */
+	}
+	*datap = data;
+	*loadp = load;
+
+	return 0;
+}
+
 int fit_image_load(struct bootm_headers *images, ulong addr,
 		   const char **fit_unamep, const char **fit_uname_configp,
 		   enum image_arch_t arch, int ph_type, int bootstage_id,
@@ -2305,40 +2374,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_GET_DATA_OK);
 
-	data = map_to_sysmem(buf);
-	load = data;
-	if (load_op == FIT_LOAD_IGNORED) {
-		log_debug("load_op: not loading\n");
-		/* Don't load */
-	} else if (fit_image_get_load(fit, noffset, &load)) {
-		if (load_op == FIT_LOAD_REQUIRED) {
-			printf("Can't get %s subimage load address!\n",
-			       prop_name);
-			bootstage_error(bootstage_id + BOOTSTAGE_SUB_LOAD);
-			return -EBADF;
-		}
-	} else if (load_op != FIT_LOAD_OPTIONAL_NON_ZERO || load) {
-		ulong image_start, image_end;
-
-		/*
-		 * move image data to the load address,
-		 * make sure we don't overwrite initial image
-		 */
-		image_start = addr;
-		image_end = addr + fit_get_size(fit);
-
-		load_end = load + len;
-		if (image_type != IH_TYPE_KERNEL &&
-		    load < image_end && load_end > image_start) {
-			printf("Error: %s overwritten\n", prop_name);
-			return -EXDEV;
-		}
-
-		printf("   Loading %s from 0x%08lx to 0x%08lx\n",
-		       prop_name, data, load);
-	} else {
-		load = data;	/* No load address specified */
-	}
+	ret = handle_load_op(fit, noffset, prop_name, buf, len, image_type,
+			     load_op, bootstage_id, &data, &load, &load_end);
+	if (ret)
+		return ret;
 
 	comp = IH_COMP_NONE;
 	loadbuf = buf;
-- 
2.43.0

