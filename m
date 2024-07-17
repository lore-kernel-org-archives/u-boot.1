Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710F2C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB30E88A5D;
	Wed, 17 Jul 2024 16:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="OzVVnoFQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="A17vTjjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E17588A4C; Wed, 17 Jul 2024 16:29:49 +0200 (CEST)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8E288A5C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 4A65913800DC;
 Wed, 17 Jul 2024 10:29:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 17 Jul 2024 10:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226586;
 x=1721312986; bh=hDqRGdh2sh+HSP+BPz4Z974wpWbuiBLlSp3lquqxEvg=; b=
 OzVVnoFQgo1ehsWFJIjUteN0ijj4l2yxZxj+d4c6fYAfVAJXBZfj9KAu7mV1EFyz
 Nv6SHvlE55TK+WJFHMF4W3Z0oc2mGCyyKhDfZrFzFZGMh0IWSjAuA/7qS5DGC05o
 n11pq6y3rPx3j5Bge1739Nj20ikPSdMfcfvXvEMe+6dJcNDCctYHFEQGJIoHbOLK
 vWJnB5PZRjjQcQrXBzR7wQl4j/OIyyIyrUXWKDVlDx/yoceKlzqStwIyi8X3QHTJ
 9ZXtsMWwLKyM7A5eFp63JxUByKAmxu99aPHFIHquNdiRD2E1CfYVqPhcDyTdcp53
 qFZT6gPjIPyIkN4yTtinGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226586; x=
 1721312986; bh=hDqRGdh2sh+HSP+BPz4Z974wpWbuiBLlSp3lquqxEvg=; b=A
 17vTjjNwTZWX4MLOXTexB85uny8sAwilCnRzqHGpjtDPqJxuddk1wFpvdq64q4Hp
 si3kby/8Pqje/V5nFqoxIjrEg96PQEHXin9wES8w52huG/sRWBTu4zmamWZhNjsG
 ag5IzynZmag5FNaJMrndFdjrOILqs41S41j4VWVNChAPWzCb3cz0MhHNhxh2oLYk
 MaHh/8hbUnEr87x/5TaqGjiPE2Mc1nUh8QrWfvYnrwl3zOXmUon+CywfLKHxqi1l
 z3i5XUz2pk9GGhSKrH79S9O+iQJ1MmJazOLe7ErUPsvSSW+vnsMafbXUqVuyNuWw
 lEUyeZlgopH8P8stp6oaw==
X-ME-Sender: <xms:WdWXZujU6Jae0kf_WsDxEVJBYn8-Bw6DMaS0OOGphCOGsXRFqoU9Ow>
 <xme:WdWXZvAyQS7veuNkcxp3MMe7jZoMHThu8cjCjivc3EXtvdVI0IAXT7MlII0tEjKd3
 kfj21iJ3hsJQTak_a4>
X-ME-Received: <xmr:WdWXZmGoJlJA2a2YBCQfVZaf4gt7pGLp4phQhKQuocWGJMHTAFStrRJIXw2nfbAUQsis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeefveffvedvjeduhfegffetleeuffffkeeujeevueeutdduveev
 veeuveegkeejvdenucffohhmrghinhepphgrthhhrdhlohgtrghlpdgtohhlrdhgrhgvvg
 hnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:WdWXZnRDDFIJOiscI_aL35TPvGykerFcVKvVMxdtJeQrY8KkWhZdSA>
 <xmx:WdWXZry0BvcHQpdaadI_kqQwRiB0QYBfs1G7DjQMMj0Iu6HhgKyofg>
 <xmx:WdWXZl54clowjw9XuxPMHJ5YVHkN38Uih4uHAY1w8CvTftg0WZoyrA>
 <xmx:WdWXZoxFJ0hiaiorlr_WkLdHK6M1YaSqyWwAaWYefw4IVfoftvJZAw>
 <xmx:WtWXZixZHUhmaQtc8eelB_NGuYCu-Myb4jb28EtnB0RgbKSSP9n2him6>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 10:29:42 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 22:29:15 +0800
Subject: [PATCH 04/18] py: Bump pylint version and clear warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-docker-image-v1-4-7c7fc6251e7a@flygoat.com>
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10374;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=oaU059S7K3+r9SFMQs3A7cUfgb8U8dun50dzFL6ZBzA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTpV10+lW5SKde61fy6tbHCdqPZJPOERz8+iCxa98r60
 irzxm6njlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIRQFGhrcL9x07uat2zvWO
 g6eFI/6I/k9iPbxyx9qYStnemjjtazGMDLPO3vZr2Fn+ZMVLeY6Kh5tS7nt3X1ucNaFyht5Xrle
 ef1kA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Bump pylint to 3.2.3 as old versions are not working with
