Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0228C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0417A88A8F;
	Wed, 17 Jul 2024 17:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q2h5sBuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE2B88A66; Wed, 17 Jul 2024 17:57:22 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A428188464
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36799fb93baso4205827f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231840; x=1721836640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0Dc9z/MxMYBIhoe4fAjTo6dkdKbIiPXVqHjnCZyqZ8=;
 b=Q2h5sBuCaB87N9J78RYHtelLv2lhE6sC3csTPz1Mr0utoAFMjuiZWCilcP8aslLyjp
 hGN8g24MWxLvwYxEtNYRt3cVrEMOE13Bm3Lqnej6DcLnG+PgPs8kiyMoTEsATdHCb774
 Rm3116yU4zMD+szXrDf4eVyTUXLJ4bF2XazTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231840; x=1721836640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0Dc9z/MxMYBIhoe4fAjTo6dkdKbIiPXVqHjnCZyqZ8=;
 b=ANRD38zcNVaMX2jT94T6afRNR3zH8igdIAAoIYlxSgaElSsoTWrB7HEZUnRJl5qiVt
 s21gXSmve0jO3n1ZIFTRVfX0gw/tLsbdAxCxQfihfDF2U1aZGrzEI74/GmcN7cgLSIl2
 4Oim2IxJtJ2wSJ7gYXW7i9ZLe1qxivm/pHdn9iRgjcpNh8eEJ52PFjaAg2IK5v6iBDaV
 hrb7lQk1/tPJXjX3RM7AQJl6VtQBGfHNGNOopQQ3OYGCShy1B75XjyP5FtfsPMi1FgdZ
 V7bC5nDiQ4glKj5GjyXJXLF9uBQvXqjpny6s/bNtULb0KZiVe5hQ5cERup31jxO+XiAd
 mQLw==
X-Gm-Message-State: AOJu0Yw6HLBDgXuMnuGSQV7dyTkg2PiBG/xY1lq0wVYThb0MOopWAxj+
 P/WbFMuVpmMyoL0zppxK3/3qwJJWCPU2pNj0qgfFcWsU7g/pNNPjirJJetuz/hjafHMaKLNMr6s
 =
X-Google-Smtp-Source: AGHT+IH5JIQZnulZpatl4XLOU2F4B8D6jfi4fh8Ojsp/fgTSTeaHgCPpNCnPyKauDGbfWIvkdfFRZg==
X-Received: by 2002:adf:a311:0:b0:367:8875:dd4c with SMTP id
 ffacd0b85a97d-368315fb700mr1658937f8f.23.1721231839984; 
 Wed, 17 Jul 2024 08:57:19 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/24] qconfig: Make KconfigScanner a function
Date: Wed, 17 Jul 2024 16:56:51 +0100
Message-Id: <20240717155712.2913651-4-sjg@chromium.org>
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

This doesn't have any methods so is not good as a class. Make it a
function instead, to keep pylint happy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 7d3989c7c3e..a11ed5303d0 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -254,17 +254,18 @@ class Progress:
         sys.stdout.flush()
 
 
-class KconfigScanner:
-    """Kconfig scanner."""
+def scan_kconfig():
+    """Scan all the Kconfig files and create a Config object
 
-    def __init__(self):
-        """Scan all the Kconfig files and create a Config object."""
-        # Define environment variables referenced from Kconfig
-        os.environ['srctree'] = os.getcwd()
-        os.environ['UBOOTVERSION'] = 'dummy'
-        os.environ['KCONFIG_OBJDIR'] = ''
-        os.environ['CC'] = 'gcc'
-        self.conf = kconfiglib.Kconfig()
+    Returns:
+        Kconfig object
+    """
+    # Define environment variables referenced from Kconfig
+    os.environ['srctree'] = os.getcwd()
+    os.environ['UBOOTVERSION'] = 'dummy'
+    os.environ['KCONFIG_OBJDIR'] = ''
+    os.environ['CC'] = 'gcc'
+    return kconfiglib.Kconfig()
 
 
 class KconfigParser:
@@ -912,7 +913,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
         config - a CONFIG_XXX options (a string, e.g. 'CONFIG_CMD_EEPROM')
         defconfig - a defconfig file (a string, e.g. 'configs/snow_defconfig')
     """
-    kconf = KconfigScanner().conf if check_kconfig else None
+    kconf = scan_kconfig() if check_kconfig else None
     if add_imply and add_imply != 'all':
         add_imply = add_imply.split(',')
 
@@ -1342,7 +1343,7 @@ def do_scan_source(path, do_update):
 
 
     print('Scanning Kconfig')
-    kconf = KconfigScanner().conf
+    kconf = scan_kconfig()
     print(f'Scanning source in {path}')
     args = ['git', 'grep', '-E', r'IS_ENABLED|\bCONFIG']
     with subprocess.Popen(args, stdout=subprocess.PIPE) as proc:
-- 
2.34.1

