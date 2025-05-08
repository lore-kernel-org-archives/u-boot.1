Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4995AC3ABC6
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B49D782A0A;
	Thu,  8 May 2025 23:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G3CXMemx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9659982A0A; Thu,  8 May 2025 23:42:29 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671BD828C2
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c173211feso459251a34.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746740546; x=1747345346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/XO9wFEeJWG7jAbMj1wSyt3zSmfQdDO4GkL+btuX3xs=;
 b=G3CXMemxLPD297OHwegr8Z8rUq1jCmaBmWZ7unRhWWubnN9YsoF9CX2T6ujf4ErwCv
 HdSA8uinwznBfR33ezcLkA3mpkrVT4CXOMxn12IMfx3Ku+rgmJSGqSJERFLMKF5OGR9x
 6ue2itY1smJoSBzgR1prJOHG0ejDPdLd+wKE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746740546; x=1747345346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XO9wFEeJWG7jAbMj1wSyt3zSmfQdDO4GkL+btuX3xs=;
 b=BqN0XVi44R3D6crICDFst/dZSQ3fHH2hLAT7YktGmmJrR2nN/B61LvsES0K57x/RDj
 88y5F4RTh02uP1WDzSzxVD2q8zK6JLC1nobaelE2I72ABpc5+Mcngdon9p5q55D6Oa+L
 ENAL/hZ/O8sJudQW6ce2JYNY6QqKgVbC8MZFdPGAXu+AdZnvLYGprXSXrp3SBuYCsBi/
 DyPbC9hvsZgBlckwjGExeXV/o7sJBi2Q4GFcX4LRiY+1Ugwk7lCYwUavKsFahoXqMTrY
 YooAPXf9ev7Hq83H6Hmb4zZsyr1E6qWF4IwcWQVW6vn4VQq8t0os5vdpDlVl4pL6V9lU
 kNcg==
X-Gm-Message-State: AOJu0YybXl+UC+kRCcrMU7YdpPpVSQE3Q4Kc4X9b1z+EZU/UoW4b9s+V
 sfCbc1h5zGNSviJTS4sCfWzlv8kIkxgeaEgrp+mTPkjTt58TDDwfwZg0EqN2yVAskIzwo2eFnTF
 1
X-Gm-Gg: ASbGncsmIA7km8uE4VD8OpK0DGITegdLhqZN7IgT9kLeEoxBhQWI9CdtdxDzvsqmMUt
 gphvqiIz+sYuVEIM+CUsutbu5vFsYP3JCZMp1EL8szKzFrMF8jyWQ7iLfbgvYfzD4UF6ekOgc2x
 yaM3lV7sJNMyMlwd8VMB5gdESXZ5ii1CP1RfpFgFLEZBAFxJqemV/MB+PecjEn7Aa1t9OtQu4SK
 U5QckUI0tTCMUpOwxPlUIPy8q0Ilqp2bPA9r8BKuTAwMyAnulESg71Nawc1WSI0iIrroz3PeZyj
 oQCI/eSDADK/SwaAB3FSAdpPxMIdV9yLrZf0r6TTKilD/Z8en7PiAQ9RhzWr5q/VpggPvOdEieY
 Ul9WB
X-Google-Smtp-Source: AGHT+IGY4PV6ybSwYgk3CZoBptJqW+OTM6DUFEaXTkWhAu1YBiF+zbMLLMahaUlfokJuaaENpkmlFg==
X-Received: by 2002:a05:6830:4881:b0:72c:3235:9c5b with SMTP id
 46e09a7af769-73226a15cecmr1164042a34.16.1746740546097; 
 Thu, 08 May 2025 14:42:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732264d439esm266167a34.30.2025.05.08.14.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 14:42:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] doc: pytest: Document the test_bind test
Date: Thu,  8 May 2025 15:34:43 -0600
Message-ID: <20250508214222.643020-2-trini@konsulko.com>
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

Add this test to the documentation. None of the functions had comments,
so attempt to explain what each does.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 doc/develop/pytest/index.rst     |  1 +
 doc/develop/pytest/test_bind.rst |  8 ++++++++
 test/py/tests/test_bind.py       | 12 ++++++++++++
 3 files changed, 21 insertions(+)
 create mode 100644 doc/develop/pytest/test_bind.rst

diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index 3265eb97c7ef..cd6eb5f038f3 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -18,6 +18,7 @@ Individual tests
    :maxdepth: 1
 
    test_000_version
+   test_bind
    test_bootstage
    test_efi_loader
    test_net
diff --git a/doc/develop/pytest/test_bind.rst b/doc/develop/pytest/test_bind.rst
new file mode 100644
index 000000000000..0f636a9cc5aa
--- /dev/null
+++ b/doc/develop/pytest/test_bind.rst
@@ -0,0 +1,8 @@
+test_bind
+=========
+
+.. automodule:: test_bind
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/test/py/tests/test_bind.py b/test/py/tests/test_bind.py
index 16c63ae9684a..850fe113fe2f 100644
--- a/test/py/tests/test_bind.py
+++ b/test/py/tests/test_bind.py
@@ -7,6 +7,7 @@ import re
 import pytest
 
 def in_tree(response, name, uclass, drv, depth, last_child):
+    """A helper function to confirm contents of the device tree """
     lines = [x.strip() for x in response.splitlines()]
     leaf = ''
     if depth != 0:
@@ -28,7 +29,12 @@ def in_tree(response, name, uclass, drv, depth, last_child):
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_bind')
 def test_bind_unbind_with_node(ubman):
+    """Test the bind and unbind commands of a node
 
+    Verify that the dm tree output contains some expected nodes, and then bind
+    and unbind a USB via node device while verifying that the dm tree output
+    matches the expected values at each step.
+    """
     tree = ubman.run_command('dm tree')
     assert in_tree(tree, 'bind-test', 'simple_bus', 'simple_bus', 0, True)
     assert in_tree(tree, 'bind-test-child1', 'phy', 'phy_sandbox', 1, False)
@@ -106,6 +112,7 @@ def test_bind_unbind_with_node(ubman):
     assert response == ''
 
 def get_next_line(tree, name):
+    """A helper function to strip content out of dm tree output"""
     treelines = [x.strip() for x in tree.splitlines() if x.strip()]
     child_line = ''
     for idx, line in enumerate(treelines):
@@ -121,6 +128,11 @@ def get_next_line(tree, name):
 @pytest.mark.buildconfigspec('cmd_bind')
 @pytest.mark.singlethread
 def test_bind_unbind_with_uclass(ubman):
+    """Test the bind and unbind commands of a class
+
+    Bind and unbind the simple_bus class while verifying that the dm tree
+    output matches the expected values at each step.
+    """
     #bind /bind-test
     response = ubman.run_command('bind  /bind-test simple_bus')
     assert response == ''
-- 
2.43.0

