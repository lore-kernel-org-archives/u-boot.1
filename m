Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6F2C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04FC98164D;
	Fri,  7 Mar 2025 00:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rltfkPG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF61810F5; Fri,  7 Mar 2025 00:23:21 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF418164D
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6fead317874so11853267b3.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303395; x=1741908195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vFq/u3G5hd50LpLI2qpXpwX1FVscLul2Jq9elZ+TirI=;
 b=rltfkPG/1RyIbWAG6sXvw5ieF4sWzrYW8AqRAjc91zo/K/Mlcxx+3i0jNy/bRa3fAp
 4IKJQnBWPlGndhRqagNPuJTcm+99OuXKKTZrTEilaJiw8SYu5kEcDbFyfDRU5jxbQCJv
 Wbe5CpF0tCZ6KEdPay3yrXykvI6asgXTtC/Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303395; x=1741908195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFq/u3G5hd50LpLI2qpXpwX1FVscLul2Jq9elZ+TirI=;
 b=Y9H9vkaFzUBS4MdLIVAdqOhMzcHl4AGD4sPPjRXk/3QlYuRqCOG1ydp7/gZ8hKRcsC
 dXf9dD64MJZc4guCpd0yEmHr3vw9hAX0vWfQ5ZlocZOa1JuTQa03iaArUF+ck9VyNV7W
 K1UPILNr8ioDwm08K+8VZht7yEXbkymOwFa1815G76m5P3XGu5DkPvfMtnC5LjwXd5il
 Cc9eIKztkArWf53nlJrGyVjXAmP5Yfp6cylVVLvhXZ9upnZnQrOL6ovS/z36bHfNZ9S/
 Oy3azjImwmPX/+7v9JV/D01dJWX1usMXm2SJCxnNC41KTPnxv1G7tSjzLDzfrs81SqAY
 NnuA==
X-Gm-Message-State: AOJu0YyTveLukBM6VE1LX7dHwKHG++CmMHI9l2rkyP96TlVaP/pxpfeU
 o1kRFKCOIpfgVwVOmW84iIkiV0Je2wE04oxHzxjs82p4EAe7xxRSnJhiyT3OlquJA8UAcpDTPY6
 t
X-Gm-Gg: ASbGncuN7J7MiWr2lOfWIw+aspU8SixZOdWNqU5l9IqzFWjgK/NYOS7Y5HkisVQfn6s
 G62AoOdVMTa0xbKsqITcD6so1QitPOZa58imNTifUlKbXusO2HtXTRNa+P+JbMGU59JC7RJMNfe
 0ksTqiJjTmAhuaxBAnry7/DbH7Dcg/fWdjU6t1C05iiTIn8e74V9jkPEnyxQ4L5rDLa6z0lLMKN
 oZEMmFWnXz3v4okMpN/+jV49+uPO3AncGXtS242yrjKsvqk2Oi3O7XLkiM4Nb8Sxp2KkYFeMa9X
 P9niHTI4aq1JGtDLG+z2CcJLMNWT1xhFGNXzPoG6SdmwhqDv
X-Google-Smtp-Source: AGHT+IHB3kRdi609Gh76V//omnXOKgxzZd9T5p2k4ldIZ/AoiZJ/H2Te0zdD142GMfBOPvSAx0bIQQ==
X-Received: by 2002:a05:690c:6386:b0:6ef:57ad:9d6e with SMTP id
 00721157ae682-6febf2f2695mr19747587b3.15.1741303394985; 
 Thu, 06 Mar 2025 15:23:14 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 10/10] Dockerfile: Update to drop virt-make-fs packages
Date: Thu,  6 Mar 2025 17:17:12 -0600
Message-ID: <20250306232256.4150882-11-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306232256.4150882-1-trini@konsulko.com>
References: <20250306232256.4150882-1-trini@konsulko.com>
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

Now that we do not need nor want people to use virt-make-fs for
filesystem tests, remove the related packages from the installation
list.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 85d67848327d..15a43811a0f7 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -91,7 +91,6 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	libconfuse-dev \
 	libgit2-dev \
 	libjson-glib-dev \
-	libguestfs-tools \
 	libgnutls28-dev \
 	libgnutls30 \
 	liblz4-tool \
@@ -105,7 +104,6 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	libtool \
 	libudev-dev \
 	libusb-1.0-0-dev \
-	linux-image-generic \
 	lzma-alone \
 	lzop \
 	mount \
@@ -142,9 +140,6 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	xxd \
 	zip
 
-# Make kernels readable for libguestfs tools to work correctly
-RUN chmod +r /boot/vmlinu*
-
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
 RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	cd /tmp/grub && \
-- 
2.43.0

