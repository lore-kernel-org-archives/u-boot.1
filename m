Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBE4109C045
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4D6F83FA7;
	Wed, 25 Mar 2026 17:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QQsUzcrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2359383FB6; Wed, 25 Mar 2026 17:55:44 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25D583FAF
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-466f1c3c627so5325b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457739; x=1775062539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsVAD4+4Y029fRGCZEiSkMOUYbOgsQQ3d5i8iCrRDW4=;
 b=QQsUzcrPTnWdblUBfMxN2KdAmWO6FbgUtoJE89EGZ8vFV8dZ+iFK+9u96xskRkDjdv
 BQ71vurOyi5GWI4IawaBIJ21kn7ZnXoygX0s0v0GHeHlwYeubqBa/ufMuYvuB37KLqw1
 9cfFjQxSL0egZa+nCQEqx3WpoMGIivASjr4zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457739; x=1775062539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DsVAD4+4Y029fRGCZEiSkMOUYbOgsQQ3d5i8iCrRDW4=;
 b=KSCJI/eP/1sIYgv7Q+NmAjDpRFN0UN4wAiorFvRgV1wKHzfzEbxo441xIIptzP4fhB
 W8Xjn/WHUYC+rHjpCQk2bh6+Ow52/pZVqQJ0vFh6xKHAaCFzraJ6JecyiE0DYkmGIBV3
 snu5bEEI1iU9IX3iyfAEBemwQSZHrKLA+LugAB72Y9NbVQcI8uJMvr4JNrnfGplQAGC5
 4wi+F+D9PL0ZXOR9WYjDPoCUZNjaF636QXePHZiy9G4M6aq0v21icrfcPjanflAdh8Yn
 jLvu/ftcQT8bdnKuGYy6SfIZlgrcyvaL8XOkKLbmol56gOG58J6csbMju2zIl99TY2dx
 QTMg==
X-Gm-Message-State: AOJu0Yyj7wsuY9N82Qfod2fP7txwLaondqXgDuaf5TDYJpf0fQ36LcEM
 eyqJ5ZVnI0h6Bx22lZn+XbjSlkvfXdTDNc9wZ29+rJFdgyqyLUyz4fdzKMpCgwfJPR6JvlT+cmc
 8jrDZMQ==
X-Gm-Gg: ATEYQzzmPYXplNkWRieGgG5eidmtv2tmmHrZaTyjDf1jLEVrDXmQfq+cp74qUhH62PB
 LO/s5pGVVXL0bjcdMuUe5kdWLbDrGUmEFfP8tttzcR1FAiBpi47plwMrMcTiuMdjwS8xVT/UbQJ
 AW6k7SJmMQKIWRGJvfXggvod89kIQcLd7kEfVhW++EsClYIAoOAhbKIYTDeXwzDJyOHae5b6cxD
 QRzQsl4M0wPnRP2RIs1Bz1KHYpEFoWzaHTsYGmw3JAqqgNfnlUL7W7HNLMavxzznnoxDBqiGK92
 RV+EwtbtVMxyMkOR3Chdla8kCAbgEyHVCLJKxQPAOvFYgUCrY3kc1Udh/fq9Gqbw+G+4SBNlpav
 N2Mg0n0RKwFik9YeQeSrjFi6J7AJEHzk95a0pnhVSLGJ7OFbFUYsj91Ctdb+rzODvWmvA0sFiTD
 EXZxIeEOY10nTvD41MLsKms5M/kj9r
X-Received: by 2002:a05:6808:c1b0:b0:467:272e:892 with SMTP id
 5614622812f47-46a5c7f5165mr2049323b6e.57.1774457739493; 
 Wed, 25 Mar 2026 09:55:39 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH 04/13] boot: Move type and OS checking into a new function
Date: Wed, 25 Mar 2026 10:54:13 -0600
Message-ID: <20260325165431.1027591-5-sjg@chromium.org>
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

Move the code which checks whether the image can be loaded into a
separate check_allowed() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 98 ++++++++++++++++++++++++++++++------------------
 include/image.h  |  4 +-
 2 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 5680cc8b496..3a6120e9151 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2177,9 +2177,64 @@ static int select_image(const void *fit, struct bootm_headers *images,
 	return noffset;
 }
 
