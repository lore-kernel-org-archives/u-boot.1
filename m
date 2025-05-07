Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58569C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 22:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE63829A1;
	Thu,  8 May 2025 00:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uSZ7Hyrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3C2828B3; Thu,  8 May 2025 00:11:24 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E2E38272A
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 00:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3feaedb39e9so156792b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 15:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746655881; x=1747260681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzeTlZy8PG+n9Eb14y+UFBtuAh4RrneKz2LrQrHsrOE=;
 b=uSZ7HyrhCgS6YB58Mw5fkhWdjIhmr8e892cnQ9SGLPobKgSukwvCXvhASF7hXxS/iO
 ++uGjBx9luvvidtRZrLOwaJavVyvSZqT7QzKGdScfScih5GR7n1leG4Nt9RtAGrtzxxW
 Pm2sosci+bGutS95EpAKDzAv9hN95B4T63sgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746655881; x=1747260681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzeTlZy8PG+n9Eb14y+UFBtuAh4RrneKz2LrQrHsrOE=;
 b=p3FB/cu896cLq+luzYeDCWi/DacDPXXITfLXX+6+L/wTi9wf2cnl+ExGDHfoF+ggie
 wuuTzGxyFC7dY0ZeHP+pxhlLuv8O3v6/hifqV2jAtR3rbB75Z22kgWaiYqyzQ2a0LupJ
 bf602Hq7uQqMEYroczCMxiFuXZzyLrHWGVKEouxUp7Jj++DQrWHnz5G3/P0MFxQ229dO
 EaGC4tIN+7D1siLdI+iRBILdzHSWzLen+wtUK+ZSNB43P6gZOMoPRRpCVTPMMI69scjS
 tY7iaxAAFqOkrJJY6jCDX5anbmEDp5zVB9iiT5ShdnOaxYhlvwwrHhPzIMoRik1nlumk
 WMZg==
X-Gm-Message-State: AOJu0YzOHrNxlh/PQyVOmAoFYwuao5SFIkQueGK6Pp6pE1OAmOShwWCl
 IhWJDfF2iFST/4D482/cfGbhWC9DGgNnRjKnrMnAc0LDtSOhazibqqkY1S0Vh7z/wPYc1k4g9yp
 N
X-Gm-Gg: ASbGnctAGQ1S5nqO/+amxtUdmNJNpFz32VqcBcFIEC9bVq8CoM6QiOGb8OrcJattiaB
 yoip3MJHhaXu6hdrmntm8Du/Rwu+XmLlDWYQ5VrYTuTVyCZQBpzc0hrb/1HZrj71Cp4Da/pDDpw
 vI9S83EQ38VW8FoTfY3VgWflFiLfMdRnzK6CRwkp8dgDBrkBd+RGU045BB5MTztQYiBmmK2swBe
 yj7Ql+N49DWHdxDJ/op+2c4NOFNpibhiSfn9JfebygV7Wc9WBd25WKFd9NuODx48hXFrDPwEJgc
 CXXZ0lfqednHpMqnMZKNIFQAJFBK8sVYuUi9VOIX7vlZ+o3ry3OV65bop4sCkQ7oleaM+VVuOXw
 9abQT
X-Google-Smtp-Source: AGHT+IG5J2F5Qi3+nnqNUqIrTrSngokTUYMwbMspm1piBBJabVZEwBlXliQkt+jMQX+lUC9Y9rfYDw==
X-Received: by 2002:a05:6870:1585:b0:2c6:72d3:fc93 with SMTP id
 586e51a60fabf-2db5be13542mr2933439fac.12.1746655880776; 
 Wed, 07 May 2025 15:11:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbf16f1sm967181fac.20.2025.05.07.15.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 15:11:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/4] test: test_net_boot: Add more comments
Date: Wed,  7 May 2025 16:08:20 -0600
Message-ID: <20250507221112.518041-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507221112.518041-1-trini@konsulko.com>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
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

Some of the functions were missing pydoc comments. Add them so they will
be included in the documentation.

Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 test/py/tests/test_net_boot.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index 6585f0574c01..72086a74637d 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -133,11 +133,21 @@ import test_net
 import re
 
 def setup_networking(ubman):
+    """Setup networking
+
+    Making use of the test_net test, first try and configure networking via
+    DHCP. If this fails, fall back to static configuration.
+    """
     test_net.test_net_dhcp(ubman)
     if not test_net.net_set_up:
         test_net.test_net_setup_static(ubman)
 
 def setup_tftpboot_boot(ubman):
+    """Setup for the tftpboot 'boot' test
+
+    We check that a file to use has been configured. If it has, we download it
+    and ensure it has the expected crc32 value.
+    """
     f = ubman.config.env.get('env__net_tftp_bootable_file', None)
     if not f:
         pytest.skip('No TFTP bootable file to read')
@@ -213,6 +223,10 @@ def test_net_tftpboot_boot(ubman):
             ubman.cleanup_spawn()
 
 def setup_pxe_boot(ubman):
+    """Setup for the PXE 'boot' test
+
+    Make sure that the file to load via PXE boot has been configured.
+    """
     f = ubman.config.env.get('env__net_pxe_bootable_file', None)
     if not f:
         pytest.skip('No PXE bootable file to read')
-- 
2.43.0

