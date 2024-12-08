Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A927E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AABE8946D;
	Sun,  8 Dec 2024 20:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jbVqb/QS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4995589541; Sun,  8 Dec 2024 20:07:56 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC07894C6
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8d44e177cso36113216d6.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684872; x=1734289672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JTosqUnFCY+pSDBdm3SL/jn4jbL4Isft+guQxMhJwfw=;
 b=jbVqb/QS8iPAnG/Fh3jvergPGOLCXHmL8bvYho3uJtzuYf2asaeY69kGCtUJ7lVcrR
 ewXZexJ7CU2HV9BAZ8YRUBh+fdb3xEm7/w0ANY49ovwZSkCJYtYxYpUrBseDKe/Gx9Fz
 fMFdE1VaL9gRXD2PLq8BIMOAFduJ6Jgw9/j/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684872; x=1734289672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTosqUnFCY+pSDBdm3SL/jn4jbL4Isft+guQxMhJwfw=;
 b=Dmw/unxKe3gUirrXpuPcjWwV5ZHRFGchTXm8MtEom3fk85uoA/BsReUkch4L9MN6HI
 pAnlNsdYNPzurVIaG+w9wxmnvVmHQR0o5uvoyilR4M2cyBe9iBmJA9Pec6sbD71S2DXy
 Sr4OIgQUDkU9mDIaZtC9LilzVV81lQ281RJ5KZ1zW6+9oUUPCLALLmyOkkgnBoiBH5+q
 Awy6WjSucQQkf9D2vr14awgBYzo4V6tKE69LRykYN1gIRSsJ8TmHiuivuZ+/SbNSQwXM
 ZyU/r94hUjhr9j6Za2qo73R/55F+MWsNI+gYn4VISC/1qdekNgnv5IsmuGALFbr706R4
 xF8A==
X-Gm-Message-State: AOJu0Yx069NEm7j0mOoUl9Yhhnbf1H000iKGojEc+Ss+zM3Xnq/haMDi
 YO027YsLcdECMi7uLmRe/u6t7nx/dtf0m+f5QjCBkXOspyZvpko0A8KsjB73fy5kOwnKw8Cd99F
 TV8E=
X-Gm-Gg: ASbGncssYQgYnO63NzELBtECCsul0ntqAphwMcVIoh6GqmXtyStBgYIyiUeS/tf9s8I
 ojs+4PPkiY6Scolp82cA1KlbL2hbDCr+NSifT0LCXb8Ubjs+lSjpPGtJkk5Yjk/Knztlpu4i7e6
 G5nV1rBaG+lmK5dnmtx50ed6vR4aZM2mZ3R2wriGQURC1TOSsbZfKDYMOmK4k8KpC2JvUdxKHtu
 9fHhCKiI7xE6G+13BLMejwcctVRmIyXVJixOkWkXgl1CjFims/fcNzRpKt4395PQXse7KvDuQ==
X-Google-Smtp-Source: AGHT+IGSohW8qa6aMx9lOcZFRstKEJHPi07lvb/wknNh+BHwYbmx0tenZRVVdXtPH8qGvu+jg4P75A==
X-Received: by 2002:a05:6214:55c4:b0:6d8:f50e:8036 with SMTP id
 6a1803df08f44-6d8f50e8397mr153300386d6.20.1733684872344; 
 Sun, 08 Dec 2024 11:07:52 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:07:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/9] docker: Use ${TCVER} more widely
Date: Sun,  8 Dec 2024 11:07:25 -0600
Message-ID: <20241208190741.4192601-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
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

Remove the rest of the places where we hard-code the version of the
toolchain we're using.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 8723834e6e5c..38a9c4b9ec69 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -156,11 +156,11 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	mkdir -p /opt/grub && \
 	./configure --target=aarch64 --with-platform=efi \
 	CC=gcc \
-	TARGET_CC=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc \
-	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-objcopy \
-	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-strip \
-	TARGET_NM=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-nm \
-	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin/aarch64-linux-ranlib && \
+	TARGET_CC=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux-strip \
+	TARGET_NM=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux-nm \
+	TARGET_RANLIB=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux-ranlib && \
 	make -j$(nproc) && \
 	./grub-mkimage -O arm64-efi -o /opt/grub/grubaa64.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
