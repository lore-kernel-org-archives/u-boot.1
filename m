Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC09C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC5C88DF2;
	Wed, 21 Aug 2024 18:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lm0CcTAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FAE388C05; Wed, 21 Aug 2024 18:19:43 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BB088E0E
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-70943b07c2cso3863154a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257180; x=1724861980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EGzBI0Le1IzVi64EH75vvK2DgzCZ7GFbLLbdDXId+I=;
 b=Lm0CcTAcE+woxFlzgZBRy2Pmu/IUVFV10qrUl+4fiqjt4Ot+E+OO9xLN9M/9df6OFD
 OkJcUn5EZoMncSmKJN/5KdoBsbtTbK1hrC0Irc1IUTn4Nr4nBc96RVYRs07auzGAN/kw
 5qVK1E2HEDsoQeb6w4BULcGzVddErg69eGxV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257180; x=1724861980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EGzBI0Le1IzVi64EH75vvK2DgzCZ7GFbLLbdDXId+I=;
 b=cCpzz2Q4dwpLvKy3oHovqLpsGshUpxIdE/zfSB94JgbBA+xIFeDS3ixmLVnkyJnJjx
 TeQ4yTAj2Gqo0teoLoky5oWDTY8dYpLEbD0vQc+ByGdhb27jzsX5pse2r/oyrJKBYAoG
 pFMyhX9R/ogSyJCyFR2a0Y3M4p2DELFpYF8IaYEYquQu0Ymu2tjM0xBSTAaTS2YqziZ0
 8bv8SpwyhCKE4e8ZW6F2ZxVaXykhEBme7UMk4s7nSp4m8hV7tUbFOo/+UXhVM89KPA6N
 YinO631KikaY6d4n6rA5VWmHgpHWHwWIwZpeDbyd0CEReuJb1pUxU7c6desWhYeGlSFp
 5lBg==
X-Gm-Message-State: AOJu0YyNcpij4DmgCxprNI3yPnqa1pNMSOrdmQ84+MxAEB/aIhN8bnqs
 rBBi+5xV/Z4aHP4KC+ZAxJ3JeQW9wefN87midtpnX6Qg8879n0CawAoIEL+F2xMn/AOL4UqHNDw
 =
X-Google-Smtp-Source: AGHT+IGSuA83W9vUJKsqX7vGQe3u0+yc0Jn2cenS+KlGjQQ2mH4omWzWcius/wmRws2hc+CCo+scag==
X-Received: by 2002:a05:6830:6589:b0:703:6ab8:1fe3 with SMTP id
 46e09a7af769-70df87178d4mr3179257a34.15.1724257179952; 
 Wed, 21 Aug 2024 09:19:39 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 05/35] video: mxs: Avoid setting global_data fb_base
Date: Wed, 21 Aug 2024 10:18:57 -0600
Message-Id: <20240821161927.695717-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This is not used, so don't set it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/mxsfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 792d6314d15..e72839cead4 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -335,7 +335,6 @@ static int mxs_video_probe(struct udevice *dev)
 	mmu_set_region_dcache_behaviour(fb_start, fb_end - fb_start,
 					DCACHE_WRITEBACK);
 	video_set_flush_dcache(dev, true);
-	gd->fb_base = plat->base;
 
 	return ret;
 }
-- 
2.34.1

