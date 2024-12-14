Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF660E77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 18:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B0E800D7;
	Sat, 14 Dec 2024 19:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YORisNuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2773F800B5; Sat, 14 Dec 2024 19:20:42 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7C6E80073
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 19:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844d5444b3dso97505739f.1
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 10:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734200438; x=1734805238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPpggf3FNenHOZQMpa2Wg2BQzAm+yZ6JYrGZbvN+kBo=;
 b=YORisNuLsolCeO/fxUg6ILEsH1tU2ok745aapVgFgQ2mLYhXO+g5U5bgLw0ueAtD1U
 OdbH9REyi5AquIkNHDAF5Yh3HDfDOm6kOFyuFh/4EAvRNiI+uc9ksGcySkp/V7VN6fSc
 XuvCHUELhWx2etvbfxNJj6H5WRQy5MEHGMKFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734200438; x=1734805238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPpggf3FNenHOZQMpa2Wg2BQzAm+yZ6JYrGZbvN+kBo=;
 b=mzOKbuWRpOMopNv2zc/GZT6E3qQ5PlopO1AFyfYGb3IMucbCx+LeQt6MpPD37IER7i
 vOuMM0L/luejlFWfiJGFn1C+Wj8GZFK1N8nEmz8LC0Ea/0t7sXR3v8ku9s3SLY332GFO
 RjTWh6E064cOPoqfflR8aU7qraOeAdXKerpTk9ZDyrOw999Dh7uUdHkTuWuv03dKcr5O
 MsQXUpG6fHNnyLFcSrt4BVCnm0jjZABsecU6MBHszaPeK3eSmT9itm3HIGreQCBMncCg
 S+KxftIDk1rlvzdSoMXnEteLy9rZKnCvD8EnAzma2uw1XqNEJ+ntn4jDpiUeBHfchcM5
 XvEg==
X-Gm-Message-State: AOJu0Ywv7ywpmfeiY4Nq0t5k51JDe5RowhJAGSTct9aKu7wxEkGhPYBx
 Evo3EI/92xNveGySbIYc+1dJU71oYRGqiwd1y7zUBveZzKmTMz/8O3TC7AvDIzoG18s2HSKtIq4
 =
X-Gm-Gg: ASbGncu/43aWxOd+xJ1ShjldEGz7OvlQyHWWKHTCVU6vZw30YtsQ3iVw0TdMHYKk5mP
 ulSRk6GLGLqtDiYfmnEUFWFd4ZY/4WGVTqJiQUpGP/8/eJfTKLRjhw0LauAudrbR0AFhb2iz/uj
 F/cei+mZ7QuE+iNSA5v5Z1gSkXYSgYRp5lO57/AbUp8DPez6i9kfDtN785pxcbUp5Eax7uLCl85
 vYrYknGjraUi7XC48q7ZGq5lLFm7yRacsCr+b5OGp1eEuG8ovUzBd5E0dBWlN/QWuAFweTzgBK7
 I5gdnDx0U+xhpGtupQ==
X-Google-Smtp-Source: AGHT+IG0KQ/jyzSd3s4cGIyLQmVwOrG1ahhtL19kuCMcngc9d1o4x5SCJW9xsfR0G0M9lwBZhl88uA==
X-Received: by 2002:a05:6602:1301:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-844e5b3af95mr711324639f.4.1734200437725; 
 Sat, 14 Dec 2024 10:20:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5dd620e20sm415135173.0.2024.12.14.10.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 10:20:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 2/5] test/py: Handle u-boot-test-getrole failure
Date: Sat, 14 Dec 2024 11:20:21 -0700
Message-Id: <20241214182024.1954974-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241214182024.1954974-1-sjg@chromium.org>
References: <20241214182024.1954974-1-sjg@chromium.org>
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

This script can fail if there is no toolchain available for the board.
At present this is not handled very nicely, in that only the error
output is reported. It is much more useful to see everything, so
combine stdout and stderr and report them both.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/conftest.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index acc7e5e090c..d4127dd0a93 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -162,10 +162,11 @@ def get_details(config):
 	# Make sure the script sees that it is being run from pytest
         env['U_BOOT_SOURCE_DIR'] = source_dir
 
-        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
+        proc = subprocess.run(cmd, stdout=subprocess.PIPE,
+                              stderr=subprocess.STDOUT, encoding='utf-8',
                               env=env)
         if proc.returncode:
-            raise ValueError(proc.stderr)
+            raise ValueError(f"Error {proc.returncode} running {cmd}: '{proc.stderr} '{proc.stdout}'")
         # For debugging
         # print('conftest: lab:', proc.stdout)
         vals = {}
-- 
2.34.1

