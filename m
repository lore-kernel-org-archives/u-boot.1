Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C34C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 19:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348CF88A95;
	Thu, 15 Aug 2024 21:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fm3OZg4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E8488A82; Thu, 15 Aug 2024 21:58:07 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258B588A95
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 21:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70b3b62025dso893457a34.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723751879; x=1724356679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRZ5Z1BhmjLKxm6Rc4pZ37P8WKoFcZAnCSdQuC5SGik=;
 b=fm3OZg4SrAUimTfz+A9vGZFGI9NzT1dVNvDf5JjE8eMS5S+GS4jrg77NGDFaCLf09J
 8PKaKxMCgVhj7KhmB58bHP21OzD2GcU8CC+Z8KorDXo+WAzp3qPtDgLdc81XoJvDVaQC
 KWQ4BIn78hM8fdv7iKTgBhikmmsgV4IaVepj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723751879; x=1724356679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRZ5Z1BhmjLKxm6Rc4pZ37P8WKoFcZAnCSdQuC5SGik=;
 b=INbXbAWBzQPFAUPiJDxoZnfzZaxllZaoplIdQf9hQBCqtNaT4b2nDn/tjmRxUMuU0I
 TioM65RJx9xXwLbMEr929AHxMJacoc3mRmIC/ZgTKrN4A5oJdIMbmvAa62qsi9qQhd/U
 Ub/ggeww8VNg+hJntIoQ/fNsVTgHyVsf+hVZpzvCvA6xFAXPSBbd2wA2iFfAnZvP1eYv
 AqAlhhC2PdyL4mOVcmn2pvNcEn0XIVjRa3enMah5jZsnH9CCVDOdw92Omy1rG4n/cCep
 fHtNsFjzsAh3+4oE4hmlPyURnY7zMbrMQCqBDAkkjwwOLSXDH/kGbZOGnVeUaoYtKuE0
 qUoQ==
X-Gm-Message-State: AOJu0YwektQwsu9sa0IiyqL4s8JHy+9AXMAHO3FJV6mV0gIAg9NSScWG
 eCgB21wbE0IjATbYuE96qBmO+G0Cor5mx/1mj4FzCifgpjtQzEP2SlCoivF9FUa0Y1MEiMI0fTO
 eEg==
X-Google-Smtp-Source: AGHT+IFwjR4mlaMEaUqCtS08WkaYpDct6LIOnQOpF8qmJq0PR5//jlB8meEf9X76MIJnK54P2vRXOA==
X-Received: by 2002:a05:6830:368b:b0:703:5d5c:3439 with SMTP id
 46e09a7af769-70cac8b1cdemr904826a34.23.1723751878860; 
 Thu, 15 Aug 2024 12:57:58 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6f3e3f2sm697372173.100.2024.08.15.12.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 12:57:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 1/3] buildman: Support building within a Python venv
Date: Thu, 15 Aug 2024 13:57:44 -0600
Message-Id: <20240815195746.749042-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815195746.749042-1-sjg@chromium.org>
References: <20240815195746.749042-1-sjg@chromium.org>
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

The Python virtualenv tool sets up a few things in the environment,
putting its path first in the PATH environment variable and setting up
a sys.prefix different from the sys.base_prefix value.

At present buildman puts the toolchain path first in PATH so that it can
be found easily during the build. For sandbox this causes problems since
/usr/bin/gcc (for example) results in '/usr/bin' being prepended to the
PATH variable. As a result, the venv is partially disabled.

The result is that sandbox builds within a venv ignore the venv, e.g.
when looking for packages.

Correct this by detecting the venv and adding the toolchain path after
the venv path.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Fix 'envronment' typo

 tools/buildman/bsettings.py |  3 ++
 tools/buildman/test.py      | 84 +++++++++++++++++++++++++++++++++++++
 tools/buildman/toolchain.py | 31 ++++++++++++--
 3 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py
index aea724fc559..a7358cfc08a 100644
--- a/tools/buildman/bsettings.py
+++ b/tools/buildman/bsettings.py
@@ -31,6 +31,9 @@ def setup(fname=''):
 def add_file(data):
     settings.read_file(io.StringIO(data))
 
