Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63492C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A1388A7F;
	Wed,  1 May 2024 04:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UkJXAGG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 739FC88A7C; Wed,  1 May 2024 04:43:26 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639DE88A78
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6a05f376effso49626306d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531403; x=1715136203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gf76JRcuPogEizXoeuxLiDSaPcwDGWD6b/n4qG2eiCc=;
 b=UkJXAGG/RHU+f5IKoUsStSovd6XACl4ri6dn22tSFUf/PIKnOV+4XoxLCa7lfUQuTt
 kda4W0G8XHzqUm1YvfN/SZ73SdL6O0UNDy+syJf/zG3Xjf+9Hw3dIVLHiyGyZdFwg9Iu
 K5E3Ar8x57KJkhcxjaAWjOJ+BQ80LNP5YIjUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531403; x=1715136203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gf76JRcuPogEizXoeuxLiDSaPcwDGWD6b/n4qG2eiCc=;
 b=GQpUnDS50HBfkBVnMZAH5U5bDGlg0fioCzcp/jC+rqG/cHmRGzcgjrU3r16c4a2iMG
 DNe8MVfvzowprZqQLJtQ17Nn6G8zIz04VBW5nCgmALBJ7oBxnPmJtvrJgY6tW+F9HOHz
 zWe550A5PUKWXHipch8w3I5PTEQx0yZSPxcfg4pGgmyLVcqA1580LrSBL8lvbBtpSVXo
 v3XHpt9G+JC2vn/xjtI1b7aIMfWqhElIi/o+Tof5aEUmir8nVehu0EXabVKc51paMjMH
 cP2pcH0sPeG9x5078C991Wv8PSCILuTfXjzyFBg1Yu7MMwW7+srIe8+hJAnmYKMbBaLa
 BN3Q==
X-Gm-Message-State: AOJu0YzNZrmCdG8LSGPToUw1BthRT3aTpVDqwMkIfM1X/VK/beo1+vEB
 B5QiWDY6RbHfdWhNv0VTNRq3nml3GitqFYGsXebwQoTPka818ekX2qKN46TskCTIWgiAb8NjkKp
 REZUikg==
X-Google-Smtp-Source: AGHT+IHPCl+Vnc1Sd4MXYdh+rMjWODMCpj3KOc9qiTMlpEuhId9JRKDbkjnc5LfG2YTA10YJdOE2uw==
X-Received: by 2002:a05:6214:20ec:b0:6a0:c950:437f with SMTP id
 12-20020a05621420ec00b006a0c950437fmr1154980qvk.12.1714531403105; 
 Tue, 30 Apr 2024 19:43:23 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 005/149] extension_board.h: Add missing <linux/list.h>
Date: Tue, 30 Apr 2024 20:40:52 -0600
Message-Id: <20240501024316.1767971-5-trini@konsulko.com>
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

This file has "struct list" in one of the structures, so add
<linux/list.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/extension_board.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/extension_board.h b/include/extension_board.h
index 3b75b5ba9f7c..87d404c00746 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -7,6 +7,8 @@
 #ifndef __EXTENSION_SUPPORT_H
 #define __EXTENSION_SUPPORT_H
 
+#include <linux/list.h>
+
 struct extension {
 	struct list_head list;
 	char name[32];
-- 
2.34.1

