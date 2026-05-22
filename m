Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B87CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 23:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C678E848BC;
	Sat, 23 May 2026 01:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KFlpDVDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD877848D7; Sat, 23 May 2026 01:58:44 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B69F848A2
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-43b53f048beso1508602fac.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779494321; x=1780099121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=An/LLZSy2eDcjMYfiuoNapbBumILWde2NHXjS2seWWE=;
 b=KFlpDVDQiSuwMEs4cTGDFqT0wP6ywcoeueT4ZIbrweirgyN27tbPesEDUK6WPY11xm
 RfvvYBK2KYa+BgZHeL8J1ywkJ5yMUA2wR9O8mbkUc5Y9CqWEDPJaTLgFMZa3ios93Lso
 6OsNKC1GPb5Oz5asyucUgShDPKLEBDiEbBk5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779494321; x=1780099121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=An/LLZSy2eDcjMYfiuoNapbBumILWde2NHXjS2seWWE=;
 b=TgI5ktKZ9Y1hVxKLu7PeNEhGiAkGUqYrzWoELhoPc5nf9DeK6rwYQNyGfjKXGWqVtZ
 OYRgsoKfqlpqG7hAa8O7G+0SAGbFc/doeDkor9MQKXwmbA46ospjGVlDbtpsdI42RaeU
 ywU4gw6VsoEBdMmhgqlMCrazLHiOstcbbwoX4XHbI0UxKvyaHK3nbMd64NtX1Ol064xv
 jYo/o5lpKWJrIAj1UClrR95n6HtQZk+rdV1BOGIcfeozDNxOa4+hyYT06pRTbuMdmAmw
 WPoysNj5yre1SxJmrmRglkrb9/iFCeb+ur0YaXK750ikbOhhx9UF3H/0IjMlwaG2ZSNR
 tGuA==
X-Gm-Message-State: AOJu0YzCGQh+1hGNxjX+izcU959kLHQj14H1prcUiefUCDe1QKtqDv76
 6VkHkYeOd0evez2s8kzmwlHZ48TeauamTC95BZM9oCwxGzU+viFED9Iu0XCeFhRxCEqdhzTMojv
 FD/9a/lE=
X-Gm-Gg: Acq92OGNFP5aqHugcSxyR5/UGuuRclokCY1OSb6c4qHP7FTcBR3DH0HeeniCex3TAPH
 XjcELXK3X8Zdr9EsKQbTrLtgPEWTSMFfU07IlWXijbwtAW4OvUOjfp92S+O/MXUpjjGGgzY8xWy
 XX94E/q58jhsYbtQVv/SCy+vrE/eZNr8Dfp93G2IIjMZjGw1N99ZGF4XCVcEugGw2pnxm+8ts9z
 YbbhrCgLXl4ULvg0O3gZK64pJyMUrxBQPdYG8DfsglrTLRLooIiiHmAk40e7ViMvNcpVp3+YJmc
 Qw22ofOfA+LiLceiPAZ5X4njvGCc8IEuFq/c4jN7yb5JAg5YsrJB3tqrJR5c0JDXuqMc+D0RbPk
 0wvADDmwHu33+MohSzwJPT0vr6NOCqm5Fe4cayvZ6qbC9giu+UVOlOXJ4wyEXFLQGWV3ZmaJny1
 j041HaMiT5DSj+kZlj73+HFzjI/9pmuj9uZUQ+rVXoWw09Jb2QuxOJayz8gKRsYPkgexcOds2qY
 kOqQzFOrsuVDOZtxupFLoF+wMElLVN7KR2/hfx3z0AeIP2OTh+IX76LfyTwLs+G2owTog==
