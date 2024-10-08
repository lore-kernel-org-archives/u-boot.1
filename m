Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B41CEF15D
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 12:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBA688CC9;
	Tue,  8 Oct 2024 14:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lv/evRpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F1788B63; Tue,  8 Oct 2024 14:08:56 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22B088CC9
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 14:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c5bca59416so7542431a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728389334; x=1728994134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zr/CauuaArXl5CsTfXcc4vDzyG5ZDQ+WptpvKfCO+kc=;
 b=lv/evRpI2F7jHNiEs2zmNbhjQVYAb6/V/udCPG8elplNhdyXP9/O21N36y8u8EYCz3
 EEv/zOzPEreLnAYgBGCVb7Ww0OjmTf2XwAr3PAUUZYcsVACIRLouCQEtyFDrifdRQXXQ
 kMJdaIpoZB7GVkkIUENFfWMyO3VROGImL0JHSDWApZces5pvm6Yq0VGoOamW9jO2YUFn
 6zd6G7IYbiB8P0OsQ/mB1UKN7sT66U49XiEaJPtaOrPddCpSdcr2yDDYXHSAb85CrqVq
 /qZFdwB04/pimBIK/zFE3oXSL7v86iYFZdO5796kGc64IwWGE9fq8dlKTIFGloetvH/Q
 N9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728389334; x=1728994134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zr/CauuaArXl5CsTfXcc4vDzyG5ZDQ+WptpvKfCO+kc=;
 b=qvpKRf1vvOaaNgvNL00641Vdrj0fbOdYHqammjLowRqPNKGiER8bMhF1ChzR/w+/GX
 FOZB5LZAAhUnQZO71Rwj6Z7XUoDuXeIwrOhTe07WgO7T+CVTdTYgIPVVWqjqfjfJ+UqC
 70/KYO0fFGCH06XyCQKpCMaEEutFMuizUevnjIF6T/BqnxCxTA8RpkuQcqxwVBL8rmhp
 zdIzha+0nsQa9Dtf8oesAEPa3yMIgTSFy2H/rWMuWO01Xqw8hQJ4vIrgI+xtBSMOjOEB
 UBXPitCDoBgyq1yhIOxz69HyAGGFK1Z9sFVGHu0rIbNYLybUKm56bVNpUG7Q16hK6r7h
 x7ZA==
X-Gm-Message-State: AOJu0YyZI6/Pa/u+7ntNRRaI0bWgmJIuCKqGWJu2vuU+7hh5HoRmwhfD
 a0M9o/8CjJUeeUxeM5e0E0FwCWgM/z39hnK36N1gJJDZ7yDt4EGxpKdbLRdNxjkP4Z2kLaEIA6d
 w
X-Google-Smtp-Source: AGHT+IEcacw1cbMD8hxYF6gS5Z8pfllzT/dDd1rbEFqwxxamQt7GhsB8t1Kv6dydAmkPMUOj2HlKNw==
X-Received: by 2002:a05:6402:358d:b0:5c8:957a:b1e5 with SMTP id
 4fb4d7f45d1cf-5c8d2e43db4mr14879547a12.16.1728389334094; 
 Tue, 08 Oct 2024 05:08:54 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:ef1:3601:ac07:1ef5:efd8:a6ed])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05bc56asm4224749a12.45.2024.10.08.05.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 05:08:53 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Love Kumar <love.kumar@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] test: Fix skip check for sleep command test
Date: Tue,  8 Oct 2024 13:08:13 +0100
Message-Id: <20241008120813.622408-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

When the config option CMD_MISC was renamed to CMD_SLEEP the check
in the test for the sleep command was not updated. Do that now.

Fixes: 16060854095 ("cmd: Rename CMD_MISC to CMD_SLEEP")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 test/py/tests/test_sleep.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_sleep.py b/test/py/tests/test_sleep.py
index 66a57434bf..8965fc3fea 100644
--- a/test/py/tests/test_sleep.py
+++ b/test/py/tests/test_sleep.py
@@ -27,7 +27,7 @@ def test_sleep(u_boot_console):
     if not sleep_skip:
         pytest.skip('sleep is not accurate')
 
-    if u_boot_console.config.buildconfig.get('config_cmd_misc', 'n') != 'y':
+    if u_boot_console.config.buildconfig.get('config_cmd_sleep', 'n') != 'y':
         pytest.skip('sleep command not supported')
 
     # 3s isn't too long, but is enough to cross a few second boundaries.
@@ -42,7 +42,7 @@ def test_sleep(u_boot_console):
         # margin is hopefully enough to account for any system overhead.
         assert elapsed < (sleep_time + sleep_margin)
 
-@pytest.mark.buildconfigspec("cmd_misc")
+@pytest.mark.buildconfigspec("cmd_time")
 def test_time(u_boot_console):
     """Test the time command, and validate that it gives approximately the
     correct amount of command execution time."""
-- 
2.39.5

