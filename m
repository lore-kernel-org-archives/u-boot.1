Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A83C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C0E80C8A;
	Sun,  9 Feb 2025 17:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lw6J9qSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9B980C72; Sun,  9 Feb 2025 17:07:57 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F3A880821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-854a682d2b6so261932439f.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739117273; x=1739722073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0EHj+lRf+4Vu7GyNScRkOSjp3UxlQmjGXLnCjLol14=;
 b=Lw6J9qSAOrgGm1gHIidifwkWkPvti8NU4DOylZQ74XR65P7HQwYzAzkis/vaxbCIX5
 GtARbKObOdWdLxrMNPKtOUhL9biheX6C1dmPBPdoaJQc6WdDsyzybbR9fReCQxuCyKEa
 HO75CB938vO0JjMAnrek5pkDY2ygv6e2xW7xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739117273; x=1739722073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0EHj+lRf+4Vu7GyNScRkOSjp3UxlQmjGXLnCjLol14=;
 b=jaSnF0DFk2O83ZQxeaBfWDwQcGXMPJT0FatljAv0W0LqmEettRmS+Tg3o+iOeAE9/F
 a3eXqqanj1WgEI9uwqEiM5iwog6wOmPWb9mQR3jif0dGSDerDqWeymh32clCEDPzKL2I
 YY2bjeXFX5M0dRGl94VA5iE+cpsyt7ebF2NUcyN81sDIRKmCZDHqn+VYADUKV4WBpMbq
 aBMqBRVHtcLhcZQndl6V99CSX71B+dZrcIMskve0b2lk+Qt9CRjYdQrBFX9DOiJHV7T+
 Z3+Y1HdJLk7f+4Ir7oB1n8XlNtqEkyDV767LE8GuM7gt+GmjrxfagojODHb5wCBNYGPb
 AVPw==
X-Gm-Message-State: AOJu0YynfylMhfwscpnFS6DXQPxIUbhnaAmU6oIW9frYKwqQFzWRYf8c
 0YZGUQgLjIbdz8xpsqinQDMwVt1SvEgPXB5/UM1vTvWjNTyAto64TEqxPttPEpDIvczPXsz2SCg
 =
X-Gm-Gg: ASbGncsKUEaAsoVwo0R95fWdpO2rOG6MPKiPr/tJWVR0UnPjT9C4indKn3iSlYpGcix
 jmZQJHy9xDX1an/E6WsMXyZZNnEy3mgped084oA4zFH0RskseyRqQe7IsLN9jGp0o3Ckn3dvAnr
 wUqJd2ZYzZE22dYOngXw7a2RVUGWWO/soJE7CWGPareAXgFBm7U7/w5MkcOuBVqSw8f1SSuBs/g
 TWZkY+BPC1ko3wozSXlKBlobtM9/K6cJ/Elqlo+UMOrm9Ifo4GFbAJki7HL7gec/gYe4SQsWvPe
 7wyDVrD469xANgjpAfnSX4gS4kb/K6M9foH9a3/K06qJyOLaF1Al
X-Google-Smtp-Source: AGHT+IF8v0wM/lL4fOvHMt7qq7wKgP2f77eeqfAj9WRUOZXlQ3eAiwGKJb5fU4y8o5wBAtKRChLj7g==
X-Received: by 2002:a05:6602:3a86:b0:849:a2bb:ffdd with SMTP id
 ca18e2360f4ac-854fd891997mr1209570339f.4.1739117273414; 
 Sun, 09 Feb 2025 08:07:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ecf2d08b0dsm354812173.59.2025.02.09.08.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:07:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2 5/6] test/py: Show info about module-loading
Date: Sun,  9 Feb 2025 09:07:18 -0700
Message-ID: <20250209160725.1054845-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209160725.1054845-1-sjg@chromium.org>
References: <20250209160725.1054845-1-sjg@chromium.org>
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

(no changes since v1)

 test/py/conftest.py | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 8d0e786ee5c..e59897c1f78 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -289,19 +289,26 @@ def pytest_configure(config):
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

