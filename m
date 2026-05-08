Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90991CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D5A84E5C;
	Sat,  9 May 2026 02:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g01fC99C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6880884D1A; Fri,  8 May 2026 23:32:44 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A77884CEF
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 27E293F9C1
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1778275962;
 bh=ZcdxGsH+z5nGD+j7GS29ZPoAxjLJdcvRr+ttuG0s2lY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=g01fC99CjlpT2YcU64hP8qTwyDFmKJjeujBfbw/z97akpDRz9WQlSBBrkDD1gCq7T
 58kjp94pqWabf2r8IiTttcEjwKdBaLFrOnsSi/kJrOuvr7GhdVhBO7AST0cXvQlE/E
 GjzOKpGFlwv5GMC9Mw4jV6sD5ZgoGTnyCOjNyNVC7KApS4REqtkE0npALXo4xqURgx
 5GeJIIhBsjbxRg1TH67FRqtAW3dChnqjjSTogux2zPCCYur8UgRmV40qr1HjhVerNh
 ocPV1269OCSo5PuZwSGzoWlJsDhp8PSomV/wgIMcPHHsQbWDFWldQezJEeihDmR264
 mAN08tYbfci6mLdK4KidLigOmrvdd5j1bJ85B71dXzUD9e0aOX4hnrSPq1W6/7A5Ji
 9SQcpB3cv1lxiGuIKsxvuB1ukW2Gv2EBVy8cOcE/1RSPXxehQq4Os/7UPTzgZuaN3S
 HbOzgQPrkkFjXu9rFuLY48tqBSwnrrw5+rB4y9g7kBTdccVNdsOrkvq+x/eir87NkE
 +oVRZA/qgxJLQFM0GbDINbNMjQNiQj37plQ7U2ATA9nP6/WUFgjKVclxW8FJEJZSRH
 eZcHCaxkJ+GQzg+oQ87NHXx20M29kcgW+RrlhXW52bWSvA5loUmPB8Xg6KTJ/KgqeW
 t1e++um+1+RyYB8n8KNqmXK4=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f756ebd0dso1647648b3a.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 14:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778275960; x=1778880760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZcdxGsH+z5nGD+j7GS29ZPoAxjLJdcvRr+ttuG0s2lY=;
 b=e35T6OAwngrXebhQdAgskNlnEioNULbg+o9CYuZrfkc8+EY2DWfacSHxrLsG8ZSgj1
 nFEzcNsRZ3/mrIkNfsOgEekrusbUG6/V+YcZHX1YwcaWw5cuYYMyIkrIwjlhIezTgqqj
 32Wcslc2DZ2DaA7SL76kflx2HZ/tTljHnnZ5R+hkmzA3bEF1OK6p4veHim365KDak051
 fkR3RgCP+EsxNQsDerRUpdkO5cshYBSzNjAPfU6IMtX6qfywTOrkOPpQMZPHqyu4E3mL
 A5aBTbxbgVQzlr7k4KhaqtdlGadHl/az55R0EE1ohqsBd+qYALpUDfzzl7Cx7tH5NOH1
 CSKw==
X-Gm-Message-State: AOJu0YzUYcm/sspL6mkdZwngCW9C08Q6yGM/RD6g+zCv27QUvOb9BUUa
 LUdPcjVldgU7sMjbqokh2KE6WW182soGkmbMYUofAI/NS34L6N7EVLlY7CI3nFZNHUp5yO/ftrZ
 u84lx4VdoxgHQShUvAHYt4fox9MEeo7ZBOs0dICBzQT6zm14uTHTb0sLzR9vC4G84TxOPy9PzJ/
 p8VLmGvxH6uJg=
X-Gm-Gg: Acq92OGuQ3xkWE9ky1Zo/zSL1CRkB+pF4aqs/bR6p7NRrWaWed4LPx1sI+tOMglK6nv
 VfTaKf1DMgbDXHPtuIO6w9u8s19lSHo+eDfqtR2bSJTbvCcAodZKTYP1Rqvg+84AAr5LudiwiIt
 fLnwVfpUPQcn7rY7aDsyg2+FrmU2gzWyNhJdsBXsloBzgbXgQxLt2HiKI2UrnJ3gL6GkaQxguuY
 o/VdyWae0XRpY7cuIGPUALEk1gldAx7E4VG7Om6DOTW4Ln3/hfEHU5MbFvhceD9lNIJV0b891g7
 rhZ1Z+HxQUmya7s0J6gsfkkCub8YSH3Tjs/0coGr7OBLPd+LCXTg9AWP6ebA/tuN7pTUpgqolNA
 r0Lj5p3rwVXLYJgXmjLVllyGOD1sYRfk5B6bUhfULCzkdxkhc/cSA8p89K0IO4HEu1sX1dNBaXI
 TKmyx3aLlc7c6ZANM=
