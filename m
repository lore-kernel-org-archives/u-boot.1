Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B7EC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 23:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5C584A8F;
	Thu,  9 Jul 2026 01:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFnWIqi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54EC84AB5; Thu,  9 Jul 2026 01:17:21 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B0984A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 01:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-43bfe209e45so974626fac.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783552638; x=1784157438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oEWETU3FPhBXzdeYqqZZKNXjtpfvyhkYf1KWA+A72/k=;
 b=aFnWIqi9KUAxWG9bl8I/ugTqISph+lCK5fCIolismW/dOVQR6wDcgJ+NCb5QdFegtc
 hTtUPHWq0FWnGVhN172R9MYICwGipzB+R7GPhTjVqV7K8ZHos+tI/pqjnsokvpJ60vL2
 rndRnd4RAOUcgZZvulQpwkUBzfBXAmjxXU6GqbM9gbwDa5ReUOLggaUFXpFUWvFYYE72
 mGUhTQEdN5lgKLHFIBh5bBFuebuQlDOGV8nwnznob0asRLXpkGiXwUQrBXzhABFQ3mCP
 VtxJD4uWLXQilamYQKTo61KW8LaqRUpIcN8wtoyQMp997OhDCAGesi+rk0yAigrBuJUC
 HmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783552638; x=1784157438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oEWETU3FPhBXzdeYqqZZKNXjtpfvyhkYf1KWA+A72/k=;
 b=jowvjNPI8Y0o2BjHAzxPvFmJ4TOXd++C7gfOTXQfCvdl/Tt1QXU2M2nxo840gFjX++
 6I6uZUr/Q9GEycSXC/lDNcsqPSLIdDCjHNIdiFTMNPyjCI4e/2r28h7KusKOG6hcB+b7
 WBBlNMLMhQo797vlwShpGsxAhZnnSSxA2r34W9mt6UZwyJ9PBkHvGKxg6e5b8N0+hpTv
 O+a3gRePpKniY3K4+EJei8oY7lgJnI5SM9c0rgKzSWhDfkAmB+a2T+uGdLFzqk5PLgR+
 a9s3K3+JFOodhiApNO9SbbItg6O3/hZR6b+N4zNvCGYlP/bQc7jPbvHfiSE8+YU+QpAx
 VfvQ==
X-Gm-Message-State: AOJu0Yyi3hvi+lRBVQ3pKl5LvfgRNmhRsBMiYWkOIzBy0uJK5MHY78x4
 cOczpgAvYzvvgzvg0DmCv0pF6+AZJ3P2Z6P4shtrTnxyDCKz2Ch3giwMfztITbYqjVTJyA==
X-Gm-Gg: AfdE7cmMIfdJInhX4ehDpg1xT4Oy6X9/jIjjOnwWEiD8eX3BmtxzLLS+ChINpxTUgLJ
 Za66wdfr7Z7hQWnS8HH6G3Zw6xIK3j4Vy3MvSe112GigqwL9RHqCDRHagQrEhshRUk2iwYTYOxh
 f3PogI9kJgmPBwEppTd468hnA+mt3bPa5w84NAElDxUGHaM26yjyZYfk5sj0sYtL5eFEW1JXfLO
 EjR8hSuRvcjBcL9k4G8r3vNMJ9mXf4hXzQkLiBZ0G+dlBQW6XJnyMa/HowuO2Yvh3/zthwdwQEP
 Pt0ttKVG/CX64ARMQRvdyO9R/vnuhWBUrPELS6Ob4GVswDRC9nC3TMAOu8ostyNijZK73mSqZ5W
 1E5mweSBm++TyVaaYuR1dqfyF5eZGNkwLDk53NYWmQy1E/sJXhfADmLES5lijV4U9mFOHw8BwqJ
 6D4jtgn6WdX59wX6a864MaPvlGM9y0Yo51GMrlSqaJ/sTTinDZyW13DNxfxKcd0dg1qXExy0Wuc
 ZtC/fQdKjuahLAVW0qFF4MLWa4qWJil2UuMzkBKMpbtZ8+92hL/ML57KPIeG0aOv+cdYwtFhKdN
 AbD/mU87wA==
