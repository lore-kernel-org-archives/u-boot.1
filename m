Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837ACC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9852885F2;
	Fri, 21 Jun 2024 21:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MXDTmwTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 475788857E; Fri, 21 Jun 2024 21:52:36 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1943D885F7
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7f38da3800aso67415639f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999551; x=1719604351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tbJLNnm3Z118ihDJe+gI1HEGhxpJQOMu7FJdqi+hsQ=;
 b=MXDTmwTwizYLLKasQXuNtmBwduQ3+P3Pja0OqdLjxmy5gv1+yFx55SBPzw4hQc1pDq
 J1G5cG4THhn+JJFGEb8GHqZ1OM4+9zdsvOGdLBepQpj+hzgW81VsEGg8n+FBtbnEiyAJ
 PBk+haFpXcJg5RgD9R3QvqlRazWSNQePSPpgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999551; x=1719604351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tbJLNnm3Z118ihDJe+gI1HEGhxpJQOMu7FJdqi+hsQ=;
 b=cLlZgeT/PhxuB80Zf6WdCgOhk5/0ybzVao5AOLbdPqcfVmeGqgaWOjSriIztSfbDa5
 jtGn0nJ7ouuE86De+MvG2bwvuYrcvH9FHwkga3bB56DAhBjwU5kD611d1GOxcJraw8TG
 Mx36r4mexK85uQhZOtk8DbhYeYquKZ1+hg3IflO7nPRkJooxe0bz/PoAbMrPyPLASCGX
 YnZhL2SqNtkxjmbeYkoDJyBAOTM/E6+HljtZOJvVls98mhTZpfgpKieMOm38D6EYSpfI
 BGFAP51gxDPzju/8C2+EDiHE+otlbXNTo6zZHCRl46lacgfpuwqG/JTFpRSOWvuFOha4
 MvOA==
X-Gm-Message-State: AOJu0Yzm+SlNW+3U8L/wI8LqiWsnzxEENH/0pDfqqsporlIBGDb4lHnR
 AV5YNp5IOJAP2KI0os7WhXA9EDZO+aZ27vHRLybf7ZHGlJEo5js7kZQJQcsBQFI2hyngMPzY5iA
 89g==
X-Google-Smtp-Source: AGHT+IHu7L88Stc0X5GXD2RApq4dKZjTTXvg/9BhIE1+HSxZjfp1YRH9H2qAhsFKnRZDEUMU+E9sYg==
X-Received: by 2002:a05:6602:2ccd:b0:7eb:7e0c:d195 with SMTP id
 ca18e2360f4ac-7f13edcf244mr1215751539f.8.1718999551654; 
 Fri, 21 Jun 2024 12:52:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 28/43] test: dm: Show failing driver name
Date: Fri, 21 Jun 2024 13:51:49 -0600
Message-Id: <20240621195204.2675252-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

