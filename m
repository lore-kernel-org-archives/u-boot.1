Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E5DC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 00:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E52EF870B5;
	Thu,  9 Nov 2023 01:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a9jDWYHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD84870BE; Thu,  9 Nov 2023 01:12:30 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 930D287040
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 01:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-66d093265dfso1984156d6.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699488747; x=1700093547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YIEt2ZcrPz+azEdZOzueLFQz7XhgrIk69ny/em5XIhg=;
 b=a9jDWYHGx/C7A1u3bDwjCpDuJTcvjYFbwSqS1bsZhT8TBzug9DevrNts209ykytglz
 Wssttx9PyszyQfJb8x6ViCR0T8i4C7m1iPf9yRPtz/wEipOcDYX3NDGLX3vjH/DzFHBg
 hwOaHhNN/0Kx+wIDNu3GBOnVi7QRLOfk1GBqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699488747; x=1700093547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YIEt2ZcrPz+azEdZOzueLFQz7XhgrIk69ny/em5XIhg=;
 b=BQBrLNPmeetCUEjlQf5FtqGb6CnByLEb8oAbYg6NzMBOYIHvLvXGDdaN6gnp5KfIKL
 nGW4QgWnHHC4YI+dLLvzxVJW8UJw+UOnanLXF/QL3A0UUPZhhz53ZR0NNOViJjk/Th69
 imChrILhfNO2GYqUUIgSRrurDevUrlsz12nceXTcfTljwP1u0CSXqHSfbv8pNDGn+ydx
 7SE9X6uxc0rqwmkzW5IQTWNUyX4oBodYuczxpz8Zgd7JQ0XKzfi3vX84oFcCUVviXaZ1
 hDSLXAIbtX+xc8G/ySCKvc22YRcrBMX5YrJ9QodbznjXySoiESb6HNGiR9pejLbrL8yv
 zTTg==
X-Gm-Message-State: AOJu0YzAgt/jhX4L/rC3hIxEDWFRlgTmaHsGM7vH1Xx6qTI/n2naCpMg
 ANSoKG+ekH6ezw7oZzlZ+GZ2B6VnRiwtUVMYN1vskQ==
X-Google-Smtp-Source: AGHT+IHhjyQDKE0BqG9DFLMU/6hRuVkT7ykYVRzVzSdm/rvlkgpiAlmacVLeAM89hc0jg+EbaUUO3w==
X-Received: by 2002:a05:6214:e49:b0:66d:bc09:f6db with SMTP id
 o9-20020a0562140e4900b0066dbc09f6dbmr3328584qvc.34.1699488746798; 
 Wed, 08 Nov 2023 16:12:26 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a0ce591000000b0066d23395d27sm1577553qvm.123.2023.11.08.16.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 16:12:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] net: Make NET imply NETDEVICES
Date: Wed,  8 Nov 2023 19:12:25 -0500
Message-Id: <20231109001225.2357160-1-trini@konsulko.com>
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

Normally, when NET is enabled, CMD_NET will then be enabled and in turn
NETDEVICES will (likely) be enabled via imply. However, if we disable
CMDLINE in a defconfig we now no longer get CMD_NET enabling NETDEVICES
for us. This suggestion (as an imply is) really isn't about the network
commands but network itself and is a legacy of how intertwined
NET/CMD_NET were historically. Move this over to the NET entry instead
where it is a more logical fit.

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
This could also be dropping the imply from cmd/Kconfig and instead
making drivers/net/Kconfig::NETDEVICES be default y, which is what it
practically is today. This would require a more lengthy check however to
be sure there's no functional change and I'm not sure it's any better or
worse than this approach.
---
 cmd/Kconfig | 1 -
 net/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 629a90afb7b5..1b4aad5c930b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1682,7 +1682,6 @@ if NET
 menuconfig CMD_NET
 	bool "Network commands"
 	default y
-	imply NETDEVICES
 
 if CMD_NET
 
diff --git a/net/Kconfig b/net/Kconfig
index 4215889127c9..8c80b3a6c671 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -5,6 +5,7 @@
 menuconfig NET
 	bool "Networking support"
 	default y
+	imply NETDEVICES
 
 if NET
 
-- 
2.34.1