X-Received: by 2002:a05:6870:b52a:b0:44c:a987:82f4 with SMTP id
 586e51a60fabf-451637e26c4mr2784484fac.10.1783552637952; 
 Wed, 08 Jul 2026 16:17:17 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4519124d07dsm429514fac.2.2026.07.08.16.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 16:17:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neha Malcom Francis <n-francis@ti.com>, Paresh Bhagat <p-bhagat@ti.com>,
 Bryan Brattlof <bb@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Andrew Davis <afd@ti.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aristo Chen <aristo.chen@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>
Subject: [PATCH] tools: fit: sign all config image references
Date: Wed,  8 Jul 2026 17:17:07 -0600
Message-ID: <20260708231711.2609159-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Target-side configuration verification builds the signed-region list from
every image-reference property in the selected configuration. Host-side
signing still uses either the signature node sign-images property or the
legacy kernel/fdt/script default list.

This lets mkimage generate configuration signatures which U-Boot cannot
verify when the configuration references other image types, such as
firmware, loadables or ramdisk entries. It also lets the host and target
disagree when sign-images names only a subset of the configuration images.

Build the host-side signing list from the configuration properties in the
same way as target-side verification. This makes signed configurations
cover the root node, the configuration node, every referenced image node,
and its hash/cipher subnodes, regardless of image type.

Update the signed-configuration documentation to describe the same rule and
to stop recommending sign-images as a selection mechanism.

Fixes: 2092322b31cc ("boot: Add fit_config_get_hash_list() to build signed node list")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 doc/board/ti/k3.rst                | 10 ++--
 doc/usage/fit/beaglebone_vboot.rst |  5 +-
 doc/usage/fit/sign-configs.rst     |  7 ++-
 doc/usage/fit/signature.rst        | 25 ++++-----
 doc/usage/fit/uefi.rst             |  2 -
 tools/fit_image.c                  | 12 ++---
 tools/image-host.c                 | 82 ++++++++++++------------------
 7 files changed, 63 insertions(+), 80 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 21973d53b15..cc1a7396c3a 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -546,7 +546,6 @@ corresponding configuration node as follows.
             signature-1 {
                     algo = "sha512,rsa4096";
                     key-name-hint = "custMpk";
-                    sign-images = "kernel", "fdt";
             };
     };
     # Optional configurations
@@ -557,14 +556,13 @@ corresponding configuration node as follows.
             signature-1 {
                     algo = "sha512,rsa4096";
                     key-name-hint = "custMpk";
-                    sign-images = "fdt";
             };
     };
 
-Specify all images you need the signature to authenticate as a part of
-sign-images. The key-name-hint needs to be changed if you are using some
-other key other than the TI dummy key that we are using for this example.
-It should be the name of the file containing the keys.
+Signed configurations authenticate all images referenced by the configuration
+node. The key-name-hint needs to be changed if you are using some other key
+other than the TI dummy key that we are using for this example. It should be
+the name of the file containing the keys.
 
 .. note::
 
diff --git a/doc/usage/fit/beaglebone_vboot.rst b/doc/usage/fit/beaglebone_vboot.rst
index b15399441ee..27e80f47eb2 100644
--- a/doc/usage/fit/beaglebone_vboot.rst
+++ b/doc/usage/fit/beaglebone_vboot.rst
@@ -169,7 +169,6 @@ Put this into a file in that directory called sign.its::
                 signature-1 {
                     algo = "sha256,rsa2048";
                     key-name-hint = "dev";
-                    sign-images = "fdt", "kernel";
                 };
             };
         };
@@ -178,7 +177,8 @@ Put this into a file in that directory called sign.its::
 
 The explanation for this is all in the documentation you have already read.
 But briefly it packages a kernel and device tree, and provides a single
-configuration to be signed with a key named 'dev'. The kernel is compressed
+configuration to be signed with a key named 'dev'. The configuration signature
+covers all images referenced by the configuration. The kernel is compressed
 with LZO to make it smaller.
 
 
@@ -407,7 +407,6 @@ First we can check which nodes are actually hashed by the configuration::
     value
     algo
     key-name-hint
-    sign-images
 
     $ fdtget image.fit /configurations/conf-1/signature-1 hashed-nodes
     / /configurations/conf-1 /images/fdt-1 /images/fdt-1/hash /images/kernel /images/kernel/hash-1
diff --git a/doc/usage/fit/sign-configs.rst b/doc/usage/fit/sign-configs.rst
index 6d98d44430c..51a97b1b99f 100644
--- a/doc/usage/fit/sign-configs.rst
+++ b/doc/usage/fit/sign-configs.rst
@@ -45,8 +45,13 @@ Signed configurations
                 signature {
                     algo = "sha256,rsa2048";
                     key-name-hint = "dev";
-                    sign-images = "fdt", "kernel";
                 };
             };
         };
     };
