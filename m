Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA7BC369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F478081A;
	Thu,  1 May 2025 03:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mORAAw/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808748081A; Thu,  1 May 2025 03:05:22 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEA68070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d9030c2b73so1467715ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061518; x=1746666318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWtF8MCeo+yPiR0L+jIbWtImESHJeV6ZNQoxh4GYBB0=;
 b=mORAAw/KhZHSZ3UwmakLkTuFA2h5LP2zzWfSPmN1GWdq+GPexDx19DP8/jS2VL+P/A
 PUziFwxeHpOS35ED2uJGU8zdSOJI0ArYpUcB6SIKmlzC44FiXv02djj+XMUgCjoKXKnw
 QgMsIF60FxKJvlHpsQUvzSJuhG0ehK1OooNmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061518; x=1746666318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWtF8MCeo+yPiR0L+jIbWtImESHJeV6ZNQoxh4GYBB0=;
 b=pX1Ji0jgli1BU8KFpYm0yL5+a0bpKRzuvLASdM69ag04IGZYLypt3UUmt3Vt2CMqyn
 XZKRtsnBAf19HC7y+nSQ/Mtdc0/OgMWr8M+KdAsek8wAFuBR9e2CpUPPLMER1WHMjZIy
 qdrAsvbjjEHBMt8t1MPuppD2iclE74r+TexWJEsOM44VTBmTlBXq2JYU4MEzSJXSKeaZ
 m6HMCxGOkeBL52uRtt8g8jFbYnHdBgTJAbA9KqcdflGnW2alC4jc1YFH+pAx/ASDkT2A
 agk9qprx+kCfJg6rR/VroA41HISQ1q49rpe6HUohaixVIohsyihUhasApOi0jvYkzkD5
 QjNQ==
X-Gm-Message-State: AOJu0YyU2+WvMTT4fLOGCJ4dPzfMjKz5J6PaTDPmIK4F1RwU4K0Ywwr3
 TIdO7ULRZm8HdYLnzvsANEkH+E4oaMKdJzKUxYedAdBHQN4umtQDtzAuUoPyu5XZCBITJWQERk0
 =
X-Gm-Gg: ASbGncuWFENskKzO2yuGnoOyWbBxiJo4BBbTKsqWtI9/piuXRsQLgX9N7JqyVe/j9F+
 UmErCCLtKwFHWR4Ya7vrjqcJ5/ZYHzi9WsI/cz/WZsNkExyIhNdQHjTM+Ft2UYkHwY/ZSr9TBgb
 KJGFcyVrVyslqARLD3qfxdkZ+Q8Tlhuaux35Pszkg9+ULfy9MFNIvKRQ9maKNRN0TDC+c+USsxz
 /2OTrEwFSYxhhbJM9XA1E5rX+mN6PlEtDa6Ui9rAm3boP0hKkxJuM9V443buxeMG2gpFXdQ6ZR6
 hoQXf+LjRKg7yEqmCgOAj17oACxGmbk3JDNpxRmm+X78l9nG6nUdf3D6rkvCb12L/QFe753xHuQ
 Gvg==
X-Google-Smtp-Source: AGHT+IFlY9vM4zOpffm08nFV9kpZXLTXdFMqTMPjMucFDqDmG9s3iu7BqY7CPOlTFPphbivWVmFgyQ==
X-Received: by 2002:a05:6e02:156c:b0:3d3:f27a:9103 with SMTP id
 e9e14a558f8ab-3d9701c8ff6mr9013795ab.1.1746061517806; 
 Wed, 30 Apr 2025 18:05:17 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 01/22] net: Use a forward declaration for cmd_tbl in
 net-common.h
Date: Wed, 30 Apr 2025 19:04:26 -0600
Message-ID: <20250501010456.3930701-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

We don't need to include command.h just for this declaration. It
eventually pulls in linux/byteorder which causes a conflict with exfat
which has its own byteorder functions.

Use a forward declaration instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v1)

 include/net-common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net-common.h b/include/net-common.h
index 12c50e2a41e..f2613a41ad8 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -4,7 +4,6 @@
 #define __NET_COMMON_H__
 
 #include <asm/cache.h>
-#include <command.h>
 #include <env.h>
 #include <hexdump.h>
 #include <linux/if_ether.h>
@@ -13,6 +12,8 @@
 #include <rand.h>
 #include <time.h>
 
+struct cmd_tbl;
+
 #define DEBUG_NET_PKT_TRACE 0	/* Trace all packet data */
 
 /*
-- 
2.43.0

