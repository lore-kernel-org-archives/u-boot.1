Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4433AD6DDFA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FDCA89676;
	Fri, 15 Nov 2024 14:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="msUITVQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C45489326; Fri, 15 Nov 2024 14:48:26 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72D389348
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83ac817aac3so64454939f.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731678502; x=1732283302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMS0tPfdY+301WVNDEnp925eU4HNoMo7yXKaA0G3g9I=;
 b=msUITVQ2UoIki6tIu5HBUAxEL3CWJIijaMMujwYd3My+SyIH9V9Ml29Yc9NbDKfIoK
 sFUtrHc4wg/q8erToTGSOPaxGu8W8hfMza84sGDLfdHzSUm0bC3561yTSNxfqeRbWgF8
 KbGzhpUTmvWEGRlVOXLh/K7gYtJI4ff2RPKCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731678502; x=1732283302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMS0tPfdY+301WVNDEnp925eU4HNoMo7yXKaA0G3g9I=;
 b=fleu5V8qZkGLtKs2awhcuJQlNiDwdE4XohAreESWC7hgMZedNRXi9DmiAn1RvZdyu3
 Z17zjvn4FAkzxxdATx/APAX83/GQL6N2xBOZ0jNETsifE2RBOO/URRfDIp6tbyaDtNMz
 g3y1kw8Iu0NDbWgoVC53wly1VlO3Of5HmTY0BKnxfsXuM4ptG9lIZYee7tNtX9aX4Njj
 RH4EpEbVS8GCSdLZyZVpr4J6Im8smoTy4YFjOhSDl3LtQJUx4t8USaJKJ3ZHuae+lv+6
 Gx7mzZVJKK7e0+EixAtt/U0ripeYpQlxJkCDGSw+0wkz3mUcG2at5QMgnHhYf5FRWV8a
 F+XQ==
X-Gm-Message-State: AOJu0YzwQkLyF31oUWbghhr5kD/q+LBWYEaHLkKnEMXA/jy+JBhYXZMw
 2GAUH9Sl/VSeX9vd1aCerS+W5jHKXreg9dU4iYxrZD2dRwplx+y76lXdCoBhUMxRCPJ4s129VEc
 =
X-Google-Smtp-Source: AGHT+IFVdnfJa4U0aT0IR9xkgKAtnJDAN3BqK/6X45M93hEYfbiLearFaPcXRhdLVwCXaKpkBvNUbg==
X-Received: by 2002:a05:6602:27c7:b0:83a:b33a:2f2e with SMTP id
 ca18e2360f4ac-83e6c154772mr278699139f.14.1731678501681; 
 Fri, 15 Nov 2024 05:48:21 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df91554sm34118439f.9.2024.11.15.05.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:48:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 3/6] docker: Drop coreboot for arm64
Date: Fri, 15 Nov 2024 06:48:04 -0700
Message-Id: <20241115134807.3068947-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115134807.3068947-1-sjg@chromium.org>
References: <20241115134807.3068947-1-sjg@chromium.org>
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

This isn't needed for sandbox builds and coreboot isn't much used on
arm64, nor does U-Boot have a build that supports running from coreboot
on any ARM target.

So drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/docker/Dockerfile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 7389661c4c5..c3fd9a04287 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -255,7 +255,8 @@ RUN mkdir /tmp/trace && \
     rm -rf /tmp/trace
 
 # Build coreboot
-RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+    wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-24.08 && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
@@ -266,7 +267,8 @@ RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp
     make olddefconfig && \
     make -j $(nproc) && \
     sudo mkdir /opt/coreboot && \
-    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/
+    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/; \
+    fi
 
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
-- 
2.34.1

