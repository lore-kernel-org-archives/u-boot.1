Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9438DC3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F15682B31;
	Sat, 10 May 2025 13:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FrkchHCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3C982952; Sat, 10 May 2025 13:06:26 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 998E882AE9
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ad228552355so207887566b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875183; x=1747479983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJmznEGqi/t7VGwDMAdlCEP44N99Uj6AUVHvk8Uq98I=;
 b=FrkchHCQIpNXZGUHcu2rvgU6uj44vY7CNN789AknsEKAhSlEanGc5pqP9AHRXl2lbo
 98efp3DfBX00j7bbeH58KBQBkO4PElx6haz/n2xUNraBx0sy+B+DG6mHdBOh5ApTGaYc
 6ffG6SmJubVzx9jzojye8uM28F+IUbGRtCkLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875183; x=1747479983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJmznEGqi/t7VGwDMAdlCEP44N99Uj6AUVHvk8Uq98I=;
 b=LEHnvU/UZDNj19jHdzatTiPab2EZF9aLW5IkfgetbWi0wGwBXhzeT6N1XkN6dpRLJ6
 8hKlt8gZsLrm6pAaKR7YEk2Ph6HIJ/aTxGslU3xEYO1oEn6/8iflScVKwVUw+VbCNKyJ
 hKDvfCsWGQ39SFPsPCGvIS+eUbCes4/biTCePL02SzTE4EtxaqurFBRdtThftyJMu4bN
 KQgtrQEpBHI8+shHYeNsL9scPx+Fe+yVLSlJzzrioXmf/U7J5DGjDsPkFWaR72+zwQ3e
 qmwVhWwi+SAKqXvBeMBsNHNK3VsUHJ9XKWOi5NkYRQuwSk/k2UYVyak0YmqRHNcplNwY
 d3Cw==
X-Gm-Message-State: AOJu0YwT9io0p0tPCXINVKcFSK20TduVdmXHkz+GK6AUA4u4yTZYhIHf
 SRjDm8Q9R4uhoCDpd637u1cuS66UfBwb936JPvIdldUO1K8ebfngVBZYpWTBsmeO2Duraaw8vsf
 6jOuuX+GQ3Q==
X-Gm-Gg: ASbGncu/f90rHJjBsX+9hQEkJXUnuJosMq7uVgTgMNeNsWe9ytcxHrOs1isQwkpm/vx
 kiFjlHWXvxZFTvBw8SzR+dPD9iajyzGP+4oPfNWOQN5QmNHVzD9N2KjSdQhpu3SA6sqdD/C6FFt
 kDJMeW0Cw4BVcDsnVOwoL6MBysDUEI02jksFGUnTngnvPgPZ1qUAfBOl+2y+UmveJvVEJRtpwI+
 TOhKtc5KSxMe63hvJZLy3ZiY/3px4LHh5dqcVJstZwdLxqUAY9779TEyppfXUNxsrGkqAj5glee
 IN1Z2tPS9i48NEAZefQnY4zHiMyHbTVGJuHLOgNJ7Zlpx0g=
X-Google-Smtp-Source: AGHT+IGFhgo1xb3JA+pzvSqtmtR2dSZSUSTy3UQAbKF+sw5RioFnSTAosFiYWxX4TxjXBsvNusar9A==
X-Received: by 2002:a17:907:86ac:b0:ad2:43be:6f04 with SMTP id
 a640c23a62f3a-ad243beca43mr8220266b.51.1746875183501; 
 Sat, 10 May 2025 04:06:23 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/25] patman: Support aliases for commands and subcommands
Date: Sat, 10 May 2025 13:05:13 +0200
Message-ID: <20250510110535.1453745-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

It is laborious to type long commands, so add some aliases to speed up
use of patman. For now, allow 'pw' for patchwork and 'st' for status.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 5943aa7e47c..18434af4cb7 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -20,6 +20,11 @@ from patman import settings
 PATMAN_DIR = pathlib.Path(__file__).parent
 HAS_TESTS = os.path.exists(PATMAN_DIR / "func_test.py")
 
+# Aliases for subcommands
+ALIASES = {
+    'status': ['st'],
+    'patchwork': ['pw'],
+    }
 
 class ErrorCatchingArgumentParser(argparse.ArgumentParser):
     def __init__(self, **kwargs):
@@ -126,7 +131,7 @@ def add_patchwork_subparser(subparsers):
         ArgumentParser: patchwork subparser
     """
     patchwork = subparsers.add_parser(
-        'patchwork',
+        'patchwork', aliases=ALIASES['patchwork'],
         help='Manage patchwork connection')
     patchwork.defaults_cmds = [
         ['set-project', 'U-Boot'],
@@ -173,7 +178,7 @@ def add_status_subparser(subparsers):
     Return:
         ArgumentParser: status subparser
     """
-    status = subparsers.add_parser('status',
+    status = subparsers.add_parser('status', aliases=ALIASES['status'],
                                    help='Check status of patches in patchwork')
     _add_show_comments(status)
     status.add_argument(
@@ -278,4 +283,13 @@ def parse_args(argv=None, config_fname=None, parsers=None):
         argv = argv[:-nargs] + ['send'] + rest
         args = parser.parse_args(argv)
 
+    # Resolve aliases
+    for full, aliases in ALIASES.items():
+        if args.cmd in aliases:
+            args.cmd = full
+        if 'subcmd' in args and args.subcmd in aliases:
+            args.subcmd = full
+    if args.cmd in ['series', 'upstream', 'patchwork'] and not args.subcmd:
+        parser.parse_args([args.cmd, '--help'])
+
     return args
-- 
2.43.0