+def add_section(name):
+    settings.add_section(name)
+
 def get_items(section):
     """Get the items from a section of the config.
 
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index bfad3093030..6191af95445 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -148,6 +148,7 @@ class TestBuild(unittest.TestCase):
         self.toolchains.Add('arm-linux-gcc', test=False)
         self.toolchains.Add('sparc-linux-gcc', test=False)
         self.toolchains.Add('powerpc-linux-gcc', test=False)
+        self.toolchains.Add('/path/to/aarch64-linux-gcc', test=False)
         self.toolchains.Add('gcc', test=False)
 
         # Avoid sending any output
@@ -868,6 +869,89 @@ class TestBuild(unittest.TestCase):
             self.assertEqual([4, 5], control.read_procs(tmpdir))
             self.assertEqual(self.finish_time, self.cur_time)
 
+    def call_make_environment(self, tchn, full_path, in_env=None):
+        """Call Toolchain.MakeEnvironment() and process the result
+
+        Args:
+            tchn (Toolchain): Toolchain to use
+            full_path (bool): True to return the full path in CROSS_COMPILE
+                rather than adding it to the PATH variable
+            in_env (dict): Input environment to use, None to use current env
+
+        Returns:
+            tuple:
+                dict: Changes that MakeEnvironment has made to the environment
+                    key: Environment variable that was changed
+                    value: New value (for PATH this only includes components
+                        which were added)
+                str: Full value of the new PATH variable
+        """
+        env = tchn.MakeEnvironment(full_path, env=in_env)
+
+        # Get the original environment
+        orig_env = dict(os.environb if in_env is None else in_env)
+        orig_path = orig_env[b'PATH'].split(b':')
+
+        # Find new variables
+        diff = dict((k, env[k]) for k in env if orig_env.get(k) != env[k])
+
+        # Find new / different path components
+        diff_path = None
+        new_path = None
+        if b'PATH' in diff:
+            new_path = diff[b'PATH'].split(b':')
+            diff_paths = [p for p in new_path if p not in orig_path]
+            diff_path = b':'.join(p for p in new_path if p not in orig_path)
+            if diff_path:
+                diff[b'PATH'] = diff_path
+            else:
+                del diff[b'PATH']
+        return diff, new_path
+
+    def test_toolchain_env(self):
+        """Test PATH and other environment settings for toolchains"""
+        # Use a toolchain which has a path, so that full_path makes a difference
+        tchn = self.toolchains.Select('aarch64')
+
+        # Normal cases
+        diff = self.call_make_environment(tchn, full_path=False)[0]
+        self.assertEqual(
+            {b'CROSS_COMPILE': b'aarch64-linux-', b'LC_ALL': b'C',
+             b'PATH': b'/path/to'}, diff)
+
+        diff = self.call_make_environment(tchn, full_path=True)[0]
+        self.assertEqual(
+            {b'CROSS_COMPILE': b'/path/to/aarch64-linux-', b'LC_ALL': b'C'},
+            diff)
+
+        # When overriding the toolchain, only LC_ALL should be set
+        tchn.override_toolchain = True
+        diff = self.call_make_environment(tchn, full_path=True)[0]
+        self.assertEqual({b'LC_ALL': b'C'}, diff)
+
+        # Test that virtualenv is handled correctly
+        tchn.override_toolchain = False
+        sys.prefix = '/some/venv'
+        env = dict(os.environb)
+        env[b'PATH'] = b'/some/venv/bin:other/things'
+        tchn.path = '/my/path'
+        diff, diff_path = self.call_make_environment(tchn, False, env)
+
+        self.assertIn(b'PATH', diff)
+        self.assertEqual([b'/some/venv/bin', b'/my/path', b'other/things'],
+                         diff_path)
+        self.assertEqual(
+            {b'CROSS_COMPILE': b'aarch64-linux-', b'LC_ALL': b'C',
+             b'PATH': b'/my/path'}, diff)
+
+        # Handle a toolchain wrapper
+        tchn.path = ''
+        bsettings.add_section('toolchain-wrapper')
+        bsettings.set_item('toolchain-wrapper', 'my-wrapper', 'fred')
+        diff = self.call_make_environment(tchn, full_path=True)[0]
+        self.assertEqual(
+            {b'CROSS_COMPILE': b'fred aarch64-linux-', b'LC_ALL': b'C'}, diff)
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 324ad0e0821..6ca79c2c0f9 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -172,13 +172,14 @@ class Toolchain:
         else:
             raise ValueError('Unknown arg to GetEnvArgs (%d)' % which)
 
-    def MakeEnvironment(self, full_path):
+    def MakeEnvironment(self, full_path, env=None):
         """Returns an environment for using the toolchain.
 
         This takes the current environment and adds CROSS_COMPILE so that
         the tool chain will operate correctly. This also disables localized
         output and possibly Unicode encoded output of all build tools by
-        adding LC_ALL=C.
+        adding LC_ALL=C. For the case where full_path is False, it prepends
+        the toolchain to PATH
 
         Note that os.environb is used to obtain the environment, since in some
         cases the environment many contain non-ASCII characters and we see
@@ -187,15 +188,21 @@ class Toolchain:
           UnicodeEncodeError: 'utf-8' codec can't encode characters in position
              569-570: surrogates not allowed
 
+        When running inside a Python venv, care is taken not to put the
+        toolchain path before the venv path, so that builds initiated by
+        buildman will still respect the venv.
+
         Args:
             full_path: Return the full path in CROSS_COMPILE and don't set
                 PATH
+            env (dict of bytes): Original environment, used for testing
         Returns:
             Dict containing the (bytes) environment to use. This is based on the
             current environment, with changes as needed to CROSS_COMPILE, PATH
             and LC_ALL.
         """
-        env = dict(os.environb)
+        env = dict(env or os.environb)
+
         wrapper = self.GetWrapper()
 
         if self.override_toolchain:
@@ -206,7 +213,23 @@ class Toolchain:
                 wrapper + os.path.join(self.path, self.cross))
         else:
             env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
-            env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
+
+            # Detect a Python virtualenv and avoid defeating it
+            if sys.prefix != sys.base_prefix:
+                paths = env[b'PATH'].split(b':')
+                new_paths = []
+                to_insert = tools.to_bytes(self.path)
+                insert_after = tools.to_bytes(sys.prefix)
+                for path in paths:
+                    new_paths.append(path)
+                    if to_insert and path.startswith(insert_after):
+                        new_paths.append(to_insert)
+                        to_insert = None
+                if to_insert:
+                    new_paths.append(to_insert)
+                env[b'PATH'] = b':'.join(new_paths)
+            else:
+                env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
 
         env[b'LC_ALL'] = b'C'
 
-- 
2.34.1