+
+For signed configurations, mkimage signs every image referenced by the
+configuration node, such as ``kernel``, ``fdt``, ``ramdisk``, ``firmware`` and
+``loadables`` entries. No ``sign-images`` property is required. Older FIT
+source files may still include ``sign-images``, but current mkimage and U-Boot
+verification do not use it to limit the signed image list.
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index da08cc75c3a..32d11a9d27a 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -341,25 +341,26 @@ So the above example is adjusted to look like this::
 
 You can see that we have added hashes for all images (since they are no
 longer signed), and a signature to each configuration. In the above example,
-mkimage will sign configurations/conf-1, the kernel and fdt that are
-pointed to by the configuration (/images/kernel-1, /images/kernel-1/hash-1,
-/images/fdt-1, /images/fdt-1/hash-1) and the root structure of the image
-(so that it isn't possible to add or remove root nodes). The signature is
-written into /configurations/conf-1/signature-1/value. It can easily be
-verified later even if the FIT has been signed with other keys in the
-meantime.
+mkimage will sign configurations/conf-1, every image referenced by that
+configuration (kernel, fdt, ramdisk, firmware, loadables, etc.) and the root
+structure of the image (so that it isn't possible to add or remove root
+nodes). The signature is written into
+/configurations/conf-1/signature-1/value. It can easily be verified later
+even if the FIT has been signed with other keys in the meantime.
 
 
 Details
 -------
 The signature node contains a property ('hashed-nodes') which lists all the
-nodes that the signature was made over.  The signer (mkimage) writes this
-property as a record of what was included in the hash.  During verification,
+nodes that the signature was made over. The signer (mkimage) writes this
+property as a record of what was included in the hash. During verification,
 however, U-Boot does not read 'hashed-nodes'. Instead it rebuilds the node
 list from the configuration's own image references (kernel, fdt, ramdisk,
-etc.), since 'hashed-nodes' is not itself covered by the signature. The
-rebuilt list always includes the root node, the configuration node, each
-referenced image node and its hash/cipher subnodes.
+firmware, loadables, etc.), since 'hashed-nodes' is not itself covered by the
+signature. The rebuilt list always includes the root node, the configuration
+node, each referenced image node and its hash/cipher subnodes. Current mkimage
+uses the same rule when signing configurations. The older 'sign-images'
+property is not required and is not used to limit the signed image list.
 
 The image is walked in order and each tag processed as follows:
 
diff --git a/doc/usage/fit/uefi.rst b/doc/usage/fit/uefi.rst
index 3bbacb5cad0..86422bec7b4 100644
--- a/doc/usage/fit/uefi.rst
+++ b/doc/usage/fit/uefi.rst
@@ -55,7 +55,6 @@ relies on the FDT provided by the board emulator.
                 signature-1 {
                     algo = "sha256,rsa2048";
                     key-name-hint = "dev";
-                    sign-images = "kernel", "fdt";
                 };
             };
 
