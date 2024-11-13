Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC657D637A8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99F31894E1;
	Wed, 13 Nov 2024 19:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P79rcwlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118C7894E1; Wed, 13 Nov 2024 19:54:12 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E2C88216
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a6bc0600f9so26041815ab.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524047; x=1732128847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/stFwtvHWq3nDoGfUE5Qt4r9POJy8wC1lGAu0y/T14=;
 b=P79rcwlq50YyVuIzHbtcbQGLS5GECoJqyrO8381Y/Yuvvhiq2nmCXFRyn4bBS0xxYc
 Bw6rE0SHa9f70T4YDqD8yI+K8fMIT4gmfRHfZN120JfprhnFAX0brMuAKA8jNh0c0Y7N
 xTg96mlDh+sIwpCC5YIW9kuS+ToVQSBwInJ3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524047; x=1732128847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/stFwtvHWq3nDoGfUE5Qt4r9POJy8wC1lGAu0y/T14=;
 b=h9Kt1wzFY5/ntFj4lPtEW2HPKeOfnnCcIrbBIcKIl2VdluSRpR7qugiIlOLN1M+ETY
 /1YisbRSuSAttbYLuHg899G0K+K/GeVrWFYnpqUG8D8frg/F+2ADO2NftAOJ2gq/KbeQ
 lclbCcfd5A2n+ES1aHI9s7b8rDc5Bn2Y8fHLf5WcwcyMEmr9AmlgG2467XMptwj4T8pd
 AZ4Vxt9NB/ae4NGcEhmG+BeaDfCMUz8Ac65SBiBNYtqlxUx5u7oZgkXsrvWH2jVDxq0c
 FvbYVU8c3yayEBQjdgMJiwikiDGYZ1IHQ8AzQJw/xFMKmZ8ylNrYmPhWxdpkO2P1PBZi
 hhgw==
X-Gm-Message-State: AOJu0Yw1SD3R1AmhZ3WCCUzdw5wyZQEM5ccRW5L1LgBAYPie4RbmvURR
 fuJqq9gLUQhLxu6gsVEPG4DYa0jBoOi5YB7F4GH3d/0pRu5auPYKyGIF47bN5bBVigWW1eItq8U
 =
X-Google-Smtp-Source: AGHT+IE+n7Rej+39fn1wXRbINrouzueZMTJ+ZvpUHth8OAP4vHpUYmm2qHUEKoYjIPToO0KFj8XsEA==
X-Received: by 2002:a05:6e02:3102:b0:3a7:1ba3:1b3a with SMTP id
 e9e14a558f8ab-3a71ba31b3dmr23071055ab.21.1731524047596; 
 Wed, 13 Nov 2024 10:54:07 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:54:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 7/9] docker: Install toolchains on arm64 host
Date: Wed, 13 Nov 2024 11:53:38 -0700
Message-Id: <20241113185340.1661198-8-sjg@chromium.org>
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

Refactor the code to support downloading toolchains for arm64 as well as
x86_64

There doesn't seem to be an xtensa toolchain for arm64 at the same
location, so download that only on x86

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v3)

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

