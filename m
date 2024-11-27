Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2503ED6ACF7
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09A1896DC;
	Wed, 27 Nov 2024 18:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HVEpJDvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6961489817; Wed, 27 Nov 2024 18:23:07 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A73897FB
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46684744173so41873211cf.3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728182; x=1733332982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4R+T0mMgyvOdQArneGnVX6+07POCZUbmRKef7Hzv1E=;
 b=HVEpJDvM7iuuMa0yng5fzuSlaGnoDDsAYB7jG3TxvUq89JIqPi/Ikt+KqOraiwp9pN
 ruRbdDUndtnGXA9O07lLzZn6Wm7I777kz/zYfzZ1EWTjNJs0RFkUwIBkuTT6zqqDqilY
 hV0R60z0pLGxIqbRx+5dOqQuEqHSsAI7umoQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728182; x=1733332982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w4R+T0mMgyvOdQArneGnVX6+07POCZUbmRKef7Hzv1E=;
 b=RpAucbVwQ0S/ERHm2U0nCaozCEH1R2s1CTH7lanMCI27UVqhsjX9PAFK8sdR49CKgz
 X6eOXmboHAvDR1Cr9M2txLw8ZCGtdS3/7jqyXbN6F6BHKOwMcmKuAGfgzd1OqQizq44A
 YioonPGBphn5+9OZKGdyxcuMzdCnvvxoep2WvPIWmYr5iJAoKMjNvLY1X25aNKRWmS8F
 yiyqpjCm5EwKZVgomWpOj0nHkosp4HT0JxAhG0d9Ta3Y1Je0rvooXH1WunYplX3CLs5A
 +3Ddpzb6q3U0l6JPcRMrIK7mZkYFzZjpJhY8qFmmcrvNqUK3RuYufqAfnsMUYquoaPXH
 KfEw==
X-Gm-Message-State: AOJu0Ywm+cmorD997Gyd50wWSb2Yd2PUrjGJUbRL0qBjNkTP46KEHmBe
 7R70MkT9MLkxPWOXSq1xxv7pdDbnaKC2f60XOrwANaUQuPJ14YKve6vudI5qzgyze50ACPOqaYr
 CUxc=
X-Gm-Gg: ASbGnctixZ4PF/yRLkVqu3DqC9ELQptYZAWmuUnMe/hXQ6XvfTBW+cPDkwxG8TM6lf5
 7P9KKuuumMRMahEqY+cYQiM6csRvUTu9aEL64ZF23SHlMPLr11VX8p2N+aA4FjQGHtGpICFrdt5
 MbfNjFGC8gmSrxxEe8aeIGjQ5tDFDsEOFq/PVNGU5R9KWKvLxrRIRajU2HsM6fbZRC93P5FdGhu
 Q+QO9Ws7qb5HqDEgwMbKCJi9igc54WgIc85J8JbFIBD579FSyi35fxCHnpiHn58dvSLgoXz
X-Google-Smtp-Source: AGHT+IHFsejb5cPQUPcrFBHh7PNCo/qfcLXAx7Cp1VpGCg9pBcrFrYf+c2Fp1qxYRMG1/LbSSn0qDg==
X-Received: by 2002:a05:6214:2688:b0:6d3:6859:c070 with SMTP id
 6a1803df08f44-6d864d07225mr67268346d6.5.1732728182105; 
 Wed, 27 Nov 2024 09:23:02 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:23:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 07/12] docker: Use cache mounts for apt
Date: Wed, 27 Nov 2024 11:17:25 -0600
Message-ID: <20241127172247.1488685-8-trini@konsulko.com>
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

Instead of deleting /var/lib/apt/lists after each relevant RUN line, use
a cache mount as is the current best practices.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v6:
- New patch
---
 tools/docker/Dockerfile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 90c90bd05f0b..bc8d1ebbb1e8 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -10,7 +10,9 @@ LABEL org.opencontainers.image.description=" This image is for building U-Boot i
 ENV DEBIAN_FRONTEND=noninteractive
 
 # Add LLVM repository
-RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib/apt/lists/*
+RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
+    --mount=type=cache,target=/var/lib/apt,sharing=locked \
+    apt-get update && apt-get install -y gnupg2 wget xz-utils
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
 RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main | tee /etc/apt/sources.list.d/llvm.list
 
@@ -33,7 +35,9 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_
 RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
 
 # Update and install things from apt now
-RUN apt-get update && apt-get install -y \
+RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
+    --mount=type=cache,target=/var/lib/apt,sharing=locked \
+    apt-get update && apt-get install -y \
 	automake \
 	autopoint \
 	bc \
@@ -118,8 +122,7 @@ RUN apt-get update && apt-get install -y \
 	vboot-utils \
 	xilinx-bootgen \
 	xxd \
-	zip \
-	&& rm -rf /var/lib/apt/lists/*
+	zip
 
 # Make kernels readable for libguestfs tools to work correctly
 RUN chmod +r /boot/vmlinu*
-- 
2.43.0

