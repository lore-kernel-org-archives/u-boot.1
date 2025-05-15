Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B425C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C28D82B39;
	Fri, 16 May 2025 01:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CgalcYV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7385082B07; Fri, 16 May 2025 01:42:18 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B39A82AFC
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72ec926e828so613855a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352535; x=1747957335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4+MLbuNZ1Ura43rydVHs+JKMGX8vHW/tt0yp8ltjx8=;
 b=CgalcYV7yoci9YS0Dz91f4Mxj7zscG/Qj2xCcyQz0k1fhqbdKqWibLjVCRhJZAH5Ak
 KGcsYxp+wQOl/4R4lgjJAVgw5ries2YOia0cEYyANhggdknYK9jHqfk5UbzaL12pJQgE
 GdM1Y1K24enVKdWHOar+pIqAW9bekHk+9SRMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352535; x=1747957335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4+MLbuNZ1Ura43rydVHs+JKMGX8vHW/tt0yp8ltjx8=;
 b=qF7/TKp/AOyVOYYMINNPiZhrPA8GeoaOBOgRlllIfmyquVAoR0g61NYO+RB0D4eMof
 Kdjiq1UsmETIgcxa8pEo8mkazXK3PlzhcBBtyN0tgMMI3EgciRynD2je23JvnOjNHH88
 01ITpsYr0PAJgIR9Gv14p8zoPfnqulHzidasEmZncMHQ25wetPN+4aiv3QRPAEACcYkO
 O6d9oslpMLnff2xkrnfOy5O08F1M23lFK7zxeYty+KkzAKzuOIqhQUL26r12sjhIHu2Y
 NJ0XSBrGMJ1Qn9jExVlbUNHmn5L1H9aymwh0fOp5DLesc5S+bCzkdmQZMrPlnTf7e9QD
 lZEg==
X-Gm-Message-State: AOJu0YwROvLQSsR2wBsTxydApWj1mzbY8ZJmECU3QQOo3nPOUPHnQtXl
 dfUdZXuGqIElAhY3bmYyGu8vkfcoPp71zPkoUgzFV2qd4o5UlEDNJO5MqSqHpi46fDCJsBw9C6i
 cH3dGvOY=
X-Gm-Gg: ASbGncv/qixrbvmjkhZJknJfn82yReljpfCU4eNJ9DroBSJcOr7APthh/0JSWP7cyY9
 ExsEkCUugO/WuFGwDUhjHVa61v5/tOi+ChLYr8CUnRlUsaVuupxL4vb7RTX4UDrx51xes7WwBjt
 UDeqSYeoMo72YqWKq461Vwh8OQMZkWUBqN4Q/NYbtfEYqbrRSHGIJb4jfHOPe9OMggC4yUB4qtm
 kR9u3avEpBMErPaCqBdE0qJhweaDz47r/6rIKeskXq1+P/qZ6FdSx6xhrQaYeW1WcysymNfm0x9
 p4XIQQtOigqHvLD9mbSi8047mA2lq48/30dQpkCmVzmcruSpr/gyOQFbkIZIflX2YB1bdN1O5MG
 ds9m7rUCi/4z2LQg=
X-Google-Smtp-Source: AGHT+IHFzxj1beqwXVyojgY8JOr+5Lu6BRp9gwT1RBLfTY+kHNbI7NF4h3EcHYtYVZi90Z+doKbx1A==
X-Received: by 2002:a05:6830:3c90:b0:72c:3235:3b97 with SMTP id
 46e09a7af769-734f9956543mr374868a34.22.1747352535156; 
 Thu, 15 May 2025 16:42:15 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/22] freescale: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:43 -0600
Message-ID: <20250515234154.1859366-15-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/freescale/mx7dsabresd/mx7dsabresd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/mx7dsabresd/mx7dsabresd.c b/board/freescale/mx7dsabresd/mx7dsabresd.c
index 3db167c0dad3..bef4f901ff74 100644
--- a/board/freescale/mx7dsabresd/mx7dsabresd.c
+++ b/board/freescale/mx7dsabresd/mx7dsabresd.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2015 Freescale Semiconductor, Inc.
  */
 
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
-- 
2.43.0

