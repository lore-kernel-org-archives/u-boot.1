Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E9AC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0432B8857E;
	Sun, 23 Jun 2024 22:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mIoseX50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFF487572; Sun, 23 Jun 2024 22:30:50 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34677884D4
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7ec00e71a57so141390239f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174646; x=1719779446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjl01oo/zYgNsESARtjMuhhXIjsgTRhjuyoEbdCHLeY=;
 b=mIoseX50vyCC3kCTlH4kXHFQN8DqjddLwagLq5dDd1ilT5QHCK+w3mLaC/zheyC7Z2
 jPi3p5PlKJosnmJphy1+k1akA0a/oM3rM/T5aK4IyZHv+GCavV0Fnz797pVk51kf41/8
 sZnY6LgdMcvRzkTHv/ZHu1+Cw0+v7569S0q08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174646; x=1719779446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjl01oo/zYgNsESARtjMuhhXIjsgTRhjuyoEbdCHLeY=;
 b=OiCjqnHvErRMyKc0YzJcnvmFzBRWMPW5hVuVU5lY5rEp1LOWhdIoX3zjhfML2t89OX
 5clytG0+WOYWy+XVbMpLeqp8p2harKxL7yUuv0mzWNIfOWPw9FzLzHeJH4IxpKVXdnzd
 M2nyA3Cb7Gmizp2odJYQv7/pLjeKmcR8sbpLxtr2ajYb8bUmM4WcnEzmBKVwBHTizdmW
 7YYa5W+tiwYSQ+kMpp43O6UCYxMKud6ui1eeU3od0WXXgrtQFuto1i0ou3FBKsJekYat
 aPBdZDStt5zjiyTamFHZ61/yPN9GC+rtNfCHCm266LOBh5hAYQ7kmrCxjEOsp7OrXJIx
 WbCg==
X-Gm-Message-State: AOJu0Yyqddn6Bmj8nv97aiV9oTzR3xKyhEVI3uecI/yWbmUGnlEBC8yE
 RCdDyJOUauIQy+KvhhPdi/ld/x8IJ2OOS0lmrkaf6aA/RIENXyeXLBkQHXg/8yh3vC/4QIqnQOV
 J7w==
X-Google-Smtp-Source: AGHT+IHSFaiPKG2dYwRA2W5PDJxkeqmImzjZJ/O+CdSjeDrN6Ezjjh+KAHGadY+lzyGNAS4Sg7UbUQ==
X-Received: by 2002:a05:6602:1655:b0:7eb:f3c8:c59b with SMTP id
 ca18e2360f4ac-7f3a7592b5amr481180539f.2.1719174645869; 
 Sun, 23 Jun 2024 13:30:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 12/14] test: Check help output
Date: Sun, 23 Jun 2024 14:30:31 -0600
Message-Id: <20240623203033.1566505-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

(no changes since v1)

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

