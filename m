Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C9C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B37980C91;
	Sat, 25 Jan 2025 22:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CCBjoYze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5BB80EF4; Sat, 25 Jan 2025 22:32:25 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E013780C7E
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8521df70be6so177481639f.1
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737840741; x=1738445541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHFEA/baj16bS2M+MzTbgGj1Lv7fZ3V9Y06bLmAGu2Q=;
 b=CCBjoYzeD3iYItS7HgOgomsRG+8644te+TjOw5ADghnhDqENXnusMqR/7ZR+a8WhrF
 YdRpbJ8GYcVg5mNhrgZp7SCzUnsh/NpqmURqswyTJRKjpUZ3tx+nhr4xHWF8fh4DMiaX
 YGdqIEznHcb3ZN/gjgqG8EvcGjB4eGPRdCBSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737840741; x=1738445541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHFEA/baj16bS2M+MzTbgGj1Lv7fZ3V9Y06bLmAGu2Q=;
 b=tcqVRCnrdp9dNGyfckPJ4DDMRVjd54sXxHQBslnlVKJpAKhulrWeaqShuuxykSW1af
 IyDAQgvm9DGMUqMc9qDkSBZyPKgV+so6dssmbYEGfbrCX4PA4gQ03FzUk5BAQgvJnTzc
 ywyi1CVQpD3w/S8jGgaafqVaSs4fiVh9boUHut/4azNFMdxgrIQKPzrR8vOgBe2hdIdV
 EIdjTYhdZmFfr8scTXyaC1tRkB3hyGea4E6XWjs/YZG0D30xA5ZAZj8QvV3caF2byH9p
 72W29wlZmM0WG00JGYv/RAPTHeO60XR20LZI10BSRyPeiLhNCbZSj0U/Pq+TyKdMrBl2
 KOhA==
X-Gm-Message-State: AOJu0YyZf+uPon6WJfR3IFAx5/6JO+3SrQ1XfcubUcQMO+rgjV6lS+Vw
 MciMLUizeb6feHMbvmzd/Jhr+Guj0eOlvcJ+TWyMEon1GwDXj1tMyU98ZGofBO3AHhpa1T88odM
 =
X-Gm-Gg: ASbGncsqOScn4mrTHusLGKcYq6k9ZegKeh1QXEXfNm9JRS71BDHQp9kbjllEEdEOB8m
 5PCep/6gXSAn4V2l84sbc6ka0QNtvI/0Pt0td6G3/IePaXUINyGc/fAtG1kV+dfoQa5yr6zzdYf
 14IWOddd96nD8GcZBDZgWu1zq7Gd1se2G/8rfbhU4QMeuFo1xFQ9BkCAXvLrQMkZGxpcCgE/kY4
 qEVVOy7cmnbM8VJ/4WQN0oPAXGODL3XMTmZIR/ECzj64ekhKe/C32z1+QWg1yKpfAz13iXm7qSm
 gUT6IRHVhxufRUZ9R2TDU9wAinoOF8zaUb6WzGlT4A==
X-Google-Smtp-Source: AGHT+IF40FkGDYb6I0Urd7N0vLpMJhHsb5oAZsL2w5A9G8prEx0LScCXerhjZR192hT/nuaibhsMmA==
X-Received: by 2002:a05:6602:418d:b0:844:bb0c:b899 with SMTP id
 ca18e2360f4ac-851b6170923mr2862731339f.1.1737840741132; 
 Sat, 25 Jan 2025 13:32:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521e01754dsm164103539f.32.2025.01.25.13.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 13:32:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 3/4] test/py: Show info about module-loading
Date: Sat, 25 Jan 2025 14:31:38 -0700
Message-ID: <20250125213150.1608395-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125213150.1608395-1-sjg@chromium.org>
References: <20250125213150.1608395-1-sjg@chromium.org>
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

It is sometimes tricky to figure out what modules test.py is loading
when it starts up. The result can be a silent failure with no clue as to
what when wrong.

Add a section which lists the modules loaded as well as those not
found.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/conftest.py | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 5096c20ed65..23435b7db3c 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -286,19 +286,26 @@ def pytest_configure(config):
     ubconfig = ArbitraryAttributeContainer()
     ubconfig.brd = dict()
     ubconfig.env = dict()
-
-    modules = [
-        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
-        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
-        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
-            board_identity_filename),
-    ]
-    for (dict_to_fill, module_name) in modules:
-        try:
-            module = __import__(module_name)
-        except ImportError:
-            continue
-        dict_to_fill.update(module.__dict__)
+    not_found = []
+
+    with log.section('Loading lab modules', 'load_modules'):
+        modules = [
+            (ubconfig.brd, 'u_boot_board_' + board_type_filename),
+            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
+            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
+                board_identity_filename),
+        ]
+        for (dict_to_fill, module_name) in modules:
+            try:
+                module = __import__(module_name)
+            except ImportError:
+                not_found.append(module_name)
+                continue
+            dict_to_fill.update(module.__dict__)
+            log.info(f"Loaded {module}")
+
+        if not_found:
+            log.warning(f"Failed to find modules: {' '.join(not_found)}")
 
     ubconfig.buildconfig = dict()
 
-- 
2.43.0

