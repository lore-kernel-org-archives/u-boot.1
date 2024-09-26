Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA27CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA7488E0A;
	Thu, 26 Sep 2024 22:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n+Q/VBh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467E188E41; Thu, 26 Sep 2024 22:51:47 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3756D88E5D
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a99fd5beb6so214691085a.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383904; x=1727988704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYWsJHLY/MeeaU8YO6IxjykvWfTg6N4UuLL7tE4hJFw=;
 b=n+Q/VBh47g8VIFJwV3Gv0pD/1q3Q4/mXIaHaJcjwPvTQY6aaHoyXm+Q7J7La0sv74w
 KTOStya5BMaafqlYmIsfzsI71+XAOcs+trpROzDfY3SFOXontLb7Eo5cb+o+mnx9Gcne
 5XdbBYxHOjG4yPHDe/4Yn7SXAQGDUevO/Dalc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383904; x=1727988704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oYWsJHLY/MeeaU8YO6IxjykvWfTg6N4UuLL7tE4hJFw=;
 b=Jh7HCRaukmcLgfDfA9c8suC41Y7AoH7+3aDeQCrF06E9HcrHVzLvBso65oD808ZNrY
 rStJaDSDSTzmIDN4V7NAqDH6loxQmeUUJsCwL+h4YRE5i5G+QjnkjhEf7shgu1MfgrL8
 /0WFPkDkOFg7UnYA6ToV7GY9l4KlS4sqv24aHvwQhXhMEEveqBmuo/I6+V7d6P6/1A/H
 dQd2ChVxJ83PU0epAdyMvS5z3F2xlNxc/yrG1PPqc0vxSHWm4XZu6kKd+z5Qezug6lCM
 7qZ1v50cxg/KQCpG0g0+Rrmieq3vAzbjqc6Q+X/Xvg9rrG2+GAgNKO1WGV3XBtAX5CEC
 6gTQ==
X-Gm-Message-State: AOJu0YyosIDUEd18oEMRq5TPb50WWfTOewjJwQ0uBvMIl5NqsusofssF
 gklaIgsPUCqJdcXKVG5YeRb/6b4iA4F3YDR4aqg7PpyXWXRCWLoaGEuROrfCThohEbarYiBDAuD
 uAF/pk/0=
X-Google-Smtp-Source: AGHT+IFHr2MCaIAeTjdFeDp+Awc3QvpMXCuYrPvvdthPeurWk5dbymAwNZduUq3a98yvczKztYuB4Q==
X-Received: by 2002:a05:6214:260f:b0:6cb:2e99:960e with SMTP id
 6a1803df08f44-6cb2f283e00mr78802776d6.13.1727383904036; 
 Thu, 26 Sep 2024 13:51:44 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:51:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 18/27] igep00x0: Drop unused status_led.h header file
Date: Thu, 26 Sep 2024 22:44:38 +0200
Message-ID: <20240926204455.963584-19-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/isee/igep00x0/igep00x0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index a35a7cd3b1f..35bb8c55806 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <malloc.h>
 #include <net.h>
-#include <status_led.h>
 #include <dm.h>
 #include <ns16550.h>
 #include <twl4030.h>
-- 
2.43.0