@@ -170,11 +170,11 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	make clean && \
 	./configure --target=arm --with-platform=efi \
 	CC=gcc \
-	TARGET_CC=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc \
-	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy \
-	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-strip \
-	TARGET_NM=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-nm \
-	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ranlib && \
+	TARGET_CC=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-gcc \
+	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-objcopy \
+	TARGET_STRIP=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-strip \
+	TARGET_NM=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-nm \
+	TARGET_RANLIB=/opt/gcc-${TCVER}-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-ranlib && \
 	make -j$(nproc) && \
 	./grub-mkimage -O arm-efi -o /opt/grub/grubarm.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
@@ -184,11 +184,11 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	make clean && \
 	./configure --target=riscv64 --with-platform=efi \
 	CC=gcc \
-	TARGET_CC=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-gcc \
-	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-objcopy \
-	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-strip \
-	TARGET_NM=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-nm \
-	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ranlib && \
+	TARGET_CC=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-strip \
+	TARGET_NM=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-nm \
+	TARGET_RANLIB=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-ranlib && \
 	make -j$(nproc) && \
 	./grub-mkimage -O riscv64-efi -o /opt/grub/grubriscv64.efi --prefix= -d \
 	grub-core cat chain configfile echo efinet ext2 fat halt help linux \
@@ -198,22 +198,22 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	make clean && \
 	./configure --target=i386 --with-platform=efi \
 	CC=gcc \
-	TARGET_CC=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-gcc \
-	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-objcopy \
-	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-strip \
-	TARGET_NM=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-nm \
-	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-ranlib && \
+	TARGET_CC=/opt/gcc-${TCVER}-nolibc/i386-linux/bin/i386-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/i386-linux/bin/i386-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-${TCVER}-nolibc/i386-linux/bin/i386-linux-strip \
+	TARGET_NM=/opt/gcc-${TCVER}-nolibc/i386-linux/bin/i386-linux-nm \
+	TARGET_RANLIB=/opt/gcc-${TCVER}-nolibc/i386-linux/bin/i386-linux-ranlib && \
 	make -j$(nproc) && \
 	./grub-mkimage -O i386-efi -o /opt/grub/grub_x86.efi --prefix= -d \
 	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd && \
 	make clean && \
 	./configure --target=x86_64 --with-platform=efi \
 	CC=gcc \
-	TARGET_CC=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-gcc \
-	TARGET_OBJCOPY=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-objcopy \
-	TARGET_STRIP=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-strip \
-	TARGET_NM=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-nm \
-	TARGET_RANLIB=/opt/gcc-13.2.0-nolibc/x86_64-linux/bin/x86_64-linux-ranlib && \
+	TARGET_CC=/opt/gcc-${TCVER}-nolibc/x86_64-linux/bin/x86_64-linux-gcc \
+	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/x86_64-linux/bin/x86_64-linux-objcopy \
+	TARGET_STRIP=/opt/gcc-${TCVER}-nolibc/x86_64-linux/bin/x86_64-linux-strip \
+	TARGET_NM=/opt/gcc-${TCVER}-nolibc/x86_64-linux/bin/x86_64-linux-nm \
+	TARGET_RANLIB=/opt/gcc-${TCVER}-nolibc/x86_64-linux/bin/x86_64-linux-ranlib && \
 	make -j$(nproc) && \
 	./grub-mkimage -O x86_64-efi -o /opt/grub/grub_x64.efi --prefix= -d \
 	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd && \
@@ -319,7 +319,7 @@ RUN virtualenv -p /usr/bin/python3 /tmp/venv && \
 
 # Create the buildman config file
 RUN /bin/echo -e "[toolchain]\nroot = /usr" > ~/.buildman
-RUN /bin/echo -e "kernelorg = /opt/gcc-13.2.0-nolibc/*" >> ~/.buildman
+RUN /bin/echo -e "kernelorg = /opt/gcc-${TCVER}-nolibc/*" >> ~/.buildman
 RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
         /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman; \
     fi
-- 
2.43.0

