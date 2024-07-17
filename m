Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C54C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD7B288ADD;
	Wed, 17 Jul 2024 17:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HJymPBcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F7E88A55; Wed, 17 Jul 2024 17:57:33 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0ED688ABD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso49415045e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231851; x=1721836651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBEjTpFHcR7NF0MTNf7/beCTB7VmZveeQpJsXogKgp8=;
 b=HJymPBcPoV5JXKxnJgIhWZFfk/fcoxXu+XWhP/PEjqai6O2nyQH1wWlvLkwbT/dIPz
 7T53ml2RKCvbmgVn0w0HCl53QsZPyWZzgM8LgZVrgMHj1JbN5EBTLVD6wH0iIIPY/kBu
 OFtgODajWxidDV8nPnvP0JfvNhMDaj6x6WBSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231851; x=1721836651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBEjTpFHcR7NF0MTNf7/beCTB7VmZveeQpJsXogKgp8=;
 b=Rl1S/wpvRaBkyVkuqetCEPPtMKQ1M26ab7NjhoN1cZqiyjy5YidQgpq/raSlXq3lj7
 n6V/Z2m8HcGfRznc+4uefhWmWgXlvtE/i8rN8eLUMqW4E4gbixB3EWQ6wZ8bOvBEGSkq
 lsDIJeD5AChrEG+Q7P0r7UX0sclTxj6fIG8JkYCNf0WkXCvZJ0g2MLobt+k5Y/kxaHDQ
 WGOv9HbTU3Kta1o8G4vsjy7/Oky5UvrZc12PAg5bpK9vxnU0i9yby4PHa03BvM1X20NJ
 2iBokKm80/NiT9B3pTXB2kj/awmhVVcZYH7cigSIAnjbMCfFlQbeXFAJXvb10jotdJk3
 WkjA==
X-Gm-Message-State: AOJu0YxIZP5MO1ipQBLAoSNVu6M27PRDiKYb4Lra8qEqFbBJycdduQO1
 AZkdMDpghWZmVuMiNNdzYIg/3ngqm7zolWIAMyt1uSP6yiKiyxpmwRBabl6DwlblcVjfv7O6G8M
 =
X-Google-Smtp-Source: AGHT+IEAeySNkUBGZX+MX6S/LcOkghS/vZl4mb5nB5d3SIv/2U8TIl5C2vSXwJiCT1TTG7VBeMgZwQ==
X-Received: by 2002:a05:600c:45cf:b0:425:5f0e:bb69 with SMTP id
 5b1f17b1804b1-427c2d1290dmr15435305e9.38.1721231850962; 
 Wed, 17 Jul 2024 08:57:30 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 16/24] qconfig: Add a return value to do_find_config()
Date: Wed, 17 Jul 2024 16:57:04 +0100
Message-Id: <20240717155712.2913651-17-sjg@chromium.org>
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

Return an exit code so we can use this function like do_tests().
Refactor the caller to handle this.

Reduce the size of main() by putting this code into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 8cba6896667..b1487928613 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1072,11 +1072,14 @@ def defconfig_matches(configs, re_match):
 def do_find_config(config_list):
     """Find boards with a given combination of CONFIGs
 
-    Params:
-        config_list: List of CONFIG options to check (each a regex consisting
-            of a config option, with or without a CONFIG_ prefix. If an option
-            is preceded by a tilde (~) then it must be false, otherwise it must
-            be true)
+    Args:
+        config_list (list of str): List of CONFIG options to check (each a regex
+            consisting of a config option, with or without a CONFIG_ prefix. If
+            an option is preceded by a tilde (~) then it must be false,
+            otherwise it must be true)
+
+    Returns:
+        int: exit code (0 for success)
     """
     _, all_defconfigs, config_db, _ = read_database()
 
@@ -1104,6 +1107,7 @@ def do_find_config(config_list):
                 out.add(defc)
     print(f'{len(out)} matches')
     print(' '.join(item.split('_defconfig')[0] for item in out))
+    return 0
 
 
 def prefix_config(cfg):
@@ -1584,8 +1588,7 @@ def main():
             sys.exit(1)
         return 0
     if args.find:
-        do_find_config(args.configs)
-        return 0
+        return do_find_config(args.configs)
 
     # We are either building the database or forcing a sync of defconfigs
     config_db = {}
-- 
2.34.1

