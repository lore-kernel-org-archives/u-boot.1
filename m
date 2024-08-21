Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A43FC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 21:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89FD388E44;
	Wed, 21 Aug 2024 23:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qOcSCHcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF4088E58; Wed, 21 Aug 2024 23:34:36 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A134988E3F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 23:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 612863F2EA
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 21:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1724276073;
 bh=mv092WfAePXTDb4wYJd4jrIBztJhs2u88FxTx4Gd/XE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qOcSCHcM/30U3NCYlGD4iVw+RGj+K7MXfmD23TcRmd8Rtt+eLZMotNbQ1GHG/q3eE
 TCOqedKi6dhOzwhlCFCg5AXhI1Nz9DviB4NH3tl+5sCtXDw1vNxN25iNraNchn+LrE
 rX7qIJ8zhmYFe1zMYcEMucQpw1lWyRbKTEPcFrzRa21BjCgPdpH94UO29/qPbi4QNi
 06y5kE4W4yNQXxjbRrM5Z9dFS67Q3hOg5YUMVSefrhfG2cS/F+5laj4OgUhEVHit+z
 6DOi72QBknpQLEWVRkEyaVAU5dIDgsffJwxzwR3Wli6ZXzNZkaPvbmpQNW2elqJP4F
 VtunYjjVUTqaw==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a868b6d6882so14057166b.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 14:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724276073; x=1724880873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mv092WfAePXTDb4wYJd4jrIBztJhs2u88FxTx4Gd/XE=;
 b=ZKbnfYe0oSXgsT2G54fYUKZlmdPIqFzsJb/qq5FHB8p3ChcTSDfCLy527/qKMsgTjT
 UDyHQmG7SlAlqK2T/nvEvfjgGKA2hFui091+oJsfDzU4btKEhTv3g7fBjo5mHNs5qIlk
 MCjP8ztV0/eb8Yq7WGx2vUAbhKQvy9xJSrGlD/V9Tpap0ygYiXrDbrg01UCPL4d6NqeI
 N2YuXvgICIz49ACl+5AFWaCEtsceklzey3Bz4DeV4E0F1C69/oiawn5zpgDf9RK/drd4
 KZT1VlWdQ/SkAD7pcP2jzZGhnTfejaJhV3XwF+3bN41uapczAM26YgkRP1omyZa2Nsq2
 GkMg==
X-Gm-Message-State: AOJu0YwxX70sR9pnRcKYpwT7IFDeRfKNDcs6GFgB1FMcIu+ZEtDevTyU
 z+W/Sxg7OL+ih40P6jjvnQs9IwHddzhUY8zO7A+aUR8CEvwt4Mw31bWjtn5Ry+lgpiPLshxCHQt
 G6xjZI7g37skdQUOgCyMTsfwNeAbsr/NIgejKyg/QkvvVBRPMBL8bIgPNafAuweGlG3ScXB4H99
 E=
X-Received: by 2002:a17:907:c24:b0:a7a:a2e3:3739 with SMTP id
 a640c23a62f3a-a868a7b6a87mr92190766b.20.1724276072909; 
 Wed, 21 Aug 2024 14:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKaNrR5S83D/Dn8rvqwL/sre/yludR+cnP6rn3N8BOYkglw2Iej8OfP560SiFd1K6xcDWU1w==
X-Received: by 2002:a17:907:c24:b0:a7a:a2e3:3739 with SMTP id
 a640c23a62f3a-a868a7b6a87mr92187966b.20.1724276072045; 
 Wed, 21 Aug 2024 14:34:32 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-046-114-198-078.46.114.pool.telefonica.de. [46.114.198.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c04a3ca798sm61301a12.32.2024.08.21.14.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:34:31 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
 architectures
Date: Wed, 21 Aug 2024 23:33:49 +0200
Message-ID: <20240821213349.256463-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

There not only ARM64 boards but also RISC-V boards that require a bounce
buffer to read block devices.

Drop the architecture restriction.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 1179c31bb13..6ffefa9103f 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -364,7 +364,6 @@ endif
 
 config EFI_LOADER_BOUNCE_BUFFER
 	bool "EFI Applications use bounce buffers for DMA operations"
-	depends on ARM64
 	help
 	  Some hardware does not support DMA to full 64bit addresses. For this
 	  hardware we can create a bounce buffer so that payloads don't have to
-- 
2.45.2