python 3.12.

Clear warnings, mostly E0606: (possibly-used-before-assignment).

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .azure-pipelines.yml                  | 2 +-
 .gitlab-ci.yml                        | 2 +-
 doc/develop/python_cq.rst             | 4 ++--
 test/py/tests/test_ums.py             | 1 +
 test/py/tests/test_usb.py             | 1 +
 tools/binman/etype/fdtmap.py          | 1 +
 tools/binman/etype/fit.py             | 1 +
 tools/binman/etype/image_header.py    | 1 +
 tools/binman/etype/pre_load.py        | 2 ++
 tools/binman/etype/ti_board_config.py | 1 +
 tools/binman/etype/x509_cert.py       | 1 +
 tools/binman/ftest.py                 | 1 +
 tools/binman/state.py                 | 1 +
 tools/buildman/builder.py             | 2 ++
 tools/microcode-tool.py               | 1 +
 tools/patman/test_checkpatch.py       | 2 ++
 tools/qconfig.py                      | 1 +
 17 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e1b2f87b974a..4119ca7ff849 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -163,7 +163,7 @@ stages:
           export USER=azure
           pip install -r test/py/requirements.txt
           pip install -r tools/buildman/requirements.txt
-          pip install asteval pylint==2.12.2 pyopenssl
+          pip install asteval pylint==3.2.3 pyopenssl
           export PATH=${PATH}:~/.local/bin
           echo "[MASTER]" >> .pylintrc
           echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0a15b7352cdd..bdaf5db1da67 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -217,7 +217,7 @@ Run pylint:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - pip install -r test/py/requirements.txt
     - pip install -r tools/buildman/requirements.txt
-    - pip install asteval pylint==2.12.2 pyopenssl
+    - pip install asteval pylint==3.2.3 pyopenssl
     - export PATH=${PATH}:~/.local/bin
     - echo "[MASTER]" >> .pylintrc
     - echo "load-plugins=pylint.extensions.docparams" >> .pylintrc
diff --git a/doc/develop/python_cq.rst b/doc/develop/python_cq.rst
index 1e209ff197d6..c8a75a5b7a7b 100644
--- a/doc/develop/python_cq.rst
+++ b/doc/develop/python_cq.rst
@@ -23,7 +23,7 @@ regressions in any module.
 To run this locally you should use this version of pylint::
 
     # pylint --version
-    pylint 2.11.1
+    pylint 3.2.3
     astroid 2.8.6
     Python 3.8.10 (default, Sep 28 2021, 16:10:42)
     [GCC 9.3.0]
@@ -31,7 +31,7 @@ To run this locally you should use this version of pylint::
 
 You should be able to select and this install other required tools with::
 
-    pip install pylint==2.11.1
+    pip install pylint==3.2.3
     pip install -r test/py/requirements.txt
     pip install asteval pyopenssl
 
diff --git a/test/py/tests/test_ums.py b/test/py/tests/test_ums.py
index 749b1606235c..55372e42a928 100644
--- a/test/py/tests/test_ums.py
+++ b/test/py/tests/test_ums.py
@@ -118,6 +118,7 @@ def test_ums(u_boot_console, env__usb_dev_port, env__block_devs):
 
     test_f = u_boot_utils.PersistentRandomFile(u_boot_console, 'ums.bin',
         1024 * 1024);
+    mounted_test_fn = None
     if have_writable_fs_partition:
         mounted_test_fn = mount_point + '/' + mount_subdir + test_f.fn
 
diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index fb3d20f0826b..27105cd1d5e1 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -564,6 +564,7 @@ def test_usb_load(u_boot_console):
                     part_detect = 1
                     addr = u_boot_utils.find_ram_base(u_boot_console)
 
+                    file, size = 0, 0
                     if fs == 'fat':
                         file, size = test_usb_fatload_fatwrite(u_boot_console)
                     elif fs == 'ext4':
