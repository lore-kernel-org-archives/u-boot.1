Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901A6C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067D18425A;
	Wed,  6 Aug 2025 16:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t8ntAKnQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB3083A62; Wed,  6 Aug 2025 16:56:16 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2424083AAF
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-619a8bfef4dso2016871eaf.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492170; x=1755096970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNbhxCzi1MkaIc2zt6W4LIdFmsE18Kj+n70CqQD1oBQ=;
 b=t8ntAKnQsMSJNYnVLKZoMunbtBeW+II7c6uQdUtasxSSaKNwt1qohqCHTJ9+Ho5ojO
 HkgtojXw7GO8TkkcKcXX0myVpA6KmKKCwrz45i1Ys3t/LlIyuLPu1OIhnfU+kSWg3+Yy
 vYhHAoi2H40GOIYcpv11XAMqdCbUk1a6GOjqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492170; x=1755096970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNbhxCzi1MkaIc2zt6W4LIdFmsE18Kj+n70CqQD1oBQ=;
 b=ZoDsYc3MMDeeGEmJWHBnxGxS4hOfgnDvPllGYL1/ROiqxvM6NmEMD3ZySb5DjaHmO5
 xGsedCH1XVFj2M1bNTs3gfhmpuexpbg6ZwTRp9i11CqzuMB+3xg8VFq2LkIJUd6r8HAj
 9XIJ+rmbxazRgE9Ku6IxeffuRMBEtqHLIX9kRuszk/7PCbJ6JGOh60lOIiCLo+8yl8Oe
 dxk6ATpRmv0j67g76wob2H/YAc8yt/v5aFem1rW0QTNxSXxB3vJUL4PFAyfzm6NSMQ5+
 5wB5k81ZB9WqYDq+gmHLe5CCngjdZ56EiUo+dSAilU4NPFV+BXRrGai0/4GAF0iMQQKb
 0lPg==
X-Gm-Message-State: AOJu0Yyv/X/gxLj87rrGvM8iHxtxztMiMY21cMRpQKXUPC81lr0g4QdS
 1iK628gRFoQDvvSYMal4k2TVIBvUDYCxKUOi6/YNreWFKTKxAWfxZ6soXGAO0+TmfTAed/C5LvA
 IUgKDUOg=
X-Gm-Gg: ASbGncvkacVVVTL9AlaJnQ/K56DqhBvUoGj3l50zU7TXrHt9WvW9fcDLr2yQH58LNTx
 igR00Kib0RTr9D/TDqGGcJJi5CK6kI0dsZudvTjew6r4PrHzHBr6bqPBggpnC5eH2xsMZz+7AHo
 unyJeSNard4mJCX6BsGBBALSCMzOvdfp6xA77mukFjPmRtYDYe5uQ1WjJ3TdSujE+xrtlzSVOJI
 uDLhFZAKZkn2QYhZtL/zeXjrqDXDjrdvhXd9PuW4jRNmykHKF7LYvpudh5S5jQtc5LFYzPD70+k
 +z4mLM+RZm+8t5XM98GWRaDxpse8hv4pcIiZGZ4owwBUlSdsiKVVAquPp4Bd7r/Yzk/jXrswS9A
 Nk7EovEMCTSZigkDpzzT6o3yTahyhSMOM9cXbp6iVUFljx4pADtJQWUf+B6MxtFbuU+G+SA==
X-Google-Smtp-Source: AGHT+IGhx1dk5c82wJX/1KCMYheHuvhtcs3gi4bun9p/734IqvnKFKxmbpACnKXdBlvcknEw+3LF+A==
X-Received: by 2002:a05:6871:5a07:b0:308:fc2b:b7d with SMTP id
 586e51a60fabf-30be607ae36mr1677946fac.46.1754492169887; 
 Wed, 06 Aug 2025 07:56:09 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30ba8228a79sm1925391fac.35.2025.08.06.07.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 6/7] usb: host: Tighten USB musb-new host glue driver
 dependencies
Date: Wed,  6 Aug 2025 08:56:00 -0600
Message-ID: <20250806145601.1664563-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145601.1664563-1-trini@konsulko.com>
References: <20250806145601.1664563-1-trini@konsulko.com>
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

A few of the USB musb-new host glue drivers cannot build without access
to some platform specific header files. Express those requirements in
Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/musb-new/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb-new/Kconfig b/drivers/usb/musb-new/Kconfig
index ad9072a53276..0e2b2b5fb857 100644
--- a/drivers/usb/musb-new/Kconfig
+++ b/drivers/usb/musb-new/Kconfig
@@ -52,9 +52,11 @@ config USB_MUSB_OMAP2PLUS
 
 config USB_MUSB_AM35X
 	bool "AM35x"
+	depends on ARCH_OMAP2PLUS
 
 config USB_MUSB_DSPS
 	bool "TI DSPS platforms"
+	depends on ARCH_OMAP2PLUS
 
 config USB_MUSB_MT85XX
 	bool "Enable Mediatek MT85XX DRC USB controller"
-- 
2.43.0

