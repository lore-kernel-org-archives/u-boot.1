Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FBDD637A8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7848955E;
	Wed, 13 Nov 2024 19:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KeFLsX9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1843089549; Wed, 13 Nov 2024 19:54:06 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2422489274
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a6be369d23so26426105ab.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524041; x=1732128841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ChhiT483sm+1hUiQKs5kyrQgB2IgonH+9xeRHPWdG0=;
 b=KeFLsX9dKMs7D/l93E+toBJXrYzDeFT6maWLsDBXOQBSd0ECiffzGNECSDm21z8TQv
 DsVr/n64Mlo9rqMKMBddpFPa3E4CYbr5MdXBBee28FQV5ZNeYo95bBSMVq00rX0UjT9q
 QGDlhrVUbi+jao2RfaL/j5FEBYXmHJrEWWwng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524041; x=1732128841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ChhiT483sm+1hUiQKs5kyrQgB2IgonH+9xeRHPWdG0=;
 b=KVcvTcsb9Y6JLMvXP3L0rR1uewKZeGQeFs4jsHxc3TGQvJB8WZDjIB0Tf90Wz0R5LG
 FFsRpdezrZynyNrMq59Ib9zvjgutPtiRhO7fi/5O9mPkmbvJ9qOMGZ4Oyel6DjR5SHf8
 lyg71Fwx1jAda1OzhQ/U0zWpZoCJAGCSaFE3AKfeLt08tV70AmyYRTDtanKwA6dirQR1
 zBD/R6ildRbedmlPisYGZ/uMUFZ7D6lxwWn7nIyK3335q54pWNFubDyRLLoTl3cpb8Oe
 RqvJrLV3qpZYchhduhz9Ii81XuNQUnCDFgpobFmkrsj86vys/9DeVhA+s/c19+pLxhZH
 EVeQ==
X-Gm-Message-State: AOJu0YzFfAUy5JYdIF+iAOPy/9CtfXief9jPjP/f1Hld+8ZaTQyHWTiC
 1GGwEJAWWvg1O2F1VjmmQdBXRWa6QlbmW559PCmO6Topj2nzIMdcUH9Wf4Y2dg2yVESZkwXCb6g
 =
X-Google-Smtp-Source: AGHT+IHLsQsjxOkwxNS9fWGW9/ap6joLxUWkv0FbKf2lUOsXndAPEoj5mcWaUocpzshTA++oE89vJg==
X-Received: by 2002:a05:6e02:1d98:b0:3a7:1c60:7de2 with SMTP id
 e9e14a558f8ab-3a71c607eb2mr22619495ab.9.1731524041304; 
 Wed, 13 Nov 2024 10:54:01 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:53:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 5/9] docker: Drop coreboot for arm64
Date: Wed, 13 Nov 2024 11:53:36 -0700
Message-Id: <20241113185340.1661198-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113185340.1661198-1-sjg@chromium.org>
References: <20241113185340.1661198-1-sjg@chromium.org>
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
index fd4835e9562..048a57c5b16 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -258,7 +258,8 @@ RUN mkdir /tmp/trace && \
     rm -rf /tmp/trace
 
 # Build coreboot
-RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+    wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-24.08 && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
@@ -269,7 +270,8 @@ RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp
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