diff --git a/tools/binman/etype/fdtmap.py b/tools/binman/etype/fdtmap.py
index f1f6217940f2..6b4ca497f871 100644
--- a/tools/binman/etype/fdtmap.py
+++ b/tools/binman/etype/fdtmap.py
@@ -106,6 +106,7 @@ class Entry_fdtmap(Entry):
         Returns:
             FDT map binary data
         """
+        fsw = None
         def _AddNode(node):
             """Add a node to the FDT map"""
             for pname, prop in node.props.items():
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 2c14b15b03cd..dfbb6de7b63e 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -808,6 +808,7 @@ class Entry_fit(Entry_section):
             data_size = fdt_util.GetInt(node, "data-size")
 
             # Contents are inside the FIT
+            offset, size = 0, 0
             if data_prop is not None:
                 # GetOffset() returns offset of a fdt_property struct,
                 # which has 3 fdt32_t members before the actual data.
diff --git a/tools/binman/etype/image_header.py b/tools/binman/etype/image_header.py
index 240118849580..3db8e61d23a2 100644
--- a/tools/binman/etype/image_header.py
+++ b/tools/binman/etype/image_header.py
@@ -62,6 +62,7 @@ class Entry_image_header(Entry):
 
     def _GetHeader(self):
         image_pos = self.GetSiblingImagePos('fdtmap')
+        offset = 0xffffffff
         if image_pos == False:
             self.Raise("'image_header' section must have an 'fdtmap' sibling")
         elif image_pos is None:
diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 2e4c72359ff3..c095cf425c93 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -112,6 +112,8 @@ class Entry_pre_load(Entry_collection):
         # Compute the signature
         if padding_name is None:
             padding_name = "pkcs-1.5"
+
+        padding, padding_args = None, {}
         if padding_name == "pss":
             salt_len = key.size_in_bytes() - hash_image.digest_size - 2
             padding = pss
diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index c10d66edcb15..33c7a351c4ea 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -118,6 +118,7 @@ class Entry_ti_board_config(Entry_section):
         Returns:
             array of bytes representing value
         """
+        br = None
         size = 0
         if (data_type == '#/definitions/u8'):
             size = 1
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index 29630d1b86c8..763cb506399b 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -83,6 +83,7 @@ class Entry_x509_cert(Entry_collection):
         output_fname = tools.get_output_filename('cert.%s' % uniq)
         input_fname = tools.get_output_filename('input.%s' % uniq)
         config_fname = tools.get_output_filename('config.%s' % uniq)
+        stdout = None
         tools.write_file(input_fname, input_data)
         if type == 'generic':
             stdout = self.openssl.x509_cert(
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index e4da04030a51..e9ad145e790d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6293,6 +6293,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             re_name = re.compile('_binman_(u_boot_(.*))_prop_(.*)')
             for name, sym in syms.items():
                 msg = 'test'
+                expect_val = None
                 val = elf.GetSymbolValue(sym, edata, msg)
                 entry_m = re_name.match(name)
                 if entry_m:
diff --git a/tools/binman/state.py b/tools/binman/state.py
index 45bae40c525a..f43be6d4ce6e 100644
--- a/tools/binman/state.py
+++ b/tools/binman/state.py
@@ -406,6 +406,7 @@ def CheckSetHashValue(node, get_data_func):
     hash_node = node.FindNode('hash')
     if hash_node:
         algo = hash_node.props.get('algo').value
+        data = None
         if algo == 'sha256':
             m = hashlib.sha256()
             m.update(get_data_func())
diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index c4384f53e8dc..88ee1f34b54e 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -1068,6 +1068,7 @@ class Builder:
             printed_target = False
             for name in sorted(result):
                 diff = result[name]
+                color = None
                 if name.startswith('_'):
                     continue
                 if diff != 0:
@@ -1328,6 +1329,7 @@ class Builder:
             for line in lines:
                 if not line:
                     continue
+                col = None
                 if line[0] == '+':
                     col = self.col.GREEN
                 elif line[0] == '-':
diff --git a/tools/microcode-tool.py b/tools/microcode-tool.py
index 24c02c4fca14..5f0287736dc7 100755
--- a/tools/microcode-tool.py
+++ b/tools/microcode-tool.py
@@ -277,6 +277,7 @@ def MicrocodeTool():
     if cmd not in commands:
         parser.error("Unknown command '%s'" % cmd)
 
+    date, license_text, microcodes = None, None, None
     if (not not options.mcfile) != (not not options.mcfile):
         parser.error("You must specify either header files or a microcode file, not both")
     if options.headerfile:
diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index db7860f551d0..e2f596940d3d 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -530,4 +530,6 @@ index 0000000..2234c87
 
 if __name__ == "__main__":
     unittest.main()
+    # pylint doesn't seem to find this
+    # pylint: disable=E1101
     gitutil.RunTests()
diff --git a/tools/qconfig.py b/tools/qconfig.py
index 04118d942da6..2492b37444a3 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -873,6 +873,7 @@ def read_database():
     all_defconfigs = set()
 
     defconfig_db = collections.defaultdict(set)
+    defconfig = None
     for line in read_file(CONFIG_DATABASE):
         line = line.rstrip()
         if not line:  # Separator between defconfigs

-- 
2.45.2

