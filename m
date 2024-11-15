Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DFDD6DDE3
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B5D89650;
	Fri, 15 Nov 2024 14:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EStyug06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04072896C8; Fri, 15 Nov 2024 14:48:32 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7709189221
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8323b555a6aso36848039f.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731678507; x=1732283307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPBRrOyPudw7pvoTaa8rX5Dtyyi6Ti+ZFFNxMJ0U7v4=;
 b=EStyug06pa8P2qe6ob0regAwbZz4mZZ92tBv0CWTEOyOtaKWLWkhae3e+6N5VkQcDn
 r/DixNXJsNJ+1KicFf6gnhcTHbvssijzgoDMZAr1dyXrALXsxZsP33NKSy/BWHwy6zl8
 YjD2nrK5vfR5AqY2lOO77CySiG/tokj1OjLqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731678507; x=1732283307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPBRrOyPudw7pvoTaa8rX5Dtyyi6Ti+ZFFNxMJ0U7v4=;
 b=l9TQ128FRuHzIKW/WR3o1aX3TdJip2DPzv+sRvXKvE5nUHYecOHjDuH2XiH3/vJj1N
 KkEgOS9x/3u2k+df+RUB3m8HAtpzURtsgH7/o6vcxFdNIyQn0QrgbpQ2JmNaZpXj0nA6
 4/Z+xq6bUvGCmuOdFevRzU1Ox59QDtTKVhGeleMeGp8lpKcj5OvumWx8DiFkk1wUXnoS
 xEmdwRL5zVqT9hWJz7j4ekfjrUbl1McAlJ5IKSaRDUD1p9gO8jOYkDQ3K+vMl+XHnydW
 TWn2+1QEFo55hb2je3j3B4xRyHPkChirlqMxl3evsHbU2M6ip4sAdccqIZm2bfgOyzSL
 /wYQ==
X-Gm-Message-State: AOJu0Yw3RHypvo0AHNtX4ulyzK0SUsLvGjxaYs2LlBAtNFx13V9gT1fI
 rJXOvwn2RkviGjob/eKqLAlEkq+LdoX4HT2H9DwM/YwMsLMhx/I1lyd+VsNE4Wxaee0GRfkeLYY
 =
X-Google-Smtp-Source: AGHT+IEUgWdjuhLuU/uIs1EgLyUPFOXo+F4cCFK8UwGprHCqp6FDhYd4AblWRQdHXQpcUCefqdlZBg==
X-Received: by 2002:a05:6602:3f85:b0:83a:b188:7a4d with SMTP id
 ca18e2360f4ac-83e6bf79ed5mr316665739f.0.1731678507242; 
 Fri, 15 Nov 2024 05:48:27 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df91554sm34118439f.9.2024.11.15.05.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:48:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 5/6] docker: Install toolchains on arm64 host
Date: Fri, 15 Nov 2024 06:48:06 -0700
Message-Id: <20241115134807.3068947-6-sjg@chromium.org>
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
index 22aeb90f9bf..ac3638d6093 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -16,6 +16,15 @@ ARG BUILDPLATFORM
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
@@ -23,22 +32,25 @@ RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib
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

