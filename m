Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA17C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 14:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0C787D66;
	Tue, 13 Feb 2024 15:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q19uicW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 319C787BF0; Tue, 13 Feb 2024 15:39:34 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABA387BF0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 15:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6078ad593easo5200747b3.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 06:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707835170; x=1708439970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OiuhspkEMgt2C37SAOGVz6QWR2xNeGJ+cnX1VNbGguE=;
 b=q19uicW8Zbg5DKnd/+lT2Q8yfxUV6lE+DqN71cLj/nClM2u9hRux33dTpnRAGnb4wA
 gubbx5sMNpH9AR2xoTFpXGygckdhc87vqRb0Us3cMXH8VVL/ClTBF+U7CLJLSDfnRrDc
 1m/0sKfRd9/cai1cROMHVrLPDYo5PAtWljL70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707835170; x=1708439970;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OiuhspkEMgt2C37SAOGVz6QWR2xNeGJ+cnX1VNbGguE=;
 b=ooodhTp89yLrG5TpMF8XQkcLwT4/kdjAuwlrN6P2F7afwU72LCoMRxbn+ndmzfm7RJ
 4Pyqgj9IajprZz3gxy846+KlxOqLCGKmSjPoWIlhsdkC8MrXzGhgm2mA52TG5SqvEu4e
 bVFuW7qqrXR+1b1GFWsiYWaZymXp2Vq1svnPMf0KM7PocHyp2U9wodYLHPdJ8nppvBhq
 Lat0BfNQzQ5VPF28daK6sh/Wkxg8VyVbekMNLVI9ZBgUjEi5VWTxUF05hdtZhCEwFQZq
 AjhFCiHT+FMQHUVdK5kWOucJZ0aFfsgahQrqm3rXuCxMqmeUR7Gry5Vnm/uiI9l8041r
 H2ww==
X-Gm-Message-State: AOJu0Ywsb6PUw30EzrkdMywdDf07iYFU2reKdHQyvXK6CbCrM6JELQo5
 XxJr7CMVI9p75XPKPi+0Dc7UfzkA68SYsCd+47iheyEjvmOOWAM421rdrDiXE2kq2UgyWZDPcBO
 l
X-Google-Smtp-Source: AGHT+IH625x3sqOrGUxLaKz5llRCBKJoAPAMLsij6soa2yxf0cZpKFjRrpLpMH9Jv5xdyahynv+rDQ==
X-Received: by 2002:a0d:cb53:0:b0:607:8344:24f7 with SMTP id
 n80-20020a0dcb53000000b00607834424f7mr1939726ywd.22.1707835170020; 
 Tue, 13 Feb 2024 06:39:30 -0800 (PST)
Received: from bill-the-cat.. (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d21-20020a814f15000000b00604997f9e77sm1765928ywb.5.2024.02.13.06.39.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 06:39:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/3] Dockerfile: Build coreboot from source
Date: Tue, 13 Feb 2024 09:39:26 -0500
Message-Id: <20240213143928.91443-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

To make CI runs rely less on external servers, build a coreboot release
from source and populate /opt/coreboot with the output.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 6122776bc64d..3d044657406e 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -231,6 +231,17 @@ RUN mkdir /tmp/trace && \
     sudo make install && \
     rm -rf /tmp/trace
 
+# Build coreboot
+RUN wget -O - https://coreboot.org/releases/coreboot-4.22.01.tar.xz | tar -C /tmp -xJ && \
+    cd /tmp/coreboot-4.22.01 && \
+    make crossgcc-i386 CPUS=$(nproc) && \
+    make -C payloads/coreinfo olddefconfig && \
+    make -C payloads/coreinfo && \
+    make olddefconfig && \
+    make -j $(nproc) && \
+    sudo mkdir /opt/coreboot && \
+    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/
+
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
 RUN useradd -m -U uboot
-- 
2.34.1

