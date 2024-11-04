Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E088D132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA82788D3A;
	Mon,  4 Nov 2024 14:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FUsJnNdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7B488D90; Mon,  4 Nov 2024 14:40:17 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BFC88F73
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-83ac4dacaf9so153737039f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727611; x=1731332411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWSD+RoTUL/HykCvtgZb3MFN/1WZRzfooJ8T7wEIJB0=;
 b=FUsJnNduKHPzM01AYq+dOdnWsFi6x+TZ0pnCrAZEzBPWAg+q/FzjeUnp7QslLz2NDn
 urZB0tn5INFDat+Di56AqqwhttrSY+8caiQr1Bn4uzRo7C7LX8/N8uxoORDynkKfHRGT
 +96cUV2tn8yz/i717ZYex4OUeTte18wTqlRtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727611; x=1731332411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWSD+RoTUL/HykCvtgZb3MFN/1WZRzfooJ8T7wEIJB0=;
 b=E3kQonkwBtLosy8sfTj5C/KG9IdPNQW2N2xu1YKFMPCXw+S0ktDv2DXO8RFaiTn9af
 +cW9eJiHoyf8RGl4Qx4VjfJy00hY+YMkp/3pmEZ3R6TSDfnVtSfAyUEf9mdiZVdeCPiz
 c01OBqHV9Zt3DJL8ET99xxIYM/xPJxFHydRxYroyGEky+eHyyJpjSCUG+mzUBJ0zRI79
 ePTXL6oC1DLkzrJ23aD/8XU5vTnFstaMC3ijAk8XASJN3Ee/C3iRJFTw+YwyxxGo9vf+
 flnB89ZoTMIqJzGjrYk7783I87Hyox0eBsVgnidcvT5rGNn4px+zO+R5K5O3MoP3l0XR
 04bA==
X-Gm-Message-State: AOJu0YwSW4br/k9ctJKzV0RfiJeHduhHOgNqX0DVMAD29uXy29mC0g11
 j4G6VxdmcH7TiTP9Ku4Ll9jtMXuAMHVu0eCXAXjk2KrBe6rAdjEZij0pIsZlw5/DymI/bjbwYCE
 =
X-Google-Smtp-Source: AGHT+IEngkSrwN0osp4p0w48/svXL2RZRoD9i1q4Q3BC57g2Vk7fQaMb4qQOpQmauE4VnhnSSvp4gw==
X-Received: by 2002:a05:6602:1695:b0:83b:2167:650f with SMTP id
 ca18e2360f4ac-83b6503964emr1951112139f.10.1730727611577; 
 Mon, 04 Nov 2024 05:40:11 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 6/9] docker: Drop tracing for arm64
Date: Mon,  4 Nov 2024 06:39:50 -0700
Message-Id: <20241104133954.840994-7-sjg@chromium.org>
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

This doesn't build on arm64 at present, so drop it for now. This can be
revisited if we wish to support arm64 for the sandbox trace-test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/docker/Dockerfile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 60106a82801..73fdd1a4302 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -240,7 +240,8 @@ RUN git clone https://github.com/stefanberger/swtpm /tmp/swtpm && \
 	rm -rf /tmp/swtpm
 
 # Build trace-cmd
-RUN mkdir /tmp/trace && \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then  \
+    mkdir /tmp/trace && \
     git clone https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git /tmp/trace/libtraceevent && \
     cd /tmp/trace/libtraceevent && \
     make -j$(nproc) && \
@@ -253,7 +254,8 @@ RUN mkdir /tmp/trace && \
     cd /tmp/trace/trace-cmd && \
     make -j$(nproc) && \
     sudo make install && \
-    rm -rf /tmp/trace
+    rm -rf /tmp/trace; \
+    fi
 
 # Build coreboot
 RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp -xJ && \
-- 
2.34.1

