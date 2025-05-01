Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E19DC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 16:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7E9820E2;
	Thu,  1 May 2025 18:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iEP29rjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608BA8210F; Thu,  1 May 2025 18:47:30 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36BF2809D4
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 18:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2c873231e7bso878781fac.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746118047; x=1746722847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kGQyu11Evez31LM5ORlwANu0M6VlQROAgLgKjbpuQr0=;
 b=iEP29rjoV1devsfy2mOeILm3yNdvqqKcvT8j/xSctnjzv5R9pxu1zc2rKZVM/BNO/P
 +17UV0JSIr/+rNx8DhXxgVThP/gEapo3z/m/s8r88TqrkB1uyOy/yq2fPn7JFQ14KCZp
 WN1AiGhLxW0KUPY3Eq+HLDz27OvKS/SW7RhUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746118047; x=1746722847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGQyu11Evez31LM5ORlwANu0M6VlQROAgLgKjbpuQr0=;
 b=COvSvhK5nLvt/OLIbuORgzakaTnkiz8OX+L9+AYzydox1WCtKj44A84g+PennL7+C+
 YDiC/2uc7gq+z3zU0NukjOmiBQxnE5zasRgY9XlFTvxlS6Yk7iCpU9i4ytxURP7qrLA4
 +LLjYLErdHIkbPxecP/YjKgYE21VJrmuKItm1d8EL0r1DKaY2ocfbaVuCfJ4lf34Bhcz
 ToFJ7JI9DffVXcm8u5Tlq4J18YsjjrZHFEsMTPZ2tofmQWTMVp0RIqQvp/Suas0bL7qh
 azrvuBBKBAAnFtIhinGx2iKnwIjjc4A/90qqqa2XHZ1KQoyGuBj4hMh/w6fVytL9AJe+
 woCw==
X-Gm-Message-State: AOJu0YwwOhPeJ6IN96BBmwwGbe6/CvEaOntAGQFRYq76Lu7Fa0mBFYcI
 6nQt6OQiQvauwKMV0LXaWTrh32C9o+G6vlE+aVX1sA8ZKZqVjhGizf3OWvJgjK1GeAIUCUqa00m
 O
X-Gm-Gg: ASbGnctwfuzAERfEi9xvG6J4qCXdHMRG5f1IaCpwBclXrwL649s4Qa/759uf5yVkE9W
 /bgQUu9MfL+cw267NPveE2Wj/nW113kpBvjWYLs0TUgT9cbssF/+oNG4C+/0twGfICcZvKl01Ae
 sWDKLAKq4Kk6cxVr5W26Pt/mLNGyl/dUdfQ6AYCQ/9XdY9konmsetqzRcwQW+YAV0PeuYXI9hMJ
 gBBFVEB2NA4mVhK/ooj0hHomcMTQX9mkUFfZ6zx0VDmMCh/+ga3sGoBfOU53KH9jEYdVOieRSYM
 vTvN3PdalapDJyKlXr8bf7zpiGG3tAPs15906hK04X+A82weqoC4mKuSIGyBznxZYgr9oSeiXOM
 YRUsD
X-Google-Smtp-Source: AGHT+IEA7g/I+sk626aQG+Xst8TbLsa7d9Zg77Ei4cG0NBr+AttJAOGEXVTL8V74CM23Iva/qzIDAQ==
X-Received: by 2002:a05:6871:338e:b0:2b8:78c0:2592 with SMTP id
 586e51a60fabf-2da6cdfadc8mr4070416fac.23.1746118046917; 
 Thu, 01 May 2025 09:47:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa1207425sm193656fac.39.2025.05.01.09.47.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 09:47:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/4] fs.h: Switch to using rtc_def.h
Date: Thu,  1 May 2025 10:47:21 -0600
Message-ID: <20250501164721.1494370-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501164721.1494370-1-trini@konsulko.com>
References: <20250501164721.1494370-1-trini@konsulko.com>
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

This file only needs the definition of 'struct rtc_time' and that is
found in <rtc_def.h>. Use that instead of pulling in rtc.h to pull in
rtc_def.h as rtc.h includes many other include files.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/fs.h b/include/fs.h
index 731aaa026375..bec021177371 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -5,7 +5,7 @@
 #ifndef _FS_H
 #define _FS_H
 
-#include <rtc.h>
+#include <rtc_def.h>
 
 struct cmd_tbl;
 
-- 
2.43.0

