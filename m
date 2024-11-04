Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0774CD132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A286B88F0C;
	Mon,  4 Nov 2024 14:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BvmlzdWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B2888C75; Mon,  4 Nov 2024 14:40:11 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851F288D14
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83ab21c269eso160052639f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727606; x=1731332406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVnNDZZtn7r/7hQkDrYKCS/sEwK8Lyq8RbCiYAlTEUc=;
 b=BvmlzdWiX+Q3t84kuLj1fU0i34qWpvBIYMRTLkj1nGL0WTwLMhSjayrc8LjeZqR3Yw
 9yKIpWHD38OSvLRmZ4JN0besRes0k6EZjYfgl7q5qv+L6UCj89vQre1S0OsKcD6Y77ds
 bb6xsQqmvCd4JqdQognZWvba2Ra9eBPPiOpPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727606; x=1731332406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVnNDZZtn7r/7hQkDrYKCS/sEwK8Lyq8RbCiYAlTEUc=;
 b=CNrS+440TYiQy9bjV+++qq92IFdjfWq6GmSe9cCME7CCczqDtN+G45AXhGZuG7iSVf
 /QATlOOjrUYtaR11jzKVtl6iWqmFeHUFvs3v2SM4VjW91O/rKFMhLpVEB1xHjErXvZcD
 KJFQzJA56CzQBlPL+Xp4+nI/tWjJXYScplHPrRwbeA9eIzxZpnipqzbRyxBqq4/ahQ/y
 MNqO2PGQRy4fTuuZ1oAaxHE2aq6E1nbMOHi9owVKq7AGPLpMuqE86FfXliPMrxhUxBfk
 xUMga8ZzhrshFJ8vVvyDaWjuZrNrLYrTxNFV9c5aW9OXsgbqdo/VUQIBFK2WDHUoPB0w
 S+ug==
X-Gm-Message-State: AOJu0YzziMayRchG8L9aD0r0cfYbtobDYgaP61h1ZIl/MGU/ELKec1mf
 OP0T4wvthpC2cidWjj2M3L+iUw9xhCHAGt7Q5MANa2Fm76kmiZ/r+1dXCX58FBu/TBLB541M+yU
 =
X-Google-Smtp-Source: AGHT+IHfWrjnp2tbp6xH+zk5Drz82qHTW4ROAhbewqejv5pzGqKh3AJtrCfBMBV2ZGC3def3G2CYtQ==
X-Received: by 2002:a05:6602:1509:b0:83a:b645:c902 with SMTP id
 ca18e2360f4ac-83b7194b784mr1388421239f.6.1730727606337; 
 Mon, 04 Nov 2024 05:40:06 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/9] docker: Support building for multiple architectures
Date: Mon,  4 Nov 2024 06:39:47 -0700
Message-Id: <20241104133954.840994-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104133954.840994-1-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
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

Add instructions on how to build the file for multiple architectures.
Add a message indicating what is happening.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/docker/Dockerfile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 967ac89fbde..c9d794082c8 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,6 +2,9 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
+# Build with (for example):
+# docker buildx build --platform linux/arm64/v8,linux/amd64 --tag sjg20/u-boot-gitlab-ci-runner-multiarch:jammy-20240808-03Nov2024 .
+
 FROM ubuntu:jammy-20240808
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
@@ -9,6 +12,10 @@ LABEL org.opencontainers.image.description=" This image is for building U-Boot i
 # Make sure apt is happy
 ENV DEBIAN_FRONTEND=noninteractive
 
+ARG TARGETPLATFORM
+ARG BUILDPLATFORM
+RUN echo "Building $BUILDPLATFORM, for target $TARGETPLATFORM"
+
 # Add LLVM repository
 RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib/apt/lists/*
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
-- 
2.34.1

