Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584D2C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A4ED88AE3;
	Wed, 17 Jul 2024 17:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OFsHushg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375FE88AD7; Wed, 17 Jul 2024 17:57:35 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4838388ACD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso49415335e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231852; x=1721836652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFnWgHqkW4KBRR6Q4YTMlaxQqxdSPuzETGsqd1MoLWY=;
 b=OFsHushgMKWryDDCx5+mSTOfS1bGun9K4ptxSTmkUEdPOXfuQmzUWMvCDMN2Q8jy/L
 fyie5RArfE6yOTy5iEx4x2bWtC/Cf+w/d4EUvPjPcbJOFubhBs+F5uSSft9a0x107OaG
 /gfQ+y8/AHbQ4e9kvsV3C3Pwn0Cr9DYN9gTZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231852; x=1721836652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFnWgHqkW4KBRR6Q4YTMlaxQqxdSPuzETGsqd1MoLWY=;
 b=okL2a5DB8usyjtr5D+W1Qe5XRw3MLAMfDJq3YBzK3o8bpjXFKWloCgJQbL1k5ZspzC
 tD300FjelLd1Ab/tJ02gppNywlPc4Bm15obCeFjJBzcqPWNVdj1KR3PeVzvD4Z1Chr/0
 u3tz2pqhIHZ0sv1GuIsUkoHRZ+1WpPTofZGvFTUZjTXcHG1T2aHHjNh4bi2FqDBmqLLj
 pkx2rvgigcOdALXUwG51TWui9RLRVNwdcsJ7FHouMgF383U/rP9PFodPRk3CFZMGTN5p
 H4ENk78uuq8c8A3wbglWgL6ReoY1IjZa9S41eyRlvk73wjtcs9LE5TL8KuCAR/O3nJ0g
 pciw==
X-Gm-Message-State: AOJu0YwDgmhJec3by4wU7Bzc1RUlzh5BPLb2K5iIv3h3TwVzzZAi98Os
 q64qX2jhbSKHUemLKPH1hwgyJaODkPrEpFlXzUI4iV382cqBxpy72+KRDac0otwvaO+2zUD+7H4
 =
X-Google-Smtp-Source: AGHT+IGMvgtH68uBd/kXNQky98cflcjcaKNDgH3apKXJgTL6lbfSwkOxf2wjGwwyO2w32nV3H0DC0Q==
X-Received: by 2002:a05:600c:1390:b0:426:6ed5:fd5 with SMTP id
 5b1f17b1804b1-427c2cadee4mr16713095e9.6.1721231852601; 
 Wed, 17 Jul 2024 08:57:32 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 18/24] qconfig: Move commit code into a separate function
Date: Wed, 17 Jul 2024 16:57:06 +0100
Message-Id: <20240717155712.2913651-19-sjg@chromium.org>
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

Reduce the size of main() by putting this code into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 74d7d1bd175..dc5b7691064 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1574,6 +1574,24 @@ def imply(args):
     return 0
 
 
+def add_commit(configs):
+    """Add a commit indicating which CONFIG options were converted
+
+    Args:
+        configs (list of str) List of CONFIG_... options to process
+    """
+    subprocess.call(['git', 'add', '-u'])
+    if configs:
+        part = 'et al ' if len(configs) > 1 else ''
+        msg = f'Convert {configs[0]} {part}to Kconfig'
+        msg += ('\n\nThis converts the following to Kconfig:\n   %s\n' %
+                '\n   '.join(configs))
+    else:
+        msg = 'configs: Resync with savedefconfig'
+        msg += '\n\nRsync all defconfig files using moveconfig.py'
+    subprocess.call(['git', 'commit', '-s', '-m', msg])
+
+
 def do_tests():
     """Run doctests and unit tests (so far there are no unit tests)"""
     sys.argv = [sys.argv[0]]
@@ -1613,22 +1631,13 @@ def main():
                          else terminal.COLOR_IF_TERMINAL)
     config_db, progress = move_config(args, col)
 
-    configs = args.configs
     if args.commit:
-        subprocess.call(['git', 'add', '-u'])
-        if configs:
-            part = 'et al ' if len(configs) > 1 else ''
-            msg = f'Convert {configs[0]} {part}to Kconfig'
-            msg += ('\n\nThis converts the following to Kconfig:\n   %s\n' %
-                    '\n   '.join(configs))
-        else:
-            msg = 'configs: Resync with savedefconfig'
-            msg += '\n\nRsync all defconfig files using moveconfig.py'
-        subprocess.call(['git', 'commit', '-s', '-m', msg])
+        add_commit(args.configs)
 
     failed = progress.total - progress.good
     failure = f'{failed} failed, ' if failed else ''
     if args.build_db:
+        configs = args.configs
         with open(CONFIG_DATABASE, 'w', encoding='utf-8') as outf:
             for defconfig, configs in config_db.items():
                 outf.write(f'{defconfig}\n')
-- 
2.34.1

