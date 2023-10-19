Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9038CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A635E87442;
	Thu, 19 Oct 2023 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iS59KS5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF5D87443; Thu, 19 Oct 2023 17:01:16 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC70B8729D
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7afd45199so101596047b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727671; x=1698332471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYtssAZZUagomFHU96+ovxneEAGKgf1H87+g5TJk/cU=;
 b=iS59KS5g1ZqziP6yysGXLLiFQxxBrojm4S80I1eEU4eVLjkGVZnSuSvN6bvfYQh4Y5
 g45YqX7wQ0oEAY8bx/Nuy8YGla/EBrROviozymEwc+vegdATHg04U9/G8xc8qa60y9c4
 /eRZvPqUUF2OVcihHN50Cz+HYM7M19WvbKjMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727671; x=1698332471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYtssAZZUagomFHU96+ovxneEAGKgf1H87+g5TJk/cU=;
 b=At7nT07A36Gc2L09g5qbwHTTkAylq4H2lmlZ9R2QRWfiiOHiSTOowKo2uzQ2G5zZ4o
 JAwOdCzk185J/w3sMbePMIg8OAlZPQI8BOAJX5RKBCZeoRGvRY6r4UBN3AF4OEyJGv2D
 tH69B7FLV//yMe9O4VBRU5qoUHf96wIJxgQ7ivWa7XfjB+jfv4fMppqqw4HJe/bbKq16
 +V4O1Xger82Pz5tZErID6ORg2pELTwBKQ8N05/eYWitwLC3BUv1k5vRKCkesn+/CT/cx
 +BFZnqZAmThcDwBQ1glcUhP4GubAIT8ydIuA1H+aYa2Od4S2miHctpyoD7lCHY6Ai4TI
 pQfg==
X-Gm-Message-State: AOJu0YyRTxVK+bETQkX88ZZB/+LHLorRRnSMI1/PH6WcY8O8tyJdn8Fk
 D1cPXXAGQ8W+rk8yBrR264LwSJZ3YnCbWjD83e7H1Q==
X-Google-Smtp-Source: AGHT+IFhY+DUN+PISpHI6Ahm86JBUDJxy9qGbQrpiAZ+0YkmPnz+IqcIUnOcqsuf/7VbEQexEMaBeQ==
X-Received: by 2002:a0d:cbd3:0:b0:5a7:b53f:c304 with SMTP id
 n202-20020a0dcbd3000000b005a7b53fc304mr2967876ywd.37.1697727670943; 
 Thu, 19 Oct 2023 08:01:10 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [v4 05/24] qemu: Correct CMD_QFW dependencies in Kconfig
Date: Thu, 19 Oct 2023 11:00:46 -0400
Message-Id: <20231019150105.714407-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

Rather than selecting CMD_QFW, we should make the option itself by
enabled by default on these platforms.  Then in the board-specific
Kconfig we should select the appropriate back-end as needed if the
command is enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 board/emulation/qemu-arm/Kconfig | 3 +--
 board/emulation/qemu-x86/Kconfig | 2 +-
 cmd/Kconfig                      | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index 09c95413a541..ac2d078f42a1 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -5,8 +5,7 @@ config TEXT_BASE
 
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
-	select CMD_QFW
-	select QFW_MMIO
+	select QFW_MMIO if CMD_QFW
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index 787751abba4f..01dc1d497aec 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -20,7 +20,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
 	select X86_RESET_VECTOR
 	select QEMU
-	select QFW_PIO
+	select QFW_PIO if CMD_QFW
 	select BOARD_ROMSIZE_KB_1024
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5bc0a92d57ad..5554bd14e2ef 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2239,6 +2239,8 @@ config CMD_SYSBOOT
 config CMD_QFW
 	bool "qfw"
 	select QFW
+	default y if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || \
+		TARGET_QEMU_X86 || TARGET_QEMU_X86_64
 	help
 	  This provides access to the QEMU firmware interface.  The main
 	  feature is to allow easy loading of files passed to qemu-system
-- 
2.34.1

