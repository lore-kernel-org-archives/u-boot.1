Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE0AC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4B688548;
	Sun, 23 Jun 2024 22:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WVw7BN6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4446788477; Sun, 23 Jun 2024 22:30:49 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8E1882EF
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7ebe019b9cdso138613339f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174644; x=1719779444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tbJLNnm3Z118ihDJe+gI1HEGhxpJQOMu7FJdqi+hsQ=;
 b=WVw7BN6vpnsI3Xl27/948lmO2MsQNdohf6xvxrEzDI7eZTzPYkYbptsSyxNU85vY9y
 XVJ+D4XQx8Qq0Iq1WkHzkm1qaDo+EQplXR7OKsMZq7DVPMfvpbqn0Aaytvz46TayJQZ6
 He2NPvQ6ewR9w3SF3e7uWuPiYouhW7osZz+04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174644; x=1719779444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tbJLNnm3Z118ihDJe+gI1HEGhxpJQOMu7FJdqi+hsQ=;
 b=Ts2f3mpDK4j/ZWVIiWEuBcESFeHXErlmNxVPGsideEA+Ko24r6ZYaHISRC1wYLZxA/
 4XwIbjaGLGiWjf1PSV5kvMWa7Q2daA7+yrU8uz9vwAyuOKTATHcWmmNtzS0MYmoB5RTJ
 8+MUN/MxMsgonp7rp6R3GV+O9xKPbGTSXbR37Ymly2ijwzT8iAcWLYsIUO0Djd+/dHVL
 EFJhqgETQqpWfLFJPa1GuiqYo/8jqakh3e6aFIo8jhu3BXbG3Dd8BZjx3wg0wjPmmL/d
 wZqxdRkabtyPhnf3okSeAcp3P15l0LvzoxwpRvZTaPByk7owg+enKsMeitBAV3TKkBZI
 EIsQ==
X-Gm-Message-State: AOJu0YzBce8Tn0hYPEFeKyPt+GfqJaiqVEZ1Z206NzIUozuP28On5tia
 80xMOLwsXtt/rCtbF1e3fVTb9ttXVfoa9zcMZ7Ew459Vvi1gmV3JqvUiuboBTB6iw4W3sXfeyx9
 1sg==
X-Google-Smtp-Source: AGHT+IGyTshpPS2u2DY/rJEwD7qWMgd2Yal2t7KcgleqNpIA5W0AoXAreVAINnWX+FMgGWMrKOwgOQ==
X-Received: by 2002:a05:6602:14c2:b0:7eb:6cbc:8856 with SMTP id
 ca18e2360f4ac-7f3a7480881mr354060039f.2.1719174644292; 
 Sun, 23 Jun 2024 13:30:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 10/14] test: dm: Show failing driver name
Date: Sun, 23 Jun 2024 14:30:29 -0600
Message-Id: <20240623203033.1566505-11-sjg@chromium.org>
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

When a driver is not registered properly it is not clear which one it
is. Adjust test_dm_compat() to show this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_dm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_dm.py b/test/py/tests/test_dm.py
index 68d4ea12235..be94971e455 100644
--- a/test/py/tests/test_dm.py
+++ b/test/py/tests/test_dm.py
@@ -13,8 +13,11 @@ def test_dm_compat(u_boot_console):
                for line in response[:-1].split('\n')[2:])
 
     response = u_boot_console.run_command('dm compat')
+    bad_drivers = set()
     for driver in drivers:
-        assert driver in response
+        if not driver in response:
+            bad_drivers.add(driver)
+    assert not bad_drivers
 
     # check sorting - output looks something like this:
     #  testacpi      0  [   ]   testacpi_drv          |-- acpi-test
-- 
2.34.1

