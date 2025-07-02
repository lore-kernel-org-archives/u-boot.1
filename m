Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09080C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D66883010;
	Wed,  2 Jul 2025 03:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bPe5zPzD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D51A82103; Wed,  2 Jul 2025 03:04:31 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 110F18300B
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-60f0a92391bso1849677eaf.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418268; x=1752023068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2owAor9+uKktLMsED7dJhU2wkfFAszfqSjHYE/TGWoQ=;
 b=bPe5zPzDIprUwNnodY2g1w+YrOFmLfyJK91jID71BMZsDBE31AE8KeqUGxJXBhc2AO
 gmR3wbVF5XuFGw5G2wwnR6SmEl4p7tKjqVm8Z72V8o/zVt0yQcwmrtaYF/xHuUzJQ7UO
 S9lzBYBO9Zpdt2bVd87dTUr9TxUk3Hy9nPvFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418268; x=1752023068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2owAor9+uKktLMsED7dJhU2wkfFAszfqSjHYE/TGWoQ=;
 b=r5DX1QX4wzVvkmdqHGuBl0f4+9WWXB9tzmsenalSB+2asGb0/sIOfxni9p/ZC5EPJi
 QSzpAUmqPVT6V2tn7GCUbwaOxfXGn3lWgV3oqic1f2GwvleOIDbYChfwVW3vs5Sj8eBD
 o68NMe7/k4KbEDEsJFNoi7WKhbjDxxQeJLmhY263I597e3IC++LFROVQ6fQa3e4BJzLM
 Hd2a1JHoSeeU/tFxVYJyrOqfB3P14M64eJKs+bunm+mllLwmWnJy/sB2ov9+xPkEmxAI
 6qaKnv/0TES7eYCHE0jUyN35RNCGAqki8nc57m+7xl1mxh0BOz6F5wPNc2bdVk5Kk68i
 n/zA==
X-Gm-Message-State: AOJu0YwM7mV4jCgnuVIeFsCQNSNwVfuAGGNuocPE0yxmeFv28Co88S6x
 nc/0hGNbhqfraBHWzHQPM+JBB/VdorfhoTZIZmnpwp394a1/oO3iCBjPN4sDH8FDdOLlVQ2kCbr
 r+84lHcg=
X-Gm-Gg: ASbGncuHhmW8sNfG3/oGYvHRCZvk97lTvKFv8bTV8I90AW6Im5dWA16mparuJjaPmY7
 niWO4A/coOlQIQLoCZ9SmOPqEYdLqEYheCdTFdZdhehrKYTqyDnUPKRbZJpy4N5oeznfAspRL3o
 4CAr4O+Ift9pBestkvNmbgGdSlpQwX9+SDPdJqGMS7A95aw1Ugi9H2Tmsl1we4YQU3bU7RoQRJ2
 01CLs5rZ6W8eZx3caGO5g47keWcFyDznSQzHiw7RdXiaQneQX9IPvilfdLcloieHEspSRyG0SUX
 S1UYrSmK/iOwHLIFaOQzXSifhkMXNcDJ/ZCaQRF441bzwcJ2zXOsVIVXaWFaviYvwMS1JsP/ODD
 H68noJaIV3tGQqTZ0p7dssnE=
X-Google-Smtp-Source: AGHT+IE9KbCA+VarWD4YO1eFM6ucDrkty5Ak04uyD7oxfZv++OaWiprclIHXEnbHPS1VE0sK/UC/sg==
X-Received: by 2002:a05:6820:210a:b0:611:b1b0:2adf with SMTP id
 006d021491bc7-612011e6a36mr568093eaf.1.1751418267795; 
 Tue, 01 Jul 2025 18:04:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b859fb13sm1563188eaf.29.2025.07.01.18.04.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cache: Update dependency for ANDES_L2_CACHE
Date: Tue,  1 Jul 2025 19:04:26 -0600
Message-ID: <20250702010426.18937-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The cache driver here can only build on RISCV due to header
dependencies. Express that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/cache/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 4f3586574445..f5bcd406a505 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -24,6 +24,7 @@ config L2X0_CACHE
 
 config ANDES_L2_CACHE
 	bool "Andes L2 cache driver"
+	depends on RISCV
 	select CACHE
 	help
 	  Support Andes L2 cache controller in AE350 platform.
-- 
2.43.0

