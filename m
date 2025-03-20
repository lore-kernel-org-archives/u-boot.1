Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3DBC35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C4E18129F;
	Thu, 20 Mar 2025 15:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XYIY17S6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36D881101; Thu, 20 Mar 2025 15:00:49 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4927F819B1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so1081300a91.0
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479245; x=1743084045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A8634JPKmY+nq+QA5YUua9+6dhYR7I+bxyt/wOcsVWI=;
 b=XYIY17S6mBdX0oeFgoeiWhcYn98Fl9rQpuwXiK9QtUm8HWFE9lRK3D9KPbVAXZOYmG
 RsNncwt7yFf5OJKhvwWPz8M/nMzHGvb+PfYPtRyAZqzHMOieEbvT/SiO1yUzoLBq/KIi
 KEsfsPl+7mMvjzpV1sdxD3dt50n72CbKixXDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479245; x=1743084045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8634JPKmY+nq+QA5YUua9+6dhYR7I+bxyt/wOcsVWI=;
 b=SmWUjf6VjDS7vdfPLV4THPkjhawGHORw5r+HgjfZg2ssDaYdrfZL/LksPAZqjsQ/SC
 Z3uiwgs1E1DFMDhrRRGZAhvEsgYODH4sZPY+I+erEreGqB8cD1p0Bdhod9DTtJKJzy81
 Vxp3G6sqkSq3eHzdum3jBuGcX/snJOzKSZWJlUTI5GNNmluUaP3C6ww7t1PYw4fd2tu1
 uCzOkICoadJKoKsfjb0zzt03mGaaI6+G8sLZrbnlRnRIdwh5EmJq4pl4ro1AoIvZhymR
 dl+F5sP4pTWpObz4Eurc0ziuAYxLLQ+gzZLZ82I/1h8/pXPRJbw/I7VWkIWqfSbywXQz
 +cmA==
X-Gm-Message-State: AOJu0YxCFV/6oqFxy1AZgSIRvu9oGoJ2mBkLbB630XlkG9u2+YEEsfIk
 FFvzJ/6e7ZUb79xP51fyAVtHgfd9VBo0umpAeHSlWRvM2OhCltDgoyYLFOWy+dyM/tH4ZJbLLjw
 b
X-Gm-Gg: ASbGncv6XgRivekuau1Q6n0J6vjFNSsExP0+IKR7uOaUmxBlEHM4/TRnDKUKV6BE5NO
 iTZekEVHtnkMWTDQkVGupgWGmDMrfak+btck8TP7ADAzdy4zEKvTRxbkQgxyUyGoyUfhzxLKeFC
 ivTOL8wwtVIOi5kZJ2dO/3I/r+CstOSOwH2Fu4lmZgV0ERAV9w5gCiS4ANiE5Cxc95/KIsMgVy3
 UjC0qLVnqyG77iyyP1uMkYH1YkGobjYzyqfY8S+KI07khszU46WGmNvvAZZ2wRjC1kj70aRWkzp
 KlV1MQk20dNjPIj3xAI9cma1BJjXh4ahdAgd9ksp1wxJFlG2
X-Google-Smtp-Source: AGHT+IGLPhZInPg18i7/dwZ9naLhlt84vVu/woqrqv4LIq6Wen/9RSQHQbh5+yhHjCCA82GJ0dQv6g==
X-Received: by 2002:a17:90b:4fc3:b0:2fe:7f40:420a with SMTP id
 98e67ed59e1d1-301d52c42femr5760557a91.17.1742479244614; 
 Thu, 20 Mar 2025 07:00:44 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 10/10] Dockerfile: Update to drop virt-make-fs packages
Date: Thu, 20 Mar 2025 07:59:31 -0600
Message-ID: <20250320140030.2052434-11-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140030.2052434-1-trini@konsulko.com>
References: <20250320140030.2052434-1-trini@konsulko.com>
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
Changes in v2:
- None
---
 tools/docker/Dockerfile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 569912303fc9..f28fbf97cac6 100644
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

