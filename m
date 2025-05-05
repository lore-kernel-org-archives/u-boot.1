Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5B4C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 14:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631F68212B;
	Mon,  5 May 2025 16:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="McMG6yL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4980E82161; Mon,  5 May 2025 16:43:22 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 271728210D
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 16:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [213.157.19.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2424840274; 
 Mon,  5 May 2025 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746456198;
 bh=sZRTcLI0kO0LZkIdcoi77Mh76WTkdbnk03hwb7tJjy0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=McMG6yL36lwjX9fZCDykxd+9stj5d4WLe2WqL7lO9zLFcwDp0qr8c/VOb+zT2PQUU
 apmDf78RsazXQb0q72871x1ZucSMYAXsGi05pl9fQXF1DgUP82Rt1IdLs4NGblkDnh
 ljiH14hGM05qUUK7/NGAfh03/SbPGeil6Fk5KPC/rcVUGYmm/xE/OFA2RivIQLT5QV
 aUMTBHezdWvVPblsC458QfSZQ4wRAhyfNwMsdL/IaG8LL3LXQW5RIjAZijHwTn26Fj
 Q2rDYSE1wbOuBSqPb3nEmy6wQM6dNSHr159XvDRzV1bTSuQ1SJkc+xp/lheV4RVbfy
 QfhaKXl97ztYQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Dockerfile: use lz4 instead of lz4-tools
Date: Mon,  5 May 2025 16:43:14 +0200
Message-ID: <20250505144314.299359-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Since Ubuntu Jammy lz4-tools is only a virtual package which pulls in
lz4 as dependency.

Update documentation too.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/build/gcc.rst       | 2 +-
 tools/docker/Dockerfile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index 480e0e3091e..c76a7fbd732 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -25,7 +25,7 @@ Depending on the build targets further packages maybe needed
 
     sudo apt-get install bc bison build-essential coccinelle \
       device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
-      liblz4-tool libgnutls28-dev libguestfs-tools libncurses-dev \
+      libgnutls28-dev libguestfs-tools libncurses-dev \
       libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
       pkg-config python3 python3-asteval python3-coverage python3-filelock \
       python3-pkg-resources python3-pycryptodome python3-pyelftools \
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 1d7d2a1877e..ceb7a25ad4d 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -97,7 +97,6 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	libjson-glib-dev \
 	libgnutls28-dev \
 	libgnutls30 \
-	liblz4-tool \
 	libpixman-1-dev \
 	libpython3-dev \
 	libsdl1.2-dev \
@@ -108,6 +107,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	libtool \
 	libudev-dev \
 	libusb-1.0-0-dev \
+	lz4 \
 	lzma-alone \
 	lzop \
 	mount \
-- 
2.48.1

