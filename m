Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8092D2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0866A89229;
	Tue,  5 Nov 2024 17:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FAkGkT/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2C98920C; Tue,  5 Nov 2024 17:08:05 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9853789204
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a3b4663e40so19268145ab.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822880; x=1731427680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjZ6cQPmMEZJKMHvvuvAJX3UCCnjOXWIF0uLFIEhf+4=;
 b=FAkGkT/TPIICiOx85GLPs+sQZOVEfZ8QHTlucgrxDe47NrMHzHxxLBNaPDTosy99AT
 bA9JZTFiy14j39j/ww2tObyMaXqHglW6iiXQCI1VPwZT7T4S2NIHNkv6DzS22RpnHRoY
 1MGHZAUWDkFZDJPHWzeChlIsxWEta+LGkw8C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822880; x=1731427680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjZ6cQPmMEZJKMHvvuvAJX3UCCnjOXWIF0uLFIEhf+4=;
 b=eW0MO4tbT3uoHd+XJtla21hX/+gkOi4g2I7LfQqCJRoFrv4r5NBevXz8sZVbkh0JJN
 DSTl6Db1cJDJ16GigpeMMaWPX5lWPMZQq+9CR+Pd9X1VzSzd2khzM9Dn8W0TqnxALEPa
 8PhUxFlXasjyxXcON1w1HNwK1a7WcP+bX8ipg5LOwHoZmy6x0NNdM+CnynqYP3wFuqcx
 xbw+dPEFkCwZhgMUTiHdqzL3ds07z2ZhkYOiIpo1zAg5YkUDGF3RZxgxd5hXO+HKHExT
 NfQZ6MaqXEEwX9M4sQK7wI2/5WOMt8gNd8r1ihnyX/5jSXZmHfovm3uhxx8Q2Ob9Y2Ct
 DGeQ==
X-Gm-Message-State: AOJu0YzjqQraSCL11E0qP5lstalvB4cVLcgBLxpZBnn5uTM+gdutygvZ
 mZr808l2k4qHOMxYzjxaN1hokgxuSZFpht6A7SAgR4kBEqhP3KXA4qL2hYqEI4uJhEoV58NWyyg
 =
X-Google-Smtp-Source: AGHT+IGqc6o2bl/VQ0BA0OZoiMZ9mdwwUhLuBddXZgOR+vxSNQh/OkrU+ERApjY2ZEIqjWPOKqJtBA==
X-Received: by 2002:a05:6e02:1a8c:b0:39d:2939:3076 with SMTP id
 e9e14a558f8ab-3a6b0394ec1mr147026875ab.25.1730822879566; 
 Tue, 05 Nov 2024 08:07:59 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:07:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/9] docker: Drop tracing for arm64
Date: Tue,  5 Nov 2024 09:07:35 -0700
Message-Id: <20241105160738.3795497-7-sjg@chromium.org>
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

This doesn't build on arm64 at present, so drop it for now. This can be
revisited if we wish to support arm64 for the sandbox trace-test.

The error is:
   /usr/bin/ld: /usr/local/lib64/libtracefs.so: undefined reference to
      `trace_seq_vprintf'

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/docker/Dockerfile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 458deb7c1ad..43b789a0c3e 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -245,7 +245,8 @@ RUN git clone https://github.com/stefanberger/swtpm /tmp/swtpm && \
 	rm -rf /tmp/swtpm
 
 # Build trace-cmd
-RUN mkdir /tmp/trace && \
+RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then  \
+    mkdir /tmp/trace && \
     git clone https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git /tmp/trace/libtraceevent && \
     cd /tmp/trace/libtraceevent && \
     make -j$(nproc) && \
@@ -258,7 +259,8 @@ RUN mkdir /tmp/trace && \
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

