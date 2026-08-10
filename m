Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5895CC5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 23:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0404440711;
	Mon, 10 Aug 2026 23:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pY2GA7lnvmFi; Mon, 10 Aug 2026 23:44:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FA8040714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786405442;
	bh=dGpEGVRsckJcDrNf2a83ugsXorUurRf8ZzRHCbnm5w0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hwvXonUN/5gR7Oa4A3PswF8wjEtDqTzSYBXMXws7bmCnnbgykX1c/M2jqfUJMJJAN
	 m+lSgDfJzGNGoxHUav3V04crqEM49D1IhKTbf6zMXHGKihA0+B2uJBP9nLfx9Z1K0T
	 dxqrhr6a6QxuqX65Ct41GZJbyAcqG+FYjtPb20uG9mIUmkshlNunSDkzyw5J8AtuAS
	 Wl42gaivhLK4wXooJ3TVKRWKqZRlFwd818a7VzhG4b9HrxffGu+EjZtB9iEeWGcWCq
	 IPAj8ZcH6zr2x0UKq8RG9XkX24D2tbivPYlA1gM5ej/6dnj69M4lFs5fHBT2yy23nI
	 gsgUXAzaUg3Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FA8040714;
	Mon, 10 Aug 2026 23:44:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 738A5282
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6834A40137
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQ5GG9TC2grz for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 23:43:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EA40440061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA40440061
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA40440061
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 23:43:58 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb42a2f5feso927310a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786405438; x=1787010238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dGpEGVRsckJcDrNf2a83ugsXorUurRf8ZzRHCbnm5w0=;
 b=nbz32gBAn4QYeIs4hlfMQENtsMRohuc5YYZEb9ClIFftfaEEHNpn7XtyghNS1gItPl
 EPCB4v5USgTt7/0jYucHBAKY7qTx1ks9GQfa3we1zj63+c71arJurL7vOvV8P5+w2//g
 bUlr7hgQY9b6g8gPxGZBobv75hn8AyqKLfiPPhDTVdzsYqeOrbdAb6QJVkxQYcNyc0KG
 ABkOzXOi1CLkPZ37kY81rsXfPFcLhKziCKmXmlYrBLWrBpyit7yY4AzBdwlw0DySIqX2
 dXLc+0/rN4Bm4BXQuWsW9YI9kOMJCIlly7Vg+KOrRUgrtDtxaiDBwK0bMwU9KrocsuHA
 2XwA==
X-Gm-Message-State: AOJu0YxLRqxNMv2tqOvbhVsXLRT51tR8/MNm9rn43EVFXNuexv6oxD5h
 Uqfeoy7lgFst+y3Rp895sT7rbr6Jieypf3KCmumAazUUJrQubS3Wn8/CRsEi1Q==
X-Gm-Gg: AR+sD10oKBRSpSVhk7VWsWlRyuzBDdHmcwmSVxDMDcHUsxklvmZ3Rs+A6M20gJyW66F
 P23je7gypTqvOQFwqVYqfRcd+wM9zFmDfdUn6Z7fvoSJsGYXogavKP9frY+ztzvithj5fmFZSM2
 iZONID8wHJesXyLXRfxDTK33ZXWiz6B9cw1OkJI7iXsY2B/FRAdC8ZurVJF3kDGeRd7g6URKMxv
 KPjcT2EXi17KWzWPSA4eJ5Ava8l+95tIo7NsAsNADmsaa8lZGqB2W0PPIWgDz2WCGgTCRH6nahm
 ohcsn7VzYPyRCC3Vjra1msHtOHBbO3EDFlkcty2pjCrGk6wAlxKRm9Bwrj5WCu6u1/KDhcQExYv
 DkfPgpC06lPSHEMmqzL/9LtSJjhO9FuesA4CgSb8T6zQ+IVaCGVfUmFmlVdWeyIxGilaEILxuuH
 2gR/IESqTctkefcBJFQQvIxG3J+MeW2cQP6BCd6u8FXXfaNr+PhePER726obIJNn/AIQkNPFwYh
 I5i+0m8AppP4o+vFRA4lEqvLJs23OYfTVmECO6FK0zBzc9yvEIqiAcPlZui2Ykzar00p0CuSzwA
 OFtkjZbFa0BwTNpxLPIiAn/bSwEvFj9au+iODjGCPEYlVgLW3dnGENaO2pe3r5kHZKj9+zL1xtj
 jUYli9wAvRfXzpRgV3XepM5VU93JBi9KjX+CZaw==
