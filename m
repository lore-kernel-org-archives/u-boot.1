Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999EDD2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C7989208;
	Tue,  5 Nov 2024 17:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cdjmPYnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EF988922E; Tue,  5 Nov 2024 17:08:07 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D62891E1
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a6ace3b6a5so15828335ab.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822882; x=1731427682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDv15Aaz2v8zK9iJghSX+hz9AVu1qO9MlbVbe1GPKuY=;
 b=cdjmPYnDN75odA6CvWOwniy+wvAreZz/Q2Ek4CnEOVuEQI+i7eNGK8K3EOkbW/DGMF
 fmDdffNQco+kxmiKspnPCvJv/0D+UA1RkLa0a8hM+Xsz4rsQ5KVPFIj+4yWGPWHt617l
 mOLzXh9pa6KIIIWwN4YOIBI76U5VHgr56ey8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822882; x=1731427682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDv15Aaz2v8zK9iJghSX+hz9AVu1qO9MlbVbe1GPKuY=;
 b=SYOmgVLjgw53wczPFh+08vbstS3967QHS6lWpeQG0ihGIiye79xe+h22AqKZak8Qsb
 MTobIsYV+A8i+G1Xohdi9uFajBolrSNFAgRRTDQ9ozVsN0rr2elWZI4xQPc9lghhBic1
 zIuvkCQmgdh/6XKUMnFiqtiXSwyB0XN6jpLUAM+pUdWPpaxPOBgkIMJnCYN0/pYXvCgM
 5WbGeMbjzVSFCZ0FfrXA2gN0o2oSjp7LH7ZEB2f4yYZpC2IpUpNU21PU241dY/6RH2IX
 /IoZJ/7yzzOUDwjwBRlpOFZ/ubYu/aVCmBPzkwrMeDaZEgRZNs8u38WvEhNyh8m7vHff
 eJZQ==
X-Gm-Message-State: AOJu0Yy5vOkU2UbS+12Uj5IoKxKla4Jt9WX74i+n8d6TKWA9v4wIbJ7+
 Gq6n6NNdG/a6FhNeI9jDUE5Jvhbz6AsHTZPnOWP1ys3olzadz3pmXCrcBuJjnECP5aQoFUwvpJo
 =
X-Google-Smtp-Source: AGHT+IG7wDEf8GW2Nbbzu7axobFPb1MFVNVwR46iPFMozP1ydohe/FMZVvPafWIvBZsoXBaUuWQYbQ==
X-Received: by 2002:a05:6e02:1ca3:b0:3a6:c439:6812 with SMTP id
 e9e14a558f8ab-3a6c4396b51mr96608035ab.16.1730822882377; 
 Tue, 05 Nov 2024 08:08:02 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:08:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 7/9] docker: Drop coreboot for arm64
Date: Tue,  5 Nov 2024 09:07:36 -0700
Message-Id: <20241105160738.3795497-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105160738.3795497-1-sjg@chromium.org>
References: <20241105160738.3795497-1-sjg@chromium.org>
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

This isn't needed for sandbox builds and coreboot isn't much used on
arm64, nor does U-Boot have a build that supports running from coreboot
on any ARM target.

So drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/docker/Dockerfile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 43b789a0c3e..9eda6d8d402 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -263,7 +263,8 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then  \
     fi
 
 # Build coreboot
-RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+    wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-24.08 && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
@@ -274,7 +275,8 @@ RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp
     make olddefconfig && \
     make -j $(nproc) && \
     sudo mkdir /opt/coreboot && \
-    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/
+    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/; \
+    fi
 
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
-- 
2.34.1

