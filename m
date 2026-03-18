Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8880110775E4
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 17:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C730883A41;
	Wed, 18 Mar 2026 18:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fKd3SBbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1170283AC5; Wed, 18 Mar 2026 18:02:40 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3668839DF
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 18:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-67badf2d5b6so65896eaf.2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 10:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773853356; x=1774458156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IsNOtCaUBamZp5UbH49ZhKbaDBEtOgslWsd07QfTAgs=;
 b=fKd3SBbutwkkqImClFTkjLSkS3IPteA7Xq+0lO0m/pqX0kHcZwKJztwCu34Pq8i3gM
 wrWGRdw5/0uKHAYnH3AAFR1PwoWi7r1MrVvB7h8WiBZfakiDDciIqXJtOJYVbLJ3ba8+
 KS6mTvODHwu0GDN28p3ZAXuTdvqCIxBd2D8GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773853356; x=1774458156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IsNOtCaUBamZp5UbH49ZhKbaDBEtOgslWsd07QfTAgs=;
 b=VDGlAxVbUUZzeFixTgy+Mq3RMnKAopT8241CWYbTlyCRkjI4eiq0VfBY6pnB+n6euh
 yA0XN0SvpI+ixLr/YAhd7jsFEKMpkoDtQpNXFjIAL2wIHek8NgWXbxoG2yj6m9BPJPou
 ZvIH1XeqvABXDBSmqlDT62R/3WWAyTdjOO/SQciJXvHCBszbOB/D4oHeG6xPkFdTU3qT
 f025R7StlwnHH7UokU5bYhOxuZkemceuLdDKsrGJX36gsG9gsruXBhmqRQgDJUXNpBPe
 JLSD82LYe6WjBdSiH+QrWL4DYdEpRg2u8pmABpVXkZGwOSscEtNR/aiMLAUerDciBbgW
 uwBA==
X-Gm-Message-State: AOJu0YxNSxMmql8gnr2MirpD9jv1rUErRcddP1clSuNXoEi663xL68qo
 J/f+H6zGj2dAHoHZttsrkJc70Z7FwsMSbJ/rlseoEN8Ml2mMn+hj76Z0DXvCZB0lWTZgE7mElFj
 XhY/F
X-Gm-Gg: ATEYQzyKGxTYTEgSlVZl9yMmsN5vjcDM5R23elSabJjjkArKxZlBsz91vpMhEEH3oBn
 5jq3ij/FSFpzbcuESGg7bbqZa5i1Y4mR6PihJwDRHJakNJ2HXktWuJGyxBUe2f04RmTVgJLGkmm
 hQOn1DN/RJEc4kCIhSwtQy4Ayq34wB8KccCsdqK3cBk+iY4wUzcSh8uzLtesWL4ztMvveM4vT//
 akaVgMC/lSvm8X97qhJsuiHnBosXTdhJ0uAEQmjxhdRiLsRHn5AQXh3MH8SrlslGwiG4lOMFSaL
 mgQFz0cOWpYtadF9I8qV9ATSQbdfSA/MtYeXET+dX1yp62n8o62ZxhxRAFlwbt56HqO6nK3xgBg
 Uaqf6aWRUPBKq5kvfi5fZwpx9cJyrsCQVh/7zzzXobqQgeMjLrxWsK1cJVuh4UX/fu07MBlkSLc
 b17+k+/mop9uMAF9j6KCz3euP6tiuLR278wUNhrNG5AZTWeUw+4SIlmQ2dcpKdZU1qMMgNUofAw
 N4ITgrtfyqYKFb6/M0eQiRHoyBBpgG9V+Juu8FkaKJ9vR8K2wU=
X-Received: by 2002:a05:6820:1993:b0:67b:bf52:998e with SMTP id
 006d021491bc7-67c0dae2cc6mr3010072eaf.36.1773853356014; 
 Wed, 18 Mar 2026 10:02:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c0d89ca52sm1973431eaf.12.2026.03.18.10.02.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:02:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] tests: FIT: Add "clone" image attack image test
