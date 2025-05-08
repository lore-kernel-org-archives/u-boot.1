Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A694C3ABC6
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123E98283E;
	Thu,  8 May 2025 23:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D6di8pG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D5D82A0A; Thu,  8 May 2025 23:42:30 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C77082952
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-730580b0de8so1510916a34.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746740547; x=1747345347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUtdYN+sWKNbPBV8UIsBAdVxvF2AZIi6xXa7OEF5MTw=;
 b=D6di8pG1SPAWZaKN3KuYHcXujHG77DUuTYGKqT+ckQQDQzEum7HtsxR6BY3kruX7NU
 l7XzsRHtvzrzoe9tDvzUs+gmppPiK4e2tXzXHHnWr23vKRTIqr488D79nTidg7C4/V+F
 FIrNwfw8QvegnaehZpMZQ5o+Gs8lvet7zRbac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746740547; x=1747345347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUtdYN+sWKNbPBV8UIsBAdVxvF2AZIi6xXa7OEF5MTw=;
 b=sqDnS79vxG+5jzX5SH30LAgVmk2d7bnhIDobAvYRn0cDZK0sK9MkZ67qJFOz7xKtVC
 htB0XndkLZAn/ir507b9/5rXXGeEHHJsjxuMWP5kn8NrpR6O1ZhKc4lzzGdVshsIQDx+
 vqeq2hMGGXT5GudV/Lhrhdx1AA6holxCSCoqo4qCtAD9fev+ForlJFAQ0Tjg3x5U0a5j
 E8r7uBLAQETg759i6rh5O3d3ekQ9SaoX9RhXLQSdRVOK7xJfeunVqzH4I890jDFxgouu
 Ud/udMMwJiftynCBdI2/wlePYguyIgSJWnxrfASRvLJRlrXMxUbU/zEws23YqWwrbCMK
 VyFQ==
X-Gm-Message-State: AOJu0YykCVtvbxnlyr7kS+0+n0B+wMOtju2p/On1bYtW+QxaFs0P28S3
 gk6hJgGYZ5NAW9VEK37SXX1pw1HgI9SznHDJ53C6+aGFUk7G5vj+mjFC1J2w9B96taP9udsQGg4
 D
X-Gm-Gg: ASbGncs4u1lxOJbwD0/A/EXKVt2/13g/Y+aZO29A8o48YAc7g/CArgkSUDPoD/bYvCu
 ELJRTSO3VaTB8geSmCmvg3LjCeYw4zAk6/t1/5sFfMRldUn6Gccw3PvWMawSVIN8Z1EzLb4HSXA
 O5tB6wJqhz+8RoIb/LbE2+Zjc0gQI+ZqAlk9k7Vufr6H/uxUU/9T4TdlJIRjlJcqdVaqOtfbLfy
 GSB6w+86ay3lS4P0EQfYuNa4ga49NzPVPIZ2LL/Qtiem3TWu2S5gxRPPfGtFrZjq71RjnFW+0sK
 GKmXcQU5ieBZA/aKSn4qg4Ot3gyff0T8qOCL34dV3Ni/8a3NuV1oCSRz6drtPb7vMQZ5i44JvXv
 ahw7X
X-Google-Smtp-Source: AGHT+IHF8uHbayU9qAluagMvFfOlt3AYbPD1xFle9k6AxUsEZdKwgqUGmxnAsKKS6PE3GAV18d1eIA==
X-Received: by 2002:a05:6830:7204:b0:72b:7dbb:e39d with SMTP id
 46e09a7af769-7321b364eeamr3360612a34.1.1746740547125; 
 Thu, 08 May 2025 14:42:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264d439esm266167a34.30.2025.05.08.14.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 14:42:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] doc: pytest: Document the test_bootmenu test
Date: Thu,  8 May 2025 15:34:44 -0600
Message-ID: <20250508214222.643020-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508214222.643020-1-trini@konsulko.com>
References: <20250507232500.527782-1-trini@konsulko.com>
 <20250508214222.643020-1-trini@konsulko.com>
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

Add this test to the documentation. There was already a function comment
that included the argument, so convert it to the right style to be
rendered correctly in output.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 doc/develop/pytest/index.rst         | 1 +
 doc/develop/pytest/test_bootmenu.rst | 8 ++++++++
 test/py/tests/test_bootmenu.py       | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100644 doc/develop/pytest/test_bootmenu.rst

diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index cd6eb5f038f3..4d949cfd1d2d 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -19,6 +19,7 @@ Individual tests
 
    test_000_version
    test_bind
+   test_bootmenu
    test_bootstage
    test_efi_loader
    test_net
diff --git a/doc/develop/pytest/test_bootmenu.rst b/doc/develop/pytest/test_bootmenu.rst
new file mode 100644
index 000000000000..e2ff5c4c201c
--- /dev/null
+++ b/doc/develop/pytest/test_bootmenu.rst
@@ -0,0 +1,8 @@
+test_bootmenu
+=============
+
+.. automodule:: test_bootmenu
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_bootmenu.py b/test/py/tests/test_bootmenu.py
index 66f3fb8a1310..be8257fe3e8b 100644
--- a/test/py/tests/test_bootmenu.py
+++ b/test/py/tests/test_bootmenu.py
@@ -8,9 +8,9 @@ import pytest
 def test_bootmenu(ubman):
     """Test bootmenu
 
-    ubman -- U-Boot console
+    Args:
+        ubman: U-Boot console
     """
-
     with ubman.temporary_timeout(500):
         ubman.run_command('setenv bootmenu_default 1')
         ubman.run_command('setenv bootmenu_0 test 1=echo ok 1')
-- 
2.43.0

