Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBD7C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D0F80FFC;
	Sun, 16 Feb 2025 21:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aT+uQfYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA2480F91; Sun, 16 Feb 2025 21:45:59 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C696B80FB8
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85586bc5086so16803939f.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738754; x=1740343554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uR6tSyVJUKZDnS0HQRCmoPSZQ+IImaaZmG389bMvQxE=;
 b=aT+uQfYnbQItbk/2++gowAq+MWKzf2DFte/TUQ18xdM74zDDOw4rJuWz0aphc/wEE/
 /pMr33IozSi0HYVBbS5cyUOaPk5tQnM+PMPXzF62R3ZvG5XW7t86OHlLRKU2QNt2GLXW
 //ZF7L+M5FDgPGJOT5yQnQoKu2qCrcEeuofKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738754; x=1740343554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uR6tSyVJUKZDnS0HQRCmoPSZQ+IImaaZmG389bMvQxE=;
 b=JPWvLcjXcwRHBVAXYHoMV7oYzSVWJr8zDjOqqVi09cJfgMbLvCN+yh5RyDDDw+2SMh
 HtK+QLMIotffRkiEVxUJsXn5mZkuOU/XPnp39hUbmuiSYaoKxRiGZj7tbZ1A56erfxpH
 ua7ud2W3mPV78pB43RIttMLeycFXkHWIe2OVX8VJ34VY5qhnF3buuNp9Pk7Rm3BQ6ObN
 +VzaAiiHhlSHIcCt+IBY+Nzgvh4TRbBmxRYc0V2kILBDYpD1K5v7i+7jMqlsims5dzj/
 tOMQwwKF3WftLmUTW7dWw7IdMfBTuVv7AY1kAHZVkMn91vbzMWZAcGlO45I+8ZjxDE5h
 E5xQ==
X-Gm-Message-State: AOJu0Yw0Uecc4mbptDsi2DJRiTln8QZLIRFvh+oxJNtUbcSgHGUs6/Ls
 BLIS9WbAL5NMKn1FZ6zAIPMcitHZTdz9TthyX3qj9VmCw3EONrnaPFwAFlAc8qSbRySNzvaMWWU
 =
X-Gm-Gg: ASbGncswes70O7M/p6kNHfKZCusdTM8lk27NERAHq3LmIP7W/fJj2kRK8j9EEuKd8HT
 SCOWZI3BDVPYeA9+VJ/FZBB6UMQJXcNLwaUsI13Uh61cHM4sigfbBlTBNE8fxCtanhG00/IZRbP
 PHoBx3LjOBcrBQ6IvAs4XrA8hg9asHTrk5QniYgcXGFNxUlDkJWFu9N/N97cfjLU5i0vZP3F/Aj
 6PqqvykEji2qJ3Dv3QiiPrAFH1hoIO4qE+rB/Yrdt6YOWQ3HkAesNhCOFdbTmygripE319WrApy
 Y50QDuJTJqZt3VHQ7cLQlstsmOoV13bRE8nsktKd7Fw3H2Iot6+q
X-Google-Smtp-Source: AGHT+IGT1dJZYjbDDQnhzaAugNtAuveOjXlWD5DcBElNEFJOG3RvxBXaQCN1zuc9kDMDTS3/Rai3cg==
X-Received: by 2002:a05:6602:60c5:b0:83a:b43b:da89 with SMTP id
 ca18e2360f4ac-8557a1190d0mr445246239f.10.1739738754547; 
 Sun, 16 Feb 2025 12:45:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 26/28] test/py: Allow tests to be filtered by role
Date: Sun, 16 Feb 2025 13:44:11 -0700
Message-ID: <20250216204421.3560012-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

Some test can only be run by a particular board in a lab, e.g. because
they are loaded with an OS image used by the test. Add a way to specify
this in tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to allow tests to be filtered by role

 test/py/conftest.py | 22 ++++++++++++++++++++++
 test/py/pytest.ini  |  1 +
 2 files changed, 23 insertions(+)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index e59897c1f78..5aea85647af 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -334,6 +334,7 @@ def pytest_configure(config):
     ubconfig.dtb = build_dir + '/arch/sandbox/dts/test.dtb'
     ubconfig.connection_ok = True
     ubconfig.timing = config.getoption('timing')
+    ubconfig.role = config.getoption('role')
 
     env_vars = (
         'board_type',
@@ -760,6 +761,26 @@ def setup_singlethread(item):
         if worker_id and worker_id != 'master':
             pytest.skip('must run single-threaded')
 
+def setup_role(item):
+    """Process any 'role' marker for a test.
+
+    Skip this test if the role does not match.
+
+    Args:
+        item (pytest.Item): The pytest test item
+    """
+    required_roles = []
+    for roles in item.iter_markers('role'):
+        role = roles.args[0]
+        if role.startswith('!'):
+            if ubconfig.role == role[1:]:
+                pytest.skip(f'role "{ubconfig.role}" not supported')
+                return
+        else:
+            required_roles.append(role)
+    if required_roles and ubconfig.role not in required_roles:
+        pytest.skip(f'board "{ubconfig.role}" not supported')
+
 def start_test_section(item):
     anchors[item.name] = log.start_section(item.name)
 
@@ -781,6 +802,7 @@ def pytest_runtest_setup(item):
     setup_buildconfigspec(item)
     setup_requiredtool(item)
     setup_singlethread(item)
+    setup_role(item)
 
 def pytest_runtest_protocol(item, nextitem):
     """pytest hook: Called to execute a test.
diff --git a/test/py/pytest.ini b/test/py/pytest.ini
index 26d83f83e00..361be0178ee 100644
--- a/test/py/pytest.ini
+++ b/test/py/pytest.ini
@@ -12,3 +12,4 @@ markers =
     requiredtool: U-Boot: Required host tools for a test.
     slow: U-Boot: Specific test will run slowly.
     singlethread: Cannot run in parallel
+    role: U-Boot: Indicates the lab 'role' which can execute this test
-- 
2.43.0

