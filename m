Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75755CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 23:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1E7837F2;
	Sat, 30 Aug 2025 01:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JTuvhLS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F181835EA; Sat, 30 Aug 2025 01:39:59 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B28F83744
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 01:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-52992b299feso358594137.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756510795; x=1757115595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZjcY5ChSGfKiO0gAO5mQT0PmflBTBoZd2Q8ODRhRqeI=;
 b=JTuvhLS6aNTpFeERaHVVhwDS14ncQhLN/iL2Yh8wBLIUPx76Cz+AZPUjM6oZKCdJ9e
 lw0wls9uGzgPop8npyy9wDuy1Izrp+c5MxcT2ODY7DbW5XjYU6XjPMt0clVYn+UMeXZf
 niZsQqCyorRuw7m7Dzacifh9+prWmFgaXwj5Ry61fq+taWKvtwZhZm6L87YcG5G+7w8W
 rc+QVVMeNia7hMFkKGG0HuJ2jLQsieE5Ng+XbsrVBIv/JUGhNl8TNl5bkz3iuRD6UCKz
 WcHpGKvNNAx0sib49ieD72m3wbkjv+MxHCmPDhZ/qBuAb+fDkamhUN5PCuhJP/BWZgRI
 RFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756510795; x=1757115595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjcY5ChSGfKiO0gAO5mQT0PmflBTBoZd2Q8ODRhRqeI=;
 b=J7131WR+VQr1uWMWZakGzl73WLSmuvcZ5/lUNrE7QsRr78QMyDD2iH/WhpobePflth
 vMgX35lzQjYvg+ZYFkTbOW9SJnLwty/Aw99wEydQmdN/6RORNsuPetIWQjzExyEpnyew
 b6igRkjlqXZhsJSMW6o34s0bJb4632LmgPyIt9ugLRLFADgj6S1YxiEgu0fAw+ZQneDe
 ELxt/o5sB5wq19b2vtaQB/hqMojjrMGJ9Ann8etVnzuxeubRMCIiKfm0gDLoNjXuTFlk
 u1NpSIyW8hveTcYrmlet5eOmiElALA+dXnwJT/PVyBfDMUgFILVc+t3byWgan4pPC6Tk
 5yuQ==
X-Gm-Message-State: AOJu0Yx2eoEmhvIK+IawQJtyglSMnlsTqY/pa+mARcUPH7sIAmi60BxS
 Uj1zGeawcms1u65O+wSXQzGLc24rNLNHvV8X7ibsVe6LUDwhS39ZxVZW4tZLS0JkuOcYYIAvD41
 VD0sZ
X-Gm-Gg: ASbGncvk0rgOZOniYEiN2CmFn2jFwqORKB0d/mZWdAy9uO+gbdfZvxqFza22O+5v9kG
 nQAN0Q+xyq/dojRq+d4YTpAutXKEfY+CWgMmojd5RRVo5acC4oOawC1YGTJv7sM9XrTuNxX0Rhc
 DEzL2gPdmR6MWtMIhP7JbEXX25m2xFGpnN28PvsK4WUAPstUkBk1RBI9b3ZC+O6NHiMv/V0FGdu
 l8Q1SrC3ISaDlTU/g/Hx4YV8yHV+6lotVXzIFH8/Pw1OY+Eu/dD3PddveCtYZE81jpENT1T1e3+
 oLoehaSS/Uh69T/hZizlAQBHjk7mjY9bvYYRy96nqsiCTSPO5HRnEC/T0cRH+8bziui+DB/CijC
 QopGKn93tDMHPuNEaI/KpQ8kKzKNqy5zTDtZVybFT7B86AKDdEgIhhDXIIRA=
X-Google-Smtp-Source: AGHT+IGAqjBOSZho4cbcsI3P0+eSHmOFKMDBu02DuQ1HGX2rbPFtAv1T5RL6gGsWb2a3nOlNatTjDw==
X-Received: by 2002:a05:6102:5f07:b0:4fd:b71b:c66b with SMTP id
 ada2fe7eead31-52b19748608mr98759137.2.1756510795175; 
 Fri, 29 Aug 2025 16:39:55 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8943bb744fasm1360819241.15.2025.08.29.16.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 16:39:54 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/4] Lindent: Remove wrapper around indent tool
Date: Fri, 29 Aug 2025 17:39:47 -0600
Message-ID: <20250829233951.547352-3-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829233951.547352-1-javier.tia@linaro.org>
References: <20250829233951.547352-1-javier.tia@linaro.org>
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

