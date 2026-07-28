Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C906C54F4D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 16:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14440605F0;
	Tue, 28 Jul 2026 16:19:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQnJTdO6I--c; Tue, 28 Jul 2026 16:19:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFEA2608CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785255563;
	bh=zF3TQgmJChOCZG7/uYc75PiSrIMV3OIZ4EiijPqAFnc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fjd6RI3atgmsLLLysjo+1vMDdzCOK2CJbi70SZOat58q2RcVE1XlltRBBsWfZ/D1d
	 UulEPtDBe7W+lNLk4IuJUkoBBKAvXPfW2VRREZtKwwp/rivchn7x290OOHYoWh81K+
	 aD+qWnClaHrfkF+w2e+fkMBfc5aPWSFNcg1GwwCMPXi2yzZPXp0rbSEEkbFqVrvCWA
	 LqaJZ/SxO1VPNgtDeRR3ePsUbIwujx4Cp5yxDWbkukAUhR093nvjcryOEkyjh+BeTG
	 F8v2mgUxC8M9t8/+E0jji1MCZoS7CHtGLLLGeuWM/Au2WQ2hZml6QHjzASqPQASedh
	 NPmtbsExL+rKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFEA2608CB;
	Tue, 28 Jul 2026 16:19:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EE524BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 309A040367
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7-drpjTE_V0 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 16:19:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF3934033A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF3934033A
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF3934033A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 16:19:20 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4a4836dc117so738171b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255559; x=1785860359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zF3TQgmJChOCZG7/uYc75PiSrIMV3OIZ4EiijPqAFnc=;
 b=L9zvIA8GJfclnZgkvpsBBpVU5MSA3CIs/s/ufXX75Yl3EdnutulmwKbEzU95CZGB8y
 UMixxJsB2wVdc9bNY9uGLgkS0XylGm97Jf1cE6NZZLH6e/sbRnZmnCls2vovnuSEySrZ
 TXKTk5QpGIyc5XPze5NHWHV8qIrHcz5BjX3HNyV+3m8TwGsoFGo9SGVaG7zjUTXtX4w7
 NuuXvj2zdReZRC3sJqHmG05VeTkCdEBiNa1QMK4blYQDySSxMtflWTbiaW8DbvNdtbbW
 w9mzTrspkWdlHVFlVHIeY0N70ilZLDixr+F1B68B0bgYIFoQ5aCygTOfJGodfSZiHRq6
 5TVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+ZSuJlWdUYuzX44z6ce8UlMvZU1/mW17GAM2XTd2SMBTaTXJbrpWsqszBLj6kk9OfazogjLk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxvKx/bH5hSSvB48wMjVHWsRXRUq8LjqeuVWAGulsBJdhksxvWc
 xwcpefVtcQ0bwbOwk2YwKEz5zxUiuWy2piK1ZyIUh/9hOjHJJHWBkxE3
X-Gm-Gg: AR+sD13FHBoZsy4+pnrgYJ4pgUkQks8BDLLZg7Etyqq7zzf6Ij8EWVQQrXEzF+t+w0j
 1HQBQTGjaKHKIuCCBVZssVrIZpBND83qKcxXtYAb00EXBaRPMVwSKJfOil0mqsZv9hv+60hA2pC
 m9mnO3+bR8WvsnkbCQ7tIyXe2hMpMRdDp78aUXCLbFM7/plmlkFp0ZsAY3a9+3DlCxxkqQ082e5
 USlvPXMwSeOUcDNR2xrc247IKZB3LyVdBFCNsac3cF4KW2bz93hwx7JE43zll1B6YPEe7OWMQQP
 7K7foZLJXMye1MAAAIp5NAVtMiaB4/gmQLVqgTzNu4JJHRFrNo8l9vAue6WDw+IIHPaAe1CDHPD
 oxEiCsHAaREJzG4FzUl6ZXI3vEs2s1kC6J7p4ZEVqsC3nIQP5Pecv7HksbMsqy+bkxHYKS/eHHY
 YdY7BgniFeKPw0N6UipYV4wWla/YivcC8t6qM7O94UqsOWO7PuTH32hT2gxvwGfMmyPXTCml1zL
 /SHY4U0gvzv71GYIgdrgYYkjJCC+/S2ybg6IBcvTrVSCmArOMfpMibgV3ubxzvTwbDbN1aPDf6r
 WQ==