X-Received: by 2002:a05:6a00:1796:b0:82f:5726:be23 with SMTP id
 d2e1a72fcca58-83cf7755867mr4855259b3a.49.1778275960164; 
 Fri, 08 May 2026 14:32:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:1796:b0:82f:5726:be23 with SMTP id
 d2e1a72fcca58-83cf7755867mr4855245b3a.49.1778275959766; 
 Fri, 08 May 2026 14:32:39 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83962e7e3fcsm16196751b3a.0.2026.05.08.14.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 14:32:39 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v1 3/3] boot/fit: use fdt_for_each_subnode() in image-fit.c
Date: Fri,  8 May 2026 21:32:01 +0000
Message-ID: <20260508213217.3807786-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508213217.3807786-1-aristo.chen@canonical.com>
References: <20260508213217.3807786-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:19 +0200
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

Replace the verbose fdt_next_node() + ndepth pattern with the
fdt_for_each_subnode() macro at all seven sites in boot/image-fit.c
where the loop only ever processes direct children. The macro is
already defined in <linux/libfdt.h> and used in boot/image-fit-sig.c,
so this brings image-fit.c in line with the rest of the FIT code.

The conversions are equivalence-preserving:

  - fit_get_subimage_count(): the depth-1 filter and the macro are
    both restricted to direct children.
  - fit_conf_print(): the parameter is named noffset, so the loop
    now uses sub_noffset to keep the parent reference stable.
  - fit_print_contents(): the count reset that lived inside the for
    initialiser is moved out as an explicit assignment before each
    loop, so the second loop still starts from zero.
  - fit_image_print(): straightforward replacement.
  - fit_all_image_verify(): same shape as the print loops, with the
    count reset moved out as an explicit assignment before the loop.
  - fit_conf_find_compat(): the body's "if (ndepth > 1) continue"
    guard is redundant once the macro is in use, and is dropped.

No behaviour changes outside of these mechanical reductions. Local
ndepth declarations that are no longer referenced are removed.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/image-fit.c | 107 ++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 80 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 5a502e93106..dddc0d97928 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -156,18 +156,10 @@ static void fit_get_debug(const void *fit, int noffset,
 int fit_get_subimage_count(const void *fit, int images_noffset)
 {
 	int noffset;
-	int ndepth;
 	int count = 0;
 
-	/* Process its subnodes, print out component images details */
-	for (ndepth = 0, count = 0,
-		noffset = fdt_next_node(fit, images_noffset, &ndepth);
-	     (noffset >= 0) && (ndepth > 0);
-	     noffset = fdt_next_node(fit, noffset, &ndepth)) {
-		if (ndepth == 1) {
-			count++;
-		}
-	}
+	fdt_for_each_subnode(noffset, fit, images_noffset)
+		count++;
 
 	return count;
 }
@@ -291,7 +283,7 @@ static void fit_conf_print(const void *fit, int noffset, const char *p)
 	const char *uname;
 	int ret;
 	int fdt_index, loadables_index;
-	int ndepth;
+	int sub_noffset;
 
 	/* Mandatory properties */
 	ret = fit_get_desc(fit, noffset, &desc);
@@ -357,14 +349,8 @@ static void fit_conf_print(const void *fit, int noffset, const char *p)
 	}
 
 	/* Process all hash subnodes of the component configuration node */
-	for (ndepth = 0, noffset = fdt_next_node(fit, noffset, &ndepth);
-	     (noffset >= 0) && (ndepth > 0);
-	     noffset = fdt_next_node(fit, noffset, &ndepth)) {
-		if (ndepth == 1) {
-			/* Direct child node of the component configuration node */
-			fit_image_print_verification_data(fit, noffset, p);
-		}
-	}
+	fdt_for_each_subnode(sub_noffset, fit, noffset)
+		fit_image_print_verification_data(fit, sub_noffset, p);
 }
 
 /**
@@ -386,8 +372,7 @@ void fit_print_contents(const void *fit)
 	int images_noffset;
 	int confs_noffset;
 	int noffset;
-	int ndepth;
-	int count = 0;
+	int count;
 	int ret;
 	const char *p;
 	time_t timestamp;
@@ -424,20 +409,12 @@ void fit_print_contents(const void *fit)
 	}
 
 	/* Process its subnodes, print out component images details */
