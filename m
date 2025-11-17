Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7422BCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 19:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D942783B9D;
	Mon, 17 Nov 2025 20:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F4183655; Mon, 17 Nov 2025 20:43:50 +0100 (CET)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0587883C19
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 20:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d9J8M5QwWzmcs;
 Mon, 17 Nov 2025 20:43:47 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d9J8L2tdwzsDc; Mon, 17 Nov 2025 20:43:46 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 17 Nov 2025 20:43:31 +0100
Subject: [PATCH v2 3/4] tools: binman: fit: add support for OpenSSL engines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-binman-engine-v2-3-e053f683c0b8@cherry.de>
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
In-Reply-To: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
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

The -k argument to mkimage can be specified via fit,engine-keydir. This
is especially useful for pkcs11 engine to specify slots, token label,
etc...

The -k argument to mkimage can be specified by setting fit,engine-keydir
property, if missing no -k argument will be passed.

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
 tools/binman/entries.rst  | 45 +++++++++++++++++++++++++++++++---
 tools/binman/etype/fit.py | 61 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 8922d6cd070..fb17157cd79 100644
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
 
@@ -898,6 +899,44 @@ The top-level 'fit' node supports the following special properties:
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
+        When `fit,engine` is set to `pkcs11`, the value of
+        `fit,engine-keydir` (if present) is concatenated with `;object=` and
+        the value of `key-name-hint`, and passed as-is to the OpenSSL engine
+        API. If the value of `fit,engine-keydir` contains `object=` or
+        `id=`, only the value of `fit,engine-keydir` is passed as-is to the
+        OpenSSL engine API. If no `fit,engine-keydir` is present,
+        `pkcs11:object=` is concatenated with the value of `key-name-hint`,
+        and passed as-is to the OpenSSL engine API.
+
+        For all other values of `fit,engine`, the value of
+        `fit,engine-keydir` (if present) is concatenated with the value of
+        `key-name-hint` and passed as-is to the OpenSSL engine API.
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
index db40479d30e..6547d0314b9 100644
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
 
@@ -117,6 +118,44 @@ class Entry_fit(Entry_section):
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
+            When `fit,engine` is set to `pkcs11`, the value of
+            `fit,engine-keydir` (if present) is concatenated with `;object=` and
+            the value of `key-name-hint`, and passed as-is to the OpenSSL engine
+            API. If the value of `fit,engine-keydir` contains `object=` or
+            `id=`, only the value of `fit,engine-keydir` is passed as-is to the
+            OpenSSL engine API. If no `fit,engine-keydir` is present,
+            `pkcs11:object=` is concatenated with the value of `key-name-hint`,
+            and passed as-is to the OpenSSL engine API.
+
+            For all other values of `fit,engine`, the value of
+            `fit,engine-keydir` (if present) is concatenated with the value of
+            `key-name-hint` and passed as-is to the OpenSSL engine API.
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
 
@@ -620,7 +659,21 @@ class Entry_fit(Entry_section):
             args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
         if (self._fit_props.get('fit,sign') is not None or
             self._fit_props.get('fit,encrypt') is not None):
-            args.update({'keys_dir': self._get_keys_dir(data)})
+            engine = None
+            if self._fit_props.get('fit,sign') is not None:
+                engine_prop = self._fit_props.get('fit,engine')
+                if engine_prop is not None:
+                    engine = engine_prop.value
+                    args.update({'engine': engine})
+                engine_keydir_prop = self._fit_props.get('fit,engine-keydir')
+                if engine_keydir_prop is not None:
+                    engine_keydir = engine_keydir_prop.value
+                    if engine_keydir:
+                        args.update({'keys_dir': engine_keydir})
+            if engine is None:
+                args.update({'keys_dir': self._get_keys_dir(data)})
+            elif self._fit_props.get('fit,encrypt') is not None:
+                self.Raise('fit,engine currently does not support encryption')
         if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
                             **args) is None:
             if not self.GetAllowMissing():

-- 
2.51.1