X-Received: by 2002:a05:6808:1796:b0:4ab:232a:759f with SMTP id
 5614622812f47-4ad5baa09b0mr1747123b6e.43.1785255559201; 
 Tue, 28 Jul 2026 09:19:19 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (71-218-31-69.hlrn.qwest.net.
 [71.218.31.69]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6afefdaasm146438b6e.0.2026.07.28.09.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 09:19:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Romain Naour <romain.naour@smile.fr>, Shiva Tripathi <s-tripathi1@ti.com>,
 Randolph Sapp <rs@ti.com>, Anton Ivanov <anton@binarly.io>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v2] tools: fit: sign all config image references
Date: Tue, 28 Jul 2026 10:18:39 -0600
Message-ID: <20260728161904.96004-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785255559; x=1785860359;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zF3TQgmJChOCZG7/uYc75PiSrIMV3OIZ4EiijPqAFnc=;
 b=sUvdMnhh6DgdsV/+dTqIlF6sA2n9Vh63deNQltCIZ8eT2jEwfjMF2a3xUrWFEnD9uv
 kedNAYiV+0eeMDXhjW+rT10FO+DOfUjIBEn6x/BRMrZWF/Of/Xi+txVspR4ZvUwiel+Z
 AjJ3lFml+jl27095r0tveqEY1wK//8KPK1B/iueCEvuKzx2j7dIzh1q3BG4E1XpMlEPm
 7REBUE27gAq0SzhqZA9eS5BmX+xZfGSX0SCpRv2F8Hz7tHbPZTh7lHMx1P6kgbK/fw3W
 86TZi3BAbYd5zU9ZkjMJI5mREY3B33PYpLSk1jWc9pWRvr/8K9f6JSjytvmN3+eEmkpP
 dMLA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sUvdMnhh
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Target-side configuration verification builds the signed-region list from
every image-reference property in the selected configuration. Host-side
signing still uses either the signature node sign-images property or the
legacy kernel/fdt/script default list.

This lets mkimage generate configuration signatures which U-Boot cannot
verify when the configuration references other image types, such as
firmware, loadables or ramdisk entries. It also lets the host and target
disagree when sign-images names only a subset of the configuration images.

Build the host-side signing list from the configuration properties in the
same way as target-side verification. Use one shared property classifier so
the host and target cannot drift apart again. This makes signed
configurations cover the root node, the configuration node, every
referenced image node, and its hash/cipher subnodes, regardless of image
type.

Warn when a legacy sign-images property is present, since it no longer
limits the signed image list. Require every referenced image to have at
least one hash subnode. Add sandbox coverage proving that a firmware
reference omitted from sign-images is still recorded in hashed-nodes and
verified.

Update the signed-configuration documentation to describe the same rule and
the hash-subnode requirement.

Fixes: 2092322b31cc ("boot: Add fit_config_get_hash_list() to build signed node list")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Add vboot coverage for an extra firmware reference omitted from
    sign-images  (suggested by Simon Glass)
  - Warn when mkimage ignores sign-images  (suggested by Simon Glass)
  - Share configuration-property classification between host and target
    code and remove the stale load-only comment  (suggested by Simon Glass)
  - Document that every referenced image needs a hash subnode
    (suggested by Simon Glass)
---
 boot/image-fit-sig.c                          |  9 +-
 boot/image-fit.c                              | 17 ++++
 doc/board/ti/k3.rst                           | 10 +--
 doc/usage/fit/beaglebone_vboot.rst            |  5 +-
 doc/usage/fit/sign-configs.rst                | 13 ++-
 doc/usage/fit/signature.rst                   | 26 +++---
 doc/usage/fit/uefi.rst                        |  2 -
 include/image.h                               |  9 ++
 test/py/tests/test_vboot.py                   | 11 ++-
 test/py/tests/vboot/sign-configs-algo-arg.its |  1 -
 test/py/tests/vboot/sign-configs-sha1-pss.its |  1 -
 test/py/tests/vboot/sign-configs-sha1.its     | 11 +++
 .../vboot/sign-configs-sha256-pss-prod.its    |  1 -
 .../tests/vboot/sign-configs-sha256-pss.its   |  1 -
 test/py/tests/vboot/sign-configs-sha256.its   |  1 -
 test/py/tests/vboot/sign-configs-sha384.its   |  1 -
 tools/fit_image.c                             | 12 ++-
 tools/image-host.c                            | 84 ++++++++-----------
 18 files changed, 121 insertions(+), 94 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index fe7ca6e4ab5..a0620f6f85b 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -317,8 +317,8 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
  * node paths: root + config + all referenced images with their hash and
  * cipher subnodes.
  *
