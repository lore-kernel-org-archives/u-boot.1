Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6BFC35FF3
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0094781DE3;
	Sat, 15 Mar 2025 15:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l0MeQ8Js";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 459FC81EC0; Sat, 15 Mar 2025 15:28:18 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42BD380F70
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso4129295e9.0
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048895; x=1742653695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHbemXiu5rRtYpiipAUbjOCQrUkto37/hy8eDHI+6Mk=;
 b=l0MeQ8JsUM16YqOxo/88hT3RzxaD2VBrl+9jnf5QYpawo0Y7+th1Vb9PIoMSNNi2vq
 vqTXdlMNYw+baETn8kTuV+vTlw7cQqe+4oM8k77AmU0+VcooEAxvKeEKQeb8eQr4hOqS
 gswuM/4EcVvNd9S9jvOj/6hZcCAxYTh4wm59Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048895; x=1742653695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHbemXiu5rRtYpiipAUbjOCQrUkto37/hy8eDHI+6Mk=;
 b=QkCGrEtIZ6KJh9I38iktQRz9TfVCcj5UxSJUQKzxrRxipCa5BEVdREoMjCP1v4kQPa
 LyEhQuOPFG4G/hIaViFtbgo0EYozc/WZ/e7ICCWP0knEy4YSPD0P9wv1bVVC/H9eWPP7
 y2ta2ZA0rRpKKfhO07EhxqwRVCTMmF4CXPRIz9lIhe7Du08T7G+re4mQGeXJP+76i3h9
 wF5xnujktV6YclVkyLuI1G+Ld1tuJ0H8ItESehpiEQoy/cRIXWbTTbS47DFD6rdElyTn
 SylDnMg2F9jB1D82XKZQ7WOVDxjMn+9SIaKtn4e+Fx+I63ug3HTljB4+6nOQN/hVBLAB
 jiLA==
X-Gm-Message-State: AOJu0YwU3j3xvTOoI3BiarAb6LZC05EEq0wdlNRLSoljr3dgIiQTaNi9
 rG2kifAovL3DKZdBfDqsW0ysKoIvFKRq4GpbxIwKOfGCv7/K4FCyK1ieQ5QR5T2y9uLZdbeasQZ
 3Dw==
X-Gm-Gg: ASbGncs+Ma3Acwvs66qo+QOCAvEXKaPYiAMGNdiW+YmQcJ06GIRm6U039sKx1Xd8FTM
 IZ54sSUcTBmOvMJeyrsSTJPpauTHCmJXy1pIEjsRhTinpXm/FQY72CYmE0c0P39RNx5UJ4PkrTK
 E4h+4CRR814nN/Pnu1Lr8y6jc+aa+kBTE+IyBqKIL8R2UwL88SVVjyvuSd3X3RMCXYd5IoImyps
 +9KvRRlw9oGCD2eAfQdnZaC2cJixZODvPweGqHlvLBDDQ6zgPXYhfJJlq7f6XK9MSlhNW+EbJuz
 1uBJHSOIc8hQGQ+/g+sOAiVU99TkLRE7HzLNhqNa0nUnpTh29MpM
X-Google-Smtp-Source: AGHT+IELxllAnZwEAGZ8NrG/cLC6SvW8i14wvU4pc5UT5L6/sjtKQCOIYLGJaXF6gkMhg7Qs9ukrbg==
X-Received: by 2002:a05:600c:4690:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-43d1ec765b7mr83986575e9.7.1742048895179; 
 Sat, 15 Mar 2025 07:28:15 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 31/46] test/py: Allow tests to be filtered by role
Date: Sat, 15 Mar 2025 14:25:51 +0000
Message-ID: <20250315142643.2600605-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