X-Received: by 2002:a05:6871:5d05:b0:439:bb0e:670a with SMTP id
 586e51a60fabf-43b5c1e0da9mr2159291fac.14.1779494320615; 
 Fri, 22 May 2026 16:58:40 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b6350ad6bsm3306417fac.4.2026.05.22.16.58.39
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 16:58:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] global: Update URL for U-Boot project
Date: Fri, 22 May 2026 17:58:38 -0600
Message-ID: <20260522235838.2536318-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Our official domain is now u-boot-project.org, so update all in-tree
references to use the correct domain.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS                                   | 2 +-
 README                                        | 2 +-
 doc/CONTRIBUTE.rst                            | 2 +-
 doc/build/documentation.rst                   | 2 +-
 doc/device-tree-bindings/bootcount-syscon.txt | 2 +-
 doc/mkeficapsule.1                            | 2 +-
 drivers/bootcount/Kconfig                     | 2 +-
 tools/binman/etype/atf_fip.py                 | 2 +-
 tools/binman/missing-blob-help                | 6 +++---
 tools/binman/pyproject.toml                   | 2 +-
 tools/buildman/pyproject.toml                 | 2 +-
 tools/dtoc/pyproject.toml                     | 2 +-
 tools/patman/pyproject.toml                   | 2 +-
 tools/u_boot_pylib/pyproject.toml             | 2 +-
 14 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2613929cdf5f..571af1964654 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,7 +1116,7 @@ EFI CLIENT
 M:	Simon Glass <sjg@chromium.org>
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 S:	Maintained
-W:	https://docs.u-boot.org/en/latest/develop/uefi/u-boot_on_efi.html
+W:	https://docs.u-boot-project.org/en/latest/develop/uefi/u-boot_on_efi.html
 F:	board/efi/efi-x86_app
 F:	configs/efi-x86_app*
 F:	doc/develop/uefi/u-boot_on_efi.rst
diff --git a/README b/README
index f0bad144360a..5653f687e820 100644
--- a/README
+++ b/README
@@ -2281,5 +2281,5 @@ Contributing
 
 The U-Boot projects depends on contributions from the user community.
 If you want to participate, please, have a look at the 'General'
-section of https://docs.u-boot.org/en/latest/develop/index.html
+section of https://docs.u-boot-project.org/en/latest/develop/index.html
 where we describe coding standards and the patch submission process.
diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index a47dfdca2216..a6e1cd1fb68a 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -22,7 +22,7 @@ Repository
 The official U-Boot repository is located at https://source.denx.de/u-boot/u-boot
 
 Further more detailed documentation can be found at the following link:
-https://docs.u-boot.org/en/latest/index.html
+https://docs.u-boot-project.org/en/latest/index.html
 
 Contributions
 -------------
diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index b55a46666431..65f767440bd5 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -40,7 +40,7 @@ The *htmldocs* target is used to build the HTML documentation. It uses the
     # Display the documentation in a graphical web browser
     x-www-browser doc/output/index.html
 
-The HTML documentation is published at https://docs.u-boot.org. The build
+The HTML documentation is published at https://docs.u-boot-project.org. The build
 process for that site is controlled by the file *.readthedocs.yml*.
 
 Infodoc documentation
diff --git a/doc/device-tree-bindings/bootcount-syscon.txt b/doc/device-tree-bindings/bootcount-syscon.txt
index ea27b246c8a4..8e6060a711e6 100644
--- a/doc/device-tree-bindings/bootcount-syscon.txt
+++ b/doc/device-tree-bindings/bootcount-syscon.txt
@@ -1,6 +1,6 @@
 Bootcount Configuration
 This is the implementation of the feature as described in
-https://docs.u-boot.org/en/latest/api/bootcount.html
+https://docs.u-boot-project.org/en/latest/api/bootcount.html
 
 Required Properties:
 - compatible: must be "u-boot,bootcount-syscon".
diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index d6653ec42472..ed296730eeb9 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -153,4 +153,4 @@ The directory in which all capsule files be placed
 Written by AKASHI Takahiro <takahiro.akashi@linaro.org>
 
 .SH HOMEPAGE
-http://www.u-boot.org/
+http://www.u-boot-project.org/
diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 99b6c7534fda..4c0c8d89bb40 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -6,7 +6,7 @@ menuconfig BOOTCOUNT_LIMIT
 	bool "Enable support for checking boot count limit"
 	help
 	  Enable checking for exceeding the boot count limit.
