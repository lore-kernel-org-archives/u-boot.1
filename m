Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9CFD6ACF4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FB189834;
	Wed, 27 Nov 2024 18:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jg78lzZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C868981F; Wed, 27 Nov 2024 18:23:11 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB248981C
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d41ac03343so354186d6.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728186; x=1733332986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPy52hz39rqeTFdGwqAY0FWuJnF3ELvUljbl5TMUArw=;
 b=Jg78lzZ2besZfPFcoQPZS29Vxv0QxLVeFNw1FEpq6CYnne3rbZBExRSaaIYEIyatzf
 TgBOcNWHiC4XKyGehNJ+kFGcrjRDRdyJATjLI0iC/RjnYH2QcSlpqZ7hpoT6z0GiEN2t
 RC2Mdq46KtFur9FPUj35QP7yNhvxkR80ceCBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728186; x=1733332986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPy52hz39rqeTFdGwqAY0FWuJnF3ELvUljbl5TMUArw=;
 b=vsyBAVjFBf19UkYgbd+pnyQgZVxoIX3ETgKMjNDXpwQwW+KkF0Qm3LRRsYt8xa+oDR
 uJtco/arm1DR9ASH9PvTjMHmec+YeDuYkc01ZMWPjb2OD1Y9/gdl25j4ysQPYpSGDFnH
 bssaA+HSE/oVT2nh0HMvXNFjOrNCTNGP4gcA9SkedVkUSMLecP14YQAa/27bQgFvozs+
 ZC7ILOKZvu8dudu7Uf0qbKqq0zF0CBOTIAmKU9a9zlcJcs7b34e2pbiK6jBhrdtoJ8Ra
 +L518NbKI2RD3e/LfrXIq0m0tBxO1LJMwPASzNK3Yhy8A5pW+PUnCQxtxehqQYGsGEEq
 Mazg==
X-Gm-Message-State: AOJu0Yx8/tr2rv/6y+C1JOWRGYjuBHJe7xO9gWKXCNAIkFOH2eOYItlE
 lXYdvEMh6hU4E1m9SXVo8+JlSyQ48LNHfdtYmLHeAJ9QDBkxqPl+At+HM1Y1R6IUZ0TRv2lTjXk
 mKT8=
X-Gm-Gg: ASbGnctjxNL7KmFVivN+CYkhlQA9drmGmrtvb2rHmPTU6/YMHbMul4N0ByLNUM5O4B4
 V+8iP1FscZoqYS63qeMRxKDdUg1/9LfBkat0M+MXvlX4F/fwNpLwgM2kPNTVGJymEYTzG5WOARY
 jU7q1YcjKgPawgvOCA279WOt2BqsbvTREz+cXpWLK5tMWxD2ZNbhn7ZfC5NyQ9msnTqaC19wbR6
 5Lz3+fK3fa5UScEd+jbIG0HA07kDYLryrIDn8rCC7bC4D1/RAh5B1T+pFuY8quEFvTM71AR
X-Google-Smtp-Source: AGHT+IGpFEqve3IdGz7CTHrEF7upLySDBaH1aJPnZt98g5HHKM9649XOxHXz48VJjOsh+NBMkViWsg==
X-Received: by 2002:a05:6214:e6d:b0:6d4:1b71:402f with SMTP id
 6a1803df08f44-6d87297035cmr2659396d6.9.1732728186385; 
 Wed, 27 Nov 2024 09:23:06 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:23:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 11/12] docker: Install toolchains on arm64 host
Date: Wed, 27 Nov 2024 11:17:29 -0600
Message-ID: <20241127172247.1488685-12-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Refactor the code to support downloading toolchains for arm64 as well as
x86_64

There doesn't seem to be an xtensa toolchain for arm64 at the same
location, so download that only on x86

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- Add x86_64 to the toolchain list
---
 tools/docker/Dockerfile | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 9d10de5b8926..ce1ad7cb23a2 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -16,6 +16,15 @@ ARG BUILDPLATFORM
 # Make sure apt is happy
 ENV DEBIAN_FRONTEND=noninteractive
 
+# Set architectures to build for (leaving out ARM which is an exception)
+ENV ARCHS="aarch64 arc i386 m68k mips microblaze nios2 powerpc riscv64 riscv32 sh2 x86_64"
+
+# Mirror containing the toolchains
+ENV MIRROR=https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin
+
+# Toolchain version
+ENV TCVER=13.2.0
+
 RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
 
 # Add LLVM repository
@@ -25,23 +34,25 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
 RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main | tee /etc/apt/sources.list.d/llvm.list
 
-# Manually install the kernel.org "Crosstool" based toolchains for gcc-13.2.0
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-aarch64-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-arc-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-arm-linux-gnueabi.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-i386-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-m68k-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-mips-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-microblaze-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-nios2-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-powerpc-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-riscv64-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-riscv32-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-sh2-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-x86_64-linux.tar.xz | tar -C /opt -xJ
+# Create a list of URLs to process, then pass them into a 'while read' loop
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then HOSTARCH=x86_64; else HOSTARCH=arm64; fi; ( \
+	# Manually install the kernel.org "Crosstool"-based toolchains
+	for arch in $ARCHS; do \
+		echo $MIRROR/$HOSTARCH/$TCVER/${HOSTARCH}-gcc-$TCVER-nolibc-${arch}-linux.tar.xz; \
+	done; \
+	\
+	# Deal with ARM, which has a 'gnueabi' suffix
+	echo $MIRROR/${HOSTARCH}/$TCVER/${HOSTARCH}-gcc-$TCVER-nolibc-arm-linux-gnueabi.tar.xz; \
+	\
+	) | while read url; do \
+		# Read the URL and unpack it into /opt
+		wget -O - $url | tar -C /opt -xJ; \
+	done
 
 # Manually install other toolchains
-RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+		wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz; \
+	fi
 
 # Update and install things from apt now
 RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
-- 
2.43.0

