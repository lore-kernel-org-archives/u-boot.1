Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55FAC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C8F88A8C;
	Wed,  1 May 2024 04:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QV0vY4Tu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F376588A7B; Wed,  1 May 2024 04:43:25 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EDB788A7D
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-69b50b8239fso3763986d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531402; x=1715136202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5JL7H8KFVi79IhQOWRZjMYXf+sBbGkLU41oALEe+FBA=;
 b=QV0vY4Tu6VuUjz6H+NGp5HkD+pFqoa6qWduDhMNxO4Uvpv5z22ApB1o1KWz29hD2nY
 cMIIpiO2mey8pUgbVVw5CnpUzILX0eN25OGKySCQCKRiAHNCJ4x0SBF3onrswDCxHwDZ
 xSHg6For4C8nRQVSbibGEq65koZWGTSz5/ou4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531402; x=1715136202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JL7H8KFVi79IhQOWRZjMYXf+sBbGkLU41oALEe+FBA=;
 b=E+wGMR2I8qioHXpnjq3RQfjNrkgXzEoU5EHxQV8jAnrT0t9FXOd0lVFqkxbK60C1Yd
 NxPvPqHfvc3yky39z7vDTn554IQTfrj9z61yXYadtnlOqGT5Qsme5MIVb0C9bzkijydt
 SF58BP4WFjFxSEXefxwzMwT4b+bBNBMZRWDyVoucF+9yBFpv3iTm2cDTjv9a9GiShRT/
 e/ES/t/nIZA3uM1nNwYaeLIHHiMFAPv7+pwluOs41A9DhaY9BJwyza7GW7kkqrJzcwRX
 veepjccDXoWi0GyscRrcA03Ww70SjzSoIprwb4+rNHfwARNTJZat5LJ3y3U3dVDjdU8Y
 ATyg==
X-Gm-Message-State: AOJu0YypdLwzl8L9nT6RBlEBd0BP8if4QUKOkO/m3TNcYv64/U2DAKpm
 ltvUjMeTQWL53GiR/WaDXM76SnG2PHTsz4bUmTl9dWpFCp0NHlFLUlr08ZDuj+NZqMm90w7eavt
 wOfCn9A==
X-Google-Smtp-Source: AGHT+IE+eTk9mAweqYNuwTnBR/dPiccyVNXzBZTPT/zLJswdfls/+I1YQc1Mh9qsnZraPlISRtOwTw==
X-Received: by 2002:a05:6214:1c05:b0:6a0:66ad:c29 with SMTP id
 u5-20020a0562141c0500b006a066ad0c29mr2684676qvc.10.1714531402109; 
 Tue, 30 Apr 2024 19:43:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 004/149] splash.h: Add missing <linux/types.h>
Date: Tue, 30 Apr 2024 20:40:51 -0600
Message-Id: <20240501024316.1767971-4-trini@konsulko.com>
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

This file has many "Linux" style types in it, add <linux/types.h>

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/splash.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/splash.h b/include/splash.h
index c3922375987d..83c6fa9767f0 100644
--- a/include/splash.h
+++ b/include/splash.h
@@ -23,6 +23,7 @@
 #define _SPLASH_H_
 
 #include <errno.h>
+#include <linux/types.h>
 
 enum splash_storage {
 	SPLASH_STORAGE_NAND,
-- 
2.34.1