Date: Wed, 18 Mar 2026 11:02:33 -0600
Message-ID: <20260318170233.1200532-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Related to the problem resolved with commit 2092322b31cc ("boot: Add
fit_config_get_hash_list() to build signed node list"), add a testcase
for the problem as well.

Reported-by: Apple Security Engineering and Architecture (SEAR)
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Apple has confirmed that we can include the test case now, rather than
waiting.
---
 test/py/tests/test_vboot.py | 10 ++++++
 test/py/tests/vboot_evil.py | 65 +++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 19f3f981379e..55518bed07e9 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -372,6 +372,16 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             msg = 'Signature checking prevents use of unit addresses (@) in nodes'
             run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
 
+            # Try doing a clone of the images
+            efit = '%stest.evilclone.fit' % tmpdir
+            shutil.copyfile(fit, efit)
+            vboot_evil.add_evil_node(fit, efit, evil_kernel, 'clone')
+
+            utils.run_and_log_expect_exception(
+                ubman, [fit_check_sign, '-f', efit, '-k', dtb],
+                1, 'Failed to verify required signature')
+            run_bootm(sha_algo, 'evil clone', 'Bad Data Hash', False, efit)
+
         # Create a new properly signed fit and replace header bytes
         make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
diff --git a/test/py/tests/vboot_evil.py b/test/py/tests/vboot_evil.py
index e2b0cd65468b..5720631ae522 100644
--- a/test/py/tests/vboot_evil.py
+++ b/test/py/tests/vboot_evil.py
@@ -14,6 +14,7 @@ FDT_END = 0x9
 
 FAKE_ROOT_ATTACK = 0
 KERNEL_AT = 1
+IMAGE_CLONE = 2
 
 MAGIC = 0xd00dfeed
 
@@ -274,6 +275,66 @@ def get_prop_value(dt_struct, dt_strings, prop_path):
 
     return tag_data
 
+def image_clone_attack(dt_struct, dt_strings, kernel_content, kernel_hash):
+    # retrieve the default configuration name
+    default_conf_name = get_prop_value(
+        dt_struct, dt_strings, '/configurations/default')
+    default_conf_name = str(default_conf_name[:-1], 'utf-8')
+
+    conf_path = '/configurations/' + default_conf_name
+
+    # fetch the loaded kernel name from the default configuration
+    loaded_kernel = get_prop_value(dt_struct, dt_strings, conf_path + '/kernel')
+
+    loaded_kernel = str(loaded_kernel[:-1], 'utf-8')
+
+    # since this is the last child in images!
+    loaded_fdt_name = get_prop_value(dt_struct, dt_strings, conf_path + '/fdt')
+
+    loaded_fdt_name = str(loaded_fdt_name[:-1], 'utf-8')
+
+     # determine boundaries of the images
+    (img_node_start, img_node_end) = (determine_offset(
+        dt_struct, dt_strings, '/images'))
+    if img_node_start is None and img_node_end is None:
+        print('Fatal error, unable to find images node')
+        sys.exit()
+
+    # copy the images node
+    img_node_copy = dt_struct[img_node_start:img_node_end]
+
+    # create an additional empty node
+    empty_node = struct.pack('>I', FDT_BEGIN_NODE) + b"EMPTYNO\0" + struct.pack('>I', FDT_END_NODE)
+    # right before the end, we add it!
+    img_node_copy = img_node_copy[:-4] + empty_node + img_node_copy[-4:]
+
+    # insert the copy inside the tree
+    dt_struct = dt_struct[:img_node_end-4] + \
+        img_node_copy + empty_node + dt_struct[img_node_end-4:]
+
+    # change the content of the kernel being loaded
+    dt_struct = change_property_value(
+        dt_struct, dt_strings, '/images/' + loaded_kernel + '/data', kernel_content)
+
+    # change the content of the kernel being loaded
+    dt_struct = change_property_value(
+        dt_struct, dt_strings, '/images/' + loaded_kernel + '/hash-1/value', kernel_hash)
+
+    # finally, the main bug: change the hashed nodes to use the images clone instead!
+    hashed_nodes: bytes = get_prop_value(dt_struct, dt_strings, conf_path + '/signature/hashed-nodes')
+    print(f"got hashed nodes: {hashed_nodes}")
+    nodes = hashed_nodes.split(b"\0")
+    patched_nodes = []
+    for node in nodes:
+        new_node = node
+        if node.startswith(b"/images/"):
+            # reparent the node
+            new_node = b"/images" + node
+        patched_nodes.append(new_node)
+    hashed_nodes = b"\0".join(patched_nodes)
+    dt_struct = change_property_value(
+        dt_struct, dt_strings, conf_path + '/signature/hashed-nodes', hashed_nodes)
+    return dt_struct
 
 def kernel_at_attack(dt_struct, dt_strings, kernel_content, kernel_hash):
     """Conduct the kernel@ attack
@@ -419,6 +480,8 @@ def add_evil_node(in_fname, out_fname, kernel_fname, attack):
         attack = FAKE_ROOT_ATTACK
     elif attack == 'kernel@':
         attack = KERNEL_AT
+    elif attack == 'clone':
+        attack = IMAGE_CLONE
     else:
         raise ValueError('Unknown attack name!')
 
@@ -455,6 +518,8 @@ def add_evil_node(in_fname, out_fname, kernel_fname, attack):
     elif attack == KERNEL_AT:
         dt_struct = kernel_at_attack(dt_struct, dt_strings, kernel_content,
                                      hash_digest)
+    elif attack == IMAGE_CLONE:
+        dt_struct = image_clone_attack(dt_struct, dt_strings, kernel_content, hash_digest)
 
     # now rebuild the new file
     size_dt_strings = len(dt_strings)
-- 
2.43.0