X-Received: by 2002:a05:6830:7103:b0:7d7:fbe2:9725 with SMTP id
 46e09a7af769-7f1e5cc3c9bmr27321388a34.5.1786405437621; 
 Mon, 10 Aug 2026 16:43:57 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (184-96-154-59.hlrn.qwest.net.
 [184.96.154.59]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b807227sm8384901a34.27.2026.08.10.16.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 16:43:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Randolph Sapp <rs@ti.com>, Anton Ivanov <anton@binarly.io>
Subject: [PATCH v3] tools: fit: sign all config image references
Date: Mon, 10 Aug 2026 17:43:07 -0600
Message-ID: <20260810234318.119255-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786405438; x=1787010238;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dGpEGVRsckJcDrNf2a83ugsXorUurRf8ZzRHCbnm5w0=;
 b=OC/1B6xOcucaT6CFddMoXSmxEgTJsBY6lrAd29VMBG35+bcLsv0Uv4l3o55+Zagnzw
 VjrHVLSL0ZUJPdHwZsqczageZH4a4LavSA0z/iubssL7B0ODvRZecU2H1Mr9KBUDbXd/
 SetkzzTnx5oNBTcS+qT1N0nPyMSYTT7TUUbnlbeG495g0AJ6hxZyoM899fl7rv7iZ8Wa
 c/ajp99/y68EBx36Kj9CGdUxsISSVIiBbeGVj6MKWN/woLiFAJ9+iFe2JgbWENWdvF08
 WkA93kLfcxB4LFLONPNQT0C7kq8WiS1PgKfpoE5Cpo6RgsWnTjKRjlhdLGPtqVX5gLKl
 qW4w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=OC/1B6xO
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
referenced image node, and its hash, cipher and dm-verity subnodes,
regardless of image type.

Warn when a legacy sign-images property is present, since it no longer
limits the signed image list. Require every referenced image to have at
least one hash subnode. Add sandbox coverage proving that a firmware
reference omitted from sign-images is still recorded in hashed-nodes and
verified.

Update the signed-configuration documentation to describe the same rule and
the hash-subnode requirement.

Fixes: 2092322b31cc ("boot: Add fit_config_get_hash_list() to build signed node list")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes v1 -> v2:
  - Add vboot coverage for an extra firmware reference omitted from
    sign-images  (suggested by Simon Glass)
  - Warn when mkimage ignores sign-images  (suggested by Simon Glass)
  - Share configuration-property classification between host and target
    code and remove the stale load-only comment  (suggested by Simon Glass)
  - Document that every referenced image needs a hash subnode
    (suggested by Simon Glass)

Changes v2 -> v3:
  - Rebase onto current upstream main
  - Retain the new dm-verity subnode coverage in the shared signed-node
    construction
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
index a0c50bba4cf..c0fbe81b4c7 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -347,8 +347,8 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
  * node paths: root + config + all referenced images with their hash,
  * cipher and dm-verity subnodes.
  *
- * Properties known not to be image references (description, compatible,
- * default, load-only) are skipped, so any new image type is covered by default.
+ * Non-image metadata properties are skipped through the shared classifier, so
+ * any new image type is covered by default.
  *
  * @fit:	FIT blob
  * @conf_noffset: Configuration node offset
@@ -399,10 +399,7 @@ int fit_config_get_signed_nodes(const void *fit, int conf_noffset,
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
index c587b8c271d..82f43dbc002 100644
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
index 64bada2f58f..e5d6ce85c7e 100644
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
-referenced image node and its hash, cipher and dm-verity subnodes.
+firmware, loadables, etc.), since 'hashed-nodes' is not itself covered by the
+signature. The rebuilt list always includes the root node, the configuration
+node, each referenced image node and its hash, cipher and dm-verity subnodes.
+Current mkimage uses the same rule when signing configurations. The older
+'sign-images' property is not required and is not used to limit the signed
+image list. Every referenced image must have at least one hash subnode.
 
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
index 6edcb1995bf..de704f5d890 100644
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
index 16a5ad6c22d..46036673050 100644
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
  * fit_config_add_node() - Add a node's path to a list of nodes to hash
  *
@@ -1314,8 +1293,10 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
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
@@ -1328,16 +1309,20 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
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
@@ -1348,34 +1333,35 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,
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

