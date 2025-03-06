Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877A2C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D2E81BC0;
	Thu,  6 Mar 2025 17:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rc+morsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00FF81D8C; Thu,  6 Mar 2025 17:05:56 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C9A81D27
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-855184b6473so58575539f.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277153; x=1741881953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHbemXiu5rRtYpiipAUbjOCQrUkto37/hy8eDHI+6Mk=;
 b=Rc+morsYW7l6NPW+YkUt/qtcbhKiJB7Ukke++piKp4e2oJ+hufcCjkjqeAugPZ9By1
 Etg4jdplwaYHWS1R1woq80GJbz33a+REv4qqy7FJRUxkj8CXaQcKcZvp+LDvyozMuCti
 8OeRKD7shY7VbhLRox0YBy8TRUs96H1KPs62Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277153; x=1741881953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHbemXiu5rRtYpiipAUbjOCQrUkto37/hy8eDHI+6Mk=;
 b=nnv90j+z8vEjnPP7hdlLGn74rXpy6UolXBWiTlo1PjsNNox0YGPDixVL2o8pT6NO9R
 +SHBu2qwX2Ud+4brglsbgx3XKgYokjLacJVPSrEbnbVfhEFEzUf7RYc9z8bQU1FEXowd
 XeCBxzkjpNMKGoyhbcoSnRQwCdQAeqwwH9SW37Fps7MI+xyrQzkdGPfDgHfdxamj6frz
 fEhS/UW5ht3E5FwVbT+2Sa+Vkx1TCoa5I5k4MSenPfEUKEg9MT+/ybFS5LPNlVpWJeKf
 GKb3n+NYk7/L3uhIPl6mu4TLfoFB9VvQJZ80SDj2hC3ejauUTko7Py6Wl91kRPX6qjW4
 JyeA==
X-Gm-Message-State: AOJu0YwVNQ4FodX0wFKK5alWyHpcHkZEjbpgiB1UcFLU0Gjlnn50Zue1
 iwoqt1BpHahqpDZAsQOkoRThqKKbB319NqzNHY9dmf30d2BSyIKfqFRqTSlpYglHK9KDAm8l9KA
 =
X-Gm-Gg: ASbGncttw0oD0OrJPsAJMig5WENcCQOPNmP8ZGAnKaNxqX9LZUDdjNIvUk6jEdvxuA1
 USc1FotatfE/GKf7ja5H21sImD0hY8imHeFVxdN5vkFA25MGzVe9Jny70pMu6TXCmaM99qOtyPv
 FICCswEP3JSPNH2ogSLU5ce/38+pYJG0rP8vBVtDprVx3lyb2qq3LenGu6aK6FxG/9NSaCIDGDY
 vOUk6ZVU/MWKyb3OFJa3trE3JHskwYi0DePqgE4lWdVA3ddTAHdcx/1iLOE51IL2YZDdwuO+pH1
 Z8wMr940tDYapaH62zYVLY/owYvsQ0rCcJQmgp3uyyOMCSvUyCzfj0cLahYhZ5YN73XW+dydoEA
 qNLgpvQ==
X-Google-Smtp-Source: AGHT+IGHnqB8AWc0PzVtMK2GlYzU5TgnKYUCkULhor2BOo1eVcGcjZBzO9UTxvybVrYKQnYTjL+80w==
X-Received: by 2002:a05:6e02:2168:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d44193d992mr471415ab.7.1741277152480; 
 Thu, 06 Mar 2025 08:05:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 31/47] test/py: Allow tests to be filtered by role
Date: Thu,  6 Mar 2025 09:03:58 -0700
Message-ID: <20250306160428.3041057-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

(no changes since v2)

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

