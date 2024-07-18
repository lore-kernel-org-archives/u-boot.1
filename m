Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AABFC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 09:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFB188ADC;
	Thu, 18 Jul 2024 11:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CMWTz6kU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC90F87B1A; Thu, 18 Jul 2024 11:11:57 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9659D885F1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 11:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-427b4c621b9so640065e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721293915; x=1721898715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MS8pSLxUwotJWTj8RPwoXI4uNnAM+URo9eqNMa8wo8Q=;
 b=CMWTz6kUUerSPSVFEhIV0LSRz49ET2XNSpXm8+OsPbd0V3kh40MfS4KjgXIQUecya4
 2pseL0KnROSoeLxNdZUqtn1zMRTSmT/ywdz1gqBn+lqzHy6jg7dFnM20PNj5f6d1bBBY
 WHJ32RpeBcQQjXHo53GKiKrKVvrkuSpnDtlRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721293915; x=1721898715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MS8pSLxUwotJWTj8RPwoXI4uNnAM+URo9eqNMa8wo8Q=;
 b=d1SYyzjmOAn6U+3huAMrPmyXfZ+zQ2Spz7k7NwzjRuvyEurRCUvk+C6DxTUBhmIg7z
 uoeGh5iIpGOFQao4gbUJvk2+MpVoUSuszPPMG+vwgrXXwVnytosiXNunT7LSOmOaxNel
 C1a8VNgEpuScf9+oeTNAEnxta7lBJ9oJKHd9fx3XZat5bE6OHxTIgUartWH0etHZIP6X
 9D0VJCxClw5GM3Ia3h8unk4ii0s2uwD1NRTvtFxQsT7IiAy3Vl7GOrtTPUraJpLglbrR
 qTe+crybx60su7G9YMZtofAhoaCIcvtolFBdhO+Uva5lbONdRvsnpmnM+HZkRJrZOwXZ
 Q91Q==
X-Gm-Message-State: AOJu0YyoOH6vuHUaOHNmLgyYLl3yYLQ1c6zzcXiAg+zWEnxG7d666ZkN
 2YxaUn/hBYqFfDG/BYEm4PcpBDyDxRsuvspO6nd0Whe4P6hUiZ+ufh3fdTOeTtUSmTyvLb052S4
 =
X-Google-Smtp-Source: AGHT+IHY4UaUoAlf3YhReMjOzIEjBwiA3KeJxykPHV8+JwxZxB69rifLjR2edhvjBaiAX6a5zqYgEA==
X-Received: by 2002:a05:600c:138b:b0:426:5269:9838 with SMTP id
 5b1f17b1804b1-427c2ca239fmr28099655e9.4.1721293914859; 
 Thu, 18 Jul 2024 02:11:54 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368525f0353sm1064403f8f.115.2024.07.18.02.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:11:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 24/26] qconfig: Allow searching for CONFIG values
Date: Thu, 18 Jul 2024 10:11:23 +0100
Message-Id: <20240718091125.3788990-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718091125.3788990-1-sjg@chromium.org>
References: <20240718091125.3788990-1-sjg@chromium.org>
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

Add basic support for searching for matching of non-matching values.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/20

---

Changes in v2:
- Drop debugging

 doc/develop/qconfig.rst | 14 ++++++++++++++
 tools/qconfig.py        | 15 +++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index 8efb1eb2685..123779eab17 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -85,6 +85,20 @@ example, to find boards which enabled CONFIG_SCSI but not CONFIG_BLK::
     3 matches
     pg_wcom_seli8_defconfig highbank_defconfig pg_wcom_expu1_defconfig
 
+It is also possible to search for particular values. For example, this finds all
+boards with an empty string for `CONFIG_DEFAULT_FDT_FILE`::
+
+    ./tools/qconfig.py -f DEFAULT_FDT_FILE=\"\"
+    1092 matches
+    ...
+
+This finds boards which have a value for SYS_MAXARGS other than 64::
+
+    ./tools/qconfig.py -f ~SYS_MAXARGS=64
+    cfg CONFIG_SYS_MAXARGS
+    281 matches
+    ...
+
 
 Finding implied CONFIGs
 -----------------------
diff --git a/tools/qconfig.py b/tools/qconfig.py
index 408807931ff..71fe6fff29c 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1079,7 +1079,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
             for linenum in sorted(linenums, reverse=True):
                 add_imply_rule(config[CONFIG_LEN:], fname, linenum)
 
-def defconfig_matches(configs, re_match):
+def defconfig_matches(configs, re_match, re_val):
     """Check if any CONFIG option matches a regex
 
     The match must be complete, i.e. from the start to end of the CONFIG option.
@@ -1089,13 +1089,15 @@ def defconfig_matches(configs, re_match):
             key: CONFIG option
             value: Value of option
         re_match (re.Pattern): Match to check
+        re_val (re.Pattern): Regular expression to check against value (or None)
 
     Returns:
         bool: True if any CONFIG matches the regex
     """
-    for cfg in configs:
+    for cfg, val in configs.items():
         if re_match.fullmatch(cfg):
-            return True
+            if not re_val or re_val.fullmatch(val):
+                return True
     return False
 
 def do_find_config(config_list):
@@ -1123,6 +1125,11 @@ def do_find_config(config_list):
         if cfg[0] == '~':
             want = False
             cfg = cfg[1:]
+        val = None
+        re_val = None
+        if '=' in cfg:
+            cfg, val = cfg.split('=', maxsplit=1)
+            re_val = re.compile(val)
 
         # Search everything that is still in the running. If it has a config
         # that we want, or doesn't have one that we don't, add it into the
@@ -1131,7 +1138,7 @@ def do_find_config(config_list):
         out = set()
         re_match = re.compile(cfg)
         for defc in in_list:
-            has_cfg = defconfig_matches(config_db[defc], re_match)
+            has_cfg = defconfig_matches(config_db[defc], re_match, re_val)
             if has_cfg == want:
                 out.add(defc)
     print(f'{len(out)} matches')
-- 
2.34.1

