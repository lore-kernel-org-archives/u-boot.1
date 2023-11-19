Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640B0C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9569A87214;
	Sun, 19 Nov 2023 16:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ClL2XsA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F987870E7; Sun, 19 Nov 2023 16:36:44 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A23E687168
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7a683bd610dso131782339f.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700408178; x=1701012978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doUBHAtR35/njDTc+k39aKQyt3+M6W4gi9G4q363OjI=;
 b=ClL2XsA3G2oP2YD+z91xRoDamsvvh36hQmouLHoN9OdmvYdDnZlARZxXATeEsJ1dAH
 mH2N2abl/x+JXWMzhbxleQiRAH7aArNYzYsU3fYW9VPgb83SE35PW9s+GXqwpwRtTCbY
 HNSYM8XDn2JLyPCuM/Hp4s0PoCgmI8RseIiT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700408178; x=1701012978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doUBHAtR35/njDTc+k39aKQyt3+M6W4gi9G4q363OjI=;
 b=PPZXcGV8dAb+AeIErHg5r/tfLayspbF3ImZh1S7nKEzY37qm40LznDN2Mc5LK6nG+p
 jzjsvGosqLIJrpAkDMCbBALzhnwqMZNpoYsjSix4H1x+ZMaW+ymcvmJDVuSGMZGDYRob
 Rl+0TmSeUFXVTn9KqqvNW6B6pjLb0AlqZOQAu/Pz81pS0AQwvALSuT9HDdYaFsXLIY/A
 ClpXX6/bwSx9O6VAn2Ig8vEkcHxzdtoIx3sroKjKtofnr6yGuwTmrw28sv70JS2yc3BZ
 tA7zXYmf5Vpo8J4BRKmjJHH1uWYOLxWyTDnDOmOTV9eZcpktD+jsl4r9sIGzTg1IljEu
 84bw==
X-Gm-Message-State: AOJu0YzDUPLcZAVzaivFuZIoAkmEqPtIEgtXeobIuiNhsahjMgeu5iXG
 qw6QNBHTRZDFFcV0+0sT7i0NIghylh6uASvshDG/yw==
X-Google-Smtp-Source: AGHT+IFFkAlP5OHpplaAyeiu+uhVvqDS2GgoaDmQkIIkwECF5Lh+Qf3nNqDDWzClqa3E9hHzOyV4tQ==
X-Received: by 2002:a05:6602:4885:b0:7a9:b1c9:665a with SMTP id
 ee5-20020a056602488500b007a9b1c9665amr6953325iob.6.1700408178218; 
 Sun, 19 Nov 2023 07:36:18 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 19-20020a0566380a5300b0046456924383sm1466712jap.73.2023.11.19.07.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:36:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH 7/7] tools: Move python tools to version 0.0.6
Date: Sun, 19 Nov 2023 08:36:06 -0700
Message-ID: <20231119153611.639252-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119153611.639252-1-sjg@chromium.org>
References: <20231119153611.639252-1-sjg@chromium.org>
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

A new release has been done with this version, so update it. Use the
version numbers in dependencies also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/pyproject.toml       | 4 ++--
 tools/buildman/pyproject.toml     | 4 ++--
 tools/dtoc/pyproject.toml         | 4 ++--
 tools/patman/pyproject.toml       | 4 ++--
 tools/u_boot_pylib/pyproject.toml | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
index c731c4b798c1..ba34437fc53a 100644
--- a/tools/binman/pyproject.toml
+++ b/tools/binman/pyproject.toml
@@ -4,11 +4,11 @@ build-backend = "setuptools.build_meta"
 
 [project]
 name = "binary-manager"
-version = "0.0.2"
+version = "0.0.6"
 authors = [
   { name="Simon Glass", email="sjg@chromium.org" },
 ]
-dependencies = ["pylibfdt", "u_boot_pylib", "dtoc"]
+dependencies = ["pylibfdt", "u_boot_pylib >= 0.0.6", "dtoc >= 0.0.6"]
 description = "Binman firmware-packaging tool"
 readme = "README.rst"
 requires-python = ">=3.7"
diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.toml
index 90ad17620296..fe0f6421b53f 100644
--- a/tools/buildman/pyproject.toml
+++ b/tools/buildman/pyproject.toml
@@ -4,11 +4,11 @@ build-backend = "setuptools.build_meta"
 
 [project]
 name = "buildman"
-version = "0.0.2"
+version = "0.0.6"
 authors = [
   { name="Simon Glass", email="sjg@chromium.org" },
 ]
-dependencies = ["u_boot_pylib", "patch-manager"]
+dependencies = ["u_boot_pylib >= 0.0.6", "patch-manager >= 0.0.6"]
 description = "Buildman build tool for U-Boot"
 readme = "README.rst"
 requires-python = ">=3.7"
diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
index 1c5a2fb15151..9f59788e6163 100644
--- a/tools/dtoc/pyproject.toml
+++ b/tools/dtoc/pyproject.toml
@@ -4,11 +4,11 @@ build-backend = "setuptools.build_meta"
 
 [project]
 name = "dtoc"
-version = "0.0.2"
+version = "0.0.6"
 authors = [
   { name="Simon Glass", email="sjg@chromium.org" },
 ]
-dependencies = ["pylibfdt", "u_boot_pylib"]
+dependencies = ["pylibfdt", "u_boot_pylib >= 0.0.6"]
 description = "Devicetree-to-C generator"
 readme = "README.rst"
 requires-python = ">=3.7"
diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index 56131947c794..fcefcf669600 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -4,11 +4,11 @@ build-backend = "setuptools.build_meta"
 
 [project]
 name = "patch-manager"
-version = "0.0.2"
+version = "0.0.6"
 authors = [
   { name="Simon Glass", email="sjg@chromium.org" },
 ]
-dependencies = ["u_boot_pylib"]
+dependencies = ["u_boot_pylib >= 0.0.6"]
 description = "Patman patch manager"
 readme = "README.rst"
 requires-python = ">=3.7"
diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index a7a91e5cfa56..ce2355084ac7 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -4,7 +4,7 @@ build-backend = "setuptools.build_meta"
 
 [project]
 name = "u_boot_pylib"
-version = "0.0.2"
+version = "0.0.6"
 authors = [
   { name="Simon Glass", email="sjg@chromium.org" },
 ]
-- 
2.43.0.rc0.421.g78406f8d94-goog

