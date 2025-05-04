Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAEBC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F7B82AAF;
	Sun,  4 May 2025 15:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gPcpl845";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D108293C; Sun,  4 May 2025 15:24:35 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7F582ABA
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso691697266b.2
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365072; x=1746969872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOGpKAWeGFzKMBlBoIowNX15iVbws11D4a8oLLR63Js=;
 b=gPcpl845Zp86rIc9lhSA0/si4wl4zp+YhqYmer5dC90KlJGlZ512swaIUjqmZNvxgX
 TTmLNh7iaphrqZ2L1vDbFo3pUR7ipr7x9ws5H5kUd7dTzmYsSPiSdg1BUqtpRZoAGJs+
 9lJ0SnR1eQS/DOqWmYSPvN4ZO+/wU2Izg8mYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365072; x=1746969872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOGpKAWeGFzKMBlBoIowNX15iVbws11D4a8oLLR63Js=;
 b=RIl02qTbntfxx0IhzE7ZYZJwPXvG5rFOurp9Rh6vCr/LfHZX4ZAcSt1DCkdwZoZMzh
 zCQ3vFOUlir2tU360zz6XVjwv7vNOiCrNZOlsMUbZn1xI10Cc8VWHNeZxslXIv5adqPD
 8gszbFISPQ7CTbZvEajgoqsFkRG1nALD+rVas7MfUjtQFMuboJ32NBDuIer/Ubt8u3BZ
 AfDUbJyVKE70ccwdB1Q0OsLxBuOUH2562LEmw5YtNXKZKrPVDJSgoAQiRZw7Za3EC+lK
 ENj7lQPfJukXAuwo6MUz5vqzy572b+D8T30ehDlTiWkikIOSs1DYUVI1Hc/5Jr58Z5TR
 EC1A==
X-Gm-Message-State: AOJu0Yzem+yrQh84PgOxCfYJwT8+6T+p3FgUczEzwh3HTDQwRx95MatR
 LAW4BdCJLCX7pw5Q6Dhv3D9un+RTGRC+Cg3ta/+85ihKi7Gg3ZCts8LfKfSuVXwF9900d6/qLyt
 fB2l1UVE=
X-Gm-Gg: ASbGncu8Y9J2lF4p75qohS7XqMWl2GjAKwIFKqvoLjDBgAdB6jO8YOtQaicsouujQvT
 1rRxHqKKUkxfeSteASRB3E5072syA0if7L2oPAn0Fddg2FCgYQqAhbFOJ7+pINV1ULs3XvOb80q
 ugj4wDwnj6ftYd2SJKLXLDcYphcltOJKHV8JIVEQA2eHMGNyUTbPeSm0o3W5snaMsbheefGMTy/
 4VHA3YUp+Czhv+bAo1c626qfdPvb9WvbFFDAFGyXLa3aa8QhS+GV4YHSp+MlRlG7vgwtP+/TYSt
 Axq4Utn6PaZaf51P89iZLuF6fiwyLL6zV9s3
X-Google-Smtp-Source: AGHT+IFzJqinVYmEp0CLIeEAtwcEsfMSz18cIMyDeRsWQ44DKsTVojwCpLbOpbytjGlBHf2VaWmCVA==
X-Received: by 2002:a17:907:9689:b0:acb:711d:36c8 with SMTP id
 a640c23a62f3a-ad1a4abde03mr338794266b.38.1746365071752; 
 Sun, 04 May 2025 06:24:31 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/30] patman: Create a module for handling patchwork
Date: Sun,  4 May 2025 15:23:32 +0200
Message-ID: <20250504132356.2317305-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

(no changes since v1)

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

