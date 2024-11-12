Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC910D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8D3A89467;
	Tue, 12 Nov 2024 15:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aFqSkn7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD3489469; Tue, 12 Nov 2024 15:11:28 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032AF8944E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83abcfb9fd4so219643139f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420684; x=1732025484; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBLVwq9s/mj3+dKcVFoeWXX+HuduBASOZYMPTDhbCiw=;
 b=aFqSkn7/dT571hQAXkIZzVGN0ahRd1kOOT6RL2F0fxoQdnfZKymenoGCZIjbHxwHsf
 b5jHno2kSDJnrb4zmJ4Si3TAZ39q+VkveteUHwPC+1basv6hVqcp34nioOBH69utFCvl
 wjwYtiOrJY/mPcZI4d0ti6LNwKNMXQCvG1OGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420684; x=1732025484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBLVwq9s/mj3+dKcVFoeWXX+HuduBASOZYMPTDhbCiw=;
 b=UBagy85d0yP5f4ZHnZ+BGrikju7lKzcWL0pjtU6MqYV3se1gIhEkDztkqCRkjurDJV
 2tYLUJvkw9NzwUloPtN8dgLMoA0hdtBKLa0hO8cM85nPQUsg6k8jGN703Oqbvq6Smb71
 VO5hgjoc4nYHXva7R5cbhBpCGlJpb3L4ULSvuoD7JuY0hD5tMuI3+nFo7CBSbmXMhQiw
 XmZ6CtzgCnozT/ySdGKWGfEA1rGfx6Ot7QnvyC06rMic4OSmNAT3gmva+eYai3gEGHfi
 rFzUy/X4URW8BEGapnw5GPQ1C0W6M3uEwNxCQt5vxxTXMCbI08iH2zeXCiblMIwl67Xq
 zLSg==
X-Gm-Message-State: AOJu0YzxcLLtSFDeAAsvjnIjhPg/bdwExFBczEb7LgIw0DgfKP6J5M72
 /f5cgiJAcTfZliYp06E9+AgBKyZMAmrsecROCS9RixyJ1M0p7paHT6lLR5Ardtk1SCylTXUQcoQ
 =
X-Google-Smtp-Source: AGHT+IHqUwkQhikkzfsw9Frar/XKNphFwsm/hKS/BaZ1seRwy38g3LUhED7z33fQV6K1OBLjLkc4ww==
X-Received: by 2002:a05:6e02:1485:b0:3a3:a307:6851 with SMTP id
 e9e14a558f8ab-3a6f1a504fcmr177826665ab.22.1731420684036; 
 Tue, 12 Nov 2024 06:11:24 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 7/9] docker: Install toolchains on arm64 host
Date: Tue, 12 Nov 2024 07:11:03 -0700
Message-Id: <20241112141105.640189-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141105.640189-1-sjg@chromium.org>
References: <20241112141105.640189-1-sjg@chromium.org>
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

Refactor the code to support downloading toolchains for arm64 as well as
x86_64

There doesn't seem to be an xtensa toolchain for arm64 at the same
location, so download that only on x86

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add patch to install toolchains on arm64 host

 tools/docker/Dockerfile | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index aa97dadbd64..4ca1d3fb013 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -19,6 +19,15 @@ ARG BUILDPLATFORM
 # Make sure apt is happy
 ENV DEBIAN_FRONTEND=noninteractive
 
+# Set architectures to build for (leaving out ARM which is an exception)
+ENV ARCHS="aarch64 arc i386 m68k mips microblaze nios2 powerpc riscv64 riscv32 sh2"
+
+# Mirror containing the toolchains
+ENV MIRROR=https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin
+
+# Toolchain version
+ENV TCVER=13.2.0
+
 RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
 
 # Add LLVM repository
@@ -26,22 +35,25 @@ RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib
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
 RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
-- 
2.34.1

