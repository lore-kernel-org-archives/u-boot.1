Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA77C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAEDC82AB2;
	Fri, 16 May 2025 01:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sS09kvlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA21B82B77; Fri, 16 May 2025 01:42:20 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AC082B0F
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c09f8369cso821709a34.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352537; x=1747957337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WT0vKS7ekJ7MtQ/e99FOMtcMGbl48OdVNe4p1SnCUDk=;
 b=sS09kvlY+S9pMOAKeG1NrzZbnR9nZQA7439UFILlfn4G8Rj/R876IuzH6J0sMf6fZ4
 Ft8Sw7nNKCshx4dA8Zx61T0C/P4sNuz0uVx+wcrjxFbyW9Y2lJ/pWyvNecQOo/R+VVF1
 c5Cg3KD5ifwEc8sk2gdWdZfh/FuQsKmgx+TuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352537; x=1747957337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WT0vKS7ekJ7MtQ/e99FOMtcMGbl48OdVNe4p1SnCUDk=;
 b=Y/IcWtlHGlMdMQ2f0SxpbsX/Fbn17K7x8X00/zcHXZ/ug19VzWORZYwVx9TWM4R1Zg
 biR3KLQu2ZZJPU0Ubmtm09j/8rDztcBNXY8dHczsEJbGEjOkxcRi7aQfL5TO7Hd3K6lB
 oCabUiA2mGlD3iDfLaGHiSimIeEkJ9KEMPiDQbB4IgAQPsspDEgho/1lAH1YaVpIS6/a
 pxc0T1qvKQcBsaZGTXIG5rxQQregLpF6yyibGhxtwZQkWQznQ1K/Vn43kPARzO4WXmEt
 sXy5hdt6gPdA3XhVOTL7bjBsJw7PeIU9xSAK3Ngl7lEcwwZEPZAzfwIy+nHwLyB9/2SH
 I4BQ==
X-Gm-Message-State: AOJu0Yzi78c7oyf6aoZDBjV5oGO9yzDGs3HegOhVDgVcv1S85bec7eiE
 kzexHinu+Pqfkjq5WA11XBmUN8XbZZTnUhLn46gdrp7yNudMKxd6y5j0qDEpE9W4E7Bb7qBEmd9
 hFXUivbI=
X-Gm-Gg: ASbGncs+ByYrlwEVPJrQmdqMwYl+NbQ4YiXJ70glU9eyNFu+kQaf06vBKefb8rcKLAb
 HwqKd2vbtHYQ87WnwI1td8HMSigFqi7b6/ltHUg7hT+vK9hlixA88sfMePOIDvqdTS5u2Bk2Jje
 I6uYxiR2/f8FFBjymStpLUP4o21zcX2aXsG9lKlaNwts+/0pVEDDrVq2SICjjiXTqpHM9NVvW9Z
 NKY0uN/QNr4CfPPiCWFK52v5TVfwl9hLsciIq2Qn6iNtf7CPHCc75IgRBkXeRzILw+CBEDj9009
 +Oj4dZRDPMqMojNeCdI9wtcS8vwuD8oQYSqAk8H9kUenWghDs/6dBpwhRWtpzivZvB2a7tQxyeM
 DcoC0fn3vPWCVJIE=
X-Google-Smtp-Source: AGHT+IHn6Oom1MetuqWdT+KyB1VBfTx4eKAsyy3qNa+l0HOkicjlIHZHBo4m6LQa5sChS+X6eZ9n9Q==
X-Received: by 2002:a05:6830:6819:b0:72b:992b:e41 with SMTP id
 46e09a7af769-734f6b8af80mr991611a34.23.1747352537378; 
 Thu, 15 May 2025 16:42:17 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 16/22] liebherr: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:45 -0600
Message-ID: <20250515234154.1859366-17-trini@konsulko.com>
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
Reviewed-by: Lukasz Majewski <lukma@denx.de>
---
Changes in v3:
- None
---
 board/liebherr/xea/xea.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 1d4f165fd13a..9630e7f576b2 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -13,6 +13,7 @@
  *
  */
 
+#include <env.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <log.h>
-- 
2.43.0

