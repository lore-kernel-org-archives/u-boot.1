Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C306C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A80871C7;
	Sun, 19 Nov 2023 16:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fRqYiRrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4FB487124; Sun, 19 Nov 2023 16:36:40 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 950B386EF6
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3574297c79eso13693685ab.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700408174; x=1701012974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwmXcVYnCtwJdsg5nCfqX48nmYGs1Ror/BXQKeObnvw=;
 b=fRqYiRrXU2FznoutizAOm5o2YJyvyEJZRN/CJ5aQ67tL6ZtpVl+CEJqd6pqeiNyl0j
 M61iYPDp9TI0dE+y/72hREEZGU8V/OQLOhAlLNvQJ0HqrlS0hpM5+TsacJNuTBlybBQn
 bVXT3JQu5ve8MfSt4rEaGwKTZk4BgKsNuTnSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700408174; x=1701012974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwmXcVYnCtwJdsg5nCfqX48nmYGs1Ror/BXQKeObnvw=;
 b=Kdiz9fADppiCelDjwrMZ8SixUSzhP9rXr/wUsziLBY0zE4Uv38GKp3q7n4P/4rBa3l
 lv+goQwE1XM+U1FlvlQbr58ZEuVaAXSCiOSVw0Q99VaJRIL1wUcb/ysFaZfO9/sT6dYo
 T92qAOSdHVA1uDPS/Z9jKW/qal2lr3/cZlfJ/+4UbZ9TMJLuOtuQ/y0DudgI8rCiWf9C
 eyBG9E5y/LytzQGVOppThbsXOR6+OkGUN/2hEox0II5sZCCxagWrKo3vYQOvY5vt5nVu
 BPNuebdTCwONiynpG/la5ATVc0wy/O7K3vifcwx1QyHUvMJR0siVw7PCqbkBC+2SpaLy
 ANlw==
X-Gm-Message-State: AOJu0Ywck+q9QpKYYVmePhu9UjXVTwyeDGlk6Of12wpC/NPVYFXiLwcT
 dCEKipJeGGToom+s0/KLZrwVlI879TXolK+vJKGG9w==
X-Google-Smtp-Source: AGHT+IGvaU9GuNg6nDqfv/DH7992dWvQe6bjDKd/TZU6oZPfsdzIIPAkpMzWh3SYlV8RMpv8DFnLbQ==
X-Received: by 2002:a92:dc88:0:b0:359:311b:490e with SMTP id
 c8-20020a92dc88000000b00359311b490emr5972748iln.2.1700408174088; 
 Sun, 19 Nov 2023 07:36:14 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 19-20020a0566380a5300b0046456924383sm1466712jap.73.2023.11.19.07.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:36:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 1/7] doc: Update documentation URL
Date: Sun, 19 Nov 2023 08:36:00 -0700
Message-ID: <20231119153611.639252-2-sjg@chromium.org>
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

Update to use the new docs.u-boot.org URL for documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                       | 2 +-
 README                            | 2 +-
 doc/build/documentation.rst       | 2 +-
 tools/binman/pyproject.toml       | 2 +-
 tools/buildman/pyproject.toml     | 2 +-
 tools/dtoc/pyproject.toml         | 2 +-
 tools/patman/pyproject.toml       | 2 +-
 tools/u_boot_pylib/pyproject.toml | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1cb2dc4dc0..65f172ae433e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -976,7 +976,7 @@ EFI APP
 M:	Simon Glass <sjg@chromium.org>
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 S:	Maintained
-W:	https://u-boot.readthedocs.io/en/latest/develop/uefi/u-boot_on_efi.html
+W:	https://docs.u-boot.org/en/latest/develop/uefi/u-boot_on_efi.html
 F:	board/efi/efi-x86_app
 F:	configs/efi-x86_app*
 F:	doc/develop/uefi/u-boot_on_efi.rst
diff --git a/README b/README
index 60c6b8a19db1..e00b8e1799ba 100644
--- a/README
+++ b/README
@@ -2650,5 +2650,5 @@ Contributing
 
 The U-Boot projects depends on contributions from the user community.
 If you want to participate, please, have a look at the 'General'
-section of https://u-boot.readthedocs.io/en/latest/develop/index.html
+section of https://docs.u-boot.org/en/latest/develop/index.html
 where we describe coding standards and the patch submission process.
diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 20b0fefa2d88..098c96a4c4ff 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -37,7 +37,7 @@ The *htmldocs* target is used to build the HTML documentation. It uses the
     # Display the documentation in a graphical web browser
     x-www-browser doc/output/index.html
 
-The HTML documentation is published at https://u-boot.readthedocs.io. The build
+The HTML documentation is published at https://docs.u-boot.org. The build
 process for that site is controlled by the file *.readthedocs.yml*.
 
 Infodoc documentation
diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
index b4b54fbaee61..c731c4b798c1 100644
--- a/tools/binman/pyproject.toml
+++ b/tools/binman/pyproject.toml
@@ -19,7 +19,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://u-boot.readthedocs.io/en/latest/develop/package/index.html"
+"Homepage" = "https://docs.u-boot.org/en/latest/develop/package/index.html"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.toml
index 4d75e772ee18..90ad17620296 100644
--- a/tools/buildman/pyproject.toml
+++ b/tools/buildman/pyproject.toml
@@ -19,7 +19,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://u-boot.readthedocs.io/en/latest/build/buildman.html"
+"Homepage" = "https://docs.u-boot.org/en/latest/build/buildman.html"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
index 77fe4da2158f..1c5a2fb15151 100644
--- a/tools/dtoc/pyproject.toml
+++ b/tools/dtoc/pyproject.toml
@@ -19,7 +19,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://u-boot.readthedocs.io/en/latest/develop/driver-model/of-plat.html"
+"Homepage" = "https://docs.u-boot.org/en/latest/develop/driver-model/of-plat.html"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index a54211f7069d..f29516acefad 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -19,7 +19,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://u-boot.readthedocs.io/en/latest/develop/patman.html"
+"Homepage" = "https://docs.u-boot.org/en/latest/develop/patman.html"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index 037c5d629ec5..1984bd370089 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -18,7 +18,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://u-boot.readthedocs.io"
+"Homepage" = "https://docs.u-boot.org"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [tool.setuptools.packages.find]
-- 
2.43.0.rc0.421.g78406f8d94-goog

