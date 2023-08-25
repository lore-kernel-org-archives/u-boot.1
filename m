Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E5BC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 17:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0DD86AB5;
	Fri, 25 Aug 2023 19:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K/DVLWTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC55586963; Fri, 25 Aug 2023 19:21:33 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B028643A
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 19:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59289606ca6so13853427b3.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692984089; x=1693588889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8MtbIylnr2PHtrzv1dcYeAQn8JrP9C7GMR8waeJDmzw=;
 b=K/DVLWTiV/gVp2T2dlAnC9sFg8R6JSx3NietvU2M7u9qeDIZiE8EhmCC7EICETbIeS
 TYCAx1Mu1kyWowdsNuzPT6h75vgc67+SiWCx5dHb2J56sVB9n1dYhJqyy2rLHGI2jySk
 kr5tE45gP65A02GbJvE5L72tlDVIcFaB0IG+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692984089; x=1693588889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8MtbIylnr2PHtrzv1dcYeAQn8JrP9C7GMR8waeJDmzw=;
 b=g7ZDxVgyCqIZ0U05uhqnjnjuXAIioU5MK1SRpNn+qqrIj5gl4AgZVS6o3giJAkwrYX
 doy/fblhPAqnFLB349mWlP5MHhVJZnc+KAErGcgOv/7mnw0cESyaj61NLyrqSRsyNFV3
 tyZZo+/pEsuASwCScI4j/8+Q50XPh/oLYK6YbtgjdgAjx7NwKj9yDwRXQDbOUOJU4R3y
 dLj5e//vzSA4bwD7IrNuAndBbaWjh5kcUf+8A4R3u6naLlCOSPXkjyFbaCyfR/Xak5Px
 0O94MHvk+MRXdRpBDJRV4trJzOgmUZQ/oRvwBsh2RAZ65UbeO+x5saRoOBK2xtmKdUWf
 ZdNw==
X-Gm-Message-State: AOJu0YyOaR1TbQq7C2LPUNqTB0njtkY+3+xd5dwMYNpXxqVOs+eAKLnv
 y9oWWQRMQGQ4zBxkrAiPKs8o7owTZ3lTev6KCvxkAw==
X-Google-Smtp-Source: AGHT+IGyYu93gyY3E8/afdhUTJ/4cHKupAzYUkSUDz1pxElm3YWGS9XxjORMs2+qzQiapedCqsEpxA==
X-Received: by 2002:a0d:d5d4:0:b0:586:9d8e:8322 with SMTP id
 x203-20020a0dd5d4000000b005869d8e8322mr22298137ywd.2.1692984088727; 
 Fri, 25 Aug 2023 10:21:28 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a0dc302000000b0057a0e5b18e0sm590469ywd.142.2023.08.25.10.21.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 10:21:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/2] CI: Update to gcc-13.2.0
Date: Fri, 25 Aug 2023 13:21:26 -0400
Message-Id: <20230825172127.3406461-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

The latest kernel.org toolchains for gcc are now 13.2.0, so upgrade to
that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml        |  2 +-
 .gitlab-ci.yml              |  2 +-
 tools/buildman/toolchain.py |  2 +-
 tools/docker/Dockerfile     | 58 ++++++++++++++++++-------------------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 0be317b38867..711b067c1f31 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -195,7 +195,7 @@ stages:
           ln -s /opt/nokia/libc6_2.5.1-1eglibc27+0m5_armel.deb nokia_rx51_tmp/
           ln -s /opt/nokia/busybox_1.10.2.legal-1osso30+0m5_armel.deb nokia_rx51_tmp/
           ln -s /opt/nokia/qemu-system-arm nokia_rx51_tmp/
-          export PATH=/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin:$PATH
+          export PATH=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin:$PATH
           test/nokia_rx51_test.sh
 
   - job: pylint
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5750d8202332..aff6a5c2dce1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -235,7 +235,7 @@ Run tests for Nokia RX-51 (aka N900):
       ln -s /opt/nokia/libc6_2.5.1-1eglibc27+0m5_armel.deb nokia_rx51_tmp/;
       ln -s /opt/nokia/busybox_1.10.2.legal-1osso30+0m5_armel.deb nokia_rx51_tmp/;
       ln -s /opt/nokia/qemu-system-arm nokia_rx51_tmp/;
-      export PATH=/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin:$PATH;
+      export PATH=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin:$PATH;
       test/nokia_rx51_test.sh
 
 # Check for any pylint regressions
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index b05001194e42..79c7c11a1105 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -499,7 +499,7 @@ class Toolchains:
         if arch == 'aarch64':
             arch = 'arm64'
         base = 'https://www.kernel.org/pub/tools/crosstool/files/bin'
