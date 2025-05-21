Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39DFC54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367CE82FB8;
	Thu, 22 May 2025 01:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VNnddrGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF0D82FE7; Thu, 22 May 2025 01:01:38 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD6B82F84
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-60634f82d1aso2100938eaf.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868495; x=1748473295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wj0GT72W5+t8Rn+pNZo/sP0k/yvr8luBl6fV+ED8Fe8=;
 b=VNnddrGKXtn90bVE9NqCrXF/wO3a3jWL8OHMGAr9Exd5GMKssoN371s3kPTr1hMCau
 j83K82EJUJv5Kt+HdC30mNDbY26KuGsiboZEQT9nIqG49txxrPjBpGxbIAOv7riWLerX
 qwJZPSAgMf1RGA4MlVQRY2pJrKjW9PISNu/Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868495; x=1748473295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wj0GT72W5+t8Rn+pNZo/sP0k/yvr8luBl6fV+ED8Fe8=;
 b=KyjI3N97ApDwtK+698s7w/Ys2oVY5T1+N5yZi4iSFVh6LUCp74E5BkbbSq0CiqtdjV
 Z2RFE5ZyJiFfPVq75gFvrP5T84Ai60i2T5Sg7+2S5XEfLifC6VcMi+Knt/GfRAOBgKCm
 /Bz5xCj5GECP4nga6QNbxqCkiPRlyO1IsBSiuR36vW0P3Peq6nPDIGfCTAZ18sDRcm4t
 33dj184U/zlQBkxJXhOjZCUgDxF+fzStqINpRxECA7OkXgDeOVfSNtgFd31IFo8gdQC5
 eaYIIIaFNaAXOLXON4hMkOWQ67KCUc/bh4Alb/6hC/+zUBzIanYTUofEVsYOIaus10V9
 61EA==
X-Gm-Message-State: AOJu0YwBCp1grzfFaNF0+slvxUttYYbfE3GkHfEC6Glz5jDyRO+N3Tah
 4nhmETUehKGzaU65Uq/Lmjj+WM9XaPA3W2Siwxgh9gcnVXtcEBpk0Uug6QVoFWGnLkFAcRvkFSV
 mFLTBUDg=
X-Gm-Gg: ASbGncs9lNvk6sLbtTurq6NVDkM/0CH/iN/7Kb+yC8DA6BVWo7wjuImg3BYmDT4KnM2
 tt28rKB6l9P0PGGNDCimvm0L0H7b7mcKtIBeFp3LxlYO6prJzhRd2i8W3FGip793Q+LZhmdMXqD
 pgGuMsNJQj8xtmME8hFTovdQ00364jg4oUrrntlWzGwkFoEfZ5FqIJlGYPl+YEIvQJlD4bC88Wg
 FHuIyoqgXYMbWUaPIOJ9Qwt1qxw2z/7KUHmyUnHwG4soVArRCh6PEllKDgy3iTOwPFTJ2f5Misy
 UwIOQvjOgVQZ2RHIHMMbzrSxO29znU3w09w8jKcerdNDF6Ss1bQ+NzqtNjQepTZGwPCnxUbNZlp
 Fd4+bavS1JohcIyM=
X-Google-Smtp-Source: AGHT+IEBUE/EXTdWYsi1q8gnSFgDQfmfdj7Xvzo4BqW+lzEW2oyPsBJUgvG6Wl1OZ7bsDyofUBcGqA==
X-Received: by 2002:a05:6820:1841:b0:601:d595:3b1f with SMTP id
 006d021491bc7-609f374d4b3mr15896806eaf.6.1747868495225; 
 Wed, 21 May 2025 16:01:35 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 08/17] include/compiler.h: Audit include list
Date: Wed, 21 May 2025 16:51:13 -0600
Message-ID: <20250521230119.2084088-9-trini@konsulko.com>
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

This file does not need <time.h> so remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/compiler.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/compiler.h b/include/compiler.h
index ef7b2cb1f7ea..f2e1e09c5980 100644
--- a/include/compiler.h
+++ b/include/compiler.h
@@ -60,8 +60,6 @@
 # define __BIG_ENDIAN BIG_ENDIAN
 #endif
 
-#include <time.h>
-
 typedef uint8_t __u8;
 typedef uint16_t __u16;
 typedef uint32_t __u32;
-- 
2.43.0

