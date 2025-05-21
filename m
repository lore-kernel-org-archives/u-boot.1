Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C56C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6F18300F;
	Thu, 22 May 2025 01:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bfZDibTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846B282F70; Thu, 22 May 2025 01:01:37 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8342682FB8
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-60b8a9be972so31568eaf.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868492; x=1748473292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7IrW0HCvfXP071zeKdkysXq2UvJkUsA+vwtfSx72eJQ=;
 b=bfZDibTWMbx9iyeXEm7yJ/iMxAaH+Le4rwQOWvgMkaRA50+rzJFp0vS5uqsvOymphs
 xtSPsNjmCkN2zWgkD3Bm+H+Gw0mO5PI7KDxBM5sXBpwKQ2I6fJfAxgDLKGQkI1Jq7Plw
 m5lbLeAJFW8/fOCCGlnEyvrNzzV7lK81R99sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868492; x=1748473292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IrW0HCvfXP071zeKdkysXq2UvJkUsA+vwtfSx72eJQ=;
 b=IkOt43E7bcIy6Yn7MUK8O2QOF/1beUP3TNKn2cUvnNrFA0KjkpgsGw0S+DoIMjW0PJ
 s/YLbH4gYuIqFgioWnm7gDJ6DYUwChkSNmrZAplgJeuXMNaKpds9y1UWSeOtf4DeHVoA
 hYkeRd57g0CnRnsVj0E1KNi+5t5IpFZXa/8p4aCvPGgwe/5tX2KdVrNZVUm4yWBgl+QB
 89scklSCfFmjO2HnMZkbOcbCak5QhB8HK3pqX0c5Fsd5q+qxNj5SvEDUAw6pEpNsvk6A
 lFsVr2979GThRQesbNCxi9LhlkxHj4Km06MG2/7M2PFS+4Fbtsfjxi4lM9ZbJKa/NY1l
 5gVA==
X-Gm-Message-State: AOJu0Yz/x1rXlPdON/Me1rOwZLf/oRwOtv7yMI8Hz/RvKAofjowkoOFP
 vQff4stYMvZTyhA3QfwUKSLfFzJTbJKulX7VrUb+PwZSqLuIC1HtJdRN6uweIrD0ne5gwcx4P9o
 7/qwchKw=
X-Gm-Gg: ASbGncsyt1g3M1TO6MtowdxgMteBigUbeSVicd3+6AsZC6zYQWR/U+rnIWMcCnlN3Ee
 opRpfT7Z2h50Yvz+8xuntP/CLE76UqHF+mnnt8tJsqjSppu/TaeZINOmvVrxSLcG9HdosfV7gbD
 qi7XaeTNUn+jO94X2xVqhu067aq8ZLlJW18LGoyDtfka7sWX0nKUi0t972qQfjMd2UhhMOF9Lt3
 7JHM2BO8Z8opYG/HMcKI/0dY059FO3ctjVc+40MIG/5Y3OaIZ+0rbVruS4gZj9A4L2SROItpvSw
 w25+geoRmWdrjVWOtdEoAnN1HI+Rcc5VpYuQk6O68B9G+eW25PaIvSBOiJe8TOht3VzPvs4Ik4Y
 fOG6tHynziD/VXYo=
X-Google-Smtp-Source: AGHT+IHGHahAUm7jXJ8CsoOA7HLixXDyRlXXzoAyEV+UXHCdfqT36OSTH5L7/KkGnKWYKDGD+6RkoQ==
X-Received: by 2002:a05:6820:1841:b0:601:d595:3b1f with SMTP id
 006d021491bc7-609f374d4b3mr15896641eaf.6.1747868492192; 
 Wed, 21 May 2025 16:01:32 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 06/17] include/cadence-nand.h: Audit include list
Date: Wed, 21 May 2025 16:51:11 -0600
Message-ID: <20250521230119.2084088-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need <linux/mtd/mtd.h> but does directly need
<linux/types.h>.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/cadence-nand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cadence-nand.h b/include/cadence-nand.h
index 27ed217b1ed9..f08dce19cb9f 100644
--- a/include/cadence-nand.h
+++ b/include/cadence-nand.h
@@ -12,7 +12,7 @@
 #define _CADENCE_NAND_H_
 #include <clk.h>
 #include <reset.h>
-#include <linux/mtd/mtd.h>
+#include <linux/types.h>
 #include <linux/mtd/rawnand.h>
 
 /*
-- 
2.43.0

