Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5458CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 597AC88DDC;
	Thu, 26 Sep 2024 22:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bT/yvSGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0679488DEF; Thu, 26 Sep 2024 22:49:09 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB81088E11
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so8052636d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383744; x=1727988544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBWXwLWTJnDHHd1m2gjYK3aAe9zloBQRFAHkbfTlaaQ=;
 b=bT/yvSGmuzIlOeacNLSmsE329/6vUqeW5C0/UrBqx1qykSJyos2SIwdm8zA9x2FrHN
 lWT0HLp3mdhG8JEdmhlOI5aAufYiQ78FBDRXqWN7xFJx5KCBm2hh/mK+UXg3TfspSMZD
 56x8PmLF2ev5KeiwtiYLFZPYFmeG9fTNfg6c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383744; x=1727988544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBWXwLWTJnDHHd1m2gjYK3aAe9zloBQRFAHkbfTlaaQ=;
 b=kUA8GGR5MlNbQUAu4CX0PDp16fZV8C6bH3pR5fkpTIPo31kBAiO64KlyF4RDzW8onb
 nr+2UIVIJRqCAjwCSgVqbQ3JBpqg8B0CjGLNoN2LBsPv5BEoMGoV6cGsStKNV0ASd/RP
 M4NeEdjQr32PuiUztdVeZufVSnZWR0ymsPo1T5Qyd3FEv7tITeORv4f9uq65p5zG5Oke
 UMVlQWs7wCPOHldj++unCKpKC1NJ5+pUzp/Ry8+a8VO6jhrUNQTP5Dx9l2NYLw8om4F0
 q/mjTue1rpkrGkTQBupzE/HW+n2Ur1fRpMVUyiFPFKDCwdsAsOln1mk/I5IuoIV9bxeT
 M8vA==
X-Gm-Message-State: AOJu0YyAtjXXOYrSpKFR8I3oESvaatwQP/GVy4YstHH+XBUCTOjOUBih
 1E9nMj8GlgC90ltjVtFe0R5EjR2cTl7vmavoFjjuzaDLjrsebym6Xg5uPrgJv9WrVXJiY8iLXeS
 5O9uJGRU=
X-Google-Smtp-Source: AGHT+IE6NYOKBFZ+7s8IoHPGFSCbQbU5TEwqdBO72o9XfLbgc5A+CM+zf3eXE2KdjMsqBWoS9LikNw==
X-Received: by 2002:a05:6214:3a88:b0:6c5:39dc:52bb with SMTP id
 6a1803df08f44-6cb3b5b905emr11788846d6.8.1727383744581; 
 Thu, 26 Sep 2024 13:49:04 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:49:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH 08/27] pinephone: Drop STATUS_LED
Date: Thu, 26 Sep 2024 22:44:28 +0200
Message-ID: <20240926204455.963584-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This feature is very old and does not use the LED framework. Drop it
from this board.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/pinephone_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index 9d39204a439..1956eca8815 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -11,8 +11,3 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=114
-CONFIG_LED_STATUS_STATE=2
-- 
2.43.0

