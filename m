Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197C1C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E37A84A0A;
	Tue,  7 Jul 2026 13:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kiBpVuiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC20880087; Tue,  7 Jul 2026 13:36:12 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71C784979
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a116bd18ebso2041608eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424169; x=1784028969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DxIwGsUoyrQ4PwlqCU9eTkk966Ts+8lzZx35enILK+w=;
 b=kiBpVuiRStsZS+K0XsQtTdymLGLweZ0S1auAm4q1Ua+w8uDSZFmLsBKfB9J0Xdo2am
 DIG1/TDfpOkvpu8zKzI5B9w8k7Y4XHAPxw9dtaKLqtbt0DX6Ua3pvJEWT4cm8GTjl3e0
 LdSPDBioZGEkG6GLQcYx2hRjr0H2q6ZKdjarM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424169; x=1784028969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DxIwGsUoyrQ4PwlqCU9eTkk966Ts+8lzZx35enILK+w=;
 b=QIe6dBlUR0ZoreGFYpwf6RrG6OAsepLJ0Li9lM9VbsCJ7B3d37p8LckZ9DcF3WI9Tc
 rNC1tN8xImaRMAYOk3UO9ANT1xjmzV8mHYVmux1uftlJj6zeJi32kG0CJggnVGUUGmWC
 Y7eeW2u2WrSyr0/IgrwX5bYmOPdQqRx3F4pIPsydj6joURG9PdwMLqADRvSysQer5Ztt
 oHBSsSW4N9aFjAft0AEqzWylKdwp0bMk7KS8QgGYyEnK9Uik0zlUxvs6qAl3adeODp/V
 tExBSrgTPmLpADW+VXS1Hvt9q8t6sC/evfbrN2auYq6qNXG6JOK2VNSjYV8HEnIUJCxK
 1w7Q==
X-Gm-Message-State: AOJu0YyKDGvHk048VzDGX/PisdqdkYOCRjOlYU4rousN6t7jBuSiLdlu
 qh/tcAjW+si5qfHPNYgfY4LsTFqyWBuiCJ2WJQHM2bhTC93UD+Wr4js/oJBbRvw0Nx3oLZp8MNo
 vogqIYg==
X-Gm-Gg: AfdE7ckGopS/bOh8fi3CqQA5yeE9nDu8PbAu5CTz6WosD3gfqKLIaIMcifzrRx2yRCO
 tVZnS4eJJZ0vGJMdjCfJEiG0cVuzz5GGYfnUwY2DvBdpsQ1NqwtqPwFqrPVvQPrdjU8DH8gh45V
 t5cKvDqS7Xqh/fmdhDf6Xngy3spPQzfJSRlRDsDhgWG+CZCGxRGnZfE7Hu0HjvKILwtig7XhDbL
 YgQdu52AQuX3iW0jxh6NOjrH23WUL0czUhvmWpG6RMV17dD93Tf1Bn1AhHrfJqLPdt+Ptk01nWn
 NcFH9muXDWCQ5CqXGdNr3bFTmnKJ+1tHYXoKUpWpyUNIw+w6MvaphoyXTz394gsBZiOWVa8W+K1
 Yrf1HRRw8vurXp3Jos04SDAG2gjVpQ12ETuGv7kIjJ/DSzWPI0VibYybfB4/c8t6EfLELsvIUYS
 2jBWZR3Qg=
X-Received: by 2002:a05:6820:8c2:b0:6a1:7f97:6e58 with SMTP id
 006d021491bc7-6a35559ce63mr3117669eaf.43.1783424169482; 
 Tue, 07 Jul 2026 04:36:09 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/13] qconfig: Refactor to allow buildman to read the database
Date: Tue,  7 Jul 2026 05:35:05 -0600
Message-ID: <20260707113538.3382145-5-sjg@chromium.org>
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

The qconfig tool has the ability to search for CONFIGs used by boards.
Refactor the code slightly so that buildman can obtain the database.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index a01481de207..efdb0a0f472 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1118,23 +1118,22 @@ def defconfig_matches(configs, re_match, re_val):
                 return True
     return False
 
-def do_find_config(config_list, list_format):
-    """Find boards with a given combination of CONFIGs
+def find_config(dbase, config_list):
+    """Find all defconfigs which match a config list
 
     Args:
+        dbase (tuple): Database from read_database()
         config_list (list of str): List of CONFIG options to check (each a regex
             consisting of a config option, with or without a CONFIG_ prefix. If
             an option is preceded by a tilde (~) then it must be false,
             otherwise it must be true)
-        list_format (bool): True to write in 'list' format, one board name per
-            line
 
     Returns:
-        int: exit code (0 for success)
+        set: matching defconfigs, without the '_defconfig' suffix
     """
-    _, all_defconfigs, config_db, _ = read_database()
-
     # Start with all defconfigs
+    _, all_defconfigs, config_db, _ = dbase
+
     out = all_defconfigs
 
     # Work through each config in turn
@@ -1161,10 +1160,31 @@ def do_find_config(config_list, list_format):
             has_cfg = defconfig_matches(config_db[defc], re_match, re_val)
             if has_cfg == want:
                 out.add(defc)
+
+    result = {c.split('_defconfig')[0] for c in out}
+
+    return result
+
+def do_find_config(config_list, list_format):
+    """Find boards with a given combination of CONFIGs
+
+    Args:
+        config_list (list of str): List of CONFIG options to check (each a regex
+            consisting of a config option, with or without a CONFIG_ prefix. If
+            an option is preceded by a tilde (~) then it must be false,
+            otherwise it must be true)
+        list_format (bool): True to write in 'list' format, one board name per
+            line
+
+    Returns:
+        int: exit code (0 for success)
+    """
+    dbase = read_database()
+    out = find_config(dbase, config_list)
     if not list_format:
         print(f'{len(out)} matches')
     sep = '\n' if list_format else ' '
-    print(sep.join(item.split('_defconfig')[0] for item in sorted(list(out))))
+    print(sep.join(sorted(list(out))))
     return 0
 
 
-- 
2.43.0

