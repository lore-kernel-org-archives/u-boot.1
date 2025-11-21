Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04041CFC294
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED5083A71;
	Fri, 21 Nov 2025 18:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56A9A83A64; Fri, 21 Nov 2025 18:15:15 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39D5B80433
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dChg46qR9ztY0;
 Fri, 21 Nov 2025 18:15:12 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dChg35gcJz92l; Fri, 21 Nov 2025 18:15:11 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 21 Nov 2025 18:14:59 +0100
Subject: [PATCH v3 3/4] tools: binman: fit: add support for OpenSSL engines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-binman-engine-v3-3-b80180aaa783@cherry.de>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
In-Reply-To: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds support for using an OpenSSL engine for signing a FIT image.
To use it, one should set the fit,engine property at the FIT node level
with the engine to use. This will in turn call mkimage with the -N
option.

The -k argument to mkimage can be specified via fit,engine-keydir. If
not specified, -k is not passed to mkimage. This property is especially
useful for pkcs11 engine to specify slots, token label, etc...

As far as I could tell, mkimage encrypts and signs a FIT in one go, thus
the -k argument applies to both signing and encrypting. Considering we
reuse the -k argument for two different meanings (info to pass to the
engine when using an engine otherwise the directory where keys are
stored), we cannot reasonably encrypt using local keys and signing with
an engine, hence the enforced check. I believe it should be possible to
support encrypting and signing with the same engine (using different
key pairs of course, via different key-name-hint likely), but this is
left for the next person to implement.
This is why the property is named fit,engine and not fit,sign-engine.
Ditto for fit,engine-keydir.

The public key (with .crt extension) is still required if it needs to be
embedded in the SPL DTB for example. We could probably support
retrieving the public key from an engine, but this is a change to make
to fdt_add_pubkey.c.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/entries.rst  | 54 +++++++++++++++++++++++++--
 tools/binman/etype/fit.py | 93 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 8922d6cd070..a81fcbd3891 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -885,9 +885,10 @@ The top-level 'fit' node supports the following special properties:
 
     fit,sign
         Enable signing FIT images via mkimage as described in
-        verified-boot.rst. If the property is found, the private keys path
-        is detected among binman include directories and passed to mkimage
-        via  -k flag. All the keys required for signing FIT must be
+        verified-boot.rst.
+        If the property is found and fit,engine is not set, the private
+        keys path is detected among binman include directories and passed to
+        mkimage via -k flag. All the keys required for signing FIT must be
         available at time of signing and must be located in single include
         directory.
 
@@ -898,6 +899,53 @@ The top-level 'fit' node supports the following special properties:
         required for encrypting the FIT must be available at the time of
         encrypting and must be located in a single include directory.
 
+        Incompatible with fit,engine.
+
+    fit,engine
+        Indicates the OpenSSL engine to use for signing the FIT image. This
+        is passed to mkimage via the `-N` flag. Example::
+
+            fit,engine = "my-engine";
+
+        A `-k` argument for mkimage may be passed via `fit,engine-keydir`.
+
+        When `fit,engine` is set to `pkcs11`, the following applies:
+
+        - If `fit,engine-keydir` is absent, the value of `key-name-hint` is
+          prefixed with `pkcs11:object=` before being passed to the OpenSSL
+          engine API::
+
+              pkcs11:object=<key-name-hint>
+
+        - If `fit,engine-keydir` contains either `object=` or `id=`, its
+          value is passed verbatim to the OpenSSL engine API,
+
+        - Otherwise, the value of `fit,engine-keydir` is followed by
+          `;object=` and the value of `key-name-hint` before being passed
+          to the OpenSSL engine API::
+
+              <fit,engine-keydir>;object=<key-name-hint>
+
+        If `fit,engine` is set to something different than `pkcs11`, the
+        value of `key-name-hint` (prefixed with the value of
+        `fit,engine-keydir` if present) and passed verbatim to the OpenSSL
+        engine API.
+
+        Depends on fit,sign.
+
+        Incompatible with fit,encrypt.
+
+    fit,engine-keydir
+        Indicates the `-k` argument to pass to mkimage if an OpenSSL engine
+        is to be used for signing the FIT image. Example::
+
+            fit,engine-keydir = "pkcs11:model=xxx;manufacturer=xxx";
+
+        Read `fit,engine` documentation for more info on special cases when
+        using `pkcs11` as engine.
+
+        Depends on fit,engine.
+
 Substitutions
 ~~~~~~~~~~~~~
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index db40479d30e..f28b1e6b4cb 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -104,9 +104,10 @@ class Entry_fit(Entry_section):
 
         fit,sign
             Enable signing FIT images via mkimage as described in
