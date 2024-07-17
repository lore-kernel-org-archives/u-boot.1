Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E9AC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EF988B19;
	Wed, 17 Jul 2024 17:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MAGl2eGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D5F88B05; Wed, 17 Jul 2024 17:57:41 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D3988AEC
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367e50f71bbso4516934f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231859; x=1721836659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/fHgOc/BF/oFirrhE+8D5d+XLJD5YWbcjoyzaVrRKA=;
 b=MAGl2eGW9RJnnRu6d9TesO0Sm6G4r6G/r5oyLIvZzvNMpZ4mV/Usbb3asYtP2ZyHtw
 JDZXMgtGaPY2MgUf2qdtNZtAJiV2rqHUf5iE4KepkxCjRxsMrdoMmSIXnNKWSQqrPMdY
 7izrUudNQ2Y3fQCcuZC+EYJ66jmwFDeX9ykbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231859; x=1721836659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/fHgOc/BF/oFirrhE+8D5d+XLJD5YWbcjoyzaVrRKA=;
 b=gVMhTJk9oe2a7sk6gXeq2FUuzK/jVBD8nnXFBAelOM88RzGOS3bPOQuOQfbeKH6YH/
 w/D83yL/xXfcckGcbAD+SFbd7/pxaasWKJRMgHd5HRMB67+P870d0mUT7wRSNuSC+Wlt
 481j73NZMfn+oV4mn/r/TvldPeJhmjmTFF2UpnOxxx0fVEFXRsOgFrwN/eDTHt7Z0qBI
 4utQ2imMAzsz+msdm+bQTbhHvyMUv6fV6a2vESXt2YjWRNi3x6RgzFzMbi4c6D41+ecU
 bp98Fzr+gszhMfeDlPnQujpToFxohX9EQzssmZlFqXZZEytdk4CMRvbi9LrFhoXaUnku
 OmMA==
X-Gm-Message-State: AOJu0Yxqr03fzbQbyzVfj9PZo3ft7ya3MaKKUYkNepb40AyoMVCRTq32
 2LNuvIysMYGMaog5+hbJG3CiXYtL26dLsdHGlgHnAdX+/u4/+8KV6h1xXyHNLEf/MKD1zAPwdXM
 =
X-Google-Smtp-Source: AGHT+IF62WmHchk5S8sFv/sm9sZRACUI4cDkn6xHw3tYuejv2PqTHE45M7TLF0G5SPzs1ABeY5CWzA==
X-Received: by 2002:a05:6000:1787:b0:35f:f58:38fc with SMTP id
 ffacd0b85a97d-3683164eca3mr1771363f8f.26.1721231858728; 
 Wed, 17 Jul 2024 08:57:38 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 24/24] qconfig: Allow searching for CONFIG values
Date: Wed, 17 Jul 2024 16:57:12 +0100
Message-Id: <20240717155712.2913651-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

 doc/develop/qconfig.rst | 14 ++++++++++++++
 tools/qconfig.py        | 16 ++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

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
index 408807931ff..3e7d42223dc 100755
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
@@ -1123,15 +1125,21 @@ def do_find_config(config_list):
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
         # running for the next stage
         in_list = out
         out = set()
+        print('cfg', cfg)
         re_match = re.compile(cfg)
         for defc in in_list:
-            has_cfg = defconfig_matches(config_db[defc], re_match)
+            has_cfg = defconfig_matches(config_db[defc], re_match, re_val)
             if has_cfg == want:
                 out.add(defc)
     print(f'{len(out)} matches')
-- 
2.34.1

