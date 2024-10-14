Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5DAD18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915AC892C6;
	Tue, 15 Oct 2024 00:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RsAVBKWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71EAC89237; Tue, 15 Oct 2024 00:32:34 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0857689246
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-3a3a3075af2so26076775ab.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945148; x=1729549948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHZ3mvNWi+Lu1Xb8Yw/3NgFVKeYynoJDk0hF0/2vuLo=;
 b=RsAVBKWFMyDkhRbyARXrKU68K9q8fXXz5/9Hhi4rcVxZIeja6LRVsBv9jT1k8sxrWY
 eTkGPLKzty75Ouvh9kH25kuHXPe7qreqQsFY1UzIlVK7NkecUkvjJn4tylY2PeBhUbRO
 EERlaWnz2F5UjtS/7LJV5I/JteSUMpfEwDUtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945148; x=1729549948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHZ3mvNWi+Lu1Xb8Yw/3NgFVKeYynoJDk0hF0/2vuLo=;
 b=M116YLCIdK2YHLaSoYnmmkqw0vJJOkgCqeqTfDnVohpdC7d3eFjIDHPtg0T/Kp0iHk
 4SeVsvRA3XlXXli3iMNLBmdkuvIEskQe5BK3L+Ho6PQVFYGU95MjKDS2OqpUlIlxRK+u
 dTRKnNldw5qmEwYMKntpJ5i70IH7UGz6suCfhjUerQUeb11WuPoA3xhfRc9IvYp/xMUp
 LSTu9sVDZtFbP2tITALrufky/4jlXPfbEm5SWcifwCbN4cguGBnoe9mgs4XeHIC3LL4c
 DWUXSYFrbzCSp8k3mOc3f5QmXBPlyghYTVw1MArVLdoQ9y6Jg3sgLy8hc/FqFSUbAKAn
 z+Ig==
X-Gm-Message-State: AOJu0Yzvu1cr0yUPvSRSyb5Va/09kFQWzxVWVdLYhlcpnWYQ1g4/ulSf
 KGCPXxk0GLxZFQSWpys4kG0iZylUwx9qilWPMKFWONxr7dV8ZqfIoceSjQrj1CQ0s9zuT2g6ydj
 3A1GD
X-Google-Smtp-Source: AGHT+IG7yrxgbJnxEg9O2H+ebBN4QP/Ez1tN7osRcqLtG6A52pOtE+OulBKaTX/Jmb+LfjxuaHfRqg==
X-Received: by 2002:a05:6e02:1c88:b0:3a2:aed1:1285 with SMTP id
 e9e14a558f8ab-3a3bccade28mr81019075ab.0.1728945148104; 
 Mon, 14 Oct 2024 15:32:28 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 13/20] docker: Update coreboot
Date: Mon, 14 Oct 2024 16:32:05 -0600
Message-Id: <20241014223212.2212442-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

Update to a newer version which supports settings in CMOS RAM and
linear framebuffer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Update Dockerfile instead

 tools/docker/Dockerfile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index c401170b1e1..967ac89fbde 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -244,12 +244,15 @@ RUN mkdir /tmp/trace && \
     rm -rf /tmp/trace
 
 # Build coreboot
-RUN wget -O - https://coreboot.org/releases/coreboot-4.22.01.tar.xz | tar -C /tmp -xJ && \
-    cd /tmp/coreboot-4.22.01 && \
+RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
+    cd /tmp/coreboot-24.08 && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \
     make olddefconfig && \
+    echo CONFIG_GENERIC_LINEAR_FRAMEBUFFER=y | tee -a .config && \
+    echo CONFIG_USE_OPTION_TABLE=y | tee -a .config && \
+    make olddefconfig && \
     make -j $(nproc) && \
     sudo mkdir /opt/coreboot && \
     sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/
-- 
2.34.1