-            verified-boot.rst. If the property is found, the private keys path
-            is detected among binman include directories and passed to mkimage
-            via  -k flag. All the keys required for signing FIT must be
+            verified-boot.rst.
+            If the property is found and fit,engine is not set, the private
+            keys path is detected among binman include directories and passed to
+            mkimage via -k flag. All the keys required for signing FIT must be
             available at time of signing and must be located in single include
             directory.
 
@@ -117,6 +118,53 @@ class Entry_fit(Entry_section):
             required for encrypting the FIT must be available at the time of
             encrypting and must be located in a single include directory.
 
+            Incompatible with fit,engine.
+
+        fit,engine
+            Indicates the OpenSSL engine to use for signing the FIT image. This
+            is passed to mkimage via the `-N` flag. Example::
+
+                fit,engine = "my-engine";
+
+            A `-k` argument for mkimage may be passed via `fit,engine-keydir`.
+
+            When `fit,engine` is set to `pkcs11`, the following applies:
+
+            - If `fit,engine-keydir` is absent, the value of `key-name-hint` is
+              prefixed with `pkcs11:object=` before being passed to the OpenSSL
+              engine API::
+
+                  pkcs11:object=<key-name-hint>
+
+            - If `fit,engine-keydir` contains either `object=` or `id=`, its
+              value is passed verbatim to the OpenSSL engine API,
+
+            - Otherwise, the value of `fit,engine-keydir` is followed by
+              `;object=` and the value of `key-name-hint` before being passed to
+              the OpenSSL engine API::
+
+                  <fit,engine-keydir>;object=<key-name-hint>
+
+            If `fit,engine` is set to something different than `pkcs11`, the
+            value of `key-name-hint` (prefixed with the value of
+            `fit,engine-keydir` if present) and passed verbatim to the OpenSSL
+            engine API.
+
+            Depends on fit,sign.
+
+            Incompatible with fit,encrypt.
+
+        fit,engine-keydir
+            Indicates the `-k` argument to pass to mkimage if an OpenSSL engine
+            is to be used for signing the FIT image. Example::
+
+                fit,engine-keydir = "pkcs11:model=xxx;manufacturer=xxx";
+
+            Read `fit,engine` documentation for more info on special cases when
+            using `pkcs11` as engine.
+
+            Depends on fit,engine.
+
     Substitutions
     ~~~~~~~~~~~~~
 
@@ -588,6 +636,29 @@ class Entry_fit(Entry_section):
 
         return paths[0] if len(paths) else None
 
+    def _get_fit_engine(self):
+        """Detect whether an OpenSSL engine is to be used for the FIT
+
+        Returns:
+            Tuple(str, str): Name of the engine to use, as first element of the
+                             Tuple. None if no engine to use.
+                             keydir arguments to pass with the engine to the
+                             OpenSSL API, as second element of the Tuple. None
+                             if no keydir to pass.
+        """
+        engine = None
+        engine_keydir = None
+
+        prop = self._fit_props.get('fit,engine')
+        if prop is not None:
+            engine = prop.value
+
+            prop = self._fit_props.get('fit,engine-keydir')
+            if prop is not None:
+                engine_keydir = prop.value
+
+        return engine, engine_keydir
+
     def BuildSectionData(self, required):
         """Build FIT entry contents
 
@@ -620,7 +691,21 @@ class Entry_fit(Entry_section):
             args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
         if (self._fit_props.get('fit,sign') is not None or
             self._fit_props.get('fit,encrypt') is not None):
-            args.update({'keys_dir': self._get_keys_dir(data)})
+            engine = None
+            keydir = None
+
+            # Engine only supported for signing for now
+            if self._fit_props.get('fit,sign') is not None:
+                engine, keydir = self._get_fit_engine()
+
+            args.update({'engine': engine})
+            # If no engine, keys must exist locally, find them
+            if engine is None:
+                keydir = self._get_keys_dir(data)
+            elif self._fit_props.get('fit,encrypt') is not None:
+                self.Raise('fit,engine currently does not support encryption')
+
+            args.update({'keys_dir': keydir})
         if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
                             **args) is None:
             if not self.GetAllowMissing():

-- 
2.51.1