+/**
+ * check_allowed() - Check if an image is allowed to be loaded
+ *
+ * @fit: FIT to check
+ * @noffset: Node offset of the image being loaded
+ * @image_type: Type of the image
+ * @arch: Expected architecture for the image
+ * @bootstage_id: ID of starting bootstage to use for progress updates
+ * Return: 0 if OK, -EIO if not
+ */
+static int check_allowed(const void *fit, int noffset,
+			 enum image_type_t image_type, enum image_arch_t arch,
+			 int bootstage_id)
+{
+	bool type_ok, os_ok;
+	uint8_t os;
+
+	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL);
+	type_ok = fit_image_check_type(fit, noffset, image_type) ||
+		  fit_image_check_type(fit, noffset, IH_TYPE_FIRMWARE) ||
+		  fit_image_check_type(fit, noffset, IH_TYPE_TEE) ||
+		  fit_image_check_type(fit, noffset, IH_TYPE_TFA_BL31) ||
+		  (image_type == IH_TYPE_KERNEL &&
+		   fit_image_check_type(fit, noffset, IH_TYPE_KERNEL_NOLOAD));
+
+	os_ok = image_type == IH_TYPE_FLATDT ||
+		image_type == IH_TYPE_FPGA ||
+		fit_image_check_os(fit, noffset, IH_OS_LINUX) ||
+		fit_image_check_os(fit, noffset, IH_OS_U_BOOT) ||
+		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
+		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
+		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
+		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
+		fit_image_check_os(fit, noffset, IH_OS_ELF);
+
+	/*
+	 * If either of the checks fail, we should report an error, but
+	 * if the image type is coming from the "loadables" field, we
+	 * don't care what it is
+	 */
+	if ((!type_ok || !os_ok) && image_type != IH_TYPE_LOADABLE) {
+		fit_image_get_os(fit, noffset, &os);
+		printf("No %s %s %s Image\n",
+		       genimg_get_os_name(os),
+		       genimg_get_arch_name(arch),
+		       genimg_get_type_name(image_type));
+		bootstage_error(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL);
+		return -EIO;
+	}
+
+	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL_OK);
+
+	return 0;
+}
+
 int fit_image_load(struct bootm_headers *images, ulong addr,
 		   const char **fit_unamep, const char **fit_uname_configp,
-		   int arch, int ph_type, int bootstage_id,
+		   enum image_arch_t arch, int ph_type, int bootstage_id,
 		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
 {
 	int image_type = image_ph_type(ph_type);
@@ -2191,10 +2246,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	void *buf;
 	void *loadbuf;
 	size_t size;
-	int type_ok, os_ok;
 	ulong load, load_end, data, len;
-	uint8_t os, comp, os_arch;
+	uint8_t comp, os_arch;
 	const char *prop_name;
+	int ret;
 
 	fit = map_sysmem(addr, 0);
 	prop_name = fit_get_image_type_property(ph_type);
@@ -2221,40 +2276,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	fit_image_get_arch(fit, noffset, &os_arch);
 	images_set_arch(images, os_arch);
 
-	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL);
-	type_ok = fit_image_check_type(fit, noffset, image_type) ||
-		  fit_image_check_type(fit, noffset, IH_TYPE_FIRMWARE) ||
-		  fit_image_check_type(fit, noffset, IH_TYPE_TEE) ||
-		  fit_image_check_type(fit, noffset, IH_TYPE_TFA_BL31) ||
-		  (image_type == IH_TYPE_KERNEL &&
-		   fit_image_check_type(fit, noffset, IH_TYPE_KERNEL_NOLOAD));
-
-	os_ok = image_type == IH_TYPE_FLATDT ||
-		image_type == IH_TYPE_FPGA ||
-		fit_image_check_os(fit, noffset, IH_OS_LINUX) ||
-		fit_image_check_os(fit, noffset, IH_OS_U_BOOT) ||
-		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
-		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
-		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
-		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
-		fit_image_check_os(fit, noffset, IH_OS_ELF);
-
-	/*
-	 * If either of the checks fail, we should report an error, but
-	 * if the image type is coming from the "loadables" field, we
-	 * don't care what it is
-	 */
-	if ((!type_ok || !os_ok) && image_type != IH_TYPE_LOADABLE) {
-		fit_image_get_os(fit, noffset, &os);
-		printf("No %s %s %s Image\n",
-		       genimg_get_os_name(os),
-		       genimg_get_arch_name(arch),
-		       genimg_get_type_name(image_type));
-		bootstage_error(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL);
-		return -EIO;
-	}
-
-	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_CHECK_ALL_OK);
+	ret = check_allowed(fit, noffset, image_type, arch, bootstage_id);
+	if (ret)
+		return ret;
 
 	/* get image data address and length */
 	if (fit_image_get_data(fit, noffset, (const void **)&buf, &size)) {
diff --git a/include/image.h b/include/image.h
index 5e11dc92559..726d82deb22 100644
--- a/include/image.h
+++ b/include/image.h
@@ -111,7 +111,7 @@ enum {
  * New IDs *MUST* be appended at the end of the list and *NEVER*
  * inserted for backward compatibility.
  */
-enum {
+enum image_arch_t {
 	IH_ARCH_INVALID		= 0,	/* Invalid CPU	*/
 	IH_ARCH_ALPHA,			/* Alpha	*/
 	IH_ARCH_ARM,			/* ARM		*/
@@ -760,7 +760,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
  */
 int fit_image_load(struct bootm_headers *images, ulong addr,
 		   const char **fit_unamep, const char **fit_uname_configp,
-		   int arch, int image_ph_type, int bootstage_id,
+		   enum image_arch_t arch, int image_ph_type, int bootstage_id,
 		   enum fit_load_op load_op, ulong *datap, ulong *lenp);
 
 /**
-- 
2.43.0

