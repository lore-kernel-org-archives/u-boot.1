Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D20C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 12:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B9388440;
	Tue, 16 Apr 2024 14:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="p6gSMOLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60CE88403; Tue, 16 Apr 2024 14:47:18 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25BF8839A
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 14:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d895138d0eso35752301fa.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1713271634; x=1713876434;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BI+6GDgK9usHwcn0oSSEjJRwEIYdlEuEvtxHnqRHNxk=;
 b=p6gSMOLnLo3JLByxf9CCCDTkGukcU7R/thhbDCA56eBK6ggC4TZPwVXItJaNqicUYn
 Ei0odZcLsKn/gb8rBxbXwmHdSchp+YDGs0qrTycQDkGonh2Y2/HQFr9KI8b3pdSKGVTp
 eI/fNSq3QsuopDiic1UylutKbJGQ3xBxSUj61Lv9XwDhp1yghoFXtEIAJDwDhoSXJs/K
 mXueEitZe3uyBlPW2nYA0G4ovbmjfhqpAFuI0jCiThB9PmtlxmHfa3fAPxs71LYJhJF8
 kt5X9U8GGcVrPzIZTG11bqRs+4JCc4D91+9LojR8Ds92RKWAfx1SwgnfcnTmcqngejdX
 CyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713271634; x=1713876434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BI+6GDgK9usHwcn0oSSEjJRwEIYdlEuEvtxHnqRHNxk=;
 b=XgNophUJOE4ufrygQ7d30itmy2tds2DXHWr44NPlKbpPeIpLKN1Lo+DJwsom9FO6wj
 j63jncwA2X2xHWhTNsZjnMmLmQzUSLpdEol+MUxu7KvXGWRW/nML7twBHfaW/26LdZYH
 FdBNnJ3ZFuScW/HlXbqoK5p8ENnibdnxncjUZNdVMSYvcJwbmu54SHkgjnZ8/nWugTs2
 gZCe3fyJ6gXZWJUdV+eNJSpdRTDeL/lEB8Yw6Y0m0um0vNn6WRBUy16Hzqu8836rpjMQ
 UakhOsgX5+CL9kbIsII+9KVNQb3KKglR4AmsA8XPpo6zNVmUx6rVMx/OEEDfDZ+gFyx5
 ysHg==
X-Gm-Message-State: AOJu0YxYUOcauW+BddAsxT+Td9W2MpWTrt/V3Em/dPdXZaj9jLYXwZft
 A09IZG92ScWDIsxXK0z+Rqfrl9iyLHSI4goEfDDmAD3CH8O/YlBwt33TpbdnuAi9ItZcTzwJIqw
 7Fh4=
X-Google-Smtp-Source: AGHT+IE9g0swTbZoCPJVwZt6AsgVpnIZn0uwJLcT5qPMnbfXF+6zaJjLove43/sxTuBEpC89f3v9Bw==
X-Received: by 2002:a05:651c:1546:b0:2da:91f5:a624 with SMTP id
 y6-20020a05651c154600b002da91f5a624mr3680077ljp.17.1713271634217; 
 Tue, 16 Apr 2024 05:47:14 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at.
 [92.42.140.82]) by smtp.gmail.com with ESMTPSA id
 r10-20020a05600c35ca00b00415dfa709dasm19860720wmq.15.2024.04.16.05.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 05:47:14 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH] rockchip: px30-board-tpl: Use CONFIG_TPL_BANNER_PRINT flag
Date: Tue, 16 Apr 2024 14:47:01 +0200
Message-Id: <20240416124701.157545-1-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Apr 2024 14:51:12 +0200
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

Display TPL init information message only when TPL_BANNER_PRINT
configuration entry is set. This allows to disable information
message in case logs on UART are unwanted.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm/mach-rockchip/px30-board-tpl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
index 637a5e1b18..a660816db0 100644
--- a/arch/arm/mach-rockchip/px30-board-tpl.c
+++ b/arch/arm/mach-rockchip/px30-board-tpl.c
@@ -46,7 +46,9 @@ void board_init_f(ulong dummy)
 	 * printhex8(0x1234);
 	 * printascii("string");
 	 */
+#if CONFIG_TPL_BANNER_PRINT
 	printascii("U-Boot TPL board init\n");
+#endif
 #endif
 
 	secure_timer_init();
-- 
2.34.1

