Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA314C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A8C88809;
	Tue, 11 Jun 2024 22:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LgFmgXb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA909887B6; Tue, 11 Jun 2024 22:02:40 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43628859A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-36ddf683ad7so6724265ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136157; x=1718740957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xrk66g0HtXE2BUPgxaLISVoF0S1VL3an45CfFPnDPto=;
 b=LgFmgXb25wZ/ckBjrq1uj79IjKEW6X2uN5xpBgYilzaIBvRbLXLVnYL2ehgqUlLsvU
 qcfPDg7J1BFdhiMsrSgrpZCBjg154f2/yb85gG2yQWlVd5r2V9WASNPMuim6ZjNd1DHm
 l2ope1/4C5aWaIrPkl8tNiGEhRlQm4di0ux4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136157; x=1718740957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xrk66g0HtXE2BUPgxaLISVoF0S1VL3an45CfFPnDPto=;
 b=NaXzMR6sj/aWOjY1upaVASnT7m6VOZXcEbHMn2AHxi6bvQ4DlVo/rSLbjfbcrHTmTQ
 dAQjS0v6MhJRlRy5a+a4WVVvXor3RL44cKbjcj1MBE1237ZzcRdRNDkQKIBhP7w+Hs9P
 2fUc+vjXMDU01wBqNrSWGmAB7z4EknJkKOuFdDZFOoyvxWTbL+8UkVuoWSXhciiNM+7N
 s8Lppb7ZSUA4we0XUpFCw/R7qgJcp5BtzSRfnnpZzGS0St3a491T7stwrZ6ns/0/PGio
 bGRYUKi3FqPFGqQrrIhhKXGWjWtRcuIZVtpf7THbXg9G0zzJVPEvicCZEn6Ef4v8e+d0
 aLLg==
X-Gm-Message-State: AOJu0YzJzXNGkOiS7K4zCngqHlAbKwa6dsu9FNC3+m8BW4Eqcy+8w82Q
 604pz7OkCRviDbBLpYZDm1WB5Yd6lZV92AAOT3HS72HtYryDaCKYiNhq1SJDTWWRj/Zc8DITGrs
 i2A==
X-Google-Smtp-Source: AGHT+IFmECS+W+QmXDwz7uYbkSuIxxdlWUMRJOpCHvxvWLgcYyjAYtugveQBv56dh6h8bPRiQr08DA==
X-Received: by 2002:a05:6e02:b25:b0:375:c443:9883 with SMTP id
 e9e14a558f8ab-375c4439b6bmr17265155ab.21.1718136157420; 
 Tue, 11 Jun 2024 13:02:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 29/42] test: Check help output
Date: Tue, 11 Jun 2024 14:01:43 -0600
Message-Id: <20240611200156.2245525-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

The current test doesn't check anything about the output. If a bug
results in junk before the output, this is not currently detected.

Add a check for the first line being the one expected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_help.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_help.py b/test/py/tests/test_help.py
index 153133cf28f..2325ff69229 100644
--- a/test/py/tests/test_help.py
+++ b/test/py/tests/test_help.py
@@ -7,7 +7,11 @@ import pytest
 def test_help(u_boot_console):
     """Test that the "help" command can be executed."""
 
-    u_boot_console.run_command('help')
+    lines = u_boot_console.run_command('help')
+    if u_boot_console.config.buildconfig.get('config_cmd_2048', 'n') == 'y':
+        assert lines.splitlines()[0] == "2048      - The 2048 game"
+    else:
+        assert lines.splitlines()[0] == "?         - alias for 'help'"
 
 @pytest.mark.boardspec('sandbox')
 def test_help_no_devicetree(u_boot_console):
-- 
2.34.1

