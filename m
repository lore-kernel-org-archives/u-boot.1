Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAD4CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1E4892F0;
	Wed, 23 Oct 2024 15:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLGLCKOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4D588DEF; Wed, 23 Oct 2024 15:10:39 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89708891E9
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so67089225e9.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729689023; x=1730293823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYZSl3q+MXzKcQUjOgIryvlFhPuPXXvb4CLqPwRmKBk=;
 b=cLGLCKOzNq8q+I6Dk2dDqqCSHd+rR0QXfPYR2h8ozCWeeSRGt8QbzrlrizYqGGtC0v
 pMmoqesKtsp3bkD5X3GEqn/ui1ceXuMX5b7p3/DP1C0t0AI5gOjYZegnD6X8V8CJD0gW
 tL50EK2Z23gnfNN94a9qg04tHWIeFNkzibO4n0AW1ofuBw0x/TMMou4ntAlhtzFJlHxi
 mIlkirYZMMrFf7Uq0Nkkrq/urTkug3xWGohQGzxJO+M1piRtMo61cL4TV1g9HUJJ961t
 fXQEHkuNjrWgB2DcENpNPSLg0cgIDrmB7Fx3ayroq6hkD0rVOGSum86wCYplpATkhRYn
 MbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729689023; x=1730293823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYZSl3q+MXzKcQUjOgIryvlFhPuPXXvb4CLqPwRmKBk=;
 b=gyv4YLEXE+IZTlkr2Z5TEGesjeTwlWyXEfqnA5Lpig4rrMKaHvXrVYGfavds8FizXy
 4Ch8mdw3Slj4IQqPL6mqh6LQItuxE8aHj1xN72St0WpXZ4DV3Wzz1/Qdc6+xVMp90cFa
 UiMLrUQPPTGh561JfKPUx2P5yjui2ZQ8RYzCXyGwQ9ScoscmDrSTxfi4IThaayIEpMyl
 DFVJdvsvy2mvpmA/uHkUsHoozW0y0LH1XA5qyOjA2aTax9R65O+q+U+2NN0l5DB2+dYL
 c0nAnoYubd3nVM1osmTSdsAycDumnkBiqYd+t7bIlR9wvxCvldfQIF8hxS5XAX/k5oMd
 A4uw==
X-Gm-Message-State: AOJu0YySsewAYCbVkFMWACVTVZ06JGthckvVp7MeM5cIp99JopzIhnDD
 jo2x1ETwf83FA2SSv09uHpZpOOkdlPeuWVSlJVV/WRWsbt+3id3rJ6h1dtny
X-Google-Smtp-Source: AGHT+IEenMqvdfuLTB5HPSJO4EuAEA6+3/reLe9otly6OdXSiOqoJL5004XuzutKCqFhAQEtKdkUUA==
X-Received: by 2002:a05:600c:1c0f:b0:431:3b53:105e with SMTP id
 5b1f17b1804b1-431841fda82mr21676035e9.9.1729689022572; 
 Wed, 23 Oct 2024 06:10:22 -0700 (PDT)
Received: from NLOOP11.neuroloop.local ([213.164.76.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a47b74sm8842742f8f.27.2024.10.23.06.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:10:22 -0700 (PDT)
From: Martin Stolpe <martinstolpe@gmail.com>
X-Google-Original-From: Martin Stolpe <martin.stolpe@gmail.com>
To: u-boot@lists.denx.de
Cc: Martin Stolpe <martin.stolpe@gmail.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/1] rpi: Only add frame buffer node if CONFIG_FDT_SIMPLEFB
 is set
Date: Wed, 23 Oct 2024 15:09:20 +0200
Message-ID: <20241023131012.2445564-2-martin.stolpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023131012.2445564-1-martin.stolpe@gmail.com>
References: <20241023131012.2445564-1-martin.stolpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Oct 2024 15:15:20 +0200
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

The functions fdt_simplefb_add_node and fdt_simplefb_enable_and_mem_rsv
are only available if CONFIG_FDT_SIMPLEFB is enabled.

Signed-off-by: Martin Stolpe <martin.stolpe@gmail.com>
---

 board/raspberrypi/rpi/rpi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index ab5ea85cf9..47db441696 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -569,11 +569,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
 
-	node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
-	if (node < 0)
-		fdt_simplefb_add_node(blob);
-	else
-		fdt_simplefb_enable_and_mem_rsv(blob);
+	if (CONFIG_IS_ENABLED(FDT_SIMPLEFB)) {
+		node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
+		if (node < 0)
+			fdt_simplefb_add_node(blob);
+		else
+			fdt_simplefb_enable_and_mem_rsv(blob);
+	}
 
 #ifdef CONFIG_EFI_LOADER
 	/* Reserve the spin table */
-- 
2.43.0

