Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960DBE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C6480217;
	Wed, 11 Dec 2024 14:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iVMxzXfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC4E8021C; Wed, 11 Dec 2024 14:19:09 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97017801C3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a9d9c86920so8949945ab.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733923145; x=1734527945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sg3MpQV05NMacdk2VNx8kR6l5PLTxZceBdOvcKZk1gU=;
 b=iVMxzXfk2iOfolYdtheqHx+mukS4s2fnncXou8Rac0pBuC/eMrb4UhyVaQ67AcX7QD
 pHfOWkNc5DrFnmqIZGY51jBLEEgS26rHvsoWoBYKfTaZ3asIqWBeHVxUFVhSs6ZC+lVE
 M65aLwaXwEJWh631nOPeLNHI0rUDTASCpIGO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733923145; x=1734527945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sg3MpQV05NMacdk2VNx8kR6l5PLTxZceBdOvcKZk1gU=;
 b=I53Iq3ySHxiPKIH1uQ4629uiQng+WjS6aHZrTyLKmJDI3gS+gGCF6iOUUEcb0gl6Ha
 QSnGIK0UwJK3R8MUNrGJYKL+cWDeeCuuyVXkIvufpIP/g/yr4meRCG8ByLASbKdSxk4w
 JHcU5hYCZB/F/9EhcAQVshf5ObUhPIPFvH7+8z7wW7voEKXCTZOP1t7CKirpXlQakLNn
 m51DSig1QzXg7l18okWAyWrj8IhVxyphfjNAsoIZbnutVOO2dphCFPM0yt/2WWRCpiUb
 8zNm3iVB7gPN+iWQQgsmNfhCqdJeVl6/Eio42DwMhs9HCK7HLWvwO5pgJqg4cncNzjUt
 jjMw==
X-Gm-Message-State: AOJu0YwfxDT/TU2MU/gYGeFx+0QBkyanR/cbHWdPAZNncSdvcVHCBhtj
 Fbh7ZzKtI20Y2tL7xQQuLP4o2iNGAOoBF9NW6+vt7eLot6C6HxgQwscoHF2h9DxvwymrKr5SepI
 =
X-Gm-Gg: ASbGncvFpjf9S6AIuDMMx60VGm6QNrUfc7MioGUaL9i2Qn/VEiTlga5K3RB5qz0X6V3
 TzXHqrJyZJ+hJrLcFmWYbjNH3j/sdQHiOh8NZIdpgqEHICLt0kCGK2nw3z9pUkDe3QN+z6k46Bj
 m1m5OCQIyEfVBX8XgGn+raDssvLetp0l5HKEP8nB1O/NifOZnXuGbog4twzxmNTO+Q8BGev+UO2
 gIb00C00kou92av0qixuhFcjH02YF+d7/lYsMSxQzo7kMzc5672isbld5sqbgVLZGnB0L+Whmtz
 jv2Xg7oq3PtNbuw=
X-Google-Smtp-Source: AGHT+IEgooZx8kIJTf1nPLm5qaiHKCqjna4wgQwJe5drAFcnewh4qlalZiJN3sT0sRQj4psQ/tX32A==
X-Received: by 2002:a05:6e02:240b:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3aa05010ebdmr33811055ab.5.1733923145226; 
 Wed, 11 Dec 2024 05:19:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2adc69d85sm2048686173.114.2024.12.11.05.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:19:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] test/py: Always use the current dir as the source tree
Date: Wed, 11 Dec 2024 06:18:58 -0700
Message-Id: <20241211131858.520639-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

The logic in get_details() retrieves the default source directory from
the Labgrid settings. This is convenient for interactive use, since it
allows pytests to be run from any directory and still find the source
tree.

However, it is not actually correct.

Gitlab sets the current directory to the source tree and expects that to
be used. At present it is ignored. The result is that Gitlab builds
whatever happens to be in the default source directory, ignoring the
tree it is supposed to be building.

Fix this by using the directory of the source tree, always. This is
obtained by looking at the grandparent of the conftest.py file.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Tom Rini <trini@konsulko.com>
Fixes: bf89a8f1fc2 ("test: Introduce the concept of a role")
---

 test/py/conftest.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index d9f074f3817..509d19b449d 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -144,6 +144,9 @@ def get_details(config):
     # Get a few provided parameters
     build_dir = config.getoption('build_dir')
     build_dir_extra = config.getoption('build_dir_extra')
+
+    # The source tree must be the current directory
+    source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
     if role:
         # When using a role, build_dir and build_dir_extra are normally not set,
         # since they are picked up from Labgrid-sjg via the u-boot-test-getrole
@@ -172,15 +175,13 @@ def get_details(config):
         # Read the build directories here, in case none were provided in the
         # command-line arguments
         (board_type, board_type_extra, default_build_dir,
-         default_build_dir_extra, source_dir) = (vals['board'],
-            vals['board_extra'], vals['build_dir'], vals['build_dir_extra'],
-            vals['source_dir'])
+         default_build_dir_extra) = (vals['board'],
+            vals['board_extra'], vals['build_dir'], vals['build_dir_extra'])
     else:
         board_type = config.getoption('board_type')
         board_type_extra = config.getoption('board_type_extra')
         board_identity = config.getoption('board_identity')
 
-        source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
         default_build_dir = source_dir + '/build-' + board_type
         default_build_dir_extra = source_dir + '/build-' + board_type_extra
 
-- 
2.34.1