-	  More information: https://docs.u-boot.org/en/latest/api/bootcount.html
+	  More information: https://docs.u-boot-project.org/en/latest/api/bootcount.html
 
 if BOOTCOUNT_LIMIT
 
diff --git a/tools/binman/etype/atf_fip.py b/tools/binman/etype/atf_fip.py
index 636e073afc84..681b79006823 100644
--- a/tools/binman/etype/atf_fip.py
+++ b/tools/binman/etype/atf_fip.py
@@ -163,7 +163,7 @@ class Entry_atf_fip(Entry_section):
 
     .. _FIP: https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html#firmware-image-package-fip
     .. _`TF-A source tree`: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
-    .. _`send a patch`: https://docs.u-boot.org/en/latest/develop/sending_patches.html
+    .. _`send a patch`: https://docs.u-boot-project.org/en/latest/develop/sending_patches.html
     """
     def __init__(self, section, etype, node):
         # Put this here to allow entry-docs and help to work without libfdt
diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index d2ed35bef4d0..27dc620bd359 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -55,7 +55,7 @@ HS-FS and HS-SE parts will not boot without this certificate.
 Have a look at your board's documentation to find and include the latest
 TIFS certificate blobs and how to include them in the build.
 
-    https://docs.u-boot.org/en/latest/board/ti/k3.html
+    https://docs.u-boot-project.org/en/latest/board/ti/k3.html
 
 tee-os:
 See the documentation for your board. You may need to build Open Portable
@@ -69,7 +69,7 @@ will not boot without this firmware.
 Have a look at your board's documentation to find the latest version of
 the DM firmware binary and how to include it in the build.
 
-    https://docs.u-boot.org/en/latest/board/ti/k3.html
+    https://docs.u-boot-project.org/en/latest/board/ti/k3.html
 
 ti-fs-enc.bin:
 You are missing TI's Foundational Security (TIFS) firmware which is
@@ -80,4 +80,4 @@ this firmware.
 Have a look at your board's documentation to find the latest version of the
 TIFS firmware binary and how to include them in the build.
 
-    https://docs.u-boot.org/en/latest/board/ti/k3.html
+    https://docs.u-boot-project.org/en/latest/board/ti/k3.html
diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
index 7c9ab0f2a27e..2f17588e9df4 100644
--- a/tools/binman/pyproject.toml
+++ b/tools/binman/pyproject.toml
@@ -19,7 +19,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://docs.u-boot.org/en/latest/develop/package/index.html"
+"Homepage" = "https://docs.u-boot-project.org/en/latest/develop/package/index.html"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.toml
index 274042df1553..5f5c405afbf0 100644
--- a/tools/buildman/pyproject.toml
+++ b/tools/buildman/pyproject.toml
@@ -23,7 +23,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://docs.u-boot.org/en/latest/build/buildman.html"
+"Homepage" = "https://docs.u-boot-project.org/en/latest/build/buildman.html"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
diff --git a/tools/dtoc/pyproject.toml b/tools/dtoc/pyproject.toml
index cc96cf784c66..53b09dba8859 100644
--- a/tools/dtoc/pyproject.toml
+++ b/tools/dtoc/pyproject.toml
@@ -19,7 +19,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://docs.u-boot.org/en/latest/develop/driver-model/of-plat.html"
+"Homepage" = "https://docs.u-boot-project.org/en/latest/develop/driver-model/of-plat.html"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
index 91802c8cc277..0fc4b7d4ecda 100644
--- a/tools/patman/pyproject.toml
+++ b/tools/patman/pyproject.toml
@@ -19,7 +19,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://docs.u-boot.org/en/latest/develop/patman.html"
+"Homepage" = "https://docs.u-boot-project.org/en/latest/develop/patman.html"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [project.scripts]
diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index ed04d956b4e6..1c6a023ee4b3 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -18,7 +18,7 @@ classifiers = [
 ]
 
 [project.urls]
-"Homepage" = "https://docs.u-boot.org"
+"Homepage" = "https://docs.u-boot-project.org"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
 [tool.setuptools]
-- 
2.43.0