- * Properties known not to be image references (description, compatible,
- * default, load-only) are skipped, so any new image type is covered by default.
+ * Non-image metadata properties are skipped through the shared classifier, so
+ * any new image type is covered by default.
  *
  * @fit:	FIT blob
  * @conf_noffset: Configuration node offset
@@ -369,10 +369,7 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
 		if (!prop_name)
 			continue;
 
-		/* Skip properties that are not image references */
-		if (!strcmp(prop_name, FIT_DESC_PROP) ||
-		    !strcmp(prop_name, FIT_COMPAT_PROP) ||
-		    !strcmp(prop_name, FIT_DEFAULT_PROP))
+		if (!fit_config_prop_is_image_ref(prop_name))
 			continue;
 
 		img_count = fdt_stringlist_count(fit, conf_noffset, prop_name);
diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..deabdfa0fba 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1962,6 +1962,23 @@ int fit_conf_get_node(const void *fit, const char *conf_uname)
 	return noffset;
 }
 
+bool fit_config_prop_is_image_ref(const char *prop_name)
+{
+	static const char * const non_image_props[] = {
+		FIT_DESC_PROP,
+		FIT_COMPAT_PROP,
+		FIT_DEFAULT_PROP,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(non_image_props); i++) {
+		if (!strcmp(prop_name, non_image_props[i]))
+			return false;
+	}
+
+	return true;
+}
+
 int fit_conf_get_prop_node_count(const void *fit, int noffset,
 		const char *prop_name)
 {
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d3ecaf59909..218de36ae61 100644
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
index 6d98d44430c..1268ec6d779 100644
--- a/doc/usage/fit/sign-configs.rst
+++ b/doc/usage/fit/sign-configs.rst
@@ -45,8 +45,19 @@ Signed configurations
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
+verification do not use it to limit the signed image list. mkimage warns when
+the property is present and signs every referenced image.
+
+Every referenced image must have at least one hash subnode. The configuration
+signature protects those hash values rather than the image data directly, so
+mkimage rejects a signed configuration that references an image without a
+hash.
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index da08cc75c3a..071ba5dcfc1 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -341,25 +341,27 @@ So the above example is adjusted to look like this::
 
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
+property is not required and is not used to limit the signed image list. Every
+referenced image must have at least one hash subnode.
 
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
diff --git a/include/image.h b/include/image.h
index 4149ebbcce9..f3d321de68a 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1152,6 +1152,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_SIG_NODENAME	"signature"
 #define FIT_KEY_REQUIRED	"required"
 #define FIT_KEY_HINT		"key-name-hint"
+#define FIT_SIGN_IMAGES_PROP	"sign-images"
 
 /* cipher node */
 #define FIT_CIPHER_NODENAME	"cipher"
@@ -1206,6 +1207,14 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 
 #define FIT_MAX_HASH_LEN	HASH_MAX_DIGEST_SIZE
 
+/**
+ * fit_config_prop_is_image_ref() - Check whether a config property names images
+ *
+ * @prop_name: Configuration property name
+ * Return: true if the property contains image references
+ */
+bool fit_config_prop_is_image_ref(const char *prop_name);
+
 /* cmdline argument format parsing */
 int fit_parse_conf(const char *spec, ulong addr_curr,
 		ulong *addr, const char **conf_name);
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 4b6707caf70..e9259584e32 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -195,7 +195,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if options:
             args += options.split(' ')
         ubman.log.action('%s: Sign images' % sha_algo)
-        utils.run_and_log(ubman, args)
+        return utils.run_and_log(ubman, args)
 
     def sign_fit_dtb(sha_algo, options, dtb):
         """Sign the FIT
@@ -323,7 +323,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
 
         # Sign images with our dev keys
-        sign_fit(sha_algo, sign_options)
+        sign_output = sign_fit(sha_algo, sign_options)
+        if sha_algo == 'sha1' and not padding:
+            assert "'sign-images' is ignored" in sign_output
+            hashed_nodes = utils.run_and_log(
+                ubman, ['fdtget', '-t', 's', fit, sig_node,
+                        'hashed-nodes']).split()
+            assert '/images/firmware' in hashed_nodes
+            assert '/images/firmware/hash-1' in hashed_nodes
         run_bootm(sha_algo, 'signed config', 'dev+', True)
 
         ubman.log.action('%s: Check signed config on the host' % sha_algo)
diff --git a/test/py/tests/vboot/sign-configs-algo-arg.its b/test/py/tests/vboot/sign-configs-algo-arg.its
index 3a5bb6d0f73..aa2878a8fa0 100644
--- a/test/py/tests/vboot/sign-configs-algo-arg.its
+++ b/test/py/tests/vboot/sign-configs-algo-arg.its
@@ -37,7 +37,6 @@
 			fdt = "fdt-1";
 			signature {
 				key-name-hint = "dev";
-				sign-images = "fdt", "kernel";
 			};
 		};
 	};
diff --git a/test/py/tests/vboot/sign-configs-sha1-pss.its b/test/py/tests/vboot/sign-configs-sha1-pss.its
index 72a5637e3a1..2c52f0e1fdd 100644
--- a/test/py/tests/vboot/sign-configs-sha1-pss.its
+++ b/test/py/tests/vboot/sign-configs-sha1-pss.its
@@ -39,7 +39,6 @@
 				algo = "sha1,rsa2048";
 				padding = "pss";
 				key-name-hint = "dev";
-				sign-images = "fdt", "kernel";
 			};
 		};
 	};
diff --git a/test/py/tests/vboot/sign-configs-sha1.its b/test/py/tests/vboot/sign-configs-sha1.its
index d8bc1fa0919..5e3bd727201 100644
--- a/test/py/tests/vboot/sign-configs-sha1.its
+++ b/test/py/tests/vboot/sign-configs-sha1.its
@@ -29,12 +29,23 @@
 				algo = "sha1";
 			};
 		};
+		firmware {
+			data = /incbin/("test-kernel.bin");
+			type = "firmware";
+			arch = "sandbox";
+			os = "u-boot";
+			compression = "none";
+			hash-1 {
+				algo = "sha1";
+			};
+		};
 	};
 	configurations {
 		default = "conf-1";
 		conf-1 {
 			kernel = "kernel";
 			fdt = "fdt-1";
+			firmware = "firmware";
 			signature {
 				algo = "sha1,rsa2048";
 				key-name-hint = "dev";
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss-prod.its b/test/py/tests/vboot/sign-configs-sha256-pss-prod.its
index aac732e304c..d64d888b3b4 100644
--- a/test/py/tests/vboot/sign-configs-sha256-pss-prod.its
+++ b/test/py/tests/vboot/sign-configs-sha256-pss-prod.its
@@ -39,7 +39,6 @@
 				algo = "sha256,rsa2048";
 				padding = "pss";
 				key-name-hint = "prod";
-				sign-images = "fdt", "kernel";
 			};
 		};
 	};
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss.its b/test/py/tests/vboot/sign-configs-sha256-pss.its
index 7bdcc7e286f..0cd9c6f272f 100644
--- a/test/py/tests/vboot/sign-configs-sha256-pss.its
+++ b/test/py/tests/vboot/sign-configs-sha256-pss.its
@@ -39,7 +39,6 @@
 				algo = "sha256,rsa2048";
 				padding = "pss";
 				key-name-hint = "dev";
-				sign-images = "fdt", "kernel";
 			};
 		};
 	};
diff --git a/test/py/tests/vboot/sign-configs-sha256.its b/test/py/tests/vboot/sign-configs-sha256.its
index f5591aad305..9ab08c8747c 100644
--- a/test/py/tests/vboot/sign-configs-sha256.its
+++ b/test/py/tests/vboot/sign-configs-sha256.its
@@ -38,7 +38,6 @@
 			signature {
 				algo = "sha256,rsa2048";
 				key-name-hint = "dev";
-				sign-images = "fdt", "kernel";
 			};
 		};
 	};
diff --git a/test/py/tests/vboot/sign-configs-sha384.its b/test/py/tests/vboot/sign-configs-sha384.its
index 2869401991e..ba28a339932 100644
--- a/test/py/tests/vboot/sign-configs-sha384.its
+++ b/test/py/tests/vboot/sign-configs-sha384.its
@@ -38,7 +38,6 @@
 			signature {
 				algo = "sha384,rsa3072";
 				key-name-hint = "dev";
-				sign-images = "fdt", "kernel";
 			};
 		};
 	};
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 7e59bc43b77..0398c86b226 100644
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
index 8f1e7be4066..9d7791bac35 100644
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
@@ -1286,16 +1267,20 @@ err_path:
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
 
+	if (fdt_getprop(fit, sig_offset, FIT_SIGN_IMAGES_PROP, NULL))
+		fprintf(stderr,
+			"Warning: configuration '%s/%s': 'sign-images' is ignored; all referenced images will be signed\n",
+			conf_name, sig_name);
+
 	/*
 	 * Build a list of nodes we need to hash. We always need the root
 	 * node and the configuration.
@@ -1306,34 +1291,35 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
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
+		if (!fit_config_prop_is_image_ref(prop_name))
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