-        versions = ['13.1.0', '12.2.0']
+        versions = ['13.2.0', '12.2.0']
         links = []
         for version in versions:
             url = '%s/%s/%s/' % (base, arch, version)
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 3d2b64a355f3..93fe8c613244 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -14,19 +14,19 @@ RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
 RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main | tee /etc/apt/sources.list.d/llvm.list
 
-# Manually install the kernel.org "Crosstool" based toolchains for gcc-13.1.0
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-aarch64-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-arc-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-arm-linux-gnueabi.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-i386-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-m68k-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-mips-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-microblaze-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-nios2-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-powerpc-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-riscv64-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-riscv32-linux.tar.xz | tar -C /opt -xJ
-RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-sh2-linux.tar.xz | tar -C /opt -xJ
+# Manually install the kernel.org "Crosstool" based toolchains for gcc-13.2.0
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-aarch64-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-arc-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-arm-linux-gnueabi.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-i386-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-m68k-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-mips-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-microblaze-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-nios2-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-powerpc-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-riscv64-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-riscv32-linux.tar.xz | tar -C /opt -xJ
+RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-sh2-linux.tar.xz | tar -C /opt -xJ
 
 # Manually install other toolchains
 RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
@@ -134,11 +134,11 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	mkdir -p /opt/grub && \
 	./configure --target=aarch64 --with-platform=efi \
 	CC=gcc \
-	TARGET_CC=/opt/gcc-13.1.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc \
-	TARGET_OBJCOPY=/opt/gcc-13.1.0-nolibc/aarch64-linux/bin/aarch64-linux-objcopy \
-	TARGET_STRIP=/opt/gcc-13.1.0-nolibc/aarch64-linux/bin/aarch64-linux-strip \
-	TARGET_NM=/opt/gcc-13.1.0-nolibc/aarch64-linux/bin/aarch64-linux-nm \
-	TARGET_RANLIB=/opt/gcc-13.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ranlib && \
+	TARGET_CC=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-strip \
+	TARGET_NM=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-nm \
+	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-ranlib && \
 	make && \
 	./grub-mkimage -O arm64-efi -o /opt/grub/grubaa64.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
@@ -148,11 +148,11 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	make clean && \
 	./configure --target=arm --with-platform=efi \
 	CC=gcc \
-	TARGET_CC=/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc \
-	TARGET_OBJCOPY=/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy \
-	TARGET_STRIP=/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-strip \
-	TARGET_NM=/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-nm \
-	TARGET_RANLIB=/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ranlib && \
+	TARGET_CC=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc \
+	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy \
+	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-strip \
+	TARGET_NM=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-nm \
+	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ranlib && \
 	make && \
 	./grub-mkimage -O arm-efi -o /opt/grub/grubarm.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
@@ -162,11 +162,11 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	make clean && \
 	./configure --target=riscv64 --with-platform=efi \
 	CC=gcc \
-	TARGET_CC=/opt/gcc-13.1.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc \
-	TARGET_OBJCOPY=/opt/gcc-13.1.0-nolibc/riscv64-linux/bin/riscv64-linux-objcopy \
-	TARGET_STRIP=/opt/gcc-13.1.0-nolibc/riscv64-linux/bin/riscv64-linux-strip \
-	TARGET_NM=/opt/gcc-13.1.0-nolibc/riscv64-linux/bin/riscv64-linux-nm \
-	TARGET_RANLIB=/opt/gcc-13.1.0-nolibc/riscv64-linux/bin/riscv64-linux-ranlib && \
+	TARGET_CC=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-strip \
+	TARGET_NM=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-nm \
+	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ranlib && \
 	make && \
 	./grub-mkimage -O riscv64-efi -o /opt/grub/grubriscv64.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
@@ -277,7 +277,7 @@ RUN virtualenv -p /usr/bin/python3 /tmp/venv && \
 
 # Create the buildman config file
 RUN /bin/echo -e "[toolchain]\nroot = /usr" > ~/.buildman
-RUN /bin/echo -e "kernelorg = /opt/gcc-13.1.0-nolibc/*" >> ~/.buildman
+RUN /bin/echo -e "kernelorg = /opt/gcc-13.2.0-nolibc/*" >> ~/.buildman
 RUN /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman;
 RUN /bin/echo -e "\n[toolchain-alias]\nsh = sh2" >> ~/.buildman
 RUN /bin/echo -e "\nsandbox = x86_64" >> ~/.buildman
-- 
2.34.1

