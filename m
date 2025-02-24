Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18110C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63BE0811B3;
	Tue, 25 Feb 2025 00:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PriQF0TR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A100811B3; Tue, 25 Feb 2025 00:08:03 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9256380F67
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3cfc8772469so15800635ab.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438479; x=1741043279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHbemXiu5rRtYpiipAUbjOCQrUkto37/hy8eDHI+6Mk=;
 b=PriQF0TRpZwD6Pr0VGj90yYKoIljAHWOpBe0/V5PlKV/NJRqRxa/YHhA5grv3WtWru
 /7LsetHXSI0ZSILQgnn0y6TASscr2fIjq22IF+XpM23MVlO5z4vD09/lWfsx2dRXCE0Z
 rMo/S3vtZawxFT87Jp+EERzthTsN+LuLKIb1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438479; x=1741043279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHbemXiu5rRtYpiipAUbjOCQrUkto37/hy8eDHI+6Mk=;
 b=AF4Ptvo3j5ADE3fM9AHm3b5VnrCD4gPKnXUB6alNTL/jJ+LU4CrnI5JzBEoSrhIsdI
 5IwxLC1egew0MIBKDQCpMTE4lPCjp64vEearp8IV0SeaewswApns25K38QaBpqdjmVq4
 sP6R7JfuTJ3XSTNVPtxX/OsnVnO27z1gaahNVJFFR4qqTSwdn7rVJhdiYSZaqEapDSVf
 17JQOv+fyOp2Q980PKqxPhtBUwq2N9qspuAMVsfP3QsvsrP6jxopmDzBDlt8Qv4/leqM
 xIjM7v62vIgAgdu+pxr9cEr1LmWkLzpYoeeOa8OyHMV3FhRZ1I6G9BC8BdMSsphU3COt
 4UCQ==
X-Gm-Message-State: AOJu0YyHr/BYaPECp0LN0hVzBbZVBbz05xsI/dkMKQE8G+2jH+V0qnd2
 pMwUvEoHlPccOr//yUsEe6HSCvMSMCy6RIPZVvPAfLrD8DZT1lnfgAxqs5Etg6n2GljrjxX3MXA
 =
X-Gm-Gg: ASbGncstADkeB3aIAyLeN+Ovld5IpyV/mT1ZgxWtnAM/S2HlIBsa6x66JsWso35WOo4
 hbPdH3dz+G8o8AQJpu7aBQenpIwb1QL5yygpuJhrL11Iswr+6LtsIaxR71z5/e97XLt/+EGg4LF
 zscjqLZHrfstFaA/R5PtAZeNB3DkEB0Mir+KZtu0vTvlwcg0Xp4OGNPxXvVuoYGy2+82DnUh4o2
 //H2lPA5HSXCJP5GUSbHUyFwzURYiUPllbF8yXnki2KdxK33RJlPUCuPUJa3qy90MgO7RgLDqDK
 boru0fOWeIgWseeIqdkDjqItGOZUvZvt+FNTLz1Z2wbCUIs6DikpmZw2trSwMxY=
X-Google-Smtp-Source: AGHT+IG8Sm3662LVBxNqUhMZq6lX7M9+2DKFAI+hW11kzJ/ZTDyISvxLvvLoKh0DxFKuLpTizUMdOQ==
X-Received: by 2002:a05:6e02:b4d:b0:3d0:24c0:bd4d with SMTP id
 e9e14a558f8ab-3d2caee65fbmr155300755ab.18.1740438478716; 
 Mon, 24 Feb 2025 15:07:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 29/44] test/py: Allow tests to be filtered by role
Date: Mon, 24 Feb 2025 16:06:18 -0700
Message-ID: <20250224230640.2665206-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

