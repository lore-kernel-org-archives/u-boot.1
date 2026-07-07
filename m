Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29005C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9AFE84A30;
	Tue,  7 Jul 2026 13:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CEZ/y47M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE7EA84A04; Tue,  7 Jul 2026 13:36:23 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87E7180087
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a18eab71bfso2222129eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424180; x=1784028980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAXq4o6Po8kr2yBuXhgb78CxfKSLEEmmObwU346xyeo=;
 b=CEZ/y47MF8ikZNxPdFnuWK6P81R+Fbeucp0rb4Bvb6mDN++/hsX8OHHSPXH8ROf9/U
 GcxWni9+gFZFkjaRDilBNkP5vrspKmdNdsMwVypyeW9zSKhqtO/3+GQgUUw0R+K07qOQ
 N3azIU6vkFqZTydun0JVdp9w8bl2yQVwSn+2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424180; x=1784028980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xAXq4o6Po8kr2yBuXhgb78CxfKSLEEmmObwU346xyeo=;
 b=l6SuD+wCkIfsQD+ptZWkOdHpWEaDfXLjroQLVP44avFagp7XlFgYasJ4bn0ay0MegX
 25rO1YuwGTyKPNM4H3c/VJj4T8YvXihH9gMKyL0/tO8Jo1H3D1dt/n/w3UXbxYf1kcDr
 da8/qFrfUrA6BvVuYA3/C2dznIrJ+9KG3LfpUtrxOwVMzJcRsiT50OmnEW2wHfHhYcyx
 MudJ4cLfqECVa9tve5lMaljy2l33U24cNV9uv+OWyUj1US0U/ZQJaZ/1VkwAKptQuTU2
 CTD8q3jbgxrLJNoS8dj1qZoqSwo770UO/UL6T6kSDDhKY0vhlBidizitqxw3ubbZUnmt
 W4bQ==
X-Gm-Message-State: AOJu0YwZ4mCDrPT3qzvE2vwdltuvmH936q1lWYJyWmJp2l4AbSdwOwhD
 c2Xaf2k5j47x0yvCpzZkkPfd5vkMYSPFIEee+lhoDObwQjFNxTXRmrbDXon0wek6ILU6fjoyd29
 efTDzyw==
X-Gm-Gg: AfdE7clqrKISMxbCSpnimpJnqvxzIC5kNLU+WJZIsXg8bbQE+fSDa9JUgL5HsyaB9Sf
 0asDh5bAaB6vZ26tLS3JDel+m6z+V7QYG/LPheNXdEaB5qaZkasqQopQKvbYjrRP2gaa94Z08cT
 3/Nc14x0WGLARZVdheflKxyHnXjCdbSjgsMc8fGEifKoTVdUXen284XWwMPI6mk0qGCOg3AisL1
 gWVPbjvp5/oVGnS4XTZBm36+FLuFkr3YTY5/ITrYWcID9uci7YnEV1//nzZ+6/eEvvGBOiftEo3
 QZlNxvy6at0JODiOGd/RX58KhQpAodrcmI0F4o3zqSgIRfqg+8CRGsIgi1iR6gyxopnvf8zWPE+
 DG4OL8m4bEJUj8s8F4WUZKhpcnMot8jAUWMk61nXBm6qKsZdtrYqRY3aUiKQrFMIy8iEvGUYrK0
 8WOxuUTc8=
X-Received: by 2002:a05:6820:1c88:b0:69d:f864:d35b with SMTP id
 006d021491bc7-6a3553678camr3304345eaf.23.1783424180210; 
 Tue, 07 Jul 2026 04:36:20 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/13] qconfig: Auto-rebuild stale database for -f queries
Date: Tue,  7 Jul 2026 05:35:10 -0600
Message-ID: <20260707113538.3382145-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

The -f (find) option calls read_database() directly, which crashes if
the database does not exist and silently returns stale data if Kconfig
or defconfig files have changed since the last build.

Add a db_is_current() check that compares the database timestamp
against all Kconfig and defconfig files, similar to output_is_new() in
buildman/boards.py. Use this in ensure_database() so that both -f and
buildman's callers get automatic rebuilds when the database is stale.

Wire do_find_config() through ensure_database() instead of
read_database() so that -f benefits from this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 2a594ea0200..0b8f14d3e65 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1286,9 +1286,11 @@ def find_config(dbase, config_list):
 
     return result
 
-def do_find_config(config_list, list_format):
+def do_find_config(config_list, list_format, jobs):
     """Find boards with a given combination of CONFIGs
 
+    Rebuilds the database automatically if it is missing or stale.
+
     Args:
         config_list (list of str): List of CONFIG options to check (each a regex
             consisting of a config option, with or without a CONFIG_ prefix. If
@@ -1296,11 +1298,12 @@ def do_find_config(config_list, list_format):
             otherwise it must be true)
         list_format (bool): True to write in 'list' format, one board name per
             line
+        jobs (int): Number of threads to use if the database needs rebuilding
 
     Returns:
         int: exit code (0 for success)
     """
-    dbase = read_database()
+    dbase = ensure_database(jobs)
     out = find_config(dbase, config_list)
     if not list_format:
         print(f'{len(out)} matches')
@@ -1837,11 +1840,37 @@ def do_tests():
     return 0
 
 
+def db_is_current():
+    """Check if the CONFIG database is up to date
+
+    Returns:
+        bool: True if the database exists and is newer than all Kconfig and
+            defconfig files
+    """
+    if not os.path.exists(CONFIG_DATABASE):
+        return False
+
+    db_time = os.path.getctime(CONFIG_DATABASE)
+
+    for dirpath, _, filenames in os.walk('configs'):
+        for fname in fnmatch.filter(filenames, '*_defconfig'):
+            if db_time < os.path.getctime(os.path.join(dirpath, fname)):
+                return False
+
+    for dirpath, _, filenames in os.walk('.'):
+        for fname in filenames:
+            if fname.startswith('Kconfig'):
+                if db_time < os.path.getctime(os.path.join(dirpath, fname)):
+                    return False
+
+    return True
+
+
 def ensure_database(threads):
-    """Return a qconfig database so that Kconfig options can be queried
+    """Return a qconfig database, rebuilding it if stale or missing
 
-    If a database exists, it is assumed to be up-to-date. If not, one is built,
-    which can take a few minutes.
+    Checks whether the database is newer than all Kconfig and defconfig files.
+    If not, it is rebuilt automatically.
 
     Args:
         threads (int): Number of threads to use when processing
@@ -1859,8 +1888,8 @@ def ensure_database(threads):
                 key: CONFIG option
                 value: set of boards using that option
     """
-    if not os.path.exists(CONFIG_DATABASE):
-        print(f'Building {CONFIG_DATABASE} database')
+    if not db_is_current():
+        print(f'Building {CONFIG_DATABASE} database...')
         args = Namespace(build_db=True, verbose=False, force_sync=False,
                          dry_run=False, exit_on_error=False, jobs=threads,
                          git_ref=None, defconfigs=None, defconfiglist=None,
@@ -1890,7 +1919,7 @@ def main():
             sys.exit(1)
         return 0
     if args.find:
-        return do_find_config(args.configs, args.list)
+        return do_find_config(args.configs, args.list, args.jobs)
 
     if args.build_db:
         config_db, progress = do_build_db(args)
-- 
2.43.0

