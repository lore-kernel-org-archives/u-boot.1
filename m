Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4544FC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B158215E;
	Tue, 29 Apr 2025 15:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oWDF1MWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F300582145; Tue, 29 Apr 2025 15:24:26 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78BCC8215E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72a4793d4e2so4421340a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933062; x=1746537862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3BXS/eHd6+zH4xydg1zecvkP8xCBCNemfkQaQLu2Gk=;
 b=oWDF1MWRS+eF5w01Vt2NnKZWg/aNoekhMx4ITRLzdqr4s/sWwfwxtdH9O760D6el0i
 bIgZvVH/qyoKLaDKygdHEhztqZkqTposcWIPcF+c3TLeP+LbcP+pdETKMb0uOr5bhjxG
 z+qXWra/0cMcHlPXSaQ95GpjnZWoYxrQHJuLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933062; x=1746537862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3BXS/eHd6+zH4xydg1zecvkP8xCBCNemfkQaQLu2Gk=;
 b=T/ngMqF36IgHgR9lw/Dwbt4B2TMFKvn0PVGffpcZqQFUvEPqsKtSpIRAyo0aV7QF6r
 3dwszxS4+VSArgl2eC8v/s8Jkao/kAJcBekSEp8/vVtj43zU7sd7QJCPxzAQJRx17bpG
 ZYEfYAIKX50TwfH79cDzegZbSrq9KLMBfP0FfQMrYRsyIVfjDuDr9NMeTTgl45PPOqf1
 qeWgd2nB/Q3gn2gOXzMtQNI2k/YdbpJacuAVICIWTL0HIhOjjKQmpXGp430wtC0C7vRh
 d5cIYJhSKo4+j9KNi0mm5TDBmd9zgNO+LJwbeyzXMeleyIa7HdGJfGzwJe44I1HUJghB
 VAlA==
X-Gm-Message-State: AOJu0YwKGzVmxHoDL4QEDqpefa9r/Doh4ER12gIIXvK2sZ5UTjuXwXL1
 X0cPUoE4b3A7cBS6eywEUj15VzbPnYyeIdn3zM3bFcQeMec1gP4sbsonqHY0cQKXeK84AZYa2PE
 =
X-Gm-Gg: ASbGnct0Xvh0XMCJHYd3djkASVGRIyprgnBUU7YHEbwAguGXfkYKU01WHLZnzHrjJ01
 Oyh5eEBi2MPTTpm5tWJfRlRN502JtSMsgRRu6JApmqeir/65SQg39C1Evfwnt2PBPpcDNKx/sKv
 u812nxIOQ07LW8iAVjDDd/KvgFp55frQ4kMhd+/SfIDRPbZCPW+Y4Gq6rBAFzzLQPI1tPKSCeSy
 yzLR10964Guc0ud5DoLjW/aPgBXgE8hVZDS8bGq8QoJ+EBtNM9UkShbEv4W0zgA+K/r4bWTFVEu
 /VBLKUbG3FViogPWcX0HgDz06WK6+btik087wk2VHmhTHb0vATvCqYAM1hgy4A5qkETpyZ2Q9ZR
 Zvg==
X-Google-Smtp-Source: AGHT+IEfqUtUWJukDRg1TbCR6VGFHcMkbNcSkesO/qPle+ZzUE5NmWOzor4lQEKroSmn/ArIPuNLmA==
X-Received: by 2002:a05:6830:7007:b0:72b:93c9:41a6 with SMTP id
 46e09a7af769-7308979f840mr2144337a34.20.1745933062325; 
 Tue, 29 Apr 2025 06:24:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/30] patman: Create a module for handling patchwork
Date: Tue, 29 Apr 2025 07:22:13 -0600
Message-ID: <20250429132239.251756-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

At present the patchwork implementation is very simple, just consisting
of a function which calls the REST API.

We want to create a fake patchwork for use in tests. So start a new
module to encapsulate communication with the patchwork server.

Use asyncio since it is easier to handle lots of concurrent requests
from different parts of the code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchwork.py   | 66 +++++++++++++++++++++++++++++++++++++
 tools/patman/pyproject.toml |  2 +-
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 tools/patman/patchwork.py

diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
new file mode 100644
index 00000000000..0456f98e83c
--- /dev/null
+++ b/tools/patman/patchwork.py
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 Simon Glass <sjg@chromium.org>
+#
+"""Provides a basic API for the patchwork server
+"""
+
+import asyncio
+
+import aiohttp
+
+# Number of retries
+RETRIES = 3
+
+# Max concurrent request
+MAX_CONCURRENT = 50
+
+class Patchwork:
+    """Class to handle communication with patchwork
+    """
+    def __init__(self, url, show_progress=True):
+        """Set up a new patchwork handler
+
+        Args:
+            url (str): URL of patchwork server, e.g.
+               'https://patchwork.ozlabs.org'
+        """
+        self.url = url
+        self.proj_id = None
+        self.link_name = None
+        self._show_progress = show_progress
+        self.semaphore = asyncio.Semaphore(MAX_CONCURRENT)
+        self.request_count = 0
+
+    async def _request(self, client, subpath):
+        """Call the patchwork API and return the result as JSON
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            subpath (str): URL subpath to use
+
+        Returns:
+            dict: Json result
+
+        Raises:
+            ValueError: the URL could not be read
+        """
+        # print('subpath', subpath)
+        self.request_count += 1
+
+        full_url = f'{self.url}/api/1.2/{subpath}'
+        async with self.semaphore:
+            # print('full_url', full_url)
+            for i in range(RETRIES + 1):
+                try:
+                    async with client.get(full_url) as response:
+                        if response.status != 200:
+                            raise ValueError(
+                                f"Could not read URL '{full_url}'")
+                        result = await response.json()
+                        # print('- done', full_url)
+                        return result
+                    break
+                except aiohttp.client_exceptions.ServerDisconnectedError:
+                    if i == RETRIES:
+                        raise
diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index fcefcf66960..06e169cdf48 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -8,7 +8,7 @@ version = "0.0.6"
 authors = [
   { name="Simon Glass", email="sjg@chromium.org" },
 ]
-dependencies = ["u_boot_pylib >= 0.0.6"]
+dependencies = ["u_boot_pylib >= 0.0.6", "aiohttp >= 3.9.1" ]
 description = "Patman patch manager"
 readme = "README.rst"
 requires-python = ">=3.7"
-- 
2.43.0

