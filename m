Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B452D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71688943F;
	Tue, 12 Nov 2024 15:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iTKTLg3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C36689454; Tue, 12 Nov 2024 15:11:25 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C3789461
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83a9ca86049so208099539f.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420680; x=1732025480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ChhiT483sm+1hUiQKs5kyrQgB2IgonH+9xeRHPWdG0=;
 b=iTKTLg3BH29eWUVoaIhWjnDaBGS8vBmlwJS7JJJg7vHyuwsFyMsTnIO9YNIt5e0A9A
 haGB5/ObwtNYMxhWkU8pqGt+4p6LEwABBIbmm8UjTlviRm8VxQmrlzxIlZfx1PU8nsKJ
 tqHbs3ZmyxV9eaMZ/PsPQSQd0f7kFizpBgoc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420680; x=1732025480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ChhiT483sm+1hUiQKs5kyrQgB2IgonH+9xeRHPWdG0=;
 b=uqklZLfCzMMUBuPSBDlbWXuoMvLQpVIRe4d3DdJ6X4/LFsuxYZ39NeomaG/qT75AuF
 cxUSbWWm3p4yoOgyXntuihL4oLspW8aeMSo6Ti4wZBml8Iij+PrhHigA7ZIQL03WVNs2
 ZOZxj2NeZslIF9SuGEDoZ1AeQAVzL9bCdHLwu5N4ASd8J+IdabFnKSLEGBj6vVuipfrS
 bfe7VIINyyv02GHJZ5ly3KcGh0iS248Dewe+T6GOzM77hglXPrVcCT+upAGvJxgIvZta
 wDUZj8D0BpBbLrK8U9OmubUjf2GroSr4ohlzMQZ3MGgq6KMBESw+ukZsZNvcgx4eCxXS
 DhBQ==
X-Gm-Message-State: AOJu0YzH++UTheXfP7mgviQWtuHGEXTqh1rr59VLh2MfcTobgCSjF/pq
 FxVRBp0wfPwyVMrrnduqAhB+S6CCbQtR6CdhM/Od6JxwfPl/jWfcYXVHMbkKh6rgRjLevKGT3mE
 =
X-Google-Smtp-Source: AGHT+IFYt+WbBW9G7OmGbozqT+syCuYcjPCTYL/+O/sUSJJsfznNRXVZ0JnUGFWBVOMIuYTnx366WA==
X-Received: by 2002:a05:6602:2d91:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-83e0329dc3dmr1907097439f.5.1731420679796; 
 Tue, 12 Nov 2024 06:11:19 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 5/9] docker: Drop coreboot for arm64
Date: Tue, 12 Nov 2024 07:11:01 -0700
Message-Id: <20241112141105.640189-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141105.640189-1-sjg@chromium.org>
References: <20241112141105.640189-1-sjg@chromium.org>
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
index fd4835e9562..048a57c5b16 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -258,7 +258,8 @@ RUN mkdir /tmp/trace && \
     rm -rf /tmp/trace
 
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

