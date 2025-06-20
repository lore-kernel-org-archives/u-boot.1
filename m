Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E11C7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 16:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B1080E9A;
	Fri, 20 Jun 2025 18:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AiLHb6H4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CB482D2B; Fri, 20 Jun 2025 18:25:08 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E49C180C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 18:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-408d14c7e92so1537985b6e.3
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750436704; x=1751041504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Chhh+xZj3qs80nPbBszT2sig8/hDjbUufeKHbBkXhzc=;
 b=AiLHb6H4/zbLwT2vwG+Ewe/B5X7N1/ZX4H5Vp/IugrO2ez2EBDR3cON0Z7wApP7k+D
 mEAiGZ8L77p6G7DnLHDlkoAF/upbtnnZItUW/t0FL4OGMH0CZwxn+FOUjoBuUKACHb78
 bAP/jEw+MEfAKOaNwJFfNdagQ/mjyppEX46DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750436704; x=1751041504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Chhh+xZj3qs80nPbBszT2sig8/hDjbUufeKHbBkXhzc=;
 b=lknR1UiTe+GQqtJvJQOsi3q+yFXuZRJQ11YDHbNcXtfpqcLBwmBUEz1ERVm8Of8POZ
 9mps0WqNJnnEOGNjzss9K7XAC0kjR+BjCJJ845VEXVj+6hVusy0SaHDTCbGBClOaB7T/
 k7NuNgzEUakU9J6To4hK+pA4kiS+y16f8TC0UsFKPRR2SW1LO9s0wjhTPKwThvIKXDDq
 JNPL4HlUIAb/G2adkSEI+vLnYhHZ24i02zVfbA4RzbHuTiSI+jprDLnTWuTgni95Ajxe
 h2qGFiFuZKJmjY/u4yLWzOGZahkRf2rQ4yebJipaFR+U8OURwGfTrhu/A402ysHg+Pcb
 vHCQ==
X-Gm-Message-State: AOJu0YzFRYJ0C1rOB/2fOLrraXQIKGnvKUsnkN9VVyy1c4yNbmM9JdUz
 /Oe0XypEACdPZY4762EwTuIkGXvlAZ4syK3qUlmaevzXaJflooezc//jOmXaLrEJkIETu9D/PUF
 swmYWpHQ=
X-Gm-Gg: ASbGnculzVP193IrHNl56JglcscUr1DDxywiptZ8TOJM1LMoqFEDhXXw7jUpK9023Ov
 6DKJmIuEQQITyz7UlPY4K5TDQqLMGEUOjnPC+i8nfBXtU1tMV+W1IVCW6OBR68ycWBOSQHNR+2y
 uYIbIj7/4L9l7YLHMKNCz0eX+0IG0+29WUhtZ14SBIkNDGGuMra3loKvthYGzq+COwUCbsPlgIL
 +H/Bm+CW1NU911GlZKSFQkAJMWLSinxCIGzbuoBwNMJs/60vJ1Hg394OYsUem+qS/VbbV7X7hJr
 Yy21kZGKw4yCd3ZuaO31GWSU94btUldZ8WibQhM39qwSQ4Xt1JsOYLEODI5LHc+8Ht52JnwHv+z
 JUHGrtxNyqFOAP63N8wDUP6i+NA==
X-Google-Smtp-Source: AGHT+IFFJxVGqqjB91gKL6qfk91cVr5/ZbnRqIsJlpip8szB2IGufX3ihvgYL8B7uSCetu4+PcLYTQ==
X-Received: by 2002:a05:6808:2018:b0:409:f8e:7274 with SMTP id
 5614622812f47-40ac70a1e3amr2835026b6e.18.1750436704558; 
 Fri, 20 Jun 2025 09:25:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90aee7f7sm374907a34.8.2025.06.20.09.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:25:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] tools: rmboard.py: Fix conversion from run_pipe to new helper
Date: Fri, 20 Jun 2025 10:25:02 -0600
Message-ID: <20250620162502.3419508-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When this utility was converted from run_pipe and to the new output
helper, two problems were introduced. First, the conversion for calling
"git rm -f" wasn't correct. Change this to match the other conversions.
Second, the final call we do we need to construct the list because we
print that command for the user to use to inspect remaining references.

Fixes: 3d094ce28a22 ("u_boot_pylib: Add a function to run a single command")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/rmboard.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/rmboard.py b/tools/rmboard.py
index 594fd89b8d78..21d68c572618 100755
--- a/tools/rmboard.py
+++ b/tools/rmboard.py
@@ -112,8 +112,7 @@ def rm_board(board):
                 rm_kconfig_include(fname)
 
     # Remove unwanted files
-    cmd = ['git', 'rm', '-r'] + real
-    stdout = command.output(*cmd, capture=True)
+    stdout = command.output('git', 'rm', '-r', *real)
 
     ## Change the messages as needed
     msg = '''arm: Remove %s board
@@ -130,7 +129,8 @@ Remove it.
 
     # Check if the board is mentioned anywhere else. The user will need to deal
     # with this
-    print(command.output('git', 'grep', '-il', board, raise_on_error=False))
+    cmd = ['git', 'grep', '-il', board]
+    print(command.output(*cmd, raise_on_error=False))
     print(' '.join(cmd))
 
 for board in sys.argv[1:]:
-- 
2.43.0