-	for (ndepth = 0, count = 0,
-		noffset = fdt_next_node(fit, images_noffset, &ndepth);
-	     (noffset >= 0) && (ndepth > 0);
-	     noffset = fdt_next_node(fit, noffset, &ndepth)) {
-		if (ndepth == 1) {
-			/*
-			 * Direct child node of the images parent node,
-			 * i.e. component image node.
-			 */
-			printf("%s Image %u (%s)\n", p, count++,
-			       fit_get_name(fit, noffset, NULL));
+	count = 0;
+	fdt_for_each_subnode(noffset, fit, images_noffset) {
+		printf("%s Image %u (%s)\n", p, count++,
+		       fit_get_name(fit, noffset, NULL));
 
-			fit_image_print(fit, noffset, p);
-		}
+		fit_image_print(fit, noffset, p);
 	}
 
 	/* Find configurations parent node offset */
@@ -454,20 +431,12 @@ void fit_print_contents(const void *fit)
 		printf("%s Default Configuration: '%s'\n", p, uname);
 
 	/* Process its subnodes, print out configurations details */
-	for (ndepth = 0, count = 0,
-		noffset = fdt_next_node(fit, confs_noffset, &ndepth);
-	     (noffset >= 0) && (ndepth > 0);
-	     noffset = fdt_next_node(fit, noffset, &ndepth)) {
-		if (ndepth == 1) {
-			/*
-			 * Direct child node of the configurations parent node,
-			 * i.e. configuration node.
-			 */
-			printf("%s Configuration %u (%s)\n", p, count++,
-			       fit_get_name(fit, noffset, NULL));
+	count = 0;
+	fdt_for_each_subnode(noffset, fit, confs_noffset) {
+		printf("%s Configuration %u (%s)\n", p, count++,
+		       fit_get_name(fit, noffset, NULL));
 
-			fit_conf_print(fit, noffset, p);
-		}
+		fit_conf_print(fit, noffset, p);
 	}
 }
 
@@ -494,7 +463,6 @@ void fit_image_print(const void *fit, int image_noffset, const char *p)
 	ulong load, entry;
 	const void *data;
 	int noffset;
-	int ndepth;
 	int ret;
 
 	if (!CONFIG_IS_ENABLED(FIT_PRINT))
@@ -584,14 +552,8 @@ void fit_image_print(const void *fit, int image_noffset, const char *p)
 	}
 
 	/* Process all hash subnodes of the component image node */
-	for (ndepth = 0, noffset = fdt_next_node(fit, image_noffset, &ndepth);
-	     (noffset >= 0) && (ndepth > 0);
-	     noffset = fdt_next_node(fit, noffset, &ndepth)) {
-		if (ndepth == 1) {
-			/* Direct child node of the component image node */
-			fit_image_print_verification_data(fit, noffset, p);
-		}
-	}
+	fdt_for_each_subnode(noffset, fit, image_noffset)
+		fit_image_print_verification_data(fit, noffset, p);
 }
 
 /**
@@ -1477,7 +1439,6 @@ int fit_all_image_verify(const void *fit)
 {
 	int images_noffset;
 	int noffset;
-	int ndepth;
 	int count;
 
 	/* Find images parent node offset */
@@ -1491,23 +1452,15 @@ int fit_all_image_verify(const void *fit)
 	/* Process all image subnodes, check hashes for each */
 	printf("## Checking hash(es) for FIT Image at %08lx ...\n",
 	       (ulong)fit);
-	for (ndepth = 0, count = 0,
-	     noffset = fdt_next_node(fit, images_noffset, &ndepth);
-			(noffset >= 0) && (ndepth > 0);
-			noffset = fdt_next_node(fit, noffset, &ndepth)) {
-		if (ndepth == 1) {
-			/*
-			 * Direct child node of the images parent node,
-			 * i.e. component image node.
-			 */
-			printf("   Hash(es) for Image %u (%s): ", count,
-			       fit_get_name(fit, noffset, NULL));
-			count++;
+	count = 0;
+	fdt_for_each_subnode(noffset, fit, images_noffset) {
+		printf("   Hash(es) for Image %u (%s): ", count,
+		       fit_get_name(fit, noffset, NULL));
+		count++;
 
-			if (!fit_image_verify(fit, noffset))
-				return 0;
-			printf("\n");
-		}
+		if (!fit_image_verify(fit, noffset))
+			return 0;
+		printf("\n");
 	}
 	return 1;
 }
@@ -1734,7 +1687,6 @@ int fit_check_format(const void *fit, ulong size)
 
 int fit_conf_find_compat(const void *fit, const void *fdt)
 {
-	int ndepth = 0;
 	int noffset, confs_noffset, images_noffset;
 	const void *fdt_compat;
 	int fdt_compat_len;
@@ -1757,9 +1709,7 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 	/*
 	 * Loop over the configurations in the FIT image.
 	 */
-	for (noffset = fdt_next_node(fit, confs_noffset, &ndepth);
-			(noffset >= 0) && (ndepth > 0);
-			noffset = fdt_next_node(fit, noffset, &ndepth)) {
+	fdt_for_each_subnode(noffset, fit, confs_noffset) {
 		const void *fdt;
 		const char *kfdt_name;
 		int kfdt_noffset, compat_noffset;
@@ -1768,9 +1718,6 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 		size_t sz;
 		int i;
 
-		if (ndepth > 1)
-			continue;
-
 		/* If there's a compat property in the config node, use that. */
 		if (fdt_getprop(fit, noffset, FIT_COMPAT_PROP, NULL)) {
 			fdt = fit;		  /* search in FIT image */
-- 
2.43.0

