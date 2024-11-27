Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E873D6ACF4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F20B89816;
	Wed, 27 Nov 2024 18:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dkUERj4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF58897E5; Wed, 27 Nov 2024 18:23:05 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36405897EC
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d41f721047so132636d6.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728181; x=1733332981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mVLGoaM6jlMnWNpSHU5C+0KEvs16d23Umu6dYXmY58=;
 b=dkUERj4jDaadVk95tWyOrVzkP0nAXhEDw0FL5igFocU7+B15LOugADxKv1AM9Ef3Qu
 chBHyEG9iip5bTkHqlIWlCVBWmAg/WLJHh7pFJYyw83Xbhha67wC5rgd/oJojl2/W2+/
 +Sg1xNZLGAPcozVygREG/QgfGiB7lx/PaPw2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728181; x=1733332981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mVLGoaM6jlMnWNpSHU5C+0KEvs16d23Umu6dYXmY58=;
 b=gvJrmbqHw7QWM6Hrb2sfRGW3r7XMaqG6PxZPUuU59IzvAWoHDv6XlW7gqD8neJGEQL
 whlNLRXW9weOEmuyLumD0B3C8DLM9RIKTsUCBu+i99snv8sNrgkxUq4XHr3cwL+1NtD4
 TYTjrLFv/nMhvv/AFnMfeMyWcrfJlM51XLL66Q9OHboS3hO7nbDKSFJWRSyfjtf4is78
 x9n0hRg0LbeUurkCTwIhbJ4LB5lOx4IAuzPZu4cEZiCEVC6EsbQM5YxF/8Ni9yJ8+V72
 MycVFCBE2XlXOcc9jtVL0m52jGOqUFE6NKWH3o5yHoKC0HVaSeRXJIj5snEK5dgO72jS
 mAJg==
X-Gm-Message-State: AOJu0Yy4Oqkx+teLezbKB6GATLa0PoSbMR6KgPgOiF5CoJHb8zJXnfeP
 uqrIAG5Noi0qKA8ERplFbZCraGnqgoq4IRMO2mj1P/z9Au93iEJhRcEr0TJWb0wZVBvFOT3HHBV
 bKaU=
X-Gm-Gg: ASbGnctBelPpRUQiFV1NhR7Gjz46udMS0Lt5B2U0wssLxoGKCxOK2sukE2xommO8gmT
 4OUgmu3TlQ2HIIQqx7MVlQIgUQ/qOO6V9cWSAlzneXSQI51Jo/QhPyxuO6MmpJjNvKaw+n1vkA/
 Jlppag/WrLxawCUDGTkEcqt7O53BOUaEEEKgjrcrMhLD54zYjrtqYpwkTmOBjAEmpwYipE3g8Zj
 GK7l0q0A6O7JBkkO6VVhCTGhyJd798fbJ91JiVTJBlQB+wPKSxqcEi+Ts+uL8bGgPLUQz6g
X-Google-Smtp-Source: AGHT+IE2wCToSzedP8s7vUtif71bnVEQ49QB18IpBoFq5xCioeLQOuOqvyWvnxk8bPg4SQNTgVUptg==
X-Received: by 2002:a05:6214:20a3:b0:6d4:19a0:208 with SMTP id
 6a1803df08f44-6d864d872e3mr53813076d6.29.1732728181141; 
 Wed, 27 Nov 2024 09:23:01 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:23:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 06/12] docker: Build grub for all architectures
Date: Wed, 27 Nov 2024 11:17:24 -0600
Message-ID: <20241127172247.1488685-7-trini@konsulko.com>
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

For consistency now, and future ease of testing with non-amd64 hosts,
build grub for all architectures rather than relying on host binaries
for i386/x86_64.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- New patch
---
 .azure-pipelines.yml    |  6 ++----
 .gitlab-ci.yml          |  6 ++----
 tools/docker/Dockerfile | 24 ++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4ecf76eaa0b5..cc335e5f720c 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -245,8 +245,6 @@ stages:
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
-          grub-mkimage --prefix=\"\" -o ~/grub_x86.efi -O i386-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
-          grub-mkimage --prefix=\"\" -o ~/grub_x64.efi -O x86_64-efi normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd
           if [[ "\${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
@@ -268,8 +266,8 @@ stages:
           fi
           pip install -r tools/buildman/requirements.txt
           tools/buildman/buildman -o \${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e --board \${TEST_PY_BD} \${OVERRIDE}
-          cp ~/grub_x86.efi \${UBOOT_TRAVIS_BUILD_DIR}/
-          cp ~/grub_x64.efi \${UBOOT_TRAVIS_BUILD_DIR}/
+          cp /opt/grub/grub_x86.efi \${UBOOT_TRAVIS_BUILD_DIR}/
+          cp /opt/grub/grub_x64.efi \${UBOOT_TRAVIS_BUILD_DIR}/
           cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_riscv64.efi
           cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm64.efi
           cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR}/grub_arm.efi
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2164ad79a72b..23bbe2c24b8d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -34,8 +34,6 @@ stages:
     - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
-    - grub-mkimage --prefix="" -o ~/grub_x86.efi -O i386-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
-    - grub-mkimage --prefix="" -o ~/grub_x64.efi -O x86_64-efi normal  echo lsefimmap lsefi lsefisystab efinet tftp minicmd
     - if [[ "${TEST_PY_BD}" == "qemu-riscv32_spl" ]]; then
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/ilp32/generic/firmware/fw_dynamic.bin;
@@ -62,8 +60,8 @@ stages:
       fi
     - tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
         --board ${TEST_PY_BD} ${OVERRIDE}
-    - cp ~/grub_x86.efi $UBOOT_TRAVIS_BUILD_DIR/
-    - cp ~/grub_x64.efi $UBOOT_TRAVIS_BUILD_DIR/
+    - cp /opt/grub/grub_x86.efi $UBOOT_TRAVIS_BUILD_DIR/
+    - cp /opt/grub/grub_x64.efi $UBOOT_TRAVIS_BUILD_DIR/
     - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_riscv64.efi
     - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm64.efi
     - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_arm.efi
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 11beaedf9b30..90c90bd05f0b 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -60,8 +60,6 @@ RUN apt-get update && apt-get install -y \
 	gnu-efi \
 	gnutls-dev \
 	graphviz \
-	grub-efi-amd64-bin \
-	grub-efi-ia32-bin \
 	help2man \
 	iasl \
 	imagemagick \
@@ -175,6 +173,28 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	lsefisystab loadenv lvm minicmd normal part_msdos part_gpt reboot \
 	search search_fs_file search_fs_uuid search_label serial sleep test \
 	true && \
+	make clean && \
+	./configure --target=i386 --with-platform=efi \
+	CC=gcc \
+	TARGET_CC=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-strip \
+	TARGET_NM=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-nm \
+	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-ranlib && \
+	make -j$(nproc) && \
+	./grub-mkimage -O i386-efi -o /opt/grub/grub_x86.efi --prefix= -d \
+	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd && \
+	make clean && \
+	./configure --target=x86_64 --with-platform=efi \
+	CC=gcc \
+	TARGET_CC=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-strip \
+	TARGET_NM=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-nm \
+	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-ranlib && \
+	make -j$(nproc) && \
+	./grub-mkimage -O x86_64-efi -o /opt/grub/grub_x64.efi --prefix= -d \
+	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd && \
 	rm -rf /tmp/grub
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
-- 
2.43.0

