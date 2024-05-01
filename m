Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043DAC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B288488BC7;
	Wed,  1 May 2024 04:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ec4q0mGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5988E88BBB; Wed,  1 May 2024 04:44:50 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B2788B7B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-69b7d2de292so25283556d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531487; x=1715136287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FundD2IMnO6EtqKuuFitFF00RXplIYVXbr19sp3W8Cc=;
 b=ec4q0mGpq9xS5CoPnwEwYqXDcv9pK+h9fflhqwo63nmGd3Q7srDPMNcycdZbNjzltV
 BV2sZp2x+vp8Era3Tem4c7cyaHeWjYzhKcJ4RKN3sxNfT5ERFmNJCRGF9U59DMlCW45J
 KI5t5N60zdk/H3cykQxC83Mi3fQNtcLXI4h1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531487; x=1715136287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FundD2IMnO6EtqKuuFitFF00RXplIYVXbr19sp3W8Cc=;
 b=exAyxNEP7jZyirZka2ujs6H86FE2O89nifom75e5znMkQ1QGrlK57Ah6RW5q7IXpZC
 SLYttwkjHktfG97A0FwmxNlnPu/19RAsyjxUleOD80CU+9JaUIVNH7vybjwClSHi/lx8
 /GTpdeV+RgV0OZ76R2HHN5Z/5ZA/zJejWH4y0nakttg4JmecFfDlO2DOTRp6BzGRNf2f
 aLhe+6bBuzwV1Z/yfInLPd8IwwwI/Bzy7Q/fh0CLXr8YT0gUGoT7kbu9bk6P4G67jx30
 aBhuSo3TGHJX1k6H0DaZTzNLT9PdaPBrS2W3SjNswLOmYAfE6CHirFKz+IkLrCyEMaYa
 a8oQ==
X-Gm-Message-State: AOJu0YwNVJdFXAZXZBw9MP3ymArhXCtTBH2gOKWcbsGoRH8+Ycf+FoAB
 PZRv83aF6W1xRxpuZGtA2VxlWzWocAJcwi14l42LqyTSHertn1Ft5GWF5MoLoAqD2I9XalmVui2
 u1LqF9A==
X-Google-Smtp-Source: AGHT+IFMVHshf39R27yd+KG/KTXhsefcIFOUeGrQ8lXX9r8xqVWP997FYZBGC6UFrRZStUXeQyXReQ==
X-Received: by 2002:a0c:f8c9:0:b0:6a0:b0e3:3571 with SMTP id
 h9-20020a0cf8c9000000b006a0b0e33571mr1116951qvo.19.1714531486740; 
 Tue, 30 Apr 2024 19:44:46 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tony Dinh <mibodhi@gmail.com>,
	Luka Perkov <luka@openwrt.org>
Subject: [PATCH 075/149] board: iomega: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:02 -0600
Message-Id: <20240501024316.1767971-75-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tony Dinh <mibodhi@gmail.com>
Cc: Luka Perkov <luka@openwrt.org>
---
 board/iomega/iconnect/iconnect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/iomega/iconnect/iconnect.c b/board/iomega/iconnect/iconnect.c
index 038716020019..00b08987e9e8 100644
--- a/board/iomega/iconnect/iconnect.c
+++ b/board/iomega/iconnect/iconnect.c
@@ -6,7 +6,6 @@
  * Luka Perkov <luka@openwrt.org>
  */
 
-#include <common.h>
 #include <init.h>
 #include <netdev.h>
 #include <asm/arch/cpu.h>
-- 
2.34.1

