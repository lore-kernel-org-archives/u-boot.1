Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A134EE67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 326A7892FD;
	Sun,  3 Nov 2024 01:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QmBYCJxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471F88880B; Sun,  3 Nov 2024 01:38:28 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F7A892FD
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so19598225ad.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594304; x=1731199104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fG7DQm52zMxSmpbncGSfKzGCEjPWHAYUm6UlhnnTSFo=;
 b=QmBYCJxCDGgNrIePkLCyKODlikT0f6reooFSdoCT3CK3BimJjTmad27GF2lUT9kDC4
 xbUWG4AyCeg0AR1juA3E6zorVT96B2PeTmC1LPqNTj6dhUUcNuiF3WWLQZjNGmo5PmfY
 bi8tyfZX8k7A8eJUR5Sh6f0BoKP+CZsQuzQNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594304; x=1731199104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fG7DQm52zMxSmpbncGSfKzGCEjPWHAYUm6UlhnnTSFo=;
 b=fekG4e11LalxX8KK9FVZ3MvsbBeD84Pr4VZAUmR/8gaoS95AP35xjGr74st7f+3//w
 fFT+80KR/ymdDYPr+P1czxcBHVgI3ElapTaJIG2KYWIvtzjsTQqfeY2uT5KzxDm74BJT
 6OLpQXqnIMFiHuZH0y3CPJJf+2ou4jOkVF3c+IcNLPazsjuUPirDka+Npg2eagUxHY7Q
 hJbmCF2w6iPuQh9RWL6Gnj3ng1n8OqF6GjmQjfSN8Y9iVhZOoLVXD114pWke7W0N9GXw
 5czWxTwhMbYCc/xmrNHwv/PeH8kx95/y7HnWX4JuOOyChKbZ6j+oeuiKiHu5Cc01cv61
 5M0w==
X-Gm-Message-State: AOJu0Yx0ig9Jxho1OtB1BU8tFMSBL9qD0X6O0mHGWXdFDVagyrzHOYux
 PKJDWFXHdppsfpZHYvoUMcx5EcCx1vqS4/VfXwEpqww7kMW5dadIT5cyjAdJ1+7olXNsrB+AIiR
 LSQ==
X-Google-Smtp-Source: AGHT+IHbZgg3FnMk52xAIOgq+42mLF/iYTkuq+gICrI4YTkdAfQUcfNHAreQA5NSI9Mw/ykSjf8tVQ==
X-Received: by 2002:a17:903:2cc:b0:20b:a409:329 with SMTP id
 d9443c01a7336-2111938ae9bmr113642595ad.5.1730594303922; 
 Sat, 02 Nov 2024 17:38:23 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:38:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v3 20/25] image: Drop unused status_led.h header file
Date: Sat,  2 Nov 2024 18:33:12 -0600
Message-ID: <20241103003322.626036-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/image.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index abac254e026..7bed8ba4b1f 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -15,10 +15,6 @@
 #include <malloc.h>
 #include <u-boot/crc.h>
 
-#ifdef CONFIG_SHOW_BOOT_PROGRESS
-#include <status_led.h>
-#endif
-
 #if CONFIG_IS_ENABLED(FIT) || CONFIG_IS_ENABLED(OF_LIBFDT)
 #include <linux/libfdt.h>
 #include <fdt_support.h>
-- 
2.43.0

