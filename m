Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68C8C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC21826AD;
	Tue, 29 Apr 2025 15:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ATAFfC4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE47A82724; Tue, 29 Apr 2025 15:15:30 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A038826AD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8f8so662873039f.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745932526; x=1746537326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1qO9QEcXz+eFX+0ALNnhr5m6/Xn09L66y8ncXhJa28=;
 b=ATAFfC4mB+OwwwuvRKKTHpHy/r77JR3YG9tueiXGm1Wu/xOHJXCkWvmAOwR3u6/Huv
 kUHbSTxWGWoHW2Ydvn3uly8z6auOgzKuaA/4j6ONi7Ug+bo2iU6G1eacTszt2+8EDLEh
 4oL5rVI1Pu0BDv8rpUUOYYyJcHUclPCm5r/v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932526; x=1746537326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1qO9QEcXz+eFX+0ALNnhr5m6/Xn09L66y8ncXhJa28=;
 b=gCxxdQJ8YIWawa4tF94krcR9LDG2YkYPlsmQMA3J429fMfK58DS3tzee1PK7raON5e
 +7AeKhiycu7gw+EiOM1tcZYWSEDZI2lpaaSsTXljmq0oJ9koXWbFXGkFn9xIfFz9qJIY
 lDOGf8bkM+/nB2z1tnryN4B1SfnEXMKtpOZNfBENXIsnhqcrM4jLvsHyJ92qNchvnlcP
 75DRWGm1UVGQPbJnUVMQ3vlPiTNWnl4enWNUI3oYATfWcC4tJWy5f4xE0oL13mAxR+dJ
 KQcJEFWzpEz5qjFcu5asMa29bMVnjsK5Np3SH77FxvBQ0zDuaUoqkFz4V45J3bwmY7Sl
 ++XQ==
X-Gm-Message-State: AOJu0YwXtaewDNIXCOxNMx1ta/nx49fVSaM8ON2QzVFO/iYNq++CbWxZ
 b1lYIq1XI3oC+rsas2RKUiEwc90UaYJu73YfaCKg0taW9/wiJC2Y4k+/2Q8EOss3vLHw+j494t8
 =
X-Gm-Gg: ASbGncvFcigAgoeU6gOTlhee80tcyHzH7WcGkADkFDlcvJL2oIYx+Ep32KoPCxm95c9
 mepac1RZuPNkKQWzZIDXpW1kipYqLEmEgQVFFUG0Gz4fFGFQAoPwSN459r9OwSZRrCz8caPbRyS
 0Oi1H26nI0q/dBy3PeEV4DX6tcq1a+6slOKYpbzUa88Eqn4AsiUPgTTBTsnBhkqvAg8BMI1MoGA
 OhiZu6ntHnBFt4oQPqGZowJhQZCYflblCC4dwXGlmt8mrb5h/Qwso0dgfJlXlEwGQShDk2qDAU0
 9hmq7sZxBFAN0xmVH99vsQklZo3MVXcsx7UKHGOEQxre6P796Olpw6gdqCd2qzNVH3hwqgagcs6
 7sF3Xx6VJDdNc
X-Google-Smtp-Source: AGHT+IHOmSDjcfUy6bBZCtjVTUTsfPbJxMWYnuyBJQZ4dwrd6S9s3d0XSM8X1uhmZVjG9DfglS35zA==
X-Received: by 2002:a05:6602:7286:b0:864:88f9:62f2 with SMTP id
 ca18e2360f4ac-8648aedcf00mr335616139f.9.1745932526493; 
 Tue, 29 Apr 2025 06:15:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f86311cccbsm271816173.84.2025.04.29.06.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:15:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] tools: Update the license specifiers
Date: Tue, 29 Apr 2025 07:15:06 -0600
Message-ID: <20250429131515.244061-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429131515.244061-1-sjg@chromium.org>
References: <20250429131515.244061-1-sjg@chromium.org>
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

Recent versions of Python complain about the license being in the
classifiers part. Use a 'license' property instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/pyproject.toml       | 2 +-
 tools/buildman/pyproject.toml     | 2 +-
 tools/dtoc/pyproject.toml         | 2 +-
 tools/patman/pyproject.toml       | 2 +-
 tools/u_boot_pylib/pyproject.toml | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
index ba34437fc53..f17bc051ea1 100644
--- a/tools/binman/pyproject.toml
+++ b/tools/binman/pyproject.toml
@@ -10,11 +10,11 @@ authors = [
 ]
 dependencies = ["pylibfdt", "u_boot_pylib >= 0.0.6", "dtoc >= 0.0.6"]
 description = "Binman firmware-packaging tool"
+license = "GPL-2.0-or-later"
 readme = "README.rst"
 requires-python = ">=3.7"
 classifiers = [
     "Programming Language :: Python :: 3",
-    "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
     "Operating System :: OS Independent",
 ]
 
diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.toml
index 68bfa45c3f4..3d0842e470a 100644
--- a/tools/buildman/pyproject.toml
+++ b/tools/buildman/pyproject.toml
@@ -14,11 +14,11 @@ dependencies = [
     "patch-manager >= 0.0.6"
 ]
 description = "Buildman build tool for U-Boot"
+license = "GPL-2.0-or-later"
 readme = "README.rst"
 requires-python = ">=3.7"
 classifiers = [
     "Programming Language :: Python :: 3",
-    "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
     "Operating System :: OS Independent",
 ]
 
diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
index 9f59788e616..3d75e5269c7 100644
--- a/tools/dtoc/pyproject.toml
+++ b/tools/dtoc/pyproject.toml
@@ -10,11 +10,11 @@ authors = [
 ]
 dependencies = ["pylibfdt", "u_boot_pylib >= 0.0.6"]
 description = "Devicetree-to-C generator"
+license = "GPL-2.0-or-later"
 readme = "README.rst"
 requires-python = ">=3.7"
 classifiers = [
     "Programming Language :: Python :: 3",
-    "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
     "Operating System :: OS Independent",
 ]
 
diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index 06e169cdf48..be7bf1998a6 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -10,11 +10,11 @@ authors = [
 ]
 dependencies = ["u_boot_pylib >= 0.0.6", "aiohttp >= 3.9.1" ]
 description = "Patman patch manager"
+license = "GPL-2.0-or-later"
 readme = "README.rst"
 requires-python = ">=3.7"
 classifiers = [
     "Programming Language :: Python :: 3",
-    "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
     "Operating System :: OS Independent",
 ]
 
diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index ce2355084ac..c0257caba84 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -9,11 +9,11 @@ authors = [
   { name="Simon Glass", email="sjg@chromium.org" },
 ]
 description = "U-Boot python library"
+license = "GPL-2.0-or-later"
 readme = "README.rst"
 requires-python = ">=3.7"
 classifiers = [
     "Programming Language :: Python :: 3",
-    "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
     "Operating System :: OS Independent",
 ]
 
-- 
2.43.0

base-commit: 0312b271dd6dff8ca6d60c53ab028af526c45dde
branch: patb
