Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C020CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 17:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1049A83A28;
	Mon,  1 Sep 2025 19:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mCAVsVUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DDA483A48; Mon,  1 Sep 2025 19:48:07 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC08B83A28
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 19:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5432dfa5e8eso3427406e0c.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756748882; x=1757353682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZjcY5ChSGfKiO0gAO5mQT0PmflBTBoZd2Q8ODRhRqeI=;
 b=mCAVsVUumz6VMrUl3Aa2mt4NCz3CfgTXXpEaW+T36c2HKu5E038akjjw0w5C+1ZZNx
 S3uIV+4/j0BnsNIUKgNiV1SkuSQaD3+A7+685Jr4uV+ouJj6KdinnuwFN9EnEbUf+TtJ
 Qww8Rz7Rf3aJxGV4s7HmY846f+1a9iFFRpAlh93XoOaTG6zOkhTWKMW4uU6fr4Kldy1n
 M+wKkI90eFtkc4RmPCZIPXpedF1KPwL+7ntNckWut5iFqPBVk6Ur41m4YqB7T8YWRC4j
 h4VGS/TtaS1gHd6pi7vTv8bpTVdYi559jnOcloMa1DUHlxKVCoiRsgkLhGgJU9BRjD1J
 7ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756748882; x=1757353682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjcY5ChSGfKiO0gAO5mQT0PmflBTBoZd2Q8ODRhRqeI=;
 b=CtQJiEXUVuYi/9fPkPGWZEEq7KVn9uk23fiLMwPhS8C/LMslWkrc2k6Xv60VpAxsxy
 U1jnMy5E3OmoabU0s1Hae9wrtWnfjjpD29RG5Uqqf/4g7FQgcDYkMc3xK1FuwXIyg+CC
 i8XGccFWi6AzElPajPLhzbee0E26SV5Phv5xt6exlO9wKfjpzqagsbFrP6GARPYpYAmZ
 cdRk8DjecZbC1euLbvqPiCAGUpY9gAVuEJp9GVCYUiVdJKOB4ZYCNkohOh80J4Ur1mct
 YVO8f3GOINscdaXSG6p8clUkuvnGDSERseHUjhonFrywm/62fJ2pN4X2UfV4jkdhuW1P
 EFGw==
X-Gm-Message-State: AOJu0Yz3P3YK9J3+aeIx0SVLecaCK8tCT76IsvbfbQQN97kaf1aDRUu5
 KlOsubUC/WSFvW3ujMgSvx+S/84BZZMtjQKb0gR4d/+Gei1RITZN24zo5LNNLHVqVQZqcCpu+zp
 JMAU5
X-Gm-Gg: ASbGncvNzQq5YoCw0BeVpwndgI7pkoDlXBsOeqwBtQNHkH3SvX2kY3Tm+FouUpOkLva
 wV3EFscfPzEWSMvjLT9O/Ldao8EHSDKSmSOIj62wQf4uKGCK7ddQNH7l9xFVZPbsSbPTaNi6VFH
 5luNu6VZxdWlsH5rJHz6mGNNDZO/YQ6AQUZUkzmBM03F0ArxrnK2sNsxrqc2KamoBIpqs9kZM9+
 XUFJVNR2Yfin81jsrtZVuaTHvZDU9IW+MkdZENddxKMppWg6g41xFpSxRz/MtyptN6erN0baxta
 vaOJKE14k2prJvXxgoJcgDZrwuDBmvHyQv6gv/LfhekyOfDDqC9/isRcnAc/NKhM8GeVKa049y2
 3mG/1PtICbemEqL/EIK+IoWnqGfrzHI6xXjF9m14dmze+VDjxybButc3GCWc=
X-Google-Smtp-Source: AGHT+IEzygKgmj3zIt7dLcbMO6PoSHevj9w9R7TBRhlelDLscExKz+RO5EFrBe9gBvg/6L78bWaJkQ==
X-Received: by 2002:a05:6122:2087:b0:539:38a4:3bc2 with SMTP id
 71dfb90a1353d-544a0171557mr2556180e0c.3.1756748882201; 
 Mon, 01 Sep 2025 10:48:02 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54491464aebsm4670495e0c.14.2025.09.01.10.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:48:01 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 v2 3/4] Lindent: Remove wrapper around indent tool
Date: Mon,  1 Sep 2025 11:47:54 -0600
Message-ID: <20250901174757.166162-4-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901174757.166162-1-javier.tia@linaro.org>
References: <20250901174757.166162-1-javier.tia@linaro.org>
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

The Linux kernel has not maintained the same script since 2017-11-01,
and with clang-format included in U-Boot, it is not required anymore.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 scripts/Lindent | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100755 scripts/Lindent

diff --git a/scripts/Lindent b/scripts/Lindent
deleted file mode 100755
index 9c4b3e2b709..00000000000
--- a/scripts/Lindent
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-PARAM="-npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1"
-RES=`indent --version`
-V1=`echo $RES | cut -d' ' -f3 | cut -d'.' -f1`
-V2=`echo $RES | cut -d' ' -f3 | cut -d'.' -f2`
-V3=`echo $RES | cut -d' ' -f3 | cut -d'.' -f3`
-if [ $V1 -gt 2 ]; then
-  PARAM="$PARAM -il0"
-elif [ $V1 -eq 2 ]; then
-  if [ $V2 -gt 2 ]; then
-    PARAM="$PARAM -il0";
-  elif [ $V2 -eq 2 ]; then
-    if [ $V3 -ge 10 ]; then
-      PARAM="$PARAM -il0"
-    fi
-  fi
-fi
-indent $PARAM "$@"
-- 
2.51.0