@@ -65,7 +64,6 @@ relies on the FDT provided by the board emulator.
                 signature-1 {
                     algo = "sha256,rsa2048";
                     key-name-hint = "dev";
-                    sign-images = "kernel";
                 };
             };
         };
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 5831b07c090..4153b54e550 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -60,13 +60,11 @@ static int fit_estimate_hash_sig_size(struct image_tool_params *params, const ch
 	 * FDT by fit_image_process_verity().
 	 *
 	 * One could try to be more precise in the estimates by
-	 * looking at the "algo" property and, in the case of
-	 * configuration signatures, the sign-images property. Also,
-	 * when signing an already created FIT image, the hash nodes
-	 * already have properly sized value properties, so one could
-	 * also take pre-existence of "value" properties in hash nodes
-	 * into account. But this rather simple approach should work
-	 * well enough in practice.
+	 * looking at the "algo" property. Also, when signing an already
+	 * created FIT image, the hash nodes already have properly sized value
+	 * properties, so one could also take pre-existence of "value"
+	 * properties in hash nodes into account. But this rather simple
+	 * approach should work well enough in practice.
 	 */
 	for (depth = 0, noffset = fdt_next_node(fdt, 0, &depth);
 	     noffset >= 0 && depth > 0;
diff --git a/tools/image-host.c b/tools/image-host.c
index 8f1e7be4066..6df6ea6df3b 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1162,27 +1162,6 @@ static int strlist_add(struct strlist *list, const char *str)
 	return 0;
 }
 
-static const char *fit_config_get_image_list(const void *fit, int noffset,
-					     int *lenp, int *allow_missingp)
-{
-	static const char default_list[] = FIT_KERNEL_PROP "\0"
-			FIT_FDT_PROP "\0" FIT_SCRIPT_PROP;
-	const char *prop;
-
-	/* If there is an "sign-image" property, use that */
-	prop = fdt_getprop(fit, noffset, "sign-images", lenp);
-	if (prop) {
-		*allow_missingp = 0;
-		return *lenp ? prop : NULL;
-	}
-
-	/* Default image list */
-	*allow_missingp = 1;
-	*lenp = sizeof(default_list);
-
-	return default_list;
-}
-
 /**
  * fit_config_add_hash() - Add a list of nodes to hash for an image
  *
@@ -1272,8 +1251,10 @@ err_path:
 /**
  * fit_config_get_hash_list() - Get the regions to sign
  *
- * This calculates a list of nodes to hash for this particular configuration,
- * returning it as a string list (struct strlist, not a devicetree string list)
+ * This calculates a list of nodes to hash for this particular configuration by
+ * walking the same image-reference properties as target-side verification.
+ * The result is returned as a string list (struct strlist, not a devicetree
+ * string list).
  *
  * @fit:	Pointer to the FIT format image header
  * @conf_noffset: Offset of configuration node to sign (child of
@@ -1286,12 +1267,11 @@ err_path:
 static int fit_config_get_hash_list(const void *fit, int conf_noffset,
 				    int sig_offset, struct strlist *node_inc)
 {
-	int allow_missing;
-	const char *prop, *iname, *end;
 	const char *conf_name, *sig_name;
+	int prop_offset;
 	char name[200];
 	int image_count;
-	int ret, len;
+	int ret;
 
 	conf_name = fit_get_name(fit, conf_noffset, NULL);
 	sig_name = fit_get_name(fit, sig_offset, NULL);
@@ -1306,34 +1286,38 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
 	    strlist_add(node_inc, name))
 		goto err_mem;
 
-	/* Get a list of images that we intend to sign */
-	prop = fit_config_get_image_list(fit, sig_offset, &len,
-					&allow_missing);
-	if (!prop)
-		return 0;
-
-	/* Locate the images */
-	end = prop + len;
+	/* Process each image referenced by the config */
 	image_count = 0;
-	for (iname = prop; iname < end; iname += strlen(iname) + 1) {
-		int image_noffset;
-		int index, max_index;
+	fdt_for_each_property_offset(prop_offset, fit, conf_noffset) {
+		const char *prop_name;
+		int img_count, i;
+
+		fdt_getprop_by_offset(fit, prop_offset, &prop_name, NULL);
+		if (!prop_name)
+			continue;
 
-		max_index = fdt_stringlist_count(fit, conf_noffset, iname);
+		/* Skip properties that are not image references */
+		if (!strcmp(prop_name, FIT_DESC_PROP) ||
+		    !strcmp(prop_name, FIT_COMPAT_PROP) ||
+		    !strcmp(prop_name, FIT_DEFAULT_PROP))
+			continue;
 
-		for (index = 0; index < max_index; index++) {
-			image_noffset = fit_conf_get_prop_node_index(fit, conf_noffset,
-								     iname, index);
+		img_count = fdt_stringlist_count(fit, conf_noffset, prop_name);
+		for (i = 0; i < img_count; i++) {
+			const char *iname;
+			int image_noffset;
 
-			if (image_noffset < 0) {
-				fprintf(stderr,
-					"Failed to find image '%s' in  configuration '%s/%s'\n",
-					iname, conf_name, sig_name);
-				if (allow_missing)
-					continue;
+			iname = fdt_stringlist_get(fit, conf_noffset, prop_name,
+						   i, NULL);
+			if (!iname)
+				continue;
 
-				return -ENOENT;
-			}
+			image_noffset = fit_conf_get_prop_node_index(fit,
+								     conf_noffset,
+								     prop_name,
+								     i);
+			if (image_noffset < 0)
+				continue;
 
 			ret = fit_config_add_hash(fit, image_noffset, node_inc,
 						  conf_name, sig_name, iname);
-- 
2.53.0

