Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CC3C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 22:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3994282E8C;
	Sun, 29 Jun 2025 00:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PPunzC1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1727E82E8C; Sun, 29 Jun 2025 00:44:02 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB6082ADA
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 00:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60f24b478e3so513339eaf.3
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751150637; x=1751755437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aDLfgmr51j1VdUB7DoE+wvG0CYKIcodf8sxeN08iG+8=;
 b=PPunzC1h+KqDnjehtBlYMbJWnwnu5JNrywS3Jnxa/E0eKik1g22KXkx9W12Xu16rn8
 W+swabUSil23z+RDAzctcid2i9Y3pIf2joMftHRPSs/49QWxhogo3r/4hitOk1JstcTC
 v4RcmBTOS1iPOxNMwUGwR2Kd2qJekBuVL68/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751150637; x=1751755437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDLfgmr51j1VdUB7DoE+wvG0CYKIcodf8sxeN08iG+8=;
 b=ZrXA57yKvpL5lH5H+W8miDfclXw9nT0TTGBDQuzpfGlyo+QazBO/VyzQdy0RPVwV8p
 xxmsUSOIPxZAeVKBwCn4D2oStHSBgDShmDGaGp/o+2BLHB5RA2McolR5d4uOCOc9cE1N
 fZwLy/CpBnK5agjwEIUnfBc5uOsq0KoYm6VNVGJhWqirhUT2J9qM09OoFhN8pcFdyhHT
 8SvQm24aTCi1dQYVbM6Iptva8J4sO0fW4C1oJLxMxT2QALPUe+USc7dLmzlCa3pWsAiu
 FIaFS5DIXE1eY0aH2fyqyXdKzPLHapTzqLY1u+ZUT7EggsgigAIx06l1euNxPR30aHAA
 5djA==
X-Gm-Message-State: AOJu0YwUkZni1lIDvqTGBuTvF8IKUgAifPTQgw6LUjv9GP4ax+LRQf/Q
 GEsWLnfrrPnE1nvXGIb8y2x8EY8FkmHoBZLc57yanR09jB5kjvxDhNzOwzyylwKjFSELROE+cnk
 Fm6ZUe/E=
X-Gm-Gg: ASbGncshdpatwU0ifD/ORHHUeaQYtVwWRamJVvw5yvf6n4VOgMAVFEc13aoil0Tf2v1
 Bf2DyQ7o3OB16QSL9F76LJPu+BLz7GW3JGbRje50pa7G4apthGquvuD2E9mVkfEJK7UDQs6fSR5
 xg8SEhjYjNimuDU7HM+huP4Z2I1R/uqBK57KcvBR0rBf/C5iQ9YbP+CiWG1nxmHUNKa5zpOBz/9
 9Xe3Jnz6h8rgOg3cBScWLKh35BSPQYO4l/QMNutm3giSHMIkjsnw3jNZXaDffWJq6GK3Ij8d9aK
 AQdk8G+ge1tKnX5AGVWO5d/4rcq+RWXuXMUKWr5/G9lBN/qmtlr0aPNiL1YN7Upw2ucjYOMLwKm
 x5j0ctpnUYPX0QsLbbQ7alj1M6w==
X-Google-Smtp-Source: AGHT+IG9USvxhoPYU+Hr033Ln8JcM224oOgFQ+AhiMNqDdn9y1mrruoIUjxSRf3DCFGZ17pgTTT++w==
X-Received: by 2002:a05:6808:13c9:b0:3f3:e9d5:7790 with SMTP id
 5614622812f47-40b33c2b29amr7129589b6e.6.1751150636676; 
 Sat, 28 Jun 2025 15:43:56 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243e4besm1013148b6e.50.2025.06.28.15.43.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 15:43:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/5] include/part.h: Audit include list
Date: Sat, 28 Jun 2025 16:43:49 -0600
Message-ID: <20250628224352.85694-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250628224352.85694-1-trini@konsulko.com>
References: <20250628224352.85694-1-trini@konsulko.com>
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

This file does not need <linker_lists.h> so remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/part.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/part.h b/include/part.h
index 7075b2cb1164..c380c21dd4c1 100644
--- a/include/part.h
+++ b/include/part.h
@@ -8,7 +8,6 @@
 
 #include <blk.h>
 #include <u-boot/uuid.h>
-#include <linker_lists.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 
-- 
2.43.0

