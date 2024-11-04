Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF73D132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A0A88D90;
	Mon,  4 Nov 2024 14:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jol1JWZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6138888C7C; Mon,  4 Nov 2024 14:40:18 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A5D89000
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83abe4524ccso156683039f.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727613; x=1731332413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzzcU3cApD8N/Fex954cQUsPauKGOJbCbvA/+ftAKp4=;
 b=Jol1JWZTVwt3ftcGSah/txD690PaNY5iWvd1MlS3x6HNl+zT65JdU+p3VKcYg+QNYf
 YS8/xQ5kEieOI/qrPTSajbC0AGXOAc7jKJ7RIkDV13ltK0NFrFKefVpnefBGQSOsjYBe
 PHIwhKBPr+sfP8Zirf1C7PUz91n6PfQKMpQeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727613; x=1731332413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzzcU3cApD8N/Fex954cQUsPauKGOJbCbvA/+ftAKp4=;
 b=i2R0Ypog+IyNW7wVbDuFtIPwdCBd/UNlG+grRfk5GX/plS749SMYzXlMjRTH3KQlGt
 vWN64csBnFGVC/L8hTllCzCJd8ItZz5BRnyR2t0P3MGBp7kayywseHLR9g2rtkl5kQvJ
 Ca1TCSWAd7ZB8aFTdtJjetvt0Anu+HqUHLGWuLe+RzoJN6nm9/c+hLQOOqafRXLtV1z2
 ZJBryfypjsIR7Ry7BYQAQhDzJqfmaGumCmA0eZiMKAJeTILXxEBOqAdG7qrv6i0YuwO9
 tFY7q7cMLWf6S9USfo7GwWdzQgGcV/4ti2EcS/RgsgVoQ59cMXCaRbJKFfRC/3yoXS8z
 TaOw==
X-Gm-Message-State: AOJu0YzgyGbIwL2qVFD8rjykMJsN9Kmvr6mQ8VAUBJFO6LgBobdlslXg
 F4uLK82KzxhAOh8VJBBdfDnAAb076NZ5XlFasvsBGrFPAKTagtT/2GfPzhZn2sTLfRUeHeAjVY4
 =
X-Google-Smtp-Source: AGHT+IGryWFZN0ivN2qk+dWXc6+nGhLZ6s9iFHW5/RmhFJZmFCzlLLRjt2ptoD6QB9HAIMeFJr/5Iw==
X-Received: by 2002:a05:6602:29ce:b0:82c:ed57:ebd9 with SMTP id
 ca18e2360f4ac-83b650372b4mr1900715839f.10.1730727613067; 
 Mon, 04 Nov 2024 05:40:13 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 7/9] docker: Drop coreboot for arm64
Date: Mon,  4 Nov 2024 06:39:51 -0700
Message-Id: <20241104133954.840994-8-sjg@chromium.org>
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

This isn't needed for sandbox builds and coreboot isn't much used on
arm64, nor does U-Boot have a build that supports running from coreboot
on any ARM target.

So drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/docker/Dockerfile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 73fdd1a4302..ae3d4685869 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -258,7 +258,8 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then  \
     fi
 
 # Build coreboot
-RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
+    wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-24.08 && \
     make crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
@@ -269,7 +270,8 @@ RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp
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

