Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB87F34C49
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F00839DF;
	Mon, 13 Apr 2026 15:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oCIKnhan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1167C8423D; Mon, 13 Apr 2026 15:02:06 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F2C8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso2286088a34.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776085316; x=1776690116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHxpxoRecGx4LjDRd0cSD4v3ZCr/2Er/76fFed6iLFY=;
 b=oCIKnhandA+RhtUgw6xluNB9ajtj6/JEdkKeX9kIq3JBnhi7jg99h2sr75j4/CBCB0
 CB0fUWWwLadII+Qa+aZAO4TCFC08eisCMYMjfOjfCQsoe0VkGmUAsRzFq+feb9jdxQDE
 xO5yJDYRKo7JFUbKCpl3Ec53J5z8eHJPheLps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085316; x=1776690116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QHxpxoRecGx4LjDRd0cSD4v3ZCr/2Er/76fFed6iLFY=;
 b=IdU/8lBAAoYT3Ubwg5+bzK/UXqKSoeJlmXvPpWxIgk7fNznQDrlKrWlmJwVE7f/LoO
 b+25Vn8EVIZ0WS/ye0F5PPP8rJ5rZp9kEQoenuianD/JtqXsYzlWNMsPkpSpduJFvq/a
 WkaocR7/MhUBF4BCcJWEonkYY8WSTHN90l+q6E6ez4fZc6gWcgpANGAXS5E1Ial+SkEm
 GieTUY+xQxK9SmV27Wu8afaVO9HbV3BASDunIgVU/LoeTmJQCtJQJGvO/HZI3gXL7+9B
 nTeIZgksGW/qBr4AZTlTILJF9NVQ4uNzPUc7k13RLCQRWlZFUJvc0GBMzSLCQuaZfAZ6
 Ct1Q==
X-Gm-Message-State: AOJu0YypIEXdU0S+JWoewE/0MgHHwLi+tmwAMsPMkzzK3fY9tewGIY1n
 I6983fReM94lmiG7LjQRXum7JKM2V6s2j6h2URg69GasC5WKHJ5D9j/Q8MZb3WguVbUbl9EMvoL
 5RdIxGw==
X-Gm-Gg: AeBDiet7JlryjGZ0srqKTQ34AM2ekPALxXTprSEupeqSw+pSttfDbqFoVi6kUYcOP7o
 AN/aqjLy3L7DkwDamjFUTPcEYAixlvmJST9JzSgMN5Vj+/eINQVmh8ZdWg2bMjUtBfQQlkPu64K
 WGSPLLH0XwK0nZ8CI5VnhdSAJ5BjFUPJ8r7U1MWZQC3aMEIZQEPKAHilpfrG9XuQbH9OL1Osv57
 3VjVOOX/PhOR41n2SX62L9xFxmap8dphG/2LlqSGyPA/NOu6+BmTQmedcl4j/Pl9M6Wn/TZpXMp
 LuRessR/CpBtq5FxiqtsyDFg52FvPNa3A3hIbNH2cgqEwUbOJOGtvOLm4AEcQgiHzh4IRFOlk4E
 65H2PLFcClddTCgsuCITDYEsvywQe/xxqEGzGyBq5RenJi6zoxsn4RTZE87+l6rsJLQB+O1NcbH
 rZ0F1VoiTeGYjKdu1JSw==
X-Received: by 2002:a05:6830:438a:b0:7d7:bf70:c021 with SMTP id
 46e09a7af769-7dc27e5c865mr6601770a34.27.1776085302529; 
 Mon, 13 Apr 2026 06:01:42 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm8369144a34.21.2026.04.13.06.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:01:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 8/8] test: Add documentation for the FIT test
Date: Mon, 13 Apr 2026 06:59:59 -0600
Message-ID: <20260413130007.1987326-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413130007.1987326-1-sjg@chromium.org>
References: <20260413130007.1987326-1-sjg@chromium.org>
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

Add a Sphinx automodule page for test_fit.py so it appears in the pytest
documentation alongside the other test modules. The index already uses a
glob pattern, so this is picked up automatically.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch for Sphinx documentation as requested by Tom Rini

 doc/develop/pytest/test_fit.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 doc/develop/pytest/test_fit.rst

diff --git a/doc/develop/pytest/test_fit.rst b/doc/develop/pytest/test_fit.rst
new file mode 100644
index 00000000000..3a2359f1e89
--- /dev/null
+++ b/doc/develop/pytest/test_fit.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+test_fit
+========
+
+.. automodule:: test_fit
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
-- 
2.43.0

